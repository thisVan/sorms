package com.nfledmedia.sorm.dao;

import java.util.List;

import org.hibernate.LockMode;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.ApplicationContext;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import com.nfledmedia.sorm.entity.Adcontract;

/**
 * A data access object (DAO) providing persistence and search support for
 * Adcontract entities. Transaction control of the save(), update() and delete()
 * operations can directly support Spring container-managed transactions or they
 * can be augmented to handle user-managed Spring transactions. Each of these
 * methods provides additional information for how to configure it for the
 * desired type of transaction control.
 * 
 * @see com.nfledmedia.sorm.entity.Adcontract
 * @author MyEclipse Persistence Tools
 */
public class AdcontractDAO extends HibernateDaoSupport {
	private static final Logger log = LoggerFactory
			.getLogger(AdcontractDAO.class);
	// property constants
	public static final String SN = "sn";
	public static final String CLIENT = "client";
	public static final String AGENCY = "agency";
	public static final String REMARK = "remark";
	public static final String STATE = "state";

	protected void initDao() {
		// do nothing
	}

	public void save(Adcontract transientInstance) {
		log.debug("saving Adcontract instance");
		try {
			getHibernateTemplate().save(transientInstance);
			log.debug("save successful");
		} catch (RuntimeException re) {
			log.error("save failed", re);
			throw re;
		}
	}

	public void delete(Adcontract persistentInstance) {
		log.debug("deleting Adcontract instance");
		try {
			getHibernateTemplate().delete(persistentInstance);
			log.debug("delete successful");
		} catch (RuntimeException re) {
			log.error("delete failed", re);
			throw re;
		}
	}

	public Adcontract findById(java.lang.Integer id) {
		log.debug("getting Adcontract instance with id: " + id);
		try {
			Adcontract instance = (Adcontract) getHibernateTemplate().get(
					"com.nfledmedia.sorm.entity.Adcontract", id);
			return instance;
		} catch (RuntimeException re) {
			log.error("get failed", re);
			throw re;
		}
	}

	public List findByExample(Adcontract instance) {
		log.debug("finding Adcontract instance by example");
		try {
			List results = getHibernateTemplate().findByExample(instance);
			log.debug("find by example successful, result size: "
					+ results.size());
			return results;
		} catch (RuntimeException re) {
			log.error("find by example failed", re);
			throw re;
		}
	}

	public List findByProperty(String propertyName, Object value) {
		log.debug("finding Adcontract instance with property: " + propertyName
				+ ", value: " + value);
		try {
			String queryString = "from Adcontract as model where model."
					+ propertyName + "= ?";
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
		log.debug("finding all Adcontract instances");
		try {
			String queryString = "from Adcontract";
			return getHibernateTemplate().find(queryString);
		} catch (RuntimeException re) {
			log.error("find all failed", re);
			throw re;
		}
	}

	public Adcontract merge(Adcontract detachedInstance) {
		log.debug("merging Adcontract instance");
		try {
			Adcontract result = (Adcontract) getHibernateTemplate().merge(
					detachedInstance);
			log.debug("merge successful");
			return result;
		} catch (RuntimeException re) {
			log.error("merge failed", re);
			throw re;
		}
	}

	public void attachDirty(Adcontract instance) {
		log.debug("attaching dirty Adcontract instance");
		try {
			getHibernateTemplate().saveOrUpdate(instance);
			log.debug("attach successful");
		} catch (RuntimeException re) {
			log.error("attach failed", re);
			throw re;
		}
	}

	public void attachClean(Adcontract instance) {
		log.debug("attaching clean Adcontract instance");
		try {
			getHibernateTemplate().lock(instance, LockMode.NONE);
			log.debug("attach successful");
		} catch (RuntimeException re) {
			log.error("attach failed", re);
			throw re;
		}
	}

	public static AdcontractDAO getFromApplicationContext(ApplicationContext ctx) {
		return (AdcontractDAO) ctx.getBean("AdcontractDAO");
	}
}