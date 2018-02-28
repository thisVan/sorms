package com.nfledmedia.sorm.entity;

import java.sql.Time;
import java.util.Date;

/**
 * Publishdetail entity. @author MyEclipse Persistence Tools
 */

public class Publishdetail implements java.io.Serializable {

	// Fields

	private Integer id;
	private Integer orderid;
	private String client;
	private String adcontent;
	private String ledname;
	private String indname;
	private String ctypename;
	private String attributename;
	private Short frequency;
	private Short addfreq;
	private Short duration;
	private Date date;
	private Time starttime;
	private Time endtime;

	// Constructors

	/** default constructor */
	public Publishdetail() {
	}

	/** minimal constructor */
	public Publishdetail(Integer orderid, String client, String ledname,
			String indname, Short frequency, Short duration) {
		this.orderid = orderid;
		this.client = client;
		this.ledname = ledname;
		this.indname = indname;
		this.frequency = frequency;
		this.duration = duration;
	}

	/** full constructor */
	public Publishdetail(Integer id, Integer orderid, String client,
			String adcontent, String ledname, String indname, String ctypename,
			String attributename, Short frequency, Short addfreq,
			Short duration, Date date, Time starttime, Time endtime) {
		super();
		this.id = id;
		this.orderid = orderid;
		this.client = client;
		this.adcontent = adcontent;
		this.ledname = ledname;
		this.indname = indname;
		this.ctypename = ctypename;
		this.attributename = attributename;
		this.frequency = frequency;
		this.addfreq = addfreq;
		this.duration = duration;
		this.date = date;
		this.starttime = starttime;
		this.endtime = endtime;
	}

	// Property accessors

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getOrderid() {
		return this.orderid;
	}

	public void setOrderid(Integer orderid) {
		this.orderid = orderid;
	}

	public String getClient() {
		return this.client;
	}

	public void setClient(String client) {
		this.client = client;
	}

	public String getAdcontent() {
		return this.adcontent;
	}

	public void setAdcontent(String adcontent) {
		this.adcontent = adcontent;
	}

	public String getLedname() {
		return this.ledname;
	}

	public void setLedname(String ledname) {
		this.ledname = ledname;
	}

	public String getIndname() {
		return this.indname;
	}

	public void setIndname(String indname) {
		this.indname = indname;
	}

	public String getCtypename() {
		return this.ctypename;
	}

	public void setCtypename(String ctypename) {
		this.ctypename = ctypename;
	}

	public String getAttributename() {
		return attributename;
	}

	public void setAttributename(String attributename) {
		this.attributename = attributename;
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

	public Short getDuration() {
		return this.duration;
	}

	public void setDuration(Short duration) {
		this.duration = duration;
	}

	public Date getDate() {
		return this.date;
	}

	public void setDate(Date date) {
		this.date = date;
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

	@Override
	public String toString() {
		return "Publishdetail [id=" + id + ", orderid=" + orderid + ", client=" + client + ", adcontent=" + adcontent + ", ledname="
				+ ledname + ", indname=" + indname + ", ctypename=" + ctypename + ", attributename=" + attributename + ", frequency="
				+ frequency + ", addfreq=" + addfreq + ", duration=" + duration + ", date=" + date + ", starttime=" + starttime
				+ ", endtime=" + endtime + "]";
	}

	
}