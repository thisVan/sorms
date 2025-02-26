package com.nfledmedia.sorm.action;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;

import com.google.gson.JsonObject;
import com.nfledmedia.sorm.entity.Resource;
import com.nfledmedia.sorm.entity.RoleResource;
import com.nfledmedia.sorm.entity.User;
import com.nfledmedia.sorm.service.ResourceService;
import com.nfledmedia.sorm.service.UserService;
import com.nfledmedia.sorm.service.YewuService;
import com.nfledmedia.sorm.util.MD5Util;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ModelDriven;

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
	
	/*
	 * @Value("#{ipallowedProperties.allowip}") private String allowip;
	 */

	@Autowired
	private UserService userService;

	@Autowired
	private YewuService yewuService;

	@Autowired
	private ResourceService resourceService;

	public User getModel() {
		if (this.user == null) {
			this.user = new User();
		}
		return this.user;
	}

	public String login() {
		System.out.println("loginAuto:" + this.usernameAuto);
		ActionContext ctx = ActionContext.getContext();
		
		if (this.user.getUsername()!= null && !verifyRemoteAccess(this.user.getUsername())) {
			this.request.setAttribute("message", "登录失败，注意：此应用不被允许在办公室以外网络使用！");
			return "login_failure";
		}
		
		if (this.usernameAuto != null && !"".equals(this.usernameAuto)) {
			// 自动登录
			User userAuto = new User();
			this.user.setPassword(MD5Util.encrypt32(this.user.getPassword()));
			userAuto.setUsername(this.usernameAuto);
			userAuto.setPassword(this.user.getPassword());
			User userAutoPojo = this.userService.chkAndBackPojo(userAuto);
			if (userAutoPojo != null) {
				this.session.setAttribute("username", userAutoPojo.getUsername());
				this.request.setAttribute("message", "登录成功！");
				ctx.getSession().put("id", userAutoPojo.getId());
				String homePage = "screenOccupancyRate";

				// 2019年3月11日 18点48分 修改resource列表的处理方法
				// List<?> resourceList =
				// userAutoPojo.getRole().getRoleResources();
				List<RoleResource> roleResourcesList = resourceService.getResourcesByRole(userAutoPojo.getRole().getId());
				List<Resource> resourceList = new ArrayList<Resource>();
				for (RoleResource roleResource : roleResourcesList) {
					resourceList.add(roleResource.getResource());
				}
				System.out.println("资源列表：" + resourceList + "长度" + resourceList.size());
				if ((resourceList != null) && (resourceList.size() > 0)) {
					homePage = ((Resource) resourceList.get(0)).getUrl();
				}
				ctx.getSession().put("home", homePage);
				if (this.returnURL == null) {
					this.returnURL = homePage;
				}
				System.out.println("UserAction(returnURL):" + this.returnURL);
				return "login_success";
			}
			this.request.setAttribute("message", "用户名或密码错误，请重新登录！");
			return "login_failure";
		}
		if ((this.usernameAuto == null) && ((this.user.getUsername() == null) || (this.user.getUsername() == ""))
				&& ((this.user.getPassword() == null) || (this.user.getPassword() == ""))) {
			return "login_failure";
		}

		// 用户登录
		this.user.setPassword(MD5Util.encrypt32(this.user.getPassword()));
		User userPojo = this.userService.chkAndBackPojo(this.user);
		if (userPojo != null) {
			System.out.println("UserAction(userName):" + userPojo.getUsername());
			this.session.setAttribute("username", userPojo.getUsername());
			this.request.setAttribute("message", "登录成功！");
			ctx.getSession().put("id", userPojo.getId());
			String homePage = "screenOccupancyRate";

			// 2019年3月11日 18点48分 修改resource列表的处理方法
			List<RoleResource> roleResourcesList = resourceService.getResourcesByRole(userPojo.getRole().getId());
			List<Resource> resourceList = new ArrayList<Resource>();
			for (RoleResource roleResource : roleResourcesList) {
				resourceList.add(roleResource.getResource());
				System.out.println(roleResource.getResource().getName());
			}
			// System.out.println("资源列表：" + resourceList + "长度" +
			// resourceList.size());
			if ((resourceList != null) && (resourceList.size() > 0)) {
				homePage = resourceList.get(0).getUrl();
			}
			ctx.getSession().put("home", homePage);
			if (this.returnURL == null) {
				this.returnURL = homePage;
			}
			System.out.println("UserAction(returnURL):" + this.returnURL);
			return "login_success";
		}
		this.request.setAttribute("message", "用户名或密码错误，请重新登录！");
		return "login_failure";
	}

	public String userInfo() throws Exception {
		Map session = ActionContext.getContext().getSession();
		this.user = this.userService.getUserById((Integer) session.get("id"));
		return "success";
	}

//	public String getAllRole() throws Exception {
//		List result = this.userService.getAllRole();
//		JsonObject jsonObject = new JsonObject();
//		jsonObject.addProperty("info", result);
//		sentMsg(jsonObject.toString());
//		return null;
//	}

	/**
	 * 修改密码
	 * 
	 * @throws IOException
	 */
	public String updateMyPassword() throws IOException {
		ActionContext ctx = ActionContext.getContext();
		User user = userService.getUserById((Integer) ctx.getSession().get("id"));
		String tipInfo = "";
		// 验证非空
		if (oldPassword != null && newPassword != null && repeatedNewPassword != null && !"".equals(oldPassword) && !"".equals(newPassword)
				&& !"".equals(repeatedNewPassword)) {
			// 验证重复密码是否一致
			if (newPassword.equals(repeatedNewPassword)) {
				// 验证旧密码是否正确
				if (MD5Util.encrypt32(oldPassword).equals(user.getPassword())) {
					// 验证新密码长度
					if (newPassword.length() <= 6) {
						tipInfo = "新密码长度太短！";
					} else {
						// 更改密码
						user.setPassword(MD5Util.encrypt32(newPassword));
						tipInfo = userService.updateUser(user);
					}
				} else {
					tipInfo = "旧密码不正确！";
				}
			} else {
				tipInfo = "两次输入不一致！";
			}
		} else {
			tipInfo = "必填选项未填写！";
		}

		JsonObject jsonObject = new JsonObject();
		jsonObject.addProperty("info", tipInfo);
		sentMsg(jsonObject.toString());

		return null;
	}

	private void sentMsg(String content) throws IOException {
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setCharacterEncoding("utf-8");
		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		out.print(content);
		out.flush();
		out.close();
	}
	
	/**
	 * 校验是否拥有远程访问权限
	 * @param uname
	 * @return
	 */
	public boolean verifyRemoteAccess(String uname) {
		String realIp = getRealIp();
		System.out.println("客户端IP：" + realIp);
		// 读取文件
		String configPath = this.getClass().getResource("/").getPath().replaceAll("%20", " ");
		// 截取字符串得到WEB-INF路径然后拼接
		System.out.println("configPath=" + configPath);
		Properties properties = new Properties();
		try {
			properties.load(new FileInputStream(configPath + "ipsconfig.properties"));
			// 获得属性文件中的IP
			String ips = properties.getProperty("allow_ip");
			String excludes = properties.getProperty("exclude_user");
			System.out.println("allow_ip=" + ips);
			System.out.println("exclude_user=" + excludes);
			if (!StringUtils.isEmpty(ips)) {
				//校验用户在不在排除列表
				if (!StringUtils.isEmpty(excludes)) {
					if (excludes.contains(uname)) {
						//如果在排除列表或IP被接受，允许访问
						return true;
					}
				}
				//校验realIp是否在IP列表
				if (ips.contains(realIp)) {
					return true;
				}
			} else {
				// ip列表为空，允许所有访问
				return true;
			}

		} catch (FileNotFoundException e) {
			e.printStackTrace();
			// 没有配置文件，默认不限制
			return true;
		} catch (IOException e) {
			e.printStackTrace();
		}

		return false;
	}
	
	/**
	 * 获取客户端真实IP
	 * @return
	 */
	public String getRealIp() {
		// 获取真实IP
		String ip = request.getHeader("X-Forwarded-For");
		System.out.println("X-Forwarded-For ip:" + ip);
		System.out.println("X-Real-IP ip:" + request.getHeader("X-Real-IP"));
		System.out.println("remoteAddr ip:" + request.getRemoteAddr());
		if (!StringUtils.isEmpty(ip) && !"unKnown".equalsIgnoreCase(ip)) {
			// 多次反向代理后会有多个ip值，第一个ip才是真实ip
			int index = ip.indexOf(",");
			if (index != -1) {
				return ip.substring(0, index);
			} else {
				return ip;
			}
		}
		ip = request.getHeader("X-Real-IP");
		if (!StringUtils.isEmpty(ip) && !"unKnown".equalsIgnoreCase(ip)) {
			return ip;
		}
		ip = request.getRemoteAddr();
		return ip;

	}
	
	public void setUserService(UserService userService) {
		this.userService = userService;
	}

	public String getReturnURL() {
		return this.returnURL;
	}

	public void setReturnURL(String returnURL) {
		this.returnURL = returnURL;
	}

	public String getOldPassword() {
		return this.oldPassword;
	}

	public void setOldPassword(String oldPassword) {
		this.oldPassword = oldPassword;
	}

	public String getNewPassword() {
		return this.newPassword;
	}

	public void setNewPassword(String newPassword) {
		this.newPassword = newPassword;
	}

	public String getRepeatedNewPassword() {
		return this.repeatedNewPassword;
	}

	public void setRepeatedNewPassword(String repeatedNewPassword) {
		this.repeatedNewPassword = repeatedNewPassword;
	}

	public User getUser() {
		return this.user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public String getAccount() {
		return this.account;
	}

	public void setAccount(String account) {
		this.account = account;
	}

	public int getPage() {
		return this.page;
	}

	public void setPage(int page) {
		this.page = page;
	}

	public String getSidx() {
		return this.sidx;
	}

	public void setSidx(String sidx) {
		this.sidx = sidx;
	}

	public String getSord() {
		return this.sord;
	}

	public void setSord(String sord) {
		this.sord = sord;
	}

	public int getRows() {
		return this.rows;
	}

	public void setRows(int rows) {
		this.rows = rows;
	}

	public boolean is_search() {
		return this._search;
	}

	public void set_search(boolean _search) {
		this._search = _search;
	}

	public String getSearchString() {
		return this.searchString;
	}

	public void setSearchString(String searchString) {
		this.searchString = searchString;
	}

	public String getSearchOper() {
		return this.searchOper;
	}

	public void setSearchOper(String searchOper) {
		this.searchOper = searchOper;
	}

	public Long getTid() {
		return this.tid;
	}

	public void setTid(Long tid) {
		this.tid = tid;
	}

	public void setYewuService(YewuService yewuService) {
		this.yewuService = yewuService;
	}

	public String getUsernameAuto() {
		return this.usernameAuto;
	}

	public void setUsernameAuto(String usernameAuto) {
		this.usernameAuto = usernameAuto;
	}
}
