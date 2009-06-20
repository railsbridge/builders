CREATE TABLE "project_volunteers" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "user_id" integer, "project_id" integer, "role" varchar(255), "created_at" datetime, "updated_at" datetime);
CREATE TABLE "projects" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "org_name" varchar(255), "org_details" text, "contact_name" varchar(255), "contact_phone" varchar(255), "contact_email" varchar(255), "website" varchar(255), "description" text, "approved" boolean, "access_key" varchar(255), "created_at" datetime, "updated_at" datetime);
CREATE TABLE "schema_migrations" ("version" varchar(255) NOT NULL);
CREATE TABLE "taggings" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "tag_id" integer, "taggable_type" varchar(255) DEFAULT '', "taggable_id" integer);
CREATE TABLE "tags" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "name" varchar(255) DEFAULT '', "kind" varchar(255) DEFAULT '');
CREATE TABLE "users" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "email" varchar(255) NOT NULL, "crypted_password" varchar(255) NOT NULL, "password_salt" varchar(255) NOT NULL, "persistence_token" varchar(255) NOT NULL, "single_access_token" varchar(255) NOT NULL, "perishable_token" varchar(255) NOT NULL, "name" varchar(255), "availability_starts" date, "availability_ends" date, "hours_per_week" integer, "notes" text, "admin" boolean DEFAULT 'f', "created_at" datetime, "updated_at" datetime);
CREATE INDEX "index_project_volunteers_on_project_id" ON "project_volunteers" ("project_id");
CREATE INDEX "index_project_volunteers_on_user_id" ON "project_volunteers" ("user_id");
CREATE INDEX "index_taggings_on_tag_id" ON "taggings" ("tag_id");
CREATE INDEX "index_taggings_on_taggable_id_and_taggable_type" ON "taggings" ("taggable_id", "taggable_type");
CREATE INDEX "index_tags_on_name_and_kind" ON "tags" ("name", "kind");
CREATE UNIQUE INDEX "unique_schema_migrations" ON "schema_migrations" ("version");
INSERT INTO schema_migrations (version) VALUES ('20090507200146');

INSERT INTO schema_migrations (version) VALUES ('20090508194452');

INSERT INTO schema_migrations (version) VALUES ('20090518205641');

INSERT INTO schema_migrations (version) VALUES ('20090617184253');