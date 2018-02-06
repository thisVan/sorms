/**     
 * @Title: contractService.java   
 * @Package com.nfledmedia.sorm.service   
 * @Description: TODO(用一句话描述该文件做什么)   
 * @author wufc@nfledmedia.com     
 * @date 2016年11月14日 上午11:37:59   
 * @version V1.0   
 * @Copyright 2016 Guangdong Southern NewVision Media Technology Co., Ltd. All rights reserved.  
 */
package com.nfledmedia.sorm.service;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import org.springframework.transaction.annotation.Transactional;

import com.nfledmedia.sorm.dao.AdcontractDAO;
import com.nfledmedia.sorm.dao.AttributeDAO;
import com.nfledmedia.sorm.dao.ClienttypeDAO;
import com.nfledmedia.sorm.dao.IndustryDAO;
import com.nfledmedia.sorm.dao.LedDAO;
import com.nfledmedia.sorm.dao.OrderDAO;
import com.nfledmedia.sorm.dao.PublishdetailDAO;
import com.nfledmedia.sorm.dao.UserDAO;
import com.nfledmedia.sorm.entity.Adcontract;
import com.nfledmedia.sorm.entity.Order;
import com.nfledmedia.sorm.entity.Publishdetail;
import com.nfledmedia.sorm.entity.User;

/**
 * @ClassName: contractService
 * @Description: TODO(保存adcontract)
 * @author PC-FAN
 * @date 2016年11月14日 上午11:37:59
 * 
 */
@Transactional
public class AdcontractService {

	// 注入DAO
	private UserDAO userDAO;
	private LedDAO ledDAO;
	private AdcontractDAO adcontractDAO;
	private IndustryDAO industryDAO;
	private AttributeDAO attributeDAO;
	private ClienttypeDAO clienttypeDAO;
	private OrderDAO orderDAO;
	private PublishdetailDAO publishdetailDAO;

	public boolean saveAdcontract(Adcontract adc, List<Order> orderList) {

		Adcontract adcPojo = adcontractDAO.merge(adc);
		for (Order order : orderList) {
			order.setAdcontract(adcPojo);
			Order ord = orderDAO.merge(order);
			List lst = packagePublishList(adcPojo, ord);
			for (int i = 0; i < lst.size(); i++) {
				System.out.println(lst.get(i));
				publishdetailDAO.save((Publishdetail) lst.get(i));
			}

		}

		return true;

	}

	/**
	 * 修改订单
	 * 
	 * @param adc
	 * @param orderList
	 * @return
	 */
	public boolean updateOrder(Adcontract adc, List<Order> orderList) {

		Adcontract adcPojo = adcontractDAO.merge(adc);
		for (Order order : orderList) {
			order.setAdcontract(adcPojo);
			Order ord = orderDAO.merge(order);
			// 删除publishdetail
			deletePublishdetail(ord.getId());

			List lst = packagePublishList(adcPojo, ord);
			for (int i = 0; i < lst.size(); i++) {
				System.out.println(lst.get(i));
				publishdetailDAO.save((Publishdetail) lst.get(i));
			}

		}

		return true;

	}

	/**
	 * 根据orderid删除publishdetail
	 * 
	 * @param orderid
	 */
	public void deletePublishdetail(Integer orderid) {
		List<Publishdetail> publishdetailList = publishdetailDAO.findByOrderid(orderid);
		for (Publishdetail pbsd : publishdetailList) {
			publishdetailDAO.delete(pbsd);
		}
	}

	/**
	 * 删除订单
	 * 
	 * @param adc
	 * @param orderList
	 * @return
	 */
	public boolean deleteOrder(Order order) {

		deletePublishdetail(order.getId());
		orderDAO.delete(order);

		return true;

	}

	public List<Publishdetail> packagePublishList(Adcontract adc, Order ord) {
		List<Publishdetail> pbsList = new ArrayList<Publishdetail>();
		String client = getAdcontractCient(adc);

		// 遍历所有日期
		Date dateInx = ord.getStartdate();
		while (dateInx.compareTo(ord.getEnddate()) <= 0) {
			Publishdetail pbsDetail = new Publishdetail();
			pbsDetail.setAdcontent(ord.getContent());
			pbsDetail.setClient(client);
			pbsDetail.setCtypename(adc.getClienttype().getCtypedesc());
			pbsDetail.setIndname(ord.getIndustry().getIndustryname());
			pbsDetail.setLedname(ord.getLed().getName());
			pbsDetail.setAttributename(ord.getAttribute().getAttributename());
			pbsDetail.setDuration(ord.getDuration());
			pbsDetail.setFrequency(ord.getFrequency());
			pbsDetail.setAddfreq(ord.getAddfreq());
			pbsDetail.setOrderid(ord.getId());
			pbsDetail.setStarttime(ord.getStarttime());
			pbsDetail.setEndtime(ord.getEndtime());

			Calendar cal = Calendar.getInstance();
			cal.setTime(dateInx);
			long datelong = dateInx.getTime();
			pbsDetail.setDate(new Date(datelong));
			pbsList.add(pbsDetail);
			cal.add(Calendar.DATE, 1);
			dateInx = cal.getTime();
		}

		return pbsList;

	}

	public String getAdcontractCient(Adcontract adc) {
		if (adc != null) {
			if (null != adc.getAgency() && !"".equals(adc.getAgency())) {
				return adc.getAgency();
			}

			return adc.getClient();
		}

		return null;

	}

	public UserDAO getUserDAO() {
		return userDAO;
	}

	public void setUserDAO(UserDAO userDAO) {
		this.userDAO = userDAO;
	}

	public LedDAO getLedDAO() {
		return ledDAO;
	}

	public void setLedDAO(LedDAO ledDAO) {
		this.ledDAO = ledDAO;
	}

	public AdcontractDAO getAdcontractDAO() {
		return adcontractDAO;
	}

	public void setAdcontractDAO(AdcontractDAO adcontractDAO) {
		this.adcontractDAO = adcontractDAO;
	}

	public IndustryDAO getIndustryDAO() {
		return industryDAO;
	}

	public void setIndustryDAO(IndustryDAO industryDAO) {
		this.industryDAO = industryDAO;
	}

	public AttributeDAO getAttributeDAO() {
		return attributeDAO;
	}

	public void setAttributeDAO(AttributeDAO attributeDAO) {
		this.attributeDAO = attributeDAO;
	}

	public ClienttypeDAO getClienttypeDAO() {
		return clienttypeDAO;
	}

	public void setClienttypeDAO(ClienttypeDAO clienttypeDAO) {
		this.clienttypeDAO = clienttypeDAO;
	}

	public OrderDAO getOrderDAO() {
		return orderDAO;
	}

	public void setOrderDAO(OrderDAO orderDAO) {
		this.orderDAO = orderDAO;
	}

	public PublishdetailDAO getPublishdetailDAO() {
		return publishdetailDAO;
	}

	public void setPublishdetailDAO(PublishdetailDAO publishdetailDAO) {
		this.publishdetailDAO = publishdetailDAO;
	}

	public Adcontract getAdcontractById(Integer contractid) {
		// TODO Auto-generated method stub
		return adcontractDAO.findById(contractid);
	}

	public Order getOrderById(Integer orderid) {
		return orderDAO.findById(orderid);
	}

	public User getUserById(Integer userid) {
		return userDAO.findById(userid);
	}

}
