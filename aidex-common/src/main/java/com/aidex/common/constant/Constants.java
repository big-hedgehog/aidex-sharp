package com.aidex.common.constant;

import io.jsonwebtoken.Claims;

/**
 * 通用常量信息
 *
 * @author ruoyi
 */
public class Constants {
    /**
     * UTF-8 字符集
     */
    public static final String UTF8 = "UTF-8";

    /**
     * GBK 字符集
     */
    public static final String GBK = "GBK";

    /**
     * http请求
     */
    public static final String HTTP = "http://";

    /**
     * https请求
     */
    public static final String HTTPS = "https://";

    /**
     * 通用成功标识
     */
    public static final String SUCCESS = "0";

    /**
     * 通用失败标识
     */
    public static final String FAIL = "1";

    /**
     * 登录成功
     */
    public static final String LOGIN_SUCCESS = "Success";

    /**
     * 注销
     */
    public static final String LOGOUT = "Logout";

    /**
     * 注册
     */
    public static final String REGISTER = "Register";

    /**
     * 登录失败
     */
    public static final String LOGIN_FAIL = "Error";

    /**
     * 验证码 redis key
     */
    public static final String CAPTCHA_CODE_KEY = "captcha_codes:";

    /**
     * 登录用户 redis key
     */
    public static final String LOGIN_TOKEN_KEY = "login_tokens:";

    /**
     * 防重提交 redis key
     */
    public static final String REPEAT_SUBMIT_KEY = "repeat_submit:";

    /**
     * 限流 redis key
     */
    public static final String RATE_LIMIT_KEY = "rate_limit:";

    /**
     * 验证码有效期（分钟）
     */
    public static final Integer CAPTCHA_EXPIRATION = 2;

    /**
     * 令牌
     */
    public static final String TOKEN = "token";

    /**
     * 令牌前缀
     */
    public static final String TOKEN_PREFIX = "Bearer ";

    /**
     * 令牌前缀
     */
    public static final String LOGIN_USER_KEY = "login_user_key";

    /**
     * 用户ID
     */
    public static final String JWT_USERID = "userid";

    /**
     * 用户名称
     */
    public static final String JWT_USERNAME = Claims.SUBJECT;

    /**
     * 用户头像
     */
    public static final String JWT_AVATAR = "avatar";

    /**
     * 创建时间
     */
    public static final String JWT_CREATED = "created";

    /**
     * 用户权限
     */
    public static final String JWT_AUTHORITIES = "authorities";

    /**
     * 参数管理 cache key
     */
    public static final String SYS_CONFIG_KEY = "sys_config:";

    /**
     * 字典管理 cache key
     */
    public static final String SYS_DICT_KEY = "sys_dict:";

    /**
     * 用户管理 cache key
     */
    public static final String SYS_USER_KEY = "sys_user:";

    /**
     * 用户管理 cache key
     */
    public static final String SYS_USER_UN_KEY = "sys_user_un:";

    /**
     * 部门管理 cache key
     */
    public static final String SYS_DEPT_KEY = "sys_dept:";

    /**
     * 列配置 cache key
     */
    public static final String SYS_TABLE_CONFIG_KEY = "sys_table_config:";

    /**
     * 部门管理 cache key
     */
    public static final String SYS_DEPT_DC_KEY = "sys_dept_dc:";

    /**
     * 角色管理 cache key
     */
    public static final String SYS_ROLE_KEY = "sys_role:";

    /**
     * RMI 远程方法调用
     */
    public static final String LOOKUP_RMI = "rmi://";


    /**
     * LDAP 远程方法调用
     */
    public static final String LOOKUP_LDAP = "ldap://";

    /**
     * 资源映射路径 前缀
     */
    public static final String RESOURCE_PREFIX = "/profile";

    /**
     * 默认为空消息
     */
    public static final String DEFAULT_NULL_MESSAGE = "暂无数据";
    /**
     * 默认成功消息
     */
    public static final String DEFAULT_SUCCESS_MESSAGE = "操作成功";
    /**
     * 默认失败消息
     */
    public static final String DEFAULT_FAILURE_MESSAGE = "操作失败";

    /**
     * 树的ID串分隔符
     */
    public static final String TREE_ROOT = "0";

    /**
     * 树的ID串分隔符
     */
    public static final String TREE_IDS_SPLIT_CHART = "/";

    /**
     * 树的ID串分隔符
     */
    public static final String TREE_LEAF_Y = "y";

    /**
     * 树的ID串分隔符
     */
    public static final String TREE_LEAF_N = "n";

    /**
     * 日志操作类型
     */
    public enum OpType {
        login, insert, delete, update, select, logout
    }

    /**
     * 登录用户编号 redis key
     */
    public static final String LOGIN_USERID_KEY = "login_userid:";


    /**
     * 注册
     */
    public static final String ATTACH_SAVE_TYPE_DISK = "Disk";
}
