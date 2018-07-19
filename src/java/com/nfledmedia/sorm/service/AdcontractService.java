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

import static org.hamcrest.CoreMatchers.nullValue;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.nfledmedia.sorm.cons.ProjectAttributeConstant;
import com.nfledmedia.sorm.cons.TypeCollections;
import com.nfledmedia.sorm.dao.AdcontractDAO;
import com.nfledmedia.sorm.dao.AdcontractHistoryDAO;
import com.nfledmedia.sorm.dao.AttributeDAO;
import com.nfledmedia.sorm.dao.ClienttypeDAO;
import com.nfledmedia.sorm.dao.IndustryDAO;
import com.nfledmedia.sorm.dao.LedDAO;
import com.nfledmedia.sorm.dao.OperatetypeDAO;
import com.nfledmedia.sorm.dao.OpereventDAO;
import com.nfledmedia.sorm.dao.OrderDAO;
import com.nfledmedia.sorm.dao.OrderHistoryDAO;
import com.nfledmedia.sorm.dao.PublishdetailDAO;
import com.nfledmedia.sorm.dao.UserDAO;
import com.nfledmedia.sorm.entity.Adcontract;
import com.nfledmedia.sorm.entity.AdcontractHistory;
import com.nfledmedia.sorm.entity.Led;
import com.nfledmedia.sorm.entity.Operatetype;
import com.nfledmedia.sorm.entity.Operevent;
import com.nfledmedia.sorm.entity.Order;
import com.nfledmedia.sorm.entity.OrderHistory;
import com.nfledmedia.sorm.entity.Publishdetail;
import com.nfledmedia.sorm.entity.User;
import com.nfledmedia.sorm.util.ClassesConvertTool;
import com.nfledmedia.sorm.util.MD5Util;
import com.nfledmedia.sorm.util.OrderCharacteristicValue;

/**
 * @ClassName: contractService
 * @Description: TODO(保存adcontract)
 * @author PC-FAN
 * @date 2016年11月14日 上午11:37:59
 * 
 */
@Transactional
@Service
public class AdcontractService {
	// 注入DAO
	@Autowired
	private UserDAO userDAO;
	@Autowired
	private LedDAO ledDAO;
	@Autowired
	private AdcontractDAO adcontractDAO;
	@Autowired
	private IndustryDAO industryDAO;
	@Autowired
	private AttributeDAO attributeDAO;
	@Autowired
	private ClienttypeDAO clienttypeDAO;
	@Autowired
	private OrderDAO orderDAO;
	@Autowired
	private PublishdetailDAO publishdetailDAO;
	@Autowired
	private AdcontractHistoryDAO adcontractHistoryDAO;
	@Autowired
	private OrderHistoryDAO orderHistoryDAO;
	@Autowired
	private OpereventDAO opereventDAO;
	@Autowired
	private OperatetypeDAO operatetypeDAO;
	
	/**
	 * 完成前端客户autocomplete功能
	 * @param keyword
	 * @return
	 */
	public List getClientsLikeKeyword(String keyword){
			
		return adcontractDAO.findLikeKeyword(AdcontractDAO.CLIENT, keyword);
		
	}
	
	/**
	 * 完成前端代理autocomplete功能
	 * @param keyword
	 * @return
	 */
	public List getAgencysLikeKeyword(String keyword){
			
		return adcontractDAO.findLikeKeyword(AdcontractDAO.AGENCY, keyword);
		
	}

	public boolean saveAdcontract(Adcontract adc, List<Order> orderList) {
		//实际为save方法
		Adcontract adcPojo = adcontractDAO.merge(adc);
		for (Order order : orderList) {
			order.setAdcontract(adcPojo);
			//实际为save方法
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
	 * 改刊的业务流程</br>
	 * 1.保存orderhistory，删除order;</br>
	 * 2.删除publishdetail写入新的order;</br>
	 * 3.写入新的publishdetail</br>
	 * 4.判断是否需要修改adcontract;</br>
	 * 5.保存adcontracthiostory，删除adcontract（如果需要）</br>
	 * 6.写入operevent事件
	 */
	public String alterAdvertisingService(String tid, Order newOrder, String operater, String[] noIgnoreProperties){
		String recallInfo = "";
//		//不能忽略led		
//		String[] newNoIgnoreProp = new String[noIgnoreProperties.length + 1];
//		System.arraycopy(noIgnoreProperties, 0, newNoIgnoreProp, 0, noIgnoreProperties.length);
//		newNoIgnoreProp[noIgnoreProperties.length] = "led";
//		noIgnoreProperties = newNoIgnoreProp;
		Order order = orderDAO.findById(Integer.valueOf(tid));
		Adcontract adcontract = order.getAdcontract();
		String[] ignoreProperties = new String[] { "id","content", "led", "duration", "frequency", "startdate", "enddate", "starttime", "endtime", "playstrategy" };
		System.out.println(noIgnoreProperties.length);
		if (noIgnoreProperties.length > 1) {
			ignoreProperties = noIgnoreProperties;
//			for (String string : noIgnoreProperties) {
//				for (String str : ignoreProperties) {
//					if(str.equals(string)){
//						List<String> list = Arrays.asList(ignoreProperties);
//						list = new ArrayList<String>(list);
//						list.remove(str);
//						Object[] objs = list.toArray();
//						String[] strs = new String[objs.length];
//						for (int i = 0; i < strs.length; i++) {
//							strs[i] = objs[i].toString();
//							}
//						ignoreProperties = strs;
//					}
//				}
//			}
		}
		
		BeanUtils.copyProperties(order, newOrder, ignoreProperties);
		
		//1.保存orderhistory，删除order，写入新的order
		OrderHistory orderHistory = new OrderHistory();
		orderHistory = (OrderHistory) new ClassesConvertTool().makeObject1ToObject2(order, orderHistory);
		orderHistory.setModifier(operater);
		orderHistory.setOperater(operater);
		orderHistory.setOperatetime(new Timestamp(System.currentTimeMillis()));
		Operatetype operatetype = operatetypeDAO.findById(TypeCollections.ADVERTISE_ALTER);
		//orderHistory.setOperatetype(new Operatetype(TypeCollections.ADVERTISE_ALTER));
		orderHistory.setOperatetype(operatetype);			
		orderHistoryDAO.save(orderHistory);
				
		//2.删除publishdetail
		List<Publishdetail> publishdetailList = publishdetailDAO.findByOrderid(order.getId());
		for (Publishdetail publishdetail : publishdetailList) {
			publishdetailDAO.delete(publishdetail);
		}
		//如果operevent表中有数据，删除
		List<Operevent> opereventList = (List<Operevent>) opereventDAO.findByOrderId(order.getId());
		if (opereventList.size() > 0) {
			for (Operevent ope : opereventList) {
				opereventDAO.delete(ope);
			}
		}
		//删除order
		orderDAO.delete(order);
		//保存新的order
		
		Order newOrderTransent = new Order();
		BeanUtils.copyProperties(newOrder, newOrderTransent);
		newOrder = newOrderTransent;
		newOrder.setAdcontract(adcontract);
		newOrder.setModifier(operater);
		newOrder.setModtime(new Timestamp(System.currentTimeMillis()));
		newOrder.setOperatetime(new Timestamp(System.currentTimeMillis()));
		newOrder.setMd5encrypt(OrderCharacteristicValue.calcCharacter(newOrder));
		Led led = ledDAO.findById(newOrder.getLed().getId());
		newOrder.setLed(led);
		System.out.println(newOrder.hashCode() + " " + newOrder.getFrequency());
		orderDAO.save(newOrder);
		

		
		//写入operevent
		Operevent operevent = new Operevent();
		operevent.setOrderId(newOrder.getId());
		operevent.setOriginorder(order.getId());
		operevent.setOperater(operater);
		operevent.setTime(new Timestamp(System.currentTimeMillis()));
		operevent.setOperatetype(new Operatetype(TypeCollections.ADVERTISE_ALTER));
		
		
		opereventDAO.save(operevent);
		
		//3.写入新的publishidetail			
		List<Publishdetail> list = packagePublishList(adcontract, newOrder);
		for (Publishdetail publishdetail : list) {
			publishdetailDAO.save(publishdetail);
		}
		//4.判断是否需要修改adcontract
		adcontract = adcontractDAO.findById(adcontract.getId());
		if (adcontract.getOrders().size() > 1) {
//			for (Object object : adcontract.getOrders()) {
//				System.out.println(((Order) object).getId());
//			}
//			adcontract.setLastModifytime(new Timestamp(System.currentTimeMillis()));
//			adcontractDAO.merge(adcontract);
		}else {//需要保存adcontracthistory		
			//5.保存adcontacthistory
			AdcontractHistory adh = new AdcontractHistory();
			BeanUtils.copyProperties(adcontract, adh);
			adh.setOperater(operater);
			adh.setOperatetype(new Operatetype(TypeCollections.ADVERTISE_ALTER));
			adh.setModifiedtime(new Timestamp(System.currentTimeMillis()));
			adcontractHistoryDAO.save(adh);
			
			//删除adcontract
			adcontractDAO.delete(adcontract);					
		}
		recallInfo = "操作成功！";
		return recallInfo;
	}
	
	/**
	 * 停刊的业务流程</br>
	 * 1.保存orderhistory;</br>
	 * 2.删除publishdetail;</br>
	 * 3.删除order，另外修改order，重新设置单据起始时间，生成publishdetail;</br>
	 * 4.判断是否需要修改adcontract;</br>
	 * 5.写入operevent事件
	 */
	public String stopAdvertisingService(String tid, String operater, String remark, Date stopAdDate) {
		String recallInfo = "";
		Order order = orderDAO.findById(Integer.valueOf(tid));
		Order originalOrder = new Order();
		BeanUtils.copyProperties(order, originalOrder);
		Adcontract adcontract = order.getAdcontract();

		// 1.保存orderhistory，删除order
		OrderHistory orderHistory = new OrderHistory();
		orderHistory = (OrderHistory) new ClassesConvertTool().makeObject1ToObject2(order, orderHistory);
		orderHistory.setModifier(operater);
		orderHistory.setOperater(operater);
		orderHistory.setOperatetime(new Timestamp(System.currentTimeMillis()));
		Operatetype operatetype = operatetypeDAO.findById(TypeCollections.ADVERTISE_STOP);
		//orderHistory.setOperatetype(new Operatetype(TypeCollections.ADVERTISE_STOP));
		orderHistory.setOperatetype(operatetype);
		orderHistoryDAO.save(orderHistory);

		// 2.删除publishdetail
		List<Publishdetail> publishdetailList = publishdetailDAO.findByOrderid(order.getId());
		for (Publishdetail publishdetail : publishdetailList) {
			publishdetailDAO.delete(publishdetail);
		}

		// 3.删除order
		orderDAO.delete(order);

		// 修改结束日期
		Order newOrderTransent = new Order();
		BeanUtils.copyProperties(order, newOrderTransent);
		order = newOrderTransent;
		order.setEnddate(stopAdDate);
		order.setId(null);
		order.setModifier(operater);
		order.setModtime(new Timestamp(System.currentTimeMillis()));
		order.setOperatetime(new Timestamp(System.currentTimeMillis()));
		order.setMd5encrypt(OrderCharacteristicValue.calcCharacter(order));
		orderDAO.save(order);

		// 生成publishdetail
		List lst = packagePublishList(adcontract, order);
		for (int i = 0; i < lst.size(); i++) {
			System.out.println(lst.get(i));
			publishdetailDAO.save((Publishdetail) lst.get(i));
		}

		// 6.写入operevent事件
		Operevent operevent = new Operevent();
		operevent.setOrderId(order.getId());
		operevent.setOriginorder(originalOrder.getId());
		operevent.setOperater(operater);
		operevent.setTime(new Timestamp(System.currentTimeMillis()));
		operevent.setOperatetype(new Operatetype(TypeCollections.ADVERTISE_STOP));
		operevent.setRemark(remark);

		opereventDAO.save(operevent);
		
		adcontract.setLastModifytime(new Timestamp(System.currentTimeMillis()) );
		adcontractDAO.merge(adcontract);

		recallInfo = "操作成功！";
		return recallInfo;
	}

	/**
	 * 撤刊的业务流程(同停刊)</br>
	 * 1.保存orderhistory，删除order;</br>
	 * 2.删除publishdetail写入新的order;</br>
	 * 3.写入新的publishdetail</br>
	 * 4.判断是否需要修改adcontract;</br>
	 * 5.写入operevent事件
	 */
	public String revokeAdvertisingService(String tid, String operater, Date revokeAdDate, String remark){
		String recallInfo = "";
		Order order = orderDAO.findById(Integer.valueOf(tid));
		Order originalOrder = new Order();
		BeanUtils.copyProperties(order, originalOrder);
		Adcontract adcontract = order.getAdcontract();
		
		//1.保存orderhistory，删除order
		OrderHistory orderHistory = new OrderHistory();
		orderHistory = (OrderHistory) new ClassesConvertTool().makeObject1ToObject2(order, orderHistory);
		orderHistory.setModifier(operater);
		orderHistory.setOperater(operater);
		orderHistory.setOperatetime(new Timestamp(System.currentTimeMillis()));
		Operatetype operatetype = operatetypeDAO.findById(TypeCollections.ADVERTISE_REVOKE);
		//orderHistory.setOperatetype(new Operatetype(TypeCollections.ADVERTISE_REVOKE));
		orderHistory.setOperatetype(operatetype);			
		orderHistoryDAO.save(orderHistory);
				
		//2.删除publishdetail
		List<Publishdetail> publishdetailList = publishdetailDAO.findByOrderid(order.getId());
		for (Publishdetail publishdetail : publishdetailList) {
			publishdetailDAO.delete(publishdetail);
		}
		
		// 3.删除order
		orderDAO.delete(order);

		// 修改结束日期
		Order newOrderTransent = new Order();
		BeanUtils.copyProperties(order, newOrderTransent);
		order = newOrderTransent;
		order.setEnddate(revokeAdDate);
		order.setId(null);
		order.setModifier(operater);
		order.setModtime(new Timestamp(System.currentTimeMillis()));
		order.setOperatetime(new Timestamp(System.currentTimeMillis()));
		order.setMd5encrypt(OrderCharacteristicValue.calcCharacter(order));
		orderDAO.save(order);

		// 生成publishdetail
		List lst = packagePublishList(adcontract, order);
		for (int i = 0; i < lst.size(); i++) {
			System.out.println(lst.get(i));
			publishdetailDAO.save((Publishdetail) lst.get(i));
		}

		// 6.写入operevent事件
		Operevent operevent = new Operevent();
		operevent.setOrderId(order.getId());
		operevent.setOriginorder(originalOrder.getId());
		operevent.setOperater(operater);
		operevent.setTime(new Timestamp(System.currentTimeMillis()));
		operevent.setOperatetype(new Operatetype(TypeCollections.ADVERTISE_STOP));
		operevent.setRemark(remark);

		opereventDAO.save(operevent);
		
		adcontract.setLastModifytime(new Timestamp(System.currentTimeMillis()) );
		adcontractDAO.merge(adcontract);

		recallInfo = "操作成功！";
		return recallInfo;
	}
	
	/**
	 * 修改订单
	 * 
	 * @param adc
	 * @param orderList
	 * @return
	 */
	public boolean updateOrder(Adcontract adc, List<Order> orderList, boolean adcontractIsModified) {

		Adcontract adcPojo = adcontractDAO.merge(adc);
		//若adcontract关键属性修改，查询所有order，级联所有publishdetail一并修改
		if (adcontractIsModified) {
			List<Order> list = orderDAO.findByProperty("adcontract", adc);
			System.out.println();
			for (Order order : list) {
				// 删除publishdetail
				deletePublishdetail(order.getId());
				List lst = packagePublishList(adcPojo, order);
				for (int i = 0; i < lst.size(); i++) {
					System.out.println(lst.get(i));
					publishdetailDAO.save((Publishdetail) lst.get(i));
				}
			}
		}
		
		for (Order order : orderList) {
			order.setAdcontract(adcPojo);
			order.setMd5encrypt(OrderCharacteristicValue.calcCharacter(order));
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
	 * @param
	 * @param orderList
	 * @return
	 */
	public boolean deleteOrder(Order order, User user) {
		//order = orderDAO.findById(order.getId());		
		//Adcontract adcontract = adcontractDAO.findById(order.getAdcontract().getId());
		Adcontract adcontract = order.getAdcontract();
		OrderHistory oh = new OrderHistory();
		BeanUtils.copyProperties(order, oh);
		
		oh.setOperater(user.getRealname());
		oh.setOperatetime(new Timestamp(System.currentTimeMillis()));
		Operatetype operatetype = operatetypeDAO.findById(ProjectAttributeConstant.ADVERTISE_ORDER_DELETE);
		oh.setOperatetype(operatetype);
//		oh.setOperatetype(new Operatetype(ProjectAttributeConstant.ADVERTISE_ORDER_DELETE));	
		orderHistoryDAO.save(oh);
				
		//2.删除publishdetail
		deletePublishdetail(order.getId());
				
		//3.判断是否需要修改adcontract	
		if (adcontract.getOrders().size() > 1) {					
		}else {//需要保存adcontracthistory		
			//保存adcontacthistory
			AdcontractHistory adh = new AdcontractHistory();
			System.out.println(adcontract.getOrders().size());
			BeanUtils.copyProperties(adcontract, adh);
			adh.setOperater(user.getRealname());
			adh.setOperatetype(new Operatetype(ProjectAttributeConstant.ADVERTISE_ORDER_DELETE));
			adh.setModifiedtime(new Timestamp(System.currentTimeMillis()));
			adcontractHistoryDAO.save(adh);
			
			//删除adcontract
			adcontractDAO.delete(adcontract);					
		}
		
		//4.删除order
		orderDAO.delete(order);
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

	public List getOrdersByAdcontractId(int adcontractid) {
		// TODO Auto-generated method stub
		List lst = orderDAO.findByProperty("adcontract.id", adcontractid);
		return lst;
		
	}

	public Adcontract getAdcontractByOrderId(Integer orderid) {
		// TODO Auto-generated method stub
		Order o = orderDAO.findById(orderid);
		return o.getAdcontract();
	}
	
	/**
	 * order重复性校验，通过比对order字段，判断是否重复
	 * @param attrValue
	 * @return
	 */
	public boolean repeatabilityCheckOfOrder(String attrValue){
		List list = orderDAO.findByProperty("md5encrypt", attrValue);	
		if (list.size() > 1) {
			//可视为重复
			return true;
		} else {
			return false;
		}
		
	}

}
