### 表清单


| 序号 | 数据表            | 名称             |
| ------ | ------------------- | ------------------ |
| 1    | rt_admin          | 管理员表         |
| 2    | rt_admin_auth     | 管理权限表       |
| 3    | rt_admin_loginlog | 管理登录日志表   |
| 4    | rt_admin_map      | 管理员权限映射表 |
| 5    | rt_admin_oplog    | 管理操作日志     |
| 6    | rt_admin_viewlog  | 管理员查看日志   |
| 7    | rt_api            | 接口管理表       |
| 8    | rt_api_input      | 接口输入表       |
| 9    | rt_api_logic      | 接口逻辑表       |
| 10   | rt_api_out        | 接口输出表       |
| 11   | rt_api_params     | 接口参数表       |
| 12   | rt_area           | 区域表           |
| 13   | rt_article        | 文章             |
| 14   | rt_cate           | 系统分类表       |
| 15   | rt_category       | 文章分类         |
| 16   | rt_crons          | 系统计划任务表   |
| 17   | rt_database       | 数据库连接表     |
| 18   | rt_datasafe       | 数据库保护表     |
| 19   | rt_error          | 系统错误日志表   |
| 20   | rt_form           | 系统表单         |
| 21   | rt_menu           | 系统菜单         |
| 22   | rt_mod            | 系统模块表       |
| 23   | rt_params         | 全局常量表       |
| 24   | rt_set            | 系统配置表       |

---

#### rt_admin-管理员表


| 排序 | 字段名      | 名称           | 类型         | 是否为空 | 索引 | 默认值 |
| ------ | ------------- | ---------------- | -------------- | ---------- | ------ | -------- |
| 2    | username    | 用户名         | varchar(50)  | NO       | UNI  | null   |
| 3    | password    | 密码           | varchar(32)  | NO       |      | null   |
| 1    | admin_id    | 唯一标志       | int(10)      | NO       | PRI  | 0      |
| 4    | salt        | 密码钥匙       | varchar(32)  | NO       |      | null   |
| 6    | add_time    | 添加时间       | int(10)      | NO       |      | 0      |
| 7    | name        | 真实姓名       | varchar(100) | YES      |      | null   |
| 8    | mobile      | 手机号         | int(10)      | YES      | UNI  | null   |
| 9    | status      | 状态1正常0禁用 | tinyint(2)   | NO       |      | 1      |
| 10   | login_time  | 登录时间       | int(10)      | YES      |      | 0      |
| 11   | login_num   | 登录次数       | int(10)      | YES      |      | 0      |
| 12   | update_time | 更新时间       | int(10)      | YES      |      | 0      |
| 5    | role_id     | 角色id         | int(10)      | NO       |      | 0      |

创建代码

```js
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
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='管理员表'
```

---

#### rt_admin_auth-管理权限表


| 排序 | 字段名 | 名称                 | 类型                | 是否为空 | 索引 | 默认值 |
| ------ | -------- | ---------------------- | --------------------- | ---------- | ------ | -------- |
| 1    | id     |                      | int(10) unsigned    | NO       | PRI  | null   |
| 2    | name   |                      | varchar(255)        | YES      |      | null   |
| 3    | rules  |                      | text                | YES      |      | null   |
| 4    | status | 是否可用0可用1不可用 | tinyint(2) unsigned | YES      |      | 0      |
| 5    | remark | 描述                 | varchar(255)        | YES      |      | null   |

创建代码

```js
DROP TABLE IF EXISTS `rt_admin_auth`;
 CREATE TABLE `rt_admin_auth` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `rules` text CHARACTER SET utf8,
  `status` tinyint(2) unsigned DEFAULT '0' COMMENT '是否可用0可用1不可用',
  `remark` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '描述',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='管理权限表'
```

---

#### rt_admin_loginlog-管理登录日志表


| 排序 | 字段名   | 名称       | 类型             | 是否为空 | 索引 | 默认值 |
| ------ | ---------- | ------------ | ------------------ | ---------- | ------ | -------- |
| 1    | id       | ID         | int(10) unsigned | NO       | PRI  | null   |
| 2    | admin_id | 管理员账号 | int(10) unsigned | NO       |      | null   |
| 3    | log      | 日志名称   | varchar(255)     | NO       |      | null   |
| 4    | data     | 返回记录   | text             | YES      |      | null   |
| 5    | ip       | IP地址     | varchar(64)      | YES      |      | null   |
| 6    | agent    | 客户端信息 | varchar(255)     | YES      |      | null   |
| 7    | url      | 地址       | varchar(255)     | YES      |      | null   |
| 8    | method   | 方法       | varchar(100)     | YES      |      | null   |
| 9    | addtime  | 添加时间   | int(10) unsigned | YES      |      | 0      |

创建代码

```js
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
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='管理登录日志表'
```

---

#### rt_admin_map-管理员权限映射表


| 排序 | 字段名   | 名称                           | 类型                | 是否为空 | 索引 | 默认值 |
| ------ | ---------- | -------------------------------- | --------------------- | ---------- | ------ | -------- |
| 1    | map_id   |                                | int(10) unsigned    | NO       | PRI  | null   |
| 2    | admin_id |                                | int(10) unsigned    | NO       | MUL  | null   |
| 3    | auth_id  |                                | int(10) unsigned    | NO       |      | null   |
| 4    | type     | 0角色1集团2公司3门店4部门5区域 | tinyint(3) unsigned | NO       |      | 0      |

创建代码

```js
DROP TABLE IF EXISTS `rt_admin_map`;
 CREATE TABLE `rt_admin_map` (
  `map_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `admin_id` int(10) unsigned NOT NULL,
  `auth_id` int(10) unsigned NOT NULL,
  `type` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '0角色1集团2公司3门店4部门5区域',
  PRIMARY KEY (`map_id`),
  UNIQUE KEY `admin_id` (`admin_id`,`auth_id`,`type`) USING HASH
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='管理员权限映射表'
```

---

#### rt_admin_oplog-管理操作日志


| 排序 | 字段名   | 名称       | 类型             | 是否为空 | 索引 | 默认值 |
| ------ | ---------- | ------------ | ------------------ | ---------- | ------ | -------- |
| 1    | id       | ID         | int(10) unsigned | NO       | PRI  | null   |
| 2    | admin_id | 管理员账号 | int(10) unsigned | NO       |      | null   |
| 3    | log      | 日志名称   | varchar(255)     | NO       |      | null   |
| 4    | data     | 返回记录   | text             | YES      |      | null   |
| 5    | ip       | IP地址     | varchar(64)      | YES      |      | null   |
| 6    | agent    | 客户端信息 | varchar(255)     | YES      |      | null   |
| 7    | url      | 地址       | varchar(255)     | YES      |      | null   |
| 8    | method   | 方法       | varchar(100)     | YES      |      | null   |
| 9    | addtime  | 添加时间   | int(10) unsigned | YES      |      | 0      |

创建代码

```js
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
) ENGINE=InnoDB AUTO_INCREMENT=290 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='管理操作日志'
```

---

#### rt_admin_viewlog-管理员查看日志


| 排序 | 字段名    | 名称       | 类型             | 是否为空 | 索引 | 默认值 |
| ------ | ----------- | ------------ | ------------------ | ---------- | ------ | -------- |
| 1    | id        | ID         | int(10) unsigned | NO       | PRI  | null   |
| 2    | admin_id  | 管理员账号 | int(10) unsigned | NO       |      | null   |
| 3    | log       | 日志名称   | varchar(255)     | NO       |      | null   |
| 4    | ip        | IP地址     | varchar(64)      | YES      |      | null   |
| 5    | agent     | 客户端信息 | varchar(255)     | YES      |      | null   |
| 6    | url       | 地址       | varchar(255)     | YES      |      | null   |
| 7    | method    | 方法       | varchar(100)     | YES      |      | null   |
| 8    | addtime   | 添加时间   | int(10) unsigned | YES      |      | 0      |
| 9    | leavetime | 离开时间   | int(10) unsigned | YES      |      | 0      |

创建代码

```js
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
) ENGINE=InnoDB AUTO_INCREMENT=350 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='管理员查看日志'
```

---

#### rt_api-接口管理表


| 排序 | 字段名 | 名称         | 类型             | 是否为空 | 索引 | 默认值 |
| ------ | -------- | -------------- | ------------------ | ---------- | ------ | -------- |
| 1    | id     | 唯一标志     | int(10) unsigned | NO       | PRI  | null   |
| 2    | name   | 接口名称     | varchar(100)     | NO       |      | null   |
| 3    | mod_id | 模块id       | int(10) unsigned | NO       |      | 0      |
| 4    | mod    | 所属模块     | varchar(60)      | NO       |      | null   |
| 5    | key    | 接口唯一标志 | varchar(100)     | NO       |      | null   |
| 6    | method | 接口方法     | varchar(20)      | NO       |      | null   |

创建代码

```js
DROP TABLE IF EXISTS `rt_api`;
 CREATE TABLE `rt_api` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '唯一标志',
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '接口名称',
  `mod_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '模块id',
  `mod` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '所属模块',
  `key` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '接口唯一标志',
  `method` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '接口方法',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='接口管理表'
```

---

#### rt_api_input-接口输入表


| 排序 | 字段名 | 名称     | 类型             | 是否为空 | 索引 | 默认值 |
| ------ | -------- | ---------- | ------------------ | ---------- | ------ | -------- |
| 1    | id     | 唯一标志 | int(10) unsigned | NO       | PRI  | null   |

创建代码

```js
DROP TABLE IF EXISTS `rt_api_input`;
 CREATE TABLE `rt_api_input` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '唯一标志',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='接口输入表'
```

---

#### rt_api_logic-接口逻辑表


| 排序 | 字段名 | 名称     | 类型             | 是否为空 | 索引 | 默认值 |
| ------ | -------- | ---------- | ------------------ | ---------- | ------ | -------- |
| 1    | id     | 唯一标志 | int(10) unsigned | NO       | PRI  | null   |

创建代码

```js
DROP TABLE IF EXISTS `rt_api_logic`;
 CREATE TABLE `rt_api_logic` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '唯一标志',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='接口逻辑表'
```

---

#### rt_api_out-接口输出表


| 排序 | 字段名 | 名称     | 类型             | 是否为空 | 索引 | 默认值 |
| ------ | -------- | ---------- | ------------------ | ---------- | ------ | -------- |
| 1    | id     | 唯一标志 | int(10) unsigned | NO       | PRI  | null   |

创建代码

```js
DROP TABLE IF EXISTS `rt_api_out`;
 CREATE TABLE `rt_api_out` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '唯一标志',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='接口输出表'
```

---

#### rt_api_params-接口参数表


| 排序 | 字段名 | 名称     | 类型             | 是否为空 | 索引 | 默认值 |
| ------ | -------- | ---------- | ------------------ | ---------- | ------ | -------- |
| 1    | id     | 唯一标志 | int(10) unsigned | NO       | PRI  | null   |

创建代码

```js
DROP TABLE IF EXISTS `rt_api_params`;
 CREATE TABLE `rt_api_params` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '唯一标志',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='接口参数表'
```

---

#### rt_area-区域表


| 排序 | 字段名   | 名称       | 类型             | 是否为空 | 索引 | 默认值 |
| ------ | ---------- | ------------ | ------------------ | ---------- | ------ | -------- |
| 1    | area_id  |            | int(10) unsigned | NO       | PRI  | null   |
| 2    | name     | 区域名称   | varchar(255)     | YES      |      | null   |
| 3    | group_id | 集团id     | int(10) unsigned | YES      |      | 0      |
| 4    | address  | 地址       | varchar(255)     | YES      |      | null   |
| 5    | city_id  | 上级城市id | int(10)          | YES      |      | null   |

创建代码

```js
DROP TABLE IF EXISTS `rt_area`;
 CREATE TABLE `rt_area` (
  `area_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '区域名称',
  `group_id` int(10) unsigned DEFAULT '0' COMMENT '集团id',
  `address` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '地址',
  `city_id` int(10) DEFAULT NULL COMMENT '上级城市id',
  PRIMARY KEY (`area_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='区域表'
```

---

#### rt_article-文章


| 排序 | 字段名       | 名称               | 类型             | 是否为空 | 索引 | 默认值            |
| ------ | -------------- | -------------------- | ------------------ | ---------- | ------ | ------------------- |
| 1    | id           | ID                 | int(11) unsigned | NO       | PRI  | null              |
| 2    | category_id  | 分类:id:title      | int(11)          | NO       |      | null              |
| 3    | title        | 文章名             | varchar(128)     | NO       |      | null              |
| 4    | desc_content |                    | varchar(255)     | NO       |      | null              |
| 5    | image        |                    | varchar(255)     | YES      |      | null              |
| 6    | content      | 内容               | text             | NO       |      | null              |
| 7    | author       | 作者:id:name       | varchar(32)      | NO       |      | null              |
| 8    | show_switch  | 展示:1=展示,0=隐藏 | tinyint(1)       | NO       |      | 1                 |
| 9    | show_time    |                    | datetime         | YES      |      | null              |
| 10   | up_time      |                    | datetime         | YES      |      | CURRENT_TIMESTAMP |
| 11   | add_time     |                    | datetime         | YES      |      | CURRENT_TIMESTAMP |

创建代码

```js
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='文章'
```

---

#### rt_cate-系统分类表


| 排序 | 字段名 | 名称         | 类型             | 是否为空 | 索引 | 默认值 |
| ------ | -------- | -------------- | ------------------ | ---------- | ------ | -------- |
| 1    | id     |              | int(10) unsigned | NO       | PRI  | null   |
| 2    | pid    | 上级id       | int(10)          | YES      |      | 0      |
| 3    | sid    | 系统类型id   | int(10)          | YES      |      | 0      |
| 4    | fid    | 系统分类标志 | int(10)          | YES      |      | null   |
| 5    | lid    | 层级         | int(10)          | YES      |      | 0      |
| 6    | name   | 名称         | varchar(255)     | YES      |      | null   |
| 7    | desc   | 描述         | text             | YES      |      | null   |

创建代码

```js
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='系统分类表'
```

---

#### rt_category-文章分类


| 排序 | 字段名 | 名称                                 | 类型             | 是否为空 | 索引 | 默认值 |
| ------ | -------- | -------------------------------------- | ------------------ | ---------- | ------ | -------- |
| 1    | id     | ID                                   | int(11) unsigned | NO       | PRI  | null   |
| 2    | name   | 分类名称                             | varchar(255)     | NO       |      | null   |
| 3    | status | 是否使用，预留                       | tinyint(2)       | YES      |      | 0      |
| 4    | ctype  | 分类类型 1新闻2账户类型3账户日志来源 | tinyint(3)       | YES      |      | 1      |
| 5    | desc   | 其他附加配置                         | text             | YES      |      | null   |
| 6    | flag   | 分类标志，同一分类不能重复           | int(10)          | NO       |      | 0      |

创建代码

```js
DROP TABLE IF EXISTS `rt_category`;
 CREATE TABLE `rt_category` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `name` varchar(255) CHARACTER SET utf8 NOT NULL COMMENT '分类名称',
  `status` tinyint(2) DEFAULT '0' COMMENT '是否使用，预留',
  `ctype` tinyint(3) DEFAULT '1' COMMENT '分类类型 1新闻2账户类型3账户日志来源',
  `desc` text CHARACTER SET utf8 COMMENT '其他附加配置',
  `flag` int(10) NOT NULL DEFAULT '0' COMMENT '分类标志，同一分类不能重复',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='文章分类'
```

---

#### rt_crons-系统计划任务表


| 排序 | 字段名    | 名称                                  | 类型             | 是否为空 | 索引 | 默认值 |
| ------ | ----------- | --------------------------------------- | ------------------ | ---------- | ------ | -------- |
| 1    | id        |                                       | int(10) unsigned | NO       | PRI  | null   |
| 2    | name      | 任务名称                              | varchar(64)      | NO       |      | null   |
| 3    | interval  | 执行间隔 毫秒为单位                   | varchar(128)     | YES      |      | null   |
| 4    | immediate | 是否立即执行                          | tinyint(1)       | YES      |      | 1      |
| 5    | handle    | 执行路径                              | varchar(128)     | YES      | UNI  | null   |
| 6    | enable    | 是否开启                              | tinyint(1)       | YES      |      | 1      |
| 7    | type      | one执行一次all一直执行                | varchar(128)     | YES      |      | null   |
| 8    | addtime   | 添加时间                              | int(10)          | YES      |      | 0      |
| 9    | uptime    | 更新时间                              | bigint(20)       | YES      |      | 0      |
| 10   | nexttime  | 下次执行时间                          | bigint(20)       | YES      |      | 0      |
| 11   | runtime   | 每次执行的时间                        | bigint(20)       | YES      |      | 0      |
| 12   | runtype   | 执行类型0为间隔执行1为系统执行crontab | tinyint(1)       | YES      |      | 0      |
| 13   | cron      | Runtype为1时不能为空 如0 */1 * * *    | varchar(255)     | YES      |      | null   |

创建代码

```js
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='系统计划任务表'
```

---

#### rt_database-数据库连接表


| 排序 | 字段名      | 名称 | 类型                | 是否为空 | 索引 | 默认值 |
| ------ | ------------- | ------ | --------------------- | ---------- | ------ | -------- |
| 1    | id          |      | int(10) unsigned    | NO       | PRI  | null   |
| 2    | database    |      | varchar(255)        | NO       |      | null   |
| 3    | host        |      | varchar(255)        | YES      |      | null   |
| 4    | port        |      | int(10) unsigned    | NO       |      | 3306   |
| 5    | user        |      | varchar(255)        | NO       |      | null   |
| 6    | password    |      | varchar(255)        | NO       |      | null   |
| 7    | dateStrings |      | tinyint(2) unsigned | YES      |      | null   |
| 8    | encoding    |      | varchar(255)        | YES      |      | null   |
| 9    | isdef       |      | tinyint(2) unsigned | YES      |      | 0      |
| 10   | prefix      |      | varchar(100)        | YES      |      | null   |
| 11   | ssh         |      | tinyint(2) unsigned | YES      |      | null   |
| 12   | shost       |      | varchar(255)        | YES      |      | null   |
| 13   | sport       |      | int(10) unsigned    | YES      |      | 22     |
| 14   | suser       |      | varchar(255)        | YES      |      | null   |
| 15   | stype       |      | tinyint(2) unsigned | YES      |      | 1      |
| 16   | spass       |      | varchar(255)        | YES      |      | null   |
| 17   | spath       |      | varchar(255)        | YES      |      | null   |

创建代码

```js
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
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='数据库连接表'
```

---

#### rt_datasafe-数据库保护表


| 排序 | 字段名  | 名称 | 类型         | 是否为空 | 索引 | 默认值 |
| ------ | --------- | ------ | -------------- | ---------- | ------ | -------- |
| 1    | id      |      | int(10)      | NO       | PRI  | null   |
| 2    | data_id |      | int(10)      | YES      | MUL  | null   |
| 3    | name    |      | varchar(255) | YES      |      | null   |

创建代码

```js
DROP TABLE IF EXISTS `rt_datasafe`;
 CREATE TABLE `rt_datasafe` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `data_id` int(10) DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `data_id` (`data_id`,`name`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='数据库保护表'
```

---

#### rt_error-系统错误日志表


| 排序 | 字段名   | 名称 | 类型             | 是否为空 | 索引 | 默认值 |
| ------ | ---------- | ------ | ------------------ | ---------- | ------ | -------- |
| 1    | id       |      | int(10) unsigned | NO       | PRI  | null   |
| 2    | name     |      | varchar(255)     | YES      |      | null   |
| 3    | url      |      | varchar(255)     | YES      |      | null   |
| 4    | msg      |      | text             | YES      |      | null   |
| 5    | addtime  |      | int(10) unsigned | YES      |      | 0      |
| 6    | admin_id |      | int(10) unsigned | YES      |      | 0      |
| 5    | add_time |      | int(10) unsigned | YES      |      | 0      |

创建代码

```js
DROP TABLE IF EXISTS `rt_error`;
 CREATE TABLE `rt_error` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `msg` text COLLATE utf8mb4_unicode_ci,
  `addtime` int(10) unsigned DEFAULT '0',
  `admin_id` int(10) unsigned DEFAULT '0',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='系统错误日志表'
```

---

#### rt_form-系统表单


| 排序 | 字段名      | 名称     | 类型             | 是否为空 | 索引 | 默认值 |
| ------ | ------------- | ---------- | ------------------ | ---------- | ------ | -------- |
| 1    | id          |          | int(10) unsigned | NO       | PRI  | null   |
| 2    | name        |          | varchar(255)     | YES      |      | null   |
| 3    | key         |          | varchar(255)     | YES      |      | null   |
| 4    | data        |          | text             | YES      |      | null   |
| 5    | get_url     |          | varchar(255)     | YES      |      | null   |
| 6    | post_url    |          | varchar(255)     | YES      |      | null   |
| 7    | form_path   |          | varchar(255)     | YES      |      | null   |
| 8    | add_time    | 添加时间 | int(10) unsigned | YES      |      | 0      |
| 9    | link_id     | 回写id   | int(10) unsigned | YES      |      | 0      |
| 10   | link_name   | 回写表名 | varchar(255)     | YES      |      | 0      |
| 11   | link_field  | 回写字段 | varchar(255)     | YES      |      | null   |
| 12   | params_get  |          | varchar(255)     | YES      |      | null   |
| 13   | params_post |          | varchar(255)     | YES      |      | null   |

创建代码

```js
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
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='系统表单'
```

---

#### rt_menu-系统菜单


| 排序 | 字段名    | 名称                 | 类型                | 是否为空 | 索引 | 默认值 |
| ------ | ----------- | ---------------------- | --------------------- | ---------- | ------ | -------- |
| 1    | id        |                      | int(10) unsigned    | NO       | PRI  | null   |
| 2    | title     |                      | varchar(255)        | YES      |      | null   |
| 3    | route     | 权限标志             | varchar(255)        | YES      | MUL  | null   |
| 4    | href      | 前端地址             | varchar(255)        | YES      |      | null   |
| 5    | type      | 0目录1菜单2按钮3权限 | tinyint(2)          | YES      |      | 0      |
| 6    | order_num | 排序                 | int(10)             | YES      |      | 0      |
| 6    | icon      |                      | varchar(255)        | YES      |      | null   |
| 8    | open_type |                      | varchar(255)        | YES      |      | null   |
| 8    | pid       |                      | int(10)             | YES      |      | 0      |
| 9    | lid       |                      | tinyint(3)          | YES      |      | 1      |
| 11   | ifshow    | 是否显示0显示1不显示 | tinyint(3) unsigned | YES      |      | 0      |
| 2    | name      |                      | varchar(255)        | YES      |      | null   |
| 3    | url       | 权限标志             | varchar(255)        | YES      |      | null   |
| 4    | ismenu    | 0目录1菜单2按钮      | tinyint(2)          | YES      |      | 0      |
| 5    | order     |                      | int(5)              | YES      |      | 0      |
| 7    | target    |                      | varchar(255)        | YES      |      | null   |

创建代码

```js
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
) ENGINE=InnoDB AUTO_INCREMENT=143 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='系统菜单'
```

---

#### rt_mod-系统模块表


| 排序 | 字段名      | 名称                          | 类型             | 是否为空 | 索引 | 默认值 |
| ------ | ------------- | ------------------------------- | ------------------ | ---------- | ------ | -------- |
| 1    | id          | 唯一标志                      | int(10) unsigned | NO       | PRI  | null   |
| 2    | name        | 模块名称                      | varchar(100)     | YES      |      | null   |
| 3    | key         | 系统标志                      | varchar(60)      | NO       | UNI  | null   |
| 4    | server_path | 模块路径                      | varchar(100)     | YES      |      | server |
| 5    | tables_main | 主表                          | varchar(100)     | NO       |      | null   |
| 6    | tables_more | 附加表                        | varchar(255)     | YES      |      | null   |
| 7    | type        | 模块类型1控制层2数据层3服务层 | tinyint(2)       | NO       |      | 1      |
| 8    | params      | 全局参数                      | varchar(255)     | NO       |      | null   |
| 9    | remark      | 模块说明                      | varchar(255)     | NO       |      | null   |

创建代码

```js
DROP TABLE IF EXISTS `rt_mod`;
 CREATE TABLE `rt_mod` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '唯一标志',
  `name` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '模块名称',
  `key` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '系统标志',
  `server_path` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT 'server' COMMENT '模块路径',
  `tables_main` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '主表',
  `tables_more` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '附加表',
  `type` tinyint(2) NOT NULL DEFAULT '1' COMMENT '模块类型1控制层2数据层3服务层',
  `params` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '全局参数',
  `remark` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '模块说明',
  PRIMARY KEY (`id`),
  UNIQUE KEY `key` (`key`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='系统模块表'
```

---

#### rt_params-全局常量表


| 排序 | 字段名  | 名称                      | 类型             | 是否为空 | 索引 | 默认值 |
| ------ | --------- | --------------------------- | ------------------ | ---------- | ------ | -------- |
| 1    | id      | 唯一标志                  | int(10) unsigned | NO       | PRI  | null   |
| 2    | name    | 参数名称                  | varchar(100)     | NO       |      | null   |
| 3    | key     | 参数值                    | varchar(255)     | NO       |      | null   |
| 4    | content | 参数内容                  | varchar(255)     | NO       |      | null   |
| 5    | type    | 参数类型1文件2数字3字符串 | tinyint(2)       | NO       |      | 1      |

创建代码

```js
DROP TABLE IF EXISTS `rt_params`;
 CREATE TABLE `rt_params` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '唯一标志',
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '参数名称',
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '参数值',
  `content` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '参数内容',
  `type` tinyint(2) NOT NULL DEFAULT '1' COMMENT '参数类型1文件2数字3字符串',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='全局常量表'
```

---

#### rt_set-系统配置表


| 排序 | 字段名    | 名称   | 类型             | 是否为空 | 索引 | 默认值 |
| ------ | ----------- | -------- | ------------------ | ---------- | ------ | -------- |
| 1    | id        |        | int(10) unsigned | NO       | PRI  | null   |
| 2    | key       | 键值   | varchar(128)     | NO       | UNI  | null   |
| 3    | name      | 名称   | varchar(128)     | YES      |      | null   |
| 4    | val       | 值     | text             | YES      |      | null   |
| 5    | enable    | 状态   | tinyint(2)       | YES      |      | 1      |
| 6    | remark    |        | varchar(255)     | YES      |      | null   |
| 7    | form_id   | 表单id | int(10) unsigned | NO       |      | 0      |
| 8    | form_path |        | varchar(255)     | YES      |      | null   |
| 9    | params    |        | varchar(255)     | YES      |      | null   |

创建代码

```js
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
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='系统配置表'
```

---
