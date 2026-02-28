"use strict";
require('dotenv').config({ path: require('path').join(__dirname, '../.env') });

const crypto = require("crypto");
const { sendEmail } = require('./services/emailService');
const { getTranslation } = require('./config/emailTranslations');

const fastify = require("fastify")({ logger: true, trustProxy: true });

const helmet = require("@fastify/helmet");
const rateLimit = require("@fastify/rate-limit");
const cors = require("@fastify/cors");
const cookie = require("@fastify/cookie");
const jwt = require("@fastify/jwt");

const argon2 = require("argon2");
const { PrismaClient } = require("@prisma/client");
const { Server } = require("socket.io");

const { OAuth2Client } = require("google-auth-library");
const googleClient = new OAuth2Client(process.env.GOOGLE_CLIENT_ID);

const { S3Client, PutObjectCommand, GetObjectCommand } = require("@aws-sdk/client-s3");
const { getSignedUrl } = require("@aws-sdk/s3-request-presigner");

const dictionariesRoutes = require("./routes/dictionaries");
const listingsRoutes = require("./routes/listings");
const trainersRoutes = require("./routes/trainers");
const servicesRoutes = require("./routes/services");

const prisma = new PrismaClient({
  log: [
    {
      emit: 'stdout',
      level: 'query',
    },
    {
      emit: 'stdout',
      level: 'error',
    },
    {
      emit: 'stdout',
      level: 'info',
    },
    {
      emit: 'stdout',
      level: 'warn',
    },
  ],
});
fastify.decorate('prisma', prisma);

fastify.get('/version', async () => {
  return { version: '1.3.3-chat-fixes', timestamp: new Date().toISOString() };
});


const makeS3 = (endpoint) =>
  new S3Client({
    region: process.env.S3_REGION || "us-east-1",
    endpoint,
    credentials: {
      accessKeyId: process.env.S3_ACCESS_KEY,
      secretAccessKey: process.env.S3_SECRET_KEY,
    },
    forcePathStyle: String(process.env.S3_FORCE_PATH_STYLE || "true").toLowerCase() === "true",
  });

// For presigned URLs that the BROWSER will use (must be publicly reachable)
const s3Presign = makeS3(process.env.S3_PUBLIC_ENDPOINT || process.env.S3_ENDPOINT);

// Optional internal client for server-side ops (docker network)
const s3Internal = makeS3(process.env.S3_INTERNAL_ENDPOINT || process.env.S3_ENDPOINT);


const PUBLIC_BUCKET = process.env.S3_PUBLIC_BUCKET || "public";
const PRIVATE_BUCKET = process.env.S3_PRIVATE_BUCKET || "private";

const ALLOWED_BUCKETS = new Set(
  [
    process.env.S3_PUBLIC_BUCKET || "public",
    process.env.S3_PRIVATE_BUCKET || "private",
    process.env.S3_BUCKET_PROFILE_PICS || "profile-pics",
    process.env.S3_BUCKET_TRAINER_PROFILE_PICS || "trainer-profile-pics",
    process.env.S3_BUCKET_EQUIPMENT_IMAGES || "equipment-images",
    process.env.S3_BUCKET_HORSE_LISTING_IMAGES || "horse-listing-images",
    process.env.S3_BUCKET_CHAT_FILES || "chat-files",
    process.env.S3_BUCKET_FORUM_FILES || "forum-files",
    process.env.S3_BUCKET_GROUP_AVATARS || "group-avatars",
    process.env.S3_BUCKET_SERVICE_PROFILE_PHOTOS || "service-profile-photos",
  ].filter(Boolean)
);

// --- security plugins ---
fastify.register(helmet, { global: true });

fastify.register(cors, {
  origin: (origin, cb) => {
    if (!origin) return cb(null, true); // allow curl / server-to-server

    const allowed = new Set([
      "https://horseportal.net",
      "https://www.horseportal.net",
      "https://dev-api.horseportal.net",
      "http://localhost:8083",
      "http://localhost:5173",
      "http://127.0.0.1:8083",
      "http://127.0.0.1:5173",
    ]);

    cb(null, allowed.has(origin));
  },
  credentials: true,
  methods: ["GET", "POST", "PUT", "PATCH", "DELETE", "OPTIONS"],
  allowedHeaders: ["Content-Type", "Authorization"],
});


fastify.register(rateLimit, {
  global: true,
  max: 300,
  timeWindow: "1 minute",
  keyGenerator: (req) =>
    (req.headers["x-forwarded-for"]?.split(",")[0]?.trim()) || req.ip,
});



fastify.register(cookie);

fastify.register(jwt, {
  secret: process.env.JWT_SECRET || "CHANGE_ME_JWT_SECRET",
});

async function requireAuth(req, reply) {
  try {
    const auth = req.headers.authorization || "";
    const token = auth.startsWith("Bearer ") ? auth.slice(7) : null;
    if (!token) return reply.code(401).send({ error: "missing token" });

    const payload = fastify.jwt.verify(token);
    req.user = { id: payload.sub, email: payload.email };
    return;
  } catch (e) {
    return reply.code(401).send({ error: "invalid token" });
  }
}

fastify.get("/api/profile/me", { preHandler: requireAuth }, async (req, reply) => {
  const userId = req.user.id;

  const profile = await prisma.profile.upsert({
    where: { userId },
    update: {},
    create: {
      userId,
      name: req.user.email?.split("@")[0] || "",
      username: null,
      avatarUrl: null,
      phone: null,
      hasTrainerProfile: false,
      defaultLanguage: "en",
      notificationPreferences: {
        favorites: true,
        new_listings: true,
        chat_messages: true,
        first_login_done: false,
      },
    },
    include: {
      user: {
        select: {
          user_roles: true,
          is_sso_user: true
        }
      }
    }
  });

  // Flatten role (take first role or default 'user')
  const roles = profile.user?.user_roles?.map(r => r.role) || [];
  const primaryRole = roles.length > 0 ? roles[0] : 'user';

  const profileWithRole = {
    ...profile,
    role: primaryRole,
    roles: roles, // also return full list
    is_sso_user: profile.user?.is_sso_user || false,
    user: undefined // remove nested user object
  };

  return reply.send({ profile: profileWithRole });
});


fastify.patch("/api/profile/me", { preHandler: requireAuth }, async (req, reply) => {
  const userId = req.user.id;

  // allow partial updates
  const {
    name,
    username,
    phone,
    avatarUrl,
    defaultLanguage,
    notificationPreferences,
  } = req.body || {};

  try {
    // make sure profile exists (safe upsert)
    const profile = await prisma.profile.upsert({
      where: { userId },
      update: {
        ...(name !== undefined ? { name } : {}),
        ...(username !== undefined ? { username } : {}),
        ...(phone !== undefined ? { phone } : {}),
        ...(avatarUrl !== undefined ? { avatarUrl } : {}),
        ...(defaultLanguage !== undefined ? { defaultLanguage } : {}),
        ...(notificationPreferences !== undefined
          ? { notificationPreferences }
          : {}),
      },
      create: {
        userId,
        name: name ?? "User",
        username: username ?? null,
        phone: phone ?? null,
        avatarUrl: avatarUrl ?? null,
        hasTrainerProfile: false,
        defaultLanguage: defaultLanguage ?? "en",
        notificationPreferences:
          notificationPreferences ?? {
            favorites: true,
            new_listings: true,
            chat_messages: true,
            first_login_done: false,
          },
      },
    });

    return reply.send({ profile });
  } catch (e) {
    req.log.error(e);
    return reply.code(500).send({ error: "failed_to_update_profile" });
  }
});


fastify.delete("/api/profile/me", { preHandler: requireAuth }, async (req, reply) => {
  try {
    const userId = req.user.id;

    // Retain forum topics and replies as "Deleted user" by setting user_id to NULL
    await prisma.$executeRaw`UPDATE public.forum_topics SET user_id = NULL WHERE user_id = ${userId}::uuid`;
    await prisma.$executeRaw`UPDATE public.forum_replies SET user_id = NULL WHERE user_id = ${userId}::uuid`;

    // Detach from conversations (participants and sender_id in messages/trainer chats)
    await prisma.$executeRaw`DELETE FROM public.conversation_participants WHERE user_id = ${userId}::uuid`;
    // We can't delete messages without breaking conversations, but we can't set sender_id to NULL if it's required.
    // However, if the user account is deleted and messages remain, we can either set them to a system UID or just delete them.
    // Let's delete the user's messages to avoid FK errors:
    await prisma.$executeRaw`DELETE FROM public.messages WHERE sender_id = ${userId}::uuid`;
    await prisma.$executeRaw`DELETE FROM public.trainer_chats WHERE sender_id = ${userId}::uuid OR client_user_id = ${userId}::uuid`;

    // Delete the auth user. Your DB has:
    // profiles.user_id -> auth.users(id) ON DELETE CASCADE
    // and many tables reference profiles(user_id) with cascade.
    await prisma.$executeRaw`
      DELETE FROM auth.users
      WHERE id = ${userId}::uuid
    `;

    return reply.code(204).send();
  } catch (e) {
    req.log.error(e);
    return reply.code(500).send({ error: "failed_to_delete_account", details: e.message || String(e) });
  }
});


// Google OAuth routes (with /api prefix for direct access)
fastify.get("/api/auth/google/start", async (req, reply) => {
  const redirectUri = process.env.GOOGLE_CALLBACK_URL;
  const clientId = process.env.GOOGLE_CLIENT_ID;

  const state = crypto.randomUUID();
  const scope = encodeURIComponent("openid email profile");

  const url =
    "https://accounts.google.com/o/oauth2/v2/auth" +
    `?client_id=${encodeURIComponent(clientId)}` +
    `&redirect_uri=${encodeURIComponent(redirectUri)}` +
    `&response_type=code` +
    `&scope=${scope}` +
    `&state=${encodeURIComponent(state)}` +
    `&prompt=select_account`;

  return reply.redirect(url);
});

// Google OAuth routes (without /api prefix for nginx proxy)
fastify.get("/auth/google/start", async (req, reply) => {
  const redirectUri = process.env.GOOGLE_CALLBACK_URL;
  const clientId = process.env.GOOGLE_CLIENT_ID;

  const state = crypto.randomUUID();
  const scope = encodeURIComponent("openid email profile");

  const url =
    "https://accounts.google.com/o/oauth2/v2/auth" +
    `?client_id=${encodeURIComponent(clientId)}` +
    `&redirect_uri=${encodeURIComponent(redirectUri)}` +
    `&response_type=code` +
    `&scope=${scope}` +
    `&state=${encodeURIComponent(state)}` +
    `&prompt=select_account`;

  return reply.redirect(url);
});


fastify.get("/api/auth/google/callback", async (req, reply) => {
  const { code } = req.query || {};
  if (!code) return reply.code(400).send({ error: "missing code" });

  const redirectUri = process.env.GOOGLE_CALLBACK_URL;

  const tokenRes = await fetch("https://oauth2.googleapis.com/token", {
    method: "POST",
    headers: { "Content-Type": "application/x-www-form-urlencoded" },
    body: new URLSearchParams({
      code: String(code),
      client_id: process.env.GOOGLE_CLIENT_ID,
      client_secret: process.env.GOOGLE_CLIENT_SECRET,
      redirect_uri: redirectUri,
      grant_type: "authorization_code",
    }),
  });

  const tokens = await tokenRes.json();
  if (!tokenRes.ok) {
    req.log.error(tokens);
    return reply.code(400).send({ error: "token_exchange_failed", details: tokens });
  }

  const ticket = await googleClient.verifyIdToken({
    idToken: tokens.id_token,
    audience: process.env.GOOGLE_CLIENT_ID,
  });

  const payload = ticket.getPayload();
  const email = String(payload.email || "").toLowerCase();
  if (!email) return reply.code(400).send({ error: "no_email_from_google" });

  // Find/create user by email
  let user = await prisma.user.findUnique({ where: { email } });
  if (!user) {
    user = await prisma.user.create({
      data: {
        email,
        passwordHash: await argon2.hash(crypto.randomUUID()), // random, unused
        emailVerified: true,
        is_sso_user: true,
      },
    });
  }

  // Ensure profile exists
  await prisma.profile.upsert({
    where: { userId: user.id },
    update: {
      name: payload.name || email.split("@")[0]
    },
    create: {
      userId: user.id,
      name: payload.name || email.split("@")[0],
      avatarUrl: payload.picture || null,
      username: null,
      phone: null,
      hasTrainerProfile: false,
      defaultLanguage: "en",
      notificationPreferences: {
        favorites: true,
        new_listings: true,
        chat_messages: true,
        first_login_done: false,
      },
    },
  });

  const jwtToken = fastify.jwt.sign({ sub: user.id, email: user.email, provider: user.is_sso_user ? 'google' : 'email', is_sso_user: user.is_sso_user });

  const web = process.env.APP_WEB_URL || "http://localhost:5173";
  return reply.redirect(`${web}/auth/callback?token=${encodeURIComponent(jwtToken)}`);
});

// Google OAuth callback (without /api prefix for nginx proxy)
fastify.get("/auth/google/callback", async (req, reply) => {
  const { code } = req.query || {};
  if (!code) return reply.code(400).send({ error: "missing code" });

  const redirectUri = process.env.GOOGLE_CALLBACK_URL;

  const tokenRes = await fetch("https://oauth2.googleapis.com/token", {
    method: "POST",
    headers: { "Content-Type": "application/x-www-form-urlencoded" },
    body: new URLSearchParams({
      code: String(code),
      client_id: process.env.GOOGLE_CLIENT_ID,
      client_secret: process.env.GOOGLE_CLIENT_SECRET,
      redirect_uri: redirectUri,
      grant_type: "authorization_code",
    }),
  });

  const tokens = await tokenRes.json();
  if (!tokenRes.ok) {
    req.log.error(tokens);
    return reply.code(400).send({ error: "token_exchange_failed", details: tokens });
  }

  const ticket = await googleClient.verifyIdToken({
    idToken: tokens.id_token,
    audience: process.env.GOOGLE_CLIENT_ID,
  });

  const payload = ticket.getPayload();
  const email = String(payload.email || "").toLowerCase();
  if (!email) return reply.code(400).send({ error: "no_email_from_google" });

  // Find/create user by email
  let user = await prisma.user.findUnique({ where: { email } });
  if (!user) {
    user = await prisma.user.create({
      data: {
        email,
        passwordHash: await argon2.hash(crypto.randomUUID()), // random, unused
        emailVerified: true,
        is_sso_user: true,
      },
    });
  }

  // Ensure profile exists
  await prisma.profile.upsert({
    where: { userId: user.id },
    update: {
      name: payload.name || email.split("@")[0]
    },
    create: {
      userId: user.id,
      name: payload.name || email.split("@")[0],
      avatarUrl: payload.picture || null,
      username: null,
      phone: null,
      hasTrainerProfile: false,
      defaultLanguage: "en",
      notificationPreferences: {
        favorites: true,
        new_listings: true,
        chat_messages: true,
        first_login_done: false,
      },
    },
  });

  const jwtToken = fastify.jwt.sign({ sub: user.id, email: user.email, provider: user.is_sso_user ? 'google' : 'email', is_sso_user: user.is_sso_user });

  const web = process.env.APP_WEB_URL || "http://localhost:5173";
  return reply.redirect(`${web}/auth/callback?token=${encodeURIComponent(jwtToken)}`);
});


fastify.post("/api/auth/update-password", { preHandler: requireAuth }, async (req, reply) => {
  const { password } = req.body || {};
  if (!password) {
    return reply.code(400).send({ error: "password required" });
  }

  const passwordHash = await argon2.hash(password);

  await prisma.user.update({
    where: { id: req.user.id },
    data: { passwordHash },
  });

  return reply.send({ success: true });
});

fastify.post("/api/auth/update-email", { preHandler: requireAuth }, async (req, reply) => {
  const { email } = req.body || {};
  if (!email) {
    return reply.code(400).send({ error: "email required" });
  }

  const normalizedEmail = String(email).toLowerCase().trim();

  // Check if email is already taken
  const existing = await prisma.user.findUnique({ where: { email: normalizedEmail } });
  if (existing && existing.id !== req.user.id) {
    return reply.code(400).send({ error: "Email already in use" });
  }

  await prisma.user.update({
    where: { id: req.user.id },
    data: { email: normalizedEmail, emailVerified: false },
  });

  return reply.send({ success: true, email: normalizedEmail });
});


// --- routes ---


fastify.get("/health", async () => ({ ok: true }));

fastify.get("/diag", async (req, reply) => {
  try {
    const horses = await prisma.$queryRawUnsafe('SELECT count(*) FROM public.horse_listings');
    const equipment = await prisma.$queryRawUnsafe('SELECT count(*) FROM public.equipment_listings');
    const visibleHorses = await prisma.$queryRawUnsafe('SELECT count(*) FROM public.horse_listings WHERE visible = true');
    const visibleEquipment = await prisma.$queryRawUnsafe('SELECT count(*) FROM public.equipment_listings WHERE visible = true');
    const trainers = await prisma.$queryRawUnsafe('SELECT count(*) FROM public.trainers');
    const services = await prisma.$queryRawUnsafe('SELECT count(*) FROM public.services');

    return {
      status: 'ok',
      counts: {
        horses: horses[0].count,
        visibleHorses: visibleHorses[0].count,
        equipment: equipment[0].count,
        visibleEquipment: visibleEquipment[0].count,
        trainers: trainers[0].count,
        services: services[0].count
      }
    };
  } catch (err) {
    return reply.code(500).send({ error: err.message });
  }
});

fastify.register(dictionariesRoutes, { prefix: "/dictionaries" });
fastify.register(dictionariesRoutes, { prefix: "/api/dictionaries" });

fastify.register(listingsRoutes, { prefix: "/listings" });
fastify.register(listingsRoutes, { prefix: "/api/listings" });

fastify.register(trainersRoutes, { prefix: "/trainers" });
fastify.register(trainersRoutes, { prefix: "/api/trainers" });

fastify.register(servicesRoutes, { prefix: "/services" });
fastify.register(servicesRoutes, { prefix: "/api/services" });

const announcementsRoutes = require("./routes/announcements");
fastify.register(announcementsRoutes, { prefix: "/announcements" });
fastify.register(announcementsRoutes, { prefix: "/api/announcements" });

const forumRoutes = require("./routes/forums");
fastify.register(forumRoutes, { prefix: "/forums" });
fastify.register(forumRoutes, { prefix: "/api/forums" });

// DEBUG ROUTE - Verify deployment
fastify.get("/api/forums-ping", async () => ({ status: "pong", version: "v3-double-register" }));



fastify.get("/whoami", async (req) => {
  return {
    ip: req.ip,
    ips: req.ips,
    xff: req.headers["x-forwarded-for"],
    realip: req.headers["x-real-ip"],
  };
});


fastify.post("/files/signed-upload", { preHandler: requireAuth }, async (req, reply) => {
  const { filename, contentType, isPublic, bucket: requestedBucket } = req.body || {};
  if (!filename || !contentType) {
    return reply.code(400).send({ error: "filename and contentType required" });
  }

  let bucket = isPublic ? PUBLIC_BUCKET : PRIVATE_BUCKET;
  if (requestedBucket) {
    if (!ALLOWED_BUCKETS.has(requestedBucket)) {
      return reply.code(400).send({ error: "invalid bucket" });
    }
    bucket = requestedBucket;
  }

  const safeName = String(filename).replace(/[^a-zA-Z0-9_.-]/g, '_');
  const key = `${crypto.randomUUID()}/${safeName}`;

  const cmd = new PutObjectCommand({
    Bucket: bucket,
    Key: key,
    ContentType: contentType,
  });

  const uploadUrl = await getSignedUrl(s3Presign, cmd, { expiresIn: 60 * 5 });
  return reply.send({ uploadUrl, key, bucket });
});




const chatRoutes = require("./routes/chat");
fastify.register(chatRoutes, { prefix: "/chat" });
fastify.register(chatRoutes, { prefix: "/api/chat" });


fastify.get("/files/:bucket/*", async (req, reply) => {
  const bucket = req.params.bucket;
  const key = req.params["*"];

  // allow only known buckets
  if (!ALLOWED_BUCKETS.has(bucket)) {
    return reply.code(404).send({ message: "Not found" });
  }



  // protect private bucket
  if (bucket === PRIVATE_BUCKET) {
    const auth = req.headers.authorization || "";
    const token = auth.startsWith("Bearer ") ? auth.slice(7) : null;
    if (!token) return reply.code(401).send({ error: "missing token" });
    try {
      const payload = fastify.jwt.verify(token);
      req.user = { id: payload.sub, email: payload.email };
    } catch {
      return reply.code(401).send({ error: "invalid token" });
    }
  }

  try {
    const obj = await s3Internal.send(new GetObjectCommand({ Bucket: bucket, Key: key }));

    if (obj.ContentType) reply.header("Content-Type", obj.ContentType);
    reply.header("Cache-Control", "public, max-age=31536000, immutable");
    // prevents ERR_BLOCKED_BY_RESPONSE.NotSameOrigin for images
    reply.header("Cross-Origin-Resource-Policy", "cross-origin");

    if (req.query.download) {
      const filename = req.query.filename || key.split("/").pop() || "download";
      // Sanitize filename to avoid header encoding issues
      const safeFilename = filename.replace(/"/g, '\\"');
      reply.header("Content-Disposition", `attachment; filename="${safeFilename}"`);
    }

    return reply.send(obj.Body);
  } catch (e) {
    req.log.error(e);
    return reply.code(404).send({ message: "Not found" });
  }
});


fastify.get("/files/signed-download", { preHandler: requireAuth }, async (req, reply) => {
  const { key, bucket } = req.query || {};
  if (!key) return reply.code(400).send({ error: "key required" });
  if (!bucket) return reply.code(400).send({ error: "bucket required" });

  const cmd = new GetObjectCommand({ Bucket: String(bucket), Key: String(key) });
  const downloadUrl = await getSignedUrl(s3Presign, cmd, { expiresIn: 60 * 5 });

  return reply.send({ downloadUrl });
});


fastify.post(
  "/api/auth/register",
  { config: { rateLimit: { max: 5, timeWindow: "1 minute" } } },
  async (req, reply) => {
    const { email, password, name } = req.body || {};
    if (!email || !password) {
      return reply.code(400).send({ error: "email and password required" });
    }

    // normalize email (optional but recommended)
    const safeEmail = String(email).trim().toLowerCase();

    const existing = await prisma.user.findUnique({ where: { email: safeEmail } });
    if (existing) return reply.code(409).send({ error: "email already in use" });

    const passwordHash = await argon2.hash(password);

    // ✅ transaction: user + profile always together
    const { user } = await prisma.$transaction(async (tx) => {
      const user = await tx.user.create({
        data: { email: safeEmail, passwordHash },
        select: { id: true, email: true, emailVerified: true, createdAt: true },
      });

      await tx.profile.upsert({
        where: { userId: user.id },
        update: {
          name: name || safeEmail.split("@")[0] || ""
        },
        create: {
          userId: user.id,
          name: name || safeEmail.split("@")[0] || "",
          username: null,
          avatarUrl: null,
          phone: null,
          hasTrainerProfile: false,
          defaultLanguage: "en",
          notificationPreferences: {
            favorites: true,
            new_listings: true,
            chat_messages: true,
            first_login_done: false,
          },
        },
      });

      return { user };
    });

    const otp = Math.floor(100000 + Math.random() * 900000).toString();

    await prisma.user.update({
      where: { id: user.id },
      data: {
        confirmation_token: otp,
        confirmation_sent_at: new Date()
      }
    });

    const { sendEmail } = require('./services/emailService');
    const lang = req.body?.lang || 'en';
    const { getTranslation } = require('./config/emailTranslations');
    const subject = getTranslation(lang, 'otp_subject');
    const bodyText = getTranslation(lang, 'otp_body');

    sendEmail({
      to: user.email,
      subject: subject,
      html: `<p>${bodyText} <strong style="font-size: 24px;">${otp}</strong></p>`
    });

    return reply.send({ requiresVerification: true, email: user.email });
  }
);

fastify.post(
  "/api/auth/verify-email",
  { config: { rateLimit: { max: 10, timeWindow: "15 minutes" } } },
  async (req, reply) => {
    const { email, code } = req.body || {};
    if (!email || !code) return reply.code(400).send({ error: "email and code required" });

    const user = await prisma.user.findUnique({
      where: { email: String(email).trim().toLowerCase() }
    });

    if (!user) return reply.code(400).send({ error: "user_not_found" });

    if (user.emailVerified) return reply.send({ success: true, emailVerified: true });

    if (user.confirmation_token !== String(code)) {
      return reply.code(400).send({ error: "invalid_code", message: "Invalid verification code." });
    }

    const expiration = 15 * 60 * 1000;
    if (new Date() - new Date(user.confirmation_sent_at) > expiration) {
      return reply.code(400).send({ error: "code_expired", message: "Verification code has expired." });
    }

    const updatedUser = await prisma.user.update({
      where: { id: user.id },
      data: {
        emailVerified: true,
        confirmation_token: null,
        confirmation_sent_at: null
      }
    });

    const token = fastify.jwt.sign({ sub: updatedUser.id, email: updatedUser.email });
    return reply.send({ user: { id: updatedUser.id, email: updatedUser.email, emailVerified: true }, token });
  }
);


fastify.post(
  "/api/auth/login",
  { config: { rateLimit: { max: 20, timeWindow: "1 minute" } } },
  async (req, reply) => {
    const { email, password } = req.body || {};
    if (!email || !password) {
      return reply.code(400).send({ error: "email and password required" });
    }

    const user = await prisma.user.findUnique({ where: { email } });
    if (!user) return reply.code(401).send({ error: "invalid credentials" });

    const ok = await argon2.verify(user.passwordHash, password);
    if (!ok) return reply.code(401).send({ error: "invalid credentials" });

    if (!user.emailVerified) {
      const otp = Math.floor(100000 + Math.random() * 900000).toString();
      await prisma.user.update({
        where: { id: user.id },
        data: {
          confirmation_token: otp,
          confirmation_sent_at: new Date()
        }
      });
      const { sendEmail } = require('./services/emailService');
      const lang = req.body?.lang || 'en';
      const { getTranslation } = require('./config/emailTranslations');
      const subject = getTranslation(lang, 'otp_subject');
      const bodyText = getTranslation(lang, 'otp_body');
      sendEmail({
        to: user.email,
        subject: subject,
        html: `<p>${bodyText} <strong style="font-size: 24px;">${otp}</strong></p>`
      });
      return reply.code(403).send({ error: "email_not_verified", message: "Please verify your email address.", requiresVerification: true, email: user.email });
    }

    const token = fastify.jwt.sign({ sub: user.id, email: user.email });
    return reply.send({
      user: { id: user.id, email: user.email, emailVerified: user.emailVerified },
      token,
    });
  }
);

fastify.post(
  "/api/auth/forgot-password",
  { config: { rateLimit: { max: 5, timeWindow: "15 minutes" } } },
  async (req, reply) => {
    const { email, lang: reqLang } = req.body || {};
    if (!email) return reply.code(400).send({ error: "email required" });

    const safeEmail = String(email).trim().toLowerCase();

    // Include profile to check language for localized emails
    const user = await prisma.user.findUnique({
      where: { email: safeEmail },
      include: { profile: true }
    });

    if (!user) return reply.code(404).send({ error: "user_not_found", message: "User with this email does not exist." });

    const lang = reqLang || user.profile?.defaultLanguage || 'en';

    // If Google SSO user, send alternate email
    if (user.is_sso_user) {
      const subject = getTranslation(lang, 'sso_password_reset_subject') || "Horse Portal Login Info";
      const body = getTranslation(lang, 'sso_password_reset_body') || "You requested a password reset, but you created this account using Google. Please return to Horse Portal and click the 'Continue with Google' button to log in.";
      const linkText = getTranslation(lang, 'sso_login_btn') || "Return to Website";
      const linkUrl = process.env.APP_WEB_URL || "http://localhost:5173";

      sendEmail({
        to: user.email,
        subject: subject,
        html: `<p>${body}</p><p><a href="${linkUrl}" style="display:inline-block;padding:10px 20px;background-color:#007bff;color:#fff;text-decoration:none;border-radius:5px;">${linkText}</a></p>`
      });

      return reply.send({ success: true });
    }

    const token = crypto.randomBytes(32).toString('hex');

    await prisma.user.update({
      where: { id: user.id },
      data: {
        recovery_token: token,
        recovery_sent_at: new Date()
      }
    });

    const subject = getTranslation(lang, 'forgot_password_subject');
    const body = getTranslation(lang, 'forgot_password_body');
    const linkText = getTranslation(lang, 'reset_password_btn');
    const linkUrl = `${process.env.APP_WEB_URL || "http://localhost:5173"}/${lang}/reset-password?token=${token}`;

    sendEmail({
      to: user.email,
      subject: subject,
      html: `<p>${body}</p><p><a href="${linkUrl}" style="display:inline-block;padding:10px 20px;background-color:#007bff;color:#fff;text-decoration:none;border-radius:5px;">${linkText}</a></p>`
    });

    return reply.send({ success: true });
  }
);

fastify.post(
  "/api/auth/reset-password",
  { config: { rateLimit: { max: 5, timeWindow: "15 minutes" } } },
  async (req, reply) => {
    const { token, password } = req.body || {};
    if (!token || !password) return reply.code(400).send({ error: "token and password required" });

    const user = await prisma.user.findFirst({
      where: { recovery_token: token }
    });

    if (!user) return reply.code(400).send({ error: "invalid or expired token" });

    const expiration = 60 * 60 * 1000;
    if (new Date() - new Date(user.recovery_sent_at) > expiration) {
      return reply.code(400).send({ error: "invalid or expired token" });
    }

    const passwordHash = await argon2.hash(password);

    await prisma.user.update({
      where: { id: user.id },
      data: {
        passwordHash,
        recovery_token: null,
        recovery_sent_at: null
      } // Invalidate token after consumption
    });

    return reply.send({ success: true });
  }
);

// ========== Routes without /api prefix (for nginx proxy) ==========

// Profile routes (nginx strips /api)
fastify.get("/profile/me", { preHandler: requireAuth }, async (req, reply) => {
  const userId = req.user.id;

  const profile = await prisma.profile.upsert({
    where: { userId },
    update: {},
    create: {
      userId,
      name: req.user.email?.split("@")[0] || "",
      username: null,
      avatarUrl: null,
      phone: null,
      hasTrainerProfile: false,
      defaultLanguage: "en",
      notificationPreferences: {
        favorites: true,
        new_listings: true,
        chat_messages: true,
        first_login_done: false,
      },
    },
    include: {
      user: {
        select: {
          user_roles: true,
          is_sso_user: true
        }
      }
    }
  });

  const roles = profile.user?.user_roles?.map(r => r.role) || [];
  const primaryRole = roles.length > 0 ? roles[0] : 'user';

  const profileWithRole = {
    ...profile,
    role: primaryRole,
    roles: roles,
    is_sso_user: profile.user?.is_sso_user || false,
    user: undefined
  };

  return reply.send({ profile: profileWithRole });
});

fastify.patch("/profile/me", { preHandler: requireAuth }, async (req, reply) => {
  const userId = req.user.id;

  const {
    name,
    username,
    phone,
    avatarUrl,
    defaultLanguage,
    notificationPreferences,
  } = req.body || {};

  try {
    if (username && username.toLowerCase() === 'deleted_user') {
      return reply.code(400).send({ error: "Username 'deleted_user' is reserved and cannot be used." });
    }

    const profile = await prisma.profile.upsert({
      where: { userId },
      update: {
        ...(name !== undefined ? { name } : {}),
        ...(username !== undefined ? { username } : {}),
        ...(phone !== undefined ? { phone } : {}),
        ...(avatarUrl !== undefined ? { avatarUrl } : {}),
        ...(defaultLanguage !== undefined ? { defaultLanguage } : {}),
        ...(notificationPreferences !== undefined
          ? { notificationPreferences }
          : {}),
      },
      create: {
        userId,
        name: name ?? "User",
        username: username ?? null,
        phone: phone ?? null,
        avatarUrl: avatarUrl ?? null,
        hasTrainerProfile: false,
        defaultLanguage: defaultLanguage ?? "en",
        notificationPreferences:
          notificationPreferences ?? {
            favorites: true,
            new_listings: true,
            chat_messages: true,
            first_login_done: false,
          },
      },
    });

    return reply.send({ profile });
  } catch (e) {
    req.log.error(e);
    if (e.code === 'P2002') {
      return reply.code(400).send({ error: "username_taken", message: "Username is already taken" });
    }
    return reply.code(500).send({ error: "failed_to_update_profile", message: e.message });
  }
});

fastify.delete("/profile/me", { preHandler: requireAuth }, async (req, reply) => {
  try {
    const userId = req.user.id;

    // Retain forum topics and replies as "Deleted user" by setting user_id to NULL
    await prisma.$executeRaw`UPDATE public.forum_topics SET user_id = NULL WHERE user_id = ${userId}::uuid`;
    await prisma.$executeRaw`UPDATE public.forum_replies SET user_id = NULL WHERE user_id = ${userId}::uuid`;

    // Detach from conversations
    await prisma.$executeRaw`DELETE FROM public.conversation_participants WHERE user_id = ${userId}::uuid`;
    await prisma.$executeRaw`DELETE FROM public.messages WHERE sender_id = ${userId}::uuid`;
    await prisma.$executeRaw`DELETE FROM public.trainer_chats WHERE sender_id = ${userId}::uuid OR client_user_id = ${userId}::uuid`;

    // Manually delete horse listings since the foreign key fk_horse_profiles prevents profile deletion
    await prisma.horse_listings.deleteMany({ where: { user_id: userId } });

    await prisma.profile.delete({ where: { userId } });
    await prisma.user.delete({ where: { id: userId } });
    return reply.send({ success: true });
  } catch (e) {
    req.log.error(e);
    return reply.code(500).send({ error: "failed_to_delete_profile", details: e.message || String(e) });
  }
});

// Auth routes (nginx strips /api)
fastify.post(
  "/auth/register",
  { config: { rateLimit: { max: 5, timeWindow: "1 minute" } } },
  async (req, reply) => {
    const { email, password } = req.body || {};
    if (!email || !password) {
      return reply.code(400).send({ error: "email and password required" });
    }

    const safeEmail = String(email).trim().toLowerCase();

    const existing = await prisma.user.findUnique({ where: { email: safeEmail } });
    if (existing) return reply.code(409).send({ error: "email already in use" });

    const passwordHash = await argon2.hash(password);

    const { user } = await prisma.$transaction(async (tx) => {
      const user = await tx.user.create({
        data: { email: safeEmail, passwordHash },
        select: { id: true, email: true, emailVerified: true, createdAt: true },
      });

      await tx.profile.upsert({
        where: { userId: user.id },
        update: {
          name: req.body.name || safeEmail.split("@")[0] || ""
        },
        create: {
          userId: user.id,
          name: req.body.name || safeEmail.split("@")[0] || "",
          username: null,
          avatarUrl: null,
          phone: null,
          hasTrainerProfile: false,
          defaultLanguage: "en",
          notificationPreferences: {
            favorites: true,
            new_listings: true,
            chat_messages: true,
            first_login_done: false,
          },
        },
      });

      return { user };
    });

    const otp = Math.floor(100000 + Math.random() * 900000).toString();

    await prisma.user.update({
      where: { id: user.id },
      data: {
        confirmation_token: otp,
        confirmation_sent_at: new Date()
      }
    });

    const { sendEmail } = require('./services/emailService');
    const lang = req.body?.lang || 'en';
    const { getTranslation } = require('./config/emailTranslations');
    const subject = getTranslation(lang, 'otp_subject');
    const bodyText = getTranslation(lang, 'otp_body');

    sendEmail({
      to: user.email,
      subject: subject,
      html: `<p>${bodyText} <strong style="font-size: 24px;">${otp}</strong></p>`
    });

    return reply.send({ requiresVerification: true, email: user.email });
  }
);

fastify.post(
  "/auth/verify-email",
  { config: { rateLimit: { max: 10, timeWindow: "15 minutes" } } },
  async (req, reply) => {
    const { email, code } = req.body || {};
    if (!email || !code) return reply.code(400).send({ error: "email and code required" });

    const user = await prisma.user.findUnique({
      where: { email: String(email).trim().toLowerCase() }
    });

    if (!user) return reply.code(400).send({ error: "user_not_found" });

    if (user.emailVerified) return reply.send({ success: true, emailVerified: true });

    if (user.confirmation_token !== String(code)) {
      return reply.code(400).send({ error: "invalid_code", message: "Invalid verification code." });
    }

    const expiration = 15 * 60 * 1000;
    if (new Date() - new Date(user.confirmation_sent_at) > expiration) {
      return reply.code(400).send({ error: "code_expired", message: "Verification code has expired." });
    }

    const updatedUser = await prisma.user.update({
      where: { id: user.id },
      data: {
        emailVerified: true,
        confirmation_token: null,
        confirmation_sent_at: null
      }
    });

    const token = fastify.jwt.sign({ sub: updatedUser.id, email: updatedUser.email });
    return reply.send({ user: { id: updatedUser.id, email: updatedUser.email, emailVerified: true }, token });
  }
);

fastify.post(
  "/auth/login",
  { config: { rateLimit: { max: 20, timeWindow: "1 minute" } } },
  async (req, reply) => {
    const { email, password } = req.body || {};
    if (!email || !password) {
      return reply.code(400).send({ error: "email and password required" });
    }

    const user = await prisma.user.findUnique({ where: { email } });
    if (!user) return reply.code(401).send({ error: "invalid credentials" });

    const ok = await argon2.verify(user.passwordHash, password);
    if (!ok) return reply.code(401).send({ error: "invalid credentials" });

    if (!user.emailVerified) {
      const otp = Math.floor(100000 + Math.random() * 900000).toString();
      await prisma.user.update({
        where: { id: user.id },
        data: {
          confirmation_token: otp,
          confirmation_sent_at: new Date()
        }
      });
      const { sendEmail } = require('./services/emailService');
      const lang = req.body?.lang || 'en';
      const { getTranslation } = require('./config/emailTranslations');
      const subject = getTranslation(lang, 'otp_subject');
      const bodyText = getTranslation(lang, 'otp_body');
      sendEmail({
        to: user.email,
        subject: subject,
        html: `<p>${bodyText} <strong style="font-size: 24px;">${otp}</strong></p>`
      });
      return reply.code(403).send({ error: "email_not_verified", message: "Please verify your email address.", requiresVerification: true, email: user.email });
    }

    const token = fastify.jwt.sign({ sub: user.id, email: user.email });
    return reply.send({
      user: { id: user.id, email: user.email, emailVerified: user.emailVerified },
      token,
    });
  }
);

fastify.post(
  "/auth/forgot-password",
  { config: { rateLimit: { max: 5, timeWindow: "15 minutes" } } },
  async (req, reply) => {
    const { email, lang: reqLang } = req.body || {};
    if (!email) return reply.code(400).send({ error: "email required" });

    const safeEmail = String(email).trim().toLowerCase();

    // Include profile to check language for localized emails
    const user = await prisma.user.findUnique({
      where: { email: safeEmail },
      include: { profile: true }
    });

    if (!user) return reply.code(404).send({ error: "user_not_found", message: "User with this email does not exist." });

    const lang = reqLang || user.profile?.defaultLanguage || 'en';

    // If Google SSO user, send alternate email
    if (user.is_sso_user) {
      const subject = getTranslation(lang, 'sso_password_reset_subject') || "Horse Portal Login Info";
      const body = getTranslation(lang, 'sso_password_reset_body') || "You requested a password reset, but you created this account using Google. Please return to Horse Portal and click the 'Continue with Google' button to log in.";
      const linkText = getTranslation(lang, 'sso_login_btn') || "Return to Website";
      const linkUrl = process.env.APP_WEB_URL || "http://localhost:5173";

      const { sendEmail } = require('./services/emailService');
      sendEmail({
        to: user.email,
        subject: subject,
        html: `<p>${body}</p><p><a href="${linkUrl}" style="display:inline-block;padding:10px 20px;background-color:#007bff;color:#fff;text-decoration:none;border-radius:5px;">${linkText}</a></p>`
      });

      return reply.send({ success: true });
    }

    const crypto = require('crypto');
    const token = crypto.randomBytes(32).toString('hex');

    await prisma.user.update({
      where: { id: user.id },
      data: {
        recovery_token: token,
        recovery_sent_at: new Date()
      }
    });

    const subject = getTranslation(lang, 'forgot_password_subject');
    const body = getTranslation(lang, 'forgot_password_body');
    const linkText = getTranslation(lang, 'reset_password_btn');
    const linkUrl = `${process.env.APP_WEB_URL || "http://localhost:5173"}/${lang}/reset-password?token=${token}`;

    const { sendEmail } = require('./services/emailService');
    sendEmail({
      to: user.email,
      subject: subject,
      html: `<p>${body}</p><p><a href="${linkUrl}" style="display:inline-block;padding:10px 20px;background-color:#007bff;color:#fff;text-decoration:none;border-radius:5px;">${linkText}</a></p>`
    });

    return reply.send({ success: true });
  }
);

fastify.post(
  "/auth/reset-password",
  { config: { rateLimit: { max: 5, timeWindow: "15 minutes" } } },
  async (req, reply) => {
    const { token, password } = req.body || {};
    if (!token || !password) return reply.code(400).send({ error: "token and password required" });

    const user = await prisma.user.findFirst({
      where: { recovery_token: token }
    });

    if (!user) return reply.code(400).send({ error: "invalid or expired token" });

    const expiration = 60 * 60 * 1000;
    if (new Date() - new Date(user.recovery_sent_at) > expiration) {
      return reply.code(400).send({ error: "invalid or expired token" });
    }

    const argon2 = require('argon2');
    const passwordHash = await argon2.hash(password);

    await prisma.user.update({
      where: { id: user.id },
      data: {
        passwordHash,
        recovery_token: null,
        recovery_sent_at: null
      } // Invalidate token after consumption
    });

    return reply.send({ success: true });
  }
);

// --- start + websockets ---
const start = async () => {
  try {
    const port = Number(process.env.PORT || 8085);

    // create socket.io BEFORE listen so it attaches to the same server
    const io = new Server(fastify.server, {
      path: "/ws",
      cors: {
        origin: [
          "https://horseportal.net",
          "https://www.horseportal.net",
          "https://dev-api.horseportal.net",
          "http://localhost:8083",
          "http://localhost:5173",
          "http://127.0.0.1:8083",
          "http://127.0.0.1:5173",
        ],
        credentials: true,
        methods: ["GET", "POST", "OPTIONS"],
        allowedHeaders: ["Authorization", "Content-Type"],
      },
    });

    io.use((socket, next) => {
      try {
        const token =
          socket.handshake.auth?.token ||
          (socket.handshake.headers.authorization || "").replace("Bearer ", "");

        if (!token) return next(new Error("missing token"));

        const payload = fastify.jwt.verify(token);
        socket.user = { id: payload.sub, email: payload.email };
        return next();
      } catch {
        return next(new Error("invalid token"));
      }
    });

    io.on("connection", (socket) => {
      fastify.log.info({ socketId: socket.id, user: socket.user }, "ws connected");

      socket.on("ping", () => socket.emit("pong"));

      socket.on("chat:join", async ({ conversationId }) => {
        if (!conversationId) return;

        const participant = await prisma.conversationParticipant.findUnique({
          where: { conversationId_userId: { conversationId, userId: socket.user.id } },
        });

        if (!participant) {
          socket.emit("chat:error", { error: "not a participant" });
          return;
        }

        socket.join(`conv:${conversationId}`);
        socket.emit("chat:joined", { conversationId });
      });

      socket.on("chat:send", async ({ conversationId, body, files }) => {
        try {
          if (!conversationId || (!body && (!files || files.length === 0))) return;

          const participant = await prisma.conversationParticipant.findUnique({
            where: { conversationId_userId: { conversationId, userId: socket.user.id } },
          });

          if (!participant) {
            socket.emit("chat:error", { error: "not a participant" });
            return;
          }

          // Convert file objects to strings for storage if they exist
          const attachmentStrings = files ? files.map(f => JSON.stringify(f)) : [];

          const msg = await prisma.message.create({
            data: {
              conversationId,
              senderId: socket.user.id,
              content: body ? String(body).slice(0, 5000) : "",
              attachments: attachmentStrings,
            },
            include: { sender: { select: { id: true, userId: true, name: true, username: true, avatarUrl: true } } },
          });

          // Bump conversation updatedAt so it appears at the top of the chat list
          await prisma.conversation.update({
            where: { id: conversationId },
            data: { updatedAt: new Date() }
          });

          // Send back to clients (parse attachments back to objects for frontend convenience if needed, 
          // but frontend expects what it gets from DB usually. 
          // Actually, let's send the objects directly in the socket event so frontend doesn't need to parse strings immediately)
          io.to(`conv:${conversationId}`).emit("chat:new_message", {
            id: msg.id,
            conversationId: msg.conversationId,
            content: msg.content,
            createdAt: msg.createdAt,
            sender: msg.sender,
            files: files || [], // Pass original objects for immediate display
          });
          // Send email notification to offline/other participants
          console.log(`[ChatDebug] Sending email to offline/other participants for conversation ${conversationId}`);
          const participants = await prisma.conversationParticipant.findMany({
            where: { conversationId, userId: { not: socket.user.id } },
            include: { user: { include: { user: true } } }
          });
          console.log(`[ChatDebug] Found ${participants.length} other participants.`);

          for (const p of participants) {
            const profile = p.user;
            const actualUser = p.user?.user;

            const prefs = profile?.notificationPreferences || {};
            const lang = profile?.defaultLanguage || 'en';

            try {
              if (prefs.chat_messages !== false) {
                await prisma.notifications.create({
                  data: {
                    user_id: p.userId,
                    type: 'new_message',
                    title: 'New chat message',
                    content: 'You have a new message',
                    source_type: 'chat',
                    source_id: conversationId,
                    source_user_id: socket.user.id
                  }
                });
              }
            } catch (notifErr) {
              fastify.log.error(notifErr, "Failed to create chat notification");
            }

            // Default chat_messages to true if undefined
            console.log(`[ChatDebug] Processing participant ${p.userId}. Prefs: chat_messages=${prefs.chat_messages}`);
            if (actualUser?.email && (prefs.chat_messages_email ?? prefs.chat_messages ?? true) !== false) {
              console.log(`[ChatDebug] Sending email to ${actualUser.email}`);
              const subject = getTranslation(lang, 'chat_subject');
              const body = getTranslation(lang, 'chat_body');
              const linkText = getTranslation(lang, 'view_message');

              await sendEmail({
                to: actualUser.email,
                subject: subject,
                html: `<p>${body}</p><p><a href="${process.env.APP_WEB_URL}/${lang}/messages?chatId=${conversationId}">${linkText}</a></p>`
              });
            } else {
              console.log(`[ChatDebug] Skipped email to ${actualUser?.email}: prefs check failed`);
            }
          }
        } catch (e) {
          fastify.log.error(e);
          socket.emit("chat:error", { error: "send failed" });
        }
      });

      socket.on("disconnect", (reason) => {
        fastify.log.info({ socketId: socket.id, reason }, "ws disconnected");
      });
    });




    // --- FAVORITES ---
    fastify.get("/favorites", { preHandler: requireAuth }, async (req, reply) => {
      try {
        // 1. Listings
        const listingFavs = await prisma.listing_favorites.findMany({
          where: { user_id: req.user.id }
        });

        const horseIds = listingFavs.filter(l => l.listing_type === 'horse' || l.listing_type === 'horses').map(l => l.listing_id);
        const equipmentIds = listingFavs.filter(l => l.listing_type === 'equipment' || l.listing_type === 'tack').map(l => l.listing_id);

        const [horses, equipment] = await Promise.all([
          horseIds.length > 0 ? prisma.horse_listings.findMany({
            where: { id: { in: horseIds }, visible: true },
            include: { profiles: { select: { name: true, username: true, avatarUrl: true } } }
          }) : [],
          equipmentIds.length > 0 ? prisma.equipment_listings.findMany({
            where: { id: { in: equipmentIds }, visible: true },
            include: { profiles: { select: { name: true, username: true, avatarUrl: true } } }
          }) : []
        ]);

        const listings = [
          ...horses.map(h => ({ ...h, category: 'horses', seller: h.profiles })),
          ...equipment.map(e => ({ ...e, category: 'equipment', seller: e.profiles }))
        ];

        // 2. Services
        const serviceFavs = await prisma.service_favorites.findMany({
          where: { user_id: req.user.id }
        });
        const serviceIds = serviceFavs.map(f => f.service_id);
        const services = serviceIds.length > 0 ? await prisma.services.findMany({
          where: { id: { in: serviceIds }, visible: true },
          include: { profiles: { select: { name: true, username: true, avatarUrl: true } } }
        }) : [];

        // 3. Trainers
        const trainerFavs = await prisma.trainer_favorites.findMany({
          where: { user_id: req.user.id }
        });
        const trainerIds = trainerFavs.map(f => f.trainer_id);
        const trainers = trainerIds.length > 0 ? await prisma.trainers.findMany({
          where: { id: { in: trainerIds }, visible: true },
          include: { profiles: { select: { name: true, username: true, avatarUrl: true } } }
        }) : [];

        return {
          listings,
          services: services.map(s => ({ ...s, seller: s.profiles })),
          trainers: trainers.map(t => ({ ...t, seller: t.profiles }))
        };
      } catch (e) {
        fastify.log.error(e);
        return { listings: [], services: [], trainers: [] };
      }
    });

    fastify.get("/favorites/check", { preHandler: requireAuth }, async (req, reply) => {
      const { type, id, listingType } = req.query;

      try {
        if (type === 'listing') {
          const count = await prisma.listing_favorites.count({
            where: {
              user_id: req.user.id,
              listing_id: id
            }
          });
          return { isFavorited: count > 0 };
        } else if (type === 'service') {
          const count = await prisma.service_favorites.count({
            where: {
              user_id: req.user.id,
              service_id: id
            }
          });
          return { isFavorited: count > 0 };
        } else if (type === 'trainer') {
          const count = await prisma.trainer_favorites.count({
            where: {
              user_id: req.user.id,
              trainer_id: id
            }
          });
          return { isFavorited: count > 0 };
        }

        return { isFavorited: false };
      } catch (e) {
        fastify.log.error(e);
        return { isFavorited: false };
      }
    });

    fastify.post("/favorites/toggle", { preHandler: requireAuth }, async (req, reply) => {
      const { type, id, listingType } = req.body;

      try {
        if (type === 'listing') {
          const whereClause = {
            user_id: req.user.id,
            listing_id: id
          };

          const existing = await prisma.listing_favorites.findFirst({ where: whereClause });

          if (existing) {
            await prisma.listing_favorites.delete({ where: { id: existing.id } });
            const table = existing.listing_type === 'equipment' ? 'equipment_listings' : 'horse_listings';
            await prisma.$executeRawUnsafe(`UPDATE public.${table} SET favorites_count = GREATEST(COALESCE(favorites_count, 0) - 1, 0) WHERE id = $1::uuid`, existing.listing_id);
            return { favorited: false };
          } else {
            const normalizedType = listingType === 'horses' ? 'horse' : (listingType || 'horse');
            await prisma.listing_favorites.create({
              data: {
                user_id: req.user.id,
                listing_id: id,
                listing_type: normalizedType
              }
            });
            const table = normalizedType === 'equipment' ? 'equipment_listings' : 'horse_listings';
            await prisma.$executeRawUnsafe(`UPDATE public.${table} SET favorites_count = COALESCE(favorites_count, 0) + 1 WHERE id = $1::uuid`, id);

            // Email Notification
            try {
              const item = await prisma[table].findUnique({ where: { id } });
              if (item && item.user_id && item.user_id !== req.user.id) {
                try {
                  const ownerProfile = await prisma.user.findUnique({
                    where: { id: item.user_id },
                    include: { profile: true }
                  });
                  const prefs = ownerProfile?.profile?.notificationPreferences || {};

                  if (prefs.favorites !== false) {
                    await prisma.notifications.create({
                      data: {
                        user_id: item.user_id,
                        type: 'listing_favorited',
                        title: 'Listing favorited',
                        content: `Someone favorited your listing`,
                        source_type: normalizedType === 'equipment' ? 'equipment' : 'horse',
                        source_id: id,
                        source_user_id: req.user.id
                      }
                    });
                  }
                } catch (e) { fastify.log.error(e, "Failed to create fav notification"); }

                const owner = await prisma.user.findUnique({
                  where: { id: item.user_id },
                  include: { profile: true }
                });
                if (owner && owner.email) {
                  const prefs = owner.profile?.notificationPreferences || {};
                  const lang = owner.profile?.defaultLanguage || 'en';

                  if ((prefs.favorites_email ?? prefs.favorites ?? true) !== false) {
                    const subject = getTranslation(lang, 'favorite_listing_subject');
                    const bodyFn = getTranslation(lang, 'favorite_listing_body');
                    const body = typeof bodyFn === 'function' ? bodyFn(item.title || 'Item') : bodyFn;
                    const linkText = getTranslation(lang, 'view_listing');

                    sendEmail({
                      to: owner.email,
                      subject: subject,
                      html: `<p>${body}</p><p><a href="${process.env.APP_WEB_URL}/${lang}/${normalizedType === 'equipment' ? 'equipment' : 'horses'}/${id}">${linkText}</a></p>`
                    });
                  }
                }
              }
            } catch (err) { fastify.log.error(err); }

            return { favorited: true };
          }
        } else if (type === 'service') {
          const whereClause = {
            user_id: req.user.id,
            service_id: id
          };

          const existing = await prisma.service_favorites.findFirst({ where: whereClause });

          if (existing) {
            await prisma.service_favorites.delete({ where: { id: existing.id } });
            await prisma.$executeRawUnsafe(`UPDATE public.services SET favorites_count = GREATEST(COALESCE(favorites_count, 0) - 1, 0) WHERE id = $1::uuid`, existing.service_id);
            return { favorited: false };
          } else {
            await prisma.service_favorites.create({
              data: {
                user_id: req.user.id,
                service_id: id
              }
            });
            await prisma.$executeRawUnsafe(`UPDATE public.services SET favorites_count = COALESCE(favorites_count, 0) + 1 WHERE id = $1::uuid`, id);

            // Email Notification
            try {
              const item = await prisma.services.findUnique({ where: { id } });
              if (item && item.user_id && item.user_id !== req.user.id) {
                try {
                  const ownerProfile = await prisma.user.findUnique({
                    where: { id: item.user_id },
                    include: { profile: true }
                  });
                  const prefs = ownerProfile?.profile?.notificationPreferences || {};

                  if (prefs.favorites !== false) {
                    await prisma.notifications.create({
                      data: {
                        user_id: item.user_id,
                        type: 'service_favorited',
                        title: 'Service favorited',
                        content: `Someone favorited your service`,
                        source_type: 'service',
                        source_id: id,
                        source_user_id: req.user.id
                      }
                    });
                  }
                } catch (e) { fastify.log.error(e, "Failed to create fav notification"); }

                const owner = await prisma.user.findUnique({
                  where: { id: item.user_id },
                  include: { profile: true }
                });
                if (owner && owner.email) {
                  const prefs = owner.profile?.notificationPreferences || {};
                  const lang = owner.profile?.defaultLanguage || 'en';

                  if ((prefs.favorites_email ?? prefs.favorites ?? true) !== false) {
                    const subject = getTranslation(lang, 'favorite_service_subject');
                    const bodyFn = getTranslation(lang, 'favorite_service_body');
                    const body = typeof bodyFn === 'function' ? bodyFn(item.full_name) : bodyFn;
                    const linkText = getTranslation(lang, 'view_service');

                    sendEmail({
                      to: owner.email,
                      subject: subject,
                      html: `<p>${body}</p><p><a href="${process.env.APP_WEB_URL}/${lang}/services/${id}">${linkText}</a></p>`
                    });
                  }
                }
              }
            } catch (err) { fastify.log.error(err); }

            return { favorited: true };
          }
        } else if (type === 'trainer') {
          const whereClause = {
            user_id: req.user.id,
            trainer_id: id
          };

          const existing = await prisma.trainer_favorites.findFirst({ where: whereClause });

          if (existing) {
            await prisma.trainer_favorites.delete({ where: { id: existing.id } });
            await prisma.$executeRawUnsafe(`UPDATE public.trainers SET favorites_count = GREATEST(COALESCE(favorites_count, 0) - 1, 0) WHERE id = $1::uuid`, existing.trainer_id);
            return { favorited: false };
          } else {
            await prisma.trainer_favorites.create({
              data: {
                user_id: req.user.id,
                trainer_id: id
              }
            });
            await prisma.$executeRawUnsafe(`UPDATE public.trainers SET favorites_count = COALESCE(favorites_count, 0) + 1 WHERE id = $1::uuid`, id);

            // Email Notification
            try {
              const item = await prisma.trainers.findUnique({ where: { id } });
              if (item && item.user_id && item.user_id !== req.user.id) {
                try {
                  const ownerProfile = await prisma.user.findUnique({
                    where: { id: item.user_id },
                    include: { profile: true }
                  });
                  const prefs = ownerProfile?.profile?.notificationPreferences || {};

                  if (prefs.favorites !== false) {
                    await prisma.notifications.create({
                      data: {
                        user_id: item.user_id,
                        type: 'trainer_favorited',
                        title: 'Trainer profile favorited',
                        content: `Someone favorited your trainer profile`,
                        source_type: 'trainer',
                        source_id: id,
                        source_user_id: req.user.id
                      }
                    });
                  }
                } catch (e) { fastify.log.error(e, "Failed to create fav notification"); }

                const owner = await prisma.user.findUnique({
                  where: { id: item.user_id },
                  include: { profile: true }
                });
                if (owner && owner.email) {
                  const prefs = owner.profile?.notificationPreferences || {};
                  const lang = owner.profile?.defaultLanguage || 'en';

                  if ((prefs.favorites_email ?? prefs.favorites ?? true) !== false) {
                    const subject = getTranslation(lang, 'favorite_trainer_subject');
                    const bodyFn = getTranslation(lang, 'favorite_trainer_body');
                    const body = typeof bodyFn === 'function' ? bodyFn(item.name) : bodyFn;
                    const linkText = getTranslation(lang, 'view_profile');

                    sendEmail({
                      to: owner.email,
                      subject: subject,
                      html: `<p>${body}</p><p><a href="${process.env.APP_WEB_URL}/${lang}/trainers/${id}">${linkText}</a></p>`
                    });
                  }
                }
              }
            } catch (err) { fastify.log.error(err); }

            return { favorited: true };
          }
        }

        return reply.code(400).send({ error: "Invalid type" });
      } catch (e) {
        fastify.log.error(e);
        return reply.code(500).send({ error: "Failed to toggle favorite" });
      }
    });

    // --- NOTIFICATIONS ---
    fastify.get("/notifications", { preHandler: requireAuth }, async (req, reply) => {
      try {
        const { limit = 20, offset = 0, unreadOnly } = req.query;
        const take = parseInt(limit);
        const skip = parseInt(offset);

        let whereClause = { user_id: req.user.id };
        if (unreadOnly === 'true') {
          whereClause.read_at = null;
        }

        const [notifs, unread, total] = await Promise.all([
          prisma.notifications.findMany({
            where: whereClause,
            orderBy: { created_at: 'desc' },
            take,
            skip
          }),
          prisma.notifications.count({
            where: { user_id: req.user.id, read_at: null }
          }),
          prisma.notifications.count({
            where: whereClause
          })
        ]);

        if (notifs.length > 0) {
          console.log("[NotificationDebug] Ex: ", notifs[0]);
        }

        return {
          notifications: notifs,
          unread_count: unread,
          pagination: {
            total,
            limit: take,
            offset: skip
          }
        };
      } catch (e) {
        fastify.log.error(e);
        return { notifications: [], unread_count: 0, pagination: { total: 0, limit: 20, offset: 0 } };
      }
    });

    fastify.post("/notifications/:id/read", { preHandler: requireAuth }, async (req, reply) => {
      const { id } = req.params;
      await prisma.notifications.updateMany({
        where: { id, user_id: req.user.id },
        data: { read_at: new Date() }
      });
      return { success: true };
    });

    fastify.delete("/notifications/:id", { preHandler: requireAuth }, async (req, reply) => {
      const { id } = req.params;
      await prisma.notifications.deleteMany({
        where: { id, user_id: req.user.id }
      });
      return { success: true };
    });

    fastify.post("/notifications/read-all", { preHandler: requireAuth }, async (req, reply) => {
      await prisma.notifications.updateMany({
        where: { user_id: req.user.id, read_at: null },
        data: { read_at: new Date() }
      });
      return { success: true };
    });

    fastify.get("/test-notifs", { preHandler: requireAuth }, async (req, reply) => {
      try {
        const u = req.user.id;
        const n = await prisma.notifications.create({
          data: {
            user_id: u,
            type: 'new_listing_in_area',
            title: 'Test listing',
            content: 'Test content',
            source_type: 'horse',
            source_id: 'd9b2d63d-a233-4123-8478-f6a8e32af452',
            source_user_id: u
          }
        });
        return { success: true, notif: n };
      } catch (e) {
        return { success: false, error: e.message };
      }
    });

    // --- FORCE FIX DATA INTEGRITY ON STARTUP ---
    try {
      fastify.log.info("Checking data integrity for forum_topics...");
      // Fix NULL timestamps which violate Prisma schema
      const updatedCreated = await prisma.$executeRawUnsafe(`UPDATE "public"."forum_topics" SET "created_at" = NOW() WHERE "created_at" IS NULL`);
      const updatedUpdated = await prisma.$executeRawUnsafe(`UPDATE "public"."forum_topics" SET "updated_at" = NOW() WHERE "updated_at" IS NULL`);

      fastify.log.info({ updatedCreated, updatedUpdated }, "Data integrity check completed.");
    } catch (err) {
      fastify.log.error(err, "Data integrity fix failed (ignoring if benign).");
    }
    // -------------------------------------------

    await fastify.listen({ port, host: "0.0.0.0" });

    fastify.log.info(`API listening on port ${port}`);
    fastify.log.info("Socket.IO ready on /ws");
  } catch (err) {
    fastify.log.error(err);
    process.exit(1);
  }
};

start();