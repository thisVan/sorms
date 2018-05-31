package com.nfledmedia.sorm.util;

import java.util.HashSet;
import java.util.Set;

import org.json.JSONArray;

public class JsonarrayDistinct {
	
	public static JSONArray jsonarrayDistinct(JSONArray array){
		Set<Object> set = new HashSet<Object>();
		for (Object o : array) {
			set.add(o);
		}
		JSONArray jsonArray = new JSONArray();
		for (Object object : set) {
			jsonArray.put(object);
		}
		return jsonArray;
		
	}

}
