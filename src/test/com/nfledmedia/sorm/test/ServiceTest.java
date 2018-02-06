package com.nfledmedia.sorm.test;

import java.text.ParseException;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.AbstractJUnit4SpringContextTests;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.nfledmedia.sorm.dao.LedDAO;
import com.nfledmedia.sorm.dao.OrderDAO;
import com.nfledmedia.sorm.entity.Led;
import com.nfledmedia.sorm.service.RenkanshuService;
import com.nfledmedia.sorm.service.YewuService;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = "classpath:applicationContext.xml")
public class ServiceTest extends AbstractJUnit4SpringContextTests {

	@Resource
	YewuService yewuService;
	
	@Resource
	RenkanshuService renkanshuService;

	@Resource
	LedDAO ledDAO;

	@Test
	public void calAvgScreenOccuRate4AllScreenTest() {
		String dateRangeSQL = "2017-11-01 2017-11-01";
		List<Led> ledsList = ledDAO.findAllAvailable();
		List<Map<String, Integer>> list = null;
		try {
			list = yewuService.calAvgScreenOccuRate4AllScreen(dateRangeSQL, ledsList);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		System.out.println(list.size());
		for (Map map : list) {
			System.out.println("--------------");
			printMap(map);
		}
	}
	
	@Test
	public void getOrderOnDateByLedTest(){
		List list = renkanshuService.getOrderOnDateByLed("2017-12-10", 10);
		for (Object object : list) {
			System.out.println(object.toString());;
		}
	}
	
	@Test
	public void getOrderByLedTest(){
		List lst = renkanshuService.getOrderByLed(Integer.valueOf(10));
		for (Object object : lst) {
			System.out.println(object);
		}
	}

	public void printMap(Map<String, Object> map) {
		for (Map.Entry<String, Object> entry : map.entrySet()) {
			System.out.println("key-->" + entry.getKey());
			System.out.println("value-->" + entry.getValue());
		}
	}

}
