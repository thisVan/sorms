package com.nfledmedia.sorm.entity;

import java.sql.Timestamp;

/**
 * Operevent entity. @author MyEclipse Persistence Tools
 */

public class Operevent implements java.io.Serializable {

	// Fields

	private static final long serialVersionUID = 1L;
	private Integer id;
	private Operatetype operatetype;
	private Integer orderId;
	private Timestamp time;
	private String operater;
	private String remark;
	private Integer originorder;

	// Constructors

	/** default constructor */
	public Operevent() {
	}

	/** minimal constructor */
	public Operevent(Integer id) {
		this.id = id;
	}

	/** full constructor */
	public Operevent(Integer id, Operatetype operatetype, Integer orderId, Timestamp time, String operater, String remark,
			Integer originorder) {
		this.id = id;
		this.operatetype = operatetype;
		this.orderId = orderId;
		this.time = time;
		this.operater = operater;
		this.remark = remark;
		this.originorder = originorder;
	}

	// Property accessors

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

	public Integer getOrderId() {
		return this.orderId;
	}

	public void setOrderId(Integer orderId) {
		this.orderId = orderId;
	}

	public Timestamp getTime() {
		return this.time;
	}

	public void setTime(Timestamp time) {
		this.time = time;
	}

	public String getOperater() {
		return this.operater;
	}

	public void setOperater(String operater) {
		this.operater = operater;
	}

	public String getRemark() {
		return this.remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public Integer getOriginorder() {
		return this.originorder;
	}

	public void setOriginorder(Integer originorder) {
		this.originorder = originorder;
	}

	@Override
	public String toString() {
		return "Operevent [id=" + id + ", operatetype=" + operatetype.getOperatetype() + ", orderId=" + orderId + ", time=" + time + ", operater=" + operater
				+ ", remark=" + remark + ", originorder=" + originorder + "]";
	}

	
}