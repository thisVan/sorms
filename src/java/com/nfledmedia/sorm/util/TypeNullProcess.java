package com.nfledmedia.sorm.util;

public class TypeNullProcess {

	public static int nullValueProcess(Object o) {
		if (o == null) {
			return 0;
		}else if (o.getClass().equals(String.class)) {
			return Integer.parseInt((String) o);
		}else if (o.getClass().equals(Integer.class)) {
			return (Integer) o;
		}else if (o.getClass().equals(Short.class)) {
			return ((Short)o).intValue();
		}
		return 0;
	}
}
