package com.nfledmedia.sorm.service;

import java.util.List;

import javax.persistence.Entity;
import javax.persistence.ManyToOne;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.nfledmedia.sorm.dao.RoleDAO;

@Entity
@Transactional
@Service("roleService")
public class RoleService {
	/**
	 * @author rthtr
	 */
	@ManyToOne
	private RoleDAO roleDAO;

	public List getAllRoles() {
		return roleDAO.findAll();
	}

	public void setRoleDAO(RoleDAO roleDAO) {
		this.roleDAO = roleDAO;
	}

}
