/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50711
Source Host           : localhost:3306
Source Database       : gitee

Target Server Type    : MYSQL
Target Server Version : 50711
File Encoding         : 65001

Date: 2021-09-23 14:08:56
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `base_table`
-- ----------------------------
DROP TABLE IF EXISTS `base_table`;
CREATE TABLE `base_table` (
  `id` varchar(50) NOT NULL COMMENT '主键ID',
  `sort` int(4) NOT NULL COMMENT '排序',
  `status` char(1) NOT NULL DEFAULT '0' COMMENT '状态（0正常 1 停用）',
  `create_by` varchar(64) DEFAULT NULL COMMENT '创建者',
  `create_dept` varchar(64) DEFAULT NULL COMMENT '创建部门',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT NULL COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `update_ip` varchar(50) DEFAULT NULL COMMENT '更新IP',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  `version` int(11) DEFAULT NULL COMMENT '版本',
  `del_flag` char(1) DEFAULT '0' COMMENT '删除标志（0存在 1删除）',
  `extend_s1` varchar(200) DEFAULT NULL COMMENT '备用字符串1',
  `extend_s2` varchar(200) DEFAULT NULL COMMENT '备用字符串2',
  `extend_s3` varchar(200) DEFAULT NULL COMMENT '备用字符串3',
  `extend_s4` varchar(200) DEFAULT NULL COMMENT '备用字符串4',
  `extend_i1` int(11) DEFAULT NULL COMMENT '备用整型1',
  `extend_i2` int(11) DEFAULT NULL COMMENT '备用整型2',
  `extend_i3` int(11) DEFAULT NULL COMMENT '备用整型3',
  `extend_i4` int(11) DEFAULT NULL COMMENT '备用整型4',
  `extend_d1` datetime DEFAULT NULL COMMENT '备用日期1',
  `extend_d2` datetime DEFAULT NULL COMMENT '备用日期2',
  `extend_d3` datetime DEFAULT NULL COMMENT '备用日期3',
  `extend_d4` datetime DEFAULT NULL COMMENT '备用日期3',
  `extend_f1` double(11,2) DEFAULT NULL COMMENT '备用浮点1',
  `extend_f2` double(11,2) DEFAULT NULL COMMENT '备用浮点2',
  `extend_f3` double(11,2) DEFAULT NULL COMMENT '备用浮点3',
  `extend_f4` double(11,2) DEFAULT NULL COMMENT '备用浮点4',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='基础表';

-- ----------------------------
-- Records of base_table
-- ----------------------------

-- ----------------------------
-- Table structure for `base_tree_table`
-- ----------------------------
DROP TABLE IF EXISTS `base_tree_table`;
CREATE TABLE `base_tree_table` (
  `id` varchar(32) NOT NULL COMMENT '部门id',
  `parent_id` varchar(32) DEFAULT '0' COMMENT '父id',
  `parent_ids` varchar(500) DEFAULT NULL COMMENT '父id集合',
  `tree_sort` int(11) DEFAULT '0' COMMENT '排序',
  `tree_sorts` varchar(500) DEFAULT NULL COMMENT '排序集合',
  `tree_level` int(11) DEFAULT NULL COMMENT '层级',
  `tree_leaf` char(1) DEFAULT NULL COMMENT '是否子节点（0是 1否）',
  `status` char(1) DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) DEFAULT NULL COMMENT '创建者',
  `create_dept` varchar(64) DEFAULT NULL COMMENT '创建部门',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT NULL COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `update_ip` varchar(64) DEFAULT NULL COMMENT '更新IP',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  `version` int(11) DEFAULT NULL COMMENT '版本',
  `del_flag` char(1) DEFAULT '0' COMMENT '删除标志（0代表存在 1代表删除）',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='树基础表';

-- ----------------------------
-- Records of base_tree_table
-- ----------------------------

-- ----------------------------
-- Table structure for `gen_config_template`
-- ----------------------------
DROP TABLE IF EXISTS `gen_config_template`;
CREATE TABLE `gen_config_template` (
  `id` varchar(50) NOT NULL COMMENT '主键ID',
  `template_name` varchar(50) NOT NULL COMMENT '模板名称',
  `function_author` varchar(100) NOT NULL COMMENT '作者',
  `function_author_email` varchar(100) NOT NULL COMMENT '邮箱',
  `workspace_path` varchar(200) DEFAULT NULL COMMENT '工作空间路径',
  `module_name` varchar(30) DEFAULT NULL COMMENT '模块名',
  `package_name` varchar(100) DEFAULT NULL COMMENT '模块包路径',
  `web_workspace_path` varchar(200) DEFAULT NULL COMMENT '前端工作空间路径',
  `template_default` varchar(10) NOT NULL COMMENT '是否默认',
  `sort` int(4) NOT NULL COMMENT '排序',
  `status` char(1) NOT NULL COMMENT '状态（0正常 1 停用）',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_dept` varchar(64) DEFAULT NULL COMMENT '创建部门',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `update_ip` varchar(50) DEFAULT NULL COMMENT '更新IP',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  `version` int(11) DEFAULT NULL COMMENT '版本',
  `del_flag` char(1) DEFAULT '0' COMMENT '删除标志（0代表存在 1代表删除）',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='模板配置表';

-- ----------------------------
-- Records of gen_config_template
-- ----------------------------

-- ----------------------------
-- Table structure for `gen_table`
-- ----------------------------
DROP TABLE IF EXISTS `gen_table`;
CREATE TABLE `gen_table` (
  `table_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `table_name` varchar(200) DEFAULT '' COMMENT '表名称',
  `table_comment` varchar(500) DEFAULT '' COMMENT '表描述',
  `sub_table_name` varchar(64) DEFAULT NULL COMMENT '关联子表的表名',
  `sub_table_fk_name` varchar(64) DEFAULT NULL COMMENT '子表关联的外键名',
  `class_name` varchar(100) DEFAULT '' COMMENT '实体类名称',
  `tpl_category` varchar(200) DEFAULT 'crud' COMMENT '使用的模板（crud单表操作 tree树表操作）',
  `workspace_path` varchar(200) DEFAULT NULL COMMENT '工作空间',
  `module_name` varchar(30) DEFAULT NULL COMMENT '模块名',
  `package_name` varchar(100) DEFAULT NULL COMMENT '包路径',
  `business_name` varchar(30) DEFAULT NULL COMMENT '业务名',
  `function_name` varchar(50) DEFAULT NULL COMMENT '功能名',
  `function_author` varchar(50) DEFAULT NULL COMMENT '作者',
  `function_author_email` varchar(200) DEFAULT NULL COMMENT '邮箱',
  `web_workspace_path` varchar(200) DEFAULT NULL COMMENT '前端工作空间路径',
  `gen_type` char(1) DEFAULT '0' COMMENT '生成代码方式（0zip压缩包 1自定义路径）',
  `options` varchar(4000) DEFAULT NULL,
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`table_id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8 COMMENT='代码生成业务表';

-- ----------------------------
-- Records of gen_table
-- ----------------------------
INSERT INTO `gen_table` VALUES ('17', 'gen_config_template', '模板配置表', null, null, 'GenConfigTemplate', 'crud', null, null, null, 'genConfigTemplate', '模板配置', null, null, null, '1', '{\"treeParentCode\":\"parentId\",\"disableEnableOption\":\"0\",\"attachOption\":\"0\",\"treeCode\":\"id\"}', 'admin', '2021-09-22 22:25:48', '', null, null);

-- ----------------------------
-- Table structure for `gen_table_column`
-- ----------------------------
DROP TABLE IF EXISTS `gen_table_column`;
CREATE TABLE `gen_table_column` (
  `column_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `table_id` varchar(64) DEFAULT NULL COMMENT '归属表编号',
  `column_name` varchar(200) DEFAULT NULL COMMENT '列名称',
  `column_comment` varchar(500) DEFAULT NULL COMMENT '列描述',
  `column_type` varchar(100) DEFAULT NULL COMMENT '列类型',
  `java_type` varchar(500) DEFAULT NULL COMMENT 'JAVA类型',
  `java_field` varchar(200) DEFAULT NULL COMMENT 'JAVA字段名',
  `is_pk` char(10) DEFAULT NULL COMMENT '是否主键（1是）',
  `is_increment` char(10) DEFAULT NULL COMMENT '是否自增（1是）',
  `is_required` char(10) DEFAULT NULL COMMENT '是否必填（1是）',
  `is_insert` char(10) DEFAULT NULL COMMENT '是否为插入字段（1是）',
  `is_edit` char(10) DEFAULT NULL COMMENT '是否编辑字段（1是）',
  `is_list` char(10) DEFAULT NULL COMMENT '是否列表字段（1是）',
  `is_query` char(10) DEFAULT NULL COMMENT '是否查询字段（1是）',
  `is_unique` char(10) DEFAULT NULL COMMENT '是否唯一性',
  `is_log` char(10) DEFAULT NULL COMMENT '是否记录日志',
  `is_new_row` char(10) DEFAULT NULL COMMENT '新行',
  `col_span` int(10) unsigned zerofill DEFAULT '0000000002' COMMENT '列数',
  `align_type` varchar(10) DEFAULT NULL COMMENT '对齐方式',
  `query_type` varchar(200) DEFAULT 'EQ' COMMENT '查询方式（等于、不等于、大于、小于、范围）',
  `html_type` varchar(200) DEFAULT NULL COMMENT '显示类型（文本框、文本域、下拉框、复选框、单选框、日期控件）',
  `dict_type` varchar(200) DEFAULT '' COMMENT '字典类型',
  `col_check` varchar(100) DEFAULT NULL COMMENT '字段校验',
  `sort` int(11) DEFAULT NULL COMMENT '排序',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`column_id`)
) ENGINE=InnoDB AUTO_INCREMENT=242 DEFAULT CHARSET=utf8 COMMENT='代码生成业务表字段';

-- ----------------------------
-- Records of gen_table_column
-- ----------------------------
INSERT INTO `gen_table_column` VALUES ('222', '17', 'template_name', '模板名称', 'varchar(50)', 'String', 'templateName', '0', '0', '1', '1', '1', '1', '1', null, null, null, '0000000002', 'left', 'LIKE', 'input', '', null, '0', 'admin', '2021-09-22 22:25:48', '', null);
INSERT INTO `gen_table_column` VALUES ('223', '17', 'function_author', '作者', 'varchar(100)', 'String', 'functionAuthor', '0', '0', '1', '1', '1', '1', '1', null, null, null, '0000000002', 'left', 'LIKE', 'input', '', null, '10', 'admin', '2021-09-22 22:25:48', '', null);
INSERT INTO `gen_table_column` VALUES ('224', '17', 'function_author_email', '邮箱', 'varchar(100)', 'String', 'functionAuthorEmail', '0', '0', '1', '1', '1', '1', '1', null, null, null, '0000000002', 'left', 'LIKE', 'input', '', null, '20', 'admin', '2021-09-22 22:25:48', '', null);
INSERT INTO `gen_table_column` VALUES ('225', '17', 'workspace_path', '工作空间路径', 'varchar(200)', 'String', 'workspacePath', '0', '0', null, '1', '1', '1', '1', null, null, null, '0000000002', 'left', 'LIKE', 'input', '', null, '30', 'admin', '2021-09-22 22:25:48', '', null);
INSERT INTO `gen_table_column` VALUES ('226', '17', 'module_name', '模块名', 'varchar(30)', 'String', 'moduleName', '0', '0', null, '1', '1', '1', null, null, null, null, '0000000002', 'left', 'EQ', 'input', '', null, '40', 'admin', '2021-09-22 22:25:48', '', null);
INSERT INTO `gen_table_column` VALUES ('227', '17', 'package_name', '模块包路径', 'varchar(100)', 'String', 'packageName', '0', '0', null, '1', '1', '1', null, null, null, null, '0000000002', 'left', 'EQ', 'input', '', null, '50', 'admin', '2021-09-22 22:25:48', '', null);
INSERT INTO `gen_table_column` VALUES ('228', '17', 'web_workspace_path', '前端工作空间路径', 'varchar(200)', 'String', 'webWorkspacePath', '0', '0', null, '1', '1', '1', null, null, null, null, '0000000002', 'left', 'EQ', 'input', '', null, '60', 'admin', '2021-09-22 22:25:48', '', null);
INSERT INTO `gen_table_column` VALUES ('229', '17', 'template_default', '是否默认', 'varchar(10)', 'String', 'templateDefault', '0', '0', '1', '1', '1', null, null, null, null, null, '0000000002', 'left', 'EQ', 'input', '', null, '70', 'admin', '2021-09-22 22:25:48', '', null);
INSERT INTO `gen_table_column` VALUES ('230', '17', 'sort', '排序', 'int(4)', 'Integer', 'sort', '0', '0', '1', '1', '1', null, null, null, null, null, '0000000002', 'right', 'EQ', 'number', '', null, '80', 'admin', '2021-09-22 22:25:48', '', null);
INSERT INTO `gen_table_column` VALUES ('231', '17', 'status', '状态（0正常 1 停用）', 'char(1)', 'String', 'status', '0', '0', '1', '1', '1', null, null, null, null, null, '0000000002', 'left', 'EQ', 'radio', '', null, '90', 'admin', '2021-09-22 22:25:48', '', null);
INSERT INTO `gen_table_column` VALUES ('232', '17', 'remark', '备注', 'varchar(500)', 'String', 'remark', '0', '0', null, '1', null, null, null, null, null, '1', '0000000002', 'left', 'EQ', 'textarea', '', null, '100', 'admin', '2021-09-22 22:25:48', '', null);
INSERT INTO `gen_table_column` VALUES ('233', '17', 'id', '主键ID', 'varchar(50)', 'String', 'id', '1', '0', '0', '0', '0', '0', '0', '0', '0', null, '0000000000', null, 'EQ', null, '', null, '110', 'admin', '2021-09-22 22:25:48', '', null);
INSERT INTO `gen_table_column` VALUES ('234', '17', 'create_by', '创建者', 'varchar(64)', 'String', 'createBy', '0', '0', '0', '0', '0', '0', '0', '0', '0', null, '0000000000', null, 'EQ', null, '', null, '120', 'admin', '2021-09-22 22:25:48', '', null);
INSERT INTO `gen_table_column` VALUES ('235', '17', 'create_dept', '创建部门', 'varchar(64)', 'String', 'createDept', '0', '0', '0', '0', '0', '0', '0', '0', '0', null, '0000000000', null, 'EQ', null, '', null, '130', 'admin', '2021-09-22 22:25:48', '', null);
INSERT INTO `gen_table_column` VALUES ('236', '17', 'create_time', '创建时间', 'datetime', 'Date', 'createTime', '0', '0', '0', '0', '0', '0', '0', '0', '0', null, '0000000000', null, 'EQ', null, '', null, '140', 'admin', '2021-09-22 22:25:48', '', null);
INSERT INTO `gen_table_column` VALUES ('237', '17', 'update_by', '更新者', 'varchar(64)', 'String', 'updateBy', '0', '0', '0', '0', '0', '0', '0', '0', '0', null, '0000000000', null, 'EQ', null, '', null, '150', 'admin', '2021-09-22 22:25:48', '', null);
INSERT INTO `gen_table_column` VALUES ('238', '17', 'update_time', '更新时间', 'datetime', 'Date', 'updateTime', '0', '0', '0', '0', '0', '0', '0', '0', '0', null, '0000000000', null, 'EQ', null, '', null, '160', 'admin', '2021-09-22 22:25:48', '', null);
INSERT INTO `gen_table_column` VALUES ('239', '17', 'update_ip', '更新IP', 'varchar(50)', 'String', 'updateIp', '0', '0', '0', '0', '0', '0', '0', '0', '0', null, '0000000000', null, 'EQ', null, '', null, '170', 'admin', '2021-09-22 22:25:48', '', null);
INSERT INTO `gen_table_column` VALUES ('240', '17', 'version', '版本', 'int(11)', 'Long', 'version', '0', '0', '0', '0', '0', '0', '0', '0', '0', null, '0000000000', null, 'EQ', null, '', null, '180', 'admin', '2021-09-22 22:25:48', '', null);
INSERT INTO `gen_table_column` VALUES ('241', '17', 'del_flag', '删除标志（0代表存在 1代表删除）', 'char(1)', 'String', 'delFlag', '0', '0', '0', '0', '0', '0', '0', '0', '0', null, '0000000000', null, 'EQ', null, '', null, '190', 'admin', '2021-09-22 22:25:48', '', null);

-- ----------------------------
-- Table structure for `qrtz_blob_triggers`
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_blob_triggers`;
CREATE TABLE `qrtz_blob_triggers` (
  `sched_name` varchar(120) NOT NULL,
  `trigger_name` varchar(200) NOT NULL,
  `trigger_group` varchar(200) NOT NULL,
  `blob_data` blob,
  PRIMARY KEY (`sched_name`,`trigger_name`,`trigger_group`),
  CONSTRAINT `qrtz_blob_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of qrtz_blob_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for `qrtz_calendars`
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_calendars`;
CREATE TABLE `qrtz_calendars` (
  `sched_name` varchar(120) NOT NULL,
  `calendar_name` varchar(200) NOT NULL,
  `calendar` blob NOT NULL,
  PRIMARY KEY (`sched_name`,`calendar_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of qrtz_calendars
-- ----------------------------

-- ----------------------------
-- Table structure for `qrtz_cron_triggers`
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_cron_triggers`;
CREATE TABLE `qrtz_cron_triggers` (
  `sched_name` varchar(120) NOT NULL,
  `trigger_name` varchar(200) NOT NULL,
  `trigger_group` varchar(200) NOT NULL,
  `cron_expression` varchar(200) NOT NULL,
  `time_zone_id` varchar(80) DEFAULT NULL,
  PRIMARY KEY (`sched_name`,`trigger_name`,`trigger_group`),
  CONSTRAINT `qrtz_cron_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of qrtz_cron_triggers
-- ----------------------------
INSERT INTO `qrtz_cron_triggers` VALUES ('RuoyiScheduler', 'TASK_CLASS_NAME1', 'DEFAULT', '0/10 * * * * ?', 'Asia/Shanghai');
INSERT INTO `qrtz_cron_triggers` VALUES ('RuoyiScheduler', 'TASK_CLASS_NAME2', 'DEFAULT', '0/15 * * * * ?', 'Asia/Shanghai');
INSERT INTO `qrtz_cron_triggers` VALUES ('RuoyiScheduler', 'TASK_CLASS_NAME3', 'DEFAULT', '0/20 * * * * ?', 'Asia/Shanghai');
INSERT INTO `qrtz_cron_triggers` VALUES ('RuoyiScheduler', 'TASK_CLASS_NAME4', 'DEFAULT', '0 0 1 * * ? *', 'Asia/Shanghai');

-- ----------------------------
-- Table structure for `qrtz_fired_triggers`
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_fired_triggers`;
CREATE TABLE `qrtz_fired_triggers` (
  `sched_name` varchar(120) NOT NULL,
  `entry_id` varchar(95) NOT NULL,
  `trigger_name` varchar(200) NOT NULL,
  `trigger_group` varchar(200) NOT NULL,
  `instance_name` varchar(200) NOT NULL,
  `fired_time` bigint(13) NOT NULL,
  `sched_time` bigint(13) NOT NULL,
  `priority` int(11) NOT NULL,
  `state` varchar(16) NOT NULL,
  `job_name` varchar(200) DEFAULT NULL,
  `job_group` varchar(200) DEFAULT NULL,
  `is_nonconcurrent` varchar(1) DEFAULT NULL,
  `requests_recovery` varchar(1) DEFAULT NULL,
  PRIMARY KEY (`sched_name`,`entry_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of qrtz_fired_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for `qrtz_job_details`
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_job_details`;
CREATE TABLE `qrtz_job_details` (
  `sched_name` varchar(120) NOT NULL,
  `job_name` varchar(200) NOT NULL,
  `job_group` varchar(200) NOT NULL,
  `description` varchar(250) DEFAULT NULL,
  `job_class_name` varchar(250) NOT NULL,
  `is_durable` varchar(1) NOT NULL,
  `is_nonconcurrent` varchar(1) NOT NULL,
  `is_update_data` varchar(1) NOT NULL,
  `requests_recovery` varchar(1) NOT NULL,
  `job_data` blob,
  PRIMARY KEY (`sched_name`,`job_name`,`job_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of qrtz_job_details
-- ----------------------------
INSERT INTO `qrtz_job_details` VALUES ('RuoyiScheduler', 'TASK_CLASS_NAME1', 'DEFAULT', null, 'com.aidex.quartz.util.QuartzDisallowConcurrentExecution', '0', '1', '0', '0', 0xACED0005737200156F72672E71756172747A2E4A6F62446174614D61709FB083E8BFA9B0CB020000787200266F72672E71756172747A2E7574696C732E537472696E674B65794469727479466C61674D61708208E8C3FBC55D280200015A0013616C6C6F77735472616E7369656E74446174617872001D6F72672E71756172747A2E7574696C732E4469727479466C61674D617013E62EAD28760ACE0200025A000564697274794C00036D617074000F4C6A6176612F7574696C2F4D61703B787001737200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F4000000000000C7708000000100000000174000F5441534B5F50524F504552544945537372001E636F6D2E61696465782E71756172747A2E646F6D61696E2E5379734A6F6200000000000000010200094C000A636F6E63757272656E747400124C6A6176612F6C616E672F537472696E673B4C000E63726F6E45787072657373696F6E71007E00094C000D637573746F6D4D65737361676571007E00094C000C696E766F6B6554617267657471007E00094C00086A6F6247726F757071007E00094C00056A6F6249647400104C6A6176612F6C616E672F4C6F6E673B4C00076A6F624E616D6571007E00094C000D6D697366697265506F6C69637971007E00094C000673746174757371007E000978720027636F6D2E61696465782E636F6D6D6F6E2E636F72652E646F6D61696E2E42617365456E7469747900000000000000010200145A000B69734E65775265636F72645A000B69735265636F72644C6F674C0008637265617465427971007E00094C000C63726561746542794E616D6571007E00094C000A6372656174654465707471007E00094C000E637265617465446570744E616D6571007E00094C000A63726561746554696D657400104C6A6176612F7574696C2F446174653B4C000764656C466C616771007E00094C000A68616E646C655479706571007E00094C0002696471007E00094C000D696D706F7274457272496E666F71007E00094C000A6E6F74457175616C496471007E00094C0004706167657400274C636F6D2F61696465782F636F6D6D6F6E2F636F72652F706167652F50616765446F6D61696E3B4C0006706172616D7371007E00034C000672656D61726B71007E00094C000B73656172636856616C756571007E00094C0008757064617465427971007E00094C0008757064617465497071007E00094C000A75706461746554696D6571007E000C4C000776657273696F6E7400134C6A6176612F6C616E672F496E74656765723B7870000074000561646D696E7070707372000E6A6176612E7574696C2E44617465686A81014B597419030000787077080000017751C2E498787400013070707070707074000070707070707400013174000E302F3130202A202A202A202A203F7074001172795461736B2E72794E6F506172616D7374000744454641554C547372000E6A6176612E6C616E672E4C6F6E673B8BE490CC8F23DF0200014A000576616C7565787200106A6176612E6C616E672E4E756D62657286AC951D0B94E08B02000078700000000000000001740018E7B3BBE7BB9FE9BB98E8AEA4EFBC88E697A0E58F82EFBC8974000133740001317800);
INSERT INTO `qrtz_job_details` VALUES ('RuoyiScheduler', 'TASK_CLASS_NAME2', 'DEFAULT', null, 'com.aidex.quartz.util.QuartzDisallowConcurrentExecution', '0', '1', '0', '0', 0xACED0005737200156F72672E71756172747A2E4A6F62446174614D61709FB083E8BFA9B0CB020000787200266F72672E71756172747A2E7574696C732E537472696E674B65794469727479466C61674D61708208E8C3FBC55D280200015A0013616C6C6F77735472616E7369656E74446174617872001D6F72672E71756172747A2E7574696C732E4469727479466C61674D617013E62EAD28760ACE0200025A000564697274794C00036D617074000F4C6A6176612F7574696C2F4D61703B787001737200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F4000000000000C7708000000100000000174000F5441534B5F50524F504552544945537372001E636F6D2E61696465782E71756172747A2E646F6D61696E2E5379734A6F6200000000000000010200094C000A636F6E63757272656E747400124C6A6176612F6C616E672F537472696E673B4C000E63726F6E45787072657373696F6E71007E00094C000D637573746F6D4D65737361676571007E00094C000C696E766F6B6554617267657471007E00094C00086A6F6247726F757071007E00094C00056A6F6249647400104C6A6176612F6C616E672F4C6F6E673B4C00076A6F624E616D6571007E00094C000D6D697366697265506F6C69637971007E00094C000673746174757371007E000978720027636F6D2E61696465782E636F6D6D6F6E2E636F72652E646F6D61696E2E42617365456E7469747900000000000000010200145A000B69734E65775265636F72645A000B69735265636F72644C6F674C0008637265617465427971007E00094C000C63726561746542794E616D6571007E00094C000A6372656174654465707471007E00094C000E637265617465446570744E616D6571007E00094C000A63726561746554696D657400104C6A6176612F7574696C2F446174653B4C000764656C466C616771007E00094C000A68616E646C655479706571007E00094C0002696471007E00094C000D696D706F7274457272496E666F71007E00094C000A6E6F74457175616C496471007E00094C0004706167657400274C636F6D2F61696465782F636F6D6D6F6E2F636F72652F706167652F50616765446F6D61696E3B4C0006706172616D7371007E00034C000672656D61726B71007E00094C000B73656172636856616C756571007E00094C0008757064617465427971007E00094C0008757064617465497071007E00094C000A75706461746554696D6571007E000C4C000776657273696F6E7400134C6A6176612F6C616E672F496E74656765723B7870000074000561646D696E7070707372000E6A6176612E7574696C2E44617465686A81014B597419030000787077080000017751C2E498787400013070707070707074000070707070707400013174000E302F3135202A202A202A202A203F7074001572795461736B2E7279506172616D7328277279272974000744454641554C547372000E6A6176612E6C616E672E4C6F6E673B8BE490CC8F23DF0200014A000576616C7565787200106A6176612E6C616E672E4E756D62657286AC951D0B94E08B02000078700000000000000002740018E7B3BBE7BB9FE9BB98E8AEA4EFBC88E69C89E58F82EFBC8974000133740001317800);
INSERT INTO `qrtz_job_details` VALUES ('RuoyiScheduler', 'TASK_CLASS_NAME3', 'DEFAULT', null, 'com.aidex.quartz.util.QuartzDisallowConcurrentExecution', '0', '1', '0', '0', 0xACED0005737200156F72672E71756172747A2E4A6F62446174614D61709FB083E8BFA9B0CB020000787200266F72672E71756172747A2E7574696C732E537472696E674B65794469727479466C61674D61708208E8C3FBC55D280200015A0013616C6C6F77735472616E7369656E74446174617872001D6F72672E71756172747A2E7574696C732E4469727479466C61674D617013E62EAD28760ACE0200025A000564697274794C00036D617074000F4C6A6176612F7574696C2F4D61703B787001737200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F4000000000000C7708000000100000000174000F5441534B5F50524F504552544945537372001E636F6D2E61696465782E71756172747A2E646F6D61696E2E5379734A6F6200000000000000010200094C000A636F6E63757272656E747400124C6A6176612F6C616E672F537472696E673B4C000E63726F6E45787072657373696F6E71007E00094C000D637573746F6D4D65737361676571007E00094C000C696E766F6B6554617267657471007E00094C00086A6F6247726F757071007E00094C00056A6F6249647400104C6A6176612F6C616E672F4C6F6E673B4C00076A6F624E616D6571007E00094C000D6D697366697265506F6C69637971007E00094C000673746174757371007E000978720027636F6D2E61696465782E636F6D6D6F6E2E636F72652E646F6D61696E2E42617365456E7469747900000000000000010200145A000B69734E65775265636F72645A000B69735265636F72644C6F674C0008637265617465427971007E00094C000C63726561746542794E616D6571007E00094C000A6372656174654465707471007E00094C000E637265617465446570744E616D6571007E00094C000A63726561746554696D657400104C6A6176612F7574696C2F446174653B4C000764656C466C616771007E00094C000A68616E646C655479706571007E00094C0002696471007E00094C000D696D706F7274457272496E666F71007E00094C000A6E6F74457175616C496471007E00094C0004706167657400274C636F6D2F61696465782F636F6D6D6F6E2F636F72652F706167652F50616765446F6D61696E3B4C0006706172616D7371007E00034C000672656D61726B71007E00094C000B73656172636856616C756571007E00094C0008757064617465427971007E00094C0008757064617465497071007E00094C000A75706461746554696D6571007E000C4C000776657273696F6E7400134C6A6176612F6C616E672F496E74656765723B7870000074000561646D696E7070707372000E6A6176612E7574696C2E44617465686A81014B597419030000787077080000017751C2E498787400013070707070707074000070707070707400013174000E302F3230202A202A202A202A203F7074003872795461736B2E72794D756C7469706C65506172616D7328277279272C20747275652C20323030304C2C203331362E3530442C203130302974000744454641554C547372000E6A6176612E6C616E672E4C6F6E673B8BE490CC8F23DF0200014A000576616C7565787200106A6176612E6C616E672E4E756D62657286AC951D0B94E08B02000078700000000000000003740018E7B3BBE7BB9FE9BB98E8AEA4EFBC88E5A49AE58F82EFBC8974000133740001317800);
INSERT INTO `qrtz_job_details` VALUES ('RuoyiScheduler', 'TASK_CLASS_NAME4', 'DEFAULT', null, 'com.aidex.quartz.util.QuartzDisallowConcurrentExecution', '0', '1', '0', '0', 0xACED0005737200156F72672E71756172747A2E4A6F62446174614D61709FB083E8BFA9B0CB020000787200266F72672E71756172747A2E7574696C732E537472696E674B65794469727479466C61674D61708208E8C3FBC55D280200015A0013616C6C6F77735472616E7369656E74446174617872001D6F72672E71756172747A2E7574696C732E4469727479466C61674D617013E62EAD28760ACE0200025A000564697274794C00036D617074000F4C6A6176612F7574696C2F4D61703B787001737200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F4000000000000C7708000000100000000174000F5441534B5F50524F504552544945537372001E636F6D2E61696465782E71756172747A2E646F6D61696E2E5379734A6F6200000000000000010200094C000A636F6E63757272656E747400124C6A6176612F6C616E672F537472696E673B4C000E63726F6E45787072657373696F6E71007E00094C000D637573746F6D4D65737361676571007E00094C000C696E766F6B6554617267657471007E00094C00086A6F6247726F757071007E00094C00056A6F6249647400104C6A6176612F6C616E672F4C6F6E673B4C00076A6F624E616D6571007E00094C000D6D697366697265506F6C69637971007E00094C000673746174757371007E000978720027636F6D2E61696465782E636F6D6D6F6E2E636F72652E646F6D61696E2E42617365456E7469747900000000000000010200145A000B69734E65775265636F72645A000B69735265636F72644C6F674C0008637265617465427971007E00094C000C63726561746542794E616D6571007E00094C000A6372656174654465707471007E00094C000E637265617465446570744E616D6571007E00094C000A63726561746554696D657400104C6A6176612F7574696C2F446174653B4C000764656C466C616771007E00094C000A68616E646C655479706571007E00094C0002696471007E00094C000D696D706F7274457272496E666F71007E00094C000A6E6F74457175616C496471007E00094C0004706167657400274C636F6D2F61696465782F636F6D6D6F6E2F636F72652F706167652F50616765446F6D61696E3B4C0006706172616D7371007E00034C000672656D61726B71007E00094C000B73656172636856616C756571007E00094C0008757064617465427971007E00094C0008757064617465497071007E00094C000A75706461746554696D6571007E000C4C000776657273696F6E7400134C6A6176612F6C616E672F496E74656765723B7870000074000561646D696E7070707372000E6A6176612E7574696C2E44617465686A81014B597419030000787077080000017A7987BA00787400013070707070707074002CE6AF8FE5A4A9E5878CE699A8E4B880E782B9E6B885E999A4E697A5E5BF97EFBC8CE4BF9DE795993130E5A4A970707070707400013174000D3020302031202A202A203F202A7074002373797374656D52656D6F76654C6F675461736B2E72656D6F76654C6F6728273130272974000744454641554C547372000E6A6176612E6C616E672E4C6F6E673B8BE490CC8F23DF0200014A000576616C7565787200106A6176612E6C616E672E4E756D62657286AC951D0B94E08B02000078700000000000000004740018E7B3BBE7BB9FE5AE9AE697B6E6B885E79086E697A5E5BF9774000131740001307800);

-- ----------------------------
-- Table structure for `qrtz_locks`
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_locks`;
CREATE TABLE `qrtz_locks` (
  `sched_name` varchar(120) NOT NULL,
  `lock_name` varchar(40) NOT NULL,
  PRIMARY KEY (`sched_name`,`lock_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of qrtz_locks
-- ----------------------------
INSERT INTO `qrtz_locks` VALUES ('RuoyiScheduler', 'STATE_ACCESS');
INSERT INTO `qrtz_locks` VALUES ('RuoyiScheduler', 'TRIGGER_ACCESS');

-- ----------------------------
-- Table structure for `qrtz_paused_trigger_grps`
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_paused_trigger_grps`;
CREATE TABLE `qrtz_paused_trigger_grps` (
  `sched_name` varchar(120) NOT NULL,
  `trigger_group` varchar(200) NOT NULL,
  PRIMARY KEY (`sched_name`,`trigger_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of qrtz_paused_trigger_grps
-- ----------------------------

-- ----------------------------
-- Table structure for `qrtz_scheduler_state`
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_scheduler_state`;
CREATE TABLE `qrtz_scheduler_state` (
  `sched_name` varchar(120) NOT NULL,
  `instance_name` varchar(200) NOT NULL,
  `last_checkin_time` bigint(13) NOT NULL,
  `checkin_interval` bigint(13) NOT NULL,
  PRIMARY KEY (`sched_name`,`instance_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of qrtz_scheduler_state
-- ----------------------------
INSERT INTO `qrtz_scheduler_state` VALUES ('RuoyiScheduler', 'DIGITAL-DONGYJ1632377097159', '1632377330659', '15000');

-- ----------------------------
-- Table structure for `qrtz_simple_triggers`
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_simple_triggers`;
CREATE TABLE `qrtz_simple_triggers` (
  `sched_name` varchar(120) NOT NULL,
  `trigger_name` varchar(200) NOT NULL,
  `trigger_group` varchar(200) NOT NULL,
  `repeat_count` bigint(7) NOT NULL,
  `repeat_interval` bigint(12) NOT NULL,
  `times_triggered` bigint(10) NOT NULL,
  PRIMARY KEY (`sched_name`,`trigger_name`,`trigger_group`),
  CONSTRAINT `qrtz_simple_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of qrtz_simple_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for `qrtz_simprop_triggers`
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_simprop_triggers`;
CREATE TABLE `qrtz_simprop_triggers` (
  `sched_name` varchar(120) NOT NULL,
  `trigger_name` varchar(200) NOT NULL,
  `trigger_group` varchar(200) NOT NULL,
  `str_prop_1` varchar(512) DEFAULT NULL,
  `str_prop_2` varchar(512) DEFAULT NULL,
  `str_prop_3` varchar(512) DEFAULT NULL,
  `int_prop_1` int(11) DEFAULT NULL,
  `int_prop_2` int(11) DEFAULT NULL,
  `long_prop_1` bigint(20) DEFAULT NULL,
  `long_prop_2` bigint(20) DEFAULT NULL,
  `dec_prop_1` decimal(13,4) DEFAULT NULL,
  `dec_prop_2` decimal(13,4) DEFAULT NULL,
  `bool_prop_1` varchar(1) DEFAULT NULL,
  `bool_prop_2` varchar(1) DEFAULT NULL,
  PRIMARY KEY (`sched_name`,`trigger_name`,`trigger_group`),
  CONSTRAINT `qrtz_simprop_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of qrtz_simprop_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for `qrtz_triggers`
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_triggers`;
CREATE TABLE `qrtz_triggers` (
  `sched_name` varchar(120) NOT NULL,
  `trigger_name` varchar(200) NOT NULL,
  `trigger_group` varchar(200) NOT NULL,
  `job_name` varchar(200) NOT NULL,
  `job_group` varchar(200) NOT NULL,
  `description` varchar(250) DEFAULT NULL,
  `next_fire_time` bigint(13) DEFAULT NULL,
  `prev_fire_time` bigint(13) DEFAULT NULL,
  `priority` int(11) DEFAULT NULL,
  `trigger_state` varchar(16) NOT NULL,
  `trigger_type` varchar(8) NOT NULL,
  `start_time` bigint(13) NOT NULL,
  `end_time` bigint(13) DEFAULT NULL,
  `calendar_name` varchar(200) DEFAULT NULL,
  `misfire_instr` smallint(2) DEFAULT NULL,
  `job_data` blob,
  PRIMARY KEY (`sched_name`,`trigger_name`,`trigger_group`),
  KEY `sched_name` (`sched_name`,`job_name`,`job_group`),
  CONSTRAINT `qrtz_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `job_name`, `job_group`) REFERENCES `qrtz_job_details` (`sched_name`, `job_name`, `job_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of qrtz_triggers
-- ----------------------------
INSERT INTO `qrtz_triggers` VALUES ('RuoyiScheduler', 'TASK_CLASS_NAME1', 'DEFAULT', 'TASK_CLASS_NAME1', 'DEFAULT', null, '1632377100000', '-1', '5', 'PAUSED', 'CRON', '1632377098000', '0', null, '2', '');
INSERT INTO `qrtz_triggers` VALUES ('RuoyiScheduler', 'TASK_CLASS_NAME2', 'DEFAULT', 'TASK_CLASS_NAME2', 'DEFAULT', null, '1632377100000', '-1', '5', 'PAUSED', 'CRON', '1632377098000', '0', null, '2', '');
INSERT INTO `qrtz_triggers` VALUES ('RuoyiScheduler', 'TASK_CLASS_NAME3', 'DEFAULT', 'TASK_CLASS_NAME3', 'DEFAULT', null, '1632377100000', '-1', '5', 'PAUSED', 'CRON', '1632377098000', '0', null, '2', '');
INSERT INTO `qrtz_triggers` VALUES ('RuoyiScheduler', 'TASK_CLASS_NAME4', 'DEFAULT', 'TASK_CLASS_NAME4', 'DEFAULT', null, '1632416400000', '-1', '5', 'WAITING', 'CRON', '1632377098000', '0', null, '-1', '');

-- ----------------------------
-- Table structure for `sys_change_log`
-- ----------------------------
DROP TABLE IF EXISTS `sys_change_log`;
CREATE TABLE `sys_change_log` (
  `id` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '编号',
  `type` char(1) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT '1' COMMENT '日志类型',
  `title` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT '' COMMENT '日志标题',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '创建者',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `remote_addr` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '操作IP地址',
  `user_agent` varchar(1000) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '用户代理',
  `request_uri` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '请求URI',
  `method` varchar(5000) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '操作方式',
  `params` text CHARACTER SET utf8 COLLATE utf8_bin COMMENT '操作提交的数据',
  `exception` text CHARACTER SET utf8 COLLATE utf8_bin COMMENT '异常信息',
  `log_type` varchar(255) DEFAULT NULL COMMENT '日志类型',
  `log_op_type` varchar(255) DEFAULT NULL,
  `log_content` text,
  `form_id` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sys_change_log
-- ----------------------------

-- ----------------------------
-- Table structure for `sys_config`
-- ----------------------------
DROP TABLE IF EXISTS `sys_config`;
CREATE TABLE `sys_config` (
  `config_name` varchar(100) DEFAULT '' COMMENT '参数名称',
  `config_key` varchar(100) DEFAULT '' COMMENT '参数键名',
  `config_value` varchar(500) DEFAULT '' COMMENT '参数键值',
  `config_type` char(1) DEFAULT 'N' COMMENT '系统内置（Y是 N否）',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  `id` varchar(64) NOT NULL COMMENT '岗位ID',
  `version` int(11) DEFAULT NULL COMMENT '版本',
  `del_flag` char(1) DEFAULT '0' COMMENT '删除标志（0代表存在 1代表删除）',
  `update_ip` varchar(50) DEFAULT NULL COMMENT '更新IP',
  `create_dept` varchar(64) DEFAULT NULL COMMENT '创建部门',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='参数配置表';

-- ----------------------------
-- Records of sys_config
-- ----------------------------
INSERT INTO `sys_config` VALUES ('主框架页-默认皮肤样式名称', 'sys.index.skinName', 'skin-blue', 'Y', 'admin', '2021-01-30 13:27:43', '1', '2021-07-06 15:13:33', '蓝色 skin-blue、绿色 skin-green、紫色 skin-purple、红色 skin-red、黄色 skin-yellow', '1', '4', '0', '127.0.0.1', '1');
INSERT INTO `sys_config` VALUES ('用户管理-账号初始密码', 'sys.user.initPassword', '123456', 'Y', 'admin', '2021-01-30 13:27:43', '', null, '初始化密码 123456', '2', '1', '0', null, '1');
INSERT INTO `sys_config` VALUES ('系统下载方式', 'system.upload.save.type', 'Disk', 'Y', 'admin', '2021-03-12 17:43:10', '1', '2021-09-05 12:10:32', 'Disk', '2345678935345', '6', '0', '127.0.0.1', '1');
INSERT INTO `sys_config` VALUES ('主框架页-侧边栏主题', 'sys.index.sideTheme', 'theme-dark', 'Y', 'admin', '2021-01-30 13:27:43', '1', '2021-08-06 11:39:33', '深色主题theme-dark，浅色主题theme-light   ', '3', '5', '0', '127.0.0.1', '1');

-- ----------------------------
-- Table structure for `sys_dept`
-- ----------------------------
DROP TABLE IF EXISTS `sys_dept`;
CREATE TABLE `sys_dept` (
  `id` varchar(32) NOT NULL COMMENT '部门id',
  `dept_code` varchar(500) DEFAULT NULL COMMENT '部门编号',
  `dept_name` varchar(30) DEFAULT '' COMMENT '部门名称',
  `dept_full_name` varchar(200) DEFAULT NULL COMMENT '全称',
  `leader` varchar(20) DEFAULT NULL COMMENT '负责人',
  `phone` varchar(11) DEFAULT NULL COMMENT '联系电话',
  `email` varchar(50) DEFAULT NULL COMMENT '邮箱',
  `dept_type` varchar(10) DEFAULT NULL COMMENT '机构类型',
  `address` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '联系地址',
  `zip_code` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '邮政编码',
  `dept_pinyin` varchar(500) DEFAULT NULL,
  `parent_id` varchar(32) DEFAULT '0' COMMENT '父id',
  `parent_ids` varchar(500) DEFAULT NULL COMMENT '父id集合',
  `tree_sort` int(11) DEFAULT '0' COMMENT '排序',
  `tree_sorts` varchar(500) DEFAULT NULL COMMENT '排序集合',
  `tree_level` int(11) DEFAULT NULL COMMENT '层级',
  `tree_leaf` char(1) DEFAULT NULL COMMENT '是否子节点（0是 1否）',
  `status` char(1) DEFAULT '0' COMMENT '部门状态（0正常 1停用）',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_dept` varchar(64) DEFAULT NULL COMMENT '创建部门',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `update_ip` varchar(64) DEFAULT NULL COMMENT '更新IP',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  `version` int(11) DEFAULT NULL COMMENT '版本',
  `del_flag` char(1) DEFAULT '0' COMMENT '删除标志（0代表存在 1代表删除）',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='部门表';

-- ----------------------------
-- Records of sys_dept
-- ----------------------------
INSERT INTO `sys_dept` VALUES ('100', '100', '集团', '集团', '管理员', '', '', 'org', null, null, 'jituan,jt', '0', '100', '10', '000010', '1', 'n', '0', 'admin', null, '2021-01-30 13:28:35', '1', '2021-09-05 10:07:57', '127.0.0.1', null, '7', '0');
INSERT INTO `sys_dept` VALUES ('102', '102', '子公司', '子公司', '管理员', '', '', 'company', null, null, 'zigongsi,zgs', '100', '100/102', '10', '000010/000010', '2', 'n', '0', 'admin', null, '2021-01-30 13:28:35', '1', '2021-09-05 10:07:48', '127.0.0.1', '111', '33', '0');
INSERT INTO `sys_dept` VALUES ('f96f514133a241fd8bffd9dd899de8ea', 'manager', '市场部', '市场部', null, null, null, 'dept', null, null, 'shichangbu,scb', '102', '100/102/f96f514133a241fd8bffd9dd899de8ea', '10', '000010/000010/000010', '3', 'y', '0', '1', '40f40750917349249f3a7d4593e3e886', '2021-07-26 18:20:38', '1', '2021-09-04 21:54:25', '127.0.0.1', null, '3', '0');

-- ----------------------------
-- Table structure for `sys_dict_data`
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_data`;
CREATE TABLE `sys_dict_data` (
  `dict_code` bigint(20) DEFAULT NULL COMMENT '字典编码',
  `dict_sort` int(4) DEFAULT '0' COMMENT '字典排序',
  `dict_label` varchar(100) DEFAULT '' COMMENT '字典标签',
  `dict_value` varchar(100) DEFAULT '' COMMENT '字典键值',
  `dict_type` varchar(100) DEFAULT '' COMMENT '字典类型',
  `css_class` varchar(100) DEFAULT NULL COMMENT '样式属性（其他样式扩展）',
  `list_class` varchar(100) DEFAULT NULL COMMENT '表格回显样式',
  `is_default` char(1) DEFAULT 'N' COMMENT '是否默认（Y是 N否）',
  `status` char(1) DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  `id` varchar(64) NOT NULL COMMENT '岗位ID',
  `version` int(11) DEFAULT NULL COMMENT '版本',
  `del_flag` char(1) DEFAULT '0' COMMENT '删除标志（0代表存在 1代表删除）',
  `update_ip` varchar(50) DEFAULT NULL COMMENT '更新IP',
  `create_dept` varchar(64) DEFAULT NULL COMMENT '创建部门',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `dict_data_idx` (`dict_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='字典数据表';

-- ----------------------------
-- Records of sys_dict_data
-- ----------------------------
INSERT INTO `sys_dict_data` VALUES (null, '10', '用户', 'user', 'sys_batch_type', null, null, null, '0', '1', '2021-07-29 17:55:52', '1', '2021-07-29 17:55:52', null, '0b2ecf34cbab484caf15dd9a95fc1b37', '1', '0', '127.0.0.1', '100');
INSERT INTO `sys_dict_data` VALUES ('1', '10', '男', '0', 'sys_user_sex', '', '', 'Y', '0', 'admin', '2021-01-30 13:27:43', '1', '2021-03-24 11:38:41', '性别男', '1', null, '0', '127.0.0.1', null);
INSERT INTO `sys_dict_data` VALUES ('10', '10', '默认', 'DEFAULT', 'sys_job_group', '', '', 'Y', '0', 'admin', '2021-01-30 13:27:43', '', null, '默认分组', '10', null, '0', null, null);
INSERT INTO `sys_dict_data` VALUES ('11', '20', '系统', 'SYSTEM', 'sys_job_group', '', '', 'N', '0', 'admin', '2021-01-30 13:27:43', '', null, '系统分组', '11', null, '0', null, null);
INSERT INTO `sys_dict_data` VALUES ('12', '10', '是', 'Y', 'sys_yes_no', '', 'primary', 'Y', '0', 'admin', '2021-01-30 13:27:43', '', null, '系统默认是', '12', null, '0', null, null);
INSERT INTO `sys_dict_data` VALUES ('13', '20', '否', 'N', 'sys_yes_no', '', 'danger', 'N', '0', 'admin', '2021-01-30 13:27:43', '', null, '系统默认否', '13', null, '0', null, null);
INSERT INTO `sys_dict_data` VALUES ('14', '10', '通知', '1', 'sys_notice_type', '', 'warning', 'Y', '0', 'admin', '2021-01-30 13:27:43', '', null, '通知', '14', null, '0', null, null);
INSERT INTO `sys_dict_data` VALUES ('15', '20', '公告', '2', 'sys_notice_type', '', 'success', 'N', '0', 'admin', '2021-01-30 13:27:43', '', null, '公告', '15', null, '0', null, null);
INSERT INTO `sys_dict_data` VALUES ('16', '10', '正常', '0', 'sys_notice_status', '', 'primary', 'Y', '0', 'admin', '2021-01-30 13:27:43', '', null, '正常状态', '16', null, '0', null, null);
INSERT INTO `sys_dict_data` VALUES ('17', '20', '关闭', '1', 'sys_notice_status', '', 'danger', 'N', '0', 'admin', '2021-01-30 13:27:43', '', null, '关闭状态', '17', null, '0', null, null);
INSERT INTO `sys_dict_data` VALUES ('18', '10', '新增', '1', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2021-01-30 13:27:43', '', null, '新增操作', '18', null, '0', null, null);
INSERT INTO `sys_dict_data` VALUES ('19', '20', '修改', '2', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2021-01-30 13:27:43', '', null, '修改操作', '19', null, '0', null, null);
INSERT INTO `sys_dict_data` VALUES ('2', '20', '女', '1', 'sys_user_sex', '', '', 'N', '0', 'admin', '2021-01-30 13:27:43', '', null, '性别女', '2', null, '0', null, null);
INSERT INTO `sys_dict_data` VALUES ('20', '30', '删除', '3', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2021-01-30 13:27:43', '', null, '删除操作', '20', null, '0', null, null);
INSERT INTO `sys_dict_data` VALUES ('21', '40', '授权', '4', 'sys_oper_type', '', 'primary', 'N', '0', 'admin', '2021-01-30 13:27:43', '', null, '授权操作', '21', null, '0', null, null);
INSERT INTO `sys_dict_data` VALUES ('22', '50', '导出', '5', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2021-01-30 13:27:43', '', null, '导出操作', '22', null, '0', null, null);
INSERT INTO `sys_dict_data` VALUES ('23', '60', '导入', '6', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2021-01-30 13:27:43', '', null, '导入操作', '23', null, '0', null, null);
INSERT INTO `sys_dict_data` VALUES ('24', '70', '强退', '7', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2021-01-30 13:27:43', '', null, '强退操作', '24', null, '0', null, null);
INSERT INTO `sys_dict_data` VALUES ('25', '80', '生成代码', '8', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2021-01-30 13:27:43', '', null, '生成操作', '25', null, '0', null, null);
INSERT INTO `sys_dict_data` VALUES ('26', '90', '清空数据', '9', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2021-01-30 13:27:43', '', null, '清空操作', '26', null, '0', null, null);
INSERT INTO `sys_dict_data` VALUES ('27', '10', '成功', '0', 'sys_common_status', '', 'primary', 'N', '0', 'admin', '2021-01-30 13:27:43', '', null, '正常状态', '27', null, '0', null, null);
INSERT INTO `sys_dict_data` VALUES ('28', '20', '失败', '1', 'sys_common_status', '', 'danger', 'N', '0', 'admin', '2021-01-30 13:27:43', '', null, '停用状态', '28', null, '0', null, null);
INSERT INTO `sys_dict_data` VALUES ('3', '30', '未知', '2', 'sys_user_sex', '', '', 'N', '0', 'admin', '2021-01-30 13:27:43', '', null, '性别未知', '3', null, '0', null, null);
INSERT INTO `sys_dict_data` VALUES (null, '10', '系统', 'S', 'sys_portal_range', null, null, null, '1', '1', '2021-05-11 10:15:31', '1', '2021-06-21 15:49:10', null, '311f9aef2e354baf962a39b52602b7ad', '21', '0', '127.0.0.1', '100');
INSERT INTO `sys_dict_data` VALUES (null, '10', '有效', '0', 'sys_is_valid', null, null, null, '0', '1', '2021-05-27 10:10:48', '1', '2021-05-27 10:10:48', null, '36315b7a36a94a56ae1822b49da8da50', '1', '0', '127.0.0.1', '100');
INSERT INTO `sys_dict_data` VALUES (null, '10', '后台用户', '1', 'sys_user_type', null, null, null, '0', '1', '2021-03-01 11:41:30', '1', '2021-03-01 11:41:35', null, '38ca19b3b24242b48c6d8302bb6f1a67', '2', '0', '127.0.0.1', '103');
INSERT INTO `sys_dict_data` VALUES (null, '10', '部分成功', 'sucess_fail', 'sys_upload_file_status', null, null, null, '0', '1', '2021-07-29 17:54:49', '1', '2021-07-29 17:54:49', null, '3e6d5a3380834e92af742b0ef3a3dbb1', '1', '0', '127.0.0.1', '100');
INSERT INTO `sys_dict_data` VALUES ('4', '10', '显示', '0', 'sys_show_hide', '', 'primary', 'Y', '0', 'admin', '2021-01-30 13:27:43', '', null, '显示菜单', '4', null, '0', null, null);
INSERT INTO `sys_dict_data` VALUES ('5', '20', '隐藏', '1', 'sys_show_hide', '', 'danger', 'N', '0', 'admin', '2021-01-30 13:27:43', '', null, '隐藏菜单', '5', null, '0', null, null);
INSERT INTO `sys_dict_data` VALUES (null, '10', '配置自定义类', '1', 'sys_data_rule_type', null, null, null, '0', '1', '2021-05-28 10:46:20', '1', '2021-05-28 10:46:20', null, '5aba6023547347e99f4bf3386a3431f7', '1', '0', '127.0.0.1', '100');
INSERT INTO `sys_dict_data` VALUES (null, '20', '失败', 'fail', 'sys_upload_file_status', null, null, null, '0', '1', '2021-07-29 17:54:28', '1', '2021-07-29 17:54:28', null, '5f04bcbfde0049ddb2a17441976a64b2', '1', '0', '127.0.0.1', '100');
INSERT INTO `sys_dict_data` VALUES ('6', '10', '正常', '0', 'sys_normal_disable', '', 'primary', 'Y', '0', 'admin', '2021-01-30 13:27:43', '', null, '正常状态', '6', null, '0', null, null);
INSERT INTO `sys_dict_data` VALUES (null, '200', '开启', '20', 'is_active', null, null, null, '0', '1', '2021-08-12 16:16:16', '1', '2021-08-12 16:16:16', null, '60e4ea6677b54a2ea98310538f597b12', '1', '0', '127.0.0.1', '100');
INSERT INTO `sys_dict_data` VALUES (null, '10', '或（or）', '0', 'sys_logical_symbol', null, null, null, '0', '1', '2021-05-27 09:20:07', '1', '2021-05-27 09:56:57', null, '63b33b9349ce4c6cbf75014c59089b2a', '2', '0', '127.0.0.1', '100');
INSERT INTO `sys_dict_data` VALUES (null, '30', '处理中', 'processing', 'sys_upload_file_status', null, null, null, '0', '1', '2021-07-29 21:41:04', '1', '2021-07-29 21:41:04', null, '68e4aeacb4534486b253c7e1d91b4f0c', '1', '0', '127.0.0.1', '100');
INSERT INTO `sys_dict_data` VALUES ('7', '20', '停用', '1', 'sys_normal_disable', '', 'danger', 'N', '0', 'admin', '2021-01-30 13:27:43', '', null, '停用状态', '7', null, '0', null, null);
INSERT INTO `sys_dict_data` VALUES (null, '10', '等待下载', 'waiting', 'sys_download_file_status', null, null, null, '0', '1', '2021-07-18 18:59:48', '1', '2021-07-18 18:59:48', null, '728d9405e43b4ac6953ef0f37fe59d5f', '1', '0', '127.0.0.1', '100');
INSERT INTO `sys_dict_data` VALUES (null, '20', '配置字段', '0', 'sys_data_rule_type', null, null, null, '0', '1', '2021-05-28 10:45:49', '1', '2021-05-28 10:45:49', null, '7ce190378adc45698d0a00a5c47906c5', '1', '0', '127.0.0.1', '100');
INSERT INTO `sys_dict_data` VALUES ('8', '10', '正常', '0', 'sys_job_status', '', 'primary', 'Y', '0', 'admin', '2021-01-30 13:27:43', '', null, '正常状态', '8', null, '0', null, null);
INSERT INTO `sys_dict_data` VALUES (null, '20', '角色', 'R', 'sys_portal_range', null, null, null, '0', '1', '2021-05-11 10:15:48', '1', '2021-05-11 10:15:48', null, '86adc81770e34600ab906d68b927c110', '1', '0', '127.0.0.1', '100');
INSERT INTO `sys_dict_data` VALUES (null, '20', '导出失败', 'fail', 'sys_download_file_status', null, null, null, '0', '1', '2021-07-18 15:05:22', '1', '2021-07-18 15:05:22', null, '888a580d4c914e9a9a59021b149301c4', '1', '0', '127.0.0.1', '100');
INSERT INTO `sys_dict_data` VALUES ('9', '20', '暂停', '1', 'sys_job_status', '', 'danger', 'N', '0', 'admin', '2021-01-30 13:27:43', '', null, '停用状态', '9', null, '0', null, null);
INSERT INTO `sys_dict_data` VALUES (null, '20', '且（and）', '1', 'sys_logical_symbol', null, null, null, '0', '1', '2021-05-27 09:20:26', '1', '2021-05-27 09:57:05', null, '9dd14cd1fb5847898ba4ac9e4b196755', '2', '0', '127.0.0.1', '100');
INSERT INTO `sys_dict_data` VALUES (null, '20', '前台用户', '2', 'sys_user_type', null, null, null, '0', '1', '2021-03-01 11:41:46', '1', '2021-03-01 11:41:46', null, '9f6424fbc8154850ba41076616855d63', '1', '0', '127.0.0.1', '103');
INSERT INTO `sys_dict_data` VALUES (null, '10', '机构', 'org', 'sys_dept_type', null, null, null, '0', '1', '2021-02-24 18:35:41', '1', '2021-02-25 15:22:42', null, 'a2c5e3f94ce44007adb448de721bbc49', '5', '0', '127.0.0.1', '103');
INSERT INTO `sys_dict_data` VALUES (null, '30', '文件已过期', 'expired', 'sys_download_file_status', null, null, null, '0', '1', '2021-07-18 15:05:46', '1', '2021-07-18 15:05:46', null, 'a8a02ea692f246c4be64b0f341291c5b', '1', '0', '127.0.0.1', '100');
INSERT INTO `sys_dict_data` VALUES (null, '20', '公司', 'company', 'sys_dept_type', null, null, null, '0', '1', '2021-02-24 11:45:32', '1', '2021-02-24 14:06:42', null, 'c226f8276bbd41ce9bb53bff9f38e6db', '3', '0', '127.0.0.1', '103');
INSERT INTO `sys_dict_data` VALUES (null, '20', '无效', '1', 'sys_is_valid', null, null, null, '0', '1', '2021-05-27 10:10:58', '1', '2021-05-27 10:10:58', null, 'c4f7b956f6074cde80ea2d0520aaae15', '1', '0', '127.0.0.1', '100');
INSERT INTO `sys_dict_data` VALUES (null, '30', '部门', 'dept', 'sys_dept_type', null, null, null, '0', '1', '2021-03-02 10:14:09', '1', '2021-03-02 10:14:09', null, 'cc8564ca5919410e8ee71145ef652ccd', '1', '0', '127.0.0.1', '103');
INSERT INTO `sys_dict_data` VALUES (null, '40', '导出成功', 'success', 'sys_download_file_status', null, null, null, '0', '1', '2021-07-18 15:05:11', '1', '2021-07-18 15:05:11', null, 'd057ba5be59947bda3275e604ad758d0', '1', '0', '127.0.0.1', '100');
INSERT INTO `sys_dict_data` VALUES (null, '100', '关闭', '10', 'is_active', null, null, null, '0', '1', '2021-08-12 16:16:05', '1', '2021-08-12 16:16:05', null, 'd6a6dd3180e2497eb34b29c5b29ead15', '1', '0', '127.0.0.1', '100');
INSERT INTO `sys_dict_data` VALUES (null, '30', '用户', 'U', 'sys_portal_range', null, null, null, '0', '1', '2021-05-11 10:16:00', '1', '2021-05-11 10:16:00', null, 'dae2f9bc8046495182fa320b9efd05b2', '1', '0', '127.0.0.1', '100');
INSERT INTO `sys_dict_data` VALUES (null, '40', '成功', 'success', 'sys_upload_file_status', null, null, null, '0', '1', '2021-07-29 17:54:13', '1', '2021-07-29 17:54:13', null, 'f5b21638f0af411fa642f78811b9650d', '1', '0', '127.0.0.1', '100');

-- ----------------------------
-- Table structure for `sys_dict_type`
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_type`;
CREATE TABLE `sys_dict_type` (
  `id` varchar(64) NOT NULL COMMENT '字典主键',
  `dict_name` varchar(100) DEFAULT '' COMMENT '字典名称',
  `dict_type` varchar(100) DEFAULT '' COMMENT '字典类型',
  `status` char(1) DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  `version` int(11) DEFAULT NULL COMMENT '版本',
  `del_flag` char(1) DEFAULT '0' COMMENT '删除标志（0代表存在 1代表删除）',
  `update_ip` varchar(50) DEFAULT NULL COMMENT '更新IP',
  `create_dept` varchar(64) DEFAULT NULL COMMENT '创建部门',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `dict_type` (`dict_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='字典类型表';

-- ----------------------------
-- Records of sys_dict_type
-- ----------------------------
INSERT INTO `sys_dict_type` VALUES ('1', '用户性别', 'sys_user_sex', '0', 'admin', '2021-01-30 13:27:43', '1', '2021-03-24 11:38:47', '用户性别列表', null, '0', '127.0.0.1', null);
INSERT INTO `sys_dict_type` VALUES ('10', '系统状态', 'sys_common_status', '0', 'admin', '2021-01-30 13:27:43', '', null, '登录状态列表', null, '0', null, null);
INSERT INTO `sys_dict_type` VALUES ('17a5aedeee3f4ed0a3a7d0d84e5b37d2', '门户应用范围', 'sys_portal_range', '0', '1', '2021-05-11 10:15:05', '1', '2021-05-11 10:15:05', null, '1', '0', '127.0.0.1', '100');
INSERT INTO `sys_dict_type` VALUES ('2', '菜单状态', 'sys_show_hide', '0', 'admin', '2021-01-30 13:27:43', '', null, '菜单状态列表', null, '0', null, null);
INSERT INTO `sys_dict_type` VALUES ('3', '系统开关', 'sys_normal_disable', '0', 'admin', '2021-01-30 13:27:43', '', null, '系统开关列表', null, '0', null, null);
INSERT INTO `sys_dict_type` VALUES ('4', '任务状态', 'sys_job_status', '0', 'admin', '2021-01-30 13:27:43', '', null, '任务状态列表', null, '0', null, null);
INSERT INTO `sys_dict_type` VALUES ('5', '任务分组', 'sys_job_group', '0', 'admin', '2021-01-30 13:27:43', '', null, '任务分组列表', null, '0', null, null);
INSERT INTO `sys_dict_type` VALUES ('6', '系统是否', 'sys_yes_no', '0', 'admin', '2021-01-30 13:27:43', '', null, '系统是否列表', null, '0', null, null);
INSERT INTO `sys_dict_type` VALUES ('6a944ab30cdb4bcda6380db18515e111', '导出文件状态', 'sys_download_file_status', '0', '1', '2021-07-18 15:03:42', '1', '2021-07-18 15:03:42', null, '1', '0', '127.0.0.1', '100');
INSERT INTO `sys_dict_type` VALUES ('7', '通知类型', 'sys_notice_type', '0', 'admin', '2021-01-30 13:27:43', '', null, '通知类型列表', null, '0', null, null);
INSERT INTO `sys_dict_type` VALUES ('79aaacc0f8424b75b4b2dd1809b698c6', '是否有效', 'sys_is_valid', '0', '1', '2021-05-27 10:10:26', '1', '2021-05-27 10:10:26', null, '1', '0', '127.0.0.1', '100');
INSERT INTO `sys_dict_type` VALUES ('8', '通知状态', 'sys_notice_status', '0', 'admin', '2021-01-30 13:27:43', '', null, '通知状态列表', null, '0', null, null);
INSERT INTO `sys_dict_type` VALUES ('9', '操作类型', 'sys_oper_type', '0', 'admin', '2021-01-30 13:27:43', '', null, '操作类型列表', null, '0', null, null);
INSERT INTO `sys_dict_type` VALUES ('a2dce0cac0ce4d539ca0c9f4ee2893b1', '是否启动', 'is_active', '0', '1', '2021-08-12 16:15:39', '1', '2021-08-12 16:15:39', null, '1', '0', '127.0.0.1', '100');
INSERT INTO `sys_dict_type` VALUES ('aa0c5c14dca441e49c5d98c620429cda', '用户类型', 'sys_user_type', '0', '1', '2021-03-01 11:41:07', '1', '2021-03-01 11:41:07', null, '1', '0', '127.0.0.1', '103');
INSERT INTO `sys_dict_type` VALUES ('c3c50d4b965640b19a5e73597922ba20', '部门类型', 'sys_dept_type', '0', '1', '2021-02-25 17:11:16', '1', '2021-02-25 17:11:16', '1', '1', '0', '127.0.0.1', '103');
INSERT INTO `sys_dict_type` VALUES ('ce2b7ab252404d5cb96a66b166e7dd7d', '逻辑符号', 'sys_logical_symbol', '0', '1', '2021-05-27 09:19:20', '1', '2021-05-27 09:19:20', null, '1', '0', '127.0.0.1', '100');
INSERT INTO `sys_dict_type` VALUES ('d2ecadc42f584d71a6d3247d7f52370a', '批量更新类型', 'sys_batch_type', '0', '1', '2021-07-29 17:55:36', '1', '2021-07-29 17:55:36', null, '1', '0', '127.0.0.1', '100');
INSERT INTO `sys_dict_type` VALUES ('f021ff0d24b24b788d3552ab8fd7ebce', '规则类型', 'sys_data_rule_type', '0', '1', '2021-05-28 10:45:23', '1', '2021-05-28 10:45:23', null, '1', '0', '127.0.0.1', '100');
INSERT INTO `sys_dict_type` VALUES ('f90f3ffd1e474160a6cbeaf88cef2647', '导入文件状态', 'sys_upload_file_status', '0', '1', '2021-07-29 17:50:27', '1', '2021-07-29 17:53:35', null, '2', '0', '127.0.0.1', '100');

-- ----------------------------
-- Table structure for `sys_job`
-- ----------------------------
DROP TABLE IF EXISTS `sys_job`;
CREATE TABLE `sys_job` (
  `job_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '任务ID',
  `job_name` varchar(64) NOT NULL DEFAULT '' COMMENT '任务名称',
  `job_group` varchar(64) NOT NULL DEFAULT 'DEFAULT' COMMENT '任务组名',
  `invoke_target` varchar(500) NOT NULL COMMENT '调用目标字符串',
  `cron_expression` varchar(255) DEFAULT '' COMMENT 'cron执行表达式',
  `misfire_policy` varchar(20) DEFAULT '3' COMMENT '计划执行错误策略（1立即执行 2执行一次 3放弃执行）',
  `concurrent` char(1) DEFAULT '1' COMMENT '是否并发执行（0允许 1禁止）',
  `status` char(1) DEFAULT '0' COMMENT '状态（0正常 1暂停）',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) DEFAULT '' COMMENT '备注信息',
  PRIMARY KEY (`job_id`,`job_name`,`job_group`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='定时任务调度表';

-- ----------------------------
-- Records of sys_job
-- ----------------------------
INSERT INTO `sys_job` VALUES ('1', '系统默认（无参）', 'DEFAULT', 'ryTask.ryNoParams', '0/10 * * * * ?', '3', '1', '1', 'admin', '2021-01-30 13:27:43', '', '2021-06-09 09:58:47', '');
INSERT INTO `sys_job` VALUES ('2', '系统默认（有参）', 'DEFAULT', 'ryTask.ryParams(\'ry\')', '0/15 * * * * ?', '3', '1', '1', 'admin', '2021-01-30 13:27:43', '', '2021-06-09 10:01:44', '');
INSERT INTO `sys_job` VALUES ('3', '系统默认（多参）', 'DEFAULT', 'ryTask.ryMultipleParams(\'ry\', true, 2000L, 316.50D, 100)', '0/20 * * * * ?', '3', '1', '1', 'admin', '2021-01-30 13:27:43', '', '2021-06-09 11:15:02', '');
INSERT INTO `sys_job` VALUES ('4', '系统定时清理日志', 'DEFAULT', 'systemRemoveLogTask.removeLog(\'10\')', '0 0 1 * * ? *', '1', '1', '0', 'admin', '2021-07-06 09:56:16', 'admin', '2021-07-06 10:48:29', '每天凌晨一点清除日志，保留10天');

-- ----------------------------
-- Table structure for `sys_job_log`
-- ----------------------------
DROP TABLE IF EXISTS `sys_job_log`;
CREATE TABLE `sys_job_log` (
  `job_log_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '任务日志ID',
  `job_name` varchar(64) NOT NULL COMMENT '任务名称',
  `job_group` varchar(64) NOT NULL COMMENT '任务组名',
  `invoke_target` varchar(500) NOT NULL COMMENT '调用目标字符串',
  `job_message` varchar(500) DEFAULT NULL COMMENT '日志信息',
  `status` char(1) DEFAULT '0' COMMENT '执行状态（0正常 1失败）',
  `exception_info` varchar(2000) DEFAULT '' COMMENT '异常信息',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`job_log_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='定时任务调度日志表';

-- ----------------------------
-- Records of sys_job_log
-- ----------------------------

-- ----------------------------
-- Table structure for `sys_log`
-- ----------------------------
DROP TABLE IF EXISTS `sys_log`;
CREATE TABLE `sys_log` (
  `id` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '编号',
  `type` char(1) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT '1' COMMENT '日志类型',
  `title` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT '' COMMENT '日志标题',
  `remote_addr` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '操作IP地址',
  `user_agent` varchar(2000) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '用户代理',
  `request_uri` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '请求URI',
  `method` varchar(5000) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '操作方式',
  `param` text CHARACTER SET utf8 COLLATE utf8_bin COMMENT '操作提交的数据',
  `exception` text CHARACTER SET utf8 COLLATE utf8_bin COMMENT '异常信息',
  `log_type` varchar(255) DEFAULT NULL COMMENT '日志类型',
  `log_op_type` varchar(255) DEFAULT NULL,
  `log_content` text,
  `form_id` varchar(255) DEFAULT NULL,
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_dept` varchar(64) DEFAULT NULL COMMENT '创建部门',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `update_ip` varchar(64) DEFAULT NULL COMMENT '更新IP',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  `version` int(11) DEFAULT NULL COMMENT '版本',
  `del_flag` char(1) DEFAULT '0' COMMENT '删除标志（0代表存在 1代表删除）',
  PRIMARY KEY (`id`),
  KEY `log_idx` (`form_id`),
  KEY `sys_log_type` (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='系统数据变更日志表';

-- ----------------------------
-- Records of sys_log
-- ----------------------------

-- ----------------------------
-- Table structure for `sys_login_log`
-- ----------------------------
DROP TABLE IF EXISTS `sys_login_log`;
CREATE TABLE `sys_login_log` (
  `user_name` varchar(50) DEFAULT '' COMMENT '用户账号',
  `ipaddr` varchar(50) DEFAULT '' COMMENT '登录IP地址',
  `login_location` varchar(255) DEFAULT '' COMMENT '登录地点',
  `browser` varchar(50) DEFAULT '' COMMENT '浏览器类型',
  `os` varchar(50) DEFAULT '' COMMENT '操作系统',
  `status` char(1) DEFAULT '0' COMMENT '登录状态（0成功 1失败）',
  `msg` varchar(255) DEFAULT '' COMMENT '提示消息',
  `login_time` datetime DEFAULT NULL COMMENT '访问时间',
  `id` varchar(64) NOT NULL COMMENT '岗位ID',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  `del_flag` char(1) DEFAULT '0' COMMENT '删除标志（0代表存在 1代表删除）',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='系统访问记录';

-- ----------------------------
-- Records of sys_login_log
-- ----------------------------
INSERT INTO `sys_login_log` VALUES ('admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 7', '0', '登录成功', '2021-09-18 10:40:14', '01ab48477cfe425ba238bd295970451d', null, '0');
INSERT INTO `sys_login_log` VALUES ('admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 7', '1', '验证码已失效', '2021-09-18 10:40:10', '066a772323614a15a950169a74377447', null, '0');
INSERT INTO `sys_login_log` VALUES ('admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 7', '0', '退出成功', '2021-09-22 21:27:09', '077ca569196f4840afe342d29819d85b', null, '0');
INSERT INTO `sys_login_log` VALUES ('admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 7', '0', '登录成功', '2021-09-22 21:33:09', '0caadd000e9d4511ab6b3da6443895ec', null, '0');
INSERT INTO `sys_login_log` VALUES ('admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 7', '0', '退出成功', '2021-09-22 21:15:42', '0dcfb75a7c72432aa7bd544254605f69', null, '0');
INSERT INTO `sys_login_log` VALUES ('admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 7', '0', '退出成功', '2021-09-22 21:32:44', '0eb0c14406da499bbb85c23ff7daccfa', null, '0');
INSERT INTO `sys_login_log` VALUES ('admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 7', '1', '用户不存在/密码错误', '2021-09-17 15:04:25', '18992b1f49444494b810ec030a4bef22', null, '0');
INSERT INTO `sys_login_log` VALUES ('admin', '10.216.70.100', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2021-09-23 13:45:18', '18c077933cf040dc8e65a9cd6f0f4c24', null, '0');
INSERT INTO `sys_login_log` VALUES ('admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 7', '0', '登录成功', '2021-09-23 13:35:15', '1b153d0a634f473893df5e3e5844dda4', null, '0');
INSERT INTO `sys_login_log` VALUES ('admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 7', '0', '登录成功', '2021-09-23 09:05:17', '234321385e184432968bddd6f92b01bd', null, '0');
INSERT INTO `sys_login_log` VALUES ('admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 7', '0', '登录成功', '2021-09-17 16:44:13', '2c621bbfe4c647fe8ae8b63b15516200', null, '0');
INSERT INTO `sys_login_log` VALUES ('admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 7', '0', '退出成功', '2021-09-23 09:05:08', '4a85ba33d846452eb54e738e6774a6d8', null, '0');
INSERT INTO `sys_login_log` VALUES ('admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 7', '0', '登录成功', '2021-09-22 21:27:13', '4e1127d3618c4b329972d2c25d4ba6aa', null, '0');
INSERT INTO `sys_login_log` VALUES ('admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 7', '0', '退出成功', '2021-09-23 13:49:02', '5b031436054d44ef98f6573ab9555e55', null, '0');
INSERT INTO `sys_login_log` VALUES ('admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 7', '1', '用户不存在/密码错误', '2021-09-17 15:04:06', '635536fba77f4826ba829bc9a93c4e5a', null, '0');
INSERT INTO `sys_login_log` VALUES ('admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 7', '0', '登录成功', '2021-09-23 13:49:58', '6a6968ef14a64ecdbb309c4e6a488089', null, '0');
INSERT INTO `sys_login_log` VALUES ('admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 7', '0', '登录成功', '2021-09-23 09:02:36', '6d65ab6396304c24be41f5614f0f1153', null, '0');
INSERT INTO `sys_login_log` VALUES ('admin', '10.216.60.21', '内网IP', 'Chrome 9', 'Windows 7', '1', '验证码已失效', '2021-09-23 09:50:02', '8ca3db30361f44afbd37380eadbd404a', null, '0');
INSERT INTO `sys_login_log` VALUES ('admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 7', '0', '登录成功', '2021-09-18 14:50:04', '9b903e23ac984922855129016c430c19', null, '0');
INSERT INTO `sys_login_log` VALUES ('admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 7', '0', '登录成功', '2021-09-23 09:50:15', 'a9b00929c07b4d67816651c7ab124c79', null, '0');
INSERT INTO `sys_login_log` VALUES ('admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 7', '0', '登录成功', '2021-09-18 11:27:31', 'ac0067d438cd4ae2bdd401eff0daba64', null, '0');
INSERT INTO `sys_login_log` VALUES ('admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 7', '0', '登录成功', '2021-09-17 15:04:41', 'be802723b7c74158ab8f122208448885', null, '0');
INSERT INTO `sys_login_log` VALUES ('admin', '10.216.70.100', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2021-09-23 09:07:21', 'c07f737fe56e4ff3b71471de47261231', null, '0');
INSERT INTO `sys_login_log` VALUES ('admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 7', '0', '退出成功', '2021-09-23 13:51:07', 'c53f2b61d72649c8a5c84f649df0e999', null, '0');
INSERT INTO `sys_login_log` VALUES ('admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 7', '0', '退出成功', '2021-09-23 09:05:52', 'd93a4c5d3d3b42689709f1a78c7fc769', null, '0');
INSERT INTO `sys_login_log` VALUES ('admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 7', '1', '用户不存在/密码错误', '2021-09-17 15:04:15', 'db26b746c9fa409797e0648fa3cc27cc', null, '0');
INSERT INTO `sys_login_log` VALUES ('admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 7', '0', '登录成功', '2021-09-23 09:06:09', 'e100a85e0960410c81ebd24ab1d66759', null, '0');
INSERT INTO `sys_login_log` VALUES ('admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 7', '0', '登录成功', '2021-09-22 19:18:07', 'e14edaab79d045c7ba41f96207af96c1', null, '0');
INSERT INTO `sys_login_log` VALUES ('admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 7', '0', '登录成功', '2021-09-22 21:21:42', 'e5cc43c39465406aa4c9fe878c3514f1', null, '0');
INSERT INTO `sys_login_log` VALUES ('admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 7', '0', '登录成功', '2021-09-23 13:51:30', 'f1d38fbe504d481291f07925f7c71f8b', null, '0');
INSERT INTO `sys_login_log` VALUES ('admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 7', '0', '登录成功', '2021-09-18 13:43:01', 'fa0d4f44f3f2415996dba36040e1dfd5', null, '0');

-- ----------------------------
-- Table structure for `sys_menu`
-- ----------------------------
DROP TABLE IF EXISTS `sys_menu`;
CREATE TABLE `sys_menu` (
  `menu_code` varchar(500) DEFAULT NULL COMMENT '菜单编码',
  `menu_name` varchar(50) NOT NULL COMMENT '菜单名称',
  `parent_id` varchar(64) DEFAULT '0' COMMENT '父菜单ID',
  `sort` int(4) DEFAULT '0' COMMENT '显示顺序',
  `path` varchar(200) DEFAULT '' COMMENT '路由地址',
  `component` varchar(255) DEFAULT NULL COMMENT '组件路径',
  `is_frame` int(1) DEFAULT '1' COMMENT '是否为外链（0是 1否）',
  `is_cache` int(1) DEFAULT '0' COMMENT '是否缓存（0缓存 1不缓存）',
  `menu_type` char(1) DEFAULT '' COMMENT '菜单类型（M目录 C菜单 F按钮）',
  `visible` char(1) DEFAULT '0' COMMENT '菜单状态（0显示 1隐藏）',
  `status` char(1) DEFAULT '0' COMMENT '菜单状态（0正常 1停用）',
  `perms` varchar(100) DEFAULT NULL COMMENT '权限标识',
  `icon` varchar(100) DEFAULT '#' COMMENT '菜单图标',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) DEFAULT '' COMMENT '备注',
  `id` varchar(64) NOT NULL,
  `parent_ids` varchar(500) DEFAULT NULL COMMENT '父id集合',
  `tree_sort` int(11) DEFAULT '0' COMMENT '排序',
  `tree_sorts` varchar(500) DEFAULT NULL COMMENT '排序集合',
  `tree_level` int(11) DEFAULT NULL COMMENT '层级',
  `tree_leaf` char(1) DEFAULT NULL COMMENT '是否子节点（0是 1否）',
  `create_dept` varchar(64) DEFAULT NULL COMMENT '创建部门',
  `update_ip` varchar(64) DEFAULT NULL COMMENT '更新IP',
  `version` int(11) DEFAULT NULL COMMENT '版本',
  `del_flag` char(1) DEFAULT '0' COMMENT '删除标志（0代表存在 1代表删除）',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sys_menu
-- ----------------------------
INSERT INTO `sys_menu` VALUES ('user-manager', '用户管理', '8f00f7f7d3b44aaba1041bc8fdf6c470', '1', 'user', 'system/user/SysUserIndex', '1', '0', 'C', '0', '0', 'system:user:list', 'team', 'admin', '2021-01-30 13:27:43', '1', '2021-09-04 10:42:04', '主要维护平台相关用户信息', '100', '8f00f7f7d3b44aaba1041bc8fdf6c470/100', '10', '000010/000010', '2', 'n', '', '127.0.0.1', '18', '0');
INSERT INTO `sys_menu` VALUES ('userQuery', '用户查询', '100', '1', '', '', '1', '0', 'F', '0', '0', 'system:user:query', '#', 'admin', '2021-01-30 13:27:43', '1', '2021-09-04 10:43:32', '', '1001', '8f00f7f7d3b44aaba1041bc8fdf6c470/100/1001', '10', '000010/000010/000010', '3', 'y', '', '127.0.0.1', '9', '0');
INSERT INTO `sys_menu` VALUES ('userAdd', '用户新增', '100', '2', '', '', '1', '0', 'F', '0', '0', 'system:user:add', '#', 'admin', '2021-01-30 13:27:43', '1', '2021-09-04 10:43:42', '', '1002', '8f00f7f7d3b44aaba1041bc8fdf6c470/100/1002', '20', '000010/000010/000020', '3', 'y', '', '127.0.0.1', '8', '0');
INSERT INTO `sys_menu` VALUES ('userEdit', '用户修改', '100', '3', '', '', '1', '0', 'F', '0', '0', 'system:user:edit', '#', 'admin', '2021-01-30 13:27:43', '1', '2021-09-04 10:43:56', '', '1003', '8f00f7f7d3b44aaba1041bc8fdf6c470/100/1003', '30', '000010/000010/000030', '3', 'y', '', '127.0.0.1', '7', '0');
INSERT INTO `sys_menu` VALUES ('userRemove', '用户删除', '100', '4', '', '', '1', '0', 'F', '0', '0', 'system:user:remove', '#', 'admin', '2021-01-30 13:27:43', '1', '2021-09-04 10:44:06', '', '1004', '8f00f7f7d3b44aaba1041bc8fdf6c470/100/1004', '40', '000010/000010/000040', '3', 'y', '', '127.0.0.1', '7', '0');
INSERT INTO `sys_menu` VALUES ('userExport', '用户导出', '100', '5', '', '', '1', '0', 'F', '0', '0', 'system:user:export', '#', 'admin', '2021-01-30 13:27:43', '1', '2021-09-04 10:44:20', '', '1005', '8f00f7f7d3b44aaba1041bc8fdf6c470/100/1005', '50', '000010/000010/000050', '3', 'y', '', '127.0.0.1', '7', '0');
INSERT INTO `sys_menu` VALUES ('userImport', '用户导入', '100', '6', '', '', '1', '0', 'F', '0', '0', 'system:user:import', '#', 'admin', '2021-01-30 13:27:43', '1', '2021-09-04 10:45:01', '', '1006', '8f00f7f7d3b44aaba1041bc8fdf6c470/100/1006', '0', '000010/000010/000000', '3', 'y', '', '127.0.0.1', '7', '0');
INSERT INTO `sys_menu` VALUES ('userReetPwd', '重置密码', '100', '7', '', '', '1', '0', 'F', '0', '0', 'system:user:resetPwd', '#', 'admin', '2021-01-30 13:27:43', '1', '2021-09-04 10:44:37', '', '1007', '8f00f7f7d3b44aaba1041bc8fdf6c470/100/1007', '0', '000010/000010/000000', '3', 'y', '', '127.0.0.1', '7', '0');
INSERT INTO `sys_menu` VALUES ('roleQuery', '角色查询', '101', '1', '', '', '1', '0', 'F', '0', '0', 'system:role:query', '#', 'admin', '2021-01-30 13:27:43', '1', '2021-03-26 14:48:38', '', '1008', 'ed0919f0a42e4a07993622037df86a33/101/1008', '10', '000020/000010/000010', '3', 'y', '', '127.0.0.1', '8', '0');
INSERT INTO `sys_menu` VALUES ('roleAdd', '角色新增', '101', '2', '', '', '1', '0', 'F', '0', '0', 'system:role:add', '#', 'admin', '2021-01-30 13:27:43', '1', '2021-03-26 14:48:55', '', '1009', 'ed0919f0a42e4a07993622037df86a33/101/1009', '20', '000020/000010/000020', '3', 'y', '', '127.0.0.1', '8', '0');
INSERT INTO `sys_menu` VALUES ('role-manager', '角色管理', 'ed0919f0a42e4a07993622037df86a33', '2', 'role', 'system/role/QueryList', '1', '0', 'C', '0', '0', '', 'contacts', 'admin', '2021-01-30 13:27:43', '1', '2021-09-04 15:49:36', '维护平台各角色数据以及权限分配.', '101', 'ed0919f0a42e4a07993622037df86a33/101', '10', '000020/000010', '2', 'n', '', '127.0.0.1', '17', '0');
INSERT INTO `sys_menu` VALUES ('roleEdit', '角色修改', '101', '3', '', '', '1', '0', 'F', '0', '0', 'system:role:edit', '#', 'admin', '2021-01-30 13:27:43', '1', '2021-03-26 14:49:03', '', '1010', 'ed0919f0a42e4a07993622037df86a33/101/1010', '30', '000020/000010/000030', '3', 'y', '', '127.0.0.1', '8', '0');
INSERT INTO `sys_menu` VALUES ('roleRemove', '角色删除', '101', '4', '', '', '1', '0', 'F', '0', '0', 'system:role:remove', '#', 'admin', '2021-01-30 13:27:43', '1', '2021-03-26 14:49:11', '', '1011', 'ed0919f0a42e4a07993622037df86a33/101/1011', '40', '000020/000010/000040', '3', 'y', '', '127.0.0.1', '8', '0');
INSERT INTO `sys_menu` VALUES ('roleExport', '角色导出', '101', '5', '', '', '1', '0', 'F', '0', '0', 'system:role:export', '#', 'admin', '2021-01-30 13:27:43', '1', '2021-03-26 14:49:18', '', '1012', 'ed0919f0a42e4a07993622037df86a33/101/1012', '50', '000020/000010/000050', '3', 'y', '', '127.0.0.1', '8', '0');
INSERT INTO `sys_menu` VALUES ('menuQuery', '菜单查询', '102', '1', '', '', '1', '0', 'F', '0', '0', 'system:menu:query', '#', 'admin', '2021-01-30 13:27:43', '1', '2021-03-26 14:49:37', '', '1013', '2ea5441cad6d47679b9029b6ac2d291f/102/1013', '10', '000030/000010/000010', '3', 'y', '', '127.0.0.1', '8', '0');
INSERT INTO `sys_menu` VALUES ('menuAdd', '菜单新增', '102', '2', '', '', '1', '0', 'F', '0', '0', 'system:menu:add', '#', 'admin', '2021-01-30 13:27:43', '1', '2021-03-26 14:49:45', '', '1014', '2ea5441cad6d47679b9029b6ac2d291f/102/1014', '20', '000030/000010/000020', '3', 'y', '', '127.0.0.1', '8', '0');
INSERT INTO `sys_menu` VALUES ('menuEdit', '菜单修改', '102', '3', '', '', '1', '0', 'F', '0', '0', 'system:menu:edit', '#', 'admin', '2021-01-30 13:27:43', '1', '2021-03-26 14:50:00', '', '1015', '2ea5441cad6d47679b9029b6ac2d291f/102/1015', '30', '000030/000010/000030', '3', 'y', '', '127.0.0.1', '8', '0');
INSERT INTO `sys_menu` VALUES ('menuRemove', '菜单删除', '102', '4', '', '', '1', '0', 'F', '0', '0', 'system:menu:remove', '#', 'admin', '2021-01-30 13:27:43', '1', '2021-03-26 14:50:08', '', '1016', '2ea5441cad6d47679b9029b6ac2d291f/102/1016', '40', '000030/000010/000040', '3', 'y', '', '127.0.0.1', '8', '0');
INSERT INTO `sys_menu` VALUES ('deptQuery', '部门查询', '103', '1', '', '', '1', '0', 'F', '0', '0', 'system:dept:query', '#', 'admin', '2021-01-30 13:27:43', '1', '2021-09-04 15:43:41', '', '1017', '8f00f7f7d3b44aaba1041bc8fdf6c470/103/1017', '30', '000010/000020/000030', '3', 'y', '', '127.0.0.1', '10', '0');
INSERT INTO `sys_menu` VALUES ('deptAdd', '部门新增', '103', '2', '', '', '1', '0', 'F', '0', '0', 'system:dept:add', '#', 'admin', '2021-01-30 13:27:43', '1', '2021-09-04 15:43:51', '', '1018', '8f00f7f7d3b44aaba1041bc8fdf6c470/103/1018', '40', '000010/000020/000040', '3', 'y', '', '127.0.0.1', '10', '0');
INSERT INTO `sys_menu` VALUES ('deptEdit', '部门修改', '103', '3', '', '', '1', '0', 'F', '0', '0', 'system:dept:edit', '#', 'admin', '2021-01-30 13:27:43', '1', '2021-09-04 15:43:20', '', '1019', '8f00f7f7d3b44aaba1041bc8fdf6c470/103/1019', '10', '000010/000020/000010', '3', 'y', '', '127.0.0.1', '9', '0');
INSERT INTO `sys_menu` VALUES ('menu-manager', '菜单管理', '2ea5441cad6d47679b9029b6ac2d291f', '3', 'menu', 'system/menu/MenuIndex', '1', '0', 'C', '0', '0', 'system:menu:list', 'bars', 'admin', '2021-01-30 13:27:43', '1', '2021-06-08 10:08:35', '平台所有菜单维护', '102', '2ea5441cad6d47679b9029b6ac2d291f/102', '10', '000030/000010', '2', 'n', '', '127.0.0.1', '14', '0');
INSERT INTO `sys_menu` VALUES ('deptRemove', '部门删除', '103', '4', '', '', '1', '0', 'F', '0', '0', 'system:dept:remove', '#', 'admin', '2021-01-30 13:27:43', '1', '2021-09-04 15:43:31', '', '1020', '8f00f7f7d3b44aaba1041bc8fdf6c470/103/1020', '20', '000010/000020/000020', '3', 'y', '', '127.0.0.1', '9', '0');
INSERT INTO `sys_menu` VALUES ('postQuery', '岗位查询', '104', '1', '', '', '1', '0', 'F', '0', '0', 'system:post:query', '#', 'admin', '2021-01-30 13:27:43', '1', '2021-09-04 15:44:29', '', '1021', '8f00f7f7d3b44aaba1041bc8fdf6c470/104/1021', '10', '000010/000030/000010', '3', 'y', '', '127.0.0.1', '9', '0');
INSERT INTO `sys_menu` VALUES ('postAdd', '岗位新增', '104', '2', '', '', '1', '0', 'F', '0', '0', 'system:post:add', '#', 'admin', '2021-01-30 13:27:43', '1', '2021-09-04 15:44:40', '', '1022', '8f00f7f7d3b44aaba1041bc8fdf6c470/104/1022', '20', '000010/000030/000020', '3', 'y', '', '127.0.0.1', '9', '0');
INSERT INTO `sys_menu` VALUES ('postEdit', '岗位修改', '104', '3', '', '', '1', '0', 'F', '0', '0', 'system:post:edit', '#', 'admin', '2021-01-30 13:27:43', '1', '2021-09-04 15:45:00', '', '1023', '8f00f7f7d3b44aaba1041bc8fdf6c470/104/1023', '30', '000010/000030/000030', '3', 'y', '', '127.0.0.1', '9', '0');
INSERT INTO `sys_menu` VALUES ('postRemove', '岗位删除', '104', '4', '', '', '1', '0', 'F', '0', '0', 'system:post:remove', '#', 'admin', '2021-01-30 13:27:43', '1', '2021-09-04 15:45:36', '', '1024', '8f00f7f7d3b44aaba1041bc8fdf6c470/104/1024', '40', '000010/000030/000040', '3', 'y', '', '127.0.0.1', '9', '0');
INSERT INTO `sys_menu` VALUES ('postExport', '岗位导出', '104', '5', '', '', '1', '0', 'F', '0', '0', 'system:post:export', '#', 'admin', '2021-01-30 13:27:43', '1', '2021-09-04 15:45:48', '', '1025', '8f00f7f7d3b44aaba1041bc8fdf6c470/104/1025', '50', '000010/000030/000050', '3', 'y', '', '127.0.0.1', '9', '0');
INSERT INTO `sys_menu` VALUES ('dictQuery', '字典查询', '105', '1', '#', '', '1', '0', 'F', '0', '0', 'system:dict:query', '#', 'admin', '2021-01-30 13:27:43', '1', '2021-03-26 15:11:42', '', '1026', '2ea5441cad6d47679b9029b6ac2d291f/105/1026', '10', '000030/000020/000010', '3', 'y', '', '127.0.0.1', '9', '0');
INSERT INTO `sys_menu` VALUES ('dictAdd', '字典新增', '105', '2', '#', '', '1', '0', 'F', '0', '0', 'system:dict:add', '#', 'admin', '2021-01-30 13:27:43', '1', '2021-03-26 15:12:08', '', '1027', '2ea5441cad6d47679b9029b6ac2d291f/105/1027', '20', '000030/000020/000020', '3', 'y', '', '127.0.0.1', '8', '0');
INSERT INTO `sys_menu` VALUES ('dictEdit', '字典修改', '105', '3', '#', '', '1', '0', 'F', '0', '0', 'system:dict:edit', '#', 'admin', '2021-01-30 13:27:43', '1', '2021-03-26 15:12:16', '', '1028', '2ea5441cad6d47679b9029b6ac2d291f/105/1028', '30', '000030/000020/000030', '3', 'y', '', '127.0.0.1', '8', '0');
INSERT INTO `sys_menu` VALUES ('dictRemove', '字典删除', '105', '4', '#', '', '1', '0', 'F', '0', '0', 'system:dict:remove', '#', 'admin', '2021-01-30 13:27:43', '1', '2021-03-26 15:12:22', '', '1029', '2ea5441cad6d47679b9029b6ac2d291f/105/1029', '40', '000030/000020/000040', '3', 'y', '', '127.0.0.1', '8', '0');
INSERT INTO `sys_menu` VALUES ('dept-manager', '部门管理', '8f00f7f7d3b44aaba1041bc8fdf6c470', '4', 'dept', 'system/dept/SysDeptIndex', '1', '0', 'C', '0', '0', 'system:dept:list', 'cluster', 'admin', '2021-01-30 13:27:43', '1', '2021-09-04 15:42:58', '部门管理菜单', '103', '8f00f7f7d3b44aaba1041bc8fdf6c470/103', '20', '000010/000020', '2', 'n', '', '127.0.0.1', '13', '0');
INSERT INTO `sys_menu` VALUES ('dictExport', '字典导出', '105', '5', '#', '', '1', '0', 'F', '0', '0', 'system:dict:export', '#', 'admin', '2021-01-30 13:27:43', '1', '2021-03-26 15:12:28', '', '1030', '2ea5441cad6d47679b9029b6ac2d291f/105/1030', '50', '000030/000020/000050', '3', 'y', '', '127.0.0.1', '8', '0');
INSERT INTO `sys_menu` VALUES ('configQuery', '参数查询', '106', '1', '#', '', '1', '0', 'F', '0', '0', 'system:config:query', '#', 'admin', '2021-01-30 13:27:43', '1', '2021-03-26 15:12:37', '', '1031', '2ea5441cad6d47679b9029b6ac2d291f/106/1031', '10', '000030/000030/000010', '3', 'y', '', '127.0.0.1', '7', '0');
INSERT INTO `sys_menu` VALUES ('configAdd', '参数新增', '106', '2', '#', '', '1', '0', 'F', '0', '0', 'system:config:add', '#', 'admin', '2021-01-30 13:27:43', '1', '2021-03-26 15:12:44', '', '1032', '2ea5441cad6d47679b9029b6ac2d291f/106/1032', '20', '000030/000030/000020', '3', 'y', '', '127.0.0.1', '7', '0');
INSERT INTO `sys_menu` VALUES ('configEdit', '参数修改', '106', '3', '#', '', '1', '0', 'F', '0', '0', 'system:config:edit', '#', 'admin', '2021-01-30 13:27:43', '1', '2021-03-26 15:12:50', '', '1033', '2ea5441cad6d47679b9029b6ac2d291f/106/1033', '30', '000030/000030/000030', '3', 'y', '', '127.0.0.1', '7', '0');
INSERT INTO `sys_menu` VALUES ('configRemove', '参数删除', '106', '4', '#', '', '1', '0', 'F', '0', '0', 'system:config:remove', '#', 'admin', '2021-01-30 13:27:43', '1', '2021-03-26 15:12:57', '', '1034', '2ea5441cad6d47679b9029b6ac2d291f/106/1034', '40', '000030/000030/000040', '3', 'y', '', '127.0.0.1', '7', '0');
INSERT INTO `sys_menu` VALUES ('configExport', '参数导出', '106', '5', '#', '', '1', '0', 'F', '0', '0', 'system:config:export', '#', 'admin', '2021-01-30 13:27:43', '1', '2021-03-26 15:13:04', '', '1035', '2ea5441cad6d47679b9029b6ac2d291f/106/1035', '50', '000030/000030/000050', '3', 'y', '', '127.0.0.1', '7', '0');
INSERT INTO `sys_menu` VALUES ('notice-query', '公告查询', '107', '1', '#', '', '1', '0', 'F', '0', '0', 'system:notice:query', '#', 'admin', '2021-01-30 13:27:43', '1', '2021-03-26 15:13:17', '', '1036', 'd8a45047891d4a28a5a3faf96f2b8d97/107/1036', '10', '000090/000010/000010', '3', 'y', '', '127.0.0.1', '7', '0');
INSERT INTO `sys_menu` VALUES ('noticeAdd', '公告新增', '107', '2', '#', '', '1', '0', 'F', '0', '0', 'system:notice:add', '#', 'admin', '2021-01-30 13:27:43', '1', '2021-03-26 15:13:23', '', '1037', 'd8a45047891d4a28a5a3faf96f2b8d97/107/1037', '20', '000090/000010/000020', '3', 'y', '', '127.0.0.1', '7', '0');
INSERT INTO `sys_menu` VALUES ('noticeEdit', '公告修改', '107', '3', '#', '', '1', '0', 'F', '0', '0', 'system:notice:edit', '#', 'admin', '2021-01-30 13:27:43', '1', '2021-03-26 15:13:29', '', '1038', 'd8a45047891d4a28a5a3faf96f2b8d97/107/1038', '30', '000090/000010/000030', '3', 'y', '', '127.0.0.1', '7', '0');
INSERT INTO `sys_menu` VALUES ('noticeRemove', '公告删除', '107', '4', '#', '', '1', '0', 'F', '0', '0', 'system:notice:remove', '#', 'admin', '2021-01-30 13:27:43', '1', '2021-03-26 15:13:36', '', '1039', 'd8a45047891d4a28a5a3faf96f2b8d97/107/1039', '40', '000090/000010/000040', '3', 'y', '', '127.0.0.1', '7', '0');
INSERT INTO `sys_menu` VALUES ('post-manager', '岗位管理', '8f00f7f7d3b44aaba1041bc8fdf6c470', '5', 'post', 'system/post/PostIndex', '1', '0', 'C', '0', '0', 'system:post:list', 'idcard', 'admin', '2021-01-30 13:27:43', '1', '2021-09-04 15:44:09', '岗位管理菜单', '104', '8f00f7f7d3b44aaba1041bc8fdf6c470/104', '30', '000010/000030', '2', 'n', '', '127.0.0.1', '14', '0');
INSERT INTO `sys_menu` VALUES ('operateLogQuery', '操作查询', '500', '1', '#', '', '1', '0', 'F', '0', '0', 'monitor:operlog:query', '#', 'admin', '2021-01-30 13:27:43', '1', '2021-03-26 15:14:05', '', '1040', '108/500/1040', '10', '000070/000010/000010', '3', 'y', '', '127.0.0.1', '7', '0');
INSERT INTO `sys_menu` VALUES ('operateLogRemove', '操作删除', '500', '2', '#', '', '1', '0', 'F', '0', '0', 'monitor:operlog:remove', '#', 'admin', '2021-01-30 13:27:43', '1', '2021-03-26 15:14:13', '', '1041', '108/500/1041', '20', '000070/000010/000020', '3', 'y', '', '127.0.0.1', '7', '0');
INSERT INTO `sys_menu` VALUES ('operateLoExport', '日志导出', '500', '4', '#', '', '1', '0', 'F', '0', '0', 'monitor:operlog:export', '#', 'admin', '2021-01-30 13:27:43', '1', '2021-03-26 15:14:20', '', '1042', '108/500/1042', '30', '000070/000010/000030', '3', 'y', '', '127.0.0.1', '7', '0');
INSERT INTO `sys_menu` VALUES ('loginLogQuery', '登录查询', '501', '1', '#', '', '1', '0', 'F', '0', '0', 'monitor:loginLog:query', '#', 'admin', '2021-01-30 13:27:43', '1', '2021-03-26 15:14:30', '', '1043', '108/501/1043', '10', '000070/000020/000010', '3', 'y', '', '127.0.0.1', '7', '0');
INSERT INTO `sys_menu` VALUES ('loginLogRemove', '登录删除', '501', '2', '#', '', '1', '0', 'F', '0', '0', 'monitor:loginLog:remove', '#', 'admin', '2021-01-30 13:27:43', '1', '2021-03-26 15:14:36', '', '1044', '108/501/1044', '20', '000070/000020/000020', '3', 'y', '', '127.0.0.1', '7', '0');
INSERT INTO `sys_menu` VALUES ('loginLogExport', '日志导出', '501', '3', '#', '', '1', '0', 'F', '0', '0', 'monitor:loginLog:export', '#', 'admin', '2021-01-30 13:27:43', '1', '2021-03-26 15:14:43', '', '1045', '108/501/1045', '30', '000070/000020/000030', '3', 'y', '', '127.0.0.1', '7', '0');
INSERT INTO `sys_menu` VALUES ('onlineQuery', '在线查询', '109', '1', '#', '', '1', '0', 'F', '0', '0', 'monitor:online:query', '#', 'admin', '2021-01-30 13:27:43', '1', '2021-03-26 15:15:40', '', '1046', '2/109/1046', '10', '000080/000010/000010', '3', 'y', '', '127.0.0.1', '6', '0');
INSERT INTO `sys_menu` VALUES ('onlineBatchLogout', '批量强退', '109', '2', '#', '', '1', '0', 'F', '0', '0', 'monitor:online:batchLogout', '#', 'admin', '2021-01-30 13:27:43', '1', '2021-03-26 15:15:47', '', '1047', '2/109/1047', '20', '000080/000010/000020', '3', 'y', '', '127.0.0.1', '6', '0');
INSERT INTO `sys_menu` VALUES ('onlineLogout', '单条强退', '109', '3', '#', '', '1', '0', 'F', '0', '0', 'monitor:online:forceLogout', '#', 'admin', '2021-01-30 13:27:43', '1', '2021-03-26 15:15:54', '', '1048', '2/109/1048', '30', '000080/000010/000030', '3', 'y', '', '127.0.0.1', '6', '0');
INSERT INTO `sys_menu` VALUES ('jobQuery', '任务查询', '110', '1', '#', '', '1', '0', 'F', '0', '0', 'monitor:job:query', '#', 'admin', '2021-01-30 13:27:43', '1', '2021-03-26 15:16:06', '', '1049', '2/110/1049', '10', '000080/000020/000010', '3', 'y', '', '127.0.0.1', '6', '0');
INSERT INTO `sys_menu` VALUES ('dict-manager', '字典管理', '2ea5441cad6d47679b9029b6ac2d291f', '6', 'dict', 'system/dict/DictIndex', '1', '0', 'C', '0', '0', 'system:dict:list', 'read', 'admin', '2021-01-30 13:27:43', '1', '2021-06-08 09:53:17', '字典管理菜单', '105', '2ea5441cad6d47679b9029b6ac2d291f/105', '20', '000030/000020', '2', 'n', '', '127.0.0.1', '12', '0');
INSERT INTO `sys_menu` VALUES ('jobAdd', '任务新增', '110', '2', '#', '', '1', '0', 'F', '0', '0', 'monitor:job:add', '#', 'admin', '2021-01-30 13:27:43', '1', '2021-03-26 15:16:17', '', '1050', '2/110/1050', '20', '000080/000020/000020', '3', 'y', '', '127.0.0.1', '6', '0');
INSERT INTO `sys_menu` VALUES ('jobEdit', '任务修改', '110', '3', '#', '', '1', '0', 'F', '0', '0', 'monitor:job:edit', '#', 'admin', '2021-01-30 13:27:43', '1', '2021-03-26 15:16:25', '', '1051', '2/110/1051', '30', '000080/000020/000030', '3', 'y', '', '127.0.0.1', '6', '0');
INSERT INTO `sys_menu` VALUES ('jobRemove', '任务删除', '110', '4', '#', '', '1', '0', 'F', '0', '0', 'monitor:job:remove', '#', 'admin', '2021-01-30 13:27:43', '1', '2021-03-26 15:16:32', '', '1052', '2/110/1052', '40', '000080/000020/000040', '3', 'y', '', '127.0.0.1', '6', '0');
INSERT INTO `sys_menu` VALUES ('jobChangeStatus', '状态修改', '110', '5', '#', '', '1', '0', 'F', '0', '0', 'monitor:job:changeStatus', '#', 'admin', '2021-01-30 13:27:43', '1', '2021-03-26 15:16:42', '', '1053', '2/110/1053', '50', '000080/000020/000050', '3', 'y', '', '127.0.0.1', '6', '0');
INSERT INTO `sys_menu` VALUES ('jobExport', '任务导出', '110', '7', '#', '', '1', '0', 'F', '0', '0', 'monitor:job:export', '#', 'admin', '2021-01-30 13:27:43', '1', '2021-03-26 15:16:49', '', '1054', '2/110/1054', '60', '000080/000020/000060', '3', 'y', '', '127.0.0.1', '6', '0');
INSERT INTO `sys_menu` VALUES ('genQuery', '生成查询', '115', '1', '#', '', '1', '0', 'F', '0', '0', 'tool:gen:query', '#', 'admin', '2021-01-30 13:27:43', '1', '2021-03-26 15:18:08', '', '1055', '3/115/1055', '10', '000030/000020/000010', '3', 'y', '', '127.0.0.1', '6', '0');
INSERT INTO `sys_menu` VALUES ('genEdit', '生成修改', '115', '2', '#', '', '1', '0', 'F', '0', '0', 'tool:gen:edit', '#', 'admin', '2021-01-30 13:27:43', '1', '2021-03-26 15:18:14', '', '1056', '3/115/1056', '20', '000030/000020/000020', '3', 'y', '', '127.0.0.1', '6', '0');
INSERT INTO `sys_menu` VALUES ('genRemove', '生成删除', '115', '3', '#', '', '1', '0', 'F', '0', '0', 'tool:gen:remove', '#', 'admin', '2021-01-30 13:27:43', '1', '2021-03-26 15:18:23', '', '1057', '3/115/1057', '30', '000030/000020/000030', '3', 'y', '', '127.0.0.1', '6', '0');
INSERT INTO `sys_menu` VALUES ('genImport', '导入代码', '115', '2', '#', '', '1', '0', 'F', '0', '0', 'tool:gen:import', '#', 'admin', '2021-01-30 13:27:43', '1', '2021-03-26 15:18:30', '', '1058', '3/115/1058', '40', '000030/000020/000040', '3', 'y', '', '127.0.0.1', '6', '0');
INSERT INTO `sys_menu` VALUES ('genPreview', '预览代码', '115', '4', '#', '', '1', '0', 'F', '0', '0', 'tool:gen:preview', '#', 'admin', '2021-01-30 13:27:43', '1', '2021-03-26 15:18:38', '', '1059', '3/115/1059', '50', '000030/000020/000050', '3', 'y', '', '127.0.0.1', '6', '0');
INSERT INTO `sys_menu` VALUES ('config-manager', '参数设置', '2ea5441cad6d47679b9029b6ac2d291f', '7', 'config', 'system/config/ConfigIndex', '1', '0', 'C', '0', '0', 'system:config:list', 'code', 'admin', '2021-01-30 13:27:43', '1', '2021-06-08 09:53:33', '参数设置菜单', '106', '2ea5441cad6d47679b9029b6ac2d291f/106', '30', '000030/000030', '2', 'n', '', '127.0.0.1', '12', '0');
INSERT INTO `sys_menu` VALUES ('gen-code', '生成代码', '115', '5', '#', '', '1', '0', 'F', '0', '0', 'tool:gen:code', '#', 'admin', '2021-01-30 13:27:43', '1', '2021-03-26 15:18:45', '', '1060', '3/115/1060', '60', '000030/000020/000060', '3', 'y', '', '127.0.0.1', '6', '0');
INSERT INTO `sys_menu` VALUES ('notice-manager', '通知公告', 'd8a45047891d4a28a5a3faf96f2b8d97', '8', 'notice', 'system/notice/NoticeIndex', '1', '0', 'C', '0', '0', 'system:notice:list', 'notification', 'admin', '2021-01-30 13:27:43', '1', '2021-06-08 10:05:31', '通知公告菜单', '107', 'd8a45047891d4a28a5a3faf96f2b8d97/107', '10', '000090/000010', '2', 'n', '', '127.0.0.1', '11', '0');
INSERT INTO `sys_menu` VALUES ('system-log', '日志管理', '0', '9', 'log', '', '1', '0', 'M', '0', '0', '', 'copy', 'admin', '2021-01-30 13:27:43', '1', '2021-09-17 17:29:29', '日志管理菜单', '108', '108', '70', '000070', '1', 'n', '', '127.0.0.1', '12', '0');
INSERT INTO `sys_menu` VALUES ('online-user', '在线用户', '2', '1', 'online', 'monitor/online/index', '1', '0', 'C', '0', '0', 'monitor:online:list', 'dot-chart', 'admin', '2021-01-30 13:27:43', '1', '2021-04-23 10:38:59', '在线用户菜单', '109', '2/109', '10', '000080/000010', '2', 'n', '', '127.0.0.1', '7', '0');
INSERT INTO `sys_menu` VALUES ('job-manager', '定时任务', '2', '2', 'job', 'monitor/job/index', '1', '0', 'C', '0', '0', 'monitor:job:list', 'bar-chart', 'admin', '2021-01-30 13:27:43', '1', '2021-04-23 10:39:25', '定时任务菜单', '110', '2/110', '20', '000080/000020', '2', 'n', '', '127.0.0.1', '7', '0');
INSERT INTO `sys_menu` VALUES ('druid-monitor', '数据监控', '2', '3', 'druid', 'monitor/druid/index', '1', '0', 'C', '0', '0', 'monitor:druid:list', 'dashboard', 'admin', '2021-01-30 13:27:43', '1', '2021-04-23 10:52:49', '数据监控菜单', '111', '2/111', '30', '000080/000030', '2', 'y', '', '127.0.0.1', '8', '0');
INSERT INTO `sys_menu` VALUES ('server-monitor', '服务监控', '2', '4', 'server', 'monitor/server/index', '1', '0', 'C', '0', '0', 'monitor:server:list', 'pie-chart', 'admin', '2021-01-30 13:27:43', '1', '2021-04-23 10:41:17', '服务监控菜单', '112', '2/112', '40', '000080/000040', '2', 'y', '', '127.0.0.1', '6', '0');
INSERT INTO `sys_menu` VALUES ('cache-monitor', '缓存监控', '2', '5', 'cache', 'monitor/cache/index', '1', '0', 'C', '0', '0', 'monitor:cache:list', 'box-plot', 'admin', '2021-01-30 13:27:43', '1', '2021-04-23 10:41:35', '缓存监控菜单', '113', '2/113', '50', '000080/000050', '2', 'y', '', '127.0.0.1', '6', '0');
INSERT INTO `sys_menu` VALUES ('form-generate', '表单构建', '3', '1', 'build', 'tool/build/index', '1', '0', 'C', '0', '0', 'tool:build:list', 'bars', 'admin', '2021-01-30 13:27:43', '1', '2021-04-23 10:41:50', '表单构建菜单', '114', '3/114', '10', '000030/000010', '2', 'y', '', '127.0.0.1', '6', '0');
INSERT INTO `sys_menu` VALUES ('code-gen', '代码生成', '3', '2', 'gen', 'tool/gen/index', '1', '0', 'C', '0', '0', 'tool:gen:list', 'code', 'admin', '2021-01-30 13:27:43', '1', '2021-03-26 15:17:26', '代码生成菜单', '115', '3/115', '20', '000030/000020', '2', 'n', '', '127.0.0.1', '6', '0');
INSERT INTO `sys_menu` VALUES ('saggger-manager', '系统接口', '3', '3', 'swagger', 'tool/swagger/index', '1', '0', 'C', '0', '0', 'tool:swagger:list', 'api', 'admin', '2021-01-30 13:27:43', '1', '2021-04-23 10:42:53', '系统接口菜单', '116', '3/116', '30', '000030/000030', '2', 'y', '', '127.0.0.1', '6', '0');
INSERT INTO `sys_menu` VALUES ('auth-center', '菜单授权', 'ed0919f0a42e4a07993622037df86a33', '0', 'sysAuth', 'system/role/SysRoleAuth', '1', '0', 'C', '0', '0', '', 'api', '1', '2021-06-04 13:44:30', '1', '2021-09-13 08:52:05', '', '1f89001d84ba48dcb41abc13cccc67e4', 'ed0919f0a42e4a07993622037df86a33/1f89001d84ba48dcb41abc13cccc67e4', '30', '000020/000030', '2', 'y', '100', '127.0.0.1', '7', '0');
INSERT INTO `sys_menu` VALUES ('system_monitor', '系统监控', '0', '2', 'monitor', '', '1', '0', 'M', '0', '0', '', 'fund', 'admin', '2021-01-30 13:27:43', '1', '2021-09-17 17:31:24', '系统监控目录', '2', '2', '80', '000080', '1', 'n', '', '127.0.0.1', '12', '0');
INSERT INTO `sys_menu` VALUES ('system-setting', '系统设置', '0', '0', 'sysSetting', '', '1', '0', 'M', '0', '0', '', 'setting', '1', '2021-06-08 09:52:35', '1', '2021-09-17 17:32:25', '', '2ea5441cad6d47679b9029b6ac2d291f', '2ea5441cad6d47679b9029b6ac2d291f', '30', '000030', '1', 'n', '100', '127.0.0.1', '10', '0');
INSERT INTO `sys_menu` VALUES ('system_tool', '系统工具', '0', '3', 'tool', '', '1', '0', 'M', '0', '0', '', 'appstore', 'admin', '2021-01-30 13:27:43', '1', '2021-09-04 10:34:25', '系统工具目录', '3', '3', '30', '000030', '1', 'n', '', '127.0.0.1', '9', '0');
INSERT INTO `sys_menu` VALUES ('simcard_oper_log', '卡操作日志查询', '76262a407245454492ccb8b100976ae9', '0', '', '', '1', '0', 'F', '0', '0', 'm2mSimcardOperLogQuery', '', '1', '2021-08-02 09:05:32', '1', '2021-08-02 09:05:32', '', '330d1940a6a64dc7adcfa03fc9f57d25', '2dc9dcc092134fb18d15cb4966100b39/76262a407245454492ccb8b100976ae9/330d1940a6a64dc7adcfa03fc9f57d25', '20', '000210/000030/000020', '3', 'y', '100', '127.0.0.1', '1', '0');
INSERT INTO `sys_menu` VALUES ('sys-operate-log', '操作日志', '108', '1', 'operlog', 'monitor/operlog/OperlogIndex', '1', '0', 'C', '0', '0', 'monitor:operlog:list', 'form', 'admin', '2021-01-30 13:27:43', '1', '2021-04-02 10:06:43', '操作日志菜单', '500', '108/500', '10', '000070/000010', '2', 'n', '', '127.0.0.1', '8', '0');
INSERT INTO `sys_menu` VALUES ('sys-login-log', '登录日志', '108', '2', 'loginLog', 'monitor/loginlog/LoginLogIndex', '1', '0', 'C', '0', '0', 'monitor:loginLog:list', 'loginLog', 'admin', '2021-01-30 13:27:43', '1', '2021-04-02 10:07:05', '登录日志菜单', '501', '108/501', '20', '000070/000020', '2', 'n', '', '127.0.0.1', '9', '0');
INSERT INTO `sys_menu` VALUES ('simcard-query', 'SIM卡查看', '76262a407245454492ccb8b100976ae9', '0', '', '', '1', '0', 'F', '0', '0', 'iot:m2mSimcard:query', '', '1', '2021-08-02 09:04:36', '1', '2021-08-02 09:04:36', '', '56b65ea40f9b4385991383fd766b5c06', '2dc9dcc092134fb18d15cb4966100b39/76262a407245454492ccb8b100976ae9/56b65ea40f9b4385991383fd766b5c06', '10', '000210/000030/000010', '3', 'y', '100', '127.0.0.1', '1', '0');
INSERT INTO `sys_menu` VALUES ('simcard-list', '卡列表查询', '76262a407245454492ccb8b100976ae9', '0', '', '', '1', '0', 'F', '0', '0', 'iot:m2mSimcard:list', '', '1', '2021-08-02 13:52:45', '1', '2021-08-02 13:52:45', '', '652e86f6905d478e924f0641ebe88874', '2dc9dcc092134fb18d15cb4966100b39/76262a407245454492ccb8b100976ae9/652e86f6905d478e924f0641ebe88874', '30', '000210/000030/000030', '3', 'y', '100', '127.0.0.1', '1', '0');
INSERT INTO `sys_menu` VALUES ('sys-job-log', '调度日志', '108', '0', 'joblog', 'monitor/job/log', '1', '0', 'C', '0', '0', '', 'bug', '1', '2021-06-18 16:39:15', '1', '2021-06-18 16:42:49', '', '67c8d43a175040a5874439d1516308da', '108/67c8d43a175040a5874439d1516308da', '30', '000070/000030', '2', 'y', '100', '127.0.0.1', '5', '0');
INSERT INTO `sys_menu` VALUES ('cache-manager', '缓存列表', '2', '0', 'cacheList', 'monitor/cache/indexCacheList', '1', '0', 'C', '0', '0', '', 'dashboardNew', '1', '2021-08-05 14:51:44', '1', '2021-08-05 14:53:53', null, '7e00c054a0d34baea9dbcec52f239d25', '2/7e00c054a0d34baea9dbcec52f239d25', '55', '000080/000055', '2', 'y', '100', '127.0.0.1', '2', '0');
INSERT INTO `sys_menu` VALUES ('org-manager', '组织管理', '0', '0', 'org', '', '1', '0', 'M', '0', '0', '', 'appstore', '1', '2021-06-08 09:31:04', '1', '2021-09-17 17:30:13', '', '8f00f7f7d3b44aaba1041bc8fdf6c470', '8f00f7f7d3b44aaba1041bc8fdf6c470', '10', '000010', '1', 'n', '100', '127.0.0.1', '6', '0');
INSERT INTO `sys_menu` VALUES ('genconfig-template', '模板配置', '3', '0', 'template', 'tool/gen/genconfigtemplate/index', '1', '0', 'C', '0', '0', '', 'picture', '1', '2021-03-07 12:28:59', '1', '2021-04-23 10:43:18', '', 'c9d88c5c57494bfcac8137ffd0aa3121', '3/c9d88c5c57494bfcac8137ffd0aa3121', '40', '000030/000040', '2', 'y', '100', '127.0.0.1', '6', '0');
INSERT INTO `sys_menu` VALUES ('system-app', '系统应用', '0', '0', 'sysApp', '', '1', '0', 'M', '0', '0', '', 'laptop', '1', '2021-06-08 10:05:01', '1', '2021-09-17 17:29:53', '', 'd8a45047891d4a28a5a3faf96f2b8d97', 'd8a45047891d4a28a5a3faf96f2b8d97', '90', '000090', '1', 'n', '100', '127.0.0.1', '8', '0');
INSERT INTO `sys_menu` VALUES ('auth-manager', '权限管理', '0', '0', 'auth', '', '1', '0', 'M', '0', '0', '', 'solution', '1', '2021-06-08 09:49:56', '1', '2021-09-17 17:30:52', '', 'ed0919f0a42e4a07993622037df86a33', 'ed0919f0a42e4a07993622037df86a33', '20', '000020', '1', 'n', '100', '127.0.0.1', '7', '0');
INSERT INTO `sys_menu` VALUES ('admin-oper', '管理员操作权限', 'ed9087f850894d21bb41044c8b95d415', '0', '', '', '1', '0', 'F', '0', '0', 'company:m2mCompany:admin', '', '1', '2021-07-27 09:08:52', '1', '2021-08-02 09:05:49', '', 'fa6c148d7bec4c31aa46b7a73d575af3', '51634d802b134c88834cebe9547c599f/ed9087f850894d21bb41044c8b95d415/fa6c148d7bec4c31aa46b7a73d575af3', '60', '000200/000010/000060', '3', 'y', '100', '127.0.0.1', '3', '0');

-- ----------------------------
-- Table structure for `sys_notice`
-- ----------------------------
DROP TABLE IF EXISTS `sys_notice`;
CREATE TABLE `sys_notice` (
  `id` varchar(64) NOT NULL COMMENT 'id',
  `notice_title` varchar(50) NOT NULL COMMENT '公告标题',
  `notice_type` char(1) NOT NULL COMMENT '公告类型（1通知 2公告）',
  `notice_content` longblob COMMENT '公告内容',
  `notice_content_html` longblob COMMENT '公告内容HTML',
  `status` char(1) DEFAULT '0' COMMENT '公告状态（0正常 1关闭）',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  `version` int(11) DEFAULT NULL COMMENT '版本',
  `del_flag` char(1) DEFAULT '0' COMMENT '删除标志（0代表存在 1代表删除）',
  `update_ip` varchar(50) DEFAULT NULL COMMENT '更新IP',
  `create_dept` varchar(64) DEFAULT NULL COMMENT '创建部门',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='通知公告表';

-- ----------------------------
-- Records of sys_notice
-- ----------------------------

-- ----------------------------
-- Table structure for `sys_notice_user_read`
-- ----------------------------
DROP TABLE IF EXISTS `sys_notice_user_read`;
CREATE TABLE `sys_notice_user_read` (
  `id` varchar(64) NOT NULL COMMENT '岗位ID',
  `notice_id` varchar(64) NOT NULL COMMENT '通知公告ID',
  `user_id` varchar(64) NOT NULL COMMENT '系统用户id',
  `is_read` varchar(10) DEFAULT NULL COMMENT '是否已读（0未读，1已读），仅在制定通知接收人时使用',
  `status` char(1) NOT NULL COMMENT '状态',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_dept` varchar(64) DEFAULT NULL COMMENT '创建部门',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `update_ip` varchar(50) DEFAULT NULL COMMENT '更新IP',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  `version` int(11) DEFAULT NULL COMMENT '版本',
  `del_flag` char(1) DEFAULT '0' COMMENT '删除标志（0代表存在 1代表删除）',
  PRIMARY KEY (`id`),
  UNIQUE KEY `index2` (`notice_id`,`user_id`,`is_read`,`status`,`del_flag`),
  KEY `index1` (`notice_id`,`user_id`,`is_read`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='通知公告用户阅读表';

-- ----------------------------
-- Records of sys_notice_user_read
-- ----------------------------

-- ----------------------------
-- Table structure for `sys_oper_log`
-- ----------------------------
DROP TABLE IF EXISTS `sys_oper_log`;
CREATE TABLE `sys_oper_log` (
  `title` varchar(50) DEFAULT '' COMMENT '模块标题',
  `business_type` int(2) DEFAULT '0' COMMENT '业务类型（0其它 1新增 2修改 3删除）',
  `method` varchar(100) DEFAULT '' COMMENT '方法名称',
  `request_method` varchar(10) DEFAULT '' COMMENT '请求方式',
  `operator_type` int(1) DEFAULT '0' COMMENT '操作类别（0其它 1后台用户 2手机端用户）',
  `oper_name` varchar(50) DEFAULT '' COMMENT '操作人员',
  `dept_name` varchar(50) DEFAULT '' COMMENT '部门名称',
  `oper_url` varchar(255) DEFAULT '' COMMENT '请求URL',
  `oper_ip` varchar(50) DEFAULT '' COMMENT '主机地址',
  `oper_location` varchar(255) DEFAULT '' COMMENT '操作地点',
  `oper_param` varchar(2000) DEFAULT '' COMMENT '请求参数',
  `json_result` text,
  `log_content` text,
  `status` int(1) DEFAULT '0' COMMENT '操作状态（0正常 1异常）',
  `error_msg` varchar(2000) DEFAULT '' COMMENT '错误消息',
  `oper_time` datetime DEFAULT NULL COMMENT '操作时间',
  `id` varchar(64) NOT NULL COMMENT '岗位ID',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  `oper_id` bigint(20) DEFAULT NULL COMMENT '任务ID',
  `del_flag` char(1) DEFAULT '0' COMMENT '删除标志（0代表存在 1代表删除）',
  `form_id` varchar(64) DEFAULT NULL,
  `take_up_time` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_formId` (`form_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='操作日志记录';

-- ----------------------------
-- Records of sys_oper_log
-- ----------------------------
INSERT INTO `sys_oper_log` VALUES ('多栏目门户配置', '2', 'com.aidex.web.controller.system.SysPortalConfigController.updateDefaultPortalConfig()', 'PUT', '1', 'admin', null, '/system/sysPortalConfig/updateDefaultPortalConfig', '127.0.0.1', '内网IP', '{\"applicationRange\":\"U\",\"resourceId\":\"1\",\"code\":\"6c297eb4651940edbb45c87c75be00d7\",\"recordLog\":true,\"delFlag\":\"0\",\"content\":\"[{\\\"id\\\":\\\"4ae60dd1debe462096698e1da993317a\\\",\\\"x\\\":0,\\\"y\\\":0,\\\"w\\\":3,\\\"h\\\":262,\\\"i\\\":\\\"4ae60dd1debe462096698e1da993317a\\\",\\\"key\\\":\\\"kuaijierukou\\\",\\\"isShowTitle\\\":\\\"N\\\",\\\"isAllowDrag\\\":false,\\\"name\\\":\\\"快捷入口\\\",\\\"type\\\":\\\"smallPage\\\",\\\"url\\\":\\\"dashboard/portal/CommonUse\\\",\\\"options\\\":\\\"{\\\\\\\"titleRequired\\\\\\\":true,\\\\\\\"moreUrl\\\\\\\":\\\\\\\"\\\\\\\",\\\\\\\"refresh\\\\\\\":1}\\\",\\\"moved\\\":false},{\\\"id\\\":\\\"fd7290c27f644234b38d18faf5d75783\\\",\\\"x\\\":0,\\\"y\\\":262,\\\"w\\\":3,\\\"h\\\":1370,\\\"i\\\":\\\"fd7290c27f644234b38d18faf5d75783\\\",\\\"key\\\":\\\"todo\\\",\\\"isShowTitle\\\":\\\"N\\\",\\\"isAllowDrag\\\":true,\\\"name\\\":\\\"待办小页\\\",\\\"type\\\":\\\"smallPage\\\",\\\"url\\\":\\\"dashboard/portal/ToDo\\\",\\\"options\\\":\\\"{\\\\\\\"titleRequired\\\\\\\":true,\\\\\\\"moreUrl\\\\\\\":\\\\\\\"\\\\\\\",\\\\\\\"refresh\\\\\\\":1}\\\",\\\"moved\\\":false}]\",\"id\":\"73c217ba0fb24945a8faef74eb10d302\",\"params\":{},\"isDefault\":\"Y\",\"name\":\"首页\",\"systemDefinedId\":\"app1\",\"status\":\"0\"}', '{\"code\":200,\"data\":{\"applicationRange\":\"U\",\"code\":\"6c297eb4651940edbb45c87c75be00d7\",\"content\":\"[{\\\"id\\\":\\\"4ae60dd1debe462096698e1da993317a\\\",\\\"x\\\":0,\\\"y\\\":0,\\\"w\\\":3,\\\"h\\\":262,\\\"i\\\":\\\"4ae60dd1debe462096698e1da993317a\\\",\\\"key\\\":\\\"kuaijierukou\\\",\\\"isShowTitle\\\":\\\"N\\\",\\\"isAllowDrag\\\":false,\\\"name\\\":\\\"快捷入口\\\",\\\"type\\\":\\\"smallPage\\\",\\\"url\\\":\\\"dashboard/portal/CommonUse\\\",\\\"options\\\":\\\"{\\\\\\\"titleRequired\\\\\\\":true,\\\\\\\"moreUrl\\\\\\\":\\\\\\\"\\\\\\\",\\\\\\\"refresh\\\\\\\":1}\\\",\\\"moved\\\":false},{\\\"id\\\":\\\"fd7290c27f644234b38d18faf5d75783\\\",\\\"x\\\":0,\\\"y\\\":262,\\\"w\\\":3,\\\"h\\\":1370,\\\"i\\\":\\\"fd7290c27f644234b38d18faf5d75783\\\",\\\"key\\\":\\\"todo\\\",\\\"isShowTitle\\\":\\\"N\\\",\\\"isAllowDrag\\\":true,\\\"name\\\":\\\"待办小页\\\",\\\"type\\\":\\\"smallPage\\\",\\\"url\\\":\\\"dashboard/portal/ToDo\\\",\\\"options\\\":\\\"{\\\\\\\"titleRequired\\\\\\\":true,\\\\\\\"moreUrl\\\\\\\":\\\\\\\"\\\\\\\",\\\\\\\"refresh\\\\\\\":1}\\\",\\\"moved\\\":false}]\",\"delFlag\":\"0\",\"id\":\"73c217ba0fb24945a8faef74eb10d302\",\"isDefault\":\"Y\",\"name\":\"首页\",\"params\":{},\"recordLog\":true,\"resourceId\":\"1\",\"status\":\"0\",\"systemDefinedId\":\"app1\"}}', null, '0', null, '2021-09-23 14:05:29', '1a5f70348b524df28c0abfe0209d4f30', null, null, '0', null, '13');
INSERT INTO `sys_oper_log` VALUES ('多栏目门户配置', '2', 'com.aidex.web.controller.system.SysPortalConfigController.updateDefaultPortalConfig()', 'PUT', '1', 'admin', null, '/system/sysPortalConfig/updateDefaultPortalConfig', '127.0.0.1', '内网IP', '{\"applicationRange\":\"U\",\"resourceId\":\"1\",\"code\":\"6c297eb4651940edbb45c87c75be00d7\",\"recordLog\":true,\"delFlag\":\"0\",\"content\":\"[{\\\"id\\\":\\\"4ae60dd1debe462096698e1da993317a\\\",\\\"x\\\":0,\\\"y\\\":0,\\\"w\\\":3,\\\"h\\\":262,\\\"i\\\":\\\"4ae60dd1debe462096698e1da993317a\\\",\\\"key\\\":\\\"kuaijierukou\\\",\\\"isShowTitle\\\":\\\"N\\\",\\\"isAllowDrag\\\":false,\\\"name\\\":\\\"快捷入口\\\",\\\"type\\\":\\\"smallPage\\\",\\\"url\\\":\\\"dashboard/portal/CommonUse\\\",\\\"options\\\":\\\"{\\\\\\\"titleRequired\\\\\\\":true,\\\\\\\"moreUrl\\\\\\\":\\\\\\\"\\\\\\\",\\\\\\\"refresh\\\\\\\":1}\\\",\\\"moved\\\":false},{\\\"id\\\":\\\"fd7290c27f644234b38d18faf5d75783\\\",\\\"x\\\":0,\\\"y\\\":262,\\\"w\\\":3,\\\"h\\\":1370,\\\"i\\\":\\\"fd7290c27f644234b38d18faf5d75783\\\",\\\"key\\\":\\\"todo\\\",\\\"isShowTitle\\\":\\\"N\\\",\\\"isAllowDrag\\\":true,\\\"name\\\":\\\"待办小页\\\",\\\"type\\\":\\\"smallPage\\\",\\\"url\\\":\\\"dashboard/portal/ToDo\\\",\\\"options\\\":\\\"{\\\\\\\"titleRequired\\\\\\\":true,\\\\\\\"moreUrl\\\\\\\":\\\\\\\"\\\\\\\",\\\\\\\"refresh\\\\\\\":1}\\\",\\\"moved\\\":false}]\",\"id\":\"73c217ba0fb24945a8faef74eb10d302\",\"params\":{},\"isDefault\":\"Y\",\"name\":\"首页\",\"systemDefinedId\":\"app1\",\"status\":\"0\"}', '{\"code\":200,\"data\":{\"applicationRange\":\"U\",\"code\":\"6c297eb4651940edbb45c87c75be00d7\",\"content\":\"[{\\\"id\\\":\\\"4ae60dd1debe462096698e1da993317a\\\",\\\"x\\\":0,\\\"y\\\":0,\\\"w\\\":3,\\\"h\\\":262,\\\"i\\\":\\\"4ae60dd1debe462096698e1da993317a\\\",\\\"key\\\":\\\"kuaijierukou\\\",\\\"isShowTitle\\\":\\\"N\\\",\\\"isAllowDrag\\\":false,\\\"name\\\":\\\"快捷入口\\\",\\\"type\\\":\\\"smallPage\\\",\\\"url\\\":\\\"dashboard/portal/CommonUse\\\",\\\"options\\\":\\\"{\\\\\\\"titleRequired\\\\\\\":true,\\\\\\\"moreUrl\\\\\\\":\\\\\\\"\\\\\\\",\\\\\\\"refresh\\\\\\\":1}\\\",\\\"moved\\\":false},{\\\"id\\\":\\\"fd7290c27f644234b38d18faf5d75783\\\",\\\"x\\\":0,\\\"y\\\":262,\\\"w\\\":3,\\\"h\\\":1370,\\\"i\\\":\\\"fd7290c27f644234b38d18faf5d75783\\\",\\\"key\\\":\\\"todo\\\",\\\"isShowTitle\\\":\\\"N\\\",\\\"isAllowDrag\\\":true,\\\"name\\\":\\\"待办小页\\\",\\\"type\\\":\\\"smallPage\\\",\\\"url\\\":\\\"dashboard/portal/ToDo\\\",\\\"options\\\":\\\"{\\\\\\\"titleRequired\\\\\\\":true,\\\\\\\"moreUrl\\\\\\\":\\\\\\\"\\\\\\\",\\\\\\\"refresh\\\\\\\":1}\\\",\\\"moved\\\":false}]\",\"delFlag\":\"0\",\"id\":\"73c217ba0fb24945a8faef74eb10d302\",\"isDefault\":\"Y\",\"name\":\"首页\",\"params\":{},\"recordLog\":true,\"resourceId\":\"1\",\"status\":\"0\",\"systemDefinedId\":\"app1\"}}', null, '0', null, '2021-09-23 14:08:37', '40732c5c23e44c17ab2bf1d9333ae02e', null, null, '0', null, '11');
INSERT INTO `sys_oper_log` VALUES ('多栏目门户配置', '2', 'com.aidex.web.controller.system.SysPortalConfigController.updateDefaultPortalConfig()', 'PUT', '1', 'admin', null, '/system/sysPortalConfig/updateDefaultPortalConfig', '127.0.0.1', '内网IP', '{\"applicationRange\":\"U\",\"resourceId\":\"1\",\"code\":\"6c297eb4651940edbb45c87c75be00d7\",\"recordLog\":true,\"delFlag\":\"0\",\"content\":\"[{\\\"id\\\":\\\"4ae60dd1debe462096698e1da993317a\\\",\\\"x\\\":0,\\\"y\\\":0,\\\"w\\\":3,\\\"h\\\":262,\\\"i\\\":\\\"4ae60dd1debe462096698e1da993317a\\\",\\\"key\\\":\\\"kuaijierukou\\\",\\\"isShowTitle\\\":\\\"N\\\",\\\"isAllowDrag\\\":false,\\\"name\\\":\\\"快捷入口\\\",\\\"type\\\":\\\"smallPage\\\",\\\"url\\\":\\\"dashboard/portal/CommonUse\\\",\\\"options\\\":\\\"{\\\\\\\"titleRequired\\\\\\\":true,\\\\\\\"moreUrl\\\\\\\":\\\\\\\"\\\\\\\",\\\\\\\"refresh\\\\\\\":1}\\\",\\\"moved\\\":false},{\\\"id\\\":\\\"fd7290c27f644234b38d18faf5d75783\\\",\\\"x\\\":0,\\\"y\\\":262,\\\"w\\\":3,\\\"h\\\":1370,\\\"i\\\":\\\"fd7290c27f644234b38d18faf5d75783\\\",\\\"key\\\":\\\"todo\\\",\\\"isShowTitle\\\":\\\"N\\\",\\\"isAllowDrag\\\":true,\\\"name\\\":\\\"待办小页\\\",\\\"type\\\":\\\"smallPage\\\",\\\"url\\\":\\\"dashboard/portal/ToDo\\\",\\\"options\\\":\\\"{\\\\\\\"titleRequired\\\\\\\":true,\\\\\\\"moreUrl\\\\\\\":\\\\\\\"\\\\\\\",\\\\\\\"refresh\\\\\\\":1}\\\",\\\"moved\\\":false}]\",\"id\":\"73c217ba0fb24945a8faef74eb10d302\",\"params\":{},\"isDefault\":\"Y\",\"name\":\"首页\",\"systemDefinedId\":\"app1\",\"status\":\"0\"}', '{\"code\":200,\"data\":{\"applicationRange\":\"U\",\"code\":\"6c297eb4651940edbb45c87c75be00d7\",\"content\":\"[{\\\"id\\\":\\\"4ae60dd1debe462096698e1da993317a\\\",\\\"x\\\":0,\\\"y\\\":0,\\\"w\\\":3,\\\"h\\\":262,\\\"i\\\":\\\"4ae60dd1debe462096698e1da993317a\\\",\\\"key\\\":\\\"kuaijierukou\\\",\\\"isShowTitle\\\":\\\"N\\\",\\\"isAllowDrag\\\":false,\\\"name\\\":\\\"快捷入口\\\",\\\"type\\\":\\\"smallPage\\\",\\\"url\\\":\\\"dashboard/portal/CommonUse\\\",\\\"options\\\":\\\"{\\\\\\\"titleRequired\\\\\\\":true,\\\\\\\"moreUrl\\\\\\\":\\\\\\\"\\\\\\\",\\\\\\\"refresh\\\\\\\":1}\\\",\\\"moved\\\":false},{\\\"id\\\":\\\"fd7290c27f644234b38d18faf5d75783\\\",\\\"x\\\":0,\\\"y\\\":262,\\\"w\\\":3,\\\"h\\\":1370,\\\"i\\\":\\\"fd7290c27f644234b38d18faf5d75783\\\",\\\"key\\\":\\\"todo\\\",\\\"isShowTitle\\\":\\\"N\\\",\\\"isAllowDrag\\\":true,\\\"name\\\":\\\"待办小页\\\",\\\"type\\\":\\\"smallPage\\\",\\\"url\\\":\\\"dashboard/portal/ToDo\\\",\\\"options\\\":\\\"{\\\\\\\"titleRequired\\\\\\\":true,\\\\\\\"moreUrl\\\\\\\":\\\\\\\"\\\\\\\",\\\\\\\"refresh\\\\\\\":1}\\\",\\\"moved\\\":false}]\",\"delFlag\":\"0\",\"id\":\"73c217ba0fb24945a8faef74eb10d302\",\"isDefault\":\"Y\",\"name\":\"首页\",\"params\":{},\"recordLog\":true,\"resourceId\":\"1\",\"status\":\"0\",\"systemDefinedId\":\"app1\"}}', null, '0', null, '2021-09-23 13:52:42', '4565b37b5a0e49f9a8ddd1e968e5cae2', null, null, '0', null, '8');

-- ----------------------------
-- Table structure for `sys_portal_config`
-- ----------------------------
DROP TABLE IF EXISTS `sys_portal_config`;
CREATE TABLE `sys_portal_config` (
  `id` varchar(64) NOT NULL COMMENT '岗位ID',
  `name` varchar(200) NOT NULL COMMENT '小页名称',
  `code` varchar(64) NOT NULL COMMENT '小页编码',
  `application_range` varchar(20) DEFAULT NULL COMMENT '应用范围(S系统,R角色,U用户)',
  `is_default` varchar(10) DEFAULT NULL COMMENT '是否默认',
  `resource_id` varchar(64) DEFAULT NULL COMMENT '资源ID(角色ID或者用户ID)',
  `system_defined_id` varchar(64) DEFAULT NULL COMMENT '系统定义ID区分系统定义和用户自定义',
  `content` text COMMENT '配置信息',
  `sort` int(11) DEFAULT NULL COMMENT '排序',
  `status` char(1) NOT NULL COMMENT '状态',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_dept` varchar(64) DEFAULT NULL COMMENT '创建部门',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `update_ip` varchar(50) DEFAULT NULL COMMENT '更新IP',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  `version` int(11) DEFAULT NULL COMMENT '版本',
  `del_flag` char(1) DEFAULT '0' COMMENT '删除标志（0代表存在 1代表删除）',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='多栏目门户配置';

-- ----------------------------
-- Records of sys_portal_config
-- ----------------------------
INSERT INTO `sys_portal_config` VALUES ('73c217ba0fb24945a8faef74eb10d302', '首页', '6c297eb4651940edbb45c87c75be00d7', 'U', 'Y', '1', 'app1', '[{\"id\":\"4ae60dd1debe462096698e1da993317a\",\"x\":0,\"y\":0,\"w\":3,\"h\":262,\"i\":\"4ae60dd1debe462096698e1da993317a\",\"key\":\"kuaijierukou\",\"isShowTitle\":\"N\",\"isAllowDrag\":false,\"name\":\"快捷入口\",\"type\":\"smallPage\",\"url\":\"dashboard/portal/CommonUse\",\"options\":\"{\\\"titleRequired\\\":true,\\\"moreUrl\\\":\\\"\\\",\\\"refresh\\\":1}\",\"moved\":false},{\"id\":\"fd7290c27f644234b38d18faf5d75783\",\"x\":0,\"y\":262,\"w\":3,\"h\":1370,\"i\":\"fd7290c27f644234b38d18faf5d75783\",\"key\":\"todo\",\"isShowTitle\":\"N\",\"isAllowDrag\":true,\"name\":\"待办小页\",\"type\":\"smallPage\",\"url\":\"dashboard/portal/ToDo\",\"options\":\"{\\\"titleRequired\\\":true,\\\"moreUrl\\\":\\\"\\\",\\\"refresh\\\":1}\",\"moved\":false}]', null, '0', '1', '100', '2021-09-01 16:25:30', '1', '2021-09-04 21:44:35', '127.0.0.1', null, '5', '0');

-- ----------------------------
-- Table structure for `sys_post`
-- ----------------------------
DROP TABLE IF EXISTS `sys_post`;
CREATE TABLE `sys_post` (
  `id` varchar(64) NOT NULL COMMENT '岗位ID',
  `post_code` varchar(64) NOT NULL COMMENT '岗位编码',
  `post_name` varchar(50) NOT NULL COMMENT '岗位名称',
  `sort` int(4) NOT NULL COMMENT '显示顺序',
  `status` char(1) NOT NULL COMMENT '状态（0正常 1删除 2停用）',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_dept` varchar(64) DEFAULT NULL COMMENT '创建部门',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `update_ip` varchar(50) DEFAULT NULL COMMENT '更新IP',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  `version` int(11) DEFAULT NULL COMMENT '版本',
  `del_flag` char(1) DEFAULT '0' COMMENT '删除标志（0代表存在 1代表删除）',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='岗位信息表';

-- ----------------------------
-- Records of sys_post
-- ----------------------------
INSERT INTO `sys_post` VALUES ('1', 'ceo', '董事长', '10', '0', 'admin', null, '2021-01-30 13:27:43', '1', '2021-09-05 10:11:01', '127.0.0.1', '', null, '0');
INSERT INTO `sys_post` VALUES ('2', 'se', '项目经理', '20', '0', 'admin', null, '2021-01-30 13:27:43', '1', '2021-09-05 10:10:50', '127.0.0.1', '', null, '0');
INSERT INTO `sys_post` VALUES ('3', 'hr', '人力资源', '30', '0', 'admin', null, '2021-01-30 13:27:43', '1', '2021-09-05 10:11:12', '127.0.0.1', '', null, '0');
INSERT INTO `sys_post` VALUES ('4', 'user', '普通员工', '40', '0', 'admin', null, '2021-01-30 13:27:43', '1', '2021-09-05 10:11:16', '127.0.0.1', '', null, '0');

-- ----------------------------
-- Table structure for `sys_role`
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role` (
  `id` varchar(64) NOT NULL COMMENT '角色ID',
  `role_name` varchar(30) NOT NULL COMMENT '角色名称',
  `role_key` varchar(100) NOT NULL COMMENT '角色权限字符串',
  `sort` int(11) NOT NULL COMMENT '显示顺序',
  `data_scope` char(1) DEFAULT '1' COMMENT '数据范围（1：全部数据权限 2：自定数据权限 3：本部门数据权限 4：本部门及以下数据权限）',
  `menu_check_strictly` tinyint(1) DEFAULT '1' COMMENT '菜单树选择项是否关联显示',
  `dept_check_strictly` tinyint(1) DEFAULT '1' COMMENT '部门树选择项是否关联显示',
  `status` char(1) NOT NULL COMMENT '角色状态（0正常 1停用）',
  `del_flag` char(1) DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_dept` varchar(64) DEFAULT NULL COMMENT '创建部门',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  `update_ip` varchar(50) DEFAULT NULL COMMENT '更新IP',
  `version` int(11) DEFAULT NULL COMMENT '版本',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='角色信息表';

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES ('1', '超级管理员', 'admin', '1', '1', '1', '1', '0', '0', 'admin', null, '2021-01-30 13:27:43', '1', '2021-07-13 10:16:52', '超级管理员', '127.0.0.1', '3');
INSERT INTO `sys_role` VALUES ('1d65a356f35d455bbb2a3a614737b0f7', '项目管理员', 'projectAdmin', '3', '2', '1', '1', '0', '0', '1', '100', '2021-06-03 18:39:55', '1', '2021-09-17 16:46:14', null, '127.0.0.1', '15');
INSERT INTO `sys_role` VALUES ('2', '系统管理员', 'sysAdmin', '2', '2', '1', '1', '0', '0', 'admin', null, '2021-01-30 13:27:43', '1', '2021-09-17 16:45:40', '普通角色', '127.0.0.1', '8');
INSERT INTO `sys_role` VALUES ('c6676868d24e43098e4724014a096800', '一般用户', 'ordinaryUser', '50', '2', '0', '0', '0', '0', '1', '100', '2021-07-16 14:49:26', '1', '2021-07-17 12:46:50', null, '127.0.0.1', '3');

-- ----------------------------
-- Table structure for `sys_role_dept`
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_dept`;
CREATE TABLE `sys_role_dept` (
  `role_id` varchar(64) NOT NULL COMMENT '角色ID',
  `dept_id` varchar(64) NOT NULL COMMENT '部门ID',
  PRIMARY KEY (`role_id`,`dept_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='角色和部门关联表';

-- ----------------------------
-- Records of sys_role_dept
-- ----------------------------
INSERT INTO `sys_role_dept` VALUES ('1d65a356f35d455bbb2a3a614737b0f7', '40f40750917349249f3a7d4593e3e886');
INSERT INTO `sys_role_dept` VALUES ('2', '40f40750917349249f3a7d4593e3e886');

-- ----------------------------
-- Table structure for `sys_role_menu`
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_menu`;
CREATE TABLE `sys_role_menu` (
  `role_id` varchar(64) NOT NULL COMMENT '角色ID',
  `menu_id` varchar(64) NOT NULL COMMENT '菜单ID',
  PRIMARY KEY (`role_id`,`menu_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='角色和菜单关联表';

-- ----------------------------
-- Records of sys_role_menu
-- ----------------------------

-- ----------------------------
-- Table structure for `sys_theme_config`
-- ----------------------------
DROP TABLE IF EXISTS `sys_theme_config`;
CREATE TABLE `sys_theme_config` (
  `id` varchar(64) NOT NULL COMMENT '岗位ID',
  `user_id` varchar(64) NOT NULL COMMENT '用户ID',
  `theme_obj` varchar(1000) DEFAULT NULL COMMENT '对应主题JSON',
  `status` char(1) NOT NULL COMMENT '状态（0正常 1删除 2停用）',
  `sort` int(4) NOT NULL COMMENT '排序',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_dept` varchar(64) DEFAULT NULL COMMENT '创建部门',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `update_ip` varchar(50) DEFAULT NULL COMMENT '更新IP',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  `version` int(11) DEFAULT NULL COMMENT '版本',
  `del_flag` char(1) DEFAULT '0' COMMENT '删除标志（0代表存在 1代表删除）',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx1` (`user_id`,`del_flag`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户主题信息记录';

-- ----------------------------
-- Records of sys_theme_config
-- ----------------------------

-- ----------------------------
-- Table structure for `sys_user`
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user` (
  `id` varchar(64) NOT NULL COMMENT '用户ID',
  `dept_id` varchar(50) DEFAULT NULL COMMENT '部门ID',
  `name` varchar(50) DEFAULT NULL COMMENT '姓名',
  `name_en` varchar(50) DEFAULT NULL COMMENT '英文名',
  `no` varchar(50) DEFAULT NULL COMMENT '用户编号',
  `secret_level` varchar(10) DEFAULT NULL COMMENT '密级',
  `user_name` varchar(30) NOT NULL COMMENT '登陆名称',
  `nick_name` varchar(30) DEFAULT NULL COMMENT '别称',
  `user_type` varchar(2) DEFAULT '0' COMMENT '前后台类型标识 0:后台用户 1:前台用户',
  `email` varchar(50) DEFAULT '' COMMENT '用户邮箱',
  `phonenumber` varchar(11) DEFAULT '' COMMENT '手机号码',
  `sex` char(1) DEFAULT '0' COMMENT '用户性别（0男 1女 2未知）',
  `avatar` varchar(100) DEFAULT '' COMMENT '头像地址',
  `password` varchar(100) DEFAULT '' COMMENT '密码',
  `birthday` date DEFAULT NULL COMMENT '生日',
  `nation` varchar(100) DEFAULT NULL COMMENT '民族',
  `birth_address` varchar(100) DEFAULT NULL COMMENT '籍贯',
  `polity` varchar(50) DEFAULT NULL COMMENT '政治面貌',
  `title` varchar(100) DEFAULT NULL COMMENT '职称',
  `office_tel` varchar(50) DEFAULT NULL COMMENT '办公电话',
  `fax` varchar(50) DEFAULT NULL COMMENT '传真号',
  `work_space` varchar(100) DEFAULT NULL COMMENT '工作地点',
  `sort` int(11) DEFAULT NULL COMMENT '排序号',
  `user_pinyin` varchar(500) DEFAULT NULL COMMENT '用户姓名全拼和简拼',
  `status` char(1) DEFAULT '0' COMMENT '帐号状态（0正常 1停用）',
  `del_flag` char(1) DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `login_ip` varchar(50) DEFAULT '' COMMENT '最后登录IP',
  `login_date` datetime DEFAULT NULL COMMENT '最后登录时间',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_dept` varchar(64) DEFAULT NULL COMMENT '创建部门',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `update_ip` varchar(50) DEFAULT NULL COMMENT '更新IP',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  `version` int(11) DEFAULT NULL COMMENT '版本',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户信息表';

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES ('01085bb3d1174d119d5b35877378a366', '100', 'test', null, 'test', '2', 'test', 'sdfsd', '2', '334444@qq.com', '', '0', null, '$2a$10$etMMI1O1HTWJ9W8//vuRdOMF2xxbG4rZQkRgAGZDGOtOpHSiGwEGq', null, null, null, null, null, null, null, null, '10', 'test,test', '0', '0', null, null, '1', '100', '2021-04-07 14:41:30', '1', '2021-09-05 10:37:08', '127.0.0.1', null, '10');
INSERT INTO `sys_user` VALUES ('1', '100', '管理员', null, 'admin', '2', 'admin', '管理员', '1', '1125373330@qq.com', '1125373330', '0', '/profile\\avatar\\2021/07/28\\fce3dc16-5f76-41d8-8ad7-fa5ade9668ef.jpeg', '$2a$10$Es.n8SRDQ3F.RP4K7K5tk./z61StuD6ZTmdD7BaI4Q9J9xIvZQFD.', null, null, null, null, null, '029-03456751111', null, null, '1', 'admin,admin', '0', '0', '127.0.0.1', '2021-01-30 13:27:43', 'admin', null, '2021-01-30 13:27:43', '1', '2021-09-17 15:06:26', '127.0.0.1', '管理员', '33');
INSERT INTO `sys_user` VALUES ('c90b3091bc824efaae1dd43845b866fd', 'f96f514133a241fd8bffd9dd899de8ea', 'test', null, 'test', null, 'test1', null, '2', null, null, '2', null, '$2a$10$8nbVbGHX4ZQy9pAY3oMwquY0alp9xOUxxZYsMRf7YfcpCsjBkvPo2', null, null, null, null, null, null, null, null, null, 'test,test', '0', '0', null, null, '1', '100', '2021-09-17 17:26:00', '1', '2021-09-17 17:26:00', '127.0.0.1', null, '1');

-- ----------------------------
-- Table structure for `sys_user_post`
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_post`;
CREATE TABLE `sys_user_post` (
  `user_id` varchar(64) NOT NULL COMMENT '用户ID',
  `post_id` varchar(64) NOT NULL COMMENT '岗位ID',
  PRIMARY KEY (`user_id`,`post_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户与岗位关联表';

-- ----------------------------
-- Records of sys_user_post
-- ----------------------------
INSERT INTO `sys_user_post` VALUES ('01085bb3d1174d119d5b35877378a366', '2');
INSERT INTO `sys_user_post` VALUES ('01085bb3d1174d119d5b35877378a366', '3');
INSERT INTO `sys_user_post` VALUES ('01085bb3d1174d119d5b35877378a366', '4');
INSERT INTO `sys_user_post` VALUES ('1', '1');
INSERT INTO `sys_user_post` VALUES ('c90b3091bc824efaae1dd43845b866fd', '1');

-- ----------------------------
-- Table structure for `sys_user_role`
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_role`;
CREATE TABLE `sys_user_role` (
  `user_id` varchar(64) NOT NULL COMMENT '用户ID',
  `role_id` varchar(64) NOT NULL COMMENT '角色ID',
  PRIMARY KEY (`user_id`,`role_id`),
  KEY `idx` (`user_id`,`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户和角色关联表';

-- ----------------------------
-- Records of sys_user_role
-- ----------------------------
INSERT INTO `sys_user_role` VALUES ('01085bb3d1174d119d5b35877378a366', '2');
INSERT INTO `sys_user_role` VALUES ('c90b3091bc824efaae1dd43845b866fd', '2');
