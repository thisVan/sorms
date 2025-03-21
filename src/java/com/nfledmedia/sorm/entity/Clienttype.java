package com.nfledmedia.sorm.entity;

import java.util.HashSet;
import java.util.Set;

/**
 * Clienttype entity. @author MyEclipse Persistence Tools
 */

public class Clienttype implements java.io.Serializable {

	// Fields

	private static final long serialVersionUID = 1L;
	private Short id;
	private String ctypedesc;
	private Set adcontracts = new HashSet(0);

	// Constructors

	/** default constructor */
	public Clienttype() {
	}

	/** minimal constructor */
	public Clienttype(Short id, String ctypedesc) {
		this.id = id;
		this.ctypedesc = ctypedesc;
	}

	/** full constructor */
	public Clienttype(Short id, String ctypedesc, Set adcontracts) {
		this.id = id;
		this.ctypedesc = ctypedesc;
		this.adcontracts = adcontracts;
	}

	// Property accessors

	public Short getId() {
		return this.id;
	}

	public void setId(Short id) {
		this.id = id;
	}

	public String getCtypedesc() {
		return this.ctypedesc;
	}

	public void setCtypedesc(String ctypedesc) {
		this.ctypedesc = ctypedesc;
	}

	public Set getAdcontracts() {
		return this.adcontracts;
	}

	public void setAdcontracts(Set adcontracts) {
		this.adcontracts = adcontracts;
	}

}