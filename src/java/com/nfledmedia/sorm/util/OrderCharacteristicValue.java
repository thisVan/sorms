package com.nfledmedia.sorm.util;

import com.nfledmedia.sorm.entity.Order;

public class OrderCharacteristicValue {
	public static String calcCharacter(Order order){
		String attrValue = "";
		attrValue += order.getAttribute().getId();
		attrValue += order.getLed().getId();
		attrValue += order.getContent();
		attrValue += order.getDuration();
		attrValue += order.getFrequency();			
		attrValue += order.getStartdate().toString();
		attrValue += order.getEnddate().toString();
		attrValue += order.getStarttime().toString();
		attrValue += order.getEndtime().toString();
		
		return MD5Util.encrypt32(attrValue);
		
	}
}
