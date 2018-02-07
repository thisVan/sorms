package com.nfledmedia.sorm.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.Map;

import javax.persistence.ManyToOne;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Service;

import com.nfledmedia.sorm.cons.CommonConstant;
import com.nfledmedia.sorm.entity.Resource;
import com.nfledmedia.sorm.entity.User;
import com.nfledmedia.sorm.service.UserService;
import com.nfledmedia.sorm.service.YewuService;
import com.nfledmedia.sorm.util.MD5Util;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ModelDriven;

/**
 * 项目名称：sorm 类全名:com.nfledmedia.sorm.action.UserAction 类描述： 创建人：Van@nfledmedia
 * 创建时间：2016年6月13日 下午1:30:44 修改备注：
 * 
 * @version jdk1.7 Copyright (c) 2016, bolven@qq.com All Rights Reserved.
 */
@Controller
public class UserAction extends SuperAction implements ModelDriven<User> {

	private static final long serialVersionUID = 1L;
	
	private String returnURL;
	private User user;
	private String oldPassword;
	private String newPassword;
	private String repeatedNewPassword;
	private String account;

	private int page;
	private String sidx;
	private String sord;
	private int rows;

	private boolean _search;
	private String searchField;
	private String searchString;
	private String searchOper;
	private String usernameAuto;

	private Long tid;

	@Override
	public User getModel() {
		// TODO Auto-generated method stub
		if (user == null) {
			user = new User();
		}
		return user;
	}

	// 注入userservice
	@Autowired
	private UserService userService;
	@Autowired
	private YewuService yewuService;

	private void sentMsg(String content) throws IOException {
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setCharacterEncoding("utf-8");
		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		out.print(content);
		out.flush();
		out.close();
	}

	public String login() {
		System.out.println("loginAuto:" + usernameAuto);
		ActionContext ctx = ActionContext.getContext();
		if (usernameAuto != null && !"".equals(usernameAuto)) {
			User userAuto = new User();
			user.setPassword(MD5Util.encrypt32(user.getPassword()));
			userAuto.setUsername(usernameAuto);
			userAuto.setPassword(user.getPassword());
			User userAutoPojo = userService.chkAndBackPojo(userAuto);
			if (userAutoPojo != null) {
				session.setAttribute("username", userAutoPojo.getUsername());
				request.setAttribute("message", "登录成功！");
				ctx.getSession().put(CommonConstant.SESSION_ID, userAutoPojo.getId());
				String homePage = ((Resource) (userAutoPojo.getRole().getRoleResources().get(0))).getUrl();
				ctx.getSession().put(CommonConstant.SESSION_HOMEPAGE, homePage);
				if (returnURL == null) {
					returnURL = homePage;
				}
				System.out.println("~~~~~~~~~~UserAction(returnURL):" + returnURL);
				return "login_success";
			} else {
				request.setAttribute("message", "用户名或密码错误，请重新登录！");
				return "login_failure";
			}
		} else {
			if (usernameAuto == null && (user.getUsername() == null || user.getUsername() == "")
					&& (user.getPassword() == null || user.getPassword() == "")) {
				return "login_failure";
			} else {
				user.setPassword(MD5Util.encrypt32(user.getPassword()));
				User userPojo = userService.chkAndBackPojo(user);
				assert userPojo == null;

				if (userPojo != null) {
					System.out.println("~~~~~~~~~~UserAction(userName):" + userPojo.getUsername());
					session.setAttribute("username", userPojo.getUsername());
					request.setAttribute("message", "登录成功！");
					ctx.getSession().put(CommonConstant.SESSION_ID, userPojo.getId());
					String homePage = ((Resource) (userPojo.getRole().getRoleResources().get(0))).getUrl();
					ctx.getSession().put(CommonConstant.SESSION_HOMEPAGE, homePage);
					if (returnURL == null) {
						returnURL = homePage;
					}
					System.out.println("~~~~~~~~~~UserAction(returnURL):" + returnURL);
					return "login_success";
				} else {
					request.setAttribute("message", "用户名或密码错误，请重新登录！");
					return "login_failure";
				}

			}
		}

	}

	public String userInfo() throws Exception {
		Map session = ActionContext.getContext().getSession();
		user = userService.getUserById((Integer) session.get(CommonConstant.SESSION_ID));
		return SUCCESS;
	}

	// public String userlist() throws Exception {
	// Map session = ActionContext.getContext().getSession();
	// Integer id = (Integer) session.get(CommonConstant.SESSION_ID);
	// System.out.println("！！！！！！！！！！！！！！！！！！！ sidx=" + sidx + " sord="
	// + sord + " page=" + page + " rows=" + rows
	// + " !!!!!!!!!!!!!!!!!!!");
	// Page result = null;
	// if (_search == false) {
	// result = userService.getUserList(sidx, sord, page, rows);
	// } else {
	// result = userService.getUserListByKeyword(searchString, sidx, sord,
	// page, rows);
	// System.out.println("searchString:" + searchString);
	// }
	//
	// JSONObject jsonObject = PageToJson.toJsonWithoutData(result);
	// JSONArray jsonArray = new JSONArray();
	// List data = result.getResult();
	// SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");
	// for (int i = 0, size = data.size(); i < size; i++) {
	//
	// Object[] row = (Object[]) data.get(i);
	//
	// JSONObject jsonObject1 = new JSONObject();
	// JSONArray jsonArray2 = new JSONArray(); // 求取cell
	//
	// JSONObject jsonObject2 = new JSONObject();
	// jsonObject2.put("id", row[0]);
	// jsonObject2.put("name", row[1]);
	// jsonArray2.put(row[0]);// id
	// jsonArray2.put(jsonObject2); // 用户名
	// jsonArray2.put(row[2]);// 姓名
	// jsonArray2.put(row[3]);// 部门
	// jsonArray2.put(row[4]);// 角色
	// jsonArray2.put(row[5]);// 密码
	//
	// jsonObject1.put("cell", jsonArray2); // 加入cell
	// jsonArray.put(jsonObject1);
	//
	// }
	// jsonObject.put("rows", jsonArray); // 加入rows
	//
	// sentMsg(jsonObject.toString());
	// return null;
	// }

	public String getAllRole() throws Exception {
		List result = null;
		result = userService.getAllRole();
		JSONObject jsonObject = new JSONObject();
		jsonObject.put("info", result);
		sentMsg(jsonObject.toString());
		return null;
	}

	public void setUserService(UserService userService) {
		this.userService = userService;
	}

	public String getReturnURL() {
		return returnURL;
	}

	public void setReturnURL(String returnURL) {
		this.returnURL = returnURL;
	}

	public String getOldPassword() {
		return oldPassword;
	}

	public void setOldPassword(String oldPassword) {
		this.oldPassword = oldPassword;
	}

	public String getNewPassword() {
		return newPassword;
	}

	public void setNewPassword(String newPassword) {
		this.newPassword = newPassword;
	}

	public String getRepeatedNewPassword() {
		return repeatedNewPassword;
	}

	public void setRepeatedNewPassword(String repeatedNewPassword) {
		this.repeatedNewPassword = repeatedNewPassword;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public String getAccount() {
		return account;
	}

	public void setAccount(String account) {
		this.account = account;
	}

	public int getPage() {
		return page;
	}

	public void setPage(int page) {
		this.page = page;
	}

	public String getSidx() {
		return sidx;
	}

	public void setSidx(String sidx) {
		this.sidx = sidx;
	}

	public String getSord() {
		return sord;
	}

	public void setSord(String sord) {
		this.sord = sord;
	}

	public int getRows() {
		return rows;
	}

	public void setRows(int rows) {
		this.rows = rows;
	}

	public boolean is_search() {
		return _search;
	}

	public void set_search(boolean _search) {
		this._search = _search;
	}

	public String getSearchString() {
		return searchString;
	}

	public void setSearchString(String searchString) {
		this.searchString = searchString;
	}

	public String getSearchOper() {
		return searchOper;
	}

	public void setSearchOper(String searchOper) {
		this.searchOper = searchOper;
	}

	public Long getTid() {
		return tid;
	}

	public void setTid(Long tid) {
		this.tid = tid;
	}

	public void setYewuService(YewuService yewuService) {
		this.yewuService = yewuService;
	}

	public String getUsernameAuto() {
		return usernameAuto;
	}

	public void setUsernameAuto(String usernameAuto) {
		this.usernameAuto = usernameAuto;
	}

}
