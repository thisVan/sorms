package com.nfledmedia.sorm.entity;

import java.sql.Time;
import java.sql.Timestamp;
import java.util.Date;

/**
 * Order entity. @author MyEclipse Persistence Tools
 */

public class Order implements java.io.Serializable {

	// Fields

	private Integer id;
	private Adcontract adcontract;
	private Led led;
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

	// Constructors

	/** default constructor */
	public Order() {
	}

	/** minimal constructor */
	public Order(Integer id) {
		this.id = id;
	}

	/** full constructor */
	public Order(Integer id, Adcontract adcontract, Led led, Industry industry,
			Attribute attribute, String ordersn, String content,
			Short duration, Short frequency, Short addfreq, Date startdate,
			Date enddate, Time starttime, Time endtime, String modifier,
			Timestamp modtime, String state) {
		this.id = id;
		this.adcontract = adcontract;
		this.led = led;
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
	}

	// Property accessors

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Adcontract getAdcontract() {
		return this.adcontract;
	}

	public void setAdcontract(Adcontract adcontract) {
		this.adcontract = adcontract;
	}

	public Led getLed() {
		return this.led;
	}

	public void setLed(Led led) {
		this.led = led;
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

	@Override
	public String toString() {
		return "Order [id=" + id + ", led=" + led.getName() + ", industry=" + industry.getIndustryname()
				+ ", attribute=" + attribute.getAttributename() + ", ordersn=" + ordersn
				+ ", content=" + content + ", duration=" + duration
				+ ", frequency=" + frequency + ", addfreq=" + addfreq
				+ ", startdate=" + startdate + ", enddate=" + enddate
				+ ", starttime=" + starttime + ", endtime=" + endtime
				+ ", modifier=" + modifier + ", modtime=" + modtime
				+ ", state=" + state + "]";
	}

	
}