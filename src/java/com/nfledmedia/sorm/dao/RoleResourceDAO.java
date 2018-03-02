package com.nfledmedia.sorm.dao;

import java.util.List;

import org.hibernate.LockMode;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.ApplicationContext;
import org.springframework.orm.hibernate4.support.HibernateDaoSupport;
import org.springframework.stereotype.Repository;

import com.nfledmedia.sorm.entity.RoleResource;

/**
 * A data access object (DAO) providing persistence and search support for
 * RoleResource entities. Transaction control of the save(), update() and
 * delete() operations can directly support Spring container-managed
 * transactions or they can be augmented to handle user-managed Spring
 * transactions. Each of these methods provides additional information for how
 * to configure it for the desired type of transaction control.
 * 
 * @see com.nfledmedia.sorm.entity.RoleResource
 * @author MyEclipse Persistence Tools
 */
@Repository
public class RoleResourceDAO extends HibernateDaoSupport {
	private static final Logger log = LoggerFactory.getLogger(RoleResourceDAO.class);

	// property constants

	protected void initDao() {
		// do nothing
	}

	public void save(RoleResource transientInstance) {
		log.debug("saving RoleResource instance");
		try {
			getHibernateTemplate().save(transientInstance);
			log.debug("save successful");
		} catch (RuntimeException re) {
			log.error("save failed", re);
			throw re;
		}
	}

	public void delete(RoleResource persistentInstance) {
		log.debug("deleting RoleResource instance");
		try {
			getHibernateTemplate().delete(persistentInstance);
			log.debug("delete successful");
		} catch (RuntimeException re) {
			log.error("delete failed", re);
			throw re;
		}
	}

	public RoleResource findById(com.nfledmedia.sorm.entity.RoleResourceId id) {
		log.debug("getting RoleResource instance with id: " + id);
		try {
			RoleResource instance = (RoleResource) getHibernateTemplate().get("com.nfledmedia.sorm.entity.RoleResource", id);
			return instance;
		} catch (RuntimeException re) {
			log.error("get failed", re);
			throw re;
		}
	}

	public List findByExample(RoleResource instance) {
		log.debug("finding RoleResource instance by example");
		try {
			List results = getHibernateTemplate().findByExample(instance);
			log.debug("find by example successful, result size: " + results.size());
			return results;
		} catch (RuntimeException re) {
			log.error("find by example failed", re);
			throw re;
		}
	}

	public List findByProperty(String propertyName, Object value) {
		log.debug("finding RoleResource instance with property: " + propertyName + ", value: " + value);
		try {
			String queryString = "from RoleResource as model where model." + propertyName + "= ?";
			return getHibernateTemplate().find(queryString, value);
		} catch (RuntimeException re) {
			log.error("find by property name failed", re);
			throw re;
		}
	}

	public List findAll() {
		log.debug("finding all RoleResource instances");
		try {
			String queryString = "from RoleResource";
			return getHibernateTemplate().find(queryString);
		} catch (RuntimeException re) {
			log.error("find all failed", re);
			throw re;
		}
	}

	public RoleResource merge(RoleResource detachedInstance) {
		log.debug("merging RoleResource instance");
		try {
			RoleResource result = (RoleResource) getHibernateTemplate().merge(detachedInstance);
			log.debug("merge successful");
			return result;
		} catch (RuntimeException re) {
			log.error("merge failed", re);
			throw re;
		}
	}

	public void attachDirty(RoleResource instance) {
		log.debug("attaching dirty RoleResource instance");
		try {
			getHibernateTemplate().saveOrUpdate(instance);
			log.debug("attach successful");
		} catch (RuntimeException re) {
			log.error("attach failed", re);
			throw re;
		}
	}

	public void attachClean(RoleResource instance) {
		log.debug("attaching clean RoleResource instance");
		try {
			getHibernateTemplate().lock(instance, LockMode.NONE);
			log.debug("attach successful");
		} catch (RuntimeException re) {
			log.error("attach failed", re);
			throw re;
		}
	}

	public static RoleResourceDAO getFromApplicationContext(ApplicationContext ctx) {
		return (RoleResourceDAO) ctx.getBean("roleResourceDAO");
	}
}