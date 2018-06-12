package com.nfledmedia.sorm.test;

import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.BeanUtils;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.AbstractJUnit4SpringContextTests;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.transaction.annotation.Transactional;

import com.nfledmedia.sorm.dao.IndustryDAO;
import com.nfledmedia.sorm.dao.LedDAO;
import com.nfledmedia.sorm.dao.OperatetypeDAO;
import com.nfledmedia.sorm.dao.OpereventDAO;
import com.nfledmedia.sorm.dao.OrderDAO;
import com.nfledmedia.sorm.dao.OrderHistoryDAO;
import com.nfledmedia.sorm.dao.PlaystrategyDAO;
import com.nfledmedia.sorm.dao.PublishdetailDAO;
import com.nfledmedia.sorm.entity.Industry;
import com.nfledmedia.sorm.entity.Led;
import com.nfledmedia.sorm.entity.Operatetype;
import com.nfledmedia.sorm.entity.Operevent;
import com.nfledmedia.sorm.entity.Order;
import com.nfledmedia.sorm.entity.OrderHistory;
import com.nfledmedia.sorm.util.ClassesConvertTool;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = "classpath:applicationContext.xml")
public class DAOTest extends AbstractJUnit4SpringContextTests {

	@Resource
	PublishdetailDAO publishdetailDAO;
	
	@Resource
	LedDAO ledDAO;
	
	@Resource
	OrderDAO orderDAO;
	
	@Resource
	PlaystrategyDAO playstrategyDAO;
	
	@Resource
	IndustryDAO industryDAO;
	
	@Resource
	OrderHistoryDAO orderHistoryDAO;
	
	@Resource
	OperatetypeDAO operatetypeDAO;
	
	@Resource
	OpereventDAO opereventDAO;
	
	@Test
	public void getAll(){
		List list = publishdetailDAO.findAll();
		System.out.println(list.size());
	}
	
	@Test
	public void getAllLedAvai(){
		List<Led> list = ledDAO.findAllAvailable();
		for (Led led : list) {
			System.out.println(led.getName());
		}
	}
	
	@Test
	public void findOrdersOnDateByLedTest() throws ParseException {
		java.sql.Date checkDate = java.sql.Date.valueOf("2017-12-10");
		List list = orderDAO.findOrdersOnDateByLed(checkDate, 10);
		for (Object object : list) {
			System.out.println(object.toString());
		}
	}

	@Test
	public void getPublishdetailFromDaterangeTest() {
		Date dateStart = new Date();
		Date dateEnd = new Date();
		List lst = new ArrayList();
		try {
			lst = publishdetailDAO.getPublishdetailFromDaterange("2017-11-01", "2017-12-31");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		System.out.println(lst.size());
	}
	
	@Test
	public void testPlaystrategyDAO() {
		List playstrategys = playstrategyDAO.findAll();
		for (Object object : playstrategys) {
			System.out.println(object.toString());
		}
		
	}
	
	@Test
	public void testIndustryDAO(){
		Industry ind = new Industry();
		ind.setIndustryid(Short.valueOf("27"));
		ind.setIndustryname("哈哈");
		
		industryDAO.save(ind);
		
	}
	
	@Test
	public void testOrderHistoryDAO(){
		com.nfledmedia.sorm.entity.Order order = orderDAO.findById(2278);
		System.out.println(order.toString());
		OrderHistory oh = new OrderHistory();
		oh = (OrderHistory) new ClassesConvertTool().makeObject1ToObject2(order, oh);
		Operatetype op = operatetypeDAO.findById((short) 1);
		oh.setOperatetype(new Operatetype((short) 1));
		oh.setOperater("admin");
		oh.setOperatetime(new Timestamp(System.currentTimeMillis()));
		System.out.println(oh.toString());
/*		try {
			orderHistoryDAO.save(oh);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}*/
		
		try {
			orderHistoryDAO.delete(oh);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}
	
	@Test
	public void testUtils(){
		com.nfledmedia.sorm.entity.Order order = orderDAO.findById(2278);
		OrderHistory oh = new OrderHistory();
		OrderHistory oh1 = new OrderHistory();
		
		oh = (OrderHistory) new ClassesConvertTool().makeObject1ToObject2(order, oh);
		BeanUtils.copyProperties(order, oh1);
		
		oh.setOperatetype(operatetypeDAO.findById((short) 1));
		oh1.setOperatetype(operatetypeDAO.findById((short) 1));
		System.out.println(oh.equals(oh1));
		System.out.println(oh1+"\r"+oh);
		
	}
	
	@Test
	public void testOpereventDAO(){
		Operevent op = (Operevent) opereventDAO.findByOrder(2280).get(0);
		Operevent op1 = new Operevent();
		op1.setOperater("杨洋");
		op1.setOperatetype(new Operatetype((short) 1));
		op1.setOrder(new Order(2280));
		op1.setTime(new Timestamp(System.currentTimeMillis()));
		op1.setOriginorder(2280);
		opereventDAO.save(op1);
		System.out.println(op1.getId());
		try {
			Thread.sleep(20000);
		} catch (InterruptedException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		opereventDAO.delete(op1);
		try {
			Thread.sleep(20000);
		} catch (InterruptedException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		System.out.println(op1.getId());
	}

	@Test
	public void testFindInDuration(){
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		List<?> list;
		try {
			list = orderDAO.findOrdersInDuration(sdf.parse("2017-07-01"), sdf.parse("2018-01-01"));
			System.out.println(list.size());
			for (Object o : list) {
				Order order = (Order) o;
				System.out.println(order.getId());
			}
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}
}
