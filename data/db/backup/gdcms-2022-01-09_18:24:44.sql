/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: rt_admin
# ------------------------------------------------------------

DROP TABLE IF EXISTS `rt_admin`;
CREATE TABLE `rt_admin` (
  `username` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '用户名',
  `password` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '密码',
  `admin_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '唯一标志',
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
) ENGINE = InnoDB AUTO_INCREMENT = 6 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '管理员表';

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: rt_admin_auth
# ------------------------------------------------------------

DROP TABLE IF EXISTS `rt_admin_auth`;
CREATE TABLE `rt_admin_auth` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `rules` text CHARACTER SET utf8,
  `status` tinyint(2) unsigned DEFAULT '0' COMMENT '是否可用0可用1不可用',
  `remark` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '描述',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 16 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '管理权限表';

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: rt_admin_loginlog
# ------------------------------------------------------------

DROP TABLE IF EXISTS `rt_admin_loginlog`;
CREATE TABLE `rt_admin_loginlog` (
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
) ENGINE = InnoDB AUTO_INCREMENT = 23 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '管理登录日志表';

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: rt_admin_map
# ------------------------------------------------------------

DROP TABLE IF EXISTS `rt_admin_map`;
CREATE TABLE `rt_admin_map` (
  `map_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `admin_id` int(10) unsigned NOT NULL,
  `auth_id` int(10) unsigned NOT NULL,
  `type` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '0角色1集团2公司3门店4部门5区域',
  PRIMARY KEY (`map_id`),
  UNIQUE KEY `admin_id` (`admin_id`, `auth_id`, `type`) USING HASH
) ENGINE = InnoDB AUTO_INCREMENT = 11 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '管理员权限映射表';

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: rt_admin_oplog
# ------------------------------------------------------------

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
) ENGINE = InnoDB AUTO_INCREMENT = 589 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '管理操作日志';

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: rt_admin_viewlog
# ------------------------------------------------------------

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
) ENGINE = InnoDB AUTO_INCREMENT = 549 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '管理员查看日志';

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: rt_api
# ------------------------------------------------------------

DROP TABLE IF EXISTS `rt_api`;
CREATE TABLE `rt_api` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '唯一标志',
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '接口名称',
  `mod_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '模块id',
  `menu_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '菜单id',
  `mod_key` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '所属模块',
  `key` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '接口唯一标志',
  `method` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '接口方法',
  `remark` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '说明',
  `add_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '添加时间',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '添加人',
  PRIMARY KEY (`id`)
) ENGINE = InnoDB AUTO_INCREMENT = 14 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '接口主表';

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: rt_api_form
# ------------------------------------------------------------

DROP TABLE IF EXISTS `rt_api_form`;
CREATE TABLE `rt_api_form` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '唯一标志',
  PRIMARY KEY (`id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '接口表单表';

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: rt_api_logic
# ------------------------------------------------------------

DROP TABLE IF EXISTS `rt_api_logic`;
CREATE TABLE `rt_api_logic` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '唯一标志',
  `code` text COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '代码',
  `add_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '添加时间',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE = InnoDB AUTO_INCREMENT = 14 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '接口逻辑表';

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: rt_api_params
# ------------------------------------------------------------

DROP TABLE IF EXISTS `rt_api_params`;
CREATE TABLE `rt_api_params` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '唯一标志',
  `aid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '接口id',
  `key` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '参数标志',
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '参数名字',
  `type` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '参数类型',
  `len_min` int(10) unsigned DEFAULT '0' COMMENT '字符最小值',
  `len_max` int(10) unsigned DEFAULT '0' COMMENT '字符最大值',
  `num_min` int(10) unsigned DEFAULT '0' COMMENT '数字最小值',
  `num_max` int(10) unsigned DEFAULT '0' COMMENT '数值最大值',
  `def` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '默认值',
  `required` tinyint(2) unsigned DEFAULT '0' COMMENT '是否必填',
  `format` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '参数格式',
  `isdb` tinyint(2) unsigned DEFAULT '0' COMMENT '是否为数据库字段',
  `tablename` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '数据库表名',
  `tablefield` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '数据库字段名',
  PRIMARY KEY (`id`)
) ENGINE = InnoDB AUTO_INCREMENT = 37 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '接口参数表';

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: rt_api_table
# ------------------------------------------------------------

DROP TABLE IF EXISTS `rt_api_table`;
CREATE TABLE `rt_api_table` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '唯一标志',
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '名称',
  PRIMARY KEY (`id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '接口表格表';

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: rt_api_test
# ------------------------------------------------------------

DROP TABLE IF EXISTS `rt_api_test`;
CREATE TABLE `rt_api_test` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '唯一标志',
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '用例名称',
  `aid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '接口id',
  `data` text COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '数据内容',
  `method` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT 'GET' COMMENT '类型',
  `add_time` int(10) NOT NULL DEFAULT '0' COMMENT '添加时间',
  `update_time` int(10) NOT NULL DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE = InnoDB AUTO_INCREMENT = 3 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '接口测试表';

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: rt_area
# ------------------------------------------------------------

DROP TABLE IF EXISTS `rt_area`;
CREATE TABLE `rt_area` (
  `id` int(10) NOT NULL COMMENT '区号',
  `name` varchar(40) DEFAULT NULL COMMENT '地区名称',
  `pid` int(11) DEFAULT NULL COMMENT '上级id',
  `status` tinyint(2) unsigned DEFAULT '1' COMMENT '状态1为可用0为不可用',
  `order_num` int(10) unsigned DEFAULT '0' COMMENT '排序',
  PRIMARY KEY (`id`),
  KEY `pid` (`pid`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8 COMMENT = '地区表';

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: rt_article
# ------------------------------------------------------------

DROP TABLE IF EXISTS `rt_article`;
CREATE TABLE `rt_article` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '文章id',
  `category_id` int(10) DEFAULT '0' COMMENT '分类id',
  `title` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '标题',
  `desc_content` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `image` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `content` text CHARACTER SET utf8 NOT NULL COMMENT '内容',
  `author` varchar(32) CHARACTER SET utf8 NOT NULL COMMENT '作者:id:name',
  `show_switch` tinyint(1) NOT NULL DEFAULT '1' COMMENT '展示:1=展示,0=隐藏',
  `show_time` int(10) unsigned DEFAULT '0',
  `up_time` int(10) unsigned DEFAULT '0',
  `add_time` int(10) unsigned DEFAULT '0',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '文章';

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: rt_cate
# ------------------------------------------------------------

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
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '系统分类表';

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: rt_category
# ------------------------------------------------------------

DROP TABLE IF EXISTS `rt_category`;
CREATE TABLE `rt_category` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `name` varchar(255) CHARACTER SET utf8 NOT NULL COMMENT '分类名称',
  `status` tinyint(2) DEFAULT '0' COMMENT '是否使用，预留',
  `ctype` tinyint(3) DEFAULT '1' COMMENT '分类类型 1新闻2账户类型3账户日志来源',
  `desc` text CHARACTER SET utf8 COMMENT '其他附加配置',
  `flag` int(10) NOT NULL DEFAULT '0' COMMENT '分类标志，同一分类不能重复',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '文章分类';

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: rt_chat_friend_log
# ------------------------------------------------------------

DROP TABLE IF EXISTS `rt_chat_friend_log`;
CREATE TABLE `rt_chat_friend_log` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `from_id` int(10) NOT NULL COMMENT '发送者',
  `to_id` int(10) NOT NULL COMMENT '接收者',
  `content` text CHARACTER SET utf8mb4 NOT NULL COMMENT '聊天内容',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '1未读 2已读 3撤回',
  `add_time` int(10) NOT NULL COMMENT '添加时间',
  `update_time` int(10) NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '好友聊天日志';

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: rt_chat_friends
# ------------------------------------------------------------

DROP TABLE IF EXISTS `rt_chat_friends`;
CREATE TABLE `rt_chat_friends` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `uid` int(10) unsigned NOT NULL COMMENT '用户id',
  `friend_id` int(10) unsigned NOT NULL COMMENT '好友ID',
  `group_id` int(10) unsigned NOT NULL COMMENT '分组id',
  `remark` varchar(25) CHARACTER SET utf8mb4 NOT NULL COMMENT '好友备注',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '1正常 2特别关注 3拉黑',
  `add_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '添加时间',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE = InnoDB AUTO_INCREMENT = 19 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '聊天好友表';

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: rt_chat_group_detail
# ------------------------------------------------------------

DROP TABLE IF EXISTS `rt_chat_group_detail`;
CREATE TABLE `rt_chat_group_detail` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `groupname` varchar(255) CHARACTER SET utf8mb4 NOT NULL COMMENT '群名称',
  `avatar` varchar(255) CHARACTER SET utf8mb4 NOT NULL COMMENT '群头像',
  `desc` varchar(255) CHARACTER SET utf8mb4 NOT NULL COMMENT '群介绍',
  `belong` varchar(10) CHARACTER SET utf8mb4 NOT NULL COMMENT '群主ID',
  `manger` text CHARACTER SET utf8mb4 NOT NULL COMMENT '管理员ID集合',
  `approval` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否需要验证 1需要 2不需要',
  `number` int(4) NOT NULL DEFAULT '200' COMMENT '群人数',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '1正常 2禁言',
  `add_time` int(10) NOT NULL COMMENT '添加时间',
  `update_time` int(10) NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '群组表';

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: rt_chat_group_log
# ------------------------------------------------------------

DROP TABLE IF EXISTS `rt_chat_group_log`;
CREATE TABLE `rt_chat_group_log` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `from_id` int(10) unsigned NOT NULL,
  `to_id` int(10) unsigned NOT NULL,
  `content` text CHARACTER SET utf8mb4 NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '1未读 2已读 3删除',
  `add_time` int(10) NOT NULL COMMENT '添加时间',
  `update_time` int(10) NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '群聊天日志';

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: rt_chat_group_member
# ------------------------------------------------------------

DROP TABLE IF EXISTS `rt_chat_group_member`;
CREATE TABLE `rt_chat_group_member` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `uid` int(10) NOT NULL,
  `group_id` int(10) NOT NULL,
  `remark` varchar(25) NOT NULL,
  `type` tinyint(1) unsigned NOT NULL DEFAULT '3' COMMENT '身份 1群主 2管理员 3群员',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '1正常 2禁言',
  `sort` int(11) NOT NULL,
  `disable_time` int(10) NOT NULL COMMENT '禁言时间',
  `add_time` int(10) NOT NULL COMMENT '添加时间',
  `update_time` int(10) NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COMMENT = '群组成员';

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: rt_chat_notify
# ------------------------------------------------------------

DROP TABLE IF EXISTS `rt_chat_notify`;
CREATE TABLE `rt_chat_notify` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `from_id` int(10) NOT NULL COMMENT '''消息发送者 0表示为系统消息''',
  `to_id` int(10) NOT NULL COMMENT '''消息接收者 0表示全体会员'',',
  `type` tinyint(1) unsigned NOT NULL COMMENT '1为请求添加用户 2为系统消息（添加好友）3为请求加群 4为系统消息（添加群） 5 全体会员消息',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '1未读 2已读',
  `remark` varchar(255) NOT NULL COMMENT '''附加消息'',',
  `create_time` datetime NOT NULL COMMENT '''发送消息时间'',',
  `operation` tinyint(255) NOT NULL COMMENT '操作状态',
  `group_id` int(11) NOT NULL COMMENT '好友添加：好友分组id，群添加：群id',
  `handle_id` int(11) unsigned NOT NULL COMMENT '操作者id',
  PRIMARY KEY (`id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COMMENT = '消息通知';

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: rt_chat_users
# ------------------------------------------------------------

DROP TABLE IF EXISTS `rt_chat_users`;
CREATE TABLE `rt_chat_users` (
  `user_id` int(11) NOT NULL,
  `username` varchar(155) CHARACTER SET utf8 DEFAULT NULL,
  `groupid` int(5) DEFAULT NULL COMMENT '所属的分组id',
  `status` varchar(55) CHARACTER SET utf8 DEFAULT NULL,
  `sign` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `avatar` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  PRIMARY KEY (`user_id`) USING BTREE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '聊天用户';

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: rt_code
# ------------------------------------------------------------

DROP TABLE IF EXISTS `rt_code`;
CREATE TABLE `rt_code` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '唯一标志',
  `add_time` int(10) NOT NULL DEFAULT '0' COMMENT '添加时间',
  `update_time` int(10) NOT NULL DEFAULT '0' COMMENT '更新时间',
  `user_id` int(10) NOT NULL DEFAULT '0' COMMENT '用户id',
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '标志',
  `path` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '文件路径',
  `title` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '标题',
  `content` text CHARACTER SET utf8 NOT NULL COMMENT '内容',
  `type` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'controller' COMMENT '类型',
  `remark` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '备注',
  PRIMARY KEY (`id`)
) ENGINE = InnoDB AUTO_INCREMENT = 2 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '程序设计器';

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: rt_company
# ------------------------------------------------------------

DROP TABLE IF EXISTS `rt_company`;
CREATE TABLE `rt_company` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `rules` text CHARACTER SET utf8,
  `status` tinyint(2) unsigned DEFAULT '0' COMMENT '是否可用0可用1不可用',
  `remark` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '描述',
  `pid` int(10) unsigned DEFAULT '0' COMMENT '上级公司id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 16 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '公司表';

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: rt_crons
# ------------------------------------------------------------

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
  `remark` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '备注',
  `intertype` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '间隔类型',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `handle` (`handle`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '系统计划任务表';

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: rt_database
# ------------------------------------------------------------

DROP TABLE IF EXISTS `rt_database`;
CREATE TABLE `rt_database` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `database` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `host` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `port` int(10) unsigned NOT NULL DEFAULT '3306',
  `user` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `dateStrings` tinyint(2) unsigned DEFAULT NULL,
  `encoding` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `isdef` tinyint(2) unsigned DEFAULT '0',
  `prefix` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ssh` tinyint(2) unsigned DEFAULT NULL,
  `shost` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sport` int(10) unsigned DEFAULT '22',
  `suser` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `stype` tinyint(2) unsigned DEFAULT '1',
  `spass` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `spath` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE = InnoDB AUTO_INCREMENT = 12 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '数据库连接表';

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: rt_datasafe
# ------------------------------------------------------------

DROP TABLE IF EXISTS `rt_datasafe`;
CREATE TABLE `rt_datasafe` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `data_id` int(10) DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `data_id` (`data_id`, `name`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 43 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '数据库保护表';

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: rt_department
# ------------------------------------------------------------

DROP TABLE IF EXISTS `rt_department`;
CREATE TABLE `rt_department` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `rules` text CHARACTER SET utf8,
  `status` tinyint(2) unsigned DEFAULT '0' COMMENT '是否可用0可用1不可用',
  `remark` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '描述',
  `pid` int(10) unsigned DEFAULT '0' COMMENT '上级部门id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 16 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '部门表';

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: rt_doc
# ------------------------------------------------------------

DROP TABLE IF EXISTS `rt_doc`;
CREATE TABLE `rt_doc` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '唯一标志',
  `title` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '文集标题',
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '文集副标题',
  `key` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '文集标志',
  `version` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '文集版本',
  `logo` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'logo图片',
  `remark` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '介绍',
  `user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户id',
  `add_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '添加时间',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE = InnoDB AUTO_INCREMENT = 2 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '文档表';

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: rt_doc_cate
# ------------------------------------------------------------

DROP TABLE IF EXISTS `rt_doc_cate`;
CREATE TABLE `rt_doc_cate` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '唯一标志',
  `did` int(10) unsigned NOT NULL DEFAULT '1' COMMENT '文集id',
  `type` tinyint(2) NOT NULL DEFAULT '0' COMMENT '类型0分类1文章',
  `add_time` int(10) NOT NULL DEFAULT '0' COMMENT '添加时间',
  `update_time` int(10) NOT NULL DEFAULT '0' COMMENT '更新时间',
  `user_id` int(10) NOT NULL DEFAULT '0' COMMENT '用户id',
  `pid` int(10) NOT NULL DEFAULT '0' COMMENT '上级id',
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '文件名称',
  `title` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '标题',
  `content` text CHARACTER SET utf8 NOT NULL COMMENT '内容',
  `order_num` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '排序',
  PRIMARY KEY (`id`)
) ENGINE = InnoDB AUTO_INCREMENT = 49 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '文档分类表';

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: rt_error
# ------------------------------------------------------------

DROP TABLE IF EXISTS `rt_error`;
CREATE TABLE `rt_error` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `msg` text COLLATE utf8mb4_unicode_ci,
  `addtime` int(10) unsigned DEFAULT '0',
  `admin_id` int(10) unsigned DEFAULT '0',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '系统错误日志表';

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: rt_excel
# ------------------------------------------------------------

DROP TABLE IF EXISTS `rt_excel`;
CREATE TABLE `rt_excel` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '唯一标志',
  `add_time` int(10) NOT NULL DEFAULT '0' COMMENT '添加时间',
  `update_time` int(10) NOT NULL DEFAULT '0' COMMENT '更新时间',
  `user_id` int(10) NOT NULL DEFAULT '0' COMMENT '用户id',
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '名称',
  `title` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '标题',
  `content` text CHARACTER SET utf8 NOT NULL COMMENT '内容',
  PRIMARY KEY (`id`)
) ENGINE = InnoDB AUTO_INCREMENT = 7 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = 'excel表';

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: rt_flow
# ------------------------------------------------------------

DROP TABLE IF EXISTS `rt_flow`;
CREATE TABLE `rt_flow` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '唯一标志',
  `type` tinyint(2) unsigned DEFAULT '1' COMMENT '类型',
  `add_time` int(10) NOT NULL DEFAULT '0' COMMENT '添加时间',
  `update_time` int(10) NOT NULL DEFAULT '0' COMMENT '更新时间',
  `user_id` int(10) NOT NULL DEFAULT '0' COMMENT '用户id',
  `title` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '标题',
  `content` text CHARACTER SET utf8 NOT NULL COMMENT '内容',
  PRIMARY KEY (`id`)
) ENGINE = InnoDB AUTO_INCREMENT = 13 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '流程图';

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: rt_form
# ------------------------------------------------------------

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
) ENGINE = InnoDB AUTO_INCREMENT = 12 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '系统表单';

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: rt_gant
# ------------------------------------------------------------

DROP TABLE IF EXISTS `rt_gant`;
CREATE TABLE `rt_gant` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '唯一标志',
  `add_time` int(10) NOT NULL DEFAULT '0' COMMENT '添加时间',
  `update_time` int(10) NOT NULL DEFAULT '0' COMMENT '更新时间',
  `user_id` int(10) NOT NULL DEFAULT '0' COMMENT '用户id',
  `title` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '标题',
  `content` text CHARACTER SET utf8 NOT NULL COMMENT '内容',
  PRIMARY KEY (`id`)
) ENGINE = InnoDB AUTO_INCREMENT = 12 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '甘特图';

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: rt_kanban
# ------------------------------------------------------------

DROP TABLE IF EXISTS `rt_kanban`;
CREATE TABLE `rt_kanban` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '唯一标志',
  `add_time` int(10) NOT NULL DEFAULT '0' COMMENT '添加时间',
  `user_id` int(10) NOT NULL DEFAULT '0' COMMENT '用户id',
  `title` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '标题',
  `maxid` int(10) unsigned NOT NULL DEFAULT '1' COMMENT '最大id',
  PRIMARY KEY (`id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '看板主表';

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: rt_kanban_item
# ------------------------------------------------------------

DROP TABLE IF EXISTS `rt_kanban_item`;
CREATE TABLE `rt_kanban_item` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '唯一标志',
  `add_time` int(10) NOT NULL DEFAULT '0' COMMENT '添加时间',
  `update_time` int(10) NOT NULL DEFAULT '0' COMMENT '更新时间',
  `user_id` int(10) NOT NULL DEFAULT '0' COMMENT '用户id',
  `pid` int(10) NOT NULL DEFAULT '0' COMMENT '上级id',
  `title` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '标题',
  PRIMARY KEY (`id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '看板卡片内容';

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: rt_kanban_list
# ------------------------------------------------------------

DROP TABLE IF EXISTS `rt_kanban_list`;
CREATE TABLE `rt_kanban_list` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '唯一标志',
  `add_time` int(10) NOT NULL DEFAULT '0' COMMENT '添加时间',
  `update_time` int(10) NOT NULL DEFAULT '0' COMMENT '更新时间',
  `pid` int(10) NOT NULL DEFAULT '0' COMMENT '上级id',
  `title` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '标题',
  PRIMARY KEY (`id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '看板卡片列表';

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: rt_menu
# ------------------------------------------------------------

DROP TABLE IF EXISTS `rt_menu`;
CREATE TABLE `rt_menu` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `key` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `route` varchar(255) CHARACTER SET utf8 DEFAULT NULL COMMENT '权限标志',
  `href` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '前端地址',
  `type` tinyint(2) DEFAULT '0' COMMENT '0目录1菜单2按钮3权限',
  `order_num` int(10) DEFAULT '0' COMMENT '排序',
  `icon` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `open_type` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `pid` int(10) DEFAULT '0',
  `lid` tinyint(3) DEFAULT '1',
  `ifshow` tinyint(3) unsigned DEFAULT '0' COMMENT '是否显示0显示1不显示',
  `desktop` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT '桌面推荐',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `url` (`route`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 290 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '系统菜单';

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: rt_mind
# ------------------------------------------------------------

DROP TABLE IF EXISTS `rt_mind`;
CREATE TABLE `rt_mind` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '唯一标志',
  `add_time` int(10) NOT NULL DEFAULT '0' COMMENT '添加时间',
  `update_time` int(10) NOT NULL DEFAULT '0' COMMENT '更新时间',
  `user_id` int(10) NOT NULL DEFAULT '0' COMMENT '用户id',
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '标题',
  `content` text COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '内容',
  PRIMARY KEY (`id`)
) ENGINE = InnoDB AUTO_INCREMENT = 10 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '思维导图';

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: rt_mod
# ------------------------------------------------------------

DROP TABLE IF EXISTS `rt_mod`;
CREATE TABLE `rt_mod` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '唯一标志',
  `name` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '模块名称',
  `key` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '系统标志',
  `server_path` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT 'server' COMMENT '模块路径',
  `tables_main` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '主表',
  `tables_more` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '附加表',
  `type` tinyint(2) NOT NULL DEFAULT '1' COMMENT '模块类型1控制层2数据层3服务层5curd',
  `params` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '全局参数',
  `extra` text COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '扩展字段',
  `remark` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '模块说明',
  PRIMARY KEY (`id`),
  UNIQUE KEY `key` (`key`)
) ENGINE = InnoDB AUTO_INCREMENT = 60 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '系统模块表';

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: rt_params
# ------------------------------------------------------------

DROP TABLE IF EXISTS `rt_params`;
CREATE TABLE `rt_params` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '唯一标志',
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '参数名称',
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '参数值',
  `content` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '参数内容',
  `type` tinyint(2) NOT NULL DEFAULT '1' COMMENT '参数类型1文件2数字3字符串',
  PRIMARY KEY (`id`)
) ENGINE = InnoDB AUTO_INCREMENT = 3 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '全局常量表';

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: rt_picedit
# ------------------------------------------------------------

DROP TABLE IF EXISTS `rt_picedit`;
CREATE TABLE `rt_picedit` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '唯一标志',
  `add_time` int(10) NOT NULL DEFAULT '0' COMMENT '添加时间',
  `update_time` int(10) NOT NULL DEFAULT '0' COMMENT '更新时间',
  `user_id` int(10) NOT NULL DEFAULT '0' COMMENT '用户id',
  `title` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '标题',
  `content` text CHARACTER SET utf8 NOT NULL COMMENT '内容',
  PRIMARY KEY (`id`)
) ENGINE = InnoDB AUTO_INCREMENT = 17 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '图片编辑器';

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: rt_planday
# ------------------------------------------------------------

DROP TABLE IF EXISTS `rt_planday`;
CREATE TABLE `rt_planday` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '唯一标志',
  `add_time` int(10) NOT NULL DEFAULT '0' COMMENT '添加时间',
  `update_time` int(10) NOT NULL DEFAULT '0' COMMENT '更新时间',
  `user_id` int(10) NOT NULL DEFAULT '0' COMMENT '用户id',
  `title` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '标题',
  `content` text COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '内容',
  `start` int(10) NOT NULL COMMENT '开始时间',
  `end` int(10) NOT NULL COMMENT '结束时间',
  PRIMARY KEY (`id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '日程计划';

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: rt_position
# ------------------------------------------------------------

DROP TABLE IF EXISTS `rt_position`;
CREATE TABLE `rt_position` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `rules` text CHARACTER SET utf8,
  `status` tinyint(2) unsigned DEFAULT '0' COMMENT '是否可用0可用1不可用',
  `remark` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '描述',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 16 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '岗位表';

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: rt_ppt
# ------------------------------------------------------------

DROP TABLE IF EXISTS `rt_ppt`;
CREATE TABLE `rt_ppt` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '唯一标志',
  `title` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '名称',
  `content` text COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '内容',
  `add_time` int(10) NOT NULL DEFAULT '0' COMMENT '添加时间',
  `update_time` int(10) NOT NULL DEFAULT '0' COMMENT '编辑时间',
  `user_id` int(10) NOT NULL DEFAULT '0' COMMENT '用户id',
  PRIMARY KEY (`id`)
) ENGINE = InnoDB AUTO_INCREMENT = 6 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '演示文稿';

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: rt_set
# ------------------------------------------------------------

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
) ENGINE = InnoDB AUTO_INCREMENT = 13 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '系统配置表';

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: rt_svg
# ------------------------------------------------------------

DROP TABLE IF EXISTS `rt_svg`;
CREATE TABLE `rt_svg` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '唯一标志',
  `add_time` int(10) NOT NULL DEFAULT '0' COMMENT '添加时间',
  `update_time` int(10) NOT NULL DEFAULT '0' COMMENT '更新时间',
  `user_id` int(10) NOT NULL DEFAULT '0' COMMENT '用户id',
  `url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '地址',
  `title` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '标题',
  PRIMARY KEY (`id`)
) ENGINE = InnoDB AUTO_INCREMENT = 12 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = 'svg编辑器';

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: rt_txt
# ------------------------------------------------------------

DROP TABLE IF EXISTS `rt_txt`;
CREATE TABLE `rt_txt` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '唯一标志',
  `add_time` int(10) NOT NULL DEFAULT '0' COMMENT '添加时间',
  `update_time` int(10) NOT NULL DEFAULT '0' COMMENT '更新时间',
  `user_id` int(10) NOT NULL DEFAULT '0' COMMENT '用户id',
  `title` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '标题',
  `content` text COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '内容',
  PRIMARY KEY (`id`)
) ENGINE = InnoDB AUTO_INCREMENT = 10 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '文本编辑器';

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: rt_word
# ------------------------------------------------------------

DROP TABLE IF EXISTS `rt_word`;
CREATE TABLE `rt_word` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '唯一标志',
  `add_time` int(10) NOT NULL DEFAULT '0' COMMENT '添加时间',
  `update_time` int(10) NOT NULL DEFAULT '0' COMMENT '更新时间',
  `user_id` int(10) NOT NULL DEFAULT '0' COMMENT '用户id',
  `title` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '标题',
  `content` text CHARACTER SET utf8 NOT NULL COMMENT '内容',
  PRIMARY KEY (`id`)
) ENGINE = InnoDB AUTO_INCREMENT = 7 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '文档编辑器';

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: rt_admin
# ------------------------------------------------------------

INSERT INTO
  `rt_admin` (
    `username`,
    `password`,
    `admin_id`,
    `salt`,
    `add_time`,
    `name`,
    `mobile`,
    `status`,
    `login_time`,
    `login_num`,
    `update_time`
  )
VALUES
  (
    'admin',
    'dc2566634148eecbd0bd04458c7dfdc2',
    1,
    'SRcw2RSdQJjsB3mh',
    0,
    NULL,
    NULL,
    0,
    1641722321,
    339,
    0
  );
INSERT INTO
  `rt_admin` (
    `username`,
    `password`,
    `admin_id`,
    `salt`,
    `add_time`,
    `name`,
    `mobile`,
    `status`,
    `login_time`,
    `login_num`,
    `update_time`
  )
VALUES
  (
    'test',
    'c7b30ad98095b7b560585ffd6371aa47',
    2,
    'x6pdhRYF4f6bHpFc',
    1636948516,
    '1test',
    '13873150575',
    0,
    0,
    0,
    0
  );
INSERT INTO
  `rt_admin` (
    `username`,
    `password`,
    `admin_id`,
    `salt`,
    `add_time`,
    `name`,
    `mobile`,
    `status`,
    `login_time`,
    `login_num`,
    `update_time`
  )
VALUES
  (
    'test12',
    'c108dd09fba019c8b9681248c876bb4e',
    5,
    'Ahn7EScJBw3R2TZR',
    1636948870,
    '222',
    '13885863355',
    0,
    0,
    0,
    1636958930
  );

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: rt_admin_auth
# ------------------------------------------------------------

INSERT INTO
  `rt_admin_auth` (`id`, `name`, `rules`, `status`, `remark`)
VALUES
  (1, '总管理员', '-1', 0, NULL);
INSERT INTO
  `rt_admin_auth` (`id`, `name`, `rules`, `status`, `remark`)
VALUES
  (2, 'aaa', '1,4,5,7,37,53', 0, 'aaa');
INSERT INTO
  `rt_admin_auth` (`id`, `name`, `rules`, `status`, `remark`)
VALUES
  (
    15,
    'test2',
    '1,4,5,7,37,53,2,9,20,21,22,23,57,10,26,27,56,58,59,60,61,11,24,25,62,63,64,65,12,66,67,68,13,28,29,30,31,32,14,33,34,35,36,3,15',
    1,
    ''
  );

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: rt_admin_loginlog
# ------------------------------------------------------------

INSERT INTO
  `rt_admin_loginlog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    1,
    1,
    'admin登录',
    '{\"password\":\"admin\",\"username\":\"admin\",\"captcha\":\"angt\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/login/do',
    'POST',
    1636683208
  );
INSERT INTO
  `rt_admin_loginlog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    2,
    1,
    'admin登录',
    '{\"username\":\"admin\",\"captcha\":\"wueq\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/login/do',
    'POST',
    1636683396
  );
INSERT INTO
  `rt_admin_loginlog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    3,
    1,
    'admin登录',
    '{\"username\":\"admin\",\"captcha\":\"8mau\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/login/do',
    'POST',
    1636684074
  );
INSERT INTO
  `rt_admin_loginlog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    4,
    1,
    'admin登录',
    '{\"username\":\"admin\",\"captcha\":\"za72\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/login/do',
    'POST',
    1636687935
  );
INSERT INTO
  `rt_admin_loginlog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    5,
    1,
    'admin登录',
    '{\"username\":\"admin\",\"captcha\":\"cxdq\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/login/do',
    'POST',
    1636688572
  );
INSERT INTO
  `rt_admin_loginlog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    6,
    1,
    'admin登录',
    '{\"username\":\"admin\",\"captcha\":\"l3nr\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/login/do',
    'POST',
    1636689117
  );
INSERT INTO
  `rt_admin_loginlog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    7,
    1,
    'admin登录',
    '{\"username\":\"admin\",\"captcha\":\"ra5w\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/login/do',
    'POST',
    1636689550
  );
INSERT INTO
  `rt_admin_loginlog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    8,
    1,
    'admin登录',
    '{\"username\":\"admin\",\"captcha\":\"2xem\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/93.0.4577.82 Safari/537.36',
    '/server/login/do',
    'POST',
    1636689633
  );
INSERT INTO
  `rt_admin_loginlog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    9,
    1,
    'admin登录',
    '{\"username\":\"admin\",\"captcha\":\"2esr\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/93.0.4577.82 Safari/537.36',
    '/server/login/do',
    'POST',
    1636690261
  );
INSERT INTO
  `rt_admin_loginlog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    10,
    1,
    'admin登录',
    '{\"username\":\"admin\",\"captcha\":\"tqxc\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/93.0.4577.82 Safari/537.36',
    '/server/login/do',
    'POST',
    1636691944
  );
INSERT INTO
  `rt_admin_loginlog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    11,
    1,
    'admin登录',
    '{\"username\":\"admin\",\"captcha\":\"g3kj\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/93.0.4577.82 Safari/537.36',
    '/server/login/do',
    'POST',
    1636707053
  );
INSERT INTO
  `rt_admin_loginlog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    12,
    1,
    'admin登录',
    '{\"username\":\"admin\",\"captcha\":\"quyg\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/93.0.4577.82 Safari/537.36',
    '/server/login/do',
    'POST',
    1636708393
  );
INSERT INTO
  `rt_admin_loginlog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    13,
    1,
    'admin登录',
    '{\"username\":\"admin\",\"captcha\":\"spkv\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/93.0.4577.82 Safari/537.36',
    '/server/login/do',
    'POST',
    1636708927
  );
INSERT INTO
  `rt_admin_loginlog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    14,
    1,
    'admin登录',
    '{\"username\":\"admin\",\"captcha\":\"q7hv\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/93.0.4577.82 Safari/537.36',
    '/server/login/do',
    'POST',
    1636708992
  );
INSERT INTO
  `rt_admin_loginlog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    15,
    1,
    'admin登录',
    '{\"username\":\"admin\",\"captcha\":\"kvm9\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/93.0.4577.82 Safari/537.36',
    '/server/login/do',
    'POST',
    1636709026
  );
INSERT INTO
  `rt_admin_loginlog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    16,
    1,
    'admin登录',
    '{\"username\":\"admin\",\"captcha\":\"4tdv\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/93.0.4577.82 Safari/537.36',
    '/server/login/do',
    'POST',
    1636709593
  );
INSERT INTO
  `rt_admin_loginlog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    17,
    1,
    'admin登录',
    '{\"username\":\"admin\",\"captcha\":\"rnxn\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/93.0.4577.82 Safari/537.36',
    '/server/login/do',
    'POST',
    1636710000
  );
INSERT INTO
  `rt_admin_loginlog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    18,
    1,
    'admin登录',
    '{\"username\":\"admin\",\"captcha\":\"zwgk\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/93.0.4577.82 Safari/537.36',
    '/server/login/do',
    'POST',
    1636711037
  );
INSERT INTO
  `rt_admin_loginlog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    19,
    1,
    'admin登录',
    '{\"username\":\"admin\",\"captcha\":\"vz4m\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Code/1.62.0 Chrome/91.0.4472.164 Electron/13.5.1 Safari/537.36',
    '/server/login/do',
    'POST',
    1636719500
  );
INSERT INTO
  `rt_admin_loginlog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    20,
    1,
    'admin登录',
    '{\"username\":\"admin\",\"captcha\":\"csq3\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Code/1.62.0 Chrome/91.0.4472.164 Electron/13.5.1 Safari/537.36',
    '/server/login/do',
    'POST',
    1636719624
  );
INSERT INTO
  `rt_admin_loginlog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    21,
    1,
    'admin登录',
    '{\"username\":\"admin\",\"captcha\":\"5u96\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Code/1.62.0 Chrome/91.0.4472.164 Electron/13.5.1 Safari/537.36',
    '/server/login/do',
    'POST',
    1636719837
  );
INSERT INTO
  `rt_admin_loginlog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    22,
    1,
    'admin登录',
    '{\"username\":\"admin\",\"captcha\":\"ssr7\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Code/1.62.0 Chrome/91.0.4472.164 Electron/13.5.1 Safari/537.36',
    '/server/login/do',
    'POST',
    1636754198
  );

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: rt_admin_map
# ------------------------------------------------------------

INSERT INTO
  `rt_admin_map` (`map_id`, `admin_id`, `auth_id`, `type`)
VALUES
  (1, 1, 1, 0);
INSERT INTO
  `rt_admin_map` (`map_id`, `admin_id`, `auth_id`, `type`)
VALUES
  (4, 2, 2, 0);
INSERT INTO
  `rt_admin_map` (`map_id`, `admin_id`, `auth_id`, `type`)
VALUES
  (10, 5, 1, 0);

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: rt_admin_oplog
# ------------------------------------------------------------

INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    1,
    1,
    'admin登录',
    '{\"password\":\"admin\",\"username\":\"admin\",\"captcha\":\"angt\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/login/do',
    'POST',
    1636683208
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    2,
    1,
    'admin登录',
    '{\"username\":\"admin\",\"captcha\":\"wueq\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/login/do',
    'POST',
    1636683396
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    3,
    1,
    'admin登录',
    '{\"username\":\"admin\",\"captcha\":\"8mau\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/login/do',
    'POST',
    1636684074
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    4,
    1,
    'admin登录',
    '{\"username\":\"admin\",\"captcha\":\"za72\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/login/do',
    'POST',
    1636687935
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    5,
    1,
    'admin登录',
    '{\"username\":\"admin\",\"captcha\":\"cxdq\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/login/do',
    'POST',
    1636688572
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    6,
    1,
    'admin登录',
    '{\"username\":\"admin\",\"captcha\":\"l3nr\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/login/do',
    'POST',
    1636689117
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    7,
    1,
    'admin登录',
    '{\"username\":\"admin\",\"captcha\":\"ra5w\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/login/do',
    'POST',
    1636689550
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    8,
    1,
    'admin登录',
    '{\"username\":\"admin\",\"captcha\":\"2xem\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/93.0.4577.82 Safari/537.36',
    '/server/login/do',
    'POST',
    1636689633
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    9,
    1,
    'admin登录',
    '{\"username\":\"admin\",\"captcha\":\"2esr\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/93.0.4577.82 Safari/537.36',
    '/server/login/do',
    'POST',
    1636690261
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    10,
    1,
    'admin登录',
    '{\"username\":\"admin\",\"captcha\":\"tqxc\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/93.0.4577.82 Safari/537.36',
    '/server/login/do',
    'POST',
    1636691944
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    11,
    1,
    'admin登录',
    '{\"username\":\"admin\",\"captcha\":\"g3kj\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/93.0.4577.82 Safari/537.36',
    '/server/login/do',
    'POST',
    1636707053
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    12,
    1,
    'admin登录',
    '{\"username\":\"admin\",\"captcha\":\"quyg\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/93.0.4577.82 Safari/537.36',
    '/server/login/do',
    'POST',
    1636708393
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    13,
    1,
    'admin登录',
    '{\"username\":\"admin\",\"captcha\":\"spkv\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/93.0.4577.82 Safari/537.36',
    '/server/login/do',
    'POST',
    1636708927
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    14,
    1,
    'admin登录',
    '{\"username\":\"admin\",\"captcha\":\"q7hv\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/93.0.4577.82 Safari/537.36',
    '/server/login/do',
    'POST',
    1636708992
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    15,
    1,
    'admin登录',
    '{\"username\":\"admin\",\"captcha\":\"kvm9\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/93.0.4577.82 Safari/537.36',
    '/server/login/do',
    'POST',
    1636709026
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    16,
    1,
    'admin登录',
    '{\"username\":\"admin\",\"captcha\":\"4tdv\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/93.0.4577.82 Safari/537.36',
    '/server/login/do',
    'POST',
    1636709593
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    17,
    1,
    'admin登录',
    '{\"username\":\"admin\",\"captcha\":\"rnxn\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/93.0.4577.82 Safari/537.36',
    '/server/login/do',
    'POST',
    1636710000
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    18,
    1,
    'admin登录',
    '{\"username\":\"admin\",\"captcha\":\"zwgk\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/93.0.4577.82 Safari/537.36',
    '/server/login/do',
    'POST',
    1636711037
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    19,
    1,
    'admin登录',
    '{\"username\":\"admin\",\"captcha\":\"tjvj\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Code/1.62.1 Chrome/91.0.4472.164 Electron/13.5.2 Safari/537.36',
    '/server/login/do',
    'POST',
    1636760259
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    20,
    1,
    'admin登录',
    '{\"username\":\"admin\",\"captcha\":\"zjem\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/93.0.4577.82 Safari/537.36',
    '/server/login/do',
    'POST',
    1636769860
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    21,
    1,
    'admin登录',
    '{\"username\":\"admin\",\"captcha\":\"2aac\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/93.0.4577.82 Safari/537.36',
    '/server/login/do',
    'POST',
    1636770059
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    22,
    1,
    'admin登录',
    '{\"username\":\"admin\",\"captcha\":\"rg8q\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/login/do',
    'POST',
    1636770165
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    23,
    1,
    'admin登录',
    '{\"username\":\"admin\",\"captcha\":\"38ay\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/login/do',
    'POST',
    1636777200
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    24,
    1,
    'admin登录',
    '{\"username\":\"admin\",\"captcha\":\"ccbj\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/login/do',
    'POST',
    1636777527
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    25,
    1,
    'admin登录',
    '{\"username\":\"admin\",\"captcha\":\"thxe\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/93.0.4577.82 Safari/537.36',
    '/server/login/do',
    'POST',
    1636777620
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    26,
    1,
    'admin登录',
    '{\"username\":\"admin\",\"captcha\":\"fqqp\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/login/do',
    'POST',
    1636778519
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    27,
    1,
    'admin登录',
    '{\"username\":\"admin\",\"captcha\":\"xwwb\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/login/do',
    'POST',
    1636778607
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    28,
    1,
    'admin登录',
    '{\"username\":\"admin\",\"captcha\":\"s6gy\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/login/do',
    'POST',
    1636778736
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    29,
    1,
    'admin登录',
    '{\"username\":\"admin\",\"captcha\":\"x9k4\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/login/do',
    'POST',
    1636778869
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    30,
    1,
    'admin登录',
    '{\"username\":\"admin\",\"captcha\":\"3mdo\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/login/do',
    'POST',
    1636781312
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    31,
    1,
    'admin登录',
    '{\"username\":\"admin\",\"captcha\":\"yrhv\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/login/do',
    'POST',
    1636784601
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    32,
    1,
    'admin登录',
    '{\"username\":\"admin\",\"captcha\":\"5kfs\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/login/do',
    'POST',
    1636788224
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    33,
    1,
    'admin登录',
    '{\"username\":\"admin\",\"captcha\":\"9etk\"}',
    '::ffff:127.0.0.1',
    'PostmanRuntime/7.28.4',
    '/server/login/do',
    'POST',
    1636790308
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    34,
    1,
    'admin登录',
    '{\"username\":\"admin\",\"captcha\":\"rrxy\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/login/do',
    'POST',
    1636791000
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    35,
    1,
    'admin登录',
    '{\"username\":\"admin\",\"captcha\":\"j42m\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/login/do',
    'POST',
    1636792621
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    36,
    1,
    'admin登录',
    '{\"username\":\"admin\",\"captcha\":\"tgcw\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/login/do',
    'POST',
    1636792990
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    37,
    1,
    'admin登录',
    '{\"username\":\"admin\",\"captcha\":\"zhlr\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/login/do',
    'POST',
    1636793350
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    38,
    1,
    'admin登录',
    '{\"username\":\"admin\",\"captcha\":\"mn3f\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/login/do',
    'POST',
    1636796303
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    39,
    1,
    'admin登录',
    '{\"username\":\"admin\",\"captcha\":\"vhld\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/login/do',
    'POST',
    1636796968
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    40,
    1,
    'admin登录',
    '{\"username\":\"admin\",\"captcha\":\"qfkw\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/login/do',
    'POST',
    1636797088
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    41,
    1,
    'admin登录',
    '{\"username\":\"admin\",\"captcha\":\"ucma\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/login/do',
    'POST',
    1636847701
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    42,
    1,
    '设置菜单显示',
    '{\"id\":\"3\",\"ifshow\":\"0\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/ifshow',
    'POST',
    1636850164
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    43,
    1,
    'admin登录',
    '{\"username\":\"admin\",\"captcha\":\"5zpj\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/login/do',
    'POST',
    1636850932
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    44,
    1,
    '设置菜单显示',
    '{\"id\":\"3\",\"ifshow\":\"1\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/ifshow',
    'POST',
    1636850942
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    45,
    1,
    'admin登录',
    '{\"username\":\"admin\",\"captcha\":\"jf9m\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/login/do',
    'POST',
    1636851796
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    46,
    1,
    '用户登录',
    '{\"username\":\"admin\",\"captcha\":\"crhq\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/login/do',
    'POST',
    1636853681
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    47,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"zmsc\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/login/do',
    'POST',
    1636855313
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    48,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"h3ae\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/login/do',
    'POST',
    1636855489
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    49,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"f7mx\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/login/do',
    'POST',
    1636856772
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    50,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"zvba\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/login/do',
    'POST',
    1636864423
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    51,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"vyyh\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/login/do',
    'POST',
    1636864729
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    52,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"uuqr\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/login/do',
    'POST',
    1636864815
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    53,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"pzpt\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/login/do',
    'POST',
    1636864927
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    54,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"uaro\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/login/do',
    'POST',
    1636864997
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    55,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"ebxu\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/login/do',
    'POST',
    1636865023
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    56,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"drxv\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/login/do',
    'POST',
    1636867592
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    57,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"b5du\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/login/do',
    'POST',
    1636867712
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    58,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"ku9t\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/login/do',
    'POST',
    1636873872
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    59,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"t545\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/login/do',
    'POST',
    1636877578
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    60,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"xhy8\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/login/do',
    'POST',
    1636885287
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    61,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"rbg2\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/login/do',
    'POST',
    1636930153
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    62,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"3kkj\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/login/do',
    'POST',
    1636930845
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    63,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"aekt\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/login/do',
    'POST',
    1636933195
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    64,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"lz3s\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/login/do',
    'POST',
    1636933445
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    65,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"rwt3\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/login/do',
    'POST',
    1636934002
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    66,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"cffy\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/login/do',
    'POST',
    1636937582
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    67,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"czda\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/login/do',
    'POST',
    1636941888
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    68,
    1,
    '编辑菜单',
    '{\"title\":\"管理员管理\",\"pname\":\"系统管理\",\"route\":\"admin/index\",\"href\":\"\",\"icon\":\"layui-icon layui-icon-key\",\"type\":\"1\",\"order_num\":\"11\",\"id\":\"11\",\"pid\":\"2\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/edit',
    'POST',
    1636941924
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    69,
    1,
    '编辑菜单',
    '{\"title\":\"管理员管理\",\"pname\":\"系统管理\",\"route\":\"admin/list\",\"href\":\"view/admin/list\",\"icon\":\"layui-icon layui-icon-key\",\"type\":\"1\",\"order_num\":\"11\",\"id\":\"11\",\"pid\":\"2\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/edit',
    'POST',
    1636941981
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    70,
    1,
    '编辑菜单',
    '{\"title\":\"管理员管理\",\"pname\":\"系统管理\",\"route\":\"admin/list\",\"href\":\"view/admin/list.html\",\"icon\":\"layui-icon layui-icon-key\",\"type\":\"1\",\"order_num\":\"11\",\"id\":\"11\",\"pid\":\"2\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/edit',
    'POST',
    1636942018
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    71,
    1,
    '添加菜单',
    '{\"title\":\"管理员添加前\",\"pname\":\"11\",\"route\":\"admin/addBefore\",\"href\":\"\",\"icon\":\"\",\"type\":\"3\",\"order_num\":\"0\",\"pid\":\"11\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/add',
    'POST',
    1636944104
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    72,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"xu9a\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/login/do',
    'POST',
    1636945520
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    73,
    1,
    '添加菜单',
    '{\"title\":\"添加管理员\",\"pname\":\"11\",\"route\":\"admin/add\",\"href\":\"\",\"icon\":\"layui-icon layui-icon-windows\",\"type\":\"2\",\"order_num\":\"0\",\"pid\":\"11\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/add',
    'POST',
    1636947931
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    74,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"ch7a\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/login/do',
    'POST',
    1636949587
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    75,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"lhtp\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/login/do',
    'POST',
    1636949669
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    76,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"3e8n\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/login/do',
    'POST',
    1636949737
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    77,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"mywv\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/login/do',
    'POST',
    1636949843
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    78,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"qxgd\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/login/do',
    'POST',
    1636949890
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    79,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"a4gc\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/login/do',
    'POST',
    1636950046
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    80,
    1,
    '添加菜单',
    '{\"title\":\"编辑管理员前\",\"pname\":\"11\",\"route\":\"admin/editBefore\",\"href\":\"\",\"icon\":\"layui-icon layui-icon-export\",\"type\":\"3\",\"order_num\":\"0\",\"pid\":\"11\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/add',
    'POST',
    1636950088
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    81,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"nhhu\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/login/do',
    'POST',
    1636957714
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    82,
    1,
    '编辑菜单',
    '{\"title\":\"编辑管理员\",\"pname\":\"管理员管理\",\"route\":\"admin/edit\",\"href\":\"\",\"icon\":\"layui-icon layui-icon-time\",\"type\":\"2\",\"order_num\":\"20\",\"id\":\"24\",\"pid\":\"11\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/edit',
    'POST',
    1636958889
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    83,
    1,
    '编辑菜单',
    '{\"title\":\"删除管理员\",\"pname\":\"管理员管理\",\"route\":\"admin/del\",\"href\":\"\",\"icon\":\"layui-icon layui-icon-more-vertical\",\"type\":\"2\",\"order_num\":\"21\",\"id\":\"25\",\"pid\":\"11\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/edit',
    'POST',
    1636959517
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    84,
    1,
    '编辑菜单',
    '{\"title\":\"管理员编辑前\",\"pname\":\"管理员管理\",\"route\":\"admin/editBefore\",\"href\":\"\",\"icon\":\"layui-icon layui-icon-export\",\"type\":\"3\",\"order_num\":\"0\",\"id\":\"64\",\"pid\":\"11\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/edit',
    'POST',
    1636959542
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    85,
    1,
    '编辑菜单',
    '{\"title\":\"日志管理\",\"pname\":\"系统管理\",\"route\":\"logs\",\"href\":\"\",\"icon\":\"layui-icon layui-icon-spread-left\",\"type\":\"0\",\"order_num\":\"12\",\"id\":\"12\",\"pid\":\"2\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/edit',
    'POST',
    1636959580
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    86,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"6ave\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/login/do',
    'POST',
    1636961221
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    87,
    1,
    '设置角色可用',
    '{\"id\":\"2\",\"status\":\"1\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/auth/enable',
    'POST',
    1636962371
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    88,
    1,
    '设置角色可用',
    '{\"id\":\"2\",\"status\":\"0\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/auth/enable',
    'POST',
    1636962383
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    89,
    1,
    '添加菜单',
    '{\"title\":\"管理员启用禁用\",\"pname\":\"11\",\"route\":\"admin/enable\",\"href\":\"\",\"icon\":\"layui-icon layui-icon-slider\",\"type\":\"2\",\"order_num\":\"0\",\"pid\":\"11\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/add',
    'POST',
    1636962429
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    90,
    1,
    '设置管理员可用',
    '{\"id\":\"5\",\"status\":\"0\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/admin/enable',
    'POST',
    1636962435
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    91,
    1,
    '设置管理员可用',
    '{\"id\":\"5\",\"status\":\"1\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/admin/enable',
    'POST',
    1636962436
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    92,
    1,
    '设置管理员可用',
    '{\"id\":\"5\",\"status\":\"0\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/admin/enable',
    'POST',
    1636962446
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    93,
    1,
    '添加菜单',
    '{\"title\":\"操作日志\",\"pname\":\"12\",\"route\":\"logs/opList\",\"href\":\"view/logs/op.html\",\"icon\":\"layui-icon layui-icon-date\",\"type\":\"1\",\"order_num\":\"0\",\"pid\":\"12\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/add',
    'POST',
    1636964785
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    94,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"2wtg\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/login/do',
    'POST',
    1636965938
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    95,
    1,
    '编辑菜单',
    '{\"title\":\"操作日志\",\"pname\":\"日志管理\",\"route\":\"logs/op\",\"href\":\"view/logs/op.html\",\"icon\":\"layui-icon layui-icon-date\",\"type\":\"1\",\"order_num\":\"0\",\"id\":\"66\",\"pid\":\"12\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/edit',
    'POST',
    1636965966
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    96,
    1,
    '添加菜单',
    '{\"title\":\"行为日志\",\"pname\":\"12\",\"route\":\"logs/view\",\"href\":\"view/logs/view.html\",\"icon\":\"layui-icon layui-icon-cols\",\"type\":\"1\",\"order_num\":\"0\",\"pid\":\"12\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/add',
    'POST',
    1636966010
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    97,
    1,
    '添加菜单',
    '{\"title\":\"错误日志\",\"pname\":\"12\",\"route\":\"logs/err\",\"href\":\"view/logs/err.html\",\"icon\":\"layui-icon layui-icon-survey\",\"type\":\"1\",\"order_num\":\"0\",\"pid\":\"12\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/add',
    'POST',
    1636966045
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    98,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"kq77\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/login/do',
    'POST',
    1636968651
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    99,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"qw4n\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/login/do',
    'POST',
    1637020753
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    100,
    1,
    '编辑菜单',
    '{\"title\":\"系统设置\",\"pname\":\"系统管理\",\"route\":\"set/cate\",\"href\":\"\",\"icon\":\"layui-icon layui-icon-find-fill\",\"type\":\"1\",\"order_num\":\"13\",\"id\":\"13\",\"pid\":\"2\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/edit',
    'POST',
    1637023335
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    101,
    1,
    '编辑菜单',
    '{\"title\":\"系统设置\",\"pname\":\"系统管理\",\"route\":\"set/cate\",\"href\":\"view/set/cate.html\",\"icon\":\"layui-icon layui-icon-find-fill\",\"type\":\"1\",\"order_num\":\"13\",\"id\":\"13\",\"pid\":\"2\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/edit',
    'POST',
    1637023402
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    102,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"5agy\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/login/do',
    'POST',
    1637027945
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    103,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"qyvh\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/login/do',
    'POST',
    1637028098
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    104,
    1,
    '添加菜单',
    '{\"title\":\"test\",\"pname\":\"3\",\"route\":\"tet\",\"href\":\"\",\"icon\":\"\",\"type\":\"0\",\"order_num\":\"0\",\"pid\":\"3\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/add',
    'POST',
    1637028919
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    105,
    1,
    '删除菜单',
    '{\"id\":69}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/del',
    'POST',
    1637028927
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    106,
    1,
    '添加菜单',
    '{\"title\":\"test\",\"pname\":\"3\",\"route\":\"ttt\",\"href\":\"\",\"icon\":\"\",\"type\":\"0\",\"order_num\":\"0\",\"pid\":\"3\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/add',
    'POST',
    1637029256
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    107,
    1,
    '删除菜单',
    '{\"id\":70}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/del',
    'POST',
    1637029261
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    108,
    1,
    '添加菜单',
    '{\"title\":\"test\",\"pname\":\"3\",\"route\":\"ttt\",\"href\":\"\",\"icon\":\"\",\"type\":\"0\",\"order_num\":\"0\",\"pid\":\"3\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/add',
    'POST',
    1637029596
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    109,
    1,
    '删除菜单',
    '{\"id\":71}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/del',
    'POST',
    1637030256
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    110,
    1,
    '添加菜单',
    '{\"title\":\"test\",\"pname\":\"0\",\"route\":\"ttt\",\"href\":\"\",\"icon\":\"layui-icon layui-icon-heart-fill\",\"type\":\"0\",\"order_num\":\"0\",\"pid\":\"0\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/add',
    'POST',
    1637030982
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    111,
    1,
    '删除菜单',
    '{\"id\":72}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/del',
    'POST',
    1637031150
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    112,
    1,
    '添加菜单',
    '{\"title\":\"test\",\"pname\":\"0\",\"route\":\"ttt\",\"href\":\"\",\"icon\":\"\",\"type\":\"0\",\"order_num\":\"0\",\"pid\":\"0\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/add',
    'POST',
    1637031472
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    113,
    1,
    '添加菜单',
    '{\"title\":\"tttt\",\"pname\":\"0\",\"route\":\"ttt\",\"href\":\"\",\"icon\":\"\",\"type\":\"0\",\"order_num\":\"0\",\"pid\":\"0\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/add',
    'POST',
    1637031483
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    114,
    1,
    '删除菜单',
    '{\"id\":73}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/del',
    'POST',
    1637031488
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    115,
    1,
    '添加菜单',
    '{\"title\":\"ttt\",\"pname\":\"74\",\"route\":\"ttttt\",\"href\":\"\",\"icon\":\"\",\"type\":\"0\",\"order_num\":\"0\",\"pid\":\"74\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/add',
    'POST',
    1637031501
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    116,
    1,
    '删除菜单',
    '{\"id\":74}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/del',
    'POST',
    1637031506
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    117,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"tnks\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/login/do',
    'POST',
    1637031563
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    118,
    1,
    '添加菜单',
    '{\"title\":\"tttt\",\"pname\":\"75\",\"route\":\"tttttt\",\"href\":\"\",\"icon\":\"\",\"type\":\"0\",\"order_num\":\"0\",\"pid\":\"75\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/add',
    'POST',
    1637032000
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    119,
    1,
    '删除菜单',
    '{\"id\":76}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/del',
    'POST',
    1637033138
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    120,
    1,
    '删除菜单',
    '{\"id\":75}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/del',
    'POST',
    1637033142
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    121,
    1,
    '添加菜单',
    '{\"title\":\"test\",\"pname\":\"0\",\"route\":\"test\",\"href\":\"\",\"icon\":\"\",\"type\":0,\"order_num\":0,\"pid\":0}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/add',
    'POST',
    1637034082
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    122,
    1,
    '删除菜单',
    '{\"id\":77}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/del',
    'POST',
    1637034087
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    123,
    1,
    '设置菜单显示',
    '{\"id\":3,\"ifshow\":0}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/ifshow',
    'POST',
    1637034286
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    124,
    1,
    '设置菜单显示',
    '{\"id\":3,\"ifshow\":1}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/ifshow',
    'POST',
    1637034293
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    125,
    1,
    '编辑菜单',
    '{\"title\":\"前端菜单\",\"pname\":\"公共模块\",\"route\":\"menu/list\",\"href\":\"\",\"icon\":\"layui-icon layui-icon-mike\",\"type\":3,\"order_num\":0,\"id\":15,\"pid\":3}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/edit',
    'POST',
    1637034309
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    126,
    1,
    '编辑菜单',
    '{\"title\":\"前端菜单\",\"pname\":\"公共模块\",\"route\":\"menu/list\",\"href\":\"\",\"icon\":\"layui-icon layui-icon-transfer\",\"type\":3,\"order_num\":0,\"id\":15,\"pid\":3}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/edit',
    'POST',
    1637034432
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    127,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"mxpk\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/login/do',
    'POST',
    1637035880
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    128,
    1,
    '添加角色',
    '{\"name\":\"test\",\"status\":0,\"id\":\"15\",\"remark\":\"\",\"rules\":\"1,4,5,7,37,53,2,9,20,21,22,23,57,10,26,27,56,58,59,60,61,11,24,25,62,63,64,65,12,66,67,68,13,28,29,30,31,32,14,33,34,35,36,3,15\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/auth/add',
    'POST',
    1637036280
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    129,
    1,
    '编辑角色',
    '{\"name\":\"test2\",\"status\":0,\"id\":15,\"remark\":\"\",\"rules\":\"1,4,5,7,37,53,2,9,20,21,22,23,57,10,26,27,56,58,59,60,61,11,24,25,62,63,64,65,12,66,67,68,13,28,29,30,31,32,14,33,34,35,36,3,15\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/auth/edit',
    'POST',
    1637037071
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    130,
    1,
    '设置角色可用',
    '{\"id\":15,\"status\":0}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/auth/enable',
    'POST',
    1637037175
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    131,
    1,
    '设置角色可用',
    '{\"id\":15,\"status\":1}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/auth/enable',
    'POST',
    1637037179
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    132,
    1,
    '添加管理员',
    '{\"username\":\"t4e\",\"name\":\"11111\",\"mobile\":\"13888888888\",\"status\":0,\"layuiTreeCheck_2\":\"2\",\"remark\":\"\",\"rules\":\"2\",\"salt\":\"KJBmzRxjAy5HMSPh\",\"add_time\":1637038189}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/admin/add',
    'POST',
    1637038189
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    133,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"foen\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/login/do',
    'POST',
    1637039428
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    134,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"x4vd\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/login/do',
    'POST',
    1637039566
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    135,
    1,
    '编辑管理员',
    '{\"username\":\"t4e\",\"name\":\"11111\",\"mobile\":\"13888888888\",\"status\":0,\"layuiTreeCheck_2\":\"2\",\"remark\":\"\",\"admin_id\":6,\"rules\":\"2\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/admin/edit',
    'POST',
    1637039790
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    136,
    1,
    '编辑管理员',
    '{\"username\":\"t4e2\",\"name\":\"11111\",\"mobile\":\"13888888888\",\"status\":0,\"layuiTreeCheck_2\":\"2\",\"remark\":\"\",\"admin_id\":6,\"rules\":\"2\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/admin/edit',
    'POST',
    1637039796
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    137,
    1,
    '删除管理员',
    '{\"admin_id\":6}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/admin/del',
    'POST',
    1637039978
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    138,
    1,
    '设置管理员可用',
    '{\"id\":5,\"status\":1}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/admin/enable',
    'POST',
    1637040173
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    139,
    1,
    '设置管理员可用',
    '{\"id\":5,\"status\":0}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/admin/enable',
    'POST',
    1637040174
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    140,
    1,
    '添加管理员',
    '{\"username\":\"ttttt\",\"name\":\"11\",\"mobile\":\"13985858888\",\"status\":0,\"layuiTreeCheck_2\":\"2\",\"remark\":\"\",\"rules\":\"2\",\"salt\":\"ZEJEKTwNiefHP4QQ\",\"add_time\":1637040196}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/admin/add',
    'POST',
    1637040196
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    141,
    1,
    '编辑管理员',
    '{\"username\":\"ttttt2\",\"name\":\"11\",\"mobile\":\"13985858888\",\"status\":0,\"layuiTreeCheck_2\":\"2\",\"remark\":\"\",\"admin_id\":7,\"rules\":\"2\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/admin/edit',
    'POST',
    1637040203
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    142,
    1,
    '删除管理员',
    '{\"admin_id\":7}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/admin/del',
    'POST',
    1637040206
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    143,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"8cs2\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/login/do',
    'POST',
    1637052507
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    144,
    1,
    '添加菜单',
    '{\"title\":\"添加系统配置类目\",\"pname\":\"13\",\"route\":\"set/cateAdd\",\"href\":\"view/set/cate_add.html\",\"icon\":\"layui-icon layui-icon-windows\",\"type\":2,\"order_num\":0,\"pid\":13}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/add',
    'POST',
    1637055590
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    145,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"r4bz\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/login/do',
    'POST',
    1637056412
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    146,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"y9hd\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/93.0.4577.82 Safari/537.36',
    '/server/login/do',
    'POST',
    1637056463
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    147,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"ftjc\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/login/do',
    'POST',
    1637107308
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    148,
    1,
    '添加菜单',
    '{\"title\":\"编辑系统类目前\",\"pname\":\"13\",\"route\":\"set/cateEditBefore\",\"href\":\"view/set/cate_edit.html\",\"icon\":\"layui-icon layui-icon-windows\",\"type\":2,\"order_num\":0,\"pid\":13}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/add',
    'POST',
    1637108007
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    149,
    1,
    '添加菜单',
    '{\"title\":\"编辑系统类目\",\"pname\":\"13\",\"route\":\"set/cateEdit\",\"href\":\"\",\"icon\":\"layui-icon layui-icon-template\",\"type\":3,\"order_num\":0,\"pid\":13}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/add',
    'POST',
    1637108058
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    150,
    1,
    '添加菜单',
    '{\"title\":\"删除配置类目\",\"pname\":\"13\",\"route\":\"set/cateDelete\",\"href\":\"\",\"icon\":\"layui-icon layui-icon-component\",\"type\":3,\"order_num\":0,\"pid\":13}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/add',
    'POST',
    1637109232
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    151,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"qwnd\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/login/do',
    'POST',
    1637111011
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    152,
    1,
    '编辑菜单',
    '{\"title\":\"添加配置\",\"pname\":\"系统设置\",\"route\":\"set/add\",\"href\":\"\",\"icon\":\"layui-icon layui-icon-at\",\"type\":2,\"order_num\":24,\"id\":28,\"pid\":13}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/edit',
    'POST',
    1637111056
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    153,
    1,
    '编辑菜单',
    '{\"title\":\"配置列表\",\"pname\":\"系统设置\",\"route\":\"set/list\",\"href\":\"\",\"icon\":\"layui-icon layui-icon-transfer\",\"type\":2,\"order_num\":26,\"id\":30,\"pid\":13}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/edit',
    'POST',
    1637112427
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    154,
    1,
    '编辑菜单',
    '{\"title\":\"删除配置\",\"pname\":\"系统设置\",\"route\":\"set/delete\",\"href\":\"\",\"icon\":\"layui-icon layui-icon-mute\",\"type\":2,\"order_num\":25,\"id\":29,\"pid\":13}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/edit',
    'POST',
    1637112783
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    155,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"cjpt\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/login/do',
    'POST',
    1637116135
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    156,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"tvuz\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/login/do',
    'POST',
    1637123746
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    157,
    1,
    '编辑菜单',
    '{\"title\":\"系统设计\",\"pname\":\"系统管理\",\"route\":\"design\",\"href\":\"\",\"icon\":\"layui-icon layui-icon-fonts-code\",\"type\":0,\"order_num\":31,\"id\":35,\"pid\":2}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/edit',
    'POST',
    1637123851
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    158,
    1,
    '添加菜单',
    '{\"title\":\"表单设计器\",\"pname\":\"35\",\"route\":\"design/form\",\"href\":\"view/design/form.html\",\"icon\":\"layui-icon layui-icon-template-1\",\"type\":1,\"order_num\":0,\"pid\":35}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/add',
    'POST',
    1637123948
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    159,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"vxkp\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/login/do',
    'POST',
    1637139982
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    160,
    1,
    '编辑菜单',
    '{\"title\":\"表单设计器\",\"pname\":\"系统设计\",\"route\":\"form/list\",\"href\":\"view/form/list.html\",\"icon\":\"layui-icon layui-icon-template-1\",\"type\":1,\"order_num\":0,\"id\":82,\"pid\":35}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/edit',
    'POST',
    1637141826
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    161,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"kq7u\"}',
    '::1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/93.0.4577.82 Safari/537.36',
    '/server/login/do',
    'POST',
    1637198112
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    162,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"lrzj\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/login/do',
    'POST',
    1637201238
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    163,
    1,
    '添加菜单',
    '{\"title\":\"添加表单\",\"pname\":\"82\",\"route\":\"form/add\",\"href\":\"view/form/add.html\",\"icon\":\"layui-icon layui-icon-auz\",\"type\":2,\"order_num\":0,\"pid\":82}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/add',
    'POST',
    1637201424
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    164,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"dglj\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/login/do',
    'POST',
    1637205247
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    165,
    1,
    '删除菜单',
    '{\"id\":81}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/del',
    'POST',
    1637205366
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    166,
    1,
    '删除菜单',
    '{\"id\":80}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/del',
    'POST',
    1637205371
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    167,
    1,
    '删除菜单',
    '{\"id\":79}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/del',
    'POST',
    1637205381
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    168,
    1,
    '删除菜单',
    '{\"id\":78}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/del',
    'POST',
    1637205386
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    169,
    1,
    '编辑菜单',
    '{\"title\":\"系统设置\",\"pname\":\"系统管理\",\"route\":\"set/cate\",\"href\":\"view/set/list.html\",\"icon\":\"layui-icon layui-icon-find-fill\",\"type\":1,\"order_num\":13,\"id\":13,\"pid\":2}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/edit',
    'POST',
    1637205401
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    170,
    1,
    '删除菜单',
    '{\"id\":30}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/del',
    'POST',
    1637205491
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    171,
    1,
    '编辑菜单',
    '{\"title\":\"编辑配置\",\"pname\":\"系统设置\",\"route\":\"set/edit\",\"href\":\"\",\"icon\":\"layui-icon layui-icon-export\",\"type\":2,\"order_num\":27,\"id\":31,\"pid\":13}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/edit',
    'POST',
    1637208797
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    172,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"bcsu\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/login/do',
    'POST',
    1637208866
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    173,
    1,
    '编辑菜单',
    '{\"title\":\"编辑配置前\",\"pname\":\"系统设置\",\"route\":\"set/editBefore\",\"href\":\"\",\"icon\":\"layui-icon layui-icon-rate-half\",\"type\":3,\"order_num\":28,\"id\":32,\"pid\":13}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/edit',
    'POST',
    1637208906
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    174,
    1,
    '编辑菜单',
    '{\"title\":\"系统设置\",\"pname\":\"系统管理\",\"route\":\"set/list\",\"href\":\"view/set/list.html\",\"icon\":\"layui-icon layui-icon-find-fill\",\"type\":1,\"order_num\":13,\"id\":13,\"pid\":2}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/edit',
    'POST',
    1637208944
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    175,
    1,
    '添加菜单',
    '{\"title\":\"设置配置可用\",\"pname\":\"13\",\"route\":\"set/enable\",\"href\":\"\",\"icon\":\"\",\"type\":3,\"order_num\":0,\"pid\":13}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/add',
    'POST',
    1637209991
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    176,
    1,
    '设置配置可用',
    '{\"id\":12,\"status\":0}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/set/enable',
    'POST',
    1637210042
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    177,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"kmbb\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/login/do',
    'POST',
    1637212679
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    178,
    1,
    '添加菜单',
    '{\"title\":\"添加表单前\",\"pname\":\"82\",\"route\":\"form/addBefore\",\"href\":\"\",\"icon\":\"layui-icon layui-icon-headset\",\"type\":3,\"order_num\":0,\"pid\":82}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/add',
    'POST',
    1637212896
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    179,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"7u8v\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/login/do',
    'POST',
    1637222000
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    180,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"38dg\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/login/do',
    'POST',
    1637225814
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    181,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"kbla\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/login/do',
    'POST',
    1637229759
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    182,
    1,
    '添加菜单',
    '{\"title\":\"设置配置前\",\"pname\":\"13\",\"route\":\"set/setBefore\",\"href\":\"\",\"icon\":\"layui-icon layui-icon-at\",\"type\":3,\"order_num\":0,\"pid\":13}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/add',
    'POST',
    1637232296
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    183,
    1,
    '添加菜单',
    '{\"title\":\"设置配置\",\"pname\":\"13\",\"route\":\"set/setConf\",\"href\":\"\",\"icon\":\"layui-icon layui-icon-404\",\"type\":3,\"order_num\":0,\"pid\":13}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/add',
    'POST',
    1637232332
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    184,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"q27r\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/login/do',
    'POST',
    1637278992
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    185,
    1,
    '编辑菜单',
    '{\"title\":\"表单设计器\",\"pname\":\"2\",\"route\":\"form/list\",\"href\":\"view/form/list.html\",\"icon\":\"layui-icon layui-icon-template-1\",\"type\":1,\"order_num\":0,\"id\":82,\"pid\":2}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/edit',
    'POST',
    1637279183
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    186,
    1,
    '编辑菜单',
    '{\"title\":\"数据库设计\",\"pname\":\"系统管理\",\"route\":\"db/list\",\"href\":\"db/list.html\",\"icon\":\"layui-icon layui-icon-layouts\",\"type\":1,\"order_num\":31,\"id\":35,\"pid\":2}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/edit',
    'POST',
    1637279223
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    187,
    1,
    '编辑菜单',
    '{\"title\":\"系统字典\",\"pname\":\"系统管理\",\"route\":\"cate/index\",\"href\":\"\",\"icon\":\"layui-icon layui-icon-fonts-clear\",\"type\":1,\"order_num\":32,\"id\":36,\"pid\":2}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/edit',
    'POST',
    1637279260
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    188,
    1,
    '编辑菜单',
    '{\"title\":\"表单设计器\",\"pname\":\"系统管理\",\"route\":\"form/list\",\"href\":\"view/form/list.html\",\"icon\":\"layui-icon layui-icon-template-1\",\"type\":1,\"order_num\":31,\"id\":82,\"pid\":2}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/edit',
    'POST',
    1637279285
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    189,
    1,
    '编辑菜单',
    '{\"title\":\"系统字典\",\"pname\":\"系统管理\",\"route\":\"cate/index\",\"href\":\"\",\"icon\":\"layui-icon layui-icon-fonts-clear\",\"type\":1,\"order_num\":50,\"id\":36,\"pid\":2}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/edit',
    'POST',
    1637279295
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    190,
    1,
    '编辑菜单',
    '{\"title\":\"数据库设计\",\"pname\":\"系统管理\",\"route\":\"db/list\",\"href\":\"view/db/list.html\",\"icon\":\"layui-icon layui-icon-layouts\",\"type\":1,\"order_num\":31,\"id\":35,\"pid\":2}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/edit',
    'POST',
    1637281307
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    191,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"yvjx\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/login/do',
    'POST',
    1637282800
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    192,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"3f5x\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/login/do',
    'POST',
    1637286423
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    193,
    1,
    '编辑菜单',
    '{\"title\":\"数据表设计\",\"pname\":\"系统管理\",\"route\":\"db/list\",\"href\":\"view/db/list.html\",\"icon\":\"layui-icon layui-icon-layouts\",\"type\":1,\"order_num\":31,\"id\":35,\"pid\":2}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/edit',
    'POST',
    1637287584
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    194,
    1,
    '添加菜单',
    '{\"title\":\"更新表缓存\",\"pname\":\"35\",\"route\":\"db/update\",\"href\":\"\",\"icon\":\"layui-icon layui-icon-refresh\",\"type\":1,\"order_num\":0,\"pid\":35}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/add',
    'POST',
    1637287821
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    195,
    1,
    '编辑菜单',
    '{\"title\":\"更新表缓存\",\"pname\":\"数据表设计\",\"route\":\"db/update\",\"href\":\"\",\"icon\":\"layui-icon layui-icon-refresh\",\"type\":2,\"order_num\":0,\"id\":88,\"pid\":35}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/edit',
    'POST',
    1637287847
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    196,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"quvk\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/login/do',
    'POST',
    1637293146
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    197,
    1,
    '添加菜单',
    '{\"title\":\"备份数据\",\"pname\":\"35\",\"route\":\"db/backup\",\"href\":\"\",\"icon\":\"layui-icon layui-icon-templeate-1\",\"type\":2,\"order_num\":0,\"pid\":35}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/add',
    'POST',
    1637293324
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    198,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"uc9l\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/login/do',
    'POST',
    1637296765
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    199,
    1,
    '添加菜单',
    '{\"title\":\"还原数据列表\",\"pname\":\"35\",\"route\":\"db/backupFile\",\"href\":\"\",\"icon\":\"layui-icon layui-icon-list\",\"type\":2,\"order_num\":0,\"pid\":35}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/add',
    'POST',
    1637296812
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    200,
    1,
    '添加菜单',
    '{\"title\":\"数据还原\",\"pname\":\"35\",\"route\":\"db/reback\",\"href\":\"\",\"icon\":\"layui-icon layui-icon-water\",\"type\":2,\"order_num\":0,\"pid\":35}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/add',
    'POST',
    1637297488
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    201,
    1,
    '编辑菜单',
    '{\"title\":\"数据还原2\",\"pname\":\"数据表设计\",\"route\":\"db/reback\",\"href\":\"\",\"icon\":\"layui-icon layui-icon-water\",\"type\":2,\"order_num\":0,\"id\":91,\"pid\":35}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/edit',
    'POST',
    1637297619
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    202,
    1,
    '添加菜单',
    '{\"title\":\"删除备份\",\"pname\":\"35\",\"route\":\"db/delback\",\"href\":\"\",\"icon\":\"layui-icon layui-icon-down\",\"type\":2,\"order_num\":0,\"pid\":35}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/add',
    'POST',
    1637298574
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    203,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"dfnm\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/login/do',
    'POST',
    1637305837
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    204,
    1,
    '添加菜单',
    '{\"title\":\"数据库文档\",\"pname\":\"35\",\"route\":\"db/doc\",\"href\":\"\",\"icon\":\"layui-icon layui-icon-service\",\"type\":2,\"order_num\":0,\"pid\":35}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/add',
    'POST',
    1637308898
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    205,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"ocgr\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/login/do',
    'POST',
    1637309763
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    206,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"bdzc\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/login/do',
    'POST',
    1637313775
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    207,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"huo9\"}',
    '::1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/93.0.4577.82 Safari/537.36',
    '/server/login/do',
    'POST',
    1637314347
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    208,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"f7yu\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/login/do',
    'POST',
    1637316500
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    209,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"ajyd\"}',
    '::1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/95.0.4638.54 Safari/537.36',
    '/server/login/do',
    'POST',
    1637322964
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    210,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"gtew\"}',
    '::1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/95.0.4638.54 Safari/537.36',
    '/server/login/do',
    'POST',
    1637330154
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    211,
    1,
    '添加菜单',
    '{\"title\":\"编辑列表内容\",\"pname\":\"35\",\"route\":\"db/editTable\",\"href\":\"\",\"icon\":\"layui-icon layui-icon-link\",\"type\":2,\"order_num\":0,\"pid\":35}',
    '::1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/95.0.4638.54 Safari/537.36',
    '/server/menu/add',
    'POST',
    1637332155
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    212,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"dr2z\"}',
    '::1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/95.0.4638.54 Safari/537.36',
    '/server/login/do',
    'POST',
    1637333854
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    213,
    1,
    '添加菜单',
    '{\"title\":\"优化表\",\"pname\":\"35\",\"route\":\"db/optimize\",\"href\":\"\",\"icon\":\"layui-icon layui-icon-rss\",\"type\":2,\"order_num\":0,\"pid\":35}',
    '::1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/95.0.4638.54 Safari/537.36',
    '/server/menu/add',
    'POST',
    1637337102
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    214,
    1,
    '添加菜单',
    '{\"title\":\"修复表\",\"pname\":\"35\",\"route\":\"db/repair\",\"href\":\"\",\"icon\":\"layui-icon layui-icon-rate-solid\",\"type\":2,\"order_num\":0,\"pid\":35}',
    '::1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/95.0.4638.54 Safari/537.36',
    '/server/menu/add',
    'POST',
    1637337155
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    215,
    1,
    '编辑菜单',
    '{\"title\":\"数据还原\",\"pname\":\"数据表设计\",\"route\":\"db/reback\",\"href\":\"\",\"icon\":\"layui-icon layui-icon-water\",\"type\":2,\"order_num\":0,\"id\":91,\"pid\":35}',
    '::1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/95.0.4638.54 Safari/537.36',
    '/server/menu/edit',
    'POST',
    1637337188
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    216,
    1,
    '添加菜单',
    '{\"title\":\"删除表\",\"pname\":\"35\",\"route\":\"db/delTable\",\"href\":\"\",\"icon\":\"layui-icon layui-icon-subtraction\",\"type\":2,\"order_num\":0,\"pid\":35}',
    '::1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/95.0.4638.54 Safari/537.36',
    '/server/menu/add',
    'POST',
    1637337232
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    217,
    1,
    '添加菜单',
    '{\"title\":\"清空表\",\"pname\":\"35\",\"route\":\"db/clear\",\"href\":\"\",\"icon\":\"layui-icon layui-icon-unlink\",\"type\":2,\"order_num\":0,\"pid\":35}',
    '::1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/95.0.4638.54 Safari/537.36',
    '/server/menu/add',
    'POST',
    1637337279
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    218,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"5spa\"}',
    '::1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/95.0.4638.54 Safari/537.36',
    '/server/login/do',
    'POST',
    1637338095
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    219,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"dsbn\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/login/do',
    'POST',
    1637370840
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    220,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"4a7h\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/login/do',
    'POST',
    1637371660
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    221,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"j4yv\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/login/do',
    'POST',
    1637371669
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    222,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"8t32\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/login/do',
    'POST',
    1637371693
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    223,
    1,
    '添加菜单',
    '{\"title\":\"字段列表\",\"pname\":\"35\",\"route\":\"db/fieldList\",\"href\":\"\",\"icon\":\"layui-icon layui-icon-star-fill\",\"type\":2,\"order_num\":0,\"pid\":35}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/add',
    'POST',
    1637379386
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    224,
    1,
    '添加菜单',
    '{\"title\":\"展示表数据\",\"pname\":\"35\",\"route\":\"db/listData\",\"href\":\"\",\"icon\":\"layui-icon layui-icon-transfer\",\"type\":2,\"order_num\":0,\"pid\":35}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/add',
    'POST',
    1637380293
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    225,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"t4cp\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/login/do',
    'POST',
    1637388954
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    226,
    1,
    '添加菜单',
    '{\"title\":\"编辑数据\",\"pname\":\"35\",\"route\":\"db/editData\",\"href\":\"\",\"icon\":\"layui-icon layui-icon-mike\",\"type\":3,\"order_num\":0,\"pid\":35}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/add',
    'POST',
    1637389295
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    227,
    1,
    '添加菜单',
    '{\"title\":\"删除数据\",\"pname\":\"35\",\"route\":\"db/delData\",\"href\":\"\",\"icon\":\"layui-icon layui-icon-fonts-del\",\"type\":2,\"order_num\":0,\"pid\":35}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/add',
    'POST',
    1637393228
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    228,
    1,
    '添加菜单',
    '{\"title\":\"数据库字段列表\",\"pname\":\"35\",\"route\":\"db/fields\",\"href\":\"view/db/edit.html\",\"icon\":\"layui-icon layui-icon-auz\",\"type\":2,\"order_num\":0,\"pid\":35}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/add',
    'POST',
    1637400438
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    229,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"nw6u\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/login/do',
    'POST',
    1637400506
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    230,
    1,
    '添加菜单',
    '{\"title\":\"删除字段\",\"pname\":\"35\",\"route\":\"db/delField\",\"href\":\"\",\"icon\":\"layui-icon layui-icon-subtraction\",\"type\":2,\"order_num\":0,\"pid\":35}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/add',
    'POST',
    1637405311
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    231,
    1,
    '添加菜单',
    '{\"title\":\"字段排序\",\"pname\":\"35\",\"route\":\"db/sortField\",\"href\":\"\",\"icon\":\"layui-icon layui-icon-slider\",\"type\":2,\"order_num\":0,\"pid\":35}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/add',
    'POST',
    1637406651
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    232,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"nxjl\"}',
    '::1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/95.0.4638.54 Safari/537.36',
    '/server/login/do',
    'POST',
    1637409694
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    233,
    1,
    '添加菜单',
    '{\"title\":\"更改字段名\",\"pname\":\"35\",\"route\":\"db/changeFieldName\",\"href\":\"\",\"icon\":\"layui-icon layui-icon-find-fill\",\"type\":2,\"order_num\":0,\"pid\":35}',
    '::1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/95.0.4638.54 Safari/537.36',
    '/server/menu/add',
    'POST',
    1637414672
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    234,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"km6r\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/login/do',
    'POST',
    1637458328
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    235,
    1,
    '添加菜单',
    '{\"title\":\"设置字段为空或自增长\",\"pname\":\"35\",\"route\":\"db/setStatus\",\"href\":\"\",\"icon\":\"layui-icon layui-icon-camera\",\"type\":2,\"order_num\":0,\"pid\":35}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/add',
    'POST',
    1637461264
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    236,
    1,
    '添加菜单',
    '{\"title\":\"添加字段\",\"pname\":\"35\",\"route\":\"db/addField\",\"href\":\"\",\"icon\":\"layui-icon layui-icon-website\",\"type\":2,\"order_num\":0,\"pid\":35}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/add',
    'POST',
    1637489235
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    237,
    1,
    '添加菜单',
    '{\"title\":\"表索引列表\",\"pname\":\"35\",\"route\":\"db/keysList\",\"href\":\"\",\"icon\":\"layui-icon layui-icon-wifi\",\"type\":2,\"order_num\":0,\"pid\":35}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/add',
    'POST',
    1637490750
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    238,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"gtw7\"}',
    '::1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/95.0.4638.54 Safari/537.36',
    '/server/login/do',
    'POST',
    1637494850
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    239,
    1,
    '编辑菜单',
    '{\"title\":\"数据库设计器\",\"pname\":\"系统管理\",\"route\":\"db/list\",\"href\":\"view/db/list.html\",\"icon\":\"layui-icon layui-icon-table\",\"type\":1,\"order_num\":31,\"id\":35,\"pid\":2}',
    '::1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/95.0.4638.54 Safari/537.36',
    '/server/menu/edit',
    'POST',
    1637494942
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    240,
    1,
    '编辑菜单',
    '{\"title\":\"表单设计器\",\"pname\":\"系统管理\",\"route\":\"form/list\",\"href\":\"view/form/list.html\",\"icon\":\"layui-icon layui-icon-form\",\"type\":1,\"order_num\":31,\"id\":82,\"pid\":2}',
    '::1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/95.0.4638.54 Safari/537.36',
    '/server/menu/edit',
    'POST',
    1637494996
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    241,
    1,
    '编辑菜单',
    '{\"title\":\"数据库设计器\",\"pname\":\"系统管理\",\"route\":\"db/list\",\"href\":\"view/db/list.html\",\"icon\":\"layui-icon layui-icon-template-1\",\"type\":1,\"order_num\":31,\"id\":35,\"pid\":2}',
    '::1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/95.0.4638.54 Safari/537.36',
    '/server/menu/edit',
    'POST',
    1637495008
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    242,
    1,
    '添加菜单',
    '{\"title\":\"删除索引\",\"pname\":\"35\",\"route\":\"db/delKey\",\"href\":\"\",\"icon\":\"layui-icon layui-icon-download-circle\",\"type\":2,\"order_num\":0,\"pid\":35}',
    '::1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/95.0.4638.54 Safari/537.36',
    '/server/menu/add',
    'POST',
    1637496539
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    243,
    1,
    '添加菜单',
    '{\"title\":\"设置索引\",\"pname\":\"35\",\"route\":\"db/setKey\",\"href\":\"\",\"icon\":\"layui-icon layui-icon-layer\",\"type\":2,\"order_num\":0,\"pid\":35}',
    '::1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/95.0.4638.54 Safari/537.36',
    '/server/menu/add',
    'POST',
    1637498516
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    244,
    1,
    '添加菜单',
    '{\"title\":\"创建表\",\"pname\":\"35\",\"route\":\"db/createTable\",\"href\":\"\",\"icon\":\"layui-icon layui-icon-transfer\",\"type\":2,\"order_num\":0,\"pid\":35}',
    '::1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/95.0.4638.54 Safari/537.36',
    '/server/menu/add',
    'POST',
    1637501722
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    245,
    1,
    '添加菜单',
    '{\"title\":\"复制表\",\"pname\":\"35\",\"route\":\"db/opcopy\",\"href\":\"\",\"icon\":\"layui-icon layui-icon-fonts-clear\",\"type\":2,\"order_num\":0,\"pid\":35}',
    '::1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/95.0.4638.54 Safari/537.36',
    '/server/menu/add',
    'POST',
    1637502932
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    246,
    1,
    '添加菜单',
    '{\"title\":\"执行Sql\",\"pname\":\"35\",\"route\":\"db/runSql\",\"href\":\"\",\"icon\":\"layui-icon layui-icon-light\",\"type\":2,\"order_num\":0,\"pid\":35}',
    '::1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/95.0.4638.54 Safari/537.36',
    '/server/menu/add',
    'POST',
    1637505223
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    247,
    1,
    '添加菜单',
    '{\"title\":\"获取创建Sql\",\"pname\":\"35\",\"route\":\"db/getSql\",\"href\":\"\",\"icon\":\"layui-icon layui-icon-service\",\"type\":2,\"order_num\":0,\"pid\":35}',
    '::1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/95.0.4638.54 Safari/537.36',
    '/server/menu/add',
    'POST',
    1637505417
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    248,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"gxpk\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/login/do',
    'POST',
    1637541837
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    249,
    1,
    '添加菜单',
    '{\"title\":\"模块管理\",\"pname\":\"2\",\"route\":\"mod/list\",\"href\":\"view/mod/list.html\",\"icon\":\"layui-icon layui-icon-slider\",\"type\":1,\"order_num\":0,\"pid\":2}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/add',
    'POST',
    1637544783
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    250,
    1,
    '添加菜单',
    '{\"title\":\"添加模块\",\"pname\":\"116\",\"route\":\"mod/add\",\"href\":\"\",\"icon\":\"layui-icon layui-icon-read\",\"type\":2,\"order_num\":0,\"pid\":116}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/add',
    'POST',
    1637544851
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    251,
    1,
    '添加菜单',
    '{\"title\":\"模块编辑前\",\"pname\":\"116\",\"route\":\"mod/editBefore\",\"href\":\"\",\"icon\":\"layui-icon layui-icon-set-sm\",\"type\":2,\"order_num\":0,\"pid\":116}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/add',
    'POST',
    1637544885
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    252,
    1,
    '添加菜单',
    '{\"title\":\"编辑模块\",\"pname\":\"116\",\"route\":\"mod/edit\",\"href\":\"\",\"icon\":\"layui-icon layui-icon-share\",\"type\":2,\"order_num\":0,\"pid\":116}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/add',
    'POST',
    1637544934
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    253,
    1,
    '添加菜单',
    '{\"title\":\"删除模块\",\"pname\":\"116\",\"route\":\"mod/delete\",\"href\":\"\",\"icon\":\"layui-icon layui-icon-chat\",\"type\":2,\"order_num\":0,\"pid\":116}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/add',
    'POST',
    1637544965
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    254,
    1,
    '添加菜单',
    '{\"title\":\"模块添加前\",\"pname\":\"116\",\"route\":\"mod/addBefore\",\"href\":\"\",\"icon\":\"layui-icon layui-icon-slider\",\"type\":3,\"order_num\":0,\"pid\":116}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/add',
    'POST',
    1637548933
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    255,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"ghnf\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/login/do',
    'POST',
    1637625446
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    256,
    1,
    '添加菜单',
    '{\"title\":\"批量删除表\",\"pname\":\"35\",\"route\":\"db/batchRemove\",\"href\":\"\",\"icon\":\"layui-icon layui-icon-fonts-del\",\"type\":2,\"order_num\":0,\"pid\":35}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/add',
    'POST',
    1637639126
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    257,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"gkwr\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/login/do',
    'POST',
    1637639672
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    258,
    1,
    '添加菜单',
    '{\"title\":\"列表编辑字段\",\"pname\":\"9\",\"route\":\"menu/editData\",\"href\":\"\",\"icon\":\"layui-icon layui-icon-key\",\"type\":2,\"order_num\":0,\"pid\":9}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/add',
    'POST',
    1637641890
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    259,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"mtsq\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/login/do',
    'POST',
    1637642218
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    260,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"7qzj\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/login/do',
    'POST',
    1637642823
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    261,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"2s9q\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/login/do',
    'POST',
    1637711574
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    262,
    1,
    '添加菜单',
    '{\"title\":\"全局常量管理\",\"pname\":\"116\",\"route\":\"mod/params\",\"href\":\"\",\"icon\":\"layui-icon layui-icon-dollar\",\"type\":2,\"order_num\":0,\"pid\":116}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/add',
    'POST',
    1637713209
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    263,
    1,
    '添加菜单',
    '{\"title\":\"常量编辑前\",\"pname\":\"116\",\"route\":\"mod/paramsBefore\",\"href\":\"\",\"icon\":\"layui-icon layui-icon-at\",\"type\":2,\"order_num\":0,\"pid\":116}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/add',
    'POST',
    1637713818
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    264,
    1,
    '添加菜单',
    '{\"title\":\"添加全局常量\",\"pname\":\"116\",\"route\":\"mod/paramsAdd\",\"href\":\"\",\"icon\":\"layui-icon layui-icon-addition\",\"type\":2,\"order_num\":0,\"pid\":116}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/add',
    'POST',
    1637714435
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    265,
    1,
    '添加菜单',
    '{\"title\":\"编辑全局常量\",\"pname\":\"116\",\"route\":\"mod/paramsEdit\",\"href\":\"\",\"icon\":\"layui-icon layui-icon-print\",\"type\":2,\"order_num\":0,\"pid\":116}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/add',
    'POST',
    1637714458
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    266,
    1,
    '添加菜单',
    '{\"title\":\"删除全局常量\",\"pname\":\"116\",\"route\":\"mod/paramDelete\",\"href\":\"\",\"icon\":\"layui-icon layui-icon-subtraction\",\"type\":2,\"order_num\":0,\"pid\":116}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/add',
    'POST',
    1637714864
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    267,
    1,
    '添加菜单',
    '{\"title\":\"接口设计器\",\"pname\":\"2\",\"route\":\"api/list\",\"href\":\"view/api/list.html\",\"icon\":\"layui-icon layui-icon-ios\",\"type\":1,\"order_num\":0,\"pid\":2}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/add',
    'POST',
    1637727762
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    268,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"fwbc\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/login/do',
    'POST',
    1637727777
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    269,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"xgcs\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/login/do',
    'POST',
    1637727893
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    270,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"td2c\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/login/do',
    'POST',
    1637797636
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    271,
    1,
    '添加菜单',
    '{\"title\":\"添加数据\",\"pname\":\"35\",\"route\":\"db/addData\",\"href\":\"views/db/data-add.html\",\"icon\":\"layui-icon layui-icon-mike\",\"type\":2,\"order_num\":0,\"pid\":35}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/add',
    'POST',
    1637812720
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    272,
    1,
    '添加菜单',
    '{\"title\":\"数据库列表\",\"pname\":\"35\",\"route\":\"db/confList\",\"href\":\"\",\"icon\":\"layui-icon layui-icon-wifi\",\"type\":2,\"order_num\":0,\"pid\":35}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/add',
    'POST',
    1637814442
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    273,
    1,
    '添加菜单',
    '{\"title\":\"添加数据库\",\"pname\":\"35\",\"route\":\"db/confAdd\",\"href\":\"\",\"icon\":\"layui-icon layui-icon-email\",\"type\":2,\"order_num\":0,\"pid\":35}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/add',
    'POST',
    1637814475
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    274,
    1,
    '添加菜单',
    '{\"title\":\"编辑数据库\",\"pname\":\"35\",\"route\":\"db/confEdit\",\"href\":\"\",\"icon\":\"layui-icon layui-icon-rss\",\"type\":2,\"order_num\":0,\"pid\":35}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/add',
    'POST',
    1637814503
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    275,
    1,
    '添加菜单',
    '{\"title\":\"测试数据库连接\",\"pname\":\"35\",\"route\":\"db/confTest\",\"href\":\"\",\"icon\":\"layui-icon layui-icon-logout\",\"type\":2,\"order_num\":0,\"pid\":35}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/add',
    'POST',
    1637814535
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    276,
    1,
    '添加菜单',
    '{\"title\":\"删除数据库\",\"pname\":\"35\",\"route\":\"db/confDel\",\"href\":\"\",\"icon\":\"layui-icon layui-icon-subtraction\",\"type\":2,\"order_num\":0,\"pid\":35}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/add',
    'POST',
    1637814566
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    277,
    1,
    '编辑菜单',
    '{\"title\":\"设置字段\",\"pname\":\"数据库设计器\",\"route\":\"db/setStatus\",\"href\":\"\",\"icon\":\"layui-icon layui-icon-camera\",\"type\":2,\"order_num\":0,\"id\":107,\"pid\":35}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/edit',
    'POST',
    1637814586
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    278,
    1,
    '添加菜单',
    '{\"title\":\"更换数据库\",\"pname\":\"35\",\"route\":\"db/confChange\",\"href\":\"\",\"icon\":\"layui-icon layui-icon-transfer\",\"type\":2,\"order_num\":0,\"pid\":35}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/add',
    'POST',
    1637815759
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    279,
    1,
    '添加菜单',
    '{\"title\":\"编辑数据库前\",\"pname\":\"35\",\"route\":\"db/confEditBefore\",\"href\":\"\",\"icon\":\"layui-icon layui-icon-snowflake\",\"type\":3,\"order_num\":0,\"pid\":35}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/add',
    'POST',
    1637817580
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    280,
    1,
    '添加菜单',
    '{\"title\":\"保护列表\",\"pname\":\"35\",\"route\":\"db/safeList\",\"href\":\"\",\"icon\":\"layui-icon layui-icon-camera\",\"type\":2,\"order_num\":0,\"pid\":35}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/add',
    'POST',
    1637829436
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    281,
    1,
    '添加菜单',
    '{\"title\":\"添加保护\",\"pname\":\"35\",\"route\":\"db/safeAdd\",\"href\":\"\",\"icon\":\"layui-icon layui-icon-addition\",\"type\":2,\"order_num\":0,\"pid\":35}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/add',
    'POST',
    1637829479
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    282,
    1,
    '添加菜单',
    '{\"title\":\"删除保护\",\"pname\":\"35\",\"route\":\"db/safeDel\",\"href\":\"\",\"icon\":\"layui-icon layui-icon-subtraction\",\"type\":2,\"order_num\":0,\"pid\":35}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/add',
    'POST',
    1637829535
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    283,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"8uyz\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/login/do',
    'POST',
    1637830100
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    284,
    1,
    '添加菜单',
    '{\"title\":\"添加数据库\",\"pname\":\"35\",\"route\":\"db/creatDatabase\",\"href\":\"\",\"icon\":\"layui-icon layui-icon-align-left\",\"type\":2,\"order_num\":0,\"pid\":35}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/add',
    'POST',
    1637832116
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    285,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"swnd\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/login/do',
    'POST',
    1637885594
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    286,
    1,
    '添加菜单',
    '{\"title\":\"上传文件\",\"pname\":\"3\",\"route\":\"upload/file\",\"href\":\"\",\"icon\":\"layui-icon layui-icon-upload-drag\",\"type\":3,\"order_num\":0,\"pid\":3}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/add',
    'POST',
    1637886979
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    287,
    1,
    '设置菜单显示',
    '{\"id\":142,\"ifshow\":1}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/ifshow',
    'POST',
    1637886986
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    288,
    1,
    '编辑菜单',
    '{\"title\":\"上传文件\",\"pname\":\"公共模块\",\"route\":\"upload/index\",\"href\":\"\",\"icon\":\"layui-icon layui-icon-upload-drag\",\"type\":3,\"order_num\":0,\"id\":142,\"pid\":3}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/edit',
    'POST',
    1637887503
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    289,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"bsf2\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/login/do',
    'POST',
    1637971387
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    290,
    1,
    '添加菜单',
    '{\"title\":\"注销登录\",\"pname\":\"3\",\"route\":\"admin/loginOut\",\"href\":\"\",\"icon\":\"layui-icon layui-icon-delete\",\"type\":2,\"order_num\":0,\"pid\":3}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/add',
    'POST',
    1637983849
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    291,
    1,
    '设置菜单显示',
    '{\"id\":143,\"ifshow\":1}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/ifshow',
    'POST',
    1637983853
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    292,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"nj4a\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/login/do',
    'POST',
    1637983880
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    293,
    1,
    '编辑菜单',
    '{\"title\":\"角色管理\",\"pname\":\"1\",\"route\":\"auth/list\",\"href\":\"view/auth/index.html\",\"icon\":\"layui-icon layui-icon-service\",\"type\":1,\"order_num\":10,\"id\":10,\"pid\":1}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/edit',
    'POST',
    1637984459
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    294,
    1,
    '编辑菜单',
    '{\"title\":\"管理员管理\",\"pname\":\"1\",\"route\":\"admin/list\",\"href\":\"view/admin/list.html\",\"icon\":\"layui-icon layui-icon-key\",\"type\":1,\"order_num\":11,\"id\":11,\"pid\":1}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/edit',
    'POST',
    1637984474
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    295,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"fvxm\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/login/do',
    'POST',
    1637984519
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    296,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"dht3\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/login/do',
    'POST',
    1638004552
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    297,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"bft8\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/login/do',
    'POST',
    1638060102
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    298,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"5nd4\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/login/do',
    'POST',
    1638096421
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    299,
    1,
    '编辑菜单',
    '{\"title\":\"计划任务\",\"pname\":\"系统管理\",\"route\":\"crons/list\",\"href\":\"view/crons/list.html\",\"icon\":\"layui-icon layui-icon-android\",\"type\":1,\"order_num\":9,\"id\":144,\"pid\":2}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/edit',
    'POST',
    1638096488
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    300,
    1,
    '删除菜单',
    '{\"id\":34}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/del',
    'POST',
    1638096518
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    301,
    1,
    '删除菜单',
    '{\"id\":33}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/del',
    'POST',
    1638096522
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    302,
    1,
    '删除菜单',
    '{\"id\":14}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/del',
    'POST',
    1638096526
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    303,
    1,
    '删除菜单',
    '{\"id\":36}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/del',
    'POST',
    1638096597
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    304,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"o5tn\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/login/do',
    'POST',
    1638096629
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    305,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"zsj3\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/login/do',
    'POST',
    1638156128
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    306,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"rnrx\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/login/do',
    'POST',
    1638156466
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    307,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"p8t3\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/login/do',
    'POST',
    1638229591
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    308,
    1,
    '编辑菜单',
    '{\"title\":\"演示文稿\",\"pname\":\"内容管理\",\"route\":\"ppt/list\",\"href\":\"view/ppt/list.html\",\"icon\":\"layui-icon layui-icon-transfer\",\"type\":1,\"order_num\":0,\"id\":149,\"pid\":1}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/edit',
    'POST',
    1638229977
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    309,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"h2mf\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/login/do',
    'POST',
    1638230989
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    310,
    1,
    '删除菜单',
    '{\"id\":37}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/del',
    'POST',
    1638235991
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    311,
    1,
    '删除菜单',
    '{\"id\":5}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/del',
    'POST',
    1638235999
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    312,
    1,
    '删除菜单',
    '{\"id\":4}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/del',
    'POST',
    1638236003
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    313,
    1,
    '删除菜单',
    '{\"id\":7}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/del',
    'POST',
    1638236008
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    314,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"dy35\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/login/do',
    'POST',
    1638236053
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    315,
    1,
    '编辑菜单',
    '{\"title\":\"首页工作台\",\"pname\":\"内容管理\",\"route\":\"index/welcome\",\"href\":\"view/index/welcome.html\",\"icon\":\"layui-icon layui-icon-rate-solid\",\"type\":1,\"order_num\":1,\"id\":53,\"pid\":1}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/edit',
    'POST',
    1638236271
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    316,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"vmxr\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/login/do',
    'POST',
    1638239040
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    317,
    1,
    '添加菜单',
    '{\"title\":\"导入EXCEL\",\"pname\":\"159\",\"route\":\"excel/upload\",\"href\":\"\",\"icon\":\"layui-icon layui-icon-fonts-code\",\"type\":2,\"order_num\":0,\"pid\":159}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/add',
    'POST',
    1638246067
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    318,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"n7f2\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/login/do',
    'POST',
    1638246457
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    319,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"cffe\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/login/do',
    'POST',
    1638331653
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    320,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"gtop\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/login/do',
    'POST',
    1638331793
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    321,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"5459\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/login/do',
    'POST',
    1638337427
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    322,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"lons\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/login/do',
    'POST',
    1638401441
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    323,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"rayd\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/login/do',
    'POST',
    1638418412
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    324,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"msuv\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/login/do',
    'POST',
    1638441140
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    325,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"wzuq\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/login/do',
    'POST',
    1638490113
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    326,
    1,
    '添加菜单',
    '{\"title\":\"文档添加前\",\"pname\":\"170\",\"route\":\"doc/addBefore\",\"href\":\"\",\"icon\":\"layui-icon layui-icon-at\",\"type\":3,\"order_num\":0,\"pid\":170}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/add',
    'POST',
    1638500902
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    327,
    1,
    '添加菜单',
    '{\"title\":\"上传文件\",\"pname\":\"170\",\"route\":\"doc/upload\",\"href\":\"\",\"icon\":\"layui-icon layui-icon-addition\",\"type\":3,\"order_num\":0,\"pid\":170}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/add',
    'POST',
    1638502463
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    328,
    1,
    '添加菜单',
    '{\"title\":\"新增文档\",\"pname\":\"170\",\"route\":\"doc/addmd\",\"href\":\"\",\"icon\":\"layui-icon layui-icon-praise\",\"type\":2,\"order_num\":0,\"pid\":170}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/add',
    'POST',
    1638508040
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    329,
    1,
    '添加菜单',
    '{\"title\":\"文档列表\",\"pname\":\"170\",\"route\":\"doc/listmd\",\"href\":\"\",\"icon\":\"layui-icon layui-icon-link\",\"type\":3,\"order_num\":0,\"pid\":170}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/add',
    'POST',
    1638516639
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    330,
    1,
    '添加菜单',
    '{\"title\":\"编辑文档前\",\"pname\":\"170\",\"route\":\"doc/editmdBefore\",\"href\":\"\",\"icon\":\"layui-icon layui-icon-read\",\"type\":3,\"order_num\":0,\"pid\":170}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/add',
    'POST',
    1638518052
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    331,
    1,
    '添加菜单',
    '{\"title\":\"编辑文档\",\"pname\":\"170\",\"route\":\"doc/editmd\",\"href\":\"\",\"icon\":\"layui-icon layui-icon-transfer\",\"type\":3,\"order_num\":0,\"pid\":170}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/add',
    'POST',
    1638521121
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    332,
    1,
    '添加菜单',
    '{\"title\":\"删除文档\",\"pname\":\"170\",\"route\":\"doc/delmd\",\"href\":\"\",\"icon\":\"layui-icon layui-icon-logout\",\"type\":3,\"order_num\":0,\"pid\":170}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/add',
    'POST',
    1638521832
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    333,
    1,
    '添加菜单',
    '{\"title\":\"编辑文档列表\",\"pname\":\"170\",\"route\":\"doc/editData\",\"href\":\"\",\"icon\":\"layui-icon layui-icon-email\",\"type\":3,\"order_num\":0,\"pid\":170}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/add',
    'POST',
    1638522299
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    334,
    1,
    '添加菜单',
    '{\"title\":\"回写数据\",\"pname\":\"170\",\"route\":\"doc/back\",\"href\":\"\",\"icon\":\"layui-icon layui-icon-windows\",\"type\":3,\"order_num\":0,\"pid\":170}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/add',
    'POST',
    1638525733
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    335,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"r7dq\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/login/do',
    'POST',
    1638576610
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    336,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"szfw\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/login/do',
    'POST',
    1638577554
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    337,
    1,
    '添加菜单',
    '{\"title\":\"接口添加前\",\"pname\":\"184\",\"route\":\"api/addBefore\",\"href\":\"\",\"icon\":\"layui-icon layui-icon-key\",\"type\":3,\"order_num\":0,\"pid\":184}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/add',
    'POST',
    1638587555
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    338,
    1,
    '添加菜单',
    '{\"title\":\"文章管理\",\"pname\":\"1\",\"route\":\"art\",\"href\":\"\",\"icon\":\"layui-icon layui-icon-slider\",\"type\":1,\"order_num\":0,\"pid\":1}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/add',
    'POST',
    1638591849
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    339,
    1,
    '删除菜单',
    '{\"id\":191}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/del',
    'POST',
    1638592590
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    340,
    1,
    '删除菜单',
    '{\"id\":192}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/del',
    'POST',
    1638592594
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    341,
    1,
    '删除菜单',
    '{\"id\":193}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/del',
    'POST',
    1638592598
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    342,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"juzu\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/login/do',
    'POST',
    1638661797
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    343,
    1,
    '添加菜单',
    '{\"title\":\"接口参数列表\",\"pname\":\"184\",\"route\":\"apiparams/list\",\"href\":\"\",\"icon\":\"layui-icon layui-icon-key\",\"type\":2,\"order_num\":0,\"pid\":184}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/add',
    'POST',
    1638663449
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    344,
    1,
    '添加菜单',
    '{\"title\":\"从数据库添加参数\",\"pname\":\"184\",\"route\":\"apiparams/addFromDb\",\"href\":\"\",\"icon\":\"layui-icon layui-icon-logout\",\"type\":2,\"order_num\":0,\"pid\":184}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/add',
    'POST',
    1638679061
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    345,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"ugm9\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/login/do',
    'POST',
    1638755567
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    346,
    1,
    '添加菜单',
    '{\"title\":\"编辑参数列表名字\",\"pname\":\"184\",\"route\":\"apiparams/editData\",\"href\":\"\",\"icon\":\"layui-icon layui-icon-transfer\",\"type\":3,\"order_num\":0,\"pid\":184}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/add',
    'POST',
    1638758164
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    347,
    1,
    '添加菜单',
    '{\"title\":\"删除接口参数\",\"pname\":\"184\",\"route\":\"apiparams/del\",\"href\":\"\",\"icon\":\"layui-icon layui-icon-subtraction\",\"type\":3,\"order_num\":0,\"pid\":184}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/add',
    'POST',
    1638763168
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    348,
    1,
    '添加菜单',
    '{\"title\":\"接口参数编辑前\",\"pname\":\"184\",\"route\":\"apiparams/editBefore\",\"href\":\"\",\"icon\":\"layui-icon layui-icon-rate\",\"type\":3,\"order_num\":0,\"pid\":184}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/add',
    'POST',
    1638766373
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    349,
    1,
    '添加菜单',
    '{\"title\":\"添加接口参数\",\"pname\":\"184\",\"route\":\"apiparams/add\",\"href\":\"\",\"icon\":\"layui-icon layui-icon-service\",\"type\":3,\"order_num\":0,\"pid\":184}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/add',
    'POST',
    1638766432
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    350,
    1,
    '添加菜单',
    '{\"title\":\"编辑接口参数\",\"pname\":\"184\",\"route\":\"apiparams/edit\",\"href\":\"\",\"icon\":\"layui-icon layui-icon-camera\",\"type\":3,\"order_num\":0,\"pid\":184}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/add',
    'POST',
    1638766461
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    351,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"phzs\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/login/do',
    'POST',
    1638840210
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    352,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"zju4\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/login/do',
    'POST',
    1638874466
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    353,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"ojnm\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/login/do',
    'POST',
    1639027727
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    354,
    1,
    '添加菜单',
    '{\"title\":\"更新接口代码\",\"pname\":\"184\",\"route\":\"api/addLogic\",\"href\":\"\",\"icon\":\"layui-icon layui-icon-android\",\"type\":3,\"order_num\":0,\"pid\":184}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/menu/add',
    'POST',
    1639028711
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    355,
    1,
    '添加菜单',
    '{\"title\":\"获取接口代码\",\"pname\":\"184\",\"route\":\"api/getLogic\",\"href\":\"\",\"icon\":\"layui-icon layui-icon-share\",\"type\":3,\"order_num\":0,\"pid\":184}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/menu/add',
    'POST',
    1639029862
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    356,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"mmar\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/login/do',
    'POST',
    1639037023
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    357,
    1,
    '添加菜单',
    '{\"title\":\"设计程序\",\"pname\":\"206\",\"route\":\"code/editCode\",\"href\":\"\",\"icon\":\"layui-icon layui-icon-spread-left\",\"type\":3,\"order_num\":0,\"pid\":206}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/menu/add',
    'POST',
    1639043611
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    358,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"335p\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/login/do',
    'POST',
    1639093982
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    359,
    1,
    '添加菜单',
    '{\"title\":\"分页新增\",\"pname\":\"184\",\"route\":\"apiparams/addPage\",\"href\":\"\",\"icon\":\"layui-icon layui-icon-wifi\",\"type\":3,\"order_num\":0,\"pid\":184}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/menu/add',
    'POST',
    1639107856
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    360,
    1,
    '添加菜单',
    '{\"title\":\"接口测试列表\",\"pname\":\"184\",\"route\":\"apitest/list\",\"href\":\"\",\"icon\":\"layui-icon layui-icon-read\",\"type\":2,\"order_num\":0,\"pid\":184}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/menu/add',
    'POST',
    1639126570
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    361,
    1,
    '添加菜单',
    '{\"title\":\"接口测试添加前\",\"pname\":\"184\",\"route\":\"apitest/addBefore\",\"href\":\"\",\"icon\":\"layui-icon layui-icon-email\",\"type\":3,\"order_num\":0,\"pid\":184}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/menu/add',
    'POST',
    1639127617
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    362,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"jntp\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/login/do',
    'POST',
    1639183323
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    363,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"jlmm\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/login/do',
    'POST',
    1639278485
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    364,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"ufzg\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (iPhone; CPU iPhone OS 11_0 like Mac OS X) AppleWebKit/604.1.38 (KHTML, like Gecko) Version/11.0 Mobile/15A372 Safari/604.1',
    '/server/login/do',
    'POST',
    1639305323
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    365,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"ym4j\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (iPhone; CPU iPhone OS 11_0 like Mac OS X) AppleWebKit/604.1.38 (KHTML, like Gecko) Version/11.0 Mobile/15A372 Safari/604.1',
    '/server/login/do',
    'POST',
    1639364783
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    366,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"jjku\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (iPhone; CPU iPhone OS 11_0 like Mac OS X) AppleWebKit/604.1.38 (KHTML, like Gecko) Version/11.0 Mobile/15A372 Safari/604.1',
    '/server/login/do',
    'POST',
    1639367744
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    367,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"zwus\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (iPhone; CPU iPhone OS 11_0 like Mac OS X) AppleWebKit/604.1.38 (KHTML, like Gecko) Version/11.0 Mobile/15A372 Safari/604.1',
    '/server/login/do',
    'POST',
    1639368047
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    368,
    1,
    '编辑菜单',
    '{\"title\":\"接口设计\",\"pname\":\"系统管理\",\"route\":\"api/list\",\"href\":\"view/api/list.html\",\"icon\":\"layui-icon layui-icon-website\",\"type\":1,\"desktop\":1,\"order_num\":0,\"id\":184,\"pid\":2}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/menu/edit',
    'POST',
    1639368125
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    369,
    1,
    '编辑菜单',
    '{\"title\":\"菜单管理\",\"pname\":\"系统管理\",\"route\":\"menu/oplist\",\"href\":\"view/menu/index.html\",\"icon\":\"layui-icon layui-icon-gift\",\"type\":1,\"desktop\":1,\"order_num\":1,\"id\":9,\"pid\":2}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/menu/edit',
    'POST',
    1639368146
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    370,
    1,
    '编辑菜单',
    '{\"title\":\"思维导图\",\"pname\":\"内容管理\",\"route\":\"mind/list\",\"href\":\"view/mind/list.html\",\"icon\":\"layui-icon layui-icon-auz\",\"type\":1,\"desktop\":1,\"order_num\":0,\"id\":154,\"pid\":1}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/menu/edit',
    'POST',
    1639368164
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    371,
    1,
    '编辑菜单',
    '{\"title\":\"流程图\",\"pname\":\"内容管理\",\"route\":\"flow/list\",\"href\":\"view/flow/list.html\",\"icon\":\"layui-icon layui-icon-spread-left\",\"type\":1,\"desktop\":1,\"order_num\":0,\"id\":165,\"pid\":1}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/menu/edit',
    'POST',
    1639368184
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    372,
    1,
    '编辑菜单',
    '{\"title\":\"演示文稿\",\"pname\":\"内容管理\",\"route\":\"ppt/list\",\"href\":\"view/ppt/list.html\",\"icon\":\"layui-icon layui-icon-transfer\",\"type\":1,\"desktop\":1,\"order_num\":0,\"id\":149,\"pid\":1}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/menu/edit',
    'POST',
    1639368194
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    373,
    1,
    '编辑菜单',
    '{\"title\":\"程序设计器\",\"pname\":\"内容管理\",\"route\":\"code/list\",\"href\":\"view/code/list.html\",\"icon\":\"layui-icon layui-icon-template\",\"type\":1,\"desktop\":1,\"order_num\":0,\"id\":206,\"pid\":1}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/menu/edit',
    'POST',
    1639368204
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    374,
    1,
    '编辑菜单',
    '{\"title\":\"文档管理\",\"pname\":\"内容管理\",\"route\":\"doc/list\",\"href\":\"view/doc/list.html\",\"icon\":\"layui-icon layui-icon-email\",\"type\":1,\"desktop\":1,\"order_num\":0,\"id\":170,\"pid\":1}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/menu/edit',
    'POST',
    1639368216
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    375,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"bqzs\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (iPhone; CPU iPhone OS 11_0 like Mac OS X) AppleWebKit/604.1.38 (KHTML, like Gecko) Version/11.0 Mobile/15A372 Safari/604.1',
    '/server/login/do',
    'POST',
    1639368339
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    376,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"49fh\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (iPhone; CPU iPhone OS 11_0 like Mac OS X) AppleWebKit/604.1.38 (KHTML, like Gecko) Version/11.0 Mobile/15A372 Safari/604.1',
    '/server/login/do',
    'POST',
    1639368710
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    377,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"cgnv\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (iPhone; CPU iPhone OS 11_0 like Mac OS X) AppleWebKit/604.1.38 (KHTML, like Gecko) Version/11.0 Mobile/15A372 Safari/604.1',
    '/server/login/do',
    'POST',
    1639369840
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    378,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"xmzr\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (iPhone; CPU iPhone OS 11_0 like Mac OS X) AppleWebKit/604.1.38 (KHTML, like Gecko) Version/11.0 Mobile/15A372 Safari/604.1',
    '/server/login/do',
    'POST',
    1639370102
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    379,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"jfdy\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (iPhone; CPU iPhone OS 11_0 like Mac OS X) AppleWebKit/604.1.38 (KHTML, like Gecko) Version/11.0 Mobile/15A372 Safari/604.1',
    '/server/login/do',
    'POST',
    1639370260
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    380,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"7hrm\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (iPhone; CPU iPhone OS 11_0 like Mac OS X) AppleWebKit/604.1.38 (KHTML, like Gecko) Version/11.0 Mobile/15A372 Safari/604.1',
    '/server/login/do',
    'POST',
    1639370325
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    381,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"cb5d\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (iPhone; CPU iPhone OS 11_0 like Mac OS X) AppleWebKit/604.1.38 (KHTML, like Gecko) Version/11.0 Mobile/15A372 Safari/604.1',
    '/server/login/do',
    'POST',
    1639371012
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    382,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"bedm\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (iPhone; CPU iPhone OS 11_0 like Mac OS X) AppleWebKit/604.1.38 (KHTML, like Gecko) Version/11.0 Mobile/15A372 Safari/604.1',
    '/server/login/do',
    'POST',
    1639371213
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    383,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"aohr\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (iPhone; CPU iPhone OS 11_0 like Mac OS X) AppleWebKit/604.1.38 (KHTML, like Gecko) Version/11.0 Mobile/15A372 Safari/604.1',
    '/server/login/do',
    'POST',
    1639371293
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    384,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"rjtn\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (iPhone; CPU iPhone OS 11_0 like Mac OS X) AppleWebKit/604.1.38 (KHTML, like Gecko) Version/11.0 Mobile/15A372 Safari/604.1',
    '/server/login/do',
    'POST',
    1639371394
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    385,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"hjpj\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (iPhone; CPU iPhone OS 11_0 like Mac OS X) AppleWebKit/604.1.38 (KHTML, like Gecko) Version/11.0 Mobile/15A372 Safari/604.1',
    '/server/login/do',
    'POST',
    1639371449
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    386,
    1,
    '编辑菜单',
    '{\"title\":\"数据库设计器\",\"pname\":\"系统管理\",\"route\":\"db/list\",\"href\":\"view/db/list.html\",\"icon\":\"layui-icon layui-icon-template-1\",\"type\":1,\"desktop\":1,\"order_num\":3,\"id\":35,\"pid\":2}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/menu/edit',
    'POST',
    1639377600
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    387,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"zrgo\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (iPhone; CPU iPhone OS 11_0 like Mac OS X) AppleWebKit/604.1.38 (KHTML, like Gecko) Version/11.0 Mobile/15A372 Safari/604.1',
    '/server/login/do',
    'POST',
    1639377977
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    388,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"42td\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (iPhone; CPU iPhone OS 11_0 like Mac OS X) AppleWebKit/604.1.38 (KHTML, like Gecko) Version/11.0 Mobile/15A372 Safari/604.1',
    '/server/login/do',
    'POST',
    1639377989
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    389,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"jqar\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (iPhone; CPU iPhone OS 11_0 like Mac OS X) AppleWebKit/604.1.38 (KHTML, like Gecko) Version/11.0 Mobile/15A372 Safari/604.1',
    '/server/login/do',
    'POST',
    1639378052
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    390,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"fupq\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (iPhone; CPU iPhone OS 11_0 like Mac OS X) AppleWebKit/604.1.38 (KHTML, like Gecko) Version/11.0 Mobile/15A372 Safari/604.1',
    '/server/login/do',
    'POST',
    1639378123
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    391,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"bav8\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (iPhone; CPU iPhone OS 11_0 like Mac OS X) AppleWebKit/604.1.38 (KHTML, like Gecko) Version/11.0 Mobile/15A372 Safari/604.1',
    '/server/login/do',
    'POST',
    1639378169
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    392,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"srwv\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (iPhone; CPU iPhone OS 11_0 like Mac OS X) AppleWebKit/604.1.38 (KHTML, like Gecko) Version/11.0 Mobile/15A372 Safari/604.1',
    '/server/login/do',
    'POST',
    1639378197
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    393,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"pskj\"}',
    '::1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/93.0.4577.82 Safari/537.36',
    '/server/login/do',
    'POST',
    1639459362
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    394,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"hedp\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (iPhone; CPU iPhone OS 11_0 like Mac OS X) AppleWebKit/604.1.38 (KHTML, like Gecko) Version/11.0 Mobile/15A372 Safari/604.1',
    '/server/login/do',
    'POST',
    1639460880
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    395,
    1,
    '编辑菜单',
    '{\"title\":\"系统管理\",\"pname\":\"顶层目录\",\"route\":\"system\",\"href\":\"\",\"icon\":\"layui-icon layui-icon-set\",\"type\":0,\"desktop\":0,\"order_num\":1,\"id\":2,\"pid\":0}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/menu/edit',
    'POST',
    1639463586
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    396,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"kksx\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (iPhone; CPU iPhone OS 11_0 like Mac OS X) AppleWebKit/604.1.38 (KHTML, like Gecko) Version/11.0 Mobile/15A372 Safari/604.1',
    '/server/login/do',
    'POST',
    1639463603
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    397,
    1,
    '编辑菜单',
    '{\"title\":\"模块管理\",\"pname\":\"系统管理\",\"route\":\"mod/list\",\"href\":\"view/mod/list.html\",\"icon\":\"layui-icon layui-icon-slider\",\"type\":1,\"desktop\":1,\"order_num\":2,\"id\":116,\"pid\":2}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/menu/edit',
    'POST',
    1639471393
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    398,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"35kw\"}',
    '::1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/93.0.4577.82 Safari/537.36',
    '/server/login/do',
    'POST',
    1639471650
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    399,
    1,
    '编辑菜单',
    '{\"title\":\"甘特图\",\"pname\":\"内容管理\",\"route\":\"gant/list\",\"href\":\"view/gant/list.html\",\"icon\":\"layui-icon layui-icon-spread-left\",\"type\":1,\"desktop\":1,\"order_num\":0,\"id\":216,\"pid\":1}',
    '::1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/93.0.4577.82 Safari/537.36',
    '/server/menu/edit',
    'POST',
    1639472046
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    400,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"d84k\"}',
    '::1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/93.0.4577.82 Safari/537.36',
    '/server/login/do',
    'POST',
    1639472357
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    401,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"q3s2\"}',
    '::1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/93.0.4577.82 Safari/537.36',
    '/server/login/do',
    'POST',
    1639472379
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    402,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"cnft\"}',
    '::1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/93.0.4577.82 Safari/537.36',
    '/server/login/do',
    'POST',
    1639472480
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    403,
    1,
    '编辑菜单',
    '{\"title\":\"甘特图\",\"pname\":\"内容管理\",\"route\":\"gant/list\",\"href\":\"view/gant/list.html\",\"icon\":\"layui-icon layui-icon-survey\",\"type\":1,\"desktop\":1,\"order_num\":0,\"id\":216,\"pid\":1}',
    '::1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/93.0.4577.82 Safari/537.36',
    '/server/menu/edit',
    'POST',
    1639472569
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    404,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"g8qc\"}',
    '::1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/93.0.4577.82 Safari/537.36',
    '/server/login/do',
    'POST',
    1639472594
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    405,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"upfq\"}',
    '::1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/93.0.4577.82 Safari/537.36',
    '/server/login/do',
    'POST',
    1639477868
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    406,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"syzc\"}',
    '::1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/93.0.4577.82 Safari/537.36',
    '/server/login/do',
    'POST',
    1639477995
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    407,
    1,
    '编辑菜单',
    '{\"title\":\"日程计划\",\"pname\":\"内容管理\",\"route\":\"planday/list\",\"href\":\"view/planday/list.html\",\"icon\":\"layui-icon layui-icon-date\",\"type\":1,\"desktop\":1,\"order_num\":0,\"id\":221,\"pid\":1}',
    '::1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/93.0.4577.82 Safari/537.36',
    '/server/menu/edit',
    'POST',
    1639478026
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    408,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"bwet\"}',
    '::1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/93.0.4577.82 Safari/537.36',
    '/server/login/do',
    'POST',
    1639478038
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    409,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"6wvf\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/login/do',
    'POST',
    1639482680
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    410,
    1,
    '编辑菜单',
    '{\"title\":\"日程计划\",\"pname\":\"内容管理\",\"route\":\"planday/list\",\"href\":\"planday/index.html\",\"icon\":\"layui-icon layui-icon-date\",\"type\":1,\"desktop\":1,\"order_num\":0,\"id\":221,\"pid\":1}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/menu/edit',
    'POST',
    1639482739
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    411,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"sqwd\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/login/do',
    'POST',
    1639482756
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    412,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"scyc\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/login/do',
    'POST',
    1639540839
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    413,
    1,
    '编辑菜单',
    '{\"title\":\"日程计划\",\"pname\":\"内容管理\",\"route\":\"calendar/list\",\"href\":\"calendar/index.html\",\"icon\":\"layui-icon layui-icon-date\",\"type\":1,\"desktop\":1,\"order_num\":0,\"id\":221,\"pid\":1}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/menu/edit',
    'POST',
    1639563395
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    414,
    1,
    '编辑菜单',
    '{\"title\":\"日程计划添加\",\"pname\":\"日程计划\",\"route\":\"calendar/add\",\"href\":\"\",\"icon\":\"\",\"type\":3,\"desktop\":0,\"order_num\":0,\"id\":222,\"pid\":221}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/menu/edit',
    'POST',
    1639563435
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    415,
    1,
    '编辑菜单',
    '{\"title\":\"日程计划编辑\",\"pname\":\"日程计划\",\"route\":\"calendar//edit\",\"href\":\"\",\"icon\":\"\",\"type\":3,\"desktop\":0,\"order_num\":0,\"id\":223,\"pid\":221}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/menu/edit',
    'POST',
    1639563455
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    416,
    1,
    '编辑菜单',
    '{\"title\":\"日程计划删除\",\"pname\":\"日程计划\",\"route\":\"calendar/del\",\"href\":\"\",\"icon\":\"\",\"type\":3,\"desktop\":0,\"order_num\":0,\"id\":224,\"pid\":221}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/menu/edit',
    'POST',
    1639563468
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    417,
    1,
    '编辑菜单',
    '{\"title\":\"日程计划编辑前\",\"pname\":\"日程计划\",\"route\":\"calendar/editBefore\",\"href\":\"\",\"icon\":\"\",\"type\":3,\"desktop\":0,\"order_num\":0,\"id\":225,\"pid\":221}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/menu/edit',
    'POST',
    1639563486
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    418,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"efbv\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/login/do',
    'POST',
    1639617875
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    419,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"ttx2\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/login/do',
    'POST',
    1639618103
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    420,
    1,
    '编辑菜单',
    '{\"title\":\"日程计划\",\"pname\":\"内容管理\",\"route\":\"planday/list\",\"href\":\"planday/index.html\",\"icon\":\"layui-icon layui-icon-date\",\"type\":1,\"desktop\":1,\"order_num\":0,\"id\":221,\"pid\":1}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/menu/edit',
    'POST',
    1639625662
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    421,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"wxmj\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/login/do',
    'POST',
    1639625672
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    422,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"admm\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/login/do',
    'POST',
    1639626724
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    423,
    1,
    '编辑菜单',
    '{\"title\":\"图片编辑器\",\"pname\":\"内容管理\",\"route\":\"picedit/list\",\"href\":\"view/picedit/list.html\",\"icon\":\"layui-icon layui-icon-camera\",\"type\":1,\"desktop\":1,\"order_num\":0,\"id\":226,\"pid\":1}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/menu/edit',
    'POST',
    1639626750
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    424,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"qtr6\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/login/do',
    'POST',
    1639626762
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    425,
    1,
    '添加菜单',
    '{\"title\":\"编辑图片名字\",\"pname\":\"226\",\"route\":\"picedit/editName\",\"href\":\"\",\"icon\":\"layui-icon layui-icon-rss\",\"type\":3,\"desktop\":0,\"order_num\":0,\"pid\":226}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/menu/add',
    'POST',
    1639646768
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    426,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"pwt5\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/login/do',
    'POST',
    1639699578
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    427,
    1,
    '编辑菜单',
    '{\"title\":\"svg编辑器\",\"pname\":\"内容管理\",\"route\":\"svgedit/list\",\"href\":\"view/svgedit/list.html\",\"icon\":\"layui-icon layui-icon-diamond\",\"type\":1,\"desktop\":1,\"order_num\":0,\"id\":237,\"pid\":1}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/menu/edit',
    'POST',
    1639699944
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    428,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"h4lg\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/login/do',
    'POST',
    1639699956
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    429,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"adcd\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/login/do',
    'POST',
    1639802631
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    430,
    1,
    '添加菜单',
    '{\"title\":\"判断登录\",\"pname\":\"3\",\"route\":\"index/isLogin\",\"href\":\"\",\"icon\":\"layui-icon layui-icon-at\",\"type\":3,\"desktop\":0,\"order_num\":0,\"pid\":3}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/menu/add',
    'POST',
    1639815206
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    431,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"3prp\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/login/do',
    'POST',
    1639819099
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    432,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"jb9f\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/login/do',
    'POST',
    1639819205
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    433,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"ucps\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/login/do',
    'POST',
    1639819713
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    434,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"7tzw\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/login/do',
    'POST',
    1639819850
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    435,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"osch\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/login/do',
    'POST',
    1639820360
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    436,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"xgqk\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/login/do',
    'POST',
    1639820488
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    437,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"ffwq\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/login/do',
    'POST',
    1639820506
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    438,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"hr8s\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/login/do',
    'POST',
    1639820547
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    439,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"ymqw\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/login/do',
    'POST',
    1639820595
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    440,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"wvru\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/login/do',
    'POST',
    1639820835
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    441,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"2jqf\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/login/do',
    'POST',
    1639820953
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    442,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"lwml\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/login/do',
    'POST',
    1639821057
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    443,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"r787\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/login/do',
    'POST',
    1639821091
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    444,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"eklm\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/login/do',
    'POST',
    1639821161
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    445,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"4y2w\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/login/do',
    'POST',
    1639821209
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    446,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"duqm\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/login/do',
    'POST',
    1639821416
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    447,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"tjcg\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/login/do',
    'POST',
    1639821426
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    448,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"3oxs\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/login/do',
    'POST',
    1639821438
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    449,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"kpty\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/login/do',
    'POST',
    1639821464
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    450,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"uufj\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/login/do',
    'POST',
    1639821581
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    451,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"sz6m\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/login/do',
    'POST',
    1639825258
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    452,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"fwzx\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/login/do',
    'POST',
    1639825293
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    453,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"exux\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/login/do',
    'POST',
    1639825388
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    454,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"4uh4\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/login/do',
    'POST',
    1639826368
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    455,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"24fz\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/login/do',
    'POST',
    1639882104
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    456,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"rvas\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/login/do',
    'POST',
    1639959799
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    457,
    1,
    '设置菜单显示',
    '{\"id\":3,\"ifshow\":0}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/menu/ifshow',
    'POST',
    1639962139
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    458,
    1,
    '添加菜单',
    '{\"title\":\"文件夹\",\"route\":\"finder/list\",\"href\":\"finder/index.html\",\"icon\":\"layui-icon layui-icon-chart-screen\",\"type\":0,\"desktop\":1,\"order_num\":0,\"pid\":2}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/menu/add',
    'POST',
    1639965284
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    459,
    1,
    '编辑菜单',
    '{\"title\":\"文件夹\",\"pname\":\"系统管理\",\"route\":\"finder/list\",\"href\":\"finder/index.html\",\"icon\":\"layui-icon layui-icon-chart-screen\",\"type\":1,\"desktop\":1,\"order_num\":0,\"id\":243,\"pid\":2}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/menu/edit',
    'POST',
    1639965303
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    460,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"qdaf\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/login/do',
    'POST',
    1639965368
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    461,
    1,
    '设置菜单显示',
    '{\"id\":3,\"ifshow\":1}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/menu/ifshow',
    'POST',
    1639969887
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    462,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"5wwn\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/login/do',
    'POST',
    1639969923
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    463,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"rtjv\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/login/do',
    'POST',
    1639970128
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    464,
    1,
    '编辑菜单',
    '{\"title\":\"excel管理\",\"route\":\"excel/list\",\"href\":\"view/excel/list.html\",\"icon\":\"layui-icon layui-icon-tabs\",\"type\":1,\"desktop\":1,\"order_num\":0,\"id\":159,\"pid\":1}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/menu/edit',
    'POST',
    1639970150
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    465,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"myyf\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/login/do',
    'POST',
    1639970215
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    466,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"pmqa\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/login/do',
    'POST',
    1640047609
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    467,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"q7od\"}',
    '::1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/93.0.4577.82 Safari/537.36',
    '/server/login/do',
    'POST',
    1640049774
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    468,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"morw\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/login/do',
    'POST',
    1640052530
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    469,
    1,
    '添加菜单',
    '{\"title\":\"聊天\",\"route\":\"chat/open\",\"href\":\"\",\"icon\":\"layui-icon layui-icon-username\",\"type\":3,\"desktop\":0,\"order_num\":0,\"pid\":1}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/menu/add',
    'POST',
    1640085438
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    470,
    1,
    '添加菜单',
    '{\"title\":\"关闭聊天socket\",\"route\":\"chat/close\",\"href\":\"\",\"icon\":\"layui-icon layui-icon-username\",\"type\":3,\"desktop\":0,\"order_num\":0,\"pid\":244}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/menu/add',
    'POST',
    1640085484
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    471,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"euhe\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/login/do',
    'POST',
    1640085504
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    472,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"wtcx\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/login/do',
    'POST',
    1640087268
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    473,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"3ocj\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/login/do',
    'POST',
    1640087672
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    474,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"gjho\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/login/do',
    'POST',
    1640088994
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    475,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"lxoh\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/login/do',
    'POST',
    1640089106
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    476,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"nubm\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/login/do',
    'POST',
    1640089155
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    477,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"adgk\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/login/do',
    'POST',
    1640089274
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    478,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"zvfo\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/login/do',
    'POST',
    1640089365
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    479,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"nhxx\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/login/do',
    'POST',
    1640089658
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    480,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"klhq\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/login/do',
    'POST',
    1640089959
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    481,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"h6gw\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/login/do',
    'POST',
    1640089995
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    482,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"dxzh\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/login/do',
    'POST',
    1640090202
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    483,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"f5wm\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/login/do',
    'POST',
    1640141150
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    484,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"ssdn\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/login/do',
    'POST',
    1640142059
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    485,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"p8wr\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/login/do',
    'POST',
    1640142418
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    486,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"ebde\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/login/do',
    'POST',
    1640145503
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    487,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"5jgz\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/login/do',
    'POST',
    1640152816
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    488,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"b2jf\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/login/do',
    'POST',
    1640153076
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    489,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"j7lc\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/login/do',
    'POST',
    1640153302
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    490,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"zurn\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/login/do',
    'POST',
    1640154534
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    491,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"rsnn\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/login/do',
    'POST',
    1640154792
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    492,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"pbhb\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/login/do',
    'POST',
    1640154909
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    493,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"zbky\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/login/do',
    'POST',
    1640155016
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    494,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"mzfu\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/login/do',
    'POST',
    1640155207
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    495,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"hshf\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/login/do',
    'POST',
    1640155241
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    496,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"gjds\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/login/do',
    'POST',
    1640157732
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    497,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"gfnf\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/login/do',
    'POST',
    1640158035
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    498,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"vgeq\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/login/do',
    'POST',
    1640158050
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    499,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"gwkn\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/login/do',
    'POST',
    1640158175
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    500,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"c3ty\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/login/do',
    'POST',
    1640165652
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    501,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"7wfb\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/login/do',
    'POST',
    1640230062
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    502,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"ez5l\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/login/do',
    'POST',
    1640238023
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    503,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"wpss\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/login/do',
    'POST',
    1640248651
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    504,
    1,
    '编辑菜单',
    '{\"title\":\"导入EXCEL并存库\",\"route\":\"excel/upload\",\"href\":\"\",\"icon\":\"layui-icon layui-icon-fonts-code\",\"type\":3,\"desktop\":0,\"order_num\":0,\"id\":164,\"pid\":159}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/menu/edit',
    'POST',
    1640250957
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    505,
    1,
    '添加菜单',
    '{\"title\":\"导入\",\"route\":\"excel/import\",\"href\":\"\",\"icon\":\"layui-icon layui-icon-username\",\"type\":3,\"desktop\":0,\"order_num\":0,\"pid\":159}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/menu/add',
    'POST',
    1640250982
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    506,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"vxca\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/login/do',
    'POST',
    1640321307
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    507,
    1,
    '添加菜单',
    '{\"title\":\"打开文档\",\"route\":\"word/openFile\",\"href\":\"\",\"icon\":\"layui-icon layui-icon-android\",\"type\":3,\"desktop\":0,\"order_num\":0,\"pid\":247}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/menu/add',
    'POST',
    1640322288
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    508,
    1,
    '编辑菜单',
    '{\"title\":\"文档编辑器\",\"route\":\"word/list\",\"href\":\"view/word/list.html\",\"icon\":\"layui-icon layui-icon-read\",\"type\":1,\"desktop\":1,\"order_num\":0,\"id\":247,\"pid\":1}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/menu/edit',
    'POST',
    1640322303
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    509,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"tomp\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/login/do',
    'POST',
    1640322329
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    510,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"z6ew\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/login/do',
    'POST',
    1640330332
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    511,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"zmcw\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/login/do',
    'POST',
    1640486642
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    512,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"hb37\"}',
    '::1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/93.0.4577.82 Safari/537.36',
    '/server/login/do',
    'POST',
    1640489500
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    513,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"dubp\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/login/do',
    'POST',
    1640490578
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    514,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"lr8k\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/login/do',
    'POST',
    1640510952
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    515,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"b3c4\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/login/do',
    'POST',
    1640511012
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    516,
    1,
    '添加菜单',
    '{\"title\":\"上传文件\",\"route\":\"word/upload\",\"href\":\"\",\"icon\":\"layui-icon layui-icon-print\",\"type\":3,\"desktop\":0,\"order_num\":0,\"pid\":247}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/menu/add',
    'POST',
    1640511621
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    517,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"9b6o\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/login/do',
    'POST',
    1640562618
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    518,
    1,
    '编辑菜单',
    '{\"title\":\"文本编辑器\",\"route\":\"txt/list\",\"href\":\"view/txt/list.html\",\"icon\":\"layui-icon layui-icon-fonts-code\",\"type\":1,\"desktop\":1,\"order_num\":0,\"id\":254,\"pid\":1}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/menu/edit',
    'POST',
    1640564225
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    519,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"f34q\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/login/do',
    'POST',
    1640564241
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    520,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"efyp\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/login/do',
    'POST',
    1640564303
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    521,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"mgw6\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/login/do',
    'POST',
    1640573658
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    522,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"jxpk\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/login/do',
    'POST',
    1640576743
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    523,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"3m2c\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/login/do',
    'POST',
    1640586624
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    524,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"utgf\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/login/do',
    'POST',
    1640661600
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    525,
    1,
    '编辑菜单',
    '{\"title\":\"任务看板\",\"route\":\"kanban/list\",\"href\":\"view/kanban/list.html\",\"icon\":\"layui-icon layui-icon-file-b\",\"type\":1,\"desktop\":1,\"order_num\":0,\"id\":259,\"pid\":1}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/menu/edit',
    'POST',
    1640662383
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    526,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"fedb\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/login/do',
    'POST',
    1640662397
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    527,
    1,
    '编辑菜单',
    '{\"title\":\"表格管理\",\"route\":\"excel/list\",\"href\":\"view/excel/list.html\",\"icon\":\"layui-icon layui-icon-tabs\",\"type\":1,\"desktop\":1,\"order_num\":0,\"id\":159,\"pid\":1}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/menu/edit',
    'POST',
    1640662444
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    528,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"vlp7\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/login/do',
    'POST',
    1640669851
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    529,
    1,
    '添加菜单',
    '{\"title\":\"开启关闭计划任务\",\"route\":\"crons/enable\",\"href\":\"\",\"icon\":\"layui-icon layui-icon-mute\",\"type\":3,\"desktop\":0,\"order_num\":0,\"pid\":144}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/menu/add',
    'POST',
    1640671160
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    530,
    1,
    '开启关闭计划任务',
    '{\"id\":\"6\",\"val\":\"false\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/crons/enable',
    'POST',
    1640671219
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    531,
    1,
    '开启关闭计划任务',
    '{\"id\":\"6\",\"val\":\"true\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/crons/enable',
    'POST',
    1640671246
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    532,
    1,
    '开启关闭计划任务',
    '{\"id\":\"6\",\"val\":\"false\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/crons/enable',
    'POST',
    1640671264
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    533,
    1,
    '开启关闭计划任务',
    '{\"id\":\"6\",\"val\":\"true\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/crons/enable',
    'POST',
    1640671298
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    534,
    1,
    '开启关闭计划任务',
    '{\"id\":\"6\",\"val\":\"true\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/crons/enable',
    'POST',
    1640671300
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    535,
    1,
    '开启关闭计划任务',
    '{\"id\":\"6\",\"val\":\"true\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/crons/enable',
    'POST',
    1640671304
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    536,
    1,
    '开启关闭计划任务',
    '{\"id\":\"6\",\"val\":\"false\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/crons/enable',
    'POST',
    1640671308
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    537,
    1,
    '开启关闭计划任务',
    '{\"id\":\"6\",\"val\":\"true\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/crons/enable',
    'POST',
    1640671337
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    538,
    1,
    '开启关闭计划任务',
    '{\"id\":\"6\",\"val\":\"false\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/crons/enable',
    'POST',
    1640671340
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    539,
    1,
    '开启关闭计划任务',
    '{\"id\":\"6\",\"val\":\"true\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/crons/enable',
    'POST',
    1640671342
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    540,
    1,
    '开启关闭计划任务',
    '{\"id\":\"6\",\"val\":\"false\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/crons/enable',
    'POST',
    1640671368
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    541,
    1,
    '开启关闭计划任务',
    '{\"id\":\"6\",\"val\":\"true\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/crons/enable',
    'POST',
    1640671404
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    542,
    1,
    '开启关闭计划任务',
    '{\"id\":\"6\",\"val\":\"false\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/crons/enable',
    'POST',
    1640671406
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    543,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"dfzp\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/login/do',
    'POST',
    1640684651
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    544,
    1,
    '添加计划任务',
    '{\"name\":\"test\",\"handle\":\"demo\",\"enable\":\"0\",\"immediate\":\"0\",\"type\":\"all\",\"runtype\":\"0\",\"interval\":\"11\",\"intertype\":\"s\",\"cron\":\"0/10 * * * * ?\",\"remark\":\"\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/crons/add',
    'POST',
    1640684953
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    545,
    1,
    '添加计划任务',
    '{\"name\":\"test\",\"handle\":\"demo\",\"enable\":\"1\",\"immediate\":\"1\",\"type\":\"all\",\"runtype\":\"0\",\"interval\":\"1\",\"intertype\":\"s\",\"cron\":\"0/10 * * * * ?\",\"remark\":\"\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/crons/add',
    'POST',
    1640687445
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    546,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"kefd\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/login/do',
    'POST',
    1640739159
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    547,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"kbdz\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/login/do',
    'POST',
    1640740236
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    548,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"fmqw\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/login/do',
    'POST',
    1640745492
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    549,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"kywp\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/login/do',
    'POST',
    1640765292
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    550,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"xzmq\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/login/do',
    'POST',
    1640765309
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    551,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"m5wt\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/login/do',
    'POST',
    1640765399
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    552,
    1,
    '添加菜单',
    '{\"title\":\"导出\",\"route\":\"server/menu/sql\",\"href\":\"\",\"icon\":\"layui-icon layui-icon-email\",\"type\":3,\"desktop\":0,\"order_num\":0,\"pid\":9}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/menu/add',
    'POST',
    1640765639
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    553,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"g2re\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/login/do',
    'POST',
    1641432400
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    554,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"rxju\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/login/do',
    'POST',
    1641434044
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    555,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"2q6w\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/login/do',
    'POST',
    1641441407
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    556,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"bbtn\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/login/do',
    'POST',
    1641460301
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    557,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"rgbb\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/login/do',
    'POST',
    1641468444
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    558,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"hqk2\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/login/do',
    'POST',
    1641527107
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    559,
    1,
    '添加菜单',
    '{\"title\":\"接口发送测试\",\"route\":\"server/apitest/testRun\",\"href\":\"\",\"icon\":\"layui-icon layui-icon-at\",\"type\":3,\"desktop\":0,\"order_num\":0,\"pid\":184}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/menu/add',
    'POST',
    1641529211
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    560,
    1,
    '添加菜单',
    '{\"title\":\"添加接口测试\",\"route\":\"server/apitest/add\",\"href\":\"\",\"icon\":\"layui-icon layui-icon-email\",\"type\":3,\"desktop\":0,\"order_num\":0,\"pid\":184}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/menu/add',
    'POST',
    1641533984
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    561,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"42me\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/login/do',
    'POST',
    1641534329
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    562,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"qc95\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/login/do',
    'POST',
    1641535451
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    563,
    1,
    '编辑菜单',
    '{\"title\":\"权限管理\",\"route\":\"auth\",\"href\":\"\",\"icon\":\"layui-icon layui-icon-vercode\",\"type\":0,\"desktop\":0,\"order_num\":1,\"id\":3,\"pid\":0}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/menu/edit',
    'POST',
    1641535493
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    564,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"wddd\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/login/do',
    'POST',
    1641535521
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    565,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"dokk\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/login/do',
    'POST',
    1641538610
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    566,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"wru4\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/login/do',
    'POST',
    1641538722
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    567,
    1,
    '编辑菜单',
    '{\"title\":\"地区管理\",\"route\":\"server/area/list\",\"href\":\"view/area/list.html\",\"icon\":\"layui-icon layui-icon-website\",\"type\":1,\"desktop\":0,\"order_num\":0,\"id\":268,\"pid\":3}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/menu/edit',
    'POST',
    1641539295
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    568,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"wxfc\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/login/do',
    'POST',
    1641539465
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    569,
    1,
    '添加菜单',
    '{\"title\":\"地区管理添加前\",\"route\":\"server/area/addBefore\",\"href\":\"\",\"icon\":\"layui-icon layui-icon-username\",\"type\":3,\"desktop\":0,\"order_num\":0,\"pid\":268}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/menu/add',
    'POST',
    1641540498
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    570,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"blqz\"}',
    '::1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/93.0.4577.82 Safari/537.36',
    '/server/login/do',
    'POST',
    1641542833
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    571,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"bdqy\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/login/do',
    'POST',
    1641543849
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    572,
    1,
    '添加菜单',
    '{\"title\":\"设置地区可用\",\"route\":\"server/area/enable\",\"href\":\"\",\"icon\":\"layui-icon layui-icon-username\",\"type\":3,\"desktop\":0,\"order_num\":0,\"pid\":268}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/menu/add',
    'POST',
    1641547688
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    573,
    1,
    '设置地区可用',
    '{\"id\":\"110000\",\"status\":\"1\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/area/enable',
    'POST',
    1641547889
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    574,
    1,
    '设置地区可用',
    '{\"id\":\"110000\",\"status\":\"0\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/area/enable',
    'POST',
    1641547896
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    575,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"pmc8\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/login/do',
    'POST',
    1641548942
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    576,
    1,
    '设置地区可用',
    '{\"id\":\"110000\",\"status\":\"1\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/area/enable',
    'POST',
    1641549240
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    577,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"lpm6\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/login/do',
    'POST',
    1641608872
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    578,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"tlyb\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/login/do',
    'POST',
    1641609574
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    579,
    1,
    '添加计划任务',
    '{\"name\":\"test\",\"handle\":\"server/demo\",\"enable\":\"0\",\"immediate\":\"1\",\"type\":\"all\",\"runtype\":\"0\",\"interval\":\"1\",\"intertype\":\"s\",\"cron\":\"0/10 * * * * ?\",\"remark\":\"\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/crons/add',
    'POST',
    1641609605
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    580,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"vbjx\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/login/do',
    'POST',
    1641627047
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    581,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"shcl\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/login/do',
    'POST',
    1641702385
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    582,
    1,
    '删除菜单',
    '{\"id\":243}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/menu/del',
    'POST',
    1641705488
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    583,
    1,
    '编辑菜单',
    '{\"title\":\"任务看板\",\"route\":\"server/kanban/list\",\"href\":\"view/kanban/list.html\",\"icon\":\"layui-icon layui-icon-file-b\",\"type\":1,\"desktop\":0,\"order_num\":0,\"id\":259,\"pid\":1}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/menu/edit',
    'POST',
    1641705516
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    584,
    1,
    '设置菜单显示',
    '{\"id\":259,\"ifshow\":1}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/menu/ifshow',
    'POST',
    1641705523
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    585,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"vlrj\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/login/do',
    'POST',
    1641705542
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    586,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"znva\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/login/do',
    'POST',
    1641707526
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    587,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"up4j\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/login/do',
    'POST',
    1641714745
  );
INSERT INTO
  `rt_admin_oplog` (
    `id`,
    `admin_id`,
    `log`,
    `data`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`
  )
VALUES
  (
    588,
    1,
    'admin用户登录',
    '{\"username\":\"admin\",\"captcha\":\"qzrv\"}',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/login/do',
    'POST',
    1641722322
  );

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: rt_admin_viewlog
# ------------------------------------------------------------

INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    2,
    1,
    '添加或删除菜单',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/one',
    'GET',
    1636851045,
    0
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    3,
    2,
    '菜单列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/oplist',
    'GET',
    1636851077,
    1636851990
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    4,
    1,
    '添加或删除菜单',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/one',
    'GET',
    1636851990,
    1636852081
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    5,
    1,
    '菜单列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/oplist',
    'GET',
    1636852081,
    1636852084
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    6,
    1,
    '添加菜单',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/one',
    'GET',
    1636852084,
    1636852148
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    7,
    1,
    '编辑菜单',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/one',
    'GET',
    1636852148,
    1636852151
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    8,
    1,
    '添加菜单',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/one',
    'GET',
    1636852151,
    1636852168
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    9,
    1,
    '菜单列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/oplist',
    'GET',
    1636852168,
    1636941898
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    10,
    1,
    '角色列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/auth/list',
    'GET',
    1636941898,
    1636941901
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    11,
    1,
    '菜单列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/oplist',
    'GET',
    1636941901,
    1636941908
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    12,
    1,
    '编辑菜单',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/one',
    'GET',
    1636941908,
    1636941924
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    13,
    1,
    '菜单列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/oplist',
    'GET',
    1636941924,
    1636941965
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    14,
    1,
    '编辑菜单',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/one',
    'GET',
    1636941965,
    1636941981
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    15,
    1,
    '菜单列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/oplist',
    'GET',
    1636941981,
    1636942013
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    16,
    1,
    '编辑菜单',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/one',
    'GET',
    1636942013,
    1636942018
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    17,
    1,
    '菜单列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/oplist',
    'GET',
    1636942018,
    1636942180
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    18,
    1,
    '管理员列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/admin/list',
    'GET',
    1636942180,
    1636942471
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    19,
    1,
    '角色列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/auth/list',
    'GET',
    1636942471,
    1636942473
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    20,
    1,
    '添加角色',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/auth/addTree',
    'GET',
    1636942473,
    1636942478
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    21,
    1,
    '编辑角色',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/auth/beforEdit',
    'GET',
    1636942478,
    1636942499
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    22,
    1,
    '添加角色',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/auth/addTree',
    'GET',
    1636942499,
    1636942510
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    23,
    1,
    '编辑角色',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/auth/beforEdit',
    'GET',
    1636942510,
    1636942771
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    24,
    1,
    '添加角色',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/auth/addTree',
    'GET',
    1636942771,
    1636943618
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    25,
    1,
    '管理员列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/admin/list',
    'GET',
    1636943618,
    1636943621
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    26,
    1,
    '添加角色',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/auth/addTree',
    'GET',
    1636943621,
    1636944071
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    27,
    1,
    '菜单列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/oplist',
    'GET',
    1636944071,
    1636944077
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    28,
    1,
    '添加菜单',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/one',
    'GET',
    1636944077,
    1636944104
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    29,
    1,
    '菜单列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/oplist',
    'GET',
    1636944104,
    1636944444
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    30,
    1,
    '管理员列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/admin/list',
    'GET',
    1636944444,
    1636947887
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    31,
    1,
    '菜单列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/oplist',
    'GET',
    1636947887,
    1636947903
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    32,
    1,
    '添加菜单',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/one',
    'GET',
    1636947903,
    1636947931
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    33,
    1,
    '菜单列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/oplist',
    'GET',
    1636947931,
    1636948396
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    34,
    1,
    '管理员列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/admin/list',
    'GET',
    1636948396,
    1636950055
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    35,
    1,
    '菜单列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/oplist',
    'GET',
    1636950055,
    1636950060
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    36,
    1,
    '添加菜单',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/one',
    'GET',
    1636950060,
    1636950088
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    37,
    1,
    '菜单列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/oplist',
    'GET',
    1636950088,
    1636950206
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    38,
    1,
    '管理员列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/admin/list',
    'GET',
    1636950206,
    1636958873
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    39,
    1,
    '菜单列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/oplist',
    'GET',
    1636958873,
    1636958880
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    40,
    1,
    '编辑菜单',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/one',
    'GET',
    1636958880,
    1636958889
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    41,
    1,
    '菜单列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/oplist',
    'GET',
    1636958889,
    1636958901
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    42,
    1,
    '管理员列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/admin/list',
    'GET',
    1636958901,
    1636959492
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    43,
    1,
    '编辑菜单',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/one',
    'GET',
    1636959492,
    1636959517
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    44,
    1,
    '菜单列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/oplist',
    'GET',
    1636959517,
    1636959534
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    45,
    1,
    '编辑菜单',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/one',
    'GET',
    1636959534,
    1636959542
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    46,
    1,
    '菜单列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/oplist',
    'GET',
    1636959542,
    1636959557
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    47,
    1,
    '编辑菜单',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/one',
    'GET',
    1636959557,
    1636959580
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    48,
    1,
    '菜单列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/oplist',
    'GET',
    1636959580,
    1636959657
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    49,
    1,
    '管理员列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/admin/list',
    'GET',
    1636959657,
    1636962361
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    50,
    1,
    '角色列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/auth/list',
    'GET',
    1636962361,
    1636962387
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    51,
    1,
    '菜单列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/oplist',
    'GET',
    1636962387,
    1636962398
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    52,
    1,
    '添加菜单',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/one',
    'GET',
    1636962398,
    1636962429
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    53,
    1,
    '菜单列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/oplist',
    'GET',
    1636962429,
    1636962445
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    54,
    1,
    '管理员列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/admin/list',
    'GET',
    1636962445,
    1636964747
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    55,
    1,
    '添加菜单',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/one',
    'GET',
    1636964747,
    1636964786
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    56,
    1,
    '菜单列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/oplist',
    'GET',
    1636964786,
    1636965961
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    57,
    1,
    '编辑菜单',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/one',
    'GET',
    1636965960,
    1636965966
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    58,
    1,
    '菜单列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/oplist',
    'GET',
    1636965966,
    1636965970
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    59,
    1,
    '添加菜单',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/one',
    'GET',
    1636965970,
    1636966011
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    60,
    1,
    '菜单列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/oplist',
    'GET',
    1636966011,
    1636966014
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    61,
    1,
    '添加菜单',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/one',
    'GET',
    1636966014,
    1636966045
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    62,
    1,
    '菜单列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/oplist',
    'GET',
    1636966045,
    1636966102
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    63,
    1,
    '管理员操作日志',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/logs/op',
    'GET',
    1636966102,
    1636966221
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    64,
    1,
    '管理员列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/admin/list',
    'GET',
    1636966221,
    1636966320
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    65,
    1,
    '管理员操作日志',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/logs/op',
    'GET',
    1636966320,
    1636968670
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    66,
    1,
    '管理员行为日志',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/logs/view',
    'GET',
    1636968670,
    1636969080
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    67,
    1,
    '系统错误日志',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/logs/err',
    'GET',
    1636969080,
    1636969086
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    68,
    1,
    '管理员行为日志',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/logs/view',
    'GET',
    1636969086,
    1636969131
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    69,
    1,
    '菜单列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/oplist',
    'GET',
    1636969131,
    1637020762
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    70,
    1,
    '管理员操作日志',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/logs/op',
    'GET',
    1637020762,
    1637020765
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    71,
    1,
    '管理员行为日志',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/logs/view',
    'GET',
    1637020765,
    1637020768
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    72,
    1,
    '系统错误日志',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/logs/err',
    'GET',
    1637020768,
    1637023322
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    73,
    1,
    '菜单列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/oplist',
    'GET',
    1637023322,
    1637023329
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    74,
    1,
    '编辑菜单',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/one',
    'GET',
    1637023329,
    1637023335
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    75,
    1,
    '菜单列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/oplist',
    'GET',
    1637023335,
    1637023388
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    76,
    1,
    '编辑菜单',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/one',
    'GET',
    1637023388,
    1637023402
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    77,
    1,
    '菜单列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/oplist',
    'GET',
    1637023402,
    1637028911
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    78,
    1,
    '添加菜单',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/one',
    'GET',
    1637028911,
    1637028919
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    79,
    1,
    '菜单列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/oplist',
    'GET',
    1637028919,
    1637029248
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    80,
    1,
    '添加菜单',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/one',
    'GET',
    1637029248,
    1637029256
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    81,
    1,
    '菜单列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/oplist',
    'GET',
    1637029256,
    1637029590
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    82,
    1,
    '添加菜单',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/one',
    'GET',
    1637029590,
    1637029596
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    83,
    1,
    '菜单列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/oplist',
    'GET',
    1637029596,
    1637030964
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    84,
    1,
    '添加菜单',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/one',
    'GET',
    1637030964,
    1637030982
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    85,
    1,
    '菜单列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/oplist',
    'GET',
    1637030982,
    1637031466
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    86,
    1,
    '添加菜单',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/one',
    'GET',
    1637031466,
    1637031472
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    87,
    1,
    '菜单列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/oplist',
    'GET',
    1637031472,
    1637031479
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    88,
    1,
    '添加菜单',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/one',
    'GET',
    1637031479,
    1637031483
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    89,
    1,
    '菜单列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/oplist',
    'GET',
    1637031483,
    1637031495
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    90,
    1,
    '添加菜单',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/one',
    'GET',
    1637031495,
    1637031501
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    91,
    1,
    '菜单列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/oplist',
    'GET',
    1637031501,
    1637031530
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    92,
    1,
    '添加菜单',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/one',
    'GET',
    1637031530,
    1637031573
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    93,
    1,
    '菜单列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/oplist',
    'GET',
    1637031573,
    1637031992
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    94,
    1,
    '添加菜单',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/one',
    'GET',
    1637031992,
    1637032000
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    95,
    1,
    '菜单列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/oplist',
    'GET',
    1637032000,
    1637033820
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    96,
    1,
    '添加菜单',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/one',
    'GET',
    1637033820,
    1637034083
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    97,
    1,
    '菜单列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/oplist',
    'GET',
    1637034083,
    1637034302
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    98,
    1,
    '编辑菜单',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/one',
    'GET',
    1637034302,
    1637034309
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    99,
    1,
    '菜单列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/oplist',
    'GET',
    1637034309,
    1637034320
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    100,
    1,
    '编辑菜单',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/one',
    'GET',
    1637034320,
    1637034432
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    101,
    1,
    '菜单列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/oplist',
    'GET',
    1637034432,
    1637034521
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    102,
    1,
    '编辑菜单',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/one',
    'GET',
    1637034521,
    1637034531
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    103,
    1,
    '添加菜单',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/one',
    'GET',
    1637034531,
    1637034627
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    104,
    1,
    '角色列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/auth/list',
    'GET',
    1637034627,
    1637036272
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    105,
    1,
    '添加角色',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/auth/addTree',
    'GET',
    1637036272,
    1637036281
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    106,
    1,
    '角色列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/auth/list',
    'GET',
    1637036281,
    1637036288
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    107,
    1,
    '编辑角色',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/auth/beforEdit',
    'GET',
    1637036288,
    1637036876
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    108,
    1,
    '菜单列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/oplist',
    'GET',
    1637036876,
    1637036909
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    109,
    1,
    '添加菜单',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/one',
    'GET',
    1637036909,
    1637037068
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    110,
    1,
    '编辑角色',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/auth/beforEdit',
    'GET',
    1637037068,
    1637037071
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    111,
    1,
    '角色列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/auth/list',
    'GET',
    1637037071,
    1637037683
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    112,
    1,
    '管理员列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/admin/list',
    'GET',
    1637037683,
    1637038175
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    113,
    1,
    '添加管理员',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/admin/addBefore',
    'GET',
    1637038175,
    1637038189
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    114,
    1,
    '管理员列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/admin/list',
    'GET',
    1637038189,
    1637038295
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    115,
    1,
    '编辑管理员',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/admin/editBefore',
    'GET',
    1637038295,
    1637038492
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    116,
    1,
    '管理员列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/admin/list',
    'GET',
    1637038492,
    1637038918
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    117,
    1,
    '编辑管理员',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/admin/editBefore',
    'GET',
    1637038918,
    1637039222
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    118,
    1,
    '菜单列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/oplist',
    'GET',
    1637039222,
    1637039440
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    119,
    1,
    '角色列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/auth/list',
    'GET',
    1637039440,
    1637039577
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    120,
    1,
    '菜单列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/oplist',
    'GET',
    1637039577,
    1637039581
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    121,
    1,
    '管理员列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/admin/list',
    'GET',
    1637039581,
    1637039585
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    122,
    1,
    '编辑管理员',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/admin/editBefore',
    'GET',
    1637039585,
    1637039790
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    123,
    1,
    '管理员列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/admin/list',
    'GET',
    1637039790,
    1637039793
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    124,
    1,
    '编辑管理员',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/admin/editBefore',
    'GET',
    1637039793,
    1637039796
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    125,
    1,
    '管理员列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/admin/list',
    'GET',
    1637039796,
    1637040178
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    126,
    1,
    '添加管理员',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/admin/addBefore',
    'GET',
    1637040177,
    1637040196
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    127,
    1,
    '管理员列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/admin/list',
    'GET',
    1637040196,
    1637040201
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    128,
    1,
    '编辑管理员',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/admin/editBefore',
    'GET',
    1637040201,
    1637040203
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    129,
    1,
    '管理员列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/admin/list',
    'GET',
    1637040203,
    1637040231
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    130,
    1,
    '管理员操作日志',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/logs/op',
    'GET',
    1637040231,
    1637052521
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    131,
    1,
    '管理员行为日志',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/logs/view',
    'GET',
    1637052521,
    1637052525
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    132,
    1,
    '系统错误日志',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/logs/err',
    'GET',
    1637052525,
    1637055527
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    133,
    1,
    '菜单列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/oplist',
    'GET',
    1637055527,
    1637055543
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    134,
    1,
    '添加菜单',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/one',
    'GET',
    1637055543,
    1637055590
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    135,
    1,
    '菜单列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/oplist',
    'GET',
    1637055590,
    1637055649
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    136,
    1,
    '编辑菜单',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/one',
    'GET',
    1637055649,
    1637055959
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    137,
    1,
    '管理员列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/admin/list',
    'GET',
    1637055959,
    1637055965
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    138,
    1,
    '添加管理员',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/admin/addBefore',
    'GET',
    1637055965,
    1637107906
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    139,
    1,
    '菜单列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/oplist',
    'GET',
    1637107906,
    1637107920
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    140,
    1,
    '编辑菜单',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/one',
    'GET',
    1637107920,
    1637107949
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    141,
    1,
    '添加菜单',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/one',
    'GET',
    1637107949,
    1637108007
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    142,
    1,
    '菜单列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/oplist',
    'GET',
    1637108007,
    1637108024
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    143,
    1,
    '添加菜单',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/one',
    'GET',
    1637108023,
    1637108058
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    144,
    1,
    '菜单列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/oplist',
    'GET',
    1637108058,
    1637109212
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    145,
    1,
    '添加菜单',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/one',
    'GET',
    1637109212,
    1637109232
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    146,
    1,
    '菜单列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/oplist',
    'GET',
    1637109232,
    1637111043
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    147,
    1,
    '编辑菜单',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/one',
    'GET',
    1637111043,
    1637111056
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    148,
    1,
    '菜单列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/oplist',
    'GET',
    1637111056,
    1637112409
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    149,
    1,
    '编辑菜单',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/one',
    'GET',
    1637112409,
    1637112427
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    150,
    1,
    '菜单列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/oplist',
    'GET',
    1637112427,
    1637112773
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    151,
    1,
    '编辑菜单',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/one',
    'GET',
    1637112773,
    1637112783
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    152,
    1,
    '菜单列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/oplist',
    'GET',
    1637112783,
    1637123825
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    153,
    1,
    '编辑菜单',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/one',
    'GET',
    1637123825,
    1637123851
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    154,
    1,
    '菜单列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/oplist',
    'GET',
    1637123851,
    1637123865
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    155,
    1,
    '添加菜单',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/one',
    'GET',
    1637123865,
    1637123948
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    156,
    1,
    '菜单列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/oplist',
    'GET',
    1637123948,
    1637141805
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    157,
    1,
    '编辑菜单',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/one',
    'GET',
    1637141805,
    1637141826
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    158,
    1,
    '菜单列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/oplist',
    'GET',
    1637141826,
    1637201389
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    159,
    1,
    '添加菜单',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/one',
    'GET',
    1637201388,
    1637201424
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    160,
    1,
    '菜单列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/oplist',
    'GET',
    1637201424,
    1637205392
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    161,
    1,
    '编辑菜单',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/one',
    'GET',
    1637205392,
    1637205401
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    162,
    1,
    '菜单列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/oplist',
    'GET',
    1637205401,
    1637205485
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    163,
    1,
    '编辑菜单',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/one',
    'GET',
    1637205485,
    1637208734
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    164,
    1,
    '菜单列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/oplist',
    'GET',
    1637208734,
    1637208784
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    165,
    1,
    '编辑菜单',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/one',
    'GET',
    1637208784,
    1637208797
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    166,
    1,
    '菜单列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/oplist',
    'GET',
    1637208797,
    1637208816
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    167,
    1,
    '编辑菜单',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/one',
    'GET',
    1637208816,
    1637208881
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    168,
    1,
    '菜单列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/oplist',
    'GET',
    1637208881,
    1637208885
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    169,
    1,
    '编辑菜单',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/one',
    'GET',
    1637208885,
    1637208906
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    170,
    1,
    '菜单列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/oplist',
    'GET',
    1637208906,
    1637208936
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    171,
    1,
    '编辑菜单',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/one',
    'GET',
    1637208936,
    1637208944
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    172,
    1,
    '菜单列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/oplist',
    'GET',
    1637208944,
    1637209956
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    173,
    1,
    '添加菜单',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/one',
    'GET',
    1637209956,
    1637209992
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    174,
    1,
    '菜单列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/oplist',
    'GET',
    1637209992,
    1637212862
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    175,
    1,
    '添加菜单',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/one',
    'GET',
    1637212862,
    1637212896
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    176,
    1,
    '菜单列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/oplist',
    'GET',
    1637212896,
    1637232272
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    177,
    1,
    '编辑菜单',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/one',
    'GET',
    1637232272,
    1637232277
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    178,
    1,
    '添加菜单',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/one',
    'GET',
    1637232277,
    1637232296
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    179,
    1,
    '菜单列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/oplist',
    'GET',
    1637232296,
    1637232300
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    180,
    1,
    '添加菜单',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/one',
    'GET',
    1637232300,
    1637232332
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    181,
    1,
    '菜单列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/oplist',
    'GET',
    1637232332,
    1637279173
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    182,
    1,
    '编辑菜单',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/one',
    'GET',
    1637279173,
    1637279183
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    183,
    1,
    '菜单列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/oplist',
    'GET',
    1637279183,
    1637279193
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    184,
    1,
    '编辑菜单',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/one',
    'GET',
    1637279193,
    1637279223
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    185,
    1,
    '菜单列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/oplist',
    'GET',
    1637279223,
    1637279251
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    186,
    1,
    '编辑菜单',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/one',
    'GET',
    1637279251,
    1637279260
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    187,
    1,
    '菜单列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/oplist',
    'GET',
    1637279260,
    1637279279
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    188,
    1,
    '编辑菜单',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/one',
    'GET',
    1637279279,
    1637279285
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    189,
    1,
    '菜单列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/oplist',
    'GET',
    1637279285,
    1637279291
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    190,
    1,
    '编辑菜单',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/one',
    'GET',
    1637279291,
    1637279295
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    191,
    1,
    '菜单列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/oplist',
    'GET',
    1637279295,
    1637281301
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    192,
    1,
    '编辑菜单',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/one',
    'GET',
    1637281301,
    1637281307
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    193,
    1,
    '菜单列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/oplist',
    'GET',
    1637281307,
    1637287504
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    194,
    1,
    '添加菜单',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/one',
    'GET',
    1637287504,
    1637287574
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    195,
    1,
    '编辑菜单',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/one',
    'GET',
    1637287574,
    1637287584
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    196,
    1,
    '菜单列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/oplist',
    'GET',
    1637287584,
    1637287791
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    197,
    1,
    '添加菜单',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/one',
    'GET',
    1637287791,
    1637287821
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    198,
    1,
    '菜单列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/oplist',
    'GET',
    1637287821,
    1637287840
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    199,
    1,
    '编辑菜单',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/one',
    'GET',
    1637287840,
    1637287847
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    200,
    1,
    '菜单列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/oplist',
    'GET',
    1637287847,
    1637293302
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    201,
    1,
    '添加菜单',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/one',
    'GET',
    1637293302,
    1637293324
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    202,
    1,
    '菜单列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/oplist',
    'GET',
    1637293324,
    1637296780
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    203,
    1,
    '添加菜单',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/one',
    'GET',
    1637296780,
    1637296812
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    204,
    1,
    '菜单列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/oplist',
    'GET',
    1637296812,
    1637297467
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    205,
    1,
    '添加菜单',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/one',
    'GET',
    1637297467,
    1637297488
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    206,
    1,
    '菜单列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/oplist',
    'GET',
    1637297488,
    1637297552
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    207,
    1,
    '编辑菜单',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/one',
    'GET',
    1637297552,
    1637297619
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    208,
    1,
    '菜单列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/oplist',
    'GET',
    1637297619,
    1637298311
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    209,
    1,
    '管理员操作日志',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/logs/op',
    'GET',
    1637298311,
    1637298323
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    210,
    1,
    '管理员行为日志',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/logs/view',
    'GET',
    1637298323,
    1637298477
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    211,
    1,
    '菜单列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/oplist',
    'GET',
    1637298477,
    1637298481
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    212,
    1,
    '添加菜单',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/one',
    'GET',
    1637298481,
    1637298574
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    213,
    1,
    '菜单列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/oplist',
    'GET',
    1637298574,
    1637308877
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    214,
    1,
    '添加菜单',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/one',
    'GET',
    1637308877,
    1637308898
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    215,
    1,
    '菜单列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/oplist',
    'GET',
    1637308898,
    1637332122
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    216,
    1,
    '添加菜单',
    '::1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/95.0.4638.54 Safari/537.36',
    '/server/menu/one',
    'GET',
    1637332122,
    1637332155
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    217,
    1,
    '菜单列表',
    '::1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/95.0.4638.54 Safari/537.36',
    '/server/menu/oplist',
    'GET',
    1637332155,
    1637337055
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    218,
    1,
    '添加菜单',
    '::1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/95.0.4638.54 Safari/537.36',
    '/server/menu/one',
    'GET',
    1637337055,
    1637337102
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    219,
    1,
    '菜单列表',
    '::1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/95.0.4638.54 Safari/537.36',
    '/server/menu/oplist',
    'GET',
    1637337102,
    1637337120
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    220,
    1,
    '添加菜单',
    '::1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/95.0.4638.54 Safari/537.36',
    '/server/menu/one',
    'GET',
    1637337120,
    1637337155
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    221,
    1,
    '菜单列表',
    '::1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/95.0.4638.54 Safari/537.36',
    '/server/menu/oplist',
    'GET',
    1637337155,
    1637337185
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    222,
    1,
    '编辑菜单',
    '::1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/95.0.4638.54 Safari/537.36',
    '/server/menu/one',
    'GET',
    1637337185,
    1637337188
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    223,
    1,
    '菜单列表',
    '::1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/95.0.4638.54 Safari/537.36',
    '/server/menu/oplist',
    'GET',
    1637337188,
    1637337200
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    224,
    1,
    '添加菜单',
    '::1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/95.0.4638.54 Safari/537.36',
    '/server/menu/one',
    'GET',
    1637337200,
    1637337232
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    225,
    1,
    '菜单列表',
    '::1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/95.0.4638.54 Safari/537.36',
    '/server/menu/oplist',
    'GET',
    1637337232,
    1637337246
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    226,
    1,
    '添加菜单',
    '::1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/95.0.4638.54 Safari/537.36',
    '/server/menu/one',
    'GET',
    1637337246,
    1637337279
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    227,
    1,
    '菜单列表',
    '::1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/95.0.4638.54 Safari/537.36',
    '/server/menu/oplist',
    'GET',
    1637337279,
    1637371702
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    228,
    1,
    '管理员操作日志',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/logs/op',
    'GET',
    1637371702,
    1637371705
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    229,
    1,
    '管理员行为日志',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/logs/view',
    'GET',
    1637371705,
    1637379349
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    230,
    1,
    '菜单列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/oplist',
    'GET',
    1637379349,
    1637379352
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    231,
    1,
    '添加菜单',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/one',
    'GET',
    1637379352,
    1637379386
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    232,
    1,
    '菜单列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/oplist',
    'GET',
    1637379386,
    1637380273
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    233,
    1,
    '添加菜单',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/one',
    'GET',
    1637380273,
    1637380293
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    234,
    1,
    '菜单列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/oplist',
    'GET',
    1637380293,
    1637389271
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    235,
    1,
    '添加菜单',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/one',
    'GET',
    1637389271,
    1637389295
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    236,
    1,
    '菜单列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/oplist',
    'GET',
    1637389295,
    1637393207
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    237,
    1,
    '添加菜单',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/one',
    'GET',
    1637393207,
    1637393228
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    238,
    1,
    '菜单列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/oplist',
    'GET',
    1637393228,
    1637400399
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    239,
    1,
    '添加菜单',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/one',
    'GET',
    1637400399,
    1637400438
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    240,
    1,
    '菜单列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/oplist',
    'GET',
    1637400438,
    1637405291
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    241,
    1,
    '添加菜单',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/one',
    'GET',
    1637405291,
    1637405311
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    242,
    1,
    '菜单列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/oplist',
    'GET',
    1637405311,
    1637406630
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    243,
    1,
    '添加菜单',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/one',
    'GET',
    1637406629,
    1637406651
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    244,
    1,
    '菜单列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/oplist',
    'GET',
    1637406651,
    1637414645
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    245,
    1,
    '添加菜单',
    '::1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/95.0.4638.54 Safari/537.36',
    '/server/menu/one',
    'GET',
    1637414645,
    1637414672
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    246,
    1,
    '菜单列表',
    '::1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/95.0.4638.54 Safari/537.36',
    '/server/menu/oplist',
    'GET',
    1637414672,
    1637428156
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    247,
    1,
    '添加管理员',
    '::1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/95.0.4638.54 Safari/537.36',
    '/server/admin/addBefore',
    'GET',
    1637428156,
    1637461213
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    248,
    1,
    '菜单列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/oplist',
    'GET',
    1637461213,
    1637461225
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    249,
    1,
    '添加菜单',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/one',
    'GET',
    1637461225,
    1637461264
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    250,
    1,
    '菜单列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/oplist',
    'GET',
    1637461264,
    1637478530
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    251,
    1,
    '添加管理员',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/admin/addBefore',
    'GET',
    1637478530,
    1637489189
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    252,
    1,
    '菜单列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/oplist',
    'GET',
    1637489189,
    1637489193
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    253,
    1,
    '添加菜单',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/one',
    'GET',
    1637489193,
    1637489235
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    254,
    1,
    '菜单列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/oplist',
    'GET',
    1637489235,
    1637490727
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    255,
    1,
    '添加菜单',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/one',
    'GET',
    1637490727,
    1637490750
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    256,
    1,
    '菜单列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/oplist',
    'GET',
    1637490750,
    1637494867
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    257,
    1,
    '编辑菜单',
    '::1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/95.0.4638.54 Safari/537.36',
    '/server/menu/one',
    'GET',
    1637494867,
    1637494942
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    258,
    1,
    '菜单列表',
    '::1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/95.0.4638.54 Safari/537.36',
    '/server/menu/oplist',
    'GET',
    1637494942,
    1637494978
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    259,
    1,
    '编辑菜单',
    '::1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/95.0.4638.54 Safari/537.36',
    '/server/menu/one',
    'GET',
    1637494978,
    1637494996
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    260,
    1,
    '菜单列表',
    '::1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/95.0.4638.54 Safari/537.36',
    '/server/menu/oplist',
    'GET',
    1637494996,
    1637495003
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    261,
    1,
    '编辑菜单',
    '::1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/95.0.4638.54 Safari/537.36',
    '/server/menu/one',
    'GET',
    1637495003,
    1637495008
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    262,
    1,
    '菜单列表',
    '::1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/95.0.4638.54 Safari/537.36',
    '/server/menu/oplist',
    'GET',
    1637495008,
    1637496508
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    263,
    1,
    '添加菜单',
    '::1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/95.0.4638.54 Safari/537.36',
    '/server/menu/one',
    'GET',
    1637496508,
    1637496539
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    264,
    1,
    '菜单列表',
    '::1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/95.0.4638.54 Safari/537.36',
    '/server/menu/oplist',
    'GET',
    1637496539,
    1637498489
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    265,
    1,
    '添加菜单',
    '::1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/95.0.4638.54 Safari/537.36',
    '/server/menu/one',
    'GET',
    1637498489,
    1637498516
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    266,
    1,
    '菜单列表',
    '::1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/95.0.4638.54 Safari/537.36',
    '/server/menu/oplist',
    'GET',
    1637498516,
    1637501699
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    267,
    1,
    '添加菜单',
    '::1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/95.0.4638.54 Safari/537.36',
    '/server/menu/one',
    'GET',
    1637501699,
    1637501722
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    268,
    1,
    '菜单列表',
    '::1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/95.0.4638.54 Safari/537.36',
    '/server/menu/oplist',
    'GET',
    1637501722,
    1637502905
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    269,
    1,
    '添加菜单',
    '::1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/95.0.4638.54 Safari/537.36',
    '/server/menu/one',
    'GET',
    1637502905,
    1637502932
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    270,
    1,
    '菜单列表',
    '::1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/95.0.4638.54 Safari/537.36',
    '/server/menu/oplist',
    'GET',
    1637502932,
    1637504479
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    271,
    1,
    '添加菜单',
    '::1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/95.0.4638.54 Safari/537.36',
    '/server/menu/one',
    'GET',
    1637504479,
    1637505224
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    272,
    1,
    '菜单列表',
    '::1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/95.0.4638.54 Safari/537.36',
    '/server/menu/oplist',
    'GET',
    1637505224,
    1637505395
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    273,
    1,
    '添加菜单',
    '::1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/95.0.4638.54 Safari/537.36',
    '/server/menu/one',
    'GET',
    1637505395,
    1637505417
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    274,
    1,
    '菜单列表',
    '::1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/95.0.4638.54 Safari/537.36',
    '/server/menu/oplist',
    'GET',
    1637505417,
    1637544745
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    275,
    1,
    '添加菜单',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/one',
    'GET',
    1637544745,
    1637544784
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    276,
    1,
    '菜单列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/oplist',
    'GET',
    1637544784,
    1637544822
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    277,
    1,
    '添加菜单',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/one',
    'GET',
    1637544822,
    1637544851
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    278,
    1,
    '菜单列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/oplist',
    'GET',
    1637544851,
    1637544854
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    279,
    1,
    '添加菜单',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/one',
    'GET',
    1637544854,
    1637544885
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    280,
    1,
    '菜单列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/oplist',
    'GET',
    1637544885,
    1637544888
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    281,
    1,
    '添加菜单',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/one',
    'GET',
    1637544888,
    1637544934
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    282,
    1,
    '菜单列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/oplist',
    'GET',
    1637544934,
    1637544937
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    283,
    1,
    '添加菜单',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/one',
    'GET',
    1637544937,
    1637544965
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    284,
    1,
    '菜单列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/oplist',
    'GET',
    1637544965,
    1637548908
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    285,
    1,
    '添加菜单',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/one',
    'GET',
    1637548908,
    1637548933
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    286,
    1,
    '菜单列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/oplist',
    'GET',
    1637548933,
    1637625502
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    287,
    1,
    '角色列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/auth/list',
    'GET',
    1637625502,
    1637625505
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    288,
    1,
    '管理员列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/admin/list',
    'GET',
    1637625505,
    1637639035
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    289,
    1,
    '菜单列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/oplist',
    'GET',
    1637639035,
    1637639045
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    290,
    1,
    '添加菜单',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/one',
    'GET',
    1637639045,
    1637639126
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    291,
    1,
    '菜单列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/oplist',
    'GET',
    1637639126,
    1637641868
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    292,
    1,
    '添加菜单',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/one',
    'GET',
    1637641868,
    1637641890
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    293,
    1,
    '菜单列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/oplist',
    'GET',
    1637641890,
    1637642790
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    294,
    1,
    '编辑菜单',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/one',
    'GET',
    1637642790,
    1637642833
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    295,
    1,
    '菜单列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/oplist',
    'GET',
    1637642833,
    1637642845
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    296,
    1,
    '角色列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/auth/list',
    'GET',
    1637642845,
    1637642850
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    297,
    1,
    '添加角色',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/auth/addTree',
    'GET',
    1637642850,
    1637642872
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    298,
    1,
    '管理员列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/admin/list',
    'GET',
    1637642872,
    1637642950
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    299,
    1,
    '菜单列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/oplist',
    'GET',
    1637642950,
    1637642969
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    300,
    1,
    '编辑菜单',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/one',
    'GET',
    1637642969,
    1637713173
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    301,
    1,
    '菜单列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/oplist',
    'GET',
    1637713173,
    1637713176
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    302,
    1,
    '添加菜单',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/one',
    'GET',
    1637713176,
    1637713210
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    303,
    1,
    '菜单列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/oplist',
    'GET',
    1637713210,
    1637713792
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    304,
    1,
    '添加菜单',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/one',
    'GET',
    1637713792,
    1637713818
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    305,
    1,
    '菜单列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/oplist',
    'GET',
    1637713818,
    1637714343
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    306,
    1,
    '添加菜单',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/one',
    'GET',
    1637714343,
    1637714435
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    307,
    1,
    '菜单列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/oplist',
    'GET',
    1637714435,
    1637714438
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    308,
    1,
    '添加菜单',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/one',
    'GET',
    1637714438,
    1637714458
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    309,
    1,
    '菜单列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/oplist',
    'GET',
    1637714458,
    1637714844
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    310,
    1,
    '添加菜单',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/one',
    'GET',
    1637714844,
    1637714864
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    311,
    1,
    '菜单列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/oplist',
    'GET',
    1637714864,
    1637727723
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    312,
    1,
    '添加菜单',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/one',
    'GET',
    1637727723,
    1637727762
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    313,
    1,
    '菜单列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/oplist',
    'GET',
    1637727762,
    1637727808
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    314,
    1,
    '编辑菜单',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/one',
    'GET',
    1637727808,
    1637812662
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    315,
    1,
    '菜单列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/oplist',
    'GET',
    1637812662,
    1637812683
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    316,
    1,
    '添加菜单',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/one',
    'GET',
    1637812683,
    1637812720
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    317,
    1,
    '菜单列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/oplist',
    'GET',
    1637812720,
    1637814425
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    318,
    1,
    '添加菜单',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/one',
    'GET',
    1637814425,
    1637814442
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    319,
    1,
    '菜单列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/oplist',
    'GET',
    1637814442,
    1637814457
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    320,
    1,
    '添加菜单',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/one',
    'GET',
    1637814457,
    1637814476
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    321,
    1,
    '菜单列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/oplist',
    'GET',
    1637814476,
    1637814489
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    322,
    1,
    '添加菜单',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/one',
    'GET',
    1637814489,
    1637814504
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    323,
    1,
    '菜单列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/oplist',
    'GET',
    1637814504,
    1637814518
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    324,
    1,
    '添加菜单',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/one',
    'GET',
    1637814518,
    1637814535
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    325,
    1,
    '菜单列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/oplist',
    'GET',
    1637814535,
    1637814550
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    326,
    1,
    '添加菜单',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/one',
    'GET',
    1637814550,
    1637814566
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    327,
    1,
    '菜单列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/oplist',
    'GET',
    1637814566,
    1637814577
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    328,
    1,
    '编辑菜单',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/one',
    'GET',
    1637814577,
    1637814586
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    329,
    1,
    '菜单列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/oplist',
    'GET',
    1637814586,
    1637815742
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    330,
    1,
    '添加菜单',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/one',
    'GET',
    1637815741,
    1637815760
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    331,
    1,
    '菜单列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/oplist',
    'GET',
    1637815760,
    1637817556
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    332,
    1,
    '添加菜单',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/one',
    'GET',
    1637817556,
    1637817581
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    333,
    1,
    '菜单列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/oplist',
    'GET',
    1637817581,
    1637829412
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    334,
    1,
    '添加菜单',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/one',
    'GET',
    1637829412,
    1637829436
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    335,
    1,
    '菜单列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/oplist',
    'GET',
    1637829436,
    1637829459
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    336,
    1,
    '添加菜单',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/one',
    'GET',
    1637829459,
    1637829479
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    337,
    1,
    '菜单列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/oplist',
    'GET',
    1637829479,
    1637829516
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    338,
    1,
    '添加菜单',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/one',
    'GET',
    1637829516,
    1637829535
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    339,
    1,
    '菜单列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/oplist',
    'GET',
    1637829535,
    1637829749
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    340,
    1,
    '编辑菜单',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/one',
    'GET',
    1637829749,
    1637832093
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    341,
    1,
    '菜单列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/oplist',
    'GET',
    1637832093,
    1637832097
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    342,
    1,
    '添加菜单',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/one',
    'GET',
    1637832097,
    1637832116
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    343,
    1,
    '菜单列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/oplist',
    'GET',
    1637832116,
    1637885618
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    344,
    1,
    '角色列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/auth/list',
    'GET',
    1637885618,
    1637886930
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    345,
    1,
    '菜单列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/oplist',
    'GET',
    1637886930,
    1637886949
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    346,
    1,
    '添加菜单',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/one',
    'GET',
    1637886949,
    1637886979
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    347,
    1,
    '菜单列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/oplist',
    'GET',
    1637886979,
    1637887497
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    348,
    1,
    '编辑菜单',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/one',
    'GET',
    1637887497,
    1637887503
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    349,
    1,
    '菜单列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/oplist',
    'GET',
    1637887503,
    1637983816
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    350,
    1,
    '添加菜单',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/one',
    'GET',
    1637983816,
    1637983849
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    351,
    1,
    '菜单列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/oplist',
    'GET',
    1637983849,
    1637983920
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    352,
    1,
    '角色列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/auth/list',
    'GET',
    1637983920,
    1637983922
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    353,
    1,
    '管理员列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/admin/list',
    'GET',
    1637983922,
    1637983956
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    354,
    1,
    '菜单列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/oplist',
    'GET',
    1637983956,
    1637984450
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    355,
    1,
    '编辑菜单',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/one',
    'GET',
    1637984450,
    1637984459
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    356,
    1,
    '菜单列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/oplist',
    'GET',
    1637984459,
    1637984470
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    357,
    1,
    '编辑菜单',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/one',
    'GET',
    1637984470,
    1637984475
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    358,
    1,
    '菜单列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/oplist',
    'GET',
    1637984475,
    1638060204
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    359,
    1,
    '管理员列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/admin/list',
    'GET',
    1638060204,
    1638060346
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    360,
    1,
    '菜单列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/oplist',
    'GET',
    1638060346,
    1638096474
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    361,
    1,
    '编辑菜单',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/one',
    'GET',
    1638096474,
    1638096488
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    362,
    1,
    '菜单列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/oplist',
    'GET',
    1638096488,
    1638096513
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    363,
    1,
    '编辑菜单',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/one',
    'GET',
    1638096513,
    1638096577
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    364,
    1,
    '菜单列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/oplist',
    'GET',
    1638096577,
    1638229964
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    365,
    1,
    '编辑菜单',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/one',
    'GET',
    1638229964,
    1638229978
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    366,
    1,
    '菜单列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/oplist',
    'GET',
    1638229978,
    1638235977
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    367,
    1,
    '角色列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/auth/list',
    'GET',
    1638235977,
    1638236109
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    368,
    1,
    '管理员列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/admin/list',
    'GET',
    1638236109,
    1638236130
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    369,
    1,
    '菜单列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/oplist',
    'GET',
    1638236130,
    1638236170
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    370,
    1,
    '编辑菜单',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/one',
    'GET',
    1638236170,
    1638236272
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    371,
    1,
    '菜单列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/oplist',
    'GET',
    1638236272,
    1638236297
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    372,
    1,
    '角色列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/auth/list',
    'GET',
    1638236297,
    1638236300
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    373,
    1,
    '管理员列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/admin/list',
    'GET',
    1638236300,
    1638236333
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    374,
    1,
    '菜单列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/oplist',
    'GET',
    1638236333,
    1638246033
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    375,
    1,
    '添加菜单',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/one',
    'GET',
    1638246033,
    1638246067
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    376,
    1,
    '菜单列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/oplist',
    'GET',
    1638246067,
    1638500877
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    377,
    1,
    '添加菜单',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/one',
    'GET',
    1638500877,
    1638500902
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    378,
    1,
    '菜单列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/oplist',
    'GET',
    1638500902,
    1638502443
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    379,
    1,
    '添加菜单',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/one',
    'GET',
    1638502443,
    1638502463
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    380,
    1,
    '菜单列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/oplist',
    'GET',
    1638502463,
    1638508001
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    381,
    1,
    '添加菜单',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/one',
    'GET',
    1638508001,
    1638508040
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    382,
    1,
    '菜单列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/oplist',
    'GET',
    1638508040,
    1638516601
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    383,
    1,
    '添加菜单',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/one',
    'GET',
    1638516600,
    1638516640
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    384,
    1,
    '菜单列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/oplist',
    'GET',
    1638516640,
    1638518022
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    385,
    1,
    '添加菜单',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/one',
    'GET',
    1638518022,
    1638518052
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    386,
    1,
    '菜单列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/oplist',
    'GET',
    1638518052,
    1638521100
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    387,
    1,
    '添加菜单',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/one',
    'GET',
    1638521100,
    1638521121
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    388,
    1,
    '菜单列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/oplist',
    'GET',
    1638521121,
    1638521814
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    389,
    1,
    '添加菜单',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/one',
    'GET',
    1638521814,
    1638521832
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    390,
    1,
    '菜单列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/oplist',
    'GET',
    1638521832,
    1638522280
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    391,
    1,
    '添加菜单',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/one',
    'GET',
    1638522280,
    1638522299
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    392,
    1,
    '菜单列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/oplist',
    'GET',
    1638522299,
    1638525711
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    393,
    1,
    '添加菜单',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/one',
    'GET',
    1638525711,
    1638525733
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    394,
    1,
    '菜单列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/oplist',
    'GET',
    1638525733,
    1638587531
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    395,
    1,
    '添加菜单',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/one',
    'GET',
    1638587531,
    1638587555
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    396,
    1,
    '菜单列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/oplist',
    'GET',
    1638587555,
    1638591832
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    397,
    1,
    '添加菜单',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/one',
    'GET',
    1638591832,
    1638591849
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    398,
    1,
    '菜单列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/oplist',
    'GET',
    1638591849,
    1638663420
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    399,
    1,
    '添加菜单',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/one',
    'GET',
    1638663420,
    1638663449
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    400,
    1,
    '菜单列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/oplist',
    'GET',
    1638663449,
    1638679036
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    401,
    1,
    '添加菜单',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/one',
    'GET',
    1638679036,
    1638679061
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    402,
    1,
    '菜单列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/oplist',
    'GET',
    1638679061,
    1638758128
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    403,
    1,
    '添加菜单',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/one',
    'GET',
    1638758128,
    1638758164
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    404,
    1,
    '菜单列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/oplist',
    'GET',
    1638758164,
    1638763051
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    405,
    1,
    '添加菜单',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/one',
    'GET',
    1638763051,
    1638763169
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    406,
    1,
    '菜单列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/oplist',
    'GET',
    1638763169,
    1638766243
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    407,
    1,
    '添加菜单',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/one',
    'GET',
    1638766243,
    1638766373
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    408,
    1,
    '菜单列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/oplist',
    'GET',
    1638766373,
    1638766402
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    409,
    1,
    '添加菜单',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/one',
    'GET',
    1638766402,
    1638766432
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    410,
    1,
    '菜单列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/oplist',
    'GET',
    1638766432,
    1638766435
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    411,
    1,
    '添加菜单',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/one',
    'GET',
    1638766435,
    1638766461
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    412,
    1,
    '菜单列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/oplist',
    'GET',
    1638766461,
    1638766688
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    413,
    1,
    '编辑菜单',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/one',
    'GET',
    1638766688,
    1638779639
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    414,
    1,
    '菜单列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0',
    '/server/menu/oplist',
    'GET',
    1638779639,
    1639028681
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    415,
    1,
    '添加菜单',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/menu/one',
    'GET',
    1639028681,
    1639028711
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    416,
    1,
    '菜单列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/menu/oplist',
    'GET',
    1639028711,
    1639029843
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    417,
    1,
    '添加菜单',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/menu/one',
    'GET',
    1639029843,
    1639029862
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    418,
    1,
    '菜单列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/menu/oplist',
    'GET',
    1639029862,
    1639043592
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    419,
    1,
    '添加菜单',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/menu/one',
    'GET',
    1639043592,
    1639043611
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    420,
    1,
    '菜单列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/menu/oplist',
    'GET',
    1639043611,
    1639107821
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    421,
    1,
    '添加菜单',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/menu/one',
    'GET',
    1639107821,
    1639107856
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    422,
    1,
    '菜单列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/menu/oplist',
    'GET',
    1639107856,
    1639126322
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    423,
    1,
    '添加菜单',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/menu/one',
    'GET',
    1639126322,
    1639126571
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    424,
    1,
    '菜单列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/menu/oplist',
    'GET',
    1639126571,
    1639127595
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    425,
    1,
    '添加菜单',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/menu/one',
    'GET',
    1639127595,
    1639127617
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    426,
    1,
    '菜单列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/menu/oplist',
    'GET',
    1639127617,
    1639367443
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    427,
    1,
    '编辑菜单',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/menu/one',
    'GET',
    1639367443,
    1639368083
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    428,
    1,
    '菜单列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/menu/oplist',
    'GET',
    1639368082,
    1639368086
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    429,
    1,
    '编辑菜单',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/menu/one',
    'GET',
    1639368086,
    1639368125
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    430,
    1,
    '菜单列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/menu/oplist',
    'GET',
    1639368125,
    1639368128
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    431,
    1,
    '编辑菜单',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/menu/one',
    'GET',
    1639368128,
    1639368146
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    432,
    1,
    '菜单列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/menu/oplist',
    'GET',
    1639368146,
    1639368161
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    433,
    1,
    '编辑菜单',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/menu/one',
    'GET',
    1639368161,
    1639368164
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    434,
    1,
    '菜单列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/menu/oplist',
    'GET',
    1639368164,
    1639368181
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    435,
    1,
    '编辑菜单',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/menu/one',
    'GET',
    1639368181,
    1639368184
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    436,
    1,
    '菜单列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/menu/oplist',
    'GET',
    1639368184,
    1639368192
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    437,
    1,
    '编辑菜单',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/menu/one',
    'GET',
    1639368192,
    1639368194
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    438,
    1,
    '菜单列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/menu/oplist',
    'GET',
    1639368194,
    1639368202
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    439,
    1,
    '编辑菜单',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/menu/one',
    'GET',
    1639368202,
    1639368204
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    440,
    1,
    '菜单列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/menu/oplist',
    'GET',
    1639368204,
    1639368213
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    441,
    1,
    '编辑菜单',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/menu/one',
    'GET',
    1639368213,
    1639368216
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    442,
    1,
    '菜单列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/menu/oplist',
    'GET',
    1639368216,
    1639375463
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    443,
    1,
    '管理员列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/admin/list',
    'GET',
    1639375463,
    1639375658
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    444,
    1,
    '菜单列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/menu/oplist',
    'GET',
    1639375658,
    1639377596
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    445,
    1,
    '编辑菜单',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/menu/one',
    'GET',
    1639377596,
    1639377600
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    446,
    1,
    '菜单列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/menu/oplist',
    'GET',
    1639377600,
    1639463572
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    447,
    1,
    '编辑菜单',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/menu/one',
    'GET',
    1639463572,
    1639463586
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    448,
    1,
    '菜单列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/menu/oplist',
    'GET',
    1639463586,
    1639463650
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    449,
    1,
    '管理员操作日志',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/logs/op',
    'GET',
    1639463650,
    1639463683
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    450,
    1,
    '菜单列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/menu/oplist',
    'GET',
    1639463683,
    1639463919
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    451,
    1,
    '系统错误日志',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/logs/err',
    'GET',
    1639463919,
    1639471348
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    452,
    1,
    '菜单列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/menu/oplist',
    'GET',
    1639471348,
    1639471390
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    453,
    1,
    '编辑菜单',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/menu/one',
    'GET',
    1639471390,
    1639471393
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    454,
    1,
    '菜单列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/menu/oplist',
    'GET',
    1639471393,
    1639472040
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    455,
    1,
    '编辑菜单',
    '::1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/93.0.4577.82 Safari/537.36',
    '/server/menu/one',
    'GET',
    1639472040,
    1639472046
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    456,
    1,
    '菜单列表',
    '::1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/93.0.4577.82 Safari/537.36',
    '/server/menu/oplist',
    'GET',
    1639472046,
    1639472535
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    457,
    1,
    '编辑菜单',
    '::1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/93.0.4577.82 Safari/537.36',
    '/server/menu/one',
    'GET',
    1639472535,
    1639472569
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    458,
    1,
    '菜单列表',
    '::1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/93.0.4577.82 Safari/537.36',
    '/server/menu/oplist',
    'GET',
    1639472569,
    1639478024
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    459,
    1,
    '编辑菜单',
    '::1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/93.0.4577.82 Safari/537.36',
    '/server/menu/one',
    'GET',
    1639478024,
    1639478026
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    460,
    1,
    '菜单列表',
    '::1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/93.0.4577.82 Safari/537.36',
    '/server/menu/oplist',
    'GET',
    1639478026,
    1639482705
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    461,
    1,
    '编辑菜单',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/menu/one',
    'GET',
    1639482705,
    1639482739
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    462,
    1,
    '菜单列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/menu/oplist',
    'GET',
    1639482739,
    1639563362
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    463,
    1,
    '编辑菜单',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/menu/one',
    'GET',
    1639563362,
    1639563395
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    464,
    1,
    '菜单列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/menu/oplist',
    'GET',
    1639563395,
    1639563419
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    465,
    1,
    '编辑菜单',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/menu/one',
    'GET',
    1639563419,
    1639563435
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    466,
    1,
    '菜单列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/menu/oplist',
    'GET',
    1639563435,
    1639563448
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    467,
    1,
    '编辑菜单',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/menu/one',
    'GET',
    1639563448,
    1639563455
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    468,
    1,
    '菜单列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/menu/oplist',
    'GET',
    1639563455,
    1639563463
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    469,
    1,
    '编辑菜单',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/menu/one',
    'GET',
    1639563463,
    1639563468
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    470,
    1,
    '菜单列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/menu/oplist',
    'GET',
    1639563468,
    1639563474
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    471,
    1,
    '编辑菜单',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/menu/one',
    'GET',
    1639563474,
    1639563486
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    472,
    1,
    '菜单列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/menu/oplist',
    'GET',
    1639563486,
    1639625649
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    473,
    1,
    '编辑菜单',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/menu/one',
    'GET',
    1639625649,
    1639625662
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    474,
    1,
    '菜单列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/menu/oplist',
    'GET',
    1639625662,
    1639626748
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    475,
    1,
    '编辑菜单',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/menu/one',
    'GET',
    1639626748,
    1639626751
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    476,
    1,
    '菜单列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/menu/oplist',
    'GET',
    1639626751,
    1639629165
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    477,
    1,
    '编辑菜单',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/menu/one',
    'GET',
    1639629165,
    1639646736
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    478,
    1,
    '菜单列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/menu/oplist',
    'GET',
    1639646736,
    1639646740
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    479,
    1,
    '添加菜单',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/menu/one',
    'GET',
    1639646740,
    1639646768
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    480,
    1,
    '菜单列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/menu/oplist',
    'GET',
    1639646768,
    1639699939
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    481,
    1,
    '编辑菜单',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/menu/one',
    'GET',
    1639699939,
    1639699944
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    482,
    1,
    '菜单列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/menu/oplist',
    'GET',
    1639699944,
    1639815181
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    483,
    1,
    '添加菜单',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/menu/one',
    'GET',
    1639815180,
    1639815206
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    484,
    1,
    '菜单列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/menu/oplist',
    'GET',
    1639815206,
    1639963287
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    485,
    1,
    '添加菜单',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/menu/one',
    'GET',
    1639963287,
    1639964325
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    486,
    1,
    '菜单列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/menu/oplist',
    'GET',
    1639964325,
    1639964328
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    487,
    1,
    '添加菜单',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/menu/one',
    'GET',
    1639964328,
    1639964372
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    488,
    1,
    '菜单列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/menu/oplist',
    'GET',
    1639964372,
    1639964375
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    489,
    1,
    '添加菜单',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/menu/one',
    'GET',
    1639964375,
    1639965284
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    490,
    1,
    '菜单列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/menu/oplist',
    'GET',
    1639965284,
    1639965300
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    491,
    1,
    '编辑菜单',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/menu/one',
    'GET',
    1639965300,
    1639965303
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    492,
    1,
    '菜单列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/menu/oplist',
    'GET',
    1639965303,
    1639969556
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    493,
    1,
    '编辑菜单',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/menu/one',
    'GET',
    1639969556,
    1639969722
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    494,
    1,
    '菜单列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/menu/oplist',
    'GET',
    1639969722,
    1639970147
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    495,
    1,
    '编辑菜单',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/menu/one',
    'GET',
    1639970147,
    1639970150
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    496,
    1,
    '菜单列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/menu/oplist',
    'GET',
    1639970150,
    1640085386
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    497,
    1,
    '添加菜单',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/menu/one',
    'GET',
    1640085386,
    1640085438
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    498,
    1,
    '菜单列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/menu/oplist',
    'GET',
    1640085438,
    1640085455
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    499,
    1,
    '添加菜单',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/menu/one',
    'GET',
    1640085455,
    1640085484
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    500,
    1,
    '菜单列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/menu/oplist',
    'GET',
    1640085484,
    1640250930
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    501,
    1,
    '编辑菜单',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/menu/one',
    'GET',
    1640250930,
    1640250957
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    502,
    1,
    '菜单列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/menu/oplist',
    'GET',
    1640250957,
    1640250962
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    503,
    1,
    '添加菜单',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/menu/one',
    'GET',
    1640250962,
    1640250982
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    504,
    1,
    '菜单列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/menu/oplist',
    'GET',
    1640250982,
    1640322250
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    505,
    1,
    '添加菜单',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/menu/one',
    'GET',
    1640322250,
    1640322288
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    506,
    1,
    '菜单列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/menu/oplist',
    'GET',
    1640322288,
    1640322300
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    507,
    1,
    '编辑菜单',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/menu/one',
    'GET',
    1640322300,
    1640322303
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    508,
    1,
    '菜单列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/menu/oplist',
    'GET',
    1640322303,
    1640511595
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    509,
    1,
    '添加菜单',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/menu/one',
    'GET',
    1640511595,
    1640511621
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    510,
    1,
    '菜单列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/menu/oplist',
    'GET',
    1640511621,
    1640564206
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    511,
    1,
    '编辑菜单',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/menu/one',
    'GET',
    1640564206,
    1640564225
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    512,
    1,
    '菜单列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/menu/oplist',
    'GET',
    1640564225,
    1640662381
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    513,
    1,
    '编辑菜单',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/menu/one',
    'GET',
    1640662381,
    1640662383
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    514,
    1,
    '菜单列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/menu/oplist',
    'GET',
    1640662383,
    1640662435
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    515,
    1,
    '编辑菜单',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/menu/one',
    'GET',
    1640662435,
    1640662444
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    516,
    1,
    '菜单列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/menu/oplist',
    'GET',
    1640662444,
    1640666469
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    517,
    1,
    '添加菜单',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/menu/one',
    'GET',
    1640666469,
    1640666535
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    518,
    1,
    '菜单列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/menu/oplist',
    'GET',
    1640666535,
    1640666545
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    519,
    1,
    '编辑菜单',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/menu/one',
    'GET',
    1640666545,
    1640670853
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    520,
    1,
    '查看计划任务列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/crons/list',
    'GET',
    1640670853,
    1640671119
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    521,
    1,
    '菜单列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/menu/oplist',
    'GET',
    1640671119,
    1640671125
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    522,
    1,
    '添加菜单',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/menu/one',
    'GET',
    1640671125,
    1640671160
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    523,
    1,
    '菜单列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/menu/oplist',
    'GET',
    1640671160,
    1640671263
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    524,
    1,
    '查看计划任务列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/crons/list',
    'GET',
    1640671263,
    1640765586
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    525,
    1,
    '菜单列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/menu/oplist',
    'GET',
    1640765586,
    1640765605
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    526,
    1,
    '添加菜单',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/menu/one',
    'GET',
    1640765605,
    1640765639
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    527,
    1,
    '菜单列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/menu/oplist',
    'GET',
    1640765639,
    1641432469
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    528,
    1,
    '编辑菜单',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/menu/one',
    'GET',
    1641432469,
    1641529175
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    529,
    1,
    '菜单列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/menu/oplist',
    'GET',
    1641529175,
    1641529180
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    530,
    1,
    '添加菜单',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/menu/one',
    'GET',
    1641529180,
    1641529211
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    531,
    1,
    '菜单列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/menu/oplist',
    'GET',
    1641529211,
    1641533951
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    532,
    1,
    '添加菜单',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/menu/one',
    'GET',
    1641533951,
    1641533984
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    533,
    1,
    '菜单列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/menu/oplist',
    'GET',
    1641533984,
    1641535480
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    534,
    1,
    '编辑菜单',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/menu/one',
    'GET',
    1641535480,
    1641535493
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    535,
    1,
    '菜单列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/menu/oplist',
    'GET',
    1641535493,
    1641536255
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    536,
    1,
    '角色列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/auth/list',
    'GET',
    1641536255,
    1641536263
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    537,
    1,
    '编辑角色',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/auth/beforEdit',
    'GET',
    1641536263,
    1641539272
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    538,
    1,
    '菜单列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/menu/oplist',
    'GET',
    1641539271,
    1641539282
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    539,
    1,
    '编辑菜单',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/menu/one',
    'GET',
    1641539282,
    1641539295
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    540,
    1,
    '菜单列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/menu/oplist',
    'GET',
    1641539295,
    1641540476
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    541,
    1,
    '添加菜单',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/menu/one',
    'GET',
    1641540476,
    1641540498
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    542,
    1,
    '菜单列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/menu/oplist',
    'GET',
    1641540498,
    1641547667
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    543,
    1,
    '添加菜单',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/menu/one',
    'GET',
    1641547667,
    1641547688
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    544,
    1,
    '菜单列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/menu/oplist',
    'GET',
    1641547688,
    1641609582
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    545,
    1,
    '查看计划任务列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/crons/list',
    'GET',
    1641609582,
    1641705456
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    546,
    1,
    '菜单列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/menu/oplist',
    'GET',
    1641705456,
    1641705507
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    547,
    1,
    '编辑菜单',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/menu/one',
    'GET',
    1641705507,
    1641705516
  );
INSERT INTO
  `rt_admin_viewlog` (
    `id`,
    `admin_id`,
    `log`,
    `ip`,
    `agent`,
    `url`,
    `method`,
    `addtime`,
    `leavetime`
  )
VALUES
  (
    548,
    1,
    '菜单列表',
    '::ffff:127.0.0.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0) Gecko/20100101 Firefox/95.0',
    '/server/menu/oplist',
    'GET',
    1641705516,
    0
  );

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: rt_api
# ------------------------------------------------------------

INSERT INTO
  `rt_api` (
    `id`,
    `name`,
    `mod_id`,
    `menu_id`,
    `mod_key`,
    `key`,
    `method`,
    `remark`,
    `add_time`,
    `update_time`,
    `user_id`
  )
VALUES
  (
    12,
    '文章列表',
    46,
    0,
    'art',
    'list',
    'get',
    '',
    1638779692,
    1638779692,
    1
  );
INSERT INTO
  `rt_api` (
    `id`,
    `name`,
    `mod_id`,
    `menu_id`,
    `mod_key`,
    `key`,
    `method`,
    `remark`,
    `add_time`,
    `update_time`,
    `user_id`
  )
VALUES
  (
    13,
    '文章分类列表',
    46,
    215,
    'art',
    'artcate',
    'get',
    '',
    1639278934,
    1639278934,
    1
  );

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: rt_api_form
# ------------------------------------------------------------


# ------------------------------------------------------------
# DATA DUMP FOR TABLE: rt_api_logic
# ------------------------------------------------------------

INSERT INTO
  `rt_api_logic` (`id`, `code`, `add_time`, `update_time`)
VALUES
  (
    12,
    '<xml xmlns=\"https://developers.google.com/blockly/xml\"><block type=\"gd_var\" id=\"w%.+3f~X=g2PemM=+|gQ\" x=\"63\" y=\"38\"><field name=\"var_type\">let</field><field name=\"var\">data</field><value name=\"val\"><block type=\"gd_post\" id=\"xd{M-#D7BQ4-RT.d6fVk\"><field name=\"var\"></field></block></value><next><block type=\"controls_if\" id=\",378wuFR,v^x$f1jwg,a\"><value name=\"IF0\"><block type=\"gd_isempty\" id=\"}P4epe6$T}kcothj@(Bl\"><field name=\"var_type\">isEmpty</field><field name=\"var\">data</field></block></value><statement name=\"DO0\"><block type=\"gd_console\" id=\"_P#9!|CI=gD)q@yVaj{h\"><field name=\"var\">data</field><next><block type=\"gd_fail\" id=\",j6GIZnJ}e3O2d4w:(~+\"><field name=\"var\">\"数据为空\"</field></block></next></block></statement><next><block type=\"controls_switch\" id=\")H|i~uC6|Lqww`Z{$8m;\"><value name=\"SWITCH\"><block type=\"gd_post\" id=\"PW]4SMcpg3aYyD4y4cOu\"><field name=\"var\"></field></block></value><value name=\"CASE0\"><block type=\"gd_get\" id=\"hj]Rv;?xh@(d,^A}Tu~(\"><field name=\"var\"></field></block></value><statement name=\"DO0\"><block type=\"gd_var\" id=\"-1Jl|!BI$^IyjDFHa0c[\"><field name=\"var_type\">let</field><field name=\"var\">data</field><value name=\"val\"><block type=\"gd_inline\" id=\"$Ay4vp_LAXL!x`(^-x[N\"><field name=\"var\">\'ddd\'</field></block></value></block></statement></block></next></block></next></block></xml>',
    1639029122,
    1639034082
  );
INSERT INTO
  `rt_api_logic` (`id`, `code`, `add_time`, `update_time`)
VALUES
  (
    13,
    '<xml xmlns=\"https://developers.google.com/blockly/xml\"><block type=\"gd_var\" id=\"l-@1J}hjVT*qGJ_7=E2^\" x=\"288\" y=\"63\"><field name=\"var_type\">let</field><field name=\"var\">data</field></block></xml>',
    1641434920,
    0
  );

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: rt_api_params
# ------------------------------------------------------------

INSERT INTO
  `rt_api_params` (
    `id`,
    `aid`,
    `key`,
    `name`,
    `type`,
    `len_min`,
    `len_max`,
    `num_min`,
    `num_max`,
    `def`,
    `required`,
    `format`,
    `isdb`,
    `tablename`,
    `tablefield`
  )
VALUES
  (
    16,
    12,
    'id',
    '文章id',
    'number',
    0,
    0,
    0,
    0,
    '',
    0,
    NULL,
    1,
    'rt_article',
    'id'
  );
INSERT INTO
  `rt_api_params` (
    `id`,
    `aid`,
    `key`,
    `name`,
    `type`,
    `len_min`,
    `len_max`,
    `num_min`,
    `num_max`,
    `def`,
    `required`,
    `format`,
    `isdb`,
    `tablename`,
    `tablefield`
  )
VALUES
  (
    17,
    12,
    'category_id',
    '分类id',
    'number',
    0,
    0,
    0,
    0,
    '11',
    1,
    NULL,
    1,
    'rt_article',
    'category_id'
  );
INSERT INTO
  `rt_api_params` (
    `id`,
    `aid`,
    `key`,
    `name`,
    `type`,
    `len_min`,
    `len_max`,
    `num_min`,
    `num_max`,
    `def`,
    `required`,
    `format`,
    `isdb`,
    `tablename`,
    `tablefield`
  )
VALUES
  (
    24,
    12,
    'title',
    '标题',
    'string',
    0,
    0,
    0,
    0,
    '1231',
    1,
    NULL,
    1,
    'rt_article',
    'title'
  );
INSERT INTO
  `rt_api_params` (
    `id`,
    `aid`,
    `key`,
    `name`,
    `type`,
    `len_min`,
    `len_max`,
    `num_min`,
    `num_max`,
    `def`,
    `required`,
    `format`,
    `isdb`,
    `tablename`,
    `tablefield`
  )
VALUES
  (
    25,
    12,
    'desc_content',
    '',
    'string',
    0,
    0,
    0,
    0,
    '',
    1,
    NULL,
    1,
    'rt_article',
    'desc_content'
  );
INSERT INTO
  `rt_api_params` (
    `id`,
    `aid`,
    `key`,
    `name`,
    `type`,
    `len_min`,
    `len_max`,
    `num_min`,
    `num_max`,
    `def`,
    `required`,
    `format`,
    `isdb`,
    `tablename`,
    `tablefield`
  )
VALUES
  (
    26,
    12,
    'image',
    '图片',
    'string',
    0,
    0,
    1,
    10,
    '',
    1,
    'image',
    1,
    'rt_article',
    'image'
  );
INSERT INTO
  `rt_api_params` (
    `id`,
    `aid`,
    `key`,
    `name`,
    `type`,
    `len_min`,
    `len_max`,
    `num_min`,
    `num_max`,
    `def`,
    `required`,
    `format`,
    `isdb`,
    `tablename`,
    `tablefield`
  )
VALUES
  (
    27,
    12,
    'content',
    '内容',
    'string',
    0,
    0,
    0,
    0,
    '',
    1,
    'date',
    1,
    'rt_article',
    'content'
  );
INSERT INTO
  `rt_api_params` (
    `id`,
    `aid`,
    `key`,
    `name`,
    `type`,
    `len_min`,
    `len_max`,
    `num_min`,
    `num_max`,
    `def`,
    `required`,
    `format`,
    `isdb`,
    `tablename`,
    `tablefield`
  )
VALUES
  (
    30,
    12,
    'author',
    '作者:id:name',
    'string',
    0,
    0,
    0,
    0,
    '',
    1,
    NULL,
    1,
    'rt_article',
    'author'
  );
INSERT INTO
  `rt_api_params` (
    `id`,
    `aid`,
    `key`,
    `name`,
    `type`,
    `len_min`,
    `len_max`,
    `num_min`,
    `num_max`,
    `def`,
    `required`,
    `format`,
    `isdb`,
    `tablename`,
    `tablefield`
  )
VALUES
  (
    34,
    12,
    'limit',
    '每页数据量',
    'number',
    0,
    0,
    0,
    0,
    '20',
    0,
    NULL,
    0,
    '',
    ''
  );
INSERT INTO
  `rt_api_params` (
    `id`,
    `aid`,
    `key`,
    `name`,
    `type`,
    `len_min`,
    `len_max`,
    `num_min`,
    `num_max`,
    `def`,
    `required`,
    `format`,
    `isdb`,
    `tablename`,
    `tablefield`
  )
VALUES
  (
    35,
    12,
    'param',
    '分页参数',
    'string',
    0,
    0,
    0,
    0,
    '',
    0,
    NULL,
    0,
    '',
    ''
  );
INSERT INTO
  `rt_api_params` (
    `id`,
    `aid`,
    `key`,
    `name`,
    `type`,
    `len_min`,
    `len_max`,
    `num_min`,
    `num_max`,
    `def`,
    `required`,
    `format`,
    `isdb`,
    `tablename`,
    `tablefield`
  )
VALUES
  (
    36,
    12,
    'page',
    '分页页数',
    'number',
    0,
    0,
    0,
    0,
    '1',
    0,
    NULL,
    0,
    '',
    ''
  );

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: rt_api_table
# ------------------------------------------------------------


# ------------------------------------------------------------
# DATA DUMP FOR TABLE: rt_api_test
# ------------------------------------------------------------

INSERT INTO
  `rt_api_test` (
    `id`,
    `name`,
    `aid`,
    `data`,
    `method`,
    `add_time`,
    `update_time`
  )
VALUES
  (
    1,
    '发发',
    13,
    '{\"formData\":{\"method\":\"get\",\"test_path\":\"/server/art/artcate\"},\"paramsData\":[],\"hasCookie\":true,\"headerData\":{\"Accept\":\"*/*\",\"rttoken\":\"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhZG1pbklkIjoxLCJpYXQiOjE2NDE1MjcxMDcsImV4cCI6MTY0MTU3MDMwN30.nVQ2WKlHw_2TP6tbL05iPirXQo73vKUubzpHnWlHSE0\"},\"statusCode\":\"200\",\"deepData\":{\"data\":[]},\"descData\":\"\\n\",\"name\":\"发发\",\"resCode\":\"\",\"resResult\":\"\",\"aid\":\"13\"}',
    '',
    0,
    0
  );
INSERT INTO
  `rt_api_test` (
    `id`,
    `name`,
    `aid`,
    `data`,
    `method`,
    `add_time`,
    `update_time`
  )
VALUES
  (
    2,
    'test',
    13,
    '{\"formData\":{\"method\":\"get\",\"test_path\":\"/server/art/artcate\"},\"paramsData\":[],\"hasCookie\":true,\"headerData\":{\"Accept\":\"*/*\",\"rttoken\":\"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhZG1pbklkIjoxLCJpYXQiOjE2NDE1MzQzMjksImV4cCI6MTY0MTU3NzUyOX0.kbIu07sQo4T1B2XaKxq5DJewzBKnG-uenYIc-fbPYVk\"},\"statusCode\":\"200\",\"deepData\":{\"data\":[]},\"descData\":\"\\n\",\"name\":\"test\",\"resCode\":\"\",\"resResult\":\"\",\"aid\":\"13\"}',
    'get',
    1641534667,
    0
  );

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: rt_area
# ------------------------------------------------------------

INSERT INTO
  `rt_area` (`id`, `name`, `pid`, `status`, `order_num`)
VALUES
  (110000, '北京市', 0, 1, 0);
INSERT INTO
  `rt_area` (`id`, `name`, `pid`, `status`, `order_num`)
VALUES
  (110100, '东城区', 110000, 1, 0);
INSERT INTO
  `rt_area` (`id`, `name`, `pid`, `status`, `order_num`)
VALUES
  (110200, '西城区', 110000, 1, 0);
INSERT INTO
  `rt_area` (`id`, `name`, `pid`, `status`, `order_num`)
VALUES
  (110500, '朝阳区', 110000, 1, 0);
INSERT INTO
  `rt_area` (`id`, `name`, `pid`, `status`, `order_num`)
VALUES
  (110600, '丰台区', 110000, 1, 0);
INSERT INTO
  `rt_area` (`id`, `name`, `pid`, `status`, `order_num`)
VALUES
  (110700, '石景山区', 110000, 1, 0);
INSERT INTO
  `rt_area` (`id`, `name`, `pid`, `status`, `order_num`)
VALUES
  (110800, '海淀区', 110000, 1, 0);
INSERT INTO
  `rt_area` (`id`, `name`, `pid`, `status`, `order_num`)
VALUES
  (110900, '门头沟区', 110000, 1, 0);
INSERT INTO
  `rt_area` (`id`, `name`, `pid`, `status`, `order_num`)
VALUES
  (111100, '房山区', 110000, 1, 0);
INSERT INTO
  `rt_area` (`id`, `name`, `pid`, `status`, `order_num`)
VALUES
  (111200, '通州区', 110000, 1, 0);
INSERT INTO
  `rt_area` (`id`, `name`, `pid`, `status`, `order_num`)
VALUES
  (111300, '顺义区', 110000, 1, 0);
INSERT INTO
  `rt_area` (`id`, `name`, `pid`, `status`, `order_num`)
VALUES
  (111400, '昌平区', 110000, 1, 0);
INSERT INTO
  `rt_area` (`id`, `name`, `pid`, `status`, `order_num`)
VALUES
  (111500, '大兴区', 110000, 1, 0);
INSERT INTO
  `rt_area` (`id`, `name`, `pid`, `status`, `order_num`)
VALUES
  (111600, '怀柔区', 110000, 1, 0);
INSERT INTO
  `rt_area` (`id`, `name`, `pid`, `status`, `order_num`)
VALUES
  (111700, '平谷区', 110000, 1, 0);
INSERT INTO
  `rt_area` (`id`, `name`, `pid`, `status`, `order_num`)
VALUES
  (112800, '密云县', 110000, 1, 0);
INSERT INTO
  `rt_area` (`id`, `name`, `pid`, `status`, `order_num`)
VALUES
  (112900, '延庆县', 110000, 1, 0);
INSERT INTO
  `rt_area` (`id`, `name`, `pid`, `status`, `order_num`)
VALUES
  (120000, '天津市', 0, 1, 0);
INSERT INTO
  `rt_area` (`id`, `name`, `pid`, `status`, `order_num`)
VALUES
  (130000, '河北省', 0, 1, 0);
INSERT INTO
  `rt_area` (`id`, `name`, `pid`, `status`, `order_num`)
VALUES
  (140000, '山西省', 0, 1, 0);
INSERT INTO
  `rt_area` (`id`, `name`, `pid`, `status`, `order_num`)
VALUES
  (150000, '内蒙古自治区', 0, 1, 0);
INSERT INTO
  `rt_area` (`id`, `name`, `pid`, `status`, `order_num`)
VALUES
  (210000, '辽宁省', 0, 1, 0);
INSERT INTO
  `rt_area` (`id`, `name`, `pid`, `status`, `order_num`)
VALUES
  (220000, '吉林省', 0, 1, 0);
INSERT INTO
  `rt_area` (`id`, `name`, `pid`, `status`, `order_num`)
VALUES
  (230000, '黑龙江省', 0, 1, 0);
INSERT INTO
  `rt_area` (`id`, `name`, `pid`, `status`, `order_num`)
VALUES
  (310000, '上海市', 0, 1, 0);
INSERT INTO
  `rt_area` (`id`, `name`, `pid`, `status`, `order_num`)
VALUES
  (320000, '江苏省', 0, 1, 0);
INSERT INTO
  `rt_area` (`id`, `name`, `pid`, `status`, `order_num`)
VALUES
  (330000, '浙江省', 0, 1, 0);
INSERT INTO
  `rt_area` (`id`, `name`, `pid`, `status`, `order_num`)
VALUES
  (340000, '安徽省', 0, 1, 0);
INSERT INTO
  `rt_area` (`id`, `name`, `pid`, `status`, `order_num`)
VALUES
  (341402, '居巢区', NULL, 1, 0);
INSERT INTO
  `rt_area` (`id`, `name`, `pid`, `status`, `order_num`)
VALUES
  (350000, '福建省', 0, 1, 0);
INSERT INTO
  `rt_area` (`id`, `name`, `pid`, `status`, `order_num`)
VALUES
  (360000, '江西省', 0, 1, 0);
INSERT INTO
  `rt_area` (`id`, `name`, `pid`, `status`, `order_num`)
VALUES
  (370000, '山东省', 0, 1, 0);
INSERT INTO
  `rt_area` (`id`, `name`, `pid`, `status`, `order_num`)
VALUES
  (410000, '河南省', 0, 1, 0);
INSERT INTO
  `rt_area` (`id`, `name`, `pid`, `status`, `order_num`)
VALUES
  (420000, '湖北省', 0, 1, 0);
INSERT INTO
  `rt_area` (`id`, `name`, `pid`, `status`, `order_num`)
VALUES
  (430000, '湖南省', 0, 1, 0);
INSERT INTO
  `rt_area` (`id`, `name`, `pid`, `status`, `order_num`)
VALUES
  (440000, '广东省', 0, 1, 0);
INSERT INTO
  `rt_area` (`id`, `name`, `pid`, `status`, `order_num`)
VALUES
  (450000, '广西壮族自治区', 0, 1, 0);
INSERT INTO
  `rt_area` (`id`, `name`, `pid`, `status`, `order_num`)
VALUES
  (460000, '海南省', 0, 1, 0);
INSERT INTO
  `rt_area` (`id`, `name`, `pid`, `status`, `order_num`)
VALUES
  (500000, '重庆市', 0, 1, 0);
INSERT INTO
  `rt_area` (`id`, `name`, `pid`, `status`, `order_num`)
VALUES
  (510000, '四川省', 0, 1, 0);
INSERT INTO
  `rt_area` (`id`, `name`, `pid`, `status`, `order_num`)
VALUES
  (520000, '贵州省', 0, 1, 0);
INSERT INTO
  `rt_area` (`id`, `name`, `pid`, `status`, `order_num`)
VALUES
  (530000, '云南省', 0, 1, 0);
INSERT INTO
  `rt_area` (`id`, `name`, `pid`, `status`, `order_num`)
VALUES
  (540000, '西藏自治区', 0, 1, 0);
INSERT INTO
  `rt_area` (`id`, `name`, `pid`, `status`, `order_num`)
VALUES
  (610000, '陕西省', 0, 1, 0);
INSERT INTO
  `rt_area` (`id`, `name`, `pid`, `status`, `order_num`)
VALUES
  (620000, '甘肃省', 0, 1, 0);
INSERT INTO
  `rt_area` (`id`, `name`, `pid`, `status`, `order_num`)
VALUES
  (630000, '青海省', 0, 1, 0);
INSERT INTO
  `rt_area` (`id`, `name`, `pid`, `status`, `order_num`)
VALUES
  (640000, '宁夏回族自治区', 0, 1, 0);
INSERT INTO
  `rt_area` (`id`, `name`, `pid`, `status`, `order_num`)
VALUES
  (650000, '新疆维吾尔自治区', 0, 1, 0);
INSERT INTO
  `rt_area` (`id`, `name`, `pid`, `status`, `order_num`)
VALUES
  (990000, '新疆建设兵团', 0, 1, 0);

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: rt_article
# ------------------------------------------------------------


# ------------------------------------------------------------
# DATA DUMP FOR TABLE: rt_cate
# ------------------------------------------------------------


# ------------------------------------------------------------
# DATA DUMP FOR TABLE: rt_category
# ------------------------------------------------------------


# ------------------------------------------------------------
# DATA DUMP FOR TABLE: rt_chat_friend_log
# ------------------------------------------------------------


# ------------------------------------------------------------
# DATA DUMP FOR TABLE: rt_chat_friends
# ------------------------------------------------------------


# ------------------------------------------------------------
# DATA DUMP FOR TABLE: rt_chat_group_detail
# ------------------------------------------------------------


# ------------------------------------------------------------
# DATA DUMP FOR TABLE: rt_chat_group_log
# ------------------------------------------------------------


# ------------------------------------------------------------
# DATA DUMP FOR TABLE: rt_chat_group_member
# ------------------------------------------------------------


# ------------------------------------------------------------
# DATA DUMP FOR TABLE: rt_chat_notify
# ------------------------------------------------------------


# ------------------------------------------------------------
# DATA DUMP FOR TABLE: rt_chat_users
# ------------------------------------------------------------

INSERT INTO
  `rt_chat_users` (
    `user_id`,
    `username`,
    `groupid`,
    `status`,
    `sign`,
    `avatar`
  )
VALUES
  (
    1,
    '纸飞机',
    2,
    'outline',
    '在深邃的编码世界，做一枚轻盈的纸飞机',
    'http://cdn.firstlinkapp.com/upload/2016_6/1465575923433_33812.jpg'
  );
INSERT INTO
  `rt_chat_users` (
    `user_id`,
    `username`,
    `groupid`,
    `status`,
    `sign`,
    `avatar`
  )
VALUES
  (
    2,
    '马云',
    2,
    'outline',
    '让天下没有难写的代码',
    'http://tp4.sinaimg.cn/2145291155/180/5601307179/1'
  );
INSERT INTO
  `rt_chat_users` (
    `user_id`,
    `username`,
    `groupid`,
    `status`,
    `sign`,
    `avatar`
  )
VALUES
  (
    3,
    '罗玉凤',
    3,
    'online',
    '在自己实力不济的时候，不要去相信什么媒体和记者。他们不是善良的人，有时候候他们的采访对当事人而言就是陷阱',
    'http://tp1.sinaimg.cn/1241679004/180/5743814375/0'
  );
INSERT INTO
  `rt_chat_users` (
    `user_id`,
    `username`,
    `groupid`,
    `status`,
    `sign`,
    `avatar`
  )
VALUES
  (
    13,
    '前端大神',
    1,
    'outline',
    '前端就是这么牛',
    'http://tp1.sinaimg.cn/1241679004/180/5743814375/0'
  );

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: rt_code
# ------------------------------------------------------------

INSERT INTO
  `rt_code` (
    `id`,
    `add_time`,
    `update_time`,
    `user_id`,
    `name`,
    `path`,
    `title`,
    `content`,
    `type`,
    `remark`
  )
VALUES
  (
    1,
    0,
    1639048245,
    0,
    'api_test',
    'server',
    '接口测试',
    '<xml xmlns=\"https://developers.google.com/blockly/xml\"><block type=\"gd_class\" id=\"Z*{ruYW)N@e4i4Td.Tgo\" x=\"113\" y=\"-388\"><field name=\"className\">apitest</field><field name=\"extendsName\"></field><field name=\"var_type\">Base</field><statement name=\"chain\"><block type=\"gd_classmethod\" id=\".b]f{^Rv=ks$hbgAe.|m\"><field name=\"methodName\">async listAction</field><field name=\"params\"></field><comment pinned=\"false\" h=\"80\" w=\"160\">列表函数</comment><statement name=\"chains\"><block type=\"gd_lets\" id=\"^:y(#gy_bY?(v.|i?mMH\"><field name=\"var_type\">let</field><field name=\"letsname\">this.get()</field><statement name=\"chain\"><block type=\"gd_plain\" id=\"A!@SJ;{]:=A:/+(LOd%9\"><field name=\"var\">page</field><next><block type=\"gd_plain\" id=\"9`i9FBwkXk)=~T![rK,2\"><field name=\"var\">limit</field><next><block type=\"gd_plain\" id=\"HkhuQnCL;8wXMKD=Lv~t\"><field name=\"var\">param</field></block></next></block></next></block></statement><next><block type=\"gd_var\" id=\"RX)ZT3wm~ma_B_/pV9wk\"><field name=\"var_type\">let</field><field name=\"var\">wsql</field><value name=\"val\"><block type=\"gd_inline\" id=\"8Q-g#XEjxa`r`L.7+k~x\"><field name=\"var\">{}</field></block></value><next><block type=\"controls_if\" id=\"oH8i?De{Nd|Q8?Qtv-b)\"><value name=\"IF0\"><block type=\"gd_inline\" id=\"PNa@s@jwAN*0,+}Wk7k0\"><field name=\"var\">param</field></block></value><statement name=\"DO0\"><block type=\"gd_val\" id=\"y@Rr8rtTf{6jo2p?gUag\"><field name=\"var1\">wsql</field><field name=\"var2\">this.parseSearch(param,wsql)</field></block></statement><next><block type=\"gd_var\" id=\"QaDzZ^.}rM4cIYfHJo}2\"><field name=\"var_type\">let</field><field name=\"var\">list</field><value name=\"val\"><block type=\"gd_await\" id=\"k^H)L(.mRv`F%vK`a1n|\"><value name=\"val\"><block type=\"gd_model\" id=\"B*G`3dClllHY+g00}:O7\"><field name=\"var\">api_test</field><value name=\"val\"><block type=\"gd_where\" id=\"$*uv=r5bLLhd:pa)Q~_Z\"><field name=\"var_type\">where</field><field name=\"var\">wsql</field><value name=\"val\"><block type=\"gd_where\" id=\"77;Ab%q(Mn}yo^;z!)~y\"><field name=\"var_type\">page</field><field name=\"var\">page,limit</field><value name=\"val\"><block type=\"gd_where\" id=\"(i4R)[g#[bv!EEO+pnT1\"><field name=\"var_type\">order</field><field name=\"var\">\'id desc\'</field><value name=\"val\"><block type=\"gd_select\" id=\"m}rcIpQr2]WEzR4.S@By\"></block></value></block></value></block></value></block></value></block></value></block></value><next><block type=\"gd_var\" id=\"*7XR??r+EQ-wcKWnV/8Q\"><field name=\"var_type\">let</field><field name=\"var\">count</field><value name=\"val\"><block type=\"gd_await\" id=\"[!DNNOK#~A^57Jm:wvtL\"><value name=\"val\"><block type=\"gd_model\" id=\"zM?Wqs0u^V/OBiYJF=AX\"><field name=\"var\">api_test</field><value name=\"val\"><block type=\"gd_where\" id=\"}cgV`t:=hddW=*CG^nUu\"><field name=\"var_type\">where</field><field name=\"var\">wsql</field><value name=\"val\"><block type=\"gd_query\" id=\"lC7TQ018PK!)-c=ttq2-\"><field name=\"var_type\">count</field><field name=\"var\"></field></block></value></block></value></block></value></block></value><next><block type=\"gd_success\" id=\"YraA5u$fx01x)z;L!9T?\"><field name=\"var\">{list,count}</field></block></next></block></next></block></next></block></next></block></next></block></statement><next><block type=\"gd_classmethod\" id=\"7eV)y;$zIp(qk{}}^Yl]\"><field name=\"methodName\">async addBeforeAction</field><field name=\"params\"></field><next><block type=\"gd_classmethod\" id=\"N^[qFF!#]C/jOCm(6(LH\"><field name=\"methodName\">async addAction</field><field name=\"params\"></field><comment pinned=\"false\" h=\"80\" w=\"160\">添加函数</comment><statement name=\"chains\"><block type=\"gd_var\" id=\"+(^62!FiD:k0C+%aXz(*\"><field name=\"var_type\">let</field><field name=\"var\">post</field><value name=\"val\"><block type=\"gd_post\" id=\"MY=nIcUl/[H^(lnza/h!\"><field name=\"var\"></field></block></value><next><block type=\"gd_var\" id=\"~X:6@+)Vq`k#?VZrYo8C\"><field name=\"var_type\">let</field><field name=\"var\">has</field><value name=\"val\"><block type=\"gd_await\" id=\"-@]pD-Dz*#8s[!V-)Y),\"><value name=\"val\"><block type=\"gd_model\" id=\"uFi@/t8Z`uSQ%3;.6CB`\"><field name=\"var\">api_test</field><value name=\"val\"><block type=\"gd_where\" id=\"%P3K%x|k9rd/yh1kwx/o\"><field name=\"var_type\">where</field><field name=\"var\">{id : post.id}</field><value name=\"val\"><block type=\"gd_find\" id=\"*@n;{u*_XsF9pvNL%LLJ\"></block></value></block></value></block></value></block></value><next><block type=\"controls_if\" id=\"23d-}D@s@Q-9fG;5D~B`\"><value name=\"IF0\"><block type=\"gd_isempty\" id=\"-`Lw9:lR{R;nn50DHzVd\"><field name=\"var_type\">isEmpty</field><field name=\"var\">has</field></block></value><statement name=\"DO0\"><block type=\"gd_fail\" id=\"P1kOk9Fos!0@Eq(T,)@t\"><field name=\"var\">数据为空</field></block></statement><next><block type=\"gd_awaits\" id=\"9w(7*N#ZRjvJ6;FJWiv@\"><value name=\"val\"><block type=\"gd_model\" id=\"fY6|gTCUYksYDlS(^1_*\"><field name=\"var\">api_test</field><value name=\"val\"><block type=\"gd_add\" id=\"?`,T5d851@mDeG*dRw*f\"><field name=\"var_type\">add</field><field name=\"var\">post</field></block></value></block></value><next><block type=\"gd_success\" id=\"BR{k6kgNfS7+64lwAY|Y\"><field name=\"var\"></field></block></next></block></next></block></next></block></next></block></statement><next><block type=\"gd_classmethod\" id=\"q0u|i)a^vuBJbx0K:5J}\"><field name=\"methodName\">async editAction</field><field name=\"params\"></field><next><block type=\"gd_classmethod\" id=\"Lj]FAABGDtA#(Pa66yb]\"><field name=\"methodName\">async editBeforeAction</field><field name=\"params\"></field></block></next></block></next></block></next></block></next></block></statement></block></xml>',
    'controller',
    '接口测试程序'
  );

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: rt_company
# ------------------------------------------------------------

INSERT INTO
  `rt_company` (`id`, `title`, `rules`, `status`, `remark`, `pid`)
VALUES
  (2, 'aaa', '1,4,5,7,37,53', 0, 'aaa', 0);
INSERT INTO
  `rt_company` (`id`, `title`, `rules`, `status`, `remark`, `pid`)
VALUES
  (
    15,
    'test2',
    '1,4,5,7,37,53,2,9,20,21,22,23,57,10,26,27,56,58,59,60,61,11,24,25,62,63,64,65,12,66,67,68,13,28,29,30,31,32,14,33,34,35,36,3,15',
    1,
    '',
    0
  );

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: rt_crons
# ------------------------------------------------------------

INSERT INTO
  `rt_crons` (
    `id`,
    `name`,
    `interval`,
    `immediate`,
    `handle`,
    `enable`,
    `type`,
    `addtime`,
    `uptime`,
    `nexttime`,
    `runtime`,
    `runtype`,
    `cron`,
    `remark`,
    `intertype`
  )
VALUES
  (
    1,
    'test',
    '1',
    1,
    'server/demo/index',
    0,
    'all',
    1641609605,
    0,
    1641609606106,
    0,
    0,
    '0/10 * * * * ?',
    '',
    's'
  );

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: rt_database
# ------------------------------------------------------------

INSERT INTO
  `rt_database` (
    `id`,
    `database`,
    `host`,
    `port`,
    `user`,
    `password`,
    `dateStrings`,
    `encoding`,
    `isdef`,
    `prefix`,
    `ssh`,
    `shost`,
    `sport`,
    `suser`,
    `stype`,
    `spass`,
    `spath`
  )
VALUES
  (
    1,
    'gdcms',
    '127.0.0.1',
    8889,
    'root',
    'root',
    0,
    'utf8',
    1,
    'rt_',
    0,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL
  );
INSERT INTO
  `rt_database` (
    `id`,
    `database`,
    `host`,
    `port`,
    `user`,
    `password`,
    `dateStrings`,
    `encoding`,
    `isdef`,
    `prefix`,
    `ssh`,
    `shost`,
    `sport`,
    `suser`,
    `stype`,
    `spass`,
    `spath`
  )
VALUES
  (
    3,
    'godo',
    '127.0.0.1',
    8889,
    'root',
    'root',
    0,
    'utf8',
    0,
    'rt_',
    0,
    '',
    0,
    '',
    1,
    '',
    ''
  );
INSERT INTO
  `rt_database` (
    `id`,
    `database`,
    `host`,
    `port`,
    `user`,
    `password`,
    `dateStrings`,
    `encoding`,
    `isdef`,
    `prefix`,
    `ssh`,
    `shost`,
    `sport`,
    `suser`,
    `stype`,
    `spass`,
    `spath`
  )
VALUES
  (
    5,
    'worklog',
    '127.0.0.1',
    3306,
    'root',
    'workLog20210927!#',
    0,
    'utf8',
    0,
    'rt_',
    1,
    '113.140.72.10',
    31,
    'root',
    1,
    'fanns@202120',
    ''
  );
INSERT INTO
  `rt_database` (
    `id`,
    `database`,
    `host`,
    `port`,
    `user`,
    `password`,
    `dateStrings`,
    `encoding`,
    `isdef`,
    `prefix`,
    `ssh`,
    `shost`,
    `sport`,
    `suser`,
    `stype`,
    `spass`,
    `spath`
  )
VALUES
  (
    8,
    'test',
    '127.0.0.1',
    8889,
    'root',
    'root',
    0,
    'utf8',
    0,
    'rt_',
    0,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL
  );
INSERT INTO
  `rt_database` (
    `id`,
    `database`,
    `host`,
    `port`,
    `user`,
    `password`,
    `dateStrings`,
    `encoding`,
    `isdef`,
    `prefix`,
    `ssh`,
    `shost`,
    `sport`,
    `suser`,
    `stype`,
    `spass`,
    `spath`
  )
VALUES
  (
    9,
    'test2',
    '127.0.0.1',
    8889,
    'root',
    'root',
    0,
    'utf8',
    0,
    'rt_',
    0,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL
  );
INSERT INTO
  `rt_database` (
    `id`,
    `database`,
    `host`,
    `port`,
    `user`,
    `password`,
    `dateStrings`,
    `encoding`,
    `isdef`,
    `prefix`,
    `ssh`,
    `shost`,
    `sport`,
    `suser`,
    `stype`,
    `spass`,
    `spath`
  )
VALUES
  (
    10,
    'xd_crm',
    '127.0.0.1',
    3306,
    'root',
    'root',
    0,
    'utf8',
    0,
    'rt_',
    0,
    '127.0.0.1',
    22,
    'root',
    1,
    '',
    ''
  );
INSERT INTO
  `rt_database` (
    `id`,
    `database`,
    `host`,
    `port`,
    `user`,
    `password`,
    `dateStrings`,
    `encoding`,
    `isdef`,
    `prefix`,
    `ssh`,
    `shost`,
    `sport`,
    `suser`,
    `stype`,
    `spass`,
    `spath`
  )
VALUES
  (
    11,
    'xdcms',
    '127.0.0.1',
    3306,
    'root',
    'root',
    0,
    'utf8',
    0,
    'rt_',
    0,
    '127.0.0.1',
    22,
    'root',
    1,
    '',
    ''
  );

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: rt_datasafe
# ------------------------------------------------------------

INSERT INTO
  `rt_datasafe` (`id`, `data_id`, `name`)
VALUES
  (31, 1, 'admin');
INSERT INTO
  `rt_datasafe` (`id`, `data_id`, `name`)
VALUES
  (32, 1, 'admin_auth');
INSERT INTO
  `rt_datasafe` (`id`, `data_id`, `name`)
VALUES
  (41, 1, 'admin_loginlog');
INSERT INTO
  `rt_datasafe` (`id`, `data_id`, `name`)
VALUES
  (33, 1, 'admin_map');
INSERT INTO
  `rt_datasafe` (`id`, `data_id`, `name`)
VALUES
  (34, 1, 'admin_oplog');
INSERT INTO
  `rt_datasafe` (`id`, `data_id`, `name`)
VALUES
  (35, 1, 'admin_viewlog');
INSERT INTO
  `rt_datasafe` (`id`, `data_id`, `name`)
VALUES
  (42, 1, 'api');
INSERT INTO
  `rt_datasafe` (`id`, `data_id`, `name`)
VALUES
  (40, 1, 'crons');
INSERT INTO
  `rt_datasafe` (`id`, `data_id`, `name`)
VALUES
  (36, 1, 'error');
INSERT INTO
  `rt_datasafe` (`id`, `data_id`, `name`)
VALUES
  (39, 1, 'form');
INSERT INTO
  `rt_datasafe` (`id`, `data_id`, `name`)
VALUES
  (37, 1, 'menu');
INSERT INTO
  `rt_datasafe` (`id`, `data_id`, `name`)
VALUES
  (38, 1, 'set');

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: rt_department
# ------------------------------------------------------------

INSERT INTO
  `rt_department` (`id`, `title`, `rules`, `status`, `remark`, `pid`)
VALUES
  (2, 'aaa', '1,4,5,7,37,53', 0, 'aaa', 0);
INSERT INTO
  `rt_department` (`id`, `title`, `rules`, `status`, `remark`, `pid`)
VALUES
  (
    15,
    'test2',
    '1,4,5,7,37,53,2,9,20,21,22,23,57,10,26,27,56,58,59,60,61,11,24,25,62,63,64,65,12,66,67,68,13,28,29,30,31,32,14,33,34,35,36,3,15',
    1,
    '',
    0
  );

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: rt_doc
# ------------------------------------------------------------

INSERT INTO
  `rt_doc` (
    `id`,
    `title`,
    `name`,
    `key`,
    `version`,
    `logo`,
    `remark`,
    `user_id`,
    `add_time`,
    `update_time`
  )
VALUES
  (
    1,
    'godocms操作手册',
    '后台操作手册',
    'oplogs',
    '1.0.1',
    'img/logo.png',
    '用户后台操作手册',
    1,
    1638496474,
    1641723665
  );

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: rt_doc_cate
# ------------------------------------------------------------

INSERT INTO
  `rt_doc_cate` (
    `id`,
    `did`,
    `type`,
    `add_time`,
    `update_time`,
    `user_id`,
    `pid`,
    `name`,
    `title`,
    `content`,
    `order_num`
  )
VALUES
  (
    29,
    1,
    0,
    1638529126,
    1638529126,
    1,
    0,
    '',
    '开发前必读',
    '',
    10
  );
INSERT INTO
  `rt_doc_cate` (
    `id`,
    `did`,
    `type`,
    `add_time`,
    `update_time`,
    `user_id`,
    `pid`,
    `name`,
    `title`,
    `content`,
    `order_num`
  )
VALUES
  (30, 1, 0, 1638529126, 1638529126, 1, 0, '', '前台接口', '', 2);
INSERT INTO
  `rt_doc_cate` (
    `id`,
    `did`,
    `type`,
    `add_time`,
    `update_time`,
    `user_id`,
    `pid`,
    `name`,
    `title`,
    `content`,
    `order_num`
  )
VALUES
  (31, 1, 0, 1638529126, 1638529126, 1, 0, '', '后端配置', '', 0);
INSERT INTO
  `rt_doc_cate` (
    `id`,
    `did`,
    `type`,
    `add_time`,
    `update_time`,
    `user_id`,
    `pid`,
    `name`,
    `title`,
    `content`,
    `order_num`
  )
VALUES
  (
    32,
    1,
    1,
    1638529126,
    1641723665,
    1,
    29,
    'README',
    '安装说明',
    '## 关于godocms\n\ngodocms是刚东科技开发的一套开源办公套件，遵从Apache License 2.0开源协议，非常适合二次开发，内含word/excel/ppt/pdf/svg/思维导图/流程图/日程管理等多个办公系统解决方案。godocms也是一套低代码开发工具，内含模块管理/接口管理/代码拖拽/数据库管理/表单管理等一套完善的低代码开发工具流。内含两套风格界面，win10和传统软件界面，可随时切换。内置了很多对开发者有用的实用工具，也可以当作一个工具箱使用。\n\n## 为什么做？\n\n现在主流的办公套件要么不开源，要么需要授权，而且安装异常复杂。随着技术的日新月异，很多开源组件基本能够解决办公套件商用化的痛点甚至更好，但都是零碎的/单一的解决方案，为此我们沉心静气花耗半年时间打磨了这套产品。godocms基本实现了办公三套件（word/ppt/excel）的编辑流，无需服务器安装底层的模块。\n低代码现在处在一个发展阶段，国内也涌现了一大批优秀的低代码套件，更接地气更平民化。但是要解决大型复杂的业务流时总是感觉有那么有点力不从心，为什么呢？我们做了认真的思考和研究，发现很多低代码套件都忽视了软件开发的基本流程和本质，一套软件的开发流程包含很多，需求分析/架构设计/开发/测试/交付等，这是一个大工程，因为每个子流程里面又包含很多小流程。反过来想，如果把每个流程都加进去那就还是低代码吗？其实google走在最前面，他们开发了blockly。但是blockly在国内并没有得到大面积的推广？why？学习成本和开发成本！blockly不能拿过来直接上项目，很多公司的开发都有自己的底层平台，如果要用那就要做二开。godocms基层很多模块都是用blockly开发的，并且完美的集成了进来。我们完全遵从控制层/模型层/逻辑层/服务层的基础软件开发框架，只要明白mvc的思想，就很容易上手。\n为什么要用nodejs开发？godocms开发原则是“**易上手，容易改**”。前端工程师和后端工程师都可以上手，没有复杂的包，学习成本低，但是可以解决复杂的的项目问题，实现是第一原则。\n\n## 功能介绍\n\n#### 一 文档管理\n\n文档管理可以理解成使用说明书/开发文档/文集的生成工具。集成了`Docsify`，可以自动生成，可以回写，可以书写多个说明文档，可以做为一个说明文档的管理工具使用。\n[看演示](http://demo.godocms.com/web/demo/wendang.gif)\n\n#### 二 数据库设计器\n\n数据库设计器其实就是一个小型的navicat，是一个mysql数据库管理工具。支持数据备份还原；支持自动生成数据库设计文档，md 格式以及实时预览，可以下载成 pdf/word文件；支持数据表名/注释/autoid 的更改，支持优化表/修复表/删除表/清空表；可查看/编辑/新增/复制任意表数据；可更改字段名/注释/默认值/排序，可拖拽排序字段，可删除字段；支持连接/管理外部数据库，可通过ssh连接外部数据库；支持数据库表保护。\n\n#### 三 思维导图\n\n一套完善的思维导图管理工具。支持增/删/改/查，进入后自动添加/自动保存文件；支持逻辑结构图、思维导图、组织结构图、目录组织图四种结构； 内置多种主题，允许高度自定义样式；支持快捷键；节点内容支持图片、图标、超链接、备注、标签；支持前进后退；支持拖动、缩放；支持右键多选；支持节点拖拽；支持 json 格式的导入导出，png/svg 导出。\n\n#### 四 excel表格管理\n\nexcel表格管理工具。支持增/删/改/查，导入/导出excel；格式设置：样式，条件格式，文本对齐及旋转，文本截断、溢出、自动换行，多种数据类型，单元格内多样式；单元格：拖拽，下拉填充，多选区，查找和替换，定位，合并单元格，数据验证；行和列操作：隐藏、插入、删除行或列，冻结，文本分列；操作体验：撤销、重做，复制、粘贴、剪切，快捷键，格式刷，选区拖拽；公式和函数：内置公式，远程公式，自定义公式；表格操作：筛选，排序。\n\n### 五 ppt演示文稿\n\n在线演示文稿（幻灯片ppt）应用。支持增/删/改/查，还原了大部分 Office PowerPoint 常用功能，支持文字、图片、形状、线条、图表、表格、视频、公式几种最常用的元素类型，每一种元素都拥有高度可编辑能力，同时支持丰富的快捷键和右键菜单，尽可能还原本地桌面应用的使用体验。内置了一些常用模版，支持导出 ppt 文件。\n\n#### 六 文档编辑器\n\n不仅仅是word编辑器，也可以作为一个简单的pdf编辑器，还可以编辑md/rtf/text/html等文本文件，基于tesseract可以打开几乎任何的文档文件，支持**ocr文字识别**，可以打开png/jpg等图片文件，打开后直接显示为文字，无需第三方api，简洁实用。\n\n#### 七 流程图编辑器\n\n项目经理的硬核工具，包含**图形/拓扑图/图表/权限流/工作流**五个流程图编辑工具，基于mxgraph，支持增/删/改/查，内置demo。更多功能请看演示。\n\n#### 八 文本编辑器\n\ntext文本编辑器，支持打开text/html/css/js/svg/xml/md等，支持预览/增/删/改/查，可以当作一个简单的在线editplus。\n\n#### 九 图片编辑器\n\n一个在线图片编辑器，基于tui.image-editor。支持增/删/改/查，支持裁剪、翻转、旋转、绘图、形状、图标、文本、遮罩过滤器、图像过滤器。\n\n#### 十 svg编辑器\n\nsvg在线编辑器，基于svgedit。支持增/删/改/查，支持导入/导出svg，功能强大，具体可查看demo。\n\n#### 十一 甘特图\n\n甘特图编辑器。支持增/删/改/查，支持自定义项目人员和角色，支持拖拽/管理分配（资源、角色、工作）等。\n\n#### 十二 日程计划\n\n在线日程计划表。支持增/删/改。基于tui.calendar，支持各种视图类型：每日、每周、每月（6周、2周、3周）；支持里程碑和任务计划的高效管理；支持周末宽度；支持更改一周的开始日期；支持自定义日期和日程信息界面（包括网格单元的页眉和页脚）；支持通过鼠标拖动调整明细表。\n\n#### 十三 开发工具箱\n\n开发工具箱，包含了很多有用的工具，如 QR 码生成器，QR 码解码、翻译，时间戳转换，源格式，JSON 管理工具，正则管理工具，图像 base64 字符编码等。\n\n#### 十四 接口开发工具\n\n内置HTTP接口，WEBSOCKET接口，SOCKET.IO接口调试工具。开发工具利器。\n\n#### 十五 字体编辑器\n\n在线字体编辑器，支持ttf, woff, woff2, otf, svg font, eot字体的编辑。\n\n#### 十六 办公白板工具\n\n一个小型的办公白板工具。支持画笔/橡皮擦/便签等。\n\n#### 十七 录屏工具\n\n一个实用的在线录屏工具。支持谷歌/火狐浏览器，直接生成gif。\n\n#### 十八 其他小工具\n\n便签/番茄时钟/计算器/万年历等。\n\n#### 十九 程序设计器\n\n基于google的blockly，支持增删改查，支持类/函数/对象/数组，**支持thinkjs的大部分内置对象拖拽**，支持自动生成项目文件，内置demo。\n\n#### 二十 模块设计器\n\n支持四层架构设计，支持**一键生成curd**，支持全局常量生成，是接口设计器的底层支撑。\n\n#### 二十一 接口设计器\n\n**一个模块就是一个文件或类，一个接口就是一个函数**。可以理解为**函数设计器**。分为基本配置/入口参数/逻辑设计/测试管理四个部分。基本配置就是配置函数的名称及其方法，入口参数即该函数的logic层定义，可直接从数据库导入并自动识别类型。逻辑设计即函数的主体部分，采用blockly直接通过拖拽代码实现。测试管理包含入参/headers/预想/结果/备注五个部分，是一套完善的测试工具流，预想可直接从数据库导入数据结构以及数据深度测试，预想并未完成数据校验（第二期完成）\n\n#### 二十二 表单设计器\n\n支持组件拖拽，支持表单回写，支持生成 html 以及代码预览，支持数据来源，支持自定义接收参数和发送附加参数。\n\n#### 二十三 其他\n\n系统配置：基于表单生成器做的demo。\n计划任务：系统的计划任务实现。\n菜单管理：系统权限管理的核心部分。\n角色管理：系统内置的角色权限管理。\n部门管理：和角色管理类似。\n公司管理：和角色管理类似。\n岗位管理：和角色管理类似。\n\n## 第二期开发计划\n\n1. 完成接口设计的测试工具。\n2. 完成表单设计器和接口设计器的对接。\n3. 基于接口设计器实现表格设计器。\n4. 完成ppt的导入。\n5. 完成聊天模块。\n6. 完成任务看板模块。\n7. 完成简单的原型设计模块。\n8. 完成文件夹管理。\n9. 修复系统bug。\n\n\n\n## 开发环境\n\n> nodejs v16.13  mysql 5.6\n\n项目解压到server根目录\n\n```bash\ncd server\nnpm i\n```\n\n## 初始化项目\n\n用工具导入`data/db/init.sql`，然后更改`src/common/config/config.js`\n\n```bash\nmysql: {\n    handle: mysql,\n    database: \'pro\',//改成自己的数据库\n    prefix: \'rt_\',\n    encoding: \'utf8\',\n    host: \'127.0.0.1\',\n    port: \'3306\',\n    user: \'root\',//改自己的用户名\n    password: \'root\',//改密码\n    dateStrings: true\n  }\n```\n\n## 本地预览\n\n通过运行 `npm start` 启动一个本地服务器。默认访问地址 http://localhost:8200 。\n\n```bash\nnpm start\n```\n\n## 正式环境\n\n```bash\npm2 start pm2.json\n```\n\n## 特别鸣谢\n\n[https://thinkjs.org](https://thinkjs.org/)\n[https://github.com/google/blockly](https://github.com/google/blockly)\n[https://gitee.com/sentsin/layui](https://gitee.com/sentsin/layui)\n[https://gitee.com/pear-admin/Pear-Admin-Layui](https://gitee.com/pear-admin/Pear-Admin-Layui)\n[https://docsify.js.org/#/zh-cn/](https://docsify.js.org/#/zh-cn/)\n[https://gitee.com/ayq947/ayq-layui-form-designer](https://gitee.com/ayq947/ayq-layui-form-designer)\n[https://github.com/wanglin2/mind-map](https://github.com/wanglin2/mind-map)\n[https://github.com/mengshukeji/Luckysheet](https://github.com/mengshukeji/Luckysheet)\n[https://github.com/pipipi-pikachu/PPTist](https://github.com/pipipi-pikachu/PPTist)\n[https://github.com/jgraph/mxgraph](https://github.com/jgraph/mxgraph)\n[https://github.com/Vanessa219/vditor](https://github.com/Vanessa219/vditor)\n[https://github.com/nhn/tui.image-editor](https://github.com/nhn/tui.image-editor)\n[https://github.com/nhn/tui.calendar](https://github.com/nhn/tui.calendar)\n[https://github.com/joaomoreno/gifcap](https://github.com/joaomoreno/gifcap)\n[https://github.com/naptha/tesseract.js](https://github.com/naptha/tesseract.js)\n[https://github.com/qunee/graph.editor_vue](https://github.com/qunee/graph.editor_vue)\n[https://github.com/SVG-Edit/svgedit](https://github.com/SVG-Edit/svgedit)\n[https://github.com/robicch/jQueryGantt](https://github.com/robicch/jQueryGantt)\n[https://gitee.com/karson/tinytools](https://gitee.com/karson/tinytools)\n[https://github.com/ecomfe/fonteditor](https://github.com/ecomfe/fonteditor)\n[https://github.com/tldraw/tldraw](https://github.com/tldraw/tldraw)\n\n如有侵权或需要二次开发请联系微信**ruitao580** 邮箱 xpbb@qq.com\n\n',
    8
  );
INSERT INTO
  `rt_doc_cate` (
    `id`,
    `did`,
    `type`,
    `add_time`,
    `update_time`,
    `user_id`,
    `pid`,
    `name`,
    `title`,
    `content`,
    `order_num`
  )
VALUES
  (
    33,
    1,
    1,
    1638529126,
    1641708373,
    1,
    29,
    'CHANGELOG',
    '变更日志',
    '## 接口管理 2021/12/04\n\n- &check;  接口分基本配置/入口参数/逻辑设计/返回测试/表单设计/表格设计六个模块，每个模块单独书写，易于维护\n- &check; 基本配置可设计接口名称/接口类别等，直接写入控制层，要加入权限处理\n- &check; 入口参数主要选择入参，和表单设计挂钩2021/12/05\n- &check; 入口参数支持直接从数据库导入，并自动识别数据格式，识别的有字段类型/是否为空/以及默认值2021/12/06\n- &check; 入口参数新增分页参数添加 2021/12/10\n- &check; 逻辑设计采用采用blockly方式完美实现，支持代码拖拽，并加入了很多实用的代码块 2021/12/08\n- &check; 代码设计器自动生成代码并保存数据库和本地，代码设计器支持的类型有：2021/12/10\n  \n  1. - 支持类/数组/对象的拖拽\n  2. - 支持thinkjs里面内置的对象/数据库处理/文件处理等\n  3. - 支持数组里面一系列代码块比如map/foreach/filter/some等\n  4. - 支持command+s保存\n  5. - 支持鼠标悬停后展示代码块\n- &cross; 数据层设计器：当内置数据不够用时需要写用到，主要做数据库的复杂处理，第二期实现，支持和代码设计器挂钩\n- &cross; 服务层设计器：当内置服务不够用时用到，比如复杂的文件逻辑，http请求逻辑等，第二期实现\n- &cross; 返回测试主要和表格设计挂钩，展示为主，输入测试数据查看返回值，设置是否删除测试数据，也可以单独作为前端测试工具，第二期实现\n  &cross; 表单和表格和接口管理界面分开，可根据接口设计，如果接口没涉及到权限，这里也要做处理，第二期实现\n- &cross; 可自动生成接口文档，第二期实现\n- &cross; 可自动生成测试用例，分模块跑测试用例，放第二期\n\n## 计划任务\n\n- &check; 可调用内置接口\n- &check; 直接写入配置文件\n- &check; 可记录执行时间\n\n## 文档管理 2021/12/03\n\n- &check; 支持多个文集管理，直接在线书写md文件，自动生成漂亮的网页\n- &check; 支持文章目录summary.md回写，直接把以前写好的md文档复制过来回写即可\n- &check; 支持多个文集分开管理\n- &check; 支持排序，直接改标题/logo，直接生成文档\n- &check; 文件入库和本地存2份，方便备份\n- &check; 用户编辑时尽量减少选择，顶部隐藏以及一些细节处理，添加后会关闭页面，避免多次提交同样数据\n- &check; 文档编辑时新增ctrl+s快捷键保存数据\n- &cross; 支持word和pdf导入，第二期\n\n## 流程图 2021/12/02\n\n- &check; 基础的增/删/改/查\n- &check; 图形编辑器 可导入导出xml，支持导出jpg/png/gif/pdf/svg/xml\n- &check; 图表编辑器 支持导出png\n- &check; 权限编辑器 内置权限流demo  支持导出png\n- &check; 工作流编辑器 内置工作流demo  支持导出png\n\n## ppt演示文稿  2021/11/30\n\n- &check; 基础的增/删/改/查\n- &check; 在线演示文稿（幻灯片）应用，还原了大部分 Office PowerPoint 常用功能，支持 文字、图片、形状、线条、图表、表格、视频、公式 几种最常用的元素类型，每一种元素都拥有高度可编辑能力，同时支持丰富的快捷键和右键菜单，尽可能还原本地桌面应用的使用体验。\n- &check; 内置了一些常用模版，支持导出ppt文件\n- &cross; 支持ppt导入，第二期\n\n## excel表格管理  2021/11/29\n\n- &check; 基础的增/删/改/查\n- &check; 格式设置：样式，条件格式，文本对齐及旋转，文本截断、溢出、自动换行，多种数据类型，单元格内多样式\n- &check; 单元格：拖拽，下拉填充，多选区，查找和替换，定位，合并单元格，数据验证\n- &check; 行和列操作：隐藏、插入、删除行或列，冻结，文本分列\n- &check; 操作体验：撤销、重做，复制、粘贴、剪切，快捷键，格式刷，选区拖拽\n- &check; 公式和函数：内置公式，远程公式，自定义公式\n- &check; 表格操作：筛选，排序\n- &check; 增强功能：数据透视表，图表，评论，共享编辑，插入图片，矩阵计算，截图，复制到其他格式\n- &check; 导入：在线导入xlsx\n- &cross; 导出xlsx第二期处理\n\n## 思维导图管理  2021/11/28\n\n- &check; 增/删/改/查，进入后自动添加/自动保存文件\n- &check; 支持逻辑结构图、思维导图、组织结构图、目录组织图四种结构\n- &check; 内置多种主题，允许高度自定义样式\n- &check; 支持快捷键\n- &check; 节点内容支持图片、图标、超链接、备注、标签\n- &check; 支持前进后退\n- &check; 支持拖动、缩放\n- &check; 支持右键多选\n- &check; 支持节点拖拽\n- &check; 支持json格式的导入导出，png/svg导出\n- &cross; 直接节点直接转化为ppt，第二期\n\n## 管理小工具 2021/11/27\n\n- &check; 二维码/时间戳/翻译/格式化/url编码/base64编码\n- &check; 新增json工具和正则工具\n- &check; 放在页面右上角，方便使用\n\n## 数据库设计器\n\n- &check; 支持数据备份还原，查看数据表实时状态 2021/11/17\n- &check; 支持自动生成数据库设计文档，md格式以及实时预览，下载成pdf文件 2021/11/18\n- &check; 新增文档可下载word文件 2021/11/27\n- &check; 支持数据表名/注释/autoid的更改，支持优化表/修复表/删除表/清空表 2021/11/19\n- &check; 可查看/编辑/新增/复制任意表数据  2021/11/20\n- &check; 新增系统表数据保护  2021/11/20\n- &check; 可更改字段名/注释/默认值/排序，可删除字段 2021/11/20\n- &check; 新增连接/管理外部数据库 2021/11/25\n- &check; 新增数据库表保护 2021/11/25\n- &check; 新增可支持sqlite和mysql管理 2021/11/26\n- &check; 新增ssh远程连接管理，支持pem和密码连接 2021/11/26\n\n## &check; 登录验证 2021/11/12\n\n- &check; jwt校验\n- &check; 只允许一个帐号在一个端下登录\n- &check; 登录后规定时间保活\n\n## 角色管理  2021/11/14\n\n- &check; 允许多角色管理，角色取交集\n- &check; 角色可继承权限，每个角色应该有独立的权限职责划分\n\n## 菜单管理 2021/11/13\n\n- &check; 分前端模版和后端路由，权限由后端路由控制，增删改，图标可自定义\n\n## 管理员管理 2021/11/15\n\n- &check; 可添加/删除/搜索/编辑管理员，管理员和菜单权限挂钩\n\n## 系统日志 2021/11/15\n\n- &check; 记录每个人的操作记录  2021/11/15\n- &cross; &rArr; 定期清理，清理前做物理归档\n- &check; 记录每个人的查看记录，并记录离开时间  2021/11/14\n\n## 系统配置\n\n- &check; 可自定义配置，支持字段配置，自定义表单定义配置信息\n- &cross; &rArr; 可自动分表，规划分表规则\n- &cross; &rArr; 数据库自动定时备份，和计划任务一起做，配置和计划任务分开\n- &cross; &rArr; 配置写库，写到config\n\n## 系统功能\n\n- &check; 支持csrf，可控制开关  2021/11/14\n- &check; 支持apidoc生成开发文档  2021/11/14\n- &check; 支持ratelimit实现访问速率限制，保护程序免受暴力攻击，可控制开关以及速度  2021/11/14\n- &check; 支持helmet，避免XSS跨站脚本攻击，可控制开关  2021/11/14\n\n## 表单生成器\n\n- &check; 支持组件拖拽，支持表单回写 2021/11/15\n- &check; 支持生成html以及代码预览 2021/11/16\n- &check; 支持数据来源，支持自定义接收参数和发送附加参数 2021/11/16\n\n',
    9
  );
INSERT INTO
  `rt_doc_cate` (
    `id`,
    `did`,
    `type`,
    `add_time`,
    `update_time`,
    `user_id`,
    `pid`,
    `name`,
    `title`,
    `content`,
    `order_num`
  )
VALUES
  (
    34,
    1,
    1,
    1638529126,
    1638585664,
    1,
    29,
    'start',
    '需求文档',
    '# BASS低代码平台\n\n## 总后台管理\n\n### 需求\n\n#### 管理员\n\n##### &check; 登录验证 2021/11/12\n\n- &check; jwt校验\n- &check; 只允许一个帐号在一个端下登录\n- &check; 登录后规定时间保活\n\n##### 角色管理  2021/11/14\n\n- &check; 允许多角色管理，角色取交集\n- &check; 角色可继承权限，每个角色应该有独立的权限职责划分\n\n##### 菜单管理 2021/11/13\n\n- &check; 分前端模版和后端路由，权限由后端路由控制，增删改，图标可自定义\n\n##### 管理员管理 2021/11/15\n\n- &check; 可添加/删除/搜索/编辑管理员，管理员和菜单权限挂钩\n\n#### 系统日志 2021/11/15\n\n- &check; 记录每个人的操作记录  2021/11/15\n- &cross; &rArr; 定期清理，清理前做物理归档\n- &check; 记录每个人的查看记录，并记录离开时间  2021/11/14\n\n#### 系统配置\n\n- &check; 可自定义配置，支持字段配置，自定义表单定义配置信息\n- &cross; &rArr; 可自动分表，规划分表规则\n- &cross; &rArr; 数据库自动定时备份，和计划任务一起做，配置和计划任务分开\n- &cross; &rArr; 配置写库，写到config\n\n#### 系统功能\n\n- &check; 支持csrf，可控制开关  2021/11/14\n- &check; 支持apidoc生成开发文档  2021/11/14\n- &check; 支持ratelimit实现访问速率限制，保护程序免受暴力攻击，可控制开关以及速度  2021/11/14\n- &check; 支持helmet，避免XSS跨站脚本攻击，可控制开关  2021/11/14\n\n#### 表单生成器\n\n- &check; 支持组件拖拽，支持表单回写 2021/11/15\n- &check; 支持生成html以及代码预览 2021/11/16\n- &check; 支持数据来源，支持自定义接收参数和发送附加参数 2021/11/16\n\n#### 数据库设计器\n\n- &check; 支持数据备份还原，查看数据表实时状态 2021/11/17\n- &check; 支持自动生成数据库设计文档，md格式以及实时预览，下载成pdf文件 2021/11/18\n- &check; 支持数据表名/注释/autoid的更改，支持优化表/修复表/删除表/清空表 2021/11/19\n- &check; 可查看/编辑/新增/复制任意表数据  2021/11/20\n- &check; 新增系统表数据保护  2021/11/20\n- &check; 可更改字段名/注释/默认值/排序，可删除字段 2021/11/20\n- &check; 新增连接/管理外部数据库 2021/11/25\n- &check; 新增数据库表保护 2021/11/25\n\n#### 模块管理\n\n- &cross; &rArr; 负责模块初始化，以及用到哪些表\n- &cross; &rArr; 可导入导出json\n\n#### 列表设计器\n\n- &cross; &rArr; 依托接口管理\n\n#### 表单设计器\n\n- &cross; &rArr; 依托接口管理\n\n#### 接口设计器\n\n- &cross; &rArr; 依托模块管理\n- &cross; &rArr; 权限管理\n- &cross; &rArr; 可调用模型设计器\n- &cross; &rArr; 管理输入和输出，方法，参数\n- &cross; &rArr; 初始参数管理\n- &cross; &rArr; 过程参数管理\n- &cross; &rArr; 逻辑管理\n- &cross; &rArr; 可自动生成文档（第二阶段）\n- &cross; &rArr; 可生成测试用例（第二阶段）\n\n#### 模型设计器\n\n- &cross; &rArr; 管理数据库操作，依托模块管理，负责接口调用\n\n#### 服务设计器\n\n- &cross; &rArr; 管理外部接口，负责接口调用\n\n#### 插件管理\n\n- &cross; &rArr; 可作为独立的npm插件包使用\n- &cross; &rArr; 检索目录，检测配置，拷贝文件\n\n##### 地区管理\n\n- &cross; &rArr; 支持无限分类，做为数据分权的依据\n\n##### 岗位管理\n\n- &cross; &rArr; 部门/集团/公司/门店/仓库都可以设立岗位，岗位具有职责性\n\n##### 部门管理\n\n- &cross; &rArr; 部门可归属总后台/集团/公司/仓库/门店，也可设置分部门\n\n##### 集团管理\n\n- &cross; &rArr; 集团是全系统的总线，每个集团可拥有整个系统的功能，除集团管理外\n\n##### 公司管理\n\n- &cross; &rArr; 公司隶属于集团，可设置分公司\n\n##### 门店管理\n\n- &cross; &rArr; 门店隶属于公司或集团，可管理仓库\n\n##### 仓库管理\n\n- &cross; &rArr; 仓库隶属于门店/公司/集团，管理商品存贮\n\n#### 计划任务\n\n- &cross; &rArr; 前期由总管理员管理，后期可下放到集团管理员\n\n### 表设计\n\n- 参考[表设计](sql.md)\n\n### 程序设计\n\n## 项目管理\n\n### 需求\n\n- 项目管理\n- 可维护项目\n- 可共享\n- 可出售\n- 可归档\n- 可导入导出\n- 可本地化部署\n\n### 表结构设计\n\n#### rt_projects(主表)\n\n#### rt_projects_sales(销售表)\n\n## 思维导图\n\n### 需求\n\n- 可管理数据库\n- 可设置接口\n- 可管理页面\n\n## 用户后台管理\n\n### 需求\n\n## 数据库管理\n\n### 需求\n\n- 可连接外部数据库\n- 可数据字段管理\n- 可新建表和库\n- 可视化\n\n## 接口管理\n\n### 需求\n\n- 可快速创建接口\n- 可根据程序创建接口\n- 可post/get测试\n- 可根据数据库创建接口\n- 微信\n- 钉钉\n\n## 页面管理\n\n### 需求\n\n- 大屏页面管理\n- h5页面管理\n- web页面管理\n- 后台页面管理\n- 可表单自定义\n- 数据表可自定义\n- 微信钉钉接口\n\n## 程序管理\n\n### 需求\n\n- 可视化程序编程\n- 可进行类和函数的拖拽\n- 可拖拽函数模块\n- 可根据目录接口创建代码\n- 支持代码模版\n\n## 设计原则\n\n### 开发原则\n\n- 易上手，易维护，容易改\n- 模块化，可独立使用，可做插件使用，每个模块都有自己独立的生命\n- 功能唯一性，所有功能尽量唯一\n- 入口唯一性，所有的入口要做到唯一，就是只能一个地方进来，避免业务逻辑的维护\n\n### 请求方法规则\n\n- 所有的数据增/删/改都用post\n- 所有的查询都用get\n\n### 小部件固化\n\n### 功能分离\n\n### 松耦合\n',
    0
  );
INSERT INTO
  `rt_doc_cate` (
    `id`,
    `did`,
    `type`,
    `add_time`,
    `update_time`,
    `user_id`,
    `pid`,
    `name`,
    `title`,
    `content`,
    `order_num`
  )
VALUES
  (
    35,
    1,
    1,
    1638529126,
    1638585803,
    1,
    29,
    'sql',
    '表设计',
    '### 表清单\n\n\n| 序号 | 数据表            | 名称             |\n| ------ | ------------------- | ------------------ |\n| 1    | rt_admin          | 管理员表         |\n| 2    | rt_admin_auth     | 管理权限表       |\n| 3    | rt_admin_loginlog | 管理登录日志表   |\n| 4    | rt_admin_map      | 管理员权限映射表 |\n| 5    | rt_admin_oplog    | 管理操作日志     |\n| 6    | rt_admin_viewlog  | 管理员查看日志   |\n| 7    | rt_api            | 接口管理表       |\n| 8    | rt_api_input      | 接口输入表       |\n| 9    | rt_api_logic      | 接口逻辑表       |\n| 10   | rt_api_out        | 接口输出表       |\n| 11   | rt_api_params     | 接口参数表       |\n| 12   | rt_area           | 区域表           |\n| 13   | rt_article        | 文章             |\n| 14   | rt_cate           | 系统分类表       |\n| 15   | rt_category       | 文章分类         |\n| 16   | rt_crons          | 系统计划任务表   |\n| 17   | rt_database       | 数据库连接表     |\n| 18   | rt_datasafe       | 数据库保护表     |\n| 19   | rt_error          | 系统错误日志表   |\n| 20   | rt_form           | 系统表单         |\n| 21   | rt_menu           | 系统菜单         |\n| 22   | rt_mod            | 系统模块表       |\n| 23   | rt_params         | 全局常量表       |\n| 24   | rt_set            | 系统配置表       |\n\n---\n\n#### rt_admin-管理员表\n\n\n| 排序 | 字段名      | 名称           | 类型         | 是否为空 | 索引 | 默认值 |\n| ------ | ------------- | ---------------- | -------------- | ---------- | ------ | -------- |\n| 2    | username    | 用户名         | varchar(50)  | NO       | UNI  | null   |\n| 3    | password    | 密码           | varchar(32)  | NO       |      | null   |\n| 1    | admin_id    | 唯一标志       | int(10)      | NO       | PRI  | 0      |\n| 4    | salt        | 密码钥匙       | varchar(32)  | NO       |      | null   |\n| 6    | add_time    | 添加时间       | int(10)      | NO       |      | 0      |\n| 7    | name        | 真实姓名       | varchar(100) | YES      |      | null   |\n| 8    | mobile      | 手机号         | int(10)      | YES      | UNI  | null   |\n| 9    | status      | 状态1正常0禁用 | tinyint(2)   | NO       |      | 1      |\n| 10   | login_time  | 登录时间       | int(10)      | YES      |      | 0      |\n| 11   | login_num   | 登录次数       | int(10)      | YES      |      | 0      |\n| 12   | update_time | 更新时间       | int(10)      | YES      |      | 0      |\n| 5    | role_id     | 角色id         | int(10)      | NO       |      | 0      |\n\n创建代码\n\n```js\nDROP TABLE IF EXISTS `rt_admin`;\n CREATE TABLE `rt_admin` (\n  `username` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT \'用户名\',\n  `password` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT \'密码\',\n  `admin_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT \'唯一标志\',\n  `salt` varchar(16) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT \'密码钥匙\',\n  `add_time` int(10) NOT NULL DEFAULT \'0\' COMMENT \'添加时间\',\n  `name` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT \'真实姓名\',\n  `mobile` varchar(15) COLLATE utf8mb4_unicode_ci DEFAULT \'0\' COMMENT \'手机号\',\n  `status` tinyint(2) NOT NULL DEFAULT \'1\' COMMENT \'状态1正常0禁用\',\n  `login_time` int(10) DEFAULT \'0\' COMMENT \'登录时间\',\n  `login_num` int(10) DEFAULT \'0\' COMMENT \'登录次数\',\n  `update_time` int(10) DEFAULT \'0\' COMMENT \'更新时间\',\n  PRIMARY KEY (`admin_id`),\n  UNIQUE KEY `username` (`username`) USING HASH,\n  UNIQUE KEY `mobile` (`mobile`) USING HASH\n) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT=\'管理员表\'\n```\n\n---\n\n#### rt_admin_auth-管理权限表\n\n\n| 排序 | 字段名 | 名称                 | 类型                | 是否为空 | 索引 | 默认值 |\n| ------ | -------- | ---------------------- | --------------------- | ---------- | ------ | -------- |\n| 1    | id     |                      | int(10) unsigned    | NO       | PRI  | null   |\n| 2    | name   |                      | varchar(255)        | YES      |      | null   |\n| 3    | rules  |                      | text                | YES      |      | null   |\n| 4    | status | 是否可用0可用1不可用 | tinyint(2) unsigned | YES      |      | 0      |\n| 5    | remark | 描述                 | varchar(255)        | YES      |      | null   |\n\n创建代码\n\n```js\nDROP TABLE IF EXISTS `rt_admin_auth`;\n CREATE TABLE `rt_admin_auth` (\n  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,\n  `name` varchar(255) CHARACTER SET utf8 DEFAULT NULL,\n  `rules` text CHARACTER SET utf8,\n  `status` tinyint(2) unsigned DEFAULT \'0\' COMMENT \'是否可用0可用1不可用\',\n  `remark` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT \'描述\',\n  PRIMARY KEY (`id`) USING BTREE\n) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT=\'管理权限表\'\n```\n\n---\n\n#### rt_admin_loginlog-管理登录日志表\n\n\n| 排序 | 字段名   | 名称       | 类型             | 是否为空 | 索引 | 默认值 |\n| ------ | ---------- | ------------ | ------------------ | ---------- | ------ | -------- |\n| 1    | id       | ID         | int(10) unsigned | NO       | PRI  | null   |\n| 2    | admin_id | 管理员账号 | int(10) unsigned | NO       |      | null   |\n| 3    | log      | 日志名称   | varchar(255)     | NO       |      | null   |\n| 4    | data     | 返回记录   | text             | YES      |      | null   |\n| 5    | ip       | IP地址     | varchar(64)      | YES      |      | null   |\n| 6    | agent    | 客户端信息 | varchar(255)     | YES      |      | null   |\n| 7    | url      | 地址       | varchar(255)     | YES      |      | null   |\n| 8    | method   | 方法       | varchar(100)     | YES      |      | null   |\n| 9    | addtime  | 添加时间   | int(10) unsigned | YES      |      | 0      |\n\n创建代码\n\n```js\nDROP TABLE IF EXISTS `rt_admin_loginlog`;\n CREATE TABLE `rt_admin_loginlog` (\n  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT \'ID\',\n  `admin_id` int(10) unsigned NOT NULL COMMENT \'管理员账号\',\n  `log` varchar(255) CHARACTER SET utf8 NOT NULL COMMENT \'日志名称\',\n  `data` text CHARACTER SET utf8 COMMENT \'返回记录\',\n  `ip` varchar(64) CHARACTER SET utf8 DEFAULT \'\' COMMENT \'IP地址\',\n  `agent` varchar(255) CHARACTER SET utf8 DEFAULT \'\' COMMENT \'客户端信息\',\n  `url` varchar(255) CHARACTER SET utf8 DEFAULT NULL COMMENT \'地址\',\n  `method` varchar(100) CHARACTER SET utf8 DEFAULT NULL COMMENT \'方法\',\n  `addtime` int(10) unsigned DEFAULT \'0\' COMMENT \'添加时间\',\n  PRIMARY KEY (`id`) USING BTREE\n) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT=\'管理登录日志表\'\n```\n\n---\n\n#### rt_admin_map-管理员权限映射表\n\n\n| 排序 | 字段名   | 名称                           | 类型                | 是否为空 | 索引 | 默认值 |\n| ------ | ---------- | -------------------------------- | --------------------- | ---------- | ------ | -------- |\n| 1    | map_id   |                                | int(10) unsigned    | NO       | PRI  | null   |\n| 2    | admin_id |                                | int(10) unsigned    | NO       | MUL  | null   |\n| 3    | auth_id  |                                | int(10) unsigned    | NO       |      | null   |\n| 4    | type     | 0角色1集团2公司3门店4部门5区域 | tinyint(3) unsigned | NO       |      | 0      |\n\n创建代码\n\n```js\nDROP TABLE IF EXISTS `rt_admin_map`;\n CREATE TABLE `rt_admin_map` (\n  `map_id` int(10) unsigned NOT NULL AUTO_INCREMENT,\n  `admin_id` int(10) unsigned NOT NULL,\n  `auth_id` int(10) unsigned NOT NULL,\n  `type` tinyint(3) unsigned NOT NULL DEFAULT \'0\' COMMENT \'0角色1集团2公司3门店4部门5区域\',\n  PRIMARY KEY (`map_id`),\n  UNIQUE KEY `admin_id` (`admin_id`,`auth_id`,`type`) USING HASH\n) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT=\'管理员权限映射表\'\n```\n\n---\n\n#### rt_admin_oplog-管理操作日志\n\n\n| 排序 | 字段名   | 名称       | 类型             | 是否为空 | 索引 | 默认值 |\n| ------ | ---------- | ------------ | ------------------ | ---------- | ------ | -------- |\n| 1    | id       | ID         | int(10) unsigned | NO       | PRI  | null   |\n| 2    | admin_id | 管理员账号 | int(10) unsigned | NO       |      | null   |\n| 3    | log      | 日志名称   | varchar(255)     | NO       |      | null   |\n| 4    | data     | 返回记录   | text             | YES      |      | null   |\n| 5    | ip       | IP地址     | varchar(64)      | YES      |      | null   |\n| 6    | agent    | 客户端信息 | varchar(255)     | YES      |      | null   |\n| 7    | url      | 地址       | varchar(255)     | YES      |      | null   |\n| 8    | method   | 方法       | varchar(100)     | YES      |      | null   |\n| 9    | addtime  | 添加时间   | int(10) unsigned | YES      |      | 0      |\n\n创建代码\n\n```js\nDROP TABLE IF EXISTS `rt_admin_oplog`;\n CREATE TABLE `rt_admin_oplog` (\n  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT \'ID\',\n  `admin_id` int(10) unsigned NOT NULL COMMENT \'管理员账号\',\n  `log` varchar(255) CHARACTER SET utf8 NOT NULL COMMENT \'日志名称\',\n  `data` text CHARACTER SET utf8 COMMENT \'返回记录\',\n  `ip` varchar(64) CHARACTER SET utf8 DEFAULT \'\' COMMENT \'IP地址\',\n  `agent` varchar(255) CHARACTER SET utf8 DEFAULT \'\' COMMENT \'客户端信息\',\n  `url` varchar(255) CHARACTER SET utf8 DEFAULT NULL COMMENT \'地址\',\n  `method` varchar(100) CHARACTER SET utf8 DEFAULT NULL COMMENT \'方法\',\n  `addtime` int(10) unsigned DEFAULT \'0\' COMMENT \'添加时间\',\n  PRIMARY KEY (`id`) USING BTREE\n) ENGINE=InnoDB AUTO_INCREMENT=290 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT=\'管理操作日志\'\n```\n\n---\n\n#### rt_admin_viewlog-管理员查看日志\n\n\n| 排序 | 字段名    | 名称       | 类型             | 是否为空 | 索引 | 默认值 |\n| ------ | ----------- | ------------ | ------------------ | ---------- | ------ | -------- |\n| 1    | id        | ID         | int(10) unsigned | NO       | PRI  | null   |\n| 2    | admin_id  | 管理员账号 | int(10) unsigned | NO       |      | null   |\n| 3    | log       | 日志名称   | varchar(255)     | NO       |      | null   |\n| 4    | ip        | IP地址     | varchar(64)      | YES      |      | null   |\n| 5    | agent     | 客户端信息 | varchar(255)     | YES      |      | null   |\n| 6    | url       | 地址       | varchar(255)     | YES      |      | null   |\n| 7    | method    | 方法       | varchar(100)     | YES      |      | null   |\n| 8    | addtime   | 添加时间   | int(10) unsigned | YES      |      | 0      |\n| 9    | leavetime | 离开时间   | int(10) unsigned | YES      |      | 0      |\n\n创建代码\n\n```js\nDROP TABLE IF EXISTS `rt_admin_viewlog`;\n CREATE TABLE `rt_admin_viewlog` (\n  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT \'ID\',\n  `admin_id` int(10) unsigned NOT NULL COMMENT \'管理员账号\',\n  `log` varchar(255) CHARACTER SET utf8 NOT NULL COMMENT \'日志名称\',\n  `ip` varchar(64) CHARACTER SET utf8 DEFAULT \'\' COMMENT \'IP地址\',\n  `agent` varchar(255) CHARACTER SET utf8 DEFAULT \'\' COMMENT \'客户端信息\',\n  `url` varchar(255) CHARACTER SET utf8 DEFAULT NULL COMMENT \'地址\',\n  `method` varchar(100) CHARACTER SET utf8 DEFAULT NULL COMMENT \'方法\',\n  `addtime` int(10) unsigned DEFAULT \'0\' COMMENT \'添加时间\',\n  `leavetime` int(10) unsigned DEFAULT \'0\' COMMENT \'离开时间\',\n  PRIMARY KEY (`id`) USING BTREE\n) ENGINE=InnoDB AUTO_INCREMENT=350 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT=\'管理员查看日志\'\n```\n\n---\n\n#### rt_api-接口管理表\n\n\n| 排序 | 字段名 | 名称         | 类型             | 是否为空 | 索引 | 默认值 |\n| ------ | -------- | -------------- | ------------------ | ---------- | ------ | -------- |\n| 1    | id     | 唯一标志     | int(10) unsigned | NO       | PRI  | null   |\n| 2    | name   | 接口名称     | varchar(100)     | NO       |      | null   |\n| 3    | mod_id | 模块id       | int(10) unsigned | NO       |      | 0      |\n| 4    | mod    | 所属模块     | varchar(60)      | NO       |      | null   |\n| 5    | key    | 接口唯一标志 | varchar(100)     | NO       |      | null   |\n| 6    | method | 接口方法     | varchar(20)      | NO       |      | null   |\n\n创建代码\n\n```js\nDROP TABLE IF EXISTS `rt_api`;\n CREATE TABLE `rt_api` (\n  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT \'唯一标志\',\n  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT \'接口名称\',\n  `mod_id` int(10) unsigned NOT NULL DEFAULT \'0\' COMMENT \'模块id\',\n  `mod` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT \'所属模块\',\n  `key` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT \'接口唯一标志\',\n  `method` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT \'接口方法\',\n  PRIMARY KEY (`id`)\n) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT=\'接口管理表\'\n```\n\n---\n\n#### rt_api_input-接口输入表\n\n\n| 排序 | 字段名 | 名称     | 类型             | 是否为空 | 索引 | 默认值 |\n| ------ | -------- | ---------- | ------------------ | ---------- | ------ | -------- |\n| 1    | id     | 唯一标志 | int(10) unsigned | NO       | PRI  | null   |\n\n创建代码\n\n```js\nDROP TABLE IF EXISTS `rt_api_input`;\n CREATE TABLE `rt_api_input` (\n  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT \'唯一标志\',\n  PRIMARY KEY (`id`)\n) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT=\'接口输入表\'\n```\n\n---\n\n#### rt_api_logic-接口逻辑表\n\n\n| 排序 | 字段名 | 名称     | 类型             | 是否为空 | 索引 | 默认值 |\n| ------ | -------- | ---------- | ------------------ | ---------- | ------ | -------- |\n| 1    | id     | 唯一标志 | int(10) unsigned | NO       | PRI  | null   |\n\n创建代码\n\n```js\nDROP TABLE IF EXISTS `rt_api_logic`;\n CREATE TABLE `rt_api_logic` (\n  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT \'唯一标志\',\n  PRIMARY KEY (`id`)\n) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT=\'接口逻辑表\'\n```\n\n---\n\n#### rt_api_out-接口输出表\n\n\n| 排序 | 字段名 | 名称     | 类型             | 是否为空 | 索引 | 默认值 |\n| ------ | -------- | ---------- | ------------------ | ---------- | ------ | -------- |\n| 1    | id     | 唯一标志 | int(10) unsigned | NO       | PRI  | null   |\n\n创建代码\n\n```js\nDROP TABLE IF EXISTS `rt_api_out`;\n CREATE TABLE `rt_api_out` (\n  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT \'唯一标志\',\n  PRIMARY KEY (`id`)\n) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT=\'接口输出表\'\n```\n\n---\n\n#### rt_api_params-接口参数表\n\n\n| 排序 | 字段名 | 名称     | 类型             | 是否为空 | 索引 | 默认值 |\n| ------ | -------- | ---------- | ------------------ | ---------- | ------ | -------- |\n| 1    | id     | 唯一标志 | int(10) unsigned | NO       | PRI  | null   |\n\n创建代码\n\n```js\nDROP TABLE IF EXISTS `rt_api_params`;\n CREATE TABLE `rt_api_params` (\n  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT \'唯一标志\',\n  PRIMARY KEY (`id`)\n) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT=\'接口参数表\'\n```\n\n---\n\n#### rt_area-区域表\n\n\n| 排序 | 字段名   | 名称       | 类型             | 是否为空 | 索引 | 默认值 |\n| ------ | ---------- | ------------ | ------------------ | ---------- | ------ | -------- |\n| 1    | area_id  |            | int(10) unsigned | NO       | PRI  | null   |\n| 2    | name     | 区域名称   | varchar(255)     | YES      |      | null   |\n| 3    | group_id | 集团id     | int(10) unsigned | YES      |      | 0      |\n| 4    | address  | 地址       | varchar(255)     | YES      |      | null   |\n| 5    | city_id  | 上级城市id | int(10)          | YES      |      | null   |\n\n创建代码\n\n```js\nDROP TABLE IF EXISTS `rt_area`;\n CREATE TABLE `rt_area` (\n  `area_id` int(10) unsigned NOT NULL AUTO_INCREMENT,\n  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT \'区域名称\',\n  `group_id` int(10) unsigned DEFAULT \'0\' COMMENT \'集团id\',\n  `address` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT \'地址\',\n  `city_id` int(10) DEFAULT NULL COMMENT \'上级城市id\',\n  PRIMARY KEY (`area_id`) USING BTREE\n) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT=\'区域表\'\n```\n\n---\n\n#### rt_article-文章\n\n\n| 排序 | 字段名       | 名称               | 类型             | 是否为空 | 索引 | 默认值            |\n| ------ | -------------- | -------------------- | ------------------ | ---------- | ------ | ------------------- |\n| 1    | id           | ID                 | int(11) unsigned | NO       | PRI  | null              |\n| 2    | category_id  | 分类:id:title      | int(11)          | NO       |      | null              |\n| 3    | title        | 文章名             | varchar(128)     | NO       |      | null              |\n| 4    | desc_content |                    | varchar(255)     | NO       |      | null              |\n| 5    | image        |                    | varchar(255)     | YES      |      | null              |\n| 6    | content      | 内容               | text             | NO       |      | null              |\n| 7    | author       | 作者:id:name       | varchar(32)      | NO       |      | null              |\n| 8    | show_switch  | 展示:1=展示,0=隐藏 | tinyint(1)       | NO       |      | 1                 |\n| 9    | show_time    |                    | datetime         | YES      |      | null              |\n| 10   | up_time      |                    | datetime         | YES      |      | CURRENT_TIMESTAMP |\n| 11   | add_time     |                    | datetime         | YES      |      | CURRENT_TIMESTAMP |\n\n创建代码\n\n```js\nDROP TABLE IF EXISTS `rt_article`;\n CREATE TABLE `rt_article` (\n  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT \'文章id\',\n  `category_id` int(10) DEFAULT \'0\' COMMENT \'分类id\',\n  `title` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT \'标题\',\n  `desc_content` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,\n  `image` varchar(255) CHARACTER SET utf8 DEFAULT NULL,\n  `content` text CHARACTER SET utf8 NOT NULL COMMENT \'内容\',\n  `author` varchar(32) CHARACTER SET utf8 NOT NULL COMMENT \'作者:id:name\',\n  `show_switch` tinyint(1) NOT NULL DEFAULT \'1\' COMMENT \'展示:1=展示,0=隐藏\',\n  `show_time` int(10) unsigned DEFAULT \'0\',\n  `up_time` int(10) unsigned DEFAULT \'0\',\n  `add_time` int(10) unsigned DEFAULT \'0\',\n  PRIMARY KEY (`id`) USING BTREE\n) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT=\'文章\'\n```\n\n---\n\n#### rt_cate-系统分类表\n\n\n| 排序 | 字段名 | 名称         | 类型             | 是否为空 | 索引 | 默认值 |\n| ------ | -------- | -------------- | ------------------ | ---------- | ------ | -------- |\n| 1    | id     |              | int(10) unsigned | NO       | PRI  | null   |\n| 2    | pid    | 上级id       | int(10)          | YES      |      | 0      |\n| 3    | sid    | 系统类型id   | int(10)          | YES      |      | 0      |\n| 4    | fid    | 系统分类标志 | int(10)          | YES      |      | null   |\n| 5    | lid    | 层级         | int(10)          | YES      |      | 0      |\n| 6    | name   | 名称         | varchar(255)     | YES      |      | null   |\n| 7    | desc   | 描述         | text             | YES      |      | null   |\n\n创建代码\n\n```js\nDROP TABLE IF EXISTS `rt_cate`;\n CREATE TABLE `rt_cate` (\n  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,\n  `pid` int(10) DEFAULT \'0\' COMMENT \'上级id\',\n  `sid` int(10) DEFAULT \'0\' COMMENT \'系统类型id\',\n  `fid` int(10) DEFAULT NULL COMMENT \'系统分类标志\',\n  `lid` int(10) DEFAULT \'0\' COMMENT \'层级\',\n  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT \'名称\',\n  `desc` text COLLATE utf8mb4_unicode_ci COMMENT \'描述\',\n  PRIMARY KEY (`id`) USING BTREE\n) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT=\'系统分类表\'\n```\n\n---\n\n#### rt_category-文章分类\n\n\n| 排序 | 字段名 | 名称                                 | 类型             | 是否为空 | 索引 | 默认值 |\n| ------ | -------- | -------------------------------------- | ------------------ | ---------- | ------ | -------- |\n| 1    | id     | ID                                   | int(11) unsigned | NO       | PRI  | null   |\n| 2    | name   | 分类名称                             | varchar(255)     | NO       |      | null   |\n| 3    | status | 是否使用，预留                       | tinyint(2)       | YES      |      | 0      |\n| 4    | ctype  | 分类类型 1新闻2账户类型3账户日志来源 | tinyint(3)       | YES      |      | 1      |\n| 5    | desc   | 其他附加配置                         | text             | YES      |      | null   |\n| 6    | flag   | 分类标志，同一分类不能重复           | int(10)          | NO       |      | 0      |\n\n创建代码\n\n```js\nDROP TABLE IF EXISTS `rt_category`;\n CREATE TABLE `rt_category` (\n  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT \'ID\',\n  `name` varchar(255) CHARACTER SET utf8 NOT NULL COMMENT \'分类名称\',\n  `status` tinyint(2) DEFAULT \'0\' COMMENT \'是否使用，预留\',\n  `ctype` tinyint(3) DEFAULT \'1\' COMMENT \'分类类型 1新闻2账户类型3账户日志来源\',\n  `desc` text CHARACTER SET utf8 COMMENT \'其他附加配置\',\n  `flag` int(10) NOT NULL DEFAULT \'0\' COMMENT \'分类标志，同一分类不能重复\',\n  PRIMARY KEY (`id`) USING BTREE\n) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT=\'文章分类\'\n```\n\n---\n\n#### rt_crons-系统计划任务表\n\n\n| 排序 | 字段名    | 名称                                  | 类型             | 是否为空 | 索引 | 默认值 |\n| ------ | ----------- | --------------------------------------- | ------------------ | ---------- | ------ | -------- |\n| 1    | id        |                                       | int(10) unsigned | NO       | PRI  | null   |\n| 2    | name      | 任务名称                              | varchar(64)      | NO       |      | null   |\n| 3    | interval  | 执行间隔 毫秒为单位                   | varchar(128)     | YES      |      | null   |\n| 4    | immediate | 是否立即执行                          | tinyint(1)       | YES      |      | 1      |\n| 5    | handle    | 执行路径                              | varchar(128)     | YES      | UNI  | null   |\n| 6    | enable    | 是否开启                              | tinyint(1)       | YES      |      | 1      |\n| 7    | type      | one执行一次all一直执行                | varchar(128)     | YES      |      | null   |\n| 8    | addtime   | 添加时间                              | int(10)          | YES      |      | 0      |\n| 9    | uptime    | 更新时间                              | bigint(20)       | YES      |      | 0      |\n| 10   | nexttime  | 下次执行时间                          | bigint(20)       | YES      |      | 0      |\n| 11   | runtime   | 每次执行的时间                        | bigint(20)       | YES      |      | 0      |\n| 12   | runtype   | 执行类型0为间隔执行1为系统执行crontab | tinyint(1)       | YES      |      | 0      |\n| 13   | cron      | Runtype为1时不能为空 如0 */1 * * *    | varchar(255)     | YES      |      | null   |\n\n创建代码\n\n```js\nDROP TABLE IF EXISTS `rt_crons`;\n CREATE TABLE `rt_crons` (\n  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,\n  `name` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT \'任务名称\',\n  `interval` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT \'执行间隔 毫秒为单位\',\n  `immediate` tinyint(1) DEFAULT \'1\' COMMENT \'是否立即执行\',\n  `handle` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT \'执行路径\',\n  `enable` tinyint(1) DEFAULT \'1\' COMMENT \'是否开启\',\n  `type` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT \'one执行一次all一直执行\',\n  `addtime` int(10) DEFAULT \'0\' COMMENT \'添加时间\',\n  `uptime` bigint(20) DEFAULT \'0\' COMMENT \'更新时间\',\n  `nexttime` bigint(20) DEFAULT \'0\' COMMENT \'下次执行时间\',\n  `runtime` bigint(20) DEFAULT \'0\' COMMENT \'每次执行的时间\',\n  `runtype` tinyint(1) DEFAULT \'0\' COMMENT \'执行类型0为间隔执行1为系统执行crontab\',\n  `cron` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT \'Runtype为1时不能为空 如0 */1 * * *\',\n  PRIMARY KEY (`id`) USING BTREE,\n  UNIQUE KEY `handle` (`handle`) USING BTREE\n) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT=\'系统计划任务表\'\n```\n\n---\n\n#### rt_database-数据库连接表\n\n\n| 排序 | 字段名      | 名称 | 类型                | 是否为空 | 索引 | 默认值 |\n| ------ | ------------- | ------ | --------------------- | ---------- | ------ | -------- |\n| 1    | id          |      | int(10) unsigned    | NO       | PRI  | null   |\n| 2    | database    |      | varchar(255)        | NO       |      | null   |\n| 3    | host        |      | varchar(255)        | YES      |      | null   |\n| 4    | port        |      | int(10) unsigned    | NO       |      | 3306   |\n| 5    | user        |      | varchar(255)        | NO       |      | null   |\n| 6    | password    |      | varchar(255)        | NO       |      | null   |\n| 7    | dateStrings |      | tinyint(2) unsigned | YES      |      | null   |\n| 8    | encoding    |      | varchar(255)        | YES      |      | null   |\n| 9    | isdef       |      | tinyint(2) unsigned | YES      |      | 0      |\n| 10   | prefix      |      | varchar(100)        | YES      |      | null   |\n| 11   | ssh         |      | tinyint(2) unsigned | YES      |      | null   |\n| 12   | shost       |      | varchar(255)        | YES      |      | null   |\n| 13   | sport       |      | int(10) unsigned    | YES      |      | 22     |\n| 14   | suser       |      | varchar(255)        | YES      |      | null   |\n| 15   | stype       |      | tinyint(2) unsigned | YES      |      | 1      |\n| 16   | spass       |      | varchar(255)        | YES      |      | null   |\n| 17   | spath       |      | varchar(255)        | YES      |      | null   |\n\n创建代码\n\n```js\nDROP TABLE IF EXISTS `rt_database`;\n CREATE TABLE `rt_database` (\n  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,\n  `database` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,\n  `host` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,\n  `port` int(10) unsigned NOT NULL DEFAULT \'3306\',\n  `user` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,\n  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,\n  `dateStrings` tinyint(2) unsigned DEFAULT NULL,\n  `encoding` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,\n  `isdef` tinyint(2) unsigned DEFAULT \'0\',\n  `prefix` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,\n  `ssh` tinyint(2) unsigned DEFAULT NULL,\n  `shost` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,\n  `sport` int(10) unsigned DEFAULT \'22\',\n  `suser` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,\n  `stype` tinyint(2) unsigned DEFAULT \'1\',\n  `spass` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,\n  `spath` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,\n  PRIMARY KEY (`id`)\n) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT=\'数据库连接表\'\n```\n\n---\n\n#### rt_datasafe-数据库保护表\n\n\n| 排序 | 字段名  | 名称 | 类型         | 是否为空 | 索引 | 默认值 |\n| ------ | --------- | ------ | -------------- | ---------- | ------ | -------- |\n| 1    | id      |      | int(10)      | NO       | PRI  | null   |\n| 2    | data_id |      | int(10)      | YES      | MUL  | null   |\n| 3    | name    |      | varchar(255) | YES      |      | null   |\n\n创建代码\n\n```js\nDROP TABLE IF EXISTS `rt_datasafe`;\n CREATE TABLE `rt_datasafe` (\n  `id` int(10) NOT NULL AUTO_INCREMENT,\n  `data_id` int(10) DEFAULT NULL,\n  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,\n  PRIMARY KEY (`id`),\n  UNIQUE KEY `data_id` (`data_id`,`name`) USING BTREE\n) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT=\'数据库保护表\'\n```\n\n---\n\n#### rt_error-系统错误日志表\n\n\n| 排序 | 字段名   | 名称 | 类型             | 是否为空 | 索引 | 默认值 |\n| ------ | ---------- | ------ | ------------------ | ---------- | ------ | -------- |\n| 1    | id       |      | int(10) unsigned | NO       | PRI  | null   |\n| 2    | name     |      | varchar(255)     | YES      |      | null   |\n| 3    | url      |      | varchar(255)     | YES      |      | null   |\n| 4    | msg      |      | text             | YES      |      | null   |\n| 5    | addtime  |      | int(10) unsigned | YES      |      | 0      |\n| 6    | admin_id |      | int(10) unsigned | YES      |      | 0      |\n| 5    | add_time |      | int(10) unsigned | YES      |      | 0      |\n\n创建代码\n\n```js\nDROP TABLE IF EXISTS `rt_error`;\n CREATE TABLE `rt_error` (\n  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,\n  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,\n  `url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,\n  `msg` text COLLATE utf8mb4_unicode_ci,\n  `addtime` int(10) unsigned DEFAULT \'0\',\n  `admin_id` int(10) unsigned DEFAULT \'0\',\n  PRIMARY KEY (`id`) USING BTREE\n) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT=\'系统错误日志表\'\n```\n\n---\n\n#### rt_form-系统表单\n\n\n| 排序 | 字段名      | 名称     | 类型             | 是否为空 | 索引 | 默认值 |\n| ------ | ------------- | ---------- | ------------------ | ---------- | ------ | -------- |\n| 1    | id          |          | int(10) unsigned | NO       | PRI  | null   |\n| 2    | name        |          | varchar(255)     | YES      |      | null   |\n| 3    | key         |          | varchar(255)     | YES      |      | null   |\n| 4    | data        |          | text             | YES      |      | null   |\n| 5    | get_url     |          | varchar(255)     | YES      |      | null   |\n| 6    | post_url    |          | varchar(255)     | YES      |      | null   |\n| 7    | form_path   |          | varchar(255)     | YES      |      | null   |\n| 8    | add_time    | 添加时间 | int(10) unsigned | YES      |      | 0      |\n| 9    | link_id     | 回写id   | int(10) unsigned | YES      |      | 0      |\n| 10   | link_name   | 回写表名 | varchar(255)     | YES      |      | 0      |\n| 11   | link_field  | 回写字段 | varchar(255)     | YES      |      | null   |\n| 12   | params_get  |          | varchar(255)     | YES      |      | null   |\n| 13   | params_post |          | varchar(255)     | YES      |      | null   |\n\n创建代码\n\n```js\nDROP TABLE IF EXISTS `rt_form`;\n CREATE TABLE `rt_form` (\n  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,\n  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,\n  `key` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,\n  `data` text COLLATE utf8mb4_unicode_ci,\n  `get_url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,\n  `post_url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,\n  `form_path` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,\n  `add_time` int(10) unsigned DEFAULT \'0\' COMMENT \'添加时间\',\n  `link_id` int(10) unsigned DEFAULT \'0\' COMMENT \'回写id\',\n  `link_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT \'0\' COMMENT \'回写表名\',\n  `link_field` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT \'回写字段\',\n  `params_get` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,\n  `params_post` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,\n  PRIMARY KEY (`id`)\n) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT=\'系统表单\'\n```\n\n---\n\n#### rt_menu-系统菜单\n\n\n| 排序 | 字段名    | 名称                 | 类型                | 是否为空 | 索引 | 默认值 |\n| ------ | ----------- | ---------------------- | --------------------- | ---------- | ------ | -------- |\n| 1    | id        |                      | int(10) unsigned    | NO       | PRI  | null   |\n| 2    | title     |                      | varchar(255)        | YES      |      | null   |\n| 3    | route     | 权限标志             | varchar(255)        | YES      | MUL  | null   |\n| 4    | href      | 前端地址             | varchar(255)        | YES      |      | null   |\n| 5    | type      | 0目录1菜单2按钮3权限 | tinyint(2)          | YES      |      | 0      |\n| 6    | order_num | 排序                 | int(10)             | YES      |      | 0      |\n| 6    | icon      |                      | varchar(255)        | YES      |      | null   |\n| 8    | open_type |                      | varchar(255)        | YES      |      | null   |\n| 8    | pid       |                      | int(10)             | YES      |      | 0      |\n| 9    | lid       |                      | tinyint(3)          | YES      |      | 1      |\n| 11   | ifshow    | 是否显示0显示1不显示 | tinyint(3) unsigned | YES      |      | 0      |\n| 2    | name      |                      | varchar(255)        | YES      |      | null   |\n| 3    | url       | 权限标志             | varchar(255)        | YES      |      | null   |\n| 4    | ismenu    | 0目录1菜单2按钮      | tinyint(2)          | YES      |      | 0      |\n| 5    | order     |                      | int(5)              | YES      |      | 0      |\n| 7    | target    |                      | varchar(255)        | YES      |      | null   |\n\n创建代码\n\n```js\nDROP TABLE IF EXISTS `rt_menu`;\n CREATE TABLE `rt_menu` (\n  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,\n  `title` varchar(255) CHARACTER SET utf8 DEFAULT NULL,\n  `route` varchar(255) CHARACTER SET utf8 DEFAULT NULL COMMENT \'权限标志\',\n  `href` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT \'前端地址\',\n  `type` tinyint(2) DEFAULT \'0\' COMMENT \'0目录1菜单2按钮3权限\',\n  `order_num` int(10) DEFAULT \'0\' COMMENT \'排序\',\n  `icon` varchar(255) CHARACTER SET utf8 DEFAULT NULL,\n  `open_type` varchar(255) CHARACTER SET utf8 DEFAULT NULL,\n  `pid` int(10) DEFAULT \'0\',\n  `lid` tinyint(3) DEFAULT \'1\',\n  `ifshow` tinyint(3) unsigned DEFAULT \'0\' COMMENT \'是否显示0显示1不显示\',\n  PRIMARY KEY (`id`) USING BTREE,\n  KEY `url` (`route`) USING BTREE\n) ENGINE=InnoDB AUTO_INCREMENT=143 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT=\'系统菜单\'\n```\n\n---\n\n#### rt_mod-系统模块表\n\n\n| 排序 | 字段名      | 名称                          | 类型             | 是否为空 | 索引 | 默认值 |\n| ------ | ------------- | ------------------------------- | ------------------ | ---------- | ------ | -------- |\n| 1    | id          | 唯一标志                      | int(10) unsigned | NO       | PRI  | null   |\n| 2    | name        | 模块名称                      | varchar(100)     | YES      |      | null   |\n| 3    | key         | 系统标志                      | varchar(60)      | NO       | UNI  | null   |\n| 4    | server_path | 模块路径                      | varchar(100)     | YES      |      | server |\n| 5    | tables_main | 主表                          | varchar(100)     | NO       |      | null   |\n| 6    | tables_more | 附加表                        | varchar(255)     | YES      |      | null   |\n| 7    | type        | 模块类型1控制层2数据层3服务层 | tinyint(2)       | NO       |      | 1      |\n| 8    | params      | 全局参数                      | varchar(255)     | NO       |      | null   |\n| 9    | remark      | 模块说明                      | varchar(255)     | NO       |      | null   |\n\n创建代码\n\n```js\nDROP TABLE IF EXISTS `rt_mod`;\n CREATE TABLE `rt_mod` (\n  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT \'唯一标志\',\n  `name` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT \'模块名称\',\n  `key` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT \'系统标志\',\n  `server_path` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT \'server\' COMMENT \'模块路径\',\n  `tables_main` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT \'主表\',\n  `tables_more` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT \'附加表\',\n  `type` tinyint(2) NOT NULL DEFAULT \'1\' COMMENT \'模块类型1控制层2数据层3服务层\',\n  `params` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT \'全局参数\',\n  `remark` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT \'模块说明\',\n  PRIMARY KEY (`id`),\n  UNIQUE KEY `key` (`key`)\n) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT=\'系统模块表\'\n```\n\n---\n\n#### rt_params-全局常量表\n\n\n| 排序 | 字段名  | 名称                      | 类型             | 是否为空 | 索引 | 默认值 |\n| ------ | --------- | --------------------------- | ------------------ | ---------- | ------ | -------- |\n| 1    | id      | 唯一标志                  | int(10) unsigned | NO       | PRI  | null   |\n| 2    | name    | 参数名称                  | varchar(100)     | NO       |      | null   |\n| 3    | key     | 参数值                    | varchar(255)     | NO       |      | null   |\n| 4    | content | 参数内容                  | varchar(255)     | NO       |      | null   |\n| 5    | type    | 参数类型1文件2数字3字符串 | tinyint(2)       | NO       |      | 1      |\n\n创建代码\n\n```js\nDROP TABLE IF EXISTS `rt_params`;\n CREATE TABLE `rt_params` (\n  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT \'唯一标志\',\n  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT \'参数名称\',\n  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT \'参数值\',\n  `content` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT \'参数内容\',\n  `type` tinyint(2) NOT NULL DEFAULT \'1\' COMMENT \'参数类型1文件2数字3字符串\',\n  PRIMARY KEY (`id`)\n) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT=\'全局常量表\'\n```\n\n---\n\n#### rt_set-系统配置表\n\n\n| 排序 | 字段名    | 名称   | 类型             | 是否为空 | 索引 | 默认值 |\n| ------ | ----------- | -------- | ------------------ | ---------- | ------ | -------- |\n| 1    | id        |        | int(10) unsigned | NO       | PRI  | null   |\n| 2    | key       | 键值   | varchar(128)     | NO       | UNI  | null   |\n| 3    | name      | 名称   | varchar(128)     | YES      |      | null   |\n| 4    | val       | 值     | text             | YES      |      | null   |\n| 5    | enable    | 状态   | tinyint(2)       | YES      |      | 1      |\n| 6    | remark    |        | varchar(255)     | YES      |      | null   |\n| 7    | form_id   | 表单id | int(10) unsigned | NO       |      | 0      |\n| 8    | form_path |        | varchar(255)     | YES      |      | null   |\n| 9    | params    |        | varchar(255)     | YES      |      | null   |\n\n创建代码\n\n```js\nDROP TABLE IF EXISTS `rt_set`;\n CREATE TABLE `rt_set` (\n  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,\n  `key` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT \'键值\',\n  `name` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT \'名称\',\n  `val` text COLLATE utf8mb4_unicode_ci COMMENT \'值\',\n  `enable` tinyint(2) DEFAULT \'1\' COMMENT \'状态\',\n  `remark` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,\n  `form_id` int(10) unsigned NOT NULL DEFAULT \'0\' COMMENT \'表单id\',\n  `form_path` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,\n  `params` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,\n  PRIMARY KEY (`id`) USING BTREE,\n  UNIQUE KEY `key` (`key`) USING BTREE\n) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT=\'系统配置表\'\n```\n\n---\n',
    0
  );
INSERT INTO
  `rt_doc_cate` (
    `id`,
    `did`,
    `type`,
    `add_time`,
    `update_time`,
    `user_id`,
    `pid`,
    `name`,
    `title`,
    `content`,
    `order_num`
  )
VALUES
  (
    36,
    1,
    1,
    1638529126,
    1638529126,
    1,
    29,
    'seedoc',
    '参考文档',
    '# 编写必读\n\n### 项目源码\n[https://gitee.com/ruitao_admin/godocms](https://gitee.com/ruitao_admin/godocms)\n\n### 框架参考文档 \n[https://thinkjs.org/zh-cn/doc/3.0/index.html](https://thinkjs.org/zh-cn/doc/3.0/index.html)\n\n[https://github.com/thinkjs/cn.thinkjs.org](https://github.com/thinkjs/cn.thinkjs.org)\n\n### 前台模版文档\n[https://gitee.com/pear-admin/Pear-Admin-Layui](https://gitee.com/pear-admin/Pear-Admin-Layui)\n\n### 编写文档参考\n[https://docsify.js.org/#/zh-cn/](https://docsify.js.org/#/zh-cn/)\n[https://apidocjs.com/](https://apidocjs.com/)\n\n### 表单设计参考\n[https://gitee.com/ayq947/ayq-layui-form-designer?_from=gitee_search](https://gitee.com/ayq947/ayq-layui-form-designer?_from=gitee_search)\n\n### 思维导图参考\n[https://github.com/wanglin2/mind-map](https://github.com/wanglin2/mind-map)\n\n### excel参考\n[https://github.com/mengshukeji/Luckysheet](https://github.com/mengshukeji/Luckysheet)\n\n### ppt参考\n[https://github.com/pipipi-pikachu/PPTist](https://github.com/pipipi-pikachu/PPTist)\n\n### 流程图参考\n[https://github.com/jgraph/mxgraph](https://github.com/jgraph/mxgraph)\n\n### markdown编辑器\n[https://github.com/Vanessa219/vditor](https://github.com/Vanessa219/vditor)\n[https://github.com/nhn/tui.editor](https://github.com/nhn/tui.editor)\n\n### 富文本编辑器\n[https://github.com/ianstormtaylor/slate](https://github.com/ianstormtaylor/slate)\n[https://textbus.tanboui.com/doc/start](https://textbus.tanboui.com/doc/start)\n[https://github.com/froala/wysiwyg-editor](https://github.com/froala/wysiwyg-editor)\n[https://github.com/quilljs/quill](https://github.com/quilljs/quill)\n[https://github.com/notadd/neditor](https://github.com/notadd/neditor)\n[https://github.com/mdnice/markdown-resume](https://github.com/mdnice/markdown-resume 简历)\n\n### 图片编辑\n[https://github.com/nhn/tui.image-editor](https://github.com/nhn/tui.image-editor)\n\n\n',
    0
  );
INSERT INTO
  `rt_doc_cate` (
    `id`,
    `did`,
    `type`,
    `add_time`,
    `update_time`,
    `user_id`,
    `pid`,
    `name`,
    `title`,
    `content`,
    `order_num`
  )
VALUES
  (
    37,
    1,
    1,
    1638529126,
    1638529126,
    1,
    29,
    'codesee',
    '代码规范',
    '# 参考\n\nhttps://github.com/GDJiaMi/frontend-standards\n\nhttps://www.git-tower.com/learn/git/ebook/cn/command-line/advanced-topics/git-flow\n\n# 1、工作流规范（基于Git）\n\n## 1.1、开发\n\n### 1.1.1、[版本规范](https://semver.org/lang/zh-CN/)\n\n版本格式：主版本号.次版本号.修订号，版本号递增规则如下：\n\n1. 主版本号：当你做了不兼容的 API 修改，\n2. 次版本号：当你做了向下兼容的功能性新增，\n3. 修订号：当你做了向下兼容的问题修正。\n\n先行版本号及版本编译元数据可以加到“主版本号.次版本号.修订号”的后面，作为延伸。\n\n### 1.1.2、Git分支模型\n\n#### master分支\n\nmaster分支表示一个稳定的发布版本. 对应百宝袋的大版本.\n\n- 场景: 所有应用会跟随版本迭代, 在dev分支测试稳定后, 会合并到master分支, 并使用tag标记应用版本\n- tag规范: `v{version}`, 例如v0.1.0\n- 人员: 由项目负责人进行审核合并, 普通开发者没有权限\n\n#### dev分支\n\n开发者主要工作的分支, 最新的特性或bug修复都会提交到这个分支. 开发者如果在该分支进行了提交，在push到远程之前应该先pull一下， 并尽量使用rebase模式，保证分支的简洁\n\n- 命名规范: dev\n- tag规范: 在dev分支中也可能会经历发布过程, 例如bug修复版本. 这里同样使用tag来标记这些发布. 例如v0.1.1\n- 提交规范：如果实在开发分支上进行开发，在推送到远程之前，应该使用`git rebase`形式更新本地分支。\n\n#### feature分支\n\n涉及多人协作或者大功能的开发, 应该从dev分支checkout出独立的feature分支, 避免干扰dev分支\n\n- 场景:\n  - 涉及多人协作: 团队多个成员在同一个项目下负责开发不同的功能, 这时候每个成员在自己的feature分支独立开发\n  - 大功能开发: 大功能开发跨越周期比较长, 需要多次迭代才会稳定. 这时候应该在独立的分支上开发. 方便跟踪历史记录, 也免于干扰dev分支的迭代和发布\n- 命名规范\n  - feature/name: name是功能名称\n  - feature/version: 这也是团队常见的模式, 当无法使用一个功能名称来描述时, 可以使用版本号作为’功能’\n- 合并时机\n  1. 当feature分支迭代稳定, 并通过测试后, 合并到dev分支. 合并到dev后, **feature分支的生命周期就结束了**. 后续bug修复和功能优化直接在dev开发\n  2. 当多个feature分支需要合并对外发布临时版本时. 合并到preview分支 . ⚠️这种情况不应该合并到dev分支, 因为feature分支可能还不稳定或未完成. 比如为了联调某些功能.\n- 合并方式\n  - 不要使用fast-forward. 这样可以在分支图上查看到分支历史\n\n#### preview分支\n\n临时的预览分支, preview分支用于临时合并feature分支, 这其中可能会修复某些bug或者冲突. 可以选择性地将这些提交cherrypick回feature分支. 当预览结束后就可以销毁preview分支\n\n#### release分支\n\n遵循gitflow规范\n\n- 场景: 需要为某个正式版本修复bug(hotFix)时, 从master的对应tag中checkout release分支\n- 命名规范: release/{version} \n- 如何修复\n    + 如果对应bug可以在dev分支直接被修复, 可以先提交到dev分支(或者已经修复了), 然后再cherrypick到release分支\n    + 如果bug在新版本无法复现. 比如新版本升级了依赖. 那么在release分支直接修复即可\n\n### 1.1.3、提交信息规范\n\n#### 格式\n\n我们采用angular的提交规范, 在这个规范的基础上支持(可选)`emoji`进行修饰\n\n```\n<type>(<scope>): <subject>\n\n<body>\n\n<footer>\n```\n\n##### header\n\n> 如果提交时feature或者fix(已发布的版本), 这些提交信息应该出现在CHANGELOG\n\n- type: 说明commit的类别. 可以配合emoji使用, 让阅读者更快地区分提交的类型,允许以下类型:\n  - feature或feat: 引入新功能\n  - fix: 修复了bug\n  - docs: 文档\n  - style: 优化项目结构或者代码格式\n  - refactor: 代码重构. 代码重构不涉及新功能和bug修复. 不应该影响原有功能, 包括对外暴露的接口\n  - test: 增加测试\n  - chore: 构建过程, 辅助工具升级. 如升级依赖, 升级构建工具\n  - perf: 性能优化\n  - revert: revert之前的commit\n    - git revert 命令用于撤销之前的一个提交, 并在为这个撤销操作生成一个提交\n  - build或release: 构建或发布版本\n  - ci: 持续集成\n  - types: 类型定义文件更改\n  - workflow: 工作流改进\n  - wip: 开发中\n  - safe: 修复安全问题\n- scope: 可选. 说明提交影响的范围. 例如样式, 后端接口, 逻辑层等等\n- Subject: 提交目的的简短描述, 动词开头, 不超过80个字符. 不要为了提交而提交\n\n##### body\n\n可选. 对本次提交的详细描述. 如果变动很简单, 可以省略\n\n##### footer\n\n可选. 只用于说明不兼容变动(break change)和关闭 Issue(如果使用使用gitlab或github管理bug的话)\n\n#### 模板参考\n\nhttps://github.com/angular/angular/commits/master\n\n```\n# 新增一条 Commit 记录\ngit commit -m \'chore(package.json): 新增 AngularJS 规范，Commit 时会自动调用钩子（GitHook）来判断 Message 是否有效\'\n\n# 搜索跟 package.json 文件相关的历史记录\ngit log HEAD --grep chore(package.json)\n```\n\n### 1.1.4、BUG处理规则\n\n对于测试，目前会经历两个阶段\n\n- 冒烟测试：在对测试正式发版之前会要求对代码进行自测，及冒烟测试。\n- 正式测试阶段：正式测试阶段测试人员会在RDMS进行bug提交和管理，对BUG的处理规则如下：\n      - [解决待关闭]: 修改了程序代码, 问题解决;\n      - [不做处理]: 没有修改程序代码, 是由于其他原因(需求变更等), 而解决的问题;\n      - [退回]: 无规律或只出现一次的BUG, 研发没找到原因, 加上必要排查日志后, 可退回给测试; 复现后重新打开\n      - [正在处理]: 已大致定位原因, 需要较多时间处理的BUG, 可置为\"正在处理\"\n\n> BUG的数量可能会和个人的KPI挂钩。所以要谨慎自测\n\n### 1.1.5、处理定制化需求\n\n- 痛点\n  - 对于定制化需求, 并不会引入到正规的代码流中, 一般情况下会checkout出一个分支, 来专门做这里定制化需求, 然后单独发版. 使用分支模式的缺点有:\n    - 更新问题\n      - 每次正规代码更新都要合并到该分支. 当分支较多时分支图就会比较混乱\n      - 正规代码合并是必然会带来风险的, 比如项目结构变动, 依赖库变动. 都可能导致定制化的代码失效\n- 解决办法\n  - 减少代码耦合\n    - 尽量将定制化需求模块化, 最小化和正规代码之间的接触面. 这是解决该问题最根本的方式.\n      - 检验方式是结构变化时, 没有或很少适配代码\n  - 考虑通过代码层面区分\n    - 例如通过权限系统来配置. 通过后端接口动态配置\n  - 优先使用fork模式\n    - 有些场景确实无法通过代码层面解决, 比如ios应用定制启动图, icon, 应用名称, 外观等等. 这种方式优先使用fork模式, fork模式和分支模式没本质区别, 但是至少可以避免干扰正规开发流程\n\n## 1.2、发布工作流\n\n- 流程\n  1. 进行代码变更\n  2. 提交这些变更, 进行CI让这些变更通过测试\n     - 如果没通过就打tag, 一旦出现测试失败, tag就得重新打\n  3. 提升package.json的版本号, 更新CHANGELOG.md\n  4. 打上tag, 提交\n  5. 可选. 合并到release分支\n- 工具\n  - 使用[jm-deploy release](https://github.com/carney520/jm-deploy)自动化发布并生成CHANGELOG.md\n\n## 1.3、持续集成\n\n所有项目基于coding的持续集成来完成。\n\n## 1.4、扩展\n\n- [如何写好 Git commit log?](https://www.zhihu.com/question/21209619)\n- [提交信息emoji规范](https://gitmoji.carloscuesta.me/)\n- [Commit message 和 Change log 编写指南](http://www.ruanyifeng.com/blog/2016/01/commit_message_change_log.html)\n- [Git远程操作详解](http://www.ruanyifeng.com/blog/2014/06/git_remote.html)\n- [git钩子定制团队代码提交流程规范](https://www.jianshu.com/p/527e34f53b51)\n- [保持fork之后的项目和上游同步](https://github.com/staticblog/wiki/wiki/保持fork之后的项目和上游同步)\n\n# 2、编码规范\n\n## 2.1、代码格式化\n\n- [Prettier](https://prettier.io/) -  关于代码格式化的所有东西都交给它吧！\n\n基本上，所有代码格式相关的工作都可以交给Prettier来做，在这个基础上再使用Eslint覆盖语义相关的检查\n\n## 2.2、Code Review\n\n#### Architecture/Design\n\n- 单一职责原则.\n  - 这是经常被违背的原则。一个类只能干一个事情, 一个方法最好也只干一件事情。 比较常见的违背是一个类既干UI的事情，又干逻辑的事情, 这个在低质量的代码里很常见。\n\n- 行为是否统一\n\n  - 比如缓存是否统一，错误处理是否统一， 错误提示是否统一， 弹出框是否统一 等等。\n  - 同一逻辑/同一行为 有没有走同一Code Path？低质量程序的另一个特征是，同一行为/同一逻辑，因为出现在不同的地方或者被不同的方式触发，没有走同一Code Path 或者各处有一份copy的实现， 导致非常难以维护。\n\n- 代码污染\n\n  - 代码有没有对其他模块强耦合 ？\n\n- 重复代码\n\n  - 主要看有没有把公用组件，可复用的代码，函数抽取出来。\n\n- Open/Closed 原则\n\n  - 就是好不好扩展。 Open for extension, closed for modification.\n\n- 面向接口编程 和 不是 面向实现编程\n\n  - 主要就是看有没有进行合适的抽象， 把一些行为抽象为接口。\n\n- 健壮性\n\n  - 对Corner case有没有考虑完整，逻辑是否健壮？有没有潜在的bug？\n  - 有没有内存泄漏？有没有循环依赖?（针对特定语言，比如Objective-C) ？有没有野指针？\n  - 有没有考虑线程安全性， 数据访问的一致性\n\n- 错误处理\n\n  - 有没有很好的Error Handling？比如网络出错，IO出错。\n\n- 改动是不是对代码的提升\n\n  - 新的改动是打补丁，让代码质量继续恶化，还是对代码质量做了修复？\n\n- 效率/性能\n\n  - 客户端程序 对频繁消息 和较大数据等耗时操作是否处理得当。\n  - 关键算法的时间复杂度多少？有没有可能有潜在的性能瓶颈。\n\n其中有一部分问题，比如一些设计原则， 可预见的效率问题， 开发模式一致性的问题 应该尽早在Design Review阶段解决。如果Design阶段没有解决，那至少在Code Review阶段也要把它找出来。\n\n#### Style\n\n- 可读性\n\n  - 衡量可读性的可以有很好实践的标准，就是Reviewer能否非常容易的理解这个代码。 如果不是，那意味着代码的可读性要进行改进。\n\n- 命名\n\n  - 命名对可读性非常重要，我倾向于函数名/方法名长一点都没关系，必须是能自我阐述的。\n  - 英语用词尽量准确一点（哪怕有时候需要借助Google Translate，是值得的）\n\n- 函数长度/类长度\n\n  - 函数太长的不好阅读。 类太长了，比如超过了1000行，那你要看一下是否违反的“单一职责” 原则。\n\n- 注释\n\n  - 恰到好处的注释。 但更多我看到比较差质量的工程的一个特点是缺少注释。\n\n- 参数个数\n\n  - 不要太多， 一般不要超过3个。\n\n#### Review Your Own Code First\n\n- 跟著名的橡皮鸭调试法（Rubber Duck Debugging）一样，每次提交前整体把自己的代码过一遍非常有帮助，尤其是看看有没有犯低级错误。\n\n#### 如何进行Code Review\n\n- 多问问题。多问 “这块儿是怎么工作的？” “如果有XXX case，你这个怎么处理？”\n- 每次提交的代码不要太多，最好不要超过1000行，否则review起来效率会非常低。\n- 当面讨论代替Comments。 大部分情况下小组内的同事是坐在一起的，face to face的 code review是非常有效的。\n- 区分重点，不要舍本逐末。 优先抓住 设计，可读性，健壮性等重点问题。\n\n#### Code Review的意识\n\n- 作为一个Developer , 不仅要Deliver working code, 还要Deliver maintainable code.\n- 必要时进行重构，随着项目的迭代，在计划新增功能的同时，开发要主动计划重构的工作项。\n- 开放的心态，虚心接受大家的Review Comments。\n\n# 3、文档规范\n\n## 3.1、文档中心\n\n采用Coding提供的WIKI作为文档中心，采用Markdown格式。\n\n可视化编辑器\n\n- **Visual Code**: 大部分代码编辑都支持Markdown编辑和预览\n- [**Mou**](https://link.jianshu.com/?t=http://mouapp.com/): Mac下的老牌编辑器\n- [**typora**](https://typora.io/): 跨平台的Markdown编辑器，推荐\n\n## 3.2、代码即文档\n\n通过‘代码即文档’的方式至少可以**保持文档和代码同步更新**；另外**很多工具会分析代码的数据类型**，自动帮我们生成参数和返回值定义，这也可以减少很多文档编写工作以及出错率。\n\n相关的工具有:\n\n- API文档 \n  - Typescript \n    - [tsdoc](https://github.com/microsoft/tsdoc) Typescript官方的注释文档标准\n    - [typedoc](https://github.com/TypeStrong/typedoc) 基于tsdoc标准的文档生成器\n  - Javascript \n    - [jsdoc](https://github.com/jsdoc/jsdoc) Javascript文档注释标准和生成器\n- 后端接口文档 \n  - [Swagger](https://swagger.io) Restful接口文档规范\n  - GraphQL: 这个有很多工具，例如[graphiql](https://github.com/graphql/graphiql), 集成了Playground和文档，很先进\n  - [Easy Mock](https://easy-mock.com/login) 一个可视化，并且能快速生成模拟数据的服务\n- 组件文档 \n  - [StoryBook](https://storybook.js.org) 通用的组件开发、测试、文档工具\n  - React \n    - [Docz](http://docz.site)\n    - [Styleguidist](https://github.com/styleguidist/react-styleguidist)\n  - Vue \n    - [vue-styleguidist](https://github.com/vue-styleguidist/vue-styleguidist)\n\n## 3.3、注释即文档\n\n**必要和适量的注释对阅读源代码的人来说就是一个路牌, 可以少走很多弯路**.\n\n关于注释的一些准则，[<阿里巴巴Java开发手册>](https://github.com/alibaba/p3c/blob/master/p3c-gitbook/编程规约/注释规约.md)总结得非常好, 推荐基于这个来建立注释规范。另外通过ESlint是可以对注释进行一定程度的规范。\n\n# 4、UI规范\n\n待定\n\n# 5、测试规范\n\n![图片](/api/project/281160/files/2347052/imagePreview)\n\n## 单元测试\n\n单元测试有很多**好处**, 比如:\n\n- **提高信心，适应变化和迭代**. 如果现有代码有较为完善的单元测试，在代码重构时，可以检验模块是否依然可以工作, 一旦变更导致错误，单元测试也可以帮助我们快速定位并修复错误\n- **单元测试是集成测试的基础**\n- **测试即文档**。如果文档不能解决你的问题，在你打算看源码之前，可以查看单元测试。通过这些测试用例，开发人员可以直观地理解程序单元的基础API\n- **提升代码质量。易于测试的代码，一般都是好代码**\n\n**测什么?**\n\n业务代码或业务组件是比较难以实施单元测试的，一方面它们比较多变、另一方面很多团队很少有精力维护这部分单元测试。所以**通常只要求对一些基础/底层的组件、框架或者服务进行测试, 视情况考虑是否要测试业务代码**\n\n**测试的准则**:\n\n- 推荐Petroware的[Unit Testing Guidelines](https://petroware.no/unittesting.html), 总结了27条单元测试准则，非常受用.\n- 另外<阿里巴巴的Java开发手册>中总结的[单元测试准则](https://github.com/alibaba/p3c/blob/master/p3c-gitbook/单元测试.md), 也不错，虽然书名是Java，准则是通用的.\n\n**单元测试指标**:\n\n一般使用[`测试覆盖率`](https://zh.wikipedia.org/wiki/代碼覆蓋率)来量化，尽管对于覆盖率能不能衡量单元测试的有效性存在较多争议。\n\n大部分情况下还是推荐尽可能提高覆盖率, 比如要求`语句覆盖率达到70%；核心模块的语句覆盖率和分支覆盖率都要达到100%`. 视团队情况而定\n\n扩展:\n\n- [测试覆盖（率）到底有什么用？](https://www.infoq.cn/article/test-coverage-rate-role)\n- [阿里巴巴Java开发文档-单元测试](https://www.kancloud.cn/kanglin/java_developers_guide/539190)\n\n**相关工具**\n\n- Headless Browsers: 无头浏览器是网页自动化的重要运行环境。 常用于功能测试、单元测试、网络爬虫 \n\n  - [puppeteer](https://github.com/GoogleChrome/puppeteer)\n  - [Headless Chromium](https://chromium.googlesource.com/chromium/src/+/lkgr/headless/README.md)\n\n- 测试框架 \n\n  - Jest\n\n    Facebook的单元测试框架. 零配置, 支持组件快照测试、模块Mock、Spy. 一般场景, 单元测试学它一个就行了 \n\n    - 组件测试 \n      - [testing-library](https://github.com/testing-library) \n      - [Enzyme](https://github.com/airbnb/enzyme)\n\n  - [Intern](https://theintern.github.io/)\n\n- 单元测试 \n\n  - [AVA](https://github.com/avajs/ava)\n  - [Jasmine](http://jasmine.github.io/)\n  - [Mocha](http://mochajs.org/)\n  - [Tape](https://github.com/substack/tape)\n\n- 断言库 \n\n  - [Chai](http://chaijs.com/)\n  - [expect.js](https://github.com/Automattic/expect.js)\n  - [should.js](http://shouldjs.github.io/)\n\n- Mock/Stubs/Spies \n\n  - [sinon.js](http://sinonjs.org/)\n\n- 代码覆盖率 \n\n  - [istanbul](https://github.com/gotwarlost/istanbul)\n\n- 基准测试 \n\n  - [benchmark.js](http://benchmarkjs.com/)\n  - [jsperf.com](https://jsperf.com/)\n\n# 6、异常处理、监控\n\n## 6.1、异常处理\n\n参考《阿里巴巴开发手册》中的[异常处理]([https://github.com/alibaba/p3c/blob/master/p3c-gitbook/%E5%BC%82%E5%B8%B8%E6%97%A5%E5%BF%97/%E5%BC%82%E5%B8%B8%E5%A4%84%E7%90%86.md](https://github.com/alibaba/p3c/blob/master/p3c-gitbook/异常日志/异常处理.md))\n\n## 6.2、日志\n\n- 避免重复打印日志\n- 谨慎地记录日志, 划分日志级别。比如生产环境禁止输出debug日志；有选择地输出info日志；\n- 使用前缀对日志进行分类, 例如: `[User] xxxx`\n\n## 6.2、异常监控\n\n异常监控通常会通过三种方式来收集异常数据:\n\n1. 全局捕获。\n2. 主动上报。在try/catch中主动上报.\n3. 用户反馈。比如弹窗让用户填写反馈信息.\n\n第三方工具推荐\n\n- [Bugly](https://bugly.qq.com/v2/) 免费\n- [Sentry](https://sentry.io/welcome/) 免费基本够用\n\n# 7、前后端协作规范\n\n## 7.1、协作流程\n\n前后端协作流程如下:\n\n![图片](/api/project/281160/files/2347269/imagePreview)\n\n1、需求分析。参与者一般有前后端、测试、以及产品. 由产品主持，对需求进行宣贯，接受开发和测试的反馈，确保大家对需求有一致的认知\n\n2、前后端开发讨论。讨论应用的一些开发设计，沟通技术点、难点、以及分工问题.\n\n3、设计接口文档。可以由前后端一起设计；或者由后端设计、前端确认是否符合要求\n\n4、并行开发。前后端并行开发，在这个阶段，前端可以先实现静态页面; 或者根据接口文档对接口进行Mock, 来模拟对接后端接口\n\n5、在联调之前，要求后端做好接口测试\n\n6、真实环境联调。前端将接口请求代理到后端服务，进行真实环境联调。\n\n## 7.2、接口规范\n\n采用RESTFUL设计规范。\n\n**需要注意的点**:\n\n- 明确区分是正常还是异常, 严格遵循接口的异常原语. 上述接口形式都有明确的异常原语，比如JSONRPC，当出现异常时应该返回`错误对象`响应，而不是在正常的响应体中返回错误代码. 另外要规范化的错误码, HTTP响应码就是一个不错的学习对象\n- 明确数据类型。很多后端写的接口都是string和number不分的，如果妥协的话、前端就需要针对这个属性做特殊处理，这也可能是潜在的bug\n- 明确空值的意义。比如在做更新操作是，空值是表示重置，还是忽略更新？\n- 响应避免冗余的嵌套。\n- 接口版本化，保持向下兼容。就像我们上文的‘语义化版本规范’说的，对于后端来说，API就是公共的接口. 公共暴露的接口应该有一个版本号，来说明当前描述的接口做了什么变动，是否向下兼容。 现在前端代码可能会在客户端被缓存，例如小程序。如果后端做了break change，就会影响这部分用户。\n\n## 7.3、接口文档规范\n\n后端通过接口文档向前端暴露接口相关的信息。通常需要包含这些信息：\n\n- 版本号\n- 文档描述\n- 服务的入口. 例如基本路径\n- 测试服务器. 可选\n- 简单使用示例\n- 安全和认证\n- 请求限制\n- 错误说明\n- 版本\n- 字段类型\n- 具体接口定义 \n  - 方法名称或者URL\n  - 方法描述\n  - 请求参数及其描述，必须说明类型(数据类型、是否可选等)\n  - 响应参数及其描述, 必须说明类型(数据类型、是否可选等)\n  - 可能的异常情况、错误代码、以及描述\n  - 请求示例，可选\n\n> 也可采用Coding提供的API文档模板来改写\n\n**人工维护导致的问题**:\n\n上文‘代码即文档’就提到了人工维护接口文档可能导致代码和文档不同步问题。\n\n如果可以从代码或者规范文档(例如OpenAPI这类API描述规范)中生成接口文档，可以解决实现和文档不一致问题, 同时也可以减少文档编写和维护的投入.\n\n**项目采用Coding提供的API文档来自动生成API文档。**\n\n\n',
    0
  );
INSERT INTO
  `rt_doc_cate` (
    `id`,
    `did`,
    `type`,
    `add_time`,
    `update_time`,
    `user_id`,
    `pid`,
    `name`,
    `title`,
    `content`,
    `order_num`
  )
VALUES
  (
    38,
    1,
    1,
    1638529126,
    1638529126,
    1,
    30,
    'login',
    '用户登录',
    '<a name=\"top\"></a>\n# <a name=\'login\'></a> login\n\n## <a name=\'获取验证码\'></a> 获取验证码\n\n<p>返回base64位图片</p>\n\n```\nGET login/captcha\n```\n\n## <a name=\'用户登录\'></a> 用户登录\n\n```\nPOST login/do\n```\n\n### 请求参数 - `Parameter`\n\n| Name     | Type       | Description                           |\n|----------|------------|---------------------------------------|\n| username | `string` | <p>用户 必填</p> |\n| password | `string` | <p>密码 必填</p> |\n| captcha | `string` | <p>验证码 必填</p> |\n\n### 返回信息\n\n#### 状态码 - `Success 200`\n\n| Name     | Type       | Description                           |\n|----------|------------|---------------------------------------|\n| code | `number` | <p>结果码</p> |\n| data | `string` | <p>数据</p> |\n| message | `string` | <p>提示</p> |\n\n### 返回事例\n\n####  - `Success-Response:`\n\n```json\n{\n\"code\": 0,\n\"message\": \"ok\",\n\"data\":token\n}\n```\n\n',
    0
  );
INSERT INTO
  `rt_doc_cate` (
    `id`,
    `did`,
    `type`,
    `add_time`,
    `update_time`,
    `user_id`,
    `pid`,
    `name`,
    `title`,
    `content`,
    `order_num`
  )
VALUES
  (
    39,
    1,
    1,
    1638529126,
    1638529126,
    1,
    30,
    'menu',
    '后台菜单',
    '<a name=\"top\"></a>\n# <a name=\'menu\'></a> menu\n\n## <a name=\'编辑菜单\'></a> 编辑菜单\n\n```\nPOST menu/edit\n```\n\n### Headers - `Header`\n\n| Name    | Type      | Description                          |\n|---------|-----------|--------------------------------------|\n| rttoken | `string` | <p>必填</p> |\n\n### 请求参数 - `Parameter`\n\n| Name     | Type       | Description                           |\n|----------|------------|---------------------------------------|\n| id | `Number` | <p>菜单id</p> |\n| pid | `Number` | <p>菜单上级id</p> |\n| title | `String` | <p>菜单名称</p> |\n| href | `String` | <p>前端模版</p> |\n| route | `String` | <p>后端路由</p> |\n| icon | `String` | <p>菜单icon</p> |\n| type | `Number` | <p>类型 0 1 2 3</p> |\n| order_num | `Number` | <p>排序</p> |\n\n### 返回信息\n\n#### 状态码 - `200`\n\n| Name     | Type       | Description                           |\n|----------|------------|---------------------------------------|\n| name | `type` | <p>description</p> |\n\n## <a name=\'菜单是否显示\'></a> 菜单是否显示\n\n```\nPOST menu/ifshow\n```\n\n### Headers - `Header`\n\n| Name    | Type      | Description                          |\n|---------|-----------|--------------------------------------|\n| rttoken | `string` | <p>必填</p> |\n\n### 请求参数 - `Parameter`\n\n| Name     | Type       | Description                           |\n|----------|------------|---------------------------------------|\n| id | `Number` | <p>菜单id</p> |\n| ifshow | `Number` | <p>显示状态0或1</p> |\n\n### 返回信息\n\n#### 状态码 - `200`\n\n| Name     | Type       | Description                           |\n|----------|------------|---------------------------------------|\n| name |  | <p>description</p> |\n\n## <a name=\'获取单个菜单数据\'></a> 获取单个菜单数据\n\n```\nGET menu/one\n```\n\n### Headers - `Header`\n\n| Name    | Type      | Description                          |\n|---------|-----------|--------------------------------------|\n| rttoken | `string` | <p>必填</p> |\n\n### 请求参数 - `Parameter`\n\n| Name     | Type       | Description                           |\n|----------|------------|---------------------------------------|\n| id | `Number` | <p>菜单id 可为0 为0时添加数据前拉取</p> |\n\n### 返回信息\n\n#### 状态码 - `200`\n\n| Name     | Type       | Description                           |\n|----------|------------|---------------------------------------|\n| name | `type` | <p>description</p> |\n\n## <a name=\'获取管理菜单列表\'></a> 获取管理菜单列表\n\n```\nGET menu/oplist\n```\n\n### Headers - `Header`\n\n| Name    | Type      | Description                          |\n|---------|-----------|--------------------------------------|\n| rttoken | `string` | <p>必填</p> |\n\n### 返回信息\n\n#### 状态码 - `Success 200`\n\n| Name     | Type       | Description                           |\n|----------|------------|---------------------------------------|\n| code | `number` | <p>结果码</p> |\n| data | `string` | <p>数据</p> |\n| message | `string` | <p>提示</p> |\n\n## <a name=\'获取管理界面菜单\'></a> 获取管理界面菜单\n\n```\nGET menu/list\n```\n\n### Headers - `Header`\n\n| Name    | Type      | Description                          |\n|---------|-----------|--------------------------------------|\n| rttoken | `string` | <p>必填</p> |\n\n### 返回信息\n\n#### 状态码 - `Success 200`\n\n| Name     | Type       | Description                           |\n|----------|------------|---------------------------------------|\n| code | `number` | <p>结果码</p> |\n| data | `string` | <p>数据</p> |\n| message | `string` | <p>提示</p> |\n\n### 返回事例\n\n####  - `Success-Response:`\n\n```json\n{\n\"code\": 200,\n\"message\": \"ok\",\n\"data\":{[\n]}\n}\n```\n\n## <a name=\'删除菜单\'></a> 删除菜单\n\n```\nPOST menu/del\n```\n\n### Headers - `Header`\n\n| Name    | Type      | Description                          |\n|---------|-----------|--------------------------------------|\n| rttoken | `string` | <p>必填</p> |\n\n### 请求参数 - `Parameter`\n\n| Name     | Type       | Description                           |\n|----------|------------|---------------------------------------|\n| id | `Number` | <p>菜单id</p> |\n\n### 返回信息\n\n#### 状态码 - `200`\n\n| Name     | Type       | Description                           |\n|----------|------------|---------------------------------------|\n| name |  | <p>description</p> |\n\n## <a name=\'添加菜单\'></a> 添加菜单\n\n```\nPOST menu/edit\n```\n\n### Headers - `Header`\n\n| Name    | Type      | Description                          |\n|---------|-----------|--------------------------------------|\n| rttoken | `string` | <p>必填</p> |\n\n### 请求参数 - `Parameter`\n\n| Name     | Type       | Description                           |\n|----------|------------|---------------------------------------|\n| pid | `Number` | <p>菜单上级id</p> |\n| title | `String` | <p>菜单名称</p> |\n| href | `String` | <p>前端模版</p> |\n| route | `String` | <p>后端路由</p> |\n| icon | `String` | <p>菜单icon</p> |\n| type | `Number` | <p>类型 0 1 2 3</p> |\n| order_num | `Number` | <p>排序</p> |\n\n### 返回信息\n\n#### 状态码 - `200`\n\n| Name     | Type       | Description                           |\n|----------|------------|---------------------------------------|\n| name | `type` | <p>description</p> |\n\n',
    0
  );
INSERT INTO
  `rt_doc_cate` (
    `id`,
    `did`,
    `type`,
    `add_time`,
    `update_time`,
    `user_id`,
    `pid`,
    `name`,
    `title`,
    `content`,
    `order_num`
  )
VALUES
  (
    40,
    1,
    1,
    1638529126,
    1638529126,
    1,
    30,
    'auth',
    '权限管理',
    '<a name=\"top\"></a>\n# <a name=\'auth\'></a> auth\n\n## <a name=\'编辑角色\'></a> 编辑角色\n\n```\nPOST auth/eidt\n```\n\n### Headers - `Header`\n\n| Name    | Type      | Description                          |\n|---------|-----------|--------------------------------------|\n| rttoken | `string` | <p>必填</p> |\n\n### 请求参数 - `Parameter`\n\n| Name     | Type       | Description                           |\n|----------|------------|---------------------------------------|\n| name | `string` | <p>角色名</p> |\n| status | `number` | <p>是否可用0可用1不可用</p> |\n| rules | `string` | <p>菜单id集合，逗号隔开</p> |\n| remark | `string` | <p>备注</p> |\n\n### 返回信息\n\n#### 状态码 - `200`\n\n| Name     | Type       | Description                           |\n|----------|------------|---------------------------------------|\n| name | `type` | <p>description</p> |\n\n## <a name=\'角色编辑前\'></a> 角色编辑前\n\n```\nPOST auth/beforEdit\n```\n\n### Headers - `Header`\n\n| Name    | Type      | Description                          |\n|---------|-----------|--------------------------------------|\n| rttoken | `string` | <p>必填</p> |\n\n### 请求参数 - `Parameter`\n\n| Name     | Type       | Description                           |\n|----------|------------|---------------------------------------|\n| id | `number` |  |\n\n### 返回信息\n\n#### 状态码 - `200`\n\n| Name     | Type       | Description                           |\n|----------|------------|---------------------------------------|\n| name | `type` | <p>description</p> |\n\n## <a name=\'角色列表\'></a> 角色列表\n\n```\nGET auth/list\n```\n\n### Headers - `Header`\n\n| Name    | Type      | Description                          |\n|---------|-----------|--------------------------------------|\n| rttoken | `string` | <p>必填</p> |\n\n### 请求参数 - `Parameter`\n\n| Name     | Type       | Description                           |\n|----------|------------|---------------------------------------|\n| page | `number` | <p>页码</p> |\n| limit | `number` | <p>每页显示数据</p> |\n\n### 返回信息\n\n#### 状态码 - `200`\n\n| Name     | Type       | Description                           |\n|----------|------------|---------------------------------------|\n| name | `type` | <p>description</p> |\n\n## <a name=\'角色添加前\'></a> 角色添加前\n\n```\nPOST auth/addTree\n```\n\n### Headers - `Header`\n\n| Name    | Type      | Description                          |\n|---------|-----------|--------------------------------------|\n| rttoken | `string` | <p>必填</p> |\n\n### 请求参数 - `Parameter`\n\n| Name     | Type       | Description                           |\n|----------|------------|---------------------------------------|\n| null |  |  |\n\n### 返回信息\n\n#### 状态码 - `200`\n\n| Name     | Type       | Description                           |\n|----------|------------|---------------------------------------|\n| name | `type` | <p>description</p> |\n\n## <a name=\'删除角色\'></a> 删除角色\n\n```\nPOST auth/del\n```\n\n### Headers - `Header`\n\n| Name    | Type      | Description                          |\n|---------|-----------|--------------------------------------|\n| rttoken | `string` | <p>必填</p> |\n\n### 请求参数 - `Parameter`\n\n| Name     | Type       | Description                           |\n|----------|------------|---------------------------------------|\n| id | `number` |  |\n\n### 返回信息\n\n#### 状态码 - `200`\n\n| Name     | Type       | Description                           |\n|----------|------------|---------------------------------------|\n| name | `type` | <p>description</p> |\n\n## <a name=\'设置角色是否可用\'></a> 设置角色是否可用\n\n```\nPOST auth/enable\n```\n\n### Headers - `Header`\n\n| Name    | Type      | Description                          |\n|---------|-----------|--------------------------------------|\n| rttoken | `string` | <p>必填</p> |\n\n### 请求参数 - `Parameter`\n\n| Name     | Type       | Description                           |\n|----------|------------|---------------------------------------|\n| status | `number` | <p>状态</p> |\n| id | `number` |  |\n\n### 返回信息\n\n#### 状态码 - `200`\n\n| Name     | Type       | Description                           |\n|----------|------------|---------------------------------------|\n| name | `type` | <p>description</p> |\n\n## <a name=\'添加角色\'></a> 添加角色\n\n```\nPOST auth/add\n```\n\n### Headers - `Header`\n\n| Name    | Type      | Description                          |\n|---------|-----------|--------------------------------------|\n| rttoken | `string` | <p>必填</p> |\n\n### 请求参数 - `Parameter`\n\n| Name     | Type       | Description                           |\n|----------|------------|---------------------------------------|\n| name | `string` | <p>角色名</p> |\n| status | `number` | <p>是否可用0可用1不可用</p> |\n| rules | `string` | <p>菜单id集合，逗号隔开</p> |\n| remark | `string` | <p>备注</p> |\n\n### 返回信息\n\n#### 状态码 - `200`\n\n| Name     | Type       | Description                           |\n|----------|------------|---------------------------------------|\n| name | `type` | <p>description</p> |\n\n',
    0
  );
INSERT INTO
  `rt_doc_cate` (
    `id`,
    `did`,
    `type`,
    `add_time`,
    `update_time`,
    `user_id`,
    `pid`,
    `name`,
    `title`,
    `content`,
    `order_num`
  )
VALUES
  (
    41,
    1,
    1,
    1638529126,
    1638529126,
    1,
    30,
    'Admin',
    '管理员管理',
    '<a name=\"top\"></a>\n# <a name=\'admin\'></a> admin\n\n## <a name=\'编辑管理员\'></a> 编辑管理员\n\n```\nPOST admin/edit\n```\n\n### Headers - `Header`\n\n| Name    | Type      | Description                          |\n|---------|-----------|--------------------------------------|\n| rttoken | `string` | <p>必填</p> |\n\n### 请求参数 - `Parameter`\n\n| Name     | Type       | Description                           |\n|----------|------------|---------------------------------------|\n| admin_id | `Number` | <p>管理员id</p> |\n| username | `string` | <p>用户名</p> |\n| password | `string` | <p>密码</p> |\n| name | `string` | <p>真实姓名</p> |\n| mobile | `Number` | <p>手机号</p> |\n| status | `Number` | <p>状态</p> |\n\n### 返回信息\n\n#### 状态码 - `200`\n\n| Name     | Type       | Description                           |\n|----------|------------|---------------------------------------|\n| name | `type` | <p>description</p> |\n\n## <a name=\'编辑管理员前\'></a> 编辑管理员前\n\n```\nGET admin/editBefore\n```\n\n### Headers - `Header`\n\n| Name    | Type      | Description                          |\n|---------|-----------|--------------------------------------|\n| rttoken | `string` | <p>必填</p> |\n\n### 请求参数 - `Parameter`\n\n| Name     | Type       | Description                           |\n|----------|------------|---------------------------------------|\n| id | `number` | <p>管理员id</p> |\n\n### 返回信息\n\n#### 状态码 - `200`\n\n| Name     | Type       | Description                           |\n|----------|------------|---------------------------------------|\n| name | `type` | <p>description</p> |\n\n## <a name=\'管理员列表\'></a> 管理员列表\n\n```\nGET admin/list\n```\n\n### Headers - `Header`\n\n| Name    | Type      | Description                          |\n|---------|-----------|--------------------------------------|\n| rttoken | `string` | <p>必填</p> |\n\n### 请求参数 - `Parameter`\n\n| Name     | Type       | Description                           |\n|----------|------------|---------------------------------------|\n| page | `number` | <p>页码</p> |\n\n### 返回信息\n\n#### 状态码 - `200`\n\n| Name     | Type       | Description                           |\n|----------|------------|---------------------------------------|\n| name | `type` | <p>description</p> |\n\n## <a name=\'删除管理员\'></a> 删除管理员\n\n```\nPOST admin/del\n```\n\n### Headers - `Header`\n\n| Name    | Type      | Description                          |\n|---------|-----------|--------------------------------------|\n| rttoken | `string` | <p>必填</p> |\n\n### 请求参数 - `Parameter`\n\n| Name     | Type       | Description                           |\n|----------|------------|---------------------------------------|\n| id | `number` |  |\n\n### 返回信息\n\n#### 状态码 - `200`\n\n| Name     | Type       | Description                           |\n|----------|------------|---------------------------------------|\n| name | `type` | <p>description</p> |\n\n## <a name=\'设置管理员是否可用\'></a> 设置管理员是否可用\n\n```\nPOST admin/enable\n```\n\n### Headers - `Header`\n\n| Name    | Type      | Description                          |\n|---------|-----------|--------------------------------------|\n| rttoken | `string` | <p>必填</p> |\n\n### 请求参数 - `Parameter`\n\n| Name     | Type       | Description                           |\n|----------|------------|---------------------------------------|\n| status | `number` | <p>状态</p> |\n| id | `number` |  |\n\n### 返回信息\n\n#### 状态码 - `200`\n\n| Name     | Type       | Description                           |\n|----------|------------|---------------------------------------|\n| name | `type` | <p>description</p> |\n\n## <a name=\'添加管理员\'></a> 添加管理员\n\n```\nPOST admin/add\n```\n\n### Headers - `Header`\n\n| Name    | Type      | Description                          |\n|---------|-----------|--------------------------------------|\n| rttoken | `string` | <p>必填</p> |\n\n### 请求参数 - `Parameter`\n\n| Name     | Type       | Description                           |\n|----------|------------|---------------------------------------|\n| username | `string` | <p>用户名</p> |\n| password | `string` | <p>密码</p> |\n| name | `string` | <p>真实姓名</p> |\n| mobile | `Number` | <p>手机号</p> |\n| status | `Number` | <p>状态</p> |\n\n### 返回信息\n\n#### 状态码 - `200`\n\n| Name     | Type       | Description                           |\n|----------|------------|---------------------------------------|\n| name | `type` | <p>description</p> |\n\n## <a name=\'添加管理员前\'></a> 添加管理员前\n\n```\nGET admin/addBefore\n```\n\n### Headers - `Header`\n\n| Name    | Type      | Description                          |\n|---------|-----------|--------------------------------------|\n| rttoken | `string` | <p>必填</p> |\n\n### 请求参数 - `Parameter`\n\n| Name     | Type       | Description                           |\n|----------|------------|---------------------------------------|\n| null |  |  |\n\n### 返回信息\n\n#### 状态码 - `200`\n\n| Name     | Type       | Description                           |\n|----------|------------|---------------------------------------|\n| name | `type` | <p>description</p> |\n\n',
    0
  );
INSERT INTO
  `rt_doc_cate` (
    `id`,
    `did`,
    `type`,
    `add_time`,
    `update_time`,
    `user_id`,
    `pid`,
    `name`,
    `title`,
    `content`,
    `order_num`
  )
VALUES
  (
    42,
    1,
    1,
    1638529126,
    1638529126,
    1,
    30,
    'logs',
    '日志管理',
    '<a name=\"top\"></a>\n# <a name=\'logs\'></a> logs\n\n## <a name=\'操作日志列表\'></a> 操作日志列表\n\n```\nGET logs/op\n```\n\n### Headers - `Header`\n\n| Name    | Type      | Description                          |\n|---------|-----------|--------------------------------------|\n| rttoken | `string` | <p>必填</p> |\n\n### 请求参数 - `Parameter`\n\n| Name     | Type       | Description                           |\n|----------|------------|---------------------------------------|\n| page | `number` | <p>页码</p> |\n| limit | `number` | <p>每页显示数据</p> |\n\n### 返回信息\n\n#### 状态码 - `200`\n\n| Name     | Type       | Description                           |\n|----------|------------|---------------------------------------|\n| name | `type` | <p>description</p> |\n\n## <a name=\'错误日志列表\'></a> 错误日志列表\n\n```\nGET logs/err\n```\n\n### Headers - `Header`\n\n| Name    | Type      | Description                          |\n|---------|-----------|--------------------------------------|\n| rttoken | `string` | <p>必填</p> |\n\n### 请求参数 - `Parameter`\n\n| Name     | Type       | Description                           |\n|----------|------------|---------------------------------------|\n| page | `number` | <p>页码</p> |\n| limit | `number` | <p>每页显示数据</p> |\n\n### 返回信息\n\n#### 状态码 - `200`\n\n| Name     | Type       | Description                           |\n|----------|------------|---------------------------------------|\n| name | `type` | <p>description</p> |\n\n## <a name=\'行为日志列表\'></a> 行为日志列表\n\n```\nGET logs/view\n```\n\n### Headers - `Header`\n\n| Name    | Type      | Description                          |\n|---------|-----------|--------------------------------------|\n| rttoken | `string` | <p>必填</p> |\n\n### 请求参数 - `Parameter`\n\n| Name     | Type       | Description                           |\n|----------|------------|---------------------------------------|\n| page | `number` | <p>页码</p> |\n| limit | `number` | <p>每页显示数据</p> |\n\n### 返回信息\n\n#### 状态码 - `200`\n\n| Name     | Type       | Description                           |\n|----------|------------|---------------------------------------|\n| name | `type` | <p>description</p> |\n\n',
    0
  );
INSERT INTO
  `rt_doc_cate` (
    `id`,
    `did`,
    `type`,
    `add_time`,
    `update_time`,
    `user_id`,
    `pid`,
    `name`,
    `title`,
    `content`,
    `order_num`
  )
VALUES
  (
    43,
    1,
    1,
    1638529126,
    1638529126,
    1,
    30,
    'set',
    '系统配置管理',
    '<a name=\"top\"></a>\n# <a name=\'set\'></a> set\n\n## <a name=\'设置是否可用\'></a> 设置是否可用\n\n```\nPOST set/enable\n```\n\n### Headers - `Header`\n\n| Name    | Type      | Description                          |\n|---------|-----------|--------------------------------------|\n| rttoken | `string` | <p>必填</p> |\n\n### 请求参数 - `Parameter`\n\n| Name     | Type       | Description                           |\n|----------|------------|---------------------------------------|\n| status | `number` | <p>状态</p> |\n| id | `number` |  |\n\n### 返回信息\n\n#### 状态码 - `200`\n\n| Name     | Type       | Description                           |\n|----------|------------|---------------------------------------|\n| name | `type` | <p>description</p> |\n\n## <a name=\'添加系统配置类目\'></a> 添加系统配置类目\n\n```\nGET set/cateAdd\n```\n\n### Headers - `Header`\n\n| Name    | Type      | Description                          |\n|---------|-----------|--------------------------------------|\n| rttoken | `string` | <p>必填</p> |\n\n### 请求参数 - `Parameter`\n\n| Name     | Type       | Description                           |\n|----------|------------|---------------------------------------|\n| key | `string` | <p>类目键值</p> |\n| name | `string` | <p>类目名</p> |\n\n### 返回信息\n\n#### 状态码 - `200`\n\n| Name     | Type       | Description                           |\n|----------|------------|---------------------------------------|\n| name | `type` | <p>description</p> |\n\n## <a name=\'系统配置类目列表\'></a> 系统配置类目列表\n\n```\nGET set/cate\n```\n\n### Headers - `Header`\n\n| Name    | Type      | Description                          |\n|---------|-----------|--------------------------------------|\n| rttoken | `string` | <p>必填</p> |\n\n### 请求参数 - `Parameter`\n\n| Name     | Type       | Description                           |\n|----------|------------|---------------------------------------|\n| page | `number` | <p>页码</p> |\n| limit | `number` | <p>每页显示数据</p> |\n\n### 返回信息\n\n#### 状态码 - `200`\n\n| Name     | Type       | Description                           |\n|----------|------------|---------------------------------------|\n| name | `type` | <p>description</p> |\n\n',
    0
  );
INSERT INTO
  `rt_doc_cate` (
    `id`,
    `did`,
    `type`,
    `add_time`,
    `update_time`,
    `user_id`,
    `pid`,
    `name`,
    `title`,
    `content`,
    `order_num`
  )
VALUES
  (
    44,
    1,
    1,
    1638529126,
    1638529126,
    1,
    30,
    'form',
    '表单设计器',
    '<a name=\"top\"></a>\n# <a name=\'form\'></a> form\n\n## <a name=\'表单列表\'></a> 表单列表\n\n```\nGET form/list\n```\n\n### Headers - `Header`\n\n| Name    | Type      | Description                          |\n|---------|-----------|--------------------------------------|\n| rttoken | `string` | <p>必填</p> |\n\n### 请求参数 - `Parameter`\n\n| Name     | Type       | Description                           |\n|----------|------------|---------------------------------------|\n| page | `number` | <p>页码</p> |\n| limit | `number` | <p>每页显示数据</p> |\n| param | `string` | <p>每页显示数据</p> |\n\n### 返回信息\n\n#### 状态码 - `200`\n\n| Name     | Type       | Description                           |\n|----------|------------|---------------------------------------|\n| name | `type` | <p>description</p> |\n\n## <a name=\'删除表单\'></a> 删除表单\n\n```\nPOST form/delete\n```\n\n### Headers - `Header`\n\n| Name    | Type      | Description                          |\n|---------|-----------|--------------------------------------|\n| rttoken | `string` | <p>必填</p> |\n\n### 请求参数 - `Parameter`\n\n| Name     | Type       | Description                           |\n|----------|------------|---------------------------------------|\n| id | `number` | <p>id</p> |\n\n### 返回信息\n\n#### 状态码 - `200`\n\n| Name     | Type       | Description                           |\n|----------|------------|---------------------------------------|\n| name | `type` | <p>description</p> |\n\n## <a name=\'添加表单\'></a> 添加表单\n\n```\nPOST form/add\n```\n\n### Headers - `Header`\n\n| Name    | Type      | Description                          |\n|---------|-----------|--------------------------------------|\n| rttoken | `string` | <p>必填</p> |\n\n### 请求参数 - `Parameter`\n\n| Name     | Type       | Description                           |\n|----------|------------|---------------------------------------|\n| id | `number` | <p>id</p> |\n\n### 返回信息\n\n#### 状态码 - `200`\n\n| Name     | Type       | Description                           |\n|----------|------------|---------------------------------------|\n| name | `type` | <p>description</p> |\n\n## <a name=\'添加事例\'></a> 添加事例\n\n```\nPOST form/add\n```\n\n### Headers - `Header`\n\n| Name    | Type      | Description                          |\n|---------|-----------|--------------------------------------|\n| rttoken | `string` | <p>必填</p> |\n\n### 请求参数 - `Parameter`\n\n| Name     | Type       | Description                           |\n|----------|------------|---------------------------------------|\n| id | `number` | <p>id</p> |\n\n### 返回信息\n\n#### 状态码 - `200`\n\n| Name     | Type       | Description                           |\n|----------|------------|---------------------------------------|\n| name | `type` | <p>description</p> |\n\n',
    0
  );
INSERT INTO
  `rt_doc_cate` (
    `id`,
    `did`,
    `type`,
    `add_time`,
    `update_time`,
    `user_id`,
    `pid`,
    `name`,
    `title`,
    `content`,
    `order_num`
  )
VALUES
  (
    45,
    1,
    1,
    1638529126,
    1638529126,
    1,
    30,
    'db',
    '数据库设计器',
    '<a name=\"top\"></a>\n# <a name=\'db\'></a> db\n\n## <a name=\'备份数据\'></a> 备份数据\n\n```\nGET db/backup\n```\n\n### Headers - `Header`\n\n| Name    | Type      | Description                          |\n|---------|-----------|--------------------------------------|\n| rttoken | `string` | <p>必填</p> |\n\n## <a name=\'查看文档\'></a> 查看文档\n\n```\nGET db/doc\n```\n\n### Headers - `Header`\n\n| Name    | Type      | Description                          |\n|---------|-----------|--------------------------------------|\n| rttoken | `string` | <p>必填</p> |\n\n## <a name=\'更新缓存\'></a> 更新缓存\n\n```\nGET db/update\n```\n\n### Headers - `Header`\n\n| Name    | Type      | Description                          |\n|---------|-----------|--------------------------------------|\n| rttoken | `string` | <p>必填</p> |\n\n## <a name=\'还原数据\'></a> 还原数据\n\n```\nGET db/reback\n```\n\n### Headers - `Header`\n\n| Name    | Type      | Description                          |\n|---------|-----------|--------------------------------------|\n| rttoken | `string` | <p>必填</p> |\n\n## <a name=\'列出备份数据文件\'></a> 列出备份数据文件\n\n```\nGET db/backupFile\n```\n\n### Headers - `Header`\n\n| Name    | Type      | Description                          |\n|---------|-----------|--------------------------------------|\n| rttoken | `string` | <p>必填</p> |\n\n## <a name=\'删除还原数据\'></a> 删除还原数据\n\n```\nGET db/delback\n```\n\n### Headers - `Header`\n\n| Name    | Type      | Description                          |\n|---------|-----------|--------------------------------------|\n| rttoken | `string` | <p>必填</p> |\n\n## <a name=\'数据列表\'></a> 数据列表\n\n```\nGET db/list\n```\n\n### Headers - `Header`\n\n| Name    | Type      | Description                          |\n|---------|-----------|--------------------------------------|\n| rttoken | `string` | <p>必填</p> |\n\n',
    0
  );
INSERT INTO
  `rt_doc_cate` (
    `id`,
    `did`,
    `type`,
    `add_time`,
    `update_time`,
    `user_id`,
    `pid`,
    `name`,
    `title`,
    `content`,
    `order_num`
  )
VALUES
  (
    46,
    1,
    1,
    1638529126,
    1638529126,
    1,
    31,
    'db',
    '数据库配置',
    '<a name=\"top\"></a>\n# <a name=\'db\'></a> db\n\n## <a name=\'备份数据\'></a> 备份数据\n\n```\nGET db/backup\n```\n\n### Headers - `Header`\n\n| Name    | Type      | Description                          |\n|---------|-----------|--------------------------------------|\n| rttoken | `string` | <p>必填</p> |\n\n## <a name=\'查看文档\'></a> 查看文档\n\n```\nGET db/doc\n```\n\n### Headers - `Header`\n\n| Name    | Type      | Description                          |\n|---------|-----------|--------------------------------------|\n| rttoken | `string` | <p>必填</p> |\n\n## <a name=\'更新缓存\'></a> 更新缓存\n\n```\nGET db/update\n```\n\n### Headers - `Header`\n\n| Name    | Type      | Description                          |\n|---------|-----------|--------------------------------------|\n| rttoken | `string` | <p>必填</p> |\n\n## <a name=\'还原数据\'></a> 还原数据\n\n```\nGET db/reback\n```\n\n### Headers - `Header`\n\n| Name    | Type      | Description                          |\n|---------|-----------|--------------------------------------|\n| rttoken | `string` | <p>必填</p> |\n\n## <a name=\'列出备份数据文件\'></a> 列出备份数据文件\n\n```\nGET db/backupFile\n```\n\n### Headers - `Header`\n\n| Name    | Type      | Description                          |\n|---------|-----------|--------------------------------------|\n| rttoken | `string` | <p>必填</p> |\n\n## <a name=\'删除还原数据\'></a> 删除还原数据\n\n```\nGET db/delback\n```\n\n### Headers - `Header`\n\n| Name    | Type      | Description                          |\n|---------|-----------|--------------------------------------|\n| rttoken | `string` | <p>必填</p> |\n\n## <a name=\'数据列表\'></a> 数据列表\n\n```\nGET db/list\n```\n\n### Headers - `Header`\n\n| Name    | Type      | Description                          |\n|---------|-----------|--------------------------------------|\n| rttoken | `string` | <p>必填</p> |\n\n',
    0
  );
INSERT INTO
  `rt_doc_cate` (
    `id`,
    `did`,
    `type`,
    `add_time`,
    `update_time`,
    `user_id`,
    `pid`,
    `name`,
    `title`,
    `content`,
    `order_num`
  )
VALUES
  (
    47,
    1,
    1,
    1638529126,
    1638529126,
    1,
    31,
    'cron',
    '计划任务配置',
    '',
    0
  );
INSERT INTO
  `rt_doc_cate` (
    `id`,
    `did`,
    `type`,
    `add_time`,
    `update_time`,
    `user_id`,
    `pid`,
    `name`,
    `title`,
    `content`,
    `order_num`
  )
VALUES
  (
    48,
    1,
    1,
    1638581395,
    1638667571,
    1,
    29,
    'todo',
    'TODO',
    '## 数据库设计器\n\n&cross; 添加字段设置为null时，null做字符串塞入默认值了\n&cross; 数据库设计器sql查询的结果不好看，需要优化\n',
    1
  );

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: rt_error
# ------------------------------------------------------------


# ------------------------------------------------------------
# DATA DUMP FOR TABLE: rt_excel
# ------------------------------------------------------------


# ------------------------------------------------------------
# DATA DUMP FOR TABLE: rt_flow
# ------------------------------------------------------------

INSERT INTO
  `rt_flow` (
    `id`,
    `type`,
    `add_time`,
    `update_time`,
    `user_id`,
    `title`,
    `content`
  )
VALUES
  (
    1,
    1,
    1638420142,
    1638420441,
    1,
    'Drawing1.xml',
    '<mxGraphModel dx=\"428\" dy=\"478\" grid=\"1\" gridSize=\"10\" guides=\"1\" tooltips=\"1\" connect=\"1\" arrows=\"1\" fold=\"1\" page=\"1\" pageScale=\"1\" pageWidth=\"827\" pageHeight=\"1169\"><root><mxCell id=\"0\"/><mxCell id=\"1\" parent=\"0\"/><mxCell id=\"2\" value=\"\" style=\"whiteSpace=wrap;html=1;aspect=fixed;\" vertex=\"1\" parent=\"1\"><mxGeometry x=\"80\" y=\"180\" width=\"80\" height=\"80\" as=\"geometry\"/></mxCell><mxCell id=\"3\" value=\"\" style=\"edgeStyle=orthogonalEdgeStyle;rounded=0;orthogonalLoop=1;jettySize=auto;html=1;\" edge=\"1\" parent=\"1\" source=\"4\" target=\"5\"><mxGeometry relative=\"1\" as=\"geometry\"/></mxCell><mxCell id=\"4\" value=\"\" style=\"shape=trapezoid;perimeter=trapezoidPerimeter;whiteSpace=wrap;html=1;fixedSize=1;\" vertex=\"1\" parent=\"1\"><mxGeometry x=\"250\" y=\"120\" width=\"120\" height=\"60\" as=\"geometry\"/></mxCell><mxCell id=\"5\" value=\"\" style=\"shape=trapezoid;perimeter=trapezoidPerimeter;whiteSpace=wrap;html=1;fixedSize=1;\" vertex=\"1\" parent=\"1\"><mxGeometry x=\"250\" y=\"260\" width=\"120\" height=\"60\" as=\"geometry\"/></mxCell><mxCell id=\"6\" value=\"\" style=\"whiteSpace=wrap;html=1;aspect=fixed;\" vertex=\"1\" parent=\"1\"><mxGeometry x=\"90\" y=\"80\" width=\"80\" height=\"80\" as=\"geometry\"/></mxCell></root></mxGraphModel>'
  );
INSERT INTO
  `rt_flow` (
    `id`,
    `type`,
    `add_time`,
    `update_time`,
    `user_id`,
    `title`,
    `content`
  )
VALUES
  (
    2,
    2,
    1638420470,
    1638420470,
    1,
    'My Diagram',
    '<mxGraphModel><root><Diagram label=\"My Diagram\" href=\"http://www.jgraph.com/\" id=\"0\"><mxCell/></Diagram><Layer label=\"Default Layer\" id=\"1\"><mxCell parent=\"0\"/></Layer><Container label=\"Container\" href=\"\" id=\"2\"><mxCell style=\"swimlane\" vertex=\"1\" connectable=\"0\" parent=\"1\"><mxGeometry x=\"140\" y=\"100\" width=\"200\" height=\"200\" as=\"geometry\"/></mxCell></Container><Roundrect label=\"Rounded\" href=\"\" id=\"3\"><mxCell style=\"rounded\" vertex=\"1\" parent=\"2\"><mxGeometry x=\"50\" y=\"50\" width=\"80\" height=\"40\" as=\"geometry\"/></mxCell></Roundrect></root></mxGraphModel>'
  );
INSERT INTO
  `rt_flow` (
    `id`,
    `type`,
    `add_time`,
    `update_time`,
    `user_id`,
    `title`,
    `content`
  )
VALUES
  (
    3,
    3,
    1638421050,
    1638421050,
    1,
    'MyWorkflow',
    '<mxGraphModel><root><Workflow label=\"MyWorkflow\" id=\"0\"><mxCell/></Workflow><Layer label=\"Default Layer\" id=\"1\"><mxCell parent=\"0\"/></Layer><Swimlane label=\"Role\" customAttribute=\"text value\" id=\"2\"><mxCell style=\"swimlane;fillColor=#83027F\" vertex=\"1\" connectable=\"0\" parent=\"1\"><mxGeometry x=\"20\" y=\"20\" width=\"220\" height=\"480\" as=\"geometry\"/></mxCell></Swimlane><Task label=\"Task\" id=\"3\"><mxCell vertex=\"1\" parent=\"2\"><mxGeometry x=\"70\" y=\"80\" width=\"80\" height=\"30\" as=\"geometry\"/></mxCell></Task></root></mxGraphModel>'
  );
INSERT INTO
  `rt_flow` (
    `id`,
    `type`,
    `add_time`,
    `update_time`,
    `user_id`,
    `title`,
    `content`
  )
VALUES
  (
    4,
    4,
    1638421070,
    1638421070,
    1,
    'MyWorkflow',
    '<mxGraphModel><root><Workflow label=\"MyWorkflow\" description=\"\" href=\"\" id=\"0\"><mxCell/></Workflow><Layer label=\"Default Layer\" id=\"1\"><mxCell parent=\"0\"/></Layer><Swimlane label=\"Swimlane\" description=\"\" href=\"\" id=\"2\"><mxCell style=\"swimlane;fillColor=#83027F\" vertex=\"1\" connectable=\"0\" parent=\"1\"><mxGeometry x=\"160\" y=\"130\" width=\"300\" height=\"160\" as=\"geometry\"/></mxCell></Swimlane><Symbol label=\"Symbol\" description=\"\" href=\"\" id=\"3\"><mxCell style=\"symbol;image=images/symbols/event_intermediate.png\" vertex=\"1\" parent=\"2\"><mxGeometry x=\"80\" y=\"90\" width=\"32\" height=\"32\" as=\"geometry\"/></mxCell></Symbol><Symbol label=\"Symbol\" description=\"\" href=\"\" id=\"4\"><mxCell style=\"symbol;image=images/symbols/event_end.png\" vertex=\"1\" parent=\"2\"><mxGeometry x=\"200\" y=\"110\" width=\"32\" height=\"32\" as=\"geometry\"/></mxCell></Symbol></root></mxGraphModel>'
  );
INSERT INTO
  `rt_flow` (
    `id`,
    `type`,
    `add_time`,
    `update_time`,
    `user_id`,
    `title`,
    `content`
  )
VALUES
  (
    5,
    1,
    1638421331,
    1638421331,
    1,
    'Drawing1',
    '<mxGraphModel dx=\"428\" dy=\"478\" grid=\"1\" gridSize=\"10\" guides=\"1\" tooltips=\"1\" connect=\"1\" arrows=\"1\" fold=\"1\" page=\"1\" pageScale=\"1\" pageWidth=\"827\" pageHeight=\"1169\"><root><mxCell id=\"0\"/><mxCell id=\"1\" parent=\"0\"/><mxCell id=\"2\" value=\"\" style=\"rounded=0;whiteSpace=wrap;html=1;\" vertex=\"1\" parent=\"1\"><mxGeometry x=\"140\" y=\"120\" width=\"120\" height=\"60\" as=\"geometry\"/></mxCell><mxCell id=\"3\" value=\"\" style=\"shape=trapezoid;perimeter=trapezoidPerimeter;whiteSpace=wrap;html=1;fixedSize=1;\" vertex=\"1\" parent=\"1\"><mxGeometry x=\"170\" y=\"230\" width=\"120\" height=\"60\" as=\"geometry\"/></mxCell></root></mxGraphModel>'
  );
INSERT INTO
  `rt_flow` (
    `id`,
    `type`,
    `add_time`,
    `update_time`,
    `user_id`,
    `title`,
    `content`
  )
VALUES
  (
    6,
    2,
    1639703903,
    1639703906,
    1,
    'My Diagram',
    '<mxGraphModel><root><Diagram label=\"My Diagram\" href=\"http://www.jgraph.com/\" id=\"0\"><mxCell/></Diagram><Layer label=\"Default Layer\" id=\"1\"><mxCell parent=\"0\"/></Layer><Roundrect label=\"Rounded\" href=\"\" id=\"2\"><mxCell style=\"rounded\" vertex=\"1\" parent=\"1\"><mxGeometry x=\"190\" y=\"70\" width=\"80\" height=\"40\" as=\"geometry\"/></mxCell></Roundrect></root></mxGraphModel>'
  );
INSERT INTO
  `rt_flow` (
    `id`,
    `type`,
    `add_time`,
    `update_time`,
    `user_id`,
    `title`,
    `content`
  )
VALUES
  (
    7,
    4,
    1640230489,
    1640230506,
    1,
    '测试',
    '<mxGraphModel><root><Workflow label=\"测试\" description=\"\" href=\"\" id=\"0\"><mxCell/></Workflow><Layer label=\"Default Layer\" id=\"1\"><mxCell parent=\"0\"/></Layer><Swimlane label=\"Swimlane\" description=\"\" href=\"\" id=\"2\"><mxCell style=\"swimlane;fillColor=#83027F\" vertex=\"1\" connectable=\"0\" parent=\"1\"><mxGeometry x=\"310\" y=\"130\" width=\"300\" height=\"160\" as=\"geometry\"/></mxCell></Swimlane></root></mxGraphModel>'
  );
INSERT INTO
  `rt_flow` (
    `id`,
    `type`,
    `add_time`,
    `update_time`,
    `user_id`,
    `title`,
    `content`
  )
VALUES
  (
    8,
    5,
    1640238100,
    1640238696,
    1,
    'false',
    '{\n\t\"version\": \"2.0\",\n\t\"scale\": 1,\n\t\"tx\": 389.5,\n\t\"ty\": 326\n}'
  );
INSERT INTO
  `rt_flow` (
    `id`,
    `type`,
    `add_time`,
    `update_time`,
    `user_id`,
    `title`,
    `content`
  )
VALUES
  (
    9,
    5,
    1640238180,
    1640238764,
    1,
    '6666',
    '{\n\t\"version\": \"2.0\",\n\t\"datas\": [\n\t\t{\n\t\t\t\"_className\": \"Q.Node\",\n\t\t\t\"json\": {\n\t\t\t\t\"enableSubNetwork\": true,\n\t\t\t\t\"name\": \"SubNetwork\",\n\t\t\t\t\"location\": {\n\t\t\t\t\t\"x\": -40,\n\t\t\t\t\t\"y\": -60\n\t\t\t\t},\n\t\t\t\t\"image\": \"Q-subnetwork\"\n\t\t\t}\n\t\t},\n\t\t{\n\t\t\t\"_className\": \"Q.Text\",\n\t\t\t\"json\": {\n\t\t\t\t\"name\": \"Text\",\n\t\t\t\t\"styles\": {\n\t\t\t\t\t\"label.background.color\": \"#2898E0\",\n\t\t\t\t\t\"label.color\": \"#FFF\",\n\t\t\t\t\t\"label.padding\": {\n\t\t\t\t\t\t\"_className\": \"Q.Insets\",\n\t\t\t\t\t\t\"json\": {\n\t\t\t\t\t\t\t\"top\": 0,\n\t\t\t\t\t\t\t\"left\": 0,\n\t\t\t\t\t\t\t\"bottom\": 0,\n\t\t\t\t\t\t\t\"right\": 0,\n\t\t\t\t\t\t\t\"_className\": \"Q.Insets\",\n\t\t\t\t\t\t\t\"json\": {\n\t\t\t\t\t\t\t\t\"top\": 3,\n\t\t\t\t\t\t\t\t\"left\": 5,\n\t\t\t\t\t\t\t\t\"bottom\": 3,\n\t\t\t\t\t\t\t\t\"right\": 5\n\t\t\t\t\t\t\t}\n\t\t\t\t\t\t}\n\t\t\t\t\t}\n\t\t\t\t},\n\t\t\t\t\"location\": {\n\t\t\t\t\t\"x\": -170,\n\t\t\t\t\t\"y\": -180\n\t\t\t\t}\n\t\t\t}\n\t\t},\n\t\t{\n\t\t\t\"_className\": \"Q.Group\",\n\t\t\t\"json\": {\n\t\t\t\t\"name\": \"Group\",\n\t\t\t\t\"location\": {\n\t\t\t\t\t\"x\": -170,\n\t\t\t\t\t\"y\": 40\n\t\t\t\t},\n\t\t\t\t\"image\": \"Q-group\",\n\t\t\t\t\"minSize\": {\n\t\t\t\t\t\"width\": 100,\n\t\t\t\t\t\"height\": 100,\n\t\t\t\t\t\"x\": 0,\n\t\t\t\t\t\"y\": 0\n\t\t\t\t}\n\t\t\t}\n\t\t},\n\t\t{\n\t\t\t\"_className\": \"Q.Node\",\n\t\t\t\"json\": {\n\t\t\t\t\"location\": {\n\t\t\t\t\t\"x\": -170,\n\t\t\t\t\t\"y\": -80\n\t\t\t\t},\n\t\t\t\t\"image\": \"Q-exchanger2\"\n\t\t\t}\n\t\t},\n\t\t{\n\t\t\t\"_className\": \"Q.Node\",\n\t\t\t\"json\": {\n\t\t\t\t\"name\": \"Message\",\n\t\t\t\t\"styles\": {\n\t\t\t\t\t\"shape.fill.color\": \"#FF0\",\n\t\t\t\t\t\"shape.stroke\": 0.5,\n\t\t\t\t\t\"shape.stroke.style\": \"#CCC\",\n\t\t\t\t\t\"label.background.color\": \"#FF0\",\n\t\t\t\t\t\"label.size\": {\n\t\t\t\t\t\t\"width\": 100,\n\t\t\t\t\t\t\"height\": 20\n\t\t\t\t\t},\n\t\t\t\t\t\"label.padding\": 5,\n\t\t\t\t\t\"label.offset.y\": -10,\n\t\t\t\t\t\"shape.fill.gradient\": {\n\t\t\t\t\t\t\"_className\": \"Q.Gradient\",\n\t\t\t\t\t\t\"json\": {\n\t\t\t\t\t\t\t\"_className\": \"Q.Gradient\",\n\t\t\t\t\t\t\t\"json\": {\n\t\t\t\t\t\t\t\t\"type\": \"r\",\n\t\t\t\t\t\t\t\t\"colors\": [\n\t\t\t\t\t\t\t\t\t\"rgba(255,255,255,0.67)\",\n\t\t\t\t\t\t\t\t\t\"rgba(238,238,238,0.20)\",\n\t\t\t\t\t\t\t\t\t\"rgba(136,136,136,0.27)\",\n\t\t\t\t\t\t\t\t\t\"rgba(102,102,102,0.20)\"\n\t\t\t\t\t\t\t\t],\n\t\t\t\t\t\t\t\t\"positions\": [\n\t\t\t\t\t\t\t\t\t0.1,\n\t\t\t\t\t\t\t\t\t0.3,\n\t\t\t\t\t\t\t\t\t0.7,\n\t\t\t\t\t\t\t\t\t0.9\n\t\t\t\t\t\t\t\t],\n\t\t\t\t\t\t\t\t\"angle\": 0,\n\t\t\t\t\t\t\t\t\"tx\": -0.2,\n\t\t\t\t\t\t\t\t\"ty\": -0.2\n\t\t\t\t\t\t\t}\n\t\t\t\t\t\t}\n\t\t\t\t\t},\n\t\t\t\t\t\"label.position\": \"ct\",\n\t\t\t\t\t\"label.anchor.position\": \"lb\"\n\t\t\t\t},\n\t\t\t\t\"location\": {\n\t\t\t\t\t\"x\": -250,\n\t\t\t\t\t\"y\": -10\n\t\t\t\t},\n\t\t\t\t\"image\": \"lamp\"\n\t\t\t}\n\t\t}\n\t],\n\t\"scale\": 1,\n\t\"tx\": 389.5,\n\t\"ty\": 326\n}'
  );
INSERT INTO
  `rt_flow` (
    `id`,
    `type`,
    `add_time`,
    `update_time`,
    `user_id`,
    `title`,
    `content`
  )
VALUES
  (
    10,
    5,
    1640238351,
    1640238360,
    1,
    'qqq',
    '{\n\t\"version\": \"2.0\",\n\t\"datas\": [\n\t\t{\n\t\t\t\"_className\": \"Q.Node\",\n\t\t\t\"json\": {\n\t\t\t\t\"name\": \"Node\",\n\t\t\t\t\"location\": {\n\t\t\t\t\t\"x\": -180,\n\t\t\t\t\t\"y\": -230\n\t\t\t\t}\n\t\t\t}\n\t\t}\n\t],\n\t\"scale\": 1,\n\t\"tx\": 389.5,\n\t\"ty\": 350.5\n}'
  );
INSERT INTO
  `rt_flow` (
    `id`,
    `type`,
    `add_time`,
    `update_time`,
    `user_id`,
    `title`,
    `content`
  )
VALUES
  (
    11,
    5,
    1640238901,
    1640238924,
    1,
    '5555',
    '{\n\t\"version\": \"2.0\",\n\t\"datas\": [\n\t\t{\n\t\t\t\"_className\": \"Q.Node\",\n\t\t\t\"json\": {\n\t\t\t\t\"name\": \"Node\",\n\t\t\t\t\"location\": {\n\t\t\t\t\t\"x\": -40,\n\t\t\t\t\t\"y\": -120\n\t\t\t\t}\n\t\t\t}\n\t\t},\n\t\t{\n\t\t\t\"_className\": \"Q.Node\",\n\t\t\t\"json\": {\n\t\t\t\t\"name\": \"Message\",\n\t\t\t\t\"styles\": {\n\t\t\t\t\t\"shape.fill.color\": \"#FF0\",\n\t\t\t\t\t\"shape.stroke\": 0.5,\n\t\t\t\t\t\"shape.stroke.style\": \"#CCC\",\n\t\t\t\t\t\"label.background.color\": \"#FF0\",\n\t\t\t\t\t\"label.size\": {\n\t\t\t\t\t\t\"width\": 100,\n\t\t\t\t\t\t\"height\": 20\n\t\t\t\t\t},\n\t\t\t\t\t\"label.padding\": 5,\n\t\t\t\t\t\"label.offset.y\": -10,\n\t\t\t\t\t\"shape.fill.gradient\": {\n\t\t\t\t\t\t\"_className\": \"Q.Gradient\",\n\t\t\t\t\t\t\"json\": {\n\t\t\t\t\t\t\t\"_className\": \"Q.Gradient\",\n\t\t\t\t\t\t\t\"json\": {\n\t\t\t\t\t\t\t\t\"type\": \"r\",\n\t\t\t\t\t\t\t\t\"colors\": [\n\t\t\t\t\t\t\t\t\t\"rgba(255,255,255,0.67)\",\n\t\t\t\t\t\t\t\t\t\"rgba(238,238,238,0.20)\",\n\t\t\t\t\t\t\t\t\t\"rgba(136,136,136,0.27)\",\n\t\t\t\t\t\t\t\t\t\"rgba(102,102,102,0.20)\"\n\t\t\t\t\t\t\t\t],\n\t\t\t\t\t\t\t\t\"positions\": [\n\t\t\t\t\t\t\t\t\t0.1,\n\t\t\t\t\t\t\t\t\t0.3,\n\t\t\t\t\t\t\t\t\t0.7,\n\t\t\t\t\t\t\t\t\t0.9\n\t\t\t\t\t\t\t\t],\n\t\t\t\t\t\t\t\t\"angle\": 0,\n\t\t\t\t\t\t\t\t\"tx\": -0.2,\n\t\t\t\t\t\t\t\t\"ty\": -0.2\n\t\t\t\t\t\t\t}\n\t\t\t\t\t\t}\n\t\t\t\t\t},\n\t\t\t\t\t\"label.position\": \"ct\",\n\t\t\t\t\t\"label.anchor.position\": \"lb\"\n\t\t\t\t},\n\t\t\t\t\"location\": {\n\t\t\t\t\t\"x\": -60,\n\t\t\t\t\t\"y\": 20\n\t\t\t\t},\n\t\t\t\t\"image\": \"lamp\"\n\t\t\t}\n\t\t},\n\t\t{\n\t\t\t\"_className\": \"Q.Node\",\n\t\t\t\"json\": {\n\t\t\t\t\"location\": {\n\t\t\t\t\t\"x\": -270,\n\t\t\t\t\t\"y\": -20\n\t\t\t\t},\n\t\t\t\t\"image\": \"roundrect\"\n\t\t\t}\n\t\t},\n\t\t{\n\t\t\t\"_className\": \"Q.Node\",\n\t\t\t\"json\": {\n\t\t\t\t\"location\": {\n\t\t\t\t\t\"x\": -200,\n\t\t\t\t\t\"y\": -110\n\t\t\t\t},\n\t\t\t\t\"image\": \"oval\"\n\t\t\t}\n\t\t}\n\t],\n\t\"scale\": 1,\n\t\"tx\": 424.5,\n\t\"ty\": 288\n}'
  );
INSERT INTO
  `rt_flow` (
    `id`,
    `type`,
    `add_time`,
    `update_time`,
    `user_id`,
    `title`,
    `content`
  )
VALUES
  (
    12,
    1,
    1641434087,
    1641434087,
    1,
    'Drawing1',
    '<mxGraphModel dx=\"441\" dy=\"506\" grid=\"1\" gridSize=\"10\" guides=\"1\" tooltips=\"1\" connect=\"1\" arrows=\"1\" fold=\"1\" page=\"1\" pageScale=\"1\" pageWidth=\"827\" pageHeight=\"1169\"><root><mxCell id=\"0\"/><mxCell id=\"1\" parent=\"0\"/><mxCell id=\"2\" value=\"\" style=\"whiteSpace=wrap;html=1;aspect=fixed;\" vertex=\"1\" parent=\"1\"><mxGeometry x=\"200\" y=\"230\" width=\"80\" height=\"80\" as=\"geometry\"/></mxCell></root></mxGraphModel>'
  );

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: rt_form
# ------------------------------------------------------------

INSERT INTO
  `rt_form` (
    `id`,
    `name`,
    `key`,
    `data`,
    `get_url`,
    `post_url`,
    `form_path`,
    `add_time`,
    `link_id`,
    `link_name`,
    `link_field`,
    `params_get`,
    `params_post`
  )
VALUES
  (
    9,
    'mysql',
    'mysql',
    '[{\"id\":\"host\",\"index\":0,\"label\":\"数据库地址\",\"tag\":\"input\",\"tagIcon\":\"input\",\"placeholder\":\"请输入数据库地址\",\"defaultValue\":null,\"labelWidth\":125,\"width\":\"100%\",\"clearable\":true,\"maxlength\":null,\"showWordLimit\":false,\"readonly\":false,\"disabled\":false,\"required\":true,\"expression\":\"\",\"document\":\"\"},{\"id\":\"port\",\"index\":1,\"label\":\"端口号\",\"tag\":\"input\",\"tagIcon\":\"input\",\"placeholder\":\"请输入端口号\",\"defaultValue\":\"3306\",\"labelWidth\":125,\"width\":\"100%\",\"clearable\":true,\"maxlength\":null,\"showWordLimit\":false,\"readonly\":false,\"disabled\":false,\"required\":true,\"expression\":\"number\",\"document\":\"\"},{\"id\":\"input_2\",\"index\":2,\"label\":\"单行文本\",\"tag\":\"input\",\"tagIcon\":\"input\",\"placeholder\":\"请输入\",\"defaultValue\":null,\"labelWidth\":110,\"width\":\"100%\",\"clearable\":true,\"maxlength\":null,\"showWordLimit\":false,\"readonly\":false,\"disabled\":false,\"required\":true,\"expression\":\"\",\"document\":\"\"},{\"id\":\"textarea_1\",\"index\":3,\"label\":\"多行文本\",\"tag\":\"textarea\",\"tagIcon\":\"textarea\",\"placeholder\":\"请输入\",\"defaultValue\":null,\"width\":\"100%\",\"readonly\":false,\"disabled\":false,\"required\":true,\"document\":\"\"}]',
    'set/setBefore',
    'set/setConf',
    'set/config/mysql',
    0,
    9,
    'set',
    'id',
    'conftype|mysql',
    'conftype|mysql'
  );
INSERT INTO
  `rt_form` (
    `id`,
    `name`,
    `key`,
    `data`,
    `get_url`,
    `post_url`,
    `form_path`,
    `add_time`,
    `link_id`,
    `link_name`,
    `link_field`,
    `params_get`,
    `params_post`
  )
VALUES
  (10, 'test', '测试', '[]', '', '', '', 0, 0, '0', NULL, '', '');
INSERT INTO
  `rt_form` (
    `id`,
    `name`,
    `key`,
    `data`,
    `get_url`,
    `post_url`,
    `form_path`,
    `add_time`,
    `link_id`,
    `link_name`,
    `link_field`,
    `params_get`,
    `params_post`
  )
VALUES
  (
    11,
    'redis',
    'redis',
    '[]',
    'set/setBefore',
    'set/setConf',
    'set/config/redis',
    0,
    10,
    'set',
    'id',
    'conftype|redis',
    'conftype|redis'
  );

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: rt_gant
# ------------------------------------------------------------

INSERT INTO
  `rt_gant` (
    `id`,
    `add_time`,
    `update_time`,
    `user_id`,
    `title`,
    `content`
  )
VALUES
  (
    1,
    0,
    0,
    0,
    'XXX项目23',
    '{\n\t\"tasks\": [\n\t\t{\n\t\t\t\"id\": -1,\n\t\t\t\"name\": \"XXX项目23\",\n\t\t\t\"progress\": 0,\n\t\t\t\"progressByWorklog\": false,\n\t\t\t\"relevance\": 0,\n\t\t\t\"type\": \"\",\n\t\t\t\"typeId\": \"\",\n\t\t\t\"description\": \"\",\n\t\t\t\"code\": \"10001\",\n\t\t\t\"level\": 0,\n\t\t\t\"status\": \"STATUS_ACTIVE\",\n\t\t\t\"depends\": \"\",\n\t\t\t\"start\": 1639497600000,\n\t\t\t\"duration\": 31,\n\t\t\t\"end\": 1643212799999,\n\t\t\t\"startIsMilestone\": false,\n\t\t\t\"endIsMilestone\": false,\n\t\t\t\"collapsed\": false,\n\t\t\t\"canWrite\": true,\n\t\t\t\"canAdd\": true,\n\t\t\t\"canDelete\": true,\n\t\t\t\"canAddIssue\": true,\n\t\t\t\"assigs\": [],\n\t\t\t\"hasChild\": true\n\t\t},\n\t\t{\n\t\t\t\"id\": \"tmp_fk1639475600597_1\",\n\t\t\t\"name\": \"ttt\",\n\t\t\t\"progress\": 0,\n\t\t\t\"progressByWorklog\": false,\n\t\t\t\"relevance\": 0,\n\t\t\t\"type\": \"\",\n\t\t\t\"typeId\": \"\",\n\t\t\t\"description\": \"\",\n\t\t\t\"code\": \"\",\n\t\t\t\"level\": 1,\n\t\t\t\"status\": \"STATUS_ACTIVE\",\n\t\t\t\"depends\": \"\",\n\t\t\t\"start\": 1639497600000,\n\t\t\t\"duration\": 1,\n\t\t\t\"end\": 1639583999999,\n\t\t\t\"startIsMilestone\": true,\n\t\t\t\"endIsMilestone\": false,\n\t\t\t\"collapsed\": false,\n\t\t\t\"canWrite\": true,\n\t\t\t\"canAdd\": true,\n\t\t\t\"canDelete\": true,\n\t\t\t\"canAddIssue\": true,\n\t\t\t\"assigs\": []\n\t\t}\n\t],\n\t\"selectedRow\": 0,\n\t\"deletedTaskIds\": [],\n\t\"resources\": [\n\t\t{\n\t\t\t\"id\": \"tmp_1\",\n\t\t\t\"name\": \"一号员工\"\n\t\t},\n\t\t{\n\t\t\t\"id\": \"tmp_2\",\n\t\t\t\"name\": \"二号员工\"\n\t\t},\n\t\t{\n\t\t\t\"id\": \"tmp_3\",\n\t\t\t\"name\": \"三号员工\"\n\t\t},\n\t\t{\n\t\t\t\"id\": \"tmp_4\",\n\t\t\t\"name\": \"四号员工\"\n\t\t}\n\t],\n\t\"roles\": [\n\t\t{\n\t\t\t\"id\": \"tmp_1\",\n\t\t\t\"name\": \"客户\"\n\t\t},\n\t\t{\n\t\t\t\"id\": \"tmp_2\",\n\t\t\t\"name\": \"开发人员\"\n\t\t},\n\t\t{\n\t\t\t\"id\": \"tmp_3\",\n\t\t\t\"name\": \"测试人员\"\n\t\t},\n\t\t{\n\t\t\t\"id\": \"tmp_4\",\n\t\t\t\"name\": \"项目经理\"\n\t\t}\n\t],\n\t\"canAdd\": true,\n\t\"canWrite\": true,\n\t\"canWriteOnParent\": true,\n\t\"zoom\": \"1M\"\n}'
  );
INSERT INTO
  `rt_gant` (
    `id`,
    `add_time`,
    `update_time`,
    `user_id`,
    `title`,
    `content`
  )
VALUES
  (
    2,
    0,
    0,
    0,
    'XXX项目23',
    '{\n\t\"tasks\": [\n\t\t{\n\t\t\t\"id\": -1,\n\t\t\t\"name\": \"XXX项目23\",\n\t\t\t\"progress\": 0,\n\t\t\t\"progressByWorklog\": false,\n\t\t\t\"relevance\": 0,\n\t\t\t\"type\": \"\",\n\t\t\t\"typeId\": \"\",\n\t\t\t\"description\": \"\",\n\t\t\t\"code\": \"10001\",\n\t\t\t\"level\": 0,\n\t\t\t\"status\": \"STATUS_ACTIVE\",\n\t\t\t\"depends\": \"\",\n\t\t\t\"start\": 1639497600000,\n\t\t\t\"duration\": 31,\n\t\t\t\"end\": 1643212799999,\n\t\t\t\"startIsMilestone\": false,\n\t\t\t\"endIsMilestone\": false,\n\t\t\t\"collapsed\": false,\n\t\t\t\"canWrite\": true,\n\t\t\t\"canAdd\": true,\n\t\t\t\"canDelete\": true,\n\t\t\t\"canAddIssue\": true,\n\t\t\t\"assigs\": [],\n\t\t\t\"hasChild\": true\n\t\t},\n\t\t{\n\t\t\t\"id\": \"tmp_fk1639475600597_1\",\n\t\t\t\"name\": \"ttt\",\n\t\t\t\"progress\": 0,\n\t\t\t\"progressByWorklog\": false,\n\t\t\t\"relevance\": 0,\n\t\t\t\"type\": \"\",\n\t\t\t\"typeId\": \"\",\n\t\t\t\"description\": \"\",\n\t\t\t\"code\": \"\",\n\t\t\t\"level\": 1,\n\t\t\t\"status\": \"STATUS_ACTIVE\",\n\t\t\t\"depends\": \"\",\n\t\t\t\"start\": 1639497600000,\n\t\t\t\"duration\": 1,\n\t\t\t\"end\": 1639583999999,\n\t\t\t\"startIsMilestone\": true,\n\t\t\t\"endIsMilestone\": false,\n\t\t\t\"collapsed\": false,\n\t\t\t\"canWrite\": true,\n\t\t\t\"canAdd\": true,\n\t\t\t\"canDelete\": true,\n\t\t\t\"canAddIssue\": true,\n\t\t\t\"assigs\": []\n\t\t}\n\t],\n\t\"selectedRow\": 0,\n\t\"deletedTaskIds\": [],\n\t\"resources\": [\n\t\t{\n\t\t\t\"id\": \"tmp_1\",\n\t\t\t\"name\": \"一号员工\"\n\t\t},\n\t\t{\n\t\t\t\"id\": \"tmp_2\",\n\t\t\t\"name\": \"二号员工\"\n\t\t},\n\t\t{\n\t\t\t\"id\": \"tmp_3\",\n\t\t\t\"name\": \"三号员工\"\n\t\t},\n\t\t{\n\t\t\t\"id\": \"tmp_4\",\n\t\t\t\"name\": \"四号员工\"\n\t\t}\n\t],\n\t\"roles\": [\n\t\t{\n\t\t\t\"id\": \"tmp_1\",\n\t\t\t\"name\": \"客户\"\n\t\t},\n\t\t{\n\t\t\t\"id\": \"tmp_2\",\n\t\t\t\"name\": \"开发人员\"\n\t\t},\n\t\t{\n\t\t\t\"id\": \"tmp_3\",\n\t\t\t\"name\": \"测试人员\"\n\t\t},\n\t\t{\n\t\t\t\"id\": \"tmp_4\",\n\t\t\t\"name\": \"项目经理\"\n\t\t}\n\t],\n\t\"canAdd\": true,\n\t\"canWrite\": true,\n\t\"canWriteOnParent\": true,\n\t\"zoom\": \"1M\"\n}'
  );
INSERT INTO
  `rt_gant` (
    `id`,
    `add_time`,
    `update_time`,
    `user_id`,
    `title`,
    `content`
  )
VALUES
  (
    3,
    0,
    1639476259,
    0,
    'XXX项目232',
    '{\n\t\"tasks\": [\n\t\t{\n\t\t\t\"id\": -1,\n\t\t\t\"name\": \"XXX项目232\",\n\t\t\t\"progress\": 0,\n\t\t\t\"progressByWorklog\": false,\n\t\t\t\"relevance\": 0,\n\t\t\t\"type\": \"\",\n\t\t\t\"typeId\": \"\",\n\t\t\t\"description\": \"\",\n\t\t\t\"code\": \"10001\",\n\t\t\t\"level\": 0,\n\t\t\t\"status\": \"STATUS_ACTIVE\",\n\t\t\t\"depends\": \"\",\n\t\t\t\"start\": 1639497600000,\n\t\t\t\"duration\": 31,\n\t\t\t\"end\": 1643212799999,\n\t\t\t\"startIsMilestone\": false,\n\t\t\t\"endIsMilestone\": false,\n\t\t\t\"collapsed\": false,\n\t\t\t\"canWrite\": true,\n\t\t\t\"canAdd\": true,\n\t\t\t\"canDelete\": true,\n\t\t\t\"canAddIssue\": true,\n\t\t\t\"assigs\": [],\n\t\t\t\"hasChild\": true\n\t\t},\n\t\t{\n\t\t\t\"id\": \"tmp_fk1639475600597_1\",\n\t\t\t\"name\": \"ttt\",\n\t\t\t\"progress\": 0,\n\t\t\t\"progressByWorklog\": false,\n\t\t\t\"relevance\": 0,\n\t\t\t\"type\": \"\",\n\t\t\t\"typeId\": \"\",\n\t\t\t\"description\": \"\",\n\t\t\t\"code\": \"\",\n\t\t\t\"level\": 1,\n\t\t\t\"status\": \"STATUS_ACTIVE\",\n\t\t\t\"depends\": \"\",\n\t\t\t\"start\": 1639497600000,\n\t\t\t\"duration\": 1,\n\t\t\t\"end\": 1639583999999,\n\t\t\t\"startIsMilestone\": true,\n\t\t\t\"endIsMilestone\": false,\n\t\t\t\"collapsed\": false,\n\t\t\t\"canWrite\": true,\n\t\t\t\"canAdd\": true,\n\t\t\t\"canDelete\": true,\n\t\t\t\"canAddIssue\": true,\n\t\t\t\"assigs\": []\n\t\t}\n\t],\n\t\"selectedRow\": 0,\n\t\"deletedTaskIds\": [],\n\t\"resources\": [\n\t\t{\n\t\t\t\"id\": \"tmp_1\",\n\t\t\t\"name\": \"一号员工\"\n\t\t},\n\t\t{\n\t\t\t\"id\": \"tmp_2\",\n\t\t\t\"name\": \"二号员工\"\n\t\t},\n\t\t{\n\t\t\t\"id\": \"tmp_3\",\n\t\t\t\"name\": \"三号员工\"\n\t\t},\n\t\t{\n\t\t\t\"id\": \"tmp_4\",\n\t\t\t\"name\": \"四号员工\"\n\t\t}\n\t],\n\t\"roles\": [\n\t\t{\n\t\t\t\"id\": \"tmp_1\",\n\t\t\t\"name\": \"客户\"\n\t\t},\n\t\t{\n\t\t\t\"id\": \"tmp_2\",\n\t\t\t\"name\": \"开发人员\"\n\t\t},\n\t\t{\n\t\t\t\"id\": \"tmp_3\",\n\t\t\t\"name\": \"测试人员\"\n\t\t},\n\t\t{\n\t\t\t\"id\": \"tmp_4\",\n\t\t\t\"name\": \"项目经理\"\n\t\t}\n\t],\n\t\"canAdd\": true,\n\t\"canWrite\": true,\n\t\"canWriteOnParent\": true,\n\t\"zoom\": \"1M\"\n}'
  );
INSERT INTO
  `rt_gant` (
    `id`,
    `add_time`,
    `update_time`,
    `user_id`,
    `title`,
    `content`
  )
VALUES
  (
    4,
    1639476264,
    1639476323,
    0,
    'XXX项目1',
    '{\n\t\"tasks\": [\n\t\t{\n\t\t\t\"id\": -1,\n\t\t\t\"name\": \"XXX项目1\",\n\t\t\t\"progress\": 0,\n\t\t\t\"progressByWorklog\": false,\n\t\t\t\"relevance\": 0,\n\t\t\t\"type\": \"\",\n\t\t\t\"typeId\": \"\",\n\t\t\t\"description\": \"\",\n\t\t\t\"code\": \"10001\",\n\t\t\t\"level\": 0,\n\t\t\t\"status\": \"STATUS_ACTIVE\",\n\t\t\t\"depends\": \"\",\n\t\t\t\"start\": 1639497600000,\n\t\t\t\"duration\": 31,\n\t\t\t\"end\": 1643212799999,\n\t\t\t\"startIsMilestone\": false,\n\t\t\t\"endIsMilestone\": false,\n\t\t\t\"collapsed\": false,\n\t\t\t\"canWrite\": true,\n\t\t\t\"canAdd\": true,\n\t\t\t\"canDelete\": true,\n\t\t\t\"canAddIssue\": true,\n\t\t\t\"assigs\": [],\n\t\t\t\"hasChild\": true\n\t\t},\n\t\t{\n\t\t\t\"id\": \"tmp_fk1639475600597_1\",\n\t\t\t\"name\": \"ttt\",\n\t\t\t\"progress\": 0,\n\t\t\t\"progressByWorklog\": false,\n\t\t\t\"relevance\": 0,\n\t\t\t\"type\": \"\",\n\t\t\t\"typeId\": \"\",\n\t\t\t\"description\": \"\",\n\t\t\t\"code\": \"\",\n\t\t\t\"level\": 1,\n\t\t\t\"status\": \"STATUS_ACTIVE\",\n\t\t\t\"depends\": \"\",\n\t\t\t\"start\": 1639497600000,\n\t\t\t\"duration\": 1,\n\t\t\t\"end\": 1639583999999,\n\t\t\t\"startIsMilestone\": true,\n\t\t\t\"endIsMilestone\": false,\n\t\t\t\"collapsed\": false,\n\t\t\t\"canWrite\": true,\n\t\t\t\"canAdd\": true,\n\t\t\t\"canDelete\": true,\n\t\t\t\"canAddIssue\": true,\n\t\t\t\"assigs\": []\n\t\t}\n\t],\n\t\"selectedRow\": 0,\n\t\"deletedTaskIds\": [],\n\t\"resources\": [\n\t\t{\n\t\t\t\"id\": \"tmp_1\",\n\t\t\t\"name\": \"一号员工\"\n\t\t},\n\t\t{\n\t\t\t\"id\": \"tmp_2\",\n\t\t\t\"name\": \"二号员工\"\n\t\t},\n\t\t{\n\t\t\t\"id\": \"tmp_3\",\n\t\t\t\"name\": \"三号员工\"\n\t\t},\n\t\t{\n\t\t\t\"id\": \"tmp_4\",\n\t\t\t\"name\": \"四号员工\"\n\t\t}\n\t],\n\t\"roles\": [\n\t\t{\n\t\t\t\"id\": \"tmp_1\",\n\t\t\t\"name\": \"客户\"\n\t\t},\n\t\t{\n\t\t\t\"id\": \"tmp_2\",\n\t\t\t\"name\": \"开发人员\"\n\t\t},\n\t\t{\n\t\t\t\"id\": \"tmp_3\",\n\t\t\t\"name\": \"测试人员\"\n\t\t},\n\t\t{\n\t\t\t\"id\": \"tmp_4\",\n\t\t\t\"name\": \"项目经理\"\n\t\t}\n\t],\n\t\"canAdd\": true,\n\t\"canWrite\": true,\n\t\"canWriteOnParent\": true,\n\t\"zoom\": \"1M\"\n}'
  );
INSERT INTO
  `rt_gant` (
    `id`,
    `add_time`,
    `update_time`,
    `user_id`,
    `title`,
    `content`
  )
VALUES
  (
    5,
    1639476327,
    1639477012,
    0,
    'XXX项目12',
    '{\n\t\"tasks\": [\n\t\t{\n\t\t\t\"id\": -1,\n\t\t\t\"name\": \"XXX项目12\",\n\t\t\t\"progress\": 0,\n\t\t\t\"progressByWorklog\": false,\n\t\t\t\"relevance\": 0,\n\t\t\t\"type\": \"\",\n\t\t\t\"typeId\": \"\",\n\t\t\t\"description\": \"\",\n\t\t\t\"code\": \"10001\",\n\t\t\t\"level\": 0,\n\t\t\t\"status\": \"STATUS_ACTIVE\",\n\t\t\t\"depends\": \"\",\n\t\t\t\"start\": 1639497600000,\n\t\t\t\"duration\": 31,\n\t\t\t\"end\": 1643212799999,\n\t\t\t\"startIsMilestone\": false,\n\t\t\t\"endIsMilestone\": false,\n\t\t\t\"collapsed\": false,\n\t\t\t\"canWrite\": true,\n\t\t\t\"canAdd\": true,\n\t\t\t\"canDelete\": true,\n\t\t\t\"canAddIssue\": true,\n\t\t\t\"assigs\": [],\n\t\t\t\"hasChild\": true\n\t\t},\n\t\t{\n\t\t\t\"id\": \"tmp_fk1639475600597_1\",\n\t\t\t\"name\": \"ttt\",\n\t\t\t\"progress\": 0,\n\t\t\t\"progressByWorklog\": false,\n\t\t\t\"relevance\": 0,\n\t\t\t\"type\": \"\",\n\t\t\t\"typeId\": \"\",\n\t\t\t\"description\": \"\",\n\t\t\t\"code\": \"\",\n\t\t\t\"level\": 1,\n\t\t\t\"status\": \"STATUS_ACTIVE\",\n\t\t\t\"depends\": \"\",\n\t\t\t\"start\": 1639497600000,\n\t\t\t\"duration\": 1,\n\t\t\t\"end\": 1639583999999,\n\t\t\t\"startIsMilestone\": true,\n\t\t\t\"endIsMilestone\": false,\n\t\t\t\"collapsed\": false,\n\t\t\t\"canWrite\": true,\n\t\t\t\"canAdd\": true,\n\t\t\t\"canDelete\": true,\n\t\t\t\"canAddIssue\": true,\n\t\t\t\"assigs\": []\n\t\t}\n\t],\n\t\"selectedRow\": 0,\n\t\"deletedTaskIds\": [],\n\t\"resources\": [\n\t\t{\n\t\t\t\"id\": \"tmp_1\",\n\t\t\t\"name\": \"一号员工\"\n\t\t},\n\t\t{\n\t\t\t\"id\": \"tmp_2\",\n\t\t\t\"name\": \"二号员工\"\n\t\t},\n\t\t{\n\t\t\t\"id\": \"tmp_3\",\n\t\t\t\"name\": \"三号员工\"\n\t\t},\n\t\t{\n\t\t\t\"id\": \"tmp_4\",\n\t\t\t\"name\": \"四号员工\"\n\t\t}\n\t],\n\t\"roles\": [\n\t\t{\n\t\t\t\"id\": \"tmp_1\",\n\t\t\t\"name\": \"客户\"\n\t\t},\n\t\t{\n\t\t\t\"id\": \"tmp_2\",\n\t\t\t\"name\": \"开发人员\"\n\t\t},\n\t\t{\n\t\t\t\"id\": \"tmp_3\",\n\t\t\t\"name\": \"测试人员\"\n\t\t},\n\t\t{\n\t\t\t\"id\": \"tmp_4\",\n\t\t\t\"name\": \"项目经理\"\n\t\t}\n\t],\n\t\"canAdd\": true,\n\t\"canWrite\": true,\n\t\"canWriteOnParent\": true,\n\t\"zoom\": \"1M\"\n}'
  );
INSERT INTO
  `rt_gant` (
    `id`,
    `add_time`,
    `update_time`,
    `user_id`,
    `title`,
    `content`
  )
VALUES
  (
    6,
    1639476751,
    1639476751,
    0,
    'XXX项目',
    '{\n\t\"tasks\": [\n\t\t{\n\t\t\t\"id\": -1,\n\t\t\t\"name\": \"XXX项目\",\n\t\t\t\"progress\": 0,\n\t\t\t\"progressByWorklog\": false,\n\t\t\t\"relevance\": 0,\n\t\t\t\"type\": \"\",\n\t\t\t\"typeId\": \"\",\n\t\t\t\"description\": \"\",\n\t\t\t\"code\": \"10001\",\n\t\t\t\"level\": 0,\n\t\t\t\"status\": \"STATUS_ACTIVE\",\n\t\t\t\"depends\": \"\",\n\t\t\t\"start\": 1639497600000,\n\t\t\t\"duration\": 31,\n\t\t\t\"end\": 1643212799999,\n\t\t\t\"startIsMilestone\": false,\n\t\t\t\"endIsMilestone\": false,\n\t\t\t\"collapsed\": false,\n\t\t\t\"canWrite\": true,\n\t\t\t\"canAdd\": true,\n\t\t\t\"canDelete\": true,\n\t\t\t\"canAddIssue\": true,\n\t\t\t\"assigs\": [],\n\t\t\t\"hasChild\": true\n\t\t}\n\t],\n\t\"selectedRow\": 0,\n\t\"deletedTaskIds\": [],\n\t\"resources\": [\n\t\t{\n\t\t\t\"id\": \"tmp_1\",\n\t\t\t\"name\": \"一号员工\"\n\t\t},\n\t\t{\n\t\t\t\"id\": \"tmp_2\",\n\t\t\t\"name\": \"二号员工\"\n\t\t},\n\t\t{\n\t\t\t\"id\": \"tmp_3\",\n\t\t\t\"name\": \"三号员工\"\n\t\t},\n\t\t{\n\t\t\t\"id\": \"tmp_4\",\n\t\t\t\"name\": \"四号员工\"\n\t\t}\n\t],\n\t\"roles\": [\n\t\t{\n\t\t\t\"id\": \"tmp_1\",\n\t\t\t\"name\": \"客户\"\n\t\t},\n\t\t{\n\t\t\t\"id\": \"tmp_2\",\n\t\t\t\"name\": \"开发人员\"\n\t\t},\n\t\t{\n\t\t\t\"id\": \"tmp_3\",\n\t\t\t\"name\": \"测试人员\"\n\t\t},\n\t\t{\n\t\t\t\"id\": \"tmp_4\",\n\t\t\t\"name\": \"项目经理\"\n\t\t}\n\t],\n\t\"canAdd\": true,\n\t\"canWrite\": true,\n\t\"canWriteOnParent\": true,\n\t\"zoom\": \"1M\"\n}'
  );
INSERT INTO
  `rt_gant` (
    `id`,
    `add_time`,
    `update_time`,
    `user_id`,
    `title`,
    `content`
  )
VALUES
  (
    7,
    1639477017,
    1639477021,
    0,
    'XXX项目',
    '{\n\t\"tasks\": [\n\t\t{\n\t\t\t\"id\": -1,\n\t\t\t\"name\": \"XXX项目\",\n\t\t\t\"progress\": 0,\n\t\t\t\"progressByWorklog\": false,\n\t\t\t\"relevance\": 0,\n\t\t\t\"type\": \"\",\n\t\t\t\"typeId\": \"\",\n\t\t\t\"description\": \"\",\n\t\t\t\"code\": \"10001\",\n\t\t\t\"level\": 0,\n\t\t\t\"status\": \"STATUS_ACTIVE\",\n\t\t\t\"depends\": \"\",\n\t\t\t\"start\": 1639497600000,\n\t\t\t\"duration\": 31,\n\t\t\t\"end\": 1643212799999,\n\t\t\t\"startIsMilestone\": true,\n\t\t\t\"endIsMilestone\": false,\n\t\t\t\"collapsed\": false,\n\t\t\t\"canWrite\": true,\n\t\t\t\"canAdd\": true,\n\t\t\t\"canDelete\": true,\n\t\t\t\"canAddIssue\": true,\n\t\t\t\"assigs\": [],\n\t\t\t\"hasChild\": true\n\t\t}\n\t],\n\t\"selectedRow\": 0,\n\t\"deletedTaskIds\": [],\n\t\"resources\": [\n\t\t{\n\t\t\t\"id\": \"tmp_1\",\n\t\t\t\"name\": \"一号员工\"\n\t\t},\n\t\t{\n\t\t\t\"id\": \"tmp_2\",\n\t\t\t\"name\": \"二号员工\"\n\t\t},\n\t\t{\n\t\t\t\"id\": \"tmp_3\",\n\t\t\t\"name\": \"三号员工\"\n\t\t},\n\t\t{\n\t\t\t\"id\": \"tmp_4\",\n\t\t\t\"name\": \"四号员工\"\n\t\t}\n\t],\n\t\"roles\": [\n\t\t{\n\t\t\t\"id\": \"tmp_1\",\n\t\t\t\"name\": \"客户\"\n\t\t},\n\t\t{\n\t\t\t\"id\": \"tmp_2\",\n\t\t\t\"name\": \"开发人员\"\n\t\t},\n\t\t{\n\t\t\t\"id\": \"tmp_3\",\n\t\t\t\"name\": \"测试人员\"\n\t\t},\n\t\t{\n\t\t\t\"id\": \"tmp_4\",\n\t\t\t\"name\": \"项目经理\"\n\t\t}\n\t],\n\t\"canAdd\": true,\n\t\"canWrite\": true,\n\t\"canWriteOnParent\": true,\n\t\"zoom\": \"1M\"\n}'
  );
INSERT INTO
  `rt_gant` (
    `id`,
    `add_time`,
    `update_time`,
    `user_id`,
    `title`,
    `content`
  )
VALUES
  (
    8,
    1639477032,
    1639477093,
    0,
    'XXX项目222',
    '{\n\t\"tasks\": [\n\t\t{\n\t\t\t\"id\": -1,\n\t\t\t\"name\": \"XXX项目222\",\n\t\t\t\"progress\": 0,\n\t\t\t\"progressByWorklog\": false,\n\t\t\t\"relevance\": 0,\n\t\t\t\"type\": \"\",\n\t\t\t\"typeId\": \"\",\n\t\t\t\"description\": \"\",\n\t\t\t\"code\": \"10001\",\n\t\t\t\"level\": 0,\n\t\t\t\"status\": \"STATUS_ACTIVE\",\n\t\t\t\"depends\": \"\",\n\t\t\t\"start\": 1639497600000,\n\t\t\t\"duration\": 31,\n\t\t\t\"end\": 1643212799999,\n\t\t\t\"startIsMilestone\": false,\n\t\t\t\"endIsMilestone\": false,\n\t\t\t\"collapsed\": false,\n\t\t\t\"canWrite\": true,\n\t\t\t\"canAdd\": true,\n\t\t\t\"canDelete\": true,\n\t\t\t\"canAddIssue\": true,\n\t\t\t\"assigs\": [],\n\t\t\t\"hasChild\": true\n\t\t},\n\t\t{\n\t\t\t\"id\": \"tmp_fk1639477063267_1\",\n\t\t\t\"name\": \"tttt\",\n\t\t\t\"progress\": 0,\n\t\t\t\"progressByWorklog\": false,\n\t\t\t\"relevance\": 0,\n\t\t\t\"type\": \"\",\n\t\t\t\"typeId\": \"\",\n\t\t\t\"description\": \"\",\n\t\t\t\"code\": \"1\",\n\t\t\t\"level\": 1,\n\t\t\t\"status\": \"STATUS_ACTIVE\",\n\t\t\t\"depends\": \"\",\n\t\t\t\"start\": 1639497600000,\n\t\t\t\"duration\": 1,\n\t\t\t\"end\": 1639583999999,\n\t\t\t\"startIsMilestone\": false,\n\t\t\t\"endIsMilestone\": false,\n\t\t\t\"canWrite\": true,\n\t\t\t\"canAdd\": true,\n\t\t\t\"canDelete\": true,\n\t\t\t\"canAddIssue\": true,\n\t\t\t\"assigs\": []\n\t\t},\n\t\t{\n\t\t\t\"id\": \"tmp_fk1639477071884_1\",\n\t\t\t\"name\": \"ggg\",\n\t\t\t\"progress\": 0,\n\t\t\t\"progressByWorklog\": false,\n\t\t\t\"relevance\": 0,\n\t\t\t\"type\": \"\",\n\t\t\t\"typeId\": \"\",\n\t\t\t\"description\": \"\",\n\t\t\t\"code\": \"2\",\n\t\t\t\"level\": 1,\n\t\t\t\"status\": \"STATUS_ACTIVE\",\n\t\t\t\"depends\": \"\",\n\t\t\t\"start\": 1639497600000,\n\t\t\t\"duration\": 1,\n\t\t\t\"end\": 1639583999999,\n\t\t\t\"startIsMilestone\": false,\n\t\t\t\"endIsMilestone\": false,\n\t\t\t\"canWrite\": true,\n\t\t\t\"canAdd\": true,\n\t\t\t\"canDelete\": true,\n\t\t\t\"canAddIssue\": true,\n\t\t\t\"assigs\": []\n\t\t}\n\t],\n\t\"selectedRow\": 2,\n\t\"deletedTaskIds\": [],\n\t\"resources\": [\n\t\t{\n\t\t\t\"id\": \"tmp_1\",\n\t\t\t\"name\": \"一号员工\"\n\t\t},\n\t\t{\n\t\t\t\"id\": \"tmp_2\",\n\t\t\t\"name\": \"二号员工\"\n\t\t},\n\t\t{\n\t\t\t\"id\": \"tmp_3\",\n\t\t\t\"name\": \"三号员工\"\n\t\t},\n\t\t{\n\t\t\t\"id\": \"tmp_4\",\n\t\t\t\"name\": \"四号员工\"\n\t\t}\n\t],\n\t\"roles\": [\n\t\t{\n\t\t\t\"id\": \"tmp_1\",\n\t\t\t\"name\": \"客户\"\n\t\t},\n\t\t{\n\t\t\t\"id\": \"tmp_2\",\n\t\t\t\"name\": \"开发人员\"\n\t\t},\n\t\t{\n\t\t\t\"id\": \"tmp_3\",\n\t\t\t\"name\": \"测试人员\"\n\t\t},\n\t\t{\n\t\t\t\"id\": \"tmp_4\",\n\t\t\t\"name\": \"项目经理\"\n\t\t}\n\t],\n\t\"canAdd\": true,\n\t\"canWrite\": true,\n\t\"canWriteOnParent\": true,\n\t\"zoom\": \"1M\"\n}'
  );
INSERT INTO
  `rt_gant` (
    `id`,
    `add_time`,
    `update_time`,
    `user_id`,
    `title`,
    `content`
  )
VALUES
  (
    9,
    1639477248,
    1639477260,
    0,
    '2XXX项目',
    '{\n\t\"tasks\": [\n\t\t{\n\t\t\t\"id\": -1,\n\t\t\t\"name\": \"2XXX项目\",\n\t\t\t\"progress\": 0,\n\t\t\t\"progressByWorklog\": false,\n\t\t\t\"relevance\": 0,\n\t\t\t\"type\": \"\",\n\t\t\t\"typeId\": \"\",\n\t\t\t\"description\": \"\",\n\t\t\t\"code\": \"10001\",\n\t\t\t\"level\": 0,\n\t\t\t\"status\": \"STATUS_ACTIVE\",\n\t\t\t\"depends\": \"\",\n\t\t\t\"start\": 1639497600000,\n\t\t\t\"duration\": 31,\n\t\t\t\"end\": 1643212799999,\n\t\t\t\"startIsMilestone\": false,\n\t\t\t\"endIsMilestone\": false,\n\t\t\t\"collapsed\": false,\n\t\t\t\"canWrite\": true,\n\t\t\t\"canAdd\": true,\n\t\t\t\"canDelete\": true,\n\t\t\t\"canAddIssue\": true,\n\t\t\t\"assigs\": [],\n\t\t\t\"hasChild\": true\n\t\t}\n\t],\n\t\"selectedRow\": 0,\n\t\"deletedTaskIds\": [],\n\t\"resources\": [\n\t\t{\n\t\t\t\"id\": \"tmp_1\",\n\t\t\t\"name\": \"一号员工\"\n\t\t},\n\t\t{\n\t\t\t\"id\": \"tmp_2\",\n\t\t\t\"name\": \"二号员工\"\n\t\t},\n\t\t{\n\t\t\t\"id\": \"tmp_3\",\n\t\t\t\"name\": \"三号员工\"\n\t\t},\n\t\t{\n\t\t\t\"id\": \"tmp_4\",\n\t\t\t\"name\": \"四号员工\"\n\t\t}\n\t],\n\t\"roles\": [\n\t\t{\n\t\t\t\"id\": \"tmp_1\",\n\t\t\t\"name\": \"客户\"\n\t\t},\n\t\t{\n\t\t\t\"id\": \"tmp_2\",\n\t\t\t\"name\": \"开发人员\"\n\t\t},\n\t\t{\n\t\t\t\"id\": \"tmp_3\",\n\t\t\t\"name\": \"测试人员\"\n\t\t},\n\t\t{\n\t\t\t\"id\": \"tmp_4\",\n\t\t\t\"name\": \"项目经理\"\n\t\t}\n\t],\n\t\"canAdd\": true,\n\t\"canWrite\": true,\n\t\"canWriteOnParent\": true,\n\t\"zoom\": \"1M\"\n}'
  );
INSERT INTO
  `rt_gant` (
    `id`,
    `add_time`,
    `update_time`,
    `user_id`,
    `title`,
    `content`
  )
VALUES
  (
    10,
    1639477332,
    1639477342,
    1,
    'XXX项目',
    '{\n\t\"tasks\": [\n\t\t{\n\t\t\t\"id\": -1,\n\t\t\t\"name\": \"XXX项目\",\n\t\t\t\"progress\": 0,\n\t\t\t\"progressByWorklog\": false,\n\t\t\t\"relevance\": 0,\n\t\t\t\"type\": \"\",\n\t\t\t\"typeId\": \"\",\n\t\t\t\"description\": \"\",\n\t\t\t\"code\": \"10001\",\n\t\t\t\"level\": 0,\n\t\t\t\"status\": \"STATUS_ACTIVE\",\n\t\t\t\"depends\": \"\",\n\t\t\t\"start\": 1639497600000,\n\t\t\t\"duration\": 31,\n\t\t\t\"end\": 1643212799999,\n\t\t\t\"startIsMilestone\": false,\n\t\t\t\"endIsMilestone\": false,\n\t\t\t\"collapsed\": false,\n\t\t\t\"canWrite\": true,\n\t\t\t\"canAdd\": true,\n\t\t\t\"canDelete\": true,\n\t\t\t\"canAddIssue\": true,\n\t\t\t\"assigs\": [],\n\t\t\t\"hasChild\": true\n\t\t}\n\t],\n\t\"selectedRow\": 0,\n\t\"deletedTaskIds\": [],\n\t\"resources\": [\n\t\t{\n\t\t\t\"id\": \"tmp_1\",\n\t\t\t\"name\": \"一号员工\"\n\t\t},\n\t\t{\n\t\t\t\"id\": \"tmp_2\",\n\t\t\t\"name\": \"二号员工\"\n\t\t},\n\t\t{\n\t\t\t\"id\": \"tmp_3\",\n\t\t\t\"name\": \"三号员工\"\n\t\t},\n\t\t{\n\t\t\t\"id\": \"tmp_4\",\n\t\t\t\"name\": \"四号员工\"\n\t\t}\n\t],\n\t\"roles\": [\n\t\t{\n\t\t\t\"id\": \"tmp_1\",\n\t\t\t\"name\": \"客户\"\n\t\t},\n\t\t{\n\t\t\t\"id\": \"tmp_2\",\n\t\t\t\"name\": \"开发人员\"\n\t\t},\n\t\t{\n\t\t\t\"id\": \"tmp_3\",\n\t\t\t\"name\": \"测试人员\"\n\t\t},\n\t\t{\n\t\t\t\"id\": \"tmp_4\",\n\t\t\t\"name\": \"项目经理\"\n\t\t}\n\t],\n\t\"canAdd\": true,\n\t\"canWrite\": true,\n\t\"canWriteOnParent\": true,\n\t\"zoom\": \"1M\"\n}'
  );
INSERT INTO
  `rt_gant` (
    `id`,
    `add_time`,
    `update_time`,
    `user_id`,
    `title`,
    `content`
  )
VALUES
  (
    11,
    1639547925,
    1639547925,
    1,
    'test',
    '{\n\t\"tasks\": [\n\t\t{\n\t\t\t\"id\": \"tmp_fk1639547897986_1\",\n\t\t\t\"name\": \"test\",\n\t\t\t\"progress\": 0,\n\t\t\t\"progressByWorklog\": false,\n\t\t\t\"description\": \"ceshi\",\n\t\t\t\"code\": \"111\",\n\t\t\t\"level\": 0,\n\t\t\t\"status\": \"STATUS_ACTIVE\",\n\t\t\t\"depends\": \"\",\n\t\t\t\"start\": 1639584000000,\n\t\t\t\"duration\": 1,\n\t\t\t\"end\": 1639670399999,\n\t\t\t\"startIsMilestone\": false,\n\t\t\t\"endIsMilestone\": false,\n\t\t\t\"canWrite\": true,\n\t\t\t\"canAdd\": true,\n\t\t\t\"canDelete\": true,\n\t\t\t\"canAddIssue\": true,\n\t\t\t\"assigs\": [\n\t\t\t\t{\n\t\t\t\t\t\"id\": \"tmp_1639547923055_1\",\n\t\t\t\t\t\"resourceId\": \"tmp_2\",\n\t\t\t\t\t\"roleId\": \"tmp_3\",\n\t\t\t\t\t\"effort\": null\n\t\t\t\t}\n\t\t\t]\n\t\t}\n\t],\n\t\"selectedRow\": 0,\n\t\"deletedTaskIds\": [],\n\t\"resources\": [\n\t\t{\n\t\t\t\"id\": \"tmp_1\",\n\t\t\t\"name\": \"一号员工\"\n\t\t},\n\t\t{\n\t\t\t\"id\": \"tmp_2\",\n\t\t\t\"name\": \"二号员工\"\n\t\t},\n\t\t{\n\t\t\t\"id\": \"tmp_3\",\n\t\t\t\"name\": \"三号员工\"\n\t\t},\n\t\t{\n\t\t\t\"id\": \"tmp_4\",\n\t\t\t\"name\": \"四号员工\"\n\t\t}\n\t],\n\t\"roles\": [\n\t\t{\n\t\t\t\"id\": \"tmp_1\",\n\t\t\t\"name\": \"客户\"\n\t\t},\n\t\t{\n\t\t\t\"id\": \"tmp_2\",\n\t\t\t\"name\": \"开发人员\"\n\t\t},\n\t\t{\n\t\t\t\"id\": \"tmp_3\",\n\t\t\t\"name\": \"测试人员\"\n\t\t},\n\t\t{\n\t\t\t\"id\": \"tmp_4\",\n\t\t\t\"name\": \"项目经理\"\n\t\t}\n\t],\n\t\"canAdd\": true,\n\t\"canWrite\": true,\n\t\"canWriteOnParent\": true,\n\t\"zoom\": \"1M\"\n}'
  );

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: rt_kanban
# ------------------------------------------------------------


# ------------------------------------------------------------
# DATA DUMP FOR TABLE: rt_kanban_item
# ------------------------------------------------------------


# ------------------------------------------------------------
# DATA DUMP FOR TABLE: rt_kanban_list
# ------------------------------------------------------------


# ------------------------------------------------------------
# DATA DUMP FOR TABLE: rt_menu
# ------------------------------------------------------------

INSERT INTO
  `rt_menu` (
    `id`,
    `title`,
    `key`,
    `route`,
    `href`,
    `type`,
    `order_num`,
    `icon`,
    `open_type`,
    `pid`,
    `lid`,
    `ifshow`,
    `desktop`
  )
VALUES
  (
    1,
    '内容管理',
    'sys',
    'content',
    NULL,
    0,
    2,
    'layui-icon layui-icon-theme',
    '_self',
    0,
    0,
    0,
    0
  );
INSERT INTO
  `rt_menu` (
    `id`,
    `title`,
    `key`,
    `route`,
    `href`,
    `type`,
    `order_num`,
    `icon`,
    `open_type`,
    `pid`,
    `lid`,
    `ifshow`,
    `desktop`
  )
VALUES
  (
    2,
    '系统管理',
    'sys',
    'system',
    '',
    0,
    1,
    'layui-icon layui-icon-set',
    '_self',
    0,
    0,
    0,
    0
  );
INSERT INTO
  `rt_menu` (
    `id`,
    `title`,
    `key`,
    `route`,
    `href`,
    `type`,
    `order_num`,
    `icon`,
    `open_type`,
    `pid`,
    `lid`,
    `ifshow`,
    `desktop`
  )
VALUES
  (
    3,
    '权限管理',
    'auth',
    'auth',
    '',
    0,
    1,
    'layui-icon layui-icon-vercode',
    '_self',
    0,
    0,
    0,
    0
  );
INSERT INTO
  `rt_menu` (
    `id`,
    `title`,
    `key`,
    `route`,
    `href`,
    `type`,
    `order_num`,
    `icon`,
    `open_type`,
    `pid`,
    `lid`,
    `ifshow`,
    `desktop`
  )
VALUES
  (
    6,
    '公共模块',
    'sys',
    'common',
    '',
    0,
    3,
    'layui-icon layui-icon-at',
    '_self',
    0,
    0,
    1,
    0
  );
INSERT INTO
  `rt_menu` (
    `id`,
    `title`,
    `key`,
    `route`,
    `href`,
    `type`,
    `order_num`,
    `icon`,
    `open_type`,
    `pid`,
    `lid`,
    `ifshow`,
    `desktop`
  )
VALUES
  (
    9,
    '菜单管理',
    'menu',
    'server/menu/oplist',
    'view/menu/index.html',
    1,
    1,
    'layui-icon layui-icon-gift',
    '_self',
    3,
    1,
    0,
    1
  );
INSERT INTO
  `rt_menu` (
    `id`,
    `title`,
    `key`,
    `route`,
    `href`,
    `type`,
    `order_num`,
    `icon`,
    `open_type`,
    `pid`,
    `lid`,
    `ifshow`,
    `desktop`
  )
VALUES
  (
    10,
    '角色管理',
    'auth',
    'server/auth/list',
    'view/auth/index.html',
    1,
    10,
    'layui-icon layui-icon-service',
    '_self',
    3,
    1,
    0,
    0
  );
INSERT INTO
  `rt_menu` (
    `id`,
    `title`,
    `key`,
    `route`,
    `href`,
    `type`,
    `order_num`,
    `icon`,
    `open_type`,
    `pid`,
    `lid`,
    `ifshow`,
    `desktop`
  )
VALUES
  (
    11,
    '管理员管理',
    'admin',
    'server/admin/list',
    'view/admin/list.html',
    1,
    11,
    'layui-icon layui-icon-key',
    '_self',
    3,
    1,
    0,
    0
  );
INSERT INTO
  `rt_menu` (
    `id`,
    `title`,
    `key`,
    `route`,
    `href`,
    `type`,
    `order_num`,
    `icon`,
    `open_type`,
    `pid`,
    `lid`,
    `ifshow`,
    `desktop`
  )
VALUES
  (
    12,
    '日志管理',
    'logs',
    'logs',
    '',
    0,
    12,
    'layui-icon layui-icon-spread-left',
    '_self',
    2,
    1,
    0,
    0
  );
INSERT INTO
  `rt_menu` (
    `id`,
    `title`,
    `key`,
    `route`,
    `href`,
    `type`,
    `order_num`,
    `icon`,
    `open_type`,
    `pid`,
    `lid`,
    `ifshow`,
    `desktop`
  )
VALUES
  (
    13,
    '系统设置',
    'set',
    'server/set/list',
    'view/set/list.html',
    1,
    13,
    'layui-icon layui-icon-find-fill',
    '_self',
    2,
    1,
    0,
    0
  );
INSERT INTO
  `rt_menu` (
    `id`,
    `title`,
    `key`,
    `route`,
    `href`,
    `type`,
    `order_num`,
    `icon`,
    `open_type`,
    `pid`,
    `lid`,
    `ifshow`,
    `desktop`
  )
VALUES
  (
    15,
    '前端菜单',
    'menu',
    'server/menu/list',
    '',
    3,
    0,
    'layui-icon layui-icon-transfer',
    NULL,
    6,
    1,
    1,
    0
  );
INSERT INTO
  `rt_menu` (
    `id`,
    `title`,
    `key`,
    `route`,
    `href`,
    `type`,
    `order_num`,
    `icon`,
    `open_type`,
    `pid`,
    `lid`,
    `ifshow`,
    `desktop`
  )
VALUES
  (
    20,
    '新增菜单',
    'menu',
    'server/menu/add',
    '',
    2,
    20,
    'layui-icon layui-icon-cols',
    '_self',
    9,
    2,
    0,
    0
  );
INSERT INTO
  `rt_menu` (
    `id`,
    `title`,
    `key`,
    `route`,
    `href`,
    `type`,
    `order_num`,
    `icon`,
    `open_type`,
    `pid`,
    `lid`,
    `ifshow`,
    `desktop`
  )
VALUES
  (
    21,
    '编辑菜单',
    'menu',
    'server/menu/edit',
    '',
    2,
    20,
    'layui-icon layui-icon-add-1',
    '_self',
    9,
    2,
    0,
    0
  );
INSERT INTO
  `rt_menu` (
    `id`,
    `title`,
    `key`,
    `route`,
    `href`,
    `type`,
    `order_num`,
    `icon`,
    `open_type`,
    `pid`,
    `lid`,
    `ifshow`,
    `desktop`
  )
VALUES
  (
    22,
    '删除菜单',
    'menu',
    'server/menu/del',
    '',
    2,
    21,
    'layui-icon layui-icon-delete',
    '_self',
    9,
    2,
    0,
    0
  );
INSERT INTO
  `rt_menu` (
    `id`,
    `title`,
    `key`,
    `route`,
    `href`,
    `type`,
    `order_num`,
    `icon`,
    `open_type`,
    `pid`,
    `lid`,
    `ifshow`,
    `desktop`
  )
VALUES
  (
    23,
    '查看菜单',
    'menu',
    'server/menu/one',
    '',
    3,
    20,
    'layui-icon layui-icon-slider',
    '_self',
    9,
    2,
    0,
    0
  );
INSERT INTO
  `rt_menu` (
    `id`,
    `title`,
    `key`,
    `route`,
    `href`,
    `type`,
    `order_num`,
    `icon`,
    `open_type`,
    `pid`,
    `lid`,
    `ifshow`,
    `desktop`
  )
VALUES
  (
    24,
    '编辑管理员',
    'admin',
    'server/admin/edit',
    '',
    2,
    20,
    'layui-icon layui-icon-time',
    '_self',
    11,
    2,
    0,
    0
  );
INSERT INTO
  `rt_menu` (
    `id`,
    `title`,
    `key`,
    `route`,
    `href`,
    `type`,
    `order_num`,
    `icon`,
    `open_type`,
    `pid`,
    `lid`,
    `ifshow`,
    `desktop`
  )
VALUES
  (
    25,
    '删除管理员',
    'admin',
    'server/admin/del',
    '',
    2,
    21,
    'layui-icon layui-icon-more-vertical',
    '_self',
    11,
    2,
    0,
    0
  );
INSERT INTO
  `rt_menu` (
    `id`,
    `title`,
    `key`,
    `route`,
    `href`,
    `type`,
    `order_num`,
    `icon`,
    `open_type`,
    `pid`,
    `lid`,
    `ifshow`,
    `desktop`
  )
VALUES
  (
    26,
    '编辑角色',
    'auth',
    'server/auth/edit',
    '',
    2,
    22,
    'layui-icon layui-icon-key',
    '_self',
    10,
    2,
    0,
    0
  );
INSERT INTO
  `rt_menu` (
    `id`,
    `title`,
    `key`,
    `route`,
    `href`,
    `type`,
    `order_num`,
    `icon`,
    `open_type`,
    `pid`,
    `lid`,
    `ifshow`,
    `desktop`
  )
VALUES
  (
    27,
    '删除角色',
    'auth',
    'server/auth/del',
    '',
    2,
    23,
    'layui-icon layui-icon-mute',
    '_self',
    10,
    2,
    0,
    0
  );
INSERT INTO
  `rt_menu` (
    `id`,
    `title`,
    `key`,
    `route`,
    `href`,
    `type`,
    `order_num`,
    `icon`,
    `open_type`,
    `pid`,
    `lid`,
    `ifshow`,
    `desktop`
  )
VALUES
  (
    28,
    '添加配置',
    'auth',
    'server/set/add',
    '',
    2,
    24,
    'layui-icon layui-icon-at',
    '_self',
    13,
    2,
    0,
    0
  );
INSERT INTO
  `rt_menu` (
    `id`,
    `title`,
    `key`,
    `route`,
    `href`,
    `type`,
    `order_num`,
    `icon`,
    `open_type`,
    `pid`,
    `lid`,
    `ifshow`,
    `desktop`
  )
VALUES
  (
    29,
    '删除配置',
    'set',
    'server/set/delete',
    '',
    2,
    25,
    'layui-icon layui-icon-mute',
    '_self',
    13,
    2,
    0,
    0
  );
INSERT INTO
  `rt_menu` (
    `id`,
    `title`,
    `key`,
    `route`,
    `href`,
    `type`,
    `order_num`,
    `icon`,
    `open_type`,
    `pid`,
    `lid`,
    `ifshow`,
    `desktop`
  )
VALUES
  (
    31,
    '编辑配置',
    'set',
    'server/set/edit',
    '',
    2,
    27,
    'layui-icon layui-icon-export',
    '_self',
    13,
    2,
    0,
    0
  );
INSERT INTO
  `rt_menu` (
    `id`,
    `title`,
    `key`,
    `route`,
    `href`,
    `type`,
    `order_num`,
    `icon`,
    `open_type`,
    `pid`,
    `lid`,
    `ifshow`,
    `desktop`
  )
VALUES
  (
    32,
    '编辑配置前',
    'set',
    'server/set/editBefore',
    '',
    3,
    28,
    'layui-icon layui-icon-rate-half',
    '_self',
    13,
    2,
    0,
    0
  );
INSERT INTO
  `rt_menu` (
    `id`,
    `title`,
    `key`,
    `route`,
    `href`,
    `type`,
    `order_num`,
    `icon`,
    `open_type`,
    `pid`,
    `lid`,
    `ifshow`,
    `desktop`
  )
VALUES
  (
    35,
    '数据库设计器',
    'db',
    'server/db/list',
    'view/db/list.html',
    1,
    3,
    'layui-icon layui-icon-template-1',
    '_self',
    2,
    1,
    0,
    1
  );
INSERT INTO
  `rt_menu` (
    `id`,
    `title`,
    `key`,
    `route`,
    `href`,
    `type`,
    `order_num`,
    `icon`,
    `open_type`,
    `pid`,
    `lid`,
    `ifshow`,
    `desktop`
  )
VALUES
  (
    53,
    '首页工作台',
    'common',
    'server/index/welcome',
    'view/index/welcome.html',
    1,
    1,
    'layui-icon layui-icon-rate-solid',
    NULL,
    1,
    1,
    0,
    0
  );
INSERT INTO
  `rt_menu` (
    `id`,
    `title`,
    `key`,
    `route`,
    `href`,
    `type`,
    `order_num`,
    `icon`,
    `open_type`,
    `pid`,
    `lid`,
    `ifshow`,
    `desktop`
  )
VALUES
  (
    56,
    '查看角色',
    'auth',
    'server/auth/one',
    '',
    2,
    0,
    'layui-icon layui-icon-camera',
    NULL,
    10,
    1,
    0,
    0
  );
INSERT INTO
  `rt_menu` (
    `id`,
    `title`,
    `key`,
    `route`,
    `href`,
    `type`,
    `order_num`,
    `icon`,
    `open_type`,
    `pid`,
    `lid`,
    `ifshow`,
    `desktop`
  )
VALUES
  (
    57,
    '菜单显示',
    'menu',
    'server/menu/ifshow',
    '',
    2,
    0,
    'layui-icon layui-icon-mike',
    NULL,
    9,
    1,
    0,
    0
  );
INSERT INTO
  `rt_menu` (
    `id`,
    `title`,
    `key`,
    `route`,
    `href`,
    `type`,
    `order_num`,
    `icon`,
    `open_type`,
    `pid`,
    `lid`,
    `ifshow`,
    `desktop`
  )
VALUES
  (
    58,
    '添加查看菜单',
    'auth',
    'server/auth/addTree',
    '',
    3,
    1,
    'layui-icon layui-icon-heart-fill',
    NULL,
    10,
    1,
    0,
    0
  );
INSERT INTO
  `rt_menu` (
    `id`,
    `title`,
    `key`,
    `route`,
    `href`,
    `type`,
    `order_num`,
    `icon`,
    `open_type`,
    `pid`,
    `lid`,
    `ifshow`,
    `desktop`
  )
VALUES
  (
    59,
    '添加角色',
    'auth',
    'server/auth/add',
    '',
    2,
    1,
    'layui-icon layui-icon-logout',
    NULL,
    10,
    1,
    0,
    0
  );
INSERT INTO
  `rt_menu` (
    `id`,
    `title`,
    `key`,
    `route`,
    `href`,
    `type`,
    `order_num`,
    `icon`,
    `open_type`,
    `pid`,
    `lid`,
    `ifshow`,
    `desktop`
  )
VALUES
  (
    60,
    '角色编辑前',
    'auth',
    'server/auth/beforEdit',
    '',
    3,
    0,
    'layui-icon layui-icon-email',
    NULL,
    10,
    1,
    0,
    0
  );
INSERT INTO
  `rt_menu` (
    `id`,
    `title`,
    `key`,
    `route`,
    `href`,
    `type`,
    `order_num`,
    `icon`,
    `open_type`,
    `pid`,
    `lid`,
    `ifshow`,
    `desktop`
  )
VALUES
  (
    61,
    '设置角色可用',
    'auth',
    'server/auth/enable',
    '',
    2,
    0,
    'layui-icon layui-icon-at',
    NULL,
    10,
    1,
    0,
    0
  );
INSERT INTO
  `rt_menu` (
    `id`,
    `title`,
    `key`,
    `route`,
    `href`,
    `type`,
    `order_num`,
    `icon`,
    `open_type`,
    `pid`,
    `lid`,
    `ifshow`,
    `desktop`
  )
VALUES
  (
    62,
    '管理员添加前',
    'admin',
    'server/admin/addBefore',
    '',
    3,
    0,
    '',
    NULL,
    11,
    1,
    0,
    0
  );
INSERT INTO
  `rt_menu` (
    `id`,
    `title`,
    `key`,
    `route`,
    `href`,
    `type`,
    `order_num`,
    `icon`,
    `open_type`,
    `pid`,
    `lid`,
    `ifshow`,
    `desktop`
  )
VALUES
  (
    63,
    '添加管理员',
    'admin',
    'server/admin/add',
    '',
    2,
    0,
    'layui-icon layui-icon-windows',
    NULL,
    11,
    1,
    0,
    0
  );
INSERT INTO
  `rt_menu` (
    `id`,
    `title`,
    `key`,
    `route`,
    `href`,
    `type`,
    `order_num`,
    `icon`,
    `open_type`,
    `pid`,
    `lid`,
    `ifshow`,
    `desktop`
  )
VALUES
  (
    64,
    '管理员编辑前',
    'admin',
    'server/admin/editBefore',
    '',
    3,
    0,
    'layui-icon layui-icon-export',
    NULL,
    11,
    1,
    0,
    0
  );
INSERT INTO
  `rt_menu` (
    `id`,
    `title`,
    `key`,
    `route`,
    `href`,
    `type`,
    `order_num`,
    `icon`,
    `open_type`,
    `pid`,
    `lid`,
    `ifshow`,
    `desktop`
  )
VALUES
  (
    65,
    '管理员启用禁用',
    'admin',
    'server/admin/enable',
    '',
    2,
    0,
    'layui-icon layui-icon-slider',
    NULL,
    11,
    1,
    0,
    0
  );
INSERT INTO
  `rt_menu` (
    `id`,
    `title`,
    `key`,
    `route`,
    `href`,
    `type`,
    `order_num`,
    `icon`,
    `open_type`,
    `pid`,
    `lid`,
    `ifshow`,
    `desktop`
  )
VALUES
  (
    66,
    '操作日志',
    'logs',
    'server/logs/op',
    'view/logs/op.html',
    1,
    0,
    'layui-icon layui-icon-date',
    NULL,
    12,
    1,
    0,
    0
  );
INSERT INTO
  `rt_menu` (
    `id`,
    `title`,
    `key`,
    `route`,
    `href`,
    `type`,
    `order_num`,
    `icon`,
    `open_type`,
    `pid`,
    `lid`,
    `ifshow`,
    `desktop`
  )
VALUES
  (
    67,
    '行为日志',
    'logs',
    'server/logs/view',
    'view/logs/view.html',
    1,
    0,
    'layui-icon layui-icon-cols',
    NULL,
    12,
    1,
    0,
    0
  );
INSERT INTO
  `rt_menu` (
    `id`,
    `title`,
    `key`,
    `route`,
    `href`,
    `type`,
    `order_num`,
    `icon`,
    `open_type`,
    `pid`,
    `lid`,
    `ifshow`,
    `desktop`
  )
VALUES
  (
    68,
    '错误日志',
    'logs',
    'server/logs/err',
    'view/logs/err.html',
    1,
    0,
    'layui-icon layui-icon-survey',
    NULL,
    12,
    1,
    0,
    0
  );
INSERT INTO
  `rt_menu` (
    `id`,
    `title`,
    `key`,
    `route`,
    `href`,
    `type`,
    `order_num`,
    `icon`,
    `open_type`,
    `pid`,
    `lid`,
    `ifshow`,
    `desktop`
  )
VALUES
  (
    82,
    '表单设计器',
    NULL,
    'server/form/list',
    'view/form/list.html',
    1,
    9,
    'layui-icon layui-icon-form',
    NULL,
    2,
    1,
    0,
    0
  );
INSERT INTO
  `rt_menu` (
    `id`,
    `title`,
    `key`,
    `route`,
    `href`,
    `type`,
    `order_num`,
    `icon`,
    `open_type`,
    `pid`,
    `lid`,
    `ifshow`,
    `desktop`
  )
VALUES
  (
    83,
    '添加表单',
    NULL,
    'server/form/add',
    'view/form/add.html',
    2,
    0,
    'layui-icon layui-icon-auz',
    NULL,
    82,
    1,
    0,
    0
  );
INSERT INTO
  `rt_menu` (
    `id`,
    `title`,
    `key`,
    `route`,
    `href`,
    `type`,
    `order_num`,
    `icon`,
    `open_type`,
    `pid`,
    `lid`,
    `ifshow`,
    `desktop`
  )
VALUES
  (
    84,
    '设置配置可用',
    'set',
    'server/set/enable',
    '',
    3,
    0,
    '',
    NULL,
    13,
    1,
    0,
    0
  );
INSERT INTO
  `rt_menu` (
    `id`,
    `title`,
    `key`,
    `route`,
    `href`,
    `type`,
    `order_num`,
    `icon`,
    `open_type`,
    `pid`,
    `lid`,
    `ifshow`,
    `desktop`
  )
VALUES
  (
    85,
    '添加表单前',
    NULL,
    'server/form/addBefore',
    '',
    3,
    0,
    'layui-icon layui-icon-headset',
    NULL,
    82,
    1,
    0,
    0
  );
INSERT INTO
  `rt_menu` (
    `id`,
    `title`,
    `key`,
    `route`,
    `href`,
    `type`,
    `order_num`,
    `icon`,
    `open_type`,
    `pid`,
    `lid`,
    `ifshow`,
    `desktop`
  )
VALUES
  (
    86,
    '设置配置前',
    NULL,
    'server/set/setBefore',
    '',
    3,
    0,
    'layui-icon layui-icon-at',
    NULL,
    13,
    1,
    0,
    0
  );
INSERT INTO
  `rt_menu` (
    `id`,
    `title`,
    `key`,
    `route`,
    `href`,
    `type`,
    `order_num`,
    `icon`,
    `open_type`,
    `pid`,
    `lid`,
    `ifshow`,
    `desktop`
  )
VALUES
  (
    87,
    '设置配置',
    NULL,
    'server/set/setConf',
    '',
    3,
    0,
    'layui-icon layui-icon-404',
    NULL,
    13,
    1,
    0,
    0
  );
INSERT INTO
  `rt_menu` (
    `id`,
    `title`,
    `key`,
    `route`,
    `href`,
    `type`,
    `order_num`,
    `icon`,
    `open_type`,
    `pid`,
    `lid`,
    `ifshow`,
    `desktop`
  )
VALUES
  (
    88,
    '更新表缓存',
    NULL,
    'server/db/update',
    '',
    2,
    0,
    'layui-icon layui-icon-refresh',
    NULL,
    35,
    1,
    0,
    0
  );
INSERT INTO
  `rt_menu` (
    `id`,
    `title`,
    `key`,
    `route`,
    `href`,
    `type`,
    `order_num`,
    `icon`,
    `open_type`,
    `pid`,
    `lid`,
    `ifshow`,
    `desktop`
  )
VALUES
  (
    89,
    '备份数据',
    NULL,
    'server/db/backup',
    '',
    2,
    0,
    'layui-icon layui-icon-templeate-1',
    NULL,
    35,
    1,
    0,
    0
  );
INSERT INTO
  `rt_menu` (
    `id`,
    `title`,
    `key`,
    `route`,
    `href`,
    `type`,
    `order_num`,
    `icon`,
    `open_type`,
    `pid`,
    `lid`,
    `ifshow`,
    `desktop`
  )
VALUES
  (
    90,
    '还原数据列表',
    NULL,
    'server/db/backupFile',
    '',
    2,
    0,
    'layui-icon layui-icon-list',
    NULL,
    35,
    1,
    0,
    0
  );
INSERT INTO
  `rt_menu` (
    `id`,
    `title`,
    `key`,
    `route`,
    `href`,
    `type`,
    `order_num`,
    `icon`,
    `open_type`,
    `pid`,
    `lid`,
    `ifshow`,
    `desktop`
  )
VALUES
  (
    91,
    '数据还原',
    NULL,
    'server/db/reback',
    '',
    2,
    0,
    'layui-icon layui-icon-water',
    NULL,
    35,
    1,
    0,
    0
  );
INSERT INTO
  `rt_menu` (
    `id`,
    `title`,
    `key`,
    `route`,
    `href`,
    `type`,
    `order_num`,
    `icon`,
    `open_type`,
    `pid`,
    `lid`,
    `ifshow`,
    `desktop`
  )
VALUES
  (
    92,
    '删除备份',
    NULL,
    'server/db/delback',
    '',
    2,
    0,
    'layui-icon layui-icon-down',
    NULL,
    35,
    1,
    0,
    0
  );
INSERT INTO
  `rt_menu` (
    `id`,
    `title`,
    `key`,
    `route`,
    `href`,
    `type`,
    `order_num`,
    `icon`,
    `open_type`,
    `pid`,
    `lid`,
    `ifshow`,
    `desktop`
  )
VALUES
  (
    93,
    '数据库文档',
    NULL,
    'server/db/doc',
    '',
    2,
    0,
    'layui-icon layui-icon-service',
    NULL,
    35,
    1,
    0,
    0
  );
INSERT INTO
  `rt_menu` (
    `id`,
    `title`,
    `key`,
    `route`,
    `href`,
    `type`,
    `order_num`,
    `icon`,
    `open_type`,
    `pid`,
    `lid`,
    `ifshow`,
    `desktop`
  )
VALUES
  (
    94,
    '编辑列表内容',
    NULL,
    'server/db/editTable',
    '',
    2,
    0,
    'layui-icon layui-icon-link',
    NULL,
    35,
    1,
    0,
    0
  );
INSERT INTO
  `rt_menu` (
    `id`,
    `title`,
    `key`,
    `route`,
    `href`,
    `type`,
    `order_num`,
    `icon`,
    `open_type`,
    `pid`,
    `lid`,
    `ifshow`,
    `desktop`
  )
VALUES
  (
    95,
    '优化表',
    NULL,
    'server/db/optimize',
    '',
    2,
    0,
    'layui-icon layui-icon-rss',
    NULL,
    35,
    1,
    0,
    0
  );
INSERT INTO
  `rt_menu` (
    `id`,
    `title`,
    `key`,
    `route`,
    `href`,
    `type`,
    `order_num`,
    `icon`,
    `open_type`,
    `pid`,
    `lid`,
    `ifshow`,
    `desktop`
  )
VALUES
  (
    96,
    '修复表',
    NULL,
    'server/db/repair',
    '',
    2,
    0,
    'layui-icon layui-icon-rate-solid',
    NULL,
    35,
    1,
    0,
    0
  );
INSERT INTO
  `rt_menu` (
    `id`,
    `title`,
    `key`,
    `route`,
    `href`,
    `type`,
    `order_num`,
    `icon`,
    `open_type`,
    `pid`,
    `lid`,
    `ifshow`,
    `desktop`
  )
VALUES
  (
    97,
    '删除表',
    NULL,
    'server/db/delTable',
    '',
    2,
    0,
    'layui-icon layui-icon-subtraction',
    NULL,
    35,
    1,
    0,
    0
  );
INSERT INTO
  `rt_menu` (
    `id`,
    `title`,
    `key`,
    `route`,
    `href`,
    `type`,
    `order_num`,
    `icon`,
    `open_type`,
    `pid`,
    `lid`,
    `ifshow`,
    `desktop`
  )
VALUES
  (
    98,
    '清空表',
    NULL,
    'server/db/clear',
    '',
    2,
    0,
    'layui-icon layui-icon-unlink',
    NULL,
    35,
    1,
    0,
    0
  );
INSERT INTO
  `rt_menu` (
    `id`,
    `title`,
    `key`,
    `route`,
    `href`,
    `type`,
    `order_num`,
    `icon`,
    `open_type`,
    `pid`,
    `lid`,
    `ifshow`,
    `desktop`
  )
VALUES
  (
    99,
    '字段列表',
    NULL,
    'server/db/fieldList',
    '',
    2,
    0,
    'layui-icon layui-icon-star-fill',
    NULL,
    35,
    1,
    0,
    0
  );
INSERT INTO
  `rt_menu` (
    `id`,
    `title`,
    `key`,
    `route`,
    `href`,
    `type`,
    `order_num`,
    `icon`,
    `open_type`,
    `pid`,
    `lid`,
    `ifshow`,
    `desktop`
  )
VALUES
  (
    100,
    '展示表数据',
    NULL,
    'server/db/listData',
    '',
    2,
    0,
    'layui-icon layui-icon-transfer',
    NULL,
    35,
    1,
    0,
    0
  );
INSERT INTO
  `rt_menu` (
    `id`,
    `title`,
    `key`,
    `route`,
    `href`,
    `type`,
    `order_num`,
    `icon`,
    `open_type`,
    `pid`,
    `lid`,
    `ifshow`,
    `desktop`
  )
VALUES
  (
    101,
    '编辑数据',
    NULL,
    'server/db/editData',
    '',
    3,
    0,
    'layui-icon layui-icon-mike',
    NULL,
    35,
    1,
    0,
    0
  );
INSERT INTO
  `rt_menu` (
    `id`,
    `title`,
    `key`,
    `route`,
    `href`,
    `type`,
    `order_num`,
    `icon`,
    `open_type`,
    `pid`,
    `lid`,
    `ifshow`,
    `desktop`
  )
VALUES
  (
    102,
    '删除数据',
    NULL,
    'server/db/delData',
    '',
    2,
    0,
    'layui-icon layui-icon-fonts-del',
    NULL,
    35,
    1,
    0,
    0
  );
INSERT INTO
  `rt_menu` (
    `id`,
    `title`,
    `key`,
    `route`,
    `href`,
    `type`,
    `order_num`,
    `icon`,
    `open_type`,
    `pid`,
    `lid`,
    `ifshow`,
    `desktop`
  )
VALUES
  (
    103,
    '数据库字段列表',
    NULL,
    'server/db/fields',
    'view/db/edit.html',
    2,
    0,
    'layui-icon layui-icon-auz',
    NULL,
    35,
    1,
    0,
    0
  );
INSERT INTO
  `rt_menu` (
    `id`,
    `title`,
    `key`,
    `route`,
    `href`,
    `type`,
    `order_num`,
    `icon`,
    `open_type`,
    `pid`,
    `lid`,
    `ifshow`,
    `desktop`
  )
VALUES
  (
    104,
    '删除字段',
    NULL,
    'server/db/delField',
    '',
    2,
    0,
    'layui-icon layui-icon-subtraction',
    NULL,
    35,
    1,
    0,
    0
  );
INSERT INTO
  `rt_menu` (
    `id`,
    `title`,
    `key`,
    `route`,
    `href`,
    `type`,
    `order_num`,
    `icon`,
    `open_type`,
    `pid`,
    `lid`,
    `ifshow`,
    `desktop`
  )
VALUES
  (
    105,
    '字段排序',
    NULL,
    'server/db/sortField',
    '',
    2,
    0,
    'layui-icon layui-icon-slider',
    NULL,
    35,
    1,
    0,
    0
  );
INSERT INTO
  `rt_menu` (
    `id`,
    `title`,
    `key`,
    `route`,
    `href`,
    `type`,
    `order_num`,
    `icon`,
    `open_type`,
    `pid`,
    `lid`,
    `ifshow`,
    `desktop`
  )
VALUES
  (
    106,
    '更改字段名',
    NULL,
    'server/db/changeFieldName',
    '',
    2,
    0,
    'layui-icon layui-icon-find-fill',
    NULL,
    35,
    1,
    0,
    0
  );
INSERT INTO
  `rt_menu` (
    `id`,
    `title`,
    `key`,
    `route`,
    `href`,
    `type`,
    `order_num`,
    `icon`,
    `open_type`,
    `pid`,
    `lid`,
    `ifshow`,
    `desktop`
  )
VALUES
  (
    107,
    '设置字段',
    NULL,
    'server/db/setStatus',
    '',
    2,
    0,
    'layui-icon layui-icon-camera',
    NULL,
    35,
    1,
    0,
    0
  );
INSERT INTO
  `rt_menu` (
    `id`,
    `title`,
    `key`,
    `route`,
    `href`,
    `type`,
    `order_num`,
    `icon`,
    `open_type`,
    `pid`,
    `lid`,
    `ifshow`,
    `desktop`
  )
VALUES
  (
    108,
    '添加字段',
    NULL,
    'server/db/addField',
    '',
    2,
    0,
    'layui-icon layui-icon-website',
    NULL,
    35,
    1,
    0,
    0
  );
INSERT INTO
  `rt_menu` (
    `id`,
    `title`,
    `key`,
    `route`,
    `href`,
    `type`,
    `order_num`,
    `icon`,
    `open_type`,
    `pid`,
    `lid`,
    `ifshow`,
    `desktop`
  )
VALUES
  (
    109,
    '表索引列表',
    NULL,
    'server/db/keysList',
    '',
    2,
    0,
    'layui-icon layui-icon-wifi',
    NULL,
    35,
    1,
    0,
    0
  );
INSERT INTO
  `rt_menu` (
    `id`,
    `title`,
    `key`,
    `route`,
    `href`,
    `type`,
    `order_num`,
    `icon`,
    `open_type`,
    `pid`,
    `lid`,
    `ifshow`,
    `desktop`
  )
VALUES
  (
    110,
    '删除索引',
    NULL,
    'server/db/delKey',
    '',
    2,
    0,
    'layui-icon layui-icon-download-circle',
    NULL,
    35,
    1,
    0,
    0
  );
INSERT INTO
  `rt_menu` (
    `id`,
    `title`,
    `key`,
    `route`,
    `href`,
    `type`,
    `order_num`,
    `icon`,
    `open_type`,
    `pid`,
    `lid`,
    `ifshow`,
    `desktop`
  )
VALUES
  (
    111,
    '设置索引',
    NULL,
    'server/db/setKey',
    '',
    2,
    0,
    'layui-icon layui-icon-layer',
    NULL,
    35,
    1,
    0,
    0
  );
INSERT INTO
  `rt_menu` (
    `id`,
    `title`,
    `key`,
    `route`,
    `href`,
    `type`,
    `order_num`,
    `icon`,
    `open_type`,
    `pid`,
    `lid`,
    `ifshow`,
    `desktop`
  )
VALUES
  (
    112,
    '创建表',
    NULL,
    'server/db/createTable',
    '',
    2,
    0,
    'layui-icon layui-icon-transfer',
    NULL,
    35,
    1,
    0,
    0
  );
INSERT INTO
  `rt_menu` (
    `id`,
    `title`,
    `key`,
    `route`,
    `href`,
    `type`,
    `order_num`,
    `icon`,
    `open_type`,
    `pid`,
    `lid`,
    `ifshow`,
    `desktop`
  )
VALUES
  (
    113,
    '复制表',
    NULL,
    'server/db/opcopy',
    '',
    2,
    0,
    'layui-icon layui-icon-fonts-clear',
    NULL,
    35,
    1,
    0,
    0
  );
INSERT INTO
  `rt_menu` (
    `id`,
    `title`,
    `key`,
    `route`,
    `href`,
    `type`,
    `order_num`,
    `icon`,
    `open_type`,
    `pid`,
    `lid`,
    `ifshow`,
    `desktop`
  )
VALUES
  (
    114,
    '执行Sql',
    NULL,
    'server/db/runSql',
    '',
    2,
    0,
    'layui-icon layui-icon-light',
    NULL,
    35,
    1,
    0,
    0
  );
INSERT INTO
  `rt_menu` (
    `id`,
    `title`,
    `key`,
    `route`,
    `href`,
    `type`,
    `order_num`,
    `icon`,
    `open_type`,
    `pid`,
    `lid`,
    `ifshow`,
    `desktop`
  )
VALUES
  (
    115,
    '获取创建Sql',
    NULL,
    'server/db/getSql',
    '',
    2,
    0,
    'layui-icon layui-icon-service',
    NULL,
    35,
    1,
    0,
    0
  );
INSERT INTO
  `rt_menu` (
    `id`,
    `title`,
    `key`,
    `route`,
    `href`,
    `type`,
    `order_num`,
    `icon`,
    `open_type`,
    `pid`,
    `lid`,
    `ifshow`,
    `desktop`
  )
VALUES
  (
    116,
    '模块管理',
    NULL,
    'server/mod/list',
    'view/mod/list.html',
    1,
    2,
    'layui-icon layui-icon-slider',
    NULL,
    2,
    1,
    0,
    1
  );
INSERT INTO
  `rt_menu` (
    `id`,
    `title`,
    `key`,
    `route`,
    `href`,
    `type`,
    `order_num`,
    `icon`,
    `open_type`,
    `pid`,
    `lid`,
    `ifshow`,
    `desktop`
  )
VALUES
  (
    117,
    '添加模块',
    NULL,
    'server/mod/add',
    '',
    2,
    0,
    'layui-icon layui-icon-read',
    NULL,
    116,
    1,
    0,
    0
  );
INSERT INTO
  `rt_menu` (
    `id`,
    `title`,
    `key`,
    `route`,
    `href`,
    `type`,
    `order_num`,
    `icon`,
    `open_type`,
    `pid`,
    `lid`,
    `ifshow`,
    `desktop`
  )
VALUES
  (
    118,
    '模块编辑前',
    NULL,
    'server/mod/editBefore',
    '',
    2,
    0,
    'layui-icon layui-icon-set-sm',
    NULL,
    116,
    1,
    0,
    0
  );
INSERT INTO
  `rt_menu` (
    `id`,
    `title`,
    `key`,
    `route`,
    `href`,
    `type`,
    `order_num`,
    `icon`,
    `open_type`,
    `pid`,
    `lid`,
    `ifshow`,
    `desktop`
  )
VALUES
  (
    119,
    '编辑模块',
    NULL,
    'server/mod/edit',
    '',
    2,
    0,
    'layui-icon layui-icon-share',
    NULL,
    116,
    1,
    0,
    0
  );
INSERT INTO
  `rt_menu` (
    `id`,
    `title`,
    `key`,
    `route`,
    `href`,
    `type`,
    `order_num`,
    `icon`,
    `open_type`,
    `pid`,
    `lid`,
    `ifshow`,
    `desktop`
  )
VALUES
  (
    120,
    '删除模块',
    NULL,
    'server/mod/delete',
    '',
    2,
    0,
    'layui-icon layui-icon-chat',
    NULL,
    116,
    1,
    0,
    0
  );
INSERT INTO
  `rt_menu` (
    `id`,
    `title`,
    `key`,
    `route`,
    `href`,
    `type`,
    `order_num`,
    `icon`,
    `open_type`,
    `pid`,
    `lid`,
    `ifshow`,
    `desktop`
  )
VALUES
  (
    121,
    '模块添加前',
    NULL,
    'server/mod/addBefore',
    '',
    3,
    0,
    'layui-icon layui-icon-slider',
    NULL,
    116,
    1,
    0,
    0
  );
INSERT INTO
  `rt_menu` (
    `id`,
    `title`,
    `key`,
    `route`,
    `href`,
    `type`,
    `order_num`,
    `icon`,
    `open_type`,
    `pid`,
    `lid`,
    `ifshow`,
    `desktop`
  )
VALUES
  (
    122,
    '批量删除表',
    NULL,
    'server/db/batchRemove',
    '',
    2,
    0,
    'layui-icon layui-icon-fonts-del',
    NULL,
    35,
    1,
    0,
    0
  );
INSERT INTO
  `rt_menu` (
    `id`,
    `title`,
    `key`,
    `route`,
    `href`,
    `type`,
    `order_num`,
    `icon`,
    `open_type`,
    `pid`,
    `lid`,
    `ifshow`,
    `desktop`
  )
VALUES
  (
    123,
    '列表编辑字段',
    NULL,
    'server/menu/editData',
    '',
    2,
    0,
    'layui-icon layui-icon-key',
    NULL,
    9,
    1,
    0,
    0
  );
INSERT INTO
  `rt_menu` (
    `id`,
    `title`,
    `key`,
    `route`,
    `href`,
    `type`,
    `order_num`,
    `icon`,
    `open_type`,
    `pid`,
    `lid`,
    `ifshow`,
    `desktop`
  )
VALUES
  (
    124,
    '全局常量管理',
    NULL,
    'server/mod/params',
    '',
    2,
    0,
    'layui-icon layui-icon-dollar',
    NULL,
    116,
    1,
    0,
    0
  );
INSERT INTO
  `rt_menu` (
    `id`,
    `title`,
    `key`,
    `route`,
    `href`,
    `type`,
    `order_num`,
    `icon`,
    `open_type`,
    `pid`,
    `lid`,
    `ifshow`,
    `desktop`
  )
VALUES
  (
    125,
    '常量编辑前',
    NULL,
    'server/mod/paramsBefore',
    '',
    2,
    0,
    'layui-icon layui-icon-at',
    NULL,
    116,
    1,
    0,
    0
  );
INSERT INTO
  `rt_menu` (
    `id`,
    `title`,
    `key`,
    `route`,
    `href`,
    `type`,
    `order_num`,
    `icon`,
    `open_type`,
    `pid`,
    `lid`,
    `ifshow`,
    `desktop`
  )
VALUES
  (
    126,
    '添加全局常量',
    NULL,
    'server/mod/paramsAdd',
    '',
    2,
    0,
    'layui-icon layui-icon-addition',
    NULL,
    116,
    1,
    0,
    0
  );
INSERT INTO
  `rt_menu` (
    `id`,
    `title`,
    `key`,
    `route`,
    `href`,
    `type`,
    `order_num`,
    `icon`,
    `open_type`,
    `pid`,
    `lid`,
    `ifshow`,
    `desktop`
  )
VALUES
  (
    127,
    '编辑全局常量',
    NULL,
    'server/mod/paramsEdit',
    '',
    2,
    0,
    'layui-icon layui-icon-print',
    NULL,
    116,
    1,
    0,
    0
  );
INSERT INTO
  `rt_menu` (
    `id`,
    `title`,
    `key`,
    `route`,
    `href`,
    `type`,
    `order_num`,
    `icon`,
    `open_type`,
    `pid`,
    `lid`,
    `ifshow`,
    `desktop`
  )
VALUES
  (
    128,
    '删除全局常量',
    NULL,
    'server/mod/paramDelete',
    '',
    2,
    0,
    'layui-icon layui-icon-subtraction',
    NULL,
    116,
    1,
    0,
    0
  );
INSERT INTO
  `rt_menu` (
    `id`,
    `title`,
    `key`,
    `route`,
    `href`,
    `type`,
    `order_num`,
    `icon`,
    `open_type`,
    `pid`,
    `lid`,
    `ifshow`,
    `desktop`
  )
VALUES
  (
    130,
    '添加数据',
    NULL,
    'server/db/addData',
    'views/db/data-add.html',
    2,
    0,
    'layui-icon layui-icon-mike',
    NULL,
    35,
    1,
    0,
    0
  );
INSERT INTO
  `rt_menu` (
    `id`,
    `title`,
    `key`,
    `route`,
    `href`,
    `type`,
    `order_num`,
    `icon`,
    `open_type`,
    `pid`,
    `lid`,
    `ifshow`,
    `desktop`
  )
VALUES
  (
    131,
    '数据库列表',
    NULL,
    'server/db/confList',
    '',
    2,
    0,
    'layui-icon layui-icon-wifi',
    NULL,
    35,
    1,
    0,
    0
  );
INSERT INTO
  `rt_menu` (
    `id`,
    `title`,
    `key`,
    `route`,
    `href`,
    `type`,
    `order_num`,
    `icon`,
    `open_type`,
    `pid`,
    `lid`,
    `ifshow`,
    `desktop`
  )
VALUES
  (
    132,
    '添加数据库',
    NULL,
    'server/db/confAdd',
    '',
    2,
    0,
    'layui-icon layui-icon-email',
    NULL,
    35,
    1,
    0,
    0
  );
INSERT INTO
  `rt_menu` (
    `id`,
    `title`,
    `key`,
    `route`,
    `href`,
    `type`,
    `order_num`,
    `icon`,
    `open_type`,
    `pid`,
    `lid`,
    `ifshow`,
    `desktop`
  )
VALUES
  (
    133,
    '编辑数据库',
    NULL,
    'server/db/confEdit',
    '',
    2,
    0,
    'layui-icon layui-icon-rss',
    NULL,
    35,
    1,
    0,
    0
  );
INSERT INTO
  `rt_menu` (
    `id`,
    `title`,
    `key`,
    `route`,
    `href`,
    `type`,
    `order_num`,
    `icon`,
    `open_type`,
    `pid`,
    `lid`,
    `ifshow`,
    `desktop`
  )
VALUES
  (
    134,
    '测试数据库连接',
    NULL,
    'server/db/confTest',
    '',
    2,
    0,
    'layui-icon layui-icon-logout',
    NULL,
    35,
    1,
    0,
    0
  );
INSERT INTO
  `rt_menu` (
    `id`,
    `title`,
    `key`,
    `route`,
    `href`,
    `type`,
    `order_num`,
    `icon`,
    `open_type`,
    `pid`,
    `lid`,
    `ifshow`,
    `desktop`
  )
VALUES
  (
    135,
    '删除数据库',
    NULL,
    'server/db/confDel',
    '',
    2,
    0,
    'layui-icon layui-icon-subtraction',
    NULL,
    35,
    1,
    0,
    0
  );
INSERT INTO
  `rt_menu` (
    `id`,
    `title`,
    `key`,
    `route`,
    `href`,
    `type`,
    `order_num`,
    `icon`,
    `open_type`,
    `pid`,
    `lid`,
    `ifshow`,
    `desktop`
  )
VALUES
  (
    136,
    '更换数据库',
    NULL,
    'server/db/confChange',
    '',
    2,
    0,
    'layui-icon layui-icon-transfer',
    NULL,
    35,
    1,
    0,
    0
  );
INSERT INTO
  `rt_menu` (
    `id`,
    `title`,
    `key`,
    `route`,
    `href`,
    `type`,
    `order_num`,
    `icon`,
    `open_type`,
    `pid`,
    `lid`,
    `ifshow`,
    `desktop`
  )
VALUES
  (
    137,
    '编辑数据库前',
    NULL,
    'server/db/confEditBefore',
    '',
    3,
    0,
    'layui-icon layui-icon-snowflake',
    NULL,
    35,
    1,
    0,
    0
  );
INSERT INTO
  `rt_menu` (
    `id`,
    `title`,
    `key`,
    `route`,
    `href`,
    `type`,
    `order_num`,
    `icon`,
    `open_type`,
    `pid`,
    `lid`,
    `ifshow`,
    `desktop`
  )
VALUES
  (
    138,
    '保护列表',
    NULL,
    'server/db/safeList',
    '',
    2,
    0,
    'layui-icon layui-icon-camera',
    NULL,
    35,
    1,
    0,
    0
  );
INSERT INTO
  `rt_menu` (
    `id`,
    `title`,
    `key`,
    `route`,
    `href`,
    `type`,
    `order_num`,
    `icon`,
    `open_type`,
    `pid`,
    `lid`,
    `ifshow`,
    `desktop`
  )
VALUES
  (
    139,
    '添加保护',
    NULL,
    'server/db/safeAdd',
    '',
    2,
    0,
    'layui-icon layui-icon-addition',
    NULL,
    35,
    1,
    0,
    0
  );
INSERT INTO
  `rt_menu` (
    `id`,
    `title`,
    `key`,
    `route`,
    `href`,
    `type`,
    `order_num`,
    `icon`,
    `open_type`,
    `pid`,
    `lid`,
    `ifshow`,
    `desktop`
  )
VALUES
  (
    140,
    '删除保护',
    NULL,
    'server/db/safeDel',
    '',
    2,
    0,
    'layui-icon layui-icon-subtraction',
    NULL,
    35,
    1,
    0,
    0
  );
INSERT INTO
  `rt_menu` (
    `id`,
    `title`,
    `key`,
    `route`,
    `href`,
    `type`,
    `order_num`,
    `icon`,
    `open_type`,
    `pid`,
    `lid`,
    `ifshow`,
    `desktop`
  )
VALUES
  (
    141,
    '添加数据库',
    NULL,
    'server/db/creatDatabase',
    '',
    2,
    0,
    'layui-icon layui-icon-align-left',
    NULL,
    35,
    1,
    0,
    0
  );
INSERT INTO
  `rt_menu` (
    `id`,
    `title`,
    `key`,
    `route`,
    `href`,
    `type`,
    `order_num`,
    `icon`,
    `open_type`,
    `pid`,
    `lid`,
    `ifshow`,
    `desktop`
  )
VALUES
  (
    142,
    '上传文件',
    NULL,
    'server/upload/index',
    '',
    3,
    0,
    'layui-icon layui-icon-upload-drag',
    NULL,
    6,
    1,
    1,
    0
  );
INSERT INTO
  `rt_menu` (
    `id`,
    `title`,
    `key`,
    `route`,
    `href`,
    `type`,
    `order_num`,
    `icon`,
    `open_type`,
    `pid`,
    `lid`,
    `ifshow`,
    `desktop`
  )
VALUES
  (
    143,
    '注销登录',
    NULL,
    'server/admin/loginOut',
    '',
    2,
    0,
    'layui-icon layui-icon-delete',
    NULL,
    6,
    1,
    1,
    0
  );
INSERT INTO
  `rt_menu` (
    `id`,
    `title`,
    `key`,
    `route`,
    `href`,
    `type`,
    `order_num`,
    `icon`,
    `open_type`,
    `pid`,
    `lid`,
    `ifshow`,
    `desktop`
  )
VALUES
  (
    144,
    '计划任务',
    'crons',
    'server/crons/list',
    'view/crons/list.html',
    1,
    9,
    'layui-icon layui-icon-android',
    NULL,
    2,
    1,
    0,
    0
  );
INSERT INTO
  `rt_menu` (
    `id`,
    `title`,
    `key`,
    `route`,
    `href`,
    `type`,
    `order_num`,
    `icon`,
    `open_type`,
    `pid`,
    `lid`,
    `ifshow`,
    `desktop`
  )
VALUES
  (
    145,
    '计划任务添加',
    'crons',
    'server/crons/add',
    'view/crons/edit.html',
    3,
    0,
    '',
    NULL,
    144,
    1,
    0,
    0
  );
INSERT INTO
  `rt_menu` (
    `id`,
    `title`,
    `key`,
    `route`,
    `href`,
    `type`,
    `order_num`,
    `icon`,
    `open_type`,
    `pid`,
    `lid`,
    `ifshow`,
    `desktop`
  )
VALUES
  (
    146,
    '计划任务编辑',
    'crons',
    'server/crons/edit',
    'view/crons/edit.html',
    3,
    0,
    '',
    NULL,
    144,
    1,
    0,
    0
  );
INSERT INTO
  `rt_menu` (
    `id`,
    `title`,
    `key`,
    `route`,
    `href`,
    `type`,
    `order_num`,
    `icon`,
    `open_type`,
    `pid`,
    `lid`,
    `ifshow`,
    `desktop`
  )
VALUES
  (
    147,
    '计划任务删除',
    'crons',
    'server/crons/del',
    '',
    3,
    0,
    '',
    NULL,
    144,
    1,
    0,
    0
  );
INSERT INTO
  `rt_menu` (
    `id`,
    `title`,
    `key`,
    `route`,
    `href`,
    `type`,
    `order_num`,
    `icon`,
    `open_type`,
    `pid`,
    `lid`,
    `ifshow`,
    `desktop`
  )
VALUES
  (
    148,
    '计划任务编辑前',
    'crons',
    'server/crons/editBefore',
    '',
    3,
    0,
    '',
    NULL,
    144,
    1,
    0,
    0
  );
INSERT INTO
  `rt_menu` (
    `id`,
    `title`,
    `key`,
    `route`,
    `href`,
    `type`,
    `order_num`,
    `icon`,
    `open_type`,
    `pid`,
    `lid`,
    `ifshow`,
    `desktop`
  )
VALUES
  (
    149,
    '演示文稿',
    NULL,
    'server/ppt/list',
    'view/ppt/list.html',
    1,
    20,
    'layui-icon layui-icon-transfer',
    NULL,
    1,
    1,
    0,
    1
  );
INSERT INTO
  `rt_menu` (
    `id`,
    `title`,
    `key`,
    `route`,
    `href`,
    `type`,
    `order_num`,
    `icon`,
    `open_type`,
    `pid`,
    `lid`,
    `ifshow`,
    `desktop`
  )
VALUES
  (
    150,
    '演示文稿添加',
    NULL,
    'server/ppt/add',
    'view/ppt/edit.html',
    3,
    0,
    '',
    NULL,
    149,
    1,
    0,
    0
  );
INSERT INTO
  `rt_menu` (
    `id`,
    `title`,
    `key`,
    `route`,
    `href`,
    `type`,
    `order_num`,
    `icon`,
    `open_type`,
    `pid`,
    `lid`,
    `ifshow`,
    `desktop`
  )
VALUES
  (
    151,
    '演示文稿编辑',
    NULL,
    'server/ppt/edit',
    'view/ppt/edit.html',
    3,
    0,
    '',
    NULL,
    149,
    1,
    0,
    0
  );
INSERT INTO
  `rt_menu` (
    `id`,
    `title`,
    `key`,
    `route`,
    `href`,
    `type`,
    `order_num`,
    `icon`,
    `open_type`,
    `pid`,
    `lid`,
    `ifshow`,
    `desktop`
  )
VALUES
  (
    152,
    '演示文稿删除',
    NULL,
    'server/ppt/del',
    '',
    3,
    0,
    '',
    NULL,
    149,
    1,
    0,
    0
  );
INSERT INTO
  `rt_menu` (
    `id`,
    `title`,
    `key`,
    `route`,
    `href`,
    `type`,
    `order_num`,
    `icon`,
    `open_type`,
    `pid`,
    `lid`,
    `ifshow`,
    `desktop`
  )
VALUES
  (
    153,
    '演示文稿编辑前',
    NULL,
    'server/ppt/editBefore',
    '',
    3,
    0,
    '',
    NULL,
    149,
    1,
    0,
    0
  );
INSERT INTO
  `rt_menu` (
    `id`,
    `title`,
    `key`,
    `route`,
    `href`,
    `type`,
    `order_num`,
    `icon`,
    `open_type`,
    `pid`,
    `lid`,
    `ifshow`,
    `desktop`
  )
VALUES
  (
    154,
    '思维导图',
    NULL,
    'server/mind/list',
    'view/mind/list.html',
    1,
    0,
    'layui-icon layui-icon-auz',
    NULL,
    1,
    1,
    0,
    1
  );
INSERT INTO
  `rt_menu` (
    `id`,
    `title`,
    `key`,
    `route`,
    `href`,
    `type`,
    `order_num`,
    `icon`,
    `open_type`,
    `pid`,
    `lid`,
    `ifshow`,
    `desktop`
  )
VALUES
  (
    155,
    '思维导图添加',
    NULL,
    'server/mind/add',
    'view/mind/edit.html',
    3,
    0,
    '',
    NULL,
    154,
    1,
    0,
    0
  );
INSERT INTO
  `rt_menu` (
    `id`,
    `title`,
    `key`,
    `route`,
    `href`,
    `type`,
    `order_num`,
    `icon`,
    `open_type`,
    `pid`,
    `lid`,
    `ifshow`,
    `desktop`
  )
VALUES
  (
    156,
    '思维导图编辑',
    NULL,
    'server/mind/edit',
    'view/mind/edit.html',
    3,
    0,
    '',
    NULL,
    154,
    1,
    0,
    0
  );
INSERT INTO
  `rt_menu` (
    `id`,
    `title`,
    `key`,
    `route`,
    `href`,
    `type`,
    `order_num`,
    `icon`,
    `open_type`,
    `pid`,
    `lid`,
    `ifshow`,
    `desktop`
  )
VALUES
  (
    157,
    '思维导图删除',
    NULL,
    'server/mind/del',
    '',
    3,
    0,
    '',
    NULL,
    154,
    1,
    0,
    0
  );
INSERT INTO
  `rt_menu` (
    `id`,
    `title`,
    `key`,
    `route`,
    `href`,
    `type`,
    `order_num`,
    `icon`,
    `open_type`,
    `pid`,
    `lid`,
    `ifshow`,
    `desktop`
  )
VALUES
  (
    158,
    '思维导图编辑前',
    NULL,
    'server/mind/editBefore',
    '',
    3,
    0,
    '',
    NULL,
    154,
    1,
    0,
    0
  );
INSERT INTO
  `rt_menu` (
    `id`,
    `title`,
    `key`,
    `route`,
    `href`,
    `type`,
    `order_num`,
    `icon`,
    `open_type`,
    `pid`,
    `lid`,
    `ifshow`,
    `desktop`
  )
VALUES
  (
    159,
    '表格管理',
    NULL,
    'server/excel/list',
    'view/excel/list.html',
    1,
    0,
    'layui-icon layui-icon-tabs',
    NULL,
    1,
    1,
    0,
    1
  );
INSERT INTO
  `rt_menu` (
    `id`,
    `title`,
    `key`,
    `route`,
    `href`,
    `type`,
    `order_num`,
    `icon`,
    `open_type`,
    `pid`,
    `lid`,
    `ifshow`,
    `desktop`
  )
VALUES
  (
    160,
    'excel管理添加',
    NULL,
    'server/excel/add',
    'view/excel/edit.html',
    3,
    0,
    '',
    NULL,
    159,
    1,
    0,
    0
  );
INSERT INTO
  `rt_menu` (
    `id`,
    `title`,
    `key`,
    `route`,
    `href`,
    `type`,
    `order_num`,
    `icon`,
    `open_type`,
    `pid`,
    `lid`,
    `ifshow`,
    `desktop`
  )
VALUES
  (
    161,
    'excel管理编辑',
    NULL,
    'server/excel/edit',
    'view/excel/edit.html',
    3,
    0,
    '',
    NULL,
    159,
    1,
    0,
    0
  );
INSERT INTO
  `rt_menu` (
    `id`,
    `title`,
    `key`,
    `route`,
    `href`,
    `type`,
    `order_num`,
    `icon`,
    `open_type`,
    `pid`,
    `lid`,
    `ifshow`,
    `desktop`
  )
VALUES
  (
    162,
    'excel管理删除',
    NULL,
    'server/excel/del',
    '',
    3,
    0,
    '',
    NULL,
    159,
    1,
    0,
    0
  );
INSERT INTO
  `rt_menu` (
    `id`,
    `title`,
    `key`,
    `route`,
    `href`,
    `type`,
    `order_num`,
    `icon`,
    `open_type`,
    `pid`,
    `lid`,
    `ifshow`,
    `desktop`
  )
VALUES
  (
    163,
    'excel管理编辑前',
    NULL,
    'server/excel/editBefore',
    '',
    3,
    0,
    '',
    NULL,
    159,
    1,
    0,
    0
  );
INSERT INTO
  `rt_menu` (
    `id`,
    `title`,
    `key`,
    `route`,
    `href`,
    `type`,
    `order_num`,
    `icon`,
    `open_type`,
    `pid`,
    `lid`,
    `ifshow`,
    `desktop`
  )
VALUES
  (
    164,
    '导入EXCEL并存库',
    NULL,
    'server/excel/upload',
    '',
    3,
    0,
    'layui-icon layui-icon-fonts-code',
    NULL,
    159,
    1,
    0,
    0
  );
INSERT INTO
  `rt_menu` (
    `id`,
    `title`,
    `key`,
    `route`,
    `href`,
    `type`,
    `order_num`,
    `icon`,
    `open_type`,
    `pid`,
    `lid`,
    `ifshow`,
    `desktop`
  )
VALUES
  (
    165,
    '流程图',
    NULL,
    'server/flow/list',
    'view/flow/list.html',
    1,
    0,
    'layui-icon layui-icon-spread-left',
    NULL,
    1,
    1,
    0,
    1
  );
INSERT INTO
  `rt_menu` (
    `id`,
    `title`,
    `key`,
    `route`,
    `href`,
    `type`,
    `order_num`,
    `icon`,
    `open_type`,
    `pid`,
    `lid`,
    `ifshow`,
    `desktop`
  )
VALUES
  (
    166,
    '流程图添加',
    NULL,
    'server/flow/add',
    'view/flow/edit.html',
    3,
    0,
    '',
    NULL,
    165,
    1,
    0,
    0
  );
INSERT INTO
  `rt_menu` (
    `id`,
    `title`,
    `key`,
    `route`,
    `href`,
    `type`,
    `order_num`,
    `icon`,
    `open_type`,
    `pid`,
    `lid`,
    `ifshow`,
    `desktop`
  )
VALUES
  (
    167,
    '流程图编辑',
    NULL,
    'server/flow/edit',
    'view/flow/edit.html',
    3,
    0,
    '',
    NULL,
    165,
    1,
    0,
    0
  );
INSERT INTO
  `rt_menu` (
    `id`,
    `title`,
    `key`,
    `route`,
    `href`,
    `type`,
    `order_num`,
    `icon`,
    `open_type`,
    `pid`,
    `lid`,
    `ifshow`,
    `desktop`
  )
VALUES
  (
    168,
    '流程图删除',
    NULL,
    'server/flow/del',
    '',
    3,
    0,
    '',
    NULL,
    165,
    1,
    0,
    0
  );
INSERT INTO
  `rt_menu` (
    `id`,
    `title`,
    `key`,
    `route`,
    `href`,
    `type`,
    `order_num`,
    `icon`,
    `open_type`,
    `pid`,
    `lid`,
    `ifshow`,
    `desktop`
  )
VALUES
  (
    169,
    '流程图编辑前',
    NULL,
    'server/flow/editBefore',
    '',
    3,
    0,
    '',
    NULL,
    165,
    1,
    0,
    0
  );
INSERT INTO
  `rt_menu` (
    `id`,
    `title`,
    `key`,
    `route`,
    `href`,
    `type`,
    `order_num`,
    `icon`,
    `open_type`,
    `pid`,
    `lid`,
    `ifshow`,
    `desktop`
  )
VALUES
  (
    170,
    '文档管理',
    NULL,
    'server/doc/list',
    'view/doc/list.html',
    1,
    0,
    'layui-icon layui-icon-email',
    NULL,
    1,
    1,
    0,
    1
  );
INSERT INTO
  `rt_menu` (
    `id`,
    `title`,
    `key`,
    `route`,
    `href`,
    `type`,
    `order_num`,
    `icon`,
    `open_type`,
    `pid`,
    `lid`,
    `ifshow`,
    `desktop`
  )
VALUES
  (
    171,
    '文档管理添加',
    NULL,
    'server/doc/add',
    'view/doc/edit.html',
    3,
    0,
    '',
    NULL,
    170,
    1,
    0,
    0
  );
INSERT INTO
  `rt_menu` (
    `id`,
    `title`,
    `key`,
    `route`,
    `href`,
    `type`,
    `order_num`,
    `icon`,
    `open_type`,
    `pid`,
    `lid`,
    `ifshow`,
    `desktop`
  )
VALUES
  (
    172,
    '文档管理编辑',
    NULL,
    'server/doc/edit',
    'view/doc/edit.html',
    3,
    0,
    '',
    NULL,
    170,
    1,
    0,
    0
  );
INSERT INTO
  `rt_menu` (
    `id`,
    `title`,
    `key`,
    `route`,
    `href`,
    `type`,
    `order_num`,
    `icon`,
    `open_type`,
    `pid`,
    `lid`,
    `ifshow`,
    `desktop`
  )
VALUES
  (
    173,
    '文档管理删除',
    NULL,
    'server/doc/del',
    '',
    3,
    0,
    '',
    NULL,
    170,
    1,
    0,
    0
  );
INSERT INTO
  `rt_menu` (
    `id`,
    `title`,
    `key`,
    `route`,
    `href`,
    `type`,
    `order_num`,
    `icon`,
    `open_type`,
    `pid`,
    `lid`,
    `ifshow`,
    `desktop`
  )
VALUES
  (
    174,
    '文档管理编辑前',
    NULL,
    'server/doc/editBefore',
    '',
    3,
    0,
    '',
    NULL,
    170,
    1,
    0,
    0
  );
INSERT INTO
  `rt_menu` (
    `id`,
    `title`,
    `key`,
    `route`,
    `href`,
    `type`,
    `order_num`,
    `icon`,
    `open_type`,
    `pid`,
    `lid`,
    `ifshow`,
    `desktop`
  )
VALUES
  (
    175,
    '文档添加前',
    NULL,
    'server/doc/addBefore',
    '',
    3,
    0,
    'layui-icon layui-icon-at',
    NULL,
    170,
    1,
    0,
    0
  );
INSERT INTO
  `rt_menu` (
    `id`,
    `title`,
    `key`,
    `route`,
    `href`,
    `type`,
    `order_num`,
    `icon`,
    `open_type`,
    `pid`,
    `lid`,
    `ifshow`,
    `desktop`
  )
VALUES
  (
    176,
    '上传文件',
    NULL,
    'server/doc/upload',
    '',
    3,
    0,
    'layui-icon layui-icon-addition',
    NULL,
    170,
    1,
    0,
    0
  );
INSERT INTO
  `rt_menu` (
    `id`,
    `title`,
    `key`,
    `route`,
    `href`,
    `type`,
    `order_num`,
    `icon`,
    `open_type`,
    `pid`,
    `lid`,
    `ifshow`,
    `desktop`
  )
VALUES
  (
    177,
    '新增文档',
    NULL,
    'server/doc/addmd',
    '',
    2,
    0,
    'layui-icon layui-icon-praise',
    NULL,
    170,
    1,
    0,
    0
  );
INSERT INTO
  `rt_menu` (
    `id`,
    `title`,
    `key`,
    `route`,
    `href`,
    `type`,
    `order_num`,
    `icon`,
    `open_type`,
    `pid`,
    `lid`,
    `ifshow`,
    `desktop`
  )
VALUES
  (
    178,
    '文档列表',
    NULL,
    'server/doc/listmd',
    '',
    3,
    0,
    'layui-icon layui-icon-link',
    NULL,
    170,
    1,
    0,
    0
  );
INSERT INTO
  `rt_menu` (
    `id`,
    `title`,
    `key`,
    `route`,
    `href`,
    `type`,
    `order_num`,
    `icon`,
    `open_type`,
    `pid`,
    `lid`,
    `ifshow`,
    `desktop`
  )
VALUES
  (
    179,
    '编辑文档前',
    NULL,
    'server/doc/editmdBefore',
    '',
    3,
    0,
    'layui-icon layui-icon-read',
    NULL,
    170,
    1,
    0,
    0
  );
INSERT INTO
  `rt_menu` (
    `id`,
    `title`,
    `key`,
    `route`,
    `href`,
    `type`,
    `order_num`,
    `icon`,
    `open_type`,
    `pid`,
    `lid`,
    `ifshow`,
    `desktop`
  )
VALUES
  (
    180,
    '编辑文档',
    NULL,
    'server/doc/editmd',
    '',
    3,
    0,
    'layui-icon layui-icon-transfer',
    NULL,
    170,
    1,
    0,
    0
  );
INSERT INTO
  `rt_menu` (
    `id`,
    `title`,
    `key`,
    `route`,
    `href`,
    `type`,
    `order_num`,
    `icon`,
    `open_type`,
    `pid`,
    `lid`,
    `ifshow`,
    `desktop`
  )
VALUES
  (
    181,
    '删除文档',
    NULL,
    'server/doc/delmd',
    '',
    3,
    0,
    'layui-icon layui-icon-logout',
    NULL,
    170,
    1,
    0,
    0
  );
INSERT INTO
  `rt_menu` (
    `id`,
    `title`,
    `key`,
    `route`,
    `href`,
    `type`,
    `order_num`,
    `icon`,
    `open_type`,
    `pid`,
    `lid`,
    `ifshow`,
    `desktop`
  )
VALUES
  (
    182,
    '编辑文档列表',
    NULL,
    'server/doc/editData',
    '',
    3,
    0,
    'layui-icon layui-icon-email',
    NULL,
    170,
    1,
    0,
    0
  );
INSERT INTO
  `rt_menu` (
    `id`,
    `title`,
    `key`,
    `route`,
    `href`,
    `type`,
    `order_num`,
    `icon`,
    `open_type`,
    `pid`,
    `lid`,
    `ifshow`,
    `desktop`
  )
VALUES
  (
    183,
    '回写数据',
    NULL,
    'server/doc/back',
    '',
    3,
    0,
    'layui-icon layui-icon-windows',
    NULL,
    170,
    1,
    0,
    0
  );
INSERT INTO
  `rt_menu` (
    `id`,
    `title`,
    `key`,
    `route`,
    `href`,
    `type`,
    `order_num`,
    `icon`,
    `open_type`,
    `pid`,
    `lid`,
    `ifshow`,
    `desktop`
  )
VALUES
  (
    184,
    '接口设计',
    NULL,
    'server/api/list',
    'view/api/list.html',
    1,
    0,
    'layui-icon layui-icon-website',
    NULL,
    2,
    1,
    0,
    1
  );
INSERT INTO
  `rt_menu` (
    `id`,
    `title`,
    `key`,
    `route`,
    `href`,
    `type`,
    `order_num`,
    `icon`,
    `open_type`,
    `pid`,
    `lid`,
    `ifshow`,
    `desktop`
  )
VALUES
  (
    185,
    '接口设计添加',
    NULL,
    'server/api/add',
    'view/api/edit.html',
    3,
    0,
    '',
    NULL,
    184,
    1,
    0,
    0
  );
INSERT INTO
  `rt_menu` (
    `id`,
    `title`,
    `key`,
    `route`,
    `href`,
    `type`,
    `order_num`,
    `icon`,
    `open_type`,
    `pid`,
    `lid`,
    `ifshow`,
    `desktop`
  )
VALUES
  (
    186,
    '接口设计编辑',
    NULL,
    'server/api/edit',
    'view/api/edit.html',
    3,
    0,
    '',
    NULL,
    184,
    1,
    0,
    0
  );
INSERT INTO
  `rt_menu` (
    `id`,
    `title`,
    `key`,
    `route`,
    `href`,
    `type`,
    `order_num`,
    `icon`,
    `open_type`,
    `pid`,
    `lid`,
    `ifshow`,
    `desktop`
  )
VALUES
  (
    187,
    '接口设计删除',
    NULL,
    'server/api/del',
    '',
    3,
    0,
    '',
    NULL,
    184,
    1,
    0,
    0
  );
INSERT INTO
  `rt_menu` (
    `id`,
    `title`,
    `key`,
    `route`,
    `href`,
    `type`,
    `order_num`,
    `icon`,
    `open_type`,
    `pid`,
    `lid`,
    `ifshow`,
    `desktop`
  )
VALUES
  (
    188,
    '接口设计编辑前',
    NULL,
    'server/api/editBefore',
    '',
    3,
    0,
    '',
    NULL,
    184,
    1,
    0,
    0
  );
INSERT INTO
  `rt_menu` (
    `id`,
    `title`,
    `key`,
    `route`,
    `href`,
    `type`,
    `order_num`,
    `icon`,
    `open_type`,
    `pid`,
    `lid`,
    `ifshow`,
    `desktop`
  )
VALUES
  (
    189,
    '接口添加前',
    NULL,
    'server/api/addBefore',
    '',
    3,
    0,
    'layui-icon layui-icon-key',
    NULL,
    184,
    1,
    0,
    0
  );
INSERT INTO
  `rt_menu` (
    `id`,
    `title`,
    `key`,
    `route`,
    `href`,
    `type`,
    `order_num`,
    `icon`,
    `open_type`,
    `pid`,
    `lid`,
    `ifshow`,
    `desktop`
  )
VALUES
  (
    190,
    '文章管理',
    NULL,
    'server/art',
    '',
    1,
    0,
    'layui-icon layui-icon-slider',
    NULL,
    1,
    1,
    0,
    0
  );
INSERT INTO
  `rt_menu` (
    `id`,
    `title`,
    `key`,
    `route`,
    `href`,
    `type`,
    `order_num`,
    `icon`,
    `open_type`,
    `pid`,
    `lid`,
    `ifshow`,
    `desktop`
  )
VALUES
  (
    194,
    '文章列表',
    NULL,
    'server/art/list',
    '',
    3,
    0,
    'layui-icon layui-icon-username',
    NULL,
    190,
    1,
    0,
    0
  );
INSERT INTO
  `rt_menu` (
    `id`,
    `title`,
    `key`,
    `route`,
    `href`,
    `type`,
    `order_num`,
    `icon`,
    `open_type`,
    `pid`,
    `lid`,
    `ifshow`,
    `desktop`
  )
VALUES
  (
    195,
    '添加文章',
    NULL,
    'server/art/add',
    '',
    3,
    0,
    'layui-icon layui-icon-username',
    NULL,
    190,
    1,
    0,
    0
  );
INSERT INTO
  `rt_menu` (
    `id`,
    `title`,
    `key`,
    `route`,
    `href`,
    `type`,
    `order_num`,
    `icon`,
    `open_type`,
    `pid`,
    `lid`,
    `ifshow`,
    `desktop`
  )
VALUES
  (
    196,
    '编辑文章',
    NULL,
    'server/art/edit',
    '',
    3,
    0,
    'layui-icon layui-icon-username',
    NULL,
    190,
    1,
    0,
    0
  );
INSERT INTO
  `rt_menu` (
    `id`,
    `title`,
    `key`,
    `route`,
    `href`,
    `type`,
    `order_num`,
    `icon`,
    `open_type`,
    `pid`,
    `lid`,
    `ifshow`,
    `desktop`
  )
VALUES
  (
    197,
    '接口参数列表',
    NULL,
    'server/apiparams/list',
    '',
    2,
    0,
    'layui-icon layui-icon-key',
    NULL,
    184,
    1,
    0,
    0
  );
INSERT INTO
  `rt_menu` (
    `id`,
    `title`,
    `key`,
    `route`,
    `href`,
    `type`,
    `order_num`,
    `icon`,
    `open_type`,
    `pid`,
    `lid`,
    `ifshow`,
    `desktop`
  )
VALUES
  (
    198,
    '从数据库添加参数',
    NULL,
    'server/apiparams/addFromDb',
    '',
    2,
    0,
    'layui-icon layui-icon-logout',
    NULL,
    184,
    1,
    0,
    0
  );
INSERT INTO
  `rt_menu` (
    `id`,
    `title`,
    `key`,
    `route`,
    `href`,
    `type`,
    `order_num`,
    `icon`,
    `open_type`,
    `pid`,
    `lid`,
    `ifshow`,
    `desktop`
  )
VALUES
  (
    199,
    '编辑参数列表名字',
    NULL,
    'server/apiparams/editData',
    '',
    3,
    0,
    'layui-icon layui-icon-transfer',
    NULL,
    184,
    1,
    0,
    0
  );
INSERT INTO
  `rt_menu` (
    `id`,
    `title`,
    `key`,
    `route`,
    `href`,
    `type`,
    `order_num`,
    `icon`,
    `open_type`,
    `pid`,
    `lid`,
    `ifshow`,
    `desktop`
  )
VALUES
  (
    200,
    '删除接口参数',
    NULL,
    'server/apiparams/del',
    '',
    3,
    0,
    'layui-icon layui-icon-subtraction',
    NULL,
    184,
    1,
    0,
    0
  );
INSERT INTO
  `rt_menu` (
    `id`,
    `title`,
    `key`,
    `route`,
    `href`,
    `type`,
    `order_num`,
    `icon`,
    `open_type`,
    `pid`,
    `lid`,
    `ifshow`,
    `desktop`
  )
VALUES
  (
    201,
    '接口参数编辑前',
    NULL,
    'server/apiparams/editBefore',
    '',
    3,
    0,
    'layui-icon layui-icon-rate',
    NULL,
    184,
    1,
    0,
    0
  );
INSERT INTO
  `rt_menu` (
    `id`,
    `title`,
    `key`,
    `route`,
    `href`,
    `type`,
    `order_num`,
    `icon`,
    `open_type`,
    `pid`,
    `lid`,
    `ifshow`,
    `desktop`
  )
VALUES
  (
    202,
    '添加接口参数',
    NULL,
    'server/apiparams/add',
    '',
    3,
    0,
    'layui-icon layui-icon-service',
    NULL,
    184,
    1,
    0,
    0
  );
INSERT INTO
  `rt_menu` (
    `id`,
    `title`,
    `key`,
    `route`,
    `href`,
    `type`,
    `order_num`,
    `icon`,
    `open_type`,
    `pid`,
    `lid`,
    `ifshow`,
    `desktop`
  )
VALUES
  (
    203,
    '编辑接口参数',
    NULL,
    'server/apiparams/edit',
    '',
    3,
    0,
    'layui-icon layui-icon-camera',
    NULL,
    184,
    1,
    0,
    0
  );
INSERT INTO
  `rt_menu` (
    `id`,
    `title`,
    `key`,
    `route`,
    `href`,
    `type`,
    `order_num`,
    `icon`,
    `open_type`,
    `pid`,
    `lid`,
    `ifshow`,
    `desktop`
  )
VALUES
  (
    204,
    '更新接口代码',
    NULL,
    'server/api/addLogic',
    '',
    3,
    0,
    'layui-icon layui-icon-android',
    NULL,
    184,
    1,
    0,
    0
  );
INSERT INTO
  `rt_menu` (
    `id`,
    `title`,
    `key`,
    `route`,
    `href`,
    `type`,
    `order_num`,
    `icon`,
    `open_type`,
    `pid`,
    `lid`,
    `ifshow`,
    `desktop`
  )
VALUES
  (
    205,
    '获取接口代码',
    NULL,
    'server/api/getLogic',
    '',
    3,
    0,
    'layui-icon layui-icon-share',
    NULL,
    184,
    1,
    0,
    0
  );
INSERT INTO
  `rt_menu` (
    `id`,
    `title`,
    `key`,
    `route`,
    `href`,
    `type`,
    `order_num`,
    `icon`,
    `open_type`,
    `pid`,
    `lid`,
    `ifshow`,
    `desktop`
  )
VALUES
  (
    206,
    '程序设计',
    NULL,
    'server/code/list',
    'view/code/list.html',
    1,
    0,
    'layui-icon layui-icon-template',
    NULL,
    1,
    1,
    0,
    1
  );
INSERT INTO
  `rt_menu` (
    `id`,
    `title`,
    `key`,
    `route`,
    `href`,
    `type`,
    `order_num`,
    `icon`,
    `open_type`,
    `pid`,
    `lid`,
    `ifshow`,
    `desktop`
  )
VALUES
  (
    207,
    '程序设计器添加',
    NULL,
    'server/code/add',
    'view/code/edit.html',
    3,
    0,
    '',
    NULL,
    206,
    1,
    0,
    0
  );
INSERT INTO
  `rt_menu` (
    `id`,
    `title`,
    `key`,
    `route`,
    `href`,
    `type`,
    `order_num`,
    `icon`,
    `open_type`,
    `pid`,
    `lid`,
    `ifshow`,
    `desktop`
  )
VALUES
  (
    208,
    '程序设计器编辑',
    NULL,
    'server/code/edit',
    'view/code/edit.html',
    3,
    0,
    '',
    NULL,
    206,
    1,
    0,
    0
  );
INSERT INTO
  `rt_menu` (
    `id`,
    `title`,
    `key`,
    `route`,
    `href`,
    `type`,
    `order_num`,
    `icon`,
    `open_type`,
    `pid`,
    `lid`,
    `ifshow`,
    `desktop`
  )
VALUES
  (
    209,
    '程序设计器删除',
    NULL,
    'server/code/del',
    '',
    3,
    0,
    '',
    NULL,
    206,
    1,
    0,
    0
  );
INSERT INTO
  `rt_menu` (
    `id`,
    `title`,
    `key`,
    `route`,
    `href`,
    `type`,
    `order_num`,
    `icon`,
    `open_type`,
    `pid`,
    `lid`,
    `ifshow`,
    `desktop`
  )
VALUES
  (
    210,
    '程序设计器编辑前',
    NULL,
    'server/code/editBefore',
    '',
    3,
    0,
    '',
    NULL,
    206,
    1,
    0,
    0
  );
INSERT INTO
  `rt_menu` (
    `id`,
    `title`,
    `key`,
    `route`,
    `href`,
    `type`,
    `order_num`,
    `icon`,
    `open_type`,
    `pid`,
    `lid`,
    `ifshow`,
    `desktop`
  )
VALUES
  (
    211,
    '设计程序',
    NULL,
    'server/code/editCode',
    '',
    3,
    0,
    'layui-icon layui-icon-spread-left',
    NULL,
    206,
    1,
    0,
    0
  );
INSERT INTO
  `rt_menu` (
    `id`,
    `title`,
    `key`,
    `route`,
    `href`,
    `type`,
    `order_num`,
    `icon`,
    `open_type`,
    `pid`,
    `lid`,
    `ifshow`,
    `desktop`
  )
VALUES
  (
    212,
    '参数分页新增',
    NULL,
    'server/apiparams/addPage',
    '',
    3,
    0,
    'layui-icon layui-icon-wifi',
    NULL,
    184,
    1,
    0,
    0
  );
INSERT INTO
  `rt_menu` (
    `id`,
    `title`,
    `key`,
    `route`,
    `href`,
    `type`,
    `order_num`,
    `icon`,
    `open_type`,
    `pid`,
    `lid`,
    `ifshow`,
    `desktop`
  )
VALUES
  (
    213,
    '接口测试列表',
    NULL,
    'server/apitest/list',
    '',
    2,
    0,
    'layui-icon layui-icon-read',
    NULL,
    184,
    1,
    0,
    0
  );
INSERT INTO
  `rt_menu` (
    `id`,
    `title`,
    `key`,
    `route`,
    `href`,
    `type`,
    `order_num`,
    `icon`,
    `open_type`,
    `pid`,
    `lid`,
    `ifshow`,
    `desktop`
  )
VALUES
  (
    214,
    '接口测试添加前',
    NULL,
    'server/apitest/addBefore',
    '',
    3,
    0,
    'layui-icon layui-icon-email',
    NULL,
    184,
    1,
    0,
    0
  );
INSERT INTO
  `rt_menu` (
    `id`,
    `title`,
    `key`,
    `route`,
    `href`,
    `type`,
    `order_num`,
    `icon`,
    `open_type`,
    `pid`,
    `lid`,
    `ifshow`,
    `desktop`
  )
VALUES
  (
    215,
    '文章分类列表',
    NULL,
    'server/art/artcate',
    '',
    3,
    0,
    'layui-icon layui-icon-username',
    NULL,
    190,
    1,
    0,
    0
  );
INSERT INTO
  `rt_menu` (
    `id`,
    `title`,
    `key`,
    `route`,
    `href`,
    `type`,
    `order_num`,
    `icon`,
    `open_type`,
    `pid`,
    `lid`,
    `ifshow`,
    `desktop`
  )
VALUES
  (
    216,
    '甘特图',
    NULL,
    'server/gant/list',
    'view/gant/list.html',
    1,
    0,
    'layui-icon layui-icon-survey',
    NULL,
    1,
    1,
    0,
    1
  );
INSERT INTO
  `rt_menu` (
    `id`,
    `title`,
    `key`,
    `route`,
    `href`,
    `type`,
    `order_num`,
    `icon`,
    `open_type`,
    `pid`,
    `lid`,
    `ifshow`,
    `desktop`
  )
VALUES
  (
    217,
    '甘特图添加',
    NULL,
    'server/gant/add',
    'view/gant/edit.html',
    3,
    0,
    '',
    NULL,
    216,
    1,
    0,
    0
  );
INSERT INTO
  `rt_menu` (
    `id`,
    `title`,
    `key`,
    `route`,
    `href`,
    `type`,
    `order_num`,
    `icon`,
    `open_type`,
    `pid`,
    `lid`,
    `ifshow`,
    `desktop`
  )
VALUES
  (
    218,
    '甘特图编辑',
    NULL,
    'server/gant/edit',
    'view/gant/edit.html',
    3,
    0,
    '',
    NULL,
    216,
    1,
    0,
    0
  );
INSERT INTO
  `rt_menu` (
    `id`,
    `title`,
    `key`,
    `route`,
    `href`,
    `type`,
    `order_num`,
    `icon`,
    `open_type`,
    `pid`,
    `lid`,
    `ifshow`,
    `desktop`
  )
VALUES
  (
    219,
    '甘特图删除',
    NULL,
    'server/gant/del',
    '',
    3,
    0,
    '',
    NULL,
    216,
    1,
    0,
    0
  );
INSERT INTO
  `rt_menu` (
    `id`,
    `title`,
    `key`,
    `route`,
    `href`,
    `type`,
    `order_num`,
    `icon`,
    `open_type`,
    `pid`,
    `lid`,
    `ifshow`,
    `desktop`
  )
VALUES
  (
    220,
    '甘特图编辑前',
    NULL,
    'server/gant/editBefore',
    '',
    3,
    0,
    '',
    NULL,
    216,
    1,
    0,
    0
  );
INSERT INTO
  `rt_menu` (
    `id`,
    `title`,
    `key`,
    `route`,
    `href`,
    `type`,
    `order_num`,
    `icon`,
    `open_type`,
    `pid`,
    `lid`,
    `ifshow`,
    `desktop`
  )
VALUES
  (
    221,
    '日程计划',
    NULL,
    'server/planday/list',
    'planday/index.html',
    1,
    0,
    'layui-icon layui-icon-date',
    NULL,
    1,
    1,
    0,
    1
  );
INSERT INTO
  `rt_menu` (
    `id`,
    `title`,
    `key`,
    `route`,
    `href`,
    `type`,
    `order_num`,
    `icon`,
    `open_type`,
    `pid`,
    `lid`,
    `ifshow`,
    `desktop`
  )
VALUES
  (
    222,
    '日程计划添加',
    NULL,
    'server/planday/add',
    '',
    3,
    0,
    '',
    NULL,
    221,
    1,
    0,
    0
  );
INSERT INTO
  `rt_menu` (
    `id`,
    `title`,
    `key`,
    `route`,
    `href`,
    `type`,
    `order_num`,
    `icon`,
    `open_type`,
    `pid`,
    `lid`,
    `ifshow`,
    `desktop`
  )
VALUES
  (
    223,
    '日程计划编辑',
    NULL,
    'server/planday/edit',
    '',
    3,
    0,
    '',
    NULL,
    221,
    1,
    0,
    0
  );
INSERT INTO
  `rt_menu` (
    `id`,
    `title`,
    `key`,
    `route`,
    `href`,
    `type`,
    `order_num`,
    `icon`,
    `open_type`,
    `pid`,
    `lid`,
    `ifshow`,
    `desktop`
  )
VALUES
  (
    224,
    '日程计划删除',
    NULL,
    'server/planday/del',
    '',
    3,
    0,
    '',
    NULL,
    221,
    1,
    0,
    0
  );
INSERT INTO
  `rt_menu` (
    `id`,
    `title`,
    `key`,
    `route`,
    `href`,
    `type`,
    `order_num`,
    `icon`,
    `open_type`,
    `pid`,
    `lid`,
    `ifshow`,
    `desktop`
  )
VALUES
  (
    225,
    '日程计划编辑前',
    NULL,
    'server/planday/editBefore',
    '',
    3,
    0,
    '',
    NULL,
    221,
    1,
    0,
    0
  );
INSERT INTO
  `rt_menu` (
    `id`,
    `title`,
    `key`,
    `route`,
    `href`,
    `type`,
    `order_num`,
    `icon`,
    `open_type`,
    `pid`,
    `lid`,
    `ifshow`,
    `desktop`
  )
VALUES
  (
    226,
    '图片编辑器',
    NULL,
    'server/picedit/list',
    'view/picedit/list.html',
    1,
    0,
    'layui-icon layui-icon-camera',
    NULL,
    1,
    1,
    0,
    1
  );
INSERT INTO
  `rt_menu` (
    `id`,
    `title`,
    `key`,
    `route`,
    `href`,
    `type`,
    `order_num`,
    `icon`,
    `open_type`,
    `pid`,
    `lid`,
    `ifshow`,
    `desktop`
  )
VALUES
  (
    227,
    '图片编辑器添加',
    NULL,
    'server/picedit/add',
    'view/picedit/edit.html',
    3,
    0,
    '',
    NULL,
    226,
    1,
    0,
    0
  );
INSERT INTO
  `rt_menu` (
    `id`,
    `title`,
    `key`,
    `route`,
    `href`,
    `type`,
    `order_num`,
    `icon`,
    `open_type`,
    `pid`,
    `lid`,
    `ifshow`,
    `desktop`
  )
VALUES
  (
    228,
    '图片编辑器编辑',
    NULL,
    'server/picedit/edit',
    'view/picedit/edit.html',
    3,
    0,
    '',
    NULL,
    226,
    1,
    0,
    0
  );
INSERT INTO
  `rt_menu` (
    `id`,
    `title`,
    `key`,
    `route`,
    `href`,
    `type`,
    `order_num`,
    `icon`,
    `open_type`,
    `pid`,
    `lid`,
    `ifshow`,
    `desktop`
  )
VALUES
  (
    229,
    '图片编辑器删除',
    NULL,
    'server/picedit/del',
    '',
    3,
    0,
    '',
    NULL,
    226,
    1,
    0,
    0
  );
INSERT INTO
  `rt_menu` (
    `id`,
    `title`,
    `key`,
    `route`,
    `href`,
    `type`,
    `order_num`,
    `icon`,
    `open_type`,
    `pid`,
    `lid`,
    `ifshow`,
    `desktop`
  )
VALUES
  (
    230,
    '图片编辑器编辑前',
    NULL,
    'server/picedit/editBefore',
    '',
    3,
    0,
    '',
    NULL,
    226,
    1,
    0,
    0
  );
INSERT INTO
  `rt_menu` (
    `id`,
    `title`,
    `key`,
    `route`,
    `href`,
    `type`,
    `order_num`,
    `icon`,
    `open_type`,
    `pid`,
    `lid`,
    `ifshow`,
    `desktop`
  )
VALUES
  (
    231,
    '编辑图片名字',
    NULL,
    'server/picedit/editName',
    '',
    3,
    0,
    'layui-icon layui-icon-rss',
    NULL,
    226,
    1,
    0,
    0
  );
INSERT INTO
  `rt_menu` (
    `id`,
    `title`,
    `key`,
    `route`,
    `href`,
    `type`,
    `order_num`,
    `icon`,
    `open_type`,
    `pid`,
    `lid`,
    `ifshow`,
    `desktop`
  )
VALUES
  (
    237,
    'svg编辑器',
    NULL,
    'server/svgedit/list',
    'view/svgedit/list.html',
    1,
    0,
    'layui-icon layui-icon-diamond',
    NULL,
    1,
    1,
    0,
    1
  );
INSERT INTO
  `rt_menu` (
    `id`,
    `title`,
    `key`,
    `route`,
    `href`,
    `type`,
    `order_num`,
    `icon`,
    `open_type`,
    `pid`,
    `lid`,
    `ifshow`,
    `desktop`
  )
VALUES
  (
    238,
    'svg编辑器添加',
    NULL,
    'server/svgedit/add',
    'view/svgedit/edit.html',
    3,
    0,
    '',
    NULL,
    237,
    1,
    0,
    0
  );
INSERT INTO
  `rt_menu` (
    `id`,
    `title`,
    `key`,
    `route`,
    `href`,
    `type`,
    `order_num`,
    `icon`,
    `open_type`,
    `pid`,
    `lid`,
    `ifshow`,
    `desktop`
  )
VALUES
  (
    239,
    'svg编辑器编辑',
    NULL,
    'server/svgedit/edit',
    'view/svgedit/edit.html',
    3,
    0,
    '',
    NULL,
    237,
    1,
    0,
    0
  );
INSERT INTO
  `rt_menu` (
    `id`,
    `title`,
    `key`,
    `route`,
    `href`,
    `type`,
    `order_num`,
    `icon`,
    `open_type`,
    `pid`,
    `lid`,
    `ifshow`,
    `desktop`
  )
VALUES
  (
    240,
    'svg编辑器删除',
    NULL,
    'server/svgedit/del',
    '',
    3,
    0,
    '',
    NULL,
    237,
    1,
    0,
    0
  );
INSERT INTO
  `rt_menu` (
    `id`,
    `title`,
    `key`,
    `route`,
    `href`,
    `type`,
    `order_num`,
    `icon`,
    `open_type`,
    `pid`,
    `lid`,
    `ifshow`,
    `desktop`
  )
VALUES
  (
    241,
    'svg编辑器编辑前',
    NULL,
    'server/svgedit/editBefore',
    '',
    3,
    0,
    '',
    NULL,
    237,
    1,
    0,
    0
  );
INSERT INTO
  `rt_menu` (
    `id`,
    `title`,
    `key`,
    `route`,
    `href`,
    `type`,
    `order_num`,
    `icon`,
    `open_type`,
    `pid`,
    `lid`,
    `ifshow`,
    `desktop`
  )
VALUES
  (
    242,
    '判断登录',
    NULL,
    'server/index/isLogin',
    '',
    3,
    0,
    'layui-icon layui-icon-at',
    NULL,
    6,
    1,
    0,
    0
  );
INSERT INTO
  `rt_menu` (
    `id`,
    `title`,
    `key`,
    `route`,
    `href`,
    `type`,
    `order_num`,
    `icon`,
    `open_type`,
    `pid`,
    `lid`,
    `ifshow`,
    `desktop`
  )
VALUES
  (
    244,
    '聊天',
    NULL,
    'server/chat/open',
    '',
    3,
    0,
    'layui-icon layui-icon-username',
    NULL,
    1,
    1,
    0,
    0
  );
INSERT INTO
  `rt_menu` (
    `id`,
    `title`,
    `key`,
    `route`,
    `href`,
    `type`,
    `order_num`,
    `icon`,
    `open_type`,
    `pid`,
    `lid`,
    `ifshow`,
    `desktop`
  )
VALUES
  (
    245,
    '关闭聊天socket',
    NULL,
    'server/chat/close',
    '',
    3,
    0,
    'layui-icon layui-icon-username',
    NULL,
    244,
    1,
    0,
    0
  );
INSERT INTO
  `rt_menu` (
    `id`,
    `title`,
    `key`,
    `route`,
    `href`,
    `type`,
    `order_num`,
    `icon`,
    `open_type`,
    `pid`,
    `lid`,
    `ifshow`,
    `desktop`
  )
VALUES
  (
    246,
    '导入',
    NULL,
    'server/excel/import',
    '',
    3,
    0,
    'layui-icon layui-icon-username',
    NULL,
    159,
    1,
    0,
    0
  );
INSERT INTO
  `rt_menu` (
    `id`,
    `title`,
    `key`,
    `route`,
    `href`,
    `type`,
    `order_num`,
    `icon`,
    `open_type`,
    `pid`,
    `lid`,
    `ifshow`,
    `desktop`
  )
VALUES
  (
    247,
    '文档编辑器',
    NULL,
    'server/word/list',
    'view/word/list.html',
    1,
    0,
    'layui-icon layui-icon-read',
    NULL,
    1,
    1,
    0,
    1
  );
INSERT INTO
  `rt_menu` (
    `id`,
    `title`,
    `key`,
    `route`,
    `href`,
    `type`,
    `order_num`,
    `icon`,
    `open_type`,
    `pid`,
    `lid`,
    `ifshow`,
    `desktop`
  )
VALUES
  (
    248,
    '文档编辑器添加',
    NULL,
    'server/word/add',
    'view/word/edit.html',
    3,
    0,
    '',
    NULL,
    247,
    1,
    0,
    0
  );
INSERT INTO
  `rt_menu` (
    `id`,
    `title`,
    `key`,
    `route`,
    `href`,
    `type`,
    `order_num`,
    `icon`,
    `open_type`,
    `pid`,
    `lid`,
    `ifshow`,
    `desktop`
  )
VALUES
  (
    249,
    '文档编辑器编辑',
    NULL,
    'server/word/edit',
    'view/word/edit.html',
    3,
    0,
    '',
    NULL,
    247,
    1,
    0,
    0
  );
INSERT INTO
  `rt_menu` (
    `id`,
    `title`,
    `key`,
    `route`,
    `href`,
    `type`,
    `order_num`,
    `icon`,
    `open_type`,
    `pid`,
    `lid`,
    `ifshow`,
    `desktop`
  )
VALUES
  (
    250,
    '文档编辑器删除',
    NULL,
    'server/word/del',
    '',
    3,
    0,
    '',
    NULL,
    247,
    1,
    0,
    0
  );
INSERT INTO
  `rt_menu` (
    `id`,
    `title`,
    `key`,
    `route`,
    `href`,
    `type`,
    `order_num`,
    `icon`,
    `open_type`,
    `pid`,
    `lid`,
    `ifshow`,
    `desktop`
  )
VALUES
  (
    251,
    '文档编辑器编辑前',
    NULL,
    'server/word/editBefore',
    '',
    3,
    0,
    '',
    NULL,
    247,
    1,
    0,
    0
  );
INSERT INTO
  `rt_menu` (
    `id`,
    `title`,
    `key`,
    `route`,
    `href`,
    `type`,
    `order_num`,
    `icon`,
    `open_type`,
    `pid`,
    `lid`,
    `ifshow`,
    `desktop`
  )
VALUES
  (
    252,
    '打开文档',
    NULL,
    'server/word/openFile',
    '',
    3,
    0,
    'layui-icon layui-icon-android',
    NULL,
    247,
    1,
    0,
    0
  );
INSERT INTO
  `rt_menu` (
    `id`,
    `title`,
    `key`,
    `route`,
    `href`,
    `type`,
    `order_num`,
    `icon`,
    `open_type`,
    `pid`,
    `lid`,
    `ifshow`,
    `desktop`
  )
VALUES
  (
    253,
    '上传文件',
    NULL,
    'server/word/upload',
    '',
    3,
    0,
    'layui-icon layui-icon-print',
    NULL,
    247,
    1,
    0,
    0
  );
INSERT INTO
  `rt_menu` (
    `id`,
    `title`,
    `key`,
    `route`,
    `href`,
    `type`,
    `order_num`,
    `icon`,
    `open_type`,
    `pid`,
    `lid`,
    `ifshow`,
    `desktop`
  )
VALUES
  (
    254,
    '文本编辑器',
    NULL,
    'server/txt/list',
    'view/txt/list.html',
    1,
    0,
    'layui-icon layui-icon-fonts-code',
    NULL,
    1,
    1,
    0,
    1
  );
INSERT INTO
  `rt_menu` (
    `id`,
    `title`,
    `key`,
    `route`,
    `href`,
    `type`,
    `order_num`,
    `icon`,
    `open_type`,
    `pid`,
    `lid`,
    `ifshow`,
    `desktop`
  )
VALUES
  (
    255,
    '文本编辑器添加',
    NULL,
    'server/txt/add',
    'view/txt/edit.html',
    3,
    0,
    '',
    NULL,
    254,
    1,
    0,
    0
  );
INSERT INTO
  `rt_menu` (
    `id`,
    `title`,
    `key`,
    `route`,
    `href`,
    `type`,
    `order_num`,
    `icon`,
    `open_type`,
    `pid`,
    `lid`,
    `ifshow`,
    `desktop`
  )
VALUES
  (
    256,
    '文本编辑器编辑',
    NULL,
    'server/txt/edit',
    'view/txt/edit.html',
    3,
    0,
    '',
    NULL,
    254,
    1,
    0,
    0
  );
INSERT INTO
  `rt_menu` (
    `id`,
    `title`,
    `key`,
    `route`,
    `href`,
    `type`,
    `order_num`,
    `icon`,
    `open_type`,
    `pid`,
    `lid`,
    `ifshow`,
    `desktop`
  )
VALUES
  (
    257,
    '文本编辑器删除',
    NULL,
    'server/txt/del',
    '',
    3,
    0,
    '',
    NULL,
    254,
    1,
    0,
    0
  );
INSERT INTO
  `rt_menu` (
    `id`,
    `title`,
    `key`,
    `route`,
    `href`,
    `type`,
    `order_num`,
    `icon`,
    `open_type`,
    `pid`,
    `lid`,
    `ifshow`,
    `desktop`
  )
VALUES
  (
    258,
    '文本编辑器编辑前',
    NULL,
    'server/txt/editBefore',
    '',
    3,
    0,
    '',
    NULL,
    254,
    1,
    0,
    0
  );
INSERT INTO
  `rt_menu` (
    `id`,
    `title`,
    `key`,
    `route`,
    `href`,
    `type`,
    `order_num`,
    `icon`,
    `open_type`,
    `pid`,
    `lid`,
    `ifshow`,
    `desktop`
  )
VALUES
  (
    259,
    '任务看板',
    NULL,
    'server/kanban/list',
    'view/kanban/list.html',
    1,
    0,
    'layui-icon layui-icon-file-b',
    NULL,
    1,
    1,
    1,
    0
  );
INSERT INTO
  `rt_menu` (
    `id`,
    `title`,
    `key`,
    `route`,
    `href`,
    `type`,
    `order_num`,
    `icon`,
    `open_type`,
    `pid`,
    `lid`,
    `ifshow`,
    `desktop`
  )
VALUES
  (
    260,
    '任务看板添加',
    NULL,
    'server/kanban/add',
    'view/kanban/edit.html',
    3,
    0,
    '',
    NULL,
    259,
    1,
    0,
    0
  );
INSERT INTO
  `rt_menu` (
    `id`,
    `title`,
    `key`,
    `route`,
    `href`,
    `type`,
    `order_num`,
    `icon`,
    `open_type`,
    `pid`,
    `lid`,
    `ifshow`,
    `desktop`
  )
VALUES
  (
    261,
    '任务看板编辑',
    NULL,
    'server/kanban/edit',
    'view/kanban/edit.html',
    3,
    0,
    '',
    NULL,
    259,
    1,
    0,
    0
  );
INSERT INTO
  `rt_menu` (
    `id`,
    `title`,
    `key`,
    `route`,
    `href`,
    `type`,
    `order_num`,
    `icon`,
    `open_type`,
    `pid`,
    `lid`,
    `ifshow`,
    `desktop`
  )
VALUES
  (
    262,
    '任务看板删除',
    NULL,
    'server/kanban/del',
    '',
    3,
    0,
    '',
    NULL,
    259,
    1,
    0,
    0
  );
INSERT INTO
  `rt_menu` (
    `id`,
    `title`,
    `key`,
    `route`,
    `href`,
    `type`,
    `order_num`,
    `icon`,
    `open_type`,
    `pid`,
    `lid`,
    `ifshow`,
    `desktop`
  )
VALUES
  (
    263,
    '任务看板编辑前',
    NULL,
    'server/kanban/editBefore',
    '',
    3,
    0,
    '',
    NULL,
    259,
    1,
    0,
    0
  );
INSERT INTO
  `rt_menu` (
    `id`,
    `title`,
    `key`,
    `route`,
    `href`,
    `type`,
    `order_num`,
    `icon`,
    `open_type`,
    `pid`,
    `lid`,
    `ifshow`,
    `desktop`
  )
VALUES
  (
    264,
    '开启关闭计划任务',
    NULL,
    'server/crons/enable',
    '',
    3,
    0,
    'layui-icon layui-icon-mute',
    NULL,
    144,
    1,
    0,
    0
  );
INSERT INTO
  `rt_menu` (
    `id`,
    `title`,
    `key`,
    `route`,
    `href`,
    `type`,
    `order_num`,
    `icon`,
    `open_type`,
    `pid`,
    `lid`,
    `ifshow`,
    `desktop`
  )
VALUES
  (
    265,
    '导出',
    NULL,
    'server/menu/sql',
    '',
    3,
    0,
    'layui-icon layui-icon-email',
    NULL,
    9,
    1,
    0,
    0
  );
INSERT INTO
  `rt_menu` (
    `id`,
    `title`,
    `key`,
    `route`,
    `href`,
    `type`,
    `order_num`,
    `icon`,
    `open_type`,
    `pid`,
    `lid`,
    `ifshow`,
    `desktop`
  )
VALUES
  (
    266,
    '接口发送测试',
    NULL,
    'server/apitest/testRun',
    '',
    3,
    0,
    'layui-icon layui-icon-at',
    NULL,
    184,
    1,
    0,
    0
  );
INSERT INTO
  `rt_menu` (
    `id`,
    `title`,
    `key`,
    `route`,
    `href`,
    `type`,
    `order_num`,
    `icon`,
    `open_type`,
    `pid`,
    `lid`,
    `ifshow`,
    `desktop`
  )
VALUES
  (
    267,
    '添加接口测试',
    NULL,
    'server/apitest/add',
    '',
    3,
    0,
    'layui-icon layui-icon-email',
    NULL,
    184,
    1,
    0,
    0
  );
INSERT INTO
  `rt_menu` (
    `id`,
    `title`,
    `key`,
    `route`,
    `href`,
    `type`,
    `order_num`,
    `icon`,
    `open_type`,
    `pid`,
    `lid`,
    `ifshow`,
    `desktop`
  )
VALUES
  (
    268,
    '地区管理',
    NULL,
    'server/area/list',
    'view/area/list.html',
    1,
    0,
    'layui-icon layui-icon-website',
    NULL,
    3,
    1,
    0,
    0
  );
INSERT INTO
  `rt_menu` (
    `id`,
    `title`,
    `key`,
    `route`,
    `href`,
    `type`,
    `order_num`,
    `icon`,
    `open_type`,
    `pid`,
    `lid`,
    `ifshow`,
    `desktop`
  )
VALUES
  (
    269,
    '地区管理添加',
    NULL,
    'server/area/add',
    'view/area/edit.html',
    3,
    0,
    '',
    NULL,
    268,
    1,
    0,
    0
  );
INSERT INTO
  `rt_menu` (
    `id`,
    `title`,
    `key`,
    `route`,
    `href`,
    `type`,
    `order_num`,
    `icon`,
    `open_type`,
    `pid`,
    `lid`,
    `ifshow`,
    `desktop`
  )
VALUES
  (
    270,
    '地区管理编辑',
    NULL,
    'server/area/edit',
    'view/area/edit.html',
    3,
    0,
    '',
    NULL,
    268,
    1,
    0,
    0
  );
INSERT INTO
  `rt_menu` (
    `id`,
    `title`,
    `key`,
    `route`,
    `href`,
    `type`,
    `order_num`,
    `icon`,
    `open_type`,
    `pid`,
    `lid`,
    `ifshow`,
    `desktop`
  )
VALUES
  (
    271,
    '地区管理删除',
    NULL,
    'server/area/del',
    '',
    3,
    0,
    '',
    NULL,
    268,
    1,
    0,
    0
  );
INSERT INTO
  `rt_menu` (
    `id`,
    `title`,
    `key`,
    `route`,
    `href`,
    `type`,
    `order_num`,
    `icon`,
    `open_type`,
    `pid`,
    `lid`,
    `ifshow`,
    `desktop`
  )
VALUES
  (
    272,
    '地区管理编辑前',
    NULL,
    'server/area/editBefore',
    '',
    3,
    0,
    '',
    NULL,
    268,
    1,
    0,
    0
  );
INSERT INTO
  `rt_menu` (
    `id`,
    `title`,
    `key`,
    `route`,
    `href`,
    `type`,
    `order_num`,
    `icon`,
    `open_type`,
    `pid`,
    `lid`,
    `ifshow`,
    `desktop`
  )
VALUES
  (
    273,
    '地区管理添加前',
    NULL,
    'server/area/addBefore',
    '',
    3,
    0,
    'layui-icon layui-icon-username',
    NULL,
    268,
    1,
    0,
    0
  );
INSERT INTO
  `rt_menu` (
    `id`,
    `title`,
    `key`,
    `route`,
    `href`,
    `type`,
    `order_num`,
    `icon`,
    `open_type`,
    `pid`,
    `lid`,
    `ifshow`,
    `desktop`
  )
VALUES
  (
    274,
    '设置地区可用',
    NULL,
    'server/area/enable',
    '',
    3,
    0,
    'layui-icon layui-icon-username',
    NULL,
    268,
    1,
    0,
    0
  );
INSERT INTO
  `rt_menu` (
    `id`,
    `title`,
    `key`,
    `route`,
    `href`,
    `type`,
    `order_num`,
    `icon`,
    `open_type`,
    `pid`,
    `lid`,
    `ifshow`,
    `desktop`
  )
VALUES
  (
    275,
    '部门管理',
    NULL,
    'server/department/list',
    'view/department/list.html',
    1,
    0,
    'layui-icon layui-icon-cols',
    NULL,
    3,
    1,
    0,
    0
  );
INSERT INTO
  `rt_menu` (
    `id`,
    `title`,
    `key`,
    `route`,
    `href`,
    `type`,
    `order_num`,
    `icon`,
    `open_type`,
    `pid`,
    `lid`,
    `ifshow`,
    `desktop`
  )
VALUES
  (
    276,
    '部门管理添加',
    NULL,
    'server/department/add',
    'view/department/edit.html',
    3,
    0,
    '',
    NULL,
    275,
    1,
    0,
    0
  );
INSERT INTO
  `rt_menu` (
    `id`,
    `title`,
    `key`,
    `route`,
    `href`,
    `type`,
    `order_num`,
    `icon`,
    `open_type`,
    `pid`,
    `lid`,
    `ifshow`,
    `desktop`
  )
VALUES
  (
    277,
    '部门管理编辑',
    NULL,
    'server/department/edit',
    'view/department/edit.html',
    3,
    0,
    '',
    NULL,
    275,
    1,
    0,
    0
  );
INSERT INTO
  `rt_menu` (
    `id`,
    `title`,
    `key`,
    `route`,
    `href`,
    `type`,
    `order_num`,
    `icon`,
    `open_type`,
    `pid`,
    `lid`,
    `ifshow`,
    `desktop`
  )
VALUES
  (
    278,
    '部门管理删除',
    NULL,
    'server/department/del',
    '',
    3,
    0,
    '',
    NULL,
    275,
    1,
    0,
    0
  );
INSERT INTO
  `rt_menu` (
    `id`,
    `title`,
    `key`,
    `route`,
    `href`,
    `type`,
    `order_num`,
    `icon`,
    `open_type`,
    `pid`,
    `lid`,
    `ifshow`,
    `desktop`
  )
VALUES
  (
    279,
    '部门管理编辑前',
    NULL,
    'server/department/editBefore',
    '',
    3,
    0,
    '',
    NULL,
    275,
    1,
    0,
    0
  );
INSERT INTO
  `rt_menu` (
    `id`,
    `title`,
    `key`,
    `route`,
    `href`,
    `type`,
    `order_num`,
    `icon`,
    `open_type`,
    `pid`,
    `lid`,
    `ifshow`,
    `desktop`
  )
VALUES
  (
    280,
    '公司管理',
    NULL,
    'server/company/list',
    'view/company/list.html',
    1,
    0,
    'layui-icon layui-icon-cellphone',
    NULL,
    3,
    1,
    0,
    0
  );
INSERT INTO
  `rt_menu` (
    `id`,
    `title`,
    `key`,
    `route`,
    `href`,
    `type`,
    `order_num`,
    `icon`,
    `open_type`,
    `pid`,
    `lid`,
    `ifshow`,
    `desktop`
  )
VALUES
  (
    281,
    '公司管理添加',
    NULL,
    'server/company/add',
    'view/company/edit.html',
    3,
    0,
    '',
    NULL,
    280,
    1,
    0,
    0
  );
INSERT INTO
  `rt_menu` (
    `id`,
    `title`,
    `key`,
    `route`,
    `href`,
    `type`,
    `order_num`,
    `icon`,
    `open_type`,
    `pid`,
    `lid`,
    `ifshow`,
    `desktop`
  )
VALUES
  (
    282,
    '公司管理编辑',
    NULL,
    'server/company/edit',
    'view/company/edit.html',
    3,
    0,
    '',
    NULL,
    280,
    1,
    0,
    0
  );
INSERT INTO
  `rt_menu` (
    `id`,
    `title`,
    `key`,
    `route`,
    `href`,
    `type`,
    `order_num`,
    `icon`,
    `open_type`,
    `pid`,
    `lid`,
    `ifshow`,
    `desktop`
  )
VALUES
  (
    283,
    '公司管理删除',
    NULL,
    'server/company/del',
    '',
    3,
    0,
    '',
    NULL,
    280,
    1,
    0,
    0
  );
INSERT INTO
  `rt_menu` (
    `id`,
    `title`,
    `key`,
    `route`,
    `href`,
    `type`,
    `order_num`,
    `icon`,
    `open_type`,
    `pid`,
    `lid`,
    `ifshow`,
    `desktop`
  )
VALUES
  (
    284,
    '公司管理编辑前',
    NULL,
    'server/company/editBefore',
    '',
    3,
    0,
    '',
    NULL,
    280,
    1,
    0,
    0
  );
INSERT INTO
  `rt_menu` (
    `id`,
    `title`,
    `key`,
    `route`,
    `href`,
    `type`,
    `order_num`,
    `icon`,
    `open_type`,
    `pid`,
    `lid`,
    `ifshow`,
    `desktop`
  )
VALUES
  (
    285,
    '岗位管理',
    NULL,
    'server/position/list',
    'view/position/list.html',
    1,
    0,
    'layui-icon layui-icon-note',
    NULL,
    3,
    1,
    0,
    0
  );
INSERT INTO
  `rt_menu` (
    `id`,
    `title`,
    `key`,
    `route`,
    `href`,
    `type`,
    `order_num`,
    `icon`,
    `open_type`,
    `pid`,
    `lid`,
    `ifshow`,
    `desktop`
  )
VALUES
  (
    286,
    '岗位管理添加',
    NULL,
    'server/position/add',
    'view/position/edit.html',
    3,
    0,
    '',
    NULL,
    285,
    1,
    0,
    0
  );
INSERT INTO
  `rt_menu` (
    `id`,
    `title`,
    `key`,
    `route`,
    `href`,
    `type`,
    `order_num`,
    `icon`,
    `open_type`,
    `pid`,
    `lid`,
    `ifshow`,
    `desktop`
  )
VALUES
  (
    287,
    '岗位管理编辑',
    NULL,
    'server/position/edit',
    'view/position/edit.html',
    3,
    0,
    '',
    NULL,
    285,
    1,
    0,
    0
  );
INSERT INTO
  `rt_menu` (
    `id`,
    `title`,
    `key`,
    `route`,
    `href`,
    `type`,
    `order_num`,
    `icon`,
    `open_type`,
    `pid`,
    `lid`,
    `ifshow`,
    `desktop`
  )
VALUES
  (
    288,
    '岗位管理删除',
    NULL,
    'server/position/del',
    '',
    3,
    0,
    '',
    NULL,
    285,
    1,
    0,
    0
  );
INSERT INTO
  `rt_menu` (
    `id`,
    `title`,
    `key`,
    `route`,
    `href`,
    `type`,
    `order_num`,
    `icon`,
    `open_type`,
    `pid`,
    `lid`,
    `ifshow`,
    `desktop`
  )
VALUES
  (
    289,
    '岗位管理编辑前',
    NULL,
    'server/position/editBefore',
    '',
    3,
    0,
    '',
    NULL,
    285,
    1,
    0,
    0
  );

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: rt_mind
# ------------------------------------------------------------

INSERT INTO
  `rt_mind` (
    `id`,
    `add_time`,
    `update_time`,
    `user_id`,
    `title`,
    `content`
  )
VALUES
  (
    1,
    0,
    0,
    0,
    '根节点',
    '{\"root\":{\"data\":{\"text\":\"根节点\",\"expand\":true,\"isActive\":true},\"children\":[{\"data\":{\"text\":\"分支主题\",\"expand\":true,\"isActive\":false},\"children\":[]},{\"data\":{\"text\":\"222\",\"expand\":true,\"isActive\":false},\"children\":[]},{\"data\":{\"text\":\"分支主题\",\"expand\":true,\"isActive\":false},\"children\":[]},{\"data\":{\"text\":\"分支主题\",\"expand\":true,\"isActive\":false},\"children\":[]},{\"data\":{\"text\":\"分支主题\",\"expand\":true,\"isActive\":false},\"children\":[]}]},\"theme\":{\"template\":\"classic\",\"config\":{}},\"layout\":\"mindMap\"}'
  );
INSERT INTO
  `rt_mind` (
    `id`,
    `add_time`,
    `update_time`,
    `user_id`,
    `title`,
    `content`
  )
VALUES
  (
    2,
    0,
    0,
    0,
    '根节点5',
    '{\"root\":{\"data\":{\"text\":\"根节点5\",\"expand\":true,\"isActive\":false},\"children\":[{\"data\":{\"text\":\"分支主题\",\"expand\":true,\"isActive\":false},\"children\":[]}]},\"theme\":{\"template\":\"classic\",\"config\":{}},\"layout\":\"mindMap\"}'
  );
INSERT INTO
  `rt_mind` (
    `id`,
    `add_time`,
    `update_time`,
    `user_id`,
    `title`,
    `content`
  )
VALUES
  (
    3,
    0,
    0,
    0,
    '根节点',
    '{\"root\":{\"data\":{\"text\":\"根节点\",\"expand\":true,\"isActive\":true},\"children\":[{\"data\":{\"text\":\"分支主题\",\"expand\":true,\"isActive\":false},\"children\":[]},{\"data\":{\"text\":\"分支主题\",\"expand\":true,\"isActive\":false},\"children\":[]},{\"data\":{\"text\":\"分支主题\",\"expand\":true},\"children\":[]}]},\"theme\":{\"template\":\"classic\",\"config\":{}},\"layout\":\"mindMap\"}'
  );
INSERT INTO
  `rt_mind` (
    `id`,
    `add_time`,
    `update_time`,
    `user_id`,
    `title`,
    `content`
  )
VALUES
  (
    5,
    0,
    1638234727,
    0,
    '222',
    '{\"root\":{\"data\":{\"text\":\"222\",\"expand\":true,\"isActive\":true},\"children\":[{\"data\":{\"text\":\"分支主题\",\"expand\":true,\"isActive\":false},\"children\":[]},{\"data\":{\"text\":\"分支主题\",\"expand\":true,\"isActive\":false},\"children\":[]},{\"data\":{\"text\":\"分支主题\",\"expand\":true,\"isActive\":false},\"children\":[]},{\"data\":{\"text\":\"分支主题\",\"expand\":true},\"children\":[]}]},\"theme\":{\"template\":\"classic\",\"config\":{}},\"layout\":\"mindMap\"}'
  );
INSERT INTO
  `rt_mind` (
    `id`,
    `add_time`,
    `update_time`,
    `user_id`,
    `title`,
    `content`
  )
VALUES
  (
    6,
    1638234768,
    1638234787,
    1,
    '根节点',
    '{\"root\":{\"data\":{\"text\":\"根节点\",\"expand\":true,\"isActive\":true},\"children\":[{\"data\":{\"text\":\"分支主题\",\"expand\":true,\"isActive\":false},\"children\":[]},{\"data\":{\"text\":\"分支主题\",\"expand\":true},\"children\":[]}]},\"theme\":{\"template\":\"classic\",\"config\":{}},\"layout\":\"mindMap\"}'
  );
INSERT INTO
  `rt_mind` (
    `id`,
    `add_time`,
    `update_time`,
    `user_id`,
    `title`,
    `content`
  )
VALUES
  (
    7,
    1638235857,
    1638235900,
    1,
    '5555555',
    '{\"root\":{\"data\":{\"text\":\"5555555\",\"expand\":true,\"isActive\":false},\"children\":[{\"data\":{\"text\":\"555\",\"expand\":true,\"isActive\":false},\"children\":[]},{\"data\":{\"text\":\"666\",\"expand\":true,\"isActive\":false},\"children\":[]}]},\"theme\":{\"template\":\"classic\",\"config\":{}},\"layout\":\"mindMap\"}'
  );
INSERT INTO
  `rt_mind` (
    `id`,
    `add_time`,
    `update_time`,
    `user_id`,
    `title`,
    `content`
  )
VALUES
  (
    8,
    1638244959,
    1638245283,
    1,
    '222',
    '{\"root\":{\"data\":{\"text\":\"222\",\"expand\":true,\"isActive\":true},\"children\":[{\"data\":{\"text\":\"分支主题\",\"expand\":true,\"isActive\":false},\"children\":[]},{\"data\":{\"text\":\"分支主题\",\"expand\":true,\"isActive\":false},\"children\":[]}]},\"theme\":{\"template\":\"classic\",\"config\":{}},\"layout\":\"mindMap\",\"view\":{\"transform\":{\"scaleX\":1,\"scaleY\":1,\"shear\":0,\"rotate\":0,\"translateX\":0,\"translateY\":0,\"originX\":0,\"originY\":0,\"a\":1,\"b\":0,\"c\":0,\"d\":1,\"e\":0,\"f\":0},\"state\":{\"scale\":1,\"x\":0,\"y\":0,\"sx\":0,\"sy\":0}}}'
  );
INSERT INTO
  `rt_mind` (
    `id`,
    `add_time`,
    `update_time`,
    `user_id`,
    `title`,
    `content`
  )
VALUES
  (
    9,
    1638421414,
    1639467588,
    1,
    '根节点',
    '{\"root\":{\"data\":{\"text\":\"根节点\",\"expand\":true,\"isActive\":true},\"children\":[{\"data\":{\"text\":\"分支主题\",\"expand\":true,\"isActive\":false},\"children\":[]},{\"data\":{\"text\":\"分支主题\",\"expand\":true,\"isActive\":false},\"children\":[]},{\"data\":{\"text\":\"分支主题\",\"expand\":true,\"isActive\":false},\"children\":[]}]},\"theme\":{\"template\":\"classic\",\"config\":{}},\"layout\":\"mindMap\"}'
  );

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: rt_mod
# ------------------------------------------------------------

INSERT INTO
  `rt_mod` (
    `id`,
    `name`,
    `key`,
    `server_path`,
    `tables_main`,
    `tables_more`,
    `type`,
    `params`,
    `extra`,
    `remark`
  )
VALUES
  (
    38,
    '计划任务',
    'crons',
    'server',
    'rt_crons',
    '',
    5,
    '',
    '{\"topAuthId\":\"2\",\"topAuthIcon\":\"layui-icon-vercode\"}',
    ''
  );
INSERT INTO
  `rt_mod` (
    `id`,
    `name`,
    `key`,
    `server_path`,
    `tables_main`,
    `tables_more`,
    `type`,
    `params`,
    `extra`,
    `remark`
  )
VALUES
  (
    39,
    '演示文稿',
    'ppt',
    'server',
    'rt_ppt',
    '',
    5,
    '',
    '{\"topAuthId\":\"1\",\"topAuthIcon\":\"layui-icon-snowflake\"}',
    ''
  );
INSERT INTO
  `rt_mod` (
    `id`,
    `name`,
    `key`,
    `server_path`,
    `tables_main`,
    `tables_more`,
    `type`,
    `params`,
    `extra`,
    `remark`
  )
VALUES
  (
    40,
    '思维导图',
    'mind',
    'server',
    'rt_mind',
    '',
    5,
    '',
    '{\"topAuthId\":\"1\",\"topAuthIcon\":\"layui-icon layui-icon-auz\"}',
    ''
  );
INSERT INTO
  `rt_mod` (
    `id`,
    `name`,
    `key`,
    `server_path`,
    `tables_main`,
    `tables_more`,
    `type`,
    `params`,
    `extra`,
    `remark`
  )
VALUES
  (
    41,
    'excel管理',
    'excel',
    'server',
    'rt_excel',
    '',
    5,
    '',
    '{\"topAuthId\":\"1\",\"topAuthIcon\":\"layui-icon layui-icon-tabs\"}',
    ''
  );
INSERT INTO
  `rt_mod` (
    `id`,
    `name`,
    `key`,
    `server_path`,
    `tables_main`,
    `tables_more`,
    `type`,
    `params`,
    `extra`,
    `remark`
  )
VALUES
  (
    42,
    '流程图',
    'flow',
    'server',
    'rt_flow',
    '',
    5,
    '',
    '{\"topAuthId\":\"1\",\"topAuthIcon\":\"layui-icon layui-icon-spread-left\"}',
    ''
  );
INSERT INTO
  `rt_mod` (
    `id`,
    `name`,
    `key`,
    `server_path`,
    `tables_main`,
    `tables_more`,
    `type`,
    `params`,
    `extra`,
    `remark`
  )
VALUES
  (
    43,
    '文档管理',
    'doc',
    'server',
    'rt_doc',
    '',
    5,
    '',
    '{\"topAuthId\":\"1\",\"topAuthIcon\":\"layui-icon layui-icon-email\"}',
    ''
  );
INSERT INTO
  `rt_mod` (
    `id`,
    `name`,
    `key`,
    `server_path`,
    `tables_main`,
    `tables_more`,
    `type`,
    `params`,
    `extra`,
    `remark`
  )
VALUES
  (
    45,
    '接口设计',
    'api',
    'server',
    'rt_api',
    'rt_mod',
    5,
    '',
    '{\"topAuthId\":\"2\",\"topAuthIcon\":\"layui-icon layui-icon-website\"}',
    ''
  );
INSERT INTO
  `rt_mod` (
    `id`,
    `name`,
    `key`,
    `server_path`,
    `tables_main`,
    `tables_more`,
    `type`,
    `params`,
    `extra`,
    `remark`
  )
VALUES
  (
    46,
    '文章',
    'art',
    'server',
    'rt_article',
    'rt_cate,rt_category',
    1,
    '',
    '',
    ''
  );
INSERT INTO
  `rt_mod` (
    `id`,
    `name`,
    `key`,
    `server_path`,
    `tables_main`,
    `tables_more`,
    `type`,
    `params`,
    `extra`,
    `remark`
  )
VALUES
  (
    47,
    '程序设计器',
    'code',
    'server',
    'rt_code',
    '',
    5,
    '',
    '{\"topAuthId\":\"1\",\"topAuthIcon\":\"layui-icon layui-icon-template\"}',
    ''
  );
INSERT INTO
  `rt_mod` (
    `id`,
    `name`,
    `key`,
    `server_path`,
    `tables_main`,
    `tables_more`,
    `type`,
    `params`,
    `extra`,
    `remark`
  )
VALUES
  (
    48,
    '甘特图',
    'gant',
    'server',
    'rt_gant',
    '',
    5,
    '',
    '{\"topAuthId\":\"1\",\"topAuthIcon\":\"layui-icon layui-icon-spread-left\"}',
    ''
  );
INSERT INTO
  `rt_mod` (
    `id`,
    `name`,
    `key`,
    `server_path`,
    `tables_main`,
    `tables_more`,
    `type`,
    `params`,
    `extra`,
    `remark`
  )
VALUES
  (
    49,
    '日程计划',
    'planday',
    'server',
    'rt_planday',
    '',
    5,
    '',
    '{\"topAuthId\":\"1\",\"topAuthIcon\":\"layui-icon layui-icon-date\"}',
    ''
  );
INSERT INTO
  `rt_mod` (
    `id`,
    `name`,
    `key`,
    `server_path`,
    `tables_main`,
    `tables_more`,
    `type`,
    `params`,
    `extra`,
    `remark`
  )
VALUES
  (
    50,
    '图片编辑器',
    'picedit',
    'server',
    'rt_picedit',
    '',
    5,
    '',
    '{\"topAuthId\":\"1\",\"topAuthIcon\":\"layui-icon layui-icon-camera\"}',
    ''
  );
INSERT INTO
  `rt_mod` (
    `id`,
    `name`,
    `key`,
    `server_path`,
    `tables_main`,
    `tables_more`,
    `type`,
    `params`,
    `extra`,
    `remark`
  )
VALUES
  (
    52,
    'svg编辑器',
    'svgedit',
    'server',
    'rt_svg',
    '',
    5,
    '',
    '{\"topAuthId\":\"1\",\"topAuthIcon\":\"layui-icon layui-icon-diamond\"}',
    ''
  );
INSERT INTO
  `rt_mod` (
    `id`,
    `name`,
    `key`,
    `server_path`,
    `tables_main`,
    `tables_more`,
    `type`,
    `params`,
    `extra`,
    `remark`
  )
VALUES
  (
    53,
    '文档编辑器',
    'word',
    'server',
    'rt_word',
    '',
    5,
    '',
    '{\"topAuthId\":\"1\",\"topAuthIcon\":\"layui-icon layui-icon-read\"}',
    ''
  );
INSERT INTO
  `rt_mod` (
    `id`,
    `name`,
    `key`,
    `server_path`,
    `tables_main`,
    `tables_more`,
    `type`,
    `params`,
    `extra`,
    `remark`
  )
VALUES
  (
    54,
    '文本编辑器',
    'txt',
    'server',
    'rt_txt',
    '',
    5,
    '',
    '{\"topAuthId\":\"1\",\"topAuthIcon\":\"layui-icon layui-icon-username\"}',
    ''
  );
INSERT INTO
  `rt_mod` (
    `id`,
    `name`,
    `key`,
    `server_path`,
    `tables_main`,
    `tables_more`,
    `type`,
    `params`,
    `extra`,
    `remark`
  )
VALUES
  (
    55,
    '任务看板',
    'kanban',
    'server',
    'rt_kanban',
    '',
    5,
    '',
    '{\"topAuthId\":\"1\",\"topAuthIcon\":\"layui-icon layui-icon-file-b\"}',
    ''
  );
INSERT INTO
  `rt_mod` (
    `id`,
    `name`,
    `key`,
    `server_path`,
    `tables_main`,
    `tables_more`,
    `type`,
    `params`,
    `extra`,
    `remark`
  )
VALUES
  (
    56,
    '地区管理',
    'area',
    'server',
    'rt_area',
    '',
    5,
    '',
    '{\"topAuthId\":\"3\",\"topAuthIcon\":\"layui-icon layui-icon-website\"}',
    ''
  );
INSERT INTO
  `rt_mod` (
    `id`,
    `name`,
    `key`,
    `server_path`,
    `tables_main`,
    `tables_more`,
    `type`,
    `params`,
    `extra`,
    `remark`
  )
VALUES
  (
    57,
    '部门管理',
    'department',
    'server',
    'rt_department',
    '',
    5,
    '',
    '{\"topAuthId\":\"3\",\"topAuthIcon\":\"layui-icon layui-icon-cols\"}',
    ''
  );
INSERT INTO
  `rt_mod` (
    `id`,
    `name`,
    `key`,
    `server_path`,
    `tables_main`,
    `tables_more`,
    `type`,
    `params`,
    `extra`,
    `remark`
  )
VALUES
  (
    58,
    '公司管理',
    'company',
    'server',
    'rt_company',
    '',
    5,
    '',
    '{\"topAuthId\":\"3\",\"topAuthIcon\":\"layui-icon layui-icon-cellphone\"}',
    ''
  );
INSERT INTO
  `rt_mod` (
    `id`,
    `name`,
    `key`,
    `server_path`,
    `tables_main`,
    `tables_more`,
    `type`,
    `params`,
    `extra`,
    `remark`
  )
VALUES
  (
    59,
    '岗位管理',
    'position',
    'server',
    'rt_position',
    '',
    5,
    '',
    '{\"topAuthId\":\"3\",\"topAuthIcon\":\"layui-icon layui-icon-note\"}',
    ''
  );

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: rt_params
# ------------------------------------------------------------

INSERT INTO
  `rt_params` (`id`, `name`, `key`, `content`, `type`)
VALUES
  (1, '路径', 'path', 'path', 1);
INSERT INTO
  `rt_params` (`id`, `name`, `key`, `content`, `type`)
VALUES
  (2, '文件操作', 'fs', 'fs', 1);

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: rt_picedit
# ------------------------------------------------------------

INSERT INTO
  `rt_picedit` (
    `id`,
    `add_time`,
    `update_time`,
    `user_id`,
    `title`,
    `content`
  )
VALUES
  (
    2,
    1639629576,
    0,
    1,
    'image.png',
    '1639629576609image.png'
  );
INSERT INTO
  `rt_picedit` (
    `id`,
    `add_time`,
    `update_time`,
    `user_id`,
    `title`,
    `content`
  )
VALUES
  (
    3,
    1639629760,
    0,
    1,
    'image.png',
    '1639629760210image.png'
  );
INSERT INTO
  `rt_picedit` (
    `id`,
    `add_time`,
    `update_time`,
    `user_id`,
    `title`,
    `content`
  )
VALUES
  (
    6,
    1639630009,
    1639630029,
    1,
    'image25.png',
    '1639630009824image2.png'
  );
INSERT INTO
  `rt_picedit` (
    `id`,
    `add_time`,
    `update_time`,
    `user_id`,
    `title`,
    `content`
  )
VALUES
  (
    9,
    1639644913,
    0,
    1,
    'image',
    '1639644913069image.png'
  );
INSERT INTO
  `rt_picedit` (
    `id`,
    `add_time`,
    `update_time`,
    `user_id`,
    `title`,
    `content`
  )
VALUES
  (
    10,
    1639644961,
    0,
    1,
    'image',
    '1639644961630image.png'
  );
INSERT INTO
  `rt_picedit` (
    `id`,
    `add_time`,
    `update_time`,
    `user_id`,
    `title`,
    `content`
  )
VALUES
  (
    11,
    1639645000,
    0,
    1,
    'image',
    '1639645000411image.png'
  );
INSERT INTO
  `rt_picedit` (
    `id`,
    `add_time`,
    `update_time`,
    `user_id`,
    `title`,
    `content`
  )
VALUES
  (
    12,
    1639645073,
    0,
    1,
    'image',
    '1639645073696image.png'
  );
INSERT INTO
  `rt_picedit` (
    `id`,
    `add_time`,
    `update_time`,
    `user_id`,
    `title`,
    `content`
  )
VALUES
  (
    13,
    1639645230,
    0,
    1,
    'image',
    '1639645228013image.png'
  );
INSERT INTO
  `rt_picedit` (
    `id`,
    `add_time`,
    `update_time`,
    `user_id`,
    `title`,
    `content`
  )
VALUES
  (
    15,
    1639645667,
    1639646801,
    1,
    'image221',
    '1639645667215image.png'
  );

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: rt_planday
# ------------------------------------------------------------

INSERT INTO
  `rt_planday` (
    `id`,
    `add_time`,
    `update_time`,
    `user_id`,
    `title`,
    `content`,
    `start`,
    `end`
  )
VALUES
  (
    '020ea24a-f812-5913-93df-abc8ea55932f',
    1639624610,
    1639624623,
    1,
    'ddd1',
    '{\"title\":\"ddd1\",\"location\":\"dddd1\",\"id\":\"020ea24a-f812-5913-93df-abc8ea55932f\"}',
    1639540800,
    1639542600
  );
INSERT INTO
  `rt_planday` (
    `id`,
    `add_time`,
    `update_time`,
    `user_id`,
    `title`,
    `content`,
    `start`,
    `end`
  )
VALUES
  (
    '108ae168-0a10-558c-98a0-5f04111fce14',
    1639622230,
    1639624187,
    1,
    'fdf',
    '{\"id\":\"108ae168-0a10-558c-98a0-5f04111fce14\",\"title\":\"fdf\",\"body\":\"\",\"isAllDay\":\"false\",\"start\":\"1639625400000\",\"end\":\"1639627200000\",\"color\":\"#ffffff\",\"isVisible\":\"true\",\"bgColor\":\"#9e5fff\",\"dragBgColor\":\"#9e5fff\",\"borderColor\":\"#9e5fff\",\"calendarId\":\"1\",\"category\":\"time\",\"dueDateClass\":\"\",\"customStyle\":\"\",\"isPending\":\"false\",\"isFocused\":\"false\",\"isReadOnly\":\"false\",\"isPrivate\":\"false\",\"location\":\"fafdas\",\"attendees\":\"\",\"recurrenceRule\":\"\",\"state\":\"忙碌\",\"goingDuration\":\"0\",\"comingDuration\":\"0\",\"raw\":\"null\",\"__fe_id\":\"48\",\"init\":\"function(options) {\\n    options = util.extend({}, options);\\n    if (options.category === SCHEDULE_CATEGORY.ALLDAY) {\\n        options.isAllDay = true;\\n    }\\n\\n    this.id = options.id || \'\';\\n    this.title = options.title || \'\';\\n    this.body = options.body || \'\';\\n    this.isAllDay = util.isExisty(options.isAllDay) ? options.isAllDay : false;\\n    this.isVisible = util.isExisty(options.isVisible) ? options.isVisible : true;\\n\\n    this.color = options.color || this.color;\\n    this.bgColor = options.bgColor || this.bgColor;\\n    this.dragBgColor = options.dragBgColor || this.dragBgColor;\\n    this.borderColor = options.borderColor || this.borderColor;\\n    this.calendarId = options.calendarId || \'\';\\n    this.category = options.category || \'\';\\n    this.dueDateClass = options.dueDateClass || \'\';\\n    this.customStyle = options.customStyle || \'\';\\n    this.location = options.location || \'\';\\n    this.attendees = options.attendees || [];\\n    this.recurrenceRule = options.recurrenceRule || \'\';\\n    this.isPrivate = options.isPrivate || false;\\n    this.isPending = options.isPending || false;\\n    this.isFocused = options.isFocused || false;\\n    this.isReadOnly = options.isReadOnly || false;\\n    this.goingDuration = options.goingDuration || 0;\\n    this.comingDuration = options.comingDuration || 0;\\n    this.state = options.state || \'\';\\n\\n    if (this.isAllDay) {\\n        this.setAllDayPeriod(options.start, options.end);\\n    } else {\\n        this.setTimePeriod(options.start, options.end);\\n    }\\n\\n    this.raw = options.raw || null;\\n}\",\"setAllDayPeriod\":\"function(start, end) {\\n    // If it is an all-day schedule, only the date information of the string is used.\\n    if (util.isString(start) \",\" start.length \":\"== 10) {\\n        start = datetime.parse(start);\\n    } else {\\n        start = new TZDate(start || Date.now());\\n    }\\n\\n    if (util.isString(end) \",\" end.length \":\"== 10) {\\n        end = datetime.parse(end);\\n        end.setHours(23, 59, 59);\\n    } else {\\n        end = new TZDate(end || start);\\n    }\\n\\n    this.start = datetime.start(start);\\n    this.end = datetime.renderEnd(start, end);\\n}\",\"setTimePeriod\":\"function(start, end) {\\n    this.start = new TZDate(start || Date.now());\\n    this.end = new TZDate(end || this.start);\\n\\n    if (!end) {\\n        this.end.setMinutes(this.end.getMinutes()   30);\\n    }\\n}\",\"getStarts\":\"function() {\\n    return this.start;\\n}\",\"getEnds\":\"function() {\\n    return this.end;\\n}\",\"cid\":\"function() {\\n    return util.stamp(this);\\n}\",\"equals\":\"function(schedule) {\\n    if (this.id !== schedule.id) {\\n        return false;\\n    }\\n\\n    if (this.title !== schedule.title) {\\n        return false;\\n    }\\n\\n    if (this.body !== schedule.body) {\\n        return false;\\n    }\\n\\n    if (this.isAllDay !== schedule.isAllDay) {\\n        return false;\\n    }\\n\\n    if (datetime.compare(this.getStarts(), schedule.getStarts()) !== 0) {\\n        return false;\\n    }\\n\\n    if (datetime.compare(this.getEnds(), schedule.getEnds()) !== 0) {\\n        return false;\\n    }\\n\\n    if (this.color !== schedule.color) {\\n        return false;\\n    }\\n\\n    if (this.bgColor !== schedule.bgColor) {\\n        return false;\\n    }\\n\\n    if (this.dragBgColor !== schedule.dragBgColor) {\\n        return false;\\n    }\\n\\n    if (this.borderColor !== schedule.borderColor) {\\n        return false;\\n    }\\n\\n    return true;\\n}\",\"duration\":\"function() {\\n    var start = this.getStarts(),\\n        end = this.getEnds(),\\n        duration;\\n    var hasPrimaryTimezoneCustomSetting = tz.hasPrimaryTimezoneCustomSetting();\\n\\n    if (this.isAllDay) {\\n        duration = datetime.end(end) - datetime.start(start);\\n    } else if (hasPrimaryTimezoneCustomSetting \",\" tz.isPrimaryUsingDSTTimezone()) {\\n        duration \":\" getDurationByPrimaryTimezone(start, end);\\n    } else if (hasPrimaryTimezoneCustomSetting \",\" tz.isNativeOsUsingDSTTimezone()) {\\n        duration \":\" getDurationByNativeTimezone(start, end);\\n    } else {\\n        duration = end - start;\\n    }\\n\\n    return duration;\\n}\",\"collidesWith\":\"function(schedule) {\\n    var ownStarts = this.getStarts(),\\n        ownEnds = this.getEnds(),\\n        start = schedule.getStarts(),\\n        end = schedule.getEnds();\\n    var ownGoingDuration = datetime.millisecondsFrom(\'minutes\', this.goingDuration),\\n        ownComingDuration = datetime.millisecondsFrom(\'minutes\', this.comingDuration),\\n        goingDuration = datetime.millisecondsFrom(\'minutes\', schedule.goingDuration),\\n        comingDuration = datetime.millisecondsFrom(\'minutes\', schedule.comingDuration);\\n\\n    if (Math.abs(ownEnds - ownStarts) < SCHEDULE_MIN_DURATION) {\\n        ownEnds  = SCHEDULE_MIN_DURATION;\\n    }\\n\\n    if (Math.abs(end - start) < SCHEDULE_MIN_DURATION) {\\n        end  = SCHEDULE_MIN_DURATION;\\n    }\\n\\n    ownStarts -= ownGoingDuration;\\n    ownEnds  = ownComingDuration;\\n    start -= goingDuration;\\n    end  = comingDuration;\\n\\n    if (\\n        (start > ownStarts \",\" start < ownEnds) ||\\n        (end > ownStarts \":\"\",\" end < ownEnds) ||\\n        (start <\":\" ownStarts \",\" end >\":\" ownEnds)\\n    ) {\\n        return true;\\n    }\\n\\n    return false;\\n}\",\"trim\":\"function(str) {\\n        return str.replace(spaceRx, \'\');\\n    }\",\"validators\":\"[object Object]\",\"isValid\":\"function() {\\n        var self = this,\\n            schema = this.constructor.schema,\\n            validators = model.validators,\\n            validator,\\n            valid = true;\\n\\n        if (!schema) {\\n            return true;\\n        }\\n\\n        util.forEach(schema, function(values, validatorName) {\\n            validator = validators[validatorName];\\n\\n            if (validator) {\\n                valid = validator(self, values);\\n\\n                return valid; // returning false can stop this loop\\n            }\\n\\n            return true;\\n        });\\n\\n        return valid;\\n    }\",\"parameterize\":\"function() {\\n        var param = {},\\n            isFunc = util.isFunction;\\n\\n        util.forEach(this, function(value, propName) {\\n            if (!isFunc(value)) {\\n                param[propName] = value;\\n            }\\n        });\\n\\n        return param;\\n    }\",\"set\":\"function(propName, value) {\\n        var originValue = this[propName];\\n\\n        if (originValue === value) {\\n            return;\\n        }\\n\\n        this[propName] = value;\\n\\n        if (!this._changed) {\\n            /**\\n             * Save changed properties.\\n             * @memberof dirty\\n             * @name _changed\\n             * @type {Object}\\n             */\\n            this._changed = {};\\n        }\\n\\n        this._changed[propName] = true;\\n\\n        /**\\n         * Dirty flag\\n         * @type {Boolean}\\n         * @name _dirty\\n         * @memberof dirty\\n         */\\n        this._dirty = true;\\n    }\",\"isDirty\":\"function() {\\n        return !!this._dirty;\\n    }\",\"dirty\":\"function(toDirty) {\\n        toDirty = existy(toDirty) ? toDirty : true;\\n\\n        /* istanbul ignore else */\\n        if (!toDirty) {\\n            this._changed = {};\\n        }\\n\\n        this._dirty = toDirty;\\n    }\",\"deleteProp\":\"function(propName) {\\n        delete this[propName];\\n\\n        if (this._changed) {\\n            delete this._changed[propName];\\n        }\\n    }\",\"isPropChanged\":\"function(propName) {\\n        if (!this._changed) {\\n            return false;\\n        }\\n\\n        return this._changed[propName] === true;\\n    }\"}',
    1639625400,
    1639627200
  );
INSERT INTO
  `rt_planday` (
    `id`,
    `add_time`,
    `update_time`,
    `user_id`,
    `title`,
    `content`,
    `start`,
    `end`
  )
VALUES
  (
    '204cc1e1-1df1-5bba-baaf-ccf158502310',
    1639703596,
    1639703690,
    1,
    '完成看板环境搭建',
    '{\"id\":\"204cc1e1-1df1-5bba-baaf-ccf158502310\",\"title\":\"完成看板环境搭建\",\"isAllDay\":\"false\",\"start\":\"1639704600000\",\"end\":\"1639706400000\",\"category\":\"time\",\"dueDateClass\":\"\",\"color\":\"#ffffff\",\"bgColor\":\"#9e5fff\",\"dragBgColor\":\"#9e5fff\",\"borderColor\":\"#9e5fff\",\"location\":\"公司\",\"isPrivate\":\"false\",\"state\":\"忙碌\",\"calendarId\":\"1\"}',
    1639704600,
    1639706400
  );
INSERT INTO
  `rt_planday` (
    `id`,
    `add_time`,
    `update_time`,
    `user_id`,
    `title`,
    `content`,
    `start`,
    `end`
  )
VALUES
  (
    '29c1f496-dcfe-5c46-a5bf-51408479470f',
    1639623733,
    1639624163,
    1,
    'da',
    '{\"id\":\"29c1f496-dcfe-5c46-a5bf-51408479470f\",\"title\":\"da\",\"body\":\"\",\"isAllDay\":\"false\",\"start\":\"1639539000000\",\"end\":\"1639540800000\",\"color\":\"#ffffff\",\"isVisible\":\"true\",\"bgColor\":\"#9e5fff\",\"dragBgColor\":\"#9e5fff\",\"borderColor\":\"#9e5fff\",\"calendarId\":\"1\",\"category\":\"time\",\"dueDateClass\":\"\",\"customStyle\":\"\",\"isPending\":\"false\",\"isFocused\":\"false\",\"isReadOnly\":\"false\",\"isPrivate\":\"false\",\"location\":\"ddd\",\"attendees\":\"\",\"recurrenceRule\":\"\",\"state\":\"忙碌\",\"goingDuration\":\"0\",\"comingDuration\":\"0\",\"raw\":\"null\",\"__fe_id\":\"47\",\"init\":\"function(options) {\\n    options = util.extend({}, options);\\n    if (options.category === SCHEDULE_CATEGORY.ALLDAY) {\\n        options.isAllDay = true;\\n    }\\n\\n    this.id = options.id || \'\';\\n    this.title = options.title || \'\';\\n    this.body = options.body || \'\';\\n    this.isAllDay = util.isExisty(options.isAllDay) ? options.isAllDay : false;\\n    this.isVisible = util.isExisty(options.isVisible) ? options.isVisible : true;\\n\\n    this.color = options.color || this.color;\\n    this.bgColor = options.bgColor || this.bgColor;\\n    this.dragBgColor = options.dragBgColor || this.dragBgColor;\\n    this.borderColor = options.borderColor || this.borderColor;\\n    this.calendarId = options.calendarId || \'\';\\n    this.category = options.category || \'\';\\n    this.dueDateClass = options.dueDateClass || \'\';\\n    this.customStyle = options.customStyle || \'\';\\n    this.location = options.location || \'\';\\n    this.attendees = options.attendees || [];\\n    this.recurrenceRule = options.recurrenceRule || \'\';\\n    this.isPrivate = options.isPrivate || false;\\n    this.isPending = options.isPending || false;\\n    this.isFocused = options.isFocused || false;\\n    this.isReadOnly = options.isReadOnly || false;\\n    this.goingDuration = options.goingDuration || 0;\\n    this.comingDuration = options.comingDuration || 0;\\n    this.state = options.state || \'\';\\n\\n    if (this.isAllDay) {\\n        this.setAllDayPeriod(options.start, options.end);\\n    } else {\\n        this.setTimePeriod(options.start, options.end);\\n    }\\n\\n    this.raw = options.raw || null;\\n}\",\"setAllDayPeriod\":\"function(start, end) {\\n    // If it is an all-day schedule, only the date information of the string is used.\\n    if (util.isString(start) \",\" start.length \":\"== 10) {\\n        start = datetime.parse(start);\\n    } else {\\n        start = new TZDate(start || Date.now());\\n    }\\n\\n    if (util.isString(end) \",\" end.length \":\"== 10) {\\n        end = datetime.parse(end);\\n        end.setHours(23, 59, 59);\\n    } else {\\n        end = new TZDate(end || start);\\n    }\\n\\n    this.start = datetime.start(start);\\n    this.end = datetime.renderEnd(start, end);\\n}\",\"setTimePeriod\":\"function(start, end) {\\n    this.start = new TZDate(start || Date.now());\\n    this.end = new TZDate(end || this.start);\\n\\n    if (!end) {\\n        this.end.setMinutes(this.end.getMinutes()   30);\\n    }\\n}\",\"getStarts\":\"function() {\\n    return this.start;\\n}\",\"getEnds\":\"function() {\\n    return this.end;\\n}\",\"cid\":\"function() {\\n    return util.stamp(this);\\n}\",\"equals\":\"function(schedule) {\\n    if (this.id !== schedule.id) {\\n        return false;\\n    }\\n\\n    if (this.title !== schedule.title) {\\n        return false;\\n    }\\n\\n    if (this.body !== schedule.body) {\\n        return false;\\n    }\\n\\n    if (this.isAllDay !== schedule.isAllDay) {\\n        return false;\\n    }\\n\\n    if (datetime.compare(this.getStarts(), schedule.getStarts()) !== 0) {\\n        return false;\\n    }\\n\\n    if (datetime.compare(this.getEnds(), schedule.getEnds()) !== 0) {\\n        return false;\\n    }\\n\\n    if (this.color !== schedule.color) {\\n        return false;\\n    }\\n\\n    if (this.bgColor !== schedule.bgColor) {\\n        return false;\\n    }\\n\\n    if (this.dragBgColor !== schedule.dragBgColor) {\\n        return false;\\n    }\\n\\n    if (this.borderColor !== schedule.borderColor) {\\n        return false;\\n    }\\n\\n    return true;\\n}\",\"duration\":\"function() {\\n    var start = this.getStarts(),\\n        end = this.getEnds(),\\n        duration;\\n    var hasPrimaryTimezoneCustomSetting = tz.hasPrimaryTimezoneCustomSetting();\\n\\n    if (this.isAllDay) {\\n        duration = datetime.end(end) - datetime.start(start);\\n    } else if (hasPrimaryTimezoneCustomSetting \",\" tz.isPrimaryUsingDSTTimezone()) {\\n        duration \":\" getDurationByPrimaryTimezone(start, end);\\n    } else if (hasPrimaryTimezoneCustomSetting \",\" tz.isNativeOsUsingDSTTimezone()) {\\n        duration \":\" getDurationByNativeTimezone(start, end);\\n    } else {\\n        duration = end - start;\\n    }\\n\\n    return duration;\\n}\",\"collidesWith\":\"function(schedule) {\\n    var ownStarts = this.getStarts(),\\n        ownEnds = this.getEnds(),\\n        start = schedule.getStarts(),\\n        end = schedule.getEnds();\\n    var ownGoingDuration = datetime.millisecondsFrom(\'minutes\', this.goingDuration),\\n        ownComingDuration = datetime.millisecondsFrom(\'minutes\', this.comingDuration),\\n        goingDuration = datetime.millisecondsFrom(\'minutes\', schedule.goingDuration),\\n        comingDuration = datetime.millisecondsFrom(\'minutes\', schedule.comingDuration);\\n\\n    if (Math.abs(ownEnds - ownStarts) < SCHEDULE_MIN_DURATION) {\\n        ownEnds  = SCHEDULE_MIN_DURATION;\\n    }\\n\\n    if (Math.abs(end - start) < SCHEDULE_MIN_DURATION) {\\n        end  = SCHEDULE_MIN_DURATION;\\n    }\\n\\n    ownStarts -= ownGoingDuration;\\n    ownEnds  = ownComingDuration;\\n    start -= goingDuration;\\n    end  = comingDuration;\\n\\n    if (\\n        (start > ownStarts \",\" start < ownEnds) ||\\n        (end > ownStarts \":\"\",\" end < ownEnds) ||\\n        (start <\":\" ownStarts \",\" end >\":\" ownEnds)\\n    ) {\\n        return true;\\n    }\\n\\n    return false;\\n}\",\"trim\":\"function(str) {\\n        return str.replace(spaceRx, \'\');\\n    }\",\"validators\":\"[object Object]\",\"isValid\":\"function() {\\n        var self = this,\\n            schema = this.constructor.schema,\\n            validators = model.validators,\\n            validator,\\n            valid = true;\\n\\n        if (!schema) {\\n            return true;\\n        }\\n\\n        util.forEach(schema, function(values, validatorName) {\\n            validator = validators[validatorName];\\n\\n            if (validator) {\\n                valid = validator(self, values);\\n\\n                return valid; // returning false can stop this loop\\n            }\\n\\n            return true;\\n        });\\n\\n        return valid;\\n    }\",\"parameterize\":\"function() {\\n        var param = {},\\n            isFunc = util.isFunction;\\n\\n        util.forEach(this, function(value, propName) {\\n            if (!isFunc(value)) {\\n                param[propName] = value;\\n            }\\n        });\\n\\n        return param;\\n    }\",\"set\":\"function(propName, value) {\\n        var originValue = this[propName];\\n\\n        if (originValue === value) {\\n            return;\\n        }\\n\\n        this[propName] = value;\\n\\n        if (!this._changed) {\\n            /**\\n             * Save changed properties.\\n             * @memberof dirty\\n             * @name _changed\\n             * @type {Object}\\n             */\\n            this._changed = {};\\n        }\\n\\n        this._changed[propName] = true;\\n\\n        /**\\n         * Dirty flag\\n         * @type {Boolean}\\n         * @name _dirty\\n         * @memberof dirty\\n         */\\n        this._dirty = true;\\n    }\",\"isDirty\":\"function() {\\n        return !!this._dirty;\\n    }\",\"dirty\":\"function(toDirty) {\\n        toDirty = existy(toDirty) ? toDirty : true;\\n\\n        /* istanbul ignore else */\\n        if (!toDirty) {\\n            this._changed = {};\\n        }\\n\\n        this._dirty = toDirty;\\n    }\",\"deleteProp\":\"function(propName) {\\n        delete this[propName];\\n\\n        if (this._changed) {\\n            delete this._changed[propName];\\n        }\\n    }\",\"isPropChanged\":\"function(propName) {\\n        if (!this._changed) {\\n            return false;\\n        }\\n\\n        return this._changed[propName] === true;\\n    }\"}',
    1639539000,
    1639540800
  );
INSERT INTO
  `rt_planday` (
    `id`,
    `add_time`,
    `update_time`,
    `user_id`,
    `title`,
    `content`,
    `start`,
    `end`
  )
VALUES
  (
    '4e8fdcdc-d88d-582c-8162-fdc1ff010ef4',
    1639624527,
    1639624536,
    1,
    'ddd1',
    '{\"title\":\"ddd1\",\"location\":\"ddd1\",\"id\":\"4e8fdcdc-d88d-582c-8162-fdc1ff010ef4\"}',
    1639540800,
    1639542600
  );
INSERT INTO
  `rt_planday` (
    `id`,
    `add_time`,
    `update_time`,
    `user_id`,
    `title`,
    `content`,
    `start`,
    `end`
  )
VALUES
  (
    '56ce7320-1671-58f1-8f92-8d14b9e7b188',
    1639624748,
    1639624748,
    1,
    '555',
    '{\"id\":\"56ce7320-1671-58f1-8f92-8d14b9e7b188\",\"title\":\"555\",\"isAllDay\":\"false\",\"start\":\"1638754200000\",\"end\":\"1638756000000\",\"category\":\"time\",\"dueDateClass\":\"\",\"color\":\"#ffffff\",\"bgColor\":\"#9e5fff\",\"dragBgColor\":\"#9e5fff\",\"borderColor\":\"#9e5fff\",\"location\":\"fff\",\"isPrivate\":\"false\",\"state\":\"忙碌\",\"calendarId\":\"1\"}',
    1638754200,
    1638756000
  );
INSERT INTO
  `rt_planday` (
    `id`,
    `add_time`,
    `update_time`,
    `user_id`,
    `title`,
    `content`,
    `start`,
    `end`
  )
VALUES
  (
    '6abb6b1a-4c11-5762-8864-854930f31f80',
    1641434060,
    1641434060,
    1,
    'test',
    '{\"id\":\"6abb6b1a-4c11-5762-8864-854930f31f80\",\"title\":\"test\",\"isAllDay\":\"false\",\"start\":\"1641432600000\",\"end\":\"1641434400000\",\"category\":\"time\",\"dueDateClass\":\"\",\"color\":\"#ffffff\",\"bgColor\":\"#9e5fff\",\"dragBgColor\":\"#9e5fff\",\"borderColor\":\"#9e5fff\",\"location\":\"test\",\"isPrivate\":\"false\",\"state\":\"忙碌\",\"calendarId\":\"1\"}',
    1641432600,
    1641434400
  );
INSERT INTO
  `rt_planday` (
    `id`,
    `add_time`,
    `update_time`,
    `user_id`,
    `title`,
    `content`,
    `start`,
    `end`
  )
VALUES
  (
    '6bff8a38-52e5-501e-bfcb-243e1ed01fd1',
    1639624645,
    1639624651,
    1,
    'dd1',
    '{\"title\":\"dd1\",\"location\":\"ddd1\",\"id\":\"6bff8a38-52e5-501e-bfcb-243e1ed01fd1\"}',
    1639542600,
    1639544400
  );
INSERT INTO
  `rt_planday` (
    `id`,
    `add_time`,
    `update_time`,
    `user_id`,
    `title`,
    `content`,
    `start`,
    `end`
  )
VALUES
  (
    '9060c719-d46f-514d-a88b-0e38601175a2',
    1639625697,
    1639625697,
    1,
    'fdas',
    '{\"id\":\"9060c719-d46f-514d-a88b-0e38601175a2\",\"title\":\"fdas\",\"isAllDay\":\"false\",\"start\":\"1639499400000\",\"end\":\"1639501200000\",\"category\":\"time\",\"dueDateClass\":\"\",\"color\":\"#ffffff\",\"bgColor\":\"#9e5fff\",\"dragBgColor\":\"#9e5fff\",\"borderColor\":\"#9e5fff\",\"location\":\"fdsaf\",\"isPrivate\":\"false\",\"state\":\"忙碌\",\"calendarId\":\"1\"}',
    1639499400,
    1639501200
  );
INSERT INTO
  `rt_planday` (
    `id`,
    `add_time`,
    `update_time`,
    `user_id`,
    `title`,
    `content`,
    `start`,
    `end`
  )
VALUES
  (
    '97cbba3e-21c9-5e36-94d3-0175a76a7681',
    1639648171,
    1639648171,
    1,
    '完成svg环境',
    '{\"id\":\"97cbba3e-21c9-5e36-94d3-0175a76a7681\",\"title\":\"完成svg环境\",\"isAllDay\":\"false\",\"start\":\"1639648800000\",\"end\":\"1639650600000\",\"category\":\"time\",\"dueDateClass\":\"\",\"color\":\"#ffffff\",\"bgColor\":\"#9e5fff\",\"dragBgColor\":\"#9e5fff\",\"borderColor\":\"#9e5fff\",\"location\":\"\",\"isPrivate\":\"false\",\"state\":\"忙碌\",\"calendarId\":\"1\"}',
    1639648800,
    1639650600
  );
INSERT INTO
  `rt_planday` (
    `id`,
    `add_time`,
    `update_time`,
    `user_id`,
    `title`,
    `content`,
    `start`,
    `end`
  )
VALUES
  (
    'c6167299-19e0-516f-9452-cadb04dae78b',
    1639620632,
    1639624485,
    1,
    'ddd1',
    '{\"title\":\"ddd1\",\"location\":\"dddd1\",\"id\":\"c6167299-19e0-516f-9452-cadb04dae78b\"}',
    1639526400,
    1639528200
  );
INSERT INTO
  `rt_planday` (
    `id`,
    `add_time`,
    `update_time`,
    `user_id`,
    `title`,
    `content`,
    `start`,
    `end`
  )
VALUES
  (
    'df4f5644-30bd-59d5-b00f-696c989fccd8',
    1639550941,
    1639624465,
    1,
    '9999a',
    '{\"title\":\"9999a\",\"location\":\"2222a\",\"id\":\"df4f5644-30bd-59d5-b00f-696c989fccd8\"}',
    1639548000,
    1639549800
  );

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: rt_position
# ------------------------------------------------------------

INSERT INTO
  `rt_position` (`id`, `title`, `rules`, `status`, `remark`)
VALUES
  (2, 'aaa', '1,4,5,7,37,53', 0, 'aaa');
INSERT INTO
  `rt_position` (`id`, `title`, `rules`, `status`, `remark`)
VALUES
  (
    15,
    'test2',
    '1,4,5,7,37,53,2,9,20,21,22,23,57,10,26,27,56,58,59,60,61,11,24,25,62,63,64,65,12,66,67,68,13,28,29,30,31,32,14,33,34,35,36,3,15',
    1,
    ''
  );

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: rt_ppt
# ------------------------------------------------------------

INSERT INTO
  `rt_ppt` (
    `id`,
    `title`,
    `content`,
    `add_time`,
    `update_time`,
    `user_id`
  )
VALUES
  (
    1,
    'test',
    '[{\"id\":\"test123456\",\"elements\":[{\"type\":\"shape\",\"id\":\"4cbRxp\",\"left\":0,\"top\":200,\"width\":546,\"height\":362.5,\"viewBox\":200,\"path\":\"M 0 0 L 0 200 L 200 200 Z\",\"fill\":\"#5b9bd5\",\"fixedRatio\":false,\"opacity\":0.7,\"rotate\":0},{\"type\":\"shape\",\"id\":\"ookHrf\",\"left\":0,\"top\":0,\"width\":300,\"height\":320,\"viewBox\":200,\"path\":\"M 0 0 L 0 200 L 200 200 Z\",\"fill\":\"#5b9bd5\",\"fixedRatio\":false,\"flipV\":true,\"rotate\":0},{\"type\":\"text\",\"id\":\"idn7Mx\",\"left\":355,\"top\":65.25,\"width\":585,\"height\":125.60000610351562,\"lineHeight\":1.2,\"content\":\"<p><strong><span style=\'font-size:  88px\'>PPT</span></strong></p>\",\"rotate\":0,\"defaultFontName\":\"Microsoft Yahei\",\"defaultColor\":\"#333\"},{\"type\":\"text\",\"id\":\"7stmVP\",\"left\":355,\"top\":253.25,\"width\":585,\"height\":56,\"content\":\"<p><span style=\'font-size:  24px\'>在线演示文稿</span></p>\",\"rotate\":0,\"defaultFontName\":\"Microsoft Yahei\",\"defaultColor\":\"#333\"},{\"type\":\"line\",\"id\":\"FnpZs4\",\"left\":361,\"top\":238,\"start\":[0,0],\"end\":[549,0],\"points\":[\"\",\"\"],\"color\":\"#5b9bd5\",\"style\":\"solid\",\"width\":2}],\"background\":{\"type\":\"solid\",\"color\":\"#ffffff\"}}]',
    0,
    0,
    0
  );
INSERT INTO
  `rt_ppt` (
    `id`,
    `title`,
    `content`,
    `add_time`,
    `update_time`,
    `user_id`
  )
VALUES
  (
    2,
    '演示文稿55561',
    '[{\"id\":\"test123456\",\"elements\":[{\"type\":\"shape\",\"id\":\"4cbRxp\",\"left\":0,\"top\":200,\"width\":546,\"height\":362.5,\"viewBox\":200,\"path\":\"M 0 0 L 0 200 L 200 200 Z\",\"fill\":\"#5b9bd5\",\"fixedRatio\":false,\"opacity\":0.7,\"rotate\":0},{\"type\":\"shape\",\"id\":\"ookHrf\",\"left\":0,\"top\":0,\"width\":300,\"height\":320,\"viewBox\":200,\"path\":\"M 0 0 L 0 200 L 200 200 Z\",\"fill\":\"#5b9bd5\",\"fixedRatio\":false,\"flipV\":true,\"rotate\":0},{\"type\":\"text\",\"id\":\"idn7Mx\",\"left\":355,\"top\":65.25,\"width\":585,\"height\":125.60000610351562,\"lineHeight\":1.2,\"content\":\"<p style=\\\"\\\"><strong><span style=\\\"font-size: 88px\\\">PPT888</span></strong></p>\",\"rotate\":0,\"defaultFontName\":\"Microsoft Yahei\",\"defaultColor\":\"#333\"},{\"type\":\"text\",\"id\":\"7stmVP\",\"left\":355,\"top\":253.25,\"width\":585,\"height\":56,\"content\":\"<p><span style=\'font-size:  24px\'>在线演示文稿</span></p>\",\"rotate\":0,\"defaultFontName\":\"Microsoft Yahei\",\"defaultColor\":\"#333\"},{\"type\":\"line\",\"id\":\"FnpZs4\",\"left\":361,\"top\":238,\"start\":[0,0],\"end\":[549,0],\"points\":[\"\",\"\"],\"color\":\"#5b9bd5\",\"style\":\"solid\",\"width\":2}],\"background\":{\"type\":\"solid\",\"color\":\"#ffffff\"}},{\"id\":\"eK1bwZPo\",\"elements\":[{\"type\":\"shape\",\"id\":\"cS7Jw3\",\"left\":0,\"top\":200,\"width\":546,\"height\":362.5,\"viewBox\":200,\"path\":\"M 0 0 L 0 200 L 200 200 Z\",\"fill\":\"#5b9bd5\",\"fixedRatio\":false,\"opacity\":0.7,\"rotate\":0},{\"type\":\"shape\",\"id\":\"lYdAQH\",\"left\":0,\"top\":0,\"width\":300,\"height\":320,\"viewBox\":200,\"path\":\"M 0 0 L 0 200 L 200 200 Z\",\"fill\":\"#5b9bd5\",\"fixedRatio\":false,\"flipV\":true,\"rotate\":0},{\"type\":\"text\",\"id\":\"VybPF7\",\"left\":355,\"top\":95.11111111111111,\"width\":585,\"height\":116,\"lineHeight\":1.2,\"content\":\"<p style=\'\'><strong><span style=\'font-size: 80px\'>输入标题</span></strong></p>\",\"rotate\":0,\"defaultFontName\":\"Microsoft Yahei\",\"defaultColor\":\"#333\",\"wordSpace\":6},{\"type\":\"text\",\"id\":\"ReiqQH\",\"left\":355,\"top\":253.25,\"width\":585,\"height\":56,\"content\":\"<p><span style=\'font-size:  24px\'>请在此处输入副标题</span></p>\",\"rotate\":0,\"defaultFontName\":\"Microsoft Yahei\",\"defaultColor\":\"#333\"},{\"type\":\"line\",\"id\":\"bGz8zU\",\"left\":361,\"top\":238,\"start\":[0,0],\"end\":[549,0],\"points\":[\"\",\"\"],\"color\":\"#5b9bd5\",\"style\":\"solid\",\"width\":2}],\"background\":{\"type\":\"solid\",\"color\":\"#fff\"}},{\"id\":\"5xGOtYOf\",\"elements\":[{\"type\":\"shape\",\"id\":\"3xK55K\",\"left\":183.5185185185185,\"top\":175.5092592592593,\"width\":605.1851851851851,\"height\":185.18518518518516,\"viewBox\":200,\"path\":\"M 0 0 L 200 0 L 200 200 L 0 200 Z\",\"fill\":\"#5b9bd5\",\"fixedRatio\":false,\"rotate\":0},{\"type\":\"shape\",\"id\":\"cGM7Xu\",\"left\":211.29629629629628,\"top\":201.80555555555557,\"width\":605.1851851851851,\"height\":185.18518518518516,\"viewBox\":200,\"path\":\"M 0 0 L 200 0 L 200 200 L 0 200 Z\",\"fill\":\"#5b9bd5\",\"fixedRatio\":false,\"rotate\":0,\"opacity\":0.7},{\"type\":\"text\",\"id\":\"QZYVcG\",\"left\":304.9074074074074,\"top\":198.10185185185182,\"width\":417.9629629629629,\"height\":140,\"content\":\"<p style=\'text-align: center;\'><strong><span style=\'color: #ffffff;\'><span style=\'font-size: 80px\'>感谢观看</span></span></strong></p>\",\"rotate\":0,\"defaultFontName\":\"Microsoft Yahei\",\"defaultColor\":\"#333\",\"wordSpace\":5}],\"background\":{\"type\":\"solid\",\"color\":\"#fff\"}}]',
    1638156886,
    1638165071,
    1
  );
INSERT INTO
  `rt_ppt` (
    `id`,
    `title`,
    `content`,
    `add_time`,
    `update_time`,
    `user_id`
  )
VALUES
  (
    3,
    '演示文稿',
    '[{\"id\":\"ppt1638164498162\",\"elements\":[{\"type\":\"shape\",\"id\":\"4cbRxp\",\"left\":0,\"top\":200,\"width\":546,\"height\":362.5,\"viewBox\":200,\"path\":\"M 0 0 L 0 200 L 200 200 Z\",\"fill\":\"#5b9bd5\",\"fixedRatio\":false,\"opacity\":0.7,\"rotate\":0},{\"type\":\"shape\",\"id\":\"ookHrf\",\"left\":0,\"top\":0,\"width\":300,\"height\":320,\"viewBox\":200,\"path\":\"M 0 0 L 0 200 L 200 200 Z\",\"fill\":\"#5b9bd5\",\"fixedRatio\":false,\"flipV\":true,\"rotate\":0},{\"type\":\"text\",\"id\":\"idn7Mx\",\"left\":355,\"top\":65.25,\"width\":585,\"height\":125.60000610351562,\"lineHeight\":1.2,\"content\":\"<p><strong><span style=\'font-size:  88px\'>PPT</span></strong></p>\",\"rotate\":0,\"defaultFontName\":\"Microsoft Yahei\",\"defaultColor\":\"#333\"},{\"type\":\"text\",\"id\":\"7stmVP\",\"left\":355,\"top\":253.25,\"width\":585,\"height\":56,\"content\":\"<p><span style=\'font-size:  24px\'>在线演示文稿</span></p>\",\"rotate\":0,\"defaultFontName\":\"Microsoft Yahei\",\"defaultColor\":\"#333\"},{\"type\":\"line\",\"id\":\"FnpZs4\",\"left\":361,\"top\":238,\"start\":[0,0],\"end\":[549,0],\"points\":[\"\",\"\"],\"color\":\"#5b9bd5\",\"style\":\"solid\",\"width\":2}],\"background\":{\"type\":\"solid\",\"color\":\"#ffffff\"}},{\"id\":\"7YXpcWVz\",\"elements\":[{\"type\":\"shape\",\"id\":\"hVDdjx\",\"left\":183.5185185185185,\"top\":175.5092592592593,\"width\":605.1851851851851,\"height\":185.18518518518516,\"viewBox\":200,\"path\":\"M 0 0 L 200 0 L 200 200 L 0 200 Z\",\"fill\":\"#5b9bd5\",\"fixedRatio\":false,\"rotate\":0},{\"type\":\"shape\",\"id\":\"8f5TT9\",\"left\":211.29629629629628,\"top\":201.80555555555557,\"width\":605.1851851851851,\"height\":185.18518518518516,\"viewBox\":200,\"path\":\"M 0 0 L 200 0 L 200 200 L 0 200 Z\",\"fill\":\"#5b9bd5\",\"fixedRatio\":false,\"rotate\":0,\"opacity\":0.7},{\"type\":\"text\",\"id\":\"f8LjH9\",\"left\":304.9074074074074,\"top\":198.10185185185182,\"width\":417.9629629629629,\"height\":140,\"content\":\"<p style=\'text-align: center;\'><strong><span style=\'color: #ffffff;\'><span style=\'font-size: 80px\'>感谢观看</span></span></strong></p>\",\"rotate\":0,\"defaultFontName\":\"Microsoft Yahei\",\"defaultColor\":\"#333\",\"wordSpace\":5}],\"background\":{\"type\":\"solid\",\"color\":\"#fff\"}},{\"id\":\"rzT06u7Z\",\"elements\":[{\"type\":\"shape\",\"id\":\"UhiLsI\",\"left\":0,\"top\":0,\"width\":352.59259259259255,\"height\":562.5,\"viewBox\":200,\"path\":\"M 0 0 L 200 0 L 200 200 L 0 200 Z\",\"fill\":\"#5b9bd5\",\"fixedRatio\":false,\"rotate\":0},{\"type\":\"shape\",\"id\":\"KvWdrM\",\"left\":171.4814814814814,\"top\":100.13888888888887,\"width\":362.22222222222223,\"height\":362.22222222222223,\"viewBox\":200,\"path\":\"M 100 0 A 50 50 0 1 1 100 200 A 50 50 0 1 1 100 0 Z\",\"fill\":\"rgba(255,255,255,0)\",\"fixedRatio\":false,\"rotate\":0,\"outline\":{\"width\":10,\"color\":\"#fff\",\"style\":\"solid\"}},{\"type\":\"shape\",\"id\":\"e0oWwX\",\"left\":216.66666666666663,\"top\":145.32407407407408,\"width\":271.85185185185185,\"height\":271.85185185185185,\"viewBox\":200,\"path\":\"M 100 0 A 50 50 0 1 1 100 200 A 50 50 0 1 1 100 0 Z\",\"fill\":\"#fff\",\"fixedRatio\":false,\"rotate\":0,\"text\":{\"content\":\"<p style=\'text-align: center;\'><span style=\'font-size: 80px\'>01</span></p>\",\"defaultFontName\":\"Microsoft Yahei\",\"defaultColor\":\"#333\",\"align\":\"middle\"}},{\"type\":\"text\",\"id\":\"irBKaU\",\"left\":561.4814814814814,\"top\":100.1388888888889,\"width\":359.25925925925924,\"height\":80,\"content\":\"<p style=\'\'><strong><span style=\'font-size: 40px\'>在此处输入标题</span></strong></p>\",\"rotate\":0,\"defaultFontName\":\"Microsoft Yahei\",\"defaultColor\":\"#333\"},{\"type\":\"text\",\"id\":\"ziVDOP\",\"left\":572.5925925925925,\"top\":202.3611111111111,\"width\":257.77777777777777,\"height\":260,\"content\":\"<ol><li><p style=\'\'>在此处输入内容</p></li><li><p style=\'\'>在此处输入内容</p></li><li><p style=\'\'>在此处输入内容</p></li><li><p style=\'\'>在此处输入内容</p></li><li><p style=\'\'>在此处输入内容</p></li><li><p style=\'\'>在此处输入内容</p></li></ol>\",\"rotate\":0,\"defaultFontName\":\"Microsoft Yahei\",\"defaultColor\":\"#333\",\"lineHeight\":2,\"fill\":\"rgba(230, 230, 230, 0.5)\"}],\"background\":{\"type\":\"solid\",\"color\":\"#fff\"}},{\"id\":\"k9Dtbb1P\",\"elements\":[{\"type\":\"text\",\"id\":\"QqtWeI\",\"left\":69.35185185185179,\"top\":51.71759259259262,\"width\":420,\"height\":58.399993896484375,\"lineHeight\":1.2,\"content\":\"<p style=\'text-align: center;\'><strong><span style=\'color: #ffffff;\'><span style=\'font-size: 32px\'>1.请输入标题</span></span></strong></p>\",\"rotate\":0,\"defaultFontName\":\"Microsoft Yahei\",\"defaultColor\":\"#333\",\"fill\":\"#5b9bd5\"},{\"type\":\"text\",\"id\":\"uOVyAa\",\"left\":69.35185185185179,\"top\":131.78240740740745,\"width\":420,\"height\":129,\"content\":\"<p style=\'text-align: center;\'><span style=\'font-size: 22px\'>在此处输入内容</span></p><p style=\'text-align: center;\'><span style=\'font-size: 22px\'>在此处输入内容</span></p><p style=\'text-align: center;\'><span style=\'font-size: 22px\'>在此处输入内容</span></p>\",\"rotate\":0,\"defaultFontName\":\"Microsoft Yahei\",\"defaultColor\":\"#333\",\"fill\":\"rgba(230, 230, 230, 0.5)\"},{\"type\":\"text\",\"id\":\"TOa7q9\",\"left\":510.6481481481481,\"top\":51.71759259259262,\"width\":420,\"height\":58.399993896484375,\"lineHeight\":1.2,\"content\":\"<p style=\'text-align: center;\'><strong><span style=\'color: #ffffff;\'><span style=\'font-size: 32px\'>2.请输入标题</span></span></strong></p>\",\"rotate\":0,\"defaultFontName\":\"Microsoft Yahei\",\"defaultColor\":\"#333\",\"fill\":\"#5b9bd5\"},{\"type\":\"text\",\"id\":\"Mx8TCT\",\"left\":510.6481481481481,\"top\":131.78240740740745,\"width\":420,\"height\":129,\"content\":\"<p style=\'text-align: center;\'><span style=\'font-size: 22px\'>在此处输入内容</span></p><p style=\'text-align: center;\'><span style=\'font-size: 22px\'>在此处输入内容</span></p><p style=\'text-align: center;\'><span style=\'font-size: 22px\'>在此处输入内容</span></p>\",\"rotate\":0,\"defaultFontName\":\"Microsoft Yahei\",\"defaultColor\":\"#333\",\"fill\":\"rgba(230, 230, 230, 0.5)\"},{\"type\":\"text\",\"id\":\"KgeI14\",\"left\":69.35185185185185,\"top\":301.71759259259255,\"width\":420,\"height\":58.399993896484375,\"lineHeight\":1.2,\"content\":\"<p style=\'text-align: center;\'><strong><span style=\'color: #ffffff;\'><span style=\'font-size: 32px\'>3.请输入标题</span></span></strong></p>\",\"rotate\":0,\"defaultFontName\":\"Microsoft Yahei\",\"defaultColor\":\"#333\",\"fill\":\"#5b9bd5\"},{\"type\":\"text\",\"id\":\"vO_dQ3\",\"left\":69.35185185185185,\"top\":381.7824074074074,\"width\":420,\"height\":129,\"content\":\"<p style=\'text-align: center;\'><span style=\'font-size: 22px\'>在此处输入内容</span></p><p style=\'text-align: center;\'><span style=\'font-size: 22px\'>在此处输入内容</span></p><p style=\'text-align: center;\'><span style=\'font-size: 22px\'>在此处输入内容</span></p>\",\"rotate\":0,\"defaultFontName\":\"Microsoft Yahei\",\"defaultColor\":\"#333\",\"fill\":\"rgba(230, 230, 230, 0.5)\"},{\"type\":\"text\",\"id\":\"TFPlHT\",\"left\":510.64814814814815,\"top\":301.71759259259255,\"width\":420,\"height\":58.399993896484375,\"lineHeight\":1.2,\"content\":\"<p style=\'text-align: center;\'><strong><span style=\'color: #ffffff;\'><span style=\'font-size: 32px\'>4.请输入标题</span></span></strong></p>\",\"rotate\":0,\"defaultFontName\":\"Microsoft Yahei\",\"defaultColor\":\"#333\",\"fill\":\"#5b9bd5\"},{\"type\":\"text\",\"id\":\"2z8ubO\",\"left\":510.64814814814815,\"top\":381.7824074074074,\"width\":420,\"height\":129,\"content\":\"<p style=\'text-align: center;\'><span style=\'font-size: 22px\'>在此处输入内容</span></p><p style=\'text-align: center;\'><span style=\'font-size: 22px\'>在此处输入内容</span></p><p style=\'text-align: center;\'><span style=\'font-size: 22px\'>在此处输入内容</span></p>\",\"rotate\":0,\"defaultFontName\":\"Microsoft Yahei\",\"defaultColor\":\"#333\",\"fill\":\"rgba(230, 230, 230, 0.5)\"}],\"background\":{\"type\":\"solid\",\"color\":\"#fff\"}}]',
    1638164516,
    1638164516,
    1
  );
INSERT INTO
  `rt_ppt` (
    `id`,
    `title`,
    `content`,
    `add_time`,
    `update_time`,
    `user_id`
  )
VALUES
  (
    4,
    '演示文稿',
    '[{\"id\":\"ppt1638164842115\",\"elements\":[{\"type\":\"shape\",\"id\":\"4cbRxp\",\"left\":0,\"top\":200,\"width\":546,\"height\":362.5,\"viewBox\":200,\"path\":\"M 0 0 L 0 200 L 200 200 Z\",\"fill\":\"#5b9bd5\",\"fixedRatio\":false,\"opacity\":0.7,\"rotate\":0},{\"type\":\"shape\",\"id\":\"ookHrf\",\"left\":0,\"top\":0,\"width\":300,\"height\":320,\"viewBox\":200,\"path\":\"M 0 0 L 0 200 L 200 200 Z\",\"fill\":\"#5b9bd5\",\"fixedRatio\":false,\"flipV\":true,\"rotate\":0},{\"type\":\"text\",\"id\":\"idn7Mx\",\"left\":355,\"top\":65.25,\"width\":585,\"height\":125.60000610351562,\"lineHeight\":1.2,\"content\":\"<p><strong><span style=\'font-size:  88px\'>PPT</span></strong></p>\",\"rotate\":0,\"defaultFontName\":\"Microsoft Yahei\",\"defaultColor\":\"#333\"},{\"type\":\"text\",\"id\":\"7stmVP\",\"left\":355,\"top\":253.25,\"width\":585,\"height\":56,\"content\":\"<p><span style=\'font-size:  24px\'>在线演示文稿</span></p>\",\"rotate\":0,\"defaultFontName\":\"Microsoft Yahei\",\"defaultColor\":\"#333\"},{\"type\":\"line\",\"id\":\"FnpZs4\",\"left\":361,\"top\":238,\"start\":[0,0],\"end\":[549,0],\"points\":[\"\",\"\"],\"color\":\"#5b9bd5\",\"style\":\"solid\",\"width\":2}],\"background\":{\"type\":\"solid\",\"color\":\"#ffffff\"}}]',
    1638164847,
    1638164847,
    1
  );
INSERT INTO
  `rt_ppt` (
    `id`,
    `title`,
    `content`,
    `add_time`,
    `update_time`,
    `user_id`
  )
VALUES
  (
    5,
    '演示文稿1666',
    '[{\"id\":\"ppt1638164996737\",\"elements\":[{\"type\":\"shape\",\"id\":\"4cbRxp\",\"left\":0,\"top\":200,\"width\":546,\"height\":362.5,\"viewBox\":200,\"path\":\"M 0 0 L 0 200 L 200 200 Z\",\"fill\":\"#5b9bd5\",\"fixedRatio\":false,\"opacity\":0.7,\"rotate\":0},{\"type\":\"shape\",\"id\":\"ookHrf\",\"left\":0,\"top\":0,\"width\":300,\"height\":320,\"viewBox\":200,\"path\":\"M 0 0 L 0 200 L 200 200 Z\",\"fill\":\"#5b9bd5\",\"fixedRatio\":false,\"flipV\":true,\"rotate\":0},{\"type\":\"text\",\"id\":\"idn7Mx\",\"left\":355,\"top\":65.25,\"width\":585,\"height\":125.60000610351562,\"lineHeight\":1.2,\"content\":\"<p><strong><span style=\'font-size:  88px\'>PPT</span></strong></p>\",\"rotate\":0,\"defaultFontName\":\"Microsoft Yahei\",\"defaultColor\":\"#333\"},{\"type\":\"text\",\"id\":\"7stmVP\",\"left\":355,\"top\":253.25,\"width\":585,\"height\":56,\"content\":\"<p><span style=\'font-size:  24px\'>在线演示文稿</span></p>\",\"rotate\":0,\"defaultFontName\":\"Microsoft Yahei\",\"defaultColor\":\"#333\"},{\"type\":\"line\",\"id\":\"FnpZs4\",\"left\":361,\"top\":238,\"start\":[0,0],\"end\":[549,0],\"points\":[\"\",\"\"],\"color\":\"#5b9bd5\",\"style\":\"solid\",\"width\":2}],\"background\":{\"type\":\"solid\",\"color\":\"#ffffff\"}},{\"id\":\"4cN5uZHp\",\"elements\":[{\"type\":\"text\",\"id\":\"hTLl7P\",\"left\":69.35185185185185,\"top\":49.21759259259262,\"width\":420,\"height\":63.19999694824219,\"lineHeight\":1.2,\"content\":\"<p style=\'text-align: center;\'><strong><span style=\'color: #ffffff;\'><span style=\'font-size: 36px\'>1.请输入标题</span></span></strong></p>\",\"rotate\":0,\"defaultFontName\":\"Microsoft Yahei\",\"defaultColor\":\"#333\",\"fill\":\"#5b9bd5\"},{\"type\":\"text\",\"id\":\"v30RcB\",\"left\":69.35185185185185,\"top\":129.28240740740745,\"width\":420,\"height\":384,\"content\":\"<p style=\'text-align: center;\'><span style=\'font-size: 24px\'>在此处输入内容</span></p><p style=\'text-align: center;\'><span style=\'font-size: 24px\'>在此处输入内容</span></p><p style=\'text-align: center;\'><span style=\'font-size: 24px\'>在此处输入内容</span></p><p style=\'text-align: center;\'><span style=\'font-size: 24px\'>在此处输入内容</span></p><p style=\'text-align: center;\'><span style=\'font-size: 24px\'>在此处输入内容</span></p><p style=\'text-align: center;\'><span style=\'font-size: 24px\'>在此处输入内容</span></p><p style=\'text-align: center;\'><span style=\'font-size: 24px\'>在此处输入内容</span></p><p style=\'text-align: center;\'><span style=\'font-size: 24px\'>在此处输入内容</span></p><p style=\'text-align: center;\'><span style=\'font-size: 24px\'>在此处输入内容</span></p>\",\"rotate\":0,\"defaultFontName\":\"Microsoft Yahei\",\"defaultColor\":\"#333\",\"fill\":\"rgba(230, 230, 230, 0.5)\"},{\"type\":\"text\",\"id\":\"b5Jv4B\",\"left\":510.64814814814815,\"top\":49.21759259259262,\"width\":420,\"height\":63.19999694824219,\"lineHeight\":1.2,\"content\":\"<p style=\'text-align: center;\'><strong><span style=\'color: #ffffff;\'><span style=\'font-size: 36px\'>2.请输入标题</span></span></strong></p>\",\"rotate\":0,\"defaultFontName\":\"Microsoft Yahei\",\"defaultColor\":\"#333\",\"fill\":\"#5b9bd5\"},{\"type\":\"text\",\"id\":\"xbe4To\",\"left\":510.64814814814815,\"top\":129.28240740740745,\"width\":420,\"height\":384,\"content\":\"<p style=\'text-align: center;\'><span style=\'font-size: 24px\'>在此处输入内容</span></p><p style=\'text-align: center;\'><span style=\'font-size: 24px\'>在此处输入内容</span></p><p style=\'text-align: center;\'><span style=\'font-size: 24px\'>在此处输入内容</span></p><p style=\'text-align: center;\'><span style=\'font-size: 24px\'>在此处输入内容</span></p><p style=\'text-align: center;\'><span style=\'font-size: 24px\'>在此处输入内容</span></p><p style=\'text-align: center;\'><span style=\'font-size: 24px\'>在此处输入内容</span></p><p style=\'text-align: center;\'><span style=\'font-size: 24px\'>在此处输入内容</span></p><p style=\'text-align: center;\'><span style=\'font-size: 24px\'>在此处输入内容</span></p><p style=\'text-align: center;\'><span style=\'font-size: 24px\'>在此处输入内容</span></p>\",\"rotate\":0,\"defaultFontName\":\"Microsoft Yahei\",\"defaultColor\":\"#333\",\"fill\":\"rgba(230, 230, 230, 0.5)\"}],\"background\":{\"type\":\"solid\",\"color\":\"#fff\"}}]',
    1638165006,
    1638165060,
    1
  );

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: rt_set
# ------------------------------------------------------------

INSERT INTO
  `rt_set` (
    `id`,
    `key`,
    `name`,
    `val`,
    `enable`,
    `remark`,
    `form_id`,
    `form_path`,
    `params`
  )
VALUES
  (
    9,
    'mysql',
    'mysql',
    '{\"host\":\"11111\",\"port\":\"3306\",\"input_2\":\"111\",\"textarea_1\":\"  5555\",\"conftype\":\"mysql\"}',
    1,
    NULL,
    9,
    '/admin/view/set/config/mysql.html',
    NULL
  );
INSERT INTO
  `rt_set` (
    `id`,
    `key`,
    `name`,
    `val`,
    `enable`,
    `remark`,
    `form_id`,
    `form_path`,
    `params`
  )
VALUES
  (
    10,
    'redis',
    'redis',
    NULL,
    1,
    NULL,
    11,
    '/admin/view/set/config/redis.html',
    NULL
  );

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: rt_svg
# ------------------------------------------------------------

INSERT INTO
  `rt_svg` (
    `id`,
    `add_time`,
    `update_time`,
    `user_id`,
    `url`,
    `title`
  )
VALUES
  (11, 1639811074, 0, 1, '1639811074222.svg', '555');

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: rt_txt
# ------------------------------------------------------------

INSERT INTO
  `rt_txt` (
    `id`,
    `add_time`,
    `update_time`,
    `user_id`,
    `title`,
    `content`
  )
VALUES
  (
    1,
    0,
    0,
    0,
    'Untitle221d.txt',
    'fdasfda\nfdsafdasfdsa\n\nfdsfsadf\nfdsafda\nfdsafdsa\n\ns\n\nfdsfa\n\nfdsaf\n\n\nfdsafdsafa'
  );
INSERT INTO
  `rt_txt` (
    `id`,
    `add_time`,
    `update_time`,
    `user_id`,
    `title`,
    `content`
  )
VALUES
  (
    2,
    0,
    0,
    0,
    'tffgfdsa.js',
    'ttttfdsafasfads\n\nfdsafsad'
  );
INSERT INTO
  `rt_txt` (
    `id`,
    `add_time`,
    `update_time`,
    `user_id`,
    `title`,
    `content`
  )
VALUES
  (
    3,
    0,
    0,
    0,
    'my.php',
    '<?php\necho phpinfo();\nvar_dump(\'555\');'
  );
INSERT INTO
  `rt_txt` (
    `id`,
    `add_time`,
    `update_time`,
    `user_id`,
    `title`,
    `content`
  )
VALUES
  (
    4,
    0,
    0,
    0,
    'dddbbb.js',
    'fdsafdsafdsa\n\nfdsafdsa\nfdsafdas\n\nfdsafdas\n\n\nfdsafdas\nfdsafa\n\n\nfdasfasdafs111'
  );
INSERT INTO
  `rt_txt` (
    `id`,
    `add_time`,
    `update_time`,
    `user_id`,
    `title`,
    `content`
  )
VALUES
  (
    8,
    0,
    0,
    0,
    'Untitled.txt',
    'fdsafas\nfdsafdsa\n\n\n\nfdsafdsafdsa\nfdsafdsa\n\n\nfdsaf\nfdsafsa\n\n\n\n'
  );
INSERT INTO
  `rt_txt` (
    `id`,
    `add_time`,
    `update_time`,
    `user_id`,
    `title`,
    `content`
  )
VALUES
  (9, 0, 0, 0, 'Untitled.txt', 'dddd\n\ndddd');

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: rt_word
# ------------------------------------------------------------

INSERT INTO
  `rt_word` (
    `id`,
    `add_time`,
    `update_time`,
    `user_id`,
    `title`,
    `content`
  )
VALUES
  (
    1,
    1640563309,
    1640563309,
    1,
    'test',
    '<p>testttt</p>'
  );
INSERT INTO
  `rt_word` (
    `id`,
    `add_time`,
    `update_time`,
    `user_id`,
    `title`,
    `content`
  )
VALUES
  (
    2,
    1640563375,
    1640563375,
    1,
    'test',
    '<p>testttt</p>'
  );
INSERT INTO
  `rt_word` (
    `id`,
    `add_time`,
    `update_time`,
    `user_id`,
    `title`,
    `content`
  )
VALUES
  (
    3,
    1640563405,
    1640563726,
    1,
    'test',
    '<p>testttt2222</p>'
  );
INSERT INTO
  `rt_word` (
    `id`,
    `add_time`,
    `update_time`,
    `user_id`,
    `title`,
    `content`
  )
VALUES
  (
    4,
    1640563481,
    1640563481,
    1,
    'tttt',
    '<p>11111111</p>'
  );
INSERT INTO
  `rt_word` (
    `id`,
    `add_time`,
    `update_time`,
    `user_id`,
    `title`,
    `content`
  )
VALUES
  (5, 1640563746, 1640563746, 1, '1111', '<p>dasdaa</p>');
INSERT INTO
  `rt_word` (
    `id`,
    `add_time`,
    `update_time`,
    `user_id`,
    `title`,
    `content`
  )
VALUES
  (
    6,
    1640564090,
    1640564090,
    1,
    'fadfad',
    '<p>可 PaddlePaddle/PaddleOCR Awesome multilingual OCR toolkits based on PaddlePaddle (practical ultra light Support 80  language.'
  );

/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
