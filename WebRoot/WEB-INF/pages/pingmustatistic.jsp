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

<!--Icons-->
<script src="js/lumino.glyphs.js"></script>

<!--[if lt IE 9]>
	<script src="js/html5shiv.js"></script>
	<script src="js/respond.min.js"></script>
		<![endif]-->

<script type="text/javascript">
	
	<%
	 //取得当前日期所在周的第一天 
	 Calendar c = new GregorianCalendar(); 
	 c.setFirstDayOfWeek(Calendar.MONDAY); 
	 c.setTime(new Date()); 
	 c.set(Calendar.DAY_OF_WEEK, c.getFirstDayOfWeek()); // Monday 
	 Date weedbeforefir = new Date(c.getTime().getTime() - 7*24*3600*1000);
	 
	 
	 //取得当前日期所在周的最后一天 
	 c.set(Calendar.DAY_OF_WEEK, c.getFirstDayOfWeek() + 6); // Sunday 
	 Date weekbeforelas = new Date(c.getTime().getTime() - 7*24*3600*1000);
	 
	 SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
     
	 String strtst = format.format(weedbeforefir);
	 
	 Date datefmt = null;
		try {
			datefmt = format.parse(strtst);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} 
	%>
			//初始化数据库连接
			<%Class.forName("com.mysql.jdbc.Driver").newInstance();
				Connection conn = DriverManager.getConnection(url, "root", "123456789");
				Statement stmt = conn.createStatement();
				ResultSet rs = stmt.executeQuery("select * from industry");
				int count = 0;%>
			
			//取出屏幕列表，填充屏幕select
			var arrayledinfo = new Array();
			var arrayledshort = new Array();
			var arrayledidprice = new Array();
			<%String queryled = "select led_id, led_name, led_weizhi, led_bofangshichang, led_bofangkaishishijian, led_bofangjieshushijian, led_changdu, led_kuangdu, led_mianji, led_fenbianlv, led_kanliprice from led where led.state = 'A'";
				rs = stmt.executeQuery(queryled);
				count = 0;
				String led_id = "";
				String led_name = "";
				String led_weizhi = "";
				String led_bofangshichang = "";
				String led_bofangkaishishijian = "";
				String led_bofangjieshushijian = "";
				String led_changdu = "";
				String led_kuangdu = "";
				String led_mianji = "";
				String led_fenbianlv = "";
				String led_kanliprice = "";
				while (rs.next()) {
					led_id = rs.getString("led_id");
					led_name = rs.getString("led_name");
					led_weizhi = rs.getString("led_weizhi");
					led_bofangshichang = rs.getString("led_bofangshichang");
					led_bofangkaishishijian = rs
							.getString("led_bofangkaishishijian");
					led_bofangjieshushijian = rs
							.getString("led_bofangjieshushijian");
					led_changdu = rs.getString("led_changdu");
					led_kuangdu = rs.getString("led_kuangdu");
					led_mianji = rs.getString("led_mianji");
					led_fenbianlv = rs.getString("led_fenbianlv");
					led_kanliprice = rs.getString("led_kanliprice");%>
							arrayledshort[<%=count%>]= new Array("<%=led_id%>","<%=led_name%>");
							arrayledidprice[<%=count%>]= new Array("<%=led_id%>","<%=led_kanliprice%>");
							arrayledinfo[<%=count%>] = new Array("<%=led_id%>","<%=led_name%>","<%=led_weizhi%>","<%=led_bofangshichang%>","<%=led_bofangkaishishijian%>","<%=led_bofangjieshushijian%>","<%=led_changdu%>","<%=led_kuangdu%>","<%=led_mianji%>","<%=led_fenbianlv%>","<%=led_kanliprice%>");
					<%count++;
				}%>
					
				
					
					//取出业务数据
					var arrayyewu = new Array();
					var arrayyewufull = new Array();
	
				<%String queryyewu = "select kanhu, leixing, ywy_id, led, shichang, pinci, shichang * pinci as bofangshijian, kaishishijian, jieshushijian, kanlijiaxiaoji from yewu";
				rs = stmt.executeQuery(queryyewu);
				count = 0;
				String kanhu = "";
				String leixing = "";
				String yw_ywyid = "";
				String led = "";
				String shichang = "";
				String pinci = "";
				String bofangshijian = "";
				String kaishishijian = "";
				String jieshushijian = "";
				String kanlijiaxiaoji = "";
				while (rs.next()) {
					kanhu = rs.getString("kanhu");
					leixing = rs.getString("leixing");
					yw_ywyid = rs.getString("ywy_id");
					led = rs.getString("led");
					shichang = rs.getString("shichang");
					pinci = rs.getString("pinci");
					bofangshijian = rs.getString("bofangshijian");
					kaishishijian = rs.getString("kaishishijian");
					jieshushijian = rs.getString("jieshushijian");
					kanlijiaxiaoji = rs.getString("kanlijiaxiaoji");%>
								arrayyewu[<%=count%>] = new Array("<%=leixing%>","<%=kaishishijian%>");
								arrayyewufull[<%=count%>] = new Array("<%=kanhu%>","<%=leixing%>","<%=yw_ywyid%>","<%=led%>","<%=shichang%>","<%=pinci%>","<%=bofangshijian%>","<%=kaishishijian%>","<%=jieshushijian%>","<%=kanlijiaxiaoji%>");
	<%count++; }%>
		
				//取出时间段内的业务数据
				var countzpl = new Array();	
  			<%String queryzpl = "select zpl.led as led, zpl.bofangshijian as bofangsum, zpl.kaishishijian as kaishitime, zpl.jieshushijian as jieshutime from (select kanhu, leixing, ywy_id, led, shichang, pinci, shichang * pinci as bofangshijian, kaishishijian, jieshushijian, kanlijiaxiaoji from yewu where kaishishijian <= "+"'"+format.format(weekbeforelas)+"'"+"and jieshushijian >= "+"'"+format.format(weedbeforefir)+"' and yewu.leixing = '商业广告' ) as zpl ";
				rs = stmt.executeQuery(queryzpl);
				count = 0;
				String ledzpl = "";
				String bofangsumzpl = "";
				String kaishitime = "";
				String jieshutime = "";
				while (rs.next()) {
					ledzpl = rs.getString("led");
					bofangsumzpl = rs.getString("bofangsum");
					kaishitime = rs.getString("kaishitime");
					jieshutime = rs.getString("jieshutime");
					%>
					countzpl[<%=count%>] = new Array("<%=ledzpl%>","<%=bofangsumzpl%>","<%=kaishitime%>","<%=jieshutime%>");
	<%count++; }%>
	
</script>


<script type="text/javascript">

	var timenow = new Date();
	var lednamelable = new Array();
	var ledbofangshichangvalue = new Array();
	for (var i = 0; i < arrayledshort.length; i++) {
		var stackshichang = 0;
		var keboshichangashours = Math.round(arrayledinfo[i][3]/360)/10;
		lednamelable.push(arrayledshort[i][1]+"("+keboshichangashours+"h)");

		for (var j = 0; j < arrayyewufull.length; j++) {
			if (arrayyewufull[j][3] == arrayledshort[i][0]) {
				var iDate = arrayyewufull[j][7].split("-");
				
				var jDate = new Date(iDate[1] + '-' + iDate[2] + '-' + iDate[0]);

				var xDate = arrayyewufull[j][8].split("-");
				var yDate = new Date(xDate[1] + '-' + xDate[2] + '-' + xDate[0]);
				/* 显示占屏率 */
				if ( timenow.getTime()>= jDate.getTime() && timenow.getTime() < (yDate.getTime()+1000*3600*24) ) {
					stackshichang = stackshichang
							+ parseInt(arrayyewufull[j][6]);
					
					
				}
				
			}
			
		}
		
		ledbofangshichangvalue.push(Math.round(stackshichang/arrayledinfo[i][3]*10000)/100);
		
	}
	
	window.onload = function() {
		
		  // 路径配置
		require.config({
		paths: {
		echarts: 'js/echarts/build/dist'
	}
		});
		  
		// 使用
		require(
			[
				'echarts',
				'echarts/chart/line',
				'echarts/chart/bar' // 使用柱状图就加载bar模块，按需加载
			],
			function(ec) {
				// 基于准备好的dom，初始化echarts图表
				var myChart = ec.init(document.getElementById('draw-barchart@echart'));
	
				option = {
					tooltip: {
						trigger: 'axis'
					},
					
					toolbox: {
						show: true,
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
						data: lednamelable
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
						data: ledbofangshichangvalue
					}]
				};
	
				// 为echarts对象加载数据 
				myChart.setOption(option);
			}
		);
	};
</script>

</head>

<body style="font-family: '微软雅黑';">

	<div class="main">
		
		<!--/.row-->

		<div class="row">
			<div class="col-lg-12">
				<h3 class="page-header">
					屏幕统计
					</h3>
			</div>
		</div>


		<div class="row">
		    <div class="col-1g-12">
				

						<ul class="nav nav-pills">
							<li class="active"><a href="pingmustatistic.action">实时占屏率</a></li>
							<li><a href="pingmustatistic_fenpingtongji.action">分广告类型占屏率（日）</a></li>
							<li><a href="annualLedAmountReport.action">年度屏签订金额</a></li>
							<li><a href="avgScreenOccupancyRate.action">平均占屏率（月份）</a></li>
							<li><a href="avgOccupancyRateByScreen.action">自有屏平均占屏率</a></li>
						</ul>
			</div>			
			<div class="col-1g-12">
				<div class="col-lg-12"></div>
					<!-- 为ECharts准备一个具备大小（宽高）的Dom -->
					<div id="draw-barchart@echart" style="height:500px;"></div>

					<!-- ECharts单文件引入 -->
					<script src="js/echarts.js"></script>

				</div>
		</div>
		<!--/.row-->

	</div>
	<!--/.main-->

	<script src="js/jquery-1.11.1.min.js"></script>
	<script src="js/bootstrap.min.js"></script>
	<script src="js/king-common.js"></script>
	<script src="js/chart.min.js"></script>
	<!-- 	<script src="js/chart-data-index.js"></script>
	<script src="js/easypiechart.js"></script>
	<script src="js/easypiechart-data.js"></script> -->

	<script>
		$(window).on('resize', function() {
			if ($(window).width() > 768)
				$('#sidebar-collapse').collapse('show')
		})
		$(window).on('resize', function() {
			if ($(window).width() <= 767)
				$('#sidebar-collapse').collapse('hide')
		})
	</script>
</body>

</html>
