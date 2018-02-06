package com.nfledmedia.sorm.entity;

import java.sql.Timestamp;

/**
 * Playstrategy entity. @author MyEclipse Persistence Tools
 */

public class Playstrategy implements java.io.Serializable {

	// Fields

	private Short id;
	private String strategyname;
	private String strategydesc;
	private Timestamp datetime;

	// Constructors

	/** default constructor */
	public Playstrategy() {
	}

	/** minimal constructor */
	public Playstrategy(String strategyname) {
		this.strategyname = strategyname;
	}

	/** full constructor */
	public Playstrategy(String strategyname, String strategydesc, Timestamp datetime) {
		this.strategyname = strategyname;
		this.strategydesc = strategydesc;
		this.datetime = datetime;
	}

	// Property accessors

	public Short getId() {
		return this.id;
	}

	public void setId(Short id) {
		this.id = id;
	}

	public String getStrategyname() {
		return this.strategyname;
	}

	public void setStrategyname(String strategyname) {
		this.strategyname = strategyname;
	}

	public String getStrategydesc() {
		return this.strategydesc;
	}

	public void setStrategydesc(String strategydesc) {
		this.strategydesc = strategydesc;
	}

	public Timestamp getDatetime() {
		return this.datetime;
	}

	public void setDatetime(Timestamp datetime) {
		this.datetime = datetime;
	}

	@Override
	public String toString() {
		return "Playstrategy [id=" + id + ", strategyname=" + strategyname + ", strategydesc=" + strategydesc + ", datetime=" + datetime
				+ "]";
	}
	
	
}