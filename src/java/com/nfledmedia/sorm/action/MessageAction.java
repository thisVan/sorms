package com.nfledmedia.sorm.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;
import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Service;

import com.nfledmedia.sorm.cons.CommonConstant;
import com.nfledmedia.sorm.entity.Message;
import com.nfledmedia.sorm.service.MessageService;
import com.nfledmedia.sorm.util.Page;
import com.nfledmedia.sorm.util.PageToJson;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ModelDriven;

@Controller
public class MessageAction extends SuperAction implements ModelDriven<Message> {

	private static final long serialVersionUID = 1L;
	
	private String ids;
	private String id;
	private int page;
	private String sidx;
	private String sord;
	private int rows;

	@Autowired
	private MessageService messageService;

	@Override
	public Message getModel() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public String execute() throws Exception {
		ActionContext ctx = ActionContext.getContext();
		List breadCrumb = new ArrayList(2);
		breadCrumb.add(new Object[] { "消息管理", "javascript:void(0);" });
		ctx.put("breadCrumb", breadCrumb);
		return SUCCESS;
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

	public String queryMessageList() throws Exception {
		Map session = ActionContext.getContext().getSession();
		Page result = messageService.getMessageList(
				(Integer) session.get(CommonConstant.SESSION_ID), sidx, sord,
				page, rows);
		JSONObject jsonObject = PageToJson.toJsonWithoutData(result);
		JSONArray jsonArray = new JSONArray();
		List data = result.getResult();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");
		DateFormat sdf2TS = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		// System.out.println("…………………………………………………MessageAction：……………………………………………………………………………");
		for (int i = 0, size = data.size(); i < size; i++) {
			Object[] row = (Object[]) data.get(i);
			JSONObject jsonObject2 = new JSONObject();
			jsonObject2.put("id", row[0]); // 加入id
			JSONArray jsonArray2 = new JSONArray(); // 求取cell
			jsonArray2.put(row[1]); // 状态
			jsonArray2.put(sdf2TS.format((Timestamp) row[2])); // 时间
			jsonArray2.put(row[3]);

			jsonObject2.put("cell", jsonArray2); // 加入cell

			jsonArray.put(jsonObject2);

		}
		jsonObject.put("rows", jsonArray); // 加入rows

		sentMsg(jsonObject.toString());
		return null;
	}

	public String countNotReadMessage() throws Exception {
		System.out
				.println("-------------------进入countNotReadMessage---------------------");
		Map session = ActionContext.getContext().getSession();
		long count = this.messageService.countNotReadMessage((Integer) session
				.get(CommonConstant.SESSION_ID));
		/** 获取response对象 */
		HttpServletResponse response = ServletActionContext.getResponse();
		/** 获取输出out对象 */
		PrintWriter out = response.getWriter();
//		String msg = "";
//		msg += count;
		out.print(count);
//		out.print(msg);
//		System.out.println("msg:" + msg);
		System.out.println("count:" + count);
		return null;
	}

	public String dealMessageRead() throws Exception {
		System.out.println("消息标记为已读时的id：" + ids);
		messageService.setMessagesRead(ids);
		return null;
	}

	public String deleteMessage() throws Exception {
		System.out
				.println("…………………………………………………MessageAction：消息删除……………………………………………………………………………");
		System.out.println("消息删除时的id：" + id);
		messageService.deleteMessage(id);
		return null;
	}

	public String getIds() {
		return ids;
	}

	public void setIds(String ids) {
		this.ids = ids;
	}


	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
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

}
