package com.nfledmedia.sorm.cons;

import java.io.Serializable;
import java.util.HashMap;
import java.util.Map;
import java.util.NoSuchElementException;

/**
 * 联系人状态，在职离职两种
 */
@SuppressWarnings({ "rawtypes", "serial", "unchecked" })
public class ContactState implements Serializable {

	private final Character symbol;

	private final String description;

	private static final Map instancesBySymbol = new HashMap();

	private ContactState(Character symbol, String description) {
		this.symbol = symbol;
		this.description = description;
		instancesBySymbol.put(symbol, this);
	}

	public Character getSymbol() {
		return symbol;
	}

	public String getDescription() {
		return description;
	}

	public static final ContactState ONTHEJOB = new ContactState(new Character(
			'O'), "在职");
	public static final ContactState LEAVEOFFICE = new ContactState(
			new Character('L'), "离职");

	public static ContactState getInstanceBySymbol(Character symbol) {
		ContactState result = (ContactState) instancesBySymbol.get(symbol);
		if (result == null) {
			throw new NoSuchElementException(symbol.toString());
		}
		return result;
	}

	/**
	 * 保证反序列化时直接返回ContactState类包含的静态实例
	 * 
	 * @return
	 */
	private Object readResolve() {
		return getInstanceBySymbol(symbol);
	}
}
