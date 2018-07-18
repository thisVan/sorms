package com.nfledmedia.sorm.action;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import com.nfledmedia.sorm.entity.User;
import com.nfledmedia.sorm.service.BaseService;
import com.nfledmedia.sorm.service.LedService;
import com.nfledmedia.sorm.service.ResourceService;
import com.nfledmedia.sorm.service.RoleService;
import com.nfledmedia.sorm.service.UserService;
import com.nfledmedia.sorm.service.YewuService;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ModelDriven;

@Controller
public class DirectionAction extends SuperAction implements ModelDriven<User> {

	private static final long serialVersionUID = 1L;

	@Autowired
	private RoleService roleService;
	@Autowired
	private YewuService yewuService;
	@Autowired
	private LedService ledService;
	@Autowired
	private BaseService baseService;
	@Autowired
	private UserService userService;
	@Autowired
	private ResourceService resourceService;

	private Integer ywyId;

	public Integer getYwyId() {
		return ywyId;
	}

	public void setYwyId(Integer ywyId) {
		this.ywyId = ywyId;
	}

	public String pingmustatistic() throws Exception {
		return SUCCESS;
	}

	public String pingmuguanli() throws Exception {
		return SUCCESS;
	}

	public String index() throws Exception {
		return SUCCESS;
	}

	public String renkantypein() throws Exception {
		ActionContext ctx = ActionContext.getContext();
		ctx.put("ledList", baseService.ledList());
		ctx.put("industryList", baseService.industryList());
		ctx.put("attributeList", baseService.attributeList());
		ctx.put("clienttypeList", baseService.clienttypeList());
		ctx.put("channelList", baseService.channelList());
		ctx.put("strategyList", baseService.strategyList());
		System.out.println(baseService.strategyList());
		ctx.put("publishstyleList", baseService.publishstyleList());
		System.out.println(ctx.get("ledList"));
		System.out.println(baseService.ledList().size());
		System.out.println(baseService.industryList().size());
		return SUCCESS;
	}

	public String screenOccupancyRate() throws Exception {
		ActionContext ctx = ActionContext.getContext();
		ctx.put("ledList", baseService.ledList());
		return SUCCESS;
	}

	public String renkanshuManage() throws Exception {
		ActionContext ctx = ActionContext.getContext();
		// ctx.put("clients", baseService.clientsList());
		ctx.put("ledList", baseService.ledList());
		return SUCCESS;
	}

	public String avgScreenOccupancyRate() throws Exception {
		return SUCCESS;
	}

	public String yejistatistic() throws Exception {
		return SUCCESS;
	}

	public String advice() throws Exception {
		return SUCCESS;
	}

	public String pingmustatistic_fenpingtongji() throws Exception {
		return SUCCESS;
	}

	public String setting() throws Exception {
		return SUCCESS;
	}

	public String addpingmu() throws Exception {
		return SUCCESS;
	}

	public String ledsavesuccess() throws Exception {
		return SUCCESS;
	}

	public String message() throws Exception {
		return SUCCESS;
	}

	public String login() throws Exception {
		return SUCCESS;
	}

	public String yewuaudit() throws Exception {
		return SUCCESS;
	}

	public String hangyestatistic() throws Exception {
		return SUCCESS;
	}

	public String ledResource() throws Exception {
		return SUCCESS;
	}

	public String myAuditOrderListPage() throws Exception {
		return SUCCESS;
	}

	public String renkanshuListAuditPage() throws Exception {
		return SUCCESS;
	}

	public String contractAuditListPage() throws Exception {

		return SUCCESS;
	}

	public String myAuditContractListPage() {
		return SUCCESS;
	}

	public String accountReceivedStatisticsPage() {
		return SUCCESS;
	}

	public String amountDigestedStatisticsPage() {
		return SUCCESS;
	}

	public String avgOccupancyRateByScreen() {
		return SUCCESS;
	}

	@Override
	public User getModel() {
		// TODO Auto-generated method stub
		return null;
	}

}
