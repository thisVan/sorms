package com.nfledmedia.sorm.util;

import java.security.MessageDigest;

/**
 * Created by PC-FAN on 2017/11/20.
 */
public class MD5Util {
	/**
	 * MD5加密大写32位
	 * @param encryptStr
	 * @return
	 */
	public static String encrypt32(String encryptStr) {
		MessageDigest md5;
		try {
			md5 = MessageDigest.getInstance("MD5");
			byte[] md5Bytes = md5.digest(encryptStr.getBytes());
			StringBuffer hexValue = new StringBuffer();
			for (int i = 0; i < md5Bytes.length; i++) {
				int val = ((int) md5Bytes[i]) & 0xff;
				if (val < 16)
					hexValue.append("0");
				hexValue.append(Integer.toHexString(val));
			}
			encryptStr = hexValue.toString().toUpperCase();
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
		return encryptStr;
	}

	/**
	 * MD5加密大写16位
	 * @param encryptStr
	 * @return
	 */
	public static String encrypt16(String encryptStr) {
		return encrypt32(encryptStr).substring(8, 24);
	}
}
