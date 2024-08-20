CREATE TABLE IF NOT EXISTS "NoBazir_customer" (
	"customerId" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"userId" uuid NOT NULL,
	"username" varchar(255) NOT NULL,
	"location" varchar(255) NOT NULL,
	"coin" integer DEFAULT 0 NOT NULL,
	"bazirPay" integer DEFAULT 0 NOT NULL,
	"profilePictureUrl" text,
	"createdAt" timestamp with time zone DEFAULT now() NOT NULL,
	"updated_at" timestamp with time zone
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "NoBazir_merchant" (
	"merchantId" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"userId" uuid NOT NULL,
	"merchantName" varchar(255) NOT NULL,
	"location" varchar(255) NOT NULL,
	"merchantType" varchar(255),
	"phoneNumber" varchar(13),
	"socialMedia" varchar(2048),
	"createdAt" timestamp with time zone DEFAULT now() NOT NULL,
	"updated_at" timestamp with time zone
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "NoBazir_post" (
	"postId" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"userId" uuid NOT NULL,
	"postTitle" varchar(255) NOT NULL,
	"postPictureUrl" text,
	"postContent" text,
	"postTag" varchar(255),
	"likeCount" integer DEFAULT 0 NOT NULL,
	"userIdLikeList" varchar(36),
	"createdAt" timestamp with time zone DEFAULT now() NOT NULL,
	"updated_at" timestamp with time zone
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "NoBazir_product" (
	"productId" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"merchantId" uuid NOT NULL,
	"productName" varchar(255) NOT NULL,
	"productType" varchar(255),
	"price" integer NOT NULL,
	"expireDate" date NOT NULL,
	"stock" integer DEFAULT 0 NOT NULL,
	"totalCalorie" real,
	"likeCount" integer DEFAULT 0 NOT NULL,
	"customerIdLikeList" varchar(36),
	"profilePictureUrl" text,
	"createdAt" timestamp with time zone DEFAULT now() NOT NULL,
	"updated_at" timestamp with time zone
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "NoBazir_user" (
	"userId" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"email" varchar(320) NOT NULL,
	"role" varchar,
	"createdAt" timestamp with time zone DEFAULT now() NOT NULL,
	"updated_at" timestamp with time zone,
	CONSTRAINT "NoBazir_user_email_unique" UNIQUE("email")
);
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "NoBazir_customer" ADD CONSTRAINT "NoBazir_customer_userId_NoBazir_user_userId_fk" FOREIGN KEY ("userId") REFERENCES "public"."NoBazir_user"("userId") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "NoBazir_merchant" ADD CONSTRAINT "NoBazir_merchant_userId_NoBazir_user_userId_fk" FOREIGN KEY ("userId") REFERENCES "public"."NoBazir_user"("userId") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "NoBazir_post" ADD CONSTRAINT "NoBazir_post_userId_NoBazir_user_userId_fk" FOREIGN KEY ("userId") REFERENCES "public"."NoBazir_user"("userId") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "NoBazir_product" ADD CONSTRAINT "NoBazir_product_merchantId_NoBazir_merchant_merchantId_fk" FOREIGN KEY ("merchantId") REFERENCES "public"."NoBazir_merchant"("merchantId") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
CREATE INDEX IF NOT EXISTS "customer_id_idx" ON "NoBazir_customer" ("customerId");--> statement-breakpoint
CREATE INDEX IF NOT EXISTS "customer_user_id_idx" ON "NoBazir_customer" ("userId");--> statement-breakpoint
CREATE INDEX IF NOT EXISTS "customer_username_idx" ON "NoBazir_customer" ("username");--> statement-breakpoint
CREATE INDEX IF NOT EXISTS "customer_location_idx" ON "NoBazir_customer" ("location");--> statement-breakpoint
CREATE INDEX IF NOT EXISTS "customer_created_at_idx" ON "NoBazir_customer" ("createdAt");--> statement-breakpoint
CREATE INDEX IF NOT EXISTS "customer_updated_at_idx" ON "NoBazir_customer" ("updated_at");--> statement-breakpoint
CREATE INDEX IF NOT EXISTS "merchant_id_idx" ON "NoBazir_merchant" ("merchantId");--> statement-breakpoint
CREATE INDEX IF NOT EXISTS "merchant_user_id_idx" ON "NoBazir_merchant" ("userId");--> statement-breakpoint
CREATE INDEX IF NOT EXISTS "merchant_name_idx" ON "NoBazir_merchant" ("merchantName");--> statement-breakpoint
CREATE INDEX IF NOT EXISTS "merchant_location_idx" ON "NoBazir_merchant" ("location");--> statement-breakpoint
CREATE INDEX IF NOT EXISTS "merchant_created_at_idx" ON "NoBazir_merchant" ("createdAt");--> statement-breakpoint
CREATE INDEX IF NOT EXISTS "merchant_updated_at_idx" ON "NoBazir_merchant" ("updated_at");--> statement-breakpoint
CREATE INDEX IF NOT EXISTS "post_id_idx" ON "NoBazir_post" ("postId");--> statement-breakpoint
CREATE INDEX IF NOT EXISTS "post_user_id_idx" ON "NoBazir_post" ("userId");--> statement-breakpoint
CREATE INDEX IF NOT EXISTS "post_title_idx" ON "NoBazir_post" ("postTitle");--> statement-breakpoint
CREATE INDEX IF NOT EXISTS "post_tag_idx" ON "NoBazir_post" ("postTag");--> statement-breakpoint
CREATE INDEX IF NOT EXISTS "post_like_count_idx" ON "NoBazir_post" ("likeCount");--> statement-breakpoint
CREATE INDEX IF NOT EXISTS "post_user_id_like_list" ON "NoBazir_post" ("userIdLikeList");--> statement-breakpoint
CREATE INDEX IF NOT EXISTS "post_created_at_idx" ON "NoBazir_post" ("createdAt");--> statement-breakpoint
CREATE INDEX IF NOT EXISTS "post_updated_at_idx" ON "NoBazir_post" ("updated_at");--> statement-breakpoint
CREATE INDEX IF NOT EXISTS "product_id_idx" ON "NoBazir_product" ("productId");--> statement-breakpoint
CREATE INDEX IF NOT EXISTS "product_merchant_id_idx" ON "NoBazir_product" ("merchantId");--> statement-breakpoint
CREATE INDEX IF NOT EXISTS "product_name_idx" ON "NoBazir_product" ("productName");--> statement-breakpoint
CREATE INDEX IF NOT EXISTS "product_type_idx" ON "NoBazir_product" ("productType");--> statement-breakpoint
CREATE INDEX IF NOT EXISTS "price_idx" ON "NoBazir_product" ("price");--> statement-breakpoint
CREATE INDEX IF NOT EXISTS "expire_date_idx" ON "NoBazir_product" ("expireDate");--> statement-breakpoint
CREATE INDEX IF NOT EXISTS "product_like_count_idx" ON "NoBazir_product" ("likeCount");--> statement-breakpoint
CREATE INDEX IF NOT EXISTS "product_customer_id_like_list_idx" ON "NoBazir_product" ("customerIdLikeList");--> statement-breakpoint
CREATE INDEX IF NOT EXISTS "product_created_at_idx" ON "NoBazir_product" ("createdAt");--> statement-breakpoint
CREATE INDEX IF NOT EXISTS "product_updated_at_idx" ON "NoBazir_product" ("updated_at");--> statement-breakpoint
CREATE INDEX IF NOT EXISTS "user_id_idx" ON "NoBazir_user" ("userId");--> statement-breakpoint
CREATE INDEX IF NOT EXISTS "email_idx" ON "NoBazir_user" ("email");--> statement-breakpoint
CREATE INDEX IF NOT EXISTS "role_idx" ON "NoBazir_user" ("role");--> statement-breakpoint
CREATE INDEX IF NOT EXISTS "user_created_at_idx" ON "NoBazir_user" ("createdAt");--> statement-breakpoint
CREATE INDEX IF NOT EXISTS "user_updated_at_idx" ON "NoBazir_user" ("updated_at");