<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>

<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="icon" href="images/logo.png" type="image/x-icon" />
<link rel="shortcut icon" href="images/logo.png" type="image/x-icon" />

<link href="css/bootstrap.min.css" rel="stylesheet">

<link href="css/bootstrap.min.css" rel="stylesheet" media="screen">
<link rel="stylesheet" href="css/bootstrap-theme.css">

<link href="css/styles.css" rel="stylesheet">
<link href="css/laydate.css" rel="stylesheet">


<!--Icons-->
<script src="js/lumino.glyphs.js"></script>
<script src="js/jquery-1.11.1.min.js"></script>


</head>

<body style="font-family: '微软雅黑';">

	<div class="main">
		
		<!--/.row-->

		<div class="row">
			<div class="col-lg-12">
				<h3 class="page-header">屏幕统计</h3>

			</div>
		</div>
		<!--/.row-->

		<div class="row">

			<div class="col-1g-12" onload="showselectlist()">
				<div class="panel panel-default">
					<div class="panel-body tabs">

						<ul class="nav nav-pills">
							<li><a href="pingmustatistic.html">实时占屏率</a></li>
							<li class="active"><a
								href="pingmustatistic_fenpingyeji.html">分屏业绩表现</a></li>
							<li><a href="pingmustatistic_fenpingtongji.jsp">分屏数据统计</a></li>

						</ul>

					</div>
					<script type="text/javascript">
						//dynamic add options in select tag
						jQuery(document)
								.ready(
										function() {
											var arrledlistfp = new Array(
													"南都楼顶", "IFC西塔", "中山益华",
													"北京路", "深圳东门", "金凯广场",
													"新绿岛", "佛山ICC", "东方广场",
													"住建大厦", "车天车地");
											for (var i = 0; i < arrledlistfp.length; i++) {
												document
														.getElementById("fenpingyeji_selectledlist").options
														.add(new Option(
																arrledlistfp[i],
																arrledlistfp[i]));
											}
										});
					</script>
					<div class="col-1g-12">
						<label>&nbsp;</label>
					</div>
					<div class="col-1g-12">
						<div class="col-md-12">
							<div class="col-md-1">
								<select class="btn-group-lg" id="fenpingyeji_selectledlist"></select>
							</div>
							<div class="col-md-11">
								<label
									style="color: rgb(200,200,200);font: bold;font-size: large;">灰色表示去年同期</label><label
									style="color: rgb(48, 164, 255);font: bold;font-size: large;">蓝色表示当前数据</label>
							</div>
						</div>
						<div class="col-md-12">
							<table class="table-condensed">
								<tbody>
									<tr>
										<td></td>
										<td style="font-size: large;">选择视图</td>
										<td>&nbsp;&nbsp;</td>
										<td>
											<div class="radio">
												<input type="radio" name="optionsRadiosfq"
													id="optionsRadiosfq1" value="option1"
													onclick="setMychartView('月')" checked>月视图
											</div>
										</td>
										<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
										<td>
											<div class="radio">
												<input type="radio" name="optionsRadiosfq"
													id="optionsRadiosfq2" value="option2"
													onclick="switchFenqiItem('周')">周视图图
											</div>
										</td>
										<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
										<td>
											<div class="radio">
												<input type="radio" name="optionsRadiosfq"
													id="optionsRadiosfq3" value="option3"
													onclick="switchFenqiItem('日')">日视图
											</div>
										</td>
									</tr>
								</tbody>
							</table>
						</div>

					</div>

					<div class="tab-content">

						<div class="tab-pane fade in active">
							<p>
							<div class="row">
								<div class="col-lg-12">
									<div class="panel panel-default">

										<div class="panel-body">
											<div class="canvas-wrapper">
												<canvas class="main-chart" id="bar-chart" height="200"
													width="600"></canvas>
											</div>
										</div>
									</div>
								</div>
							</div>
							<!--/.row-->
							</p>
						</div>


					</div>
				</div>
				<!--/.panel-->
			</div>
			<!-- /.col-->
		</div>
		<!-- /.row -->



	</div>
	<!--/.main-->


	<script src="js/jquery-1.11.1.min.js"></script>
	<script src="js/bootstrap.min.js"></script>
	<script src="js/chart.min.js"></script>
	<script type="text/javascript" src="js/chart-data@fenpingyeji.js"></script>

	<script>
		!function($) {
			$(document)
					.on(
							"click",
							"ul.nav li.parent > a > span.icon",
							function() {
								$(this).find('em:first').toggleClass(
										"glyphicon-minus");
							});
			$(".sidebar span.icon").find('em:first').addClass("glyphicon-plus");
		}(window.jQuery);

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