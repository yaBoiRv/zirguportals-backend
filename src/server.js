"use strict";

const crypto = require("crypto");

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
  return { version: '1.1.1-inspect-triggers', timestamp: new Date().toISOString() };
});

fastify.register(require('./routes/debug'));


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
          user_roles: true
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
    return reply.code(500).send({ error: "failed_to_delete_account" });
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
    `&state=${encodeURIComponent(state)}`;

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
    `&state=${encodeURIComponent(state)}`;

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
      },
    });
  }

  // Ensure profile exists
  await prisma.profile.upsert({
    where: { userId: user.id },
    update: {},
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

  const jwtToken = fastify.jwt.sign({ sub: user.id, email: user.email });

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
      },
    });
  }

  // Ensure profile exists
  await prisma.profile.upsert({
    where: { userId: user.id },
    update: {},
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

  const jwtToken = fastify.jwt.sign({ sub: user.id, email: user.email });

  const web = process.env.APP_WEB_URL || "http://localhost:5173";
  return reply.redirect(`${web}/auth/callback?token=${encodeURIComponent(jwtToken)}`);
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

  const ext = String(filename).split(".").pop()?.toLowerCase() || "bin";
  const key = `${crypto.randomUUID()}.${ext}`;

  const cmd = new PutObjectCommand({
    Bucket: bucket,
    Key: key,
    ContentType: contentType,
  });

  const uploadUrl = await getSignedUrl(s3Presign, cmd, { expiresIn: 60 * 5 });
  return reply.send({ uploadUrl, key, bucket });
});



fastify.post("/chat/conversations", { preHandler: requireAuth }, async (req, reply) => {
  const { targetUserId, sourceType, sourceId } = req.body || {};
  if (!targetUserId) return reply.code(400).send({ error: "targetUserId required" });
  if (targetUserId === req.user.id) return reply.code(400).send({ error: "cannot message self" });

  // ✅ ensure both users exist
  const [me, them] = await Promise.all([
    prisma.user.findUnique({ where: { id: req.user.id } }),
    prisma.user.findUnique({ where: { id: targetUserId } }),
  ]);
  if (!me) return reply.code(401).send({ error: "invalid user" });
  if (!them) return reply.code(404).send({ error: "target user not found" });

  // ✅ find existing conversation with same participants + optional source
  const existing = await prisma.conversation.findFirst({
    where: {
      participants: {
        every: { userId: { in: [req.user.id, targetUserId] } },
      },
      sourceType: sourceType ?? null,
      sourceId: sourceId ?? null,
    },
  });
  if (existing) return reply.send({ conversationId: existing.id });

  const conv = await prisma.conversation.create({
    data: {
      sourceType: sourceType ?? null,
      sourceId: sourceId ?? null,
      participants: {
        create: [
          { userId: req.user.id },
          { userId: targetUserId },
        ],
      },
    },
    select: { id: true },
  });

  return reply.send({ conversationId: conv.id });
});

fastify.get("/chat/conversations", { preHandler: requireAuth }, async (req, reply) => {
  const conversations = await prisma.conversation.findMany({
    where: {
      participants: { some: { userId: req.user.id } },
    },
    orderBy: { updatedAt: "desc" },
    include: {
      participants: { include: { user: { select: { id: true, email: true } } } },
      messages: {
        orderBy: { createdAt: "desc" },
        take: 1,
        include: { sender: { select: { id: true, email: true } } },
      },
    },
  });

  // flatten last message
  const out = conversations.map((c) => ({
    id: c.id,
    createdAt: c.createdAt,
    updatedAt: c.updatedAt,
    participants: c.participants.map((p) => p.user),
    lastMessage: c.messages[0] || null,
  }));

  return reply.send({ conversations: out });
});

fastify.get(
  "/chat/conversations/:id/messages",
  { preHandler: requireAuth },
  async (req, reply) => {
    const conversationId = req.params.id;
    const limit = Math.min(Number(req.query.limit || 50), 200);
    const cursor = req.query.cursor;

    // must be participant
    const participant = await prisma.conversationParticipant.findUnique({
      where: { conversationId_userId: { conversationId, userId: req.user.id } },
    });
    if (!participant) return reply.code(403).send({ error: "not a participant" });

    const messages = await prisma.message.findMany({
      where: { conversationId },
      orderBy: { createdAt: "desc" },
      take: limit,
      ...(cursor
        ? { skip: 1, cursor: { id: String(cursor) } } // prisma cursor pagination
        : {}),
      include: { sender: { select: { id: true, email: true } } },
    });

    return reply.send({
      messages: messages.reverse(), // oldest -> newest for UI
      nextCursor: messages.length ? messages[0].id : null,
    });
  }
);

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
    const { email, password } = req.body || {};
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
        update: {}, // (you can update defaults later if you want)
        create: {
          userId: user.id,
          name: safeEmail.split("@")[0] || "",
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

    const token = fastify.jwt.sign({ sub: user.id, email: user.email });
    return reply.send({ user, token });
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

    const token = fastify.jwt.sign({ sub: user.id, email: user.email });
    return reply.send({
      user: { id: user.id, email: user.email, emailVerified: user.emailVerified },
      token,
    });
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
  });

  return reply.send({ profile });
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

fastify.delete("/profile/me", { preHandler: requireAuth }, async (req, reply) => {
  try {
    const userId = req.user.id;
    await prisma.profile.delete({ where: { userId } });
    await prisma.user.delete({ where: { id: userId } });
    return reply.send({ success: true });
  } catch (e) {
    req.log.error(e);
    return reply.code(500).send({ error: "failed_to_delete_profile" });
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
        update: {},
        create: {
          userId: user.id,
          name: safeEmail.split("@")[0] || "",
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

    const token = fastify.jwt.sign({ sub: user.id, email: user.email });
    return reply.send({ user, token });
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

    const token = fastify.jwt.sign({ sub: user.id, email: user.email });
    return reply.send({
      user: { id: user.id, email: user.email, emailVerified: user.emailVerified },
      token,
    });
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

      socket.on("chat:send", async ({ conversationId, body }) => {
        try {
          if (!conversationId || !body) return;

          const participant = await prisma.conversationParticipant.findUnique({
            where: { conversationId_userId: { conversationId, userId: socket.user.id } },
          });

          if (!participant) {
            socket.emit("chat:error", { error: "not a participant" });
            return;
          }

          const msg = await prisma.message.create({
            data: {
              conversationId,
              senderId: socket.user.id,
              body: String(body).slice(0, 5000),
            },
            include: { sender: { select: { id: true, email: true } } },
          });

          io.to(`conv:${conversationId}`).emit("chat:new_message", {
            id: msg.id,
            conversationId: msg.conversationId,
            body: msg.body,
            createdAt: msg.createdAt,
            sender: msg.sender,
          });
        } catch (e) {
          fastify.log.error(e);
          socket.emit("chat:error", { error: "send failed" });
        }
      });

      socket.on("disconnect", (reason) => {
        fastify.log.info({ socketId: socket.id, reason }, "ws disconnected");
      });
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