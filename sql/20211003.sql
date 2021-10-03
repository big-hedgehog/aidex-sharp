-- 更新日志表字段类型，用于表头排序功能
ALTER TABLE `sys_oper_log`
MODIFY COLUMN `take_up_time`  int(11) NULL DEFAULT NULL AFTER `form_id`;

