
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

		<!--/.row-->

		<div class="row">
			<div class="col-lg-12">
				<h3 class="page-header">占屏率图表</h3>
			</div>

		<div class="row">
			<div class="col-lg-12">
				<!-- <div class="panel panel-default"> -->
				<div class="panel-body">
					<div id="jqgrid-wrapper">					
							<fieldset>
								<legend>查询条件</legend>
								<form class="form-horizontal" role="form" id="exactForm">
								<div class="col-sm-4">
									<div class="input-group input-group-sm">
									  <div class="input-group-addon">选择屏幕</div>
										<select name="ledId" class="form-control input-sm" id="ledid">
											<option value="all">--请选择屏幕--</option>
											<s:iterator value="#ledList">
												<option value='<s:property value="id"/>'><s:property value="name"/></option>
											</s:iterator>
										</select>
									</div>
								</div>
								<div class="col-sm-4">
									<div class="input-group input-group-sm">
										<div class="input-group-addon">时间段</div>
										<input type="text" id="daterange-default" class="form-control date-picker"> <span class="input-group-addon"><span
											class="glyphicon glyphicon-calendar"></span></span>
									</div>
								</div>
								</form>						
								<div class="col-sm-2 pull-right">
									<button class="btn btn-primary btn-sm" id="exactQuery">查询</button>
									<button class="btn btn-danger btn-sm" id="clearExactForm">清除</button>
								</div>
							</fieldset>
					
						<div class="col-lg-12">
							<div class="col-lg-12"></div>
							<!-- 为ECharts准备一个具备大小（宽高）的Dom -->
							<div id="draw-barchart@echart" style="height:500px;"></div>
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
<content tag="scripts">
<script src="js/jquery.ba-bbq.min.js"></script>
<%-- <script src="js/grid.history.js"></script> --%>
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
<!-- ECharts单文件引入 --> 
<%-- <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/echarts/3.8.5/echarts.js"></script> --%>
<script type="text/javascript" src="js/echarts3.8.4.min.js"></script> <script>
	var dateRangeSQL = "";
	var searchFilter = "";

	function occuFormatter(cellvalue, options, rowObject) {
		return cellvalue + "%";
	}

	$(document).ready(function() {
		//时间范围控件
		$("#daterange-default").daterangepicker({
			//maxViewMode: 1,
			format : 'YYYY/MM/DD',
			showDropdowns : !0,
			ranges : {
				"过去一年" : [ moment().subtract("year", 1).startOf("year"), moment().subtract("year", 1).endOf("year") ],
				"过去半年" : [ moment().subtract("month", 6).startOf("month"), moment().subtract("month", 1).endOf("month") ],
				"上月" : [ moment().subtract("month", 1).startOf("month"), moment().subtract("month", 1).endOf("month") ],
				"过去30天" : [ moment().subtract("days", 29), moment() ],
				"本月" : [ moment().startOf("month"), moment().endOf("month") ],
				//"本周": [moment().startOf("week"), moment().endOf("week")],
				"本周" : [ moment().startOf("week"), moment().endOf("week") ],
			},
			opens : 'right',
			separator : " 至 ",

			locale : {
				applyLabel : "确认",
				cancelLabel : "清除",
				fromLabel : "起始",
				toLabel : "截止",
				customRangeLabel : "自定义",
				daysOfWeek : [ "日", "一", "二", "三", "四", "五", "六" ],
				monthNames : [ "一月", "二月", "三月", "四月", "五月", "六月", "七月", "八月", "九月", "十月", "十一月", "十二月" ],
				firstDay : 1
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
			var ledId = $("#ledid").val();
			if (dateRangeSQL == "" || ledId == "") {
				alert("请选择屏幕和起始日期！");
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

		});

	});

	$("#clearExactForm").click(function() {
		location.reload();
		return false;
	});


	function drawEcharts(data, chartTitle) {
		// 基于准备好的dom，初始化echarts图表
		var myChart = echarts.init(document.getElementById('draw-barchart@echart'));

		var option = {
			title : {
				text : chartTitle,
				left: 'center',
				textStyle : {}
			},
			tooltip : {
				trigger : 'axis'
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
			series : [/*  {
				name : '总占屏率',
				type : 'bar',
				label : {
					position : 'top'
				},
				itemStyle : {
					normal : {
						label : {
							show : true,
							position : 'top',
							formatter : '{c}%',
							textStyle : {
								//color : '#ffffffff'
							}
						},
						areaStyle : {
							type : 'default'
						}
					}
				},
				data : data.totalOccus,
				markLine : {
					lineStyle : {
						normal : {
							type : 'dashed'
						}
					},
					data : [ [ {
						type : 'min'
					}, {
						type : 'max'
					} ] ]
				}
			}, */ {
				name : '商业',
				type : 'bar',
				//barWidth : 15,
				stack : '总占屏率',
				data : data.bussOccus
			}, {
				name : '赠播',
				type : 'bar',
				//barWidth : 15,
				stack : '总占屏率',
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



	$(document).ready(function() {
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
		})
	})

	function drawEcharts2(data) {
		var myChart2 = echarts.init(document.getElementById('draw-barchart@echart'));

		var option2 = {
			title : {
				text : '实时总占屏率',
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
				name : '实时占屏率',
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
		myChart2.setOption(option2);

	}
</script>
</content>