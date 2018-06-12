package com.nfledmedia.sorm.cons;

public class ProjectAttributeConstant {
	/**
	 * 客户属性
	 */
	public static final String CLIENT_TYPE_1 = "直客";

	/**
	 * LED属性，A表示激活的
	 */
	public static final String LED_ACTIVE_STATE = "A";

	/**
	 * Adcontract属性，A表示激活的
	 */
	public static final String ADCONTRACT_ACTIVE_STATE = "A";

	/**
	 * Order对象state字段的属性
	 */
	public static final String ORDER_STATE_ACTIVE = "A";
	public static final String ORDER_STATE_DEAD = "D";

	/**
	 * 下单属性
	 */
	public static final String ATTRIBUTE_BUSSINESS = "商业";
	public static final String ATTRIBUTE_PRESENT = "赠播";
	public static final String ATTRIBUTE_COMMONWEAL = "公益";

	/**
	 * operatetype属性
	 */
	public static final Short ADVERTISE_NORMAL = 0;
	public static final Short ADVERTISE_ALTER = 1;
	public static final Short ADVERTISE_STOP = 2;
	public static final Short ADVERTISE_REVOKE = 3;
	public static final Short ADVERTISE_ORDER_DELETE = 4;
}
