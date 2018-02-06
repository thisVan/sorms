package com.nfledmedia.sorm.cons;

import java.util.Collection;

/**
 * 整个应用通用的常量
 */
public class CommonConstant {

	/**
	 * 每页记录数
	 */
	public static final int DEFAULT_PAGE_SIZE = 10;

	/**
	 * session中存放登录用户id的字段名
	 */
	public static final String SESSION_ID = "id";

	/**
	 * session中存放登录用户的主页的字段名
	 */
	public static final String SESSION_HOMEPAGE = "home";

	/**
	 * 新创建的用户初始密码
	 */
	public static final String INITIAL_PASSWORD = "123456";

	/**
	 * 附件保存路径
	 */
	public static final String SAVE_PATH = "/upload";

	/**
	 * 领取操作的返回结果描述信息
	 */
	public static final String[] FOLLOW_MESSAGE = { "您之前已提交过，正在审核中，请耐心等待",
			"领取操作成功，请等待审核", "该客户已被领取", "" };
	/**
	 * 修改个人密码的返回结果描述信息
	 */
	public static final String[] UPDATE_MY_MESSAGE = { "修改成功", "您尚未登录",
			"旧密码不正确", "两次密码不相等" };

	// /**
	// * 删除人员层次表数据时返回结果描述信息
	// */
	// public static final String[] DELELE_PERSON_LEVEL =
	// {"删除成功","包含有子节点","未知原因"};
	//
	/**
	 * 删除部门列表数据时返回结果描述信息
	 */
	public static final String[] DELELE_DEPARTMENT = { "删除成功", "包含有子节点", "未知原因" };
}
