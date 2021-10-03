-- 更新日志表字段类型，用于表头排序功能
ALTER TABLE `sys_oper_log`
MODIFY COLUMN `take_up_time`  int(11) NULL DEFAULT NULL AFTER `form_id`;

-- 增加是否允许用户注册开关
INSERT INTO `sys_config` VALUES ('验证码开关', 'sys.account.registerUser', 'true', 'Y', '1', '2021-09-29 23:51:21', '1', '2021-09-29 23:51:21', '是否开启验证码功能（true开启，false关闭）', 'b3158f15cbed4a3d93e43f19d5fb5893', '1', '0', '127.0.0.1', '100');