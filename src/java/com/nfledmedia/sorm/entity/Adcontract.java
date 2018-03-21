package com.nfledmedia.sorm.entity;

import java.sql.Timestamp;
import java.util.Date;
import java.util.HashSet;
import java.util.Set;

/**
 * Adcontract entity. @author MyEclipse Persistence Tools
 */

public class Adcontract implements java.io.Serializable {

	// Fields

	private Integer id;
	private Channel channel;
	private Clienttype clienttype;
	private String sn;
	private Date date;
	private String client;
	private String agency;
	private String placer;
	private String remark;
	private Timestamp createtime;
	private String state;
	private Timestamp lastModifytime;
	private Set orders = new HashSet(0);

	// Constructors

	/** default constructor */
	public Adcontract() {
	}

	/** minimal constructor */
	public Adcontract(Date date) {
		this.date = date;
	}

	/** full constructor */
	public Adcontract(Channel channel, Clienttype clienttype, String sn,
			Date date, String client, String agency, String placer, String remark,
			Timestamp createtime, String state, Timestamp lastModifytime,
			Set orders) {
		this.channel = channel;
		this.clienttype = clienttype;
		this.sn = sn;
		this.date = date;
		this.client = client;
		this.agency = agency;
		this.placer = placer;
		this.remark = remark;
		this.createtime = createtime;
		this.state = state;
		this.lastModifytime = lastModifytime;
		this.orders = orders;
	}

	// Property accessors

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Channel getChannel() {
		return this.channel;
	}

	public void setChannel(Channel channel) {
		this.channel = channel;
	}

	public Clienttype getClienttype() {
		return this.clienttype;
	}

	public void setClienttype(Clienttype clienttype) {
		this.clienttype = clienttype;
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

	public String getPlacer() {
		return placer;
	}

	public void setPlacer(String placer) {
		this.placer = placer;
	}

	public String getRemark() {
		return this.remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public Timestamp getCreatetime() {
		return createtime;
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

	public Set getOrders() {
		return this.orders;
	}

	public void setOrders(Set orders) {
		this.orders = orders;
	}
	
	@Override
	public String toString() {
		return "Adcontract [id=" + id + ", channel=" + channel.getChannelname() + ", clienttype=" + clienttype.getCtypedesc() + ", sn=" + sn + ", date=" + date
				+ ", client=" + client + ", agency=" + agency + ", placer=" + placer + ", remark=" + remark + ", createtime=" + createtime
				+ ", state=" + state + ", lastModifytime=" + lastModifytime + "]";
	}
	
	/**
	 * 比较adcontract修改时关键属性是否改变，是，则所有的order以及级联的publishdetail都要修改
	 * @param adcontract
	 * @return
	 */
	public boolean keyPropertiesModified(Adcontract adcontract) {
		// TODO Auto-generated method stub
		if (this.client.equals(adcontract.client) 
				|| this.agency.equals(adcontract.agency)
				|| this.clienttype.getId().equals(adcontract.clienttype.getId())
				|| this.channel.getId().equals(adcontract.channel.getId())
				|| adcontract.placer.equals(this.placer)) {
			return true;
		}

		return false;
	}
	
}