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
<link rel="stylesheet" type="text/css" media="screen" href="css/jqGrid4.4.3/ui.jqgrid.css" />
<link rel="stylesheet" type="text/css" media="screen" href="css/jqGrid4.4.3/ui.jqgrid.css" />

<link href="css/main.css" rel="stylesheet">

<!--Icons-->
<script src="js/lumino.glyphs.js"></script>
<script src="js/jqGrid4.4.3/jquery-1.7.2.min.js"></script>
<script src="js/echarts.min.js"></script>
<script type="text/javascript">
function mouseOver(obj)
{

    obj.style.color = "#1A94E6";
}

</script>
</head>
<body style="font-family: '微软雅黑';">

	<div class="main">
		<form class="form-horizontal" role="form" action="upOrderPage"
			id="upOrderForm">
			<div class="input-group input-group-sm">
				<input type="text" class="hidden" name="upOrder_id" id="upOrder_id">
			</div>
		</form>

		<!--/.row-->

		<div class="row">
			<div class="col-lg-12">
				<h3 class="page-header">年度分行业数据统计</h3>
			</div>
		</div>
		<!--/.row-->
		
		<div class="row">
			<div class="col-1g-12">
			 <div class="span6">
				<ul class="nav nav-tabs">
					<li><a href="hangyestatistic.action" onmouseover="mouseOver(this)">行业投放分布</a></li>
					<li class="active"><a href="annualIndustryReport.action">行业年度统计</a></li>
					<li><a href="yejistatistic.action" onmouseover="mouseOver(this)">行业投放明细</a></li>
				</ul>
			 </div>
			</div>
			<!-- /.col-->
		</div>

	<div class="row">

		   <div class="tabs" id="tabs">
				<ul class="nav nav-pills">
					<li class="active"><a href="#tab1" data-toggle="tab">年度占屏率</a></li>
					<li><a href="#tab2" data-toggle="tab">年度签单金额</a></li>
				</ul>

			<div class="col-lg-12" ><label> </label></div>
			
			<div id="tab1" class="tab-pane fade in active">
				<div class="row">
					<div class="col-sm-2">
						<div class="input-group input-group-sm">
							<div class="input-group-addon">年度</div>
							<select name="annualIndustry" id="annualIndustry"
								class="form-control" onchange="AnnualIndustrySelectClick()">
								<option value="2015">2015</option>
								<option value="2016" selected="selected">2016</option>
								<option value="2017">2017</option>
								<option value="2018">2018</option>
								<option value="2019">2019</option>
								<option value="2020">2020</option>
							</select>
						</div>
					</div>

					<!-- <div class="col-sm-2">
				<button class="btn btn-primary btn-sm" id="exactQuery1">查询</button>
			    </div> -->
					<%-- <div class="col-sm-3 pull-right">
					<div id="fuzzySearchbox" class="input-group input-group-sm searchbox">
						<input type="search" id="searchText1-1" class="form-control" placeholder="请输入关键字...">
						<span class="input-group-btn">
							<button class="btn btn-default" type="button" id="searchButton1-1">搜索</button>
						</span>
					</div>
				</div> --%>
					<div class="col-sm-12">
						<lable>&nbsp;</lable>
					</div>
				</div>
				<div class="row">
					<div class="col-sm-10">
						<lable>
						<h4>
							<b>行业年度占屏率统计报表(%)</b>
						</h4>
						</lable>
					</div>
					<div class="col-sm-1">
						<button class="btn btn-primary btn-sm" id="changeReport" onclick="changeViewOfReport()">切换视图</button>
					</div>
					<div class="col-sm-1">
						<button class="btn btn-primary btn-sm" id="exportExcel1-1">导出报表</button>
					</div>
				</div>
				
				<div id="report2" style="width:100%;" >
				<div id="mainpie" style="width: 100%;height:600px;overflow: visible"></div>
				</div>
				
				<div id="report1" class="row" >
				<div id="jqgrid-wrapper_industry_annual_sort">
					<table id="jqgrid_industry_annual_sort"
						class="table table-striped table-hover table-bordered"></table>
					<div id="jqgrid-pager_industry_annual_sort"></div>
				</div>
				</div>
				
				<div class="col-sm-12">
					<lable>&nbsp;</lable>
				</div>

			</div>
			
			<div id="tab2" class="tab-pane fade">
				<div class="row">
					<div class="col-sm-2">
						<div class="input-group input-group-sm">
							<div class="input-group-addon">年度</div>
							<select name="annualIndustry1" id="annualIndustry1"
								class="form-control" onchange="AnnualIndustrySelectClick()">
								<option value="2015">2015</option>
								<option value="2016" selected="selected">2016</option>
								<option value="2017">2017</option>
								<option value="2018">2018</option>
								<option value="2019">2019</option>
								<option value="2020">2020</option>
							</select>
						</div>
					</div>

					<!-- <div class="col-sm-2">
				<button class="btn btn-primary btn-sm" id="exactQuery1">查询</button>
			    </div> -->
					<%-- <div class="col-sm-3 pull-right">
					<div id="fuzzySearchbox" class="input-group input-group-sm searchbox">
						<input type="search" id="searchText1-1" class="form-control" placeholder="请输入关键字...">
						<span class="input-group-btn">
							<button class="btn btn-default" type="button" id="searchButton1-1">搜索</button>
						</span>
					</div>
				</div> --%>
					<div class="col-sm-12">
						<lable>&nbsp;</lable>
					</div>
				</div>
				
				<div class="row">
					<div class="col-sm-10">
						<lable>
						<h4>
							<b>行业年度金额统计报表</b>
						</h4>
						</lable>
					</div>
					<div class="col-sm-1">
						<button class="btn btn-primary btn-sm" id="changeReport" onclick="changeViewOfReport1()">切换视图</button>
					</div>
					<div class="col-sm-1">
						<button class="btn btn-primary btn-sm" id="exportExcel1-2">导出报表</button>
					</div>
				</div>
				
				<div id="report3" >
				<div id="mainpie2" style="width: 100%;height:600px;overflow: visible"></div>
				</div>
				
				<div id="report4" class="row" >
				<div id="jqgrid-wrapper_industry_annual_sort2">
					<table id="jqgrid_industry_annual_sort2"
						class="table table-striped table-hover table-bordered"></table>
					<div id="jqgrid-pager_industry_annual_sort2"></div>
				</div>
				</div>
				
				
				
			</div>

		</div>
	
	


	<!--/.row-->
	</div>
	<!--/.main-->
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
</div>
	<script src="js/jquery-1.8.3.min.js"></script>
	<script src="js/jquery-ui.js"></script>
	<script src="js/bootstrap.min.js"></script>
	<script src="js/bootstrap-select.js"></script>
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
		var myChart2 = echarts.init(document.getElementById('mainpie2'));
		
		function query(month, industry){
			$.ajax({
				type: "post",
				url: "getAnnualIndustryReportDetail",
				data: {year: $("select#annualIndustry").val(), month: month, industry: industry},
				dataType: "json",
				success: function(data) {
		        	var style = " style='text-align: center'";
					$("#modalTable>tbody").empty();
		 	    	$("#modalTable>tbody").append("<th"+style+">上画屏幕</th><th"+style+">刊户</th><th"+style+">类型</th><th"+style+">签订日期</th><th"+style+">屏签订金额（元）</th>");
		 	    	var count = 0;
		 	    	for(var i = 0; i < data.res.length; i++){
		    			if(count <= 15) {
		    				$("#modalTable>tbody").append("<tr><td>"+data.res[i].led+"</td><td>"+data.res[i].client+"</td><td>"+data.res[i].type+"</td><td>"+data.res[i].time+"</td><td>"+data.res[i].price+"</td></tr>");
		    			} else {
		    				$("#modalTable>tbody").append("<tr class='hidden'><td>"+data.res[i].led+"</td><td>"+data.res[i].client+"</td><td>"+data.res[i].type+"</td><td>"+data.res[i].time+"</td><td>"+data.res[i].price+"</td></tr>");
		    			}
			    		count++;
			    	}
		         },
		         error: function(errorMsg) {
		         	alert("错误!");
		         }
			})
			$("#modal_detail").modal('show');
		}
		
		 $(document).ready(function(){
				function e_industry_annual_sort() {
			        $("#jqgrid_industry_annual_sort").length > 0 && t_industry_annual_sort.fluidGrid({
			            base: "#jqgrid-wrapper_industry_annual_sort",
			            offset: 0
			        })
			    } 
				    var t_industry_annual_sort= $("#jqgrid_industry_annual_sort");
				    $("#jqgrid_industry_annual_sort").length > 0 && (t_industry_annual_sort.jqGrid({
				    	url:"getTop10_annual_Led_Occupy.action",
				    	mtype:"GET",
				    	datatype:"json",
				    	colNames:['行业','1月','2月','3月','4月','5月','6月','7月','8月','9月','10月','11月','12月','合计'],
				    	shrinkToFit:false,
				    	height:350,
				    	rowNum:10,
				    	rowList: [10, 20, 30],
		        		pager: "jqgrid-pager_industry_annual_sort",
		        		multiselect:!1,
		        		sortname:"renkanshu.qiandingriqi",
		        		sortorder: "asc",
		        		viewrecords: !0,
		        		colModel:[{
		        			name:"goalYwy.ywyXingming",
		        			index:"goalYwy.ywyXingming",
		        			sortable: !1,
		        			align:"center",
		        	 		width:"110px",
							//formatter: formatQuery
		        		},{
		        			name:"Jan",
		        			sortable: !1,
		        			align:"center",
		        	 		width:"70px"
		        		},{
		        			name:"Feb",
		        			sortable: !1,
		        			align:"center",
		        			width:"70px" 
		        		},{
		        			name:"Mar",
		        			sortable: !1,
		        			align:"center",
		        			width:"70px"
		        		},{
		        			name:"Apr",
		        			sortable: !1,
		        			align:"center",
		        			width:"70px"
		        		},{
		        			name:"May",
		        			sortable: !1,
		        			align:"center",
		        			width:"70px"       			
		        		},{
		        			name:"Jun",
		        			sortable: !1,
		        			align:"center",
		        			width:"70px" 
		        		},{
		        			name:"Jul",
		        			sortable: !1,
		        			align:"center",
		        			width:"70px"
		        		},{
		        			name:"Aug",
		        			sortable: !1,
		        			align:"center",
		        			width:"70px"
		        		},{
		        			name:"Sep",
		        			sortable: !1,
		        			align:"center",
		        			width:"70px" 
		        		},{
		        			name:"Oct",
		        			sortable: !1,
		        			align:"center",
		        			width:"70px" 
		        		},{
		        			name:"Nov",
		        			sortable: !1,
		        			align:"center",
		        			width:"70px" 
		        		},{
		        			name:"Dec",
		        			sortable: !1,
		        			align:"center",
		        			width:"70px"
		        		},{
		        			name:"total",
		        			sortable: !1,
		        			align:"center",
		        			width:"80px"
		        		}],
		        		loadComplete: function(data) {
		        			var rowNum = $("#jqgrid_industry_annual_sort").getGridParam("reccount");
		        			var colModel = $("#jqgrid_industry_annual_sort").jqGrid('getGridParam','colModel');
		        			for(var i = 1; i <= rowNum; i++) {
		        				var industry = $("#jqgrid_industry_annual_sort").jqGrid('getCell', i, "goalYwy.ywyXingming");
		        				console.log(industry);
		        				for(var j = 1; j < 13; j++) {
		        					var val = $("#jqgrid_industry_annual_sort").jqGrid('getCell', i, colModel[j].name);
		        					var newVal = "<span onclick=query(" + j + ",'" + industry + "')>" + val + "</span>";
		        					$("#jqgrid_industry_annual_sort").jqGrid('setCell', i, colModel[j].name, newVal);
		        				}
		        			}
		        		}
				    }), e_industry_annual_sort(), $("#jqgrid_industry_annual_sort").length > 0 && t_industry_annual_sort.jqGrid("navGrid","#jqgrid-pager_industry_annual_sort",{
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
				    $(window).resize(e_industry_annual_sort);	
					    
					    
					  //导出报表功能
						$("#exportExcel1-1").click(function(){
							$("#jqgrid_industry_annual_sort").jqGrid('excelExport',{url:'industryAnnualOccupyExport.action'})
						});
						
					    function e_industry_annual_sort2() {
					        $("#jqgrid_industry_annual_sort2").length > 0 && t_industry_annual_sort2.fluidGrid({
					            base: "#jqgrid-wrapper_industry_annual_sort2",
					            offset: 0
					        })
					    } 
					    var t_industry_annual_sort2= $("#jqgrid_industry_annual_sort2");
					    $("#jqgrid_industry_annual_sort2").length > 0 && (t_industry_annual_sort2.jqGrid({
					    	url:"getTop10_annual_Led_Sum.action",
					    	mtype:"GET",
					    	datatype:"json",
					    	colNames:['行业','1月','2月','3月','4月','5月','6月','7月','8月','9月','10月','11月','12月','合计'],
					    	shrinkToFit:false,
					    	height:350,
					    	rowNum:10,
					    	rowList: [10, 20, 30],
			        		pager: "jqgrid-pager_industry_annual_sort2",
			        		multiselect:!1,
			        		sortname:"renkanshu.qiandingriqi",
			        		sortorder: "asc",
			        		viewrecords: !0,
			        		colModel:[{
			        			name:"goalYwy.ywyXingming",
			        			sortable: !1,
			        			align:"center",
			        	 		width:"120px"    		
			        		},{
			        			name:"Jan",
			        			sortable: !1,
			        			align:"center",
			        	 		width:"80px"
			        		},{
			        			name:"Feb",
			        			sortable: !1,
			        			align:"center",
			        			width:"80px" 
			        		},{
			        			name:"Mar",
			        			sortable: !1,
			        			align:"center",
			        			width:"80px"
			        		},{
			        			name:"Apr",
			        			sortable: !1,
			        			align:"center",
			        			width:"80px"
			        		},{
			        			name:"May",
			        			sortable: !1,
			        			align:"center",
			        			width:"80px"       			
			        		},{
			        			name:"Jun",
			        			sortable: !1,
			        			align:"center",
			        			width:"80px" 
			        		},{
			        			name:"Jul",
			        			sortable: !1,
			        			align:"center",
			        			width:"80px"
			        		},{
			        			name:"Aug",
			        			sortable: !1,
			        			align:"center",
			        			width:"80px"
			        		},{
			        			name:"Sep",
			        			sortable: !1,
			        			align:"center",
			        			width:"80px" 
			        		},{
			        			name:"Oct",
			        			sortable: !1,
			        			align:"center",
			        			width:"80px" 
			        		},{
			        			name:"Nov",
			        			sortable: !1,
			        			align:"center",
			        			width:"80px" 
			        		},{
			        			name:"Dec",
			        			sortable: !1,
			        			align:"center",
			        			width:"80px"
			        		},{
			        			name:"total",
			        			sortable: !1,
			        			align:"center",
			        			width:"100px"
			        		}],
			        		gridComplete: function(data){}
					    }), e_industry_annual_sort2(), $("#jqgrid_industry_annual_sort2").length > 0 && t_industry_annual_sort2.jqGrid("navGrid","#jqgrid-pager_industry_annual_sort2",{
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
					    $(window).resize(e_industry_annual_sort2);	
					
					    //导出报表功能
						$("#exportExcel1-2").click(function(){
							$("#jqgrid_industry_annual_sort2").jqGrid('excelExport',{url:'industryAnnualSumExport.action'})
						});
			});

			function AnnualIndustrySelectClick(){
				var t_industry_annual_sort= $("#jqgrid_industry_annual_sort");
				var t_industry_annual_sort2= $("#jqgrid_industry_annual_sort2");
				annualIndustry=$.trim($("#annualIndustry").val());
				annualIndustry1=$.trim($("#annualIndustry1").val());
			 //   alert(annualIndustry1); 
				redrawReport(annualIndustry);
				redrawReport2(annualIndustry1);
				t_industry_annual_sort[0].p.search = true;
				t_industry_annual_sort2[0].p.search = true;
				$.extend(t_industry_annual_sort[0].p.postData,{annualIndustry:annualIndustry,searchString:"",searchField:"allfieldsearch",searchOper:"cn"});
				$.extend(t_industry_annual_sort2[0].p.postData,{annualIndustry1:annualIndustry1,searchString:"",searchField:"allfieldsearch",searchOper:"cn"});
				t_industry_annual_sort.trigger("reloadGrid",[{page:1,current:true}]);
				t_industry_annual_sort2.trigger("reloadGrid",[{page:1,current:true}]);
				
				return false;
			}

			
			
			function redrawReport(obj) {
				$.ajax({
			         type : "post",
			         url : "annualIndustryReportAno.action",    //请求发送到TestServlet处
			         data : {annualIndustry:obj,_search:true},
			         dataType : "json",        //返回数据形式为json
			         success : function(result) {
			             //请求成功时执行该函数内容，result即为服务器返回的json对象
			        	 myChart.setOption({
				      		    title : {
				      		        text: '全年各行业占屏率分布',
				      		        subtext: '按占屏率大小排序',
				      		        x:'center'
				      		    },
				      		    tooltip : {
				      		        trigger: 'item',
				      		        formatter: "{b} <br/>{a} : {c}% (所占份额{d}%)"
				      		    },
				      		    legend: {
				      		        orient : 'vertical',
				      		        x : 'left',
				      		       data:  result.legenddata
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
				      		          data:result.ratiosdata//json 格式為{led:南都樓頂,zpl:11.56;...}
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
			
			function redrawReport2(obj) {
				$.ajax({
			         type : "post",
			         url : "annualIndustryReportSum.action",    //请求发送到TestServlet处
			         data : {annualIndustry1:obj,_search:true},
			         dataType : "json",        //返回数据形式为json
			         success : function(result) {
			             //请求成功时执行该函数内容，result即为服务器返回的json对象
			        	 myChart2.setOption({
				      		    title : {
				      		        text: '全年各行业签单金额分布',
				      		        subtext: '按照金额大小排序',
				      		        x:'center'
				      		    },
				      		    tooltip : {
				      		        trigger: 'item',
				      		        formatter: "{b} <br/>{a} : {c} (所占份额{d}%)"
				      		    },
				      		    legend: {
				      		        orient : 'vertical',
				      		        x : 'left',
				      		       data:  result.legenddata
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
				      		            name:'签单金额',
				      		            type:'pie',
				      		            radius : '55%',
				      		            center: ['50%', '60%'],
				      		          data:result.ratiosdata//json 格式為{led:南都樓頂,zpl:11.56;...}
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
			
			function changeViewOfReport1() {
				if($("#report3").is(":hidden")){
				       $("#report3").show();    //如果元素为隐藏,则将它显现
				       $("#report4").hide();     //如果元素为显现,则将其隐藏 
				}else{
					   $("#report4").show();    //如果元素为隐藏,则将它显现
				       $("#report3").hide();     //如果元素为显现,则将其隐藏
				}
				
			} 
			
			
			//$(function(){});函数是$(document).ready(function(){});函数的简写
			$(function(){
				$("#tabs").tabs();
				AnnualIndustrySelectClick();
				changeViewOfReport();
				changeViewOfReport1();

			});
			
			

	</script> 
	</content>