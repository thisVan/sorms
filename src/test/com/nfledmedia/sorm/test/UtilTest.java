package com.nfledmedia.sorm.test;

import org.junit.Test;

import com.nfledmedia.sorm.util.ExcelUtil;

public class UtilTest {
	
	@Test
	public void excelUtilTest(){
		System.out.println(ExcelUtil.colName2Index("jk"));
		System.out.println(ExcelUtil.index2ColName(1136));
	}
}
