package com.nfledmedia.sorm.util;

import java.sql.SQLException;
import java.util.Iterator;
import java.util.List;

import com.google.gson.JsonObject;


/**
 * 项目名称：sorm 类全名:com.nfledmedia.sorm.util.List2Json 类描述： 创建人：Van@nfledmedia
 * 创建时间：2016年6月16日 下午7:20:37 修改备注：
 * 
 * @version jdk1.7
 * 
 * Copyright (c) 2016, bolven@qq.com All Rights Reserved.
 */
public class List2Json {
	public static JsonObject listToJSON(List list) {
		JsonObject list_json = new JsonObject();
		try {
			for (Iterator<Throwable> iterator = ((SQLException) list).iterator(); iterator.hasNext();) {
				Object obj = iterator.next();
				// list_json.put("JobID", obj.getJobID());
				// list_json.put("AssistantNO", obj.getAssistantNO());
				// list_json.put("FeeName", obj.getFeeName());
				// list_json.put("PE", obj.getPE());

			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		System.out.println(list_json.size());
		return list_json;

	}
}
