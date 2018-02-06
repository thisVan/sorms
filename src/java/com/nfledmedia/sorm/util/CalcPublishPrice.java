/**     
 * @Title: CalcPublishPrice.java   
 * @Package com.nfledmedia.sorm.util   
 * @Description: TODO(计算刊例价)   
 * @author wufc@nfledmedia.com     
 * @date 2016年10月28日 上午11:36:16   
 * @version V1.0   
 * @Copyright 2016 Guangdong Southern NewVision Media Technology Co., Ltd. All rights reserved.  
 */
package com.nfledmedia.sorm.util;

/**
 * @ClassName: CalcPublishPrice
 * @Description: TODO(这里用一句话描述这个类的作用)
 * @author PC-FAN
 * @date 2016年10月28日 上午11:36:16
 * 
 */
public class CalcPublishPrice {
	/**
	 * 
	 * @Title: calcPublishPrice
	 * @Description: TODO(计算刊例价)
	 * @param times
	 * @param duration
	 * @param publishPrice
	 * @return double 返回类型
	 * @throws
	 */
	public double calcPublishPrice(double times, double duration,
			double publishPrice) {

		return Math.round(publishPrice * ((times - 60) / 30 * 0.3 + 1)
				* ((duration - 15) / 5 * 0.35 + 1));
	}
}