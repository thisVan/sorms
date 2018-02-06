package com.nfledmedia.sorm.entity;

import java.sql.Timestamp;

/**
 * Message entity. @author MyEclipse Persistence Tools
 */

public class Message implements java.io.Serializable {

	// Fields

	private Long id;
	private User recevier;
	private Timestamp time;
	private Integer hasRead;
	private String content;

	// Constructors

	/** default constructor */
	public Message() {
	}

	/** minimal constructor */
	public Message(User recevier, Timestamp time, Integer hasRead) {
		this.recevier = recevier;
		this.time = time;
		this.hasRead = hasRead;
	}

	/** full constructor */
	public Message(User recevier, Timestamp time, Integer hasRead,
			String content) {
		this.recevier = recevier;
		this.time = time;
		this.hasRead = hasRead;
		this.content = content;
	}

	// Property accessors

	public Long getId() {
		return this.id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public User getRecevier() {
		return recevier;
	}

	public void setRecevier(User recevier) {
		this.recevier = recevier;
	}

	public Timestamp getTime() {
		return this.time;
	}

	public void setTime(Timestamp time) {
		this.time = time;
	}

	public Integer getHasRead() {
		return this.hasRead;
	}

	public void setHasRead(Integer hasRead) {
		this.hasRead = hasRead;
	}

	public String getContent() {
		return this.content;
	}

	public void setContent(String content) {
		this.content = content;
	}

}