package com.nfledmedia.sorm.entity;

/**
 * User entity. @author MyEclipse Persistence Tools
 */

public class User implements java.io.Serializable {

	// Fields

	private Integer id;
	private Role role;
	private String username;
	private String password;
	private String realname;
	private String state;

	// Constructors

	/** default constructor */
	public User() {
	}

	/** minimal constructor */
	public User(Role role, String username, String password, String state) {
		this.role = role;
		this.username = username;
		this.password = password;
		this.state = state;
	}

	/** full constructor */
	public User(Role role, String username, String password, String realname,
			String state) {
		this.role = role;
		this.username = username;
		this.password = password;
		this.realname = realname;
		this.state = state;
	}

	// Property accessors

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Role getRole() {
		return this.role;
	}

	public void setRole(Role role) {
		this.role = role;
	}

	public String getUsername() {
		return this.username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return this.password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getRealname() {
		return this.realname;
	}

	public void setRealname(String realname) {
		this.realname = realname;
	}

	public String getState() {
		return this.state;
	}

	public void setState(String state) {
		this.state = state;
	}

}