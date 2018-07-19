<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="com.google.gson.*"%>
<%@ page import="java.sql.*"%>
<%@ taglib uri="/struts-tags" prefix="s"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<s:i18n name="contentMessage.yejistatistic">
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="icon" href="images/logo.png" type="image/x-icon" />
<link rel="shortcut icon" href="images/logo.png" type="image/x-icon" />

<link href="css/bootstrap.min.css" rel="stylesheet" media="screen">
<link rel="stylesheet" href="css/bootstrap-theme.css">
<link rel="stylesheet" href="css/main.css">
<link href="css/styles.css" rel="stylesheet">
<link href="css/laydate.css" rel="stylesheet">


<!--Icons-->
<script src="js/lumino.glyphs.js"></script>


<!-- CSS Files for createAreaChart.html-->
<link type="text/css" href="css/base.css" rel="stylesheet">

<!--[if IE]><script language="javascript" type="text/javascript" src="../../Extras/excanvas.js"></script><![endif]-->

<!--[if lt IE 9]>
<script src="js/html5shiv.js"></script>
<script src="js/respond.min.js"></script>
<![endif]-->
 

</head>

<body style="font-family: '微软雅黑';" onload="init()">

<div class="main">
		
		
		<div class="modal fade" id="file_modal_id">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
					<h4 class="modal-title text-muted" id="modaltitle"></h4>
				</div>
				<div class="modal-body">
				<div class="form-group">
				    
					<table id="modaltable" class="table table-striped table-hover" >
					<tbody>
					
					</tbody>
					</table>
					
				</div>
				</div>
				
			</div><!-- /.modal-content -->
		</div><!-- /.modal-dialog -->
	</div><!-- /.modal -->
		
		
		<!--/.row-->

		<div class="row">
			<div class="col-lg-12">
				<h3 class="page-header">行业统计</h3>
			</div>
		</div>
		<!--/.row-->

		<div class="row">

			<div class="col-1g-12">
				<ul class="nav nav-pills">
					<li class="active"><a href="hangyestatistic.action">行业投放分布</a></li>
					<li><a href="annualIndustryReport.action">行业年度统计</a></li>
					<li><a href="yejistatistic.action">行业投放明细</a></li>
				</ul>

			</div>
			<!-- /.col-->
		</div>
		<!-- /.row -->

	<!--/.main-->

<div id="jqgrid-wrapper">
		<form class="form-horizontal" role="form" action="getPieData" id="exactForm">
			<fieldset>
				<legend>查询条件</legend>
			<div class="col-sm-4">
				<div class="input-group input-group-sm" >
					<div class="input-group-addon">时间段</div>
					<input type="text" id="daterange-default" name="timeRange" value="" class="form-control">
					<input type="text" class="hidden" name="startTime" id="startTime">
					<input type="text" class="hidden" name="endTime" id="endTime">
					<input type="text" class="hidden" name="data" id="data">
					<span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
				</div>
			</div>
			<div class="col-sm-3">
					<div class="input-group input-group-sm">
						<div class="input-group-addon">屏幕</div>				
						<select  name="led" id="led" class="form-control">	
						    <option value="">所有屏幕</option>			
						</select>
					</div>
			</div>				
				<div class="col-sm-2">	
					<button class="btn btn-primary btn-sm" id="exactQuery" onclick="query()">查询</button>
					<button class="btn btn-danger btn-sm" id="clearExactForm">清除</button>
				</div>
			</fieldset>
		</form>

	</div>
	
	<div class="tab-content">		
		<div id="mainpie" style="width: 100%;height:600px;overflow: visible"></div>
	</div>
	
</div>	
</body>
</html>
<content tag="scripts">
    <script src="js/jquery-1.11.1.min.js"></script>
	<script src="js/bootstrap.min.js"></script>
	<script src="js/jquery.ba-bbq.min.js"></script>
	<script src="js/king-common.js"></script>
	<script src="js/moment.js"></script>
	<script src="js/daterangepicker.js"></script>
	<script src="js/echarts.min.js"></script>
	<script language="javascript" type="text/javascript" src="js/jit.js"></script>
	<script>
	var industrys=<%=request.getAttribute("industryArr")%>;
    var industriesJsp=new Array();
    var ratiosJsp=new Array();
    var amountsJsp=new Array();
    <%String str1=request.getAttribute("industryArr").toString();
      String str2=request.getAttribute("ratios").toString();
      String str3=request.getAttribute("amounts").toString();
      String []industries=str1.split(",");
      String []ratios=str2.split(",");
      String []amounts=str3.split(",");
      int len=ratios.length-1;
      Double []ratiosDouble=new Double[len];
      int []amountsInt=new int[len];
      for(int j=1;j<ratios.length-1;j++){
    	  ratiosDouble[j]=Double.parseDouble(ratios[j]);
    	  amountsInt[j]=Integer.parseInt(amounts[j]);
      }
      for(int i=1;i<industries.length-1;i++){%>
         industriesJsp.push(<%=industries[i]%>);
         ratiosJsp.push(<%= ratiosDouble[i]%>);
         amountsJsp.push(<%= amountsInt[i]%>);
     <% } %>
		var myChart = echarts.init(document.getElementById('mainpie'));
		myChart.setOption({
	      		    title : {
	      		        text: '占屏率分行业分布',
	      		        subtext: '目前所有屏幕',
	      		        x:'center'
	      		    },
	      		    tooltip : {
	      		        trigger: 'item',
	      		        //formatter: "{a} <br/>{b} : {c}个 ({d}%)"
	      		         formatter: function (params) {
         					return params.name+"<br>"+params.seriesName + ": " + params.value + "% <br>刊户数量: " + amountsJsp[params.dataIndex];
 						}
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
		
		
				myChart.on('click', function (param) {
			    	var index = param.name;
			    	$("#modaltable>tbody").html("");
			    	$("#modaltitle").html(index+"行业 客户分布情况");
			    	console.log('${clientManageModal}');
			    	var datas= eval('${clientManageModal}');
			    	for(var i = 0,length=datas.length;i<length;i++){
			    		var jsonobject = datas[i];
			    		if(jsonobject.industry == index){
				    		$("#modaltable>tbody").append("<tr><td>"+jsonobject.client+"</td><td>"+jsonobject.amount+"</td><td>"+jsonobject.date+"</td><td>"+jsonobject.employee+"</td></tr>");
				    	}
			    	}
			    	
			    	openModal();
			 });  

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
			  dateRangeSQL = "";
			});
			$('#daterange-default').on('apply.daterangepicker', function(ev, picker) {
			  console.log("start:"+picker.startDate.format('YYYY-MM-DD')+"\nend:"+picker.endDate.format('YYYY-MM-DD'));
			  dateRangeSQL = "y.renkanshu.qiandingriqi between '"+picker.startDate.format('YYYY-MM-DD')+"' and '"+picker.endDate.format('YYYY-MM-DD')+"' ";
			  startTime=""+picker.startDate.format('YYYY-MM-DD');
			  endTime=""+picker.endDate.format('YYYY-MM-DD');
			  request.setAttribute("startTime", startTime);
			  request.setAttribute("endTime", endTime);
			  myChart.setOption();
	//		  alert(request.getAttribute("endTime"));
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
                          value: ratiosJsp[len]
                          });
                          }
                          return res;
                          })()
	  		        }]
	  		    });	

			});
			
		    $("#clearExactForm").click(function(){
				$("#searchButton").click();
				return false;
			});
		});
		
		function frontval() {
	  		if($("#daterange-default").val()=="" ){
	  	  		alert("日期不能为空，请选择日期范围！");
//	  	  	    location.reload();
	  	  		return false;
	  	  	}
	  		return true;
		}
		
		function query() {
			if (frontval()) {
				$("#startTime").val(startTime);
				$("#endTime").val(endTime);
				$("#exactForm").submit();
			}	
		}

		function loadingLed(){		 
			 $.ajax({
			  		type:"post",
			  		dataType:"json",
			  		url:"getAllLed.action",
			  		success:function(data){ 	
			  			var jsonData = data.info;
			  			for(var i=0, n = jsonData.length;i<n;i++){
			  				$("#led").append("<option  value='"+jsonData[i][0]+"'>"+jsonData[i][1]+"</option>");		
			  			}
			  		}
			  });	
		}
		function loadingIndustry(){		 
			 $.ajax({
			  		type:"post",
			  		dataType:"json",
			  		url:"getAllIndustry.action",
			  		success:function(data){ 	
			  			var jsonData = data.info;
			  			for(var i=0, n = jsonData.length;i<n;i++){
			  				$("#industry").append("<option  value='"+jsonData[i][0]+"'>"+jsonData[i][1]+"</option>");		
			  			}
			  		}
			  });	
		}
		$(function(){
			loadingLed();
			
			loadingIndustry();

		});
		
//		$("#query").click(function(){
		
//			doucument.getElementById("query").href("getPieData.action");
//			request.setAttribute("startTime", startTime);
//			request.setAttribute("endTime", endTime);
//			request.setAttribute("led", $("#led").val());

			
//	})   
		 function openModal(){
	      $("#file_modal_id").modal({backdrop:'static'});
	      $("#file_modal_id").modal('show');
	   }
	   
		 function fillTimerangeandLed(){
			 var tmp = "<%=request.getAttribute("timeRange") %>";
			 var tmp1 = "<%=request.getAttribute("led") %>";
			 if(tmp!=null || tmp!=""){
				 $("#daterange-default").val(tmp);
				 
				 $("#led").val(tmp1);
				 startTime= tmp.substring(0, 10).replace(/\//g, "-");
				 endTime = tmp.substring(13, 23).replace(/\//g, "-");
			 }
		 }
		 
		 setTimeout(function() {
			 fillTimerangeandLed()	
		 }, 50);
	</script>
</content>
</s:i18n>