package com.nfledmedia.sorm.dao;

import java.util.List;

import org.hibernate.LockMode;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.ApplicationContext;
import org.springframework.orm.hibernate5.support.HibernateDaoSupport;

import com.nfledmedia.sorm.entity.Operatetype;

public class OperatetypeDAO extends HibernateDaoSupport {
	private static final Logger log = LoggerFactory.getLogger(OperatetypeDAO.class);
	// property constants
	public static final String DESCRIPTION = "description";

	protected void initDao() {
		// do nothing
	}

	public void save(Operatetype transientInstance) {
		log.debug("saving Operatetype instance");
		try {
			getHibernateTemplate().save(transientInstance);
			log.debug("save successful");
		} catch (RuntimeException re) {
			log.error("save failed", re);
			throw re;
		}
	}

	public void delete(Operatetype persistentInstance) {
		log.debug("deleting Operatetype instance");
		try {
			getHibernateTemplate().delete(persistentInstance);
			log.debug("delete successful");
		} catch (RuntimeException re) {
			log.error("delete failed", re);
			throw re;
		}
	}

	public Operatetype findById(java.lang.Short id) {
		log.debug("getting Operatetype instance with id: " + id);
		try {
			Operatetype instance = (Operatetype) getHibernateTemplate().get("com.nfledmedia.sorm.entity.Operatetype", id);
			return instance;
		} catch (RuntimeException re) {
			log.error("get failed", re);
			throw re;
		}
	}

	public List findByExample(Operatetype instance) {
		log.debug("finding Operatetype instance by example");
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
		log.debug("finding Operatetype instance with property: " + propertyName + ", value: " + value);
		try {
			String queryString = "from Operatetype as model where model." + propertyName + "= ?";
			return getHibernateTemplate().find(queryString, value);
		} catch (RuntimeException re) {
			log.error("find by property name failed", re);
			throw re;
		}
	}

	public List<?> findByDescription(Object description) {
		return findByProperty(DESCRIPTION, description);
	}

	public List<?> findAll() {
		log.debug("finding all Operatetype instances");
		try {
			String queryString = "from Operatetype";
			return getHibernateTemplate().find(queryString);
		} catch (RuntimeException re) {
			log.error("find all failed", re);
			throw re;
		}
	}

	public Operatetype merge(Operatetype detachedInstance) {
		log.debug("merging Operatetype instance");
		try {
			Operatetype result = (Operatetype) getHibernateTemplate().merge(detachedInstance);
			log.debug("merge successful");
			return result;
		} catch (RuntimeException re) {
			log.error("merge failed", re);
			throw re;
		}
	}

	public void attachDirty(Operatetype instance) {
		log.debug("attaching dirty Operatetype instance");
		try {
			getHibernateTemplate().saveOrUpdate(instance);
			log.debug("attach successful");
		} catch (RuntimeException re) {
			log.error("attach failed", re);
			throw re;
		}
	}

	public void attachClean(Operatetype instance) {
		log.debug("attaching clean Operatetype instance");
		try {
			getHibernateTemplate().lock(instance, LockMode.NONE);
			log.debug("attach successful");
		} catch (RuntimeException re) {
			log.error("attach failed", re);
			throw re;
		}
	}

	public static OperatetypeDAO getFromApplicationContext(ApplicationContext ctx) {
		return (OperatetypeDAO) ctx.getBean("operatetypeDAO");
	}
}
