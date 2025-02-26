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

import java.sql.Timestamp;
import java.text.ParseException;
import java.util.ArrayList;
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
import com.nfledmedia.sorm.dao.AlterrecordDAO;
import com.nfledmedia.sorm.dao.AttributeDAO;
import com.nfledmedia.sorm.dao.ClienttypeDAO;
import com.nfledmedia.sorm.dao.IndustryDAO;
import com.nfledmedia.sorm.dao.LedDAO;
import com.nfledmedia.sorm.dao.OperatetypeDAO;
import com.nfledmedia.sorm.dao.OpereventDAO;
import com.nfledmedia.sorm.dao.OrderDAO;
import com.nfledmedia.sorm.dao.OrderHistoryDAO;
import com.nfledmedia.sorm.dao.PlaystrategyDAO;
import com.nfledmedia.sorm.dao.PublishdetailDAO;
import com.nfledmedia.sorm.dao.UserDAO;
import com.nfledmedia.sorm.entity.Adcontract;
import com.nfledmedia.sorm.entity.AdcontractHistory;
import com.nfledmedia.sorm.entity.Alterrecord;
import com.nfledmedia.sorm.entity.Led;
import com.nfledmedia.sorm.entity.Operatetype;
import com.nfledmedia.sorm.entity.Operevent;
import com.nfledmedia.sorm.entity.Order;
import com.nfledmedia.sorm.entity.OrderHistory;
import com.nfledmedia.sorm.entity.Playstrategy;
import com.nfledmedia.sorm.entity.Publishdetail;
import com.nfledmedia.sorm.entity.User;
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
	@Autowired
	private PlaystrategyDAO playstrategyDAO;
	@Autowired
	private AlterrecordDAO alterrecordDAO;

	/**
	 * 完成前端客户autocomplete功能
	 * 
	 * @param keyword
	 * @return
	 */
	public List<Adcontract> getClientsLikeKeyword(String keyword) {

		return adcontractDAO.findLikeKeyword(AdcontractDAO.CLIENT, keyword);

	}

	/**
	 * 完成前端代理autocomplete功能
	 * 
	 * @param keyword
	 * @return
	 */
	public List<Adcontract> getAgencysLikeKeyword(String keyword) {

		return adcontractDAO.findLikeKeyword(AdcontractDAO.AGENCY, keyword);

	}

	public boolean saveAdcontract(Adcontract adc, List<Order> orderList) {
		// 实际为save方法
		Adcontract adcPojo = adcontractDAO.merge(adc);
		for (Order order : orderList) {
			order.setAdcontract(adcPojo);
			// 实际为save方法
			Order ord = orderDAO.merge(order);
			List lst = packagePublishList(adcPojo, ord);
			for (int i = 0; i < lst.size(); i++) {
				System.out.println(lst.get(i));
				publishdetailDAO.save((Publishdetail) lst.get(i));
			}
		}
		return true;
	}

	/*	*//**
			 * 改刊的业务流程</br>
			 * 1.保存orderhistory，删除order;</br>
			 * 2.删除publishdetail写入新的order;</br>
			 * 3.写入新的publishdetail</br>
			 * 4.判断是否需要修改adcontract;</br>
			 * 5.保存adcontracthiostory，删除adcontract（如果需要）</br>
			 * 6.写入operevent事件
			 * 
			 * 是否需要改order 选择方案，不更改order
			 *//*
				 * public String alterAdvertisingService(String tid, Order
				 * newOrder, String operater, String[] noIgnoreProperties) {
				 * String recallInfo = ""; Order order =
				 * orderDAO.findById(Integer.valueOf(tid)); Adcontract
				 * adcontract = order.getAdcontract(); ArrayList<String>
				 * ignorePropertiesList = new
				 * ArrayList<String>(Arrays.asList("id", "content", "led",
				 * "duration", "frequency", "startdate", "enddate", "starttime",
				 * "endtime", "playstrategy")); //如果是批量操作，页面form中至少会传入1个值，led if
				 * (noIgnoreProperties.length > 0 &&
				 * !"".equals(noIgnoreProperties[0])) { List<String>
				 * noIgnoreList = new
				 * ArrayList<String>(Arrays.asList(noIgnoreProperties));
				 * ignorePropertiesList = new
				 * ArrayList<String>(Arrays.asList("id"));
				 * ignorePropertiesList.addAll(noIgnoreList); }
				 * 
				 * new ClassesConvertTool().copyProperties(order, newOrder,
				 * ignorePropertiesList);
				 * 
				 * // 1.保存orderhistory，删除order，写入新的order OrderHistory
				 * orderHistory = new OrderHistory(); orderHistory =
				 * (OrderHistory) new
				 * ClassesConvertTool().makeObject1ToObject2(order,
				 * orderHistory); orderHistory.setModifier(operater);
				 * orderHistory.setOperater(operater);
				 * orderHistory.setOperatetime(new
				 * Timestamp(System.currentTimeMillis())); Operatetype
				 * operatetype =
				 * operatetypeDAO.findById(TypeCollections.ADVERTISE_ALTER);
				 * orderHistory.setOperatetype(operatetype);
				 * orderHistoryDAO.save(orderHistory);
				 * 
				 * // 2.删除publishdetail List<Publishdetail> publishdetailList =
				 * publishdetailDAO.findByOrderid(order.getId()); for
				 * (Publishdetail publishdetail : publishdetailList) {
				 * publishdetailDAO.delete(publishdetail); }
				 * 
				 * //11.9不删除order // 删除order // orderDAO.delete(order); //
				 * 保存新的order
				 * 
				 * Order newOrderTransent = new Order();
				 * BeanUtils.copyProperties(newOrder, newOrderTransent);
				 * newOrder = newOrderTransent;
				 * newOrder.setAdcontract(adcontract);
				 * newOrder.setModifier(operater); newOrder.setModtime(new
				 * Timestamp(System.currentTimeMillis()));
				 * newOrder.setOperatetime(new
				 * Timestamp(System.currentTimeMillis()));
				 * newOrder.setMd5encrypt(OrderCharacteristicValue.calcCharacter
				 * (newOrder)); Led led =
				 * ledDAO.findById(newOrder.getLed().getId());
				 * newOrder.setLed(led); System.out.println(newOrder.hashCode()
				 * + " " + newOrder.getFrequency()); orderDAO.save(newOrder);
				 * 
				 * // 写入operevent Operevent operevent = new Operevent();
				 * operevent.setOrderId(newOrder.getId());
				 * operevent.setOriginorder(order.getId());
				 * operevent.setOperater(operater); operevent.setTime(new
				 * Timestamp(System.currentTimeMillis()));
				 * operevent.setOperatetype(new
				 * Operatetype(TypeCollections.ADVERTISE_ALTER));
				 * 
				 * opereventDAO.save(operevent);
				 * 
				 * // 3.写入新的publishidetail List<Publishdetail> list =
				 * packagePublishList(adcontract, newOrder); for (Publishdetail
				 * publishdetail : list) { publishdetailDAO.save(publishdetail);
				 * }
				 * 
				 * //写入alterrecord Alterrecord altr =
				 * createAlterrecord(newOrder, operater);
				 * 
				 * // 4.判断是否需要修改adcontract adcontract =
				 * adcontractDAO.findById(adcontract.getId()); if
				 * (adcontract.getOrders().size() > 1) {
				 * 
				 * } else {// 需要保存adcontracthistory // 5.保存adcontacthistory
				 * AdcontractHistory adh = new AdcontractHistory();
				 * BeanUtils.copyProperties(adcontract, adh);
				 * adh.setOperater(operater); adh.setOperatetype(new
				 * Operatetype(TypeCollections.ADVERTISE_ALTER));
				 * adh.setModifiedtime(new
				 * Timestamp(System.currentTimeMillis()));
				 * adcontractHistoryDAO.save(adh);
				 * 
				 * // 删除adcontract adcontractDAO.delete(adcontract); }
				 * recallInfo = "操作成功！"; return recallInfo; }
				 */

	/**
	 * 改刊的业务流程</br>
	 * 1.删除publishdetail;</br>
	 * 2.写入新的publishdetail;</br>
	 * 3.写入alterrecord</br>
	 * 4.判断是否需要修改adcontract;</br>
	 * 5.保存adcontracthiostory，删除adcontract（如果需要）</br>
	 * @throws ParseException 
	 * 
	 */
	public String alterAdvertisingService(String tid, Order newOrder, String operater, String[] preIgnoreProperties) {
		String recallInfo = "";
		Order order = orderDAO.findById(Integer.valueOf(tid));
		Adcontract adcontract = order.getAdcontract();
		String[] ignoreProperties = {"id", "content", "led", "duration", "frequency", "startdate", "enddate", "starttime", "endtime", "playstrategy"};
		// 如果是批量操作，页面form中至少会传入1个值，led,如果不是批操作，则传回的值可能是长度为1的空数组
		if (preIgnoreProperties.length > 0 && !"".equals(preIgnoreProperties[0])) {
			ignoreProperties = preIgnoreProperties;
		}
		BeanUtils.copyProperties(order, newOrder, ignoreProperties);

		// List<String> ignorePropertiesList = new ArrayList<String>(Arrays.asList(defaultIgnoreProperties));
		// if (ignoreProperties.length > 0 && !"".equals(ignoreProperties[0])) {
		// List<String> ignoreList = new
		// ArrayList<String>(Arrays.asList(ignoreProperties));
		// ignorePropertiesList = ignoreList;
		// }
		// new ClassesConvertTool().copyProperties(order, newOrder,
		// ignorePropertiesList);
		
		Calendar todayStart = Calendar.getInstance();
		todayStart.set(Calendar.HOUR_OF_DAY, 0);
		todayStart.set(Calendar.MINUTE, 0);
		todayStart.set(Calendar.SECOND, 0);
		todayStart.set(Calendar.MILLISECOND, 0);
		Date today = todayStart.getTime();
		
		// 1.删除改刊期间publishdetail
		List<Publishdetail> publishdetailList = publishdetailDAO.findByOrderid(order.getId());
		for (Publishdetail publishdetail : publishdetailList) {
			//如果是在播的单据，改刊不改历史
			if (today.compareTo(order.getStartdate()) > 0 && publishdetail.getDate().compareTo(newOrder.getStartdate()) < 0) {
			} else {
				publishdetailDAO.delete(publishdetail);
			}
		}
//		todayStart.add(Calendar.DATE, -1);
//		order.setEnddate(todayStart.getTime());

		// 2.写入新的publishidetail
		Led led = ledDAO.findById(newOrder.getLed().getId());
		// 增加轮播、包屏、其他形式播放策略后，针对之前的数据没有此项属性，避免空指针异常
		Playstrategy ps = playstrategyDAO.findById(newOrder.getPlaystrategy().getId());
		newOrder.setLed(led);
		newOrder.setPlaystrategy(ps);
		List<Publishdetail> list = packagePublishList(adcontract, newOrder);
		for (Publishdetail publishdetail : list) {
			if (today.compareTo(order.getStartdate()) > 0 && publishdetail.getDate().compareTo(newOrder.getStartdate()) < 0) {
			} else {
				publishdetailDAO.save(publishdetail);
			}
		}

		// 3.写入alterrecord
		Alterrecord altr = createAlterrecord(newOrder, operater, TypeCollections.ADVERTISE_ALTER);
		alterrecordDAO.save(altr);

		// 4.判断是否需要修改adcontract
		adcontract = adcontractDAO.findById(adcontract.getId());
		if (adcontract.getOrders().size() < 1) {
			// 需要保存adcontracthistory
			// 5.保存adcontacthistory
			AdcontractHistory adh = new AdcontractHistory();
			BeanUtils.copyProperties(adcontract, adh);
			adh.setOperater(operater);
			adh.setOperatetype(new Operatetype(TypeCollections.ADVERTISE_ALTER));
			adh.setModifiedtime(new Timestamp(System.currentTimeMillis()));
			adcontractHistoryDAO.save(adh);

			// 删除adcontract
			adcontractDAO.delete(adcontract);
		}
		recallInfo = "操作成功！";
		return recallInfo;
	}

	public Alterrecord createAlterrecord(Order ord, String operater, Short operatetypeId) {
		Alterrecord alr = new Alterrecord();

		alr.setAdcontent(ord.getContent());
		alr.setLedname(ord.getLed().getName());
		alr.setDatestart(ord.getStartdate());
		alr.setDateend(ord.getEnddate());
		alr.setDuration(ord.getDuration());
		alr.setFrequency(ord.getFrequency());
		alr.setPlaystrategyname(ord.getPlaystrategy().getStrategyname());
		alr.setAlterdate(new Date());
		alr.setOperatetype(new Operatetype(operatetypeId));
		alr.setOperater(operater);
		alr.setOrder(ord);
		alr.setCreatetime(new Timestamp(System.currentTimeMillis()));

		return alr;

	}

	/**
	 * 停刊的业务流程</br>
	 * 1.保存orderhistory;</br>
	 * 2.删除publishdetail;</br>
	 * 3.删除order，另外修改order，重新设置单据起始时间，生成publishdetail;</br>
	 * 4.判断是否需要修改adcontract;</br>
	 * 5.写入operevent事件
	 * 
	 */
	@Transactional
	public String stopAdvertisingService(String tid, String operater, String remark, Date stopAdvertiseDateFrom, Date stopAdvertiseDateTo) {
		String recallInfo = "";
		Order order = orderDAO.findById(Integer.valueOf(tid));
		Order originalOrder = new Order();
		BeanUtils.copyProperties(order, originalOrder);
		Adcontract adcontract = order.getAdcontract();

		// 2.删除停刊时间内publishdetail
		List<Publishdetail> publishdetailList = publishdetailDAO.findByOrderid(order.getId());
		for (Publishdetail publishdetail : publishdetailList) {
			System.out.println(publishdetail.getDate().toString());
			System.out.println(stopAdvertiseDateFrom.toString());
			System.out.println(publishdetail.getDate().compareTo(stopAdvertiseDateFrom) >= 0);
			if (publishdetail.getDate().compareTo(stopAdvertiseDateFrom) >= 0 && publishdetail.getDate().compareTo(stopAdvertiseDateTo) <= 0) {
				publishdetailDAO.delete(publishdetail);
			}
		}

		// 3.写入alterrecord
		Alterrecord altr = new Alterrecord();

		altr.setAdcontent(order.getContent());
		altr.setDatestart(stopAdvertiseDateFrom);
		altr.setDateend(stopAdvertiseDateTo);
		altr.setDuration(order.getDuration());
		altr.setFrequency(order.getFrequency());
		altr.setLedname(order.getLed().getName());
		altr.setOperater(operater);
		altr.setOperatetype(new Operatetype(TypeCollections.ADVERTISE_STOP));
		altr.setRemark(remark);
		altr.setAlterdate(new Date());
		altr.setOrder(order);
		altr.setPlaystrategyname(order.getPlaystrategy() == null ? "" : order.getPlaystrategy().getStrategyname());
		altr.setCreatetime(new Timestamp(System.currentTimeMillis()));

		alterrecordDAO.save(altr);

		// 6.写入operevent事件
		Operevent operevent = new Operevent();
		operevent.setOrderId(order.getId());
		operevent.setOriginorder(originalOrder.getId());
		operevent.setOperater(operater);
		operevent.setTime(new Timestamp(System.currentTimeMillis()));
		operevent.setOperatetype(new Operatetype(TypeCollections.ADVERTISE_STOP));
		operevent.setRemark(remark);

		opereventDAO.save(operevent);

		adcontract.setLastModifytime(new Timestamp(System.currentTimeMillis()));
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
	@Transactional
	public String revokeAdvertisingService(String tid, String operater, String remark, Date stopAdvertiseDateFrom, Date stopAdvertiseDateTo) {
		String recallInfo = "";
		Order order = orderDAO.findById(Integer.valueOf(tid));
		Order originalOrder = new Order();
		BeanUtils.copyProperties(order, originalOrder);
		Adcontract adcontract = order.getAdcontract();

		// 1.删除停刊时间内publishdetail
		List<Publishdetail> publishdetailList = publishdetailDAO.findByOrderid(order.getId());
		for (Publishdetail publishdetail : publishdetailList) {
			if (publishdetail.getDate().compareTo(stopAdvertiseDateFrom) >= 0 && publishdetail.getDate().compareTo(stopAdvertiseDateTo) <= 0) {
				publishdetailDAO.delete(publishdetail);
			}
		}

		// 2.写入alterrecord
		Alterrecord altr = new Alterrecord();

		altr.setAdcontent(order.getContent());
		altr.setDatestart(stopAdvertiseDateFrom);
		altr.setDateend(stopAdvertiseDateTo);
		altr.setLedname(order.getLed().getName());
		altr.setOperater(operater);
		altr.setOperatetype(new Operatetype(TypeCollections.ADVERTISE_REVOKE));
		altr.setRemark(remark);
		altr.setAlterdate(new Date());
		altr.setOrder(order);
		altr.setPlaystrategyname(order.getPlaystrategy() == null ? "" : order.getPlaystrategy().getStrategyname());
		altr.setCreatetime(new Timestamp(System.currentTimeMillis()));

		alterrecordDAO.save(altr);

		// 3.写入operevent事件
		Operevent operevent = new Operevent();
		operevent.setOrderId(order.getId());
		operevent.setOriginorder(originalOrder.getId());
		operevent.setOperater(operater);
		operevent.setTime(new Timestamp(System.currentTimeMillis()));
		operevent.setOperatetype(new Operatetype(TypeCollections.ADVERTISE_REVOKE));
		operevent.setRemark(remark);

		opereventDAO.save(operevent);

		// 4.更新adcontract
		adcontract.setLastModifytime(new Timestamp(System.currentTimeMillis()));
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
		// 若adcontract关键属性修改，查询所有order，级联所有publishdetail一并修改
		if (adcontractIsModified) {
			List<Order> list = orderDAO.findByProperty("adcontract", adc);
			System.out.println();
			for (Order order : list) {
				// 删除publishdetail
				List alterList = alterrecordDAO.findByOrderId(order.getId());
				if (alterList.size() > 0) {
					continue;
				}
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
		// order = orderDAO.findById(order.getId());
		// Adcontract adcontract =
		// adcontractDAO.findById(order.getAdcontract().getId());
		Adcontract adcontract = order.getAdcontract();
		OrderHistory oh = new OrderHistory();
		BeanUtils.copyProperties(order, oh);

		oh.setOperater(user.getRealname());
		oh.setOperatetime(new Timestamp(System.currentTimeMillis()));
		Operatetype operatetype = operatetypeDAO.findById(ProjectAttributeConstant.ADVERTISE_ORDER_DELETE);
		oh.setOperatetype(operatetype);
		// oh.setOperatetype(new
		// Operatetype(ProjectAttributeConstant.ADVERTISE_ORDER_DELETE));
		orderHistoryDAO.save(oh);

		// 2.删除publishdetail
		deletePublishdetail(order.getId());

		// 3.判断是否需要修改adcontract
		if (adcontract.getOrders().size() > 1) {
		} else {// 需要保存adcontracthistory
				// 保存adcontacthistory
			AdcontractHistory adh = new AdcontractHistory();
			System.out.println(adcontract.getOrders().size());
			BeanUtils.copyProperties(adcontract, adh);
			adh.setOperater(user.getRealname());
			adh.setOperatetype(new Operatetype(ProjectAttributeConstant.ADVERTISE_ORDER_DELETE));
			adh.setModifiedtime(new Timestamp(System.currentTimeMillis()));
			adcontractHistoryDAO.save(adh);

			// 删除adcontract
			adcontractDAO.delete(adcontract);
		}

		// 4.删除order
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
	 * 
	 * @param attrValue
	 * @return
	 */
	public boolean repeatabilityCheckOfOrder(String attrValue) {
		List list = orderDAO.findByProperty("md5encrypt", attrValue);
		if (list.size() > 1) {
			// 可视为重复
			return true;
		} else {
			return false;
		}

	}

}
