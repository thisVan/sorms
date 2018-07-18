package com.nfledmedia.sorm.entity;

/**
 * Publishstyle entity. @author MyEclipse Persistence Tools
 */

public class Publishstyle implements java.io.Serializable {

	// Fields

	private Short id;
	private String name;
	private String desc;

	// Constructors

	/** default constructor */
	public Publishstyle() {
	}

	/** minimal constructor */
	public Publishstyle(Short id, String name) {
		this.id = id;
		this.name = name;
	}

	/** full constructor */
	public Publishstyle(Short id, String name, String desc) {
		this.id = id;
		this.name = name;
		this.desc = desc;
	}

	// Property accessors

	public Short getId() {
		return this.id;
	}

	public void setId(Short id) {
		this.id = id;
	}

	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getDesc() {
		return this.desc;
	}

	public void setDesc(String desc) {
		this.desc = desc;
	}

	@Override
	public String toString() {
		return "Publishstyle [id=" + id + ", name=" + name + ", desc=" + desc + "]";
	}

}