package com.nfledmedia.sorm.entity;

import java.util.HashSet;
import java.util.Set;

/**
 * Operatetype entity. @author MyEclipse Persistence Tools
 */

public class Operatetype implements java.io.Serializable {

	// Fields

	private Short id;
	private String operatetype;
	private String description;
	private Set orderHistories = new HashSet(0);

	// Constructors

	/** default constructor */
	public Operatetype() {
	}

	/** minimal constructor */
	public Operatetype(Short id) {
		this.id = id;
	}

	/** full constructor */
	public Operatetype(Short id, String operatetype, String description, Set orderHistories) {
		this.id = id;
		this.operatetype = operatetype;
		this.description = description;
		this.orderHistories = orderHistories;
	}

	// Property accessors

	public Short getId() {
		return this.id;
	}

	public void setId(Short id) {
		this.id = id;
	}

	public String getOperatetype() {
		return this.operatetype;
	}

	public void setOperatetype(String operatetype) {
		this.operatetype = operatetype;
	}

	public String getDescription() {
		return this.description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public Set getOrderHistories() {
		return this.orderHistories;
	}

	public void setOrderHistories(Set orderHistories) {
		this.orderHistories = orderHistories;
	}

}