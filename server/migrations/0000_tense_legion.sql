CREATE TABLE `conversation` (
	`id` text PRIMARY KEY NOT NULL,
	`user_id` text NOT NULL,
	`history` text NOT NULL,
	`created_at` integer DEFAULT CURRENT_TIMESTAMP,
	`updated_at` integer DEFAULT CURRENT_TIMESTAMP
);
--> statement-breakpoint
CREATE TABLE `geojson` (
	`id` text PRIMARY KEY NOT NULL,
	`type` text NOT NULL,
	`geo_json_id` text NOT NULL,
	`properties` text,
	`geometry` text NOT NULL,
	`created_at` integer DEFAULT CURRENT_TIMESTAMP,
	`updated_at` integer DEFAULT CURRENT_TIMESTAMP
);
--> statement-breakpoint
CREATE TABLE `item` (
	`id` text PRIMARY KEY NOT NULL,
	`name` text NOT NULL,
	`weight` real NOT NULL,
	`quantity` integer NOT NULL,
	`unit` text NOT NULL,
	`category` text,
	`global` integer DEFAULT false,
	`created_at` integer DEFAULT CURRENT_TIMESTAMP,
	`updated_at` integer DEFAULT CURRENT_TIMESTAMP,
	FOREIGN KEY (`category`) REFERENCES `item_category`(`id`) ON UPDATE no action ON DELETE no action
);
--> statement-breakpoint
CREATE TABLE `item_category` (
	`id` text PRIMARY KEY NOT NULL,
	`name` text,
	`created_at` integer DEFAULT CURRENT_TIMESTAMP,
	`updated_at` integer DEFAULT CURRENT_TIMESTAMP
);
--> statement-breakpoint
CREATE TABLE `item_owners` (
	`ownerId` text,
	`itemId` text,
	FOREIGN KEY (`ownerId`) REFERENCES `user`(`id`) ON UPDATE no action ON DELETE no action,
	FOREIGN KEY (`itemId`) REFERENCES `item`(`id`) ON UPDATE no action ON DELETE no action
);
--> statement-breakpoint
CREATE TABLE `item_packs` (
	`itemId` text,
	`packId` text,
	FOREIGN KEY (`itemId`) REFERENCES `item`(`id`) ON UPDATE no action ON DELETE no action,
	FOREIGN KEY (`packId`) REFERENCES `pack`(`id`) ON UPDATE no action ON DELETE no action
);
--> statement-breakpoint
CREATE TABLE `node` (
	`id` text PRIMARY KEY NOT NULL,
	`osm_id` integer,
	`lat` real,
	`lon` real,
	`tags` text,
	`created_at` integer DEFAULT CURRENT_TIMESTAMP,
	`updated_at` integer
);
--> statement-breakpoint
CREATE TABLE `pack` (
	`id` text PRIMARY KEY NOT NULL,
	`name` text NOT NULL,
	`owner_id` text,
	`is_public` integer,
	`grades` text DEFAULT '{"weight":"","essentialItems":"","redundancyAndVersatility":""}',
	`scores` text DEFAULT '{"weightScore":0,"essentialItemsScore":0,"redundancyAndVersatilityScore":0}',
	`type` text DEFAULT 'pack',
	`total_weight` real,
	`total_score` integer DEFAULT 0,
	`favorites_count` integer DEFAULT 0,
	`created_at` integer DEFAULT CURRENT_TIMESTAMP,
	`updated_at` integer DEFAULT CURRENT_TIMESTAMP,
	FOREIGN KEY (`owner_id`) REFERENCES `user`(`id`) ON UPDATE no action ON DELETE no action
);
--> statement-breakpoint
CREATE TABLE `pack_owners` (
	`owner_id` text,
	`pack_id` text,
	FOREIGN KEY (`owner_id`) REFERENCES `user`(`id`) ON UPDATE no action ON DELETE no action,
	FOREIGN KEY (`pack_id`) REFERENCES `pack`(`id`) ON UPDATE no action ON DELETE no action
);
--> statement-breakpoint
CREATE TABLE `relation` (
	`id` text PRIMARY KEY NOT NULL,
	`osm_id` integer,
	`osm_type` text DEFAULT 'relation',
	`tags` text,
	`members` text,
	`geo_json` text,
	`updated_at` integer,
	`created_at` integer DEFAULT CURRENT_TIMESTAMP
);
--> statement-breakpoint
CREATE TABLE `template` (
	`id` text PRIMARY KEY NOT NULL,
	`type` text DEFAULT 'pack' NOT NULL,
	`template_id` text NOT NULL,
	`is_global_template` integer DEFAULT false,
	`created_by` text,
	`created_at` integer DEFAULT CURRENT_TIMESTAMP,
	`updated_at` integer DEFAULT CURRENT_TIMESTAMP,
	FOREIGN KEY (`created_by`) REFERENCES `user`(`id`) ON UPDATE no action ON DELETE no action
);
--> statement-breakpoint
CREATE TABLE `trip` (
	`id` text PRIMARY KEY NOT NULL,
	`name` text NOT NULL,
	`description` text NOT NULL,
	`duration` text NOT NULL,
	`weather` text NOT NULL,
	`start_date` integer NOT NULL,
	`end_date` integer NOT NULL,
	`destination` text NOT NULL,
	`owner_id` text,
	`packs` text,
	`is_public` integer,
	`type` text DEFAULT 'trip',
	`created_at` integer DEFAULT CURRENT_TIMESTAMP,
	`updated_at` integer DEFAULT CURRENT_TIMESTAMP,
	FOREIGN KEY (`owner_id`) REFERENCES `user`(`id`) ON UPDATE no action ON DELETE no action,
	FOREIGN KEY (`packs`) REFERENCES `pack`(`id`) ON UPDATE no action ON DELETE no action
);
--> statement-breakpoint
CREATE TABLE `trip_geojson` (
	`trip_id` text,
	`geojson_id` text,
	FOREIGN KEY (`trip_id`) REFERENCES `trip`(`id`) ON UPDATE no action ON DELETE no action,
	FOREIGN KEY (`geojson_id`) REFERENCES `geojson`(`id`) ON UPDATE no action ON DELETE no action
);
--> statement-breakpoint
CREATE TABLE `user` (
	`id` text PRIMARY KEY NOT NULL,
	`name` text NOT NULL,
	`password` text NOT NULL,
	`email` text NOT NULL,
	`token` text,
	`google_id` text,
	`code` text,
	`is_certified_guide` integer,
	`password_reset_token` text,
	`password_reset_token_expiration` integer,
	`role` text DEFAULT 'user',
	`username` text NOT NULL,
	`profile_image` text,
	`preferred_weather` text,
	`preferred_weight` text,
	`created_at` integer DEFAULT CURRENT_TIMESTAMP
);
--> statement-breakpoint
CREATE TABLE `user_favorite_packs` (
	`user_id` text,
	`pack_id` text,
	FOREIGN KEY (`user_id`) REFERENCES `user`(`id`) ON UPDATE no action ON DELETE no action,
	FOREIGN KEY (`pack_id`) REFERENCES `pack`(`id`) ON UPDATE no action ON DELETE no action
);
--> statement-breakpoint
CREATE TABLE `way` (
	`id` text PRIMARY KEY NOT NULL,
	`osm_id` integer,
	`osm_type` text,
	`tags` text,
	`geo_json` text,
	`created_at` integer DEFAULT CURRENT_TIMESTAMP,
	`updated_at` integer
);
--> statement-breakpoint
CREATE TABLE `way_nodes` (
	`way_id` text,
	`node_id` text,
	FOREIGN KEY (`way_id`) REFERENCES `way`(`id`) ON UPDATE no action ON DELETE no action,
	FOREIGN KEY (`node_id`) REFERENCES `node`(`id`) ON UPDATE no action ON DELETE no action
);
--> statement-breakpoint
CREATE UNIQUE INDEX `user_email_unique` ON `user` (`email`);--> statement-breakpoint
CREATE UNIQUE INDEX `user_username_unique` ON `user` (`username`);