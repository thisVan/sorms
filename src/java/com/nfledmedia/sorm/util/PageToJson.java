package com.nfledmedia.sorm.util;

import java.util.List;

import org.json.JSONException;
import org.json.JSONObject;

public class PageToJson {

	public static JSONObject toJsonWithoutData(Page page) throws JSONException {
		JSONObject jsonObject = new JSONObject();
		jsonObject.put("total", page.getTotalPageCount());
		jsonObject.put("page", page.getCurrentPageNo());
		jsonObject.put("records", page.getTotalCount());
		return jsonObject;
	}
	public static JSONObject toJsonFromListWithoutData(List list) throws JSONException {
		JSONObject jsonObject = new JSONObject();
		jsonObject.put("total", 1);
		jsonObject.put("page", 1);
		jsonObject.put("records",list.size());
		return jsonObject;
	}
}
