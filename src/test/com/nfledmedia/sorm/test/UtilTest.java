package com.nfledmedia.sorm.test;

import org.junit.Test;
import org.springframework.beans.BeanUtils;

import com.nfledmedia.sorm.entity.Order;
import com.nfledmedia.sorm.entity.OrderHistory;
import com.nfledmedia.sorm.util.ExcelUtil;

public class UtilTest {
	
	@Test
	public void propertiesCopyTest(){
		Order order = new Order();
		order.setDuration((short) 15);
		order.setContent("string");
		OrderHistory orderHistory = new OrderHistory();
		orderHistory.setDuration((short) 30);
		
		BeanUtils.copyProperties(order, orderHistory, new String[] { "content", "led", "duration", "frequency", "startdate", "enddate", "starttime", "endtime", "playstrategy" });
		
		System.out.println(order);
		System.out.println(orderHistory);
		
	}
	
	@Test
	public void excelUtilTest(){
		System.out.println(ExcelUtil.colName2Index("jk"));
		System.out.println(ExcelUtil.index2ColName(1136));
	}
}
