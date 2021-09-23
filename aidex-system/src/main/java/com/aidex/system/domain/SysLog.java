package com.aidex.system.domain;

import com.aidex.common.annotation.Excel;
import com.aidex.common.core.domain.BaseEntity;
import lombok.Data;
import lombok.EqualsAndHashCode;
import org.apache.commons.lang3.builder.ReflectionToStringBuilder;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

import java.util.Date;
import java.util.Map;

/**
 * 系统数据变更日志对象 sys_log
 * @author aidex
 * @email aidex@qq.com
 * @date 2021-06-17
 */
@Data
@EqualsAndHashCode(callSuper = true)
public class SysLog extends BaseEntity<SysLog>
{
    private static final long serialVersionUID = 1L;
    private String type; 		// 日志类型（1：接入日志；2：错误日志）
    private String title;		// 日志标题
    private String remoteAddr; 	// 操作用户的IP地址
    private String requestUri; 	// 操作的URI
    private String method; 		// 操作的方式
    private String param; 		// 操作提交的数据
    private String userAgent;	// 操作用户代理信息
    private String exception; 	// 异常信息
    private Date beginDate;		// 开始日期
    private Date endDate;		// 结束日期
    private String logType;	// 日志类型
    private String logOpType;	// 日志操作类型0=其它,1=新增,2=修改,3=删除,4=授权,5=导出,6=导入,7=强退,8=生成代码,9=清空数据
    private String logContent;	// 日志内容
    private String formId;	// ID

    // 日志类型（1：接入日志；2：错误日志；3：数据审计日志）
    public static final String TYPE_ACCESS = "1";
    public static final String TYPE_EXCEPTION = "2";
    public static final String TYPE_CHANGE_CONTENTS = "3";

    //数据操作类型
    public enum LogOpType {
        insert, delete, update;
    }

    //日志类型：业务操作,系统管理,安全管理,安全审计
    public enum LogType {
        module_operate, system_manage, safety_manage , safety_audit;
    }

    public SysLog(){
        super();
    }

    public SysLog(String id){
        super(id);
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getRemoteAddr() {
        return remoteAddr;
    }

    public void setRemoteAddr(String remoteAddr) {
        this.remoteAddr = remoteAddr;
    }

    public String getUserAgent() {
        return userAgent;
    }

    public void setUserAgent(String userAgent) {
        this.userAgent = userAgent;
    }

    public String getRequestUri() {
        return requestUri;
    }

    public void setRequestUri(String requestUri) {
        this.requestUri = requestUri;
    }

    public String getMethod() {
        return method;
    }

    public void setMethod(String method) {
        this.method = method;
    }


    public void setParam(String param) {
        this.param = param;
    }
    public String getParam() {
        return param;
    }

    public String getException() {
        return exception;
    }

    public void setException(String exception) {
        this.exception = exception;
    }

    public String getLogType() {
        return logType;
    }

    public void setLogType(String logType) {
        this.logType = logType;
    }

    public String getLogOpType() {
        return logOpType;
    }

    public void setLogOpType(String logOpType) {
        this.logOpType = logOpType;
    }

    public String getLogContent() {
        return logContent;
    }

    public void setLogContent(String logContent) {
        this.logContent = logContent;
    }

    public String getFormId() {
        return formId;
    }

    public void setFormId(String formId) {
        this.formId = formId;
    }

    public Date getBeginDate() {
        return beginDate;
    }

    public void setBeginDate(Date beginDate) {
        this.beginDate = beginDate;
    }

    public Date getEndDate() {
        return endDate;
    }

    public void setEndDate(Date endDate) {
        this.endDate = endDate;
    }

    @Override
    public String toString() {
        return ReflectionToStringBuilder.toString(this);
    }

    public String getLogTitle() {
        return "日志管理模块";
    }
}
