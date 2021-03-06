package com.nfledmedia.sorm.dao;

import java.util.List;

import org.hibernate.LockMode;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.ApplicationContext;
import org.springframework.orm.hibernate5.support.HibernateDaoSupport;
import org.springframework.stereotype.Repository;

import com.nfledmedia.sorm.entity.AdcontractHistory;


/**
 * A data access object (DAO) providing persistence and search support for
 * AdcontractHistory entities. Transaction control of the save(), update() and delete()
 * operations can directly support Spring container-managed transactions or they
 * can be augmented to handle user-managed Spring transactions. Each of these
 * methods provides additional information for how to configure it for the
 * desired type of transaction control.
 * 
 * @see com.nfledmedia.sorm.entity.AdcontractHistory
 * @author MyEclipse Persistence Tools
 */
@Repository
public class AdcontractHistoryDAO extends HibernateDaoSupport {
	private static final Logger log = LoggerFactory.getLogger(AdcontractDAO.class);
	// property constants
	public static final String SN = "sn";
	public static final String CLIENT = "client";
	public static final String AGENCY = "agency";
	public static final String REMARK = "remark";
	public static final String STATE = "state";

	protected void initDao() {
		// do nothing
	}

	public void save(AdcontractHistory transientInstance) {
		log.debug("saving AdcontractHistory instance");
		try {
			getHibernateTemplate().save(transientInstance);
			log.debug("save successful");
		} catch (RuntimeException re) {
			log.error("save failed", re);
			throw re;
		}
	}

	public void delete(AdcontractHistory persistentInstance) {
		log.debug("deleting AdcontractHistory instance");
		try {
			getHibernateTemplate().delete(persistentInstance);
			log.debug("delete successful");
		} catch (RuntimeException re) {
			log.error("delete failed", re);
			throw re;
		}
	}

	public AdcontractHistory findById(java.lang.Integer id) {
		log.debug("getting AdcontractHistory instance with id: " + id);
		try {
			AdcontractHistory instance = (AdcontractHistory) getHibernateTemplate().get("com.nfledmedia.sorm.entity.AdcontractHistory", id);
			return instance;
		} catch (RuntimeException re) {
			log.error("get failed", re);
			throw re;
		}
	}

	public List findByExample(AdcontractHistory instance) {
		log.debug("finding AdcontractHistory instance by example");
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
		log.debug("finding AdcontractHistory instance with property: " + propertyName + ", value: " + value);
		try {
			String queryString = "from AdcontractHistory as model where model." + propertyName + "= ?";
			return getHibernateTemplate().find(queryString, value);
		} catch (RuntimeException re) {
			log.error("find by property name failed", re);
			throw re;
		}
	}

	public List findBySn(Object sn) {
		return findByProperty(SN, sn);
	}

	public List findByClient(Object client) {
		return findByProperty(CLIENT, client);
	}

	public List findByAgency(Object agency) {
		return findByProperty(AGENCY, agency);
	}

	public List findByRemark(Object remark) {
		return findByProperty(REMARK, remark);
	}

	public List findByState(Object state) {
		return findByProperty(STATE, state);
	}

	public List findAll() {
		log.debug("finding all AdcontractHistory instances");
		try {
			String queryString = "from AdcontractHistory";
			return getHibernateTemplate().find(queryString);
		} catch (RuntimeException re) {
			log.error("find all failed", re);
			throw re;
		}
	}

	public AdcontractHistory merge(AdcontractHistory detachedInstance) {
		log.debug("merging AdcontractHistory instance");
		try {
			AdcontractHistory result = (AdcontractHistory) getHibernateTemplate().merge(detachedInstance);
			log.debug("merge successful");
			return result;
		} catch (RuntimeException re) {
			log.error("merge failed", re);
			throw re;
		}
	}

	public void attachDirty(AdcontractHistory instance) {
		log.debug("attaching dirty AdcontractHistory instance");
		try {
			getHibernateTemplate().saveOrUpdate(instance);
			log.debug("attach successful");
		} catch (RuntimeException re) {
			log.error("attach failed", re);
			throw re;
		}
	}

	public void attachClean(AdcontractHistory instance) {
		log.debug("attaching clean AdcontractHistory instance");
		try {
			getHibernateTemplate().lock(instance, LockMode.NONE);
			log.debug("attach successful");
		} catch (RuntimeException re) {
			log.error("attach failed", re);
			throw re;
		}
	}

	public static AdcontractDAO getFromApplicationContext(ApplicationContext ctx) {
		return (AdcontractDAO) ctx.getBean("adcontractDAO");
	}
	
	public List<AdcontractHistory> findLikeKeyword(String propertyName, Object value) {
		log.debug("finding AdcontractHistory instance with property: " + propertyName + ", value: " + value);
		String queryString = "from AdcontractHistory as model where model." + propertyName + " like :keyword";		
		List<AdcontractHistory> list = currentSession().createQuery(queryString).setParameter("keyword", "%"+value+"%").list();
		
		return list;
		    
	}
}
