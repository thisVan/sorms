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
<link href="css/daterangepicker2.1.30.css" rel="stylesheet">
</head>
<body>
	<div class="main">
		<div class="row">
			<div class="col-lg-12">
				<h3 class="page-header">占屏率图表</h3>
			</div>
		</div>

		<div class="row">
			<div class="col-lg-12">
				<legend>查询条件</legend>
			</div>
			<form class="form-horizontal" role="form" id="exactForm">
				<div class="col-sm-4">
					<div class="input-group input-group-sm">
						<div class="input-group-addon">选择屏幕</div>
						<select name="ledId" class="form-control input-sm" id="ledid">
							<option value="">--请选择屏幕--</option>
							<s:iterator value="#ledList">
								<option value='<s:property value="id"/>'><s:property value="name"/></option>
							</s:iterator>
						</select>
					</div>
				</div>
				<div class="col-sm-4">
					<div class="input-group input-group-sm">
						<div class="input-group-addon">时间段</div>
						<input type="text" id="daterange-default" class="form-control date-picker">
							<span class="input-group-addon">
							<span class="glyphicon glyphicon-calendar"></span></span>
					</div>
				</div>
				<div class="col-sm-2 pull-right">
					<a class="btn btn-primary btn-sm" id="exactQuery">查询</a>
					<a class="btn btn-danger btn-sm" id="clearExactForm">清除</a>
				</div>
			</form>
			<div class="col-lg-12">
				<label></label>
			</div>
		</div>

		<div class="row">
			<div class="col-lg-12">
				<div class="tabbable">
					<ul class="nav nav-tabs">
						<li class="active"><a href="#realTimeOccupyReport" data-toggle="tab">日占屏率</a></li>
						<li class=""><a href="#avgOccupyReport" data-toggle="tab">月平均占屏率</a></li>
					</ul>
					<div class="tab-content">
						<div class="tab-pane active" id="realTimeOccupyReport">
							<!-- 为ECharts准备一个具备大小（宽高）的Dom -->
							<div id="draw-barchart" style="height:500px;"></div>
						</div>
						<div class="tab-pane" id="avgOccupyReport">
							<!-- 为ECharts准备一个具备大小（宽高）的Dom -->
							<div id="draw-barchart2" style="height:500px;"></div>
						</div>
					</div>
				</div>
			</div>
		</div>
		
	</div>
</body>
</html>
<content tag="scripts">
<!--Icons-->
<script src="js/lumino.glyphs.js"></script>

<script src="js/jquery-1.11.1.min.js"></script>
<script src="js/bootstrap.min.js"></script>
<%-- <script src="js/jqGrid4.4.3/jquery-1.7.2.min.js"></script>
<script src="js/jqGrid4.4.3/jquery.jqGrid.src.js"></script>
<script src="js/jquery.jqGrid.fluid.js"></script>
<script src="js/jqGrid4.4.3/plugins/grid.setcolumns.js"></script>
<script src="js/jqGrid4.4.3/plugins/grid.jqueryui.js"></script> --%>
<script src="js/king-common.js"></script> 
<script src="js/moment2.13.0.js"></script>
<script src="js/daterangepicker2.1.30.js"></script>
<!-- ECharts单文件引入 --> 
<%-- <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/echarts/3.8.5/echarts.js"></script> --%>
<script type="text/javascript" src="js/echarts3.8.4.min.js"></script>
<script>
	var dateRangeSQL = "";
	var searchFilter = "";

	//指定屏点日占屏率
	function drawEcharts(data, chartTitle) {
		// 基于准备好的dom，初始化echarts图表
		var myChart = echarts.init(document.getElementById('draw-barchart'));

		var option = {
			title : {
				text : chartTitle,
				left: 'center',
				textStyle : {}
			},
			tooltip : {
				trigger : 'axis',
				//formatter: "{c}%" // 这里是鼠标移上去的显示数据
				formatter : function(params){
					var relVal = params[0].name + "<br/>";
					relVal += params[0].seriesName + ' : ' + params[0].value + "%" + "<br/>";
					relVal += params[1].seriesName + ' : ' + params[1].value + "%" + "<br/>";
					relVal += params[2].seriesName + ' : ' + params[2].value + "%";
					return relVal;
				}
			},
			legend : {
				top : 'bottom',
				data : ['商业', '赠播', '公益']
			},
			toolbox : {
				show : true,
				feature : {
					magicType : {
						show : true,
						type : [ 'line', 'bar' ]
					},
					restore : {
						show : true
					},
					saveAsImage : {
						show : true
					}
				}
			},
			calculable : true,
			xAxis : [ {
				type : 'category',
				margin : 0,
				interval : 0,
				boundaryGap : true,
				splitLine : {
					show : false
				},
				axisLabel : {
					//rotate : 45,
					textStyle : {
						fontFamily : '微软雅黑'
					}
				},
				data : data.dateLegend
			} ],
			grid : { // 控制图的大小，调整下面这些值就可以，
				left : '3%',
				right : '4%',
				bottom : '3%',
				containLabel : true,
				x : 60,
				x2 : 100,
				// y2: 120,// y2可以控制 X轴跟Zoom控件之间的间隔，避免以为倾斜后造成 label重叠到zoom上
			},
			yAxis : [ {
				name : '占屏率',
				type : 'value',
				position : 'left',
				//min: 0,
				//max: 720,
				//splitNumber: 5,
				boundaryGap : [ 0, 0.2 ],
				axisLabel : {
					show : true,
					interval : 'auto', // {number}
					margin : 12,
					formatter : '{value}%'
				// Template formatter!
				}
			} ],
			series : [{
				name : '商业',
				type : 'bar',
				//barWidth : 15,
				stack : '总占屏率',
				label : {
					normal : {
						show : false
					}
				},
				data : data.bussOccus
			}, {
				name : '赠播',
				type : 'bar',
				//barWidth : 15,
				stack : '总占屏率',
				label : {
					normal : {
						show : false
					}
				},
				data : data.presOccus
			}, {
				name : '公益',
				type : 'bar',
				//barWidth : 15,
				stack : '总占屏率',
				label : {
					normal : {
						show : true,
						position : 'top',
						textStyle : {
							color : 'red'
						},
 						formatter : function(params) {
							return data.totalOccus[params.dataIndex] + "%";
							//return parseFloat(params.value) + parseFloat(data.bussOccus[params.dataIndex]) + parseFloat(data.presOccus[params.dataIndex]) ;
						}
					}
				},
				data : data.commOccus
			} ],
			
		};
		// 为echarts对象加载数据 
		myChart.setOption(option);
	}

	//各屏点实时占屏率
	function drawEcharts2(data) {
		var myChart = echarts.init(document.getElementById('draw-barchart'));

		var option = {
			title : {
				text : '实时总占屏率',
				left: 'center'
			},
			tooltip : {
				trigger : 'axis'
			},
			legend : {
				data : [ '总占屏率' ]
			},
			toolbox : {
				show : true,
				feature : {
					magicType : {
						show : true,
						type : [ 'line', 'bar' ]
					},
					restore : {
						show : true
					},
					saveAsImage : {
						show : true
					}
				}
			},
			calculable : true,
			xAxis : [ {
				type : 'category',
				margin : 80,
				interval : 0,
				boundaryGap : true,
				splitLine : {
					show : false
				},
				axisLabel : {
					rotate : 45,
					textStyle : {
						fontFamily : '微软雅黑'
					}
				},
				data : data.ledOccuRates.ledName
			} ],
			grid : { // 控制图的大小，调整下面这些值就可以，
				x : 60,
				x2 : 100,
				y2 : 120, // y2可以控制 X轴跟Zoom控件之间的间隔，避免以为倾斜后造成 label重叠到zoom上
			},
			yAxis : [ {
				name : '占屏率',
				type : 'value',
				position : 'left',
				//min: 0,
				//max: 720,
				//splitNumber: 5,
				boundaryGap : [ 0, 0.2 ],
				axisLabel : {
					show : true,
					interval : 'auto', // {number}
					margin : 18,
					formatter : '{value}%'
				// Template formatter!
				}
			} ],
			series : [ {
				name : '实时总占屏率',
				type : 'bar',
				itemStyle : {
					normal : {
						label : {
							show : true,
							position : 'top',
							formatter : '{c}%',
						},
						areaStyle : {
							type : 'default'
						}
					}
				},
				data : data.ledOccuRates.ledOccuRate
			} ]
		};
		// 为echarts对象加载数据 
		myChart.setOption(option);
	}
	
	//所有屏点月平均占屏率
	function drawEcharts3(data) {
		var myChart = echarts.init(document.getElementById('draw-barchart2'));

		var option = {
			title : {
				text : data.title,
				left: 'center'
			},
			tooltip : {
				trigger : 'axis'
			},
			legend : {
				data : [ '平均占屏率' ]
			},
			toolbox : {
				show : true,
				feature : {
					magicType : {
						show : true,
						type : [ 'line', 'bar' ]
					},
					restore : {
						show : true
					},
					saveAsImage : {
						show : true
					}
				}
			},
			calculable : true,
			xAxis : [ {
				type : 'category',
				margin : 80,
				interval : 0,
				boundaryGap : true,
				splitLine : {
					show : false
				},
				axisLabel : {
					rotate : 0,
					textStyle : {
						fontFamily : '微软雅黑'
					}
				},
				data : data.months
			} ],
			grid : { // 控制图的大小，调整下面这些值就可以，
				x : 60,
				x2 : 100,
				y2 : 120, // y2可以控制 X轴跟Zoom控件之间的间隔，避免以为倾斜后造成 label重叠到zoom上
			},
			yAxis : [ {
				name : '占屏率',
				type : 'value',
				position : 'left',
				//min: 0,
				//max: 720,
				//splitNumber: 5,
				boundaryGap : [ 0, 0.2 ],
				axisLabel : {
					show : true,
					interval : 'auto', // {number}
					margin : 18,
					formatter : '{value}%'
				// Template formatter!
				}
			} ],
			series : [ {
				name : '实时总占屏率',
				type : 'bar',
				itemStyle : {
					normal : {
						label : {
							show : true,
							position : 'top',
							formatter : '{c}%',
						},
						areaStyle : {
							type : 'default'
						}
					}
				},
				data : data.occupys
			} ]
		};
		// 为echarts对象加载数据 
		myChart.setOption(option);
	}
	
	//指定屏月平均占屏率
	function drawEcharts4(data) {
		var myChart = echarts.init(document.getElementById('draw-barchart2'));

		var option = {
			title : {
				text : data.title,
				left: 'center'
			},
			tooltip : {
				trigger : 'axis',
				
	        formatter: function (params) {
	        	//提示框
                var res = "月份: " + params[1].name + "<br/>";
                res += "日均广告时长: " + params[1].data + "<br/>";
                res += "平均占屏率: " + params[0].data + "%";
                return res;
	        }
			},
			legend : {
				show : false,
				data : [ '平均占屏率' ]
			},
			toolbox : {
				show : true,
				feature : {
					magicType : {
						show : true,
						type : [ 'line', 'bar' ]
					},
					restore : {
						show : true
					},
					saveAsImage : {
						show : true
					}
				}
			},
			calculable : true,
			xAxis : [ {
				type : 'category',
				margin : 80,
				interval : 0,
				boundaryGap : true,
				splitLine : {
					show : false
				},
				axisLabel : {
					rotate : 0,
					textStyle : {
						fontFamily : '微软雅黑'
					}
				},
				data : data.months
			} ],
			grid : { // 控制图的大小，调整下面这些值就可以，
				x : 60,
				x2 : 100,
				y2 : 120, // y2可以控制 X轴跟Zoom控件之间的间隔，避免以为倾斜后造成 label重叠到zoom上
			},
			yAxis : [ {
				name : '占屏率',
				type : 'value',
				position : 'left',
				//min: 0,
				//max: 720,
				//splitNumber: 5,
				boundaryGap : [ 0, 0.2 ],
				axisLabel : {
					show : true,
					interval : 'auto', // {number}
					margin : 18,
					formatter : '{value}%'
				}
			} ],
			series : [ {
				name : '平均占屏率',
				type : 'bar',
				itemStyle : {
					normal : {
						label : {
							show : true,
							position : 'top',
							formatter : '{c}%',
						},
						areaStyle : {
							type : 'default'
						}
					}
				},
				data : data.occupys
			},
			{
				name : '广告时长',
				type : "line",
				data : data.durations
			} ]
		};
		// 为echarts对象加载数据 
		myChart.setOption(option);
	}
	
	function occuFormatter(cellvalue, options, rowObject) {
		return cellvalue + "%";
	}
	
	function initEcharts(){
		$.ajax({
			url : "avgOccuRateListByScreen.action",
			data : {},
			type : "post",
			dataType : "json",
			success : function(data) {
				drawEcharts2(data);
			},
			error : function(XMLHttpRequest, textStatus, errorThrown) {
				alert('操作失败\nXMLHttpRequest.readyState['
					+ XMLHttpRequest.readyState
					+ ']\nXMLHttpRequest.status['
					+ XMLHttpRequest.status + ']\ntextStatus['
					+ textStatus + ']');
			}
		});
	}
	
	function initEcharts2(){
		$.ajax({
			url : "avgOccuByMonthsReport.action",
			data : {"led":"","year":new Date().getFullYear()},
			type : "post",
			dataType : "json",
			success : function(data) {
				drawEcharts3(data);
			},
			error : function(XMLHttpRequest, textStatus, errorThrown) {
				alert('操作失败\nXMLHttpRequest.readyState['
					+ XMLHttpRequest.readyState
					+ ']\nXMLHttpRequest.status['
					+ XMLHttpRequest.status + ']\ntextStatus['
					+ textStatus + ']');
			}
		});
	}

	$(document).ready(function() {
		initEcharts(); 
		
		//时间范围控件
			$("#daterange-default").daterangepicker({
				showDropdowns: true,
    			autoUpdateInput: true,
    			autoApply: false,
				ranges: {
					"过去30天": [moment().subtract(29, "days"), moment()],
					"上月":[moment().subtract(1, "month").startOf("month"), moment().subtract(1, "month").endOf("month")],
					"本月": [moment().startOf("month"), moment().endOf("month")],
/* 					"下周":[moment().add(1, "week").startOf("week"), moment().add(1, "week").endOf("week")],
					"下月":[moment().add(1, "month").startOf("month"), moment().add(1, "month").endOf("month")] */
					"未来7天":[moment().add(1, "days"), moment().add(7, "days")],
					"未来30天":[moment().add(1, "days"), moment().add(30, "days")]
	            },
	            locale: {
	           		format: 'YYYY-MM-DD',
                    separator: ' 至 ',
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
		});
		$('#daterange-default').on('apply.daterangepicker', function(ev, picker) {
			//console.log("start:" + picker.startDate.format('YYYY-MM-DD') + "\nend:" + picker.endDate.format('YYYY-MM-DD'));
			//此处修改了dateRangeSQL定义的语法，下面注释的部分是原来的定义
			dateRangeSQL = picker.startDate.format('YYYY-MM-DD') + " " + picker.endDate.format('YYYY-MM-DD');
		/* dateRangeSQL = "y.kaishishijian between '"+picker.startDate.format('YYYY-MM-DD')+"' and '"+picker.endDate.format('YYYY-MM-DD')+"' "; */
		});

		//精确查询
		$("#exactQuery").click(function() {
			var isAvgOccupyTab = $("#avgOccupyReport").hasClass("active");
			if (isAvgOccupyTab){
				if (dateRangeSQL == "") {
					alert("请选择报告年份！");
					return;
				}
				var led = $("#ledid").find("option:selected").text();
				var ledid = $("#ledid").val();
				var year = dateRangeSQL.substr(0, 4)
				if (ledid == "") {
					$.ajax({
						type : "post",
						dataType : "json",
						url : "avgOccuByMonthsReport.action",
						data : {
							"year" : year,
							"led" : led
						},
						success : function(data) {
							drawEcharts3(data);
						},
						error : function(data) {
							alert("服务器未能返回结果！")
						}
					});
				} else {
					$.ajax({
						type : "post",
						dataType : "json",
						url : "avgOccuByMonthsReport.action",
						data : {
							"year" : year,
							"led" : led
						},
						success : function(data) {
							drawEcharts4(data);
						},
						error : function(data) {
							alert("服务器未能返回结果！")
						}
					});
				}
			} else {
				var ledId = $("#ledid").val();
				if (dateRangeSQL == "" || ledId == "") {
					if (ledId == "") {
						alert("请选择屏幕！");
					} else {
						alert("请选择起止日期！");
					}
					return;
				} else {
					var dateRangeStr = dateRangeSQL.replace(" ", "至");
					var chartTittle = $("#ledid").find("option:selected").text() + dateRangeStr + "占屏率";
					$.ajax({
						type : "post",
						dataType : "json",
						url : "screenOccuRateListByDate.action",
						data : {
							"dateRangeSQL" : dateRangeSQL,
							"ledId" : ledId
						},
						success : function(data) {
							drawEcharts(data.ledOccuRates,chartTittle);
						},
						error : function(data) {
							alert("服务器未能返回结果！")
						}
					});
				}
			
			}


		});
		
		$("#clearExactForm").click(function() {
			location.reload();
			return false;
		});
		
		jQuery.noConflict();
		
 		/* $("a[data-toggle='tabs']").on("shown.bs.tab", function(e) {
			console.log(e);
            initEcharts();
            initEcharts2();
        }); */
   
 	    $('[href=#avgOccupyReport]').on('shown.bs.tab', function (e) {
		    initEcharts2();
		});
		
		$('[href=#realTimeOccupyReport]').on('shown.bs.tab', function (e) {
		    initEcharts();
		});
       
	});
</script>
</content>