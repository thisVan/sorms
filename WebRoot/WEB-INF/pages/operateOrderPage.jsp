<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="com.google.gson.*"%>
<%@ page import="java.sql.*"%>
<%@ taglib uri="/struts-tags" prefix="s"%>

<!DOCTYPE HTML>
<html>
<head>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<link rel="icon" href="images/logo.png" type="image/x-icon" />
<link rel="shortcut icon" href="images/logo.png" type="image/x-icon" />

<link href="css/bootstrap.min.css" rel="stylesheet" media="screen">
<link href="css/bootstrap-theme.css" rel="stylesheet" >
<link href="css/bootstrap-table.css" rel="stylesheet">

<link href="css/jquery-confirm.min.css" rel="stylesheet">
<link href="css/jquery-ui.min.css" rel="stylesheet" media="screen">

<link href="css/styles.css" rel="stylesheet">
<link href="css/laydate.css" rel="stylesheet">

<style type="text/css">
.table th, .table td { 
    text-align: center;
    vertical-align: middle!important;
}
</style>


<!--Icons-->
<script src="js/jquery-1.11.1.min.js"></script>
<script src="js/lumino.glyphs.js"></script>
<script src="js/bootstrap.min.js"></script>
<script src="js/jquery-ui.min.js"></script>
<script src="js/jquery-confirm.min.js"></script>
<script src="js/bootstrap-table.js"></script>


</head>
<body style="font-family: '微软雅黑';">
	<div class="main">

		<!--/.row-->

		<div class="row">
			<div class="col-lg-12">
				<h3 class="page-header">改停刊操作</h3>
			</div>
		</div>
		<!--/.row-->
		<div class="row">
			<form id="updateOrderForm" class="form-horizontal" role="form">
				<input type="text" class="hidden" name="adcontract.id" id="adcontractid"
					value='${adcontract.id }'>
				<div class="form-group col-lg-6 col-md-12">
					<label for="account" class="col-sm-3 control-label">广告刊户</label>
					<div class="col-sm-9">
						<input type="text" class="form-control input-sm"
							name="adcontract.client"
							value='<s:property value="#adcontract.client"/>' maxlength="20" readonly="readonly">
					</div>
				</div>
				<div class="form-group col-lg-6 col-md-12">
					<label for="account" class="col-sm-3 control-label">代理公司</label>
					<div class="col-sm-9">
						<input type="text" class="form-control input-sm"
							name="adcontract.agency"
							value='<s:property value="#adcontract.agency"/>' maxlength="20" readonly="readonly">
					</div>
				</div>

				<div class="form-group col-lg-6 col-md-12">
					<label for="" class="col-sm-3 control-label">客户属性</label>
					<div class="col-sm-9">
						<s:select name="clienttype.id" cssClass="form-control input-sm"
							list="clienttypeList" listKey="id" listValue="ctypedesc"
							value="#adcontract.clienttype.id" disabled="true">
						</s:select>
					</div>
				</div>
				
				<div class="form-group col-lg-6 col-md-12">
					<label for="" class="col-sm-3 control-label">单据类型</label>
					<div class="col-sm-9">
						<s:select name="adcontract.publishstyle.id" cssClass="form-control input-sm"
							list="publishstyleList" listKey="id" listValue="name"
							value="#adcontract.publishstyle.id" disabled="true">
						</s:select>
					</div>
				</div>

				<div class="form-group col-lg-6 col-md-12">
					<label for="" class="col-sm-3 control-label">单据来源</label>
					<div class="col-sm-9">
						<s:select name="channel.id" cssClass="form-control input-sm"
							list="channelList" listKey="id" listValue="channelname"
							value="#adcontract.channel.id" disabled="true">
						</s:select>
					</div>
				</div>

				<div class="form-group col-lg-6 col-md-12">
					<label for="" class="col-sm-3 control-label">合同金额</label>
					<div class="col-sm-9">
						<input class="form-control input-sm"  name="adcontract.amount" 
						value='<s:property value="#adcontract.amount"/>' maxlength="20" readonly="readonly"></input>
					</div>
				</div>
				
				<div class="form-group col-lg-6 col-md-12">
					<label for="" class="col-sm-3 control-label">下单人</label>
					<div class="col-sm-9">
						<input class="form-control input-sm " 
							name="adcontract.place" value='<s:property value="#adcontract.placer"/>' 
							maxlength="20" readonly="readonly"></input>
					</div>
				</div>

				<div class="form-group col-lg-6 col-md-12">
					<label for="" class="col-sm-3 control-label">备注</label>
					<div class="col-sm-9">
						<textarea class="form-control input-sm " rows="1"
							name="adcontract.remark" maxlength="150" readonly="readonly"><s:property
								value="#adcontract.remark" /></textarea>
					</div>
				</div>
				<div class="col-lg-12 col-md-12">
					<table id="tb_order" ></table>
				</div>
			</form>

<!-- 			<div class="col-lg-12 col-md-12">
				<p class="text-center">
					<button type="button" class="btn btn-custom-primary btn-sm"
						id="back" onclick="goBack()"
						style="float:left;background:#AAAAAB;border:2px solid #e5e5e5;margin-left:40%;width:63px">
						</i>返回
					</button>
					<button type="button" class="btn btn-danger btn-sm" id="save"
						style="margin-left:-40%">
						<i class="fa fa-floppy-o"></i> 保存
					</button>
				</p>
			</div> -->
			
		<div class="modal fade " id="modal-alterAdvertise">
			<div class="modal-dialog ">
				<div class="modal-content col-sm-12">
					<div class="modal-header">
						<h4 class="modal-title" id="myModalLabel">改刊内容</h4>
					</div>
					<div class="modal-body " >
						<form id="alterAdvertise_form" action="" class="form-horizontal" role="form">
							<input class="hidden" id="order.id" name="tid"/>
							<div class="form-group">
							    <label for="name">发布内容</label>
							    <input type="text" class="form-control" name="order.content" id="order.content" />
							</div>
							<div class="form-group">
							    <label for="name">上画点位</label>
							    <s:select name="order.led.id" cssClass="form-control"
									list="ledList" listKey="id" listValue="name">
								</s:select>
							</div>
							<div class="form-group">
							    <label for="name">时长</label>
							    <input type="text" class="form-control" name="order.duration" id="order.duration" />
							</div>
							<div class="form-group">
							    <label for="name">频次</label>
							    <input type="text" class="form-control" name="order.frequency" id="order.frequency" />
							</div>
							<div class="form-group">
							    <label for="name">起始日期</label>
							    <input type="date" class="form-control" name="order.startdate" id="order.startdate" />
							</div>
							<div class="form-group">
							    <label for="name">结束日期</label>
							    <input type="date" class="form-control" name="order.enddate" id="order.enddate" />
							</div>
							<div class="form-group">
							    <label for="name">开始时间</label>
							    <input type="time" class="form-control" name="order.starttime" id="order.starttime" />
							</div>
							<div class="form-group">
							    <label for="name">结束时间</label>
							    <input type="time" class="form-control" name="order.endtime" id="order.endtime" />
							</div>
							<div class="form-group">
							    <label for="name">播放策略</label>
							    <s:select name="order.playstrategy.id" cssClass="form-control"
									list="playstrategyList" listKey="id" listValue="strategyname">
								</s:select>
							</div>
							<div class="form-group">
							    <label for="name">备注</label>
							    <!-- <input class="form-control" name="remark" id="batchStopAdRemark" /> -->
							    <textarea class="form-control input-sm " rows="2"
									name="remark" id="batchStopAdRemark" maxlength="150" ></textarea>
							</div>
							<div class="form-group" id="showOriginOrderdetail">
								
							</div>
						</form>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal">
							<i class="fa fa-times-circle"></i> 取消
						</button>
						<button id="ok" type="button" class="btn btn-custom-primary" >
							<i class="fa fa-check-circle"></i> 确认
						</button>
					</div>
				</div>
				<!-- /.modal-content -->
			</div>
			<!-- /.modal-dialog -->
		</div>
		<!-- /.modal -->
		
		<div class="modal fade " id="modal-batchStopAdvertise">
			<div class="modal-dialog ">
				<div class="modal-content col-sm-12">
					<div class="modal-header">
						<h4 class="modal-title" >停撤刊信息</h4>
					</div>
					<div class="modal-body " >
						<form id="batchStopAdvertise_form" action="" class="form-horizontal" role="form">
							<!-- <div class="form-group">
							    <label for="name">日期</label>
							    <input type="date" class="form-control" name="adEndDate" id="adEndDate" />
							</div> -->
							<div class="form-group">
							    <label for="name">开始日期</label>
							    <input type="date" class="form-control" name="stopAdvertiseDateFrom" id="stopAdvertiseDateFrom" max="2099-12-31"/>
							</div>
							<div class="form-group">
							    <label for="name">结束日期</label>
							    <input type="date" class="form-control" name="stopAdvertiseDateTo" id="stopAdvertiseDateTo" max="2099-12-31"/>
							</div>
							<div class="form-group">
							    <label for="name">备注</label>
							    <!-- <input class="form-control" name="remark" id="batchStopAdRemark" /> -->
							    <textarea class="form-control input-sm " rows="2"
									name="remark" id="batchStopAdRemark" maxlength="150" ></textarea>
							</div>
							
						</form>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal">
							<i class="fa fa-times-circle"></i> 取消
						</button>
						<button id="batchOperate_ok" type="button" class="btn btn-custom-primary" >
							<i class="fa fa-check-circle"></i> 提交
						</button>
					</div>
				</div>
				<!-- /.modal-content -->
			</div>
			<!-- /.modal-dialog -->
		</div>
		<!-- /.modal -->
		
		<!-- Button trigger modal -->
		
		
		<!-- Modal -->
		<div class="modal fade" id="alterHistoryModal" aria-labelledby="alterHistoryModalLabel" >
		  <div class="modal-dialog">
		    <div class="modal-content">
		      <div class="modal-header">
		        <h3 class="modal-title " id="alterHistoryModalLabel">改停撤刊记录</h3>
		      </div>
		      <div class="modal-body" id="alterHistoryModalBodyContent">
		      
		      </div>
		      <div class="modal-footer">
		        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal" onclick="closeAlterHistoryModal()">关闭</button>
		      </div>
		    </div>
		  </div>
		</div>

		</div>
	</div>
<script type="text/javascript" src="js/bootstrap-datetimepicker.js"></script>
<script type="text/javascript" src="js/bootstrap-datetimepicker.zh-CN.js" charset="UTF-8"></script>
<script type="text/javascript" src="js/king-common.js"></script>
<script type="text/javascript" src="js/moment.js"></script>
<script type="text/javascript" src="js/daterangepicker.js"></script>
<script type="text/javascript" >

	var nameValid = true;

	var originalAdcontractid = '${adcontract.id}';
	var originalAdcontractclient = '${adcontract.client}';
	var originalAdcontractagency = '${adcontract.agency}';
	var originalAdcontractclienttype = '${adcontract.clienttype.id}';
	var originalAdcontractchannel = '${adcontract.channel.id}';
	var originalAdcontractremark = '${adcontract.remark}';

/* 	var originalOrderid = '${order.id}';
	var originalOrdercontent = '${order.content}';
	var originalOrderled = '${order.led.id}';
	var originalOrderindustry = '${order.industry.industryid}';
	var originalOrderattribute = '${order.attribute.id}';
	var originalOrderfrequency = '${order.frequency}';
	var originalOrderduration = '${order.duration}';
	var originalOrderstartdate = '<s:date name="#order.startdate" format="yyyy-MM-dd" />';
	var originalOrderenddate = '<s:date name="#order.enddate" format="yyyy-MM-dd" />';
	var originalOrderstarttime = '${order.starttime}';
	var originalOrderendtime = '${order.endtime}'; */
	
	var orderListRows = new Array();

	//保存按钮的点击事件
/* 	$("#save")
		.click(
			function() {

				//时间需要格式化为HH:mm:ss格式，否则后台无法封装对象
				if ($("#starttime1").val().length == 5) {
					$("#starttime1")
						.val($("#starttime1").val() + ":00");
				}
				if ($("#endtime1").val().length == 5) {
					$("#endtime1").val($("#endtime1").val() + ":00");
				}

				if ($("input[name='adcontract.client']").val() == originalAdcontractclient
					&& $("input[name='adcontract.agency']").val() == originalAdcontractagency
					&& $("textarea[name='adcontract.remark']").val() == originalAdcontractremark
					&& $("select[name='channel.id']").val() == originalAdcontractchannel
					&& $("select[name='clienttype.id']").val() == originalAdcontractclienttype
					&& $("input[name='order.content']").val() == originalOrdercontent
					&& $("select[name='led.id']").val() == originalOrderled
					&& $("select[name='industry.industryid']").val() == originalOrderindustry
					&& $("select[name='attribute.id']").val() == originalOrderattribute
					&& $("input[name='order.frequency']").val() == originalOrderfrequency
					&& $("input[name='order.duration']").val() == originalOrderduration
					&& $("input[name='order.startdate']").val() == originalOrderstartdate
					&& $("input[name='order.enddate']").val() == originalOrderenddate
					&& $("input[name='order.starttime']").val() == originalOrderstarttime
					&& $("input[name='order.endtime']").val() == originalOrderendtime) {
					alert("您没有修改信息！");
					return;
				} else {
					$('#save').attr('disabled', "true");
					$.ajax({
						url : "updateOrder.action",
						type : "post",
						data : $("#updateOrderForm").serializeArray(),
						dataType : "json",
						success : function(data) {
							alert(data.info);
							if (data.state === 0) { //操作成功
								$('#save').removeAttr("disabled");
							}
						},
						error : function(XMLHttpRequest, textStatus, errorThrown) {
							alert('保存失败，请联系系统管理员处理！\nXMLHttpRequest.readyState['
								+ XMLHttpRequest.readyState
								+ ']\nXMLHttpRequest.status['
								+ XMLHttpRequest.status
								+ ']\ntextStatus['
								+ textStatus + ']');
							$('#save').removeAttr("disabled");
						}
					});
				}
			}); */

	function goBack() {
		if (confirm("您确定要放弃相关操作，返回到认刊书列表中吗？")) {
			location.replace('renkanshuManage');
		}
	}

	function deletePublishdetail(obj) {
		console.log($(obj).parent());
		return false;
	}

	function setSSTime(obj) {
		var led = $(obj).val();
		$.ajax({
			url : "returnLedSSTime.action",
			type : "post",
			async : false,
			data : {
				ledId : led
			},
			dataType : "json",
			success : function(data) {
				console.log(data.startTime);
				console.log(data.endTime);
				var tridx = parseInt(obj.id.replace(/[^0-9]/ig, ""));
				$("#starttime" + tridx).val(data.startTime);
				$("#endtime" + tridx).val(data.endTime);
			}
		});

	}

	$(function() {
		//初始化Table
		$('#tb_order').bootstrapTable({
			url : 'operateOrderList.action?adcontractid=' + originalAdcontractid, //请求后台的URL（*）
			method : 'post', //请求方式（*）
			//toolbar: '#toolbar',                //工具按钮用哪个容器
			striped : true, //是否显示行间隔色
			cache : false, //是否使用缓存，默认为true，所以一般情况下需要设置一下这个属性（*）
			pagination : true, //是否显示分页（*）
			sortable : false, //是否启用排序
			sortOrder : "asc", //排序方式
			/*queryParams: {adcontract_id: originalAdcontractid},			//传递参数（*） */
			sidePagination : "client", //分页方式：client客户端分页，server服务端分页（*）
			pageNumber : 1, //初始化加载第一页，默认第一页
			pageSize : 10, //每页的记录行数（*）
			pageList : [ 10, 20, 50, 100, 200], //可供选择的每页的行数（*）
			search : false, //是否显示表格搜索，此搜索是客户端搜索，不会进服务端，所以，个人感觉意义不大
			strictSearch : true,
			showColumns : true, //是否显示所有的列
			showRefresh : true, //是否显示刷新按钮
			minimumCountColumns : 5, //最少允许的列数
			clickToSelect : false, //是否启用点击选中行
			// height : 500, //行高，如果没有设置height属性，表格自动根据记录条数觉得表格高度
			uniqueId : "id", //每一行的唯一标识，一般为主键列
			showToggle : false, //是否显示详细视图和列表视图的切换按钮
			cardView : false, //是否显示详细视图
			detailView : false, //是否显示父子表
			columns : [
			{
				checkbox : true
			},
			{
				field : 'id',
				title : '编号',
				visible: false
			}, {
				field : 'content',
				title : '发布内容'
			}, {
				field : 'led',
				title : '上画点位'
			}, {
				field : 'industry',
				title : '行业类型'
			}, {
				field : 'attribute',
				title : '下单属性'
			}, {
				field : 'frequency',
				title : '广告频次'
			}, {
				field : 'duration',
				title : '广告时长'
			}, {
				field : 'startdate',
				title : '开始日期'
			}, {
				field : 'enddate',
				title : '结束日期'
			}, {
				field : 'starttime',
				title : '开始时间'
			}, {
				field : 'endtime',
				title : '结束时间'
			}, {
				field : 'playstrategy',
				title : '播放策略'
			}, {
				field : 'operatetype',
				title : '单据类型',
				formatter : operateFormatter
			}, {
				field : 'action',
				title : '操作',
				formatter : actionFormatter
			}, ],
			onLoadSuccess: function(data){
				//console.log(data);
				orderListRows = new Array();
				for(var i=0; i<data.length; i++){
					orderListRows.push(data[i]);
				}
			}
		});	

	});
	
	// 查看改停撤刊历史
	function operateFormatter(value, row, index) {
		//orderListRows.push(row);
		var result = "";
		console.log(value, row, index);
		if (value == "认刊") {
			result = value;
		} else {
			result = "<a href='javascript:;' class='btn btn-xs blue' onclick='showAlterHistory(" + row.id + ")' title='查看改刊记录'>" + value + "</a>";
		}
		return result;
	}
	
	function closeAlterHistoryModal() {
		$("#alterHistoryModalBodyContent").html("");
		$("#alterHistoryModal").modal('hide');
	}

	//操作栏的格式化
	function actionFormatter(value, row, index) {
		//orderListRows.push(row);
		var result = "";
		result += "<a href='javascript:;' class='btn btn-xs green' onclick='alterAdvertise("+ index +")' title='改刊'><span class='glyphicon glyphicon-pencil'></span></a>";
		result += "<a href='javascript:;' class='btn btn-xs blue' onclick='stopAdvertise("+ index +")' title='停刊'><span class='glyphicon glyphicon-off'></span></a>";
		result += "<a href='javascript:;' class='btn btn-xs red' onclick='revokeAdvertise("+ index +")' title='撤刊'><span class='glyphicon glyphicon-remove'></span></a>";

		return result;
	}

	function showAlterHistory(orderid) {
		
		console.log(orderid);
		
		$.ajax({
			url : "orderOperateHistory.action?orderid=" + orderid,
			async : false,
			success : function(result) {
				let alterhistorycontent = "";
				console.log(result);
				const jsonArr = JSON.parse(result);
				if (result.length > 0) {
					for (var i = 0; i < jsonArr.length; i++) {
						let altercontent = "";
						if (jsonArr[i].operatetype == "停刊") {
							altercontent += ",停刊日期:" + jsonArr[i].startdate + "至" + jsonArr[i].enddate + "<br>";
						} else if (jsonArr[i].operatetype == "撤刊") {
							altercontent += ",撤刊日期:" + jsonArr[i].startdate + "至" + jsonArr[i].enddate + "<br>";
						} else if (jsonArr[i].operatetype == "改刊") {
							altercontent += ", " + jsonArr[i].remark + "<br>";
						}
						
						alterhistorycontent += jsonArr[i].operatetype + ", 操作时间:" + jsonArr[i].alterdate + ", 操作人:" + jsonArr[i].operater + altercontent;
						console.log(jsonArr[i]);
					}
				}
				
				$("#alterHistoryModalBodyContent").html(alterhistorycontent);
			}
		});

		$("#alterHistoryModal").modal('show');
	}

	function alterAdvertise(rowIndex) {
		checkLocalStorageSupport();
		console.log("dataRows=" + orderListRows.length);
		var target = orderListRows[rowIndex];
		$("input[name='order.content']").val(target.content);
		$("input[name='order.duration']").val(target.duration);
		$("input[name='order.frequency']").val(target.frequency);
		//拼接日期字符串
		var sds = target.startdate;
		var eds = target.enddate;
		var sdsarr = sds.split(".");
		var edsarr = eds.split(".");
		for (var i = 0; i < sdsarr.length; i++) {
			if (sdsarr[i] < 10) {
				sdsarr[i] = 0 + sdsarr[i];
			}
		}
		for (var i = 0; i < edsarr.length; i++) {
			if (edsarr[i] < 10) {
				edsarr[i] = 0 + edsarr[i];
			}
		}
		var sdsstr = "";
		var edsstr = "";
		for (var i = 0; i < sdsarr.length; i++) {
			sdsstr += sdsarr[i] + "-";
			edsstr += edsarr[i] + "-";
		}
		$("input[name='order.startdate']").val(sdsstr.substr(0, sdsstr.length - 1));
		$("input[name='order.enddate']").val(edsstr.substr(0, edsstr.length - 1));
		$("input[name='order.starttime']").val(target.starttime + ":00");
		$("input[name='order.endtime']").val(target.endtime + ":00");
		$("input[name='tid']").val(target.id);
		console.log("tid=" + $("input[name='tid']").val());

		$("select[name='order.led.id']").find("option").filter(function(index) {
			return target.led === $(this).text();
		}).attr("selected", true);

		$("select[name='order.playstrategy.id']").find("option").filter(function(index) {
			return target.playstrategy === $(this).text();
		}).attr("selected", true);
		var orderdetaildata = "<h4>原单内容</h4>";
		orderdetaildata += "发布内容：" + target.content + "<br>";
		orderdetaildata += "上画点位：" + target.led + "<br>";
		orderdetaildata += "时长：" + target.duration + "<br>";
		orderdetaildata += "频次：" + target.frequency + "<br>";
		orderdetaildata += "起止日期：" + target.startdate + " - " + target.enddate + "<br>";
		orderdetaildata += "起止时间：" + target.starttime + " - " + target.endtime + "<br>";
		orderdetaildata += "播放策略：" + target.playstrategy + "<br>";

		localStorage.setItem("singleRowSelected", rowIndex);
		var selectedRows = $("#tb_order").bootstrapTable('getSelections')
		//多选的时候，不显示原单内容，显示确认改刊信息
		if (selectedRows.length > 1) {
			var alterPropertiesCheckbox = "<h4>改刊信息</h4>";
			alterPropertiesCheckbox += "<button type='button' class='btn btn-default' name='propertiesCheck' value='content' id='contentCheck' onclick='checkSelect(this)'>发布内容</button>";
			alterPropertiesCheckbox += "<button type='button' class='btn btn-default' name='propertiesCheck' value='duration' id='durationCheck' onclick='checkSelect(this)'>时长</button>";
			alterPropertiesCheckbox += "<button type='button' class='btn btn-default' name='propertiesCheck' value='frequency' id='frequencyCheck' onclick='checkSelect(this)'>频次</button>";
			alterPropertiesCheckbox += "<button type='button' class='btn btn-default' name='propertiesCheck' value='startdate' id='startdateCheck' onclick='checkSelect(this)'>起始日期</button>";
			alterPropertiesCheckbox += "<button type='button' class='btn btn-default' name='propertiesCheck' value='enddate' id='enddateCheck' onclick='checkSelect(this)'>结束日期</button>";
			alterPropertiesCheckbox += "<button type='button' class='btn btn-default' name='propertiesCheck' value='starttime' id='starttimeCheck' onclick='checkSelect(this)'>开始时间</button>";
			alterPropertiesCheckbox += "<button type='button' class='btn btn-default' name='propertiesCheck' value='endtime' id='endtimeCheck' onclick='checkSelect(this)'>结束时间</button>";

			orderdetaildata = alterPropertiesCheckbox;
		}

		$("#showOriginOrderdetail").html(orderdetaildata);
		$("#modal-alterAdvertise").modal('show');
	}

	$("#ok").click(function() {
		//禁用按钮，防止重复提交
		$("#ok").attr('disabled', 'disabled');

		var str1 = $("input[name='order.starttime']").val();
		var str2 = $("input[name='order.endtime']").val();
		if (str1.length < 8) {
			$("input[name='order.starttime']").val(str1 + ":00")
		}
		if (str2.length < 8) {
			$("input[name='order.endtime']").val(str2 + ":00")
		}

		var selectedRows = $("#tb_order").bootstrapTable('getSelections');
		var orderArray = new Array();
		var alterPropertiesArray = new Array();
		var confirmTip = "确定要改刊吗？";
		var orderRowData = orderListRows[localStorage.getItem("singleRowSelected")];
		console.log(orderRowData);
		var confirmContentText = completeConfirmContent(orderRowData);
		var multiSelectConfirmContentTemp = "";
		if (selectedRows.length > 1) {
			for (var i = 0; i < selectedRows.length; i++) {
				var target = selectedRows[i];
				orderArray.push(target.id);
				multiSelectConfirmContentTemp += completeConfirmContent(target);
			}
			confirmTip = "你选中了多条数据，确定要改刊吗？"
		}
		var propertiesButtonCheck = $(":input[name='propertiesCheck']");
		if (propertiesButtonCheck.length > 0) {
			for (var i = 0; i < propertiesButtonCheck.length; i++) {
				if ($(propertiesButtonCheck[i]).hasClass("btn-success")) {
					alterPropertiesArray.push($(propertiesButtonCheck[i]).val());
				}
			}
		}
		if (orderArray.length > 1 && alterPropertiesArray < 1) {
			alert("请点击指定改刊信息！<br>点击选中，再次点击可以取消选中。");
			return;
		}
		var alterPropertiesObj = {
			name : "alterPropertiesArray",
			value : alterPropertiesArray
		};
		var multiselectedarrayobject = {
			name : "orderArray",
			value : orderArray
		};

		var alterAdsFormData = $("#alterAdvertise_form").serializeArray();
		console.log(alterAdsFormData);
		alterAdsFormData.push(multiselectedarrayobject);
		alterAdsFormData.push(alterPropertiesObj);
		console.log(alterAdsFormData);
		$.confirm({
			title : confirmTip,
			content : multiSelectConfirmContentTemp,
			type : "blue",
			icon : "glyphicon glyphicon-question-sign",
			buttons : {
				confirm : {
					text : "确认",
					btnClass : "btn-primary",
					action : function() {
						$.ajax({
							url : "alterAdvertisingAction.action",
							data : alterAdsFormData,
							type : "post",
							dataType : "json",
							traditional : true,
							async : false,
							success : function(data) {
								if (data.state === 0) {
									location.reload();
								} else {
									$.alert({
										title : "系统提示",
										content : data.info
									});
									$('#tb_order').bootstrapTable('refresh');
								}
							},
							error : function(XMLHttpRequest, textStatus, errorThrown) {
								$.alert('操作失败\nXMLHttpRequest.readyState[' + XMLHttpRequest.readyState + ']\nXMLHttpRequest.status[' + XMLHttpRequest.status + ']\ntextStatus[' + textStatus + ']');
							}
						});
						localStorage.clear();
						$("#modal-alterAdvertise").modal('hide');
						$("#ok").removeAttr('disabled');
					},
				},
				cancel : {
					text : "取消",
					action : function() {
						localStorage.clear();
						$("#modal-alterAdvertise").modal('hide');
						$("#ok").removeAttr('disabled');
						return;
					}
				}
			}
		});

	});

	$("#batchOperate_ok").click(function() {
		$("#batchOperate_ok").attr('disabled', 'disabled');
		var selectedRows = $("#tb_order").bootstrapTable('getSelections');
		var orderArray = new Array();
		var adEndDate = $("#adEndDate").val();
		var stopAdvertiseDateFrom = $("#stopAdvertiseDateFrom").val();
		var stopAdvertiseDateTo = $("#stopAdvertiseDateTo").val();
		var remark = $("#batchStopAdRemark").val();

		var confirmTip = "确定要" + localStorage.getItem("stopOrRevoke") + "吗？";
		var orderRowData = orderListRows[localStorage.getItem("singleRowSelected")];
		var confirmContentText = completeConfirmContent(orderRowData);
		var multiSelectConfirmContentTemp = "";
		if (selectedRows.length > 0) {
			for (var i = 0; i < selectedRows.length; i++) {
				var target = selectedRows[i];
				orderArray.push(target.id);
				multiSelectConfirmContentTemp += completeConfirmContent(target);
			}
			confirmTip = "你选中了多条数据，确定要" + localStorage.getItem("stopOrRevoke") + "吗？"
		}
		console.log(orderArray);

		/* 		var stopAdvertiseConfirm = confirm(confirmTip);
				if (stopAdvertiseConfirm == true) {
					$.ajax({
						url : localStorage.getItem("operateUrl"),
						data : {
							tid : orderListRows[localStorage.getItem("singleRowSelected")].id,
							orderArray : orderArray,
							adEndDate : adEndDate,
							remark : remark
						},
						type : "post",
						dataType : "json",
						traditional : true,
						success : function(data) {
							if (data.state === 0) {
								location.reload();
							} else {
								alert(data.info);
							}
						},
						error : function(XMLHttpRequest, textStatus, errorThrown) {
							alert('操作失败\nXMLHttpRequest.readyState[' + XMLHttpRequest.readyState + ']\nXMLHttpRequest.status[' + XMLHttpRequest.status + ']\ntextStatus[' + textStatus + ']');
						}
					});
				} else {
					return;
				} */
		$.confirm({
			title : confirmTip,
			content : multiSelectConfirmContentTemp,
			type : "blue",
			icon : "glyphicon glyphicon-question-sign",
			buttons : {
				confirm : {
					text : "确认",
					btnClass : "btn-primary",
					action : function() {
						$.ajax({
							url : localStorage.getItem("operateUrl"),
							data : {
								tid : orderListRows[localStorage.getItem("singleRowSelected")].id,
								orderArray : orderArray,
								//adEndDate : adEndDate,
								stopAdvertiseDateFrom : stopAdvertiseDateFrom,
								stopAdvertiseDateTo : stopAdvertiseDateTo,
								remark : remark
							},
							type : "post",
							dataType : "json",
							traditional : true,
							async : false,
							success : function(data) {
								if (data.state === 0) {
									location.reload();
								} else {
									$.alert({
										title : "系统提示",
										content : data.info
									});
									$('#tb_order').bootstrapTable('refresh');
								}
							},
							error : function(XMLHttpRequest, textStatus, errorThrown) {
								$.alert('操作失败\nXMLHttpRequest.readyState[' + XMLHttpRequest.readyState + ']\nXMLHttpRequest.status[' + XMLHttpRequest.status + ']\ntextStatus[' + textStatus + ']');
							}
						});
						localStorage.clear();
						$("#modal-batchStopAdvertise").modal('hide');
						$("#batchOperate_ok").removeAttr('disabled');
					},
				},
				cancel : {
					text : "取消",
					action : function() {
						localStorage.clear();
						$("#modal-batchStopAdvertise").modal('hide');
						$("#batchOperate_ok").removeAttr('disabled');
						return;
					}
				}
			}
		});

	});

	function stopAdvertise(target) {
		checkLocalStorageSupport();
		localStorage.setItem("singleRowSelected", target);
		localStorage.setItem("stopOrRevoke", "停刊");
		localStorage.setItem("operateUrl", "stopAdvertisingAction.action");
		$("#modal-batchStopAdvertise").modal('show');
	}

	function revokeAdvertise(target) {
		checkLocalStorageSupport();
		localStorage.setItem("singleRowSelected", target);
		localStorage.setItem("stopOrRevoke", "撤刊");
		localStorage.setItem("operateUrl", "revokeAdvertisingAction.action");
		$("#modal-batchStopAdvertise").modal('show');
	}

	function checkLocalStorageSupport() {
		if (window.localStorage) {
		} else {
			alert('您的浏览器不支持本地功能，推荐使用Chrome内核浏览器进行操作！');
			return;
		}
	}

	function completeConfirmContent(target) {
		var confirmContent = "";
		confirmContent += "发布内容：" + target.content + " ";
		confirmContent += "上画点位：" + target.led + " ";
		confirmContent += "时长：" + target.duration + " ";
		confirmContent += "频次：" + target.frequency + " ";
		confirmContent += "起止日期：" + target.startdate + " - " + target.enddate + " ";
		confirmContent += "起止时间：" + target.starttime + " - " + target.endtime + " ";
		confirmContent += "播放策略：" + target.playstrategy + " ";
		confirmContent += "<br>";

		return confirmContent;
	}

	function checkSelect(obj) {
		if ($(obj).hasClass("btn-success")) {
			$(obj).removeClass("btn-success");
		} else {
			$(obj).addClass("btn-success");
		}
	}

	//加
	Number.prototype.add = function(arg) {
		var r1, r2, m;
		try {
			r1 = this.toString().split(".")[1].length;
		} catch (e) {
			r1 = 0;
		}
		try {
			r2 = arg.toString().split(".")[1].length;
		} catch (e) {
			r2 = 0;
		}
		m = Math.pow(10, Math.max(r1, r2));
		return (this * m + arg * m) / m;
	};
	// 减法
	Number.prototype.sub = function(arg) {
		return this.add(-arg);
	};

	// 乘法
	Number.prototype.mul = function(arg) {
		var m = 0, s1 = this.toString(), s2 = arg.toString();
		try {
			m += s1.split(".")[1].length;
		} catch (e) {
		}
		try {
			m += s2.split(".")[1].length;
		} catch (e) {
		}
		return Number(s1.replace(".", "")) * Number(s2.replace(".", "")) / Math.pow(10, m);
	};
	// 除法
	Number.prototype.div = function(arg) {
		var t1 = 0, t2 = 0, r1, r2;
		try {
			t1 = this.toString().split(".")[1].length;
		} catch (e) {
		}
		try {
			t2 = arg.toString().split(".")[1].length;
		} catch (e) {
		}
		with (Math) {
			r1 = Number(this.toString().replace(".", ""));
			r2 = Number(arg.toString().replace(".", ""));
			return (r1 / r2) * pow(10, t2 - t1);
		}
	};
</script>
</body>
</html>

