package com.nfledmedia.sorm.dao;

import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.hibernate.LockMode;
import org.hibernate.Query;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.ApplicationContext;
import org.springframework.orm.hibernate3.HibernateTemplate;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;
import org.springframework.util.Assert;

import com.nfledmedia.sorm.entity.Message;
import com.nfledmedia.sorm.util.Page;

/**
 * A data access object (DAO) providing persistence and search support for
 * Message entities. Transaction control of the save(), update() and delete()
 * operations can directly support Spring container-managed transactions or they
 * can be augmented to handle user-managed Spring transactions. Each of these
 * methods provides additional information for how to configure it for the
 * desired type of transaction control.
 * 
 * @see com.nfledmedia.sorm.entity.Message
 * @author MyEclipse Persistence Tools
 */
public class MessageDAO extends HibernateDaoSupport {
	private static final Logger log = LoggerFactory.getLogger(MessageDAO.class);
	// property constants
	public static final String HAS_READ = "hasRead";
	public static final String CONTENT = "content";

	private static final String GET_MESSAGES_LIST = "select m.id,m.hasRead,m.time,m.content from Message m where m.hasRead!=2 and m.yewuyuan.id = ?";
	private static final String COUNT_NOTREAD_MESSAGE = "select count(*) from Message m where m.yewuyuan.id = ? and m.hasRead=0";

	protected void initDao() {
		// do nothing
		getHibernateTemplate().setFlushMode(HibernateTemplate.FLUSH_EAGER);
	}

	public Page getMessageList(Integer user, String sidx, String sord,
			int pageNo, int pageSize) {
		return pagedQuery(GET_MESSAGES_LIST + " order by m." + sidx + " "
				+ sord, pageNo, pageSize, user);
	}

	public long countNotreadMessage(Integer userId) {
		List countlist = null;
		try {
			countlist = find(COUNT_NOTREAD_MESSAGE, userId);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return (Long) countlist.get(0);
	}

	public Page pagedQuery(String hql, int pageNo, int pageSize,
			Object... values) {
		// Assert.hasText(hql);
		// Assert.isTrue(pageNo >= 1, "页码应该不小于1");
		// Count查询
		String countQueryString = " select count (*) "
				+ removeSelect(removeOrders(hql));
		// System.out.print(hql);
		// System.out.print( getHibernateTemplate().find(countQueryString,
		// values));
		List countlist = getHibernateTemplate().find(countQueryString, values);
		long totalCount = countlist.isEmpty() ? 0 : (Long) countlist.get(0);

		if (totalCount < 1)
			return new Page();
		// 实际查询返回分页对象
		int startIndex = Page.getStartOfPage(pageNo, pageSize);
		Query query = createQuery(hql, values);
		List list = query.setFirstResult(startIndex).setMaxResults(pageSize)
				.list();

		return new Page(startIndex, totalCount, pageSize, list);
	}

	/**
	 * 去除hql的orderby 子句，用于pagedQuery.
	 *
	 * @see #pagedQuery(String,int,int,Object[])
	 */
	private static String removeOrders(String hql) {
		// Assert.hasText(hql);
		Pattern p = Pattern.compile("order\\s*by[\\w|\\W|\\s|\\S]*",
				Pattern.CASE_INSENSITIVE);
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
		Assert.isTrue(beginPos != -1, " hql : " + hql
				+ " must has a keyword 'from'");
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

	public List find(String hql, Object... params) {
		return this.getHibernateTemplate().find(hql, params);
	}

	public void save(Message transientInstance) {
		System.out
				.println(".....................进入messageDAO中的save方法....................");
		System.out.println(transientInstance.getContent() + "  "
				+ transientInstance.getHasRead() + "  "
				+ transientInstance.getTime());
		log.debug("saving Message instance");
		try {
			getHibernateTemplate().save(transientInstance);
			log.debug("save successful");
		} catch (Exception re) {
			log.error("save failed", re);
			re.printStackTrace();
			try {
				throw re;
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}

	public void delete(Message persistentInstance) {
		log.debug("deleting Message instance");
		try {
			getHibernateTemplate().delete(persistentInstance);
			log.debug("delete successful");
		} catch (Exception re) {
			log.error("delete failed", re);
			re.printStackTrace();
			try {
				throw re;
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}

	public Message findById(java.lang.Long id) {
		log.debug("getting Message instance with id: " + id);
		try {
			Message instance = (Message) getHibernateTemplate().get(
					"com.nfledmedia.sorm.entity.Message", id);
			return instance;
		} catch (RuntimeException re) {
			log.error("get failed", re);
			throw re;
		}
	}

	public List findByExample(Message instance) {
		log.debug("finding Message instance by example");
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
		log.debug("finding Message instance with property: " + propertyName
				+ ", value: " + value);
		try {
			String queryString = "from Message as model where model."
					+ propertyName + "= ?";
			return getHibernateTemplate().find(queryString, value);
		} catch (RuntimeException re) {
			log.error("find by property name failed", re);
			throw re;
		}
	}

	public List findByHasRead(Object hasRead) {
		return findByProperty(HAS_READ, hasRead);
	}

	public List findByContent(Object content) {
		return findByProperty(CONTENT, content);
	}

	public List findAll() {
		log.debug("finding all Message instances");
		try {
			String queryString = "from Message";
			return getHibernateTemplate().find(queryString);
		} catch (RuntimeException re) {
			log.error("find all failed", re);
			throw re;
		}
	}

	public Message merge(Message detachedInstance) {
		System.out.println("~~~~~~~~~~~~MessageDAO~~~~~~~~~~~~~~~~~");
		log.debug("merging Message instance");
		try {
			Message result = (Message) getHibernateTemplate().merge(
					detachedInstance);
			log.debug("merge successful");
			return result;
		} catch (Exception re) {
			log.error("merge failed", re);
			re.printStackTrace();
			try {
				throw re;
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return null;
	}

	public void attachDirty(Message instance) {
		log.debug("attaching dirty Message instance");
		try {
			getHibernateTemplate().saveOrUpdate(instance);
			log.debug("attach successful");
		} catch (RuntimeException re) {
			log.error("attach failed", re);
			throw re;
		}
	}

	public void attachClean(Message instance) {
		log.debug("attaching clean Message instance");
		try {
			getHibernateTemplate().lock(instance, LockMode.NONE);
			log.debug("attach successful");
		} catch (RuntimeException re) {
			log.error("attach failed", re);
			throw re;
		}
	}

	public static MessageDAO getFromApplicationContext(ApplicationContext ctx) {
		return (MessageDAO) ctx.getBean("MessageDAO");
	}
}