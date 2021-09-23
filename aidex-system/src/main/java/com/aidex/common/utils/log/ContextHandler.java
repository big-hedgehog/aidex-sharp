package com.aidex.common.utils.log;

import org.apache.commons.lang3.BooleanUtils;

import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

/**
 * 线程变量
 * @author aidex
 * @email aidex@qq.com
 * @version 2014-05-16
 */
public class ContextHandler {
    private static transient ThreadLocal<Map<String, Object>> threadLocal = new InheritableThreadLocal<Map<String, Object>>() {
        @Override
        protected Map<String, Object> childValue(Map<String, Object> parentValue) {
            return parentValue != null ? (Map) ((HashMap) parentValue).clone() : null;
        }
    };

    public ContextHandler() {
    }

    private static void initThreadLocal() {
        if (threadLocal.get() == null) {
            threadLocal.set(new HashMap(0));
        }

    }

    public static Map<String, Object> getAll() {
        initThreadLocal();
        return (Map) threadLocal.get();
    }

    public static void setAll(Map<String, Object> map) {
        remove();
        putAll(map);
    }

    public static void putAll(Map<String, Object> map) {
        initThreadLocal();

        String key;
        Object value;
        for (Iterator var1 = map.entrySet().iterator(); var1.hasNext(); ((Map) threadLocal.get()).put(key, value)) {
            Map.Entry<String, Object> entry = (Map.Entry) var1.next();
            key = (String) entry.getKey();
            value = entry.getValue();
            if (value instanceof String) {
                Object value1 = BooleanUtils.toBooleanObject((String) value, "true", "false", (String) value);
                value = null == value1 ? entry.getValue() : value;
            }
        }

    }

    public static void remove() {
        threadLocal.remove();
    }

    public static Object get(String key) {
        initThreadLocal();
        return ((Map) threadLocal.get()).get(key);
    }

    public static void set(String key, Object value) {
        initThreadLocal();
        if (value instanceof String) {
            String strValue = (String) value;
            Object value1 = BooleanUtils.toBooleanObject(strValue, "true", "false", strValue);
            value = null == value1 ? strValue : value;
        }

        ((Map) threadLocal.get()).put(key, value);
    }

    public static boolean getBoolean(String key) {
        return getBoolean(key, false);
    }

    public static boolean getBoolean(String key, boolean defaultResponse) {
        Object o = get(key);
        return o instanceof Boolean ? (Boolean) o : defaultResponse;
    }

    public static String getString(String key) {
        Object o = get(key);
        return o instanceof String ? (String) o : "";
    }

    public static boolean continueRequest() {
        return getBoolean("CONTINUE_REQUEST", true);
    }

    public static void setContinueRequest(boolean continueRequest) {
        set("CONTINUE_REQUEST", continueRequest);
    }

    public static String getUserId() {
        return getString("userId");
    }

    public static void setUserId(String userId) {
        set("userId", userId);
    }

    public static String getServerPath() {
        return getString("serverPath");
    }

    public static void setServerPath(String serverPath) {
        set("serverPath", serverPath);
    }

    public static String getUsername() {
        return getString("username");
    }

    public static void setUsername(String username) {
        set("username", username);
    }

    public static String getName() {
        return getString("name");
    }

    public static void setName(String name) {
        set("name", name);
    }

    public static String getToken() {
        return getString("token");
    }

    public static void setToken(String token) {
        set("token", token);
    }

    public static boolean isSuperAdmin() {
        return getBoolean("superAdmin");
    }

    public static void setSuperAdmin(boolean isSupperAdmin) {
        set("superAdmin", isSupperAdmin);
    }

    public static String getCorpCode() {
        return getString("corpCode");
    }

    public static void setCorpCode(String corpCode) {
        set("corpCode", corpCode);
    }

    public static boolean passAuth() {
        return getBoolean("pass_auth");
    }

    public static void signContext() {
        set("SET_CONTEXT", true);
        set("pass_auth", true);
    }

    public static boolean setContext() {
        return getBoolean("SET_CONTEXT");
    }

    public static void setDebug() {
        set("DEBUG", true);
    }

    public static boolean debug() {
        return getBoolean("DEBUG");
    }
}