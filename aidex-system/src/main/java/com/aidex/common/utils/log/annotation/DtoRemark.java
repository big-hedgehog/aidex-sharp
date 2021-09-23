package com.aidex.common.utils.log.annotation;

import static java.lang.annotation.ElementType.TYPE;
import static java.lang.annotation.RetentionPolicy.RUNTIME;

import java.lang.annotation.Retention;
import java.lang.annotation.Target;


/**
 * <p>[aidex]</p>
 * <p>作者：aidex</p>
 * <p>邮箱：aidex@qq.com</p>
 * <p>创建时间： 2015-11-27 下午2:10:01 </p>
 * <p>类说明：DTO对象的注解</p>
 * <p>修改记录： </p>
 */
@Target(TYPE)
@Retention(RUNTIME)
public @interface DtoRemark {

	String table() default "";

	String object() default "";

	String name() default "";
}
