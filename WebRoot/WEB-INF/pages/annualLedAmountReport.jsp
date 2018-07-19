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
	
		<form class="form-horizontal" role="form" action="upOrderPage"
			id="upOrderForm">
			<div class="input-group input-group-sm">
				<input type="text" class="hidden" name="upOrder_id" id="upOrder_id">
			</div>
		</form>

		<!--/.row-->

		<div class="row">
			<div class="col-lg-12">
				<h3 class="page-header">年度屏签订金额数据统计</h3>
			</div>
					<div class="panel-body tabs">

						<ul class="nav nav-pills">
							<li ><a href="pingmustatistic.action">实时占屏率</a></li>
							<li><a href="pingmustatistic_fenpingtongji.action">分广告类型占屏率（日）</a></li>
							<li class="active"><a href="annualLedAmountReport.action">年度屏签订金额</a></li>
							<li><a href="avgScreenOccupancyRate.action">平均占屏率（月份）</a></li>
							<li><a href="avgOccupancyRateByScreen.action">自有屏平均占屏率</a></li>
						</ul>

					</div>
		</div>
		<!--/.row-->

	
	</div>
	

	<div class="row">
		<div class="col-lg-12">
			<div class="col-lg-12 tabs" id="tabs">
				<ul class="nav nav-pills">
					<li class="active"><a href="#tab1" onclick="tab('#tab1')" data-toggle="tab">各屏幕全年签订金额</a></li>
					<li><a href="#tab2" onclick="tab('#tab2')" data-toggle="tab">各屏幕分月签订金额</a></li>
				</ul>
				
				<div class="col-lg-12" ><label> </label></div>
				
				<div id="tab1" class="tab-pane fade in active">
					<div class="row">
						<div class="col-sm-2">
							<div class="input-group input-group-sm">
								<div class="input-group-addon">年度</div>
								<select name="annualLedSum" id="annualLedSum"
									class="form-control" onchange="AnnualLedSumSelect()">
									<option value="2015">2015</option>
									<option value="2016" selected="selected">2016</option>
									<option value="2017">2017</option>
									<option value="2018">2018</option>
									<option value="2019">2019</option>
									<option value="2020">2020</option>
								</select>
							</div>
						</div>
						<div class="col-sm-1 pull-right">
							<button class="btn btn-primary btn-sm" id="exportExcel2">导出报表</button>
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
					
					<div id="report1" class="row" >
					<div id="jqgrid-wrapper_EveryLed_sum">
						<table id="jqgrid_EveryLed_sum"
							class="table table-striped table-hover table-bordered"></table>
						<div id="jqgrid-pager_EveryLed_sum"></div>
					</div>
					</div>
				</div>
					
				<div id="tab2" class="tab-pane fade">
					<div id="report3" class="row" >	<!-- 屏幕按月份统计表 -->
						<div class="col-sm-2">
							<div class="input-group input-group-sm">
								<div class="input-group-addon">年度</div>
								<select id="year" class="form-control" onchange="changeReport3()">
									<option value="2015">2015</option>
									<option value="2016" selected="selected">2016</option>
									<option value="2017">2017</option>
									<option value="2018">2018</option>
									<option value="2019">2019</option>
									<option value="2020">2020</option>
								</select>
							</div>
						</div>
						<div class="col-sm-12"><label>&nbsp;</label></div>
					</div>
					
					<div id="report3" class="row" >
						<div id="jqgrid-wrapper_report3">
							<table id="jqgrid_report3" class="table table-striped table-hover table-bordered"></table>
							<div id="jqgrid-pager_report3"></div>
						</div>
					</div>
				</div>
			</div>
		</div>

	<div class="modal fade" id="modal_detail">
		<div class="modal-dialog" style="width: 650px">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
					<h4 class="modal-title text-muted" id="modalTitle">订单详情</h4>
				</div>
				<div class="modal-body">
					<div class="form-group">
						<table id="modalTable" class="table table-striped table-hover" >
							<tbody></tbody>
						</table>
					</div>
				</div>
			</div><!-- /.modal-content -->
		</div><!-- /.modal-dialog -->
	</div><!-- /.modal -->

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
	function tab(pid) {
		var tabs=["#tab1","#tab2"];
		for(var i = 0; i < tabs.length; i++){
			if(tabs[i] == pid){
		    	$("div" + tabs[i]).show();
		  	} else{
		    	$("div" + tabs[i]).hide();
		  	}
		}
	}
	
	function changeReport3() {
		$.extend($("#jqgrid_report3")[0].p.postData, {year: $("select#year").val()});
		$("#jqgrid_report3").trigger("reloadGrid",[{page:1,current:true}]);
		//alert();
	}
	
	function query(month, led){
			$.ajax({
				type: "post",
				url: "getMonthlySignedAmountDetail",
				data: {year: $("select#year").val(), month: month, led: led},
				dataType: "json",
				success: function(data) {
		        	var style = " style='text-align: center'";
					$("#modalTable>tbody").empty();
		 	    	$("#modalTable>tbody").append("<th"+style+">上画屏幕</th><th"+style+">刊户</th><th"+style+">类型</th><th"+style+">签订日期</th><th"+style+">屏签订金额（元）</th>");
		 	    	for(var i = 0; i < data.res.length; i++){
	    				$("#modalTable>tbody").append("<tr><td>"+data.res[i].led+"</td><td>"+data.res[i].client+"</td><td>"+data.res[i].type+"</td><td>"+data.res[i].time+"</td><td>"+data.res[i].price+"</td></tr>");
			    	}
		         },
		         error: function(errorMsg) {
		         	alert("错误!");
		         }
			})
			$("#modal_detail").modal('show');
		}
	
	$(document).ready(function(){
		var t_EveryLed_sum= $("#jqgrid_EveryLed_sum");
	    var report3 = $("#jqgrid_report3");
	    
		function e_EveryLed_sum() {
			t_EveryLed_sum.length > 0 && t_EveryLed_sum.fluidGrid({
				base: "#jqgrid-wrapper_EveryLed_sum",
				offset: 0
			})
		}
		
		function e_report3() {
			report3.length > 0 && report3.fluidGrid({
				base: "#jqgrid-wrapper_report3",
				offset: 0
			})
		}
		
	    
	    $("#jqgrid_EveryLed_sum").length > 0 && (t_EveryLed_sum.jqGrid({
	    	url:"getLedSum.action",
	    	mtype:"GET",
	    	datatype:"json",
	    	colNames:['屏幕','收入合计'],
	    	shrinkToFit:true,
	    	height:360,
	    	width:800,
	    	rowNum:10,
	    	rowList: [10, 20, 30],
       		pager: "jqgrid-pager_EveryLed_sum",
       		multiselect:!1,
       		sortname:"y.led.ledId",
       		sortorder: "desc",
       		viewrecords: !0,
       		colModel:[{
       			name:"y.led.ledName",
       			index:"y.led.ledName",
       	//		sortable: !1,
       			align:"center",
       	 		width:"120px"    		
       		},{
       			name:"sum(y.totalpublishprice)",
       			index:"sum(y.totalpublishprice)",
       			align:"center",
       			width:"100px"
       		}],
       		gridComplete: function(data){}
	    }), e_EveryLed_sum(), $("#jqgrid_EveryLed_sum").length > 0 && t_EveryLed_sum.jqGrid("navGrid","#jqgrid-pager_EveryLed_sum",{
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
	    $(window).resize(e_EveryLed_sum);	
		
		//屏幕分月签订金额统计
		report3.length > 0 && (report3.jqGrid({
	    	url:"getMonthlySignedAmountOfLed",
	    	mtype:"GET",
	    	datatype:"json",
	    	colNames:['屏幕','1月','2月','3月','4月','5月','6月','7月','8月','9月','10月','11月','12月','合计'],
	    	shrinkToFit:true,
	    	height:360,
	    	width:800,
	    	rowNum:10,
	    	rowList: [10, 20, 30],
       		pager: "jqgrid-pager_report3",
       		multiselect:!1,
       		sortname:"y.led.ledId",
       		sortorder: "desc",
       		viewrecords: !0,
       		colModel:[{
       			name:"y.led.ledName",
       			index:"y.led.ledName",
       	//		sortable: !1,
       			align:"center",
       	 		width:"120px"    		
       		},{
       			name:"Jan",
       			index:"Jan",
       			align:"center",
       			width:"100px"
       		},{
       			name:"Feb",
       			index:"Feb",
       			align:"center",
       			width:"100px"
       		},{
       			name:"Mar",
       			index:"Mar",
       			align:"center",
       			width:"100px"
       		},{
       			name:"Apr",
       			index:"Apr",
       			align:"center",
       			width:"100px"
       		},{
       			name:"May",
       			index:"May",
       			align:"center",
       			width:"100px"
       		},{
       			name:"Jun",
       			index:"Jun",
       			align:"center",
       			width:"100px"
       		},{
       			name:"Jul",
       			index:"Jul",
       			align:"center",
       			width:"100px"
       		},{
       			name:"Aug",
       			index:"Aug",
       			align:"center",
       			width:"100px"
       		},{
       			name:"Sept",
       			index:"Sept",
       			align:"center",
       			width:"100px"
       		},{
       			name:"Oct",
       			index:"Oct",
       			align:"center",
       			width:"100px"
       		},{
       			name:"Nov",
       			index:"Nov",
       			align:"center",
       			width:"100px"
       		},{
       			name:"Dec",
       			index:"Dec",
       			align:"center",
       			width:"100px"
       		},{
       			name:"total",
       			index:"total",
       			align:"center",
       			width:"100px"
       		}],
       		postData:{
       			year: $("select#year").val()
       		},
       		//gridComplete: function(data){},
       		loadComplete: function(data){
       			var rowNum = report3.getGridParam("reccount");
       			var colModel = report3.jqGrid('getGridParam','colModel');
       			for(var i = 1; i <= rowNum; i++) {
       				var led = report3.jqGrid('getCell', i, "y.led.ledName");
       				console.log(led);
       				for(var j = 1; j <= 12; j++) {
       					var val = report3.jqGrid('getCell', i, colModel[j].name);
       					var newVal = "<span onclick=query(" + j + ",'" + led + "')>" + val + "</span>";
       					report3.jqGrid('setCell', i, colModel[j].name, newVal);
       				}
       			}
       		}
	    }), e_report3(), report3.length > 0 && report3.jqGrid("navGrid","#jqgrid-pager_report3",{
	    	add:!1,
	    	edit:!1,
	    	del:!1,
	    	view:!1,
	    	search: !1,
       		refresh:0
	    },{},{},{},{
	    	multipleSearch: true,
	    	multipleGroup:true
	    }))
	    $(window).resize(e_report3);
				
	});

	function AnnualLedSumSelect(){
		var t_EveryLed_sum= $("#jqgrid_EveryLed_sum");
		annualLedSum=$.trim($("#annualLedSum").val());
//		alert(annualYeji);
		redrawReport(annualLedSum);
		t_EveryLed_sum[0].p.search = true;
		$.extend(t_EveryLed_sum[0].p.postData,{annualLedSum:annualLedSum,searchString:"",searchField:"allfieldsearch",searchOper:"cn"});
		$.extend($("#jqgrid_report3")[0].p.postData, {year: $("select#year").val()});
		t_EveryLed_sum.trigger("reloadGrid",[{page:1,current:true}]);
		$("#jqgrid_report3").trigger("reloadGrid",[{page:1,current:true}]);
		return false;
	}
	
	$(function(){
		AnnualLedSumSelect();
		changeViewOfReport();
	});
	
	//模糊搜索
    $("#searchText2").keypress(function(event){
    	if(event.keyCode == "13"){
    		$("#searchButton2").click();
    	}
    });
	    
	$("#searchButton2").click(function(){
		var searchFilter = $("#searchText2").val();
	   	if(searchFilter.length !== 0){
	   		t_EveryLed_sum[0].p.search = false; 
	   		$.extend(t_EveryLed_sum[0].p.postData,{searchString:"",searchField:"",searchOper:""});
	    	searchFilter = " and y.state!='D' and "+" ( y.led.ledName like '%"+searchFilter+"%' )";
	   		console.log(searchFilter);
	   		t_EveryLed_sum[0].p.search = true;
	   		$.extend(t_EveryLed_sum[0].p.postData,{searchString:searchFilter,searchField:"allfieldsearch",searchOper:"cn"});
	   	}
	   	t_EveryLed_sum.trigger("reloadGrid",[{page:1,current:true}]);
	});
	    
	  //导出报表功能
	$("#exportExcel2").click(function(){
		$("#jqgrid_EveryLed_sum").jqGrid('excelExport',{url:'ledSumListExport.action'})
	});
	
	function redrawReport(obj) {
		$.ajax({
	         type : "post",
	         url : "annualLedAmountReportAno.action",    //请求发送到后台
	         data : {annualLedSum:obj,_search:true},
	         dataType : "json",        //返回数据形式为json
	         success : function(result) {
	        	
	        	 //请求成功时执行该函数内容，result即为服务器返回的json对象

	        	 myChart.setOption({
		      		    title : {
		      		        text: '全年各屏幕签订金额',
		      		        subtext: '按签订金额大小排序',
		      		        x:'center'
		      		    },
		      		    tooltip : {
		      		        trigger: 'item',
		      		    }, 	
		      		    legend: {
		      		        orient : 'vertical',
		      		        x : 'left',
		      		       data:  result.legend
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
		      		            name:'屏幕排名及签订金额',
		      		            type:'pie',
		      		            radius : '55%',
		      		            center: ['50%', '60%'],
		      		          	data:result.series,//json 格式為{led:南都樓頂,zpl:11.56;...}
		      		        }
		      		    ]
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
			
	myChart.on('click', function (param) {
    	var index = param.name;
    	var idxarr = index.split(" ");
    	if(idxarr.length>1){
    		index = idxarr[1];
    	}
    	var startTime = $("#annualLedSum").val()+"-01-01";
    	var endTime = $("#annualLedSum").val()+"-12-31";
    	$("#modaltable>tbody").html("");
    	$("#modaltitle").html(index+" 客户分布情况");
    	$.ajax({
	  		type:"post",
	  		dataType:"json",
	  		url:"getInfo4PieModal.action",
	  		data : {led:index,startTime:startTime,endTime:endTime},
	  		success:function(data){ 	
	  			var datas = eval(data.info);
	  			for(var i = 0,length=datas.length;i<length;i++){
		    		var jsonobject = datas[i];
			    	$("#modaltable>tbody").append("<tr><td>"+jsonobject.client+"</td><td>"+jsonobject.publishprice+"</td><td>"+jsonobject.date+"</td><td>"+jsonobject.employee+"</td></tr>");
		    	}

		    	openModal();
	  		}
	  });
 }); 
			
			//$(function(){});函数是$(document).ready(function(){});函数的简写
/* 			$(function(){
				$("#tabs").tabs();
				AnnualIndustrySelectClick();
				changeViewOfReport();
				changeViewOfReport1();

			});
			 */
			 
		function openModal(){
			$("#file_modal_id").modal({backdrop:'static'});
			$("#file_modal_id").modal('show');
		}

	</script> 
	</content>