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

<link rel="stylesheet" href="css/bootstrap-theme.css">
<link href="css/styles.css" rel="stylesheet">
<link href="css/laydate.css" rel="stylesheet">

<!--Icons-->
<script src="js/lumino.glyphs.js"></script>
<script src="js/jquery-1.11.1.min.js"></script>
<script src="js/bootstrap-table.js"></script>


</head>
<body style="font-family: '微软雅黑';">

	<div class="main">
		
		<!--/.row-->

		<div class="row">
			<div class="col-lg-12">
				<h3 class="page-header">
					认刊书审核
				</h3>
			</div>
		</div>
		<!--/.row-->

		<div id="jqgrid-wrapper">
			<div class="row" id="tabs">
				<ul class="nav nav-pills">
					<li id="toBeAudit" class="active" onclick="tab('#tab1')"><a href="#tab1" data-toggle="tab">待审核<span></span></a></li>
					<li id="approved" class="" onclick="tab('#tab2')"><a href="#tab2" data-toggle="tab">已通过<span></span></a></li>
					<li id="unapproved" class="" onclick="tab('#tab3')"><a href="#tab3" data-toggle="tab">未通过<span></span></a></li>
				</ul>
			</div>
			<form class="form-horizontal" role="form" action="auditRenkanshuPage" id="auditForm">
				<div class="input-group input-group-sm" >
					<input type="text" class="hidden" name="audit_id" id="audit_id">
				</div>		
		    </form>
		    
		    <form class="form-horizontal" role="form" action="seeAuditRenkanshuPage" id="seeRenkanshuauditForm">
				<div class="input-group input-group-sm" >
					<input type="text" class="hidden" name="audit_id" id="audit_id">
				</div>
		    </form>
	    
		    <form class="form-horizontal" role="form" action="updateRenkanshuAuditPage" id="auditForm_alter">
				<div class="input-group input-group-sm" >
					<input type="text" class="hidden" name="renkanshuauditId" id="renkanshuauditId">
				</div>			
		    </form>
	    
		    <div id="tab1">
		    	<div class="row" style="margin-bottom:10px;">
				<!-- 条件搜索 begin-->
				<div class="col-sm-3 pull-right">
					<div id="fuzzySearchbox" class="input-group input-group-sm searchbox">
						<input type="search" id="searchText" class="form-control" placeholder="请输入关键字...">
						<span class="input-group-btn">
							<button class="btn btn-default" type="button" id="searchButton"><i class="fa fa-search"></i></button>
						</span>
					</div>

				</div>
				<!-- 条件搜索 end-->
				</div>

				<!-- jqgrid begin-->
				<table id="jqgrid" class="table table-striped table-hover"></table>
				<div id="jqgrid-pager"></div>
				<!-- jqgrid end-->
				<!--/.row-->
		    </div>
		</div>
		
		<div id="jqgrid-wrapper">
			<div id="tab2">
				<div>&nbsp;</div>
				<table id="jqgrid-approved" class="table table-striped table-hover"></table>
				<div id="jqgrid-approved-pager"></div>
			</div>
		</div>
		
		<div id="jqgrid-wrapper">
			<div id="tab3">
				<div>&nbsp;</div>
				<table id="jqgrid-unapproved" class="table table-striped table-hover"></table>
				<div id="jqgrid-unapproved-pager"></div>
			</div>
		</div>
		
	</div>
	<!--/.main-->

	
</body>
</html>
<content tag="scripts">
    <script src="js/jquery-1.11.1.min.js"></script>
	<script src="js/bootstrap.min.js"></script>
	<script src="js/jquery.ba-bbq.min.js"></script>
	<script src="js/grid.history.js"></script>
	<script src="js/grid.locale-cn.js"></script>
	<script>
		$.jgrid.useJSON = true;
	</script>
	<script src="js/jquery.jqGrid.min.js"></script>
	<script src="js/jquery.jqGrid.fluid.js"></script>
	<script src="js/king-common.js"></script>
	<script src="js/moment.js"></script>
	<script src="js/daterangepicker.js"></script>
	<script>
		function tab(pid) {
			var tabs=["#tab1","#tab2","#tab3"];
			for(var i = 0; i < 3; i++){
				if(tabs[i] == pid){
			    	$("div" + tabs[i]).show();
			  	} else{
			    	$("div" + tabs[i]).hide();
			  	}
			}
		}
		
		
		function seeAuditRenkanshu(target){
			var target = $(target).data("target");
			if(target==null || target==""){
			return;
			}
			$("input[name='audit_id']").val(target);
			$("#seeRenkanshuauditForm").submit();
		}
		
		function auditRenkanshu(target){
			var target = $(target).data("target");
			if(target==null || target==""){
			return;
			}
//			alert("点击审核按钮，调用auditOrder函数");
//			alert(target);
			$("input[name='audit_id']").val(target);
			$("#auditForm").submit();
		}
		function auditRenkanshu_alter(target){
			var target = $(target).data("target");
			if(target==null || target==""){
			return;
			}
//			alert("点击审核按钮，调用auditOrder函数");
//			alert(target);
			$("input[name='renkanshuauditId']").val(target);
			$("#auditForm_alter").submit();
		}

		$(document).ready(function() {
		    var t = $("#jqgrid");
		    var table_approved = $("#jqgrid-approved");
		    var table_unapproved = $("#jqgrid-unapproved");
		    
		    $("div#tab2").hide();
		    $("div#tab3").hide();
		    
		    function e() {
		        $("#jqgrid").length > 0 && t.fluidGrid({
		            base: "#jqgrid-wrapper",
		            offset: 0
		        })
		    }
		    
		    function e_approved() {
		    	table_approved.length > 0 && table_approved.fluidGrid({
		            base: "#jqgrid-wrapper",
		            offset: 0
		        })
		    }
		    
		    function e_unapproved() {
		    	table_unapproved.length > 0 && table_unapproved.fluidGrid({
		            base: "#jqgrid-wrapper",
		            offset: 0
		        })
		    }
		    
		    //待审核的认刊书列表
		    t.length > 0 && (t.jqGrid({
		    	url:"renkanshuAuditList.action",
		    	mtype:"GET",
		    	datatype:"json",
		    	colNames:['认刊编号','广告刊户','广告代理公司','签订日期','操作类型',''],
	//	    	shrinkToFit:false,
		    	height: 320,
		    	rowNum:'<s:property value="@com.nfledmedia.sorm.cons.CommonConstant@DEFAULT_PAGE_SIZE"/>',
		    	rowList: [10, 20, 30],
        		pager: "jqgrid-pager",
        		multiselect:!1,
        		sortname:"qiandingriqi",
        		sortorder: "desc",
        		viewrecords: !0,
        		colModel:[{
        			name:"renkanbianhao",
        			sortable: 1,
        			search: !1,
        			align:"center", 
        			width:"100px" 
        		},{
        			name:"guangaokanhu",
        			sortable: 1,
        			search: !1,
        			align:"center",
        			width:"150px" 
        		},{
        			name:"guanggaodailigognsi",
        			sortable: 1,
        			search: !1,
        			align:"center",
        			width:"150px" 
        		},{
        			name:"qiandingriqi",
        			sortable: 1,
        			search: !1,
        			align:"center",
        			width:"100px" 
        		},{
        			name:"operType",
        			sortable: 1,
        			search: !1,
        			align:"center",
        			width:"50px"
        		},{
        			name:"actions",
        			sortable: !1,
        			search: !1,
        			align:"center",
        			width:"50px"
        		}],
        		loadComplete: function(data) {
        			var ids = $("#jqgrid").jqGrid("getDataIDs");
        			console.log(data);
        			for(var i = 0; i < ids.length; i++){
        				/* console.log(ids[i]); */
						//取出操作类型的值
        				var operType = t.jqGrid("getCell",ids[i],"operType");
        				//加入判断是【添加】还是【修改】【删除】
        				if(operType == "添加") {
        					ce = '<button class="btn btn-primary btn-xs" data-target="'+ids[i]+'" onclick="auditRenkanshu(this);">审核</button>';
        				} else {
        					ce = '<button class="btn btn-primary btn-xs" data-target="'+ids[i]+'" onclick="auditRenkanshu_alter(this);">审核</button>';
        				}
                        t.jqGrid('setRowData',ids[i],{actions:ce});
                    }
                    $("li#toBeAudit a span").addClass("badge");
                    $("li#toBeAudit a span")[0].innerHTML = data.records;
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
		    
		    //已通过的认刊书列表
		    table_approved.length > 0 && (table_approved.jqGrid({
		    	url:"getApprovedRenkanshu",
		    	mtype:"GET",
		    	styleUI: 'Bootstrap',//设置jqgrid的全局样式为bootstrap样式
		    	datatype:"json",
		    	colNames:['认刊编号','广告刊户','广告代理公司','签订日期','操作类型',''],
		    	height: 320,
		    	rowNum:'<s:property value="@com.nfledmedia.sorm.cons.CommonConstant@DEFAULT_PAGE_SIZE"/>',
		    	rowList: [10, 20, 30],
        		pager: "jqgrid-approved-pager",
        		multiselect:!1,
        		sortname:"qiandingriqi",
        		sortorder: "desc",
        		viewrecords: !0,
        		colModel:[{
        			name:"renkanbianhao",
        			sortable: 1,
        			search: !1,
        			align:"center",
        			width:"180px" 
        		},{
        			name:"guangaokanhu",
        			sortable: 1,
        			search: !1,
        			align:"center",
        			width:"255px"
        		},{
        			name:"guangaodailigognsi",
        			sortable: 1,
        			search: !1,
        			align:"center",
        			width:"255px" 
        		},{
        			name:"qiandingriqi",
        			sortable: 1,
        			search: !1,
        			align:"center",
        			width:"150px" 
        		},{
        			name:"operType",
        			sortable: 1,
        			search: !1,
        			align:"center",
        			width:"100px"
        		},{
        			name:"actions",
        			sortable: !1,
        			search: !1,
        			align:"center",
        			width:"60px"
        		}],
        		loadComplete: function(data) {
        			var ids = table_approved.jqGrid("getDataIDs");
        			console.log(data);
        			
        			for(var i = 0; i < ids.length; i++){
        				console.log("ids:"+ids[i]);
        				ce = '<button class="btn btn-primary btn-xs" data-target="'+ids[i]+'" onclick="seeAuditRenkanshu(this);">查看</button>';
        				table_approved.jqGrid('setRowData',ids[i],{actions:ce});
                    }
                    $("li#approved a span").addClass("badge");
                    $("li#approved a span")[0].innerHTML = data.records;
        		}
		    }), e_approved(), table_approved.length > 0 && table_approved.jqGrid("navGrid","#jqgrid-approved-pager",{
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
		    $(window).resize(e_approved);
		    
		    //未通过的认刊书列表
		    table_unapproved.length > 0 && (table_unapproved.jqGrid({
		    	url:"getUnapprovedRenkanshu",
		    	mtype:"GET",
		    	datatype:"json",
		    	colNames:['认刊编号','广告刊户','广告代理公司','签订日期','操作类型',''],
	//	    	shrinkToFit:false,
		    	height: 320,
		    	rowNum:'<s:property value="@com.nfledmedia.sorm.cons.CommonConstant@DEFAULT_PAGE_SIZE"/>',
		    	rowList: [10, 20, 30],
        		pager: "jqgrid-unapproved-pager",
        		multiselect:!1,
        		sortname:"qiandingriqi",
        		sortorder: "desc",
        		viewrecords: !0,
        		colModel:[{
        			name:"renkanbianhao",
        			sortable: 1,
        			search: !1,
        			align:"center",
        			width:"180px" 
        		},{
        			name:"guangaokanhu",
        			sortable: 1,
        			search: !1,
        			align:"center",
        			width:"255px" 
        		},{
        			name:"guangaodailigongsi",
        			sortable: 1,
        			search: !1,
        			align:"center",
        			width:"255px" 
        		},{
        			name:"qiandingriqi",
        			sortable: 1,
        			search: !1,
        			align:"center",
        			width:"140px" 
        		},{
        			name:"operType",
        			sortable: 1,
        			search: !1,
        			align:"center",
        			width:"110px"
        		},{
        			name:"actions",
        			sortable: !1,
        			search: !1,
        			align:"center",
        			width:"60px"
        		}],
        		loadComplete: function(data) {
                    $("li#unapproved a span").addClass("badge");
                    $("li#unapproved a span")[0].innerHTML = data.records;
                    //审核按钮
                    var ids = table_unapproved.jqGrid("getDataIDs");
        			for(var i = 0; i < ids.length; i++){
						var ce;
						//取出操作类型的值
        				var operType = table_unapproved.jqGrid("getCell",ids[i],"operType");
        				//加入判断是【添加】还是【修改】【删除】
        				if(operType == "添加") {
        					ce = '<button class="btn btn-primary btn-xs" data-target="'+ids[i]+'" onclick="auditRenkanshu(this);">审核</button>';
        				} else {
        					ce = '<button class="btn btn-primary btn-xs" data-target="'+ids[i]+'" onclick="auditRenkanshu_alter(this);">审核</button>';
        				}
                        table_unapproved.jqGrid('setRowData',ids[i],{actions:ce});
                    }
        		}
		    }), e_unapproved(), table_unapproved.length > 0 && table_unapproved.jqGrid("navGrid","#jqgrid-unapproved-pager",{
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
		    $(window).resize(e_unapproved);
		    
	         //模糊搜索
		    $("#searchText").keypress(function(event){
		    	if(event.keyCode == "13"){
		    		$("#searchButton").click();
		    	}
		    });
		    $("#searchButton").click(function(){
		    	console.log("searchbox click");
		    	var searchFilter = $("#searchText").val();
		    	if(searchFilter.length === 0){
		    		t[0].p.search = false;
		    		$.extend(t[0].p.postData,{searchString:"",searchField:"",searchOper:""});
		    	}else{
		    		searchFilter = " and ( r.renkanbianhao like '%"+searchFilter+"%' or "+
		    		" r.guanggaodailigongsi like '%"+searchFilter+
		    		"%' or r.guangaokanhu like '%"+searchFilter+"%')";
		    		console.log(searchFilter);
		    		t[0].p.search = true;
		    		$.extend(t[0].p.postData,{searchString:searchFilter,searchField:"allfieldsearch",searchOper:"cn"});
		    	}
		    	t.trigger("reloadGrid",[{page:1,current:true}]);
		    })

		});		
	</script>
</content>