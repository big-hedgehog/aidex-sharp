package com.aidex.quartz.util;

import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.LinkedList;
import java.util.List;
import com.aidex.common.utils.StringUtils;
import com.aidex.common.utils.spring.SpringUtils;
import com.aidex.quartz.domain.SysJob;

/**
 * 任务执行工具
 *
 * @author ruoyi
 */
public class JobInvokeUtil
{
    /**
     * 执行方法
     *
     * @param sysJob 系统任务
     */
    public static void invokeMethod(SysJob sysJob) throws Exception
    {
        String invokeTarget = sysJob.getInvokeTarget();
        String beanName = getBeanName(invokeTarget);
        String methodName = getMethodName(invokeTarget);
        List<Object[]> methodParams = getMethodParams(invokeTarget);
        String message = "";//定时任务方法可以返回自定义信息用户记录到执行日志
        if (!isValidClassName(beanName))
        {
            Object bean = SpringUtils.getBean(beanName);
            message = invokeMethod(bean, methodName, methodParams);
        }
        else
        {
            Object bean = Class.forName(beanName).newInstance();
            message = invokeMethod(bean, methodName, methodParams);
        }
        sysJob.setCustomMessage(message);
    }

    /**
     * 调用任务方法
     *
     * @param bean 目标对象
     * @param methodName 方法名称
     * @param methodParams 方法参数
     */
    private static String invokeMethod(Object bean, String methodName, List<Object[]> methodParams)
            throws NoSuchMethodException, SecurityException, IllegalAccessException, IllegalArgumentException,
            InvocationTargetException
    {
        String message = "";//定时任务方法可以返回自定义信息用户记录到执行日志
        if (StringUtils.isNotNull(methodParams) && methodParams.size() > 0)
        {
            Method method = bean.getClass().getDeclaredMethod(methodName, getMethodParamsType(methodParams));
            message =(String)method.invoke(bean, getMethodParamsValue(methodParams));
            System.out.println("返回参数"+message);
        }
        else
        {
            Method method = bean.getClass().getDeclaredMethod(methodName);
            message =(String)method.invoke(bean);
        }
        return message;
    }

    /**
     * 校验是否为为class包名
     * 
     * @return true是 false否
     */
    public static boolean isValidClassName(String invokeTarget)
    {
        return StringUtils.countMatches(invokeTarget, ".") > 1;
    }

    /**
     * 获取bean名称
     * 
     * @param invokeTarget 目标字符串
     * @return bean名称
     */
    public static String getBeanName(String invokeTarget)
    {
        String beanName = StringUtils.substringBefore(invokeTarget, "(");
        return StringUtils.substringBeforeLast(beanName, ".");
    }

    /**
     * 获取bean方法
     * 
     * @param invokeTarget 目标字符串
     * @return method方法
     */
    public static String getMethodName(String invokeTarget)
    {
        String methodName = StringUtils.substringBefore(invokeTarget, "(");
        return StringUtils.substringAfterLast(methodName, ".");
    }

    /**
     * 获取method方法参数相关列表
     * 
     * @param invokeTarget 目标字符串
     * @return method方法相关参数列表
     */
    public static List<Object[]> getMethodParams(String invokeTarget)
    {
        String methodStr = StringUtils.substringBetween(invokeTarget, "(", ")");
        if (StringUtils.isEmpty(methodStr))
        {
            return null;
        }
        String[] methodParams = methodStr.split(",");
        List<Object[]> classs = new LinkedList<>();
        for (int i = 0; i < methodParams.length; i++)
        {
            String str = StringUtils.trimToEmpty(methodParams[i]);
            // String字符串类型，包含'
            if (StringUtils.contains(str, "'"))
            {
                classs.add(new Object[] { StringUtils.replace(str, "'", ""), String.class });
            }
            // boolean布尔类型，等于true或者false
            else if (StringUtils.equals(str, "true") || StringUtils.equalsIgnoreCase(str, "false"))
            {
                classs.add(new Object[] { Boolean.valueOf(str), Boolean.class });
            }
            // long长整形，包含L
            else if (StringUtils.containsIgnoreCase(str, "L"))
            {
                classs.add(new Object[] { Long.valueOf(StringUtils.replaceIgnoreCase(str, "L", "")), Long.class });
            }
            // double浮点类型，包含D
            else if (StringUtils.containsIgnoreCase(str, "D"))
            {
                classs.add(new Object[] { Double.valueOf(StringUtils.replaceIgnoreCase(str, "D", "")), Double.class });
            }
            // 其他类型归类为整形
            else
            {
                classs.add(new Object[] { Integer.valueOf(str), Integer.class });
            }
        }
        return classs;
    }

    /**
     * 获取参数类型
     * 
     * @param methodParams 参数相关列表
     * @return 参数类型列表
     */
    public static Class<?>[] getMethodParamsType(List<Object[]> methodParams)
    {
        Class<?>[] classs = new Class<?>[methodParams.size()];
        int index = 0;
        for (Object[] os : methodParams)
        {
            classs[index] = (Class<?>) os[1];
            index++;
        }
        return classs;
    }

    /**
     * 获取参数值
     * 
     * @param methodParams 参数相关列表
     * @return 参数值列表
     */
    public static Object[] getMethodParamsValue(List<Object[]> methodParams)
    {
        Object[] classs = new Object[methodParams.size()];
        int index = 0;
        for (Object[] os : methodParams)
        {
            classs[index] = (Object) os[0];
            index++;
        }
        return classs;
    }
}
