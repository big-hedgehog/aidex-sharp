package com.aidex.common.utils;

import com.aidex.common.core.domain.model.LoginUser;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

/**
 * 安全服务工具类
 *
 * @author ruoyi
 */
public class SecurityUtils {
    /**
     * 获取用户账户
     **/
    public static String getUsername() {
        LoginUser loginUser =  getLoginUser();
        if(null == loginUser){
            return "";
        }
        return loginUser.getUsername();
    }

    /**
     * 获取用户
     **/
    public static LoginUser getLoginUser() {
        if(null != getAuthentication()){
            Object principal = getAuthentication().getPrincipal();
            if (principal != null) {
                LoginUser user = (LoginUser) principal;
                if (user != null) {
                    return user;
                }
                return new LoginUser();
            }
        }
        return new LoginUser();
    }

    /**
     * 获取用户ID
     **/
    public static String getLoginUserId() {
        return getLoginUser().getUser().getId() + "";
    }

    /**
     * 获取部门ID
     **/
    public static String getLoginDeptId() {
        return getLoginUser().getUser().getDeptId() + "";
    }

    /**
     * 获取部门姓名
     **/
    public static String getLoginDeptName() {
        return getLoginUser().getUser().getSysDept().getDeptName();
    }

    /**
     * 获取登录IP地址
     **/
    public static String getIpaddr() {
        return getLoginUser().getIpaddr();
    }

    /**
     * 获取Authentication
     */
    public static Authentication getAuthentication() {
        return SecurityContextHolder.getContext().getAuthentication();
    }

    /**
     * 生成BCryptPasswordEncoder密码
     *
     * @param password 密码
     * @return 加密字符串
     */
    public static String encryptPassword(String password) {
        BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
        return passwordEncoder.encode(password);
    }

    /**
     * 判断密码是否相同
     *
     * @param rawPassword     真实密码
     * @param encodedPassword 加密后字符
     * @return 结果
     */
    public static boolean matchesPassword(String rawPassword, String encodedPassword) {
        BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
        return passwordEncoder.matches(rawPassword, encodedPassword);
    }

    /**
     * 是否为管理员
     *
     * @param userId 用户ID
     * @return 结果
     */
    public static boolean isAdmin(String userId) {
        return StringUtils.isNotBlank(userId) && "1".equals(userId);
    }
}
