package com.nfledmedia.sorm.service;

import java.util.List;

import javax.persistence.Entity;
import javax.persistence.ManyToOne;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.nfledmedia.sorm.cons.TypeCollections;
import com.nfledmedia.sorm.dao.LedDAO;
import com.nfledmedia.sorm.entity.Led;

/**
 * 项目名称：sorm 类全名:com.nfledmedia.sorm.service.LedService 类描述：
 * 创建人：Van@nfledmedia 创建时间：2016年6月22日 上午10:08:47 修改备注：
 * 
 * @version jdk1.7
 * 
 * Copyright (c) 2016, bolven@qq.com All Rights Reserved.
 */
@Transactional
@Service
public class LedService {
	@Autowired
	private LedDAO ledDAO;

/*	public Page getPingmuguanliList(String sidx, String sord, int pageNo,
			int pageSize) {
		System.out.println("???????????yewuService:getYewuList:sidx:" + sidx);
		return ledDAO.getPingmuguanliList(sidx, sord, pageNo, pageSize);
	}

	public Page getPingmuguanliListByKeyword(String keyword, String sidx,
			String sord, int pageNo, int pageSize) {
		return ledDAO.getPingmuguanliListByKeyword(keyword, sidx, sord, pageNo,
				pageSize);
	}

	public Page getledResourceList(String sidx, String sord, int pageNo,
			int pageSize) {
		System.out.println("???????????yewuService:getYewuList:sidx:" + sidx);
		return ledDAO.getledResourceList(sidx, sord, pageNo, pageSize);
	}

	public Page getledResourceListByKeyword(String keyword, String sidx,
			String sord, int pageNo, int pageSize) {
		return ledDAO.getledResourceListByKeyword(keyword, sidx, sord, pageNo,
				pageSize);
	}

	public Led loadLedByID(String ledId) {
		System.out.println("###########  yewuServiceyewuId:" + ledId);
		Led led = ledDAO.findById(ledId);
		return led;
	}

	public void saveLed(Led led){
		try{
			ledDAO.save(led);
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	public void update(Led led) {
		System.out
				.println("###########  LedService###############led.getLedId():"
						+ led.getLedId());
		Led lednew = ledDAO.findById(led.getLedId());
		lednew.setLedDaima(led.getLedDaima());
		lednew.setLedName(led.getLedName());
		lednew.setLedWeizhi(led.getLedWeizhi());
		lednew.setLedBofangshichang(led.getLedBofangshichang());
		lednew.setLedBofangkaishishijian(led.getLedBofangkaishishijian());
		// 播放结束时间不能为null
		lednew.setLedBofangjieshushijian(led.getLedBofangjieshushijian());
		lednew.setLedJianxieshichang(led.getLedJianxieshichang());
		lednew.setLedJianxiestart(led.getLedJianxiestart());
		lednew.setLedJianxieend(led.getLedJianxieend());
		lednew.setLedChangdu(led.getLedChangdu());
		lednew.setLedKuangdu(led.getLedKuangdu());
		lednew.setLedMianji(led.getLedMianji());
		lednew.setLedFenbianlv(led.getLedFenbianlv());
		lednew.setLedLeixing(led.getLedLeixing());
		lednew.setLedKanliprice(led.getLedKanliprice());
		lednew.setState(led.getState());
		System.out
				.println("###########  LedService###############setState()执行完毕");
		ledDAO.merge(lednew);

	}*/
	

	public void deleteLed(String ids) {
		String[] idss = ids.split(",");
		for (int i = 0, size = idss.length; i < size; i++) {
			Led led = ledDAO.findById(Integer.valueOf(idss[i]));
			if (!led.getState().equals("D")) {
				led.setState("D");
				ledDAO.merge(led);
			}
		}
	}
	
	public Integer returnPublishPrice(Integer ledId){
		Led led = (Led) ledDAO.findById(ledId);
		return led.getPublishprice();
	}
	
	public List actledList() {
		
		return ledDAO.findByState(TypeCollections.LED_ACTIVE_STATE);
		
	}


}
