package com.nfledmedia.sorm.cons;

import java.io.Serializable;
import java.util.HashMap;
import java.util.Map;
import java.util.NoSuchElementException;

/**
 * 表示User类状态的枚举类
 */
@SuppressWarnings({ "rawtypes", "serial", "unchecked" })
public class UserState implements Serializable {

	private final Character symbol;

	private static final Map instancesBySymbol = new HashMap();

	/**
	 * 构造方法声明为private类型，以便禁止外部程序创建UserState实例
	 * 
	 * @param symbol
	 */
	public UserState(Character symbol) {
		this.symbol = symbol;
		instancesBySymbol.put(symbol, this);
	}

	public Character getSymbol() {
		return symbol;
	}

//	public static final UserState NORMAL = new UserState(new Character('N'));
//	public static final UserState FIRST_LOGIN = new UserState(new Character('F'));
//	public static final UserState DELETE = new UserState(new Character('D'));
	
	public static final String NORMAL = "N";
	public static final String FIRST_LOGIN = "F";
	public static final String DELETE = "D";

	public static UserState getInstanceBySymbol(Character symbol) {
		UserState result = (UserState) instancesBySymbol.get(symbol);
		if (result == null) {
			throw new NoSuchElementException(symbol.toString());
		}
		return result;
	}

	/**
	 * 保证反序列化时直接返回UserState类包含的静态实例
	 * 
	 * @return
	 */
	private Object readResolve() {
		return getInstanceBySymbol(symbol);
	}
}
