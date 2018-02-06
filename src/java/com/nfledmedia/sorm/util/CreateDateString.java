package com.nfledmedia.sorm.util;

import java.text.SimpleDateFormat;
import java.util.Date;


/**
 * 
 * 项目名称：sorm  
 * 类全名：com.nfledmedia.sorm.util.CreateDateString    
 * 类描述：生成交易流水号的字符串
 * 创建人：Van  
 * 创建时间：2016年11月27日 下午2:35:08    
 * 修改备注：    
 * @version  jdk1.6 
 * 
 * Copyright (c) 2016, this.van@hotmail.com  All Rights Reserved.
 */
public class CreateDateString {
	public String createDateString() {
		Date date = new Date();
		String dateString = new SimpleDateFormat("yyyyMMdd").format(date)+ new SimpleDateFormat("HHmmss").format(date);
		dateString += Math.round(Math.random() * 1000);
		return dateString;
		
	}
}


