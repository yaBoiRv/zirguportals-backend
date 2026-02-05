-- Fix missing timestamps
UPDATE "public"."forum_topics"
SET "created_at" = NOW()
WHERE "created_at" IS NULL;
UPDATE "public"."forum_topics"
SET "updated_at" = NOW()
WHERE "updated_at" IS NULL;
-- Fix potentially missing counts
UPDATE "public"."forum_topics"
SET "views_count" = 0
WHERE "views_count" IS NULL;
UPDATE "public"."forum_topics"
SET "likes_count" = 0
WHERE "likes_count" IS NULL;
UPDATE "public"."forum_topics"
SET "replies_count" = 0
WHERE "replies_count" IS NULL;
-- Make columns NOT NULL enforced if possible (optional)
-- ALTER TABLE "public"."forum_topics" ALTER COLUMN "created_at" SET NOT NULL;