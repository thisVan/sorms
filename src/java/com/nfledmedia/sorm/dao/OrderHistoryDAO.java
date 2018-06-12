package com.nfledmedia.sorm.dao;

import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.hibernate.LockMode;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.ApplicationContext;
import org.springframework.orm.hibernate5.support.HibernateDaoSupport;
import org.springframework.transaction.annotation.Transactional;

import com.nfledmedia.sorm.cons.TypeCollections;
import com.nfledmedia.sorm.entity.OrderHistory;
import com.nfledmedia.sorm.util.Page;

public class OrderHistoryDAO extends HibernateDaoSupport {
	private static final Logger log = LoggerFactory.getLogger(OrderHistoryDAO.class);
	// property constants
	public static final String ORDERSN = "ordersn";
	public static final String CONTENT = "content";
	public static final String MODIFIER = "modifier";
	public static final String STATE = "state";
	public static final String OPERATER = "operater";
	
	private static final String GET_ORDER_LIST = "select o.id, o.led.name, o.adcontractId, o.adcontract.agency, o.content, o.frequency, o.addfreq, o.duration,"
			+ "o.startdate, o.enddate, o.starttime, o.endtime, o.adcontract.remark, o.attribute.attributename, o.adcontract.clienttype.ctypedesc, o.adcontract.placer from OrderHistory o ";

	protected void initDao() {
		// do nothing
	}

	@Transactional(readOnly=false)
	public void save(OrderHistory transientInstance) {
		log.debug("saving OrderHistory instance");
		try {
			getHibernateTemplate().save(transientInstance);
			log.debug("save successful");
		} catch (RuntimeException re) {
			log.error("save failed", re);
			throw re;
		}
	}
	
	@Transactional(readOnly=false)
	public void delete(OrderHistory persistentInstance) {
		log.debug("deleting OrderHistory instance");
		try {
			getHibernateTemplate().delete(persistentInstance);
			log.debug("delete successful");
		} catch (RuntimeException re) {
			log.error("delete failed", re);
			throw re;
		}
	}

	public OrderHistory findById(java.lang.Integer id) {
		log.debug("getting OrderHistory instance with id: " + id);
		try {
			OrderHistory instance = (OrderHistory) getHibernateTemplate().get("com.nfledmedia.sorm.entity.OrderHistory", id);
			return instance;
		} catch (RuntimeException re) {
			log.error("get failed", re);
			throw re;
		}
	}

	public List<OrderHistory> findByExample(OrderHistory instance) {
		log.debug("finding OrderHistory instance by example");
		try {
			List<OrderHistory> results = getHibernateTemplate().findByExample(instance);
			log.debug("find by example successful, result size: " + results.size());
			return results;
		} catch (RuntimeException re) {
			log.error("find by example failed", re);
			throw re;
		}
	}

	public List<?> findByProperty(String propertyName, Object value) {
		log.debug("finding OrderHistory instance with property: " + propertyName + ", value: " + value);
		try {
			String queryString = "from OrderHistory as model where model." + propertyName + "= ?";
			return getHibernateTemplate().find(queryString, value);
		} catch (RuntimeException re) {
			log.error("find by property name failed", re);
			throw re;
		}
	}

	public List<?> findByOrdersn(Object ordersn) {
		return findByProperty(ORDERSN, ordersn);
	}

	public List<?> findByContent(Object content) {
		return findByProperty(CONTENT, content);
	}

	public List<?> findByModifier(Object modifier) {
		return findByProperty(MODIFIER, modifier);
	}

	public List<?> findByState(Object state) {
		return findByProperty(STATE, state);
	}
	
	public List<?> findByOperater(Object operater) {
		return findByProperty(OPERATER, operater);
	}

	public List<?> findAll() {
		log.debug("finding all OrderHistory instances");
		try {
			String queryString = "from OrderHistory";
			return getHibernateTemplate().find(queryString);
		} catch (RuntimeException re) {
			log.error("find all failed", re);
			throw re;
		}
	}

	public OrderHistory merge(OrderHistory detachedInstance) {
		log.debug("merging OrderHistory instance");
		try {
			OrderHistory result = (OrderHistory) getHibernateTemplate().merge(detachedInstance);
			log.debug("merge successful");
			return result;
		} catch (RuntimeException re) {
			log.error("merge failed", re);
			throw re;
		}
	}

	public void attachDirty(OrderHistory instance) {
		log.debug("attaching dirty OrderHistory instance");
		try {
			getHibernateTemplate().saveOrUpdate(instance);
			log.debug("attach successful");
		} catch (RuntimeException re) {
			log.error("attach failed", re);
			throw re;
		}
	}

	public void attachClean(OrderHistory instance) {
		log.debug("attaching clean OrderHistory instance");
		try {
			getHibernateTemplate().lock(instance, LockMode.NONE);
			log.debug("attach successful");
		} catch (RuntimeException re) {
			log.error("attach failed", re);
			throw re;
		}
	}

	public static OrderHistoryDAO getFromApplicationContext(ApplicationContext ctx) {
		return (OrderHistoryDAO) ctx.getBean("orderHistoryDAO");
	}

	public Page getRenkanshuManageList(String sidx, String sord, int pageNo, int pageSize) {
		System.out.println("???????????renkanshuDAO:getRenkanshuManageList???????????????");
		Page page = null;
		try {
			page = pagedQuery(
					GET_ORDER_LIST + " where o.state='" + TypeCollections.ORDER_STATE_ACTIVE + "' " + " OrderHistory by o." + sidx + " " + sord,
					pageNo, pageSize);
		} catch (RuntimeException re) {
			re.printStackTrace();
			log.error("getRenkanshuManageList failed", re);
			throw re;
		}
		return page;
	}

	public Page getRenkanshuManageListByKeyword(String keyword, String sidx, String sord, int pageNo, int pageSize) {
		Page page = null;
		try {
			page = pagedQuery(GET_ORDER_LIST + keyword + " OrderHistory by o." + sidx + " " + sord, pageNo, pageSize);
		} catch (RuntimeException re) {
			re.printStackTrace();
			log.error("getRenkanshuManageListByKeyword failed", re);
			throw re;
		}
		return page;
	}

	public Page pagedQuery(String hql, int pageNo, int pageSize, Object... values) {
		// Assert.hasText(hql);
		// Assert.isTrue(pageNo >= 1, "页码应该不小于1");
		// Count查询
		String countQueryString = " select count (*) " + removeSelect(removeOrders(hql));
		
		List<?> countlist = getHibernateTemplate().find(countQueryString, values);
		long totalCount = countlist.isEmpty() ? 0 : (Long) countlist.get(0);

		if (totalCount < 1)
			return new Page();
		// 实际查询返回分页对象
		int startIndex = Page.getStartOfPage(pageNo, pageSize);
		org.hibernate.query.Query query = createQuery(hql, values);
		List<OrderHistory> list = query.setFirstResult(startIndex).setMaxResults(pageSize).list();

		return new Page(startIndex, totalCount, pageSize, list);
	}

	/**
	 * 去除hql的orderby 子句，用于pagedQuery.
	 *
	 * @see #pagedQuery(String,int,int,Object[])
	 */
	private static String removeOrders(String hql) {
		// Assert.hasText(hql);
		Pattern p = Pattern.compile("OrderHistory\\s*by[\\w|\\W|\\s|\\S]*", Pattern.CASE_INSENSITIVE);
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
	 * @param values 可变参数.
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
	public List<?> findOrderHistorysOnDateByLed(java.sql.Date checkDate, Integer ledId) {
		// TODO Auto-generated method stub
		String hql = "select o from OrderHistory o where o.startdate <= '" + checkDate + "' and o.enddate >= '" + checkDate + "' and o.led = "
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
	public List<?> findLikeKeyword(String propertyName, Object value) {
		log.debug("finding OrderHistory instance with property: " + propertyName + ", value: " + value);		
		String queryString = "from OrderHistory as model where model." + propertyName + " like :keyword";		
		List<?> list = currentSession().createQuery(queryString).setParameter("keyword", "%"+value+"%").list();
		
		return list;
		    
	}

}
