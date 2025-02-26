package com.nfledmedia.sorm.test;

import java.io.IOException;

import javax.annotation.Resource;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.AbstractJUnit4SpringContextTests;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.nfledmedia.sorm.action.RenkanAction;
import com.nfledmedia.sorm.action.UserAction;
import com.nfledmedia.sorm.action.YewuAction;


@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = "classpath:applicationContext.xml")
public class ActionTest extends AbstractJUnit4SpringContextTests{

	@Resource
	YewuAction yewuAction;
	
	@Resource
	RenkanAction renkanAction;
	
	@Resource
	UserAction userAction;
	
	@Test
	public void avgOccuRateListByScreenTest() throws Exception{
		yewuAction.avgOccuRateListByScreen();
	}
	
	@Test
	public void publishResourceExportTest() throws Exception{
		yewuAction.setStartTime("2017-12-01");
		yewuAction.setEndTime("2017-12-07");
		yewuAction.setLedId("外经贸大厦");
		yewuAction.publishResourceExport();
	}
	
	@Test
	public void adcontentStatisticExportTest() throws Exception {
		yewuAction.setStartTime("2017-12-01");
		yewuAction.setEndTime("2017-12-31");
		yewuAction.adcontentStatisticExport();
	}
	
	@Test
	public void screenOcuuRateByDate() throws Exception{
		yewuAction.setDateRangeSQL("2017-12-01 2017-12-07");
		yewuAction.setLedId("1");
		
		yewuAction.screenOccuRateListByDate();
	}
	
	@Test
	public void publishArrangementExportTest() throws Exception {
		yewuAction.setStartTime("2017-12-10");
		yewuAction.setEndTime("2017-12-12");
		String[] ledsArr = {"1","10"};
		yewuAction.setLedsArray(ledsArr);
		
		yewuAction.publishArrangementExport();
		
	}
	
	@Test
	public void updateOrderTest() throws IOException {
		renkanAction.updateOrder();
	}

	@Test
	public void autocompleteclientTest() throws Exception{
		yewuAction.setKeyword("广东");
		yewuAction.autocompleteclient();
	}
	
	@Test
	public void orderDetailExportTest() throws Exception{
		yewuAction.setStartTime("2018-01-01");
		yewuAction.setEndTime("2018-04-30");
		
		yewuAction.orderDetailExport();
	}
	
	@Test
	public void getAlterHistoryTest() throws IOException {
		yewuAction.setOrderid(69);
		yewuAction.getAlterrecordsByOrderid();
	}
	
	@Test
	public void avgOccuByMonthsReportTestf() throws Exception{
		yewuAction.setYear(2019);
		yewuAction.setLed("");
		
		yewuAction.avgOccuByMonthsReport();
	}
	
	
	@Test
	public void testVerifyRemoteAccess() {
		System.out.println(userAction.verifyRemoteAccess("wun"));
	}
}
