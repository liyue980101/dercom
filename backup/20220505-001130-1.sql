-- -----------------------------
-- Think MySQL Data Transfer 
-- 
-- Host     : 172.24.192.1
-- Port     : 3305
-- Database : dercom
-- 
-- Part : #1
-- Date : 2022-05-05 00:11:30
-- -----------------------------

SET FOREIGN_KEY_CHECKS = 0;


-- -----------------------------
-- Table structure for `d_admin`
-- -----------------------------
DROP TABLE IF EXISTS `d_admin`;
CREATE TABLE `d_admin` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(25) NOT NULL COMMENT '用户名',
  `nickname` varchar(25) DEFAULT NULL COMMENT '昵称',
  `avatar` varchar(120) DEFAULT NULL COMMENT '头像',
  `sex` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '0男1女2未知',
  `password` varchar(255) NOT NULL COMMENT '密码',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '状态0 拉黑 1正常',
  `login_time` int(11) unsigned DEFAULT '0' COMMENT '登录时间',
  `login_ip` varchar(25) DEFAULT NULL COMMENT '登录IP',
  `token` varchar(150) DEFAULT NULL COMMENT '登录token，需要做单一登录的时候才有',
  `create_time` int(11) unsigned NOT NULL,
  `update_time` int(11) DEFAULT '0',
  `phone` varchar(20) DEFAULT NULL COMMENT '手机号',
  `email` varchar(30) DEFAULT NULL COMMENT '邮箱号',
  `birthday` varchar(80) DEFAULT NULL COMMENT '出生日期',
  `logins` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '登录次数',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC COMMENT='后台管理员表';

-- -----------------------------
-- Records of `d_admin`
-- -----------------------------
INSERT INTO `d_admin` VALUES ('1', 'admin', '超级管理员', '/uploads/adminuser/avatar/20200702/5e19638241c47d668ad937cd5fde4847.jpg', '1', '$2y$10$XxyKGjfAtyo5I9.9HBY21O1frCziHTOzuWhhdiDypvUldM24xXVzW', '1', '1651680672', '172.21.0.1', '', '1593179425', '1651680672', '123', 'abc@qq.com', '1995-06-05', '61');
INSERT INTO `d_admin` VALUES ('2', 'deradmin', 'admin', '', '0', '$2y$10$cBQNpBTp0pVB2sEPLYboPuzUMpXzC4P3AsRaA5xp2Bq93cmg7qPWa', '1', '1651568465', '172.21.0.1', '', '1651568103', '1651568465', '', '', '', '1');
INSERT INTO `d_admin` VALUES ('6', 'simon', '西门吹雪', '', '2', '$2y$10$9rz5hUzlIaA9Qte4eARnqeacRB2zObgw5dzy02sKwzbGJphymVeDy', '1', '1651638813', '172.21.0.1', '', '1651638426', '1651638813', '', '', '', '1');

-- -----------------------------
-- Table structure for `d_attachment`
-- -----------------------------
DROP TABLE IF EXISTS `d_attachment`;
CREATE TABLE `d_attachment` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL DEFAULT '' COMMENT '附件名称',
  `att_dir` varchar(200) NOT NULL DEFAULT '' COMMENT '附件路径',
  `satt_dir` varchar(200) DEFAULT NULL COMMENT '压缩图片路径',
  `size` char(30) NOT NULL DEFAULT '' COMMENT '附件大小',
  `img_dir` varchar(100) NOT NULL DEFAULT '' COMMENT '图片存储的文件夹',
  `type` char(30) NOT NULL DEFAULT '' COMMENT '附件类型',
  `create_time` int(11) NOT NULL DEFAULT '0' COMMENT '上传时间',
  `image_type` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '图片上传类型 1本地 2七牛云 3OSS 4COS ',
  `module_type` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '图片上传模块类型 1 后台上传 2 用户生成',
  `update_time` int(11) unsigned DEFAULT '0',
  `ext` varchar(60) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC COMMENT='附件管理表';

-- -----------------------------
-- Records of `d_attachment`
-- -----------------------------
INSERT INTO `d_attachment` VALUES ('2', 'f0253fbbd7e198bbfe7cdc825c0d7bd0.jpg', '/uploads/attachment/images/20200702/f0253fbbd7e198bbfe7cdc825c0d7bd0.jpg', '/uploads/attachment/images/20200702/f0253fbbd7e198bbfe7cdc825c0d7bd0.jpg', '275219', 'attachment/images', 'image/jpeg', '1593680457', '1', '1', '1593680457', 'jpg');
INSERT INTO `d_attachment` VALUES ('5', '91a0b83b7e61d518a7a3ceee6cf53491.jpg', '/uploads/adminuser/avatar/20200702/91a0b83b7e61d518a7a3ceee6cf53491.jpg', '/uploads/adminuser/avatar/20200702/91a0b83b7e61d518a7a3ceee6cf53491.jpg', '37399', 'adminuser/avatar', 'image/jpg', '1593694742', '1', '1', '1593694742', 'jpg');
INSERT INTO `d_attachment` VALUES ('6', '5e19638241c47d668ad937cd5fde4847.jpg', '/uploads/adminuser/avatar/20200702/5e19638241c47d668ad937cd5fde4847.jpg', '/uploads/adminuser/avatar/20200702/5e19638241c47d668ad937cd5fde4847.jpg', '119892', 'adminuser/avatar', 'image/jpeg', '1593695855', '1', '1', '1593695855', 'jpg');
INSERT INTO `d_attachment` VALUES ('9', '11093c7b2cafb9a3b18a783c9e39f656.jpg', '/uploads/article/images/20200812/11093c7b2cafb9a3b18a783c9e39f656.jpg', '/uploads/article/images/20200812/11093c7b2cafb9a3b18a783c9e39f656.jpg', '719359', 'article/images', 'image/jpeg', '1597218530', '1', '1', '1597218530', 'jpg');
INSERT INTO `d_attachment` VALUES ('10', '23a99408465fe357b8b249e49bd3ada0.jpg', '/uploads/article/images/20200812/23a99408465fe357b8b249e49bd3ada0.jpg', '/uploads/article/images/20200812/23a99408465fe357b8b249e49bd3ada0.jpg', '168009', 'article/images', 'image/jpeg', '1597218904', '1', '1', '1597218904', 'jpg');
INSERT INTO `d_attachment` VALUES ('11', 'e432c8dfe88c6f96cd11f614ec20d93d.jpg', '/uploads/article/images/20200812/e432c8dfe88c6f96cd11f614ec20d93d.jpg', '/uploads/article/images/20200812/e432c8dfe88c6f96cd11f614ec20d93d.jpg', '719359', 'article/images', 'image/jpeg', '1597219379', '1', '1', '1597219379', 'jpg');
INSERT INTO `d_attachment` VALUES ('12', 'e5099e6662e3419b13934aad76c06c2e.png', '/uploads/attachment/images/20200812/e5099e6662e3419b13934aad76c06c2e.png', '/uploads/attachment/images/20200812/e5099e6662e3419b13934aad76c06c2e.png', '819835', 'attachment/images', 'image/png', '1597240018', '1', '1', '1597240018', 'png');
INSERT INTO `d_attachment` VALUES ('13', '273388959722ce1a6cbe4d176f935809.png', '/uploads/attachment/images/20200812/273388959722ce1a6cbe4d176f935809.png', '/uploads/attachment/images/20200812/273388959722ce1a6cbe4d176f935809.png', '1167653', 'attachment/images', 'image/png', '1597240078', '1', '1', '1597240078', 'png');

-- -----------------------------
-- Table structure for `d_auth_group`
-- -----------------------------
DROP TABLE IF EXISTS `d_auth_group`;
CREATE TABLE `d_auth_group` (
  `id` int(8) unsigned NOT NULL AUTO_INCREMENT,
  `create_time` int(11) NOT NULL,
  `update_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '状态1正常0拉黑',
  `title` varchar(255) NOT NULL DEFAULT '' COMMENT '角色组',
  `rules` text COMMENT '权限',
  `pid` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC COMMENT='角色组管理';

-- -----------------------------
-- Records of `d_auth_group`
-- -----------------------------
INSERT INTO `d_auth_group` VALUES ('1', '1593248783', '0', '1', '超级管理', 'all', '0');
INSERT INTO `d_auth_group` VALUES ('2', '1596100582', '1651568613', '1', '超级管理员', '2,6,12,13,14,15,1,3,5,4,25,43,33,9,10,11,34,35,36,26,44,45,50,51,52,46,47,48,49,27,30,31,32,28,29', '0');
INSERT INTO `d_auth_group` VALUES ('5', '1651638661', '1651639237', '1', '普通管理员', '2,34,35,36,83,84,86,87,88,90,85,89', '0');

-- -----------------------------
-- Table structure for `d_auth_group_access`
-- -----------------------------
DROP TABLE IF EXISTS `d_auth_group_access`;
CREATE TABLE `d_auth_group_access` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `uid` mediumint(8) unsigned NOT NULL,
  `group_id` mediumint(8) unsigned NOT NULL,
  `create_time` int(11) DEFAULT '0' COMMENT '添加时间',
  `update_time` int(11) DEFAULT '0' COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `uid_group_id` (`uid`,`group_id`) USING BTREE,
  KEY `uid` (`uid`) USING BTREE,
  KEY `group_id` (`group_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC COMMENT='权限关系表';

-- -----------------------------
-- Records of `d_auth_group_access`
-- -----------------------------
INSERT INTO `d_auth_group_access` VALUES ('1', '2', '2', '1593248783', '0');
INSERT INTO `d_auth_group_access` VALUES ('2', '6', '5', '1651638696', '0');

-- -----------------------------
-- Table structure for `d_auth_rule`
-- -----------------------------
DROP TABLE IF EXISTS `d_auth_rule`;
CREATE TABLE `d_auth_rule` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `pid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '父ID',
  `name` varchar(255) NOT NULL DEFAULT '' COMMENT '控制器/方法',
  `title` char(20) NOT NULL DEFAULT '' COMMENT '菜单名称',
  `type` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '1菜单 2按钮',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '菜单状态0 禁止 1正常',
  `condition` char(100) DEFAULT '',
  `sort` mediumint(8) NOT NULL DEFAULT '0' COMMENT '排序',
  `auth_open` tinyint(2) unsigned DEFAULT '1' COMMENT '1 需验证 2不需验证',
  `icon` varchar(50) DEFAULT '' COMMENT '图标',
  `font_family` varchar(25) NOT NULL DEFAULT 'fa' COMMENT '图标类型',
  `create_time` int(11) NOT NULL DEFAULT '0' COMMENT '添加时间',
  `update_time` int(11) unsigned DEFAULT '0' COMMENT '更新时间',
  `param` varchar(50) DEFAULT '' COMMENT '参数',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=91 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC COMMENT='菜单表';

-- -----------------------------
-- Records of `d_auth_rule`
-- -----------------------------
INSERT INTO `d_auth_rule` VALUES ('1', '2', 'AuthRule/index', '菜单规则', '1', '1', '', '98', '1', 'fa-home', 'fa', '1593354333', '1593354333', '');
INSERT INTO `d_auth_rule` VALUES ('2', '0', '', '权限管理', '1', '1', '', '90', '1', 'fa-cog', 'fa', '1593352451', '1593352729', '');
INSERT INTO `d_auth_rule` VALUES ('3', '1', 'AuthRule/addAuth', '新增', '2', '1', '', '30', '1', '', 'fa', '1593353629', '1593353629', '');
INSERT INTO `d_auth_rule` VALUES ('4', '1', 'AuthRule/addSon', '新增子菜单', '2', '1', '', '10', '1', '', 'fa', '1593354311', '1593509572', '');
INSERT INTO `d_auth_rule` VALUES ('5', '1', 'AuthRule/del', '删除', '2', '1', '', '20', '1', '', 'fa', '1593354333', '1593354333', '');
INSERT INTO `d_auth_rule` VALUES ('6', '2', 'AuthGroup/index', '角色组', '1', '1', '', '100', '1', 'fa-address-book-o', 'fa', '1593441632', '1593441632', '');
INSERT INTO `d_auth_rule` VALUES ('9', '33', 'Admin/addAdmin', '添加', '2', '1', '', '0', '1', '', 'fa', '1593508446', '1593508446', '');
INSERT INTO `d_auth_rule` VALUES ('10', '33', 'Admin/del', '删除', '2', '1', '', '0', '1', '', 'fa', '1593508463', '1593508463', '');
INSERT INTO `d_auth_rule` VALUES ('11', '33', 'Admin/addAdmin', '编辑', '2', '1', '', '0', '1', '', 'fa', '1593508493', '1593508986', '');
INSERT INTO `d_auth_rule` VALUES ('12', '6', 'AuthGroup/userGroup', '角色授权', '2', '1', '', '0', '1', '', 'fa', '1593508559', '1593508559', '');
INSERT INTO `d_auth_rule` VALUES ('13', '6', 'AuthGroup/addGroups', '编辑', '2', '1', '', '0', '1', '', 'fa', '1593508580', '1593508580', '');
INSERT INTO `d_auth_rule` VALUES ('14', '6', 'AuthGroup/del', '删除', '2', '1', '', '0', '1', '', 'fa', '1593508598', '1593508598', '');
INSERT INTO `d_auth_rule` VALUES ('15', '6', 'AuthGroup/addGroups', '新增', '2', '1', '', '0', '1', '', 'fa', '1593508625', '1593508625', '');
INSERT INTO `d_auth_rule` VALUES ('16', '26', 'DataBackup/index', '数据备份', '1', '1', '', '0', '2', 'fa-bank', 'fa', '1593570323', '1596024154', '');
INSERT INTO `d_auth_rule` VALUES ('17', '16', 'DataBackup/index', '数据表列表', '1', '1', '', '0', '2', 'fa-align-left', 'fa', '1593570431', '1593570431', '');
INSERT INTO `d_auth_rule` VALUES ('18', '16', 'DataBackup/importlist', '备份列表', '1', '1', '', '0', '2', 'fa-align-right', 'fa', '1593573590', '1593573590', '');
INSERT INTO `d_auth_rule` VALUES ('25', '1', 'AuthRule/addNode', '添加节点', '2', '1', '', '0', '1', '', 'fa', '1593661475', '0', '');
INSERT INTO `d_auth_rule` VALUES ('26', '0', '', '系统管理', '1', '1', '', '0', '1', 'fa-cogs', 'fa', '1593661642', '1593661642', '');
INSERT INTO `d_auth_rule` VALUES ('27', '26', 'AttachMents/index', '附件管理', '1', '1', '', '0', '1', 'fa-link', 'fa', '1593661815', '1593661815', '');
INSERT INTO `d_auth_rule` VALUES ('28', '26', 'SystemLog/index', '日志管理', '1', '1', '', '0', '1', 'fa-book', 'fa', '1593669289', '1593669289', '');
INSERT INTO `d_auth_rule` VALUES ('29', '28', 'SystemLog/del', '删除', '2', '1', '', '0', '1', '', 'fa', '1593669410', '0', '');
INSERT INTO `d_auth_rule` VALUES ('30', '27', 'AttachMents/uploadAttachment', '上传', '2', '1', '', '0', '1', '', 'fa', '1593670168', '0', '');
INSERT INTO `d_auth_rule` VALUES ('31', '27', 'AttachMents/del', '删除', '2', '1', '', '0', '1', '', 'fa', '1593670168', '0', '');
INSERT INTO `d_auth_rule` VALUES ('32', '27', 'AttachMents/download', '打包下载', '2', '1', '', '0', '1', '', 'fa', '1593680898', '0', '');
INSERT INTO `d_auth_rule` VALUES ('33', '2', 'Admin/index', '管理员管理', '1', '1', '', '0', '1', 'fa-address-book', 'fa', '1593692881', '1593692881', '');
INSERT INTO `d_auth_rule` VALUES ('34', '2', '', '基本设置', '1', '1', '', '0', '1', 'fa-address-book-o', 'fa', '1593693025', '1593693025', '');
INSERT INTO `d_auth_rule` VALUES ('35', '34', 'Admin/baseData', '基本资料', '1', '1', '', '0', '1', 'fa-address-card', 'fa', '1593693110', '1593693233', '');
INSERT INTO `d_auth_rule` VALUES ('36', '34', 'Admin/changPass', '修改密码', '1', '1', '', '0', '1', 'fa-amazon', 'fa', '1593693191', '1593693191', '');
INSERT INTO `d_auth_rule` VALUES ('43', '1', 'AuthRule/update', '修改', '2', '1', '', '0', '1', '', 'fa', '1596091531', '0', '');
INSERT INTO `d_auth_rule` VALUES ('44', '26', '', '系统配置', '1', '1', '', '10', '1', 'fa-gear', 'fa', '1596092002', '1596092016', '');
INSERT INTO `d_auth_rule` VALUES ('45', '44', 'config.Sysconfigtab/index', '配置分类', '1', '1', '', '10', '1', 'fa-rouble', 'fa', '1596093842', '1596093842', '');
INSERT INTO `d_auth_rule` VALUES ('46', '44', 'config.Sysconfig/index', '配置列表', '1', '1', '', '10', '1', 'fa-gbp', 'fa', '1596093879', '1596093879', '');
INSERT INTO `d_auth_rule` VALUES ('47', '46', 'config.Sysconfig/addConfig', '添加', '2', '1', '', '0', '1', '', 'fa', '1596098397', '0', '');
INSERT INTO `d_auth_rule` VALUES ('48', '46', 'config.Sysconfig/update', '编辑', '2', '1', '', '0', '1', '', 'fa', '1596098397', '0', '');
INSERT INTO `d_auth_rule` VALUES ('49', '46', 'config.Sysconfig/del', '删除', '2', '1', '', '0', '1', '', 'fa', '1596098397', '0', '');
INSERT INTO `d_auth_rule` VALUES ('50', '45', 'config.Sysconfigtab/addConfigTab', '新增', '2', '1', '', '0', '1', '', 'fa', '1596098741', '0', '');
INSERT INTO `d_auth_rule` VALUES ('51', '45', 'config.Sysconfigtab/update', '修改', '2', '1', '', '0', '1', '', 'fa', '1596098741', '0', '');
INSERT INTO `d_auth_rule` VALUES ('52', '45', 'config.Sysconfigtab/del', '删除', '2', '1', '', '0', '1', '', 'fa', '1596098741', '0', '');
INSERT INTO `d_auth_rule` VALUES ('77', '76', 'example.FormBuilder/index', 'FormBuilder', '1', '1', '', '10', '1', 'fa-facebook-official', 'fa', '1597279795', '1597279795', '');
INSERT INTO `d_auth_rule` VALUES ('78', '76', 'example.FormLayui/index', 'FormLayui', '1', '1', '', '10', '1', 'fa-paper-plane-o', 'fa', '1597279836', '1597279836', '');
INSERT INTO `d_auth_rule` VALUES ('79', '65', 'article.ArticleComment/check', '审核评论', '2', '1', '', '0', '1', '', 'fa', '1597328076', '0', '');
INSERT INTO `d_auth_rule` VALUES ('80', '65', 'article.ArticleComment/del', '删除评论', '2', '1', '', '0', '1', '', 'fa', '1597328076', '0', '');
INSERT INTO `d_auth_rule` VALUES ('81', '65', 'article.ArticleComment/edit', '编辑评论', '2', '1', '', '0', '1', '', 'fa', '1597328076', '0', '');
INSERT INTO `d_auth_rule` VALUES ('82', '64', 'article.ArticleUser/del', '删除', '2', '1', '', '0', '1', '', 'fa', '1597328132', '0', '');
INSERT INTO `d_auth_rule` VALUES ('83', '0', '', '页面设置', '1', '1', '', '10', '1', 'fa-tags', 'fa', '1651595689', '1651599707', '');
INSERT INTO `d_auth_rule` VALUES ('84', '83', 'PageSetting/index', '跳转页面设置', '1', '1', '', '10', '1', 'fa-paper-plane', 'fa', '1651595736', '1651599594', '');
INSERT INTO `d_auth_rule` VALUES ('85', '83', 'PageEmail/index', '页面邮箱收集', '1', '1', '', '10', '1', 'fa-envelope', 'fa', '1651598941', '1651598941', '');
INSERT INTO `d_auth_rule` VALUES ('86', '84', 'PageSetting/del', '跳转页面删除', '2', '1', '', '0', '1', '', 'fa', '1651637840', '0', '');
INSERT INTO `d_auth_rule` VALUES ('87', '84', 'PageSetting/add', '跳转页面添加', '2', '1', '', '0', '1', '', 'fa', '1651637901', '0', '');
INSERT INTO `d_auth_rule` VALUES ('88', '84', 'PageSetting/edit', '跳转页面编辑', '2', '1', '', '0', '1', '', 'fa', '1651637943', '0', '');
INSERT INTO `d_auth_rule` VALUES ('89', '85', 'PageEmail/del', '删除', '2', '1', '', '0', '1', '', 'fa', '1651637996', '0', '');
INSERT INTO `d_auth_rule` VALUES ('90', '84', 'PageSetting/upAndAdd', '添加和更新', '2', '1', '', '0', '1', '', 'fa', '1651639198', '0', '');

-- -----------------------------
-- Table structure for `d_commands`
-- -----------------------------
DROP TABLE IF EXISTS `d_commands`;
CREATE TABLE `d_commands` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `admin_id` int(11) NOT NULL COMMENT '执行者',
  `name` varchar(80) DEFAULT NULL,
  `app` varchar(255) NOT NULL DEFAULT 'admin' COMMENT '模块名',
  `command` varchar(255) NOT NULL COMMENT '命令',
  `controller` varchar(100) NOT NULL COMMENT '控制器',
  `model` varchar(100) NOT NULL COMMENT '模型',
  `validate` varchar(100) NOT NULL COMMENT '验证器',
  `ext` varchar(255) DEFAULT NULL COMMENT '序列化值',
  `do_time` datetime DEFAULT NULL COMMENT '命令执行时间',
  `status` tinyint(1) unsigned zerofill NOT NULL DEFAULT '1' COMMENT '执行状态：0失败，1成功',
  `create_time` int(11) NOT NULL,
  `update_time` int(11) unsigned DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COMMENT='在线命令管理';

-- -----------------------------
-- Records of `d_commands`
-- -----------------------------
INSERT INTO `d_commands` VALUES ('1', '1', '生成菜单', 'admin', 'php think make:jrkadmin_curd Test Tests Test --app admin', 'Test', 'Tests', 'Test', '[\"Test\",\"Tests\",\"Test\",\"--app\",\"admin\"]', '2020-08-07 14:27:42', '1', '1596781662', '1596781662');
INSERT INTO `d_commands` VALUES ('2', '1', '生成菜单', 'admin', 'php think make:jrkadmin_curd Friendlink Friendlinks Friendlink --app admin', 'Friendlink', 'Friendlinks', 'Friendlink', '[\"Friendlink\",\"Friendlinks\",\"Friendlink\",\"--app\",\"admin\"]', '2020-08-10 14:17:16', '1', '1597040236', '1597040236');

-- -----------------------------
-- Table structure for `d_friendlinks`
-- -----------------------------
DROP TABLE IF EXISTS `d_friendlinks`;
CREATE TABLE `d_friendlinks` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL COMMENT '链接名称',
  `url` varchar(150) NOT NULL COMMENT '链接地址',
  `admin_id` int(11) unsigned NOT NULL,
  `site_link` tinyint(1) NOT NULL COMMENT '所属平台, 1=> ''PC'',2=> ''WAP站'',3=> ''小程序'', 4=> ''APP应用''',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '1正常0禁止',
  `create_time` int(11) NOT NULL,
  `update_time` int(11) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COMMENT='友情链接';

-- -----------------------------
-- Records of `d_friendlinks`
-- -----------------------------
INSERT INTO `d_friendlinks` VALUES ('1', '百度', 'www.baidu.com', '1', '1', '1', '1597043244', '1597043285');

-- -----------------------------
-- Table structure for `d_page_email_collect`
-- -----------------------------
DROP TABLE IF EXISTS `d_page_email_collect`;
CREATE TABLE `d_page_email_collect` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `email` varchar(255) NOT NULL,
  `p` varchar(64) NOT NULL DEFAULT '',
  `create_time` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `time` (`create_time`) USING BTREE,
  KEY `email` (`email`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

-- -----------------------------
-- Records of `d_page_email_collect`
-- -----------------------------
INSERT INTO `d_page_email_collect` VALUES ('7', '123@qq.com', '', '1651608900');
INSERT INTO `d_page_email_collect` VALUES ('8', '123@qq.com', '1', '1651635697');
INSERT INTO `d_page_email_collect` VALUES ('9', '456@qq.com', 'abc', '1651636376');

-- -----------------------------
-- Table structure for `d_page_setting`
-- -----------------------------
DROP TABLE IF EXISTS `d_page_setting`;
CREATE TABLE `d_page_setting` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `page_num` varchar(64) NOT NULL DEFAULT '0',
  `jump_url` varchar(512) NOT NULL DEFAULT '',
  `create_time` int(11) NOT NULL DEFAULT '0',
  `update_time` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `page_num` (`page_num`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- -----------------------------
-- Records of `d_page_setting`
-- -----------------------------
INSERT INTO `d_page_setting` VALUES ('1', '1', 'https://wa.me/+447448001002?text=Rich', '0', '1651598704');
INSERT INTO `d_page_setting` VALUES ('2', '3', 'https://wa.me/+447448001002?text=Rich', '1651597854', '1651598207');
INSERT INTO `d_page_setting` VALUES ('3', 'abc', 'https://wa.me/+447448001002?text=Rich', '1651636301', '1651636342');
INSERT INTO `d_page_setting` VALUES ('4', '123', 'add', '1651639109', '1651639109');
INSERT INTO `d_page_setting` VALUES ('5', 'asd', 'https://wa.me/+447448001002?text=Rich', '1651639254', '1651639254');

-- -----------------------------
-- Table structure for `d_sys_config`
-- -----------------------------
DROP TABLE IF EXISTS `d_sys_config`;
CREATE TABLE `d_sys_config` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `group_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '分组ID',
  `group` varchar(80) NOT NULL COMMENT '配置分组名',
  `name` varchar(80) NOT NULL COMMENT '配置名',
  `value` varchar(255) DEFAULT NULL COMMENT '配置值',
  `create_time` int(11) unsigned NOT NULL DEFAULT '0',
  `beizhu` varchar(255) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC COMMENT='配置表';

-- -----------------------------
-- Records of `d_sys_config`
-- -----------------------------
INSERT INTO `d_sys_config` VALUES ('1', '3', 'upload', 'accessKey', 'accessKey', '1593354333', '');
INSERT INTO `d_sys_config` VALUES ('2', '3', 'upload', 'secretKey', 'secretKey', '1593354333', '');
INSERT INTO `d_sys_config` VALUES ('3', '3', 'upload', 'uploadUrl', 'uploadUrl', '1593354333', '');
INSERT INTO `d_sys_config` VALUES ('4', '3', 'upload', 'storage_name', 'storage_name', '1593354333', '');
INSERT INTO `d_sys_config` VALUES ('5', '3', 'upload', 'storage_region', 'storage_region', '1593354333', '');
INSERT INTO `d_sys_config` VALUES ('14', '2', 'site', 'site_name', 'DER', '1593354333', '');
INSERT INTO `d_sys_config` VALUES ('15', '2', 'site', 'site_url', '网站地址', '1593354333', '');
INSERT INTO `d_sys_config` VALUES ('16', '2', 'site', 'site_logo', '站点LOGO', '1593354333', '');
INSERT INTO `d_sys_config` VALUES ('17', '2', 'site', 'site_phone', '站点联系电话', '1593354333', '');
INSERT INTO `d_sys_config` VALUES ('18', '2', 'site', 'site_seo_title', 'SEO标题', '1593354333', '');
INSERT INTO `d_sys_config` VALUES ('19', '2', 'site', 'site_email', '站点联系邮箱', '1593354333', '');
INSERT INTO `d_sys_config` VALUES ('20', '2', 'site', 'site_qq', '站点联系QQ', '1593354333', '');
INSERT INTO `d_sys_config` VALUES ('21', '2', 'site', 'site_close', '网站关闭', '1593354333', '0=>开启1=>PC端关闭2=>WAP端关闭(含微信)3=>全部关闭');
INSERT INTO `d_sys_config` VALUES ('22', '3', 'upload', 'upload_type', '1', '1593354333', '1=>本地存储2=>七牛云存储3=>阿里云OSS4=>腾讯COS');
INSERT INTO `d_sys_config` VALUES ('23', '4', 'push', 'xzappid', '的appid', '1596099671', '');
INSERT INTO `d_sys_config` VALUES ('24', '4', 'push', 'xztoken', 'token', '1596099698', '');
INSERT INTO `d_sys_config` VALUES ('25', '4', 'push', 'zz_site', '1', '1596099776', '百度站长的站点');
INSERT INTO `d_sys_config` VALUES ('26', '4', 'push', 'zz_token', '2', '1596099819', '百度站长token');
INSERT INTO `d_sys_config` VALUES ('27', '2', 'site', 'site_keywords', 'keywords', '1596101048', '');
INSERT INTO `d_sys_config` VALUES ('28', '2', 'site', 'site_description', 'description', '1596101062', '');
INSERT INTO `d_sys_config` VALUES ('29', '5', 'mail', 'mail_smtp_host', '12@qq.com', '1596165822', 'smtp服务器');
INSERT INTO `d_sys_config` VALUES ('30', '5', 'mail', 'mail_smtp_port', '25', '1596165861', '端口：25, 465 or 587');
INSERT INTO `d_sys_config` VALUES ('31', '5', 'mail', 'mail_secure', 'ssl', '1596165954', '安全协议，ssl,tls');
INSERT INTO `d_sys_config` VALUES ('32', '5', 'mail', 'mail_smtp_user', '1@qq.com', '1596165991', '用户名');
INSERT INTO `d_sys_config` VALUES ('33', '5', 'mail', 'mail_smtp_pass', 'dasdasd', '1596166005', '密码');
INSERT INTO `d_sys_config` VALUES ('34', '5', 'mail', 'mail_smtp_name', 'asd', '1596166030', '发送邮件的用户名称');

-- -----------------------------
-- Table structure for `d_sys_config_tab`
-- -----------------------------
DROP TABLE IF EXISTS `d_sys_config_tab`;
CREATE TABLE `d_sys_config_tab` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(100) NOT NULL COMMENT '配置分类名称',
  `eng_title` varchar(100) NOT NULL COMMENT '分类英文名',
  `pid` int(10) unsigned NOT NULL DEFAULT '0',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '0禁止1正常',
  `create_time` int(11) NOT NULL DEFAULT '0',
  `update_time` int(11) NOT NULL DEFAULT '0',
  `beizhu` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COMMENT='配置分类表';

-- -----------------------------
-- Records of `d_sys_config_tab`
-- -----------------------------
INSERT INTO `d_sys_config_tab` VALUES ('1', '默认分类', 'moren', '0', '1', '1596095169', '1596095169', '没有分配分类的配置');
INSERT INTO `d_sys_config_tab` VALUES ('2', '站点配置', 'site', '0', '1', '1596095705', '1596095705', '后端站点所有配置');
INSERT INTO `d_sys_config_tab` VALUES ('3', '上传配置', 'upload', '0', '1', '1596096079', '1596096079', '');
INSERT INTO `d_sys_config_tab` VALUES ('4', '地址推送', 'push', '0', '1', '1596099565', '1596099565', '');
INSERT INTO `d_sys_config_tab` VALUES ('5', '邮件发送', 'mail', '0', '1', '1596165769', '1596165769', '');

-- -----------------------------
-- Table structure for `d_sys_version`
-- -----------------------------
DROP TABLE IF EXISTS `d_sys_version`;
CREATE TABLE `d_sys_version` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `admin_id` int(11) unsigned NOT NULL,
  `version` varchar(255) NOT NULL DEFAULT '' COMMENT '版本号',
  `content` varchar(255) NOT NULL COMMENT '更新内容',
  `date_time` date NOT NULL COMMENT '更新时间',
  `create_time` int(11) NOT NULL DEFAULT '0',
  `update_time` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COMMENT='系统版本管理';


-- -----------------------------
-- Table structure for `d_system_log_202205`
-- -----------------------------
DROP TABLE IF EXISTS `d_system_log_202205`;
CREATE TABLE `d_system_log_202205` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `admin_id` int(10) unsigned DEFAULT '0' COMMENT '管理员ID',
  `url` varchar(1500) NOT NULL DEFAULT '' COMMENT '操作页面',
  `method` varchar(50) NOT NULL COMMENT '请求方法',
  `title` varchar(100) DEFAULT '' COMMENT '日志标题',
  `content` text NOT NULL COMMENT '内容',
  `ip` varchar(50) NOT NULL DEFAULT '' COMMENT 'IP',
  `useragent` varchar(255) DEFAULT '' COMMENT 'User-Agent',
  `os` varchar(100) DEFAULT '' COMMENT 'os',
  `brower` varchar(100) DEFAULT '' COMMENT 'brower',
  `create_time` int(10) DEFAULT NULL COMMENT '操作时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=114 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT COMMENT='后台操作日志表 - 202205';

-- -----------------------------
-- Records of `d_system_log_202205`
-- -----------------------------
INSERT INTO `d_system_log_202205` VALUES ('1', '0', '/admin/login/logout', 'post', '', 'a:0:{}', '172.21.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/101.0.4951.41 Safari/537.36 Edg/101.0.1210.32', 'windows', 'Chrome/101.0.4951.41', '1651566142');
INSERT INTO `d_system_log_202205` VALUES ('2', '1', '/admin/login/loginCheck.html', 'post', '超级管理员', 'a:2:{s:8:\"username\";s:5:\"admin\";s:9:\"__token__\";s:32:\"be89394f0af90f0a6997f9abc8519229\";}', '172.21.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/101.0.4951.41 Safari/537.36 Edg/101.0.1210.32', 'windows', 'Chrome/101.0.4951.41', '1651566152');
INSERT INTO `d_system_log_202205` VALUES ('3', '1', '/admin/login/loginCheck.html', 'post', '超级管理员', 'a:2:{s:8:\"username\";s:5:\"admin\";s:9:\"__token__\";s:32:\"be89394f0af90f0a6997f9abc8519229\";}', '172.21.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/101.0.4951.41 Safari/537.36 Edg/101.0.1210.32', 'windows', 'Chrome/101.0.4951.41', '1651566578');
INSERT INTO `d_system_log_202205` VALUES ('4', '0', '/admin/login/logout', 'post', '', 'a:0:{}', '172.21.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/101.0.4951.41 Safari/537.36 Edg/101.0.1210.32', 'windows', 'Chrome/101.0.4951.41', '1651566742');
INSERT INTO `d_system_log_202205` VALUES ('5', '0', '/admin/login/logout', 'post', '', 'a:0:{}', '172.21.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/101.0.4951.41 Safari/537.36 Edg/101.0.1210.32', 'windows', 'Chrome/101.0.4951.41', '1651566759');
INSERT INTO `d_system_log_202205` VALUES ('6', '1', '/admin/login/loginCheck.html', 'post', '超级管理员', 'a:2:{s:8:\"username\";s:5:\"admin\";s:9:\"__token__\";s:32:\"6acdff12c6985c3c07e59d23b999b8fe\";}', '172.21.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/101.0.4951.41 Safari/537.36 Edg/101.0.1210.32', 'windows', 'Chrome/101.0.4951.41', '1651566769');
INSERT INTO `d_system_log_202205` VALUES ('7', '1', '/admin/login/loginCheck.html', 'post', '超级管理员', 'a:2:{s:8:\"username\";s:5:\"admin\";s:9:\"__token__\";s:32:\"6acdff12c6985c3c07e59d23b999b8fe\";}', '172.21.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/101.0.4951.41 Safari/537.36 Edg/101.0.1210.32', 'windows', 'Chrome/101.0.4951.41', '1651566880');
INSERT INTO `d_system_log_202205` VALUES ('8', '0', '/admin/login/logout', 'post', '', 'a:0:{}', '172.21.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/101.0.4951.41 Safari/537.36 Edg/101.0.1210.32', 'windows', 'Chrome/101.0.4951.41', '1651567019');
INSERT INTO `d_system_log_202205` VALUES ('9', '0', '/admin/login/logout', 'post', '', 'a:0:{}', '172.21.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/101.0.4951.41 Safari/537.36 Edg/101.0.1210.32', 'windows', 'Chrome/101.0.4951.41', '1651567029');
INSERT INTO `d_system_log_202205` VALUES ('10', '1', '/admin/login/loginCheck.html', 'post', '超级管理员', 'a:2:{s:8:\"username\";s:5:\"admin\";s:9:\"__token__\";s:32:\"38cc5363a41d9b95b13bfdf34512f438\";}', '172.21.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/101.0.4951.41 Safari/537.36 Edg/101.0.1210.32', 'windows', 'Chrome/101.0.4951.41', '1651567038');
INSERT INTO `d_system_log_202205` VALUES ('11', '1', '/admin/login/loginCheck.html', 'post', '超级管理员', 'a:2:{s:8:\"username\";s:5:\"admin\";s:9:\"__token__\";s:32:\"38cc5363a41d9b95b13bfdf34512f438\";}', '172.21.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/101.0.4951.41 Safari/537.36 Edg/101.0.1210.32', 'windows', 'Chrome/101.0.4951.41', '1651567083');
INSERT INTO `d_system_log_202205` VALUES ('12', '0', '/admin/login/logout', 'post', '', 'a:0:{}', '172.21.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/101.0.4951.41 Safari/537.36 Edg/101.0.1210.32', 'windows', 'Chrome/101.0.4951.41', '1651567205');
INSERT INTO `d_system_log_202205` VALUES ('13', '0', '/admin/login/logout', 'post', '', 'a:0:{}', '172.21.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/101.0.4951.41 Safari/537.36 Edg/101.0.1210.32', 'windows', 'Chrome/101.0.4951.41', '1651567316');
INSERT INTO `d_system_log_202205` VALUES ('14', '1', '/admin/login/loginCheck.html', 'post', '超级管理员', 'a:2:{s:8:\"username\";s:5:\"admin\";s:9:\"__token__\";s:32:\"f990db3e6dc3c0b7cc361c2cbfcad872\";}', '172.21.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/101.0.4951.41 Safari/537.36 Edg/101.0.1210.32', 'windows', 'Chrome/101.0.4951.41', '1651567325');
INSERT INTO `d_system_log_202205` VALUES ('15', '1', '/admin/AuthRule/index.html', 'post', '超级管理员', 'a:1:{s:5:\"title\";s:0:\"\";}', '172.21.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/101.0.4951.41 Safari/537.36 Edg/101.0.1210.32', 'windows', 'Chrome/101.0.4951.41', '1651567406');
INSERT INTO `d_system_log_202205` VALUES ('16', '1', '/admin/AuthRule/index.html', 'post', '超级管理员', 'a:1:{s:5:\"title\";s:0:\"\";}', '172.21.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/101.0.4951.41 Safari/537.36 Edg/101.0.1210.32', 'windows', 'Chrome/101.0.4951.41', '1651567436');
INSERT INTO `d_system_log_202205` VALUES ('17', '1', '/admin/AuthRule/index.html', 'post', '超级管理员', 'a:1:{s:5:\"title\";s:0:\"\";}', '172.21.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/101.0.4951.41 Safari/537.36 Edg/101.0.1210.32', 'windows', 'Chrome/101.0.4951.41', '1651567442');
INSERT INTO `d_system_log_202205` VALUES ('18', '1', '/admin/index/clearCache', 'post', '超级管理员', 'a:0:{}', '172.21.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/101.0.4951.41 Safari/537.36 Edg/101.0.1210.32', 'windows', 'Chrome/101.0.4951.41', '1651567511');
INSERT INTO `d_system_log_202205` VALUES ('19', '1', '/admin/login/loginCheck.html', 'post', '超级管理员', 'a:2:{s:8:\"username\";s:5:\"admin\";s:9:\"__token__\";s:32:\"f990db3e6dc3c0b7cc361c2cbfcad872\";}', '172.21.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/101.0.4951.41 Safari/537.36 Edg/101.0.1210.32', 'windows', 'Chrome/101.0.4951.41', '1651567679');
INSERT INTO `d_system_log_202205` VALUES ('20', '1', '/admin/login/loginCheck.html', 'post', '超级管理员', 'a:2:{s:8:\"username\";s:5:\"admin\";s:9:\"__token__\";s:32:\"f990db3e6dc3c0b7cc361c2cbfcad872\";}', '172.21.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/101.0.4951.41 Safari/537.36 Edg/101.0.1210.32', 'windows', 'Chrome/101.0.4951.41', '1651567687');
INSERT INTO `d_system_log_202205` VALUES ('21', '1', '/admin/index/clearCache', 'post', '超级管理员', 'a:0:{}', '172.21.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/101.0.4951.41 Safari/537.36 Edg/101.0.1210.32', 'windows', 'Chrome/101.0.4951.41', '1651567761');
INSERT INTO `d_system_log_202205` VALUES ('22', '1', '/admin/index/clearCache', 'post', '超级管理员', 'a:0:{}', '172.21.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/101.0.4951.41 Safari/537.36 Edg/101.0.1210.32', 'windows', 'Chrome/101.0.4951.41', '1651567961');
INSERT INTO `d_system_log_202205` VALUES ('23', '1', '/admin/AuthGroup/getRoles.html', 'post', '超级管理员', 'a:1:{s:2:\"id\";s:1:\"0\";}', '172.21.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/101.0.4951.41 Safari/537.36 Edg/101.0.1210.32', 'windows', 'Chrome/101.0.4951.41', '1651568032');
INSERT INTO `d_system_log_202205` VALUES ('24', '1', '/admin/Admin/addAdmin.html', 'post', '超级管理员', 'a:9:{s:6:\"avatar\";s:0:\"\";s:8:\"username\";s:8:\"deradmin\";s:8:\"nickname\";s:5:\"admin\";s:5:\"phone\";s:0:\"\";s:5:\"email\";s:0:\"\";s:8:\"birthday\";s:0:\"\";s:3:\"sex\";s:1:\"0\";s:6:\"status\";s:1:\"1\";s:9:\"__token__\";s:32:\"cd6541bddc178dfe9dc8f9d703e705b0\";}', '172.21.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/101.0.4951.41 Safari/537.36 Edg/101.0.1210.32', 'windows', 'Chrome/101.0.4951.41', '1651568103');
INSERT INTO `d_system_log_202205` VALUES ('25', '1', '/admin/index/clearCache', 'post', '超级管理员', 'a:0:{}', '172.21.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/101.0.4951.41 Safari/537.36 Edg/101.0.1210.32', 'windows', 'Chrome/101.0.4951.41', '1651568399');
INSERT INTO `d_system_log_202205` VALUES ('26', '0', '/admin/login/logout', 'post', '', 'a:0:{}', '172.21.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/101.0.4951.41 Safari/537.36 Edg/101.0.1210.32', 'windows', 'Chrome/101.0.4951.41', '1651568438');
INSERT INTO `d_system_log_202205` VALUES ('27', '2', '/admin/login/loginCheck.html', 'post', 'admin', 'a:2:{s:8:\"username\";s:8:\"deradmin\";s:9:\"__token__\";s:32:\"ad821ee55f78c458556b0857d978895d\";}', '172.21.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/101.0.4951.41 Safari/537.36 Edg/101.0.1210.32', 'windows', 'Chrome/101.0.4951.41', '1651568465');
INSERT INTO `d_system_log_202205` VALUES ('28', '0', '/admin/login/logout', 'post', '', 'a:0:{}', '172.21.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/101.0.4951.41 Safari/537.36 Edg/101.0.1210.32', 'windows', 'Chrome/101.0.4951.41', '1651568484');
INSERT INTO `d_system_log_202205` VALUES ('29', '1', '/admin/login/loginCheck.html', 'post', '超级管理员', 'a:2:{s:8:\"username\";s:5:\"admin\";s:9:\"__token__\";s:32:\"b462d19d593e1b5c3baa7f988175e6bd\";}', '172.21.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/101.0.4951.41 Safari/537.36 Edg/101.0.1210.32', 'windows', 'Chrome/101.0.4951.41', '1651568499');
INSERT INTO `d_system_log_202205` VALUES ('30', '1', '/admin/AuthGroup/userGroup.html', 'post', '超级管理员', 'a:2:{s:8:\"group_id\";s:1:\"2\";s:3:\"uid\";a:1:{i:0;s:1:\"2\";}}', '172.21.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/101.0.4951.41 Safari/537.36 Edg/101.0.1210.32', 'windows', 'Chrome/101.0.4951.41', '1651568539');
INSERT INTO `d_system_log_202205` VALUES ('31', '1', '/admin/AuthGroup/getRoles.html', 'post', '超级管理员', 'a:1:{s:2:\"id\";s:1:\"2\";}', '172.21.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/101.0.4951.41 Safari/537.36 Edg/101.0.1210.32', 'windows', 'Chrome/101.0.4951.41', '1651568552');
INSERT INTO `d_system_log_202205` VALUES ('32', '1', '/admin/AuthGroup/upAndAdd.html', 'post', '超级管理员', 'a:6:{s:3:\"pid\";s:1:\"0\";s:2:\"id\";s:1:\"2\";s:9:\"__token__\";s:32:\"ef1dd8a68af5b241596beda6accb319f\";s:5:\"title\";s:16:\"超级管理员2\";s:6:\"status\";s:1:\"1\";s:4:\"rule\";a:44:{i:0;s:1:\"2\";i:1;s:1:\"6\";i:2;s:2:\"12\";i:3;s:2:\"13\";i:4;s:2:\"14\";i:5;s:2:\"15\";i:6;s:1:\"6\";i:7;s:1:\"1\";i:8;s:1:\"3\";i:9;s:1:\"5\";i:10;s:1:\"4\";i:11;s:2:\"25\";i:12;s:2:\"43\";i:13;s:1:\"1\";i:14;s:2:\"33\";i:15;s:1:\"9\";i:16;s:2:\"10\";i:17;s:2:\"11\";i:18;s:2:\"33\";i:19;s:2:\"34\";i:20;s:2:\"35\";i:21;s:2:\"35\";i:22;s:2:\"36\";i:23;s:2:\"36\";i:24;s:2:\"26\";i:25;s:2:\"44\";i:26;s:2:\"45\";i:27;s:2:\"50\";i:28;s:2:\"51\";i:29;s:2:\"52\";i:30;s:2:\"45\";i:31;s:2:\"46\";i:32;s:2:\"47\";i:33;s:2:\"48\";i:34;s:2:\"49\";i:35;s:2:\"46\";i:36;s:2:\"27\";i:37;s:2:\"30\";i:38;s:2:\"31\";i:39;s:2:\"32\";i:40;s:2:\"27\";i:41;s:2:\"28\";i:42;s:2:\"29\";i:43;s:2:\"28\";}}', '172.21.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/101.0.4951.41 Safari/537.36 Edg/101.0.1210.32', 'windows', 'Chrome/101.0.4951.41', '1651568585');
INSERT INTO `d_system_log_202205` VALUES ('33', '1', '/admin/AuthGroup/upAndAdd.html', 'post', '超级管理员', 'a:6:{s:3:\"pid\";s:1:\"0\";s:2:\"id\";s:1:\"2\";s:9:\"__token__\";s:32:\"ef1dd8a68af5b241596beda6accb319f\";s:5:\"title\";s:16:\"超级管理员2\";s:6:\"status\";s:1:\"1\";s:4:\"rule\";a:44:{i:0;s:1:\"2\";i:1;s:1:\"6\";i:2;s:2:\"12\";i:3;s:2:\"13\";i:4;s:2:\"14\";i:5;s:2:\"15\";i:6;s:1:\"6\";i:7;s:1:\"1\";i:8;s:1:\"3\";i:9;s:1:\"5\";i:10;s:1:\"4\";i:11;s:2:\"25\";i:12;s:2:\"43\";i:13;s:1:\"1\";i:14;s:2:\"33\";i:15;s:1:\"9\";i:16;s:2:\"10\";i:17;s:2:\"11\";i:18;s:2:\"33\";i:19;s:2:\"34\";i:20;s:2:\"35\";i:21;s:2:\"35\";i:22;s:2:\"36\";i:23;s:2:\"36\";i:24;s:2:\"26\";i:25;s:2:\"44\";i:26;s:2:\"45\";i:27;s:2:\"50\";i:28;s:2:\"51\";i:29;s:2:\"52\";i:30;s:2:\"45\";i:31;s:2:\"46\";i:32;s:2:\"47\";i:33;s:2:\"48\";i:34;s:2:\"49\";i:35;s:2:\"46\";i:36;s:2:\"27\";i:37;s:2:\"30\";i:38;s:2:\"31\";i:39;s:2:\"32\";i:40;s:2:\"27\";i:41;s:2:\"28\";i:42;s:2:\"29\";i:43;s:2:\"28\";}}', '172.21.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/101.0.4951.41 Safari/537.36 Edg/101.0.1210.32', 'windows', 'Chrome/101.0.4951.41', '1651568600');
INSERT INTO `d_system_log_202205` VALUES ('34', '1', '/admin/AuthGroup/upAndAdd.html', 'post', '超级管理员', 'a:6:{s:3:\"pid\";s:1:\"0\";s:2:\"id\";s:1:\"2\";s:9:\"__token__\";s:32:\"ef1dd8a68af5b241596beda6accb319f\";s:5:\"title\";s:16:\"超级管理员2\";s:6:\"status\";s:1:\"1\";s:4:\"rule\";a:44:{i:0;s:1:\"2\";i:1;s:1:\"6\";i:2;s:2:\"12\";i:3;s:2:\"13\";i:4;s:2:\"14\";i:5;s:2:\"15\";i:6;s:1:\"6\";i:7;s:1:\"1\";i:8;s:1:\"3\";i:9;s:1:\"5\";i:10;s:1:\"4\";i:11;s:2:\"25\";i:12;s:2:\"43\";i:13;s:1:\"1\";i:14;s:2:\"33\";i:15;s:1:\"9\";i:16;s:2:\"10\";i:17;s:2:\"11\";i:18;s:2:\"33\";i:19;s:2:\"34\";i:20;s:2:\"35\";i:21;s:2:\"35\";i:22;s:2:\"36\";i:23;s:2:\"36\";i:24;s:2:\"26\";i:25;s:2:\"44\";i:26;s:2:\"45\";i:27;s:2:\"50\";i:28;s:2:\"51\";i:29;s:2:\"52\";i:30;s:2:\"45\";i:31;s:2:\"46\";i:32;s:2:\"47\";i:33;s:2:\"48\";i:34;s:2:\"49\";i:35;s:2:\"46\";i:36;s:2:\"27\";i:37;s:2:\"30\";i:38;s:2:\"31\";i:39;s:2:\"32\";i:40;s:2:\"27\";i:41;s:2:\"28\";i:42;s:2:\"29\";i:43;s:2:\"28\";}}', '172.21.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/101.0.4951.41 Safari/537.36 Edg/101.0.1210.32', 'windows', 'Chrome/101.0.4951.41', '1651568603');
INSERT INTO `d_system_log_202205` VALUES ('35', '1', '/admin/AuthGroup/upAndAdd.html', 'post', '超级管理员', 'a:6:{s:3:\"pid\";s:1:\"0\";s:2:\"id\";s:1:\"2\";s:9:\"__token__\";s:32:\"ef1dd8a68af5b241596beda6accb319f\";s:5:\"title\";s:15:\"超级管理员\";s:6:\"status\";s:1:\"1\";s:4:\"rule\";a:44:{i:0;s:1:\"2\";i:1;s:1:\"6\";i:2;s:2:\"12\";i:3;s:2:\"13\";i:4;s:2:\"14\";i:5;s:2:\"15\";i:6;s:1:\"6\";i:7;s:1:\"1\";i:8;s:1:\"3\";i:9;s:1:\"5\";i:10;s:1:\"4\";i:11;s:2:\"25\";i:12;s:2:\"43\";i:13;s:1:\"1\";i:14;s:2:\"33\";i:15;s:1:\"9\";i:16;s:2:\"10\";i:17;s:2:\"11\";i:18;s:2:\"33\";i:19;s:2:\"34\";i:20;s:2:\"35\";i:21;s:2:\"35\";i:22;s:2:\"36\";i:23;s:2:\"36\";i:24;s:2:\"26\";i:25;s:2:\"44\";i:26;s:2:\"45\";i:27;s:2:\"50\";i:28;s:2:\"51\";i:29;s:2:\"52\";i:30;s:2:\"45\";i:31;s:2:\"46\";i:32;s:2:\"47\";i:33;s:2:\"48\";i:34;s:2:\"49\";i:35;s:2:\"46\";i:36;s:2:\"27\";i:37;s:2:\"30\";i:38;s:2:\"31\";i:39;s:2:\"32\";i:40;s:2:\"27\";i:41;s:2:\"28\";i:42;s:2:\"29\";i:43;s:2:\"28\";}}', '172.21.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/101.0.4951.41 Safari/537.36 Edg/101.0.1210.32', 'windows', 'Chrome/101.0.4951.41', '1651568613');
INSERT INTO `d_system_log_202205` VALUES ('36', '1', '/admin/AuthGroup/del.html?id=4', 'post', '超级管理员', 'a:2:{s:2:\"id\";s:1:\"4\";s:3:\"ids\";s:1:\"4\";}', '172.21.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/101.0.4951.41 Safari/537.36 Edg/101.0.1210.32', 'windows', 'Chrome/101.0.4951.41', '1651568627');
INSERT INTO `d_system_log_202205` VALUES ('37', '1', '/admin/AuthRule/index.html', 'post', '超级管理员', 'a:1:{s:5:\"title\";s:0:\"\";}', '172.21.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/101.0.4951.41 Safari/537.36 Edg/101.0.1210.32', 'windows', 'Chrome/101.0.4951.41', '1651595611');
INSERT INTO `d_system_log_202205` VALUES ('38', '1', '/admin/AuthRule/upAndAdd.html', 'post', '超级管理员', 'a:11:{s:3:\"pid\";s:1:\"0\";s:11:\"font_family\";s:2:\"fa\";s:9:\"__token__\";s:32:\"032e6c39c598d7da3161f8b3062eb8fb\";s:4:\"type\";s:1:\"1\";s:5:\"title\";s:12:\"页面设置\";s:9:\"auth_open\";s:1:\"1\";s:6:\"status\";s:1:\"1\";s:4:\"name\";s:17:\"PageSetting/index\";s:4:\"sort\";s:2:\"10\";s:4:\"icon\";s:0:\"\";s:5:\"param\";s:0:\"\";}', '172.21.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/101.0.4951.41 Safari/537.36 Edg/101.0.1210.32', 'windows', 'Chrome/101.0.4951.41', '1651595689');
INSERT INTO `d_system_log_202205` VALUES ('39', '1', '/admin/AuthRule/index.html', 'post', '超级管理员', 'a:1:{s:5:\"title\";s:0:\"\";}', '172.21.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/101.0.4951.41 Safari/537.36 Edg/101.0.1210.32', 'windows', 'Chrome/101.0.4951.41', '1651595692');
INSERT INTO `d_system_log_202205` VALUES ('40', '1', '/admin/AuthRule/upAndAdd.html', 'post', '超级管理员', 'a:11:{s:3:\"pid\";s:2:\"83\";s:11:\"font_family\";s:2:\"fa\";s:9:\"__token__\";s:32:\"041efcddec40420e5ec8621cb50ba636\";s:4:\"type\";s:1:\"1\";s:5:\"title\";s:18:\"跳转页面设置\";s:9:\"auth_open\";s:1:\"1\";s:6:\"status\";s:1:\"1\";s:4:\"name\";s:17:\"PageSetting/index\";s:4:\"sort\";s:2:\"10\";s:4:\"icon\";s:0:\"\";s:5:\"param\";s:0:\"\";}', '172.21.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/101.0.4951.41 Safari/537.36 Edg/101.0.1210.32', 'windows', 'Chrome/101.0.4951.41', '1651595736');
INSERT INTO `d_system_log_202205` VALUES ('41', '1', '/admin/AuthRule/index.html', 'post', '超级管理员', 'a:1:{s:5:\"title\";s:0:\"\";}', '172.21.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/101.0.4951.41 Safari/537.36 Edg/101.0.1210.32', 'windows', 'Chrome/101.0.4951.41', '1651595742');
INSERT INTO `d_system_log_202205` VALUES ('42', '1', '/admin/index/clearCache', 'post', '超级管理员', 'a:0:{}', '172.21.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/101.0.4951.41 Safari/537.36 Edg/101.0.1210.32', 'windows', 'Chrome/101.0.4951.41', '1651595794');
INSERT INTO `d_system_log_202205` VALUES ('43', '1', '/admin/login/loginCheck.html', 'post', '超级管理员', 'a:2:{s:8:\"username\";s:5:\"admin\";s:9:\"__token__\";s:32:\"b462d19d593e1b5c3baa7f988175e6bd\";}', '172.21.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/101.0.4951.41 Safari/537.36 Edg/101.0.1210.32', 'windows', 'Chrome/101.0.4951.41', '1651595936');
INSERT INTO `d_system_log_202205` VALUES ('44', '1', '/admin/login/loginCheck.html', 'post', '超级管理员', 'a:2:{s:8:\"username\";s:5:\"admin\";s:9:\"__token__\";s:32:\"b462d19d593e1b5c3baa7f988175e6bd\";}', '172.21.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/101.0.4951.41 Safari/537.36 Edg/101.0.1210.32', 'windows', 'Chrome/101.0.4951.41', '1651595936');
INSERT INTO `d_system_log_202205` VALUES ('45', '1', '/admin/index/clearCache', 'post', '超级管理员', 'a:0:{}', '172.21.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/101.0.4951.41 Safari/537.36 Edg/101.0.1210.32', 'windows', 'Chrome/101.0.4951.41', '1651596839');
INSERT INTO `d_system_log_202205` VALUES ('46', '1', '/admin/PageSetting/upAndAdd.html', 'post', '超级管理员', 'a:3:{s:9:\"__token__\";s:32:\"d9ee7ea12b1128a51109ed2bb7e0b5e0\";s:8:\"page_num\";s:1:\"2\";s:8:\"jump_url\";s:37:\"https://wa.me/+447448001002?text=Rich\";}', '172.21.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/101.0.4951.41 Safari/537.36 Edg/101.0.1210.32', 'windows', 'Chrome/101.0.4951.41', '1651597372');
INSERT INTO `d_system_log_202205` VALUES ('47', '1', '/admin/PageSetting/upAndAdd.html', 'post', '超级管理员', 'a:3:{s:9:\"__token__\";s:32:\"d9ee7ea12b1128a51109ed2bb7e0b5e0\";s:8:\"page_num\";s:1:\"2\";s:8:\"jump_url\";s:37:\"https://wa.me/+447448001002?text=Rich\";}', '172.21.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/101.0.4951.41 Safari/537.36 Edg/101.0.1210.32', 'windows', 'Chrome/101.0.4951.41', '1651597379');
INSERT INTO `d_system_log_202205` VALUES ('48', '1', '/admin/PageSetting/upAndAdd.html', 'post', '超级管理员', 'a:3:{s:9:\"__token__\";s:32:\"d9ee7ea12b1128a51109ed2bb7e0b5e0\";s:8:\"page_num\";s:1:\"2\";s:8:\"jump_url\";s:37:\"https://wa.me/+447448001002?text=Rich\";}', '172.21.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/101.0.4951.41 Safari/537.36 Edg/101.0.1210.32', 'windows', 'Chrome/101.0.4951.41', '1651597546');
INSERT INTO `d_system_log_202205` VALUES ('49', '1', '/admin/PageSetting/upAndAdd.html', 'post', '超级管理员', 'a:3:{s:9:\"__token__\";s:32:\"9355152fcea0cc72f3b924290f8c5367\";s:8:\"page_num\";s:1:\"2\";s:8:\"jump_url\";s:37:\"https://wa.me/+447448001002?text=Rich\";}', '172.21.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/101.0.4951.41 Safari/537.36 Edg/101.0.1210.32', 'windows', 'Chrome/101.0.4951.41', '1651597646');
INSERT INTO `d_system_log_202205` VALUES ('50', '1', '/admin/PageSetting/upAndAdd.html', 'post', '超级管理员', 'a:3:{s:9:\"__token__\";s:32:\"9355152fcea0cc72f3b924290f8c5367\";s:8:\"page_num\";s:1:\"2\";s:8:\"jump_url\";s:37:\"https://wa.me/+447448001002?text=Rich\";}', '172.21.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/101.0.4951.41 Safari/537.36 Edg/101.0.1210.32', 'windows', 'Chrome/101.0.4951.41', '1651597658');
INSERT INTO `d_system_log_202205` VALUES ('51', '1', '/admin/PageSetting/upAndAdd.html', 'post', '超级管理员', 'a:3:{s:9:\"__token__\";s:32:\"9355152fcea0cc72f3b924290f8c5367\";s:8:\"page_num\";s:1:\"2\";s:8:\"jump_url\";s:37:\"https://wa.me/+447448001002?text=Rich\";}', '172.21.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/101.0.4951.41 Safari/537.36 Edg/101.0.1210.32', 'windows', 'Chrome/101.0.4951.41', '1651597854');
INSERT INTO `d_system_log_202205` VALUES ('52', '1', '/admin/PageSetting/upAndAdd.html', 'post', '超级管理员', 'a:4:{s:9:\"__token__\";s:32:\"3883ea8cf2d1717e80ad7bcdaa429ad5\";s:2:\"id\";s:1:\"2\";s:8:\"page_num\";s:1:\"2\";s:8:\"jump_url\";s:37:\"https://wa.me/+447448001002?text=Rich\";}', '172.21.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/101.0.4951.41 Safari/537.36 Edg/101.0.1210.32', 'windows', 'Chrome/101.0.4951.41', '1651598066');
INSERT INTO `d_system_log_202205` VALUES ('53', '1', '/admin/PageSetting/upAndAdd.html', 'post', '超级管理员', 'a:4:{s:9:\"__token__\";s:32:\"a68c4141b283ee42e086c024c9686296\";s:2:\"id\";s:1:\"2\";s:8:\"page_num\";s:1:\"3\";s:8:\"jump_url\";s:37:\"https://wa.me/+447448001002?text=Rich\";}', '172.21.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/101.0.4951.41 Safari/537.36 Edg/101.0.1210.32', 'windows', 'Chrome/101.0.4951.41', '1651598207');
INSERT INTO `d_system_log_202205` VALUES ('54', '1', '/admin/PageSetting/upAndAdd.html', 'post', '超级管理员', 'a:4:{s:9:\"__token__\";s:32:\"10a8e95ab11d36a144b9cc0e5dc9cb6b\";s:2:\"id\";s:1:\"1\";s:8:\"page_num\";s:1:\"3\";s:8:\"jump_url\";s:37:\"https://wa.me/+447448001002?text=Rich\";}', '172.21.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/101.0.4951.41 Safari/537.36 Edg/101.0.1210.32', 'windows', 'Chrome/101.0.4951.41', '1651598606');
INSERT INTO `d_system_log_202205` VALUES ('55', '1', '/admin/PageSetting/upAndAdd.html', 'post', '超级管理员', 'a:4:{s:9:\"__token__\";s:32:\"10a8e95ab11d36a144b9cc0e5dc9cb6b\";s:2:\"id\";s:1:\"1\";s:8:\"page_num\";s:1:\"1\";s:8:\"jump_url\";s:37:\"https://wa.me/+447448001002?text=Rich\";}', '172.21.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/101.0.4951.41 Safari/537.36 Edg/101.0.1210.32', 'windows', 'Chrome/101.0.4951.41', '1651598613');
INSERT INTO `d_system_log_202205` VALUES ('56', '1', '/admin/PageSetting/upAndAdd.html', 'post', '超级管理员', 'a:4:{s:9:\"__token__\";s:32:\"10a8e95ab11d36a144b9cc0e5dc9cb6b\";s:2:\"id\";s:1:\"1\";s:8:\"page_num\";s:1:\"1\";s:8:\"jump_url\";s:37:\"https://wa.me/+447448001002?text=Rich\";}', '172.21.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/101.0.4951.41 Safari/537.36 Edg/101.0.1210.32', 'windows', 'Chrome/101.0.4951.41', '1651598704');
INSERT INTO `d_system_log_202205` VALUES ('57', '1', '/admin/AuthRule/index.html', 'post', '超级管理员', 'a:1:{s:5:\"title\";s:0:\"\";}', '172.21.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/101.0.4951.41 Safari/537.36 Edg/101.0.1210.32', 'windows', 'Chrome/101.0.4951.41', '1651598817');
INSERT INTO `d_system_log_202205` VALUES ('58', '1', '/admin/AuthRule/upAndAdd.html', 'post', '超级管理员', 'a:11:{s:3:\"pid\";s:2:\"83\";s:11:\"font_family\";s:2:\"fa\";s:9:\"__token__\";s:32:\"d292ed5768929e5eaa03beb33ea305b2\";s:4:\"type\";s:1:\"1\";s:5:\"title\";s:18:\"页面邮箱收集\";s:9:\"auth_open\";s:1:\"1\";s:6:\"status\";s:1:\"1\";s:4:\"name\";s:15:\"PageEmail/index\";s:4:\"sort\";s:2:\"10\";s:4:\"icon\";s:11:\"fa-envelope\";s:5:\"param\";s:0:\"\";}', '172.21.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/101.0.4951.41 Safari/537.36 Edg/101.0.1210.32', 'windows', 'Chrome/101.0.4951.41', '1651598941');
INSERT INTO `d_system_log_202205` VALUES ('59', '1', '/admin/AuthRule/index.html', 'post', '超级管理员', 'a:1:{s:5:\"title\";s:0:\"\";}', '172.21.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/101.0.4951.41 Safari/537.36 Edg/101.0.1210.32', 'windows', 'Chrome/101.0.4951.41', '1651598945');
INSERT INTO `d_system_log_202205` VALUES ('60', '1', '/admin/index/clearCache', 'post', '超级管理员', 'a:0:{}', '172.21.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/101.0.4951.41 Safari/537.36 Edg/101.0.1210.32', 'windows', 'Chrome/101.0.4951.41', '1651598961');
INSERT INTO `d_system_log_202205` VALUES ('61', '1', '/admin/AuthRule/index.html', 'post', '超级管理员', 'a:1:{s:5:\"title\";s:0:\"\";}', '172.21.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/101.0.4951.41 Safari/537.36 Edg/101.0.1210.32', 'windows', 'Chrome/101.0.4951.41', '1651599254');
INSERT INTO `d_system_log_202205` VALUES ('62', '1', '/admin/AuthRule/upAndAdd.html', 'post', '超级管理员', 'a:12:{s:3:\"pid\";s:2:\"83\";s:11:\"font_family\";s:2:\"fa\";s:9:\"__token__\";s:32:\"0c32f91f7f1455930d016c8b647ca76c\";s:4:\"type\";s:1:\"1\";s:2:\"id\";s:2:\"84\";s:5:\"title\";s:18:\"跳转页面设置\";s:9:\"auth_open\";s:1:\"1\";s:6:\"status\";s:1:\"1\";s:4:\"name\";s:17:\"PageSetting/index\";s:4:\"sort\";s:2:\"10\";s:4:\"icon\";s:14:\"fa-paper-plane\";s:5:\"param\";s:0:\"\";}', '172.21.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/101.0.4951.41 Safari/537.36 Edg/101.0.1210.32', 'windows', 'Chrome/101.0.4951.41', '1651599594');
INSERT INTO `d_system_log_202205` VALUES ('63', '1', '/admin/AuthRule/index.html', 'post', '超级管理员', 'a:1:{s:5:\"title\";s:0:\"\";}', '172.21.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/101.0.4951.41 Safari/537.36 Edg/101.0.1210.32', 'windows', 'Chrome/101.0.4951.41', '1651599599');
INSERT INTO `d_system_log_202205` VALUES ('64', '1', '/admin/index/clearCache', 'post', '超级管理员', 'a:0:{}', '172.21.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/101.0.4951.41 Safari/537.36 Edg/101.0.1210.32', 'windows', 'Chrome/101.0.4951.41', '1651599608');
INSERT INTO `d_system_log_202205` VALUES ('65', '1', '/admin/AuthRule/index.html', 'post', '超级管理员', 'a:1:{s:5:\"title\";s:0:\"\";}', '172.21.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/101.0.4951.41 Safari/537.36 Edg/101.0.1210.32', 'windows', 'Chrome/101.0.4951.41', '1651599626');
INSERT INTO `d_system_log_202205` VALUES ('66', '1', '/admin/AuthRule/upAndAdd.html', 'post', '超级管理员', 'a:12:{s:3:\"pid\";s:1:\"0\";s:11:\"font_family\";s:2:\"fa\";s:9:\"__token__\";s:32:\"bd7e01f50683796cda40a97427648bb2\";s:4:\"type\";s:1:\"1\";s:2:\"id\";s:2:\"83\";s:5:\"title\";s:12:\"页面设置\";s:9:\"auth_open\";s:1:\"1\";s:6:\"status\";s:1:\"1\";s:4:\"name\";s:0:\"\";s:4:\"sort\";s:2:\"10\";s:4:\"icon\";s:7:\"fa-tags\";s:5:\"param\";s:0:\"\";}', '172.21.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/101.0.4951.41 Safari/537.36 Edg/101.0.1210.32', 'windows', 'Chrome/101.0.4951.41', '1651599707');
INSERT INTO `d_system_log_202205` VALUES ('67', '1', '/admin/AuthRule/index.html', 'post', '超级管理员', 'a:1:{s:5:\"title\";s:0:\"\";}', '172.21.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/101.0.4951.41 Safari/537.36 Edg/101.0.1210.32', 'windows', 'Chrome/101.0.4951.41', '1651599711');
INSERT INTO `d_system_log_202205` VALUES ('68', '1', '/admin/index/clearCache', 'post', '超级管理员', 'a:0:{}', '172.21.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/101.0.4951.41 Safari/537.36 Edg/101.0.1210.32', 'windows', 'Chrome/101.0.4951.41', '1651600402');
INSERT INTO `d_system_log_202205` VALUES ('69', '1', '/admin/DataBackup/export.html', 'post', '超级管理员', 'a:1:{s:6:\"tables\";a:13:{i:0;s:7:\"d_admin\";i:1;s:12:\"d_attachment\";i:2;s:12:\"d_auth_group\";i:3;s:19:\"d_auth_group_access\";i:4;s:11:\"d_auth_rule\";i:5;s:10:\"d_commands\";i:6;s:13:\"d_friendlinks\";i:7;s:20:\"d_page_email_collect\";i:8;s:14:\"d_page_setting\";i:9;s:12:\"d_sys_config\";i:10;s:16:\"d_sys_config_tab\";i:11;s:13:\"d_sys_version\";i:12;s:19:\"d_system_log_202205\";}}', '172.21.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/101.0.4951.41 Safari/537.36 Edg/101.0.1210.32', 'windows', 'Chrome/101.0.4951.41', '1651606884');
INSERT INTO `d_system_log_202205` VALUES ('70', '1', '/admin/index/clearCache', 'post', '超级管理员', 'a:0:{}', '172.21.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/101.0.4951.41 Safari/537.36 Edg/101.0.1210.32', 'windows', 'Chrome/101.0.4951.41', '1651609420');
INSERT INTO `d_system_log_202205` VALUES ('71', '0', '/admin/login/logout', 'post', '', 'a:0:{}', '172.21.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/101.0.4951.41 Safari/537.36 Edg/101.0.1210.32', 'windows', 'Chrome/101.0.4951.41', '1651609684');
INSERT INTO `d_system_log_202205` VALUES ('72', '1', '/admin/login/loginCheck.html', 'post', '超级管理员', 'a:2:{s:8:\"username\";s:5:\"admin\";s:9:\"__token__\";s:32:\"8a1ed534f7749268eee8ca0b40fe5cf7\";}', '172.21.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/101.0.4951.41 Safari/537.36 Edg/101.0.1210.32', 'windows', 'Chrome/101.0.4951.41', '1651609695');
INSERT INTO `d_system_log_202205` VALUES ('73', '1', '/admin/PageSetting/upAndAdd.html', 'post', '超级管理员', 'a:3:{s:9:\"__token__\";s:32:\"dd1cb862b9199aa4c25ecf9a36a10dd3\";s:8:\"page_num\";s:3:\"abc\";s:8:\"jump_url\";s:37:\"https://wa.me/+447448001002?text=Rich\";}', '172.21.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/101.0.4951.41 Safari/537.36 Edg/101.0.1210.32', 'windows', 'Chrome/101.0.4951.41', '1651635866');
INSERT INTO `d_system_log_202205` VALUES ('74', '1', '/admin/PageSetting/upAndAdd.html', 'post', '超级管理员', 'a:3:{s:9:\"__token__\";s:32:\"dd1cb862b9199aa4c25ecf9a36a10dd3\";s:8:\"page_num\";s:3:\"abc\";s:8:\"jump_url\";s:37:\"https://wa.me/+447448001002?text=Rich\";}', '172.21.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/101.0.4951.41 Safari/537.36 Edg/101.0.1210.32', 'windows', 'Chrome/101.0.4951.41', '1651635871');
INSERT INTO `d_system_log_202205` VALUES ('75', '1', '/admin/PageSetting/upAndAdd.html', 'post', '超级管理员', 'a:3:{s:9:\"__token__\";s:32:\"dd1cb862b9199aa4c25ecf9a36a10dd3\";s:8:\"page_num\";s:3:\"abc\";s:8:\"jump_url\";s:37:\"https://wa.me/+447448001002?text=Rich\";}', '172.21.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/101.0.4951.41 Safari/537.36 Edg/101.0.1210.32', 'windows', 'Chrome/101.0.4951.41', '1651635875');
INSERT INTO `d_system_log_202205` VALUES ('76', '1', '/admin/PageSetting/upAndAdd.html', 'post', '超级管理员', 'a:3:{s:9:\"__token__\";s:32:\"dd1cb862b9199aa4c25ecf9a36a10dd3\";s:8:\"page_num\";s:1:\"5\";s:8:\"jump_url\";s:37:\"https://wa.me/+447448001002?text=Rich\";}', '172.21.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/101.0.4951.41 Safari/537.36 Edg/101.0.1210.32', 'windows', 'Chrome/101.0.4951.41', '1651635975');
INSERT INTO `d_system_log_202205` VALUES ('77', '1', '/admin/index/clearCache', 'post', '超级管理员', 'a:0:{}', '172.21.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/101.0.4951.41 Safari/537.36 Edg/101.0.1210.32', 'windows', 'Chrome/101.0.4951.41', '1651636133');
INSERT INTO `d_system_log_202205` VALUES ('78', '1', '/admin/PageSetting/upAndAdd.html', 'post', '超级管理员', 'a:3:{s:9:\"__token__\";s:32:\"c37bc0566529030acb1b3f37465bdfa2\";s:8:\"page_num\";s:1:\"5\";s:8:\"jump_url\";s:4:\"1111\";}', '172.21.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/101.0.4951.41 Safari/537.36 Edg/101.0.1210.32', 'windows', 'Chrome/101.0.4951.41', '1651636207');
INSERT INTO `d_system_log_202205` VALUES ('79', '1', '/admin/PageSetting/upAndAdd.html', 'post', '超级管理员', 'a:3:{s:9:\"__token__\";s:32:\"c37bc0566529030acb1b3f37465bdfa2\";s:8:\"page_num\";s:1:\"5\";s:8:\"jump_url\";s:4:\"1111\";}', '172.21.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/101.0.4951.41 Safari/537.36 Edg/101.0.1210.32', 'windows', 'Chrome/101.0.4951.41', '1651636301');
INSERT INTO `d_system_log_202205` VALUES ('80', '1', '/admin/PageSetting/upAndAdd.html', 'post', '超级管理员', 'a:4:{s:9:\"__token__\";s:32:\"67c3618d0b011d551a55ef0ab7a16a7a\";s:2:\"id\";s:1:\"3\";s:8:\"page_num\";s:1:\"5\";s:8:\"jump_url\";s:37:\"https://wa.me/+447448001002?text=Rich\";}', '172.21.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/101.0.4951.41 Safari/537.36 Edg/101.0.1210.32', 'windows', 'Chrome/101.0.4951.41', '1651636328');
INSERT INTO `d_system_log_202205` VALUES ('81', '1', '/admin/PageSetting/upAndAdd.html', 'post', '超级管理员', 'a:4:{s:9:\"__token__\";s:32:\"a4088511dc79cefb742595f6033cc821\";s:2:\"id\";s:1:\"3\";s:8:\"page_num\";s:3:\"abc\";s:8:\"jump_url\";s:37:\"https://wa.me/+447448001002?text=Rich\";}', '172.21.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/101.0.4951.41 Safari/537.36 Edg/101.0.1210.32', 'windows', 'Chrome/101.0.4951.41', '1651636342');
INSERT INTO `d_system_log_202205` VALUES ('82', '1', '/admin/DataBackup/export.html', 'post', '超级管理员', 'a:1:{s:6:\"tables\";a:13:{i:0;s:7:\"d_admin\";i:1;s:12:\"d_attachment\";i:2;s:12:\"d_auth_group\";i:3;s:19:\"d_auth_group_access\";i:4;s:11:\"d_auth_rule\";i:5;s:10:\"d_commands\";i:6;s:13:\"d_friendlinks\";i:7;s:20:\"d_page_email_collect\";i:8;s:14:\"d_page_setting\";i:9;s:12:\"d_sys_config\";i:10;s:16:\"d_sys_config_tab\";i:11;s:13:\"d_sys_version\";i:12;s:19:\"d_system_log_202205\";}}', '172.21.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/101.0.4951.41 Safari/537.36 Edg/101.0.1210.32', 'windows', 'Chrome/101.0.4951.41', '1651637552');
INSERT INTO `d_system_log_202205` VALUES ('83', '1', '/admin/AuthRule/index.html', 'post', '超级管理员', 'a:1:{s:5:\"title\";s:0:\"\";}', '172.21.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/101.0.4951.41 Safari/537.36 Edg/101.0.1210.32', 'windows', 'Chrome/101.0.4951.41', '1651637741');
INSERT INTO `d_system_log_202205` VALUES ('84', '1', '/admin/AuthRule/index.html', 'post', '超级管理员', 'a:1:{s:5:\"title\";s:0:\"\";}', '172.21.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/101.0.4951.41 Safari/537.36 Edg/101.0.1210.32', 'windows', 'Chrome/101.0.4951.41', '1651637763');
INSERT INTO `d_system_log_202205` VALUES ('85', '1', '/admin/AuthRule/addNode.html', 'post', '超级管理员', 'a:6:{s:3:\"pid\";s:2:\"84\";s:9:\"__token__\";s:32:\"cb40049e5f7ec5b910fd6d7dd3cc1838\";s:5:\"title\";a:1:{i:0;s:18:\"跳转页面删除\";}s:4:\"name\";a:1:{i:0;s:15:\"PageSetting/del\";}s:9:\"auth_open\";s:1:\"1\";s:6:\"status\";s:1:\"1\";}', '172.21.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/101.0.4951.41 Safari/537.36 Edg/101.0.1210.32', 'windows', 'Chrome/101.0.4951.41', '1651637840');
INSERT INTO `d_system_log_202205` VALUES ('86', '1', '/admin/AuthRule/index.html', 'post', '超级管理员', 'a:1:{s:5:\"title\";s:0:\"\";}', '172.21.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/101.0.4951.41 Safari/537.36 Edg/101.0.1210.32', 'windows', 'Chrome/101.0.4951.41', '1651637843');
INSERT INTO `d_system_log_202205` VALUES ('87', '1', '/admin/AuthRule/addNode.html', 'post', '超级管理员', 'a:6:{s:3:\"pid\";s:2:\"84\";s:9:\"__token__\";s:32:\"14095579bce514b5b123319c3c66440a\";s:5:\"title\";a:1:{i:0;s:18:\"跳转页面添加\";}s:4:\"name\";a:1:{i:0;s:15:\"PageSetting/add\";}s:9:\"auth_open\";s:1:\"1\";s:6:\"status\";s:1:\"1\";}', '172.21.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/101.0.4951.41 Safari/537.36 Edg/101.0.1210.32', 'windows', 'Chrome/101.0.4951.41', '1651637901');
INSERT INTO `d_system_log_202205` VALUES ('88', '1', '/admin/AuthRule/index.html', 'post', '超级管理员', 'a:1:{s:5:\"title\";s:0:\"\";}', '172.21.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/101.0.4951.41 Safari/537.36 Edg/101.0.1210.32', 'windows', 'Chrome/101.0.4951.41', '1651637906');
INSERT INTO `d_system_log_202205` VALUES ('89', '1', '/admin/AuthRule/addNode.html', 'post', '超级管理员', 'a:6:{s:3:\"pid\";s:2:\"84\";s:9:\"__token__\";s:32:\"9ad0611f05c08993ec84a18590946d45\";s:5:\"title\";a:1:{i:0;s:18:\"跳转页面编辑\";}s:4:\"name\";a:1:{i:0;s:16:\"PageSetting/edit\";}s:9:\"auth_open\";s:1:\"1\";s:6:\"status\";s:1:\"1\";}', '172.21.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/101.0.4951.41 Safari/537.36 Edg/101.0.1210.32', 'windows', 'Chrome/101.0.4951.41', '1651637943');
INSERT INTO `d_system_log_202205` VALUES ('90', '1', '/admin/AuthRule/index.html', 'post', '超级管理员', 'a:1:{s:5:\"title\";s:0:\"\";}', '172.21.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/101.0.4951.41 Safari/537.36 Edg/101.0.1210.32', 'windows', 'Chrome/101.0.4951.41', '1651637947');
INSERT INTO `d_system_log_202205` VALUES ('91', '1', '/admin/AuthRule/addNode.html', 'post', '超级管理员', 'a:6:{s:3:\"pid\";s:2:\"85\";s:9:\"__token__\";s:32:\"2cd0395873ac7b3ca45502cffef5dbd5\";s:5:\"title\";a:1:{i:0;s:6:\"删除\";}s:4:\"name\";a:1:{i:0;s:13:\"PageEmail/del\";}s:9:\"auth_open\";s:1:\"1\";s:6:\"status\";s:1:\"1\";}', '172.21.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/101.0.4951.41 Safari/537.36 Edg/101.0.1210.32', 'windows', 'Chrome/101.0.4951.41', '1651637996');
INSERT INTO `d_system_log_202205` VALUES ('92', '1', '/admin/AuthRule/index.html', 'post', '超级管理员', 'a:1:{s:5:\"title\";s:0:\"\";}', '172.21.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/101.0.4951.41 Safari/537.36 Edg/101.0.1210.32', 'windows', 'Chrome/101.0.4951.41', '1651637999');
INSERT INTO `d_system_log_202205` VALUES ('93', '1', '/admin/Admin/addAdmin.html', 'post', '超级管理员', 'a:9:{s:6:\"avatar\";s:0:\"\";s:8:\"username\";s:5:\"simon\";s:8:\"nickname\";s:12:\"西门吹雪\";s:5:\"phone\";s:0:\"\";s:5:\"email\";s:0:\"\";s:8:\"birthday\";s:0:\"\";s:3:\"sex\";s:1:\"2\";s:6:\"status\";s:1:\"1\";s:9:\"__token__\";s:32:\"275351663fc636ab8fdbcf8911540b7c\";}', '172.21.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/101.0.4951.41 Safari/537.36 Edg/101.0.1210.32', 'windows', 'Chrome/101.0.4951.41', '1651638426');
INSERT INTO `d_system_log_202205` VALUES ('94', '1', '/admin/AuthGroup/getRoles.html', 'post', '超级管理员', 'a:1:{s:2:\"id\";s:1:\"0\";}', '172.21.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/101.0.4951.41 Safari/537.36 Edg/101.0.1210.32', 'windows', 'Chrome/101.0.4951.41', '1651638620');
INSERT INTO `d_system_log_202205` VALUES ('95', '1', '/admin/AuthGroup/upAndAdd.html', 'post', '超级管理员', 'a:5:{s:3:\"pid\";s:1:\"0\";s:9:\"__token__\";s:32:\"46a1f98dcdf739b6a51528133c02e360\";s:5:\"title\";s:15:\"普通管理员\";s:6:\"status\";s:1:\"1\";s:4:\"rule\";a:9:{i:24;s:2:\"83\";i:25;s:2:\"84\";i:26;s:2:\"86\";i:27;s:2:\"87\";i:28;s:2:\"88\";i:29;s:2:\"84\";i:30;s:2:\"85\";i:31;s:2:\"89\";i:32;s:2:\"85\";}}', '172.21.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/101.0.4951.41 Safari/537.36 Edg/101.0.1210.32', 'windows', 'Chrome/101.0.4951.41', '1651638661');
INSERT INTO `d_system_log_202205` VALUES ('96', '1', '/admin/AuthGroup/userGroup.html', 'post', '超级管理员', 'a:2:{s:8:\"group_id\";s:1:\"5\";s:3:\"uid\";a:1:{i:1;s:1:\"6\";}}', '172.21.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/101.0.4951.41 Safari/537.36 Edg/101.0.1210.32', 'windows', 'Chrome/101.0.4951.41', '1651638696');
INSERT INTO `d_system_log_202205` VALUES ('97', '1', '/admin/AuthGroup/getRoles.html', 'post', '超级管理员', 'a:1:{s:2:\"id\";s:1:\"5\";}', '172.21.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/101.0.4951.41 Safari/537.36 Edg/101.0.1210.32', 'windows', 'Chrome/101.0.4951.41', '1651638707');
INSERT INTO `d_system_log_202205` VALUES ('98', '1', '/admin/AuthGroup/upAndAdd.html', 'post', '超级管理员', 'a:6:{s:3:\"pid\";s:1:\"0\";s:2:\"id\";s:1:\"5\";s:9:\"__token__\";s:32:\"e91a4c4371c2c402c77c75dcf7a69c3b\";s:5:\"title\";s:15:\"普通管理员\";s:6:\"status\";s:1:\"1\";s:4:\"rule\";a:15:{i:0;s:1:\"2\";i:19;s:2:\"34\";i:20;s:2:\"35\";i:21;s:2:\"35\";i:22;s:2:\"36\";i:23;s:2:\"36\";i:24;s:2:\"83\";i:25;s:2:\"84\";i:26;s:2:\"86\";i:27;s:2:\"87\";i:28;s:2:\"88\";i:29;s:2:\"84\";i:30;s:2:\"85\";i:31;s:2:\"89\";i:32;s:2:\"85\";}}', '172.21.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/101.0.4951.41 Safari/537.36 Edg/101.0.1210.32', 'windows', 'Chrome/101.0.4951.41', '1651638725');
INSERT INTO `d_system_log_202205` VALUES ('99', '6', '/admin/login/loginCheck.html', 'post', '西门吹雪', 'a:2:{s:8:\"username\";s:5:\"simon\";s:9:\"__token__\";s:32:\"e257366ccaf7403803b191f1db677412\";}', '172.21.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/100.0.4896.127 Safari/537.36', 'windows', 'Chrome/100.0.4896.127', '1651638813');
INSERT INTO `d_system_log_202205` VALUES ('100', '6', '/admin/PageSetting/upAndAdd.html', 'post', '西门吹雪', 'a:3:{s:9:\"__token__\";s:32:\"b7972e95cb0fc29e00eaa6e3e02269a0\";s:8:\"page_num\";s:3:\"asd\";s:8:\"jump_url\";s:37:\"https://wa.me/+447448001002?text=Rich\";}', '172.21.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/100.0.4896.127 Safari/537.36', 'windows', 'Chrome/100.0.4896.127', '1651638870');
INSERT INTO `d_system_log_202205` VALUES ('101', '6', '/admin/PageSetting/upAndAdd.html', 'post', '西门吹雪', 'a:3:{s:9:\"__token__\";s:32:\"b7972e95cb0fc29e00eaa6e3e02269a0\";s:8:\"page_num\";s:3:\"asd\";s:8:\"jump_url\";s:37:\"https://wa.me/+447448001002?text=Rich\";}', '172.21.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/100.0.4896.127 Safari/537.36', 'windows', 'Chrome/100.0.4896.127', '1651638877');
INSERT INTO `d_system_log_202205` VALUES ('102', '1', '/admin/PageSetting/upAndAdd.html', 'post', '超级管理员', 'a:3:{s:9:\"__token__\";s:32:\"0e1db02de1815e22c4271ada6276d001\";s:8:\"page_num\";s:3:\"123\";s:8:\"jump_url\";s:3:\"add\";}', '172.21.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/101.0.4951.41 Safari/537.36 Edg/101.0.1210.32', 'windows', 'Chrome/101.0.4951.41', '1651639109');
INSERT INTO `d_system_log_202205` VALUES ('103', '1', '/admin/AuthRule/index.html', 'post', '超级管理员', 'a:1:{s:5:\"title\";s:0:\"\";}', '172.21.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/101.0.4951.41 Safari/537.36 Edg/101.0.1210.32', 'windows', 'Chrome/101.0.4951.41', '1651639149');
INSERT INTO `d_system_log_202205` VALUES ('104', '1', '/admin/AuthRule/addNode.html', 'post', '超级管理员', 'a:6:{s:3:\"pid\";s:2:\"84\";s:9:\"__token__\";s:32:\"2ac5bbb737021d2fc91b2f0e42abf759\";s:5:\"title\";a:1:{i:0;s:15:\"添加和更新\";}s:4:\"name\";a:1:{i:0;s:20:\"PageSetting/upAndAdd\";}s:9:\"auth_open\";s:1:\"1\";s:6:\"status\";s:1:\"1\";}', '172.21.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/101.0.4951.41 Safari/537.36 Edg/101.0.1210.32', 'windows', 'Chrome/101.0.4951.41', '1651639198');
INSERT INTO `d_system_log_202205` VALUES ('105', '1', '/admin/AuthRule/index.html', 'post', '超级管理员', 'a:1:{s:5:\"title\";s:0:\"\";}', '172.21.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/101.0.4951.41 Safari/537.36 Edg/101.0.1210.32', 'windows', 'Chrome/101.0.4951.41', '1651639202');
INSERT INTO `d_system_log_202205` VALUES ('106', '1', '/admin/AuthGroup/getRoles.html', 'post', '超级管理员', 'a:1:{s:2:\"id\";s:1:\"5\";}', '172.21.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/101.0.4951.41 Safari/537.36 Edg/101.0.1210.32', 'windows', 'Chrome/101.0.4951.41', '1651639223');
INSERT INTO `d_system_log_202205` VALUES ('107', '1', '/admin/AuthGroup/upAndAdd.html', 'post', '超级管理员', 'a:6:{s:3:\"pid\";s:1:\"0\";s:2:\"id\";s:1:\"5\";s:9:\"__token__\";s:32:\"7f8d6b0c09582849ffd8719ea1f59682\";s:5:\"title\";s:15:\"普通管理员\";s:6:\"status\";s:1:\"1\";s:4:\"rule\";a:16:{i:0;s:1:\"2\";i:19;s:2:\"34\";i:20;s:2:\"35\";i:21;s:2:\"35\";i:22;s:2:\"36\";i:23;s:2:\"36\";i:24;s:2:\"83\";i:25;s:2:\"84\";i:26;s:2:\"86\";i:27;s:2:\"87\";i:28;s:2:\"88\";i:29;s:2:\"90\";i:30;s:2:\"84\";i:31;s:2:\"85\";i:32;s:2:\"89\";i:33;s:2:\"85\";}}', '172.21.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/101.0.4951.41 Safari/537.36 Edg/101.0.1210.32', 'windows', 'Chrome/101.0.4951.41', '1651639237');
INSERT INTO `d_system_log_202205` VALUES ('108', '6', '/admin/PageSetting/upAndAdd.html', 'post', '西门吹雪', 'a:3:{s:9:\"__token__\";s:32:\"b7972e95cb0fc29e00eaa6e3e02269a0\";s:8:\"page_num\";s:3:\"asd\";s:8:\"jump_url\";s:37:\"https://wa.me/+447448001002?text=Rich\";}', '172.21.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/100.0.4896.127 Safari/537.36', 'windows', 'Chrome/100.0.4896.127', '1651639254');
INSERT INTO `d_system_log_202205` VALUES ('109', '0', '/admin/login/logout', 'post', '', 'a:0:{}', '172.21.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/101.0.4951.41 Safari/537.36 Edg/101.0.1210.32', 'windows', 'Chrome/101.0.4951.41', '1651677939');
INSERT INTO `d_system_log_202205` VALUES ('110', '0', '/admin/login/logout', 'post', '', 'a:0:{}', '172.21.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/101.0.4951.41 Safari/537.36 Edg/101.0.1210.32', 'windows', 'Chrome/101.0.4951.41', '1651677949');
INSERT INTO `d_system_log_202205` VALUES ('111', '0', '/admin/login/logout', 'post', '', 'a:0:{}', '172.21.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/101.0.4951.41 Safari/537.36 Edg/101.0.1210.32', 'windows', 'Chrome/101.0.4951.41', '1651677984');
INSERT INTO `d_system_log_202205` VALUES ('112', '1', '/admin/login/loginCheck.html', 'post', '超级管理员', 'a:2:{s:8:\"username\";s:5:\"admin\";s:9:\"__token__\";s:32:\"41f6b95dfd60c37ae2d3f31dd81645ca\";}', '172.21.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/101.0.4951.41 Safari/537.36 Edg/101.0.1210.32', 'windows', 'Chrome/101.0.4951.41', '1651680672');
INSERT INTO `d_system_log_202205` VALUES ('113', '1', '/admin/DataBackup/export.html', 'post', '超级管理员', 'a:1:{s:6:\"tables\";a:13:{i:0;s:7:\"d_admin\";i:1;s:12:\"d_attachment\";i:2;s:12:\"d_auth_group\";i:3;s:19:\"d_auth_group_access\";i:4;s:11:\"d_auth_rule\";i:5;s:10:\"d_commands\";i:6;s:13:\"d_friendlinks\";i:7;s:20:\"d_page_email_collect\";i:8;s:14:\"d_page_setting\";i:9;s:12:\"d_sys_config\";i:10;s:16:\"d_sys_config_tab\";i:11;s:13:\"d_sys_version\";i:12;s:19:\"d_system_log_202205\";}}', '172.21.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/101.0.4951.41 Safari/537.36 Edg/101.0.1210.32', 'windows', 'Chrome/101.0.4951.41', '1651680690');
