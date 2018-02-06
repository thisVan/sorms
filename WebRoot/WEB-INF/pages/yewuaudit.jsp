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
					订单审核
					</h3>
			</div>
		</div>
		<!--/.row-->

		<div id="jqgrid-wrapper">
		
		<form class="form-horizontal" role="form" action="auditPage" id="auditForm">
				<div class="input-group input-group-sm" >
					<input type="text" class="hidden" name="audit_id" id="audit_id">
				</div>			
	    </form>
		
		<div class="row" style="margin-bottom:10px;">
			<div class="col-sm-3">
				<button class="btn btn-primary btn-xs" id="batchAudit" data-target="" onclick="setIds(this);openAuditModel(this);">批量审核</button>
			</div>   
			
			
			
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
	</div>
	<div class="modal fade" id="modal-id">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-body">
					<form id="form_audit" action="" class="form-horizontal" role="form">
						<input class="hidden" name="ids">
						<div class="form-group">
							<div class="simple-radio simple-radio-inline radio-green">
								<input id="pass" type="radio" name="auditResult" value="true" checked>
								<label for="pass">通过</label>
								<input id="unpass" type="radio" name="auditResult" value="false">
								<label for="unpass">不通过</label>
							</div>
						</div>
						<div class="form-group">
							<p>理由</p>
							<textarea id="textarea" class="form-control" rows="6" cols="30" maxlength="100" name="auditReason"></textarea>
							<p class="help-block text-right js-textarea-help"><span class="text-muted"></span></p>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal"><i class="fa fa-times-circle"></i> 取消</button>
					<button id="ok" type="button" class="btn btn-custom-primary"><i class="fa fa-check-circle"></i> 确认</button>
				</div>
			</div><!-- /.modal-content -->
		</div><!-- /.modal-dialog -->
	</div><!-- /.modal -->
		<!--/.row-->

	</div>
	<!--/.main-->

	<script src="js/jquery-1.11.1.min.js"></script>
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
	<script src="js/jquery.jqGrid.min.js"></script>
	<script src="js/jquery.jqGrid.fluid.js"></script>
	<script src="js/king-common.js"></script>
	<script src="js/moment.js"></script>
	<script src="js/daterangepicker.js"></script>
	<script>
		function setIds(tt){
			var ids = $("#jqgrid").jqGrid('getGridParam','selarrrow');
			var target = "";
			if(ids.length==0){
				alert("请先选择订单");
				$(tt).data("target",target);
				return;
			}
			for(var i=0;i<ids.length;i++){
				target += ids[i]+',';
			}
	//		alert(target);
			target = target.substring(0,target.length-1);
			console.log("target:"+target);
			$(tt).data("target",target);
		}

		function openAuditModel(target){
			console.log($(target).data("target"));
			var target = $(target).data("target");
			if(target==null || target==""){
				return;
			}
			$("input[name='ids']").val(target);
			$("#modal-id").modal('show');
		} 
		

		function auditOrder(target){
			var target = $(target).data("target");
			if(target==null || target==""){
			return;
			}
//			alert("点击审核按钮，调用auditOrder函数");
//			alert(target);
			$("input[name='audit_id']").val(target);
			$("#auditForm").submit();
		}

		$(document).ready(function() {
		    function e() {
		        $("#jqgrid").length > 0 && t.fluidGrid({
		            base: "#jqgrid-wrapper",
		            offset: 0
		        })
		    } 

		    var t = $("#jqgrid");
		    $("#jqgrid").length > 0 && (t.jqGrid({
		    	url:"orderAuditList.action",
		    	mtype:"GET",
		    	datatype:"json",
		    	colNames:['审核内容',''],
	//	    	shrinkToFit:false,
		    	height:320,
		    	rowNum:<s:property value="@com.nfledmedia.sorm.cons.CommonConstant@DEFAULT_PAGE_SIZE"/>,
		    	rowList: [10, 20, 30],
        		pager: "jqgrid-pager",
        		multiselect:1,
        		sortname:"id",
        		sortorder: "asc",
        		viewrecords: !0,
        		colModel:[{
        			name:"auditContent",
        			sortable: !1,
        			search: !1,
        //			align:"center",
        			width:"700px" 
        		},{
        			name:"actions",
        			sortable: !1,
        			search: !1,
        			align:"center",
        			width:"50px"
        		}],
        		gridComplete: function(data){
        			var ids = $("#jqgrid").jqGrid("getDataIDs");
        			for(var i=0;i < ids.length;i++){
        				console.log(ids[i]);
                        ce = '<button class="btn btn-primary btn-xs" data-target="'+ids[i]+'" onclick="auditOrder(this);">审核</button>';
                        t.jqGrid('setRowData',ids[i],{actions:ce});
                    }
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

		    var count = 100;
	        $(".js-textarea-help span").html(count + " "+'个字剩余'),
	        $("#textarea").keyup(function() {
	            var a = $("#textarea").val().length,
	            t = count - a;
	            $(".js-textarea-help span").html(t + " "+'个字剩余')
	        });

	        //审核ajax
	        $("#ok").click(function(){
	        	$.ajax({
	        		url:"batchAudit.action",
	        		data:$("#form_audit").serializeArray(),
	        		type:"post",
	        		dataType:"json",
	        		success:function(data){
	        			if(data.state===0){
	        				alert(data.info);
	        				//$("#jqgrid").jqGrid("delRowData",$("input[name='id']").val());
	        				var s = $("input[name='ids']").val().split(',');
	        				for(var i=0,size=s.length;i<size;i++){
	        					$("#jqgrid").jqGrid("delRowData",s[i]);
	        				}
	        			}else{
	        				alert('审核失败，未知原因');
	        			}
	        		},
	        		error:function(XMLHttpRequest, textStatus, errorThrown){
							alert('审核失败\nXMLHttpRequest.readyState['+XMLHttpRequest.readyState+']\nXMLHttpRequest.status['+XMLHttpRequest.status+']\ntextStatus['+textStatus+']');
					}
	        	})
	        	$("#modal-id").modal('hide');
	        });

	        $("#modal-id").on('hidden.bs.modal',function(){
	        	$("input[name='auditResult']:first").click();
	        	$("#textarea").val('');
	        	$(".js-textarea-help span").html(count + " "+'个字剩余');
	        })  

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
		    		searchFilter = " where r.state='A' and "+ "(r.operContent like '%"+searchFilter+"%')";
		    		console.log(searchFilter);
		    		t[0].p.search = true;
		    		$.extend(t[0].p.postData,{searchString:searchFilter,searchField:"allfieldsearch",searchOper:"cn"});
		    	}
		    	t.trigger("reloadGrid",[{page:1,current:true}]);
		    })

		});		
	</script>
</content>