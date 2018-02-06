
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


<!--Icons-->
<script src="js/lumino.glyphs.js"></script>


</head>

<body>
	<div class="main">
		<form class="form-horizontal" role="form" action="upOrderPage" id="upOrderForm">
			<div class="input-group input-group-sm">
				<input type="text" class="hidden" name="upOrder_id" id="upOrder_id">
			</div>
		</form>

		<!--/.row-->

		<div class="row">
			<div class="col-lg-12">
				<h3 class="page-header">占屏率统计</h3>
			</div>
			<div class="panel-body tabs">

						<ul class="nav nav-pills">
							<li ><a href="pingmustatistic.action">实时占屏率</a></li>
							<li><a href="pingmustatistic_fenpingtongji.action">分广告类型占屏率（日）</a></li>
							<li><a href="annualLedAmountReport.action">年度屏签订金额</a></li>
							<li class="active"><a href="avgScreenOccupancyRate.action">平均占屏率（月份）</a></li>
							<li><a href="avgOccupancyRateByScreen.action">自有屏平均占屏率</a></li>
						</ul>

					</div>
		</div>

		<div class="row">
			<div class="col-lg-12">
				<!-- <div class="panel panel-default"> -->
				<div class="panel-body">
					<div id="jqgrid-wrapper">

						<form class="form-horizontal" role="form" id="exactForm">
							<fieldset>
								<legend>查询条件</legend>
								<div class="col-sm-4">
									<div class="input-group input-group-sm">
										<div class="input-group-addon">时间段</div>
										<input type="text" id="daterange-default" class="form-control"> <span class="input-group-addon"><span
											class="glyphicon glyphicon-calendar"></span></span>
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
								
								<div class="col-sm-2 pull-right">
									<button class="btn btn-primary btn-sm" id="exactQuery">查询</button>
									<button class="btn btn-danger btn-sm" id="clearExactForm">清除</button>
								</div>
							</fieldset>
						</form>
						<ul class="nav nav-pills">
							<li class="active"><a href="#pilltab1" data-toggle="tab" onclick="changetab1Width()">平均占屏率图表</a></li>
							<li><a href="#pilltab2" data-toggle="tab" onclick="changetab2Width()">平均占屏率报表</a></li>
						</ul>

						<!-- <div class="tab-content"> -->
						<div class="tab-pane fade in active" id="pilltab1">

							<div class="col-lg-12">
								<div class="col-lg-12"></div>
								<!-- 为ECharts准备一个具备大小（宽高）的Dom -->
								<div id="draw-barchart@echart" style="height:500px;"></div>

							</div>

						</div>
						<div class="tab-pane fade" id="pilltab2">
							<div class="row" id="tab2toggle">
								<div class="col-lg-12">
									<div class="col-sm-2 pull-left">
										<button class="btn btn-primary btn-sm" id="exportExcel">导出报表</button>
									</div>
									<div class="col-sm-2 pull-right">
										<button class="btn btn-primary btn-sm" id="selectColumns">选择显示列</button>
									</div>
									<div class="col-sm-12">
										<lable>&nbsp;</lable>
									</div>
									<div class="col-lg-12">
										<table id="jqgrid" class="table table-striped table-hover table-bordered" style="border-collapse: collapse"></table>
										<div id="jqgrid-pager"></div>
									</div>

								</div>
							</div>

						</div>

						<!-- </div> -->
					</div>

				</div>
				<!-- </div> --><!-- panel -->
			</div>
		</div>
	</div>
	<script src="js/jqGrid4.4.3/jquery-1.7.2.min.js"></script>
	<script src="js/bootstrap.min.js"></script>
</body>
</html>
<content tag="scripts"> <script src="js/jquery.ba-bbq.min.js"></script> <script src="js/grid.history.js"></script> <script src="js/grid.locale-cn.js"></script>
<script>
		$.jgrid.useJSON = true;
	</script> <script src="js/jqGrid4.4.3/jquery.jqGrid.src.js"></script> <script src="js/jquery.jqGrid.fluid.js"></script> <script
	src="js/jqGrid4.4.3/plugins/grid.setcolumns.js"></script> <script src="js/jqGrid4.4.3/plugins/grid.jqueryui.js"></script> <script src="js/king-common.js"></script>
<script src="js/moment.js"></script> <script src="js/daterangepicker.js"></script> <!-- ECharts单文件引入 --> <script src="js/echarts.js"></script> <script>
 		var dateRangeSQL = "";
		var searchFilter = "";
<%--		var renkanshubianhao = new Array();
		<%
		// 这段可以用EL和JSTL等方法代替
		List<String> valueList = (List)request.getAttribute("renkanshubianhao");
		for (String currentValue : valueList) {%>
			renkanshubianhao.push("<%=currentValue%>");
		<% } %>
		function formatRenkanbianhao(cellvalue, options, rowObject){
			if(cellvalue.id == null){
				return "";
			}
			return cellvalue.name;
		} --%>
		function occuFormatter(cellvalue, options, rowObject) {
			return cellvalue + "%";
		} 
		
		
		var chartData;
		var records;
		$(document).ready(function() {
			//时间范围控件
			$("#daterange-default").daterangepicker({
				maxViewMode: 1,
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
			  dateRangeSQL = "";
			  console.log("dateRangeSQL" + dateRangeSQL);
			});
			$('#daterange-default').on('apply.daterangepicker', function(ev, picker) {
			  console.log("start:"+picker.startDate.format('YYYY-MM-DD')+"\nend:"+picker.endDate.format('YYYY-MM-DD'));
			  dateRangeSQL = "y.kaishishijian between '"+picker.startDate.format('YYYY-MM-DD')+"' and '"+picker.endDate.format('YYYY-MM-DD')+"' ";
			});


		    function e() {
		        $("#jqgrid").length > 0 && table.fluidGrid({
		            base: "#jqgrid-wrapper",
		            offset: 0
		        })
		    }
		    
		    
		    var table = $("#jqgrid");
		    $("#jqgrid").length > 0 && (table.jqGrid({
		    	url:"avgScreenOccuRateList.action",
		    	mtype:"POST",
		    	datatype:"json",
		    	colNames:['年份','自有屏','月份','占屏率'],
//		    	shrinkToFit: false,
		    	height:400,
		    	rowNum:30,
		    	rowList: [10,20, 30],
        		pager: "jqgrid-pager",
        		multiselect:!1,
        		editurl:"deleteOrder.action",
        		//sortname:"shichang",
        		sortorder: "asc",
        		viewrecords: !0,
        		colModel:[{
        			name: "year",
        			index: "year",
        			align: "center",
        	 		width: "100px"
        		},{
        			name: "led",
        			index: "led",
        			align: "center",
        			width: "130px"
        				
        		},{
        			name: "month",
        			index: "month",
        			align: "center",
        			width: "80px" 
        				
        		},{
        			name: "occupancy",
        			index: "occupancy",
        			align: "center",
        			width: "90px",
        			formatter: "currency",
        			formatoptions:{suffix: '%'}
        		}],
        		//记录
        		loadComplete: function (data) {
        			chartData = data.rows;
        			records = data.records;
        			//alert(chartData[0].cell[2]);
        			
					load(data);
             		console.log(data.rows);
             		console.log(data.rows[0].cell[2])//为所有数据行，具体取决于reader配置的root或者服务器返回的内容
         		},
        		
/*         		gridComplete: function(data){

        		} */
		    }), e(), $("#jqgrid").length > 0 && table.jqGrid("navGrid","#jqgrid-pager",{
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
	
		
         	
			//精确查询
		    $("#exactQuery").click(function(){
				var led = $.trim($("#led").val()); 
		    	if(dateRangeSQL === "" && led === ""){
		    		table[0].p.search = false;
		    		$.extend(table[0].p.postData,{dateRangeSQL: "", searchString: "", searchField: "",searchOper: ""});
		    	} else{
		    		searchFilter="  where y.state!='D' and (";
		    		if(led !== ""){
		    			searchFilter += "  y.led.ledName like '%" + led + "%' ";
		    		} else{
		    			searchFilter = searchFilter.substring(0, searchFilter.lastIndexOf('and '));
		    		}
		    		searchFilter += ")";
		    		console.log(searchFilter);
		    		table[0].p.search = true;
		    		$.extend(table[0].p.postData,{dateRangeSQL: dateRangeSQL, searchString: searchFilter, searchField: "allfieldsearch", searchOper: "cn"});
		    	}

		    	table.trigger("reloadGrid",[{page:1,current:true}]); 
				
		    	return false;
		    });
		    
		    //导出报表功能
			$("#exportExcel").click(function(){
	        	
				$("#jqgrid").jqGrid('excelExport',{url:'avgScreenOccuRateListExport.action'})
			})
			
			$("#selectColumns").click( function() {
			    table.setColumns([""]);
			    return false;
		    });
			
		});
		    
			
		//加载屏幕列表
		function loadingLed(){	 
			$.ajax({
				type:"post",
			  	dataType:"json",
			  	url:"getAllLed.action",
			  	success:function(data){
			  		var jsonData = data.info;
			  		for(var i = 0, n = jsonData.length; i < n; i++){
			  			$("#led").append("<option value='"+jsonData[i][1]+"'>"+jsonData[i][1]+"</option>");		
			  		}
			  	}
			});	
		}
			
		$(function(){
			loadingLed();
		});
		    
		$("#clearExactForm").click(function(){
			location.reload();
			return false;
		});
		

			
			
		function load(data) {
			var months = new Array();
			var occuRate = new Array();
			for(var i = 0; i < data.rows.length; i++) {
				months.push(data.rows[i].cell[2]);
			}
			for(var i = 0; i < data.rows.length; i++) {
				occuRate.push(data.rows[i].cell[3]);
			}
				// 路径配置
				require.config({
								paths: {
								echarts: 'js/echarts/build/dist'
								}
								});
		  
				// 使用
				require(['echarts',
						 'echarts/chart/line',
						 'echarts/chart/bar' // 使用柱状图就加载bar模块，按需加载
						],
				function(ec) {
				// 基于准备好的dom，初始化echarts图表
					var myChart = ec.init(document.getElementById('draw-barchart@echart'));
	
					option = {
						tooltip: {trigger: 'axis'
								},
					
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
						data: months
					}],
					grid: { // 控制图的大小，调整下面这些值就可以，
			             x: 60,
			             x2: 100,
			             y2: 120,// y2可以控制 X轴跟Zoom控件之间的间隔，避免以为倾斜后造成 label重叠到zoom上
			         },
					yAxis: [{
						name: '实时占屏率(商业广告)',
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
						name: '实时占屏率',
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
						data: occuRate
					}]
				};
	
				// 为echarts对象加载数据 
				myChart.setOption(option);
			}
		);
	};
	
	$(document).ready(function() {
		document.getElementById("tab2toggle").setAttribute("style", "display: none;");
	})
	
	function changetab2Width(){
		document.getElementById("draw-barchart@echart").setAttribute("style", "display: none;");
		document.getElementById("tab2toggle").setAttribute("style", "display: ;");
	}
	function changetab1Width(){
		document.getElementById("draw-barchart@echart").setAttribute("style", "display: ;");
		document.getElementById("tab2toggle").setAttribute("style", "display: none;");
	}
	</script> </content>