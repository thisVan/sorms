package com.nfledmedia.sorm.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.DecimalFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;

import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import com.nfledmedia.sorm.cons.CommonConstant;
import com.nfledmedia.sorm.cons.TypeCollections;
import com.nfledmedia.sorm.entity.Adcontract;
import com.nfledmedia.sorm.entity.Led;
import com.nfledmedia.sorm.entity.Order;
import com.nfledmedia.sorm.entity.Publishdetail;
import com.nfledmedia.sorm.service.AdcontractService;
import com.nfledmedia.sorm.service.BaseService;
import com.nfledmedia.sorm.service.RenkanshuService;
import com.nfledmedia.sorm.service.YewuService;
import com.nfledmedia.sorm.util.Page;
import com.nfledmedia.sorm.util.PageToJson;
import com.nfledmedia.sorm.util.TypeNullProcess;
import com.opensymphony.xwork2.ActionContext;

import jxl.Workbook;
import jxl.format.Alignment;
import jxl.format.VerticalAlignment;
import jxl.write.Label;
import jxl.write.WritableCellFormat;
import jxl.write.WritableFont;
import jxl.write.WritableSheet;
import jxl.write.WritableWorkbook;

@Controller
public class YewuAction extends SuperAction {

	private static final long serialVersionUID = 1L;
	// 注入service
	@Autowired
	private YewuService yewuService;
	@Autowired
	private BaseService baseService;
	@Autowired
	private AdcontractService adcontractService;
	@Autowired
	private RenkanshuService renkanshuService;

	// 参数
	private int page;
	private String sidx;
	private String sord;
	private int rows;

	private boolean _search;
	private String searchField;
	private String searchString;
	private String searchOper;
	private String dateRangeSQL;

	private Integer tid;
	private Integer yewuId;

	private Integer adcontractid;
	private Integer orderid;

	public Integer getAdcontractid() {
		return adcontractid;
	}

	public void setAdcontractid(Integer adcontractid) {
		this.adcontractid = adcontractid;
	}

	/**
	 * @return the orderid
	 */
	public Integer getOrderid() {
		return orderid;
	}

	/**
	 * @param orderid
	 *            the orderid to set
	 */
	public void setOrderid(Integer orderid) {
		this.orderid = orderid;
	}

	private String kanhu;
	private String guanggaoneirong;
	private String leixing;
	private String ledId;
	private Short industryId;
	private Integer shichang;
	private Integer pinci;
	private Date kaishishijian;
	private Date jieshushijian;
	private Double shuliang;
	private String updateReason;
	private String addReason;
	private String upReason;

	public String getUpReason() {
		return upReason;
	}

	public void setUpReason(String upReason) {
		this.upReason = upReason;
	}

	private String state;

	// yejistatistic_hangye页面中Form中的数据
	private String timeRange;
	private String industry;
	private String led;
	private String startTime;
	private String endTime;
	private String selectclassifyind;

	// 业务员二级联动接收选中部门
	private String selectbumenid;
	// 认刊书审核
	private String renkanbianhao;
	// 行业年度统计
	private int annualIndustry;
	private int annualIndustry1;

	// 业绩年度统计
	private int annualYeji;
	// 屏幕年度金额统计
	private int annualLedSum;

	// 应收款统计表-年度&月份
	private Integer year;
	private Integer month;
	private Integer goalYwyId;

	private Integer renkanshuauditId;

	private String[] ledsArray;

	public String[] getLedsArray() {
		return ledsArray;
	}

	public void setLedsArray(String[] ledsArray) {
		this.ledsArray = ledsArray;
	}

	public Integer getRenkanshuauditId() {
		return renkanshuauditId;
	}

	public void setRenkanshuauditId(Integer renkanshuauditId) {
		this.renkanshuauditId = renkanshuauditId;
	}

	public String getDateRangeSQL() {
		return dateRangeSQL;
	}

	public void setDateRangeSQL(String dateRangeSQL) {
		this.dateRangeSQL = dateRangeSQL;
	}

	// 接收myauditorderupdatepage.jsp 页面传来的部分数据
	private String kanlizongjia;
	private String yewuyuan;
	private String zhekou;
	private String kanlixiaoji;
	private String qiandingriqi;

	private Integer orderauditId;

	public Integer getOrderauditId() {
		return orderauditId;
	}

	public void setOrderauditId(Integer orderauditId) {
		this.orderauditId = orderauditId;
	}

	public String getQiandingriqi() {
		return qiandingriqi;
	}

	public void setQiandingriqi(String qiandingriqi) {
		this.qiandingriqi = qiandingriqi;
	}

	public String getKanlizongjia() {
		return kanlizongjia;
	}

	public void setKanlizongjia(String kanlizongjia) {
		this.kanlizongjia = kanlizongjia;
	}

	public String getZhekou() {
		return zhekou;
	}

	public void setZhekou(String zhekou) {
		this.zhekou = zhekou;
	}

	public String getKanlixiaoji() {
		return kanlixiaoji;
	}

	public void setKanlixiaoji(String kanlixiaoji) {
		this.kanlixiaoji = kanlixiaoji;
	}

	public String getYewuyuan() {
		return yewuyuan;
	}

	public void setYewuyuan(String yewuyuan) {
		this.yewuyuan = yewuyuan;
	}

	private void sentMsg(String content) throws IOException {
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setCharacterEncoding("utf-8");
		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		out.print(content);
		out.flush();
		out.close();
	}

	public String renkanshuManageList() throws Exception {

		Map session = ActionContext.getContext().getSession();
		Integer id = (Integer) session.get(CommonConstant.SESSION_ID);
		System.out.println("调用YewuAction中的renkanshuManageList: ");
		System.out.println("  sidx=" + sidx + "  sord=" + sord + "  page=" + page + "  rows=" + rows);
		Page result = null;
		if (_search == false) {
			result = renkanshuService.getRenkanshuManageList(sidx, sord, page, rows);
		} else {
			System.out.println("searchString:" + searchString);
			result = renkanshuService.getRenkanshuManageListByKeyword(searchString, sidx, sord, page, rows);
		}

		JSONObject jsonObject = PageToJson.toJsonWithoutData(result);
		JSONArray jsonArray = new JSONArray();
		List data = result.getResult();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");
		SimpleDateFormat tdf = new SimpleDateFormat("HH:mm");
		for (int i = 0, size = data.size(); i < size; i++) {

			Object[] row = (Object[]) data.get(i);

			JSONObject jsonObject1 = new JSONObject();
			jsonObject1.put("id", row[0]);// 订单编号
			JSONArray jsonArray2 = new JSONArray(); // 求取cell
			jsonArray2.put(row[1]);// 上画点位
			// 放入客户
			if (null != row[3] && !"".equals(row[3])) {
				jsonArray2.put(row[3]);
			} else {
				jsonArray2.put(row[2]);
			}
			jsonArray2.put(row[4]);// 发布内容
			jsonArray2.put(row[13]);// 下单属性
			jsonArray2.put(row[5]);// 广告频次
			jsonArray2.put(row[6]);// 增加频次
			jsonArray2.put(row[7]);// 广告时长
			jsonArray2.put(sdf.format(row[8]) + " - " + sdf.format(row[9]));// 起止日期
			jsonArray2.put(tdf.format(row[10]) + "-" + tdf.format(row[11]));// 时段
			jsonObject1.put("cell", jsonArray2); // 加入cell
			jsonArray.put(jsonObject1);
		}
		jsonObject.put("rows", jsonArray); // 加入rows
		System.out.println("jsonObject:" + jsonObject.toString());
		sentMsg(jsonObject.toString());
		return SUCCESS;
	}

	/**
	 * 资源管理表导出为Excel
	 * 
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public String publishResourceExport() throws Exception {
		DateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		DateFormat mdf = new SimpleDateFormat("MM-dd");
		// DecimalFormat df = new DecimalFormat("#.##%");
		DecimalFormat df = new DecimalFormat("#.#%");
		List<Object[]> queryResult = renkanshuService.publishResourceList(startTime, endTime, ledId);
		List distinctQueryResult = new ArrayList();
		Set contentSet = new HashSet();
		Map<String, ArrayList> pubDateMap = new HashMap<String, ArrayList>();
		// 根据发布内容区分不同的单
		for (int i = 0; i < queryResult.size(); i++) {
			Object[] os = queryResult.get(i);
			if (contentSet.add(os[3])) {
				List l = new ArrayList();
				for (int j = 0; j < os.length; j++) {
					l.add(os[j]);
				}
				distinctQueryResult.add(l);
			}
			if (pubDateMap.containsKey(os[3])) {
				ArrayList arrList = pubDateMap.get(os[3]);
				arrList.add(os[9]);
				pubDateMap.put((String) os[3], arrList);
			} else {
				ArrayList arrList = new ArrayList();
				arrList.add(os[9]);
				pubDateMap.put((String) os[3], arrList);
			}

		}

		System.out.println(startTime + "--" + endTime + "  " + ledId);

		List resultList = new ArrayList();
		List title = new ArrayList<String>();
		String[] arr = { "序号", "屏幕", "客户", "发布内容", "下单属性", "客户属性", "频次", "增加频次", "时长", "时间" };
		for (int k = 0; k < arr.length; k++) {
			title.add(arr[k]);
		}

		// 遍历所有日期
		for (int i = 0; i < distinctQueryResult.size(); i++) {
			Date dateInx = sdf.parse(startTime);
			List subList = (ArrayList) distinctQueryResult.get(i);
			// 修改第一列的id为""最后一列日期为合计处的值为""
			subList.set(0, "");
			subList.set(9, "");
			while (dateInx.compareTo(sdf.parse(endTime)) <= 0) {
				if (pubDateMap.get(subList.get(3)).contains(dateInx)) {
					int addfreq = (Integer) ((subList.get(7) == null) ? 0 : subList.get(7));
					int procfreq = 0;
					try {
						procfreq = (((Short) subList.get(6)).intValue() + addfreq) * ((Short) subList.get(8)).intValue() / 15;
					} catch (Exception e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
						System.out.println(e);
					}
					subList.add(procfreq);
				} else {
					subList.add("");
				}

				Calendar cal = Calendar.getInstance();
				cal.setTime(dateInx);
				cal.add(Calendar.DATE, 1);
				dateInx = cal.getTime();
			}
			resultList.add(subList);
		}

		// list根据下单属性排序，规则为商业，公益，赠播
		List subListOfBuss = new ArrayList();
		List subListOfComm = new ArrayList();
		List subListOfPres = new ArrayList();
		for (int i = 0; i < resultList.size(); i++) {
			List listSort = (List) resultList.get(i);
			switch ((String) listSort.get(4)) {
			case TypeCollections.ATTRIBUTE_BUSSINESS:
				subListOfBuss.add(listSort);
				break;
			case TypeCollections.ATTRIBUTE_COMMONWEAL:
				subListOfComm.add(listSort);
				break;
			case TypeCollections.ATTRIBUTE_PRESENT:
				subListOfPres.add(listSort);
				break;
			}
		}

		// 对结果集排序，按照商业 公益 赠播 顺序排序
		List resultListSorted = new ArrayList();
		resultListSorted.addAll(subListOfBuss);
		resultListSorted.addAll(subListOfComm);
		resultListSorted.addAll(subListOfPres);

		// 增加占屏率数据
		List leds = yewuService.getLedListByName(ledId);
		List listOccuTotal = createEmptyListBySize(10);
		List listOccuBussiness = createEmptyListBySize(10);
		List listOccuPresent = createEmptyListBySize(10);
		List listOccuCommonweal = createEmptyListBySize(10);

		List listOccuTotalAmount = createEmptyListBySize(10);
		List listOccuBussinessAmount = createEmptyListBySize(10);
		List listOccuPresentAmount = createEmptyListBySize(10);
		List listOccuCommonwealAmount = createEmptyListBySize(10);

		List listOccuTotalAmountSpare = createEmptyListBySize(10);

		List listOccuBussinessAmountShare = createEmptyListBySize(10);
		List listOccuPresentAmountShare = createEmptyListBySize(10);
		List listOccuCommonwealAmountShare = createEmptyListBySize(10);

		// 表头添加日期列
		Date dateInx = sdf.parse(startTime);
		while (dateInx.compareTo(sdf.parse(endTime)) <= 0) {
			title.add(mdf.format(dateInx));
			String dateRange = sdf.format(dateInx);
			String dateRangeStr = dateRange + " " + dateRange;
			List<Map<String, Integer>> occuDataList = yewuService.calAvgScreenOccuRate4AllScreen(dateRangeStr, leds);
			listOccuTotal.set(9, "总占屏率");
			listOccuTotal.add(
					df.format(TypeNullProcess.nullValueProcess(occuDataList.get(0).get(ledId)) / (double) occuDataList.get(1).get(ledId)));
			listOccuBussiness.set(9, "商业占屏率");
			listOccuBussiness.add(df.format(
					(Integer) TypeNullProcess.nullValueProcess(occuDataList.get(2).get(ledId)) / (double) occuDataList.get(1).get(ledId)));
			listOccuPresent.set(9, "赠播占屏率");
			listOccuPresent.add(df.format(
					(Integer) TypeNullProcess.nullValueProcess(occuDataList.get(3).get(ledId)) / (double) occuDataList.get(1).get(ledId)));
			listOccuCommonweal.set(9, "公益占屏率");
			listOccuCommonweal.add(df.format(
					(Integer) TypeNullProcess.nullValueProcess(occuDataList.get(4).get(ledId)) / (double) occuDataList.get(1).get(ledId)));

			listOccuTotalAmount.set(9, "合计");
			listOccuTotalAmount.add(TypeNullProcess.nullValueProcess(occuDataList.get(0).get(ledId)) / 15);// 合计总量，LED屏总播放时间除以15s
			listOccuBussinessAmount.set(9, "商业小计");
			listOccuBussinessAmount.add(TypeNullProcess.nullValueProcess(occuDataList.get(2).get(ledId)) / 15);
			listOccuPresentAmount.set(9, "赠播小计");
			listOccuPresentAmount.add(TypeNullProcess.nullValueProcess(occuDataList.get(3).get(ledId)) / 15);
			listOccuCommonwealAmount.set(9, "公益小计");
			listOccuCommonwealAmount.add(TypeNullProcess.nullValueProcess(occuDataList.get(4).get(ledId)) / 15);

			listOccuTotalAmountSpare.set(9, "余量");
			listOccuTotalAmountSpare
					.add(occuDataList.get(1).get(ledId) / 15 - TypeNullProcess.nullValueProcess(occuDataList.get(0).get(ledId)) / 15);// 合计余量

			listOccuBussinessAmountShare.set(9, "商业占比");
			listOccuBussinessAmountShare.add(df.format(TypeNullProcess.nullValueProcess(occuDataList.get(2).get(ledId))
					/ (double) TypeNullProcess.nullValueProcess(occuDataList.get(0).get(ledId))));
			listOccuPresentAmountShare.set(9, "赠播占比");
			listOccuPresentAmountShare.add(df.format(TypeNullProcess.nullValueProcess(occuDataList.get(3).get(ledId))
					/ (double) TypeNullProcess.nullValueProcess(occuDataList.get(0).get(ledId))));
			listOccuCommonwealAmountShare.set(9, "公益占比");
			listOccuCommonwealAmountShare.add(df.format(TypeNullProcess.nullValueProcess(occuDataList.get(4).get(ledId))
					/ (double) TypeNullProcess.nullValueProcess(occuDataList.get(0).get(ledId))));

			Calendar cal = Calendar.getInstance();
			cal.setTime(dateInx);
			cal.add(Calendar.DATE, 1);
			dateInx = cal.getTime();
		}

		// 结果集处理
		resultListSorted.add(0, listOccuTotalAmount);
		resultListSorted.add(1, listOccuTotal);
		resultListSorted.add(2, listOccuTotalAmountSpare);

		int insertPoint = 3;

		if (subListOfBuss.size() > 0) {
			insertPoint += subListOfBuss.size();
			if (insertPoint > resultListSorted.size()) {
				resultListSorted.add(listOccuBussinessAmount);
			} else {
				resultListSorted.add(insertPoint, listOccuBussinessAmount);
			}
			insertPoint++;
			if (insertPoint > resultListSorted.size()) {
				resultListSorted.add(listOccuBussinessAmountShare);
			} else {
				resultListSorted.add(insertPoint, listOccuBussinessAmountShare);
			}
			insertPoint++;

		}
		if (subListOfComm.size() > 0) {
			insertPoint += subListOfComm.size();
			if (insertPoint > resultListSorted.size()) {
				resultListSorted.add(listOccuCommonwealAmount);
			} else {
				resultListSorted.add(insertPoint, listOccuCommonwealAmount);
			}
			insertPoint++;
			if (insertPoint > resultListSorted.size()) {
				resultListSorted.add(listOccuCommonwealAmountShare);
			} else {
				resultListSorted.add(insertPoint, listOccuCommonwealAmountShare);
			}
			insertPoint++;
		}
		if (subListOfPres.size() > 0) {
			insertPoint += subListOfPres.size();
			if (insertPoint > resultListSorted.size()) {
				resultListSorted.add(listOccuPresentAmount);
			} else {
				resultListSorted.add(insertPoint, listOccuPresentAmount);
			}
			insertPoint++;
			if (insertPoint > resultListSorted.size()) {
				resultListSorted.add(listOccuPresentAmountShare);
			} else {
				resultListSorted.add(insertPoint, listOccuPresentAmountShare);
			}
			insertPoint++;
		}

		// 添加序号
		int sequence = 1;
		for (int i = 0; i < resultListSorted.size(); i++) {

			List theLst = (List) resultListSorted.get(i);
			if (theLst.get(1) != null && ((String) theLst.get(1)).length() > 0) {
				theLst.set(0, sequence);
				sequence++;
			}

		}

		// exportExcel方法只接受object[]此处将list转为object[]
		String[] sheetTitles = new String[title.size()];
		SimpleDateFormat hhmmFormat = new SimpleDateFormat("HH:mm");
		Led theLed = baseService.getLedByName(ledId);
		String ledTimeRange = hhmmFormat.format(theLed.getStarttime()) + "-" + hhmmFormat.format(theLed.getEndtime());
		sheetTitles[0] = ledId + "(" + ledTimeRange + ")" + " " + "(" + theLed.getAvlduration() / 15 + "次" + "/15s" + ")";
		String[] titles = new String[title.size()];
		for (int i = 0; i < title.size(); i++) {
			titles[i] = (String) title.get(i);
		}
		List list = new ArrayList();

		for (int i = 0; i < resultListSorted.size(); i++) {
			ArrayList tlist = (ArrayList) resultListSorted.get(i);
			Object[] objs = new Object[tlist.size()];
			for (int j = 0; j < tlist.size(); j++) {
				objs[j] = tlist.get(j);
			}
			list.add(objs);
		}
		String fileName = new String(ledId + "资源管理表" + startTime + "-" + endTime);
		String codedFileName = java.net.URLEncoder.encode(fileName, "UTF-8");
		// ExcelUtil.exportExcel(codedFileName, titles, list);

		// \\以下为绘制表格//\\
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setContentType("aplication/vnd.ms-excel");
		response.addHeader("Content-Disposition", "inline; filename=" + codedFileName + ".xls");

		// System.out.println("-----fileName-------"+fileName);
		try {
			// 创建Excel工作薄

			WritableWorkbook wwb = Workbook.createWorkbook(response.getOutputStream());

			// WritableWorkbook wwb = Workbook.createWorkbook(new
			// File(fileName+".xls"));

			// 添加第一个工作表并设置第一个Sheet的名字 ,所以只是sheet的名字，文件名仍为日期
			WritableSheet sheet = wwb.createSheet(fileName, 0);

			Label label;

			// 设置列宽度
			sheet.setColumnView(0, 10);
			sheet.setColumnView(3, 10);
			sheet.setColumnView(6, 10);

			// 单元格样式
			WritableFont writableFont = new WritableFont(WritableFont.createFont("微软雅黑"), 10, WritableFont.BOLD);
			WritableCellFormat wcf_titles = new WritableCellFormat(writableFont);
			wcf_titles.setBackground(jxl.format.Colour.YELLOW);
			wcf_titles.setVerticalAlignment(VerticalAlignment.CENTRE);

			// 添加表头标题
			if (sheetTitles != null) {
				for (int i = 0; i < sheetTitles.length; i++) {
					label = new Label(i, 0, sheetTitles[i], wcf_titles);
					sheet.addCell(label);
				}
			}

			WritableCellFormat wcfTtitles = new WritableCellFormat();
			wcfTtitles.setVerticalAlignment(VerticalAlignment.CENTRE);
			wcfTtitles.setAlignment(Alignment.CENTRE);
			// 添加标题
			if (titles != null) {
				for (int i = 0; i < titles.length; i++) {
					label = new Label(i, 1, titles[i], wcfTtitles);
					sheet.addCell(label);
				}
			}

			// 下面是填充数据
			if (list != null && list.size() > 0) {
				for (int i = 0, size = list.size(); i < size; i++) {
					for (int j = 0; j < titles.length; j++) {
						Object[] row = (Object[]) list.get(i);
						String value = null;
						if (row[j] != null)
							value = row[j].toString();
						if (value != null && !value.equals("")) {
							label = new Label(j, i + 2, value, wcfTtitles);
						} else {
							label = new Label(j, i + 2, "", wcfTtitles);
						}
						sheet.addCell(label);
					}
				}
			}

			// 合并单元格
			sheet.mergeCells(0, 0, titles.length - 1, 0);

			sheet.mergeCells(0, 1, 0, 4);
			sheet.mergeCells(1, 1, 1, 4);
			sheet.mergeCells(2, 1, 2, 4);
			sheet.mergeCells(3, 1, 3, 4);
			sheet.mergeCells(4, 1, 4, 4);
			sheet.mergeCells(5, 1, 5, 4);
			sheet.mergeCells(6, 1, 6, 4);
			sheet.mergeCells(7, 1, 7, 4);
			sheet.mergeCells(8, 1, 8, 4);

			wwb.write();
			// 关闭
			wwb.close();

		} catch (Exception e) {
			e.printStackTrace();
			System.out.println(e);

		}

		return null;

	}

	/**
	 * 广告内容汇总表导出为Excel
	 * 
	 * @return
	 * @throws Exception
	 */
	public String adcontentStatisticExport() throws Exception {
		DateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		List<Publishdetail> queryResult = renkanshuService.publishInTimerangeList(startTime, endTime);
		List distinctQueryResult = new ArrayList();
		Set contentSet = new HashSet();
		Map<String, Integer> pubContentCountMap = new HashMap<String, Integer>();
		// 根据发布内容区分不同的单
		for (int i = 0; i < queryResult.size(); i++) {
			Publishdetail pbs = queryResult.get(i);
			if (contentSet.add(pbs.getAdcontent())) {
				distinctQueryResult.add(pbs);
				// adcontent计数集中没有key，添加
				pubContentCountMap.put(pbs.getAdcontent(), 1);
			} else {
				// adcontent计数集中没有key，计数自加
				if (pubContentCountMap.containsKey(pbs.getAdcontent())) {
					pubContentCountMap.put(pbs.getAdcontent(), pubContentCountMap.get(pbs.getAdcontent()) + 1);
				}
			}
		}

		System.out.println(startTime + "--" + endTime + "  " + ledId);

		List resultList = new ArrayList();
		List title = new ArrayList<String>();
		String[] arr = { "序号", "广告客户", "发布内容", "类别", "投放量(屏幕数*天数)" };
		for (int k = 0; k < arr.length; k++) {
			title.add(arr[k]);
		}

		for (int i = 0, n = distinctQueryResult.size(); i < n; i++) {
			List dataList = new ArrayList();
			Publishdetail thisPbs = (Publishdetail) distinctQueryResult.get(i);
			dataList.add("");
			dataList.add(thisPbs.getClient());
			dataList.add(thisPbs.getAdcontent());
			try {
				System.out.println(renkanshuService.getOrderById(thisPbs.getOrderid()));
			} catch (Exception e) {
				// TODO Auto-generated catch block
				System.out.println(e);
				e.printStackTrace();
			}
			dataList.add(renkanshuService.getOrderById(thisPbs.getOrderid()).getIndustry().getIndustryname());
			dataList.add(pubContentCountMap.get(thisPbs.getAdcontent()));

			resultList.add(dataList);

		}

		// 添加序号
		int sequence = 1;
		for (int i = 0; i < resultList.size(); i++) {

			List theLst = (List) resultList.get(i);
			if (theLst.get(1) != null && ((String) theLst.get(1)).length() > 0) {
				theLst.set(0, sequence);
				sequence++;
			}

		}

		// exportExcel方法只接受object[]此处将list转为object[]
		String[] sheetTitles = new String[title.size()];
		String[] timearrs = startTime.split("-");
		String ledTimeRange = timearrs[0] + "年" + timearrs[1] + "月";
		sheetTitles[0] = ledTimeRange + "LED广告发布客户";
		String[] titles = new String[title.size()];
		for (int i = 0; i < title.size(); i++) {
			titles[i] = (String) title.get(i);
		}
		List list = new ArrayList();

		for (int i = 0; i < resultList.size(); i++) {
			ArrayList tlist = (ArrayList) resultList.get(i);
			Object[] objs = new Object[tlist.size()];
			for (int j = 0; j < tlist.size(); j++) {
				objs[j] = tlist.get(j);
			}
			list.add(objs);
		}
		String fileName = new String(sheetTitles[0]);
		String codedFileName = java.net.URLEncoder.encode(fileName, "UTF-8");
		// ExcelUtil.exportExcel(codedFileName, titles, list);

		// \\以下为绘制表格//\\
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setContentType("aplication/vnd.ms-excel");
		response.addHeader("Content-Disposition", "inline; filename=" + codedFileName + ".xls");

		// System.out.println("-----fileName-------"+fileName);
		try {
			// 创建Excel工作薄

			WritableWorkbook wwb = Workbook.createWorkbook(response.getOutputStream());

			// WritableWorkbook wwb = Workbook.createWorkbook(new
			// File(fileName+".xls"));

			// 添加第一个工作表并设置第一个Sheet的名字 ,所以只是sheet的名字，文件名仍为日期
			WritableSheet sheet = wwb.createSheet(fileName, 0);

			Label label;

			// 设置列宽度
			// CellView dataCellView = new CellView();
			// dataCellView.setAutosize(true); //设置自动大小
			// sheet.setColumnView(0, 10);
			// sheet.setColumnView(3, 10);

			// 单元格样式
			WritableFont writableFont = new WritableFont(WritableFont.createFont("微软雅黑"), 11, WritableFont.BOLD);
			WritableCellFormat wcf_titles = new WritableCellFormat(writableFont);
			wcf_titles.setBackground(jxl.format.Colour.YELLOW);
			wcf_titles.setAlignment(Alignment.CENTRE);
			wcf_titles.setVerticalAlignment(VerticalAlignment.CENTRE);

			// 添加表头标题
			if (sheetTitles != null) {
				for (int i = 0; i < sheetTitles.length - 1; i++) {
					label = new Label(i, 0, sheetTitles[i], wcf_titles);
					sheet.addCell(label);
				}
			}

			WritableCellFormat wcfTtitles = new WritableCellFormat(new WritableFont(WritableFont.createFont("宋体"), 10, WritableFont.BOLD));
			wcfTtitles.setVerticalAlignment(VerticalAlignment.CENTRE);
			wcfTtitles.setAlignment(Alignment.CENTRE);
			// 添加标题
			if (titles != null) {
				for (int i = 0; i < titles.length - 1; i++) {
					// sheet.setColumnView(i,sheet.getCell(i,1).getContents().length()*2+6);
					label = new Label(i, 1, titles[i], wcfTtitles);
					sheet.addCell(label);
				}
			}

			WritableCellFormat dataRowCellFormat = new WritableCellFormat(new WritableFont(WritableFont.createFont("宋体"), 10));
			dataRowCellFormat.setVerticalAlignment(VerticalAlignment.CENTRE);
			dataRowCellFormat.setAlignment(Alignment.CENTRE);

			// 下面是填充数据
			if (list != null && list.size() > 0) {
				for (int i = 0, size = list.size(); i < size; i++) {
					for (int j = 0; j < titles.length - 1; j++) {
						Object[] row = (Object[]) list.get(i);
						String value = null;
						if (row[j] != null)
							value = row[j].toString();
						if (value != null && !value.equals("")) {
							label = new Label(j, i + 2, value, dataRowCellFormat);
						} else {
							label = new Label(j, i + 2, "", dataRowCellFormat);
						}
						sheet.addCell(label);
					}
				}
			}

			// 合并单元格
			sheet.mergeCells(0, 0, titles.length - 2, 0);

			if (list != null && list.size() > 0) {

				for (int i = 0, size = list.size(); i < size; i++) {
					for (int j = 0; j < titles.length - 1; j++) {
						System.out.println(sheet.getCell(j, i + 2).getContents().length());
						sheet.setColumnView(j, sheet.getCell(j, i + 2).getContents().length() * 2 + 8);
					}
				}
			}

			wwb.write();
			// 关闭
			wwb.close();

		} catch (Exception e) {
			e.printStackTrace();
			System.out.println(e);

		}

		return null;

	}

	/**
	 * 广告发布安排表导出为Excel
	 * 
	 * @return
	 * @throws Exception
	 */
	public String publishArrangementExport() throws Exception {
		DateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		DateFormat sdfMd = new SimpleDateFormat("MM.dd");
		DateFormat sdfHm = new SimpleDateFormat("HH:mm");
		// ledList 主要是处理多led的请求，导出excel要求表格为根据led生成不同的sheet
		List<Led> ledList = new ArrayList<Led>();
		for (int i = 0; i < ledsArray.length; i++) {
			Led led = baseService.getLedById(Integer.valueOf(ledsArray[i]));
			ledList.add(led);
		}

		// 数据集
		List ledListDataRow = new ArrayList();
		for (int i = 0; i < ledList.size(); i++) {

			Led thisLed = ledList.get(i);
			String timerangeStr = "(" + sdfHm.format(thisLed.getStarttime()) + "-" + sdfHm.format(thisLed.getEndtime()) + ")";
			String positionAndTimerange = thisLed.getName() + timerangeStr;

			List dateListData = new ArrayList();
			// 表头添加日期列
			Date dateInx = sdf.parse(startTime);
			List theDateListRow = null;
			try {
				while (dateInx.compareTo(sdf.parse(endTime)) <= 0) {
					theDateListRow = new ArrayList();
					// 1.查询出order列表
					List dataResultOnDate = renkanshuService.getOrderOnDateByLed(sdf.format(dateInx), thisLed.getId());
					// 2.处理列表，发布内容相同的项目合并发布日期，获取备注
					Map<String, ArrayList> orderApendDateRangeListMap = new HashMap<String, ArrayList>();
					int dateDataRowCount = 1;
					for (int j = 0; j < dataResultOnDate.size(); j++) {
						Order ord = (Order) dataResultOnDate.get(j);
						String dateRangeStr = "";
						if (sdfHm.format(thisLed.getStarttime()).equals(sdfHm.format(ord.getStarttime()))
								&& sdfHm.format(thisLed.getEndtime()).equals(sdfHm.format(ord.getEndtime()))) {
							dateRangeStr = sdfMd.format(ord.getStartdate()) + "-" + sdfMd.format(ord.getEnddate()) + "; ";
						} else {
							dateRangeStr = sdfMd.format(ord.getStartdate()) + "-" + sdfMd.format(ord.getEnddate()) + "("
									+ sdfHm.format(ord.getStarttime()) + "-" + sdfHm.format(ord.getEndtime()) + ");";
						}

						if (orderApendDateRangeListMap.containsKey(ord.getContent())) {

						} else {
							// 没有则添加list
							ArrayList dateListDataRow = new ArrayList();
							dateListDataRow.add(sdfMd.format(dateInx));// 日期
							dateListDataRow.add(positionAndTimerange);// 位置
							dateListDataRow.add(dateDataRowCount);// 序号
							dateListDataRow.add(getOrderClient(ord));// 客户
							dateListDataRow.add(ord.getContent());// 发布内容
							dateListDataRow.add(ord.getFrequency());// 频次
							dateListDataRow.add(ord.getAddfreq());// 增加频次
							dateListDataRow.add(ord.getDuration());// 长度
							dateListDataRow.add(dateRangeStr);// 起止日期，index=8
							dateListDataRow.add(ord.getAdcontract().getRemark());// 备注

							orderApendDateRangeListMap.put(ord.getContent(), dateListDataRow);

							dateDataRowCount++;

						}

					}

					List<Order> allDataByLed = renkanshuService.getOrderByLed(thisLed.getId());
					for (Order o : allDataByLed) {
						String dateRangeStr = "";
						if (sdfHm.format(thisLed.getStarttime()).equals(sdfHm.format(o.getStarttime()))
								&& sdfHm.format(thisLed.getEndtime()).equals(sdfHm.format(o.getEndtime()))) {
							dateRangeStr = sdfMd.format(o.getStartdate()) + "-" + sdfMd.format(o.getEnddate()) + "; ";
						} else {
							dateRangeStr = sdfMd.format(o.getStartdate()) + "-" + sdfMd.format(o.getEnddate()) + "("
									+ sdfHm.format(o.getStarttime()) + "-" + sdfHm.format(o.getEndtime()) + ");";
						}

						if (orderApendDateRangeListMap.containsKey(o.getContent())) {
							// 如果有修改起止日期
							ArrayList arrLst = orderApendDateRangeListMap.get(o.getContent());
							// 此处arrLst为空的话，判断是order重复
							if (arrLst != null && !arrLst.isEmpty()) {
								String sourceStr = (String) orderApendDateRangeListMap.get(o.getContent()).get(8);
								String[] srcStrArr = sourceStr.split(";");
								for (int j = 0; j < srcStrArr.length; j++) {
									if (!dateRangeStr.substring(0, dateRangeStr.length() - 1).equals(srcStrArr[j])) {
										String dateRangeApend = sourceStr + dateRangeStr;
										arrLst.set(8, dateRangeApend);
										orderApendDateRangeListMap.put(o.getContent(), arrLst);
									}
								}

							}
						}
					}

					for (Iterator iterator = orderApendDateRangeListMap.entrySet().iterator(); iterator.hasNext();) {
						Entry entry = (Entry) iterator.next();
						ArrayList arrlist = (ArrayList) entry.getValue();
						theDateListRow.add(arrlist);
					}

					// 根据序号排序
					Collections.sort(theDateListRow, new Comparator() {
						@Override
						public int compare(Object o1, Object o2) {
							ArrayList arrl1 = (ArrayList) o1;
							ArrayList arrl2 = (ArrayList) o2;
							if ((int) arrl1.get(2) > (int) arrl2.get(2)) {
								return 1;
							} else if ((int) arrl1.get(2) == (int) arrl2.get(2)) {
								return 0;
							} else {
								return -1;
							}
						}
					});

					dateListData.add(theDateListRow);

					Calendar cal = Calendar.getInstance();
					cal.setTime(dateInx);
					cal.add(Calendar.DATE, 1);
					dateInx = cal.getTime();
				}
			} catch (Exception e) {
				// TODO Auto-generated catch block
				System.out.println(e);
				e.printStackTrace();
			}

			ledListDataRow.add(dateListData);
		}

		for (int i = 0; i < ledListDataRow.size(); i++) {
			ArrayList tlst = (ArrayList) ledListDataRow.get(i);
			for (Iterator iterator = tlst.iterator(); iterator.hasNext();) {
				ArrayList object = (ArrayList) iterator.next();
				for (Iterator iterator2 = object.iterator(); iterator2.hasNext();) {
					Object object2 = iterator2.next();
					System.out.print(object2 + " ");
				}
				System.out.println();
			}
		}

		System.out.println(startTime + "--" + endTime + "  " + ledId);

		// ------------------------以下为绘制表格------------------------

		List resultList = new ArrayList();
		List title = new ArrayList<String>();
		String[] arr = { "日期", "位置", "序号", "客户", "发布内容", "频次", "增加", "长度", "起止日期", "备注" };
		for (int k = 0; k < arr.length; k++) {
			title.add(arr[k]);
		}

		// exportExcel方法只接受object[]此处将list转为object[]
		String[] sheetTitles = new String[title.size()];
		String[] timearrs = startTime.split("-");
		String ledTimeRange = timearrs[0] + "年" + timearrs[1] + "月";
		sheetTitles[0] = ledTimeRange + "LED广告发布安排表";
		String[] titles = new String[title.size()];
		for (int i = 0; i < title.size(); i++) {
			titles[i] = (String) title.get(i);
		}

		String fileName = new String(sheetTitles[0]);
		String codedFileName = java.net.URLEncoder.encode(fileName, "UTF-8");

		HttpServletResponse response = ServletActionContext.getResponse();
		response.setContentType("aplication/vnd.ms-excel");
		response.addHeader("Content-Disposition", "inline; filename=" + codedFileName + ".xls");

		try {
			// 创建Excel工作薄
			WritableWorkbook wwb = Workbook.createWorkbook(response.getOutputStream());

			// 添加第一个工作表并设置第一个Sheet的名字 ,所以只是sheet的名字，文件名仍为日期
			for (int k = 0, t = ledListDataRow.size(); k < t; k++) {
				WritableSheet sheet = wwb.createSheet(ledList.get(k).getName(), k);

				Label label;

				// 单元格样式
				WritableFont writableFont = new WritableFont(WritableFont.createFont("微软雅黑"), 11, WritableFont.BOLD);
				WritableCellFormat wcf_titles = new WritableCellFormat(writableFont);
				wcf_titles.setBackground(jxl.format.Colour.YELLOW);
				wcf_titles.setAlignment(Alignment.CENTRE);
				wcf_titles.setVerticalAlignment(VerticalAlignment.CENTRE);

				// 添加表头标题
				if (sheetTitles != null) {
					for (int i = 0; i < sheetTitles.length - 1; i++) {
						label = new Label(i, 0, sheetTitles[i], wcf_titles);
						sheet.addCell(label);
					}
				}

				WritableCellFormat wcfTtitles = new WritableCellFormat(
						new WritableFont(WritableFont.createFont("宋体"), 10, WritableFont.BOLD));
				wcfTtitles.setVerticalAlignment(VerticalAlignment.CENTRE);
				wcfTtitles.setAlignment(Alignment.CENTRE);
				// 添加标题
				if (titles != null) {
					for (int i = 0; i < titles.length; i++) {
						// sheet.setColumnView(i,sheet.getCell(i,1).getContents().length()*2+6);
						label = new Label(i, 1, titles[i], wcfTtitles);
						sheet.addCell(label);
					}
				}

				WritableCellFormat dataRowCellFormat = new WritableCellFormat(new WritableFont(WritableFont.createFont("宋体"), 10));
				dataRowCellFormat.setVerticalAlignment(VerticalAlignment.CENTRE);
				dataRowCellFormat.setAlignment(Alignment.CENTRE);
				dataRowCellFormat.setWrap(true);

				int mergeCellPoint = 2;
				ArrayList dateArrList = new ArrayList();
				dateArrList = (ArrayList) ledListDataRow.get(k);
				for (int p = 0; p < dateArrList.size(); p++) {
					List list = new ArrayList();
					list = list2ObjectArray((ArrayList) dateArrList.get(p));
					// 下面是填充数据
					if (list != null && list.size() > 0) {
						for (int i = 0, size = list.size(); i < size; i++) {
							for (int j = 0; j < titles.length - 1; j++) {
								Object[] row = (Object[]) list.get(i);
								String value = null;
								if (row[j] != null)
									value = row[j].toString();
								if (value != null && !value.equals("")) {
									label = new Label(j, i + mergeCellPoint, value, dataRowCellFormat);
								} else {
									label = new Label(j, i + mergeCellPoint, "", dataRowCellFormat);
								}
								sheet.addCell(label);
							}
						}
					}

					// 合并单元格
					int pointOffset = list.size();
					// 相同日期和位置合并
					sheet.mergeCells(0, mergeCellPoint, 0, mergeCellPoint + pointOffset - 1);
					sheet.mergeCells(1, mergeCellPoint, 1, mergeCellPoint + pointOffset - 1);

					mergeCellPoint += pointOffset;

					// 设置列宽度
					if (list != null && list.size() > 0) {

						for (int i = 0, size = list.size(); i < size; i++) {
							// 第一列和第二列，索引位置0，1设置固定宽度
							sheet.setColumnView(0, 10);
							sheet.setColumnView(1, 30);
							for (int j = 2; j < titles.length - 1; j++) {
								// System.out.println(sheet.getCell(j,i +
								// 2).getContents().length());
								sheet.setColumnView(j, sheet.getCell(j, i + 2).getContents().length() * 2 + 8);
							}
						}
					}
				}

				// 1.表头标题合并
				sheet.mergeCells(0, 0, titles.length - 1, 0);
			}

			wwb.write();
			// 关闭
			wwb.close();

		} catch (Exception e) {
			e.printStackTrace();
			System.out.println(e);

		}

		return null;

	}

	public String calcScreenRate() {

		return addReason;

	}

	public List createEmptyListBySize(int n) {
		List l = new ArrayList();
		for (int i = 0; i < n; i++) {
			l.add("");
		}
		return l;
	}

	/**
	 * list转为object[]
	 * 
	 * @param resultList
	 * @return
	 */
	public ArrayList list2ObjectArray(List resultList) {
		ArrayList list = new ArrayList();
		for (int i = 0; i < resultList.size(); i++) {
			ArrayList tlist = (ArrayList) resultList.get(i);
			Object[] objs = new Object[tlist.size()];
			for (int j = 0; j < tlist.size(); j++) {
				objs[j] = tlist.get(j);
			}
			list.add(objs);
		}
		return list;
	}

	// 获取月初时间
	public static Date getTimesMonthmorning(int year, int month) {
		Calendar cal = Calendar.getInstance();
		cal.set(year, month, 1, 0, 0, 0);
		cal.set(Calendar.DAY_OF_MONTH, cal.getActualMinimum(Calendar.DAY_OF_MONTH));
		return cal.getTime();
	}

	// 获取月末时间
	public static Date getTimesMonthnight(int year, int month) {
		Calendar cal = Calendar.getInstance();
		cal.set(year, month, 1, 0, 0, 0);
		cal.set(Calendar.DAY_OF_MONTH, cal.getActualMaximum(Calendar.DAY_OF_MONTH));
		cal.set(Calendar.DATE, cal.get(cal.DATE) - 1);
		cal.set(Calendar.HOUR_OF_DAY, 24);
		return cal.getTime();
	}

	/**
	 * 计算在startTimeLong和endTimeLong时间范围内订单的播放天数占所有天数的比例
	 * 
	 * @param object1
	 *            订单播放开始时间
	 * @param object2
	 *            订单播放结束时间
	 * @param startTimeLong
	 *            时间范围起始时间
	 * @param endTimeLong
	 *            时间范围结束时间
	 * @return 返回比例
	 * @throws ParseException
	 */
	public Double daysRatio(Object object1, Object object2, Long startTimeLong, Long endTimeLong) throws ParseException {
		long onedaytmp = 24 * 3600 * 1000;
		DateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		String kaishittm = sdf.format(object1);
		String jieshutm = sdf.format(object2);
		Date dtKaishitm = sdf.parse(kaishittm);// 开始日期
		Date dtJieshutm = sdf.parse(jieshutm);// 结束日期
		long kaishishijianLong = dtKaishitm.getTime();
		long jieshushijianLong = dtJieshutm.getTime();
		int days = (int) ((jieshushijianLong - kaishishijianLong) / onedaytmp) + 1;
		int countdays = 0;
		// 计算在本月中某条订单的播放天数，分为四种情况
		if (jieshushijianLong >= startTimeLong && jieshushijianLong <= endTimeLong && kaishishijianLong <= startTimeLong) {
			countdays = (int) ((jieshushijianLong - startTimeLong) / onedaytmp) + 1;
		} else if (jieshushijianLong >= startTimeLong && jieshushijianLong <= endTimeLong && kaishishijianLong >= startTimeLong
				&& kaishishijianLong <= endTimeLong) {
			countdays = (int) ((jieshushijianLong - kaishishijianLong) / onedaytmp) + 1;
		} else if (jieshushijianLong >= endTimeLong && kaishishijianLong >= startTimeLong && kaishishijianLong <= endTimeLong) {
			countdays = (int) ((endTimeLong - kaishishijianLong) / onedaytmp) + 1;
		} else if (jieshushijianLong >= endTimeLong && kaishishijianLong <= startTimeLong) {
			countdays = (int) ((endTimeLong - startTimeLong) / onedaytmp) + 1;
		}
		System.out.println("时间段内的天数countdays:" + countdays + "    总天数days:" + days);
		return (double) ((countdays / 1.00000) / (days / 1.00000));
	}

	public String annualLedAmountReport() throws Exception {

		return SUCCESS;
	}

	public String annualPerformanceReport() throws Exception {

		return SUCCESS;
	}

	/**
	 * 
	 * TODO 每个屏的平均占屏率，分屏列出 <br>
	 * 
	 * @author PC-FAN
	 * @throws Exception
	 * @return String
	 */
	public String avgOccuRateListByScreen() throws Exception {
		// Map session = ActionContext.getContext().getSession();
		// Integer id = (Integer) session.get(CommonConstant.SESSION_ID);
		DecimalFormat df = new DecimalFormat("0.00");
		JSONObject jsonObject = new JSONObject();
		List<Led> leds = yewuService.getAllAvaiLed();
		// data类型为map组成的list
		// String dateRangeSQL = "2017-11-30 2017-11-30";
		if (dateRangeSQL == null || dateRangeSQL.length() == 0) {
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			dateRangeSQL = sdf.format(new Date()) + " " + sdf.format(new Date());
		}
		List<?> data = yewuService.calAvgScreenOccuRate4AllScreen(dateRangeSQL, leds);

		Map<?, ?> mapBofang = (Map<?, ?>) data.get(0);
		Map<?, ?> mapTotal = (Map<?, ?>) data.get(1);

		String ledName = "";
		double ledOccuRate = 0;

		JSONArray ledNames = new JSONArray();
		JSONArray ledOccus = new JSONArray();
		for (int i = 0, size = leds.size(); i < size; i++) {

			ledName = ((Led) leds.get(i)).getName();
			// System.out.println("key:" + mapBofang.get(ledName));
			if (mapBofang.containsKey(ledName)) {
				try {
					ledOccuRate = Double.parseDouble(mapBofang.get(ledName).toString()) / (Integer) mapTotal.get(ledName) * 100;
				} catch (Exception e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			} else {
				ledOccuRate = 0;
			}

			ledNames.put(ledName);
			ledOccus.put(df.format(ledOccuRate));
		}

		JSONObject jsonObject1 = new JSONObject();
		jsonObject1.put("ledName", ledNames);
		jsonObject1.put("ledOccuRate", ledOccus);

		jsonObject.put("ledOccuRates", jsonObject1);
		// jsonObject.put("errorMsg", "服务器错误！");
		sentMsg(jsonObject.toString());
		return null;
	}

	public String returnLedSSTime() throws Exception {

		JSONObject jsonObject = new JSONObject();
		jsonObject.put("state", 0);
		jsonObject.put("startTime", baseService.returnSETimeByLedId(Integer.parseInt(ledId))[0]);
		jsonObject.put("endTime", baseService.returnSETimeByLedId(Integer.parseInt(ledId))[1]);
		sentMsg(jsonObject.toString());
		return null;

	}

	public String updateOrderPage() throws Exception {
		ActionContext ctx = ActionContext.getContext();
		Order order = adcontractService.getOrderById(orderid);
		Adcontract adcontract = order.getAdcontract();
		ctx.put("ledList", baseService.ledList());
		ctx.put("industryList", baseService.industryList());
		ctx.put("attributeList", baseService.attributeList());
		ctx.put("clienttypeList", baseService.clienttypeList());
		ctx.put("channelList", baseService.channelList());
		ctx.put("adcontract", adcontract);
		ctx.put("order", order);
		return SUCCESS;
	}

	/**
	 * 占屏率图表，以日期列出
	 * 
	 * @return
	 * @throws Exception
	 */
	public String screenOccuRateListByDate() throws Exception {

		DecimalFormat df = new DecimalFormat("0.00");
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		SimpleDateFormat ssdf = new SimpleDateFormat("MM-dd");
		JSONObject jsonObject = new JSONObject();
		Led led = baseService.getLedById(Integer.valueOf(ledId));
		List<Led> leds = yewuService.getLedListByName(led.getName());
		// data类型为map组成的list
		if (dateRangeSQL == null || dateRangeSQL.length() == 0) {
			dateRangeSQL = sdf.format(new Date()) + " " + sdf.format(new Date());
		}

		JSONArray dateLegend = new JSONArray();
		JSONArray totalOccus = new JSONArray();
		JSONArray bussOccus = new JSONArray();
		JSONArray presOccus = new JSONArray();
		JSONArray commOccus = new JSONArray();

		// 遍历日期
		Date dateInx = sdf.parse(dateRangeSQL.split(" ")[0]);
		while (dateInx.compareTo(sdf.parse(dateRangeSQL.split(" ")[1])) <= 0) {
			String dateRange = sdf.format(dateInx);
			String dateRangeStr = dateRange + " " + dateRange;
			List<Map<String, Integer>> occuDataList = yewuService.calAvgScreenOccuRate4AllScreen(dateRangeStr, leds);

			totalOccus.put(df.format(TypeNullProcess.nullValueProcess(occuDataList.get(0).get(led.getName()))
					/ (double) occuDataList.get(1).get(led.getName()) * 100));
			bussOccus.put(df.format(TypeNullProcess.nullValueProcess(occuDataList.get(2).get(led.getName()))
					/ (double) occuDataList.get(1).get(led.getName()) * 100));
			presOccus.put(df.format(TypeNullProcess.nullValueProcess(occuDataList.get(3).get(led.getName()))
					/ (double) occuDataList.get(1).get(led.getName()) * 100));
			commOccus.put(df.format(TypeNullProcess.nullValueProcess(occuDataList.get(4).get(led.getName()))
					/ (double) occuDataList.get(1).get(led.getName()) * 100));

			dateLegend.put(ssdf.format(dateInx));

			Calendar cal = Calendar.getInstance();
			cal.setTime(dateInx);
			cal.add(Calendar.DATE, 1);
			dateInx = cal.getTime();
		}

		JSONObject jsonObject1 = new JSONObject();
		jsonObject1.put("dateLegend", dateLegend);
		jsonObject1.put("totalOccus", totalOccus);
		jsonObject1.put("bussOccus", bussOccus);
		jsonObject1.put("presOccus", presOccus);
		jsonObject1.put("commOccus", commOccus);

		jsonObject.put("ledOccuRates", jsonObject1);

		sentMsg(jsonObject.toString());
		return null;
	}

	public String getOrderClient(Order o) {
		String str = "";
		if (o.getAdcontract().getAgency() == null || "".equals(o.getAdcontract().getAgency())) {
			str = o.getAdcontract().getClient();
		} else {
			str = o.getAdcontract().getAgency();
		}
		return str;
	}

	public String getAllClients() throws JSONException, IOException {
		JSONObject jsonObject = new JSONObject();
		jsonObject.put("clients", baseService.clientsList());
		sentMsg(jsonObject.toString());
		return null;
	}

	public int getPage() {
		return page;
	}

	public void setPage(int page) {
		this.page = page;
	}

	public String getSidx() {
		return sidx;
	}

	public void setSidx(String sidx) {
		this.sidx = sidx;
	}

	public String getSord() {
		return sord;
	}

	public void setSord(String sord) {
		this.sord = sord;
	}

	public int getRows() {
		return rows;
	}

	public void setRows(int rows) {
		this.rows = rows;
	}

	public boolean is_search() {
		return _search;
	}

	public void set_search(boolean _search) {
		this._search = _search;
	}

	public String getSearchField() {
		return searchField;
	}

	public void setSearchField(String searchField) {
		this.searchField = searchField;
	}

	public String getSearchString() {
		return searchString;
	}

	public void setSearchString(String searchString) {
		this.searchString = searchString;
	}

	public String getSearchOper() {
		return searchOper;
	}

	public void setSearchOper(String searchOper) {
		this.searchOper = searchOper;
	}

	public Integer getTid() {
		return tid;
	}

	public void setTid(Integer tid) {
		this.tid = tid;
	}

	public Integer getYewuId() {
		return yewuId;
	}

	public void setYewuId(Integer yewuId) {
		this.yewuId = yewuId;
	}

	public String getLedId() {
		return ledId;
	}

	public void setLedId(String ledId) {
		this.ledId = ledId;
	}

	public Integer getShichang() {
		return shichang;
	}

	public void setShichang(Integer shichang) {
		this.shichang = shichang;
	}

	public Integer getPinci() {
		return pinci;
	}

	public void setPinci(Integer pinci) {
		this.pinci = pinci;
	}

	public Date getKaishishijian() {
		return kaishishijian;
	}

	public void setKaishishijian(Date kaishishijian) {
		this.kaishishijian = kaishishijian;
	}

	public Date getJieshushijian() {
		return jieshushijian;
	}

	public void setJieshushijian(Date jieshushijian) {
		this.jieshushijian = jieshushijian;
	}

	public Double getShuliang() {
		return shuliang;
	}

	public void setShuliang(Double shuliang) {
		this.shuliang = shuliang;
	}

	public String getGuanggaoneirong() {
		return guanggaoneirong;
	}

	public void setGuanggaoneirong(String guanggaoneirong) {
		this.guanggaoneirong = guanggaoneirong;
	}

	public Short getIndustryId() {
		return industryId;
	}

	public void setIndustryId(Short industryId) {
		this.industryId = industryId;
	}

	public String getTimeRange() {
		return timeRange;
	}

	public void setTimeRange(String timeRange) {
		this.timeRange = timeRange;
	}

	public String getIndustry() {
		return industry;
	}

	public void setIndustry(String industry) {
		this.industry = industry;
	}

	public String getLed() {
		return led;
	}

	public void setLed(String led) {
		this.led = led;
	}

	public String getStartTime() {
		return startTime;
	}

	public void setStartTime(String startTime) {
		this.startTime = startTime;
	}

	public String getEndTime() {
		return endTime;
	}

	public void setEndTime(String endTime) {
		this.endTime = endTime;
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	public String getSelectclassifyind() {
		return selectclassifyind;
	}

	public void setSelectclassifyind(String selectclassifyind) {
		this.selectclassifyind = selectclassifyind;
	}

	public String getSelectbumenid() {
		return selectbumenid;
	}

	public void setSelectbumenid(String selectbumenid) {
		this.selectbumenid = selectbumenid;
	}

	public String getLeixing() {
		return leixing;
	}

	public void setLeixing(String leixing) {
		this.leixing = leixing;
	}

	public String getKanhu() {
		return kanhu;
	}

	public void setKanhu(String kanhu) {
		this.kanhu = kanhu;
	}

	public String getUpdateReason() {
		return updateReason;
	}

	public void setUpdateReason(String updateReason) {
		this.updateReason = updateReason;
	}

	public String getAddReason() {
		return addReason;
	}

	public void setAddReason(String addReason) {
		this.addReason = addReason;
	}

	public String getRenkanbianhao() {
		return renkanbianhao;
	}

	public void setRenkanbianhao(String renkanbianhao) {
		this.renkanbianhao = renkanbianhao;
	}

	public int getAnnualIndustry() {
		return annualIndustry;
	}

	public void setAnnualIndustry(int annualIndustry) {
		this.annualIndustry = annualIndustry;
	}

	/**
	 * @return the annualIndustry1
	 */
	public int getAnnualIndustry1() {
		return annualIndustry1;
	}

	/**
	 * @param annualIndustry1
	 *            the annualIndustry1 to set
	 */
	public void setAnnualIndustry1(int annualIndustry1) {
		this.annualIndustry1 = annualIndustry1;
	}

	public int getAnnualYeji() {
		return annualYeji;
	}

	public void setAnnualYeji(int annualYeji) {
		this.annualYeji = annualYeji;
	}

	public int getAnnualLedSum() {
		return annualLedSum;
	}

	public void setAnnualLedSum(int annualLedSum) {
		this.annualLedSum = annualLedSum;
	}

	public Integer getGoalYwyId() {
		return goalYwyId;
	}

	public void setGoalYwyId(Integer goalYwyId) {
		this.goalYwyId = goalYwyId;
	}

	public Integer getYear() {
		return year;
	}

	public void setYear(Integer year) {
		this.year = year;
	}

	public Integer getMonth() {
		return month;
	}

	public void setMonth(Integer month) {
		this.month = month;
	}

	// public String industryAnnualSumExport() throws Exception {
	// System.out.println("------------industryAnnualSumExport----------");
	// int annual;
	// Calendar cal = Calendar.getInstance();
	// if (_search == false) {
	// annual = 2016;
	// } else {
	// annual = annualIndustry;
	// }
	// DateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	// List result[] = new List[12];
	//
	// for (int i = 0; i < result.length; i++) {
	// String startTime = sdf.format(getTimesMonthmorning(annual, i));
	// String endTime = sdf.format(getTimesMonthnight(annual, i));
	// result[i] = yewuService.get_Led_sum(startTime, endTime);
	// }
	//
	// List listIndustryclassfy = yewuService.getAllIndustryclassify();
	// double sumMonth[][] = new double[12][listIndustryclassfy.size()];
	// double sumAnnual[] = new double[listIndustryclassfy.size()];
	// String IndustryClassfyName[] = new String[listIndustryclassfy.size()];
	//
	// for (int j = 0; j < 12; j++) {
	// for (int k = 0; k < listIndustryclassfy.size(); k++) {
	// for (int i = 0; i < result[j].size(); i++) {
	// Object[] objs = (Object[]) result[j].get(i);
	// Object[] objsIndustry = (Object[]) listIndustryclassfy.get(k);
	// IndustryClassfyName[k] = objsIndustry[1].toString();
	// try {
	// if (objs[3].toString().equals(objsIndustry[1]) && objs[4] != null) {
	// sumMonth[j][k] += Double.parseDouble(objs[4].toString());
	// }
	// } catch (Exception e) {
	// e.printStackTrace();
	// }
	// }
	// sumAnnual[k] += sumMonth[j][k];
	// }
	// }
	//
	// for (int i = 0; i < listIndustryclassfy.size(); i++) {
	// for (int j = i + 1; j < listIndustryclassfy.size(); j++) {
	// if (sumAnnual[j] > sumAnnual[i]) {
	// String tempStr = IndustryClassfyName[i];
	// IndustryClassfyName[i] = IndustryClassfyName[j];
	// IndustryClassfyName[j] = tempStr;
	//
	// double tempSumAnnual = sumAnnual[i];
	// sumAnnual[i] = sumAnnual[j];
	// sumAnnual[j] = tempSumAnnual;
	//
	// double[] tempSumMonth = new double[12];
	// for (int k = 0; k < 12; k++) {
	// tempSumMonth[k] = sumMonth[k][i];
	// sumMonth[k][i] = sumMonth[k][j];
	// sumMonth[k][j] = tempSumMonth[k];
	// }
	// }
	// }
	// }
	// JSONArray jsonArray = new JSONArray();
	// JSONObject jsonObject = new JSONObject();
	//
	// List list = new ArrayList();
	//
	// for (int i = 0, size = listIndustryclassfy.size(); i < size; i++) {
	// Object[] rowinput = new Object[14];
	// rowinput[0] = IndustryClassfyName[i];
	// rowinput[1] = sumMonth[0][i];
	// rowinput[2] = sumMonth[1][i];
	// rowinput[3] = sumMonth[2][i];
	// rowinput[4] = sumMonth[3][i];
	// rowinput[5] = sumMonth[4][i];
	// rowinput[6] = sumMonth[5][i];
	// rowinput[7] = sumMonth[6][i];
	// rowinput[8] = sumMonth[7][i];
	// rowinput[9] = sumMonth[8][i];
	// rowinput[10] = sumMonth[9][i];
	// rowinput[11] = sumMonth[10][i];
	// rowinput[12] = sumMonth[11][i];
	// rowinput[13] = sumAnnual[i];
	// list.add(rowinput);
	//
	// }
	// String[] title = new String[] { "行业", "1月", "2月", "3月", "4月", "5月", "6月",
	// "7月", "8月", "9月", "10月", "11月",
	// "12月", "合计" };
	// String fileName = new String("行业年度金额统计报表") + new
	// SimpleDateFormat("yyyyMMddHHmmss").format(new Date());
	// String codedFileName = java.net.URLEncoder.encode(fileName, "UTF-8");
	// ExcelUtil.exportExcel(codedFileName, title, list);
	// return null;
	//
	// }

	// public String avgScreenOccuRateList() throws Exception {
	// Map session = ActionContext.getContext().getSession();
	// Integer id = (Integer) session.get(CommonConstant.SESSION_ID);
	// Page result = null;
	// System.out.println("searchString是：" + searchString);
	// result = yewuService.getAvgScreenOccuRateListByKeyword(sidx, sord, page,
	// rows, searchString, dateRangeSQL);
	//
	// JSONObject jsonObject = PageToJson.toJsonWithoutData(result);
	// JSONArray jsonArray = new JSONArray();
	// List data = result.getResult();
	//
	// SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");
	// for (int i = 0, size = data.size(); i < size; i++) {
	//
	// Object[] row = (Object[]) data.get(i);
	//
	// JSONObject jsonObject1 = new JSONObject();
	// // jsonObject1.put("id", row[0]);
	// JSONArray jsonArray2 = new JSONArray(); // 求取cell
	//
	// jsonArray2.put(row[0]); // 年份
	// jsonArray2.put(row[1]); // 自有屏
	// jsonArray2.put(row[2]); // 月份
	// jsonArray2.put(row[3]); // 占屏率
	//
	// jsonObject1.put("cell", jsonArray2); // 加入cell
	// jsonArray.put(jsonObject1);
	// }
	// jsonObject.put("rows", jsonArray); // 加入rows
	// // System.out.println("jsonObject:" + jsonObject.toString());
	// sentMsg(jsonObject.toString());
	// return SUCCESS;
	// }

	// public String dingdanDetailListExport() throws Exception {
	// List result = null;
	// if (_search == false) {
	// result = yewuService.getDingdanDetailListExport(sidx, sord);
	// } else {
	// System.out.println(" ~~~~~~~~~~~~~~~~~~~~~~~~~~searchString:" +
	// searchString);
	// result = yewuService.getDingdanDetailListByKeywordExport(searchString,
	// sidx, sord);
	// }
	//
	// Calendar c = Calendar.getInstance();
	// SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");
	// List listExcel = new ArrayList();
	// for (int i = 0, size = result.size(); i < size; i++) {
	//
	// Object[] row = (Object[]) result.get(i);
	// Object[] rowinput = new Object[28];
	// Integer yewuIdLocal = 0;
	// try {
	// yewuIdLocal = Integer.parseInt(row[0].toString());
	// } catch (Exception e) {
	// e.printStackTrace();
	// }
	//
	// Renkanshu renkanshu =
	// yewuService.loadYewuByID(yewuIdLocal).getRenkanshu();
	//
	// rowinput[0] = row[1];
	// rowinput[1] = row[2];
	// rowinput[2] = row[3];
	// rowinput[3] = row[4];
	// rowinput[4] = row[5];
	// rowinput[5] = sdf.format(row[6]);
	// rowinput[6] = renkanshu.getAgencymode();
	// rowinput[7] = row[7];
	// c.setTime((Date) row[6]);
	// rowinput[8] = c.get(Calendar.YEAR);
	// rowinput[9] = ((Integer) c.get(Calendar.MONTH)) + 1;
	// rowinput[10] = sdf.format((Date) row[8]);// 开始时间
	// rowinput[11] = sdf.format((Date) row[9]);// 结束时间
	// rowinput[12] = (((Date) row[9]).getTime() - ((Date) row[8]).getTime()) /
	// (24 * 60 * 60 * 1000);// 天数
	// rowinput[13] = row[10];// 屏幕
	// rowinput[14] = row[11];// 频次
	// rowinput[15] = row[12];// 时长
	// rowinput[16] = ((Integer) row[11]) * ((Integer) row[12]);// 总秒数
	// rowinput[17] = row[13];// 刊例总价
	// rowinput[18] = row[14];// 签订金额
	// rowinput[19] = row[15];// 折扣
	//
	// Set<Shoukuan> shoukuanSet = renkanshu.getShoukuans();
	// String shoukuanDates = "";
	// Iterator shoukuan = shoukuanSet.iterator();
	// for (int j = 0; j < shoukuanSet.size(); j++) {
	// shoukuanDates += sdf.format(((Shoukuan)
	// shoukuan.next()).getSkShoukuanshijian()) + " ";
	// }
	//
	// Set<Fukuan> fukuanSet = renkanshu.getFukuans();
	// String fukuanDatesExpected = "";
	// Iterator fukuan = fukuanSet.iterator();
	// for (int j = 0; j < fukuanSet.size(); j++) {
	// fukuanDatesExpected += sdf.format(((Fukuan)
	// fukuan.next()).getFukuanshijian()) + " ";
	// }
	// Orderpay orderpay =
	// renkanshuService.getOrderpayByRenkanbianhao(renkanshu.getRenkanbianhao());
	// if (orderpay == null) {
	// rowinput[20] = "";// 应收款
	// rowinput[21] = "";// 实收款
	// rowinput[22] = row[16];// 外购成本
	// rowinput[23] = row[17];// 净收入
	// rowinput[24] = shoukuanDates;// 付款时间
	// rowinput[25] = fukuanDatesExpected;// 约定收款时间
	// rowinput[26] = "";// 到款率
	// } else {
	// double paid = orderpay.getPaid();
	// double yingfuzonge = orderpay.getYingfuzonge();
	// double shoukuanRatio = (double) paid / yingfuzonge;
	//
	// rowinput[20] = yingfuzonge;// 应收款
	// rowinput[21] = paid;// 实收款
	// rowinput[22] = row[16];// 外购成本
	// rowinput[23] = row[17];// 净收入
	// rowinput[24] = shoukuanDates;// 付款时间
	// rowinput[25] = fukuanDatesExpected;// 约定收款时间
	// rowinput[26] = shoukuanRatio;// 到款率
	// System.out.println("fukuanDates:" + fukuanDatesExpected);
	// }
	// rowinput[27] = row[18];// 备注
	//
	// listExcel.add(rowinput);
	// }
	//
	// String[] title = new String[] { "部门", "业务员", "代理公司", "客户名称", "类别",
	// "签订日期", "代理/直客", "合作类型", "年", "月", "开始时间",
	// "结束时间", "天数", "上画屏幕", "频次", "时长", "总秒数", "刊例总价", "签订金额", "折扣", "应收款",
	// "实收款", "外购成本", "净收入", "付款时间",
	// "约定付款时间", "到款率", "备注" };
	// String fileName = new String("订单明细表") + new
	// SimpleDateFormat("yyyyMMddHHmmss").format(new Date());
	// String codedFileName = java.net.URLEncoder.encode(fileName, "UTF-8");
	// ExcelUtil.exportExcel(codedFileName, title, listExcel);
	//
	// return null;
	//
	// }

	// public String avgScreenOccuRateListExport() throws
	// UnsupportedEncodingException {
	// List result = yewuService.calAvgScreenOccuRate(searchString,
	// dateRangeSQL);
	// String[] title = new String[] { "年份", "自有屏", "月份", "占屏率(%)" };
	// String fileName = new String("平均占屏率统计表") + new
	// SimpleDateFormat("yyyyMMdd").format(new Date());
	// String codedFileName = java.net.URLEncoder.encode(fileName, "UTF-8");
	// ExcelUtil.exportExcel(codedFileName, title, result);
	// return null;
	// }

	// public String orderUpdatePage() throws Exception {
	// ActionContext ctx = ActionContext.getContext();
	// SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	// order = o;
	// ctx.put("leds", yewuService.getAllLed());
	// ctx.put("industry", baseService.getAllIndustry());
	//
	// System.out.println("===================================" +
	// yewuService.getAllIndustry().size());
	// List list = yewuService.getRemarks(yewu.getYewuId());
	// String remark = "";
	// for (int i = 0; i < list.size(); i++) {
	// remark += list.get(i).toString() + "<br>";
	// }
	// ctx.put("remark", remark);
	// ctx.put("qiandingriqi",
	// sdf.format(yewu.getRenkanshu().getQiandingriqi()));
	// ctx.put("kaishishijian", sdf.format(yewu.getKaishishijian()));
	// ctx.put("jieshushijian", sdf.format(yewu.getJieshushijian()));
	// System.out.println("###############调用YewuAction中的orderUpdatePage函数:yewu:"
	// + yewu);
	// return SUCCESS;
	// }

	// public String updateOrder() throws Exception {
	// JSONObject jsonObject = new JSONObject();
	// Map session = ActionContext.getContext().getSession();
	// Integer userID = (Integer) session.get(CommonConstant.SESSION_ID);
	// System.out.println("………………………………updateOrder……………………………………" + userID + " "
	// + tid + " " + ledId + " " + shichang
	// + " " + pinci + " " + kaishishijian + " " + jieshushijian + " " +
	// guanggaoneirong);
	// yewuService.update(tid, leixing, ledId, shichang, pinci, kaishishijian,
	// jieshushijian, shuliang, updateReason,
	// Double.parseDouble(kanlixiaoji));
	//
	// System.out.println("………………………………调用yewuService.update后……………………………………");
	// jsonObject.put("state", 0);
	// jsonObject.put("info", "您的修改信息已提交，请耐心等待审核结果！");
	// sentMsg(jsonObject.toString());
	// return null;
	// }

	// public String upOrder() throws Exception {
	// JSONObject jsonObject = new JSONObject();
	// Map session = ActionContext.getContext().getSession();
	// Integer userID = (Integer) session.get(CommonConstant.SESSION_ID);
	// yewuService.upOrder(userID, tid, upReason);
	// jsonObject.put("state", 0);
	// jsonObject.put("info", "您的上画信息已提交，请耐心等待审核结果！");
	// sentMsg(jsonObject.toString());
	// return null;
	// }
	//
	// public String addOrder() throws Exception {
	// JSONObject jsonObject = new JSONObject();
	// Map session = ActionContext.getContext().getSession();
	// Integer userID = (Integer) session.get(CommonConstant.SESSION_ID);
	// Renkanshu renkanshu =
	// yewuService.getRenkanshuByRenkanbianhao(renkanbianhao);
	// yewuService.addOrder(userID, renkanshu, ledId, leixing, shichang, pinci,
	// kaishishijian, jieshushijian,
	// shuliang, kanlixiaoji, addReason);
	// jsonObject.put("state", 0);
	// jsonObject.put("info", "您添加的订单信息已提交，请耐心等待审核结果！");
	// sentMsg(jsonObject.toString());
	// return null;
	// }

	// public String getPieData() throws Exception {
	// DateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	// List result = null;
	// List result4modal = null;
	//
	// System.out.println("………………………………getPieData……………………………………" + " 时间范畴：" +
	// timeRange + " 开始时间：" + startTime
	// + " 结束时间：" + endTime + " 屏幕：" + led + " 行业：" + industry);
	// if (led.equals("")) {
	// result = yewuService.getPieDataAllLed(startTime, endTime);
	// result4modal = yewuService.getPieDataAllLed4modal(startTime, endTime);
	// } else {
	// result = yewuService.getPieData(startTime, endTime, led);
	// result4modal = yewuService.getPieData4modal(startTime, endTime, led);
	// }
	//
	// // System.out.println(result4modal.size());
	// List<Object[]> distinctResult4modal = new ArrayList<Object[]>();
	// String tmpStr = new String();
	// boolean switchPlus = false;
	// for (int i = 0, length = result4modal.size(); i < length; i++) {
	// if (tmpStr.equals((String) ((Object[]) result4modal.get(i))[5])) {
	//
	// } else {
	// tmpStr = (String) ((Object[]) result4modal.get(i))[5];
	// distinctResult4modal.add((Object[]) result4modal.get(i));
	// }
	// //
	// System.out.println(((Object[])result4modal.get(i))[0]+"
	// "+((Object[])result4modal.get(i))[1]+"
	// "+((Object[])result4modal.get(i))[2]);
	// }
	// // System.out.println(distinctResult4modal.size());
	//
	// List<String> lstArray = new ArrayList<String>();
	// TreeSet<String> tset = new TreeSet<String>();
	// for (int i = 0; i < result.size(); i++) {
	// lstArray.add((String) ((Object[]) result.get(i))[2]);
	// tset.add((String) ((Object[]) result.get(i))[18]);
	// }
	//
	// Collections.sort(lstArray);
	//
	// System.out.println("tset.toString():" + tset.toString());
	// System.out.println("lstArray:" + lstArray);
	//
	// DecimalFormat df = new DecimalFormat("#####0.0000");
	// Double[] ratios = new Double[tset.size()];
	// int[] amounts = new int[tset.size()];
	// for (int i = 0; i < ratios.length; i++) {
	// ratios[i] = 0.0000;
	// amounts[i] = 0;
	// }
	//
	// if ((!startTime.equals("")) && (!endTime.equals(""))) {
	// long datesttmp = sdf.parse(startTime).getTime();
	// long dateettmp = sdf.parse(endTime).getTime();
	// long onedaytmp = 24 * 3600 * 1000;
	// int statisticdays = (int) ((dateettmp - datesttmp) / onedaytmp) + 1;
	//
	// List lstddsta = new ArrayList();
	//
	// for (int i = 0; i < result.size(); i++) {
	// String[] lstloop = null;
	// Object[] objs = (Object[]) result.get(i);
	//
	// String strttm = sdf.format(objs[13]);
	// String endtm = sdf.format(objs[14]);
	//
	// Date dtsttm = sdf.parse(strttm);
	// Date dtedtm = sdf.parse(endtm);
	// int countdays = 0;
	// if (dtsttm.getTime() <= datesttmp && dtedtm.getTime() <= dateettmp) {
	// countdays = (int) ((dtedtm.getTime() - datesttmp) / onedaytmp) + 1;
	// } else if (dtsttm.getTime() <= datesttmp && dtedtm.getTime() >=
	// dateettmp) {
	// countdays = (int) ((dateettmp - datesttmp) / onedaytmp) + 1;
	// } else if (dtsttm.getTime() >= datesttmp && dtedtm.getTime() >=
	// dateettmp) {
	// countdays = (int) ((dateettmp - dtsttm.getTime()) / onedaytmp) + 1;
	// } else {
	// countdays = (int) ((dtedtm.getTime() - dtsttm.getTime()) / onedaytmp) +
	// 1;
	// }
	// double zpltmp = ((Integer) objs[12] * countdays) * 10000 / ((Integer)
	// objs[9] * statisticdays)
	// / 10000.000000;
	// //
	// // System.out.println("zpltmp:" + zpltmp);
	//
	// Iterator<String> iterator = tset.iterator();
	// for (int j = 0; j < tset.size(); j++) {
	// try {
	// if (objs[18].toString().equals(iterator.next())) {
	// ratios[j] += zpltmp;
	// amounts[j]++;
	// }
	// } catch (Exception e) {
	// e.printStackTrace();
	// }
	//
	// }
	//
	// }
	// }
	//
	// System.out.println("-----------------------------------------------------");
	// System.out.println("集合大小：" + tset.size());
	// System.out.println("数组长度：" + ratios.length);
	// JSONArray jsonArray = new JSONArray();
	// Iterator<String> iterator = tset.iterator();
	// // String str;
	// JSONArray jsonArray1 = new JSONArray();
	// JSONArray jsonArray2 = new JSONArray();
	// JSONArray jsonArray3 = new JSONArray();
	// jsonArray1.put("a");
	// jsonArray2.put(0.001);
	// jsonArray3.put(0);
	// for (int j = 0; j < tset.size(); j++) {
	// jsonArray1.put(iterator.next());
	// jsonArray2.put(Double.parseDouble(df.format(ratios[j] * 100)));
	// jsonArray3.put(amounts[j]);
	// System.out.println("double:" + Double.parseDouble(df.format(ratios[j] *
	// 100)));
	// }
	// jsonArray1.put("a");
	// jsonArray2.put(0.001);
	// jsonArray3.put(0);
	// System.out.println("jsonArray:" + jsonArray.toString());
	// // industryArr
	//
	// ActionContext ctx = ActionContext.getContext();
	// ctx.put("industryArr", jsonArray1);
	// ctx.put("ratios", jsonArray2);
	// ctx.put("amounts", jsonArray3);
	//
	// JSONArray jsonArrayModal = new JSONArray();
	//
	// for (int i = 0, length = distinctResult4modal.size(); i < length; i++) {
	// Object[] objects = (Object[]) distinctResult4modal.get(i);
	// JSONObject jsonObjectModalCell = new JSONObject();
	//
	// jsonObjectModalCell.put("industry", objects[0]);
	// jsonObjectModalCell.put("client", objects[1]);
	// jsonObjectModalCell.put("amount", objects[2]);
	// jsonObjectModalCell.put("date", sdf.format((Date) objects[3]));
	// jsonObjectModalCell.put("employee", objects[4]);
	// jsonObjectModalCell.put("publishmentnumber", objects[5]);
	//
	// jsonArrayModal.put(jsonObjectModalCell);
	//
	// // System.out.println(objects[0]+" "+objects[1]);
	//
	// }
	//
	// System.out.println("jsonArrayModal :" + jsonArrayModal);
	// ctx.put("clientManageModal", jsonArrayModal);
	//
	// // ctx.put("industryclassifys", yewuService.getAllIndustryclassify());
	//
	// // JSONObject jsonObjectA = new JSONObject();
	// // jsonObjectA.put("industryArr", jsonArray1);
	// // jsonObjectA.put("ratioArr", jsonArray2);
	// //
	// // jsonObjectA.put("info", "您的修改信息已提交，请耐心等待审核结果！");
	// // System.out.println("jsonObjectA.toString():"+jsonObjectA.toString());
	// // sentMsg(jsonObjectA.toString());
	// return SUCCESS;
	// }

	// /**
	// * 根据占屏率统计出排名前十的行业
	// *
	// * @return
	// * @throws JSONException
	// * @throws IOException
	// * 因为list没有封装成为Page，所以在前端页面不能翻页
	// */
	// public String getTop10_annual_Led_Occupy() throws Exception {
	// // //更新yewu表中缺少的数据
	// // yewuService.updateYewuInfo();
	//
	// DateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	// List result[] = new List[12];
	//
	// MathContext mc = new MathContext(2);
	//
	// int annual;
	// if (_search == false) {
	// annual = 2016;
	// } else {
	// annual = annualIndustry;
	// }
	// System.out.println("----------getTop10_annual_Led_Occupy-------annualIndustry："
	// + annualIndustry);
	// for (int i = 0; i < result.length; i++) {
	// String startTime = sdf.format(getTimesMonthmorning(annual, i));
	// String endTime = sdf.format(getTimesMonthnight(annual, i));
	// result[i] = yewuService.getLedOccupy_Industry(startTime, endTime);
	// }
	//
	// List listIndustryclassfy = yewuService.getAllIndustryclassify();
	// String IndustryClassfyName[] = new String[listIndustryclassfy.size()];
	//
	// List listLedBofangshichang = yewuService.getAllLedBofangshichang();
	// int countShichang = 0;
	// for (int i = 0; i < listLedBofangshichang.size(); i++) {
	// countShichang +=
	// Integer.parseInt(listLedBofangshichang.get(i).toString());
	// }
	// // System.out.println("countShichang------------"+countShichang);
	//
	// DecimalFormat df = new DecimalFormat("0.00");
	// // System.out.println("DecimalFormat");
	// double[][] ratios = new double[12][listIndustryclassfy.size()];
	// int[][] shichang = new int[12][listIndustryclassfy.size()];
	// int[][] amounts = new int[12][listIndustryclassfy.size()];
	// double[] ratiosCount = new double[listIndustryclassfy.size()];
	//
	// for (int j = 0; j < 12; j++) {
	//
	// for (int i = 0; i < ratios[j].length; i++) {
	// ratios[j][i] = 0.0000;
	// amounts[j][i] = 0;
	// }
	// }
	//
	// for (int j = 0; j < 12; j++) {
	// Date startTime = getTimesMonthmorning(annual, j);
	// Date endTime = getTimesMonthnight(annual, j);
	// long startTimeLong = startTime.getTime();
	// long endTimeLong = endTime.getTime();
	// long onedaytmp = 24 * 3600 * 1000;
	// int statisticdays = (int) ((endTimeLong - startTimeLong) / onedaytmp) +
	// 1;
	//
	// for (int k = 0; k < listIndustryclassfy.size(); k++) {
	// Object[] objsIndustry = (Object[]) listIndustryclassfy.get(k);
	// IndustryClassfyName[k] = objsIndustry[1].toString();
	//
	// for (int i = 0; i < result[j].size(); i++) {
	// Object[] objs = (Object[]) result[j].get(i);
	// String kaishittm = sdf.format(objs[5]);
	// String jieshutm = sdf.format(objs[6]);
	// Date dtKaishitm = sdf.parse(kaishittm);// 开始日期
	// Date dtJieshutm = sdf.parse(jieshutm);// 结束日期
	// long kaishishijianLong = dtKaishitm.getTime();
	// long jieshushijianLong = dtJieshutm.getTime();
	// int countdays = 0;
	// // 计算在本月中某条订单的播放天数，分为四种情况
	// if (jieshushijianLong >= startTimeLong && jieshushijianLong <=
	// endTimeLong
	// && kaishishijianLong <= startTimeLong) {
	// countdays = (int) ((jieshushijianLong - startTimeLong) / onedaytmp) + 1;
	// } else if (jieshushijianLong >= startTimeLong && jieshushijianLong <=
	// endTimeLong
	// && kaishishijianLong >= startTimeLong && kaishishijianLong <=
	// endTimeLong) {
	// countdays = (int) ((jieshushijianLong - kaishishijianLong) / onedaytmp) +
	// 1;
	// } else if (jieshushijianLong >= endTimeLong && kaishishijianLong >=
	// startTimeLong
	// && kaishishijianLong <= endTimeLong) {
	// countdays = (int) ((endTimeLong - kaishishijianLong) / onedaytmp) + 1;
	// } else if (jieshushijianLong >= endTimeLong && kaishishijianLong <=
	// startTimeLong) {
	// countdays = (int) ((endTimeLong - startTimeLong) / onedaytmp) + 1;
	// }
	// // // System.out.println("countdays----:::"+countdays);
	// int shichangEvery = Integer.parseInt(objs[4].toString()) * countdays;
	// try {
	// if (objs[7].toString().equals(IndustryClassfyName[k])) {
	// shichang[j][k] += shichangEvery;
	// // ratios[j][k] += zpltmp;
	// amounts[j][k]++;
	// }
	// } catch (Exception e) {
	// e.printStackTrace();
	// }
	// }
	// ratios[j][k] = shichang[j][k] * 10000.0000 / (countShichang *
	// statisticdays) / 100.0000;
	// // ratiosCount[k]+=ratios[j][k];
	// try {
	// ratiosCount[k] += Double.parseDouble(df.format(ratios[j][k]));
	// } catch (Exception e) {
	// // TODO Auto-generated catch block
	// e.printStackTrace();
	// // System.out.println(e);
	// }
	// // System.out.println(ratiosCount[k]);
	// }
	// }
	//
	// // 排序
	// for (int i = 0; i < listIndustryclassfy.size(); i++) {
	// for (int j = i + 1; j < listIndustryclassfy.size(); j++) {
	// if (ratiosCount[j] > ratiosCount[i]) {
	// String tempStr = IndustryClassfyName[i];
	// IndustryClassfyName[i] = IndustryClassfyName[j];
	// IndustryClassfyName[j] = tempStr;
	//
	// double tempRationsCount = ratiosCount[i];
	// ratiosCount[i] = ratiosCount[j];
	// ratiosCount[j] = tempRationsCount;
	//
	// double[] tempratios = new double[12];
	// for (int k = 0; k < 12; k++) {
	// tempratios[k] = ratios[k][i];
	// ratios[k][i] = ratios[k][j];
	// ratios[k][j] = tempratios[k];
	// }
	//
	// }
	// }
	// }
	//
	// System.out.println("---------------------getTop10_annual_Led_Occupy--------------------------------");
	// System.out.println("数组长度：" + ratios.length);
	// System.out.println("子数组长度：" + ratios[0].length);
	//
	// // // 实际查询返回分页对象
	// // int startIndex = Page.getStartOfPage(page, rows);
	// // long totalCount=listIndustryclassfy.size();
	// // Page page=Page(startIndex, totalCount, rows, listIndustryclassfy);
	//
	// JSONArray jsonArray = new JSONArray();
	// JSONObject jsonObject = new JSONObject();
	// for (int i = 0, size = listIndustryclassfy.size(); i < size; i++) {
	// // Object[] row = (Object[]) result[j].get(i);
	//
	// JSONObject jsonObject1 = new JSONObject();
	// JSONArray jsonArray2 = new JSONArray(); // 求取cell
	//
	// jsonArray2.put(IndustryClassfyName[i]);// 行业
	//
	// jsonArray2.put(Double.parseDouble(df.format(ratios[0][i])));// 1月份
	// jsonArray2.put(Double.parseDouble(df.format(ratios[1][i])));// 2月份
	// jsonArray2.put(Double.parseDouble(df.format(ratios[2][i])));// 3月份
	// jsonArray2.put(Double.parseDouble(df.format(ratios[3][i])));// 4月份
	// jsonArray2.put(Double.parseDouble(df.format(ratios[4][i])));// 5月份
	// jsonArray2.put(Double.parseDouble(df.format(ratios[5][i])));// 6月份
	// jsonArray2.put(Double.parseDouble(df.format(ratios[6][i])));// 7月份
	// jsonArray2.put(Double.parseDouble(df.format(ratios[7][i])));// 8月份
	// jsonArray2.put(Double.parseDouble(df.format(ratios[8][i])));// 9月份
	// jsonArray2.put(Double.parseDouble(df.format(ratios[9][i])));// 10月份
	// jsonArray2.put(Double.parseDouble(df.format(ratios[10][i])));// 11月份
	// jsonArray2.put(Double.parseDouble(df.format(ratios[11][i])));// 12月份
	//
	// jsonArray2.put(Double.parseDouble(df.format(ratiosCount[i])));
	//
	// jsonObject1.put("cell", jsonArray2); // 加入cell
	// jsonArray.put(jsonObject1);
	// }
	// // System.out.println("jsonObject");
	// // System.out.println(jsonArray.length());
	// JSONArray jsonArrayIndustryClassify = new JSONArray();
	// JSONArray jsonArrayRatios = new JSONArray();
	// for (int i = 0; i < 10; i++) {
	// jsonArrayIndustryClassify.put(IndustryClassfyName[i]);
	// jsonArrayRatios.put(Double.parseDouble(df.format(ratiosCount[i])));
	// }
	// ActionContext ctx = ActionContext.getContext();
	// ctx.put("industry4Report", jsonArrayIndustryClassify);
	// ctx.put("ratios4Report", jsonArrayRatios);
	// jsonObject.put("rows", jsonArray); // 加入rows
	// sentMsg(jsonObject.toString());
	// return SUCCESS;
	//
	// }

	// public String industryAnnualOccupyExport() throws Exception {
	// DateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	// List result[] = new List[12];
	//
	// int annual;
	// if (_search == false) {
	// annual = 2016;
	// } else {
	// annual = annualIndustry;
	// }
	//
	// for (int i = 0; i < result.length; i++) {
	// String startTime = sdf.format(getTimesMonthmorning(annual, i));
	// String endTime = sdf.format(getTimesMonthnight(annual, i));
	//
	// result[i] = yewuService.getLedOccupy_Industry(startTime, endTime);
	// }
	//
	// List listIndustryclassfy = yewuService.getAllIndustryclassify();
	// String IndustryClassfyName[] = new String[listIndustryclassfy.size()];
	//
	// List listLedBofangshichang = yewuService.getAllLedBofangshichang();
	// int countShichang = 0;
	// for (int i = 0; i < listLedBofangshichang.size(); i++) {
	// countShichang +=
	// Integer.parseInt(listLedBofangshichang.get(i).toString());
	// }
	// System.out.println("countShichang------------" + countShichang);
	//
	// DecimalFormat df = new DecimalFormat("0.00");
	// System.out.println("DecimalFormat");
	// double[][] ratios = new double[12][listIndustryclassfy.size()];
	// int[][] shichang = new int[12][listIndustryclassfy.size()];
	// int[][] amounts = new int[12][listIndustryclassfy.size()];
	// double[] ratiosCount = new double[listIndustryclassfy.size()];
	//
	// for (int j = 0; j < 12; j++) {
	// for (int i = 0; i < ratios[j].length; i++) {
	// ratios[j][i] = 0.0000;
	// amounts[j][i] = 0;
	// }
	// }
	// for (int j = 0; j < 12; j++) {
	// Date startTime = getTimesMonthmorning(annual, j);
	// Date endTime = getTimesMonthnight(annual, j);
	// long startTimeLong = startTime.getTime();
	// long endTimeLong = endTime.getTime();
	// long onedaytmp = 24 * 3600 * 1000;
	// int statisticdays = (int) ((endTimeLong - startTimeLong) / onedaytmp) +
	// 1;
	//
	// for (int k = 0; k < listIndustryclassfy.size(); k++) {
	// Object[] objsIndustry = (Object[]) listIndustryclassfy.get(k);
	// IndustryClassfyName[k] = objsIndustry[1].toString();
	//
	// for (int i = 0; i < result[j].size(); i++) {
	// Object[] objs = (Object[]) result[j].get(i);
	// String kaishittm = sdf.format(objs[5]);
	// String jieshutm = sdf.format(objs[6]);
	// Date dtKaishitm = sdf.parse(kaishittm);// 开始日期
	// Date dtJieshutm = sdf.parse(jieshutm);// 结束日期
	// long kaishishijianLong = dtKaishitm.getTime();
	// long jieshushijianLong = dtJieshutm.getTime();
	// int countdays = 0;
	// // 计算在本月中某条订单的播放天数，分为四种情况
	// if (jieshushijianLong >= startTimeLong && jieshushijianLong <=
	// endTimeLong
	// && kaishishijianLong <= startTimeLong) {
	// countdays = (int) ((jieshushijianLong - startTimeLong) / onedaytmp) + 1;
	// } else if (jieshushijianLong >= startTimeLong && jieshushijianLong <=
	// endTimeLong
	// && kaishishijianLong >= startTimeLong && kaishishijianLong <=
	// endTimeLong) {
	// countdays = (int) ((jieshushijianLong - kaishishijianLong) / onedaytmp) +
	// 1;
	// } else if (jieshushijianLong >= endTimeLong && kaishishijianLong >=
	// startTimeLong
	// && kaishishijianLong <= endTimeLong) {
	// countdays = (int) ((endTimeLong - kaishishijianLong) / onedaytmp) + 1;
	// } else if (jieshushijianLong >= endTimeLong && kaishishijianLong <=
	// startTimeLong) {
	// countdays = (int) ((endTimeLong - startTimeLong) / onedaytmp) + 1;
	// }
	// // // System.out.println("countdays----:::"+countdays);
	// int shichangEvery = Integer.parseInt(objs[4].toString()) * countdays;
	// try {
	// if (objs[7].toString().equals(IndustryClassfyName[k])) {
	// shichang[j][k] += shichangEvery;
	// // ratios[j][k] += zpltmp;
	// amounts[j][k]++;
	// }
	// } catch (Exception e) {
	// e.printStackTrace();
	// }
	// }
	// ratios[j][k] = shichang[j][k] * 10000.0000 / (countShichang *
	// statisticdays) / 100.0000;
	// ratiosCount[k] += Double.parseDouble(df.format(ratios[j][k]));
	//
	// }
	// }
	//
	// // 排序
	// for (int i = 0; i < listIndustryclassfy.size(); i++) {
	// for (int j = i + 1; j < listIndustryclassfy.size(); j++) {
	// if (ratiosCount[j] > ratiosCount[i]) {
	// String tempStr = IndustryClassfyName[i];
	// IndustryClassfyName[i] = IndustryClassfyName[j];
	// IndustryClassfyName[j] = tempStr;
	//
	// double tempRationsCount = ratiosCount[i];
	// ratiosCount[i] = ratiosCount[j];
	// ratiosCount[j] = tempRationsCount;
	//
	// double[] tempratios = new double[12];
	// for (int k = 0; k < 12; k++) {
	// tempratios[k] = ratios[k][i];
	// ratios[k][i] = ratios[k][j];
	// ratios[k][j] = tempratios[k];
	// }
	// }
	// }
	// }
	//
	// List list = new ArrayList();
	//
	// for (int i = 0, size = listIndustryclassfy.size(); i < size; i++) {
	// Object[] rowinput = new Object[14];
	// rowinput[0] = IndustryClassfyName[i];
	// rowinput[1] = Double.parseDouble(df.format(ratios[0][i]));
	// rowinput[2] = Double.parseDouble(df.format(ratios[1][i]));
	// rowinput[3] = Double.parseDouble(df.format(ratios[2][i]));
	// rowinput[4] = Double.parseDouble(df.format(ratios[3][i]));
	// rowinput[5] = Double.parseDouble(df.format(ratios[4][i]));
	// rowinput[6] = Double.parseDouble(df.format(ratios[5][i]));
	// rowinput[7] = Double.parseDouble(df.format(ratios[6][i]));
	// rowinput[8] = Double.parseDouble(df.format(ratios[7][i]));
	// rowinput[9] = Double.parseDouble(df.format(ratios[8][i]));
	// rowinput[10] = Double.parseDouble(df.format(ratios[9][i]));
	// rowinput[11] = Double.parseDouble(df.format(ratios[10][i]));
	// rowinput[12] = Double.parseDouble(df.format(ratios[11][i]));
	//
	// rowinput[13] = Double.parseDouble(df.format(ratiosCount[i]));
	// list.add(rowinput);
	//
	// }
	// String[] title = new String[] { "行业", "1月", "2月", "3月", "4月", "5月", "6月",
	// "7月", "8月", "9月", "10月", "11月",
	// "12月", "合计" };
	// String fileName = new String("行业年度占屏率统计报表") + new
	// SimpleDateFormat("yyyyMMddHHmmss").format(new Date());
	// String codedFileName = java.net.URLEncoder.encode(fileName, "UTF-8");
	// ExcelUtil.exportExcel(codedFileName, title, list);
	// return null;
	//
	// }

}
