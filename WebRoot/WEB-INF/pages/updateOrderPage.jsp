<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
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
<link href="css/bootstrap-table.css" rel="stylesheet">
<link href="css/jquery-confirm.min.css" rel="stylesheet">

<link rel="stylesheet" href="css/bootstrap-theme.css">
<link href="css/jquery-ui.min.css" rel="stylesheet" media="screen">
<link href="css/styles.css" rel="stylesheet">
<link href="css/laydate.css" rel="stylesheet">

<!--Icons-->
<script src="js/lumino.glyphs.js"></script>
<script src="js/jquery-1.11.1.min.js"></script>
<script src="js/bootstrap.min.js"></script>
<script src="js/jquery-ui.min.js"></script>
<script src="js/bootstrap-table.js"></script>
<script src="js/jquery-confirm.min.js"></script>


</head>
<body style="font-family: '微软雅黑';">
	<div class="main">

		<!--/.row-->

		<div class="row">
			<div class="col-lg-12">
				<h3 class="page-header">修改认刊书</h3>
			</div>
		</div>
		<!--/.row-->
		<div class="row">
			<form id="updateOrderForm" class="form-horizontal" role="form">
				<input type="text" class="hidden" name="adcontract.id"
					value='${adcontract.id }'> <input type="text"
					class="hidden" name="order.id" value='${order.id }'>
				<div class="form-group col-lg-6 col-md-12">
					<label for="account" class="col-sm-3 control-label">广告刊户</label>
					<div class="col-sm-9">
						<input type="text" class="form-control input-sm"
							name="adcontract.client"
							value='<s:property value="#adcontract.client"/>' maxlength="20">
					</div>
				</div>
				<div class="form-group col-lg-6 col-md-12">
					<label for="account" class="col-sm-3 control-label">代理公司</label>
					<div class="col-sm-9">
						<input type="text" class="form-control input-sm"
							name="adcontract.agency"
							value='<s:property value="#adcontract.agency"/>' maxlength="20">
					</div>
				</div>

				<div class="form-group col-lg-6 col-md-12">
					<label for="" class="col-sm-3 control-label">客户属性</label>
					<div class="col-sm-9">
						<s:select name="clienttype.id" cssClass="form-control input-sm"
							list="clienttypeList" listKey="id" listValue="ctypedesc"
							value="#adcontract.clienttype.id">
						</s:select>
					</div>
				</div>

				<div class="form-group col-lg-6 col-md-12">
					<label for="" class="col-sm-3 control-label">单据来源</label>
					<div class="col-sm-9">
						<s:select name="channel.id" cssClass="form-control input-sm"
							list="channelList" listKey="id" listValue="channelname"
							value="#adcontract.channel.id">
						</s:select>
					</div>
				</div>

				<div class="form-group col-lg-6 col-md-12">
					<label for="" class="col-sm-3 control-label">下单人</label>
					<div class="col-sm-9">
						<textarea class="form-control input-sm " rows="1"
							name="adcontract.place" maxlength="150"><s:property
								value="#adcontract.placer" /></textarea>
					</div>
				</div>

				<div class="form-group col-lg-6 col-md-12">
					<label for="" class="col-sm-3 control-label">备注</label>
					<div class="col-sm-9">
						<textarea class="form-control input-sm " rows="1"
							name="adcontract.remark" maxlength="150"><s:property
								value="#adcontract.remark" /></textarea>
					</div>
				</div>
				<div class="col-lg-12 col-md-12">
					<table id="table" class="table-responsive">
						<thead>
							<tr>
								<th data-field="fabuneirong" data-sortable="true">发布内容</th>
								<th data-field="shanghuadianwei" data-sortable="true">上画点位</th>
								<th data-field="hangyeleixing" data-sortable="true">行业类型</th>
								<th data-field="xiadanshuxing" data-sortable="true">下单属性</th>
								<th data-field="pinci" data-sortable="true">广告频次</th>
								<th data-field="shichang" data-sortable="true">广告时长(秒)</th>
								<th data-field="startdate" data-sortable="true">开始日期</th>
								<th data-field="enddate" data-sortable="true">结束日期</th>
								<th data-field="starttime" data-sortable="true">开始时间</th>
								<th data-field="endtime" data-sortable="true">结束时间</th>
								<th data-field="playstrategy" data-sortable="true">播放策略</th>
								<th data-field="operate" data-sortable="false">操作</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td><input name="order.content"
									class="form-control input-sm" id="fabuneirong1"
									value="${order.content }"></td>
								<td><s:select name="led.id" id="shanghuadianwei1"
										cssClass="form-control input-sm" list="ledList" listKey="id"
										listValue="name" value="#order.led.id"
										onchange="setSSTime(this)"></s:select></td>
								<td><s:select name="industry.industryid"
										id="hangyeleixing1" cssClass="form-control input-sm"
										list="industryList" listKey="industryid"
										listValue="industryname" value="#order.industry.industryid"></s:select>
								</td>
								<td><s:select name="attribute.id" id="guanggaoleixing1"
										cssClass="form-control input-sm" list="attributeList"
										listKey="id" listValue="attributename"
										value="#order.attribute.id"></s:select></td>
								<td><input name="order.frequency"
									class="form-control input-sm" id="pinci1"
									value="${order.frequency }"></td>
								<td><input name="order.duration"
									class="form-control input-sm" id="shichang1"
									value="${order.duration }"></td>
								<td><input name="order.startdate"
									class="form-control input-sm" type="date" max="9999-12-31"
									id="startdate1"
									value="<s:date name='#order.startdate' format="yyyy-MM-dd" />"></td>
								<td><input name="order.enddate"
									class="form-control input-sm" type="date" max="9999-12-31"
									id="enddate1"
									value="<s:date name='#order.enddate' format="yyyy-MM-dd" />"></td>
								<td><input name="order.starttime"
									class="form-control input-sm" type="time"
									value="${order.starttime }" id="starttime1"></td>
								<td><input name="order.endtime"
									class="form-control input-sm" type="time"
									value="${order.endtime }" id="endtime1"></td>
								<td><s:select name="playstrategy.id" id="playstrategy1"
										cssClass="form-control input-sm" list="playstrategyList"
										listKey="id" listValue="strategyname"
										value="#order.playstrategy.id"></s:select></td>
								<td><button class="btn btn-danger btn-sm"
										onclick="deletePublishdetail(this)">删除</button></td>
							</tr>
						</tbody>
					</table>
				</div>
			</form>

			<div class="col-lg-12 col-md-12">
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
			</div>

		</div>
	</div>
	<script src="js/bootstrap.min.js"></script>
	<script type="text/javascript" src="js/bootstrap-datetimepicker.js"></script>
	<script src="js/bootstrap-datetimepicker.zh-CN.js" charset="UTF-8"></script>

</body>
</html>
<content tag="scripts">

	<script src="js/jquery.jqGrid.min.js"></script>
	<script src="js/jquery.jqGrid.fluid.js"></script>
	<script src="js/king-common.js"></script>
	<script src="js/moment.js"></script>
	<script src="js/daterangepicker.js"></script>
	<script>
		var nameValid = true;
	
		var originalAdcontractid = '${adcontract.id}';
		var originalAdcontractclient = '${adcontract.client}';
		var originalAdcontractagency = '${adcontract.agency}';
		var originalAdcontractclienttype = '${adcontract.clienttype.id}';
		var originalAdcontractchannel = '${adcontract.channel.id}';
		var originalAdcontractremark = '${adcontract.remark}';
	
		var originalOrderid = '${order.id}';
		var originalOrdercontent = '${order.content}';
		var originalOrderled = '${order.led.id}';
		var originalOrderindustry = '${order.industry.industryid}';
		var originalOrderattribute = '${order.attribute.id}';
		var originalOrderfrequency = '${order.frequency}';
		var originalOrderduration = '${order.duration}';
		var originalOrderstartdate = '<s:date name="#order.startdate" format="yyyy-MM-dd" />';
		var originalOrderenddate = '<s:date name="#order.enddate" format="yyyy-MM-dd" />';
		var originalOrderstarttime = '${order.starttime}';
		var originalOrderendtime = '${order.endtime}';
	
		//保存按钮的点击事件
		$("#save")
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
								$('#save').attr('disabled',"true");
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
										error : function(XMLHttpRequest,textStatus, errorThrown) {
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
						});
	
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
			return Number(s1.replace(".", "")) * Number(s2.replace(".", ""))
					/ Math.pow(10, m);
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
</content>
