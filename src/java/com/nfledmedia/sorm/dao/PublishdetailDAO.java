package com.nfledmedia.sorm.dao;

import java.util.Date;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.hibernate.LockMode;
import org.hibernate.Query;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.ApplicationContext;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import com.nfledmedia.sorm.entity.Publishdetail;
import com.nfledmedia.sorm.util.Page;

/**
 * A data access object (DAO) providing persistence and search support for
 * Publishdetail entities. Transaction control of the save(), update() and
 * delete() operations can directly support Spring container-managed
 * transactions or they can be augmented to handle user-managed Spring
 * transactions. Each of these methods provides additional information for how
 * to configure it for the desired type of transaction control.
 * 
 * @see com.nfledmedia.sorm.entity.Publishdetail
 * @author MyEclipse Persistence Tools
 */
public class PublishdetailDAO extends HibernateDaoSupport {
	private static final Logger log = LoggerFactory.getLogger(PublishdetailDAO.class);
	// property constants
	public static final String ORDERID = "orderid";
	public static final String CLIENT = "client";
	public static final String ADCONTENT = "adcontent";
	public static final String LEDNAME = "ledname";
	public static final String INDNAME = "indname";
	public static final String CTYPENAME = "ctypename";
	public static final String FREQUENCY = "frequency";
	public static final String ADDFREQ = "addfreq";
	public static final String DURATION = "duration";

	public static final String LED_START_END_DISTINCT = "select p.id, p.ledname, p.client, p.adcontent, p.attributename, p.ctypename, p.frequency, p.addfreq, p.duration,"
			+ " p.date from Publishdetail p ";

	protected void initDao() {
		// do nothing
	}

	public void save(Publishdetail transientInstance) {
		log.debug("saving Publishdetail instance");
		try {
			getHibernateTemplate().save(transientInstance);
			log.debug("save successful");
		} catch (RuntimeException re) {
			log.error("save failed", re);
			throw re;
		}
	}

	public void delete(Publishdetail persistentInstance) {
		log.debug("deleting Publishdetail instance");
		try {
			getHibernateTemplate().delete(persistentInstance);
			log.debug("delete successful");
		} catch (RuntimeException re) {
			log.error("delete failed", re);
			throw re;
		}
	}

	public Publishdetail findById(java.lang.Integer id) {
		log.debug("getting Publishdetail instance with id: " + id);
		try {
			Publishdetail instance = (Publishdetail) getHibernateTemplate().get("com.nfledmedia.sorm.entity.Publishdetail", id);
			return instance;
		} catch (RuntimeException re) {
			log.error("get failed", re);
			throw re;
		}
	}

	public List findByExample(Publishdetail instance) {
		log.debug("finding Publishdetail instance by example");
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
		log.debug("finding Publishdetail instance with property: " + propertyName + ", value: " + value);
		try {
			String queryString = "from Publishdetail as model where model." + propertyName + "= ?";
			return getHibernateTemplate().find(queryString, value);
		} catch (RuntimeException re) {
			log.error("find by property name failed", re);
			throw re;
		}
	}

	public List findByOrderid(Object orderid) {
		return findByProperty(ORDERID, orderid);
	}

	public List findByClient(Object client) {
		return findByProperty(CLIENT, client);
	}

	public List findByAdcontent(Object adcontent) {
		return findByProperty(ADCONTENT, adcontent);
	}

	public List findByLedname(Object ledname) {
		return findByProperty(LEDNAME, ledname);
	}

	public List findByIndname(Object indname) {
		return findByProperty(INDNAME, indname);
	}

	public List findByCtypename(Object ctypename) {
		return findByProperty(CTYPENAME, ctypename);
	}

	public List findByFrequency(Object frequency) {
		return findByProperty(FREQUENCY, frequency);
	}

	public List findByAddfreq(Object addfreq) {
		return findByProperty(ADDFREQ, addfreq);
	}

	public List findByDuration(Object duration) {
		return findByProperty(DURATION, duration);
	}

	public List findAll() {
		log.debug("finding all Publishdetail instances");
		try {
			String queryString = "from Publishdetail";
			return getHibernateTemplate().find(queryString);
		} catch (RuntimeException re) {
			log.error("find all failed", re);
			throw re;
		}
	}

	public Publishdetail merge(Publishdetail detachedInstance) {
		log.debug("merging Publishdetail instance");
		try {
			Publishdetail result = (Publishdetail) getHibernateTemplate().merge(detachedInstance);
			log.debug("merge successful");
			return result;
		} catch (RuntimeException re) {
			log.error("merge failed", re);
			throw re;
		}
	}

	public void attachDirty(Publishdetail instance) {
		log.debug("attaching dirty Publishdetail instance");
		try {
			getHibernateTemplate().saveOrUpdate(instance);
			log.debug("attach successful");
		} catch (RuntimeException re) {
			log.error("attach failed", re);
			throw re;
		}
	}

	public void attachClean(Publishdetail instance) {
		log.debug("attaching clean Publishdetail instance");
		try {
			getHibernateTemplate().lock(instance, LockMode.NONE);
			log.debug("attach successful");
		} catch (RuntimeException re) {
			log.error("attach failed", re);
			throw re;
		}
	}

	public static PublishdetailDAO getFromApplicationContext(ApplicationContext ctx) {
		return (PublishdetailDAO) ctx.getBean("PublishdetailDAO");
	}

	/**
	 * 获取所有资源列表，指广告在某个屏幕某段时间每天的发布内容
	 * 
	 * @param startdate
	 * @param enddate
	 * @param ledname
	 * @return List
	 */
	public List getResourceListAll(String startdate, String enddate, String ledname) {
		List lst = null;
		try {
			String hql = LED_START_END_DISTINCT + " where p.ledname ='" + ledname + "' and p.date >= '" + startdate
					+ "' and p.date <= '" + enddate + "'" + " order by p.attributename ";
			lst = find(hql);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return lst;
	}

	public List find(String hql, Object... params) {
		return this.getHibernateTemplate().find(hql, params);
	}

	public Page pagedQuery(String hql, int pageNo, int pageSize, Object... values) {
		String countQueryString = " select count (*) " + removeSelect(removeOrders(hql));
		List countlist = getHibernateTemplate().find(countQueryString, values);
		long totalCount = countlist.isEmpty() ? 0 : (Long) countlist.get(0);
		if (totalCount < 1)
			return new Page();
		// 实际查询返回分页对象
		int startIndex = Page.getStartOfPage(pageNo, pageSize);
		Query query = createQuery(hql, values);
		List list = query.setFirstResult(startIndex).setMaxResults(pageSize).list();
		return new Page(startIndex, totalCount, pageSize, list);
	}

	/**
	 * 去除hql的orderby 子句，用于pagedQuery.
	 *
	 * @see #pagedQuery(String,int,int,Object[])
	 */
	private static String removeOrders(String hql) {
		// Assert.hasText(hql);
		Pattern p = Pattern.compile("order\\s*by[\\w|\\W|\\s|\\S]*", Pattern.CASE_INSENSITIVE);
		Matcher m = p.matcher(hql);
		StringBuffer sb = new StringBuffer();
		while (m.find()) {
			m.appendReplacement(sb, "");
		}
		m.appendTail(sb);
		return sb.toString();
	}

	/**
	 * 去除hql的select 子句，未考虑union的情况,用于pagedQuery.
	 *
	 * @see #pagedQuery(String,int,int,Object[])
	 */
	private static String removeSelect(String hql) {
		int beginPos = hql.toLowerCase().indexOf("from");
		return hql.substring(beginPos);
	}

	/**
	 * 创建Query对象.
	 * 对于需要first,max,fetchsize,cache,cacheRegion等诸多设置的函数,可以在返回Query后自行设置.
	 * 留意可以连续设置
	 * 
	 * @param values
	 *            可变参数.
	 */
	public Query createQuery(String hql, Object... values) {
		// Assert.hasText(hql);
		Query query = getSession().createQuery(hql);
		for (int i = 0; i < values.length; i++) {
			query.setParameter(i, values[i]);
		}
		return query;
	}

	public List<Publishdetail> getPublishdetailFromDaterange(String dateStart, String dateEnd) {
		// TODO Auto-generated method stub
		String hql = "select p from Publishdetail p where p.date >='" + dateStart + "' and p.date <='" + dateEnd + "'";
		return find(hql);
	}
}