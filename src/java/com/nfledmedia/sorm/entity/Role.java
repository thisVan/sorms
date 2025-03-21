package com.nfledmedia.sorm.entity;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

/**
 * Role entity. @author MyEclipse Persistence Tools
 */

public class Role implements java.io.Serializable {

	// Fields

	private static final long serialVersionUID = 1L;
	private Short id;
	private Long competence;
	private String name;
	private Set users = new HashSet(0);
	private List roleResources = new ArrayList();

	// Constructors

	/** default constructor */
	public Role() {
	}

	/** minimal constructor */
	public Role(Long competence, String name) {
		this.competence = competence;
		this.name = name;
	}

	/** full constructor */
	public Role(Long competence, String name, Set users, List roleResources) {
		this.competence = competence;
		this.name = name;
		this.users = users;
		this.roleResources = roleResources;
	}

	// Property accessors

	public Short getId() {
		return this.id;
	}

	public void setId(Short id) {
		this.id = id;
	}

	public Long getCompetence() {
		return this.competence;
	}

	public void setCompetence(Long competence) {
		this.competence = competence;
	}

	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Set getUsers() {
		return this.users;
	}

	public void setUsers(Set users) {
		this.users = users;
	}

	public List getRoleResources() {
		return this.roleResources;
	}

	public void setRoleResources(List roleResources) {
		this.roleResources = roleResources;
	}

}