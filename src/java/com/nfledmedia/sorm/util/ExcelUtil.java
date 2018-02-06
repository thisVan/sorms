package com.nfledmedia.sorm.util;

import java.util.List;

import javax.servlet.http.HttpServletResponse;

import jxl.Workbook;
import jxl.write.Label;
import jxl.write.WritableCellFormat;
import jxl.write.WritableSheet;
import jxl.write.WritableWorkbook;

import org.apache.log4j.Logger;
import org.apache.struts2.ServletActionContext;

public class ExcelUtil {

	private static Logger log = Logger.getLogger(ExcelUtil.class);

	public static boolean exportExcel(String fileName, String[] title, List<?> dataList) {

		HttpServletResponse response = ServletActionContext.getResponse();
		response.setContentType("aplication/vnd.ms-excel");
		response.addHeader("Content-Disposition", "inline; filename=" + fileName + ".xls");

		// System.out.println("-----fileName-------"+fileName);
		try {
			// 创建Excel工作薄
			WritableWorkbook wwb = Workbook.createWorkbook(response.getOutputStream());

			// 添加第一个工作表并设置第一个Sheet的名字 ,所以只是sheet的名字，文件名仍为日期
			WritableSheet sheet = wwb.createSheet(fileName, 0);

			Label label;

			// 设置列宽度
			sheet.setColumnView(0, 10);
			sheet.setColumnView(3, 10);
			sheet.setColumnView(6, 10);

			// 单元格样式
			WritableCellFormat wcf_title = new WritableCellFormat();
			wcf_title.setBackground(jxl.format.Colour.YELLOW);

			// 添加标题
			if (title != null) {
				for (int i = 0; i < title.length; i++) {
					label = new Label(i, 0, title[i], wcf_title);
					sheet.addCell(label);
				}
			}

			// 下面是填充数据
			if (dataList != null && dataList.size() > 0) {
				for (int i = 0, size = dataList.size(); i < size; i++) {
					for (int j = 0; j < title.length; j++) {
						Object[] row = (Object[]) dataList.get(i);
						String value = null;
						if (row[j] != null)
							value = row[j].toString();
						if (value != null && !value.equals("")) {
							label = new Label(j, i + 1, value);
						} else {
							label = new Label(j, i + 1, "");
						}
						sheet.addCell(label);
					}
				}
			}

			wwb.write();
			// 关闭
			wwb.close();
			return true;
		} catch (Exception e) {
			log.error("------------生成Excel异常------------");
			e.printStackTrace();
			System.out.println(e);
			return false;
		}
	}

}
