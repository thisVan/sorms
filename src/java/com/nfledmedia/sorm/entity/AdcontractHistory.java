package com.nfledmedia.sorm.entity;

import java.sql.Timestamp;
import java.util.Date;

/**
 * AdcontractHistory entity. @author MyEclipse Persistence Tools
 */

public class AdcontractHistory implements java.io.Serializable {

	// Fields

	private Integer id;
	private Clienttype clienttype;
	private Channel channel;
	private String sn;
	private Date date;
	private String client;
	private String agency;
	private String remark;
	private Timestamp createtime;
	private String state;
	private Timestamp lastModifytime;
	private String placer;
	private Timestamp modifiedtime;
	private String operater;
	private Short operateType;

	// Constructors

	/** default constructor */
	public AdcontractHistory() {
	}

	/** minimal constructor */
	public AdcontractHistory(Timestamp modifiedtime, String operater, Short operateType) {
		this.modifiedtime = modifiedtime;
		this.operater = operater;
		this.operateType = operateType;
	}

	/** full constructor */
	public AdcontractHistory(Clienttype clienttype, Channel channel, String sn, Date date, String client, String agency, String remark,
			Timestamp createtime, String state, Timestamp lastModifytime, String placer, Timestamp modifiedtime, String operater,
			Short operateType) {
		this.clienttype = clienttype;
		this.channel = channel;
		this.sn = sn;
		this.date = date;
		this.client = client;
		this.agency = agency;
		this.remark = remark;
		this.createtime = createtime;
		this.state = state;
		this.lastModifytime = lastModifytime;
		this.placer = placer;
		this.modifiedtime = modifiedtime;
		this.operater = operater;
		this.operateType = operateType;
	}

	// Property accessors

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Clienttype getClienttype() {
		return this.clienttype;
	}

	public void setClienttype(Clienttype clienttype) {
		this.clienttype = clienttype;
	}

	public Channel getChannel() {
		return this.channel;
	}

	public void setChannel(Channel channel) {
		this.channel = channel;
	}

	public String getSn() {
		return this.sn;
	}

	public void setSn(String sn) {
		this.sn = sn;
	}

	public Date getDate() {
		return this.date;
	}

	public void setDate(Date date) {
		this.date = date;
	}

	public String getClient() {
		return this.client;
	}

	public void setClient(String client) {
		this.client = client;
	}

	public String getAgency() {
		return this.agency;
	}

	public void setAgency(String agency) {
		this.agency = agency;
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

	public String getState() {
		return this.state;
	}

	public void setState(String state) {
		this.state = state;
	}

	public Timestamp getLastModifytime() {
		return this.lastModifytime;
	}

	public void setLastModifytime(Timestamp lastModifytime) {
		this.lastModifytime = lastModifytime;
	}

	public String getPlacer() {
		return this.placer;
	}

	public void setPlacer(String placer) {
		this.placer = placer;
	}

	public Timestamp getModifiedtime() {
		return this.modifiedtime;
	}

	public void setModifiedtime(Timestamp modifiedtime) {
		this.modifiedtime = modifiedtime;
	}

	public String getOperater() {
		return this.operater;
	}

	public void setOperater(String operater) {
		this.operater = operater;
	}

	public Short getOperateType() {
		return this.operateType;
	}

	public void setOperateType(Short operateType) {
		this.operateType = operateType;
	}

}