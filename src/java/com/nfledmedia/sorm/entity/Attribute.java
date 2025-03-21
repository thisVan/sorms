package com.nfledmedia.sorm.entity;

import java.sql.Timestamp;
import java.util.HashSet;
import java.util.Set;

/**
 * Attribute entity. @author MyEclipse Persistence Tools
 */

public class Attribute implements java.io.Serializable {

	// Fields

	private static final long serialVersionUID = 1L;
	private Short id;
	private String attributename;
	private String attributedesc;
	private Timestamp modifytime;
	private Set orders = new HashSet(0);

	// Constructors

	/** default constructor */
	public Attribute() {
	}

	/** minimal constructor */
	public Attribute(Short id, String arrtibutename) {
		this.id = id;
		this.attributename = arrtibutename;
	}

	/** full constructor */
	public Attribute(Short id, String arrtibutename, String attributedesc,
			Timestamp modifytime, Set orders) {
		this.id = id;
		this.attributename = arrtibutename;
		this.attributedesc = attributedesc;
		this.modifytime = modifytime;
		this.orders = orders;
	}

	// Property accessors

	public Short getId() {
		return this.id;
	}

	public void setId(Short id) {
		this.id = id;
	}

	public String getAttributename() {
		return attributename;
	}

	public void setAttributename(String attributename) {
		this.attributename = attributename;
	}

	public String getAttributedesc() {
		return this.attributedesc;
	}

	public void setAttributedesc(String attributedesc) {
		this.attributedesc = attributedesc;
	}

	public Timestamp getModifytime() {
		return this.modifytime;
	}

	public void setModifytime(Timestamp modifytime) {
		this.modifytime = modifytime;
	}

	public Set getOrders() {
		return this.orders;
	}

	public void setOrders(Set orders) {
		this.orders = orders;
	}


}