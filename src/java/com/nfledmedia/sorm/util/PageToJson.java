package com.nfledmedia.sorm.util;

import java.util.List;
import com.google.gson.JsonObject;

public class PageToJson {

	public static JsonObject toJsonWithoutData(Page page) {
		JsonObject jsonObject = new JsonObject();
		jsonObject.addProperty("total", page.getTotalPageCount());
		jsonObject.addProperty("page", page.getCurrentPageNo());
		jsonObject.addProperty("records", page.getTotalCount());
		return jsonObject;
	}
	public static JsonObject toJsonFromListWithoutData(List list) {
		JsonObject jsonObject = new JsonObject();
		jsonObject.addProperty("total", 1);
		jsonObject.addProperty("page", 1);
		jsonObject.addProperty("records",list.size());
		return jsonObject;
	}
}
