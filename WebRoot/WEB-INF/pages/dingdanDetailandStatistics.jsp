<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="com.google.gson.*"%>
<%@ page import="java.sql.*"%>
<%@ taglib uri="/struts-tags" prefix="s"%>

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
<link rel="stylesheet" href="css/bootstrap-select.css">

<link rel="stylesheet" href="css/bootstrap-theme.css">
<link href="css/styles.css" rel="stylesheet">
<link href="css/laydate.css" rel="stylesheet">
<link rel="stylesheet" type="text/css" media="screen"
	href="css/jqGrid4.4.3/ui.jqgrid.css" />

<link href="css/main.css" rel="stylesheet">

<!--Icons-->
<script src="js/lumino.glyphs.js"></script>
<script src="js/jqGrid4.4.3/jquery-1.7.2.min.js"></script>
<script src="js/bootstrap-select.js"></script>
<script src="js/echarts.min.js"></script>

</head>
<body style="font-family: '微软雅黑';">

	<div class="main">
		<form class="form-horizontal" role="form" action="upOrderPage" id="upOrderForm">
			<div class="input-group input-group-sm">
				<input type="text" class="hidden" name="upOrder_id" id="upOrder_id">
			</div>
		</form>

		<!--/.row-->

		<div class="row">
			<div class="col-lg-12">
				<h3 class="page-header">订单明细及相关数据统计</h3>
			</div>
		</div>
		<!--/.row-->

		<div class="row">
			<div class="col-lg-12">
				<div class="panel panel-default">
					<div class="panel-body">

						<div class="row" style="margin-bottom:10px;">
							<div class="col-sm-3 pull-right">
								<div id="fuzzySearchbox" class="input-group input-group-sm searchbox">
									<input type="search" id="searchText" class="form-control" placeholder="请输入关键字..."> <span class="input-group-btn">
										<button class="btn btn-default" type="button" id="searchButton">搜索</button>
									</span>
								</div>
							</div>
						</div>
						<form class="form-horizontal" role="form" id="exactForm">
							<fieldset>
								<legend>查询条件</legend>
								<div class="col-sm-3">
									<div class="input-group input-group-sm">
										<div class="input-group-addon">签订时间</div>
										<input type="text" id="daterange-default" class="form-control"> <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
									</div>
								</div>

								<div class="col-sm-3">
									<div class="input-group input-group-sm">
										<div class="input-group-addon">区域</div>
										<select name="region" id="region" class="form-control">
											<option value="">所有区域</option>
										</select>
									</div>
								</div>

								<div class="col-sm-3">
									<div class="input-group input-group-sm">
										<div class="input-group-addon">屏幕</div>
										<select name="led" id="led" class="form-control">
											<option value="">所有屏幕</option>
										</select>
									</div>
								</div>



								<div class="col-sm-12">
									<lable>&nbsp;</lable>
								</div>

								<div class="col-sm-3">
									<div class="input-group input-group-sm">
										<div class="input-group-addon">行业</div>
										<select name="industry" id="industry" class="form-control selectpicker" data-live-search="true">
											<option value="">所有行业</option>
										</select>
									</div>
								</div>

								<div class="col-sm-3">
									<div class="input-group input-group-sm">
										<div class="input-group-addon">部门</div>
										<select name="department" id="department" class="form-control">
											<option value="">所有部门</option>
										</select>
									</div>
								</div>

								<div class="col-sm-3">
									<div class="input-group input-group-sm">
										<div class="input-group-addon">业务员</div>
										<select name="salesman" id="salesman" class="form-control selectpicker" data-live-search="true">
											<option value="">所有业务员</option>
										</select>
									</div>
								</div>

								<div class="col-sm-2 pull-right">
									<button class="btn btn-primary btn-sm" id="exactQuery">查询</button>
									<button class="btn btn-danger btn-sm" id="clearExactForm">清除</button>
								</div>

							</fieldset>
						</form>

						<!-- <div class="row">
							<div class="col-sm-2 pull-left">
								<button class="btn btn-primary btn-sm" id="exportExcel">导出报表</button>
							</div>
							<div class="col-sm-2 pull-right">
								<button class="btn btn-primary btn-sm" id="selectColumns">选择显示列</button>
							</div>
							<div class="col-sm-12">
								<lable>&nbsp;</lable>
							</div>
						</div>
						<div class="row">
							<div id="jqgrid-wrapper">
								<table id="jqgrid"
									class="table table-striped table-hover table-bordered"></table>
								<div id="jqgrid-pager"></div>
							</div>
						</div> -->
					</div>
				</div>
			</div>
		</div>
	</div>

	<div class="row">
		<div class="col-lg-12">
			<div class="panel panel-default">
				<div class="panel-body">
					<div class="row" class="col-lg-12" id="tabs">
						<ul class="nav nav-pills">
							<li class="active"><a href="#tab0" data-toggle="tab">订单明细详情</a></li>
							<li><a href="#tab1" data-toggle="tab">行业年度占屏率排行</a></li>
							<li><a href="#tab4" data-toggle="tab">行业年度签单金额排行</a></li>
							<li><a href="#tab2" data-toggle="tab">各屏签订金额统计</a></li>
							<li><a href="#tab3" data-toggle="tab">业绩统计</a></li>
						</ul>

						<div class="col-lg-12">
							<label> </label>
						</div>

						<div id="tab0">

							<div class="row">
								<div class="col-sm-2 pull-left">
									<button class="btn btn-primary btn-sm" id="exportExcel">导出报表</button>
								</div>
								<div class="col-sm-2 pull-right">
									<button class="btn btn-primary btn-sm" id="selectColumns">选择显示列</button>
								</div>
								<div class="col-sm-12">
									<lable>&nbsp;</lable>
								</div>
							</div>
							<div class="row">
								<div id="jqgrid-wrapper">
									<table id="jqgrid" class="table table-striped table-hover table-bordered"></table>
									<div id="jqgrid-pager"></div>
								</div>
							</div>

						</div>

						<div id="tab1">
							<div class="row">
								<div class="col-sm-2">
									<div class="input-group input-group-sm">
										<div class="input-group-addon">年度</div>
										<select name="annualIndustry" id="annualIndustry" class="form-control" onchange="AnnualIndustrySelectClick()">
											<option value="2015">2015</option>
											<option value="2016" selected="selected">2016</option>
											<option value="2017">2017</option>
											<option value="2018">2018</option>
											<option value="2019">2019</option>
											<option value="2020">2020</option>
										</select>
									</div>
								</div>

								<!-- <div class="col-sm-2">
				<button class="btn btn-primary btn-sm" id="exactQuery1">查询</button>
			    </div> -->
								<%-- <div class="col-sm-3 pull-right">
					<div id="fuzzySearchbox" class="input-group input-group-sm searchbox">
						<input type="search" id="searchText1-1" class="form-control" placeholder="请输入关键字...">
						<span class="input-group-btn">
							<button class="btn btn-default" type="button" id="searchButton1-1">搜索</button>
						</span>
					</div>
				</div> --%>
								<div class="col-sm-12">
									<lable>&nbsp;</lable>
								</div>
							</div>
							<div class="row">
								<div class="col-sm-10">
									<lable>
									<h4>
										<b>行业年度占屏率统计报表(%)</b>
									</h4>
									</lable>
								</div>
								<div class="col-sm-1">
									<button class="btn btn-primary btn-sm" id="exportExcel1-1">导出报表</button>
								</div>
							</div>

							<div id="jqgrid-wrapper_industry_annual_sort">
								<table id="jqgrid_industry_annual_sort" class="table table-striped table-hover table-bordered"></table>
								<div id="jqgrid-pager_industry_annual_sort"></div>
							</div>
							<div class="col-sm-12">
								<lable>&nbsp;</lable>
							</div>

						</div>

						<div id="tab4">
							<div class="row">
								<div class="col-sm-2">
									<div class="input-group input-group-sm">
										<div class="input-group-addon">年度</div>
										<select name="annualIndustry1" id="annualIndustry1" class="form-control" onchange="AnnualIndustrySelectClick()">
											<option value="2015">2015</option>
											<option value="2016" selected="selected">2016</option>
											<option value="2017">2017</option>
											<option value="2018">2018</option>
											<option value="2019">2019</option>
											<option value="2020">2020</option>
										</select>
									</div>
								</div>

								<div class="col-sm-12">
									<lable>&nbsp;</lable>
								</div>
							</div>

							<div class="row">
								<div class="col-sm-10">
									<lable>
									<h4>
										<b>行业年度金额统计报表</b>
									</h4>
									</lable>
								</div>
								<div class="col-sm-1">
									<button class="btn btn-primary btn-sm" id="exportExcel1-2">导出报表</button>
								</div>
							</div>

							<div id="jqgrid-wrapper_industry_annual_sort2">
								<table id="jqgrid_industry_annual_sort2" class="table table-striped table-hover table-bordered"></table>
								<div id="jqgrid-pager_industry_annual_sort2"></div>
							</div>

						</div>

						<div id="tab2">
							<div class="row">
								<div class="col-sm-2 pull-left">
									<button class="btn btn-primary btn-sm" id="exportExcel2">导出报表</button>
								</div>
								<div class="col-sm-2">
									<div class="input-group input-group-sm">
										<div class="input-group-addon">年度</div>
										<select name="annualLedSum" id="annualLedSum" class="form-control" onchange="AnnualLedSumSelect()">
											<option value="2015">2015</option>
											<option value="2016" selected="selected">2016</option>
											<option value="2017">2017</option>
											<option value="2018">2018</option>
											<option value="2019">2019</option>
											<option value="2020">2020</option>
										</select>
									</div>
								</div>
								<div class="col-sm-3 pull-right">
									<div id="fuzzySearchbox" class="input-group input-group-sm searchbox">
										<input type="search" id="searchText2" class="form-control" placeholder="请输入关键字..."> <span class="input-group-btn">
											<button class="btn btn-default" type="button" id="searchButton2">搜索</button>
										</span>
									</div>
								</div>
								<div class="col-sm-12">
									<lable>&nbsp;</lable>
								</div>
							</div>
							<div id="jqgrid-wrapper_EveryLed_sum">
								<table id="jqgrid_EveryLed_sum" class="table table-striped table-hover table-bordered"></table>
								<div id="jqgrid-pager_EveryLed_sum"></div>
							</div>
						</div>
						<div id="tab3">
							<div class="row">
								<div class="col-sm-2 pull-left">
									<button class="btn btn-primary btn-sm" id="exportExcel3">导出报表</button>
								</div>
								<div class="col-sm-2">
									<div class="input-group input-group-sm">
										<div class="input-group-addon">年度</div>
										<select name="annualYeji" id="annualYeji" class="form-control" onchange="AnnualPerformanceSelect()">
											<option value="2015">2015</option>
											<option value="2016" selected="selected">2016</option>
											<option value="2017">2017</option>
											<option value="2018">2018</option>
											<option value="2019">2019</option>
											<option value="2020">2020</option>
										</select>
									</div>
								</div>
								<!-- <div class="col-sm-2">
				<button class="btn btn-primary btn-sm" id="exactQuery3">查询</button>
			    </div> -->
								<div class="col-sm-3 pull-right">
									<div id="fuzzySearchbox" class="input-group input-group-sm searchbox">
										<input type="search" id="searchText3" class="form-control" placeholder="请输入关键字..."> <span class="input-group-btn">
											<button class="btn btn-default" type="button" id="searchButton3">搜索</button>
										</span>
									</div>
								</div>
								<div class="col-sm-12">
									<lable>&nbsp;</lable>
								</div>
							</div>
							<div id="jqgrid-wrapper_performance_evaluation">
								<table id="jqgrid_performance_evaluation" class="table table-striped table-hover table-bordered"></table>
								<div id="jqgrid-pager_performance_evaluation"></div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>


		<!--/.row-->
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
<script src="js/myJs/IndustryReport.js"></script>
<script src="js/myJs/EveryLedSum.js"></script>
<script src="js/myJs/PerformanceEvaluation.js"></script>
<script>
		var dateRangeSQL ="";
		
	<%-- 	var renkanshubianhao = new Array();
		<%
		// 这段可以用EL和JSTL等方法代替
		List<String> valueList = (List)request.getAttribute("renkanshubianhao");
		for (String currentValue : valueList) {%>
		renkanshubianhao.push("<%=currentValue%>");
		<% } %> --%>
		
		function formatShoukuan(cellvalue, options, rowObject){
			 if(cellvalue.length!=0){
			    var loadUrl="";
				for(var key=0;key<cellvalue.length;key++){
				    var url="<a href='shoukuanDetail?shoukuanId="+cellvalue[key].id+"'>"+cellvalue[key].name+"</a>";
					loadUrl=loadUrl+url+"<br>";
					}
			 }else{
			 loadUrl="";
			 }
			 return loadUrl;
		}

		$(document).ready(function() {
			/* for (var i = 0; i < renkanshubianhao.length; i++) {
				$("#renkanshubianhao").append("<option  value='"+renkanshubianhao[i]+"'>"+renkanshubianhao[i]+"</option>");
			} */
			
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
			
			

		    function e() {
		        $("#jqgrid").length > 0 && t.fluidGrid({
		            base: "#jqgrid-wrapper",
		            offset: 0
		        })
		    } 
		    var t = $("#jqgrid");
		    $("#jqgrid").length > 0 && (t.jqGrid({
		    	url:"dingdanDetailList.action",
		    	mtype:"GET",
		    	datatype:"json",
		    	colNames:['部门','业务员','代理公司','客户名称','类别','签订日期','直客/代理','合作类型','年','月份','开始时间','结束时间','天数','上画屏幕','频次','时长','总秒数','刊例总价','签订金额','折扣','应收款','实收款','外购成本','净收入','付款时间','约定收款时间','到款率','备注'],
		    	shrinkToFit:false,
		    	height:400,
		    	rowNum:<s:property value="@com.nfledmedia.sorm.cons.CommonConstant@DEFAULT_PAGE_SIZE"/>,
		    	rowList: [10, 20, 30],
        		pager: "jqgrid-pager",
        		multiselect:!1,
        		sortname:"yewuyuan.bumen.bmMingcheng",
        		sortorder: "asc",
        		viewrecords: !0,
        		colModel:[{
        			name:"yewuyuan.bumen.bmMingcheng",
        			index:"yewuyuan.bumen.bmMingcheng",
        			align:"center",
        	 		width:"100px"
        		},{
        			name:"yewuyuan.ywyXingming",
        			index:"yewuyuan.ywyXingming",
        			align:"center",
        			width:"80px" 
        				
        		},{
        			name:".renkanshu.guanggaodailigongsi",
        			index:".renkanshu.guanggaodailigongsi",
        			align:"center",
        			width:"100px" 
        				
        		},{
        			name:"kanhu",
        			index:"kanhu",
        			align:"center",
        			width:"130px" 
        				
        		},{
        			name:"renkanshu.industry.industryDesc",
        			index:"renkanshu.industry.industryDesc",
        			align:"center",
        			width:"90px"
        		},{
        			name:"renkanshu.qiandingriqi",
        			index:"renkanshu.qiandingriqi",
        			align:"center",
        			width:"90px"
        		},{
        			name:"agencyMode",
        			index:"agencyMode",
        			align:"center",
        			width:"80px"
        		},{
        			name:"leixing",
        			index:"leixing",
        			align:"center",
        			width:"90px"
        		},{
        			name:"year",
        			index:"year",
        			align:"center",
        			width:"60px"
        		},{
        			name:"month",
        			index:"month",
        			align:"center",
        			width:"50px"
        		},{
        			name:"kaishishijian",
        			index:"kaishishijian",
        			align:"center",
        			width:"90px"
        		},{
        			name:"jieshushijian",
        			index:"jieshushijian",
        			align:"center",
        			width:"90px" 
        		},{
        			name:"days",
        			index:"days",
        			align:"center",
        			width:"50px"
        		},{
        			name:"led.ledName",
        			index:"led.ledName",
        			align:"center",
        			width:"100px"
        		},{
        			name:"pinci",
        			index:"pinci",
        			align:"center",
        			width:"50px" 
        		},{
        			name:"shichang",
        			index: "shichang",
        			align:"center",
        			width:"50px"
        		},{
        			name:"seconds",
        			index:"seconds",
        			align:"center",
        			width:"70px"
        		},{
        			name:"renkanshu.kanlizongjia",
        			index:"renkanshu.kanlizongjia",
        			align:"center",
        			width:"70px"
        		},{
        			name:"qiandingjine",
        			index:"qiandingjine",
        			align:"center",
        			width:"70px"
        		},{
        			name:"renkanshu.zhekou",
        			index:"renkanshu.zhekou",
        			align:"center",
        			width:"70px"
        		},{
        			name:"yingfuzonge",
        			index:"yingfuzonge",
        			align:"center",
        			width:"70px"
        		},{
        			name:"paid",
        			index:"paid",
        			align:"center",
        			width:"70px"
        		},{
        			name:"purchasecost",
        			index:"purchasecost",
        			align:"center",
        			width:"70px"
        		},{
        			name:"netrevenues",
        			index:"netrevenues",
        			align:"center",
        			width:"70px"
        		},{
        			name:"shoukuanDates",
        			index:"shoukuanDates",
        			align:"center",
        			width:"90px",
        			formatter:formatShoukuan
        		},{
        			name:"orderpayDatesExpected",
        			index:"orderpayDatesExpected",
        			align:"center",
        			width:"90px"
        		},{
        			name:"paidRatio",
        			index:"paidRatio",
        			align:"center",
        			width:"70px"
        		},{
        			name:"renkanshu.renkanshubeizhu",
        			index:"renkanshu.renkanshubeizhu",
        			align:"center",
        			width:"200px"
        		}],
        		gridComplete: function(data){}
		    }), e(), $("#jqgrid").length > 0 && t.jqGrid("navGrid","#jqgrid-pager",{
		    	add:!1,
		    	edit:!1,
		    	del:!1,
		    	view:!1,
		    	search: !1,
        		refresh:0
		    },{},{},{},{
		    	multipleSearch: true,
		    	multipleGroup:true
		    })),
		    $(window).resize(e);

		    $("#selectColumns").click( function() {
			    t.setColumns([""]);
			    return false;
		    });
		

		    //模糊搜索
		    $("#searchText").keypress(function(event){
		    	if(event.keyCode == "13"){
		    		$("#searchButton").click();
		    	}
		    });
		    
		    $("#searchButton").click(function(){
				var searchFilter = $("#searchText").val();
			    	if(searchFilter.length !== 0){
				    	searchFilter = " where y.state!='D' and "+dateRangeSQL+" (y.yewuyuan.bumen.bmMingcheng like '%"+searchFilter+"%' or y.yewuyuan.ywyXingming like '%"+searchFilter+
				    	"%' or y.led.ledName like '%"+searchFilter+"%' or y.renkanshu.guanggaodailigongsi like '%"+searchFilter+"%' or y.renkanshu.industry.industryDesc like '%"+searchFilter+
				    	"%' or y.leixing like '%"+searchFilter+"%' or y.netrevenues like '%"+searchFilter+"%' or y.renkanshu.renkanshubeizhu like '%"+searchFilter+"%' or y.kanhu like '%"+searchFilter+"%' )";
			    		console.log(searchFilter);
			    		t[0].p.search = true;
			    		$.extend(t[0].p.postData,{searchString:searchFilter,searchField:"allfieldsearch",searchOper:"cn"});
			    	}
			    	t.trigger("reloadGrid",[{page:1,current:true}]);
		    });
		    
		    //精确查询
		    $("#exactQuery").click(function(){
		    	var led = $.trim($("#led").val()); 
		    	var region = $.trim($("#region").val());
		    	var industry = $.trim($("#industry").val()); 
		    	var salesman = $.trim($("#salesman").val()); 
		    	var department = $.trim($("#department").val()); 
		    	if(dateRangeSQL === ""&& led === ""&& region==""&& industry==""&& salesman=="" && department==""){
		    		t[0].p.search = false;
		    		$.extend(t[0].p.postData,{searchString:"",searchField:"",searchOper:""});
		    	}else{
		    		var searchFilter="  where y.state!='D' and (";
		    		if(led !== ""){
		    			searchFilter += "  y.led.ledName like '%"+led+"%' and ";
		    		}
		    		if(region !== ""){
		    			searchFilter += "  y.led.ledChengshi like '%"+region+"%' and ";
		    		}
		    		if(industry !== "" ){
		    			searchFilter += "  y.renkanshu.industry.industryclassify.name like '%"+industry+"%' and ";
		    		}
		    		if(salesman !== "" ){
		    			searchFilter += "  y.yewuyuan.ywyXingming like '%"+salesman+"%' and ";
		    		}
		    		if(department !== "" ){
		    			searchFilter += "  y.yewuyuan.bumen.bmMingcheng like '%"+department+"%' and ";
		    		}
		    		
		    		if(dateRangeSQL !== ""){
		    			searchFilter += " "+ dateRangeSQL;
		    		}else{
		    			searchFilter = searchFilter.substring(0,searchFilter.lastIndexOf('and '));
		    		}
		    		searchFilter += ")";
		    		console.log(searchFilter);
		    		t[0].p.search = true;
		    		$.extend(t[0].p.postData,{searchString:searchFilter,searchField:"allfieldsearch",searchOper:"cn"});
		    	}
		    	t.trigger("reloadGrid",[{page:1,current:true}]);
		    	return false;
		    });
		    $("#clearExactForm").click(function(){
	//			$("#searchButton").click();
				location.reload();
				return false;
			});

			//导出报表功能
			$("#exportExcel").click(function(){
				$("#jqgrid").jqGrid('excelExport',{url:'dingdanDetailListExport.action'})
			})

			 
		});
		    
		function loadingLed(){		 
			 $.ajax({
			  		type:"post",
			  		dataType:"json",
			  		url:"getAllLed.action",
			  		success:function(data){ 	
			  			var jsonData = data.info;
			  			for(var i=0, n = jsonData.length;i<n;i++){
			  				$("#led").append("<option  value='"+jsonData[i][1]+"'>"+jsonData[i][1]+"</option>");		
			  			}
			  		}
			  });	
		}
		
		function loadingRegion(){		 
			 $.ajax({
			  		type:"post",
			  		dataType:"json",
			  		url:"getAllRegion.action",
			  		success:function(data){ 	
			  			var jsonData = data.info;
			  			for(var i=0, n = jsonData.length;i<n;i++){
			  				$("#region").append("<option  value='"+jsonData[i][1]+"'>"+jsonData[i][1]+"</option>");		
			  			}
			  		}
			  });	
		}

		function loadingDepartment(){		 
			 $.ajax({
			  		type:"post",
			  		dataType:"json",
			  		url:"getAllDepartment.action",
			  		success:function(data){ 	
			  			var jsonData = data.info;
			  			for(var i=0, n = jsonData.length;i<n;i++){
			  				$("#department").append("<option  value='"+jsonData[i][1]+"'>"+jsonData[i][1]+"</option>");		
			  			}
			  		}
			  });	
		}
		
		function loadingClient(){		 
			 $.ajax({
			  		type:"post",
			  		dataType:"json",
			  		url:"getAllClient.action",
			  		success:function(data){ 	
			  			var jsonData = data.info;
			  			clients=data.info;
//			  			alert("clients[0]="+clients[0]);
			  			for(var i=0, n = jsonData.length;i<n;i++){		  				
			  				$("#client").append("<option  value='"+jsonData[i]+"'>"+jsonData[i]+"</option>");		
			  			}

			  		}
			  });	
		}
		
        //可自行输入的下拉选择框数据获取（数据首先存入跳转页面的action中）,不能和普通的下拉框一样获取数据
	    function loadingIndustry(){		 
	    	$("#industry").append("<s:iterator value="#request.industries">");
		    $("#industry").append("<option value='<s:property value="[0].top[1]"/>'><s:property value="[0].top[1]"/></option>");
		    $("#industry").append("</s:iterator>");
		}

	    function loadingSalesman(){		 
	    	$("#salesman").append("<s:iterator value="#request.salesmen">");
		    $("#salesman").append("<option value='<s:property value="[0].top[1]"/>'><s:property value="[0].top[1]"/></option>");
		    $("#salesman").append("</s:iterator>");
		}

		


		//$(function(){});函数是$(document).ready(function(){});函数的简写
		$(function(){
			$("#tabs").tabs();
			loadingLed();
			loadingRegion();
			loadingDepartment();
			loadingIndustry();
			loadingSalesman();

//			loadingClient();
		});
		
		var myChart = echarts.init(document.getElementById('mainpie'));
		var datas = eval("${industry4Report}");
		alert(datas);
		myChart.setOption({
	      		    title : {
	      		        text: '占屏率分行业分布',
	      		        subtext: '目前所有屏幕',
	      		        x:'center'
	      		    },
	      		    tooltip : {
	      		        trigger: 'item',
	      		        formatter: "{a} <br/>{b} : {c}个 ({d}%)"
	      		    },
	      		    legend: {
	      		        orient : 'vertical',
	      		        x : 'left',
	      		       data:  []
	      		    },
	      		    toolbox: {
	      		        show : true,
	      		        feature : {
	      		            
	      		            magicType : {
	      		                show: true, 
	      		                type: ['pie'],
	      		                option: {
	      		                    funnel: {
	      		                        x: '25%',
	      		                        width: '50%',
	      		                        funnelAlign: 'left',
	      		                        max: 1548
	      		                    }
	      		                }
	      		            },
	      		            restore : {show: true},
	      		            saveAsImage : {show: true}
	      		        }
	      		    },
	      		    calculable : true,
	      		    series : [
	      		        {
	      		            name:'占屏率',
	      		            type:'pie',
	      		            radius : '55%',
	      		            center: ['50%', '60%'],
	      		          data:[],//json 格式為{led:南都樓頂,zpl:11.56;...}
	      		        }
	      		    ]
	      		});
		
		 $(document).ready(function(){
				myChart.setOption({
	  				legend: {
	  	               data:  (function(){
                        var res = [];
                        var len = industriesJsp.length;
                        while (len--) {
                        res.push(industriesJsp[len]);
                        }
                        return res;
                        })()
	  		        },
	  		        series: [{
	  		          name: '占屏率',
	  		          data:(function(){
	  		        	 
                       var res = [];
                       var len = industriesJsp.length;
                       while (len--) {
                       res.push({
                       name: industriesJsp[len],
                       value: amountsJsp[len]
                       });
                       }
                       return res;
                       })()
	  		        }]
	  		    });	

			});

	</script>
</content>