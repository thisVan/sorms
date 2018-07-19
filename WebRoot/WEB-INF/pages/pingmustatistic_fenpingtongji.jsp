<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<%! String url = "jdbc:mysql://localhost:3306/led_statistic?useUnicode=true&characterEncoding=GBK";
	String qstr="select hangyename from hangye";
%>
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
<link rel="stylesheet" href="css/bootstrap-theme.css">
<link href="css/styles.css" rel="stylesheet">

<!--Icons-->
<script src="js/lumino.glyphs.js"></script>
</head>

<body style="font-family: '微软雅黑';">

	<div class="main">

		<div class="row">
			<div class="col-lg-12">
				<h3 class="page-header">屏幕统计</h3>
			</div>
			<div class="tabs">
						<ul class="nav nav-pills">
							<li><a href="pingmustatistic.action">实时占屏率</a></li>
							<li class="active"><a href="pingmustatistic_fenpingtongji.action">分广告类型占屏率（日）</a></li>
							<li><a href="annualLedAmountReport.action">年度屏签订金额</a></li>
							<li><a href="avgScreenOccupancyRate.action">平均占屏率（月份）</a></li>
							<li><a href="avgOccupancyRateByScreen.action">自有屏平均占屏率</a></li>
						</ul>

			</div>
		</div>
		<!--/.row-->

		<div class="row">

			<div class="col-1g-12">
				<div class="panel panel-default">
					<div class="panel-body tabs">

						<div class="tab-content">
							<div class="col-1g-12">
								<div class="col-md-12">
									<form class="form-inline">

										<script type="text/javascript">
							//dynamic add options in select tag back the default date
	
							window.onload = function (){
								var arrledlist = arrayledshort;
								for(var i=0;i< arrayledshort.length;i++){
								document.getElementById("fenpingyeji_select").options.add(new Option(arrledlist[i][1],arrledlist[i][0]));
								}
								document.getElementById('nffptime-strat').valueAsDate = new Date();
								document.getElementById('nffptime-end').valueAsDate = new Date(new Date().getTime()+1000*3600*24*6);
							}
							
							</script>
										<select class="form-control" id="fenpingyeji_select"></select>
										<label>请选择起始时间：</label><input class="form-control"
											id="nffptime-strat" type="date" /> <label>请选择结束时间：</label><input
											class="form-control" id="nffptime-end" type="date" /> <input type="button" class="btn-primary form-control" value="按日统计" onclick="btnCount_Click()" />
											<input type="button" class="btn-primary form-control" value="按时段统计" onclick="btnzhzpl_Click()" />
									</form>

								</div>
							</div>
						</div>
						<div class="col-1g-12">
							<label>&nbsp;</label>
						</div>
						<script type="text/JavaScript">
						
						
					  function  btnCount_Click(){
						  var kebsc = 0;
						  var ledselectvalue = document.getElementById("fenpingyeji_select").value;
						 
					      var s1  =  document.getElementById("nffptime-strat").value;
					      var s2  =  document.getElementById("nffptime-end").value;
						
					      //确定可播时长
					      for(var i = 0;i<arrayledinfo.length;i++){
					    	  if(arrayledinfo[i][0] == ledselectvalue){
					    		  kebsc = arrayledinfo[i][3];
					    	  }
					      }
					     // 路径配置
						require.config({
						paths: {
						echarts: 'js/echarts/build/dist'
					}
						});
						
						var datestrat = document.getElementById("nffptime-strat");
						var dateend = document.getElementById("nffptime-end");
						var dDate  =  datestrat.value.split("-");
						var dDate1  =  new  Date(dDate[1]  +  '-'  +  dDate[2]  +  '-'  +  dDate[0]); 
						var datestratvalue = Math.abs(dDate1);
						var oneDay = 24 * 3600 * 1000;
						
						var ledconfirmedrecordsy = new Array();
						var ledconfirmedrecordhz = new Array();
						var ledconfirmedrecordzb = new Array();
						var ledconfirmedrecordgy = new Array();
						var ledconfirmedrecordqt = new Array();
						
						for(var i =0;i<arrayyewushangye.length;i++){
							if(ledselectvalue == arrayyewushangye[i][3]){
								ledconfirmedrecordsy.push(arrayyewushangye[i]);
								
							}
						}
						for(var i =0;i<arrayyewuhuzeng.length;i++){
							if(arrayyewuhuzeng[i][3] == ledselectvalue){
								ledconfirmedrecordhz.push(arrayyewuhuzeng[i]);
							}
						}
						for(var i =0;i<arrayyewuzengbo.length;i++){
							if(arrayyewuzengbo[i][3] == ledselectvalue){
								ledconfirmedrecordzb.push(arrayyewuzengbo[i]);
							}
						}
						for(var i =0;i<arrayyewugongyi.length;i++){
							if(arrayyewugongyi[i][3] == ledselectvalue){
								ledconfirmedrecordgy.push(arrayyewugongyi[i]);
							}
						}
						for(var i =0;i<arrayyewuqita.length;i++){
							if(arrayyewuqita[i][3] == ledselectvalue){
								ledconfirmedrecordqt.push(arrayyewuqita[i]);
							}
						}
						var arrywsy = [];
						var arrywhz = [];
						var arrywzb = [];
						var arrywgy = [];
						var arrywqt = [];
						
						if(ledconfirmedrecordsy.length>0){
							var dateTmp = dDate1;
							for(var j=0; j<DateDiff(s1, s2);j++){
								var stackshichang = 0;
								for(var i=0;i<ledconfirmedrecordsy.length;i++){
									
									var iDate  =  ledconfirmedrecordsy[i][7].split("-");
					       			var jDate  =  new  Date(iDate[1]  +  '-'  +  iDate[2]  +  '-'  +  iDate[0]);
									
									var xDate  =  ledconfirmedrecordsy[i][8].split("-");
									var yDate  =  new  Date(xDate[1]  +  '-'  +  xDate[2]  +  '-'  +  xDate[0]);
									if(dateTmp.getTime()>=jDate.getTime() && dateTmp.getTime()<(yDate.getTime()+24*3600*1000)){
										
										stackshichang = stackshichang + parseInt(ledconfirmedrecordsy[i][6]);
									}
								}
								arrywsy.push(Math.round(stackshichang/kebsc*10000)/100);
								
								dateTmp = new Date(dateTmp.getTime() + oneDay);
							}
			
						}else{
							for(var i=0;i<DateDiff(s1,  s2);i++){
								arrywsy.push(0);
							}
						}
						
						if(ledconfirmedrecordhz.length>0){
							var dateTmp = dDate1;
							for(var j=0; j<DateDiff(s1, s2);j++){
								var stackshichang = 0;
								for(var i=0;i<ledconfirmedrecordhz.length;i++){
									
									var iDate  =  ledconfirmedrecordhz[i][7].split("-");
					       			var jDate  =  new  Date(iDate[1]  +  '-'  +  iDate[2]  +  '-'  +  iDate[0]);
									
									var xDate  =  ledconfirmedrecordhz[i][8].split("-");
									var yDate  =  new  Date(xDate[1]  +  '-'  +  xDate[2]  +  '-'  +  xDate[0]);
									if(dateTmp.getTime()>=jDate.getTime() && dateTmp.getTime()<(yDate.getTime()+24*3600*1000)){
										stackshichang = stackshichang + parseInt(ledconfirmedrecordhz[i][6]);
									}
								}
								arrywhz.push(Math.round(stackshichang/kebsc*10000)/100);
								dateTmp = new Date(dateTmp.getTime() + oneDay);
							}

						}else{
							for(var i=0;i<DateDiff(s1,  s2);i++){
								arrywhz.push(0);
							}
						}
						
						if(ledconfirmedrecordzb.length>0){
							var dateTmp = dDate1;
							for(var j=0; j<DateDiff(s1, s2);j++){
								var stackshichang = 0;
								for(var i=0;i<ledconfirmedrecordzb.length;i++){
									
									var iDate  =  ledconfirmedrecordzb[i][7].split("-");
					       			var jDate  =  new  Date(iDate[1]  +  '-'  +  iDate[2]  +  '-'  +  iDate[0]);
									
									var xDate  =  ledconfirmedrecordzb[i][8].split("-");
									var yDate  =  new  Date(xDate[1]  +  '-'  +  xDate[2]  +  '-'  +  xDate[0]);
									if(dateTmp.getTime()>=jDate.getTime() && dateTmp.getTime()<(yDate.getTime()+24*3600*1000)){
										stackshichang = stackshichang + parseInt(ledconfirmedrecordzb[i][6]);
									}
								}
								arrywzb.push(Math.round(stackshichang/kebsc*10000)/100);
								dateTmp = new Date(dateTmp.getTime() + oneDay);
							}

						}else{
							for(var i=0;i<DateDiff(s1,  s2);i++){
								arrywzb.push(0);
							}
						}
						
						if(ledconfirmedrecordgy.length>0){
							var dateTmp = dDate1;
							for(var j=0; j<DateDiff(s1, s2);j++){
								var stackshichang = 0;
								for(var i=0;i<ledconfirmedrecordgy.length;i++){
									
									var iDate  =  ledconfirmedrecordgy[i][7].split("-");
					       			var jDate  =  new  Date(iDate[1]  +  '-'  +  iDate[2]  +  '-'  +  iDate[0]);
									
									var xDate  =  ledconfirmedrecordgy[i][8].split("-");
									var yDate  =  new  Date(xDate[1]  +  '-'  +  xDate[2]  +  '-'  +  xDate[0]);
									if(dateTmp.getTime()>=jDate.getTime() && dateTmp.getTime()<(yDate.getTime()+24*3600*1000)){
										stackshichang = stackshichang + parseInt(ledconfirmedrecordgy[i][6]);
									}
								}
								arrywgy.push(Math.round(stackshichang/kebsc*10000)/100);
								dateTmp = new Date(dateTmp.getTime() + oneDay);
							}

						}else{
							for(var i=0;i<DateDiff(s1,  s2);i++){
								arrywgy.push(0);
							}
						}
						
						if(ledconfirmedrecordqt.length>0){
							var dateTmp = dDate1;
							for(var j=0; j<DateDiff(s1, s2);j++){
								var stackshichang = 0;
								for(var i=0;i<ledconfirmedrecordqt.length;i++){
									
									var iDate  =  ledconfirmedrecordqt[i][7].split("-");
					       			var jDate  =  new  Date(iDate[1]  +  '-'  +  iDate[2]  +  '-'  +  iDate[0]);
									
									var xDate  =  ledconfirmedrecordqt[i][8].split("-");
									var yDate  =  new  Date(xDate[1]  +  '-'  +  xDate[2]  +  '-'  +  xDate[0]);
									if(dateTmp.getTime()>=jDate.getTime() && dateTmp.getTime()<(yDate.getTime()+24*3600*1000)){
										stackshichang = stackshichang + parseInt(ledconfirmedrecordqt[i][6]);
									}
								}
								arrywqt.push(Math.round(stackshichang/kebsc*10000)/100);
								dateTmp = new Date(dateTmp.getTime() + oneDay);
							}

						}else{
							for(var i=0;i<DateDiff(s1,  s2);i++){
								arrywqt.push(0);
							}
						}

						
						var date = [];
						var data = arrywsy;
						var data1 = arrywhz;
						var data2 = arrywzb;
						var data3 = arrywgy;
						var data4 = arrywqt;
						
						if(s2 < s1){
							alert("结束日期不能小于开始日期！")
						}
						
						for (var i = 1; i <= DateDiff(s1,  s2); i++) {
							var now = new Date(datestratvalue);
						    date.push([now.getFullYear(), now.getMonth() + 1, now.getDate()].join('-'));
						    datestratvalue += oneDay;
						}

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
									legend: {
										data: ['商业广告', '互赠广告', '赠播广告', '公益广告', '其他广告']
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
										interval: 'auto',
										boundaryGap: true,
										data: date
									}],
									yAxis: [{
										name: '占屏率',
							            type : 'value',
							            position: 'left',
							            //min: 0,
							            //max: 720,
							            //splitNumber: 5,
							            boundaryGap: [0,0.1],
							            axisLabel : {
							                show:true,
							                interval: 'auto',    // {number}
							                margin: 18,
							                formatter: '{value}%'
							                // Template formatter!
							             }
										}],
									series: [{
										name: '商业广告',
										type: 'bar',
										stack: '总量',
										itemStyle: {
											normal: {
												areaStyle: {
													type: 'default'
												}
											}
										},
										data: data
									}, {
										name: '互赠广告',
										type: 'bar',
										stack: '总量',
										itemStyle: {
											normal: {
												areaStyle: {
													type: 'default'
												}
											}
										},
										data: data1
									}, {
										name: '赠播广告',
										type: 'bar',
										stack: '总量',
										itemStyle: {
											normal: {
												areaStyle: {
													type: 'default'
												}
											}
										},
										data: data2
									}, {
										name: '公益广告',
										type: 'bar',
										stack: '总量',
										itemStyle: {
											normal: {
												areaStyle: {
													type: 'default'
												}
											}
										},
										data: data3
									}, {
										name: '其他广告',
										type: 'bar',
										stack: '总量',
										itemStyle: {
											normal: {
												areaStyle: {
													type: 'default'
												}
											}
										},
										data: data4
									}]
								};
					
								// 为echarts对象加载数据 
								myChart.setOption(option);
							}
						);
					      
					   }  
					
					  function btnzhzpl_Click() {
						  var kebsc = 0;
						  var ledselectvalue = document.getElementById("fenpingyeji_select").value;
						 
					      var s1  =  document.getElementById("nffptime-strat").value;
					      var s2  =  document.getElementById("nffptime-end").value;
						
					      //确定可播时长
					      for(var i = 0;i<arrayledinfo.length;i++){
					    	  if(arrayledinfo[i][0] == ledselectvalue){
					    		  kebsc = arrayledinfo[i][3];
					    	  }
					      }
					     // 路径配置
						require.config({
						paths: {
						echarts: 'js/echarts/build/dist'
					}
						});
						
						var datestrat = document.getElementById("nffptime-strat");
						var dateend = document.getElementById("nffptime-end");
						var dDate  =  datestrat.value.split("-");
						var dDate1  =  new  Date(dDate[1]  +  '-'  +  dDate[2]  +  '-'  +  dDate[0]); 
						var datestratvalue = Math.abs(dDate1);
						var oneDay = 24 * 3600 * 1000;
						
						var ledconfirmedrecordsy = new Array();
						var ledconfirmedrecordhz = new Array();
						var ledconfirmedrecordzb = new Array();
						var ledconfirmedrecordgy = new Array();
						var ledconfirmedrecordqt = new Array();
						
						for(var i =0;i<arrayyewushangye.length;i++){
							if(ledselectvalue == arrayyewushangye[i][3]){
								ledconfirmedrecordsy.push(arrayyewushangye[i]);
								
							}
						}
						for(var i =0;i<arrayyewuhuzeng.length;i++){
							if(arrayyewuhuzeng[i][3] == ledselectvalue){
								ledconfirmedrecordhz.push(arrayyewuhuzeng[i]);
							}
						}
						for(var i =0;i<arrayyewuzengbo.length;i++){
							if(arrayyewuzengbo[i][3] == ledselectvalue){
								ledconfirmedrecordzb.push(arrayyewuzengbo[i]);
							}
						}
						for(var i =0;i<arrayyewugongyi.length;i++){
							if(arrayyewugongyi[i][3] == ledselectvalue){
								ledconfirmedrecordgy.push(arrayyewugongyi[i]);
							}
						}
						for(var i =0;i<arrayyewuqita.length;i++){
							if(arrayyewuqita[i][3] == ledselectvalue){
								ledconfirmedrecordqt.push(arrayyewuqita[i]);
							}
						}
						var arrywsy = [];
						var arrywhz = [];
						var arrywzb = [];
						var arrywgy = [];
						var arrywqt = [];
						
						if(ledconfirmedrecordsy.length>0){
							var dateTmp = dDate1;
							for(var j=0; j<DateDiff(s1, s2);j++){
								var stackshichang = 0;
								
								for(var i=0;i<ledconfirmedrecordsy.length;i++){
									
									var iDate  =  ledconfirmedrecordsy[i][7].split("-");
					       			var jDate  =  new  Date(iDate[1]  +  '-'  +  iDate[2]  +  '-'  +  iDate[0]);
									
									var xDate  =  ledconfirmedrecordsy[i][8].split("-");
									var yDate  =  new  Date(xDate[1]  +  '-'  +  xDate[2]  +  '-'  +  xDate[0]);
									if(dateTmp.getTime()>=jDate.getTime() && dateTmp.getTime()<(yDate.getTime()+24*3600*1000)){
										
										stackshichang = stackshichang + parseInt(ledconfirmedrecordsy[i][6]);
									}
								}
								arrywsy.push(stackshichang);
								
								dateTmp = new Date(dateTmp.getTime() + oneDay);
							}
			
						}else{
							for(var i=0;i<DateDiff(s1,  s2);i++){
								arrywsy.push(0);
							}
						}
						
						if(ledconfirmedrecordhz.length>0){
							var dateTmp = dDate1;
							for(var j=0; j<DateDiff(s1, s2);j++){
								var stackshichang = 0;
								
								for(var i=0;i<ledconfirmedrecordhz.length;i++){
									
									var iDate  =  ledconfirmedrecordhz[i][7].split("-");
					       			var jDate  =  new  Date(iDate[1]  +  '-'  +  iDate[2]  +  '-'  +  iDate[0]);
									
									var xDate  =  ledconfirmedrecordhz[i][8].split("-");
									var yDate  =  new  Date(xDate[1]  +  '-'  +  xDate[2]  +  '-'  +  xDate[0]);
									if(dateTmp.getTime()>=jDate.getTime() && dateTmp.getTime()<(yDate.getTime()+24*3600*1000)){
										stackshichang = stackshichang + parseInt(ledconfirmedrecordhz[i][6]);
									}
								}
								arrywhz.push(stackshichang);
								dateTmp = new Date(dateTmp.getTime() + oneDay);
							}

						}else{
							for(var i=0;i<DateDiff(s1,  s2);i++){
								arrywhz.push(0);
							}
						}
						
						if(ledconfirmedrecordzb.length>0){
							var dateTmp = dDate1;
							for(var j=0; j<DateDiff(s1, s2);j++){
								var stackshichang = 0;
								
								for(var i=0;i<ledconfirmedrecordzb.length;i++){
									
									var iDate  =  ledconfirmedrecordzb[i][7].split("-");
					       			var jDate  =  new  Date(iDate[1]  +  '-'  +  iDate[2]  +  '-'  +  iDate[0]);
									
									var xDate  =  ledconfirmedrecordzb[i][8].split("-");
									var yDate  =  new  Date(xDate[1]  +  '-'  +  xDate[2]  +  '-'  +  xDate[0]);
									if(dateTmp.getTime()>=jDate.getTime() && dateTmp.getTime()<(yDate.getTime()+24*3600*1000)){
										stackshichang = stackshichang + parseInt(ledconfirmedrecordzb[i][6]);
									}
								}
								arrywzb.push(stackshichang);
								dateTmp = new Date(dateTmp.getTime() + oneDay);
							}

						}else{
							for(var i=0;i<DateDiff(s1,  s2);i++){
								arrywzb.push(0);
							}
						}
						
						if(ledconfirmedrecordgy.length>0){
							var dateTmp = dDate1;
							for(var j=0; j<DateDiff(s1, s2);j++){
								var stackshichang = 0;
								
								for(var i=0;i<ledconfirmedrecordgy.length;i++){
									
									var iDate  =  ledconfirmedrecordgy[i][7].split("-");
					       			var jDate  =  new  Date(iDate[1]  +  '-'  +  iDate[2]  +  '-'  +  iDate[0]);
									
									var xDate  =  ledconfirmedrecordgy[i][8].split("-");
									var yDate  =  new  Date(xDate[1]  +  '-'  +  xDate[2]  +  '-'  +  xDate[0]);
									if(dateTmp.getTime()>=jDate.getTime() && dateTmp.getTime()<(yDate.getTime()+24*3600*1000)){
										stackshichang = stackshichang + parseInt(ledconfirmedrecordgy[i][6]);
									}
								}
								arrywgy.push(stackshichang);
								dateTmp = new Date(dateTmp.getTime() + oneDay);
							}

						}else{
							for(var i=0;i<DateDiff(s1,  s2);i++){
								arrywgy.push(0);
							}
						}
						
						if(ledconfirmedrecordqt.length>0){
							var dateTmp = dDate1;
							for(var j=0; j<DateDiff(s1, s2);j++){
								var stackshichang = 0;
								
								for(var i=0;i<ledconfirmedrecordqt.length;i++){
									
									var iDate  =  ledconfirmedrecordqt[i][7].split("-");
					       			var jDate  =  new  Date(iDate[1]  +  '-'  +  iDate[2]  +  '-'  +  iDate[0]);
									
									var xDate  =  ledconfirmedrecordqt[i][8].split("-");
									var yDate  =  new  Date(xDate[1]  +  '-'  +  xDate[2]  +  '-'  +  xDate[0]);
									if(dateTmp.getTime()>=jDate.getTime() && dateTmp.getTime()<(yDate.getTime()+24*3600*1000)){
										stackshichang = stackshichang + parseInt(ledconfirmedrecordqt[i][6]);
									}
								}
								arrywqt.push(stackshichang);
								dateTmp = new Date(dateTmp.getTime() + oneDay);
							}

						}else{
							for(var i=0;i<DateDiff(s1,  s2);i++){
								arrywqt.push(0);
							}
						}
						
						arrywqt.push(Math.round(stackshichang/kebsc*10000)/100);
						
						//统计数据
						var fptjsy = 0;
						var fptjhz = 0;
						var fptjzb = 0;
						var fptjgy = 0;
						var fptjqt = 0;
						for(var idx=0;idx<arrywsy.length;idx ++){
							fptjsy += arrywsy[idx];
							
							fptjhz += arrywhz[idx];
							
							fptjzb += arrywzb[idx];
							
							fptjgy += arrywgy[idx];
							
							fptjqt += arrywqt[idx];
							
						}
						fptjsy = Math.round(fptjsy/kebsc/arrywsy.length*10000)/100;
						fptjhz = Math.round(fptjhz/kebsc/arrywsy.length*10000)/100;
						fptjzb = Math.round(fptjzb/kebsc/arrywsy.length*10000)/100;
						fptjgy = Math.round(fptjgy/kebsc/arrywsy.length*10000)/100;
						fptjqt = Math.round(fptjqt/kebsc/arrywsy.length*10000)/100;
						
						if(s2 < s1){
							alert("结束日期不能小于开始日期！");
						}
						
						var selectObj = document.getElementById("fenpingyeji_select");
						var selectpmtxt = selectObj.options[selectObj.selectedIndex].text;
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
									legend: {
										data: ['商业广告', '互赠广告', '赠播广告', '公益广告', '其他广告']
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
										interval: 'auto',
										boundaryGap: true,
										data: [selectpmtxt]
									}],
									yAxis: [{
										name: '占屏率',
							            type : 'value',
							            position: 'left',
							            //min: 0,
							            //max: 720,
							            //splitNumber: 5,
							            boundaryGap: [0,0.1],
							            axisLabel : {
							                show:true,
							                interval: 'auto',    // {number}
							                margin: 18,
							                formatter: '{value}%'
							                // Template formatter!
							             }
										}],
									series: [{
										name: '商业广告',
										type: 'bar',
										stack: '总量',
										itemStyle: {
											normal: {
												areaStyle: {
													type: 'default'
												}
											}
										},
										data: [fptjsy]
									}, {
										name: '互赠广告',
										type: 'bar',
										stack: '总量',
										itemStyle: {
											normal: {
												areaStyle: {
													type: 'default'
												}
											}
										},
										data: [fptjhz]
									}, {
										name: '赠播广告',
										type: 'bar',
										stack: '总量',
										itemStyle: {
											normal: {
												areaStyle: {
													type: 'default'
												}
											}
										},
										data: [fptjzb]
									}, {
										name: '公益广告',
										type: 'bar',
										stack: '总量',
										itemStyle: {
											normal: {
												areaStyle: {
													type: 'default'
												}
											}
										},
										data: [fptjgy]
									}, {
										name: '其他广告',
										type: 'bar',
										stack: '总量',
										itemStyle: {
											normal: {
												areaStyle: {
													type: 'default'
												}
											}
										},
										data: [fptjqt]
									}]
								};
					
								// 为echarts对象加载数据 
								myChart.setOption(option);
							}
						);
					}
					  
					   //计算天数差的函数，通用  
					   function  DateDiff(s1,  s2){    //sDate1和sDate2是2016-12-18格式  
					       var  aDate,  oDate1,  oDate2,  iDays;
					       aDate  =  s1.split("-");
					       oDate1  =  new  Date(aDate[1]  +  '-'  +  aDate[2]  +  '-'  +  aDate[0]);  //转换为12-18-2016格式  
					       aDate  =  s2.split("-");
					       oDate2  =  new  Date(aDate[1]  +  '-'  +  aDate[2]  +  '-'  +  aDate[0]);
					       iDays  =  parseInt(Math.abs(oDate2  -  oDate1)  /  1000  /  60  /  60  /24);  //把相差的毫秒数转换为天数  
					      return  iDays+1;
					   }    
					
					</script>

					</div>
					<!-- /.panel-body -->
				</div>
				<!--/.panel-->
				<div class="col-1g-12">
					<!-- 为ECharts准备一个具备大小（宽高）的Dom -->
					<div id="draw-barchart@echart" style="height:400px"></div>

					<!-- ECharts单文件引入 -->
					<script src="js/echarts.js"></script>

					<script type="text/javascript">
				
			</script>
				</div>

			</div>
			<!-- /.col-->
		</div>
		<!-- /.row -->

	</div>
	<!--/.main-->


	<script src="js/jquery-1.11.1.min.js"></script>
	<script src="js/bootstrap.min.js"></script>
	<script src="js/king-common.js"></script>
	<script src="js/chart.min.js"></script>

	<script>
		!function ($) {
		    $(document).on("click","ul.nav li.parent > a > span.icon", function(){          
		        $(this).find('em:first').toggleClass("glyphicon-minus");      
		    }); 
		    $(".sidebar span.icon").find('em:first').addClass("glyphicon-plus");
		}(window.jQuery);

		$(window).on('resize', function () {
		  if ($(window).width() > 768) $('#sidebar-collapse').collapse('show')
		})
		$(window).on('resize', function () {
		  if ($(window).width() <= 767) $('#sidebar-collapse').collapse('hide')
		})
	</script>
</body>

</html>