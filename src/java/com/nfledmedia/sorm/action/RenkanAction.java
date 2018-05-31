package com.nfledmedia.sorm.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Time;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletResponse;
import javax.transaction.Transactional;

import org.apache.struts2.ServletActionContext;
import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import com.nfledmedia.sorm.cons.CommonConstant;
import com.nfledmedia.sorm.cons.TypeCollections;
import com.nfledmedia.sorm.entity.Adcontract;
import com.nfledmedia.sorm.entity.Attribute;
import com.nfledmedia.sorm.entity.Channel;
import com.nfledmedia.sorm.entity.Clienttype;
import com.nfledmedia.sorm.entity.Industry;
import com.nfledmedia.sorm.entity.Led;
import com.nfledmedia.sorm.entity.Order;
import com.nfledmedia.sorm.entity.Playstrategy;
import com.nfledmedia.sorm.entity.User;
import com.nfledmedia.sorm.service.AdcontractService;
import com.nfledmedia.sorm.service.BaseService;
import com.nfledmedia.sorm.service.RenkanshuService;
import com.nfledmedia.sorm.service.YewuService;
import com.opensymphony.xwork2.ActionContext;

/**
 * 项目名称：sorm 类全名:com.nfledmedia.sorm.action.RenkanshuAction
 * 类描述：认刊书的action类，对提交的认刊书进行存储
 * 
 * @version jdk1.7 Copyright (c) 2016, bolven@qq.com All Rights Reserved.
 */
@Controller
public class RenkanAction extends SuperAction {

	private static final long serialVersionUID = 1L;

	// 注入service
	@Autowired
	private YewuService yewuService;
	@Autowired
	private AdcontractService adcontractService;
	@Autowired
	private RenkanshuService renkanshuService;
	@Autowired
	private BaseService baseService;

	private int page;
	private String sidx;
	private String sord;
	private int rows;

	private boolean _search;
	private String searchField;
	private String searchString;
	private String searchOper;
	private String queryString;

	private Adcontract adcontract;
	private Order order;

	private String clienttype_id;
	private String channel_id;
	private String adcontractdate;

	private Industry industry;
	private Led led;
	private Channel channel;
	private Attribute attribute;
	private Clienttype clienttype;

	public Adcontract getAdcontract() {
		return adcontract;
	}

	public void setAdcontract(Adcontract adcontract) {
		this.adcontract = adcontract;
	}

	public Order getOrder() {
		return order;
	}

	public void setOrder(Order order) {
		this.order = order;
	}

	public Channel getChannel() {
		return channel;
	}

	public void setChannel(Channel channel) {
		this.channel = channel;
	}

	public Attribute getAttribute() {
		return attribute;
	}

	public void setAttribute(Attribute attribute) {
		this.attribute = attribute;
	}

	public Clienttype getClienttype() {
		return clienttype;
	}

	public void setClienttype(Clienttype clienttype) {
		this.clienttype = clienttype;
	}

	public String getClienttype_id() {
		return clienttype_id;
	}

	public void setClienttype_id(String clienttype_id) {
		this.clienttype_id = clienttype_id;
	}

	public String getChannel_id() {
		return channel_id;
	}

	public void setChannel_id(String channel_id) {
		this.channel_id = channel_id;
	}

	public String getAdcontractdate() {
		return getAdcontractdate();
	}

	public void setAdcontractdate(String adcontractdate) {
		this.adcontractdate = adcontractdate;
	}

	// 无法接受的数据使用string接收
	private String kanlizongjia;
	private Integer renkanshuauditId;
	private String purchasecost;

	private String auditIds;
	private boolean auditResult;
	private String auditReason;
	private String deleteRenkanshu_Reason;
	private String deleteRenkanshu_id;

	// 获取表单数组数据
	private String[] fabuneirongledtable;
	private String[] shanghuadianweiledtable;
	private String[] hangyeleixingledtable;
	private String[] guanggaoleixingledtable;
	private String[] startdateledtable;
	private String[] enddateledtable;
	private String[] starttimeledtable;
	private String[] endtimeledtable;
	private String[] pinciledtable;
	private String[] shichangledtable;
	private String[] playstrategytable;

	private String renkanbianhao;
	private String renkanshuauditid;

	// 接收查询条件
	public String getQueryString() {
		return queryString;
	}

	public void setQueryString(String queryString) {
		this.queryString = queryString;
	}

	// updateReason:认刊书修改中的参数
	private String updateReason;
	private String tid;

	// 多对多关系保存

	List<Led> ledList = new ArrayList<Led>();

	/**
	 * @return the ledList
	 */
	public List<Led> getLedList() {
		return ledList;
	}

	/**
	 * @param ledList
	 *            the ledList to set
	 */
	public void setLedList(List<Led> ledList) {
		this.ledList = ledList;
	}

	/**
	 * @return the page
	 */
	public int getPage() {
		return page;
	}

	/**
	 * @return the sidx
	 */
	public String getSidx() {
		return sidx;
	}

	/**
	 * @return the sord
	 */
	public String getSord() {
		return sord;
	}

	/**
	 * @return the rows
	 */
	public int getRows() {
		return rows;
	}

	/**
	 * @return the _search
	 */
	public boolean is_search() {
		return _search;
	}

	/**
	 * @return the searchField
	 */
	public String getSearchField() {
		return searchField;
	}

	/**
	 * @return the searchString
	 */
	public String getSearchString() {
		return searchString;
	}

	/**
	 * @return the searchOper
	 */
	public String getSearchOper() {
		return searchOper;
	}

	/**
	 * @return the yewuService
	 */
	public YewuService getYewuService() {
		return yewuService;
	}

	/**
	 * @return the renkanshuauditId
	 */
	public Integer getRenkanshuauditId() {
		return renkanshuauditId;
	}

	/**
	 * @return the purchasecost
	 */
	public String getPurchasecost() {
		return purchasecost;
	}

	/**
	 * @return the auditIds
	 */
	public String getAuditIds() {
		return auditIds;
	}

	/**
	 * @return the auditResult
	 */
	public boolean isAuditResult() {
		return auditResult;
	}

	/**
	 * @return the auditReason
	 */
	public String getAuditReason() {
		return auditReason;
	}

	/**
	 * @return the deleteRenkanshu_Reason
	 */
	public String getDeleteRenkanshu_Reason() {
		return deleteRenkanshu_Reason;
	}

	/**
	 * @return the deleteRenkanshu_id
	 */
	public String getDeleteRenkanshu_id() {
		return deleteRenkanshu_id;
	}

	/**
	 * @return the updateReason
	 */
	public String getUpdateReason() {
		return updateReason;
	}

	/**
	 * @return the tid
	 */
	public String getTid() {
		return tid;
	}

	private String audit_id;

	/**
	 * @return the audit_id
	 */
	public String getAudit_id() {
		return audit_id;
	}

	/**
	 * @param audit_id
	 *            the audit_id to set
	 */
	public void setAudit_id(String audit_id) {
		this.audit_id = audit_id;
	}

	public String saverenkan() throws JSONException, IOException {
		String tip;
		if ("success".equals(trySave())) {
			tip = "您填写的信息已经提交成功！";

		} else {
			tip = "提交失败，请联系管理员处理！";
		}
		JSONObject jsonObject = new JSONObject();
		jsonObject.put("state", 0);
		jsonObject.put("info", tip);
		sentMsg(jsonObject.toString());
		return null;

	}

	/**
	 * 
	 * TODO 持久化前台提交的认刊书 <br>
	 * 
	 * @author PC-FAN
	 * @return boolean
	 */
	public String trySave() {
		try {
			// 公共工具类
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			Clienttype clt = new Clienttype();
			clt.setId(Short.valueOf(clienttype_id));
			adcontract.setClienttype(clt);
			Channel cha = new Channel();
			cha.setId(Integer.parseInt(channel_id));
			adcontract.setChannel(cha);

			adcontract.setCreatetime(new Timestamp(System.currentTimeMillis()));
			adcontract.setState(TypeCollections.ADCONTRACT_ACTIVE_STATE);

			System.out.println(adcontract.toString());
			List<Order> ordList = new ArrayList<Order>();

			for (int i = 0; i < enddateledtable.length; i++) {
				Order ord = new Order();
				ord.setContent(fabuneirongledtable[i]);
				Led l = new Led();
				l.setId(Integer.parseInt(shanghuadianweiledtable[i]));
				ord.setLed(l);
				Industry ind = new Industry();
				ind.setIndustryid(Short.parseShort(hangyeleixingledtable[i]));
				ord.setIndustry(ind);
				Attribute att = new Attribute();
				att.setId(Short.parseShort(guanggaoleixingledtable[i]));
				ord.setAttribute(att);
				Playstrategy pstrategy = new Playstrategy();
				pstrategy.setId(Short.parseShort(playstrategytable[i]));
				ord.setPlaystrategy(pstrategy);
				ord.setOrdersn(adcontract.getSn());
				ord.setFrequency(Short.parseShort(pinciledtable[i]));
				ord.setDuration(Short.parseShort(shichangledtable[i]));
				ord.setStartdate(sdf.parse(startdateledtable[i]));
				ord.setEnddate(sdf.parse(enddateledtable[i]));
				
				// 前台time时间格式转换
				if (starttimeledtable[i].length() == 5) {
					ord.setStarttime(Time.valueOf(starttimeledtable[i] + ":00"));
				} else {
					ord.setStarttime(Time.valueOf(starttimeledtable[i]));
				}
				if (endtimeledtable[i].length() == 5) {
					ord.setEndtime(Time.valueOf(endtimeledtable[i] + ":00"));
				} else {
					ord.setEndtime(Time.valueOf(endtimeledtable[i]));
				}

				ord.setState(TypeCollections.ORDER_STATE_ACTIVE);
				System.out.println(ord.toString());
				ordList.add(ord);
			}

			adcontractService.saveAdcontract(adcontract, ordList);
		} catch (Exception e) {
			e.printStackTrace();
			return "failure";
		}
		return "success";
	}

	// public void deleteRenkanshu() throws Exception {
	// System.out.println("---------进入RenkanshuAction，调用deleteRenkanshu---------");
	// Map session = ActionContext.getContext().getSession();
	// Integer yewuyuanId = (Integer) (session).get(CommonConstant.SESSION_ID);
	// renkanshuService.deleteRenkanshu(deleteRenkanshu_id,
	// deleteRenkanshu_Reason, yewuyuanId);
	//
	// JSONObject jsonObject = new JSONObject();
	// jsonObject.put("state", 0);
	// jsonObject.put("info", "操作成功，请等待审核！");
	// sentMsg(jsonObject.toString());
	// System.out.println(jsonObject.toString());
	// }

	@Transactional
	public String updateOrder() throws JSONException, IOException {
		ActionContext ctx = ActionContext.getContext();
		User user = adcontractService.getUserById((Integer) ctx.getSession().get(CommonConstant.SESSION_ID));
		String tip = "";
		adcontract.setChannel(baseService.getChannelById(channel.getId()));
		adcontract.setClienttype(baseService.getClienttypeById(clienttype.getId()));

		order.setAdcontract(adcontract);
		order.setIndustry(baseService.getIndustryByIndustryid(industry.getIndustryid()));
		order.setAttribute(baseService.getAttributeById(attribute.getId()));
		order.setLed(baseService.getLedById(led.getId()));

		Adcontract adcontp = adcontractService.getAdcontractById(adcontract.getId());
		Adcontract adcSource = new Adcontract();
		adcSource = adcontp;
		Order ordp = adcontractService.getOrderById(order.getId());
		// 复制前台修改的属性，同时忽略部分前台未封装的属性
		BeanUtils.copyProperties(adcontract, adcontp, new String[] { "sn", "date", "createtime", "state", "lastModifytime" });
		BeanUtils.copyProperties(order, ordp, new String[] { "ordersn", "addfreq", "modifier", "modtime", "state" });
		// 设置修改人以及修改时间
		ordp.setModifier(user.getRealname());
		ordp.setModtime(new Timestamp(System.currentTimeMillis()));
		boolean adcontractIsModified = adcontp.keyPropertiesModified(adcSource);
		
		System.out.println(adcontract);
		System.out.println(order);
		List<Order> orderList = new ArrayList<Order>();
		orderList.add(ordp);

		if (adcontractService.updateOrder(adcontp, orderList, adcontractIsModified)) {
			tip = "您填写的信息已经提交成功！";

		} else {
			tip = "提交失败，请联系管理员处理！";
		}
		JSONObject jsonObject = new JSONObject();
		jsonObject.put("state", 0);
		jsonObject.put("info", tip);
		sentMsg(jsonObject.toString());
		return null;

	}

	public String deletethisOrder() throws JSONException, IOException {
		String tip = "";
		Order ordp = adcontractService.getOrderById(order.getId());

		if (adcontractService.deleteOrder(ordp)) {
			tip = "删除成功！";

		} else {
			tip = "提交失败，请联系管理员处理！";
		}
		JSONObject jsonObject = new JSONObject();
		jsonObject.put("state", 0);
		jsonObject.put("info", tip);
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

	public Industry getIndustry() {
		return industry;
	}

	public void setIndustry(Industry industry) {
		this.industry = industry;
	}

	public Led getLed() {
		return led;
	}

	public void setLed(Led led) {
		this.led = led;
	}

	public String[] getShanghuadianweiledtable() {
		return shanghuadianweiledtable;
	}

	public void setShanghuadianweiledtable(String[] shanghuadianweiledtable) {
		this.shanghuadianweiledtable = shanghuadianweiledtable;
	}

	public String[] getGuanggaoleixingledtable() {
		return guanggaoleixingledtable;
	}

	public void setGuanggaoleixingledtable(String[] guanggaoleixingledtable) {
		this.guanggaoleixingledtable = guanggaoleixingledtable;
	}

	public String[] getStarttimeledtable() {
		return starttimeledtable;
	}

	public void setStarttimeledtable(String[] starttimeledtable) {
		this.starttimeledtable = starttimeledtable;
	}

	public String[] getEndtimeledtable() {
		return endtimeledtable;
	}

	public void setEndtimeledtable(String[] endtimeledtable) {
		this.endtimeledtable = endtimeledtable;
	}

	public String[] getPinciledtable() {
		return pinciledtable;
	}

	public void setPinciledtable(String[] pinciledtable) {
		this.pinciledtable = pinciledtable;
	}

	public String[] getShichangledtable() {
		return shichangledtable;
	}

	public void setShichangledtable(String[] shichangledtable) {
		this.shichangledtable = shichangledtable;
	}

	public String[] getPlaystrategytable() {
		return playstrategytable;
	}

	public void setPlaystrategytable(String[] playstrategytable) {
		this.playstrategytable = playstrategytable;
	}

	public String[] getFabuneirongledtable() {
		return fabuneirongledtable;
	}

	public void setFabuneirongledtable(String[] fabuneirongledtable) {
		this.fabuneirongledtable = fabuneirongledtable;
	}

	public String[] getHangyeleixingledtable() {
		return hangyeleixingledtable;
	}

	public void setHangyeleixingledtable(String[] hangyeleixingledtable) {
		this.hangyeleixingledtable = hangyeleixingledtable;
	}

	public String[] getStartdateledtable() {
		return startdateledtable;
	}

	public void setStartdateledtable(String[] startdateledtable) {
		this.startdateledtable = startdateledtable;
	}

	public String[] getEnddateledtable() {
		return enddateledtable;
	}

	public void setEnddateledtable(String[] enddateledtable) {
		this.enddateledtable = enddateledtable;
	}

	public void setRenkanshuService(RenkanshuService renkanshuService) {
		this.renkanshuService = renkanshuService;
	}

	public void setYewuService(YewuService yewuService) {
		this.yewuService = yewuService;
	}
	
	public void setAdcontractService(AdcontractService adcontractService) {
		this.adcontractService = adcontractService;
	}

	public void setBaseService(BaseService baseService) {
		this.baseService = baseService;
	}

	public String getKanlizongjia() {
		return kanlizongjia;
	}

	public void setKanlizongjia(String kanlizongjia) {
		this.kanlizongjia = kanlizongjia;
	}

	public void setUpdateReason(String updateReason) {
		this.updateReason = updateReason;
	}

	public void setTid(String tid) {
		this.tid = tid;
	}

	public void setPage(int page) {
		this.page = page;
	}

	public void setSidx(String sidx) {
		this.sidx = sidx;
	}

	public void setSord(String sord) {
		this.sord = sord;
	}

	public void setRows(int rows) {
		this.rows = rows;
	}

	public void set_search(boolean _search) {
		this._search = _search;
	}

	public void setSearchField(String searchField) {
		this.searchField = searchField;
	}

	public void setSearchString(String searchString) {
		this.searchString = searchString;
	}

	public void setSearchOper(String searchOper) {
		this.searchOper = searchOper;
	}

	public void setRenkanshuauditId(Integer renkanshuauditId) {
		this.renkanshuauditId = renkanshuauditId;
	}

	public void setAuditIds(String auditIds) {
		this.auditIds = auditIds;
	}

	public void setAuditResult(boolean auditResult) {
		this.auditResult = auditResult;
	}

	public void setAuditReason(String auditReason) {
		this.auditReason = auditReason;
	}

	public void setDeleteRenkanshu_Reason(String deleteRenkanshu_Reason) {
		this.deleteRenkanshu_Reason = deleteRenkanshu_Reason;
	}

	public void setDeleteRenkanshu_id(String deleteRenkanshu_id) {
		this.deleteRenkanshu_id = deleteRenkanshu_id;
	}

	public void setPurchasecost(String purchasecost) {
		this.purchasecost = purchasecost;
	}

	public String getRenkanbianhao() {
		return renkanbianhao;
	}

	public void setRenkanbianhao(String renkanbianhao) {
		this.renkanbianhao = renkanbianhao;
	}

	public String getRenkanshuauditid() {
		return renkanshuauditid;
	}

	public void setRenkanshuauditid(String renkanshuauditid) {
		this.renkanshuauditid = renkanshuauditid;
	}

	// /**
	// * 修改日期：2017-3-26
	// * 返回未通过审核的认刊书列表
	// * @author free_ion
	// * @return String
	// * @throws Exception
	// */
	// public String getUnapprovedRenkanshu() throws Exception {
	// Page result = null;
	// Map session = ActionContext.getContext().getSession();
	// Integer uid = (Integer) session.get(CommonConstant.SESSION_ID);
	// SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	// result = renkanshuService.getUnappovedRenkanshu(sidx, sord, page, rows,
	// Integer.toString(uid));
	// JSONObject jsonObject = PageToJson.toJsonWithoutData(result);
	// JSONArray jsonArray = new JSONArray();
	// List<Renkanshuaudit> data = result.getResult();
	// for (int i = 0, size = data.size(); i < size; i++) {
	// Renkanshuaudit ra = (Renkanshuaudit) data.get(i);
	// JSONObject jsonObject1 = new JSONObject();
	// JSONArray jsonArray2 = new JSONArray(); // 求取cell
	//
	// jsonArray2.put(ra.getRenkanbianhao());
	// jsonArray2.put(ra.getGuangaokanhu());
	// jsonArray2.put(ra.getGuanggaodailigongsi());
	// jsonArray2.put(sdf.format(ra.getQiandingriqi()));
	// String operType = ra.getOperType();
	// if("A".equals(operType)) {
	// jsonArray2.put("添加");
	// } else if ("D".equals(operType)) {
	// jsonArray2.put("删除");
	// } else if("L".equals(operType)) {
	// jsonArray2.put("修改");
	// }
	// jsonObject1.put("cell", jsonArray2); // 加入cell
	// jsonArray.put(jsonObject1);
	// }
	// jsonObject.put("rows", jsonArray); // 加入rows
	// System.out.println("jsonObject:" + jsonObject.toString());
	// sentMsg(jsonObject.toString());
	// return null;
	// }

	// /**
	// * 修改日期：2017-3-26
	// * 返回已通过审核的认刊书列表
	// * @author free_ion
	// * @return String
	// * @throws Exception
	// */
	// public String getApprovedRenkanshu() throws Exception {
	// Page result = null;
	// Map session = ActionContext.getContext().getSession();
	// Integer uid = (Integer) session.get(CommonConstant.SESSION_ID);
	// SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	// result = renkanshuService.getApprovedRenkanshu(sidx, sord, page, rows,
	// Integer.toString(uid));
	// JSONObject jsonObject = PageToJson.toJsonWithoutData(result);
	// JSONArray jsonArray = new JSONArray();
	// List<Renkanshuaudit> data = result.getResult();
	// for (int i = 0, size = data.size(); i < size; i++) {
	// Renkanshuaudit ra = (Renkanshuaudit) data.get(i);
	// JSONObject jsonObject1 = new JSONObject();
	// JSONArray jsonArray2 = new JSONArray(); // 求取cell
	// jsonObject1.put("id", ra.getId()); // 认刊书审核ID
	//
	// jsonArray2.put(ra.getRenkanbianhao());
	// jsonArray2.put(ra.getGuangaokanhu());
	// jsonArray2.put(ra.getGuanggaodailigongsi());
	// jsonArray2.put(sdf.format(ra.getQiandingriqi()));
	// String operType = ra.getOperType();
	// if("A".equals(operType)) {
	// jsonArray2.put("添加");
	// } else if ("D".equals(operType)) {
	// jsonArray2.put("删除");
	// } else if("L".equals(operType)) {
	// jsonArray2.put("修改");
	// }
	// jsonObject1.put("cell", jsonArray2); // 加入cell
	// jsonArray.put(jsonObject1);
	// }
	// jsonObject.put("rows", jsonArray); // 加入rows
	// System.out.println("jsonObject:" + jsonObject.toString());
	// sentMsg(jsonObject.toString());
	// return null;
	// }

}
