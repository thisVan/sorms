package com.nfledmedia.sorm.test;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.beanutils.converters.ClassConverter;
import org.junit.Test;
import org.springframework.beans.BeanUtils;

import com.nfledmedia.sorm.entity.Order;
import com.nfledmedia.sorm.entity.OrderHistory;
import com.nfledmedia.sorm.entity.User;
import com.nfledmedia.sorm.util.ClassesConvertTool;
import com.nfledmedia.sorm.util.ExcelUtil;
import com.nfledmedia.sorm.util.MD5Util;

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
	
	@Test
	public void copyPropsTest() {
		Order order = new Order();
		order.setDuration((short) 15);
		order.setContent("string");
		OrderHistory orderHistory = new OrderHistory();
		orderHistory.setDuration((short) 30);
		
		new ClassesConvertTool().copyProperties(order, orderHistory, new ArrayList<String>(Arrays.asList( "content", "led", "frequency", "startdate", "enddate", "starttime", "endtime", "playstrategy" )));
		
		System.out.println(order);
		System.out.println(orderHistory);
	}
	
	@Test
	public void hashCodeTest(){
		String str = "北方大厦福利彩票120152017-08-012018-08-0108：00：00";
		str += "22：00：00";
		System.out.println(MD5Util.encrypt32(str));
	}
	
	@Test
	public void dateBeforeTest() throws ParseException {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		
		Date date = sdf.parse("2018-11-23");
		Date date1 = sdf.parse("2018-11-24");
		System.out.println(date.compareTo(date1));;
	}
	
	@Test
	public void stringBuilderTest() {

		Map<String, String> map = new HashMap<String, String>();
		map.put("end", "2018-11-28");
		map.put("start", "2018-10-01");

		
		StringBuilder sb = new StringBuilder("SELECT * FROM my_daily, `user`, ( SELECT MAX(create_time) AS create_time, daily_id AS daily_id FROM my_daily GROUP BY user_id, company_name ) AS b ");
		sb.append(map);
		sb.append(" b.create_time = my_daily.create_time AND `user`.deleted = 0 AND my_daily.deleted = 0 ORDER BY CONVERT ( `user`.department USING gb2312 ), CONVERT (`user`.`name` USING gb2312), b.create_time");
		String sql = sb.toString();
		
		System.out.println(sql);
	}
	
	@Test
	public void emptyStringEqualsTest() {
		String whereParam = "my_daily.create_time >= '124587' and my_daily.create_time <='467456'  and";
		System.out.println(whereParam);
		if (whereParam.endsWith("and")) {
			whereParam = whereParam.substring(0, whereParam.length() - "and".length());
		}
		System.out.println(whereParam);
	}
	
	@Test
	public void beanUtilTest() throws ParseException {
		Order order = new Order();
		order.setContent("瓜子二手车");
		order.setDuration((short) 15);
		order.setFrequency((short) 60);
		order.setStartdate(new Date());
		order.setEnddate(new Date());
		
		Order newOrder = new Order();
		// String[] ignoreProperties = {"content", "led", "duration", "frequency", "startdate", "enddate", "starttime", "endtime", "playstrategy"};
		String[] ignoreProperties = {"content", "led", "duration"};
		List<String> ignorePropertiesList = new ArrayList<String>(Arrays.asList(ignoreProperties));
		List<String> ignoreList = new ArrayList<String>(Arrays.asList(ignoreProperties));
		ignorePropertiesList =  ignoreList;

		BeanUtils.copyProperties(order, newOrder, ignoreProperties);
		System.out.println(newOrder.getContent() + " " + newOrder.getDuration() + " " + newOrder.getFrequency());
		
		Order newOrder1 = new Order();
		new ClassesConvertTool().copyProperties(order, newOrder1, ignorePropertiesList);
		
		System.out.println(newOrder1.getContent() + " " + newOrder1.getDuration() + " " + newOrder1.getFrequency());
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		SimpleDateFormat fulldateformat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Date dateOri = new Date();
		Date date = sdf.parse(sdf.format(dateOri));
		System.out.println(dateOri.getTime());
		System.out.println(date.getTime());
		System.out.println(fulldateformat.format(date));
		
		Calendar todayStart = Calendar.getInstance();
		todayStart.set(Calendar.HOUR_OF_DAY, 0);
		todayStart.set(Calendar.MINUTE, 0);
		todayStart.set(Calendar.SECOND, 0);
		todayStart.set(Calendar.MILLISECOND, 0);
		
		System.out.println(todayStart.getTime().getTime());
		System.out.println(fulldateformat.format(todayStart.getTime()));
		
		System.out.println(sdf.format(new Date(date.getTime() - 1000*60*60*24)));
	}
	
	@Test
	public void testString() {
		User u = new User();
		System.out.println(u.getUsername());
		String str = "ert";
		System.out.println(str.contains(""));
	}

}
