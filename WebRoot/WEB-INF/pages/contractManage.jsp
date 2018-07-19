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

 
<!--Icons-->
<script src="js/lumino.glyphs.js"></script>
<script src="js/jquery-1.11.1.min.js"></script>
<script src="js/bootstrap-select.js"></script>

</head>
<body style="font-family: '微软雅黑';">

	<div class="main">
	    <form class="form-horizontal" role="form" action="contractUpdatePage" id="updateContractForm">
				<div class="input-group input-group-sm" >
					<input type="text" class="hidden" name="contractnotypein" id="contractnotypein">
				</div>			
	    </form>

		<!--/.row-->

		<div class="row">
			<div class="col-lg-12">
				<h3 class="page-header">
					合同管理
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
		<form class="form-horizontal" role="form" id="exactForm">
			<fieldset>
				<legend>查询条件</legend>
			<div class="col-sm-3">
				<div class="input-group input-group-sm" >
					<div class="input-group-addon">时间段</div>
					<input type="text" id="daterange-default" class="form-control">
					<span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
				</div>
			</div>
			
			<div class="col-sm-3">
					<div class="input-group input-group-sm">
						<div class="input-group-addon">合同编号</div>		 
	  				    <select  name="hetongbianhao" id="hetongbianhao" class="form-control selectpicker" data-live-search="true">
			 				<option value="">所有合同编号</option>		 	 
						</select>   	
					</div>
			</div>
			
			<div class="col-sm-3">
					<div class="input-group input-group-sm">
						<div class="input-group-addon">客户</div>		 
	  				    <select  name="client" id="client" class="form-control selectpicker" data-live-search="true">
			 				<option value="">所有客户</option>		 	 
						</select>   	
					</div>
			</div>
							
			<div class="col-sm-2 pull-right">
					<button class="btn btn-primary btn-sm" id="exactQuery">查询</button>
					<button class="btn btn-danger btn-sm" id="clearExactForm">清除</button>
			</div>
			<div class="col-sm-12"><lable>&nbsp;</lable></div>
			</fieldset>
		</form>
		
		<table id="jqgrid" class="table table-striped table-hover table-bordered" ></table>
		   <div id="jqgrid-pager"></div>
		
	 </div>

					</div>
				</div>
			</div>
		</div>
		
	
	<div class="modal fade " id="deleteContract-modal-id">
		<div class="modal-dialog ">
			<div class="modal-content col-sm-12">
				<div class="modal-body " style="text-align:center">
					<form id="deleteContract_form" action="" class="form-horizontal" role="form">
						<input class="hidden" name="deleteContract_id">
						<div class="form-group">
							<label for="account" class="col-sm-2 control-label">删除理由</label>
							<textarea id="textarea" class="form-control" rows="6" cols="10" maxlength="100" name="deleteContract_Reason"></textarea>
							<p class="help-block text-right js-textarea-help"><span class="text-muted"></span></p>
						</div>
						<div class="form-group" >
							<label>确认删除所选项吗？</label>
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
		var dateRangeSQL = "";

		function formatRenkanbianhao(cellvalue, options, rowObject){
			if(cellvalue.id == null){
				return "";
			}
			return cellvalue.name;
		}

		function formatContractId(cellvalue, options, rowObject){
			/* if(cellvalue.id == null){
				return "";
			} */
			
			return "<a  target='_blank' href='contractUpdatePage.action?contractnotypein="+cellvalue+"'>"+cellvalue+"</a>";
		}
		function formatLed(cellvalue, options, rowObject){
			if(cellvalue.id == null){
				return "";
			}
			return cellvalue.name;
		}

		/* ${clientslist}
		${hetongbianhaolist} */
		$(document).ready(function() {
		    $("#client").append("<s:iterator value="#request.clientslist">");
		    $("#client").append("<option value='<s:property />'><s:property /></option>");
		    $("#client").append("</s:iterator>");

		    $("#hetongbianhao").append("<s:iterator value="#request.hetongbianhaolist">");
		    $("#hetongbianhao").append("<option value='<s:property />'><s:property /></option>");
		    $("#hetongbianhao").append("</s:iterator>");
			
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
			  dateRangeSQL = "c.cdate between '"+picker.startDate.format('YYYY-MM-DD')+"' and '"+picker.endDate.format('YYYY-MM-DD')+"' ";
			});


		    function e() {
		        $("#jqgrid").length > 0 && t.fluidGrid({
		            base: "#jqgrid-wrapper",
		            offset: 0
		        })
		    } 

		    var t = $("#jqgrid");
		    $("#jqgrid").length > 0 && (t.jqGrid({
		    	url:"contractManageList.action",
		    	mtype:"GET",
		    	datatype:"json",
		    	colNames:['合同编号','客户','签订日期','承办人',''],
	//	    	shrinkToFit:false,
		    	height:400,
		    	rowNum:<s:property value="@com.nfledmedia.sorm.cons.CommonConstant@DEFAULT_PAGE_SIZE"/>,
		    	rowList: [10, 20, 30],
        		pager: "jqgrid-pager",
        		multiselect:!1,
        		editurl:"deleteOrder.action",
        		sortname:"cdate",
        		sortorder: "desc",
        		viewrecords: !0,
        		colModel:[{
        			name:"cno",
        			index:"cno",
        			align:"center",
        	 		width:"100px",
        	 		formatter:formatContractId
        		},{
        			name:"cclient",
        			index:"cclient",
        			align:"center",
        			width:"130px" ,
 //       			formatter:formatKanhu
        				
        		},{
            		name:"cdate",
            		index:"cdate",
            		align:"center",
            		width:"100px"
            	},{
        			name:"ywyXingming",
        			index:"ywyXingming",
        			align:"center",
        			width:"80px" 
        				
        		},{
        			name:"actions",
        			sortable: !1,
        			search: !1,
        			align:"center",
        			width:"100px"
        		}],
        		gridComplete: function(data){
        			var ids = $("#jqgrid").jqGrid("getDataIDs");
        			for(var i=0;i < ids.length;i++){
       			    console.log(ids[i]);
        			update = '<button class="btn btn-primary btn-xs" data-target="'+ids[i]+'" onclick="updateContract(this)">修改</button>';
        			de = '<button class="btn btn-danger btn-xs" data-target="'+ids[i]+'" onclick="deleteContract(this)">删除</button>';
        			t.jqGrid('setRowData',ids[i],{actions:update+"  "+de});
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
				    	searchFilter = " where c.cstate='N' and "+dateRangeSQL+" (c.cno like '%"+searchFilter+
				    	"%' or c.cclient like '%"+searchFilter+"%')";
			    		console.log(searchFilter);
			    		t[0].p.search = true;
			    		$.extend(t[0].p.postData,{searchString:searchFilter,searchField:"allfieldsearch",searchOper:"cn"});
			    	}
			    	t.trigger("reloadGrid",[{page:1,current:true}]);
		    });
		    
		    //精确查询
		    $("#exactQuery").click(function(){
		    	var client = $.trim($("#client").val());
		    	var renkanshubianhao = $.trim($("#hetongbianhao").val()); 	
		    	if(dateRangeSQL === "" && client === ""&& renkanshubianhao==""){
		    		t[0].p.search = false;
		    		$.extend(t[0].p.postData,{searchString:"",searchField:"",searchOper:""});
		    	}else{
		    		var searchFilter="  where c.cstate='N' and (";
		    		if(renkanshubianhao !== ""){
		    			searchFilter += "  c.cno like '%"+renkanshubianhao+"%' and ";
		    		}
		    		if(client !== "" ){
		    			searchFilter += "  c.cclient like '%"+client+"%' and ";
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
	//			$("#searchButton").click();
				location.reload();
				return false;
			});
		});

		function deleteContract(target){
			console.log($(target).data("target"));
			var target = $(target).data("target");
			if(target==null || target==""){
				return;
			}
	 		
			$("input[name='deleteContract_id']").val(target);
			$("#deleteContract-modal-id").modal('show');
		}
		
		$("#ok").click(function(){
        	$.ajax({
        		url:"deleteContract.action",
        		data:$("#deleteContract_form").serializeArray(),
        		type:"post",
        		dataType:"json",
        		success:function(data){
        			if(data.state===0){
        				alert(data.info);
        			}else{
        				alert(data.info);
        			}
        		},
        		error:function(XMLHttpRequest, textStatus, errorThrown){
						alert('操作失败\nXMLHttpRequest.readyState['+XMLHttpRequest.readyState+']\nXMLHttpRequest.status['+XMLHttpRequest.status+']\ntextStatus['+textStatus+']');
				}
        	});
        	$("#deleteContract-modal-id").modal('hide');
        });
		function updateContract(target){
			var target =$(target).data("target");
			if(target==null||target==""){
				return;
			}
			$("input[name='contractnotypein']").val(target);
			$("#updateContractForm").submit();
		}

		
	</script>
</content>