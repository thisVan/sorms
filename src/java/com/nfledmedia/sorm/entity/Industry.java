package com.nfledmedia.sorm.entity;

import java.util.HashSet;
import java.util.Set;

/**
 * Industry entity. @author MyEclipse Persistence Tools
 */

public class Industry implements java.io.Serializable {

	// Fields

	private Short industryid;
	private String industryname;
	private Set orders = new HashSet(0);

	// Constructors

	/** default constructor */
	public Industry() {
	}

	/** minimal constructor */
	public Industry(Short industryid, String industryname) {
		this.industryid = industryid;
		this.industryname = industryname;
	}

	/** full constructor */
	public Industry(Short industryid, String industryname, Set orders) {
		this.industryid = industryid;
		this.industryname = industryname;
		this.orders = orders;
	}

	// Property accessors

	public Short getIndustryid() {
		return this.industryid;
	}

	public void setIndustryid(Short industryid) {
		this.industryid = industryid;
	}

	public String getIndustryname() {
		return this.industryname;
	}

	public void setIndustryname(String industryname) {
		this.industryname = industryname;
	}

	public Set getOrders() {
		return this.orders;
	}

	public void setOrders(Set orders) {
		this.orders = orders;
	}

}