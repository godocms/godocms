/*
 Navicat Premium Data Transfer

 Source Server         : mysql57
 Source Server Type    : MySQL
 Source Server Version : 50732
 Source Host           : localhost:8889
 Source Schema         : gdcms

 Target Server Type    : MySQL
 Target Server Version : 50732
 File Encoding         : 65001

 Date: 19/11/2021 12:55:46
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for rt_achievement
-- ----------------------------
DROP TABLE IF EXISTS `rt_achievement`;
CREATE TABLE `rt_achievement` (
  `achievement_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `order_id` int(10) unsigned DEFAULT '0' COMMENT '订单id',
  `product_id` int(10) unsigned DEFAULT '0' COMMENT '商品id',
  `group_id` int(10) unsigned DEFAULT '0' COMMENT '集团id',
  `store_id` int(10) unsigned DEFAULT '0' COMMENT '店铺id',
  `manager_id` int(10) unsigned DEFAULT '0' COMMENT '员工id',
  `money` decimal(10,2) unsigned DEFAULT '0.00' COMMENT '实际业绩',
  `all_money` decimal(10,2) unsigned DEFAULT '0.00' COMMENT '订单总额',
  `add_time` int(10) unsigned DEFAULT NULL COMMENT '添加时间',
  `update_time` int(10) unsigned DEFAULT '0' COMMENT '发放时间',
  PRIMARY KEY (`achievement_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='业绩表';

-- ----------------------------
-- Records of rt_achievement
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for rt_admin
-- ----------------------------
DROP TABLE IF EXISTS `rt_admin`;
CREATE TABLE `rt_admin` (
  `admin_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '唯一标志',
  `username` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '用户名',
  `password` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '密码',
  `salt` varchar(16) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '密码钥匙',
  `add_time` int(10) NOT NULL DEFAULT '0' COMMENT '添加时间',
  `name` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '真实姓名',
  `mobile` varchar(15) COLLATE utf8mb4_unicode_ci DEFAULT '0' COMMENT '手机号',
  `status` tinyint(2) NOT NULL DEFAULT '1' COMMENT '状态1正常0禁用',
  `login_time` int(10) DEFAULT '0' COMMENT '登录时间',
  `login_num` int(10) DEFAULT '0' COMMENT '登录次数',
  `update_time` int(10) DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`admin_id`),
  UNIQUE KEY `username` (`username`) USING HASH,
  UNIQUE KEY `mobile` (`mobile`) USING HASH
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='管理员表';

-- ----------------------------
-- Records of rt_admin
-- ----------------------------
BEGIN;
INSERT INTO `rt_admin` VALUES (1, 'admin', 'c1027273bf401fede290641952d30fac', 'F8yRsMe7nJmpGTFB', 0, NULL, NULL, 0, 1637296765, 122, 0);
INSERT INTO `rt_admin` VALUES (2, 'test', 'c7b30ad98095b7b560585ffd6371aa47', 'x6pdhRYF4f6bHpFc', 1636948516, '1test', '13873150575', 0, 0, 0, 0);
INSERT INTO `rt_admin` VALUES (5, 'test12', 'c108dd09fba019c8b9681248c876bb4e', 'Ahn7EScJBw3R2TZR', 1636948870, '222', '13885863355', 0, 0, 0, 1636958930);
COMMIT;

-- ----------------------------
-- Table structure for rt_admin_auth
-- ----------------------------
DROP TABLE IF EXISTS `rt_admin_auth`;
CREATE TABLE `rt_admin_auth` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `rules` text CHARACTER SET utf8,
  `status` tinyint(2) unsigned DEFAULT '0' COMMENT '是否可用0可用1不可用',
  `remark` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '描述',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='管理权限表';

-- ----------------------------
-- Records of rt_admin_auth
-- ----------------------------
BEGIN;
INSERT INTO `rt_admin_auth` VALUES (1, '总管理员', '-1', 0, NULL);
INSERT INTO `rt_admin_auth` VALUES (2, 'aaa', '1,4,5,7,37,53', 0, 'aaa');
INSERT INTO `rt_admin_auth` VALUES (15, 'test2', '1,4,5,7,37,53,2,9,20,21,22,23,57,10,26,27,56,58,59,60,61,11,24,25,62,63,64,65,12,66,67,68,13,28,29,30,31,32,14,33,34,35,36,3,15', 1, '');
COMMIT;

-- ----------------------------
-- Table structure for rt_admin_log
-- ----------------------------
DROP TABLE IF EXISTS `rt_admin_log`;
CREATE TABLE `rt_admin_log` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `admin_id` int(10) unsigned NOT NULL COMMENT '管理员账号',
  `log` varchar(255) CHARACTER SET utf8 NOT NULL COMMENT '日志名称',
  `data` text CHARACTER SET utf8 COMMENT '返回记录',
  `ip` varchar(64) CHARACTER SET utf8 DEFAULT '' COMMENT 'IP地址',
  `agent` varchar(255) CHARACTER SET utf8 DEFAULT '' COMMENT '客户端信息',
  `url` varchar(255) CHARACTER SET utf8 DEFAULT NULL COMMENT '地址',
  `method` varchar(100) CHARACTER SET utf8 DEFAULT NULL COMMENT '方法',
  `addtime` int(10) unsigned DEFAULT '0' COMMENT '添加时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='管理操作日志';

-- ----------------------------
-- Records of rt_admin_log
-- ----------------------------
BEGIN;
INSERT INTO `rt_admin_log` VALUES (1, 1, 'admin登录', '{\"password\":\"admin\",\"username\":\"admin\",\"captcha\":\"angt\"}', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/login/do', 'POST', 1636683208);
INSERT INTO `rt_admin_log` VALUES (2, 1, 'admin登录', '{\"username\":\"admin\",\"captcha\":\"wueq\"}', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/login/do', 'POST', 1636683396);
INSERT INTO `rt_admin_log` VALUES (3, 1, 'admin登录', '{\"username\":\"admin\",\"captcha\":\"8mau\"}', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/login/do', 'POST', 1636684074);
INSERT INTO `rt_admin_log` VALUES (4, 1, 'admin登录', '{\"username\":\"admin\",\"captcha\":\"za72\"}', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/login/do', 'POST', 1636687935);
INSERT INTO `rt_admin_log` VALUES (5, 1, 'admin登录', '{\"username\":\"admin\",\"captcha\":\"cxdq\"}', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/login/do', 'POST', 1636688572);
INSERT INTO `rt_admin_log` VALUES (6, 1, 'admin登录', '{\"username\":\"admin\",\"captcha\":\"l3nr\"}', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/login/do', 'POST', 1636689117);
INSERT INTO `rt_admin_log` VALUES (7, 1, 'admin登录', '{\"username\":\"admin\",\"captcha\":\"ra5w\"}', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/login/do', 'POST', 1636689550);
INSERT INTO `rt_admin_log` VALUES (8, 1, 'admin登录', '{\"username\":\"admin\",\"captcha\":\"2xem\"}', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/93.0.4577.82 Safari/537.36', '/server/login/do', 'POST', 1636689633);
INSERT INTO `rt_admin_log` VALUES (9, 1, 'admin登录', '{\"username\":\"admin\",\"captcha\":\"2esr\"}', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/93.0.4577.82 Safari/537.36', '/server/login/do', 'POST', 1636690261);
INSERT INTO `rt_admin_log` VALUES (10, 1, 'admin登录', '{\"username\":\"admin\",\"captcha\":\"tqxc\"}', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/93.0.4577.82 Safari/537.36', '/server/login/do', 'POST', 1636691944);
INSERT INTO `rt_admin_log` VALUES (11, 1, 'admin登录', '{\"username\":\"admin\",\"captcha\":\"g3kj\"}', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/93.0.4577.82 Safari/537.36', '/server/login/do', 'POST', 1636707053);
INSERT INTO `rt_admin_log` VALUES (12, 1, 'admin登录', '{\"username\":\"admin\",\"captcha\":\"quyg\"}', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/93.0.4577.82 Safari/537.36', '/server/login/do', 'POST', 1636708393);
INSERT INTO `rt_admin_log` VALUES (13, 1, 'admin登录', '{\"username\":\"admin\",\"captcha\":\"spkv\"}', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/93.0.4577.82 Safari/537.36', '/server/login/do', 'POST', 1636708927);
INSERT INTO `rt_admin_log` VALUES (14, 1, 'admin登录', '{\"username\":\"admin\",\"captcha\":\"q7hv\"}', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/93.0.4577.82 Safari/537.36', '/server/login/do', 'POST', 1636708992);
INSERT INTO `rt_admin_log` VALUES (15, 1, 'admin登录', '{\"username\":\"admin\",\"captcha\":\"kvm9\"}', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/93.0.4577.82 Safari/537.36', '/server/login/do', 'POST', 1636709026);
INSERT INTO `rt_admin_log` VALUES (16, 1, 'admin登录', '{\"username\":\"admin\",\"captcha\":\"4tdv\"}', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/93.0.4577.82 Safari/537.36', '/server/login/do', 'POST', 1636709593);
INSERT INTO `rt_admin_log` VALUES (17, 1, 'admin登录', '{\"username\":\"admin\",\"captcha\":\"rnxn\"}', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/93.0.4577.82 Safari/537.36', '/server/login/do', 'POST', 1636710000);
INSERT INTO `rt_admin_log` VALUES (18, 1, 'admin登录', '{\"username\":\"admin\",\"captcha\":\"zwgk\"}', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/93.0.4577.82 Safari/537.36', '/server/login/do', 'POST', 1636711037);
INSERT INTO `rt_admin_log` VALUES (19, 1, 'admin登录', '{\"username\":\"admin\",\"captcha\":\"vz4m\"}', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Code/1.62.0 Chrome/91.0.4472.164 Electron/13.5.1 Safari/537.36', '/server/login/do', 'POST', 1636719500);
INSERT INTO `rt_admin_log` VALUES (20, 1, 'admin登录', '{\"username\":\"admin\",\"captcha\":\"csq3\"}', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Code/1.62.0 Chrome/91.0.4472.164 Electron/13.5.1 Safari/537.36', '/server/login/do', 'POST', 1636719624);
INSERT INTO `rt_admin_log` VALUES (21, 1, 'admin登录', '{\"username\":\"admin\",\"captcha\":\"5u96\"}', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Code/1.62.0 Chrome/91.0.4472.164 Electron/13.5.1 Safari/537.36', '/server/login/do', 'POST', 1636719837);
INSERT INTO `rt_admin_log` VALUES (22, 1, 'admin登录', '{\"username\":\"admin\",\"captcha\":\"ssr7\"}', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Code/1.62.0 Chrome/91.0.4472.164 Electron/13.5.1 Safari/537.36', '/server/login/do', 'POST', 1636754198);
COMMIT;

-- ----------------------------
-- Table structure for rt_admin_map
-- ----------------------------
DROP TABLE IF EXISTS `rt_admin_map`;
CREATE TABLE `rt_admin_map` (
  `map_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `admin_id` int(10) unsigned NOT NULL,
  `auth_id` int(10) unsigned NOT NULL,
  `type` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '0角色1集团2公司3门店4部门5区域',
  PRIMARY KEY (`map_id`),
  UNIQUE KEY `admin_id` (`admin_id`,`auth_id`,`type`) USING HASH
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='管理员权限映射表';

-- ----------------------------
-- Records of rt_admin_map
-- ----------------------------
BEGIN;
INSERT INTO `rt_admin_map` VALUES (1, 1, 1, 0);
INSERT INTO `rt_admin_map` VALUES (4, 2, 2, 0);
INSERT INTO `rt_admin_map` VALUES (10, 5, 1, 0);
COMMIT;

-- ----------------------------
-- Table structure for rt_admin_oplog
-- ----------------------------
DROP TABLE IF EXISTS `rt_admin_oplog`;
CREATE TABLE `rt_admin_oplog` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `admin_id` int(10) unsigned NOT NULL COMMENT '管理员账号',
  `log` varchar(255) CHARACTER SET utf8 NOT NULL COMMENT '日志名称',
  `data` text CHARACTER SET utf8 COMMENT '返回记录',
  `ip` varchar(64) CHARACTER SET utf8 DEFAULT '' COMMENT 'IP地址',
  `agent` varchar(255) CHARACTER SET utf8 DEFAULT '' COMMENT '客户端信息',
  `url` varchar(255) CHARACTER SET utf8 DEFAULT NULL COMMENT '地址',
  `method` varchar(100) CHARACTER SET utf8 DEFAULT NULL COMMENT '方法',
  `addtime` int(10) unsigned DEFAULT '0' COMMENT '添加时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=202 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='管理操作日志';

-- ----------------------------
-- Records of rt_admin_oplog
-- ----------------------------
BEGIN;
INSERT INTO `rt_admin_oplog` VALUES (1, 1, 'admin登录', '{\"password\":\"admin\",\"username\":\"admin\",\"captcha\":\"angt\"}', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/login/do', 'POST', 1636683208);
INSERT INTO `rt_admin_oplog` VALUES (2, 1, 'admin登录', '{\"username\":\"admin\",\"captcha\":\"wueq\"}', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/login/do', 'POST', 1636683396);
INSERT INTO `rt_admin_oplog` VALUES (3, 1, 'admin登录', '{\"username\":\"admin\",\"captcha\":\"8mau\"}', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/login/do', 'POST', 1636684074);
INSERT INTO `rt_admin_oplog` VALUES (4, 1, 'admin登录', '{\"username\":\"admin\",\"captcha\":\"za72\"}', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/login/do', 'POST', 1636687935);
INSERT INTO `rt_admin_oplog` VALUES (5, 1, 'admin登录', '{\"username\":\"admin\",\"captcha\":\"cxdq\"}', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/login/do', 'POST', 1636688572);
INSERT INTO `rt_admin_oplog` VALUES (6, 1, 'admin登录', '{\"username\":\"admin\",\"captcha\":\"l3nr\"}', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/login/do', 'POST', 1636689117);
INSERT INTO `rt_admin_oplog` VALUES (7, 1, 'admin登录', '{\"username\":\"admin\",\"captcha\":\"ra5w\"}', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/login/do', 'POST', 1636689550);
INSERT INTO `rt_admin_oplog` VALUES (8, 1, 'admin登录', '{\"username\":\"admin\",\"captcha\":\"2xem\"}', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/93.0.4577.82 Safari/537.36', '/server/login/do', 'POST', 1636689633);
INSERT INTO `rt_admin_oplog` VALUES (9, 1, 'admin登录', '{\"username\":\"admin\",\"captcha\":\"2esr\"}', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/93.0.4577.82 Safari/537.36', '/server/login/do', 'POST', 1636690261);
INSERT INTO `rt_admin_oplog` VALUES (10, 1, 'admin登录', '{\"username\":\"admin\",\"captcha\":\"tqxc\"}', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/93.0.4577.82 Safari/537.36', '/server/login/do', 'POST', 1636691944);
INSERT INTO `rt_admin_oplog` VALUES (11, 1, 'admin登录', '{\"username\":\"admin\",\"captcha\":\"g3kj\"}', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/93.0.4577.82 Safari/537.36', '/server/login/do', 'POST', 1636707053);
INSERT INTO `rt_admin_oplog` VALUES (12, 1, 'admin登录', '{\"username\":\"admin\",\"captcha\":\"quyg\"}', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/93.0.4577.82 Safari/537.36', '/server/login/do', 'POST', 1636708393);
INSERT INTO `rt_admin_oplog` VALUES (13, 1, 'admin登录', '{\"username\":\"admin\",\"captcha\":\"spkv\"}', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/93.0.4577.82 Safari/537.36', '/server/login/do', 'POST', 1636708927);
INSERT INTO `rt_admin_oplog` VALUES (14, 1, 'admin登录', '{\"username\":\"admin\",\"captcha\":\"q7hv\"}', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/93.0.4577.82 Safari/537.36', '/server/login/do', 'POST', 1636708992);
INSERT INTO `rt_admin_oplog` VALUES (15, 1, 'admin登录', '{\"username\":\"admin\",\"captcha\":\"kvm9\"}', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/93.0.4577.82 Safari/537.36', '/server/login/do', 'POST', 1636709026);
INSERT INTO `rt_admin_oplog` VALUES (16, 1, 'admin登录', '{\"username\":\"admin\",\"captcha\":\"4tdv\"}', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/93.0.4577.82 Safari/537.36', '/server/login/do', 'POST', 1636709593);
INSERT INTO `rt_admin_oplog` VALUES (17, 1, 'admin登录', '{\"username\":\"admin\",\"captcha\":\"rnxn\"}', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/93.0.4577.82 Safari/537.36', '/server/login/do', 'POST', 1636710000);
INSERT INTO `rt_admin_oplog` VALUES (18, 1, 'admin登录', '{\"username\":\"admin\",\"captcha\":\"zwgk\"}', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/93.0.4577.82 Safari/537.36', '/server/login/do', 'POST', 1636711037);
INSERT INTO `rt_admin_oplog` VALUES (19, 1, 'admin登录', '{\"username\":\"admin\",\"captcha\":\"tjvj\"}', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Code/1.62.1 Chrome/91.0.4472.164 Electron/13.5.2 Safari/537.36', '/server/login/do', 'POST', 1636760259);
INSERT INTO `rt_admin_oplog` VALUES (20, 1, 'admin登录', '{\"username\":\"admin\",\"captcha\":\"zjem\"}', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/93.0.4577.82 Safari/537.36', '/server/login/do', 'POST', 1636769860);
INSERT INTO `rt_admin_oplog` VALUES (21, 1, 'admin登录', '{\"username\":\"admin\",\"captcha\":\"2aac\"}', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/93.0.4577.82 Safari/537.36', '/server/login/do', 'POST', 1636770059);
INSERT INTO `rt_admin_oplog` VALUES (22, 1, 'admin登录', '{\"username\":\"admin\",\"captcha\":\"rg8q\"}', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/login/do', 'POST', 1636770165);
INSERT INTO `rt_admin_oplog` VALUES (23, 1, 'admin登录', '{\"username\":\"admin\",\"captcha\":\"38ay\"}', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/login/do', 'POST', 1636777200);
INSERT INTO `rt_admin_oplog` VALUES (24, 1, 'admin登录', '{\"username\":\"admin\",\"captcha\":\"ccbj\"}', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/login/do', 'POST', 1636777527);
INSERT INTO `rt_admin_oplog` VALUES (25, 1, 'admin登录', '{\"username\":\"admin\",\"captcha\":\"thxe\"}', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/93.0.4577.82 Safari/537.36', '/server/login/do', 'POST', 1636777620);
INSERT INTO `rt_admin_oplog` VALUES (26, 1, 'admin登录', '{\"username\":\"admin\",\"captcha\":\"fqqp\"}', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/login/do', 'POST', 1636778519);
INSERT INTO `rt_admin_oplog` VALUES (27, 1, 'admin登录', '{\"username\":\"admin\",\"captcha\":\"xwwb\"}', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/login/do', 'POST', 1636778607);
INSERT INTO `rt_admin_oplog` VALUES (28, 1, 'admin登录', '{\"username\":\"admin\",\"captcha\":\"s6gy\"}', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/login/do', 'POST', 1636778736);
INSERT INTO `rt_admin_oplog` VALUES (29, 1, 'admin登录', '{\"username\":\"admin\",\"captcha\":\"x9k4\"}', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/login/do', 'POST', 1636778869);
INSERT INTO `rt_admin_oplog` VALUES (30, 1, 'admin登录', '{\"username\":\"admin\",\"captcha\":\"3mdo\"}', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/login/do', 'POST', 1636781312);
INSERT INTO `rt_admin_oplog` VALUES (31, 1, 'admin登录', '{\"username\":\"admin\",\"captcha\":\"yrhv\"}', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/login/do', 'POST', 1636784601);
INSERT INTO `rt_admin_oplog` VALUES (32, 1, 'admin登录', '{\"username\":\"admin\",\"captcha\":\"5kfs\"}', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/login/do', 'POST', 1636788224);
INSERT INTO `rt_admin_oplog` VALUES (33, 1, 'admin登录', '{\"username\":\"admin\",\"captcha\":\"9etk\"}', '::ffff:127.0.0.1', 'PostmanRuntime/7.28.4', '/server/login/do', 'POST', 1636790308);
INSERT INTO `rt_admin_oplog` VALUES (34, 1, 'admin登录', '{\"username\":\"admin\",\"captcha\":\"rrxy\"}', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/login/do', 'POST', 1636791000);
INSERT INTO `rt_admin_oplog` VALUES (35, 1, 'admin登录', '{\"username\":\"admin\",\"captcha\":\"j42m\"}', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/login/do', 'POST', 1636792621);
INSERT INTO `rt_admin_oplog` VALUES (36, 1, 'admin登录', '{\"username\":\"admin\",\"captcha\":\"tgcw\"}', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/login/do', 'POST', 1636792990);
INSERT INTO `rt_admin_oplog` VALUES (37, 1, 'admin登录', '{\"username\":\"admin\",\"captcha\":\"zhlr\"}', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/login/do', 'POST', 1636793350);
INSERT INTO `rt_admin_oplog` VALUES (38, 1, 'admin登录', '{\"username\":\"admin\",\"captcha\":\"mn3f\"}', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/login/do', 'POST', 1636796303);
INSERT INTO `rt_admin_oplog` VALUES (39, 1, 'admin登录', '{\"username\":\"admin\",\"captcha\":\"vhld\"}', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/login/do', 'POST', 1636796968);
INSERT INTO `rt_admin_oplog` VALUES (40, 1, 'admin登录', '{\"username\":\"admin\",\"captcha\":\"qfkw\"}', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/login/do', 'POST', 1636797088);
INSERT INTO `rt_admin_oplog` VALUES (41, 1, 'admin登录', '{\"username\":\"admin\",\"captcha\":\"ucma\"}', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/login/do', 'POST', 1636847701);
INSERT INTO `rt_admin_oplog` VALUES (42, 1, '设置菜单显示', '{\"id\":\"3\",\"ifshow\":\"0\"}', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/menu/ifshow', 'POST', 1636850164);
INSERT INTO `rt_admin_oplog` VALUES (43, 1, 'admin登录', '{\"username\":\"admin\",\"captcha\":\"5zpj\"}', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/login/do', 'POST', 1636850932);
INSERT INTO `rt_admin_oplog` VALUES (44, 1, '设置菜单显示', '{\"id\":\"3\",\"ifshow\":\"1\"}', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/menu/ifshow', 'POST', 1636850942);
INSERT INTO `rt_admin_oplog` VALUES (45, 1, 'admin登录', '{\"username\":\"admin\",\"captcha\":\"jf9m\"}', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/login/do', 'POST', 1636851796);
INSERT INTO `rt_admin_oplog` VALUES (46, 1, '用户登录', '{\"username\":\"admin\",\"captcha\":\"crhq\"}', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/login/do', 'POST', 1636853681);
INSERT INTO `rt_admin_oplog` VALUES (47, 1, 'admin用户登录', '{\"username\":\"admin\",\"captcha\":\"zmsc\"}', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/login/do', 'POST', 1636855313);
INSERT INTO `rt_admin_oplog` VALUES (48, 1, 'admin用户登录', '{\"username\":\"admin\",\"captcha\":\"h3ae\"}', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/login/do', 'POST', 1636855489);
INSERT INTO `rt_admin_oplog` VALUES (49, 1, 'admin用户登录', '{\"username\":\"admin\",\"captcha\":\"f7mx\"}', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/login/do', 'POST', 1636856772);
INSERT INTO `rt_admin_oplog` VALUES (50, 1, 'admin用户登录', '{\"username\":\"admin\",\"captcha\":\"zvba\"}', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/login/do', 'POST', 1636864423);
INSERT INTO `rt_admin_oplog` VALUES (51, 1, 'admin用户登录', '{\"username\":\"admin\",\"captcha\":\"vyyh\"}', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/login/do', 'POST', 1636864729);
INSERT INTO `rt_admin_oplog` VALUES (52, 1, 'admin用户登录', '{\"username\":\"admin\",\"captcha\":\"uuqr\"}', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/login/do', 'POST', 1636864815);
INSERT INTO `rt_admin_oplog` VALUES (53, 1, 'admin用户登录', '{\"username\":\"admin\",\"captcha\":\"pzpt\"}', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/login/do', 'POST', 1636864927);
INSERT INTO `rt_admin_oplog` VALUES (54, 1, 'admin用户登录', '{\"username\":\"admin\",\"captcha\":\"uaro\"}', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/login/do', 'POST', 1636864997);
INSERT INTO `rt_admin_oplog` VALUES (55, 1, 'admin用户登录', '{\"username\":\"admin\",\"captcha\":\"ebxu\"}', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/login/do', 'POST', 1636865023);
INSERT INTO `rt_admin_oplog` VALUES (56, 1, 'admin用户登录', '{\"username\":\"admin\",\"captcha\":\"drxv\"}', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/login/do', 'POST', 1636867592);
INSERT INTO `rt_admin_oplog` VALUES (57, 1, 'admin用户登录', '{\"username\":\"admin\",\"captcha\":\"b5du\"}', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/login/do', 'POST', 1636867712);
INSERT INTO `rt_admin_oplog` VALUES (58, 1, 'admin用户登录', '{\"username\":\"admin\",\"captcha\":\"ku9t\"}', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/login/do', 'POST', 1636873872);
INSERT INTO `rt_admin_oplog` VALUES (59, 1, 'admin用户登录', '{\"username\":\"admin\",\"captcha\":\"t545\"}', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/login/do', 'POST', 1636877578);
INSERT INTO `rt_admin_oplog` VALUES (60, 1, 'admin用户登录', '{\"username\":\"admin\",\"captcha\":\"xhy8\"}', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/login/do', 'POST', 1636885287);
INSERT INTO `rt_admin_oplog` VALUES (61, 1, 'admin用户登录', '{\"username\":\"admin\",\"captcha\":\"rbg2\"}', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/login/do', 'POST', 1636930153);
INSERT INTO `rt_admin_oplog` VALUES (62, 1, 'admin用户登录', '{\"username\":\"admin\",\"captcha\":\"3kkj\"}', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/login/do', 'POST', 1636930845);
INSERT INTO `rt_admin_oplog` VALUES (63, 1, 'admin用户登录', '{\"username\":\"admin\",\"captcha\":\"aekt\"}', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/login/do', 'POST', 1636933195);
INSERT INTO `rt_admin_oplog` VALUES (64, 1, 'admin用户登录', '{\"username\":\"admin\",\"captcha\":\"lz3s\"}', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/login/do', 'POST', 1636933445);
INSERT INTO `rt_admin_oplog` VALUES (65, 1, 'admin用户登录', '{\"username\":\"admin\",\"captcha\":\"rwt3\"}', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/login/do', 'POST', 1636934002);
INSERT INTO `rt_admin_oplog` VALUES (66, 1, 'admin用户登录', '{\"username\":\"admin\",\"captcha\":\"cffy\"}', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/login/do', 'POST', 1636937582);
INSERT INTO `rt_admin_oplog` VALUES (67, 1, 'admin用户登录', '{\"username\":\"admin\",\"captcha\":\"czda\"}', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/login/do', 'POST', 1636941888);
INSERT INTO `rt_admin_oplog` VALUES (68, 1, '编辑菜单', '{\"title\":\"管理员管理\",\"pname\":\"系统管理\",\"route\":\"admin/index\",\"href\":\"\",\"icon\":\"layui-icon layui-icon-key\",\"type\":\"1\",\"order_num\":\"11\",\"id\":\"11\",\"pid\":\"2\"}', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/menu/edit', 'POST', 1636941924);
INSERT INTO `rt_admin_oplog` VALUES (69, 1, '编辑菜单', '{\"title\":\"管理员管理\",\"pname\":\"系统管理\",\"route\":\"admin/list\",\"href\":\"view/admin/list\",\"icon\":\"layui-icon layui-icon-key\",\"type\":\"1\",\"order_num\":\"11\",\"id\":\"11\",\"pid\":\"2\"}', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/menu/edit', 'POST', 1636941981);
INSERT INTO `rt_admin_oplog` VALUES (70, 1, '编辑菜单', '{\"title\":\"管理员管理\",\"pname\":\"系统管理\",\"route\":\"admin/list\",\"href\":\"view/admin/list.html\",\"icon\":\"layui-icon layui-icon-key\",\"type\":\"1\",\"order_num\":\"11\",\"id\":\"11\",\"pid\":\"2\"}', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/menu/edit', 'POST', 1636942018);
INSERT INTO `rt_admin_oplog` VALUES (71, 1, '添加菜单', '{\"title\":\"管理员添加前\",\"pname\":\"11\",\"route\":\"admin/addBefore\",\"href\":\"\",\"icon\":\"\",\"type\":\"3\",\"order_num\":\"0\",\"pid\":\"11\"}', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/menu/add', 'POST', 1636944104);
INSERT INTO `rt_admin_oplog` VALUES (72, 1, 'admin用户登录', '{\"username\":\"admin\",\"captcha\":\"xu9a\"}', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/login/do', 'POST', 1636945520);
INSERT INTO `rt_admin_oplog` VALUES (73, 1, '添加菜单', '{\"title\":\"添加管理员\",\"pname\":\"11\",\"route\":\"admin/add\",\"href\":\"\",\"icon\":\"layui-icon layui-icon-windows\",\"type\":\"2\",\"order_num\":\"0\",\"pid\":\"11\"}', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/menu/add', 'POST', 1636947931);
INSERT INTO `rt_admin_oplog` VALUES (74, 1, 'admin用户登录', '{\"username\":\"admin\",\"captcha\":\"ch7a\"}', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/login/do', 'POST', 1636949587);
INSERT INTO `rt_admin_oplog` VALUES (75, 1, 'admin用户登录', '{\"username\":\"admin\",\"captcha\":\"lhtp\"}', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/login/do', 'POST', 1636949669);
INSERT INTO `rt_admin_oplog` VALUES (76, 1, 'admin用户登录', '{\"username\":\"admin\",\"captcha\":\"3e8n\"}', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/login/do', 'POST', 1636949737);
INSERT INTO `rt_admin_oplog` VALUES (77, 1, 'admin用户登录', '{\"username\":\"admin\",\"captcha\":\"mywv\"}', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/login/do', 'POST', 1636949843);
INSERT INTO `rt_admin_oplog` VALUES (78, 1, 'admin用户登录', '{\"username\":\"admin\",\"captcha\":\"qxgd\"}', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/login/do', 'POST', 1636949890);
INSERT INTO `rt_admin_oplog` VALUES (79, 1, 'admin用户登录', '{\"username\":\"admin\",\"captcha\":\"a4gc\"}', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/login/do', 'POST', 1636950046);
INSERT INTO `rt_admin_oplog` VALUES (80, 1, '添加菜单', '{\"title\":\"编辑管理员前\",\"pname\":\"11\",\"route\":\"admin/editBefore\",\"href\":\"\",\"icon\":\"layui-icon layui-icon-export\",\"type\":\"3\",\"order_num\":\"0\",\"pid\":\"11\"}', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/menu/add', 'POST', 1636950088);
INSERT INTO `rt_admin_oplog` VALUES (81, 1, 'admin用户登录', '{\"username\":\"admin\",\"captcha\":\"nhhu\"}', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/login/do', 'POST', 1636957714);
INSERT INTO `rt_admin_oplog` VALUES (82, 1, '编辑菜单', '{\"title\":\"编辑管理员\",\"pname\":\"管理员管理\",\"route\":\"admin/edit\",\"href\":\"\",\"icon\":\"layui-icon layui-icon-time\",\"type\":\"2\",\"order_num\":\"20\",\"id\":\"24\",\"pid\":\"11\"}', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/menu/edit', 'POST', 1636958889);
INSERT INTO `rt_admin_oplog` VALUES (83, 1, '编辑菜单', '{\"title\":\"删除管理员\",\"pname\":\"管理员管理\",\"route\":\"admin/del\",\"href\":\"\",\"icon\":\"layui-icon layui-icon-more-vertical\",\"type\":\"2\",\"order_num\":\"21\",\"id\":\"25\",\"pid\":\"11\"}', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/menu/edit', 'POST', 1636959517);
INSERT INTO `rt_admin_oplog` VALUES (84, 1, '编辑菜单', '{\"title\":\"管理员编辑前\",\"pname\":\"管理员管理\",\"route\":\"admin/editBefore\",\"href\":\"\",\"icon\":\"layui-icon layui-icon-export\",\"type\":\"3\",\"order_num\":\"0\",\"id\":\"64\",\"pid\":\"11\"}', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/menu/edit', 'POST', 1636959542);
INSERT INTO `rt_admin_oplog` VALUES (85, 1, '编辑菜单', '{\"title\":\"日志管理\",\"pname\":\"系统管理\",\"route\":\"logs\",\"href\":\"\",\"icon\":\"layui-icon layui-icon-spread-left\",\"type\":\"0\",\"order_num\":\"12\",\"id\":\"12\",\"pid\":\"2\"}', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/menu/edit', 'POST', 1636959580);
INSERT INTO `rt_admin_oplog` VALUES (86, 1, 'admin用户登录', '{\"username\":\"admin\",\"captcha\":\"6ave\"}', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/login/do', 'POST', 1636961221);
INSERT INTO `rt_admin_oplog` VALUES (87, 1, '设置角色可用', '{\"id\":\"2\",\"status\":\"1\"}', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/auth/enable', 'POST', 1636962371);
INSERT INTO `rt_admin_oplog` VALUES (88, 1, '设置角色可用', '{\"id\":\"2\",\"status\":\"0\"}', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/auth/enable', 'POST', 1636962383);
INSERT INTO `rt_admin_oplog` VALUES (89, 1, '添加菜单', '{\"title\":\"管理员启用禁用\",\"pname\":\"11\",\"route\":\"admin/enable\",\"href\":\"\",\"icon\":\"layui-icon layui-icon-slider\",\"type\":\"2\",\"order_num\":\"0\",\"pid\":\"11\"}', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/menu/add', 'POST', 1636962429);
INSERT INTO `rt_admin_oplog` VALUES (90, 1, '设置管理员可用', '{\"id\":\"5\",\"status\":\"0\"}', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/admin/enable', 'POST', 1636962435);
INSERT INTO `rt_admin_oplog` VALUES (91, 1, '设置管理员可用', '{\"id\":\"5\",\"status\":\"1\"}', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/admin/enable', 'POST', 1636962436);
INSERT INTO `rt_admin_oplog` VALUES (92, 1, '设置管理员可用', '{\"id\":\"5\",\"status\":\"0\"}', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/admin/enable', 'POST', 1636962446);
INSERT INTO `rt_admin_oplog` VALUES (93, 1, '添加菜单', '{\"title\":\"操作日志\",\"pname\":\"12\",\"route\":\"logs/opList\",\"href\":\"view/logs/op.html\",\"icon\":\"layui-icon layui-icon-date\",\"type\":\"1\",\"order_num\":\"0\",\"pid\":\"12\"}', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/menu/add', 'POST', 1636964785);
INSERT INTO `rt_admin_oplog` VALUES (94, 1, 'admin用户登录', '{\"username\":\"admin\",\"captcha\":\"2wtg\"}', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/login/do', 'POST', 1636965938);
INSERT INTO `rt_admin_oplog` VALUES (95, 1, '编辑菜单', '{\"title\":\"操作日志\",\"pname\":\"日志管理\",\"route\":\"logs/op\",\"href\":\"view/logs/op.html\",\"icon\":\"layui-icon layui-icon-date\",\"type\":\"1\",\"order_num\":\"0\",\"id\":\"66\",\"pid\":\"12\"}', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/menu/edit', 'POST', 1636965966);
INSERT INTO `rt_admin_oplog` VALUES (96, 1, '添加菜单', '{\"title\":\"行为日志\",\"pname\":\"12\",\"route\":\"logs/view\",\"href\":\"view/logs/view.html\",\"icon\":\"layui-icon layui-icon-cols\",\"type\":\"1\",\"order_num\":\"0\",\"pid\":\"12\"}', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/menu/add', 'POST', 1636966010);
INSERT INTO `rt_admin_oplog` VALUES (97, 1, '添加菜单', '{\"title\":\"错误日志\",\"pname\":\"12\",\"route\":\"logs/err\",\"href\":\"view/logs/err.html\",\"icon\":\"layui-icon layui-icon-survey\",\"type\":\"1\",\"order_num\":\"0\",\"pid\":\"12\"}', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/menu/add', 'POST', 1636966045);
INSERT INTO `rt_admin_oplog` VALUES (98, 1, 'admin用户登录', '{\"username\":\"admin\",\"captcha\":\"kq77\"}', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/login/do', 'POST', 1636968651);
INSERT INTO `rt_admin_oplog` VALUES (99, 1, 'admin用户登录', '{\"username\":\"admin\",\"captcha\":\"qw4n\"}', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/login/do', 'POST', 1637020753);
INSERT INTO `rt_admin_oplog` VALUES (100, 1, '编辑菜单', '{\"title\":\"系统设置\",\"pname\":\"系统管理\",\"route\":\"set/cate\",\"href\":\"\",\"icon\":\"layui-icon layui-icon-find-fill\",\"type\":\"1\",\"order_num\":\"13\",\"id\":\"13\",\"pid\":\"2\"}', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/menu/edit', 'POST', 1637023335);
INSERT INTO `rt_admin_oplog` VALUES (101, 1, '编辑菜单', '{\"title\":\"系统设置\",\"pname\":\"系统管理\",\"route\":\"set/cate\",\"href\":\"view/set/cate.html\",\"icon\":\"layui-icon layui-icon-find-fill\",\"type\":\"1\",\"order_num\":\"13\",\"id\":\"13\",\"pid\":\"2\"}', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/menu/edit', 'POST', 1637023402);
INSERT INTO `rt_admin_oplog` VALUES (102, 1, 'admin用户登录', '{\"username\":\"admin\",\"captcha\":\"5agy\"}', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/login/do', 'POST', 1637027945);
INSERT INTO `rt_admin_oplog` VALUES (103, 1, 'admin用户登录', '{\"username\":\"admin\",\"captcha\":\"qyvh\"}', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/login/do', 'POST', 1637028098);
INSERT INTO `rt_admin_oplog` VALUES (104, 1, '添加菜单', '{\"title\":\"test\",\"pname\":\"3\",\"route\":\"tet\",\"href\":\"\",\"icon\":\"\",\"type\":\"0\",\"order_num\":\"0\",\"pid\":\"3\"}', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/menu/add', 'POST', 1637028919);
INSERT INTO `rt_admin_oplog` VALUES (105, 1, '删除菜单', '{\"id\":69}', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/menu/del', 'POST', 1637028927);
INSERT INTO `rt_admin_oplog` VALUES (106, 1, '添加菜单', '{\"title\":\"test\",\"pname\":\"3\",\"route\":\"ttt\",\"href\":\"\",\"icon\":\"\",\"type\":\"0\",\"order_num\":\"0\",\"pid\":\"3\"}', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/menu/add', 'POST', 1637029256);
INSERT INTO `rt_admin_oplog` VALUES (107, 1, '删除菜单', '{\"id\":70}', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/menu/del', 'POST', 1637029261);
INSERT INTO `rt_admin_oplog` VALUES (108, 1, '添加菜单', '{\"title\":\"test\",\"pname\":\"3\",\"route\":\"ttt\",\"href\":\"\",\"icon\":\"\",\"type\":\"0\",\"order_num\":\"0\",\"pid\":\"3\"}', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/menu/add', 'POST', 1637029596);
INSERT INTO `rt_admin_oplog` VALUES (109, 1, '删除菜单', '{\"id\":71}', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/menu/del', 'POST', 1637030256);
INSERT INTO `rt_admin_oplog` VALUES (110, 1, '添加菜单', '{\"title\":\"test\",\"pname\":\"0\",\"route\":\"ttt\",\"href\":\"\",\"icon\":\"layui-icon layui-icon-heart-fill\",\"type\":\"0\",\"order_num\":\"0\",\"pid\":\"0\"}', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/menu/add', 'POST', 1637030982);
INSERT INTO `rt_admin_oplog` VALUES (111, 1, '删除菜单', '{\"id\":72}', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/menu/del', 'POST', 1637031150);
INSERT INTO `rt_admin_oplog` VALUES (112, 1, '添加菜单', '{\"title\":\"test\",\"pname\":\"0\",\"route\":\"ttt\",\"href\":\"\",\"icon\":\"\",\"type\":\"0\",\"order_num\":\"0\",\"pid\":\"0\"}', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/menu/add', 'POST', 1637031472);
INSERT INTO `rt_admin_oplog` VALUES (113, 1, '添加菜单', '{\"title\":\"tttt\",\"pname\":\"0\",\"route\":\"ttt\",\"href\":\"\",\"icon\":\"\",\"type\":\"0\",\"order_num\":\"0\",\"pid\":\"0\"}', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/menu/add', 'POST', 1637031483);
INSERT INTO `rt_admin_oplog` VALUES (114, 1, '删除菜单', '{\"id\":73}', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/menu/del', 'POST', 1637031488);
INSERT INTO `rt_admin_oplog` VALUES (115, 1, '添加菜单', '{\"title\":\"ttt\",\"pname\":\"74\",\"route\":\"ttttt\",\"href\":\"\",\"icon\":\"\",\"type\":\"0\",\"order_num\":\"0\",\"pid\":\"74\"}', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/menu/add', 'POST', 1637031501);
INSERT INTO `rt_admin_oplog` VALUES (116, 1, '删除菜单', '{\"id\":74}', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/menu/del', 'POST', 1637031506);
INSERT INTO `rt_admin_oplog` VALUES (117, 1, 'admin用户登录', '{\"username\":\"admin\",\"captcha\":\"tnks\"}', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/login/do', 'POST', 1637031563);
INSERT INTO `rt_admin_oplog` VALUES (118, 1, '添加菜单', '{\"title\":\"tttt\",\"pname\":\"75\",\"route\":\"tttttt\",\"href\":\"\",\"icon\":\"\",\"type\":\"0\",\"order_num\":\"0\",\"pid\":\"75\"}', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/menu/add', 'POST', 1637032000);
INSERT INTO `rt_admin_oplog` VALUES (119, 1, '删除菜单', '{\"id\":76}', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/menu/del', 'POST', 1637033138);
INSERT INTO `rt_admin_oplog` VALUES (120, 1, '删除菜单', '{\"id\":75}', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/menu/del', 'POST', 1637033142);
INSERT INTO `rt_admin_oplog` VALUES (121, 1, '添加菜单', '{\"title\":\"test\",\"pname\":\"0\",\"route\":\"test\",\"href\":\"\",\"icon\":\"\",\"type\":0,\"order_num\":0,\"pid\":0}', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/menu/add', 'POST', 1637034082);
INSERT INTO `rt_admin_oplog` VALUES (122, 1, '删除菜单', '{\"id\":77}', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/menu/del', 'POST', 1637034087);
INSERT INTO `rt_admin_oplog` VALUES (123, 1, '设置菜单显示', '{\"id\":3,\"ifshow\":0}', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/menu/ifshow', 'POST', 1637034286);
INSERT INTO `rt_admin_oplog` VALUES (124, 1, '设置菜单显示', '{\"id\":3,\"ifshow\":1}', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/menu/ifshow', 'POST', 1637034293);
INSERT INTO `rt_admin_oplog` VALUES (125, 1, '编辑菜单', '{\"title\":\"前端菜单\",\"pname\":\"公共模块\",\"route\":\"menu/list\",\"href\":\"\",\"icon\":\"layui-icon layui-icon-mike\",\"type\":3,\"order_num\":0,\"id\":15,\"pid\":3}', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/menu/edit', 'POST', 1637034309);
INSERT INTO `rt_admin_oplog` VALUES (126, 1, '编辑菜单', '{\"title\":\"前端菜单\",\"pname\":\"公共模块\",\"route\":\"menu/list\",\"href\":\"\",\"icon\":\"layui-icon layui-icon-transfer\",\"type\":3,\"order_num\":0,\"id\":15,\"pid\":3}', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/menu/edit', 'POST', 1637034432);
INSERT INTO `rt_admin_oplog` VALUES (127, 1, 'admin用户登录', '{\"username\":\"admin\",\"captcha\":\"mxpk\"}', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/login/do', 'POST', 1637035880);
INSERT INTO `rt_admin_oplog` VALUES (128, 1, '添加角色', '{\"name\":\"test\",\"status\":0,\"id\":\"15\",\"remark\":\"\",\"rules\":\"1,4,5,7,37,53,2,9,20,21,22,23,57,10,26,27,56,58,59,60,61,11,24,25,62,63,64,65,12,66,67,68,13,28,29,30,31,32,14,33,34,35,36,3,15\"}', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/auth/add', 'POST', 1637036280);
INSERT INTO `rt_admin_oplog` VALUES (129, 1, '编辑角色', '{\"name\":\"test2\",\"status\":0,\"id\":15,\"remark\":\"\",\"rules\":\"1,4,5,7,37,53,2,9,20,21,22,23,57,10,26,27,56,58,59,60,61,11,24,25,62,63,64,65,12,66,67,68,13,28,29,30,31,32,14,33,34,35,36,3,15\"}', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/auth/edit', 'POST', 1637037071);
INSERT INTO `rt_admin_oplog` VALUES (130, 1, '设置角色可用', '{\"id\":15,\"status\":0}', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/auth/enable', 'POST', 1637037175);
INSERT INTO `rt_admin_oplog` VALUES (131, 1, '设置角色可用', '{\"id\":15,\"status\":1}', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/auth/enable', 'POST', 1637037179);
INSERT INTO `rt_admin_oplog` VALUES (132, 1, '添加管理员', '{\"username\":\"t4e\",\"name\":\"11111\",\"mobile\":\"13888888888\",\"status\":0,\"layuiTreeCheck_2\":\"2\",\"remark\":\"\",\"rules\":\"2\",\"salt\":\"KJBmzRxjAy5HMSPh\",\"add_time\":1637038189}', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/admin/add', 'POST', 1637038189);
INSERT INTO `rt_admin_oplog` VALUES (133, 1, 'admin用户登录', '{\"username\":\"admin\",\"captcha\":\"foen\"}', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/login/do', 'POST', 1637039428);
INSERT INTO `rt_admin_oplog` VALUES (134, 1, 'admin用户登录', '{\"username\":\"admin\",\"captcha\":\"x4vd\"}', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/login/do', 'POST', 1637039566);
INSERT INTO `rt_admin_oplog` VALUES (135, 1, '编辑管理员', '{\"username\":\"t4e\",\"name\":\"11111\",\"mobile\":\"13888888888\",\"status\":0,\"layuiTreeCheck_2\":\"2\",\"remark\":\"\",\"admin_id\":6,\"rules\":\"2\"}', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/admin/edit', 'POST', 1637039790);
INSERT INTO `rt_admin_oplog` VALUES (136, 1, '编辑管理员', '{\"username\":\"t4e2\",\"name\":\"11111\",\"mobile\":\"13888888888\",\"status\":0,\"layuiTreeCheck_2\":\"2\",\"remark\":\"\",\"admin_id\":6,\"rules\":\"2\"}', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/admin/edit', 'POST', 1637039796);
INSERT INTO `rt_admin_oplog` VALUES (137, 1, '删除管理员', '{\"admin_id\":6}', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/admin/del', 'POST', 1637039978);
INSERT INTO `rt_admin_oplog` VALUES (138, 1, '设置管理员可用', '{\"id\":5,\"status\":1}', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/admin/enable', 'POST', 1637040173);
INSERT INTO `rt_admin_oplog` VALUES (139, 1, '设置管理员可用', '{\"id\":5,\"status\":0}', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/admin/enable', 'POST', 1637040174);
INSERT INTO `rt_admin_oplog` VALUES (140, 1, '添加管理员', '{\"username\":\"ttttt\",\"name\":\"11\",\"mobile\":\"13985858888\",\"status\":0,\"layuiTreeCheck_2\":\"2\",\"remark\":\"\",\"rules\":\"2\",\"salt\":\"ZEJEKTwNiefHP4QQ\",\"add_time\":1637040196}', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/admin/add', 'POST', 1637040196);
INSERT INTO `rt_admin_oplog` VALUES (141, 1, '编辑管理员', '{\"username\":\"ttttt2\",\"name\":\"11\",\"mobile\":\"13985858888\",\"status\":0,\"layuiTreeCheck_2\":\"2\",\"remark\":\"\",\"admin_id\":7,\"rules\":\"2\"}', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/admin/edit', 'POST', 1637040203);
INSERT INTO `rt_admin_oplog` VALUES (142, 1, '删除管理员', '{\"admin_id\":7}', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/admin/del', 'POST', 1637040206);
INSERT INTO `rt_admin_oplog` VALUES (143, 1, 'admin用户登录', '{\"username\":\"admin\",\"captcha\":\"8cs2\"}', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/login/do', 'POST', 1637052507);
INSERT INTO `rt_admin_oplog` VALUES (144, 1, '添加菜单', '{\"title\":\"添加系统配置类目\",\"pname\":\"13\",\"route\":\"set/cateAdd\",\"href\":\"view/set/cate_add.html\",\"icon\":\"layui-icon layui-icon-windows\",\"type\":2,\"order_num\":0,\"pid\":13}', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/menu/add', 'POST', 1637055590);
INSERT INTO `rt_admin_oplog` VALUES (145, 1, 'admin用户登录', '{\"username\":\"admin\",\"captcha\":\"r4bz\"}', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/login/do', 'POST', 1637056412);
INSERT INTO `rt_admin_oplog` VALUES (146, 1, 'admin用户登录', '{\"username\":\"admin\",\"captcha\":\"y9hd\"}', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/93.0.4577.82 Safari/537.36', '/server/login/do', 'POST', 1637056463);
INSERT INTO `rt_admin_oplog` VALUES (147, 1, 'admin用户登录', '{\"username\":\"admin\",\"captcha\":\"ftjc\"}', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/login/do', 'POST', 1637107308);
INSERT INTO `rt_admin_oplog` VALUES (148, 1, '添加菜单', '{\"title\":\"编辑系统类目前\",\"pname\":\"13\",\"route\":\"set/cateEditBefore\",\"href\":\"view/set/cate_edit.html\",\"icon\":\"layui-icon layui-icon-windows\",\"type\":2,\"order_num\":0,\"pid\":13}', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/menu/add', 'POST', 1637108007);
INSERT INTO `rt_admin_oplog` VALUES (149, 1, '添加菜单', '{\"title\":\"编辑系统类目\",\"pname\":\"13\",\"route\":\"set/cateEdit\",\"href\":\"\",\"icon\":\"layui-icon layui-icon-template\",\"type\":3,\"order_num\":0,\"pid\":13}', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/menu/add', 'POST', 1637108058);
INSERT INTO `rt_admin_oplog` VALUES (150, 1, '添加菜单', '{\"title\":\"删除配置类目\",\"pname\":\"13\",\"route\":\"set/cateDelete\",\"href\":\"\",\"icon\":\"layui-icon layui-icon-component\",\"type\":3,\"order_num\":0,\"pid\":13}', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/menu/add', 'POST', 1637109232);
INSERT INTO `rt_admin_oplog` VALUES (151, 1, 'admin用户登录', '{\"username\":\"admin\",\"captcha\":\"qwnd\"}', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/login/do', 'POST', 1637111011);
INSERT INTO `rt_admin_oplog` VALUES (152, 1, '编辑菜单', '{\"title\":\"添加配置\",\"pname\":\"系统设置\",\"route\":\"set/add\",\"href\":\"\",\"icon\":\"layui-icon layui-icon-at\",\"type\":2,\"order_num\":24,\"id\":28,\"pid\":13}', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/menu/edit', 'POST', 1637111056);
INSERT INTO `rt_admin_oplog` VALUES (153, 1, '编辑菜单', '{\"title\":\"配置列表\",\"pname\":\"系统设置\",\"route\":\"set/list\",\"href\":\"\",\"icon\":\"layui-icon layui-icon-transfer\",\"type\":2,\"order_num\":26,\"id\":30,\"pid\":13}', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/menu/edit', 'POST', 1637112427);
INSERT INTO `rt_admin_oplog` VALUES (154, 1, '编辑菜单', '{\"title\":\"删除配置\",\"pname\":\"系统设置\",\"route\":\"set/delete\",\"href\":\"\",\"icon\":\"layui-icon layui-icon-mute\",\"type\":2,\"order_num\":25,\"id\":29,\"pid\":13}', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/menu/edit', 'POST', 1637112783);
INSERT INTO `rt_admin_oplog` VALUES (155, 1, 'admin用户登录', '{\"username\":\"admin\",\"captcha\":\"cjpt\"}', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/login/do', 'POST', 1637116135);
INSERT INTO `rt_admin_oplog` VALUES (156, 1, 'admin用户登录', '{\"username\":\"admin\",\"captcha\":\"tvuz\"}', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/login/do', 'POST', 1637123746);
INSERT INTO `rt_admin_oplog` VALUES (157, 1, '编辑菜单', '{\"title\":\"系统设计\",\"pname\":\"系统管理\",\"route\":\"design\",\"href\":\"\",\"icon\":\"layui-icon layui-icon-fonts-code\",\"type\":0,\"order_num\":31,\"id\":35,\"pid\":2}', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/menu/edit', 'POST', 1637123851);
INSERT INTO `rt_admin_oplog` VALUES (158, 1, '添加菜单', '{\"title\":\"表单设计器\",\"pname\":\"35\",\"route\":\"design/form\",\"href\":\"view/design/form.html\",\"icon\":\"layui-icon layui-icon-template-1\",\"type\":1,\"order_num\":0,\"pid\":35}', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/menu/add', 'POST', 1637123948);
INSERT INTO `rt_admin_oplog` VALUES (159, 1, 'admin用户登录', '{\"username\":\"admin\",\"captcha\":\"vxkp\"}', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/login/do', 'POST', 1637139982);
INSERT INTO `rt_admin_oplog` VALUES (160, 1, '编辑菜单', '{\"title\":\"表单设计器\",\"pname\":\"系统设计\",\"route\":\"form/list\",\"href\":\"view/form/list.html\",\"icon\":\"layui-icon layui-icon-template-1\",\"type\":1,\"order_num\":0,\"id\":82,\"pid\":35}', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/menu/edit', 'POST', 1637141826);
INSERT INTO `rt_admin_oplog` VALUES (161, 1, 'admin用户登录', '{\"username\":\"admin\",\"captcha\":\"kq7u\"}', '::1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/93.0.4577.82 Safari/537.36', '/server/login/do', 'POST', 1637198112);
INSERT INTO `rt_admin_oplog` VALUES (162, 1, 'admin用户登录', '{\"username\":\"admin\",\"captcha\":\"lrzj\"}', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/login/do', 'POST', 1637201238);
INSERT INTO `rt_admin_oplog` VALUES (163, 1, '添加菜单', '{\"title\":\"添加表单\",\"pname\":\"82\",\"route\":\"form/add\",\"href\":\"view/form/add.html\",\"icon\":\"layui-icon layui-icon-auz\",\"type\":2,\"order_num\":0,\"pid\":82}', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/menu/add', 'POST', 1637201424);
INSERT INTO `rt_admin_oplog` VALUES (164, 1, 'admin用户登录', '{\"username\":\"admin\",\"captcha\":\"dglj\"}', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/login/do', 'POST', 1637205247);
INSERT INTO `rt_admin_oplog` VALUES (165, 1, '删除菜单', '{\"id\":81}', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/menu/del', 'POST', 1637205366);
INSERT INTO `rt_admin_oplog` VALUES (166, 1, '删除菜单', '{\"id\":80}', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/menu/del', 'POST', 1637205371);
INSERT INTO `rt_admin_oplog` VALUES (167, 1, '删除菜单', '{\"id\":79}', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/menu/del', 'POST', 1637205381);
INSERT INTO `rt_admin_oplog` VALUES (168, 1, '删除菜单', '{\"id\":78}', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/menu/del', 'POST', 1637205386);
INSERT INTO `rt_admin_oplog` VALUES (169, 1, '编辑菜单', '{\"title\":\"系统设置\",\"pname\":\"系统管理\",\"route\":\"set/cate\",\"href\":\"view/set/list.html\",\"icon\":\"layui-icon layui-icon-find-fill\",\"type\":1,\"order_num\":13,\"id\":13,\"pid\":2}', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/menu/edit', 'POST', 1637205401);
INSERT INTO `rt_admin_oplog` VALUES (170, 1, '删除菜单', '{\"id\":30}', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/menu/del', 'POST', 1637205491);
INSERT INTO `rt_admin_oplog` VALUES (171, 1, '编辑菜单', '{\"title\":\"编辑配置\",\"pname\":\"系统设置\",\"route\":\"set/edit\",\"href\":\"\",\"icon\":\"layui-icon layui-icon-export\",\"type\":2,\"order_num\":27,\"id\":31,\"pid\":13}', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/menu/edit', 'POST', 1637208797);
INSERT INTO `rt_admin_oplog` VALUES (172, 1, 'admin用户登录', '{\"username\":\"admin\",\"captcha\":\"bcsu\"}', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/login/do', 'POST', 1637208866);
INSERT INTO `rt_admin_oplog` VALUES (173, 1, '编辑菜单', '{\"title\":\"编辑配置前\",\"pname\":\"系统设置\",\"route\":\"set/editBefore\",\"href\":\"\",\"icon\":\"layui-icon layui-icon-rate-half\",\"type\":3,\"order_num\":28,\"id\":32,\"pid\":13}', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/menu/edit', 'POST', 1637208906);
INSERT INTO `rt_admin_oplog` VALUES (174, 1, '编辑菜单', '{\"title\":\"系统设置\",\"pname\":\"系统管理\",\"route\":\"set/list\",\"href\":\"view/set/list.html\",\"icon\":\"layui-icon layui-icon-find-fill\",\"type\":1,\"order_num\":13,\"id\":13,\"pid\":2}', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/menu/edit', 'POST', 1637208944);
INSERT INTO `rt_admin_oplog` VALUES (175, 1, '添加菜单', '{\"title\":\"设置配置可用\",\"pname\":\"13\",\"route\":\"set/enable\",\"href\":\"\",\"icon\":\"\",\"type\":3,\"order_num\":0,\"pid\":13}', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/menu/add', 'POST', 1637209991);
INSERT INTO `rt_admin_oplog` VALUES (176, 1, '设置配置可用', '{\"id\":12,\"status\":0}', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/set/enable', 'POST', 1637210042);
INSERT INTO `rt_admin_oplog` VALUES (177, 1, 'admin用户登录', '{\"username\":\"admin\",\"captcha\":\"kmbb\"}', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/login/do', 'POST', 1637212679);
INSERT INTO `rt_admin_oplog` VALUES (178, 1, '添加菜单', '{\"title\":\"添加表单前\",\"pname\":\"82\",\"route\":\"form/addBefore\",\"href\":\"\",\"icon\":\"layui-icon layui-icon-headset\",\"type\":3,\"order_num\":0,\"pid\":82}', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/menu/add', 'POST', 1637212896);
INSERT INTO `rt_admin_oplog` VALUES (179, 1, 'admin用户登录', '{\"username\":\"admin\",\"captcha\":\"7u8v\"}', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/login/do', 'POST', 1637222000);
INSERT INTO `rt_admin_oplog` VALUES (180, 1, 'admin用户登录', '{\"username\":\"admin\",\"captcha\":\"38dg\"}', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/login/do', 'POST', 1637225814);
INSERT INTO `rt_admin_oplog` VALUES (181, 1, 'admin用户登录', '{\"username\":\"admin\",\"captcha\":\"kbla\"}', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/login/do', 'POST', 1637229759);
INSERT INTO `rt_admin_oplog` VALUES (182, 1, '添加菜单', '{\"title\":\"设置配置前\",\"pname\":\"13\",\"route\":\"set/setBefore\",\"href\":\"\",\"icon\":\"layui-icon layui-icon-at\",\"type\":3,\"order_num\":0,\"pid\":13}', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/menu/add', 'POST', 1637232296);
INSERT INTO `rt_admin_oplog` VALUES (183, 1, '添加菜单', '{\"title\":\"设置配置\",\"pname\":\"13\",\"route\":\"set/setConf\",\"href\":\"\",\"icon\":\"layui-icon layui-icon-404\",\"type\":3,\"order_num\":0,\"pid\":13}', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/menu/add', 'POST', 1637232332);
INSERT INTO `rt_admin_oplog` VALUES (184, 1, 'admin用户登录', '{\"username\":\"admin\",\"captcha\":\"q27r\"}', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/login/do', 'POST', 1637278992);
INSERT INTO `rt_admin_oplog` VALUES (185, 1, '编辑菜单', '{\"title\":\"表单设计器\",\"pname\":\"2\",\"route\":\"form/list\",\"href\":\"view/form/list.html\",\"icon\":\"layui-icon layui-icon-template-1\",\"type\":1,\"order_num\":0,\"id\":82,\"pid\":2}', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/menu/edit', 'POST', 1637279183);
INSERT INTO `rt_admin_oplog` VALUES (186, 1, '编辑菜单', '{\"title\":\"数据库设计\",\"pname\":\"系统管理\",\"route\":\"db/list\",\"href\":\"db/list.html\",\"icon\":\"layui-icon layui-icon-layouts\",\"type\":1,\"order_num\":31,\"id\":35,\"pid\":2}', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/menu/edit', 'POST', 1637279223);
INSERT INTO `rt_admin_oplog` VALUES (187, 1, '编辑菜单', '{\"title\":\"系统字典\",\"pname\":\"系统管理\",\"route\":\"cate/index\",\"href\":\"\",\"icon\":\"layui-icon layui-icon-fonts-clear\",\"type\":1,\"order_num\":32,\"id\":36,\"pid\":2}', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/menu/edit', 'POST', 1637279260);
INSERT INTO `rt_admin_oplog` VALUES (188, 1, '编辑菜单', '{\"title\":\"表单设计器\",\"pname\":\"系统管理\",\"route\":\"form/list\",\"href\":\"view/form/list.html\",\"icon\":\"layui-icon layui-icon-template-1\",\"type\":1,\"order_num\":31,\"id\":82,\"pid\":2}', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/menu/edit', 'POST', 1637279285);
INSERT INTO `rt_admin_oplog` VALUES (189, 1, '编辑菜单', '{\"title\":\"系统字典\",\"pname\":\"系统管理\",\"route\":\"cate/index\",\"href\":\"\",\"icon\":\"layui-icon layui-icon-fonts-clear\",\"type\":1,\"order_num\":50,\"id\":36,\"pid\":2}', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/menu/edit', 'POST', 1637279295);
INSERT INTO `rt_admin_oplog` VALUES (190, 1, '编辑菜单', '{\"title\":\"数据库设计\",\"pname\":\"系统管理\",\"route\":\"db/list\",\"href\":\"view/db/list.html\",\"icon\":\"layui-icon layui-icon-layouts\",\"type\":1,\"order_num\":31,\"id\":35,\"pid\":2}', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/menu/edit', 'POST', 1637281307);
INSERT INTO `rt_admin_oplog` VALUES (191, 1, 'admin用户登录', '{\"username\":\"admin\",\"captcha\":\"yvjx\"}', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/login/do', 'POST', 1637282800);
INSERT INTO `rt_admin_oplog` VALUES (192, 1, 'admin用户登录', '{\"username\":\"admin\",\"captcha\":\"3f5x\"}', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/login/do', 'POST', 1637286423);
INSERT INTO `rt_admin_oplog` VALUES (193, 1, '编辑菜单', '{\"title\":\"数据表设计\",\"pname\":\"系统管理\",\"route\":\"db/list\",\"href\":\"view/db/list.html\",\"icon\":\"layui-icon layui-icon-layouts\",\"type\":1,\"order_num\":31,\"id\":35,\"pid\":2}', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/menu/edit', 'POST', 1637287584);
INSERT INTO `rt_admin_oplog` VALUES (194, 1, '添加菜单', '{\"title\":\"更新表缓存\",\"pname\":\"35\",\"route\":\"db/update\",\"href\":\"\",\"icon\":\"layui-icon layui-icon-refresh\",\"type\":1,\"order_num\":0,\"pid\":35}', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/menu/add', 'POST', 1637287821);
INSERT INTO `rt_admin_oplog` VALUES (195, 1, '编辑菜单', '{\"title\":\"更新表缓存\",\"pname\":\"数据表设计\",\"route\":\"db/update\",\"href\":\"\",\"icon\":\"layui-icon layui-icon-refresh\",\"type\":2,\"order_num\":0,\"id\":88,\"pid\":35}', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/menu/edit', 'POST', 1637287847);
INSERT INTO `rt_admin_oplog` VALUES (196, 1, 'admin用户登录', '{\"username\":\"admin\",\"captcha\":\"quvk\"}', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/login/do', 'POST', 1637293146);
INSERT INTO `rt_admin_oplog` VALUES (197, 1, '添加菜单', '{\"title\":\"备份数据\",\"pname\":\"35\",\"route\":\"db/backup\",\"href\":\"\",\"icon\":\"layui-icon layui-icon-templeate-1\",\"type\":2,\"order_num\":0,\"pid\":35}', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/menu/add', 'POST', 1637293324);
INSERT INTO `rt_admin_oplog` VALUES (198, 1, 'admin用户登录', '{\"username\":\"admin\",\"captcha\":\"uc9l\"}', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/login/do', 'POST', 1637296765);
INSERT INTO `rt_admin_oplog` VALUES (199, 1, '添加菜单', '{\"title\":\"还原数据列表\",\"pname\":\"35\",\"route\":\"db/backupFile\",\"href\":\"\",\"icon\":\"layui-icon layui-icon-list\",\"type\":2,\"order_num\":0,\"pid\":35}', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/menu/add', 'POST', 1637296812);
INSERT INTO `rt_admin_oplog` VALUES (200, 1, '添加菜单', '{\"title\":\"数据还原\",\"pname\":\"35\",\"route\":\"db/reback\",\"href\":\"\",\"icon\":\"layui-icon layui-icon-water\",\"type\":2,\"order_num\":0,\"pid\":35}', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/menu/add', 'POST', 1637297488);
INSERT INTO `rt_admin_oplog` VALUES (201, 1, '编辑菜单', '{\"title\":\"数据还原2\",\"pname\":\"数据表设计\",\"route\":\"db/reback\",\"href\":\"\",\"icon\":\"layui-icon layui-icon-water\",\"type\":2,\"order_num\":0,\"id\":91,\"pid\":35}', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/menu/edit', 'POST', 1637297619);
COMMIT;

-- ----------------------------
-- Table structure for rt_admin_viewlog
-- ----------------------------
DROP TABLE IF EXISTS `rt_admin_viewlog`;
CREATE TABLE `rt_admin_viewlog` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `admin_id` int(10) unsigned NOT NULL COMMENT '管理员账号',
  `log` varchar(255) CHARACTER SET utf8 NOT NULL COMMENT '日志名称',
  `ip` varchar(64) CHARACTER SET utf8 DEFAULT '' COMMENT 'IP地址',
  `agent` varchar(255) CHARACTER SET utf8 DEFAULT '' COMMENT '客户端信息',
  `url` varchar(255) CHARACTER SET utf8 DEFAULT NULL COMMENT '地址',
  `method` varchar(100) CHARACTER SET utf8 DEFAULT NULL COMMENT '方法',
  `addtime` int(10) unsigned DEFAULT '0' COMMENT '添加时间',
  `leavetime` int(10) unsigned DEFAULT '0' COMMENT '离开时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=209 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='管理员查看日志';

-- ----------------------------
-- Records of rt_admin_viewlog
-- ----------------------------
BEGIN;
INSERT INTO `rt_admin_viewlog` VALUES (1, 1, '菜单列表', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/menu/oplist', 'GET', 1636851040, 0);
INSERT INTO `rt_admin_viewlog` VALUES (2, 1, '添加或删除菜单', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/menu/one', 'GET', 1636851045, 0);
INSERT INTO `rt_admin_viewlog` VALUES (3, 1, '菜单列表', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/menu/oplist', 'GET', 1636851077, 1636851990);
INSERT INTO `rt_admin_viewlog` VALUES (4, 1, '添加或删除菜单', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/menu/one', 'GET', 1636851990, 1636852081);
INSERT INTO `rt_admin_viewlog` VALUES (5, 1, '菜单列表', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/menu/oplist', 'GET', 1636852081, 1636852084);
INSERT INTO `rt_admin_viewlog` VALUES (6, 1, '添加菜单', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/menu/one', 'GET', 1636852084, 1636852148);
INSERT INTO `rt_admin_viewlog` VALUES (7, 1, '编辑菜单', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/menu/one', 'GET', 1636852148, 1636852151);
INSERT INTO `rt_admin_viewlog` VALUES (8, 1, '添加菜单', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/menu/one', 'GET', 1636852151, 1636852168);
INSERT INTO `rt_admin_viewlog` VALUES (9, 1, '菜单列表', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/menu/oplist', 'GET', 1636852168, 1636941898);
INSERT INTO `rt_admin_viewlog` VALUES (10, 1, '角色列表', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/auth/list', 'GET', 1636941898, 1636941901);
INSERT INTO `rt_admin_viewlog` VALUES (11, 1, '菜单列表', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/menu/oplist', 'GET', 1636941901, 1636941908);
INSERT INTO `rt_admin_viewlog` VALUES (12, 1, '编辑菜单', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/menu/one', 'GET', 1636941908, 1636941924);
INSERT INTO `rt_admin_viewlog` VALUES (13, 1, '菜单列表', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/menu/oplist', 'GET', 1636941924, 1636941965);
INSERT INTO `rt_admin_viewlog` VALUES (14, 1, '编辑菜单', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/menu/one', 'GET', 1636941965, 1636941981);
INSERT INTO `rt_admin_viewlog` VALUES (15, 1, '菜单列表', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/menu/oplist', 'GET', 1636941981, 1636942013);
INSERT INTO `rt_admin_viewlog` VALUES (16, 1, '编辑菜单', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/menu/one', 'GET', 1636942013, 1636942018);
INSERT INTO `rt_admin_viewlog` VALUES (17, 1, '菜单列表', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/menu/oplist', 'GET', 1636942018, 1636942180);
INSERT INTO `rt_admin_viewlog` VALUES (18, 1, '管理员列表', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/admin/list', 'GET', 1636942180, 1636942471);
INSERT INTO `rt_admin_viewlog` VALUES (19, 1, '角色列表', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/auth/list', 'GET', 1636942471, 1636942473);
INSERT INTO `rt_admin_viewlog` VALUES (20, 1, '添加角色', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/auth/addTree', 'GET', 1636942473, 1636942478);
INSERT INTO `rt_admin_viewlog` VALUES (21, 1, '编辑角色', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/auth/beforEdit', 'GET', 1636942478, 1636942499);
INSERT INTO `rt_admin_viewlog` VALUES (22, 1, '添加角色', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/auth/addTree', 'GET', 1636942499, 1636942510);
INSERT INTO `rt_admin_viewlog` VALUES (23, 1, '编辑角色', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/auth/beforEdit', 'GET', 1636942510, 1636942771);
INSERT INTO `rt_admin_viewlog` VALUES (24, 1, '添加角色', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/auth/addTree', 'GET', 1636942771, 1636943618);
INSERT INTO `rt_admin_viewlog` VALUES (25, 1, '管理员列表', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/admin/list', 'GET', 1636943618, 1636943621);
INSERT INTO `rt_admin_viewlog` VALUES (26, 1, '添加角色', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/auth/addTree', 'GET', 1636943621, 1636944071);
INSERT INTO `rt_admin_viewlog` VALUES (27, 1, '菜单列表', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/menu/oplist', 'GET', 1636944071, 1636944077);
INSERT INTO `rt_admin_viewlog` VALUES (28, 1, '添加菜单', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/menu/one', 'GET', 1636944077, 1636944104);
INSERT INTO `rt_admin_viewlog` VALUES (29, 1, '菜单列表', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/menu/oplist', 'GET', 1636944104, 1636944444);
INSERT INTO `rt_admin_viewlog` VALUES (30, 1, '管理员列表', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/admin/list', 'GET', 1636944444, 1636947887);
INSERT INTO `rt_admin_viewlog` VALUES (31, 1, '菜单列表', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/menu/oplist', 'GET', 1636947887, 1636947903);
INSERT INTO `rt_admin_viewlog` VALUES (32, 1, '添加菜单', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/menu/one', 'GET', 1636947903, 1636947931);
INSERT INTO `rt_admin_viewlog` VALUES (33, 1, '菜单列表', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/menu/oplist', 'GET', 1636947931, 1636948396);
INSERT INTO `rt_admin_viewlog` VALUES (34, 1, '管理员列表', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/admin/list', 'GET', 1636948396, 1636950055);
INSERT INTO `rt_admin_viewlog` VALUES (35, 1, '菜单列表', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/menu/oplist', 'GET', 1636950055, 1636950060);
INSERT INTO `rt_admin_viewlog` VALUES (36, 1, '添加菜单', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/menu/one', 'GET', 1636950060, 1636950088);
INSERT INTO `rt_admin_viewlog` VALUES (37, 1, '菜单列表', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/menu/oplist', 'GET', 1636950088, 1636950206);
INSERT INTO `rt_admin_viewlog` VALUES (38, 1, '管理员列表', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/admin/list', 'GET', 1636950206, 1636958873);
INSERT INTO `rt_admin_viewlog` VALUES (39, 1, '菜单列表', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/menu/oplist', 'GET', 1636958873, 1636958880);
INSERT INTO `rt_admin_viewlog` VALUES (40, 1, '编辑菜单', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/menu/one', 'GET', 1636958880, 1636958889);
INSERT INTO `rt_admin_viewlog` VALUES (41, 1, '菜单列表', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/menu/oplist', 'GET', 1636958889, 1636958901);
INSERT INTO `rt_admin_viewlog` VALUES (42, 1, '管理员列表', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/admin/list', 'GET', 1636958901, 1636959492);
INSERT INTO `rt_admin_viewlog` VALUES (43, 1, '编辑菜单', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/menu/one', 'GET', 1636959492, 1636959517);
INSERT INTO `rt_admin_viewlog` VALUES (44, 1, '菜单列表', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/menu/oplist', 'GET', 1636959517, 1636959534);
INSERT INTO `rt_admin_viewlog` VALUES (45, 1, '编辑菜单', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/menu/one', 'GET', 1636959534, 1636959542);
INSERT INTO `rt_admin_viewlog` VALUES (46, 1, '菜单列表', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/menu/oplist', 'GET', 1636959542, 1636959557);
INSERT INTO `rt_admin_viewlog` VALUES (47, 1, '编辑菜单', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/menu/one', 'GET', 1636959557, 1636959580);
INSERT INTO `rt_admin_viewlog` VALUES (48, 1, '菜单列表', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/menu/oplist', 'GET', 1636959580, 1636959657);
INSERT INTO `rt_admin_viewlog` VALUES (49, 1, '管理员列表', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/admin/list', 'GET', 1636959657, 1636962361);
INSERT INTO `rt_admin_viewlog` VALUES (50, 1, '角色列表', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/auth/list', 'GET', 1636962361, 1636962387);
INSERT INTO `rt_admin_viewlog` VALUES (51, 1, '菜单列表', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/menu/oplist', 'GET', 1636962387, 1636962398);
INSERT INTO `rt_admin_viewlog` VALUES (52, 1, '添加菜单', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/menu/one', 'GET', 1636962398, 1636962429);
INSERT INTO `rt_admin_viewlog` VALUES (53, 1, '菜单列表', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/menu/oplist', 'GET', 1636962429, 1636962445);
INSERT INTO `rt_admin_viewlog` VALUES (54, 1, '管理员列表', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/admin/list', 'GET', 1636962445, 1636964747);
INSERT INTO `rt_admin_viewlog` VALUES (55, 1, '添加菜单', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/menu/one', 'GET', 1636964747, 1636964786);
INSERT INTO `rt_admin_viewlog` VALUES (56, 1, '菜单列表', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/menu/oplist', 'GET', 1636964786, 1636965961);
INSERT INTO `rt_admin_viewlog` VALUES (57, 1, '编辑菜单', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/menu/one', 'GET', 1636965960, 1636965966);
INSERT INTO `rt_admin_viewlog` VALUES (58, 1, '菜单列表', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/menu/oplist', 'GET', 1636965966, 1636965970);
INSERT INTO `rt_admin_viewlog` VALUES (59, 1, '添加菜单', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/menu/one', 'GET', 1636965970, 1636966011);
INSERT INTO `rt_admin_viewlog` VALUES (60, 1, '菜单列表', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/menu/oplist', 'GET', 1636966011, 1636966014);
INSERT INTO `rt_admin_viewlog` VALUES (61, 1, '添加菜单', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/menu/one', 'GET', 1636966014, 1636966045);
INSERT INTO `rt_admin_viewlog` VALUES (62, 1, '菜单列表', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/menu/oplist', 'GET', 1636966045, 1636966102);
INSERT INTO `rt_admin_viewlog` VALUES (63, 1, '管理员操作日志', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/logs/op', 'GET', 1636966102, 1636966221);
INSERT INTO `rt_admin_viewlog` VALUES (64, 1, '管理员列表', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/admin/list', 'GET', 1636966221, 1636966320);
INSERT INTO `rt_admin_viewlog` VALUES (65, 1, '管理员操作日志', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/logs/op', 'GET', 1636966320, 1636968670);
INSERT INTO `rt_admin_viewlog` VALUES (66, 1, '管理员行为日志', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/logs/view', 'GET', 1636968670, 1636969080);
INSERT INTO `rt_admin_viewlog` VALUES (67, 1, '系统错误日志', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/logs/err', 'GET', 1636969080, 1636969086);
INSERT INTO `rt_admin_viewlog` VALUES (68, 1, '管理员行为日志', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/logs/view', 'GET', 1636969086, 1636969131);
INSERT INTO `rt_admin_viewlog` VALUES (69, 1, '菜单列表', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/menu/oplist', 'GET', 1636969131, 1637020762);
INSERT INTO `rt_admin_viewlog` VALUES (70, 1, '管理员操作日志', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/logs/op', 'GET', 1637020762, 1637020765);
INSERT INTO `rt_admin_viewlog` VALUES (71, 1, '管理员行为日志', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/logs/view', 'GET', 1637020765, 1637020768);
INSERT INTO `rt_admin_viewlog` VALUES (72, 1, '系统错误日志', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/logs/err', 'GET', 1637020768, 1637023322);
INSERT INTO `rt_admin_viewlog` VALUES (73, 1, '菜单列表', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/menu/oplist', 'GET', 1637023322, 1637023329);
INSERT INTO `rt_admin_viewlog` VALUES (74, 1, '编辑菜单', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/menu/one', 'GET', 1637023329, 1637023335);
INSERT INTO `rt_admin_viewlog` VALUES (75, 1, '菜单列表', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/menu/oplist', 'GET', 1637023335, 1637023388);
INSERT INTO `rt_admin_viewlog` VALUES (76, 1, '编辑菜单', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/menu/one', 'GET', 1637023388, 1637023402);
INSERT INTO `rt_admin_viewlog` VALUES (77, 1, '菜单列表', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/menu/oplist', 'GET', 1637023402, 1637028911);
INSERT INTO `rt_admin_viewlog` VALUES (78, 1, '添加菜单', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/menu/one', 'GET', 1637028911, 1637028919);
INSERT INTO `rt_admin_viewlog` VALUES (79, 1, '菜单列表', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/menu/oplist', 'GET', 1637028919, 1637029248);
INSERT INTO `rt_admin_viewlog` VALUES (80, 1, '添加菜单', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/menu/one', 'GET', 1637029248, 1637029256);
INSERT INTO `rt_admin_viewlog` VALUES (81, 1, '菜单列表', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/menu/oplist', 'GET', 1637029256, 1637029590);
INSERT INTO `rt_admin_viewlog` VALUES (82, 1, '添加菜单', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/menu/one', 'GET', 1637029590, 1637029596);
INSERT INTO `rt_admin_viewlog` VALUES (83, 1, '菜单列表', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/menu/oplist', 'GET', 1637029596, 1637030964);
INSERT INTO `rt_admin_viewlog` VALUES (84, 1, '添加菜单', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/menu/one', 'GET', 1637030964, 1637030982);
INSERT INTO `rt_admin_viewlog` VALUES (85, 1, '菜单列表', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/menu/oplist', 'GET', 1637030982, 1637031466);
INSERT INTO `rt_admin_viewlog` VALUES (86, 1, '添加菜单', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/menu/one', 'GET', 1637031466, 1637031472);
INSERT INTO `rt_admin_viewlog` VALUES (87, 1, '菜单列表', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/menu/oplist', 'GET', 1637031472, 1637031479);
INSERT INTO `rt_admin_viewlog` VALUES (88, 1, '添加菜单', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/menu/one', 'GET', 1637031479, 1637031483);
INSERT INTO `rt_admin_viewlog` VALUES (89, 1, '菜单列表', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/menu/oplist', 'GET', 1637031483, 1637031495);
INSERT INTO `rt_admin_viewlog` VALUES (90, 1, '添加菜单', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/menu/one', 'GET', 1637031495, 1637031501);
INSERT INTO `rt_admin_viewlog` VALUES (91, 1, '菜单列表', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/menu/oplist', 'GET', 1637031501, 1637031530);
INSERT INTO `rt_admin_viewlog` VALUES (92, 1, '添加菜单', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/menu/one', 'GET', 1637031530, 1637031573);
INSERT INTO `rt_admin_viewlog` VALUES (93, 1, '菜单列表', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/menu/oplist', 'GET', 1637031573, 1637031992);
INSERT INTO `rt_admin_viewlog` VALUES (94, 1, '添加菜单', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/menu/one', 'GET', 1637031992, 1637032000);
INSERT INTO `rt_admin_viewlog` VALUES (95, 1, '菜单列表', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/menu/oplist', 'GET', 1637032000, 1637033820);
INSERT INTO `rt_admin_viewlog` VALUES (96, 1, '添加菜单', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/menu/one', 'GET', 1637033820, 1637034083);
INSERT INTO `rt_admin_viewlog` VALUES (97, 1, '菜单列表', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/menu/oplist', 'GET', 1637034083, 1637034302);
INSERT INTO `rt_admin_viewlog` VALUES (98, 1, '编辑菜单', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/menu/one', 'GET', 1637034302, 1637034309);
INSERT INTO `rt_admin_viewlog` VALUES (99, 1, '菜单列表', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/menu/oplist', 'GET', 1637034309, 1637034320);
INSERT INTO `rt_admin_viewlog` VALUES (100, 1, '编辑菜单', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/menu/one', 'GET', 1637034320, 1637034432);
INSERT INTO `rt_admin_viewlog` VALUES (101, 1, '菜单列表', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/menu/oplist', 'GET', 1637034432, 1637034521);
INSERT INTO `rt_admin_viewlog` VALUES (102, 1, '编辑菜单', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/menu/one', 'GET', 1637034521, 1637034531);
INSERT INTO `rt_admin_viewlog` VALUES (103, 1, '添加菜单', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/menu/one', 'GET', 1637034531, 1637034627);
INSERT INTO `rt_admin_viewlog` VALUES (104, 1, '角色列表', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/auth/list', 'GET', 1637034627, 1637036272);
INSERT INTO `rt_admin_viewlog` VALUES (105, 1, '添加角色', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/auth/addTree', 'GET', 1637036272, 1637036281);
INSERT INTO `rt_admin_viewlog` VALUES (106, 1, '角色列表', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/auth/list', 'GET', 1637036281, 1637036288);
INSERT INTO `rt_admin_viewlog` VALUES (107, 1, '编辑角色', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/auth/beforEdit', 'GET', 1637036288, 1637036876);
INSERT INTO `rt_admin_viewlog` VALUES (108, 1, '菜单列表', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/menu/oplist', 'GET', 1637036876, 1637036909);
INSERT INTO `rt_admin_viewlog` VALUES (109, 1, '添加菜单', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/menu/one', 'GET', 1637036909, 1637037068);
INSERT INTO `rt_admin_viewlog` VALUES (110, 1, '编辑角色', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/auth/beforEdit', 'GET', 1637037068, 1637037071);
INSERT INTO `rt_admin_viewlog` VALUES (111, 1, '角色列表', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/auth/list', 'GET', 1637037071, 1637037683);
INSERT INTO `rt_admin_viewlog` VALUES (112, 1, '管理员列表', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/admin/list', 'GET', 1637037683, 1637038175);
INSERT INTO `rt_admin_viewlog` VALUES (113, 1, '添加管理员', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/admin/addBefore', 'GET', 1637038175, 1637038189);
INSERT INTO `rt_admin_viewlog` VALUES (114, 1, '管理员列表', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/admin/list', 'GET', 1637038189, 1637038295);
INSERT INTO `rt_admin_viewlog` VALUES (115, 1, '编辑管理员', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/admin/editBefore', 'GET', 1637038295, 1637038492);
INSERT INTO `rt_admin_viewlog` VALUES (116, 1, '管理员列表', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/admin/list', 'GET', 1637038492, 1637038918);
INSERT INTO `rt_admin_viewlog` VALUES (117, 1, '编辑管理员', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/admin/editBefore', 'GET', 1637038918, 1637039222);
INSERT INTO `rt_admin_viewlog` VALUES (118, 1, '菜单列表', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/menu/oplist', 'GET', 1637039222, 1637039440);
INSERT INTO `rt_admin_viewlog` VALUES (119, 1, '角色列表', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/auth/list', 'GET', 1637039440, 1637039577);
INSERT INTO `rt_admin_viewlog` VALUES (120, 1, '菜单列表', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/menu/oplist', 'GET', 1637039577, 1637039581);
INSERT INTO `rt_admin_viewlog` VALUES (121, 1, '管理员列表', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/admin/list', 'GET', 1637039581, 1637039585);
INSERT INTO `rt_admin_viewlog` VALUES (122, 1, '编辑管理员', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/admin/editBefore', 'GET', 1637039585, 1637039790);
INSERT INTO `rt_admin_viewlog` VALUES (123, 1, '管理员列表', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/admin/list', 'GET', 1637039790, 1637039793);
INSERT INTO `rt_admin_viewlog` VALUES (124, 1, '编辑管理员', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/admin/editBefore', 'GET', 1637039793, 1637039796);
INSERT INTO `rt_admin_viewlog` VALUES (125, 1, '管理员列表', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/admin/list', 'GET', 1637039796, 1637040178);
INSERT INTO `rt_admin_viewlog` VALUES (126, 1, '添加管理员', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/admin/addBefore', 'GET', 1637040177, 1637040196);
INSERT INTO `rt_admin_viewlog` VALUES (127, 1, '管理员列表', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/admin/list', 'GET', 1637040196, 1637040201);
INSERT INTO `rt_admin_viewlog` VALUES (128, 1, '编辑管理员', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/admin/editBefore', 'GET', 1637040201, 1637040203);
INSERT INTO `rt_admin_viewlog` VALUES (129, 1, '管理员列表', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/admin/list', 'GET', 1637040203, 1637040231);
INSERT INTO `rt_admin_viewlog` VALUES (130, 1, '管理员操作日志', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/logs/op', 'GET', 1637040231, 1637052521);
INSERT INTO `rt_admin_viewlog` VALUES (131, 1, '管理员行为日志', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/logs/view', 'GET', 1637052521, 1637052525);
INSERT INTO `rt_admin_viewlog` VALUES (132, 1, '系统错误日志', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/logs/err', 'GET', 1637052525, 1637055527);
INSERT INTO `rt_admin_viewlog` VALUES (133, 1, '菜单列表', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/menu/oplist', 'GET', 1637055527, 1637055543);
INSERT INTO `rt_admin_viewlog` VALUES (134, 1, '添加菜单', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/menu/one', 'GET', 1637055543, 1637055590);
INSERT INTO `rt_admin_viewlog` VALUES (135, 1, '菜单列表', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/menu/oplist', 'GET', 1637055590, 1637055649);
INSERT INTO `rt_admin_viewlog` VALUES (136, 1, '编辑菜单', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/menu/one', 'GET', 1637055649, 1637055959);
INSERT INTO `rt_admin_viewlog` VALUES (137, 1, '管理员列表', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/admin/list', 'GET', 1637055959, 1637055965);
INSERT INTO `rt_admin_viewlog` VALUES (138, 1, '添加管理员', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/admin/addBefore', 'GET', 1637055965, 1637107906);
INSERT INTO `rt_admin_viewlog` VALUES (139, 1, '菜单列表', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/menu/oplist', 'GET', 1637107906, 1637107920);
INSERT INTO `rt_admin_viewlog` VALUES (140, 1, '编辑菜单', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/menu/one', 'GET', 1637107920, 1637107949);
INSERT INTO `rt_admin_viewlog` VALUES (141, 1, '添加菜单', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/menu/one', 'GET', 1637107949, 1637108007);
INSERT INTO `rt_admin_viewlog` VALUES (142, 1, '菜单列表', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/menu/oplist', 'GET', 1637108007, 1637108024);
INSERT INTO `rt_admin_viewlog` VALUES (143, 1, '添加菜单', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/menu/one', 'GET', 1637108023, 1637108058);
INSERT INTO `rt_admin_viewlog` VALUES (144, 1, '菜单列表', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/menu/oplist', 'GET', 1637108058, 1637109212);
INSERT INTO `rt_admin_viewlog` VALUES (145, 1, '添加菜单', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/menu/one', 'GET', 1637109212, 1637109232);
INSERT INTO `rt_admin_viewlog` VALUES (146, 1, '菜单列表', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/menu/oplist', 'GET', 1637109232, 1637111043);
INSERT INTO `rt_admin_viewlog` VALUES (147, 1, '编辑菜单', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/menu/one', 'GET', 1637111043, 1637111056);
INSERT INTO `rt_admin_viewlog` VALUES (148, 1, '菜单列表', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/menu/oplist', 'GET', 1637111056, 1637112409);
INSERT INTO `rt_admin_viewlog` VALUES (149, 1, '编辑菜单', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/menu/one', 'GET', 1637112409, 1637112427);
INSERT INTO `rt_admin_viewlog` VALUES (150, 1, '菜单列表', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/menu/oplist', 'GET', 1637112427, 1637112773);
INSERT INTO `rt_admin_viewlog` VALUES (151, 1, '编辑菜单', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/menu/one', 'GET', 1637112773, 1637112783);
INSERT INTO `rt_admin_viewlog` VALUES (152, 1, '菜单列表', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/menu/oplist', 'GET', 1637112783, 1637123825);
INSERT INTO `rt_admin_viewlog` VALUES (153, 1, '编辑菜单', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/menu/one', 'GET', 1637123825, 1637123851);
INSERT INTO `rt_admin_viewlog` VALUES (154, 1, '菜单列表', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/menu/oplist', 'GET', 1637123851, 1637123865);
INSERT INTO `rt_admin_viewlog` VALUES (155, 1, '添加菜单', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/menu/one', 'GET', 1637123865, 1637123948);
INSERT INTO `rt_admin_viewlog` VALUES (156, 1, '菜单列表', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/menu/oplist', 'GET', 1637123948, 1637141805);
INSERT INTO `rt_admin_viewlog` VALUES (157, 1, '编辑菜单', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/menu/one', 'GET', 1637141805, 1637141826);
INSERT INTO `rt_admin_viewlog` VALUES (158, 1, '菜单列表', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/menu/oplist', 'GET', 1637141826, 1637201389);
INSERT INTO `rt_admin_viewlog` VALUES (159, 1, '添加菜单', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/menu/one', 'GET', 1637201388, 1637201424);
INSERT INTO `rt_admin_viewlog` VALUES (160, 1, '菜单列表', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/menu/oplist', 'GET', 1637201424, 1637205392);
INSERT INTO `rt_admin_viewlog` VALUES (161, 1, '编辑菜单', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/menu/one', 'GET', 1637205392, 1637205401);
INSERT INTO `rt_admin_viewlog` VALUES (162, 1, '菜单列表', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/menu/oplist', 'GET', 1637205401, 1637205485);
INSERT INTO `rt_admin_viewlog` VALUES (163, 1, '编辑菜单', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/menu/one', 'GET', 1637205485, 1637208734);
INSERT INTO `rt_admin_viewlog` VALUES (164, 1, '菜单列表', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/menu/oplist', 'GET', 1637208734, 1637208784);
INSERT INTO `rt_admin_viewlog` VALUES (165, 1, '编辑菜单', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/menu/one', 'GET', 1637208784, 1637208797);
INSERT INTO `rt_admin_viewlog` VALUES (166, 1, '菜单列表', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/menu/oplist', 'GET', 1637208797, 1637208816);
INSERT INTO `rt_admin_viewlog` VALUES (167, 1, '编辑菜单', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/menu/one', 'GET', 1637208816, 1637208881);
INSERT INTO `rt_admin_viewlog` VALUES (168, 1, '菜单列表', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/menu/oplist', 'GET', 1637208881, 1637208885);
INSERT INTO `rt_admin_viewlog` VALUES (169, 1, '编辑菜单', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/menu/one', 'GET', 1637208885, 1637208906);
INSERT INTO `rt_admin_viewlog` VALUES (170, 1, '菜单列表', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/menu/oplist', 'GET', 1637208906, 1637208936);
INSERT INTO `rt_admin_viewlog` VALUES (171, 1, '编辑菜单', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/menu/one', 'GET', 1637208936, 1637208944);
INSERT INTO `rt_admin_viewlog` VALUES (172, 1, '菜单列表', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/menu/oplist', 'GET', 1637208944, 1637209956);
INSERT INTO `rt_admin_viewlog` VALUES (173, 1, '添加菜单', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/menu/one', 'GET', 1637209956, 1637209992);
INSERT INTO `rt_admin_viewlog` VALUES (174, 1, '菜单列表', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/menu/oplist', 'GET', 1637209992, 1637212862);
INSERT INTO `rt_admin_viewlog` VALUES (175, 1, '添加菜单', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/menu/one', 'GET', 1637212862, 1637212896);
INSERT INTO `rt_admin_viewlog` VALUES (176, 1, '菜单列表', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/menu/oplist', 'GET', 1637212896, 1637232272);
INSERT INTO `rt_admin_viewlog` VALUES (177, 1, '编辑菜单', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/menu/one', 'GET', 1637232272, 1637232277);
INSERT INTO `rt_admin_viewlog` VALUES (178, 1, '添加菜单', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/menu/one', 'GET', 1637232277, 1637232296);
INSERT INTO `rt_admin_viewlog` VALUES (179, 1, '菜单列表', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/menu/oplist', 'GET', 1637232296, 1637232300);
INSERT INTO `rt_admin_viewlog` VALUES (180, 1, '添加菜单', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/menu/one', 'GET', 1637232300, 1637232332);
INSERT INTO `rt_admin_viewlog` VALUES (181, 1, '菜单列表', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/menu/oplist', 'GET', 1637232332, 1637279173);
INSERT INTO `rt_admin_viewlog` VALUES (182, 1, '编辑菜单', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/menu/one', 'GET', 1637279173, 1637279183);
INSERT INTO `rt_admin_viewlog` VALUES (183, 1, '菜单列表', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/menu/oplist', 'GET', 1637279183, 1637279193);
INSERT INTO `rt_admin_viewlog` VALUES (184, 1, '编辑菜单', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/menu/one', 'GET', 1637279193, 1637279223);
INSERT INTO `rt_admin_viewlog` VALUES (185, 1, '菜单列表', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/menu/oplist', 'GET', 1637279223, 1637279251);
INSERT INTO `rt_admin_viewlog` VALUES (186, 1, '编辑菜单', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/menu/one', 'GET', 1637279251, 1637279260);
INSERT INTO `rt_admin_viewlog` VALUES (187, 1, '菜单列表', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/menu/oplist', 'GET', 1637279260, 1637279279);
INSERT INTO `rt_admin_viewlog` VALUES (188, 1, '编辑菜单', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/menu/one', 'GET', 1637279279, 1637279285);
INSERT INTO `rt_admin_viewlog` VALUES (189, 1, '菜单列表', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/menu/oplist', 'GET', 1637279285, 1637279291);
INSERT INTO `rt_admin_viewlog` VALUES (190, 1, '编辑菜单', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/menu/one', 'GET', 1637279291, 1637279295);
INSERT INTO `rt_admin_viewlog` VALUES (191, 1, '菜单列表', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/menu/oplist', 'GET', 1637279295, 1637281301);
INSERT INTO `rt_admin_viewlog` VALUES (192, 1, '编辑菜单', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/menu/one', 'GET', 1637281301, 1637281307);
INSERT INTO `rt_admin_viewlog` VALUES (193, 1, '菜单列表', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/menu/oplist', 'GET', 1637281307, 1637287504);
INSERT INTO `rt_admin_viewlog` VALUES (194, 1, '添加菜单', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/menu/one', 'GET', 1637287504, 1637287574);
INSERT INTO `rt_admin_viewlog` VALUES (195, 1, '编辑菜单', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/menu/one', 'GET', 1637287574, 1637287584);
INSERT INTO `rt_admin_viewlog` VALUES (196, 1, '菜单列表', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/menu/oplist', 'GET', 1637287584, 1637287791);
INSERT INTO `rt_admin_viewlog` VALUES (197, 1, '添加菜单', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/menu/one', 'GET', 1637287791, 1637287821);
INSERT INTO `rt_admin_viewlog` VALUES (198, 1, '菜单列表', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/menu/oplist', 'GET', 1637287821, 1637287840);
INSERT INTO `rt_admin_viewlog` VALUES (199, 1, '编辑菜单', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/menu/one', 'GET', 1637287840, 1637287847);
INSERT INTO `rt_admin_viewlog` VALUES (200, 1, '菜单列表', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/menu/oplist', 'GET', 1637287847, 1637293302);
INSERT INTO `rt_admin_viewlog` VALUES (201, 1, '添加菜单', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/menu/one', 'GET', 1637293302, 1637293324);
INSERT INTO `rt_admin_viewlog` VALUES (202, 1, '菜单列表', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/menu/oplist', 'GET', 1637293324, 1637296780);
INSERT INTO `rt_admin_viewlog` VALUES (203, 1, '添加菜单', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/menu/one', 'GET', 1637296780, 1637296812);
INSERT INTO `rt_admin_viewlog` VALUES (204, 1, '菜单列表', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/menu/oplist', 'GET', 1637296812, 1637297467);
INSERT INTO `rt_admin_viewlog` VALUES (205, 1, '添加菜单', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/menu/one', 'GET', 1637297467, 1637297488);
INSERT INTO `rt_admin_viewlog` VALUES (206, 1, '菜单列表', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/menu/oplist', 'GET', 1637297488, 1637297552);
INSERT INTO `rt_admin_viewlog` VALUES (207, 1, '编辑菜单', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/menu/one', 'GET', 1637297552, 1637297619);
INSERT INTO `rt_admin_viewlog` VALUES (208, 1, '菜单列表', '::ffff:127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0', '/server/menu/oplist', 'GET', 1637297619, 0);
COMMIT;

-- ----------------------------
-- Table structure for rt_area
-- ----------------------------
DROP TABLE IF EXISTS `rt_area`;
CREATE TABLE `rt_area` (
  `area_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '区域名称',
  `group_id` int(10) unsigned DEFAULT '0' COMMENT '集团id',
  `address` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '地址',
  `city_id` int(10) DEFAULT NULL COMMENT '上级城市id',
  PRIMARY KEY (`area_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='区域表';

-- ----------------------------
-- Records of rt_area
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for rt_article
-- ----------------------------
DROP TABLE IF EXISTS `rt_article`;
CREATE TABLE `rt_article` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `category_id` int(11) NOT NULL COMMENT '分类:id:title',
  `title` varchar(128) CHARACTER SET utf8 NOT NULL COMMENT '文章名',
  `desc_content` varchar(255) CHARACTER SET utf8 NOT NULL DEFAULT '',
  `image` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `content` text CHARACTER SET utf8 NOT NULL COMMENT '内容',
  `author` varchar(32) CHARACTER SET utf8 NOT NULL COMMENT '作者:id:name',
  `show_switch` tinyint(1) NOT NULL DEFAULT '1' COMMENT '展示:1=展示,0=隐藏',
  `show_time` datetime DEFAULT NULL,
  `up_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `add_time` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='文章';

-- ----------------------------
-- Records of rt_article
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for rt_cate
-- ----------------------------
DROP TABLE IF EXISTS `rt_cate`;
CREATE TABLE `rt_cate` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `pid` int(10) DEFAULT '0' COMMENT '上级id',
  `sid` int(10) DEFAULT '0' COMMENT '系统类型id',
  `fid` int(10) DEFAULT NULL COMMENT '系统分类标志',
  `lid` int(10) DEFAULT '0' COMMENT '层级',
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '名称',
  `desc` text COLLATE utf8mb4_unicode_ci COMMENT '描述',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='系统分类表';

-- ----------------------------
-- Records of rt_cate
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for rt_category
-- ----------------------------
DROP TABLE IF EXISTS `rt_category`;
CREATE TABLE `rt_category` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `name` varchar(255) CHARACTER SET utf8 NOT NULL COMMENT '分类名称',
  `status` tinyint(2) DEFAULT '0' COMMENT '是否使用，预留',
  `ctype` tinyint(3) DEFAULT '1' COMMENT '分类类型 1新闻2账户类型3账户日志来源',
  `desc` text CHARACTER SET utf8 COMMENT '其他附加配置',
  `flag` int(10) NOT NULL DEFAULT '0' COMMENT '分类标志，同一分类不能重复',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='文章分类';

-- ----------------------------
-- Records of rt_category
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for rt_city
-- ----------------------------
DROP TABLE IF EXISTS `rt_city`;
CREATE TABLE `rt_city` (
  `city_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '城市名称',
  `group_id` int(10) unsigned DEFAULT '0' COMMENT '集团id',
  `address` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '地址',
  `company_id` int(10) DEFAULT NULL COMMENT '上级公司id',
  PRIMARY KEY (`city_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='城市表';

-- ----------------------------
-- Records of rt_city
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for rt_company
-- ----------------------------
DROP TABLE IF EXISTS `rt_company`;
CREATE TABLE `rt_company` (
  `company_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '公司名称',
  `group_id` int(10) unsigned DEFAULT '0' COMMENT '集团id',
  `address` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '地址',
  `parent_id` int(10) DEFAULT NULL COMMENT '上级公司id',
  PRIMARY KEY (`company_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='公司表';

-- ----------------------------
-- Records of rt_company
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for rt_config
-- ----------------------------
DROP TABLE IF EXISTS `rt_config`;
CREATE TABLE `rt_config` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `key` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `name` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `val` text COLLATE utf8mb4_unicode_ci,
  `isrun` tinyint(2) DEFAULT '1',
  `param` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `key` (`key`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='系统配置表';

-- ----------------------------
-- Records of rt_config
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for rt_crons
-- ----------------------------
DROP TABLE IF EXISTS `rt_crons`;
CREATE TABLE `rt_crons` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '任务名称',
  `interval` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '执行间隔 毫秒为单位',
  `immediate` tinyint(1) DEFAULT '1' COMMENT '是否立即执行',
  `handle` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '执行路径',
  `enable` tinyint(1) DEFAULT '1' COMMENT '是否开启',
  `type` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'one执行一次all一直执行',
  `addtime` int(10) DEFAULT '0' COMMENT '添加时间',
  `uptime` bigint(20) DEFAULT '0' COMMENT '更新时间',
  `nexttime` bigint(20) DEFAULT '0' COMMENT '下次执行时间',
  `runtime` bigint(20) DEFAULT '0' COMMENT '每次执行的时间',
  `runtype` tinyint(1) DEFAULT '0' COMMENT '执行类型0为间隔执行1为系统执行crontab',
  `cron` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Runtype为1时不能为空 如0 */1 * * *',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `handle` (`handle`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='系统计划任务表';

-- ----------------------------
-- Records of rt_crons
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for rt_error
-- ----------------------------
DROP TABLE IF EXISTS `rt_error`;
CREATE TABLE `rt_error` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `msg` text COLLATE utf8mb4_unicode_ci,
  `addtime` int(10) unsigned DEFAULT '0',
  `admin_id` int(10) unsigned DEFAULT '0',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='系统错误日志表';

-- ----------------------------
-- Records of rt_error
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for rt_form
-- ----------------------------
DROP TABLE IF EXISTS `rt_form`;
CREATE TABLE `rt_form` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `key` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `data` text COLLATE utf8mb4_unicode_ci,
  `get_url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `post_url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `form_path` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `add_time` int(10) unsigned DEFAULT '0' COMMENT '添加时间',
  `link_id` int(10) unsigned DEFAULT '0' COMMENT '回写id',
  `link_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '0' COMMENT '回写表名',
  `link_field` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '回写字段',
  `params_get` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `params_post` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='系统表单';

-- ----------------------------
-- Records of rt_form
-- ----------------------------
BEGIN;
INSERT INTO `rt_form` VALUES (9, 'mysql', 'mysql', '[{\"id\":\"host\",\"index\":0,\"label\":\"数据库地址\",\"tag\":\"input\",\"tagIcon\":\"input\",\"placeholder\":\"请输入数据库地址\",\"defaultValue\":null,\"labelWidth\":125,\"width\":\"100%\",\"clearable\":true,\"maxlength\":null,\"showWordLimit\":false,\"readonly\":false,\"disabled\":false,\"required\":true,\"expression\":\"\",\"document\":\"\"},{\"id\":\"port\",\"index\":1,\"label\":\"端口号\",\"tag\":\"input\",\"tagIcon\":\"input\",\"placeholder\":\"请输入端口号\",\"defaultValue\":\"3306\",\"labelWidth\":125,\"width\":\"100%\",\"clearable\":true,\"maxlength\":null,\"showWordLimit\":false,\"readonly\":false,\"disabled\":false,\"required\":true,\"expression\":\"number\",\"document\":\"\"},{\"id\":\"input_2\",\"index\":2,\"label\":\"单行文本\",\"tag\":\"input\",\"tagIcon\":\"input\",\"placeholder\":\"请输入\",\"defaultValue\":null,\"labelWidth\":110,\"width\":\"100%\",\"clearable\":true,\"maxlength\":null,\"showWordLimit\":false,\"readonly\":false,\"disabled\":false,\"required\":true,\"expression\":\"\",\"document\":\"\"},{\"id\":\"textarea_1\",\"index\":3,\"label\":\"多行文本\",\"tag\":\"textarea\",\"tagIcon\":\"textarea\",\"placeholder\":\"请输入\",\"defaultValue\":null,\"width\":\"100%\",\"readonly\":false,\"disabled\":false,\"required\":true,\"document\":\"\"}]', 'set/setBefore', 'set/setConf', 'set/config/mysql', 0, 9, 'set', 'id', 'conftype|mysql', 'conftype|mysql');
INSERT INTO `rt_form` VALUES (10, 'test', '测试', '[]', '', '', '', 0, 0, '0', NULL, '', '');
INSERT INTO `rt_form` VALUES (11, 'redis', 'redis', '[]', 'set/setBefore', 'set/setConf', 'set/config/redis', 0, 10, 'set', 'id', 'conftype|redis', 'conftype|redis');
COMMIT;

-- ----------------------------
-- Table structure for rt_group
-- ----------------------------
DROP TABLE IF EXISTS `rt_group`;
CREATE TABLE `rt_group` (
  `group_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '集团名称',
  `address` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '集团地址',
  `add_time` int(10) unsigned DEFAULT '0' COMMENT '添加时间',
  `manager_id` int(10) unsigned DEFAULT '0' COMMENT '主管理员id',
  `admin_id` int(10) DEFAULT NULL COMMENT '审核或添加管理员id',
  `store_num` int(10) unsigned DEFAULT '0' COMMENT '可控门店数',
  `end_time` int(10) unsigned DEFAULT '0' COMMENT '结束时间',
  `start_time` int(10) unsigned DEFAULT '0' COMMENT '开始时间',
  `status` tinyint(2) unsigned DEFAULT '0' COMMENT '0正常1过期2禁用3删除',
  PRIMARY KEY (`group_id`),
  UNIQUE KEY `name` (`name`) USING HASH
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='集团表';

-- ----------------------------
-- Records of rt_group
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for rt_group_map
-- ----------------------------
DROP TABLE IF EXISTS `rt_group_map`;
CREATE TABLE `rt_group_map` (
  `cate_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `group_id` int(10) unsigned DEFAULT '0' COMMENT '集团id',
  `parent_id` int(10) DEFAULT NULL COMMENT '上级id',
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '名称',
  `type` tinyint(2) unsigned DEFAULT '0' COMMENT '类型0公司1城市2区域3门店',
  `manager_id` int(10) DEFAULT NULL COMMENT '操作员id',
  `add_time` int(10) unsigned DEFAULT NULL COMMENT '添加时间',
  PRIMARY KEY (`cate_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='集团下属关系表';

-- ----------------------------
-- Records of rt_group_map
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for rt_group_note
-- ----------------------------
DROP TABLE IF EXISTS `rt_group_note`;
CREATE TABLE `rt_group_note` (
  `note_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '标题',
  `content` text COLLATE utf8mb4_unicode_ci COMMENT '内容',
  `group_id` int(10) DEFAULT NULL COMMENT '集团id',
  `add_time` int(10) unsigned DEFAULT '0' COMMENT '添加时间',
  `manager_id` int(10) unsigned DEFAULT '0' COMMENT '添加人',
  PRIMARY KEY (`note_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='集团公告表';

-- ----------------------------
-- Records of rt_group_note
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for rt_manager_change
-- ----------------------------
DROP TABLE IF EXISTS `rt_manager_change`;
CREATE TABLE `rt_manager_change` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `manager_id` int(10) unsigned DEFAULT NULL COMMENT '员工id',
  `type` int(255) unsigned DEFAULT '1' COMMENT '类型1申请转店2授权转店3禁止',
  `msg` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '标记',
  `add_time` int(10) unsigned DEFAULT NULL COMMENT '时间',
  `mgr_id` int(10) DEFAULT NULL COMMENT '审核人',
  `update_time` int(10) unsigned DEFAULT '0' COMMENT '审核时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='员工转店记录';

-- ----------------------------
-- Records of rt_manager_change
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for rt_manager_log
-- ----------------------------
DROP TABLE IF EXISTS `rt_manager_log`;
CREATE TABLE `rt_manager_log` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `manager_id` int(10) unsigned NOT NULL COMMENT '管理员账号',
  `log` varchar(255) CHARACTER SET utf8 NOT NULL COMMENT '日志名称',
  `data` text CHARACTER SET utf8 COMMENT '返回记录',
  `ip` varchar(64) CHARACTER SET utf8 DEFAULT '' COMMENT 'IP地址',
  `agent` varchar(255) CHARACTER SET utf8 DEFAULT '' COMMENT '客户端信息',
  `url` varchar(255) CHARACTER SET utf8 DEFAULT NULL COMMENT '地址',
  `method` varchar(100) CHARACTER SET utf8 DEFAULT NULL COMMENT '方法',
  `addtime` int(10) unsigned DEFAULT '0' COMMENT '添加时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='管理操作日志';

-- ----------------------------
-- Records of rt_manager_log
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for rt_manager_map
-- ----------------------------
DROP TABLE IF EXISTS `rt_manager_map`;
CREATE TABLE `rt_manager_map` (
  `manager_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `group_id` int(10) unsigned DEFAULT '0' COMMENT '集团id',
  `company_ids` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '公司归集id',
  `city_ids` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '城市归集id',
  `store_ids` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '门店归集id',
  `position_ids` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '岗位归集id',
  `role_ids` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '角色归集id',
  `strore_id` int(10) unsigned DEFAULT '0' COMMENT '主门店id',
  `role_id` int(10) unsigned DEFAULT '0' COMMENT '主角色id',
  PRIMARY KEY (`manager_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='员工归属表';

-- ----------------------------
-- Records of rt_manager_map
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for rt_manger
-- ----------------------------
DROP TABLE IF EXISTS `rt_manger`;
CREATE TABLE `rt_manger` (
  `manger_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '唯一标志',
  `username` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '用户名',
  `password` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '密码',
  `salt` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '密码钥匙',
  `role_id` int(10) NOT NULL DEFAULT '0' COMMENT '角色id',
  `add_time` int(10) NOT NULL DEFAULT '0' COMMENT '添加时间',
  `name` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '真实姓名',
  `mobile` int(10) DEFAULT NULL COMMENT '手机号',
  `status` tinyint(2) NOT NULL DEFAULT '1' COMMENT '状态1正常0禁用',
  `login_time` int(10) DEFAULT '0' COMMENT '登录时间',
  `login_num` int(10) DEFAULT '0' COMMENT '登录次数',
  `update_time` int(10) DEFAULT '0' COMMENT '更新时间',
  `group_id` int(10) unsigned DEFAULT '0' COMMENT '集团id',
  `rules` text COLLATE utf8mb4_unicode_ci COMMENT '权限，可单独设立',
  `usercode` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '员工编号',
  PRIMARY KEY (`manger_id`) USING BTREE,
  UNIQUE KEY `username` (`username`,`group_id`) USING BTREE,
  UNIQUE KEY `mobile` (`mobile`,`group_id`) USING BTREE,
  UNIQUE KEY `usercode` (`usercode`,`group_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='员工表';

-- ----------------------------
-- Records of rt_manger
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for rt_manger_auth
-- ----------------------------
DROP TABLE IF EXISTS `rt_manger_auth`;
CREATE TABLE `rt_manger_auth` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `rules` text CHARACTER SET utf8,
  `group_id` int(10) unsigned DEFAULT '0' COMMENT '集团id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='员工权限表';

-- ----------------------------
-- Records of rt_manger_auth
-- ----------------------------
BEGIN;
INSERT INTO `rt_manger_auth` VALUES (1, '总管理员', '-1', 0);
COMMIT;

-- ----------------------------
-- Table structure for rt_menu
-- ----------------------------
DROP TABLE IF EXISTS `rt_menu`;
CREATE TABLE `rt_menu` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `route` varchar(255) CHARACTER SET utf8 DEFAULT NULL COMMENT '权限标志',
  `href` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '前端地址',
  `type` tinyint(2) DEFAULT '0' COMMENT '0目录1菜单2按钮3权限',
  `order_num` int(10) DEFAULT '0' COMMENT '排序',
  `icon` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `open_type` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `pid` int(10) DEFAULT '0',
  `lid` tinyint(3) DEFAULT '1',
  `ifshow` tinyint(3) unsigned DEFAULT '0' COMMENT '是否显示0显示1不显示',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `url` (`route`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=92 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='系统菜单';

-- ----------------------------
-- Records of rt_menu
-- ----------------------------
BEGIN;
INSERT INTO `rt_menu` VALUES (1, '内容管理', 'content', NULL, 0, 1, 'layui-icon layui-icon-theme', '_self', 0, 0, 0);
INSERT INTO `rt_menu` VALUES (2, '系统管理', 'system', '', 0, 2, 'layui-icon layui-icon-windows', '_self', 0, 0, 0);
INSERT INTO `rt_menu` VALUES (3, '公共模块', 'common', '', 0, 3, 'layui-icon layui-icon-at', '_self', 0, 0, 1);
INSERT INTO `rt_menu` VALUES (4, '用户管理', 'user/index', '', 1, 4, 'layui-icon layui-icon-username', '_self', 1, 1, 0);
INSERT INTO `rt_menu` VALUES (5, '用户账户', 'user/account', '', 1, 5, 'layui-icon layui-icon-heart-fill', '_self', 1, 1, 0);
INSERT INTO `rt_menu` VALUES (7, '文章管理', 'art/index', '', 1, 7, 'layui-icon layui-icon-light', '_self', 1, 1, 0);
INSERT INTO `rt_menu` VALUES (9, '菜单管理', 'menu/oplist', 'view/menu/index.html', 1, 9, 'layui-icon layui-icon-gift', '_self', 2, 1, 0);
INSERT INTO `rt_menu` VALUES (10, '角色管理', 'auth/list', 'view/auth/index.html', 1, 10, 'layui-icon layui-icon-service', '_self', 2, 1, 0);
INSERT INTO `rt_menu` VALUES (11, '管理员管理', 'admin/list', 'view/admin/list.html', 1, 11, 'layui-icon layui-icon-key', '_self', 2, 1, 0);
INSERT INTO `rt_menu` VALUES (12, '日志管理', 'logs', '', 0, 12, 'layui-icon layui-icon-spread-left', '_self', 2, 1, 0);
INSERT INTO `rt_menu` VALUES (13, '系统设置', 'set/list', 'view/set/list.html', 1, 13, 'layui-icon layui-icon-find-fill', '_self', 2, 1, 0);
INSERT INTO `rt_menu` VALUES (14, '计划任务', 'set/crons', '', 1, 14, 'layui-icon layui-icon-component', '_self', 2, 1, 0);
INSERT INTO `rt_menu` VALUES (15, '前端菜单', 'menu/list', '', 3, 0, 'layui-icon layui-icon-transfer', NULL, 3, 1, 1);
INSERT INTO `rt_menu` VALUES (20, '新增菜单', 'menu/add', '', 2, 20, 'layui-icon layui-icon-cols', '_self', 9, 2, 0);
INSERT INTO `rt_menu` VALUES (21, '编辑菜单', 'menu/edit', '', 2, 20, 'layui-icon layui-icon-add-1', '_self', 9, 2, 0);
INSERT INTO `rt_menu` VALUES (22, '删除菜单', 'menu/del', '', 2, 21, 'layui-icon layui-icon-delete', '_self', 9, 2, 0);
INSERT INTO `rt_menu` VALUES (23, '查看菜单', 'menu/one', '', 3, 20, 'layui-icon layui-icon-slider', '_self', 9, 2, 0);
INSERT INTO `rt_menu` VALUES (24, '编辑管理员', 'admin/edit', '', 2, 20, 'layui-icon layui-icon-time', '_self', 11, 2, 0);
INSERT INTO `rt_menu` VALUES (25, '删除管理员', 'admin/del', '', 2, 21, 'layui-icon layui-icon-more-vertical', '_self', 11, 2, 0);
INSERT INTO `rt_menu` VALUES (26, '编辑角色', 'auth/edit', '', 2, 22, 'layui-icon layui-icon-key', '_self', 10, 2, 0);
INSERT INTO `rt_menu` VALUES (27, '删除角色', 'auth/del', '', 2, 23, 'layui-icon layui-icon-mute', '_self', 10, 2, 0);
INSERT INTO `rt_menu` VALUES (28, '添加配置', 'set/add', '', 2, 24, 'layui-icon layui-icon-at', '_self', 13, 2, 0);
INSERT INTO `rt_menu` VALUES (29, '删除配置', 'set/delete', '', 2, 25, 'layui-icon layui-icon-mute', '_self', 13, 2, 0);
INSERT INTO `rt_menu` VALUES (31, '编辑配置', 'set/edit', '', 2, 27, 'layui-icon layui-icon-export', '_self', 13, 2, 0);
INSERT INTO `rt_menu` VALUES (32, '编辑配置前', 'set/editBefore', '', 3, 28, 'layui-icon layui-icon-rate-half', '_self', 13, 2, 0);
INSERT INTO `rt_menu` VALUES (33, '编辑计划任务', 'set/cronsEdit', NULL, 2, 29, '', '_self', 14, 2, 0);
INSERT INTO `rt_menu` VALUES (34, '删除计划任务', 'set/cronDel', NULL, 2, 30, '', '_self', 14, 2, 0);
INSERT INTO `rt_menu` VALUES (35, '数据表设计', 'db/list', 'view/db/list.html', 1, 31, 'layui-icon layui-icon-layouts', '_self', 2, 1, 0);
INSERT INTO `rt_menu` VALUES (36, '系统字典', 'cate/index', '', 1, 50, 'layui-icon layui-icon-fonts-clear', '_self', 2, 1, 0);
INSERT INTO `rt_menu` VALUES (37, '用户地址', 'user/address', '', 1, 33, 'layui-icon layui-icon-key', '_self', 1, 1, 0);
INSERT INTO `rt_menu` VALUES (53, '首页工作台', 'index/welcome', 'index/welcome', 1, 1, 'layui-icon layui-icon-rate-solid', NULL, 1, 1, 0);
INSERT INTO `rt_menu` VALUES (56, '查看角色', 'auth/one', '', 2, 0, 'layui-icon layui-icon-camera', NULL, 10, 1, 0);
INSERT INTO `rt_menu` VALUES (57, '菜单显示', 'menu/ifshow', '', 2, 0, 'layui-icon layui-icon-mike', NULL, 9, 1, 0);
INSERT INTO `rt_menu` VALUES (58, '添加查看菜单', 'auth/addTree', '', 3, 1, 'layui-icon layui-icon-heart-fill', NULL, 10, 1, 0);
INSERT INTO `rt_menu` VALUES (59, '添加角色', 'auth/add', '', 2, 1, 'layui-icon layui-icon-logout', NULL, 10, 1, 0);
INSERT INTO `rt_menu` VALUES (60, '角色编辑前', 'auth/beforEdit', '', 3, 0, 'layui-icon layui-icon-email', NULL, 10, 1, 0);
INSERT INTO `rt_menu` VALUES (61, '设置角色可用', 'auth/enable', '', 2, 0, 'layui-icon layui-icon-at', NULL, 10, 1, 0);
INSERT INTO `rt_menu` VALUES (62, '管理员添加前', 'admin/addBefore', '', 3, 0, '', NULL, 11, 1, 0);
INSERT INTO `rt_menu` VALUES (63, '添加管理员', 'admin/add', '', 2, 0, 'layui-icon layui-icon-windows', NULL, 11, 1, 0);
INSERT INTO `rt_menu` VALUES (64, '管理员编辑前', 'admin/editBefore', '', 3, 0, 'layui-icon layui-icon-export', NULL, 11, 1, 0);
INSERT INTO `rt_menu` VALUES (65, '管理员启用禁用', 'admin/enable', '', 2, 0, 'layui-icon layui-icon-slider', NULL, 11, 1, 0);
INSERT INTO `rt_menu` VALUES (66, '操作日志', 'logs/op', 'view/logs/op.html', 1, 0, 'layui-icon layui-icon-date', NULL, 12, 1, 0);
INSERT INTO `rt_menu` VALUES (67, '行为日志', 'logs/view', 'view/logs/view.html', 1, 0, 'layui-icon layui-icon-cols', NULL, 12, 1, 0);
INSERT INTO `rt_menu` VALUES (68, '错误日志', 'logs/err', 'view/logs/err.html', 1, 0, 'layui-icon layui-icon-survey', NULL, 12, 1, 0);
INSERT INTO `rt_menu` VALUES (82, '表单设计器', 'form/list', 'view/form/list.html', 1, 31, 'layui-icon layui-icon-template-1', NULL, 2, 1, 0);
INSERT INTO `rt_menu` VALUES (83, '添加表单', 'form/add', 'view/form/add.html', 2, 0, 'layui-icon layui-icon-auz', NULL, 82, 1, 0);
INSERT INTO `rt_menu` VALUES (84, '设置配置可用', 'set/enable', '', 3, 0, '', NULL, 13, 1, 0);
INSERT INTO `rt_menu` VALUES (85, '添加表单前', 'form/addBefore', '', 3, 0, 'layui-icon layui-icon-headset', NULL, 82, 1, 0);
INSERT INTO `rt_menu` VALUES (86, '设置配置前', 'set/setBefore', '', 3, 0, 'layui-icon layui-icon-at', NULL, 13, 1, 0);
INSERT INTO `rt_menu` VALUES (87, '设置配置', 'set/setConf', '', 3, 0, 'layui-icon layui-icon-404', NULL, 13, 1, 0);
INSERT INTO `rt_menu` VALUES (88, '更新表缓存', 'db/update', '', 2, 0, 'layui-icon layui-icon-refresh', NULL, 35, 1, 0);
INSERT INTO `rt_menu` VALUES (89, '备份数据', 'db/backup', '', 2, 0, 'layui-icon layui-icon-templeate-1', NULL, 35, 1, 0);
INSERT INTO `rt_menu` VALUES (90, '还原数据列表', 'db/backupFile', '', 2, 0, 'layui-icon layui-icon-list', NULL, 35, 1, 0);
INSERT INTO `rt_menu` VALUES (91, '数据还原2', 'db/reback', '', 2, 0, 'layui-icon layui-icon-water', NULL, 35, 1, 0);
COMMIT;

-- ----------------------------
-- Table structure for rt_msg
-- ----------------------------
DROP TABLE IF EXISTS `rt_msg`;
CREATE TABLE `rt_msg` (
  `msg_id` int(10) NOT NULL,
  `msg` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '消息',
  `url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '跳转地址',
  `type` tinyint(3) DEFAULT NULL COMMENT '类型',
  `add_time` int(10) unsigned DEFAULT '0' COMMENT '添加时间',
  `update_time` int(10) DEFAULT NULL COMMENT '阅读时间',
  PRIMARY KEY (`msg_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='待办消息表';

-- ----------------------------
-- Records of rt_msg
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for rt_order
-- ----------------------------
DROP TABLE IF EXISTS `rt_order`;
CREATE TABLE `rt_order` (
  `order_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `order_num` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '订单编号',
  `product_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '商品id',
  `group_id` int(10) NOT NULL COMMENT '集团id',
  `need_pay` decimal(10,2) NOT NULL COMMENT '应付',
  `true_pay` decimal(10,2) NOT NULL COMMENT '实付',
  `has_use` decimal(10,2) DEFAULT NULL COMMENT '已消费金额',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '0未支付2已支付1审核中3作废4退款5关闭',
  `user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户id',
  `manager_id` int(10) NOT NULL COMMENT '员工id',
  `mgr_id` int(10) DEFAULT NULL COMMENT '审核员id',
  `type` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '0正常订单1业务订单2作废单3退款单',
  `store_id` int(10) unsigned DEFAULT '0' COMMENT '店铺id',
  `pay_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '支付方式',
  `order_from` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '订单来源',
  `add_time` int(10) DEFAULT NULL COMMENT '添加时间',
  `pay_time` int(10) DEFAULT NULL COMMENT '支付时间',
  `check_time` int(10) DEFAULT NULL COMMENT '审核时间',
  `achievement` decimal(10,2) DEFAULT NULL COMMENT '总支付业绩',
  `service_num` int(10) unsigned DEFAULT '0' COMMENT '服务次数',
  `service_use` int(10) unsigned DEFAULT '0' COMMENT '已用次数',
  `remark` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '标记',
  PRIMARY KEY (`order_id`),
  UNIQUE KEY `order_num` (`order_num`) USING HASH
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='订单表';

-- ----------------------------
-- Records of rt_order
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for rt_order_back
-- ----------------------------
DROP TABLE IF EXISTS `rt_order_back`;
CREATE TABLE `rt_order_back` (
  `back_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `order_id` int(10) DEFAULT NULL COMMENT '订单id',
  `add_time` int(10) DEFAULT NULL COMMENT '添加时间',
  `reason` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '原因',
  `mgr_id` int(10) DEFAULT NULL COMMENT '作废人',
  `manager_id` int(10) DEFAULT NULL COMMENT '归属人',
  PRIMARY KEY (`back_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='作废单';

-- ----------------------------
-- Records of rt_order_back
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for rt_order_log
-- ----------------------------
DROP TABLE IF EXISTS `rt_order_log`;
CREATE TABLE `rt_order_log` (
  `log_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `order_id` int(10) DEFAULT NULL COMMENT '订单id',
  `mgr_id` int(10) DEFAULT NULL COMMENT '操作人',
  `add_time` int(10) DEFAULT NULL COMMENT '操作时间',
  `remark` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '标记',
  PRIMARY KEY (`log_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='订单日志表';

-- ----------------------------
-- Records of rt_order_log
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for rt_order_refund
-- ----------------------------
DROP TABLE IF EXISTS `rt_order_refund`;
CREATE TABLE `rt_order_refund` (
  `refund_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `order_id` int(10) unsigned DEFAULT '0' COMMENT '订单编号',
  `user_id` int(10) unsigned DEFAULT '0' COMMENT '用户id',
  `store_id` int(10) unsigned DEFAULT '0' COMMENT '店铺id',
  `group_id` int(10) DEFAULT NULL COMMENT '集团id',
  `mgr_id` int(10) unsigned DEFAULT '0' COMMENT '操作人id',
  `manager_id` int(10) DEFAULT NULL COMMENT '归属人id',
  `reason` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '退款原因',
  `has_pay` decimal(10,2) DEFAULT NULL COMMENT '实际支付金额',
  `has_use` decimal(10,2) DEFAULT NULL COMMENT '已消耗金额',
  `need_pay` decimal(10,2) DEFAULT NULL COMMENT '应退款金额',
  `true_pay` decimal(10,2) DEFAULT NULL COMMENT '实际退款金额',
  `add_time` int(10) unsigned DEFAULT '0' COMMENT '添加时间',
  `check_time` int(10) DEFAULT NULL COMMENT '审核时间',
  `check_uid` int(10) DEFAULT NULL COMMENT '审核人',
  `type` tinyint(3) unsigned DEFAULT '0' COMMENT '状态0提交审核1审核通过2驳回',
  PRIMARY KEY (`refund_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='退款单';

-- ----------------------------
-- Records of rt_order_refund
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for rt_order_service
-- ----------------------------
DROP TABLE IF EXISTS `rt_order_service`;
CREATE TABLE `rt_order_service` (
  `service_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `order_id` int(10) DEFAULT NULL,
  `service_num` int(10) DEFAULT NULL COMMENT '消耗的次数',
  `product_id` int(10) DEFAULT NULL COMMENT '商品id',
  `group_id` int(10) DEFAULT NULL COMMENT '集团id',
  `store_id` int(10) DEFAULT NULL COMMENT '商品id',
  `add_time` int(10) DEFAULT NULL COMMENT '添加时间',
  `update_time` int(10) DEFAULT NULL COMMENT '更新时间',
  `manager_id` int(10) DEFAULT NULL COMMENT '员工id',
  `user_id` int(10) DEFAULT NULL COMMENT '用户id',
  `remark` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '标记',
  PRIMARY KEY (`service_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='消耗单';

-- ----------------------------
-- Records of rt_order_service
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for rt_product
-- ----------------------------
DROP TABLE IF EXISTS `rt_product`;
CREATE TABLE `rt_product` (
  `product_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '名称',
  `type` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT '类型0商品1消耗品2组合商品',
  `code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '编码',
  `format` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '规格',
  `format_id` int(10) unsigned DEFAULT '0' COMMENT '规格id',
  `unit` decimal(10,2) DEFAULT NULL COMMENT '单位',
  `unit_id` int(10) unsigned DEFAULT '0' COMMENT '单位id',
  `stock` int(10) unsigned DEFAULT '0' COMMENT '库存',
  `price` decimal(10,2) DEFAULT NULL COMMENT '价格',
  `price_one` decimal(10,2) unsigned DEFAULT '0.00' COMMENT '单个售价',
  `price_low` decimal(10,2) DEFAULT NULL COMMENT '最低售价',
  `group_id` int(10) unsigned DEFAULT '0' COMMENT '集团id',
  `add_time` int(10) unsigned DEFAULT '0' COMMENT '添加时间',
  `update_time` int(10) unsigned DEFAULT '0' COMMENT '更新时间',
  `status` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT '状态0正常1下架',
  `manager_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '添加人id',
  `service_num` int(10) unsigned DEFAULT '0' COMMENT '服务次数',
  `remark` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '标签',
  PRIMARY KEY (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='商品表';

-- ----------------------------
-- Records of rt_product
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for rt_product_compose
-- ----------------------------
DROP TABLE IF EXISTS `rt_product_compose`;
CREATE TABLE `rt_product_compose` (
  `compose_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `product_id` int(10) DEFAULT NULL COMMENT '商品主id',
  `pro_id` int(10) DEFAULT NULL COMMENT '组合商品id',
  `service_num` int(10) DEFAULT NULL COMMENT '服务次数',
  `price` decimal(10,2) unsigned DEFAULT '0.00' COMMENT '价格',
  `add_time` int(10) unsigned DEFAULT '0' COMMENT '添加时间',
  PRIMARY KEY (`compose_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='组合商品';

-- ----------------------------
-- Records of rt_product_compose
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for rt_product_param
-- ----------------------------
DROP TABLE IF EXISTS `rt_product_param`;
CREATE TABLE `rt_product_param` (
  `param_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `type` tinyint(3) unsigned DEFAULT '0' COMMENT '类别0规格1单位',
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '名称',
  `group_id` int(10) DEFAULT NULL COMMENT '集团id',
  `add_time` int(10) unsigned DEFAULT '0' COMMENT '添加时间',
  `manager_id` int(10) DEFAULT NULL COMMENT '添加人',
  PRIMARY KEY (`param_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='商品规格单位字典';

-- ----------------------------
-- Records of rt_product_param
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for rt_product_price
-- ----------------------------
DROP TABLE IF EXISTS `rt_product_price`;
CREATE TABLE `rt_product_price` (
  `price_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `price` decimal(10,2) unsigned DEFAULT '0.00' COMMENT '价格',
  `strore_id` int(10) unsigned DEFAULT '0' COMMENT '门店id',
  `group_id` int(10) DEFAULT NULL COMMENT '集团id',
  `product_id` int(10) DEFAULT NULL COMMENT '商品id',
  `can_edit` tinyint(2) unsigned DEFAULT '0' COMMENT '是否可改价0可改1不可改',
  `service_num` int(10) unsigned DEFAULT '0' COMMENT '服务次数',
  PRIMARY KEY (`price_id`),
  UNIQUE KEY `product_id` (`strore_id`,`group_id`,`product_id`) USING HASH
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='商品区间价';

-- ----------------------------
-- Records of rt_product_price
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for rt_set
-- ----------------------------
DROP TABLE IF EXISTS `rt_set`;
CREATE TABLE `rt_set` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `key` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '键值',
  `name` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '名称',
  `val` text COLLATE utf8mb4_unicode_ci COMMENT '值',
  `enable` tinyint(2) DEFAULT '1' COMMENT '状态',
  `remark` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `form_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '表单id',
  `form_path` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `params` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `key` (`key`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='系统配置表';

-- ----------------------------
-- Records of rt_set
-- ----------------------------
BEGIN;
INSERT INTO `rt_set` VALUES (9, 'mysql', 'mysql', '{\"host\":\"11111\",\"port\":\"3306\",\"input_2\":\"111\",\"textarea_1\":\"  5555\",\"conftype\":\"mysql\"}', 1, NULL, 9, '/admin/view/set/config/mysql.html', NULL);
INSERT INTO `rt_set` VALUES (10, 'redis', 'redis', NULL, 1, NULL, 11, '/admin/view/set/config/redis.html', NULL);
INSERT INTO `rt_set` VALUES (11, 'test', 'test', NULL, 1, NULL, 0, NULL, NULL);
INSERT INTO `rt_set` VALUES (12, 'dd', 'dd', NULL, 0, '5555', 0, '/admin/view/set/config/test.html', NULL);
INSERT INTO `rt_set` VALUES (14, 'test1', 'test', NULL, 1, '111', 0, '', NULL);
COMMIT;

-- ----------------------------
-- Table structure for rt_set_cate
-- ----------------------------
DROP TABLE IF EXISTS `rt_set_cate`;
CREATE TABLE `rt_set_cate` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `key` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT '0' COMMENT '唯一标志',
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '名称',
  `remark` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '描述',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `key` (`key`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='系统配置分类表';

-- ----------------------------
-- Records of rt_set_cate
-- ----------------------------
BEGIN;
INSERT INTO `rt_set_cate` VALUES (1, 'config', '系统配置', NULL);
INSERT INTO `rt_set_cate` VALUES (2, 'test', 'test', 'test');
INSERT INTO `rt_set_cate` VALUES (5, 'ttt', 'ttt', '111');
COMMIT;

-- ----------------------------
-- Table structure for rt_sms
-- ----------------------------
DROP TABLE IF EXISTS `rt_sms`;
CREATE TABLE `rt_sms` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `phone` bigint(12) unsigned DEFAULT NULL,
  `sendtime` int(10) unsigned DEFAULT '0',
  `endtime` int(10) unsigned DEFAULT '0',
  `num` int(10) unsigned DEFAULT '0',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='系统短信表';

-- ----------------------------
-- Records of rt_sms
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for rt_store
-- ----------------------------
DROP TABLE IF EXISTS `rt_store`;
CREATE TABLE `rt_store` (
  `store_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '门店名称',
  `address` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '门店地址',
  `group_id` int(10) unsigned DEFAULT '0' COMMENT '集团id',
  `city_id` int(10) unsigned DEFAULT '0' COMMENT '城市id',
  `company_id` int(10) unsigned DEFAULT '0' COMMENT '公司id',
  `area_id` int(10) unsigned DEFAULT '0' COMMENT '区域id',
  `status` tinyint(2) unsigned DEFAULT '0' COMMENT '0正常1关闭',
  `type` tinyint(2) unsigned DEFAULT '0' COMMENT '0直营1渠道',
  `add_time` int(10) DEFAULT NULL COMMENT '添加时间',
  `manager_id` int(10) unsigned DEFAULT '0' COMMENT '添加人id',
  PRIMARY KEY (`store_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='门店表';

-- ----------------------------
-- Records of rt_store
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for rt_sys_cate
-- ----------------------------
DROP TABLE IF EXISTS `rt_sys_cate`;
CREATE TABLE `rt_sys_cate` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `key` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT '0' COMMENT '唯一标志',
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '名称',
  `desc` text COLLATE utf8mb4_unicode_ci COMMENT '描述',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `key` (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='系统总分类表';

-- ----------------------------
-- Records of rt_sys_cate
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for rt_user
-- ----------------------------
DROP TABLE IF EXISTS `rt_user`;
CREATE TABLE `rt_user` (
  `user_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '唯一标志',
  `username` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '用户名',
  `password` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '密码,默认111111',
  `salt` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '密码钥匙',
  `level_id` int(6) DEFAULT NULL COMMENT '用户等级',
  `balance` decimal(10,2) DEFAULT NULL COMMENT '用户积分',
  `add_time` int(10) NOT NULL DEFAULT '0' COMMENT '添加时间',
  `name` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '真实姓名',
  `mobile` int(10) DEFAULT NULL COMMENT '手机号',
  `status` tinyint(2) NOT NULL DEFAULT '1' COMMENT '状态1正常0禁用',
  `login_time` int(10) DEFAULT '0' COMMENT '登录时间',
  `login_num` int(10) DEFAULT '0' COMMENT '登录次数',
  `update_time` int(10) DEFAULT '0' COMMENT '更新时间',
  `group_id` int(10) unsigned DEFAULT '0' COMMENT '集团id',
  `blone_id` int(10) unsigned DEFAULT '0' COMMENT '归属id',
  `manager_id` int(10) unsigned DEFAULT '0' COMMENT '添加人id',
  `all_use` decimal(10,2) unsigned DEFAULT '0.00' COMMENT '用户总支付',
  `remark` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '标签',
  PRIMARY KEY (`user_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='客户表';

-- ----------------------------
-- Records of rt_user
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for rt_user_level
-- ----------------------------
DROP TABLE IF EXISTS `rt_user_level`;
CREATE TABLE `rt_user_level` (
  `level_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '名称',
  `balance` decimal(10,2) DEFAULT NULL COMMENT '需要达到的积分',
  PRIMARY KEY (`level_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='用户等级表';

-- ----------------------------
-- Records of rt_user_level
-- ----------------------------
BEGIN;
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
