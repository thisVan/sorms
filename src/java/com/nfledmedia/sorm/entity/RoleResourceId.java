package com.nfledmedia.sorm.entity;

/**
 * RoleResourceId entity. @author MyEclipse Persistence Tools
 */

public class RoleResourceId implements java.io.Serializable {

	// Fields

	private static final long serialVersionUID = 1L;
	private Role role;
	private Integer position;

	// Constructors

	/** default constructor */
	public RoleResourceId() {
	}

	/** full constructor */
	public RoleResourceId(Role role, Integer position) {
		this.role = role;
		this.position = position;
	}

	// Property accessors

	public Role getRole() {
		return this.role;
	}

	public void setRole(Role role) {
		this.role = role;
	}

	public Integer getPosition() {
		return this.position;
	}

	public void setPosition(Integer position) {
		this.position = position;
	}

	public boolean equals(Object other) {
		if ((this == other))
			return true;
		if ((other == null))
			return false;
		if (!(other instanceof RoleResourceId))
			return false;
		RoleResourceId castOther = (RoleResourceId) other;

		return ((this.getRole() == castOther.getRole()) || (this.getRole() != null
				&& castOther.getRole() != null && this.getRole().equals(
				castOther.getRole())))
				&& ((this.getPosition() == castOther.getPosition()) || (this
						.getPosition() != null
						&& castOther.getPosition() != null && this
						.getPosition().equals(castOther.getPosition())));
	}

	public int hashCode() {
		int result = 17;

		result = 37 * result
				+ (getRole() == null ? 0 : this.getRole().hashCode());
		result = 37 * result
				+ (getPosition() == null ? 0 : this.getPosition().hashCode());
		return result;
	}

}