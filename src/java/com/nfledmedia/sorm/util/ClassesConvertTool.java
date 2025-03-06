/**     
 * @Title: ClassesConvertTool.java   
 * @Package com.nfledmedia.sorm.util   
 * @Description: TODO(用一句话描述该文件做什么)   
 * @author wufc@nfledmedia.com     
 * @date 2016年11月24日 下午5:11:52   
 * @version V1.0   
 * @Copyright 2016 Guangdong Southern NewVision Media Technology Co., Ltd. All rights reserved.  
 */
package com.nfledmedia.sorm.util;

import java.beans.PropertyDescriptor;
import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.util.List;

/**
 * @ClassName ClassesConvertTool
 * @Description 将对象1转换为对象2，并给相同属性字段赋值
 * @author PC-FAN
 * @date 2016年11月24日 下午5:11:52
 * 
 */
public class ClassesConvertTool {

	public static Object convertObject1ToObject2(Object object1, Object object2) {
		Field[] fields1 = object1.getClass().getDeclaredFields();
		Field[] fields2 = object2.getClass().getDeclaredFields();
		if (null != fields1 && null != fields2) {
			for (Field field1 : fields1) {
				try {
					String name1 = field1.getName();
					PropertyDescriptor pd = new PropertyDescriptor(name1, object1.getClass());
					Method getMethod = pd.getReadMethod();// 获得get方法
					Object ohh = getMethod.invoke(object1);// 执行get方法返回一个Object
					for (Field field2 : fields2) {
						String name2 = field2.getName();
						if (name1.equals(name2)) {
							PropertyDescriptor pd2 = new PropertyDescriptor(name2, object2.getClass());
							Method writeMethod = pd2.getWriteMethod();// 获得set方法
							writeMethod.invoke(object2, ohh);// 执行set方法，将的值放入
						}
					}
				} catch (Exception e) {
					// logger.info(e.getMessage());
				}

			}
		}

		return object2;
	}

	/**
	 * 复制source类的同名属性到target类，忽略ignoreProperties列表包含的属性
	 * @param source
	 * @param target
	 * @param ignorePropertiesList
	 * @return Object
	 */
	public Object copyProperties(Object source, Object target, List<String> ignorePropertiesList) {
		Field[] fields1 = source.getClass().getDeclaredFields();
		Field[] fields2 = target.getClass().getDeclaredFields();
		List<String> ignorePropertiesArray = ignorePropertiesList;
		if (fields1 != null && fields2 != null) {
			for (Field field1 : fields1) {
				try {
					String name1 = field1.getName();
					PropertyDescriptor pd = new PropertyDescriptor(name1, source.getClass());
					Method getMethod = pd.getReadMethod();// 获得get方法
					Object ohh = getMethod.invoke(source);// 执行get方法返回一个Object
					for (Field field2 : fields2) {
						String name2 = field2.getName();
						if (name1.equals(name2) && !ignorePropertiesArray.contains(name1)) {
							PropertyDescriptor pd2 = new PropertyDescriptor(name2, target.getClass());
							Method writeMethod = pd2.getWriteMethod();// 获得set方法
							writeMethod.invoke(target, ohh);// 执行set方法，将的值放入
						}
					}
				} catch (Exception e) {
					e.printStackTrace();
				}

			}
		}

		return target;
	}

}
