package com.nfledmedia.sorm.service;

import java.util.List;

import javax.persistence.Entity;
import javax.persistence.ManyToOne;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.nfledmedia.sorm.dao.ResourceDAO;

@Transactional
@Service
public class ResourceService {
	/**
	 * @author rthtr
	 */
	@Autowired
	private ResourceDAO resourceDAO;

	public List getAllResource() {
		return resourceDAO.findAll();
	}

}
