package com.nfledmedia.sorm.entity;

/**
 * RoleResource entity. @author MyEclipse Persistence Tools
 */

public class RoleResource implements java.io.Serializable {

	// Fields

	private RoleResourceId id;
	private Resource resource;

	// Constructors

	/** default constructor */
	public RoleResource() {
	}

	/** full constructor */
	public RoleResource(RoleResourceId id, Resource resource) {
		this.id = id;
		this.resource = resource;
	}

	// Property accessors

	public RoleResourceId getId() {
		return this.id;
	}

	public void setId(RoleResourceId id) {
		this.id = id;
	}

	public Resource getResource() {
		return this.resource;
	}

	public void setResource(Resource resource) {
		this.resource = resource;
	}

}