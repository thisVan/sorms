package com.nfledmedia.sorm.dao;

import java.util.List;

import org.hibernate.LockMode;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.ApplicationContext;
import org.springframework.orm.hibernate5.support.HibernateDaoSupport;
import org.springframework.stereotype.Repository;

import com.nfledmedia.sorm.entity.Publishstyle;

/**
 * A data access object (DAO) providing persistence and search support for
 * Publishstyle entities. Transaction control of the save(), update() and delete()
 * operations can directly support Spring container-managed transactions or they
 * can be augmented to handle user-managed Spring transactions. Each of these
 * methods provides additional information for how to configure it for the
 * desired type of transaction control.
 * 
 * @see com.nfledmedia.sorm.entity.Publishstyle
 * @author MyEclipse Persistence Tools
 */
@Repository
public class PublishstyleDAO extends HibernateDaoSupport {
	private static final Logger log = LoggerFactory.getLogger(PublishstyleDAO.class);
	// property constants

	protected void initDao() {
		// do nothing
	}

	public void save(Publishstyle transientInstance) {
		log.debug("saving Publishstyle instance");
		try {
			getHibernateTemplate().save(transientInstance);
			log.debug("save successful");
		} catch (RuntimeException re) {
			log.error("save failed", re);
			throw re;
		}
	}

	public void delete(Publishstyle persistentInstance) {
		log.debug("deleting Publishstyle instance");
		try {
			getHibernateTemplate().delete(persistentInstance);
			log.debug("delete successful");
		} catch (RuntimeException re) {
			log.error("delete failed", re);
			throw re;
		}
	}

	public Publishstyle findById(java.lang.Short id) {
		log.debug("getting Publishstyle instance with id: " + id);
		try {
			Publishstyle instance = (Publishstyle) getHibernateTemplate().get("com.nfledmedia.sorm.entity.Publishstyle", id);
			return instance;
		} catch (RuntimeException re) {
			log.error("get failed", re);
			throw re;
		}
	}

	public List findByExample(Publishstyle instance) {
		log.debug("finding Publishstyle instance by example");
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
		log.debug("finding Publishstyle instance with property: " + propertyName + ", value: " + value);
		try {
			String queryString = "from Publishstyle as model where model." + propertyName + "= ?";
			return getHibernateTemplate().find(queryString, value);
		} catch (RuntimeException re) {
			log.error("find by property name failed", re);
			throw re;
		}
	}

	public List findAll() {
		log.debug("finding all Publishstyle instances");
		try {
			String queryString = "from Publishstyle";
			return getHibernateTemplate().find(queryString);
		} catch (RuntimeException re) {
			log.error("find all failed", re);
			throw re;
		}
	}

	public Publishstyle merge(Publishstyle detachedInstance) {
		log.debug("merging Publishstyle instance");
		try {
			Publishstyle result = (Publishstyle) getHibernateTemplate().merge(detachedInstance);
			log.debug("merge successful");
			return result;
		} catch (RuntimeException re) {
			log.error("merge failed", re);
			throw re;
		}
	}

	public void attachDirty(Publishstyle instance) {
		log.debug("attaching dirty Publishstyle instance");
		try {
			getHibernateTemplate().saveOrUpdate(instance);
			log.debug("attach successful");
		} catch (RuntimeException re) {
			log.error("attach failed", re);
			throw re;
		}
	}

	public void attachClean(Publishstyle instance) {
		log.debug("attaching clean Publishstyle instance");
		try {
			getHibernateTemplate().lock(instance, LockMode.NONE);
			log.debug("attach successful");
		} catch (RuntimeException re) {
			log.error("attach failed", re);
			throw re;
		}
	}

	public static PublishstyleDAO getFromApplicationContext(ApplicationContext ctx) {
		return (PublishstyleDAO) ctx.getBean("PublishstyleDAO");
	}
}