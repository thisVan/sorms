package com.nfledmedia.sorm.service;

import java.util.List;

import javax.persistence.Entity;
import javax.persistence.ManyToOne;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.nfledmedia.sorm.dao.ResourceDAO;

@Entity
@Transactional
@Service("resourceService")
public class ResourceService {
	/**
	 * @author rthtr
	 */
	@ManyToOne
	private ResourceDAO resourceDAO;

	public List getAllResource() {
		return resourceDAO.findAll();
	}

	public ResourceDAO getResourceDAO() {
		return resourceDAO;
	}

	public void setResourceDAO(ResourceDAO resourceDAO) {
		this.resourceDAO = resourceDAO;
	}

}
