package com.aidex.common.config;

import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;

import java.io.File;

/**
 * 读取项目相关配置
 * 
 * @author aidex
 */
@Component
@ConfigurationProperties(prefix = "aidex")
public class AiDexConfig
{
    /** 项目名称 */
    private String name;

    /** 版本 */
    private String version;

    /** 版权年份 */
    private String copyrightYear;

    /** 实例演示开关 */
    private boolean demoEnabled;

    /** 上传路径 */
    private static String profile;

    /** 上传路径 */
    private static String dbName;

    /** 获取地址开关 */
    private static boolean addressEnabled;

    public String getName()
    {
        return name;
    }

    public void setName(String name)
    {
        this.name = name;
    }

    public String getVersion()
    {
        return version;
    }

    public void setVersion(String version)
    {
        this.version = version;
    }

    public String getCopyrightYear()
    {
        return copyrightYear;
    }

    public void setCopyrightYear(String copyrightYear)
    {
        this.copyrightYear = copyrightYear;
    }

    public boolean isDemoEnabled()
    {
        return demoEnabled;
    }

    public void setDemoEnabled(boolean demoEnabled)
    {
        this.demoEnabled = demoEnabled;
    }

    public static String getProfile()
    {
        return profile;
    }

    public void setProfile(String profile)
    {
        AiDexConfig.profile = profile;
    }

    public static boolean isAddressEnabled()
    {
        return addressEnabled;
    }

    public void setAddressEnabled(boolean addressEnabled)
    {
        AiDexConfig.addressEnabled = addressEnabled;
    }

    /**
     * 获取头像上传路径
     */
    public static String getAvatarPath()
    {
//        return getProfile() + "/avatar";
        return getProfile() + File.separator +"avatar";
    }

    /**
     * 获取下载路径
     */
    public static String getDownloadPath()
    {

//        return getProfile() + "/download/";
        return getProfile() + File.separator + "download" +File.separator ;
    }

    /**
     * 获取上传路径
     */
    public static String getUploadPath()
    {

//        return getProfile() + "/upload";
        return getProfile() + File.separator  + "upload";
    }

    public static String getDbName() {
        return dbName;
    }

    public static void setDbName(String dbName) {
        AiDexConfig.dbName = dbName;
    }
}
