package com.nfledmedia.sorm.entity;

import java.sql.Timestamp;
import java.util.Date;

/**
 * Alterrecord entity. @author MyEclipse Persistence Tools
 */

public class Alterrecord implements java.io.Serializable {

	// Fields

	private Integer id;
	private Operatetype operatetype;
	private Order order;
	private String adcontent;
	private Date datestart;
	private Date dateend;
	private Short duration;
	private Short frequency;
	private Date alterdate;
	private String remark;
	private String operater;
	private String ledname;
	private String playstrategyname;
	private Timestamp createtime;

	// Constructors

	/** default constructor */
	public Alterrecord() {
	}

	/** minimal constructor */
	public Alterrecord(Integer id, Operatetype operatetype, User user, Order order, String adcontent, Date datestart,
			Date dateend, Short duration, Short frequency, Date alterdate, String operater, Timestamp createtime) {
		this.id = id;
		this.operatetype = operatetype;
		this.operater = operater;
		this.order = order;
		this.adcontent = adcontent;
		this.datestart = datestart;
		this.dateend = dateend;
		this.duration = duration;
		this.frequency = frequency;
		this.alterdate = alterdate;
		this.createtime = createtime;
	}

	/** full constructor */
	public Alterrecord(Integer id, Operatetype operatetype, Order order, String adcontent, Date datestart, Date dateend, Short duration, Short frequency,
			Date alterdate, String remark, String operater, String ledname, String playstrategyname, Timestamp createtime) {
		super();
		this.id = id;
		this.operatetype = operatetype;
		this.order = order;
		this.adcontent = adcontent;
		this.datestart = datestart;
		this.dateend = dateend;
		this.duration = duration;
		this.frequency = frequency;
		this.alterdate = alterdate;
		this.remark = remark;
		this.operater = operater;
		this.ledname = ledname;
		this.playstrategyname = playstrategyname;
		this.createtime = createtime;
	}

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Operatetype getOperatetype() {
		return this.operatetype;
	}

	public void setOperatetype(Operatetype operatetype) {
		this.operatetype = operatetype;
	}

	public String getOperater() {
		return operater;
	}

	public void setOperater(String operater) {
		this.operater = operater;
	}

	public String getLedname() {
		return ledname;
	}

	public void setLedname(String ledname) {
		this.ledname = ledname;
	}

	public String getPlaystrategyname() {
		return playstrategyname;
	}

	public void setPlaystrategyname(String playstrategyname) {
		this.playstrategyname = playstrategyname;
	}

	public Order getOrder() {
		return this.order;
	}

	public void setOrder(Order order) {
		this.order = order;
	}

	public String getAdcontent() {
		return this.adcontent;
	}

	public void setAdcontent(String adcontent) {
		this.adcontent = adcontent;
	}

	public Date getDatestart() {
		return this.datestart;
	}

	public void setDatestart(Date datestart) {
		this.datestart = datestart;
	}

	public Date getDateend() {
		return this.dateend;
	}

	public void setDateend(Date dateend) {
		this.dateend = dateend;
	}

	public Short getDuration() {
		return this.duration;
	}

	public void setDuration(Short duration) {
		this.duration = duration;
	}

	public Short getFrequency() {
		return this.frequency;
	}

	public void setFrequency(Short frequency) {
		this.frequency = frequency;
	}

	public Date getAlterdate() {
		return this.alterdate;
	}

	public void setAlterdate(Date alterdate) {
		this.alterdate = alterdate;
	}

	public String getRemark() {
		return this.remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public Timestamp getCreatetime() {
		return this.createtime;
	}

	public void setCreatetime(Timestamp createtime) {
		this.createtime = createtime;
	}

	@Override
	public String toString() {
		return "Alterrecord [id=" + id + ", operatetype=" + operatetype.getOperatetype() + ", operater=" + operater
				+ ", order=" + order.getId() + ", adcontent=" + adcontent + ", datestart=" + datestart + ", dateend="
				+ dateend + ", duration=" + duration + ", frequency=" + frequency + ", alterdate=" + alterdate
				+ ", remark=" + remark + ", createtime=" + createtime + "]";
	}

}