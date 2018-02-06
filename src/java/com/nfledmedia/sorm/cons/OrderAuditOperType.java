package com.nfledmedia.sorm.cons;

import java.io.Serializable;
import java.util.HashMap;
import java.util.Map;
import java.util.NoSuchElementException;

/**
 * 表示品牌审核的操作类型
 */
@SuppressWarnings({ "rawtypes", "serial", "unchecked" })
public class OrderAuditOperType implements Serializable {

	private final Character symbol;

	// private final String description;

	private static final Map instancesBySymbol = new HashMap();

	// private OrderAuditOperType(Character symbol,String description){
	// this.symbol = symbol;
	// this.description = description;
	// instancesBySymbol.put(symbol, this);
	// }
	private OrderAuditOperType(Character symbol) {
		this.symbol = symbol;
		instancesBySymbol.put(symbol, this);
	}

	public Character getSymbol() {
		return symbol;
	}

	// public String getDescription(){
	// return description;
	// }

	public static final OrderAuditOperType ADD = new OrderAuditOperType(
			new Character('A'));
	public static final OrderAuditOperType ALTER = new OrderAuditOperType(
			new Character('L'));
	public static final OrderAuditOperType DELETE = new OrderAuditOperType(
			new Character('D'));

	public static OrderAuditOperType getInstanceBySymbol(Character symbol) {
		OrderAuditOperType result = (OrderAuditOperType) instancesBySymbol
				.get(symbol);
		if (result == null) {
			throw new NoSuchElementException(symbol.toString());
		}
		return result;
	}

	/**
	 * 保证反序列化时直接返回BrandAuditOperType类包含的静态实例
	 * 
	 * @return
	 */
	private Object readResolve() {
		return getInstanceBySymbol(symbol);
	}
}
