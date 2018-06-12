package com.nfledmedia.sorm.service;

import java.sql.Timestamp;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.nfledmedia.sorm.dao.AdcontractDAO;
import com.nfledmedia.sorm.dao.AdcontractHistoryDAO;
import com.nfledmedia.sorm.dao.IndustryDAO;
import com.nfledmedia.sorm.dao.MessageDAO;
import com.nfledmedia.sorm.dao.OrderDAO;
import com.nfledmedia.sorm.dao.OrderHistoryDAO;
import com.nfledmedia.sorm.dao.PublishdetailDAO;
import com.nfledmedia.sorm.dao.UserDAO;
import com.nfledmedia.sorm.entity.Industry;
import com.nfledmedia.sorm.entity.Operatetype;
import com.nfledmedia.sorm.entity.Order;
import com.nfledmedia.sorm.entity.OrderHistory;
import com.nfledmedia.sorm.entity.Publishdetail;
import com.nfledmedia.sorm.util.ClassesConvertTool;
import com.nfledmedia.sorm.util.Page;

/**
 * 项目名称：sorm 类全名:com.nfledmedia.sorm.service.RenkanshuService 类描述：
 * 创建人：Van@nfledmedia 创建时间：2016年6月12日 上午10:40:29 修改备注：
 * 
 * @version jdk1.7
 * 
 * Copyright (c) 2016, bolven@qq.com All Rights Reserved.
 */

@Service
@Transactional
public class RenkanshuService {
	// 注入DAO
	@Autowired
	private IndustryDAO industryDAO;
	@Autowired
	private UserDAO userDAO;
	@Autowired
	private MessageDAO messageDAO;
	@Autowired
	private OrderDAO orderDAO;
	@Autowired
	private PublishdetailDAO publishdetailDAO;
	@Autowired
	private AdcontractDAO adcontractDAO;

	
	/**
	 * 完成前端广告内容autocomplete功能
	 * @param keyword
	 * @return
	 */
	public List getContentsLikeKeyword(String keyword){
			
		return orderDAO.findLikeKeyword(OrderDAO.CONTENT, keyword);
		
	}
	
	public String saveIndustry(String industryname){
		String tip = "";
		List indList = industryDAO.findAll();
		
		Industry industry = new Industry();		
		industry.setIndustryname(industryname);
		industry.setIndustryid((short) (indList.size() + 1));
		
		try {
			industryDAO.save(industry);
			tip = "执行成功！";
		} catch (Exception e) {
			// TODO Auto-generated catch block
			tip = "添加失败！";
			//重新抛出异常，触发事务
			throw new RuntimeException();
		}
		
		return tip;

	}
	
	public Page getRenkanshuManageList(String sidx, String sord, int pageNo, int pageSize) {
		System.out.println("???????????yewuService:getYewuList:sidx:" + sidx);
		System.out.println(pageSize);
		return orderDAO.getRenkanshuManageList(sidx, sord, pageNo, pageSize);
	}

	public Page getRenkanshuManageListByKeyword(String keyword, String sidx, String sord, int pageNo, int pageSize) {
		System.out.println("???????????yewuService:getRenkanshuManageListByKeyword:sidx:" + sidx);
		return orderDAO.getRenkanshuManageListByKeyword(keyword, sidx, sord, pageNo, pageSize);
	}
	
	/**
	 * 根据条件返回publishdetail列表，
	 * 注意：此处的最后一个参数
	 * @param startdate
	 * @param enddate
	 * @param ledname
	 * @return
	 */
	public List<Object[]> publishResourceList(String startdate,String enddate, String ledname) {
		return publishdetailDAO.getResourceListAll(startdate, enddate, ledname);
		
	}
	
	public List<Publishdetail> publishInTimerangeList(String startdate,String enddate) {
		return publishdetailDAO.getPublishdetailFromDaterange(startdate, enddate);
		
	}
	
	/**
	 * 根据选择时间和led导出广告内容表
	 * @param startdate
	 * @param enddate
	 * @param ledname
	 * @return
	 */
	public List<Publishdetail> publishInTimerangeListAndLedname(String startdate, String enddate, String ledname) {
		return publishdetailDAO.getPublishdetailFromDaterangeAndLedname(startdate, enddate, ledname);
		
	}
	
	/**
	 * 查询给定日期的orderlist
	 * @param checkDate
	 * @param ledId
	 * @return List<Order>
	 */
	public List<?> getOrderOnDateByLed(String checkDate, Integer ledId) {
		java.sql.Date checkSQLDate = java.sql.Date.valueOf(checkDate);
		return orderDAO.findOrdersOnDateByLed(checkSQLDate, ledId);
		
	}

	/**
	 * 返回Order
	 * @param orderId
	 * @return
	 */
	public Order getOrderById(Integer orderId) {
		return orderDAO.findById(orderId);
	}
	
	/**
	 * 获取某段时间的Order
	 * @param dateStart
	 * @param dateEnd
	 * @return List
	 */
	public List getOrderInDuration(Date dateStart, Date dateEnd) {
		return orderDAO.findOrdersInDuration(dateStart, dateEnd);
	}
	
//	// tid即要修改的认刊书的认刊编号
//	public void update(Integer userID, Renkanshu renkanshu, String updateReason, String tid, String[] fenqiid,
//			String[] fenqimingcheng, String[] fenqijine, String[] fenqifukuanshijian, String[] fukuanfangshi,
//			String[] fukuanbeizhu) throws ParseException {
//		System.out.println("………………进入renkanshuService.update………………");
//		boolean updateRenkanshuflag = false;
//		int fenqiUpdate = 0;
//		if (fenqimingcheng != null) {
//			fenqiUpdate = fenqimingcheng.length;
//		}
//		User operUser = null;
//		Renkanshu renkanshuPrev = null;
//		try {
//			operUser = yewuyuanDAO.findById(userID);
//			System.out.println("operUser:" + operUser);
//			renkanshuPrev = renkanshuDAO.findById(tid);
//			System.out.println("renkanshuPrev:" + renkanshuPrev);
//			System.out.println("renkanshu:" + renkanshu);
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
//
//		System.out.println("renkanshu.getIndustry().getIndustryId():" + renkanshu.getIndustry().getIndustryid());
//		Industry industryPrev = industryDAO.findById(renkanshu.getIndustry().getIndustryid());
//		User yewuyuanPrev = yewuyuanDAO.findById(renkanshuPrev.getYwyId());
//		System.out.println("yewuyuanPrev:" + yewuyuanPrev);
//		User yewuyuan = yewuyuanDAO.findById(renkanshu.getYwyId());
//		System.out.println("yewuyuan:" + yewuyuan);
//		// format的格式可以任意
//		Date datenow = new Date();
//		DateFormat sdf2TS = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
//		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
//		String dateStr = sdf2TS.format(datenow);
//		Timestamp timeStamp = new Timestamp(System.currentTimeMillis());
//		String tsStr = dateStr;
//		timeStamp = Timestamp.valueOf(tsStr);
//		String remarkContent = "" + timeStamp + " " + operUser.getRealname() + " 修改认刊书———认刊书编号：" + tid + "<br> 将";
//		if (!renkanshu.getHetongbianhao().equals(renkanshuPrev.getHetongbianhao())) {
//			remarkContent += "合同编号：" + sdf.format(renkanshuPrev.getHetongbianhao()) + " 修改为 "
//					+ sdf.format(renkanshu.getHetongbianhao()) + "; ";
//			updateRenkanshuflag = true;
//		}
//		if (!renkanshu.getQiandingriqi().equals(renkanshuPrev.getQiandingriqi())) {
//			remarkContent += "签订日期：" + sdf.format(renkanshuPrev.getQiandingriqi()) + " 修改为 "
//					+ sdf.format(renkanshu.getQiandingriqi()) + "; ";
//			updateRenkanshuflag = true;
//		}
//		if (!renkanshu.getYwyId().equals(renkanshuPrev.getYwyId())) {
//			remarkContent += "业务员：" + yewuyuanPrev.getRealname() + " 修改为 " + yewuyuan.getRealname() + "; ";
//			updateRenkanshuflag = true;
//		}
//		if (!renkanshu.getGuangaokanhu().equals(renkanshuPrev.getGuangaokanhu())) {
//			remarkContent += "广告客户：" + renkanshuPrev.getGuangaokanhu() + " 修改为 " + renkanshu.getGuangaokanhu() + "; ";
//			updateRenkanshuflag = true;
//		}
//		if (!renkanshu.getGuanggaodailigongsi().equals(renkanshuPrev.getGuanggaodailigongsi())) {
//			remarkContent += "广告代理公司：" + renkanshuPrev.getGuanggaodailigongsi() + " 修改为 "
//					+ renkanshu.getGuanggaodailigongsi() + "; ";
//			updateRenkanshuflag = true;
//		}
//		System.out.println("行业：" + renkanshuPrev.getIndustry().getIndustryname() + " 修改为 "
//				+ industryPrev.getIndustryname() + "; ");
//		System.out.println("行业：" + renkanshu.getIndustry().getIndustryid() + " 修改为 " + industryPrev.getIndustryid()
//				+ "; ");
//		if (!renkanshu.getIndustry().getIndustryid().equals(renkanshuPrev.getIndustry().getIndustryid())) {
//			remarkContent += "行业：" + renkanshuPrev.getIndustry().getIndustryname() + " 修改为 "
//					+ industryPrev.getIndustryname() + "; ";
//			updateRenkanshuflag = true;
//		}
//		if (!renkanshu.getGuanggaoneirong().equals(renkanshuPrev.getGuanggaoneirong())) {
//			remarkContent += "广告内容：" + renkanshuPrev.getGuanggaoneirong() + " 修改为 " + renkanshu.getGuanggaoneirong()
//					+ "; ";
//			updateRenkanshuflag = true;
//		}
//		if (!renkanshu.getGaojianlaiyuan().equals(renkanshuPrev.getGaojianlaiyuan())) {
//			remarkContent += "稿件来源：" + renkanshuPrev.getGaojianlaiyuan() + " 修改为 " + renkanshu.getGaojianlaiyuan()
//					+ "; ";
//			updateRenkanshuflag = true;
//		}
//		if (!renkanshu.getGaojianleibie().equals(renkanshuPrev.getGaojianleibie())) {
//			remarkContent += "稿件类别：" + renkanshuPrev.getGaojianleibie() + " 修改为 " + renkanshu.getGaojianleibie() + "; ";
//			updateRenkanshuflag = true;
//		}
//		if (!renkanshu.getKanlizongjia().equals(renkanshuPrev.getKanlizongjia())) {
//			remarkContent += "刊例总价：" + renkanshuPrev.getKanlizongjia() + " 修改为 " + renkanshu.getKanlizongjia() + "; ";
//			updateRenkanshuflag = true;
//		}
//		if (renkanshu.getPurchasecost() != null
//				&& (!renkanshu.getPurchasecost().equals(renkanshuPrev.getPurchasecost()))) {
//			remarkContent += "外购成本：" + renkanshuPrev.getPurchasecost() + " 修改为 " + renkanshu.getPurchasecost() + "; ";
//			updateRenkanshuflag = true;
//		}
//		System.out.println("折扣：" + remarkContent);
//		if (!renkanshu.getZhekou().equals(renkanshuPrev.getZhekou())) {
//			remarkContent += "折扣：" + renkanshuPrev.getZhekou() + " 修改为 " + renkanshu.getZhekou() + "; ";
//			updateRenkanshuflag = true;
//		}
//
//		System.out.println("认刊书备注：" + remarkContent);
//		if (!renkanshu.getRenkanshubeizhu().equals(renkanshuPrev.getRenkanshubeizhu())) {
//			remarkContent += "认刊书备注：" + renkanshuPrev.getRenkanshubeizhu() + " 修改为 " + renkanshu.getRenkanshubeizhu()
//					+ "; ";
//			updateRenkanshuflag = true;
//		}
//
//	}

//	public void deleteRenkanshu(String deleteRenkanshu_id, String deleteRenkanshu_Reason, Integer yewuyuanId) {
//		System.out.println("---------进入RenkanshuService，调用deleteRenkanshu---------");
//		Renkanshuaudit renkanshuaudit = new Renkanshuaudit();
//		Renkanshu renkanshu = renkanshuDAO.findById(deleteRenkanshu_id);
//		User yewuyuan = yewuyuanDAO.findById(renkanshu.getYwyId());
//		User operYwy = yewuyuanDAO.findById(yewuyuanId);
//		renkanshuaudit.setRenkanbianhao(deleteRenkanshu_id);
//		renkanshuaudit.setGuangaokanhu(renkanshu.getGuangaokanhu());
//		renkanshuaudit.setQiandingriqi(renkanshu.getQiandingriqi());
//		renkanshuaudit.setYwyId(renkanshu.getYwyId());
//		renkanshuaudit.setGuanggaodailigongsi(renkanshu.getGuanggaodailigongsi());
//		renkanshuaudit.setIndustry(renkanshu.getIndustry());
//		renkanshuaudit.setGuanggaoneirong(renkanshu.getGuanggaoneirong());
//		renkanshuaudit.setGaojianlaiyuan(renkanshu.getGaojianlaiyuan());
//		renkanshuaudit.setGaojianleibie(renkanshu.getGaojianleibie());
//		renkanshuaudit.setKanlizongjia(renkanshu.getKanlizongjia());
//		renkanshuaudit.setPurchasecost(renkanshu.getPurchasecost());
//		renkanshuaudit.setZhekou(renkanshu.getZhekou());
//		renkanshuaudit.setRenkanshubeizhu(renkanshu.getRenkanshubeizhu());
//		// renkanshuaudit.setState("D");
//		renkanshuaudit.setOperType("D");
//		renkanshuaudit.setOperReason(deleteRenkanshu_Reason);
//		renkanshuaudit.setOperState("A");// 未审核
//		renkanshuaudit.setOperTimestamp(new Date());
//		renkanshuauditDAO.save(renkanshuaudit);
//
//		List<Fukuan> fukuans = fukuanDAO.findByRenkanbianhao(renkanshu.getRenkanbianhao());
//		// 保存分期付款修改
//		List<Fukuanaudit> fukuanauditList = new ArrayList<Fukuanaudit>();
//		for (int i = 0; i < fukuans.size(); i++) {
//			try {
//				Fukuanaudit fukuanaudit = new Fukuanaudit();
//				Fukuan fukuanTemp = (Fukuan) fukuans.get(i);
//				fukuanaudit.setOrderpay(fukuanTemp.getOrderpay());
//				fukuanaudit.setRenkanshuauditid(renkanshuaudit.getId());
//				fukuanaudit.setMingcheng(fukuanTemp.getMingcheng());
//				fukuanaudit.setJine(fukuanTemp.getJine());
//				fukuanaudit.setFukuanshijian(fukuanTemp.getFukuanshijian());
//				fukuanaudit.setFukuanfangshi(fukuanTemp.getFukuanfangshi());
//				fukuanaudit.setFukuanbeizhu(fukuanTemp.getFukuanbeizhu());
//				fukuanaudit.setRenkanbianhao(fukuanTemp.getRenkanbianhao());
//				fukuanaudit.setKanhu(fukuanTemp.getRenkanbianhao());
//				fukuanaudit.setYwyId(fukuanTemp.getYwyId());
//				fukuanaudit.setState("D");
//				fukuanaudit.setFukuanTimestamp(fukuanTemp.getFukuanTimestamp());
//
//				fukuanauditList.add(fukuanaudit);
//				System.out.println(fukuanaudit.toString());
//			} catch (Exception e) {
//				e.printStackTrace();
//			}
//		}
//
//		saveFukuanaudit4Renkanshu(fukuanauditList);
//
//		Date datenow = new Date();
//		DateFormat sdf2TS = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
//		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
//		String dateStr = sdf2TS.format(datenow);
//		Timestamp timeStamp = new Timestamp(System.currentTimeMillis());
//		String tsStr = dateStr;
//		timeStamp = Timestamp.valueOf(tsStr);
//		String remarkContent = "" + timeStamp + " " + operYwy.getRealname() + " 删除认刊书———认刊书编号：" + deleteRenkanshu_id
//				+ "<br>删除理由：" + deleteRenkanshu_Reason;
//		Renkanshuremark renkanshuremark = new Renkanshuremark();
//		renkanshuremark.setOperTime(timeStamp);
//		renkanshuremark.setOperYwyName(operYwy.getRealname());
//		renkanshuremark.setRenkanshu(renkanshu);
//		renkanshuremark.setOperContent(remarkContent);
//		renkanshuremark.setRenkanshuauditId(renkanshuaudit.getId());
//		renkanshuremark.setState("A");
//		renkanshuremarkDAO.save(renkanshuremark);
//	}


	public List<Order> getOrderByLed(Integer id) {
		// TODO Auto-generated method stub
		return orderDAO.findByProperty("led.id", id);
	}

}