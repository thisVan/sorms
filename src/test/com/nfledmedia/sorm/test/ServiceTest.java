package com.nfledmedia.sorm.test;

import java.text.ParseException;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.AbstractJUnit4SpringContextTests;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.nfledmedia.sorm.dao.AdcontractDAO;
import com.nfledmedia.sorm.dao.LedDAO;
import com.nfledmedia.sorm.dao.OrderDAO;
import com.nfledmedia.sorm.entity.Adcontract;
import com.nfledmedia.sorm.entity.Led;
import com.nfledmedia.sorm.entity.Publishdetail;
import com.nfledmedia.sorm.service.AdcontractService;
import com.nfledmedia.sorm.service.BaseService;
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
	
	@Resource
	BaseService baseService;
	
	@Resource
	AdcontractService adcontractService;;
	
	@Test
	public void getClientsLikeKeywordTest(){
		String keyword = "广东";
		List<Adcontract> list = adcontractService.getClientsLikeKeyword(keyword);
		//System.out.println(list);
		for (Adcontract ad : list) {
			System.out.println(ad.getClient());
		}
	}

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
	
	@Test
	public void baseServiceTest(){
		System.out.println(baseService.clientsList());
		System.out.println(baseService.ledList());
	}
	
	@Test
	public void renkanshuServiceTest(){
		List<Publishdetail> list = renkanshuService.publishInTimerangeListAndLedname("2018-02-01", "2018-02-28", "外经贸大厦");
		for (Publishdetail publishdetail : list) {
			System.out.println(publishdetail.toString());
		}
	}

	@Test
	public void getOrdersByAdcontract(){
		List list = adcontractService.getOrdersByAdcontractId(1000);
		System.out.println(list);
	}
	
	public void printMap(Map<String, Object> map) {
		for (Map.Entry<String, Object> entry : map.entrySet()) {
			System.out.println("key-->" + entry.getKey());
			System.out.println("value-->" + entry.getValue());
		}
	}
	
	@Test
	public void avgOccuByMonthsReportServiceTest(){
		List list = yewuService.avgOccuByMonthsReportService(2019, "南都楼顶");
		System.out.println("数据长度：" + list.size());
		for (Object object : list) {
			List lst = (List) object;
			System.out.println(lst.get(0) + " " + lst.get(1) + " " + lst.get(2));
		}
	}

}
