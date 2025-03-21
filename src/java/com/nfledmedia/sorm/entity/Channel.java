package com.nfledmedia.sorm.entity;

import java.sql.Timestamp;

/**
 * Channel entity. @author MyEclipse Persistence Tools
 */

public class Channel implements java.io.Serializable {

	// Fields

	private static final long serialVersionUID = 1L;
	private Integer id;
	private String channelname;
	private String channeldesc;
	private Timestamp modifiytime;

	// Constructors

	/** default constructor */
	public Channel() {
	}

	/** minimal constructor */
	public Channel(String channelname, String channeldesc) {
		this.channelname = channelname;
		this.channeldesc = channeldesc;
	}

	/** full constructor */
	public Channel(String channelname, String channeldesc, Timestamp modifiytime) {
		this.channelname = channelname;
		this.channeldesc = channeldesc;
		this.modifiytime = modifiytime;
	}

	// Property accessors

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getChannelname() {
		return this.channelname;
	}

	public void setChannelname(String channelname) {
		this.channelname = channelname;
	}

	public String getChanneldesc() {
		return this.channeldesc;
	}

	public void setChanneldesc(String channeldesc) {
		this.channeldesc = channeldesc;
	}

	public Timestamp getModifiytime() {
		return this.modifiytime;
	}

	public void setModifiytime(Timestamp modifiytime) {
		this.modifiytime = modifiytime;
	}

}