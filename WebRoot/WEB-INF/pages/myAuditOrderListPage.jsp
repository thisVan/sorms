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
<link rel="stylesheet" href="css/bootstrap-select.css">

<link rel="stylesheet" href="css/bootstrap-theme.css">
<link href="css/styles.css" rel="stylesheet">
<link href="css/laydate.css" rel="stylesheet">
<link rel="stylesheet" type="text/css" media="screen" href="css/jqGrid4.4.3/ui.jqgrid.css" />
<link href="css/main.css" rel="stylesheet">

<!--Icons-->
<script src="js/lumino.glyphs.js"></script>
<script src="js/jqGrid4.4.3/jquery-1.7.2.min.js"></script>
<script src="js/bootstrap-select.js"></script>
<script src="js/echarts.min.js"></script>

</head>
<body style="font-family: '微软雅黑';">

	<div class="main">
		<form class="form-horizontal" role="form" action="updateMyAddRenkanshuPage" id="updateMyAddRenkanshuForm">
			<div class="input-group input-group-sm">
				<input type="number" class="hidden" name="renkanshuaudit.id" id="add_renkanshuaudit_id">
			</div>
		</form>
		<form class="form-horizontal" role="form" action="updateMyRenkanshuPage" id="updateMyRenkanshuForm">
			<div class="input-group input-group-sm">
				<input type="number" class="hidden" name="renkanshuaudit.id" id="update_renkanshuaudit_id">
			</div>
		</form>

		<!--/.row-->

		<div class="row">
			<div class="col-lg-12">
				<h3 class="page-header">我的认刊书</h3>
			</div>
		</div>
		<!--/.row-->

		<div class="row">
				<div class="" id="tabs">
					<ul class="nav nav-pills">
						<li id="wait4Audit" class="active"><a href="#tab0" data-toggle="tab">待审核<span></span></a></li>
						<li id="auditPassed"><a href="#tab1" data-toggle="tab">已通过<span></span></a></li>
						<li id="auditFailed"><a href="#tab2" data-toggle="tab">未通过<span></span></a></li>
					</ul>

					<div id="tab0" >
						<div class="col-lg-12">
							<label>&nbsp;</label>
						</div>
						<div id="jqgrid-wrapper_waitForAudit" class="">
							<table id="jqgrid_waitForAudit" class="table table-striped table-hover table-bordered"></table>
							<div id="jqgrid-pager_waitForAudit"></div>
						</div>

					</div>

					<div id="tab1">
						<div class="col-lg-12">
							<div class="col-sm-12">
								<lable>&nbsp;</lable>
							</div>
						</div>

						<div id="jqgrid-wrapper_passed">
							<table id="jqgrid_passed" class="table table-striped table-hover table-bordered"></table>
							<div id="jqgrid-pager_passed"></div>
						</div>
						<div class="col-sm-12">
							<lable>&nbsp;</lable>
						</div>

					</div>

					<div id="tab2">
						<div class="col-lg-12">
							<lable>&nbsp;</lable>
						</div>
						<div id="jqgrid-wrapper_noPassed">
							<table id="jqgrid_noPassed" class="table table-striped table-hover table-bordered"></table>
							<div id="jqgrid-pagerjqgrid_noPassed"></div>
						</div>
					</div>
				</div>
			<!--/.row-->
		</div>
	</div>
	<!--/.main-->

	<script src="js/jqGrid4.4.3/jquery-1.7.2.min.js"></script>
	<script src="js/jquery-ui.js"></script>
	<script src="js/bootstrap.min.js"></script>
</body>
</html>

<content tag="scripts">
<script src="js/jquery.ba-bbq.min.js"></script>
<script src="js/grid.history.js"></script>
<script src="js/grid.locale-cn.js"></script>
<script>
		$.jgrid.useJSON = true;
</script> 
<script src="js/jqGrid4.4.3/jquery.jqGrid.src.js"></script>
<script src="js/jquery.jqGrid.fluid.js"></script>
<script src="js/jqGrid4.4.3/plugins/grid.setcolumns.js"></script>
<script src="js/jqGrid4.4.3/plugins/grid.jqueryui.js"></script>
<script src="js/king-common.js"></script>
<script src="js/moment.js"></script>
<script src="js/daterangepicker.js"></script> 
<script src="js/myJs/myWaitforAuditRenkanshu.js"></script> 
<script src="js/myJs/myPassedRenkanshu.js"></script> 
<script src="js/myJs/myNopassedRenkanshu.js"></script>
 	<script>
		var dateRangeSQL ="";

		$(document).ready(function() {
		
			//时间范围控件
			$("#daterange-default").daterangepicker({
				format: 'YYYY/MM/DD',
				showDropdowns: !0,
				ranges: {
	                "过去三年": [moment().subtract("year", 3).startOf("year"), moment().subtract("year", 1).endOf("year")],
					"过去一年": [moment().subtract("year", 1).startOf("year"), moment().subtract("year", 1).endOf("year")],
					"过去半年":[moment().subtract("month", 6).startOf("month"), moment().subtract("month", 1).endOf("month")],
					"上月":[moment().subtract("month", 1).startOf("month"), moment().subtract("month", 1).endOf("month")],
					"过去30天": [moment().subtract("days", 29), moment()],
					"本月": [moment().startOf("month"), moment().endOf("month")],
	            },
	            separator: " 至 ",
	            locale: {
	                applyLabel: "确认",
	                cancelLabel: "清除",
	                fromLabel: "起始",
	                toLabel: "截止",
	                customRangeLabel: "自定义",
	                daysOfWeek: ["日", "一", "二", "三", "四", "五", "六"],
	                monthNames: ["一月", "二月", "三月", "四月", "五月", "六月", "七月", "八月", "九月", "十月", "十一月", "十二月"],
	                firstDay: 1
	            }
			});
			$('#daterange-default').on('cancel.daterangepicker', function(ev, picker) {
			  $('#daterange-default').val('');
			  dateRangeSQL ="";
			});
			$('#daterange-default').on('apply.daterangepicker', function(ev, picker) {
			  console.log("start:"+picker.startDate.format('YYYY-MM-DD')+"\nend:"+picker.endDate.format('YYYY-MM-DD'));
			  dateRangeSQL = "y.renkanshu.qiandingriqi between '"+picker.startDate.format('YYYY-MM-DD')+"' and '"+picker.endDate.format('YYYY-MM-DD')+"' ";
			});
		});
		    

		$(function(){
			$("#tabs").tabs();
		});

	</script>
</content>