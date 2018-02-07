package com.nfledmedia.sorm.service;

import java.util.List;

import javax.persistence.Entity;
import javax.persistence.ManyToOne;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.nfledmedia.sorm.dao.RoleDAO;

@Transactional
@Service
public class RoleService {
	/**
	 * @author rthtr
	 */
	@Autowired
	private RoleDAO roleDAO;

}
