package com.nfledmedia.sorm.util;

import java.io.*;

import net.sf.json.JSONObject;

/**
 * 项目名称：sorm 
 * 类全名:com.nfledmedia.sorm.util.CreateJsonFile 
 * 类描述：
 * 创建人：Van@nfledmedia 
 * 创建时间：2016年6月16日 下午6:52:28 
 * 修改备注：
 * 
 * @version jdk1.7
 * 
 * Copyright (c) 2016, bolven@qq.com All Rights Reserved.
 */
public class CreateJsonFile {

	/**
	 * 
	 * readJson: 从给定位置读取Json文件 TODO (这里描述这个方法适用条件 – 可选).
	 * 
	 * @author Wu. Van
	 * @param path
	 * @return
	 * @since JDK 1.6
	 */
	/*
	 * public static String readJson(String path){ //从给定位置获取文件 File file = new
	 * File(path); BufferedReader reader = null; //返回值,使用StringBuffer
	 * StringBuffer data = new StringBuffer(); // try { reader = new
	 * BufferedReader(new FileReader(file)); //每次读取文件的缓存 String temp = null;
	 * while((temp = reader.readLine()) != null){ data.append(temp); } } catch
	 * (FileNotFoundException e) { e.printStackTrace(); } catch (IOException e)
	 * { e.printStackTrace(); }finally { //关闭文件流 if (reader != null){ try {
	 * reader.close(); } catch (IOException e) { e.printStackTrace(); } } }
	 * return data.toString(); }
	 */

	/**
	 * 
	 * writeJson: 给定路径与Json文件，存储到硬盘 TODO (这里描述这个方法适用条件 – 可选).
	 * 
	 * @author Wu. Van
	 * @param path
	 * @param json
	 * @param fileName
	 * @since JDK 1.6
	 */
	public static void writeJson(String path, JSONObject json, String fileName) {

		BufferedWriter writer = null;
		File file = new File(path + fileName + ".json");
		// 如果文件存在，则删除；不存在，则新建一个
		if (file.exists()) {
			file.delete();
		}
		try {
			file.createNewFile();
		} catch (IOException e) {
			e.printStackTrace();
		}

		// 写入文件
		try {
			writer = new BufferedWriter(new FileWriter(file));
			writer.write(json.toString());
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			try {
				if (writer != null) {
					writer.close();
				}
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		// System.out.println("文件写入成功！");
	}

}