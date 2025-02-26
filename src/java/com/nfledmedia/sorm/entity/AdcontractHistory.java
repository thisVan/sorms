package com.nfledmedia.sorm.entity;

import java.sql.Timestamp;
import java.util.Date;

/**
 * AdcontractHistory entity. @author MyEclipse Persistence Tools
 */

public class AdcontractHistory implements java.io.Serializable {

	// Fields

	private static final long serialVersionUID = 1L;
	private Integer sid;
	private Clienttype clienttype;
	private Operatetype operatetype;
	private Channel channel;
	private Integer id;
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
	private String amount;
	private String operater;

	// Constructors

	/** default constructor */
	public AdcontractHistory() {
	}

	/** minimal constructor */
	public AdcontractHistory(Operatetype operatetype, Timestamp modifiedtime, String operater) {
		this.operatetype = operatetype;
		this.modifiedtime = modifiedtime;
		this.operater = operater;
	}

	/** full constructor */
	public AdcontractHistory(Clienttype clienttype, Operatetype operatetype, Channel channel, Integer id, String sn, Date date,
			String client, String agency, String remark, Timestamp createtime, String state, Timestamp lastModifytime, String placer,
			Timestamp modifiedtime,String amount, String operater) {
		this.clienttype = clienttype;
		this.operatetype = operatetype;
		this.channel = channel;
		this.id = id;
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
		this.amount = amount;
		this.operater = operater;
	}

	// Property accessors

	public Integer getSid() {
		return this.sid;
	}

	public void setSid(Integer sid) {
		this.sid = sid;
	}

	public Clienttype getClienttype() {
		return this.clienttype;
	}

	public void setClienttype(Clienttype clienttype) {
		this.clienttype = clienttype;
	}

	public Operatetype getOperatetype() {
		return this.operatetype;
	}

	public void setOperatetype(Operatetype operatetype) {
		this.operatetype = operatetype;
	}

	public Channel getChannel() {
		return this.channel;
	}

	public void setChannel(Channel channel) {
		this.channel = channel;
	}

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
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

	public String getAmount() {
		return amount;
	}

	public void setAmount(String amount) {
		this.amount = amount;
	}

	public String getOperater() {
		return this.operater;
	}

	public void setOperater(String operater) {
		this.operater = operater;
	}

	@Override
	public String toString() {
		return "AdcontractHistory [sid=" + sid + ", clienttype=" + clienttype.getCtypedesc() + ", operatetype=" + operatetype.getOperatetype() + ", channel=" + channel.getChannelname()
				+ ", id=" + id + ", sn=" + sn + ", date=" + date + ", client=" + client + ", agency=" + agency + ", remark=" + remark
				+ ", createtime=" + createtime + ", state=" + state + ", lastModifytime=" + lastModifytime + ", placer=" + placer
				+ ", modifiedtime=" + modifiedtime + ", amount=" + amount + ", operater=" + operater + "]";
	}
	
	
}