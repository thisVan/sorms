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

<!--[if IE]><script language="javascript" type="text/javascript" src="../../Extras/excanvas.js"></script><![endif]-->

<!--[if lt IE 9]>
<script src="js/html5shiv.js"></script>
<script src="js/respond.min.js"></script>
<![endif]-->

</head>

<body style="font-family: '微软雅黑';">

	<div class="main">

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
					<li><a href="hangyestatistic.action">行业投放分布</a></li>
					<li><a href="annualIndustryReport.action">行业年度统计</a></li>
					<li class="active"><a href="yejistatistic.action">行业投放明细</a></li>
				</ul>

			</div>
			<!-- /.col-->
		</div>
		<!-- /.row -->

		<!--/.main-->

		<div id="jqgrid-wrapper">
			<div class="row" style="margin-bottom:10px;">
				<div class="col-sm-3 pull-right">
					<div id="fuzzySearchbox" class="input-group input-group-sm searchbox">
						<input type="search" id="searchText" class="form-control" placeholder="请输入关键字..."> <span class="input-group-btn">
							<button class="btn btn-default" type="button" id="searchButton">搜索</button>
						</span>
					</div>
				</div>
			</div>
			<form class="form-horizontal" role="form" id="exactForm">
				<fieldset>
					<legend>查询条件</legend>
					<div class="col-sm-4">
						<div class="input-group input-group-sm">
							<div class="input-group-addon">时间段</div>
							<input type="text" id="daterange-default" class="form-control"> <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
						</div>
					</div>
					<div class="col-sm-3">
						<div class="input-group input-group-sm">
							<div class="input-group-addon">行业</div>
							<select name="industry" id="industry" class="form-control">
								<option value="">所有行业</option>
							</select>
						</div>
					</div>
					<div class="col-sm-3">
						<div class="input-group input-group-sm">
							<div class="input-group-addon">屏幕</div>
							<select name="led" id="led" class="form-control">
								<option value="">所有屏幕</option>
							</select>
						</div>
					</div>
					<div class="col-sm-2">
						<button class="btn btn-primary btn-sm" id="exactQuery">查询</button>
						<button class="btn btn-danger btn-sm" id="clearExactForm">清除</button>
					</div>
				</fieldset>
			</form>

			<table id="jqgrid" class="table table-striped table-hover"></table>
			<div id="jqgrid-pager"></div>

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
<script>
		$.jgrid.useJSON = true;
</script>
<script src="js/jquery.jqGrid.min.js"></script>
<script src="js/jquery.jqGrid.fluid.js"></script>
<script src="js/grid.history.js"></script>
<script src="js/grid.locale-cn.js"></script>
<script type="text/javascript">
		var dateRangeSQL = "";
		function formatRenkanbianhao(cellvalue, options, rowObject){
			if(cellvalue.id == null){
				return "";
			}
			return cellvalue.id;
		}
		function formatYewuyuan(cellvalue, options, rowObject){
			if(cellvalue.id == null){
				return "";
			}
			return cellvalue.name;
		}
		function formatLed(cellvalue, options, rowObject){
			if(cellvalue.id == null){
				return "";
			}
			return cellvalue.name;
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
			  dateRangeSQL = "";
			});
			$('#daterange-default').on('apply.daterangepicker', function(ev, picker) {
			  console.log("start:"+picker.startDate.format('YYYY-MM-DD')+"\nend:"+picker.endDate.format('YYYY-MM-DD'));
			  dateRangeSQL = "y.renkanshu.qiandingriqi between '"+picker.startDate.format('YYYY-MM-DD')+"' and '"+picker.endDate.format('YYYY-MM-DD')+"' ";
			});


		    function e() {
		        $("#jqgrid").length > 0 && t.fluidGrid({
		            base: "#jqgrid-wrapper",
		            offset: 0
		        })
		    } 

		    var t = $("#jqgrid");
		    $("#jqgrid").length > 0 && (t.jqGrid({
		    	url:"yewulist.action",
		    	mtype:"GET",
		    	datatype:"json",
		    	colNames:['认刊编号','行业','刊户','类型','业务员','屏幕','时长','频次','开始时间','结束时间','投放时长','刊例价小计','时段'],
		    	shrinkToFit:false,
		    	height:320,
		    	rowNum:<s:property value="@com.nfledmedia.sorm.cons.CommonConstant@DEFAULT_PAGE_SIZE"/>,
		    	rowList: [10, 20, 30],
        		pager: "jqgrid-pager",
        		multiselect: !1,
        		sortname:"yewuId",
        		sortorder: "asc",
        		viewrecords: !0,
        		colModel:[{
        			name:"renkanshu.renkanbianhao",
        			index:"renkanshu.renkanbianhao",
        			align:"center",
        	 		width:"80px",  
        			formatter:formatRenkanbianhao
        		},{
        			name:"renkanshu.industry.industryDesc",
        			index:"renkanshu.industry.industryDesc",
        			align:"center",
        	 		width:"100px"
        		},{
        			name:"kanhu",
        			index:"kanhu",
        			align:"center",
        			width:"120px" 
        		},{
        			name:"leixing",
        			index:"leixing",
        			align:"center",
        			width:"80px"
        		},{
        			name:"yewuyuan.username",
        			index:"yewuyuan.username",
        			align:"center",
        			width:"70px",
        			formatter:formatYewuyuan
        		},{
        			name:"led.ledName",
        			index:"led.ledName",
        			align:"center",
        			width:"100px",
        			formatter:formatLed
        		},{
        			name:"shichang",
        			index:"shichang",
        			align:"center",
        			width:"50px" 
        		},{
        			name:"pinci",
        			sortable: !1,
        			search: !1,
        			align:"center",
        			width:"50px"
        		},{
        			name:"kaishishijian",
        			sortable: !1,
        			search: !1,
        			align:"center",
        			width:"100px"
        		},{
        			name:"jieshushijian",
        			sortable: !1,
        			search: !1,
        			align:"center",
        			width:"100px" 
        		},{
        			name:"shuliang",
        			sortable: !1,
        			search: !1,
        			align:"center",
        			width:"80px" 
        		},{
        			name:"kanlijiaxiaoji",
        			sortable: !1,
        			search: !1,
        			align:"center",
        			width:"80px" 
        		},{
        			name:"shiduan",
        			sortable: !1,
        			search: !1,
        			align:"center",
        			width:"100px"
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
				    	searchFilter = " where "+dateRangeSQL+" (y.renkanshu.renkanbianhao like '%"+searchFilter+"%' or y.kanhu like '%"+searchFilter+
				    	"%' or y.leixing like '%"+searchFilter+"%' or y.yewuyuan.ywyXingming like '%"+searchFilter+"%' or y.led.ledName like '%"+searchFilter+
				    	"%' or y.shichang like '%"+searchFilter+"%' or y.pinci like '%"+searchFilter+"%' or y.shuliang like '%"+searchFilter+"%' or y.shiduan like '%"+searchFilter+"%')";
			    		console.log(searchFilter);
			    		t[0].p.search = true;
			    		$.extend(t[0].p.postData,{searchString:searchFilter,searchField:"allfieldsearch",searchOper:"cn"});
			    	}
			    	t.trigger("reloadGrid",[{page:1,current:true}]);
		    });
		    
		    //精确查询
		    $("#exactQuery").click(function(){
		    	var industry = $.trim($("#industry").val());
		    	var led = $.trim($("#led").val());  	
		    	if(dateRangeSQL === "" && industry === ""&& led === ""){
		    		t[0].p.search = false;
		    		$.extend(t[0].p.postData,{searchString:"",searchField:"",searchOper:""});
		    	}else{
		    		var searchFilter=" where(";
		    		if(industry !== "" ){
		    			searchFilter += "  y.renkanshu.industry.industryDesc like '%"+industry+"%' and ";
		    		}
		    		if(led !== ""){
		    			searchFilter += "  y.led.ledName like '%"+led+"%' and ";
		    		}
		    		if(dateRangeSQL !== ""){
		    			searchFilter += " "+ dateRangeSQL;
		    		}else{
		    			searchFilter = searchFilter.substring(0,searchFilter.lastIndexOf('and '));
		    		}
		    		searchFilter += ")";
		    		console.log(searchFilter);
		    		t[0].p.search = true;
		    		$.extend(t[0].p.postData,{searchString:searchFilter,searchField:"allfieldsearch",searchOper:"cn"});
		    	}
		    	t.trigger("reloadGrid",[{page:1,current:true}]);
		    	return false;
		    });
		    
		    $("#clearExactForm").click(function(){
			//	$("#searchButton").click();
				location.reload();
				return false;
			});
		});

		function loadingLed(){		 
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
		function loadingIndustry(){		 
			 $.ajax({
			  		type:"post",
			  		dataType:"json",
			  		url:"getAllIndustry.action",
			  		success:function(data){ 	
			  			var jsonData = data.info;
			  			for(var i=0, n = jsonData.length;i<n;i++){
			  				$("#industry").append("<option  value='"+jsonData[i][1]+"'>"+jsonData[i][1]+"</option>");		
			  			}
			  		}
			  });	
		}
		$(function(){
			loadingLed();
			loadingIndustry();
		});		
</script>
</content>
</s:i18n>