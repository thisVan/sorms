package com.nfledmedia.sorm.service;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.persistence.Entity;
import javax.persistence.ManyToOne;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.nfledmedia.sorm.cons.TypeCollections;
import com.nfledmedia.sorm.dao.IndustryDAO;
import com.nfledmedia.sorm.dao.LedDAO;
import com.nfledmedia.sorm.dao.PublishdetailDAO;
import com.nfledmedia.sorm.dao.UserDAO;
import com.nfledmedia.sorm.entity.Led;
import com.nfledmedia.sorm.entity.Publishdetail;
import com.nfledmedia.sorm.util.TypeNullProcess;

/**
 * 项目名称：sorm 类全名:com.nfledmedia.sorm.service.YewuService 类描述： 创建人：Van@nfledmedia
 * 创建时间：2016年6月22日 上午10:07:59 修改备注：
 * @version jdk1.7
 * Copyright (c) 2016, bolven@qq.com All Rights Reserved.
 */
@Transactional
@Service("yewuService")
public class YewuService {

	private LedDAO ledDAO;

	private IndustryDAO industryDAO;

	private UserDAO userDAO;

	private PublishdetailDAO publishdetailDAO;

	// @SuppressWarnings("unchecked")
	// public List calAvgScreenOccuRate(String led, String dateRangeSQL) {
	// String nameOfLed = null;
	// System.out.println("-------pay attention-----" + led);
	//
	// if(led != null && !led.equals("")) {
	// nameOfLed = "";
	// Pattern pat = Pattern.compile("%(.*)%");
	// Matcher mat = pat.matcher(led);
	// while(mat.find()){
	// nameOfLed = mat.group(1);
	// }
	// } else {
	// nameOfLed = "";
	// }
	//
	// System.out.println("led的名字是：" + nameOfLed);
	//
	// List<Yewu> yewuData = null;
	// yewuData = yewuDAO.getYewuByLED(nameOfLed); //获取某块屏幕的所有广告
	//
	// long ledDurationPerDay = 0;
	// List list = yewuDAO.getDurationByLED(nameOfLed);
	//
	// if(!"".equals(nameOfLed)) {
	// Integer row = (Integer) list.get(0);
	// // System.out.println(row[0]);
	// //获取某块屏幕的每天可播放时长
	// ledDurationPerDay = row;
	// } else {
	// Integer row = null;
	// for(int i = 0; i < list.size(); i++) {
	// row = (Integer) list.get(i);
	// ledDurationPerDay += row;
	// }
	// System.out.println("所有屏幕每天播放时长 ：" + ledDurationPerDay);
	// }
	//
	//
	// /**统计占屏率*/
	// Yewu yewu = (Yewu)yewuData.get(0);
	// Calendar beginDate = Calendar.getInstance();
	// Calendar endDate = Calendar.getInstance();
	// beginDate.setTime(yewu.getKaishishijian()); //最早的开始时间
	// endDate.setTime(yewu.getJieshushijian()); //最晚的结束时间
	//
	// for(int i = 0; i < yewuData.size(); i++) {
	// Calendar tempDate = Calendar.getInstance();
	// tempDate.setTime(yewuData.get(i).getJieshushijian());
	// if(tempDate.after(endDate)) {
	// endDate = tempDate;
	// }
	// }
	// SimpleDateFormat sdf = new SimpleDateFormat("yyyy年MM月");
	// System.out.println("最早的开始的时间：" + sdf.format(beginDate.getTime()));
	// System.out.println("最晚的结束的时间：" + sdf.format(endDate.getTime()));
	//
	// /**计算月份数*/
	// int months = (endDate.get(Calendar.YEAR) - beginDate.get(Calendar.YEAR))
	// * 12 + (endDate.get(Calendar.MONTH) - beginDate.get(Calendar.MONTH)) + 1;
	// System.out.println("经历的月份数：" + months);
	//
	//
	// double[] arr = new double[months];
	// Calendar endOfCurrMonth = Calendar.getInstance();
	// Calendar beginOfCurrMonth = Calendar.getInstance();
	// Calendar[] beginCalendars = new Calendar[months];
	//
	// for(int i = 0; i < months; i++) {
	// beginCalendars[i] = Calendar.getInstance();
	// beginCalendars[i].setTime(beginDate.getTime());
	// beginCalendars[i].add(Calendar.MONTH, i);
	// }
	//
	//
	// /**对每项广告判断所在月份，并计算每个月的广告播放总时长*/
	// for(Yewu yw : yewuData) {
	// //该广告的开始和结束时间
	// Calendar beginDateOfAd = Calendar.getInstance();
	// Calendar endDateOfAd = Calendar.getInstance();
	//
	// beginDateOfAd.setTime(yw.getKaishishijian());
	// endDateOfAd.setTime(yw.getJieshushijian());
	//
	// beginOfCurrMonth.setTime(beginDate.getTime());
	// endOfCurrMonth.setTime(beginDate.getTime());
	// beginOfCurrMonth.set(Calendar.DATE, 1);
	// endOfCurrMonth.set(Calendar.DATE, 1);
	// for(int i = 0; i < arr.length; i++) {
	// endOfCurrMonth.roll(Calendar.DATE, -1); //变为当月最后一天
	// if(!beginDateOfAd.after(endOfCurrMonth) &&
	// !endDateOfAd.before(beginOfCurrMonth)) {//广告开始时间不晚于该月最后一天且结束时间不早于该月第1天
	// //计算在这个月的天数
	// int daysInTheMonth;
	// if(!beginDateOfAd.before(beginOfCurrMonth) &&
	// !endDateOfAd.after(endOfCurrMonth)) {//头尾都没超出该月的范围
	// daysInTheMonth = endDateOfAd.get(Calendar.DATE) -
	// beginDateOfAd.get(Calendar.DATE) + 1;
	// } else if(beginDateOfAd.before(beginOfCurrMonth) &&
	// !endDateOfAd.after(endOfCurrMonth)){//头超尾不超
	// daysInTheMonth = endDateOfAd.get(Calendar.DATE);
	// } else if(!beginDateOfAd.before(beginOfCurrMonth) &&
	// endDateOfAd.after(endOfCurrMonth)) {//尾超头不超
	// daysInTheMonth = endOfCurrMonth.get(Calendar.DATE) -
	// beginDateOfAd.get(Calendar.DATE) + 1;
	// } else {//头尾皆超
	// daysInTheMonth = endOfCurrMonth.getActualMaximum(Calendar.DATE);
	// }
	// //arr[i] += daysInTheMonth*duration
	// int duration = yw.getShichang() * yw.getPinci();
	// arr[i] += daysInTheMonth * duration;
	// }
	// endOfCurrMonth.add(Calendar.DATE, 1);
	// beginOfCurrMonth.add(Calendar.MONTH, 1);
	// }
	// }
	//
	// System.out.println("arr里的内容：");
	// for(double d : arr) {
	// // System.out.println(d);
	// }
	//
	// /**计算每个月总可播放时长，并用arr[i]去除，得到每个月的占屏率*/
	// endOfCurrMonth.setTime(beginDate.getTime());
	// endOfCurrMonth.set(Calendar.DATE, 1);
	// for(int i = 0; i < arr.length; i++) {
	// endOfCurrMonth.roll(Calendar.DATE, -1);
	// //总可播放时长 = 屏幕每天可播放时长 * 该月天数
	// long totalTimeOfTheMonth = ledDurationPerDay *
	// endOfCurrMonth.getActualMaximum(Calendar.DATE);
	// arr[i] /= totalTimeOfTheMonth;
	// endOfCurrMonth.add(Calendar.DATE, 1);
	// }
	//
	// System.out.println("arr里的内容：");
	// for(double d : arr) {
	// // System.out.println(d);
	// }
	//
	// /**测试计算结果*/
	// DecimalFormat df = new DecimalFormat("0.00");
	// endOfCurrMonth.setTime(beginDate.getTime());
	// endOfCurrMonth.set(Calendar.DATE, 1);
	// for(int i = 0; i < arr.length; i++) {
	// //输出：月份，占屏率
	// endOfCurrMonth.roll(Calendar.DATE, -1);
	// System.out.println(sdf.format(endOfCurrMonth.getTime()) + ":" +
	// df.format(arr[i] * 100) + "%");
	// endOfCurrMonth.add(Calendar.DATE, 1);
	// }
	//
	// List data = new ArrayList();
	//
	// //获得筛选条件中的时间参数
	// int beginIndex = 0, endIndex = months - 1;
	// if(dateRangeSQL != null && !dateRangeSQL.equals("")) {
	// int index = dateRangeSQL.indexOf("kaishishijian");
	// String beginDateFilterString = new String(dateRangeSQL).substring(index +
	// 23, index + 33);
	// String endDateFilterString = new String(dateRangeSQL).substring(index +
	// 40, index + 50);
	// System.out.println("hahaha" + beginDateFilterString + " " +
	// endDateFilterString);
	// SimpleDateFormat sdf2 = new SimpleDateFormat("yyyy-MM-dd");
	// Calendar beginDateFilterCalendar = Calendar.getInstance();
	// Calendar endDateFilterCalendar = Calendar.getInstance();
	//
	// try {
	// //筛选条件中的时间参数转换为Calendar类型
	// beginDateFilterCalendar.setTime(sdf2.parse(beginDateFilterString));
	// endDateFilterCalendar.setTime(sdf2.parse(endDateFilterString));
	// } catch (ParseException e) {
	// // TODO Auto-generated catch block
	// e.printStackTrace();
	// }
	//
	// for(int i = 0; i < months; i++) {
	// if(beginDateFilterCalendar.get(Calendar.YEAR) ==
	// beginCalendars[i].get(Calendar.YEAR)
	// && beginDateFilterCalendar.get(Calendar.MONTH) ==
	// beginCalendars[i].get(Calendar.MONTH)) {
	// beginIndex = i;
	// }
	// if(endDateFilterCalendar.get(Calendar.YEAR) ==
	// beginCalendars[i].get(Calendar.YEAR)
	// && endDateFilterCalendar.get(Calendar.MONTH) ==
	// beginCalendars[i].get(Calendar.MONTH)) {
	// endIndex = i;
	// break;
	// }
	// }
	// }
	//
	// //往data中填充统计好的数据（时间经过筛选的数据）
	// endOfCurrMonth.setTime(beginDate.getTime());
	// endOfCurrMonth.set(Calendar.DATE, 1);
	// for(int i = beginIndex; i <= endIndex; i++) {
	// endOfCurrMonth.roll(Calendar.DATE, -1);
	// Object[] objs = new Object[4];
	// objs[0] = beginCalendars[i].get(Calendar.YEAR);
	// objs[1] = nameOfLed;
	// objs[2] = beginCalendars[i].get(Calendar.YEAR) + "年" +
	// (beginCalendars[i].get(Calendar.MONTH) + 1) + "月";
	// objs[3] = df.format(arr[i] * 100);
	// /*objs[4] = beginCalendars[i];*/
	// data.add(objs);
	// endOfCurrMonth.add(Calendar.DATE, 1);
	// }
	// return data;
	// }

	// public Page getAvgScreenOccuRateListByKeyword(String sidx, String sord,
	// int pageNo,
	// int pageSize, String led, String dateRangeSQL) {
	// System.out.println("------yewuService:getYewuList:sidx:" + sidx);
	// System.out.println("调用Service层getAvgScreenOccuRateListByKeyword");
	// List data = calAvgScreenOccuRate(led, dateRangeSQL);
	// int startIndex = Page.getStartOfPage(pageNo, pageSize);
	//
	// List pagedData = new ArrayList();
	// for(int i = (pageNo - 1) * pageSize; i < pageNo * pageSize && i <
	// data.size(); i++) {
	// pagedData.add(data.get(i));
	// }
	// System.out.println(pagedData.size());
	// return new Page(startIndex, data.size(), pageSize, pagedData);
	// }
	/**
	 * 返回占屏率统计5个关键指标，1.总占屏时长Map 2.屏幕可播时长Map 3.商业占屏时长Map 4.赠播占屏时长Map 5.公益占屏时长Map
	 * @param dateRangeSQL
	 * @param ledsList
	 * @return
	 * @throws ParseException
	 */
	public List<Map<String, Integer>> calAvgScreenOccuRate4AllScreen(String dateRangeSQL, List<Led> ledsList) throws ParseException {
		System.out.println("dateRangeSQL:" + dateRangeSQL);
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		// Date dateStart = sdf.parse(dateRangeSQL.split(" ")[0]);
		// Date dateEnd = sdf.parse(dateRangeSQL.split(" ")[1]);
		String dateStart = dateRangeSQL.split(" ")[0];
		String dateEnd = dateRangeSQL.split(" ")[1];
		Long oneDay = (long) (1000 * 3600 * 24);
		int days = (int) ((sdf.parse(dateEnd).getTime() - sdf.parse(dateStart).getTime()) / oneDay) + 1;
		List<Map<String, Integer>> resultData = new ArrayList<Map<String, Integer>>();
		// 获取屏幕的可播时长Map
		Map<String, Integer> ledAvailableMap = new HashMap<String, Integer>();
		Map<String, Integer> ledMap = new HashMap<String, Integer>();
		// List<Led> ledsList = ledDAO.findAllAvailable();
		for (Led led : ledsList) {
			ledAvailableMap.put(led.getName(), led.getAvlduration());
			ledMap.put(led.getName(), led.getAvlduration()*days);
		}
		// 获取初选的结果集
		List<Publishdetail> publishData = null;
		try {
			publishData = publishdetailDAO.getPublishdetailFromDaterange(dateStart, dateEnd);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		// 统计占屏率
		int seconds = 0;
		Map<String, Integer> ledOccu = new HashMap<String, Integer>();
		Map<String, Integer> bussinessOccu = new HashMap<String, Integer>();
		Map<String, Integer> presentOccu = new HashMap<String, Integer>();
		Map<String, Integer> commonwealOccu = new HashMap<String, Integer>();

		Integer theValue = 0;
		Integer thebussValue = 0;
		Integer thepresValue = 0;
		Integer thecommValue = 0;
		// 对每项广告判断屏幕，并计算每个屏的广告播放总时长
		for (Publishdetail pbd : publishData) {
			// 该广告的开始和结束时间
			seconds = (pbd.getFrequency() + TypeNullProcess.nullValueProcess(pbd.getAddfreq())) * pbd.getDuration();

			// // 计算天数
			// if (ywstart >= timestart && ywend <= timeend) {// 头尾都没超出该月的范围
			// days = (int) ((ywend - ywstart) / oneDay + 1);
			// } else if (ywstart <= timestart && ywend <= timeend) {// 头超尾不超
			// days = (int) ((ywend - timestart) / oneDay + 1);
			// } else if (ywstart >= timestart && ywend >= timeend) {// 尾超头不超
			// days = (int) ((timeend - ywstart) / oneDay + 1);
			// } else {// 头尾皆超
			// days = (int) ((timeend - timestart) / oneDay + 1);
			// }
	
			if (ledAvailableMap.containsKey(pbd.getLedname())) {
				switch (pbd.getAttributename()) {
				case TypeCollections.ATTRIBUTE_BUSSINESS:
					if (bussinessOccu.containsKey(pbd.getLedname())) {
						thebussValue = (Integer) bussinessOccu.get(pbd.getLedname());
						thebussValue += days * seconds;
						bussinessOccu.put(pbd.getLedname(), thebussValue);
					} else {
						thebussValue = days * seconds;
						bussinessOccu.put(pbd.getLedname(), thebussValue);
					}
					break;

				case TypeCollections.ATTRIBUTE_PRESENT:
					if (presentOccu.containsKey(pbd.getLedname())) {
						thepresValue = (Integer) presentOccu.get(pbd.getLedname());
						thepresValue += days * seconds;
						presentOccu.put(pbd.getLedname(), thepresValue);
					} else {
						thepresValue = days * seconds;
						presentOccu.put(pbd.getLedname(), thepresValue);
					}
					break;

				case TypeCollections.ATTRIBUTE_COMMONWEAL:
					if (commonwealOccu.containsKey(pbd.getLedname())) {
						thecommValue = (Integer) commonwealOccu.get(pbd.getLedname());
						thecommValue += days * seconds;
						commonwealOccu.put(pbd.getLedname(), thecommValue);
					} else {
						thecommValue = days * seconds;
						commonwealOccu.put(pbd.getLedname(), thecommValue);
					}
					break;
				}
				if (ledOccu.containsKey(pbd.getLedname())) {
					theValue = (Integer) ledOccu.get(pbd.getLedname());
					theValue += days * seconds;
					ledOccu.put(pbd.getLedname(), theValue);
				} else {
					theValue = days * seconds;
					ledOccu.put(pbd.getLedname(), theValue);
				}
			}

		}

		resultData.add(ledOccu);
		resultData.add(ledMap);
		resultData.add(bussinessOccu);
		resultData.add(presentOccu);
		resultData.add(commonwealOccu);

		return resultData;
	}

	// // 获取待审的认刊书列表
	// public Page getRenkanshuAuditList(String sidx, String sord, int pageNo,
	// int pageSize) {
	// System.out.println("^^^^^^^^yewuService:getRenkanshuAuditList:sidx:"
	// + sidx);
	// return renkanshuDAO.getRenkanshuAuditList(sidx, sord, pageNo, pageSize);
	// }
	//
	// public Page getRenkanshuAuditListByKeyword(String keyword, String sidx,
	// String sord, int pageNo, int pageSize) {
	// return renkanshuDAO.getRenkanshuAuditListByKeyword(keyword, sidx, sord,
	// pageNo, pageSize);
	// }

	// //获取我的认刊书列表(类别由type确定（待审核，已通过，未通过）)
	// public Page myRenkanshuList(Integer ywyID,String type,String sidx, String
	// sord, int pageNo,
	// int pageSize) {
	// return renkanshuDAO.myRenkanshuList(ywyID,type,sidx, sord, pageNo,
	// pageSize);
	// }
	//
	// public Page myRenkanshuListByKeyword(Integer ywyID,String type,String
	// keyword, String sidx,
	// String sord, int pageNo, int pageSize) {
	// return renkanshuDAO.myRenkanshuListByKeyword(ywyID,type,keyword, sidx,
	// sord,
	// pageNo, pageSize);
	// }
	//

	// // 获取我的待审核列表
	// public Page getMyOrderAuditList(String sidx, String sord, int pageNo,
	// int pageSize, Integer operYwyId) {
	// System.out
	// .println("^^^^^^^^^^^^^^^^^^^^^^^^^yewuService:getMyOrderAuditList:sidx:"
	// + sidx);
	// return orderauditDAO.getMyOrderAuditList(sidx, sord, pageNo, pageSize,
	// operYwyId);
	// }

	// public List getAllLedBofangshichang() {
	// List list = null;
	// try {
	// list=ledDAO.getAllLedBofangshichang();
	// } catch (Exception e) {
	// e.printStackTrace();
	// }
	// return list;
	// }

	// public void update(Integer id, String leixing, String ledId, Integer
	// shichang, Integer pinci,
	// Date kaishishijian, Date jieshushijian, Double shuliang,
	// String updateReason, Double kanlixiaoji) {
	// Map session = ActionContext.getContext().getSession();
	// Yewuyuan operUser = yewuyuanDAO.findById((Integer)session.get("id"));
	// Led led = ledDAO.findById(ledId);
	// Yewu yewu = yewuDAO.findById(id);
	// Renkanshu renkanshu = yewu.getRenkanshu();
	// // format的格式可以任意
	// Date datenow = new Date();
	// DateFormat sdf2TS = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	// SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	// String dateStr = sdf2TS.format(datenow);
	// Timestamp timeStamp = new Timestamp(System.currentTimeMillis());
	// String remarkContent = "" + timeStamp + " " + operUser.getYwyXingming()
	// + " 修改订单———认刊书编号：" + yewu.getRenkanshu().getRenkanbianhao()
	// + " 广告客户：" + yewu.getRenkanshu().getGuangaokanhu() + " 将";
	// /*if (!guanggaoneirong.equals(yewu.getGuanggaoneirong())) {
	// remarkContent += "广告内容：" + yewu.getGuanggaoneirong() + " 修改为 "
	// + guanggaoneirong + "; ";
	// }
	// if (!yewuyuan.equals(yewu.getYewuyuan())) {
	// remarkContent += "业务员：" + yewu.getYewuyuan().getYwyXingming()
	// + " 修改为 " + yewuyuan.getYwyXingming() + "; ";
	// }
	// if (!industryId.equals(yewu.getIndustry().getIndustryId())) {
	// remarkContent += "行业：" + yewu.getIndustry().getIndustryDesc()
	// + " 修改为 " + industry.getIndustryDesc() + "; ";
	// }*/
	// if (!ledId.equals(yewu.getLed().getLedId())) {
	// remarkContent += "屏幕：" + yewu.getLed().getName() + " 更换为 "
	// + led.getName() + "; ";
	// }
	// if (!leixing.equals(yewu.getLeixing())) {
	// remarkContent += "广告类别：" + yewu.getLeixing() + " 修改为 "
	// + leixing + "; ";
	// }
	// if (!shichang.equals(yewu.getShichang())) {
	// remarkContent += "时长：" + yewu.getShichang() + "秒 修改为 " + shichang
	// + "秒; ";
	// }
	// if (!pinci.equals(yewu.getPinci())) {
	// remarkContent += "频次：" + yewu.getPinci() + "次 修改为 " + pinci + "次; ";
	// }
	// if (!kaishishijian.equals(yewu.getKaishishijian())) {
	// remarkContent += "开始时间：" + sdf.format(yewu.getKaishishijian())
	// + " 修改为 " + sdf.format(kaishishijian) + "; ";
	// }
	// if (!jieshushijian.equals(yewu.getJieshushijian())) {
	// remarkContent += "结束时间：" + sdf.format(yewu.getJieshushijian())
	// + " 修改为 " + sdf.format(jieshushijian) + "; ";
	// }
	// if (!shuliang.equals(yewu.getShuliang())) {
	// remarkContent += "投放时长：" + yewu.getShuliang() + "周 修改为 " + shuliang
	// + "周; ";
	// }
	// if (!kanlixiaoji.equals(yewu.getKanlijiaxiaoji())) {
	// remarkContent += "刊例价小计：" + yewu.getKanlijiaxiaoji() + "元 修改为 "
	// + kanlixiaoji + "元; ";
	// }
	// remarkContent += "<br>" + "修改理由：" + updateReason;
	// // if (!state.equals(yewu.getState())) {
	// // if (yewu.getState().equals("N"))
	// // remarkContent += "订单状态：上画 修改为 下画";
	// // if (yewu.getState().equals("U"))
	// // remarkContent += "订单状态：下画 修改为 上画";
	// //
	// // }
	// Orderaudit orderAudit = new Orderaudit();
	// orderAudit.setYewuId(id);
	// orderAudit.setRenkanbianhao(yewu.getRenkanshu().getRenkanbianhao());
	// orderAudit.setYewuyuanByYwyId(yewu.getYewuyuan());
	// orderAudit.setYewuyuanByOperYwyId(operUser);
	// orderAudit.setKanhu(yewu.getKanhu());
	// orderAudit.setGuanggaoneirong(yewu.getGuanggaoneirong());
	// orderAudit.setLeixing(yewu.getLeixing());
	// orderAudit.setIndustry(yewu.getIndustry());
	// orderAudit.setLed(led);
	// orderAudit.setShichang(shichang);
	// orderAudit.setPinci(pinci);
	// orderAudit.setKaishishijian(kaishishijian);
	// orderAudit.setJieshushijian(jieshushijian);
	// orderAudit.setShuliang(shuliang);
	// orderAudit.setKanlijiaxiaoji(kanlixiaoji);
	// orderAudit.setOperReason(updateReason);
	// // orderAudit.setOrderState("N");
	// orderAudit.setOperTimestamp(timeStamp);
	// orderAudit.setOperType("L");
	// orderauditDAO.save(orderAudit);
	// // renkanshu.setKanlizongjia(kanlizongjia);
	// // renkanshuDAO.merge(renkanshu);
	// Remark remark = new Remark();
	// remark.setOperTime(timeStamp);
	// remark.setOperYwyName(operUser.getYwyXingming());
	// remark.setYewu(yewu);
	// remark.setOperContent(remarkContent);
	// remark.setOrderauditId(orderAudit.getId());
	// remark.setState("A");
	// remarkDAO.save(remark);
	// System.out.println("-------------------------orderAudit.getId:"
	// + orderAudit.getId());
	// // 修改品牌信息
	// // Map session = ActionContext.getContext().getSession();
	// // String username=(String) session.get("loginName");
	// // String
	// //
	// content=operUser.getYwyXingming()+"修改了认刊书编号为："+yewubefore.getRenkanshu().getRenkanbianhao()+",广告客户为："+yewubefore.getKanhu()+"的订单信息，请审核！";
	// // Message message = new Message(new Date(), 0, content, orderAudit.);
	// // messageDao.save(message);
	// }

	// /**
	// *
	// * updatemyAuidtOrder: 待审核订单修改 TODO 用户主动查错修改，或者审核未通过，进行修改
	// *
	// * @author Wu. Van
	// * @param kanhu
	// * @param yewuyuan
	// * @param leixing
	// * @param qiandingriqi
	// * @param userID
	// * @param id
	// * @param guanggaoneirong
	// * @param industryId
	// * @param kanlizongjia
	// * @param zhekou
	// * @param kanlixiaoji
	// * @param ledId
	// * @param shichang
	// * @param pinci
	// * @param kaishishijian
	// * @param jieshushijian
	// * @param shuliang
	// * @param updateReason
	// * @param renkanshuaudit
	// * @since JDK 1.6
	// */
	// public void updatemyAuidtOrder(String kanhu, Integer yewuyuan, String
	// leixing, Date qiandingriqi, Integer userID, Integer id,
	// String guanggaoneirong, Short industryId, Double kanlizongjia, Double
	// zhekou, Double kanlixiaoji, String ledId,
	// Integer shichang, Integer pinci, Date kaishishijian, Date jieshushijian,
	// Double shuliang, String updateReason, Renkanshuaudit renkanshuaudit) {
	// System.out.println("………………进入yewuService.updatemyAuidtOrder………………");
	// DecimalFormat df = new DecimalFormat(",##0.00");
	// //前台的折扣乘了100，后台转回去
	// renkanshuaudit.setZhekou(renkanshuaudit.getZhekou()/100);
	// Yewuyuan operUser = yewuyuanDAO.findById(userID);
	// System.out.println("operUser:" + operUser);
	// Led led = ledDAO.findById(ledId);
	// Industry industry = industryDAO.findById(industryId);
	// System.out.println("operUser:" + operUser + "   led:" + led);
	// String messageTmp = "";
	// Orderaudit orderaudit = orderauditDAO.findById(id);
	// // format的格式可以任意
	// Date datenow = new Date();
	// DateFormat sdf2TS = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	// SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	// String dateStr = sdf2TS.format(datenow);
	// Timestamp timeStamp = new Timestamp(System.currentTimeMillis());
	// if (orderaudit.getLed().getLedId().equals(ledId)) {
	// } else {
	// messageTmp += "将上画点位 " + orderaudit.getLed().getName() + " 修改为 " +
	// led.getName() + " ";
	// }
	// if (orderaudit.getLeixing().equals(leixing)) {
	// } else {
	// messageTmp += "将广告类型 " + orderaudit.getLeixing() + " 修改为 " + leixing +
	// " ";
	// }
	// if (orderaudit.getShichang().equals(shichang)) {
	// } else {
	// messageTmp += "将时长 " + orderaudit.getShichang() + " 修改为 " + shichang +
	// " ";
	// }
	// if (orderaudit.getPinci().equals(pinci)) {
	// } else {
	// messageTmp += "将频次 " + orderaudit.getPinci() + " 修改为 " + pinci + " ";
	// }
	// if
	// (sdf.format(orderaudit.getKaishishijian()).equals(sdf.format(kaishishijian)))
	// {
	// } else {
	// messageTmp += "将开始时间 " + sdf.format(orderaudit.getKaishishijian()) +
	// " 修改为 " + sdf.format(kaishishijian) + " ";
	// }
	// if
	// (sdf.format(orderaudit.getJieshushijian()).equals(sdf.format(jieshushijian)))
	// {
	// } else {
	// messageTmp += "将结束时间 " + sdf.format(orderaudit.getJieshushijian()) +
	// " 修改为 " + sdf.format(jieshushijian) + " ";
	// }
	// if (orderaudit.getShuliang().equals(shuliang)) {
	// } else {
	// messageTmp += "将投放时长 " + df.format(orderaudit.getShuliang()) + "周 修改为 " +
	// df.format(shuliang) + "周 ";
	// }
	// if (orderaudit.getKanlijiaxiaoji().equals(kanlixiaoji)) {
	// } else {
	// messageTmp += "将屏签订金额 " + df.format(orderaudit.getKanlijiaxiaoji()) +
	// "元 修改为 " + df.format(kanlixiaoji) + "元 ";
	// }
	//
	// System.out.println(messageTmp);
	//
	// /**
	// * 增加刊户和类型可以修改 160902 16:03
	// */
	// orderaudit.setKanhu(kanhu);
	// orderaudit.setLeixing(leixing);
	// orderaudit.setKanlijiaxiaoji(kanlixiaoji);
	// // orderaudit.setYewuId(id);
	// orderaudit.setYewuyuanByOperYwyId(operUser);
	// orderaudit.setGuanggaoneirong(guanggaoneirong);
	// orderaudit.setIndustry(industry);
	// orderaudit.setLed(led);
	// orderaudit.setShichang(shichang);
	// orderaudit.setPinci(pinci);
	// orderaudit.setKaishishijian(kaishishijian);
	// orderaudit.setJieshushijian(jieshushijian);
	// orderaudit.setShuliang(shuliang);
	// orderaudit.setOperReason(updateReason);
	// // orderAudit.setOrderState(state);
	// orderaudit.setOperTimestamp(timeStamp);
	// orderaudit.setYewuyuanByYwyId(yewuyuanDAO.findById(yewuyuan));
	// orderaudit.setOperType("A");
	//
	// // 同时修改认刊书里的刊户，行业
	// Renkanshuaudit renkanshuinstance = (Renkanshuaudit)
	// renkanshuauditDAO.findByRenkanbianhao(renkanshuaudit.getRenkanbianhao()).get(0);
	// // 后台验证认刊书内容修改了才进行数据库端操作
	// if
	// ((sdf.format(renkanshuinstance.getQiandingriqi())).equals(sdf.format(renkanshuaudit.getQiandingriqi())))
	// {
	// } else {
	// messageTmp += "将签订日期 " + sdf.format(renkanshuinstance.getQiandingriqi())
	// + " 修改为 " + sdf.format(renkanshuaudit.getQiandingriqi()) + " ";
	// renkanshuinstance.setQiandingriqi(renkanshuaudit.getQiandingriqi());;
	// }
	// if
	// (renkanshuinstance.getGuangaokanhu().equals(renkanshuaudit.getGuangaokanhu()))
	// {
	// } else {
	// messageTmp += "将广告刊户 " + renkanshuinstance.getGuangaokanhu() + " 修改为 " +
	// renkanshuaudit.getGuangaokanhu() + " ";
	// renkanshuinstance.setGuangaokanhu(renkanshuaudit.getGuangaokanhu());
	// }
	// if (renkanshuinstance.getYwyId().equals(yewuyuan)) {
	// } else {
	// messageTmp += "将业务员 " +
	// yewuyuanDAO.findById(renkanshuinstance.getYwyId()).getYwyXingming() +
	// " 修改为 " + yewuyuanDAO.findById(yewuyuan).getYwyXingming() + " ";
	// renkanshuinstance.setYwyId(yewuyuan);
	// }
	// if (renkanshuinstance.getIndustry().getIndustryId().equals(industryId)) {
	// } else {
	// messageTmp += "将行业 " + renkanshuinstance.getIndustry().getIndustryDesc()
	// + " 修改为 " + industry.getIndustryDesc() + " ";
	// renkanshuinstance.setIndustry(industry);
	// }
	// if
	// (renkanshuinstance.getAdvertisingintentcomein().equals(renkanshuaudit.getAdvertisingintentcomein()))
	// {
	// } else {
	// messageTmp += "将合计实付 " +
	// df.format(renkanshuinstance.getAdvertisingintentcomein()) + " 修改为 " +
	// df.format(renkanshuaudit.getAdvertisingintentcomein()) + " ";
	// renkanshuinstance.setKanlizongjia(kanlizongjia);
	// }
	// if (renkanshuinstance.getZhekou().equals(renkanshuaudit.getZhekou())) {
	// } else {
	// messageTmp += "将折扣 " + renkanshuinstance.getZhekou() + " 修改为 " +
	// renkanshuaudit.getZhekou() + " ";
	// renkanshuinstance.setZhekou(renkanshuaudit.getZhekou());
	// }
	//
	// System.out.println(messageTmp);
	//
	// orderauditDAO.merge(orderaudit);
	//
	//
	// renkanshuauditDAO.merge(renkanshuinstance);
	// // 添加remark记录，以显示在业务审核页面
	// // 删除之前的remark记录
	// Remark remark = (Remark)
	// remarkDAO.findByOrderauditId(orderaudit.getId()).get(0);
	// String remarkContent = "用户主动修改：" + timeStamp + " " +
	// operUser.getYwyXingming() + " 认刊书编号：" + orderaudit.getRenkanbianhao() +
	// messageTmp;
	// if (updateReason != null && updateReason != "") {
	// remarkContent += "<br>" + "修改理由：" + updateReason;
	// }
	// remark.setOperTime(timeStamp);
	// remark.setOperYwyName(operUser.getYwyXingming());
	// remark.setOperContent(remarkContent);
	// remark.setState("A");
	// remarkDAO.merge(remark);
	// System.out.println("-------------------------orderAudit.getId:" +
	// orderaudit.getId());
	// }

	// public void upOrder(Integer userID, Integer id, String upReason) {
	// Yewuyuan operUser = yewuyuanDAO.findById(userID);
	// Yewu yewu = yewuDAO.findById(id);
	// // format的格式可以任意
	// Date datenow = new Date();
	// DateFormat sdf2TS = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	// String dateStr = sdf2TS.format(datenow);
	// Timestamp timeStamp = new Timestamp(System.currentTimeMillis());
	// String remarkContent = "" + timeStamp + " " + operUser.getYwyXingming()
	// + " 上画订单———认刊书编号：" + yewu.getRenkanshu().getRenkanbianhao()
	// + " 广告客户：" + yewu.getRenkanshu().getGuangaokanhu() + "<br>"
	// + " 上画理由：" + upReason;
	// System.out.println(remarkContent);
	// Orderaudit orderAudit = new Orderaudit();
	// orderAudit.setYewuId(id);
	// orderAudit.setRenkanbianhao(yewu.getRenkanshu().getRenkanbianhao());
	// orderAudit.setYewuyuanByOperYwyId(operUser);
	// orderAudit.setKanhu(yewu.getKanhu());
	// orderAudit.setGuanggaoneirong(yewu.getGuanggaoneirong());
	// orderAudit.setLeixing(yewu.getLeixing());
	// orderAudit.setIndustry(yewu.getIndustry());
	// orderAudit.setLed(yewu.getLed());
	// orderAudit.setShichang(yewu.getShichang());
	// orderAudit.setPinci(yewu.getPinci());
	// orderAudit.setKaishishijian(yewu.getKaishishijian());
	// orderAudit.setJieshushijian(yewu.getJieshushijian());
	// orderAudit.setShuliang(yewu.getShuliang());
	// orderAudit.setOperTimestamp(timeStamp);
	// orderAudit.setOperReason(upReason);
	// orderAudit.setOperType("O");
	// orderauditDAO.save(orderAudit);
	// Remark remark = new Remark();
	// remark.setOperTime(timeStamp);
	// remark.setOperYwyName(operUser.getYwyXingming());
	// remark.setYewu(yewu);
	// remark.setOperContent(remarkContent);
	// remark.setOrderauditId(orderAudit.getId());
	// remark.setState("A");
	// remarkDAO.save(remark);
	// // 修改品牌信息
	// // Map session = ActionContext.getContext().getSession();
	// // String username=(String) session.get("loginName");
	// // String
	// //
	// content=operUser.getYwyXingming()+"修改了认刊书编号为："+yewubefore.getRenkanshu().getRenkanbianhao()+",广告客户为："+yewubefore.getKanhu()+"的订单信息，请审核！";
	// // Message message = new Message(new Date(), 0, content, orderAudit.);
	// // messageDao.save(message);
	// }

	// public void addOrder(Integer userID, Renkanshu renkanshu, String ledId,
	// String type, Integer shichang, Integer pinci, Date kaishishijian,
	// Date jieshushijian, Double shuliang, String kanlijiaxiaoji, String
	// addReason) {
	// Yewuyuan operUser = yewuyuanDAO.findById(userID);
	// System.out.println("operUser:" + operUser);
	// Led led = ledDAO.findById(ledId);
	// System.out.println("operUser:" + operUser + "   led:" + led);
	// // format的格式可以任意
	// Date datenow = new Date();
	// DateFormat sdf2TS = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	// String dateStr = sdf2TS.format(datenow);
	// Timestamp timeStamp = new Timestamp(System.currentTimeMillis());
	// String remarkContent = "" + timeStamp + " " + operUser.getYwyXingming()
	// + " 添加订单———认刊书编号：" + renkanshu.getRenkanbianhao()
	// + " 广告客户：" + renkanshu.getGuangaokanhu() + "<br>"
	// + " 添加理由：" + addReason;
	// System.out.println(remarkContent);
	// Orderaudit orderAudit = new Orderaudit();
	// // orderAudit.setYewuId(id);
	// orderAudit.setRenkanbianhao(renkanshu.getRenkanbianhao());
	// orderAudit.setYewuyuanByOperYwyId(operUser);
	// orderAudit.setKanhu(renkanshu.getGuangaokanhu());
	// orderAudit.setGuanggaoneirong(renkanshu.getGuanggaoneirong());
	// orderAudit.setLeixing(type);
	// orderAudit.setIndustry(renkanshu.getIndustry());
	// orderAudit.setLed(led);
	// orderAudit.setShichang(shichang);
	// orderAudit.setPinci(pinci);
	// orderAudit.setKaishishijian(kaishishijian);
	// orderAudit.setJieshushijian(jieshushijian);
	// orderAudit.setShuliang(shuliang);
	// orderAudit.setOperTimestamp(timeStamp);
	// orderAudit.setOperReason(addReason);
	// orderAudit.setOperType("A");
	// orderAudit.setKanlijiaxiaoji(Double.parseDouble(kanlijiaxiaoji));
	// orderauditDAO.save(orderAudit);
	// Remark remark = new Remark();
	// remark.setOperTime(timeStamp);
	// remark.setOperYwyName(operUser.getYwyXingming());
	// //remark.setYewu(yewu);
	// remark.setOperContent(remarkContent);
	// remark.setOrderauditId(orderAudit.getId());
	// remark.setState("A");
	// remarkDAO.save(remark);
	// System.out.println("-------------------------orderAudit.getId:"
	// + orderAudit.getId());
	// }

	// //在我的认刊书中修改订单内容
	// public void addOrderForRenkanshuaudit(Integer userID, Integer
	// renkanshuauditId, String ledId,
	// String type, Integer shichang, Integer pinci, Date kaishishijian,
	// Date jieshushijian, Double shuliang, String kanlijiaxiaoji, String
	// addReason) {
	// Renkanshuaudit
	// renkanshuaudit=renkanshuauditDAO.findById(renkanshuauditId);
	// Yewuyuan operUser = yewuyuanDAO.findById(userID);
	// System.out.println("operUser:" + operUser);
	// Led led = ledDAO.findById(ledId);
	// System.out.println("operUser:" + operUser + "   led:" + led);
	// // format的格式可以任意
	// Date datenow = new Date();
	// DateFormat sdf2TS = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	// String dateStr = sdf2TS.format(datenow);
	// Timestamp timeStamp = new Timestamp(System.currentTimeMillis());
	// String remarkContent = "" + timeStamp + " " + operUser.getYwyXingming()
	// + " 添加订单———认刊书编号：" + renkanshuaudit.getRenkanbianhao()
	// + " 广告客户：" + renkanshuaudit.getGuangaokanhu() + "<br>"
	// + " 添加理由：" + addReason;
	// System.out.println(remarkContent);
	// Orderaudit orderAudit = new Orderaudit();
	// // orderAudit.setYewuId(id);
	// orderAudit.setRenkanbianhao(renkanshuaudit.getRenkanbianhao());
	// orderAudit.setYewuyuanByOperYwyId(operUser);
	// orderAudit.setKanhu(renkanshuaudit.getGuangaokanhu());
	// orderAudit.setGuanggaoneirong(renkanshuaudit.getGuanggaoneirong());
	// orderAudit.setLeixing(type);
	// orderAudit.setIndustry(renkanshuaudit.getIndustry());
	// orderAudit.setLed(led);
	// orderAudit.setShichang(shichang);
	// orderAudit.setPinci(pinci);
	// orderAudit.setKaishishijian(kaishishijian);
	// orderAudit.setJieshushijian(jieshushijian);
	// orderAudit.setShuliang(shuliang);
	// orderAudit.setOperTimestamp(timeStamp);
	// orderAudit.setOperReason(addReason);
	// orderAudit.setOperType("A");
	// orderAudit.setKanlijiaxiaoji(Double.parseDouble(kanlijiaxiaoji));
	// orderauditDAO.save(orderAudit);
	// Remark remark = new Remark();
	// remark.setOperTime(timeStamp);
	// remark.setOperYwyName(operUser.getYwyXingming());
	// //remark.setYewu(yewu);
	// remark.setOperContent(remarkContent);
	// remark.setOrderauditId(orderAudit.getId());
	// remark.setState("A");
	// remarkDAO.save(remark);
	// System.out.println("-------------------------orderAudit.getId:"
	// + orderAudit.getId());
	// }

	// public void deleteOderByID(Integer yewuyuanId, Integer idInteger) {
	// Yewuyuan operYewuyuan = yewuyuanDAO.findById(yewuyuanId);
	// Yewu yewu = yewuDAO.findById(idInteger);
	// Orderaudit orderAudit = new Orderaudit();
	// Timestamp timeStamp = new Timestamp(System.currentTimeMillis());
	// orderAudit.setYewuId(idInteger);
	// orderAudit.setRenkanbianhao(yewu.getRenkanshu().getRenkanbianhao());
	// orderAudit.setYewuyuanByOperYwyId(operYewuyuan);
	// orderAudit.setGuanggaoneirong(yewu.getGuanggaoneirong());
	// orderAudit.setIndustry(yewu.getIndustry());
	// orderAudit.setLed(yewu.getLed());
	// orderAudit.setShichang(yewu.getShichang());
	// orderAudit.setPinci(yewu.getPinci());
	// orderAudit.setKaishishijian(yewu.getKaishishijian());
	// orderAudit.setJieshushijian(yewu.getJieshushijian());
	// orderAudit.setShuliang(yewu.getShuliang());
	// orderAudit.setOperTimestamp(timeStamp);
	// orderAudit.setOperType("D");
	// orderauditDAO.save(orderAudit);
	// // format的格式可以任意
	// Date datenow = new Date();
	// DateFormat sdf2TS = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	// String dateStr = sdf2TS.format(datenow);
	// timeStamp = new Timestamp(System.currentTimeMillis());
	// String remarkContent = "" + timeStamp + " "
	// + operYewuyuan.getYwyXingming() + " 删除订单———认刊书编号："
	// + yewu.getRenkanshu().getRenkanbianhao() + " 广告客户："
	// + yewu.getRenkanshu().getGuangaokanhu() + " 广告内容："
	// + yewu.getGuanggaoneirong() + " 行业："
	// + yewu.getIndustry().getIndustryDesc() + " 广告类型："
	// + yewu.getLeixing() + " 屏幕：" + yewu.getLed().getName()
	// + " 时长：" + yewu.getShichang() + " 频次：" + yewu.getPinci()
	// + " 开始时间：" + yewu.getKaishishijian() + " 结束时间："
	// + yewu.getJieshushijian() + " 数量：" + yewu.getShuliang();
	// Remark remark = new Remark();
	// remark.setOperTime(timeStamp);
	// remark.setOperYwyName(operYewuyuan.getYwyXingming());
	// remark.setYewu(yewu);
	// remark.setOperContent(remarkContent);
	// remark.setOrderauditId(orderAudit.getId());
	// remark.setState("A");
	// remarkDAO.save(remark);
	// }

	// public void downOderByID(Integer yewuyuanId, Integer idInteger,
	// Date xiahuaDate, String xiahua_Reason) {
	// Timestamp timeStamp = new Timestamp(System.currentTimeMillis());
	// Yewuyuan operYewuyuan = yewuyuanDAO.findById(yewuyuanId);
	// Yewu yewu = yewuDAO.findById(idInteger);
	// Orderaudit orderAudit = new Orderaudit();
	// orderAudit.setYewuId(idInteger);
	// orderAudit.setRenkanbianhao(yewu.getRenkanshu().getRenkanbianhao());
	// orderAudit.setYewuyuanByOperYwyId(operYewuyuan);
	// orderAudit.setKanhu(yewu.getKanhu());
	// orderAudit.setGuanggaoneirong(yewu.getGuanggaoneirong());
	// orderAudit.setLeixing(yewu.getLeixing());
	// orderAudit.setIndustry(yewu.getIndustry());
	// orderAudit.setLed(yewu.getLed());
	// orderAudit.setShichang(yewu.getShichang());
	// orderAudit.setPinci(yewu.getPinci());
	// orderAudit.setKaishishijian(yewu.getKaishishijian());
	// // orderAudit.setJieshushijian(yewu.getJieshushijian());
	// System.out.println("-----------xiahuaDate----------------");
	// orderAudit.setJieshushijian(xiahuaDate);
	// orderAudit.setShuliang(yewu.getShuliang());
	// orderAudit.setOperTimestamp(timeStamp);
	// System.out.println("-----------xiahua_Reason前----------------");
	// orderAudit.setOperReason(xiahua_Reason);
	// System.out.println("-----------xiahua_Reason后----------------");
	// orderAudit.setOperType("U");
	// orderauditDAO.save(orderAudit);
	// // format的格式可以任意
	// Date datenow = new Date();
	// DateFormat sdf2TS = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	// String dateStr = sdf2TS.format(datenow);
	// timeStamp = new Timestamp(System.currentTimeMillis());
	// String remarkContent = "" + timeStamp + " "
	// + operYewuyuan.getYwyXingming() + " 下画订单———认刊书编号："
	// + yewu.getRenkanshu().getRenkanbianhao() + " 广告客户："
	// + yewu.getRenkanshu().getGuangaokanhu() + " 广告内容："
	// + yewu.getGuanggaoneirong() + " 行业："
	// + yewu.getIndustry().getIndustryDesc() + " 广告类型："
	// + yewu.getLeixing() + " 屏幕：" + yewu.getLed().getName()
	// + " 时长：" + yewu.getShichang() + " 频次：" + yewu.getPinci()
	// + " 开始时间：" + yewu.getKaishishijian() + " 结束时间："
	// + yewu.getJieshushijian() + " 数量：" + yewu.getShuliang()
	// + "<br>" + "下画理由：" + xiahua_Reason;
	// Remark remark = new Remark();
	// remark.setOperTime(timeStamp);
	// remark.setOperYwyName(operYewuyuan.getYwyXingming());
	// remark.setYewu(yewu);
	// remark.setOperContent(remarkContent);
	// remark.setOrderauditId(orderAudit.getId());
	// remark.setState("A");// 审核阶段状态
	// remarkDAO.save(remark);
	// }

	public List getAllIndustrytst() {
		System.out.println("调用???????????yewuService：getAllLed");
		return industryDAO.findAll();
	}

	/** 
	 * 根据led的id加载led <br>
	 * 修改日期： 2017年3月29日 下午6:14:22
	 * @author PC-FAN
	 * @param ledId
	 * @return Led
	 */
	public Led loadLed(Integer ledId) {
		return ledDAO.findById(ledId);
	}
	
	public List<Led> getLedListByName(String ledName) {
		return ledDAO.findByName(ledName);
	}

	public List getAllLed() {
		return ledDAO.findAll();
	}
	
	/**
	 * 获取激活的led列表
	 * @return
	 */
	public List<Led> getAllAvaiLed() {
		return ledDAO.findAllAvailable();
	}

	public UserDAO getUserDAO() {
		return userDAO;
	}

	public void setUserDAO(UserDAO userDAO) {
		this.userDAO = userDAO;
	}

	public LedDAO getLedDAO() {
		return ledDAO;
	}

	public void setLedDAO(LedDAO ledDAO) {
		this.ledDAO = ledDAO;
	}

	public IndustryDAO getIndustryDAO() {
		return industryDAO;
	}

	public void setIndustryDAO(IndustryDAO industryDAO) {
		this.industryDAO = industryDAO;
	}

	public PublishdetailDAO getPublishdetailDAO() {
		return publishdetailDAO;
	}

	public void setPublishdetailDAO(PublishdetailDAO publishdetailDAO) {
		this.publishdetailDAO = publishdetailDAO;
	}

}