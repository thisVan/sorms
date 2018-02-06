<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="com.google.gson.*"%>
<%@ page import="java.sql.*"%>
<%@ taglib uri="/struts-tags" prefix="s"%>

<!DOCTYPE HTML>
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
<link href="css/main.css" rel="stylesheet">
<!--Icons-->
<script src="js/lumino.glyphs.js"></script>
<script src="js/jqGrid4.4.3/jquery-1.7.2.min.js"></script>
<script src="js/bootstrap-select.js"></script>


</head>
<body style="font-family: '微软雅黑';">

	<div class="main">
	    <form class="form-horizontal" action="upOrderPage" id="upOrderForm">
				<div class="input-group input-group-sm" >
					<input type="text" class="hidden" name="upOrder_id" id="upOrder_id">
				</div>			
	    </form>

		<!--/.row-->

		<div class="row">
			<div class="col-lg-12">
				<h3 class="page-header">
					应收款统计表
					</h3>
			</div>
		</div>
		<!--/.row-->

		<div class="row">
			<div class="col-lg-12">
				<div class="panel panel-default">
					<div class="panel-body">
						<div id="jqgrid-wrapper">
							<div class="row" style="margin-bottom:10px;">
								<div class="col-sm-3 pull-right">
									<div id="fuzzySearchbox" class="input-group input-group-sm searchbox">
										<input type="search" id="searchText" class="form-control" placeholder="请输入关键字...">
										<span class="input-group-btn">
											<button class="btn btn-default" type="button" id="searchButton">搜索</button>
										</span>
									</div>
								</div>
							</div>	
							<form class="form-horizontal" role="form" id="timeForm">
								<fieldset>
									<legend>查询条件</legend>
									<div class="col-sm-2 ">
										<label >约定付款时间</label> 
									</div>
									<div class="col-sm-2">
										<div class="input-group input-group-sm">
											<div class="input-group-addon">年度</div>
											<select name="year" id="year" class="form-control" >
												<option id="year2015" value="2015">2015</option>
											    <option id="year2016" value="2016">2016</option>
								 				<option id="year2017" value="2017">2017</option>
								 				<option id="year2018" value="2018">2018</option>
											</select>
										</div>
									</div>
									
									<div class="col-sm-2">
										<div class="input-group input-group-sm">
											<div class="input-group-addon">月份</div>
											<select name="month" id="month" class="form-control" >
												<option id="month0" value="0">1</option>
								 				<option id="month1" value="1">2</option>
								 				<option id="month2" value="2">3</option>
								 				<option id="month3" value="3">4</option>
								 				<option id="month4" value="4">5</option>
								 				<option id="month5" value="5">6</option>
								 				<option id="month6" value="6">7</option>
								 				<option id="month7" value="7">8</option>
								 				<option id="month8" value="8">9</option>
								 				<option id="month9" value="9">10</option>
								 				<option id="month10" value="10">11</option>
								 				<option id="month11" value="11">12</option>
											</select>
										</div>
									</div>
									
									
								<div class="col-sm-2 pull-right">
									<button class="btn btn-primary btn-sm" id="exactQuery">查询</button>
									<button class="btn btn-danger btn-sm" id="clearExactForm">清除</button>
								</div>
								</fieldset>
							</form>
						   <table id="jqgrid" class="table table-striped table-hover table-bordered" ></table>
						   <div id="jqgrid-pager"></div>
	 					</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!--/.main-->

	<script src="js/jqGrid4.4.3/jquery-1.7.2.min.js"></script>
	<script src="js/bootstrap.min.js"></script>
</body>
</html>
<content tag="scripts">
	<script src="js/jquery.ba-bbq.min.js"></script>
	<script src="js/grid.history.js"></script>
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
	<script>
	
	$(document).ready(function() {
		var now_date=new Date();
		var now_year=now_date.getFullYear();
		var now_month=now_date.getMonth();
//		alert("now_year:"+now_year+"  now_month:"+now_month);
		$("#year"+now_year).attr("selected","selected");
		$("#month"+now_month).attr("selected","selected");
		
		var t = $("#jqgrid");
	    function e() {
	        $("#jqgrid").length > 0 && t.fluidGrid({
	            base: "#jqgrid-wrapper",
	            offset: 0
	        });
	    } 

	   
	    $("#jqgrid").length > 0 && (t.jqGrid({
	    	url:"accountReceivedStatistics.action",
	    	mtype:"GET",
	    	datatype:"json",
	    	colNames:['部门','业务员','客户名称','签订日期','合作类型','签订金额','刊例总价','折扣','实收款','期次','应收款','已收款','付款时间','约定付款时间','备注'],
	    	shrinkToFit:false,
	    	height:400,
	    	rowNum:<s:property value="@com.nfledmedia.sorm.cons.CommonConstant@DEFAULT_PAGE_SIZE"/>,
	    	rowList: [10, 20, 30],
       		pager: "jqgrid-pager",
       		multiselect:!1,
       		sortname:"fukuanshijian",
       		sortorder: "asc",
       		viewrecords: !0,
       		colModel:[{
       			name:"orderpay.yewuyuan.bumen.bmMingcheng",
       			index:"orderpay.yewuyuan.bumen.bmMingcheng",
       			align:"center",
       	 		width:"100px"
       		},{
       			name:"orderpay.yewuyuan.ywyXingming",
       			index:"orderpay.yewuyuan.ywyXingming",
       			align:"center",
       			width:"100px"
       		},{
       			name:"kanhu",
       			index:"kanhu",
       			align:"center",
       			width:"100px" 
       		},{
       			name:"qiandingTime",
       			sortable: !1,
       			align:"center",
       			width:"90px"
       		},{
       			name:"leixing",
       			sortable: !1,
       			align:"center",
       			width:"90px"
       		},{
       			name:"qiandingjine",
       			sortable: !1,
       			align:"center",
       			width:"100px"
       		},{
       			name:"kanjizongjia",
       			sortable: !1,
       			align:"center",
       			width:"100px"
       		},{
       			name:"zhekou",
       			sortable: !1,
       			align:"center",
       			width:"50px"
       		},{
       			name:"shishoukuan",
       			sortable: !1,
       			align:"center",
       			width:"90px"
       		},{
       			name:"qici",
       			sortable: !1,
       			align:"center",
       			width:"90px" 
       		},{
       			name:"yingshoukuan",
       			sortable: !1,
       			align:"center",
       			width:"90px" 
       		},{
       			name:"yishoukuan",
       			sortable: !1,
       			align:"center",
       			width:"90px"
       		},{
       			name:"shoukuanshijian",
       			sortable: !1,
       			align:"center",
       			width:"100px"
       		},{
       			name:"fukuanshijian",
       			index: "fukuanshijian",
       			align:"center",
       			width:"100px"
       		},{
       			name:"beizhu",
       			sortable: !1,
       			align:"center",
       			width:"120px"
       		}],
       		gridComplete: function(data){
       			var ids = $("#jqgrid").jqGrid("getDataIDs");
       		}
	    }), e(), $("#jqgrid").length > 0 && t.jqGrid("navGrid","#jqgrid-pager",{
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


	    //模糊搜索
	    $("#searchText").keypress(function(event){
	    	if(event.keyCode == "13"){
	    		$("#searchButton").click();
	    	}
	    });
	    $("#searchButton").click(function(){
			var searchFilter = $("#searchText").val();
		    	if(searchFilter.length === 0){
		    		t[0].p.search = false; 
		    		$.extend(t[0].p.postData,{searchString:"",searchField:"",searchOper:""});
		    	}else{
			    	searchFilter = " where y.state!='D' and "+dateRangeSQL+" (y.renkanshu.renkanbianhao like '%"+searchFilter+"%' or y.kanhu like '%"+searchFilter+
			    	"%' or y.leixing like '%"+searchFilter+"%' or y.yewuyuan.ywyXingming like '%"+searchFilter+"%' or y.led.ledName like '%"+searchFilter+
			    	"%' or y.shichang like '%"+searchFilter+"%' or y.pinci like '%"+searchFilter+"%' or y.shuliang like '%"+searchFilter+
			    	"%' or y.shiduan like '%"+searchFilter+"%')";
		    		console.log(searchFilter);
		    		t[0].p.search = true;
		    		$.extend(t[0].p.postData,{searchString:searchFilter,searchField:"allfieldsearch",searchOper:"cn"});
		    	}
		    	t.trigger("reloadGrid",[{page:1,current:true}]);
	    });
	    
        //精确查询
	    $("#exactQuery").click(function(){
	    	var year = $.trim($("#year").val());
	    	var month = $.trim($("#month").val()); 
    		t[0].p.search = false;
    		$.extend(t[0].p.postData,{year:year, month:month});
	    	t.trigger("reloadGrid",[{page:1,current:true}]);
	    	return false;
	    });
	    $("#clearExactForm").click(function(){
//			$("#searchButton").click();
			location.reload();
			return false;
		});
	});
	
/*		function loadingLed(){		 
			 $.ajax({
			  		type:"post",
			  		dataType:"json",
			  		url:"getAllLed.action",
			  		success:function(data){ 	
			  			var jsonData = data.info;
			  			for(var i=0, n = jsonData.length;i<n;i++){
			  				$("#led").append("<option  value='"+jsonData[i][1]+"'>"+jsonData[i][1]+"</option>");		
			  			}
			  		}
			  });	
		}
		function loadingClient(){		 
			 $.ajax({
			  		type:"post",
			  		dataType:"json",
			  		url:"getAllClient.action",
			  		success:function(data){ 	
			  			var jsonData = data.info;
			  			clients=data.info;
//			  			alert("clients[0]="+clients[0]);
			  			for(var i=0, n = jsonData.length;i<n;i++){		  				
			  				$("#client").append("<option  value='"+jsonData[i]+"'>"+jsonData[i]+"</option>");		
			  			}

			  		}
			  });	
		}
		$(function(){
			loadingLed();
		}) */

	</script>
</content>