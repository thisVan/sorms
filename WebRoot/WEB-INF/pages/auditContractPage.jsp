<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="com.google.gson.*"%>
<%@ page import="java.sql.*"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> 

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
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

<link rel="stylesheet" href="css/bootstrap-theme.css">
<link href="css/styles.css" rel="stylesheet">
<link href="css/laydate.css" rel="stylesheet">

<!--Icons-->
<script src="js/lumino.glyphs.js"></script>
<script src="js/jquery-1.11.1.min.js"></script>
<script src="js/bootstrap-table.js"></script>


</head>
<body style="font-family: '微软雅黑';">
	<div class="main">

		<!--/.row-->

		<div class="row">
			<div class="col-lg-12">
				<h3 class="page-header">合同审核</h3>
			</div>
		</div>
		<!--/.row-->
		<div class="row">
			<div class="col-lg-12">
						<div class="col-lg-12 col-md-6">
							<form id="form_save" class="form-horizontal" role="form">
								<input type="text" class="hidden" name="ids" value='<s:property value="#contractauditEntity.cid"/>'>
								<input type="text" class="hidden" name="cpc" value='<s:property value="#contractauditEntity.cpurchasecost"/>'>
								<div class="form-group">
									<label for="account" class="col-sm-2 control-label">合同编号</label>
									<div class="col-sm-4">
										<p class="form-control-static">
											<s:property value="#contractauditEntity.cno" />
										</p>
									</div>
								</div>
								<div class="form-group">
									<label for="account" class="col-sm-2 control-label">广告客户</label>
									<div class="col-sm-4">
										<p class="form-control-static">
											<s:property value="#contractauditEntity.cclient" />
										</p>
									</div>
								</div>

								<div class="form-group">
									<label for="account" class="col-sm-2 control-label">签订日期</label>
									<div class="col-sm-4">
										<p class="form-control-static">
											<s:date name='#contractauditEntity.cdate' format="yyyy-MM-dd" />
										</p>
									</div>
								</div>
								<div class="form-group">
									<label for="account" class="col-sm-2 control-label">承办人</label>
									<div class="col-sm-4">
										<p class="form-control-static">
											<s:property value="#contractauditEntity.yewuyuan.ywyXingming" />
										</p>
									</div>
								</div>

								<div class="form-group">
									<label for="account" class="col-sm-2 control-label">合同内容</label>
									<div class="col-sm-4">
										<p class="form-control-static">
											<s:property value="#contractauditEntity.ccontent" />
										</p>
									</div>
								</div>

								<div class="form-group">
									<label for="account" class="col-sm-2 control-label">合同金额（元）</label>
									<div class="col-sm-4">
										<p class="form-control-static">
											<fmt:formatNumber type="number" value="${contractauditEntity.camount}" /> 
										</p>
									</div>
								</div>
								
								<div class="form-group">
									<label for="account" class="col-sm-2 control-label">折扣(折)</label>
									<div class="col-sm-4">
										<p class="form-control-static">
											<s:property value="#contractauditEntity.cdiscount * 10" />
										</p>
									</div>
								</div>

								<div class="form-group">
									<label for="role" class="col-sm-2 control-label">合同生效时间</label>
									<div class="col-sm-4">
										<p class="form-control-static">
											<s:date name='#contractauditEntity.cdatestart' format="yyyy-MM-dd" />
										</p>
									</div>
								</div>
								<div class="form-group">
									<label for="account" class="col-sm-2 control-label">合同结束时间</label>
									<div class="col-sm-4">
										<p class="form-control-static">
											<s:date name='#contractauditEntity.cdateend' format="yyyy-MM-dd" />
										</p>
									</div>
								</div>
								<div class="form-group">
									<label for="account" class="col-sm-2 control-label">合同持续时间（月）</label>
									<div class="col-sm-4">
										<p class="form-control-static">
											<s:property value="#contractauditEntity.cperiodmonths" />
										</p>
									</div>
								</div>
								<div class="form-group">
									<label for="account" class="col-sm-2 control-label">置换金额（元）</label>
									<div class="col-sm-4">
										<p class="form-control-static">
											<s:property value="#contractauditEntity.creplacementamount" />
										</p>
									</div>
								</div>
								<div class="form-group">
									<label for="account" class="col-sm-2 control-label">置换内容</label>
									<div class="col-sm-4">
										<p class="form-control-static">
											<s:property value="#contractauditEntity.creplacementcontent" />
										</p>
									</div>
								</div>
<%-- 								<div class="form-group">
									<label for="account" class="col-sm-2 control-label">外购成本(元)</label>
									<div class="col-sm-4">
										<p class="form-control-static">
											<s:property value="#contractauditEntity.cpurchasecost" />
										</p>
									</div>
								</div> --%>
								<div class="form-group">
									<label for="account" class="col-sm-2 control-label">分期付款期数</label>
									<div class="col-sm-4">
										<p class="form-control-static">
											<s:property value="#contractauditEntity.cinstalments" />
										</p>
									</div>
								</div>
								<div class="form-group ">
									<label class="col-sm-2 control-label" for="fukuantable">约定付款信息</label>
									<div class="col-sm-6 ">
											<table id="fukuantable" class="table-condensed" style="table-layout:fixed;">
												<thead align="justify">
													<th>付款期次</th>
													<th>约定付款金额</th>
													<th>约定付款时间</th>
													<th>付款方式</th>
													<th>备注</th>
												</thead>
												<tbody>
													<s:iterator id="fukuan" value="fukuanList" status="st">
														<tr>
															<td><s:property value="#fukuan.mingcheng" /></td>
															<td><fmt:formatNumber type="number" value="${fukuan.jine}" /></td>
															<td><s:date name='#fukuan.fukuanshijian' format='yyyy-MM-dd'/></td>
															<td><s:property value="#fukuan.fukuanfangshi"/></td>
															<td><s:property value="#fukuan.fukuanbeizhu"/></td>
														</tr>
													</s:iterator>
												</tbody>
											</table>
									</div>
								</div>
								<div class="form-group">
									<label for="account" class="col-sm-2 control-label">备注</label>
									<div class="col-sm-4">
										<p class="form-control-static">
											<s:property value="#contractauditEntity.cremark" />
										</p>
									</div>
								</div>

								<div class="form-group">
									<label for="account" class="col-sm-2 control-label">审核内容</label>
									<div class="col-sm-6">
										<p class="form-control-static">${request.remarkContent}</p>
									</div>
									<!--		<label for="account" class="col-sm-8 control-label">${request.remark}</label>  -->
								</div>

								<div class="form-group">
									<label for="account" class="col-sm-2 control-label">审核理由</label>
									<div class="col-sm-6">
										<textarea class="form-control input-sm" name="auditReason" rows="5"></textarea>
									</div>
									<!--		<label for="account" class="col-sm-8 control-label">${request.remark}</label>  -->
								</div>

								<div class="form-group">
									<label for="account" class="col-sm-2 control-label">审核结果</label>
									<div class="simple-radio simple-radio-inline radio-green">
										<input id="pass" type="radio" name="auditResult" value="true" checked> <label for="pass">通过</label> <input id="unpass" type="radio" name="auditResult" value="false"> <label for="unpass">不通过</label>
									</div>
								</div>

							</form>

							<p class="text-center">
								<button type="button" class="btn btn-custom-primary btn-sm" id="back" onclick="goBack()" style="float:left;background:#AAAAAB;border:2px solid #e5e5e5;margin-left:40%;width:63px">
									<i></i>返回
								</button>
								<button type="button" class="btn btn-primary btn-sm" id="submit" style="margin-left:-40%">
									<i class="fa fa-floppy-o"></i> 提交
								</button>
							</p>
						</div>
					</div>
				</div>
			</div>
							<script src="js/jquery-1.11.1.min.js"></script>
							<script src="js/bootstrap.min.js"></script>
							<script type="text/javascript" src="js/bootstrap-datetimepicker.js"></script>
							<script src="js/bootstrap-datetimepicker.zh-CN.js" charset="UTF-8"></script>
							<script type="text/javascript">
								$('.form_datetime').datetimepicker({
									language : 'zh-CN',
									weekStart : 1,
									todayBtn : 1,
									autoclose : 1,
									todayHighlight : 1,
									startView : 2,
									forceParse : 0,
									showMeridian : 1
								});
								$('.form_date').datetimepicker({
									language : 'zh-CN',
									weekStart : 1,
									todayBtn : 1,
									autoclose : 1,
									todayHighlight : 1,
									startView : 2,
									minView : 2,
									forceParse : 0
								});
								$('.form_time').datetimepicker({
									language : 'zh-CN',
									weekStart : 1,
									todayBtn : 1,
									autoclose : 1,
									todayHighlight : 1,
									startView : 1,
									minView : 0,
									maxView : 1,
									forceParse : 0
								});
							</script>
</body>
</html>
<content tag="scripts"> 
<script src="js/jquery.ba-bbq.min.js"></script> <script src="js/grid.history.js"></script> <script src="js/grid.locale-cn.js"></script> <script>
	$.jgrid.useJSON = true;
</script>
<script src="js/jquery.jqGrid.min.js"></script>
<script src="js/jquery.jqGrid.fluid.js"></script>
<script src="js/king-common.js"></script>
<script src="js/moment.js"></script>
<script src="js/daterangepicker.js"></script>
<script>
		$(document).ready(function() {
			var purchaseCost = $("input[name='cpc']").val();
			if(purchaseCost != "") {	//有外购成本
				if(purchaseCost === "0.0") {	//未录入
					$("form#form_save").children(":eq(14)")
						.after('<div class="form-group">'
						+			'<label for="account" class="col-sm-2 control-label">外购成本</label>'
						+			'<div class="col-sm-4">'
						+				'<input class="form-control" type="text" name="cpurchasecost">'
						+			'</div>'
						+		'</div>');
				} else {	//已录入
					$("form#form_save").append('<input class="hidden" name="cpurchasecost" value=' + purchaseCost + '>');
				}
			}
			
			
			//提交按钮的点击事件
			$("#submit").click(function() {
				$.ajax({
					url : "contractAudit.action",
					type : "post",
					data : $("#form_save").serializeArray(),
					dataType : "json",
					success : function(data) {
						alert(data.info);
						if (data.state === 0) { //操作成功
							location.replace('contractAuditListPage');
						}
					},
					error : function(XMLHttpRequest, textStatus, errorThrown) {
						alert('提交失败\nXMLHttpRequest.readyState[' + XMLHttpRequest.readyState + ']\nXMLHttpRequest.status[' + XMLHttpRequest.status + ']\ntextStatus[' + textStatus + ']');
					}
				})
			})
		});

		function goBack() {
			if (confirm("您确定要放弃相关操作，返回到审核列表中吗？")) {
				location.replace('contractAuditListPage');
			}
		}
	</script>
</content>
