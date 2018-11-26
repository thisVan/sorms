package com.nfledmedia.sorm.dao;

import java.util.Date;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.hibernate.LockMode;
//import org.hibernate.Query;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.ApplicationContext;
import org.springframework.orm.hibernate5.support.HibernateDaoSupport;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.nfledmedia.sorm.cons.ProjectAttributeConstant;
import com.nfledmedia.sorm.cons.TypeCollections;
import com.nfledmedia.sorm.entity.Adcontract;
import com.nfledmedia.sorm.entity.Order;
import com.nfledmedia.sorm.util.Page;

/**
 * A data access object (DAO) providing persistence and search support for Order
 * entities. Transaction control of the save(), update() and delete() operations
 * can directly support Spring container-managed transactions or they can be
 * augmented to handle user-managed Spring transactions. Each of these methods
 * provides additional information for how to configure it for the desired type
 * of transaction control.
 * 
 * @see com.nfledmedia.sorm.entity.Order
 * @author MyEclipse Persistence Tools
 */
@Transactional
@Repository
public class OrderDAO extends HibernateDaoSupport {
	private static final Logger log = LoggerFactory.getLogger(OrderDAO.class);
	// property constants
	public static final String ORDERSN = "ordersn";
	public static final String CONTENT = "content";
	public static final String MODIFIER = "modifier";
	public static final String STATE = "state";
	private static final String GET_ORDER_LIST = "select o.id, o.led.name, o.adcontract.client, o.adcontract.agency, o.content, o.frequency, o.addfreq, o.duration,"
			+ "o.startdate, o.enddate, o.starttime, o.endtime, o.adcontract.remark, o.attribute.attributename, o.adcontract.clienttype.ctypedesc, o.adcontract.placer from Order o ";

	protected void initDao() {
		// do nothing
	}

	public void save(Order transientInstance) {
		log.debug("saving Order instance");
		try {
			getHibernateTemplate().save(transientInstance);
			log.debug("save successful");
		} catch (RuntimeException re) {
			log.error("save failed", re);
			throw re;
		}
	}

	public void delete(Order persistentInstance) {
		log.debug("deleting Order instance");
		try {
			getHibernateTemplate().delete(persistentInstance);
			log.debug("delete successful");
		} catch (RuntimeException re) {
			log.error("delete failed", re);
			throw re;
		}
	}

	public Order findById(java.lang.Integer id) {
		log.debug("getting Order instance with id: " + id);
		try {
			Order instance = (Order) getHibernateTemplate().get("com.nfledmedia.sorm.entity.Order", id);
			return instance;
		} catch (RuntimeException re) {
			log.error("get failed", re);
			throw re;
		}
	}

	public List findByExample(Order instance) {
		log.debug("finding Order instance by example");
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
		log.debug("finding Order instance with property: " + propertyName + ", value: " + value);
		try {
			String queryString = "from Order as model where model." + propertyName + "= ?";
			return getHibernateTemplate().find(queryString, value);
		} catch (RuntimeException re) {
			log.error("find by property name failed", re);
			throw re;
		}
	}

	public List findByOrdersn(Object ordersn) {
		return findByProperty(ORDERSN, ordersn);
	}

	public List findByContent(Object content) {
		return findByProperty(CONTENT, content);
	}

	public List findByModifier(Object modifier) {
		return findByProperty(MODIFIER, modifier);
	}

	public List findByState(Object state) {
		return findByProperty(STATE, state);
	}

	public List findAll() {
		log.debug("finding all Order instances");
		try {
			String queryString = "from Order";
			return getHibernateTemplate().find(queryString);
		} catch (RuntimeException re) {
			log.error("find all failed", re);
			throw re;
		}
	}

	public Order merge(Order detachedInstance) {
		log.debug("merging Order instance");
		try {
			Order result = (Order) getHibernateTemplate().merge(detachedInstance);
			log.debug("merge successful");
			return result;
		} catch (RuntimeException re) {
			log.error("merge failed", re);
			throw re;
		}
	}

	public void attachDirty(Order instance) {
		log.debug("attaching dirty Order instance");
		try {
			getHibernateTemplate().saveOrUpdate(instance);
			log.debug("attach successful");
		} catch (RuntimeException re) {
			log.error("attach failed", re);
			throw re;
		}
	}

	public void attachClean(Order instance) {
		log.debug("attaching clean Order instance");
		try {
			getHibernateTemplate().lock(instance, LockMode.NONE);
			log.debug("attach successful");
		} catch (RuntimeException re) {
			log.error("attach failed", re);
			throw re;
		}
	}

	public static OrderDAO getFromApplicationContext(ApplicationContext ctx) {
		return (OrderDAO) ctx.getBean("orderDAO");
	}

	public Page getRenkanshuManageList(String sidx, String sord, int pageNo, int pageSize) {
		System.out.println("???????????renkanshuDAO:getRenkanshuManageList???????????????");
		Page page = null;
		try {
			page = pagedQuery(
					GET_ORDER_LIST + " where o.state='" + TypeCollections.ORDER_STATE_ACTIVE + "' " + " order by o." + sidx + " " + sord,
					pageNo, pageSize);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return page;
	}

	public Page getRenkanshuManageListByKeyword(String keyword, String sidx, String sord, int pageNo, int pageSize) {
		Page page = null;
		try {
			page = pagedQuery(GET_ORDER_LIST + keyword + " order by o." + sidx + " " + sord, pageNo, pageSize);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return page;
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

		if (totalCount < 1)
			return new Page();
		// 实际查询返回分页对象
		int startIndex = Page.getStartOfPage(pageNo, pageSize);
		org.hibernate.query.Query query = createQuery(hql, values);
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
	public org.hibernate.query.Query createQuery(String hql, Object... values) {
		// Assert.hasText(hql);
		org.hibernate.query.Query query = currentSession().createQuery(hql);
		for (int i = 0; i < values.length; i++) {
			query.setParameter(i, values[i]);
		}
		return query;
	}

	/**
	 * 查询给定日期，led的订单
	 * 
	 * @param checkDate
	 * @param ledId
	 * @return
	 */
	public List<?> findOrdersOnDateByLed(java.sql.Date checkDate, Integer ledId) {
		// TODO Auto-generated method stub
		String hql = "select o from Order o where o.startdate <= '" + checkDate + "' and o.enddate >= '" + checkDate + "' and o.led = "
				+ ledId;
		hql += " and o.state='" + TypeCollections.ORDER_STATE_ACTIVE + "'";
		return find(hql);
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
	
	/**
	 * 模糊查找广告内容
	 * @param propertyName
	 * @param value
	 * @return
	 */
	public List<Order> findLikeKeyword(String propertyName, Object value) {
		log.debug("finding Order instance with property: " + propertyName + ", value: " + value);		
		String queryString = "from Order as model where model." + propertyName + " like :keyword";		
		List<Order> list = currentSession().createQuery(queryString).setParameter("keyword", "%"+value+"%").list();
		
		return list;
		    
	}

	/**
	 * 查询期间的Order，按录入日期
	 * @param dateStart
	 * @param dateEnd
	 * @return List<Order>
	 */
	public List<?> findOrdersInDuration(Date dateStart, Date dateEnd) {
		log.debug("finding Order instance in start: " + dateStart + ", end: " + dateEnd);
		try {
			String queryString = "from Order as model where (model.adcontract.createtime >= ? and model.adcontract.createtime <= ?)";
			queryString += " or (model.operatetime >= ? and model.operatetime <= ?)";
			String conditions = " and model.state = '" + ProjectAttributeConstant.ORDER_STATE_ACTIVE + "'";
			queryString += conditions;
			return getHibernateTemplate().find(queryString, dateStart, dateEnd, dateStart, dateEnd);
		} catch (RuntimeException re) {
			log.error("find by property name failed", re);
			throw re;
		}
	}
	
//	//按上刊日期导出
//	public List<?> findOrdersInDuration(Date dateStart, Date dateEnd) {
//		// TODO Auto-generated method stub
//		log.debug("finding Order instance in start: " + dateStart + ", end: " + dateEnd);
//		try {
//			String queryString = "from Order as model where model.startdate >= ? and model.enddate <= ?";
//			String conditions = " and model.state = '" + ProjectAttributeConstant.ORDER_STATE_ACTIVE + "'";
//			queryString += conditions;
//			return getHibernateTemplate().find(queryString, dateStart, dateEnd);
//		} catch (RuntimeException re) {
//			log.error("find by property name failed", re);
//			throw re;
//		}
//	}
	
}