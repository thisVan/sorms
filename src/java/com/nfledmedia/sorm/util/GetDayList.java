package com.nfledmedia.sorm.util;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.List;

/**
 * 
 * 项目名称：dynamic-quote-system 类全名:com.nfledmedia.dynamicquotesystem.GetDayList
 * 类描述：获取时间序列，作为前端界面中图表的时间轴 创建人：Van@nfledmedia 创建时间：2016年5月30日 上午10:52:42 修改备注：
 * 
 * @version jdk1.7
 * 
 * Copyright (c) 2016, wufc@nfledmedia.com All Rights Reserved.
 */
public class GetDayList {

	public GetDayList() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * 
	 * getProccedDate:返回处理过的时间序列，这个时间序列形如 31,2016年，2,3,...,31,2月,2... TODO
	 * 在方法getDay()之后进行处理
	 * 
	 * @author Wu. Van
	 * @param date
	 * @return
	 * @since JDK 1.6
	 */
	public static ArrayList<String> getProccedDate(Date date, int n) {
		ArrayList<String> arrLst = GetDayList.getDay(date, n);
		Date date1234 = new Date();
		List<String> lst = new ArrayList<String>();
		String str, strShort = null;
		System.out.println("in getDay" + arrLst);
		for (int i = 0; i < arrLst.size(); i++) {
			str = arrLst.get(i);
			System.out.println("shuc " + "第" + i + "次 " + str);
			charge: if (str.endsWith("01")) {
				if ("01".equals(str.substring(str.indexOf("-") + 1,
						str.lastIndexOf("-")))) {
					strShort = str.substring(0, 4) + "年";
				} else {
					if (!str.substring(str.indexOf("-") + 1,
							str.lastIndexOf("-")).startsWith("0")) {
						strShort = str.substring(str.indexOf("-") + 1,
								str.lastIndexOf("-"))
								+ "月";
						break charge;
					}
					strShort = str.substring(str.indexOf("-") + 2,
							str.lastIndexOf("-"))
							+ "月";
				}
			} else {
				strShort = str.substring(8);
			}

			lst.add(strShort);
		}
		return (ArrayList<String>) lst;

	}

	/**
	 * 取得当前日期所在周的第一天
	 * 
	 * @param date
	 * @return
	 */
	public static Date getFirstDayOfWeek() {
		Calendar c = new GregorianCalendar();
		c.setFirstDayOfWeek(Calendar.MONDAY);
		c.setTime(new Date());
		c.set(Calendar.DAY_OF_WEEK, c.getFirstDayOfWeek()); // Monday
		return c.getTime();
	}

	/**
	 * 取得当前日期所在周的最后一天
	 * 
	 * @param date
	 * @return
	 */
	public static Date getLastDayOfWeek() {
		Calendar c = new GregorianCalendar();
		c.setFirstDayOfWeek(Calendar.MONDAY);
		c.setTime(new Date());
		c.set(Calendar.DAY_OF_WEEK, c.getFirstDayOfWeek() + 6); // Sunday
		return c.getTime();
	}

	/**
	 * 
	 * getDay:返回某一时间后n天日期序列 TODO (这里描述这个方法适用条件 – 可选).
	 * 
	 * @author Wu. Van
	 * @param date
	 * @return
	 * @since JDK 1.6
	 */
	public static ArrayList<String> getDay(Date date, int n) {
		ArrayList<String> strArr = new ArrayList<String>();
		long time = date.getTime();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		try {
			sdf.parse("2016-06-25");
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		String dateStyle;
		for (int i = 0; i < n; i++) {
			Date nDate = new Date(time);
			dateStyle = sdf.format(nDate);
			strArr.add(dateStyle);
			time += 86400000;
		}
		Date nDate = new Date(time);
		System.out.println(sdf.format(nDate));
		System.out.println(strArr.toString());
		System.out.println(strArr.size());
		return strArr;

	}
}
