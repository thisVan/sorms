package com.nfledmedia.sorm.service;

import java.sql.Time;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.jar.Attributes.Name;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;

import com.nfledmedia.sorm.cons.TypeCollections;
import com.nfledmedia.sorm.dao.AlterrecordDAO;
import com.nfledmedia.sorm.dao.AttributeDAO;
import com.nfledmedia.sorm.dao.ChannelDAO;
import com.nfledmedia.sorm.dao.ClienttypeDAO;
import com.nfledmedia.sorm.dao.IndustryDAO;
import com.nfledmedia.sorm.dao.LedDAO;
import com.nfledmedia.sorm.dao.OpereventDAO;
import com.nfledmedia.sorm.dao.PlaystrategyDAO;
import com.nfledmedia.sorm.dao.PublishdetailDAO;
import com.nfledmedia.sorm.dao.PublishstyleDAO;
import com.nfledmedia.sorm.entity.Alterrecord;
import com.nfledmedia.sorm.entity.Attribute;
import com.nfledmedia.sorm.entity.Channel;
import com.nfledmedia.sorm.entity.Clienttype;
import com.nfledmedia.sorm.entity.Industry;
import com.nfledmedia.sorm.entity.Led;
import com.nfledmedia.sorm.entity.Operevent;
import com.nfledmedia.sorm.entity.Playstrategy;
import com.nfledmedia.sorm.entity.Publishdetail;

/**
 * 
 * @author PC-FAN
 *
 */
@Service
public class BaseService {
	@Autowired
	private LedDAO ledDAO;
	@Autowired
	private AttributeDAO attributeDAO;
	@Autowired
	private ClienttypeDAO clienttypeDAO;
	@Autowired
	private ChannelDAO channelDAO;
	@Autowired
	private IndustryDAO industryDAO;
	@Autowired
	private PublishdetailDAO publishdetailDAO;
	@Autowired
	private PlaystrategyDAO playstrategyDAO;
	@Autowired
	private OpereventDAO opereventDAO;
	@Autowired
	private PublishstyleDAO publishstyleDAO;
	@Autowired
	private AlterrecordDAO alterrecordDAO;

	public List ledList() {
		return ledDAO.findByState(TypeCollections.LED_ACTIVE_STATE);
	}

	public List clienttypeList() {
		return clienttypeDAO.findAll();

	}

	public List<Attribute> attributeList() {
		return attributeDAO.findAll();
	}

	public List<Industry> industryList() {
		return industryDAO.findAll();
	}

	public List<Channel> channelList() {
		return channelDAO.findAll();
	}

	public PublishdetailDAO getPublishdetailDAO() {
		return publishdetailDAO;
	}

	public void setPublishdetailDAO(PublishdetailDAO publishdetailDAO) {
		this.publishdetailDAO = publishdetailDAO;
	}

	public List<String> clientsList() {
		List<Publishdetail> pbsdtlList = publishdetailDAO.findAll();
		List<String> strList = new ArrayList<String>();
		Set cset = new HashSet();
		for (Publishdetail pbd : pbsdtlList) {
			cset.add(pbd.getClient());
		}
		for (Object object : cset) {
			strList.add((String) object);
		}
		return strList;

	}

	/**
	 * 根据ledId获取开关屏时间
	 * 
	 * @param id
	 * @return
	 */
	public Time[] returnSETimeByLedId(Integer id) {
		Led l = ledDAO.findById(id);
		Time[] setime = {l.getStarttime(), l.getEndtime()};
		return setime;
	}

	public Led getLedById(Integer id) {
		return ledDAO.findById(id);
	}

	public Channel getChannelById(Integer id) {
		return channelDAO.findById(id);
	}

	public Industry getIndustryByIndustryid(Short industryid) {
		return industryDAO.findById(industryid);
	}

	public Clienttype getClienttypeById(Short id) {
		return clienttypeDAO.findById(id);
	}

	public Attribute getAttributeById(Short id) {
		return attributeDAO.findById(id);
	}

	public Attribute getAttributeByName(String attrname) {
		return (Attribute) attributeDAO.findByArrtibutename(attrname).get(0);
	}

	public Led getLedByName(String ledName) {
		// TODO Auto-generated method stub
		return (Led) ledDAO.findByName(ledName).get(0);
	}

	/**
	 * 返回所有播放策略
	 * 
	 * @return
	 */
	public List<?> strategyList() {
		// TODO Auto-generated method stub
		return playstrategyDAO.findAll();
	}

	public Playstrategy getPlaystrategyById(Short id) {
		return playstrategyDAO.findById(id);
	}

	public Playstrategy getPlaystrategyByName(String playstrategyname) {
		return (Playstrategy) playstrategyDAO.findByStrategyname(playstrategyname).get(0);
	}


//	public List<Operevent> getOpereventByOrderId(int orderid){
//	 
//	    return opereventDAO.findByOrderId(orderid);
//	  
//	}


	public List<Alterrecord> getAlterrecordByOrderId(int orderid) {

		return alterrecordDAO.findByOrderId(orderid);

	}

	public List publishstyleList() {
		return publishstyleDAO.findAll();
	}
}
