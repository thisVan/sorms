package com.nfledmedia.sorm.util;

import java.util.HashSet;
import java.util.Set;

import com.google.gson.JsonArray;
import com.google.gson.JsonElement;

public class JsonarrayDistinct {
	
	public static JsonArray jsonarrayDistinct(JsonArray array){
		Set<String> set = new HashSet<String>();
		for (JsonElement o : array) {
			set.add(o.getAsString());
		}
		JsonArray jsonArray = new JsonArray();
		for (String object : set) {
			jsonArray.add(object);;
		}
		return jsonArray;
		
	}

}
