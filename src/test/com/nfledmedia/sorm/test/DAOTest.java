package com.nfledmedia.sorm.test;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.AbstractJUnit4SpringContextTests;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.nfledmedia.sorm.dao.LedDAO;
import com.nfledmedia.sorm.dao.OrderDAO;
import com.nfledmedia.sorm.dao.PlaystrategyDAO;
import com.nfledmedia.sorm.dao.PublishdetailDAO;
import com.nfledmedia.sorm.entity.Led;

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

}
