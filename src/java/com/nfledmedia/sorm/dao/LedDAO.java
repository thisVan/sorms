package com.nfledmedia.sorm.dao;

import java.util.List;

import org.hibernate.LockMode;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.ApplicationContext;
import org.springframework.orm.hibernate5.support.HibernateDaoSupport;
import org.springframework.stereotype.Repository;

import com.nfledmedia.sorm.cons.CommonConstant;
import com.nfledmedia.sorm.cons.TypeCollections;
import com.nfledmedia.sorm.entity.Led;

/**
 * A data access object (DAO) providing persistence and search support for Led
 * entities. Transaction control of the save(), update() and delete() operations
 * can directly support Spring container-managed transactions or they can be
 * augmented to handle user-managed Spring transactions. Each of these methods
 * provides additional information for how to configure it for the desired type
 * of transaction control.
 * 
 * @see com.nfledmedia.sorm.entity.Led
 * @author MyEclipse Persistence Tools
 */
@Repository
public class LedDAO extends HibernateDaoSupport {
	private static final Logger log = LoggerFactory.getLogger(LedDAO.class);
	// property constants
	public static final String LEDSN = "ledsn";
	public static final String CODE = "code";
	public static final String NAME = "name";
	public static final String LOCATION = "location";
	public static final String AVLDURATION = "avlduration";
	public static final String BRKDURATION = "brkduration";
	public static final String LEDLENGTH = "ledlength";
	public static final String LEDHEIGHT = "ledheight";
	public static final String LEDSQURE = "ledsqure";
	public static final String LEDRESOLUTION = "ledresolution";
	public static final String LEDTYPE = "ledtype";
	public static final String PUBLISHPRICE = "publishprice";
	public static final String PROVINCE = "province";
	public static final String CITY = "city";
	public static final String DISTRICT = "district";
	public static final String STATE = "state";

	protected void initDao() {
		// do nothing
	}

	public void save(Led transientInstance) {
		log.debug("saving Led instance");
		try {
			getHibernateTemplate().save(transientInstance);
			log.debug("save successful");
		} catch (RuntimeException re) {
			log.error("save failed", re);
			throw re;
		}
	}

	public void delete(Led persistentInstance) {
		log.debug("deleting Led instance");
		try {
			getHibernateTemplate().delete(persistentInstance);
			log.debug("delete successful");
		} catch (RuntimeException re) {
			log.error("delete failed", re);
			throw re;
		}
	}

	public Led findById(java.lang.Integer id) {
		log.debug("getting Led instance with id: " + id);
		try {
			Led instance = (Led) getHibernateTemplate().get("com.nfledmedia.sorm.entity.Led", id);
			return instance;
		} catch (RuntimeException re) {
			log.error("get failed", re);
			throw re;
		}
	}

	public List findByExample(Led instance) {
		log.debug("finding Led instance by example");
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
		log.debug("finding Led instance with property: " + propertyName + ", value: " + value);
		try {
			String queryString = "from Led as model where model." + propertyName + "= ?";
			return getHibernateTemplate().find(queryString, value);
		} catch (RuntimeException re) {
			log.error("find by property name failed", re);
			throw re;
		}
	}

	public List findByLedsn(Object ledsn) {
		return findByProperty(LEDSN, ledsn);
	}

	public List findByCode(Object code) {
		return findByProperty(CODE, code);
	}

	public List findByName(Object name) {
		return findByProperty(NAME, name);
	}

	public List findByLocation(Object location) {
		return findByProperty(LOCATION, location);
	}

	public List findByAvlduration(Object avlduration) {
		return findByProperty(AVLDURATION, avlduration);
	}

	public List findByBrkduration(Object brkduration) {
		return findByProperty(BRKDURATION, brkduration);
	}

	public List findByLedlength(Object ledlength) {
		return findByProperty(LEDLENGTH, ledlength);
	}

	public List findByLedheight(Object ledheight) {
		return findByProperty(LEDHEIGHT, ledheight);
	}

	public List findByLedsqure(Object ledsqure) {
		return findByProperty(LEDSQURE, ledsqure);
	}

	public List findByLedresolution(Object ledresolution) {
		return findByProperty(LEDRESOLUTION, ledresolution);
	}

	public List findByLedtype(Object ledtype) {
		return findByProperty(LEDTYPE, ledtype);
	}

	public List findByPublishprice(Object publishprice) {
		return findByProperty(PUBLISHPRICE, publishprice);
	}

	public List findByProvince(Object province) {
		return findByProperty(PROVINCE, province);
	}

	public List findByCity(Object city) {
		return findByProperty(CITY, city);
	}

	public List findByDistrict(Object district) {
		return findByProperty(DISTRICT, district);
	}

	public List findByState(Object state) {
		return findByProperty(STATE, state);
	}

	public List findAll() {
		log.debug("finding all Led instances");
		try {
			String queryString = "from Led";
			return getHibernateTemplate().find(queryString);
		} catch (RuntimeException re) {
			log.error("find all failed", re);
			throw re;
		}
	}

	/**
	 * 返回所有激活的Led
	 * 
	 * @return
	 */
	public List findAllAvailable() {
		return findByState(TypeCollections.LED_ACTIVE_STATE);
	}

	public Led merge(Led detachedInstance) {
		log.debug("merging Led instance");
		try {
			Led result = (Led) getHibernateTemplate().merge(detachedInstance);
			log.debug("merge successful");
			return result;
		} catch (RuntimeException re) {
			log.error("merge failed", re);
			throw re;
		}
	}

	public void attachDirty(Led instance) {
		log.debug("attaching dirty Led instance");
		try {
			getHibernateTemplate().saveOrUpdate(instance);
			log.debug("attach successful");
		} catch (RuntimeException re) {
			log.error("attach failed", re);
			throw re;
		}
	}

	public void attachClean(Led instance) {
		log.debug("attaching clean Led instance");
		try {
			getHibernateTemplate().lock(instance, LockMode.NONE);
			log.debug("attach successful");
		} catch (RuntimeException re) {
			log.error("attach failed", re);
			throw re;
		}
	}

	public static LedDAO getFromApplicationContext(ApplicationContext ctx) {
		return (LedDAO) ctx.getBean("ledDAO");
	}
}