package com.nfledmedia.sorm.dao;

import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.hibernate.LockMode;
import org.hibernate.query.Query;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.ApplicationContext;
import org.springframework.orm.hibernate5.support.HibernateDaoSupport;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.nfledmedia.sorm.entity.Alterrecord;
import com.nfledmedia.sorm.util.Page;

/**
 * A data access object (DAO) providing persistence and search support for
 * Alterrecord entities. Transaction control of the save(), update() and
 * delete() operations can directly support Spring container-managed
 * transactions or they can be augmented to handle user-managed Spring
 * transactions. Each of these methods provides additional information for how
 * to configure it for the desired type of transaction control.
 * 
 * @see com.nfledmedia.sorm.entity.Alterrecord
 * @author MyEclipse Persistence Tools
 */
@Transactional
@Repository
public class AlterrecordDAO extends HibernateDaoSupport {
	private static final Logger log = LoggerFactory.getLogger(AlterrecordDAO.class);

	protected void initDao() {
		// do nothing
	}

	public void save(Alterrecord transientInstance) {
		log.debug("saving Alterrecord instance");
		try {
			getHibernateTemplate().save(transientInstance);
			log.debug(transientInstance.toString() + "save successful");
		} catch (RuntimeException re) {
			log.error("save failed", re);
			throw re;
		}
	}

	public void delete(Alterrecord persistentInstance) {
		log.debug("deleting Alterrecord instance");
		try {
			getHibernateTemplate().delete(persistentInstance);
			log.debug("delete successful");
		} catch (RuntimeException re) {
			log.error("delete failed", re);
			throw re;
		}
	}

	public Alterrecord findById(java.lang.Integer id) {
		log.debug("getting Alterrecord instance with id: " + id);
		try {
			Alterrecord instance = (Alterrecord) getHibernateTemplate().get("com.nfledmedia.sorm.entity.Alterrecord", id);
			return instance;
		} catch (RuntimeException re) {
			log.error("get failed", re);
			throw re;
		}
	}

	public List findByExample(Alterrecord instance) {
		log.debug("finding Alterrecord instance by example");
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
		log.debug("finding Alterrecord instance with property: " + propertyName + ", value: " + value);
		try {
			String queryString = "from Alterrecord as model where model." + propertyName + "= ?";
			return getHibernateTemplate().find(queryString, value);
		} catch (RuntimeException re) {
			log.error("find by property name failed", re);
			throw re;
		}
	}
	
	public List findByPropertySort(String propertyName, Object value) {
		log.debug("finding Alterrecord instance with property: " + propertyName + ", value: " + value);
		try {
			String queryString = "from Alterrecord as model where model." + propertyName + "= ? order by model.alterdate desc";
			return getHibernateTemplate().find(queryString, value);
		} catch (RuntimeException re) {
			log.error("find by property name failed", re);
			throw re;
		}
	}

	public List findByOrderId(Object orderid) {
		return findByProperty("order.id", orderid);
	}
	
	public List findByOrderIdSort(Object orderid) {
		return findByPropertySort("order.id", orderid);
	}

	public List findAll() {
		log.debug("finding all Alterrecord instances");
		try {
			String queryString = "from Alterrecord";
			return getHibernateTemplate().find(queryString);
		} catch (RuntimeException re) {
			log.error("find all failed", re);
			throw re;
		}
	}

	public Alterrecord merge(Alterrecord detachedInstance) {
		log.debug("merging Alterrecord instance");
		try {
			Alterrecord result = (Alterrecord) getHibernateTemplate().merge(detachedInstance);
			log.debug("merge successful");
			return result;
		} catch (RuntimeException re) {
			log.error("merge failed", re);
			throw re;
		}
	}

	public void attachDirty(Alterrecord instance) {
		log.debug("attaching dirty Alterrecord instance");
		try {
			getHibernateTemplate().saveOrUpdate(instance);
			log.debug("attach successful");
		} catch (RuntimeException re) {
			log.error("attach failed", re);
			throw re;
		}
	}

	public void attachClean(Alterrecord instance) {
		log.debug("attaching clean Alterrecord instance");
		try {
			getHibernateTemplate().lock(instance, LockMode.NONE);
			log.debug("attach successful");
		} catch (RuntimeException re) {
			log.error("attach failed", re);
			throw re;
		}
	}

	public static AlterrecordDAO getFromApplicationContext(ApplicationContext ctx) {
		return (AlterrecordDAO) ctx.getBean("alterrecordDAO");
	}

	public Page pagedQuery(String hql, int pageNo, int pageSize, Object... values) {
		// Assert.hasText(hql);
		// Assert.isTrue(pageNo >= 1, "页码应该不小于1");
		// Count查询
		String countQueryString = " select count (*) " + removeSelect(removeOrders(hql));
		// System.out.print(hql);
		// System.out.print( getHibernateTemplate().find(countQueryString,
		// values));
		List countlist = getHibernateTemplate().find(countQueryString, values);
		long totalCount = countlist.isEmpty() ? 0 : (Long) countlist.get(0);

		if (totalCount < 1) {
			return new Page();
		}
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
		// Assert.hasText(hql);
		int beginPos = hql.toLowerCase().indexOf("from");
		// Assert.isTrue(beginPos != -1, " hql : " + hql +
		// " must has a keyword 'from'");
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
		Query query = currentSession().createQuery(hql);
		for (int i = 0; i < values.length; i++) {
			query.setParameter(i, values[i]);
		}
		return query;
	}

	/**
	 * 执行hql的方法
	 * 
	 * @param hql
	 * @param params
	 * @return
	 */
	public List<?> find(String hql, Object... params) {
		return this.getHibernateTemplate().find(hql, params);
	}

}