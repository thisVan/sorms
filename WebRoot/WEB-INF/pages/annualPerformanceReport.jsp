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
		<form class="form-horizontal" role="form" action="upOrderPage"
			id="upOrderForm">
			<div class="input-group input-group-sm">
				<input type="text" class="hidden" name="upOrder_id" id="upOrder_id">
			</div>
		</form>

		<!--/.row-->

		<div class="row">
			<div class="col-lg-12">
				<h3 class="page-header">年度业务员业绩统计</h3>
			</div>
		</div>
		<!--/.row-->
	
	<div class="row">
		<div class="col-lg-12">
		  <div class="row">
				<div class="col-sm-2 pull-left">
					<button class="btn btn-primary btn-sm" id="exportExcel3">导出报表</button>
				</div>
				<div class="col-sm-2">
					<div class="input-group input-group-sm">
						<div class="input-group-addon">年度</div>
						<select name="annualYeji" id="annualYeji" class="form-control"
							onchange="AnnualPerformanceSelect()">
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
						<div id="fuzzySearchbox"
							class="input-group input-group-sm searchbox">
							<input type="search" id="searchText3" class="form-control"
								placeholder="请输入关键字..."> <span class="input-group-btn">
								<button class="btn btn-default" type="button" id="searchButton3">搜索</button>
							</span>
						</div>
					</div>
					<div class="col-sm-1 pull-right">
						<button class="btn btn-primary btn-sm" id="changeReport" onclick="changeViewOfReport()">切换视图</button>
					</div>
					<div class="col-sm-12">
						<lable>&nbsp;</lable>
					</div>
				</div>
				
				
				<div id="report2" style="width:100%;" >
				<div id="mainpie" style="width: 100%;height:600px;overflow: visible"></div>
				</div>
				
				<div id="report1" >
				<div id="jqgrid-wrapper_performance_evaluation">
					<table id="jqgrid_performance_evaluation"
						class="table table-striped table-hover table-bordered"></table>
					<div id="jqgrid-pager_performance_evaluation"></div>
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
<content tag="scripts"> <script src="js/jquery.ba-bbq.min.js"></script>
<script src="js/grid.history.js"></script> <script
	src="js/grid.locale-cn.js"></script> <script>
		$.jgrid.useJSON = true;
	</script> <script src="js/jqGrid4.4.3/jquery.jqGrid.src.js"></script> <script
	src="js/jquery.jqGrid.fluid.js"></script> <script
	src="js/jqGrid4.4.3/plugins/grid.setcolumns.js"></script> <script
	src="js/jqGrid4.4.3/plugins/grid.jqueryui.js"></script> <script
	src="js/king-common.js"></script> <script src="js/moment.js"></script>
<script src="js/daterangepicker.js"></script>

<script>
		var myChart = echarts.init(document.getElementById('mainpie'));
		/* var myChart2 = echarts.init(document.getElementById('mainpie2')); */
	
		$(document).ready(function(){
			function e_performance_evaluation() {
				        $("#jqgrid_performance_evaluation").length > 0 && t_performance_evaluation.fluidGrid({
				            base: "#jqgrid-wrapper_performance_evaluation",
				            offset: 0
				        })
				    } 
				    var t_performance_evaluation= $("#jqgrid_performance_evaluation");
				    $("#jqgrid_performance_evaluation").length > 0 && (t_performance_evaluation.jqGrid({
				    	url:"ywyyejilist.action",
				    	mtype:"GET",
				    	datatype:"json",
				    	colNames:['部门','业务员','1月','2月','3月','4月','5月','6月','7月','8月','9月','10月','11月','12月','合计','全年目标','完成比例'],
				    	shrinkToFit:false,
				    	height:400,
				    	rowNum:10,
				    	rowList: [10, 20, 30],
		        		pager: "jqgrid-pager_performance_evaluation",
		        		multiselect:!1,
		        		sortname:"goalId",
		        		sortorder: "asc",
		        		viewrecords: !0,
		        		colModel:[{
		        			name:"goalYwy.bumen.bmMingcheng",
		        			index:"goalYwy.bumen.bmMingcheng",
		        			search:!1,
		        			align:"center",
		        	 		width:"100px", 
		        		},{
		        			name:"goalYwy.ywyXingming",
		        			index:"goalYwy.ywyXingming",
		        			align:"center",
		        	 		width:"80px"    		
		        		},{
		        			name:"Jan",
		        			index:"Jan",
		        			sortable:!1,
		        			align:"center",
		        	 		width:"70px"
		        		},{
		        			name:"Feb",
		        			index:"Feb",
		        			sortable:!1,
		        			align:"center",
		        			width:"70px" 
		        		},{
		        			name:"Mar",
		        			index:"Mar",
		        			sortable:!1,
		        			align:"center",
		        			width:"70px"
		        		},{
		        			name:"Apr",
		        			index:"Apr",
		        			sortable:!1,
		        			align:"center",
		        			width:"70px"
		        		},{
		        			name:"May",
		        			index:"May",
		        			sortable:!1,
		        			align:"center",
		        			width:"70px"       			
		        		},{
		        			name:"Jun",
		        			index:"Jun",
		        			sortable:!1,
		        			align:"center",
		        			width:"70px" 
		        		},{
		        			name:"Jul",
		        			sortable: !1,
		        			align:"center",
		        			width:"70px"
		        		},{
		        			name:"Aug",
		        			sortable: !1,
		        			align:"center",
		        			width:"70px"
		        		},{
		        			name:"Sep",
		        			sortable: !1,
		        			align:"center",
		        			width:"70px" 
		        		},{
		        			name:"Oct",
		        			sortable: !1,
		        			align:"center",
		        			width:"70px" 
		        		},{
		        			name:"Nov",
		        			sortable: !1,
		        			align:"center",
		        			width:"70px" 
		        		},{
		        			name:"Dec",
		        			sortable: !1,
		        			align:"center",
		        			width:"70px"
		        		},{
		        			name:"total",
		        			sortable: !1,
		        			align:"center",
		        			width:"80px"
		        		},{
		        			name:"goalMubiao",
		        			sortable: !1,
		        			align:"center",
		        			width:"100px"
		        		},{
		        			name:"ratio",
		        			sortable: !1,
		        			align:"center",
		        			width:"100px"
		        		}],
		        		gridComplete: function(data){}
				    }), e_performance_evaluation(), $("#jqgrid_performance_evaluation").length > 0 && t_performance_evaluation.jqGrid("navGrid","#jqgrid-pager_performance_evaluation",{
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
				    $(window).resize(e_performance_evaluation);	
				    
				  //模糊搜索
				    $("#searchText3").keypress(function(event){
				    	if(event.keyCode == "13"){
				    		$("#searchButton3").click();
				    	}
				    });
				    
				    $("#searchButton3").click(function(){
						var searchFilter = $("#searchText3").val();
						var annualYeji=$.trim($("#annualYeji").val());
		//				alert(annualYeji);
				    	if(searchFilter.length !== 0){
				    		t_performance_evaluation[0].p.search = false; 
				    		$.extend(t_performance_evaluation[0].p.postData,{searchString:"",searchField:"",searchOper:""});
					    	searchFilter = " and ( y.goalYwy.bumen.bmMingcheng like '%"+searchFilter+"%' or y.goalYwy.ywyXingming like '%"+searchFilter+"%' )";
				    		console.log(searchFilter);
				    		t_performance_evaluation[0].p.search = true;
				    		$.extend(t_performance_evaluation[0].p.postData,{annualYeji:annualYeji,searchString:searchFilter,searchField:"allfieldsearch",searchOper:"cn"});
				    	}
				    	t_performance_evaluation.trigger("reloadGrid",[{page:1,current:true}]);
				    });
				
				  //导出报表功能
					$("#exportExcel3").click(function(){
						$("#jqgrid_performance_evaluation").jqGrid('excelExport',{url:'ywyyejilistExport.action'})
					});
		});
		
		function AnnualPerformanceSelect(){
			var t_performance_evaluation= $("#jqgrid_performance_evaluation");
			var annualYeji=$.trim($("#annualYeji").val());
		//	alert(annualYeji);
			redrawReport(annualYeji);
			t_performance_evaluation[0].p.search = true;
			$.extend(t_performance_evaluation[0].p.postData,{annualYeji:annualYeji,searchString:"",searchField:"allfieldsearch",searchOper:"cn"});
			t_performance_evaluation.trigger("reloadGrid",[{page:1,current:true}]);
			return false;
		}
		$(function(){
			AnnualPerformanceSelect();
			changeViewOfReport();
			
		});
		

			function redrawReport(obj) {
				$.ajax({
			         type : "post",
			         url : "employeePerformanceReport.action",    //请求发送到TestServlet处
			         data : {annualYeji:obj,_search:true},
			         dataType : "json",        //返回数据形式为json
			         success : function(result) {
			             //请求成功时执行该函数内容，result即为服务器返回的json对象
			        	myChart.setOption({
							tooltip: {trigger: 'axis'},
							toolbox: {show: true,
							  feature: {
								magicType: {
								show: true,
								type: ['line', 'bar']
								},
							restore: {
								show: true
							},
							saveAsImage: {
								show: true
							}
						}
					},
					calculable: true,
					xAxis: [{
						type: 'category',
						margin: 80,
						interval: 0,
						boundaryGap: true,
						splitLine:{show: false},
						axisLabel:{
							rotate: 45,
				            textStyle:{
				            	fontFamily:'微软雅黑'
				            }
				          },
						data: result.employeenames
					}],
					grid: { // 控制图的大小，调整下面这些值就可以，
			             x: 60,
			             x2: 100,
			             y2: 120,// y2可以控制 X轴跟Zoom控件之间的间隔，避免以为倾斜后造成 label重叠到zoom上
			         },
					yAxis: [{
						name: '全年业绩完成率',
			            type : 'value',
			            position: 'left',
			            //min: 0,
			            //max: 720,
			            //splitNumber: 5,
			            boundaryGap: [0,0.2],
			            axisLabel : {
			                show:true,
			                interval: 'auto',    // {number}
			                margin: 18,
			                formatter: '{value}%'
			                // Template formatter!
			             }
						}],
					series: [{
						name: '业绩完成率',
						type: 'bar',
						itemStyle: {
							normal: {
								color: "rgba(48, 164, 255, 0.3)",
								barBorderColor: "rgba(48, 164, 255, 1)",
								barBorderWidth: 2,
								label: {
			                         show: true,
			                         formatter: '{c}%',
			                         textStyle: {
			                             color: '#800080'
			                         }
			                     },
								areaStyle: {
									type: 'default'
								}
							}
						},
						data: result.performances
					}]
				});
			         
			        },
			         error : function(errorMsg) {
			             //请求失败时执行该函数
			         alert("图表请求数据失败!");
			         myChart.hideLoading();
			         }
			    })
			}
			
			
			function changeViewOfReport() {
				if($("#report1").is(":hidden")){
				       $("#report1").show();    //如果元素为隐藏,则将它显现
				       $("#report2").hide();     //如果元素为显现,则将其隐藏 
				}else{
					   $("#report2").show();    //如果元素为隐藏,则将它显现
				       $("#report1").hide();     //如果元素为显现,则将其隐藏
				}
				
			} 
			
			
			//$(function(){});函数是$(document).ready(function(){});函数的简写
/* 			$(function(){
				$("#tabs").tabs();
				AnnualIndustrySelectClick();
				changeViewOfReport();
				changeViewOfReport1();

			});
			 */
			

	</script> 
	</content>