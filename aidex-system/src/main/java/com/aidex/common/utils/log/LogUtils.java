package com.aidex.common.utils.log;

import com.aidex.common.core.domain.BaseEntity;
import com.aidex.common.core.domain.model.LoginUser;
import com.aidex.common.utils.Exceptions;
import com.aidex.common.utils.SecurityUtils;
import com.aidex.common.utils.StringUtils;
import com.aidex.common.utils.uuid.IdUtils;
import com.aidex.system.domain.SysLog;
import org.springframework.util.CollectionUtils;

import javax.servlet.http.HttpServletRequest;
import java.util.Date;
import java.util.List;

/**
 * 字典工具类
 * @author aidex
 * @email aidex@qq.com
 * @version 2014-05-16
 */
public class LogUtils {

	public static final String CACHE_MENU_NAME_PATH_MAP = "menuNamePathMap";

	private static final String LOG_IGNORE_PROPERTIES  = "createBy,createDate,updateBy,updateDate,version,updateIp,delFlag,remoteAddr,requestUri,method,userAgent";
	/**
	 * 记录插入日志
	 * @param baseEntity 业务实体对象
	 */
	public static void log4Insert(BaseEntity<?> baseEntity) {
		new SaveLogCompareThread(baseEntity,"insert").start();
	}

	/**
	 * 记录更新日志
	 * @param oldBaseEntity 业务实体对象
	 * @param newBaseEntity 新业务实体对象
	 */
	public static void log4Update(BaseEntity<?> oldBaseEntity, BaseEntity<?> newBaseEntity) {
		new SaveLogCompareThread(oldBaseEntity, newBaseEntity).start();
	}

	/**
	 * 记录删除日志
	 * @param baseEntity 业务实体对象
	 */
	public static void log4Delete(BaseEntity<?> baseEntity) {
		new SaveLogCompareThread(baseEntity,"delete").start();
	}

	public static SysLog buildLog(BaseEntity<?> baseEntity) {
		SysLog log = new SysLog();
		log.setType(SysLog.TYPE_CHANGE_CONTENTS);
		log.setTitle("测试");
//		log.setTitle(baseEntity.getLogTitle());
//		log.setRemoteAddr(baseEntity.getRemoteAddr());
//		log.setUserAgent(baseEntity.getUserAgent());
//		log.setRequestUri(baseEntity.getRequestUri());
//		log.setMethod(baseEntity.getRequestUri());
		log.setFormId(baseEntity.getId());

        log.setCreateBy(baseEntity.getCreateBy());
        log.setUpdateBy(baseEntity.getUpdateBy());
        log.setCreateDept(baseEntity.getCreateDept());
        log.setUpdateIp(baseEntity.getUpdateIp());
        log.setVersion(1);
        log.setCreateTime(new Date());
        log.setUpdateTime(new Date());
		return log;
	}

	/**
	 * 保存日志
	 */
	public static void saveLog(HttpServletRequest request, String title) {
		saveLog(request, null, null, title);
	}
	
	


	/**
	 * 保存日志
	 */
	public static void saveLog(HttpServletRequest request, Object handler, Exception ex, String title) {
		LoginUser user = SecurityUtils.getLoginUser();
		if (user != null && user.getUser() != null) {
			SysLog log = new SysLog();
			log.setTitle(title);
			log.setType(ex == null ? SysLog.TYPE_ACCESS : SysLog.TYPE_EXCEPTION);
			log.setRemoteAddr(user.getIpaddr());
			log.setUserAgent(request.getHeader("user-agent"));
			log.setRequestUri(request.getRequestURI());
			log.setMethod(request.getMethod());
			// 异步保存日志
			new SaveLogThread(log, handler, ex).start();
		}
	}

	/**
	 * 保存日志线程
	 */
	public static class SaveLogCompareThread extends Thread {

		private BaseEntity<?> baseEntity;
		private BaseEntity<?> oldBaseEntity;
		private BaseEntity<?> newBaseEntity;
		private String logType;

		public SaveLogCompareThread(BaseEntity<?> oldBaseEntity, BaseEntity<?> newBaseEntity) {
			super(SaveLogCompareThread.class.getSimpleName());
			this.oldBaseEntity = oldBaseEntity;
			this.newBaseEntity = newBaseEntity;
			this.logType = "update";
		}

		public SaveLogCompareThread(BaseEntity<?> baseEntity, String logType) {
			super(SaveLogCompareThread.class.getSimpleName());
			this.baseEntity = baseEntity;
			this.logType = logType;
		}

		@Override
		public void run() {
			if ("insert".equals(logType)) {

			} else if ("update".equals(logType)) {

			} else if ("delete".equals(logType)) {

			}
		}
	}

	/**
	 * 保存日志线程
	 */
	public static class SaveLogThread extends Thread {

		private SysLog log;
		private Object handler;
		private Exception ex;

		public SaveLogThread(SysLog log, Object handler, Exception ex) {
			super(SaveLogThread.class.getSimpleName());
			this.log = log;
			this.handler = handler;
			this.ex = ex;
		}

		@Override
		public void run() {
			// 获取日志标题
			if (StringUtils.isBlank(log.getTitle())) {
				String permission = "";
				log.setTitle("");
			}
			// 如果有异常，设置异常信息
			if (log.getType().equals(SysLog.TYPE_CHANGE_CONTENTS)) {
				if (null != ex && !StringUtils.isEmpty(ex.getMessage())) {
					log.setException(ex.getMessage());
				}
			} else {
				log.setException(Exceptions.getStackTraceAsString(ex));
			}
			// 如果无标题并无异常日志，则不保存信息
			if (StringUtils.isBlank(log.getTitle()) && StringUtils.isBlank(log.getException())) {
				return;
			}
			// 保存日志信息
//			log.preInsert();
			log.setId(IdUtils.randomUUID());
			//logDao.insert(log);
		}
	}
}
