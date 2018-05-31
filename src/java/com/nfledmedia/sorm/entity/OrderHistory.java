package com.nfledmedia.sorm.entity;

import java.sql.Time;
import java.sql.Timestamp;
import java.util.Date;

/**
 * OrderHistory entity. @author MyEclipse Persistence Tools
 */

public class OrderHistory implements java.io.Serializable {

	// Fields

	private Integer id;
	private Led led;
	private Operatetype operatetype;
	private Adcontract adcontract;
	private Playstrategy playstrategy;
	private Industry industry;
	private Attribute attribute;
	private String ordersn;
	private String content;
	private Short duration;
	private Short frequency;
	private Short addfreq;
	private Date startdate;
	private Date enddate;
	private Time starttime;
	private Time endtime;
	private String modifier;
	private Timestamp modtime;
	private String state;
	private Timestamp operatetime;
	private String operater;

	// Constructors

	/** default constructor */
	public OrderHistory() {
	}

	/** minimal constructor */
	public OrderHistory(Operatetype operatetype, Timestamp operatetime, String operater) {
		this.operatetype = operatetype;
		this.operatetime = operatetime;
		this.operater = operater;
	}

	/** full constructor */
	public OrderHistory(Led led, Operatetype operatetype, Adcontract adcontract, Playstrategy playstrategy, Industry industry,
			Attribute attribute, String ordersn, String content, Short duration, Short frequency, Short addfreq, Date startdate,
			Date enddate, Time starttime, Time endtime, String modifier, Timestamp modtime, String state, Timestamp operatetime,
			String operater) {
		this.led = led;
		this.operatetype = operatetype;
		this.adcontract = adcontract;
		this.playstrategy = playstrategy;
		this.industry = industry;
		this.attribute = attribute;
		this.ordersn = ordersn;
		this.content = content;
		this.duration = duration;
		this.frequency = frequency;
		this.addfreq = addfreq;
		this.startdate = startdate;
		this.enddate = enddate;
		this.starttime = starttime;
		this.endtime = endtime;
		this.modifier = modifier;
		this.modtime = modtime;
		this.state = state;
		this.operatetime = operatetime;
		this.operater = operater;
	}

	// Property accessors

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Led getLed() {
		return this.led;
	}

	public void setLed(Led led) {
		this.led = led;
	}

	public Operatetype getOperatetype() {
		return this.operatetype;
	}

	public void setOperatetype(Operatetype operatetype) {
		this.operatetype = operatetype;
	}

	public Adcontract getAdcontract() {
		return this.adcontract;
	}

	public void setAdcontract(Adcontract adcontract) {
		this.adcontract = adcontract;
	}

	public Playstrategy getPlaystrategy() {
		return this.playstrategy;
	}

	public void setPlaystrategy(Playstrategy playstrategy) {
		this.playstrategy = playstrategy;
	}

	public Industry getIndustry() {
		return this.industry;
	}

	public void setIndustry(Industry industry) {
		this.industry = industry;
	}

	public Attribute getAttribute() {
		return this.attribute;
	}

	public void setAttribute(Attribute attribute) {
		this.attribute = attribute;
	}

	public String getOrdersn() {
		return this.ordersn;
	}

	public void setOrdersn(String ordersn) {
		this.ordersn = ordersn;
	}

	public String getContent() {
		return this.content;
	}

	public void setContent(String content) {
		this.content = content;
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

	public Short getAddfreq() {
		return this.addfreq;
	}

	public void setAddfreq(Short addfreq) {
		this.addfreq = addfreq;
	}

	public Date getStartdate() {
		return this.startdate;
	}

	public void setStartdate(Date startdate) {
		this.startdate = startdate;
	}

	public Date getEnddate() {
		return this.enddate;
	}

	public void setEnddate(Date enddate) {
		this.enddate = enddate;
	}

	public Time getStarttime() {
		return this.starttime;
	}

	public void setStarttime(Time starttime) {
		this.starttime = starttime;
	}

	public Time getEndtime() {
		return this.endtime;
	}

	public void setEndtime(Time endtime) {
		this.endtime = endtime;
	}

	public String getModifier() {
		return this.modifier;
	}

	public void setModifier(String modifier) {
		this.modifier = modifier;
	}

	public Timestamp getModtime() {
		return this.modtime;
	}

	public void setModtime(Timestamp modtime) {
		this.modtime = modtime;
	}

	public String getState() {
		return this.state;
	}

	public void setState(String state) {
		this.state = state;
	}

	public Timestamp getOperatetime() {
		return this.operatetime;
	}

	public void setOperatetime(Timestamp operatetime) {
		this.operatetime = operatetime;
	}

	public String getOperater() {
		return this.operater;
	}

	public void setOperater(String operater) {
		this.operater = operater;
	}

}