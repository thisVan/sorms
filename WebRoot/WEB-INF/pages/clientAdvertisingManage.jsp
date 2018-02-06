<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
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
<script src="js/jquery-1.8.3.min.js"></script>
<script src="js/lumino.glyphs.js"></script>
<script src="js/bootstrap-select.js"></script>

<!-- CSS Files for createAreaChart.html-->
<link type="text/css" href="css/base.css" rel="stylesheet">
</head>
<body>
<div class="main">
	<div class="modal fade" id="modalAdverInfo">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
					<h4 class="modal-title text-muted" id="modalTitle"></h4>
				</div>
				<button type="button" id="exportReport" class="btn btn-primary btn-sm">导出报表</button>
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
	<div class="row">
		<div class="col-lg-12">
			<h3 class="page-header">客户投放管理</h3>
		</div>
	</div>
	<!--/.row-->
	<div class="row">
		<div class="col-1g-12">

					<div class="row" class="col-sm-12" id="tabs">
						<ul class="nav nav-pills">
							<li id="clientAdverAmountDist" class="active" onclick="tab('#tab1')"><a href="#tab1" data-toggle="tab">客户投放金额分布</a></li>
							<li id="clientAdverDetail" class="" onclick="tab('#tab2')"><a href="#tab2" data-toggle="tab">客户投放明细</a></li>
							<li id="clientAdverLedDist" class="" onclick="tab('#tab3')"><a href="#tab3" data-toggle="tab">客户投放屏幕分布</a></li>
						</ul>
					</div>
						
					<div class="row" class="col-sm-12" id="jqgrid-wrapper">
						<div class="form-horizontal" role="form"  id="exactForm">
							<fieldset id="queryConditions">
								<legend>查询条件</legend>
								<div class="col-sm-4">
									<div class="input-group input-group-sm" >
										<div class="input-group-addon">时间段</div>
										<input type="text" id="daterange-default" name="timeRange" value="" class="form-control">
										<span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
									</div>
								</div>
								<div id="divClients" class="col-sm-4">
									<div class="input-group input-group-sm">
										<div class="input-group-addon">刊户</div>
										<select name="client" id="client"
											class="form-control selectpicker" data-live-search="true">
											<option value="">--请选择刊户--</option>
										</select>
									</div>
								</div>
								<div id="divLeds" class="col-sm-3">
										<div class="input-group input-group-sm">
											<div class="input-group-addon">屏幕</div>				
											<select  name="led" id="led" class="form-control">	
											    <option value="">所有屏幕</option>			
											</select>
										</div>
								</div>
								<div id="divIndustry" class="col-sm-3">
									<div class="input-group input-group-sm">
										<div class="input-group-addon">行业</div>
										<select name="industry" id="industry"
											class="form-control selectpicker" data-live-search="true">
											<option value="">所有行业</option>
										</select>
									</div>
								</div>
								<div class="col-sm-2">	
									<button class="btn btn-primary btn-sm" id="exactQuery">查询</button>
									<button class="btn btn-danger btn-sm" id="clearExactForm">清除</button>
								</div>
							</fieldset>
						</div>
				
					</div>
						
					<div id="tab1">
						<div class="col-sm-8">		
							<div id = "pieChart" style = "width: 100%; height: 600px; overflow: visible"></div>
						</div>
						<div class="col-sm-4">
							<span class="h4"><b>客户投放排名</b></span><br><br>
							<div id="ranking"></div>
						</div>
					</div>
					
					<div id="tab2">
						<div class="row">
							<table id="jqgrid" class="table table-striped table-hover table-bordered" style="border-collapse: collapse"></table>
							<div id="jqgrid-pager"></div>
						</div>
					</div>
					
					<div id="tab3">
						<div class="row">
							<table id="jqgrid2" class="table table-striped table-hover table-bordered" style="border-collapse: collapse"></table>
							<div id="jqgrid-pager2"></div>
						</div>
					</div>
					
		</div>
		<!-- /.col-->
	</div>
	<!-- /.row -->
<!--/.main-->
	<div class="modal fade" id="modalAdverLedDist">
		<div class="modal-dialog ">
			<div class="modal-content">
				<div class="modal-header h4">客户投放屏幕分布情况</div>
				<div class="modal-body " style="text-align:center">
					<div id = "pieChartAdverLedDist" style = "width: 500px; height: 400px; overflow: visible"></div>
				</div>
				<!-- <div class="modal-footer">
					<button id="editOrder-ok" class="btn btn-success"><i class="fa fa-check-circle"></i>确认</button>
					<button class="btn btn-danger" data-dismiss="modal"><i class="fa fa-times-circle"></i>取消</button>
				</div> -->
			</div><!-- /.modal-content -->
		</div><!-- /.modal-dialog -->
	</div><!-- /.modal -->
	
</div>	
<script src="js/bootstrap.min.js"></script>
<%-- <script src="js/jquery.table2excel.min.js"></script> --%>
</body>
</html>
<content tag="scripts">
	<script src="js/jquery.ba-bbq.min.js"></script>
	<script src="js/grid.history.js"></script>
	<script	src="js/grid.locale-cn.js"></script>
	<script>$.jgrid.useJSON = true;</script>
	<script src="js/jqGrid4.4.3/jquery.jqGrid.src.js"></script>
	<script	src="js/jquery.jqGrid.fluid.js"></script>
	<script	src="js/jqGrid4.4.3/plugins/grid.setcolumns.js"></script>
	<script	src="js/jqGrid4.4.3/plugins/grid.jqueryui.js"></script>
	<script src="js/king-common.js"></script>
	<script src="js/moment.js"></script>
	<script src="js/daterangepicker.js"></script>
	<script src="js/echarts.min.js"></script>
	<script language="javascript" type="text/javascript" src="js/jit.js"></script>
	<script>
		var pieChart = echarts.init(document.getElementById('pieChart'));
		var pieChartAdverLedDist = echarts.init(document.getElementById('pieChartAdverLedDist'));
		var result = [];
		var result2 = [];
		var jsonObj, number; //jsonObj用于模态框中展示数据，number用于判断数据否完整显示
		var startTime = endTime = "";
		var table = $("#jqgrid");
		var table2 = $("#jqgrid2");
		function daysFormatter(cellvalue, options, rowObject){  
		    return cellvalue + "天";  
		}
		function freqFormatter(cellvalue, options, rowObject){  
		    return cellvalue + "次/天";  
		}
		function durationFormatter(cellvalue, options, rowObject){  
		    return cellvalue + "秒";  
		}
		function tab(pid) {
			var tabs=["#tab1","#tab2","#tab3"];
			for(var i = 0; i < 3; i++){
				if(tabs[i] == pid){
			    	$("div" + tabs[i]).show();
			  	} else{
			    	$("div" + tabs[i]).hide();
			  	}
			}
			if(pid == tabs[2]) {
				$("#exactQuery").off("click");
				$("#exactQuery").click(doTab3Query);
				$("fieldset#queryConditions div#divClients").show();
				$("fieldset#queryConditions div#divLeds").hide();
				$("fieldset#queryConditions div#divIndustry").hide();
			} else {
				$("#exactQuery").off("click");
				$("#exactQuery").click(doTab12Query);
				$("fieldset#queryConditions div#divClients").hide();
				$("fieldset#queryConditions div#divLeds").show();
				$("fieldset#queryConditions div#divIndustry").show();
			}
		}
		
		//导出报表
		function exportExcel(param){
			/* $("#modalAdverInfo").modal("hide");
			$("#adverDetail").addClass("active");
			$("#adverManage").removeClass("active");
			$("#adverDetail").click();
			document.getElementById("tab1").style.display="none";
			document.getElementById("tab2").style.display="block";	 */
			$("#modalTable").table2excel({
			    exclude: ".excludeThisClass",
			    fileext: ".xls",
			    name: "sheet1",
			    filename: "客户投放明细-" + param,
			});
		}
		
		function doTab12Query() {
			$.ajax({  
			   type: "GET",
			   url: "getAdverInfo",
			   data: {startTime: startTime, endTime: endTime, led: $("#led").val(), industry: $("#industry").val()},
			   dataType: "json",
			   success: function(data){
			   		//alert("success");
			   		$("#ranking").empty();
			   		if(data.res.length != 0) {
			   			for(var i = 1; i <= 5 && i <= data.res.length; i++) {
			   				$("#ranking").append("<p>" + i + ".&nbsp&nbsp" + data.res[i-1].client + "</p>");
			   			}
			   		}
			   		jsonObj = data;
			   }
			}),
			
			$.ajax({  
			   type: "GET",//请求方式  
			   url: "getClientAdverManageChartStat",//地址，就是action请求路径  
			   data: {startTime: startTime, endTime: endTime, led: $("#led").val(), industry: $("#industry").val()},
			   dataType: "json",//数据类型text xml json  script  jsonp  
			   success: function(data){//返回的参数就是 action里面所有的有get和set方法的参数  
			       //alert("success");
			       console.log(data.res);
			       console.log(data.res.length);
			       console.log(data.res[0].level);
			       console.log(data.res[0].number);
			       result = [];
			       for(var i = 0; i < data.res.length; i++) {
				       	result.push({
							name: data.res[i].level,
	                     	value: data.res[i].number
	                    });
			       }
			       console.log("name:" + result[1].name);
			       console.log("value:" + result[1].value);
			       pieChart.setOption({
			       		series: [{
		   		          	data: result
     		    			}],
     		    			legend: {
     		       				data: result
     		    			}
			       })
			       return false;
			   },
			   error: function(msg) {
			   	alert("error");
			   }
			}); 
			
			$.extend(table[0].p.postData,{startTime: startTime, endTime: endTime, led: $("#led").val(), industry: $("#industry").val()});
			table.trigger("reloadGrid",[{page:1,current:true}]);
			//alert("done");
		}
		
		function doTab3Query() {
			table2.length > 0 && (table2.jqGrid({
		    	url:"getClientAdverDist",
		    	mtype:"GET",
		    	datatype:"JSON",
		    	caption: "客户投放屏幕分布",
		    	colNames:['广告刊户','认刊书数量','投放总金额','投放屏幕分布'],
		    	shrinkToFit: true,
		    	height:400,
		    	rowNum:<s:property value="@com.nfledmedia.sorm.cons.CommonConstant@DEFAULT_PAGE_SIZE"/>,
		    	rowList: [10, 20, 30],
        		pager: "jqgrid-pager2",
        		multiselect:!1,
        		sortorder: "asc",
        		viewrecords: !0,
        		colModel:[{
        			name: "client",
        			index: "client",
        			align: "center",
        	 		width: "30%"
        		},{
        			name: "numberOfContract",
        			index: "numberOfContract",
        			align: "center",
        			width: "15%"
        		},{
        			name: "totalAmount",
        			index: "totalAmount",
        			align: "center",
        			width: "25%" 
        		},{
        			name: "viewLedDist",
        			index: "viewLedDist",
        			align: "center",
        			width: "25%" 
        		}],
        		loadComplete: function (data) {
        			for(var i = 1; i <= data.rows.length; i++){
       			    	table2.jqGrid("setCell", i, 3, "<div class='btn btn-info btn-xs' onclick=viewLedDist('" + data.rows[i-1].cell[0] + "')>查看</div>");
       			    }
       			},
		    }), e(), table2.length > 0 && table2.jqGrid("navGrid","#jqgrid-pager2",{
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
		    
		    $.extend(table2[0].p.postData,{startTime: startTime, endTime: endTime, kanhu: $("select#client").val()});
			table2.trigger("reloadGrid",[{page:1,current:true}]);
		}
		
		$("#tab2").hide();
		$("#tab3").hide();
		$("fieldset#queryConditions div#divClients").hide();
			
		pieChart.on('click', function(param) {
	    	var index = param.name;
	    	//alert(index);
	    	var title = index + "客户投放明细";
	    	for(var i = 0; i < result.length; i++ ){
	    		if(result[i].name == index) {
	    			if(result[i].value > 15) {
	    				title += "(未完整显示)";
	    			}
	    		}
	    	}
	    	//console.log(jsonObj.res.length);
	    	$("#modalTitle").html(title);
	    	$("#modalTable>tbody").empty();
	    	$("#modalTable>tbody").append("<th>刊户</th><th>投放金额</th><th>投放次数</th><th>最近投放时间</th>")
	    	$("#exportReport").attr("onclick", "exportExcel('" + index + "')");
	    	var count = 0;	//control the number of items displayed. 
	    	for(var i = 0; i < jsonObj.res.length; i++){
	    		if(jsonObj.res[i].level == index){
	    			if(count <= 15) {
	    				$("#modalTable>tbody").append("<tr><td>"+jsonObj.res[i].client+"</td><td>"+jsonObj.res[i].amount+"</td><td>"+jsonObj.res[i].adverNum+"</td><td>"+jsonObj.res[i].lastAdverTime+"</td></tr>");
	    			} else {
	    				$("#modalTable>tbody").append("<tr class='hidden'><td>"+jsonObj.res[i].client+"</td><td>"+jsonObj.res[i].amount+"</td><td>"+jsonObj.res[i].adverNum+"</td><td>"+jsonObj.res[i].lastAdverTime+"</td></tr>");
	    			}
		    		count++;
		    	}
	    	}
	    	
	    	openModal(); 
		});
		
		function openModal() {
	    	$("#modalAdverInfo").modal('show');
		}
		
		function e() {
	        $("#jqgrid2").length > 0 && table2.fluidGrid({
	            base: "#jqgrid-wrapper",
	            offset: 0
	        })
	    }
	    
	    function viewLedDist(client) {
	    	$.ajax({
				type:"post",
				dataType:"json",
				url:"getAdverLedDistChart",
				data: {startTime: startTime, endTime: endTime, kanhu: client},
				success:function(data){
					result2 = [];
					var i = 0;
					for(; i < 10 && i < data.res.length; i++) {
						if(data.res[i].amount == 0)
							continue;
				       	result2.push({
							name: data.res[i].led,
	                     	value: data.res[i].amount
	                    });
			    	}
			    	if(data.res.length > 10 && data.res[i + 1].amount > 0) {
			    		var rest = 0;
			    		for(; i < data.res.length; i++) {
			    			rest += data.res[i].amount;
			    		}
			    		result2.push({
							name: "其他",
	                     	value: rest
		                });
			    	}
			    	
					pieChartAdverLedDist.setOption({
						title : {
		      		        text: "——" + client,
		      		        x:"left"
		      			},
			       		series: [{
		   		          	data: result2
     		    		}],
     		    		legend: {
     		       			data: result2
     		    		}
			       })
				}
			});
	    	$("#modalAdverLedDist").modal('show');
	    }

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
				startTime = endTime = "";
			});
			$('#daterange-default').on('apply.daterangepicker', function(ev, picker) {
				console.log("start:"+picker.startDate.format('YYYY-MM-DD')+"\nend:"+picker.endDate.format('YYYY-MM-DD'));
				startTime=""+picker.startDate.format('YYYY-MM-DD');
				endTime=""+picker.endDate.format('YYYY-MM-DD');
			});
			
			loadOptions();	//加载下拉菜单的内容
			
			pieChart.setOption({
	      		title : {
	      			text: "客户投放情况",
      		        subtext: "",
      		        x:"center"
      			},
      		    tooltip : {
      		        trigger: "item",
      		        formatter: "{a} <br/>{b} : {c}个 ({d}%)"
      		    },
      		    legend: {
      		        orient: "horizontal",
      		        top: "10%",
      		       	data: result
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
      		    series: [{
      		    	name:"客户投放金额",
   		            type:'pie',
   		            radius : '55%',
   		            center: ['50%', '50%'],
   		          	data: result
      		    }]
      		});
      		
      		pieChartAdverLedDist.setOption({
	      		/*title : {
	      			text: "客户投放屏幕分布情况",
      		        subtext: "",
      		        x:"center" 
      			}, */
      		    tooltip : {
      		        trigger: "item",
      		        formatter: "{a} <br/>{b} : {c}元 ({d}%)"
      		    },
      		    legend: {
      		        orient: "horizontal",
      		        top: "10%",
      		       	data: result2
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
      		            restore: {show: true},
      		            saveAsImage: {show: true}
      		        }
      		    },
      		    calculable: true,
      		    series: [{
      		    	name:"客户投放金额",
   		            type:'pie',
   		            radius : '55%',
   		            center: ['50%', '60%'],
   		          	data: result2
      		    }]
      		});
      		
      		
      		
		    table.length > 0 && (table.jqGrid({
		    	url:"getAdverDetail",
		    	mtype:"GET",
		    	datatype:"JSON",
		    	colNames:['广告刊户','签订日期','投放点位','开始时间','结束时间','投放时长','播放频次','广告时长','屏签订金额','刊例总价'],
//		    	shrinkToFit: false,
		    	height:400,
		    	rowNum:<s:property value="@com.nfledmedia.sorm.cons.CommonConstant@DEFAULT_PAGE_SIZE"/>,
		    	rowList: [10, 20, 30],
        		pager: "jqgrid-pager",
        		multiselect:!1,
        		//sortname:"shichang",
        		sortorder: "asc",
        		viewrecords: !0,
        		colModel:[{
        			name: "client",
        			index: "client",
        			align: "center",
        	 		width: "160px"
        		},{
        			name: "signDate",
        			index: "signDate",
        			align: "center",
        			width: "100px"
        		},{
        			name: "led",
        			index: "led",
        			align: "center",
        			width: "100px" 
        		},{
        			name: "startTime",
        			index: "startTime",
        			align: "center",
        			width: "100px",
        		},{
        			name: "endTime",
        			index: "endTime",
        			align: "center",
        			width: "100px" 
        		},{
        			name: "adverDuration",
        			index: "adverDuration",
        			align: "center",
        			width: "60px",
        			formatter: daysFormatter   				
        		},{
        			name: "freq",
        			index: "freq",
        			align: "center",
        			width: "100px",
        			formatter: freqFormatter
        		},{
        			name: "playDuration",
        			index: "playDuration",
        			align: "center",
        			width: "80px",
        			formatter: durationFormatter
        		},{
        			name: "orderPrice",
        			index: "orderPrice",
        			align: "center",
        			width: "120px",
        			formatter: "currency",
        			formatoptions:{suffix: '元'}
        		},{
        			name: "casePrice",
        			index: "casePrice",
        			align: "center",
        			width: "120px",
        			formatter: "currency",
        			formatoptions:{suffix: '元'}
        		}],
        		//记录
        		/* loadComplete: function (data) {
        			chartData = data.rows;
        			records = data.records;
        			//alert(chartData[0].cell[2]);
        			
					load(data);
             		console.log(data.rows);
             		console.log(data.rows[0].cell[2])//为所有数据行，具体取决于reader配置的root或者服务器返回的内容
         		}, */
        		
				/* gridComplete: function(data){

        		} */
		    }), e(), table.length > 0 && table.jqGrid("navGrid","#jqgrid-pager",{
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
		});

		$("#clearExactForm").click(function(){
			$('#daterange-default').val('');
			startTime = endTime = "";
			document.getElementById("led").options[0].selected = true;
			document.getElementById("industry").options[0].selected = true;
			return false;
		});
		
		$("#exactQuery").click(doTab12Query);

		function loadOptions(){	//加载屏幕列表与行业列表
			//加载屏幕列表
			$.ajax({
				type:"post",
				dataType:"json",
				url:"getAllLed",
				success:function(data){
					var jsonData = data.info;
					for(var i = 0, n = jsonData.length; i < n; i++){
						$("#led").append("<option value='"+jsonData[i][1]+"'>"+jsonData[i][1]+"</option>");
					}
				}
			});	
			
			//可自行输入的下拉选择框数据获取（数据首先存入跳转页面的action中）,不能和普通的下拉框一样获取数据
			//加载行业列表
			$("select#industry").append("<s:iterator value="#request.industries">");
			$("select#industry").append("<option value='<s:property value="[0].top[1]"/>'><s:property value="[0].top[1]"/></option>");
			$("select#industry").append("</s:iterator>");
			//加载刊户列表
			$("select#client").append("<s:iterator value="#request.clients">");
			$("select#client").append("<option value='<s:property value="[0].top[1]"/>'><s:property value="[0].top[1]"/></option>");
			$("select#client").append("</s:iterator>");
		}
	</script>
</content>