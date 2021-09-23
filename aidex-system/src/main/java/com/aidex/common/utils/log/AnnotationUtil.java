package com.aidex.common.utils.log;

import com.aidex.common.utils.log.annotation.DtoRemark;
import com.aidex.common.utils.log.annotation.FieldRemark;
import org.apache.commons.beanutils.PropertyUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.lang.annotation.Annotation;
import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 注解工具类
 * @author aidex
 * @email aidex@qq.com
 * @version 2014-05-16
 */
public class AnnotationUtil {

	static Logger log = LoggerFactory.getLogger(AnnotationUtil.class);

	/**
	 * 返回某个对象的注解属性
	 * @param obj
	 * @param annotationClass
	 * @return
	 */
	public static List<String> getFieldName(Object obj, Class<? extends Annotation> annotationClass) {
		List<String> list = new ArrayList<String>();
		Class<?> o = obj.getClass();
		Field[] fields = o.getDeclaredFields();
		for (int i = 0; i < fields.length; i++) {
			if (fields[i].isAnnotationPresent(annotationClass)) {
				String fieldName = fields[i].getName();
				list.add(fieldName);
			}
		}
		return list;
	}

	/**
	 * 返回某个对象的注解属性的map
	 * @param obj
	 * @param annotationClass
	 * @return
	 */
	public static Map<String, String> getFieldNameMap(Object obj, Class<? extends Annotation> annotationClass) {
		Map<String, String> map = new HashMap<String, String>(16);
		Class<?> o = obj.getClass();
		Field[] fields = o.getDeclaredFields();
		for (int i = 0; i < fields.length; i++) {
			if (fields[i].isAnnotationPresent(annotationClass)) {
				String fieldName = fields[i].getName();
				map.put(fieldName, fieldName);
			}
		}
		return map;
	}

	/**
	 * 返回某个对象的方法注解
	 * @param obj
	 * @param annotationClass
	 * @return
	 */
	public static List<String> getMethodName(Object obj, Class<? extends Annotation> annotationClass) {
		List<String> list = new ArrayList<String>();
		Class<?> o = obj.getClass();
		Method[] methods = o.getDeclaredMethods();
		log.trace(" 查找已添加注解的方法   ");
		for (int i = 0; i < methods.length; i++) {
			if (methods[i].isAnnotationPresent(annotationClass)) {
				String methodName = methods[i].getName();
				list.add(methodName);
			}
		}
		return list;
	}

	/**
	 * 返回某个对象的方法注解
	 * @param obj
	 * @param annotationClass
	 * @return
	 */
	public static Map<String, String> getMethodNameMap(Object obj, Class<? extends Annotation> annotationClass) {
		Map<String, String> map = new HashMap<String, String>(1);
		Class<?> o = obj.getClass();
		Method[] methods = o.getDeclaredMethods();
		for (int i = 0; i < methods.length; i++) {
			if (methods[i].isAnnotationPresent(annotationClass)) {
				String methodName = methods[i].getName();
				map.put(methodName, methodName);
			}
		}
		return map;
	}

	/**
	 * 返回某个对象的方法注解返回属性列表
	 * @param obj
	 * @param annotationClass
	 * @return
	 */
	public static List<String> getFieldNameByMethodAnnotation(Object obj, Class<? extends Annotation> annotationClass) {
		List<String> list = new ArrayList<String>();
		List<String> methods = getMethodName(obj, annotationClass);
		for (String method : methods) {
			String field = method.substring(3, 4).toLowerCase() + method.substring(4);
			list.add(field);
		}
		return list;
	}

	/**
	 * 返回某个对象的方法注解返回属性列表
	 * @param obj
	 * @param annotationClass
	 * @return
	 */
	public static Map<String, String> getFieldNameByMethodAnnotationMap(Object obj, Class<? extends Annotation> annotationClass) {
		Map<String, String> map = new HashMap<String, String>(16);
		List<String> methods = getMethodName(obj, annotationClass);
		for (String method : methods) {
			String field = method.substring(3, 4).toLowerCase() + method.substring(4);
			map.put(field, field);
		}
		return map;
	}

	/**
	 * 返回某个对象注解属性的值，该方法只针对唯一注解，返回一个字段的值
	 * @param obj 对象
	 * @param AnnotationClass 注解类型
	 * @return 值
	 */
	public static String getFieldAnnotationValue(Object obj, Class<? extends Annotation> AnnotationClass) {
		String fieldValue = "";
		List<String> list = getFieldName(obj, AnnotationClass);
		if (list != null && list.size() > 0) {
			try {
				Object value = PropertyUtils.getProperty(obj, list.get(0));
				if (value instanceof String) {
					fieldValue = (String) value;
				}

			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return fieldValue;
	}

	/**
	 * 返回某个对象注解方法的值，该方法只针对唯一注解，返回一个字段的值
	 * @param obj 对象
	 * @param AnnotationClass 注解类型
	 * @return 值
	 */
	public static String getMethodAnnotationValue(Object obj, Class<? extends Annotation> AnnotationClass) {
		String fieldValue = "";
		List<String> list = getMethodName(obj, AnnotationClass);
		if (list != null && list.size() > 0) {
			try {
				String method = list.get(0);
				String field = method.substring(3, 4).toLowerCase() + method.substring(4);
				Object value = PropertyUtils.getProperty(obj, field);
				if (value instanceof String) {
					fieldValue = (String) value;
				}

			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return fieldValue;
	}

	public static DtoRemark getPojoRemark(Object obj) {
		Class<?> o = obj.getClass();
		if (o.isAnnotationPresent(DtoRemark.class)) {
			return o.getAnnotation(DtoRemark.class);
		}
		return null;
	}

	public static List<FieldRemark> getFieldRemark(Object obj) {
		List<FieldRemark> list = new ArrayList<FieldRemark>();
		Class<?> o = obj.getClass();
		Field[] fields = o.getDeclaredFields();
		for (int i = 0; i < fields.length; i++) {
			if (fields[i].isAnnotationPresent(FieldRemark.class)) {
				list.add(fields[i].getAnnotation(FieldRemark.class));
			}
		}
		return list;
	}
}
