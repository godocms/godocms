/*
 Navicat Premium Data Transfer

 Source Server         : godocms
 Source Server Type    : SQLite
 Source Server Version : 3030001
 Source Schema         : main

 Target Server Type    : SQLite
 Target Server Version : 3030001
 File Encoding         : 65001

 Date: 26/11/2021 17:48:30
*/

PRAGMA foreign_keys = false;

-- ----------------------------
-- Table structure for rt_database
-- ----------------------------
DROP TABLE IF EXISTS "rt_database";
CREATE TABLE "rt_database" (
  "id" integer NOT NULL PRIMARY KEY AUTOINCREMENT,
  "database" TEXT NOT NULL,
  "host" text NOT NULL,
  "port" integer,
  "user" TEXT,
  "password" TEXT NOT NULL,
  "dateStrings" integer DEFAULT 0,
  "encoding" TEXT,
  "isdef" integer DEFAULT 0,
  "prefix" TEXT DEFAULT rt_,
  "ssh" integer DEFAULT 0,
  "shost" TEXT,
  "sport" integer,
  "suser" TEXT,
  "stype" integer,
  "spass" TEXT,
  "skey" TEXT,
  "spath" TEXT
);

-- ----------------------------
-- Table structure for rt_datasafe
-- ----------------------------
DROP TABLE IF EXISTS "rt_datasafe";
CREATE TABLE "rt_datasafe" (
  "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
  "data_id" INTEGER(10),
  "name" TEXT(255),
  CONSTRAINT "name" UNIQUE ("data_id", "name")
);

-- ----------------------------
-- Table structure for sqlite_sequence
-- ----------------------------
DROP TABLE IF EXISTS "sqlite_sequence";
CREATE TABLE sqlite_sequence(name,seq);

-- ----------------------------
-- Auto increment value for rt_database
-- ----------------------------
UPDATE "main"."sqlite_sequence" SET seq = 6 WHERE name = 'rt_database';

-- ----------------------------
-- Auto increment value for rt_datasafe
-- ----------------------------
UPDATE "main"."sqlite_sequence" SET seq = 40 WHERE name = 'rt_datasafe';

PRAGMA foreign_keys = true;
