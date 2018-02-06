package com.nfledmedia.sorm.entity;

import java.sql.Time;
import java.sql.Timestamp;
import java.util.HashSet;
import java.util.Set;

/**
 * Led entity. @author MyEclipse Persistence Tools
 */

public class Led implements java.io.Serializable {

	// Fields

	private Integer id;
	private String ledsn;
	private String code;
	private String name;
	private String location;
	private Integer avlduration;
	private Time starttime;
	private Time endtime;
	private Time brkstart;
	private Time brkend;
	private Integer brkduration;
	private Float ledlength;
	private Float ledheight;
	private Float ledsqure;
	private String ledresolution;
	private String ledtype;
	private Integer publishprice;
	private String province;
	private String city;
	private String district;
	private Timestamp modtime;
	private String state;
	private Set orders = new HashSet(0);

	// Constructors

	/** default constructor */
	public Led() {
	}

	/** minimal constructor */
	public Led(String ledsn, String name, String location, Integer avlduration,
			Time starttime, Time endtime) {
		this.ledsn = ledsn;
		this.name = name;
		this.location = location;
		this.avlduration = avlduration;
		this.starttime = starttime;
		this.endtime = endtime;
	}

	/** full constructor */
	public Led(String ledsn, String code, String name, String location,
			Integer avlduration, Time starttime, Time endtime, Time brkstart,
			Time brkend, Integer brkduration, Float ledlength, Float ledheight,
			Float ledsqure, String ledresolution, String ledtype,
			Integer publishprice, String province, String city,
			String district, Timestamp modtime, String state, Set orders) {
		this.ledsn = ledsn;
		this.code = code;
		this.name = name;
		this.location = location;
		this.avlduration = avlduration;
		this.starttime = starttime;
		this.endtime = endtime;
		this.brkstart = brkstart;
		this.brkend = brkend;
		this.brkduration = brkduration;
		this.ledlength = ledlength;
		this.ledheight = ledheight;
		this.ledsqure = ledsqure;
		this.ledresolution = ledresolution;
		this.ledtype = ledtype;
		this.publishprice = publishprice;
		this.province = province;
		this.city = city;
		this.district = district;
		this.modtime = modtime;
		this.state = state;
		this.orders = orders;
	}

	// Property accessors

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getLedsn() {
		return this.ledsn;
	}

	public void setLedsn(String ledsn) {
		this.ledsn = ledsn;
	}

	public String getCode() {
		return this.code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getLocation() {
		return this.location;
	}

	public void setLocation(String location) {
		this.location = location;
	}

	public Integer getAvlduration() {
		return this.avlduration;
	}

	public void setAvlduration(Integer avlduration) {
		this.avlduration = avlduration;
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

	public Time getBrkstart() {
		return this.brkstart;
	}

	public void setBrkstart(Time brkstart) {
		this.brkstart = brkstart;
	}

	public Time getBrkend() {
		return this.brkend;
	}

	public void setBrkend(Time brkend) {
		this.brkend = brkend;
	}

	public Integer getBrkduration() {
		return this.brkduration;
	}

	public void setBrkduration(Integer brkduration) {
		this.brkduration = brkduration;
	}

	public Float getLedlength() {
		return this.ledlength;
	}

	public void setLedlength(Float ledlength) {
		this.ledlength = ledlength;
	}

	public Float getLedheight() {
		return this.ledheight;
	}

	public void setLedheight(Float ledheight) {
		this.ledheight = ledheight;
	}

	public Float getLedsqure() {
		return this.ledsqure;
	}

	public void setLedsqure(Float ledsqure) {
		this.ledsqure = ledsqure;
	}

	public String getLedresolution() {
		return this.ledresolution;
	}

	public void setLedresolution(String ledresolution) {
		this.ledresolution = ledresolution;
	}

	public String getLedtype() {
		return this.ledtype;
	}

	public void setLedtype(String ledtype) {
		this.ledtype = ledtype;
	}

	public Integer getPublishprice() {
		return this.publishprice;
	}

	public void setPublishprice(Integer publishprice) {
		this.publishprice = publishprice;
	}

	public String getProvince() {
		return this.province;
	}

	public void setProvince(String province) {
		this.province = province;
	}

	public String getCity() {
		return this.city;
	}

	public void setCity(String city) {
		this.city = city;
	}

	public String getDistrict() {
		return this.district;
	}

	public void setDistrict(String district) {
		this.district = district;
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

	public Set getOrders() {
		return this.orders;
	}

	public void setOrders(Set orders) {
		this.orders = orders;
	}

}