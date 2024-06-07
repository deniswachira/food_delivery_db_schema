CREATE TABLE IF NOT EXISTS "address_table" (
	"address_id" serial PRIMARY KEY NOT NULL,
	"address" text,
	"street_address_2" text,
	"zip_code" text,
	"delivery_instructions" text,
	"user_id" integer NOT NULL,
	"city_id" integer NOT NULL,
	"created_at" timestamp DEFAULT now(),
	"updated_at" timestamp DEFAULT now()
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "category_table" (
	"category_id" serial PRIMARY KEY NOT NULL,
	"name" text,
	"created_at" timestamp DEFAULT now(),
	"updated_at" timestamp DEFAULT now()
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "city_table" (
	"city_id" serial PRIMARY KEY NOT NULL,
	"city_name" text,
	"state_id" integer NOT NULL,
	"created_at" timestamp DEFAULT now(),
	"updated_at" timestamp DEFAULT now()
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "comment_table" (
	"comment_id" serial PRIMARY KEY NOT NULL,
	"user_id" integer NOT NULL,
	"order_id" integer NOT NULL,
	"comment_text" text,
	"is_complaint" boolean DEFAULT false,
	"is_praise" boolean DEFAULT false,
	"created_at" timestamp DEFAULT now(),
	"updated_at" timestamp DEFAULT now()
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "driver_table" (
	"driver_id" serial PRIMARY KEY NOT NULL,
	"car_make" text,
	"car_model" text,
	"car_year" integer,
	"user_id" integer NOT NULL,
	"online" boolean DEFAULT false,
	"delivering" boolean DEFAULT false,
	"created_at" timestamp DEFAULT now(),
	"updated_at" timestamp DEFAULT now()
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "menu_item_table" (
	"menu_item_id" serial PRIMARY KEY NOT NULL,
	"name" text,
	"price" numeric,
	"description" text,
	"ingredients" text,
	"active" boolean DEFAULT true,
	"restaurant_id" integer NOT NULL,
	"category_id" integer NOT NULL,
	"created_at" timestamp DEFAULT now(),
	"updated_at" timestamp DEFAULT now()
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "order_menu_table" (
	"order_menu_id" serial PRIMARY KEY NOT NULL,
	"order_id" integer NOT NULL,
	"menu_item_id" integer NOT NULL,
	"quantity" integer,
	"item_price" numeric,
	"price" numeric,
	"comment" text,
	"created_at" timestamp DEFAULT now(),
	"updated_at" timestamp DEFAULT now()
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "order_status_table" (
	"order_status_id" serial PRIMARY KEY NOT NULL,
	"order_id" integer NOT NULL,
	"status_catalog_id" integer NOT NULL,
	"created_at" timestamp DEFAULT now(),
	"updated_at" timestamp DEFAULT now()
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "order_table" (
	"order_id" serial PRIMARY KEY NOT NULL,
	"user_id" integer NOT NULL,
	"driver_id" integer,
	"restaurant_id" integer NOT NULL,
	"delivery_address_id" integer NOT NULL,
	"estimated_delivery_time" timestamp,
	"actual_delivery_time" timestamp,
	"price" numeric,
	"discount" numeric,
	"final_price" numeric,
	"comment" text,
	"created_at" timestamp DEFAULT now(),
	"updated_at" timestamp DEFAULT now()
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "restaurant_owner_table" (
	"restaurant_owner_id" serial PRIMARY KEY NOT NULL,
	"restaurant_id" integer NOT NULL,
	"owner_id" integer NOT NULL
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "restaurant_table" (
	"restaurant_id" serial PRIMARY KEY NOT NULL,
	"name" text,
	"street_address" text,
	"zip_code" text,
	"city_id" integer NOT NULL,
	"created_at" timestamp DEFAULT now(),
	"updated_at" timestamp DEFAULT now()
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "state_table" (
	"state_id" serial PRIMARY KEY NOT NULL,
	"name" text,
	"code" text,
	"created_at" timestamp DEFAULT now(),
	"updated_at" timestamp DEFAULT now()
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "status_catalog_table" (
	"status_catalog_id" serial PRIMARY KEY NOT NULL,
	"status" text,
	"created_at" timestamp DEFAULT now(),
	"updated_at" timestamp DEFAULT now()
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "user_table" (
	"user_id" serial PRIMARY KEY NOT NULL,
	"fullname" varchar,
	"email" varchar NOT NULL,
	"password" varchar NOT NULL,
	"created_at" timestamp DEFAULT now(),
	"updated_at" timestamp DEFAULT now()
);
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "address_table" ADD CONSTRAINT "address_table_user_id_user_table_user_id_fk" FOREIGN KEY ("user_id") REFERENCES "public"."user_table"("user_id") ON DELETE cascade ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "address_table" ADD CONSTRAINT "address_table_city_id_city_table_city_id_fk" FOREIGN KEY ("city_id") REFERENCES "public"."city_table"("city_id") ON DELETE cascade ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "city_table" ADD CONSTRAINT "city_table_state_id_state_table_state_id_fk" FOREIGN KEY ("state_id") REFERENCES "public"."state_table"("state_id") ON DELETE cascade ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "comment_table" ADD CONSTRAINT "comment_table_user_id_user_table_user_id_fk" FOREIGN KEY ("user_id") REFERENCES "public"."user_table"("user_id") ON DELETE cascade ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "comment_table" ADD CONSTRAINT "comment_table_order_id_order_table_order_id_fk" FOREIGN KEY ("order_id") REFERENCES "public"."order_table"("order_id") ON DELETE cascade ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "driver_table" ADD CONSTRAINT "driver_table_user_id_user_table_user_id_fk" FOREIGN KEY ("user_id") REFERENCES "public"."user_table"("user_id") ON DELETE cascade ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "menu_item_table" ADD CONSTRAINT "menu_item_table_restaurant_id_restaurant_table_restaurant_id_fk" FOREIGN KEY ("restaurant_id") REFERENCES "public"."restaurant_table"("restaurant_id") ON DELETE cascade ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "menu_item_table" ADD CONSTRAINT "menu_item_table_category_id_category_table_category_id_fk" FOREIGN KEY ("category_id") REFERENCES "public"."category_table"("category_id") ON DELETE cascade ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "order_menu_table" ADD CONSTRAINT "order_menu_table_order_id_order_table_order_id_fk" FOREIGN KEY ("order_id") REFERENCES "public"."order_table"("order_id") ON DELETE cascade ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "order_menu_table" ADD CONSTRAINT "order_menu_table_menu_item_id_menu_item_table_menu_item_id_fk" FOREIGN KEY ("menu_item_id") REFERENCES "public"."menu_item_table"("menu_item_id") ON DELETE cascade ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "order_status_table" ADD CONSTRAINT "order_status_table_order_id_order_table_order_id_fk" FOREIGN KEY ("order_id") REFERENCES "public"."order_table"("order_id") ON DELETE cascade ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "order_status_table" ADD CONSTRAINT "order_status_table_status_catalog_id_status_catalog_table_status_catalog_id_fk" FOREIGN KEY ("status_catalog_id") REFERENCES "public"."status_catalog_table"("status_catalog_id") ON DELETE cascade ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "order_table" ADD CONSTRAINT "order_table_user_id_user_table_user_id_fk" FOREIGN KEY ("user_id") REFERENCES "public"."user_table"("user_id") ON DELETE cascade ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "order_table" ADD CONSTRAINT "order_table_driver_id_driver_table_driver_id_fk" FOREIGN KEY ("driver_id") REFERENCES "public"."driver_table"("driver_id") ON DELETE cascade ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "order_table" ADD CONSTRAINT "order_table_restaurant_id_restaurant_table_restaurant_id_fk" FOREIGN KEY ("restaurant_id") REFERENCES "public"."restaurant_table"("restaurant_id") ON DELETE cascade ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "order_table" ADD CONSTRAINT "order_table_delivery_address_id_address_table_address_id_fk" FOREIGN KEY ("delivery_address_id") REFERENCES "public"."address_table"("address_id") ON DELETE cascade ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "restaurant_owner_table" ADD CONSTRAINT "restaurant_owner_table_restaurant_id_restaurant_table_restaurant_id_fk" FOREIGN KEY ("restaurant_id") REFERENCES "public"."restaurant_table"("restaurant_id") ON DELETE cascade ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "restaurant_owner_table" ADD CONSTRAINT "restaurant_owner_table_owner_id_user_table_user_id_fk" FOREIGN KEY ("owner_id") REFERENCES "public"."user_table"("user_id") ON DELETE cascade ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "restaurant_table" ADD CONSTRAINT "restaurant_table_city_id_city_table_city_id_fk" FOREIGN KEY ("city_id") REFERENCES "public"."city_table"("city_id") ON DELETE cascade ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
