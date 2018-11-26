package com.nfledmedia.sorm.service;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.Entity;
import javax.persistence.ManyToOne;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.nfledmedia.sorm.dao.RoleDAO;
import com.nfledmedia.sorm.dao.UserDAO;
import com.nfledmedia.sorm.entity.User;

/**
 * 项目名称：sorm 类全名:com.nfledmedia.sorm.service.UserService 类描述：
 * 创建人：Van@nfledmedia 创建时间：2016年6月13日 下午1:11:08 修改备注：
 * 
 * @version jdk1.7
 * 
 * Copyright (c) 2016, bolven@qq.com All Rights Reserved.
 */
@Transactional
@Service
public class UserService {

	// 注入userDao
	@Autowired
	private UserDAO userDAO;
	@Autowired
	private RoleDAO roleDAO;

	/**
	 * 
	 * usersLogin: 实现用户的登录验证的具体方法 TODO (这里描述这个方法适用条件 – 可选).
	 * 
	 * @author Wu. Van
	 * @param user
	 * @return
	 * @since JDK 1.6
	 */
	@SuppressWarnings("unchecked")
	public boolean usersLogin(User user) {
		userDAO.getHibernateTemplate();
		List<User> list = new ArrayList<User>();
		System.out.println(user.getUsername());
		try {
			list = userDAO.findByUsername(user.getUsername());
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}

		if (list.size() > 0 && loginCheck(list, user)) {
			System.out.println("yes，login successfully");
			return true;

		} else {
			System.out.println("no， login failed");
			return false;
		}
	}
	
	public User chkAndBackPojo(User u){
		User user = null;
		List<User> list = new ArrayList<User>();
		System.out.println(u.getUsername());
		try {
			list = userDAO.findByUsername(u.getUsername());
		} catch (Exception e) {
			e.printStackTrace();
		}
		if(list.size() > 0){
			for (User user2 : list) {
				if(loginCheck(list, u)){
					user = user2;
					break;
				}
			}
		}
		return user;
	}
	

	private boolean loginCheck(List<User> list, User user) {

		for (int i = 0; i < list.size(); i++) {
			if (list.get(i).getUsername().equals(user.getUsername())
					&& list.get(i).getPassword().equals(user.getPassword())) {
				return true;
			}
		}
		return false;
	}

	public List getAllRole() {
		// TODO Auto-generated method stub
		return roleDAO.findAll();
	}

	public User getUserById(Integer integer) {
		// TODO Auto-generated method stub
		return userDAO.findById(integer);
	}

	public List loadUserByUsername(String username) {
		// TODO Auto-generated method stub
		return userDAO.findByUsername(username);
	}
	
	public boolean saveUser(User user) {
		boolean state = false;
		try {
			userDAO.save(user);
			state = true;
		} catch (RuntimeException re) {
			throw re;			
		} finally {
			return state;
		}
		
	}

}
