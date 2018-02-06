package com.nfledmedia.sorm.dao;

import java.util.List;

import org.hibernate.LockMode;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.ApplicationContext;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import com.nfledmedia.sorm.entity.Channel;

/**
 * A data access object (DAO) providing persistence and search support for
 * Channel entities. Transaction control of the save(), update() and delete()
 * operations can directly support Spring container-managed transactions or they
 * can be augmented to handle user-managed Spring transactions. Each of these
 * methods provides additional information for how to configure it for the
 * desired type of transaction control.
 * 
 * @see com.nfledmedia.sorm.entity.Channel
 * @author MyEclipse Persistence Tools
 */
public class ChannelDAO extends HibernateDaoSupport {
	private static final Logger log = LoggerFactory.getLogger(ChannelDAO.class);
	// property constants
	public static final String CHANNELNAME = "channelname";
	public static final String CHANNELDESC = "channeldesc";

	protected void initDao() {
		// do nothing
	}

	public void save(Channel transientInstance) {
		log.debug("saving Channel instance");
		try {
			getHibernateTemplate().save(transientInstance);
			log.debug("save successful");
		} catch (RuntimeException re) {
			log.error("save failed", re);
			throw re;
		}
	}

	public void delete(Channel persistentInstance) {
		log.debug("deleting Channel instance");
		try {
			getHibernateTemplate().delete(persistentInstance);
			log.debug("delete successful");
		} catch (RuntimeException re) {
			log.error("delete failed", re);
			throw re;
		}
	}

	public Channel findById(java.lang.Integer id) {
		log.debug("getting Channel instance with id: " + id);
		try {
			Channel instance = (Channel) getHibernateTemplate().get(
					"com.nfledmedia.sorm.entity.Channel", id);
			return instance;
		} catch (RuntimeException re) {
			log.error("get failed", re);
			throw re;
		}
	}

	public List findByExample(Channel instance) {
		log.debug("finding Channel instance by example");
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
		log.debug("finding Channel instance with property: " + propertyName
				+ ", value: " + value);
		try {
			String queryString = "from Channel as model where model."
					+ propertyName + "= ?";
			return getHibernateTemplate().find(queryString, value);
		} catch (RuntimeException re) {
			log.error("find by property name failed", re);
			throw re;
		}
	}

	public List findByChannelname(Object channelname) {
		return findByProperty(CHANNELNAME, channelname);
	}

	public List findByChanneldesc(Object channeldesc) {
		return findByProperty(CHANNELDESC, channeldesc);
	}

	public List findAll() {
		log.debug("finding all Channel instances");
		try {
			String queryString = "from Channel";
			return getHibernateTemplate().find(queryString);
		} catch (RuntimeException re) {
			log.error("find all failed", re);
			throw re;
		}
	}

	public Channel merge(Channel detachedInstance) {
		log.debug("merging Channel instance");
		try {
			Channel result = (Channel) getHibernateTemplate().merge(
					detachedInstance);
			log.debug("merge successful");
			return result;
		} catch (RuntimeException re) {
			log.error("merge failed", re);
			throw re;
		}
	}

	public void attachDirty(Channel instance) {
		log.debug("attaching dirty Channel instance");
		try {
			getHibernateTemplate().saveOrUpdate(instance);
			log.debug("attach successful");
		} catch (RuntimeException re) {
			log.error("attach failed", re);
			throw re;
		}
	}

	public void attachClean(Channel instance) {
		log.debug("attaching clean Channel instance");
		try {
			getHibernateTemplate().lock(instance, LockMode.NONE);
			log.debug("attach successful");
		} catch (RuntimeException re) {
			log.error("attach failed", re);
			throw re;
		}
	}

	public static ChannelDAO getFromApplicationContext(ApplicationContext ctx) {
		return (ChannelDAO) ctx.getBean("ChannelDAO");
	}
}