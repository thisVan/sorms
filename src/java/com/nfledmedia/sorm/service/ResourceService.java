package com.nfledmedia.sorm.service;

import java.util.List;

import javax.persistence.Entity;
import javax.persistence.ManyToOne;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.nfledmedia.sorm.dao.ResourceDAO;
import com.nfledmedia.sorm.dao.RoleResourceDAO;
import com.nfledmedia.sorm.entity.RoleResource;

@Transactional
@Service
public class ResourceService {
	/**
	 * @author rthtr
	 */
	@Autowired
	private ResourceDAO resourceDAO;
	
	@Autowired
	private RoleResourceDAO roleResourceDAO;

	public List getAllResource() {
		return resourceDAO.findAll();
	}
	
	/**
	 * 获取指定Role的资源列表
	 * @param roleId
	 * @return
	 */
	public List<RoleResource> getResourcesByRole(Short roleId) {
		return roleResourceDAO.findByProperty("id.role.id", roleId);
	}

}
