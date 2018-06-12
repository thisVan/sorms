package com.nfledmedia.sorm.dao;

import java.util.List;

import org.hibernate.LockMode;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.ApplicationContext;
import org.springframework.orm.hibernate5.support.HibernateDaoSupport;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.nfledmedia.sorm.entity.Operevent;

/**
 * A data access object (DAO) providing persistence and search support for
 * Operevent entities. Transaction control of the save(), update() and delete()
 * operations can directly support Spring container-managed transactions or they
 * can be augmented to handle user-managed Spring transactions. Each of these
 * methods provides additional information for how to configure it for the
 * desired type of transaction control.
 * 
 * @see com.nfledmedia.sorm.entity.Operevent
 * @author MyEclipse Persistence Tools
 */
@Repository
public class OpereventDAO extends HibernateDaoSupport {
	private static final Logger log = LoggerFactory.getLogger(AdcontractDAO.class);

	protected void initDao() {
		// do nothing
	}
	
	@Transactional(readOnly=false)
	public void save(Operevent transientInstance) {
		log.debug("saving Operevent instance");
		try {
			getHibernateTemplate().save(transientInstance);
			log.debug("save successful");
		} catch (RuntimeException re) {
			log.error("save failed", re);
			throw re;
		}
	}

	@Transactional(readOnly=false)
	public void delete(Operevent persistentInstance) {
		log.debug("deleting Operevent instance");
		try {
			getHibernateTemplate().delete(persistentInstance);
			log.debug("delete successful");
		} catch (RuntimeException re) {
			log.error("delete failed", re);
			throw re;
		}
	}

	public Operevent findById(java.lang.Integer id) {
		log.debug("getting Operevent instance with id: " + id);
		try {
			Operevent instance = (Operevent) getHibernateTemplate().get("com.nfledmedia.sorm.entity.Operevent", id);
			return instance;
		} catch (RuntimeException re) {
			log.error("get failed", re);
			throw re;
		}
	}

	public List findByExample(Operevent instance) {
		log.debug("finding Operevent instance by example");
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
		log.debug("finding Operevent instance with property: " + propertyName + ", value: " + value);
		try {
			String queryString = "from Operevent as model where model." + propertyName + "= ?";
			return getHibernateTemplate().find(queryString, value);
		} catch (RuntimeException re) {
			log.error("find by property name failed", re);
			throw re;
		}
	}

	public List findByOrder(Object order) {
		return findByProperty("order.id", order);
	}

	public List findByOperater(Object operater) {
		return findByProperty("operater", operater);
	}

	public List findByOriginorder(Object originorder) {
		return findByProperty("originorder", originorder);
	}

	public List findAll() {
		log.debug("finding all Operevent instances");
		try {
			String queryString = "from Operevent";
			return getHibernateTemplate().find(queryString);
		} catch (RuntimeException re) {
			log.error("find all failed", re);
			throw re;
		}
	}

	public Operevent merge(Operevent detachedInstance) {
		log.debug("merging Operevent instance");
		try {
			Operevent result = (Operevent) getHibernateTemplate().merge(detachedInstance);
			log.debug("merge successful");
			return result;
		} catch (RuntimeException re) {
			log.error("merge failed", re);
			throw re;
		}
	}

	public void attachDirty(Operevent instance) {
		log.debug("attaching dirty Operevent instance");
		try {
			getHibernateTemplate().saveOrUpdate(instance);
			log.debug("attach successful");
		} catch (RuntimeException re) {
			log.error("attach failed", re);
			throw re;
		}
	}

	public void attachClean(Operevent instance) {
		log.debug("attaching clean Operevent instance");
		try {
			getHibernateTemplate().lock(instance, LockMode.NONE);
			log.debug("attach successful");
		} catch (RuntimeException re) {
			log.error("attach failed", re);
			throw re;
		}
	}

	public static AdcontractDAO getFromApplicationContext(ApplicationContext ctx) {
		return (AdcontractDAO) ctx.getBean("opereventDAO");
	}

}
