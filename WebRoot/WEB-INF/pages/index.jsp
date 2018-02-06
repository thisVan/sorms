<%@ page import="java.text.*"%>
<%@ page import="java.util.Date"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html >
<%! String url = "jdbc:mysql://localhost:3306/led_statistic?useUnicode=true&characterEncoding=GBK"; %>
<html>
<head>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="description" content="占屏率监控系统">

<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="icon" href="images/logo.png" type="image/x-icon" />
<link rel="shortcut icon" href="images/logo.png" type="image/x-icon" />

<link href="css/bootstrap.min.css" rel="stylesheet" media="screen">
<link href="css/styles.css" rel="stylesheet" media="screen">
<link href="css/laydate.css" rel="stylesheet">

<!--Icons-->
<script src="js/lumino.glyphs.js"></script>
<script src="js/bootstrap.min.js"></script>
<script src="js/king-common.js"></script>

<!--[if lt IE 9]>
	<script src="js/html5shiv.js"></script>
	<script src="js/respond.min.js"></script>
  <![endif]-->

<script type="text/javascript">

/* 			function load(data) {
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
						name: '实时占屏率',
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
	}; */
	

	$(document).ready(function() {
				$.ajax({
					url : "avgOccuRateListByScreen.action",
					data : {},
					type : "post",
					dataType : "json",
					success : function(data) {
						console.log(data);
						drawEcharts(data);
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

	function drawEcharts(data) {

		/* var chart2 = document.getElementById("bar-chart").getContext("2d");
		window.myBar = new Chart(chart2).Bar(barChartData, {
			responsive : true
		}); */

		// 路径配置
		require.config({
			paths : {
				echarts : 'js/echarts/build/dist'
			}
		});

		// 使用
		require([ 'echarts', 'echarts/chart/line', 'echarts/chart/bar' // 使用柱状图就加载bar模块，按需加载
		], function(ec) {
			// 基于准备好的dom，初始化echarts图表
			var myChart = ec.init(document
					.getElementById('draw-barchart@echart'));

			option = {
				tooltip : {
					trigger : 'axis'
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
					y2 : 120,// y2可以控制 X轴跟Zoom控件之间的间隔，避免以为倾斜后造成 label重叠到zoom上
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
					name : '实时占屏率',
					type : 'bar',
					itemStyle : {
						normal : {
							color : "rgba(48, 164, 255, 0.3)",
							barBorderColor : "rgba(48, 164, 255, 1)",
							barBorderWidth : 2,
							label : {
								show : true,
								formatter : '{c}%',
								textStyle : {
									color : '#800080'
								}
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
		});
	};
</script>

</head>

<body style="font-family: '微软雅黑';">

	<div class="col-sm-12 col-lg-12 main">
		
		
		<div class="row">		
			<div class="col-1g-12">
				<div class="panel-heading">实时占屏率</div>
					<!-- 为ECharts准备一个具备大小（宽高）的Dom -->
					<div id="draw-barchart@echart" style="height:500px;"></div>

					<!-- ECharts单文件引入 -->
					<script src="js/echarts.js"></script>

				</div>
		</div>
		<!--/.row-->


	</div>
	<!--/.main-->

</body>
</html>