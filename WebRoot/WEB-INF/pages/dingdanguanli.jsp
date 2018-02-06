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
<link href="css/main.css" rel="stylesheet">
<!--Icons-->
<script src="js/lumino.glyphs.js"></script>
<script src="js/jqGrid4.4.3/jquery-1.7.2.min.js"></script>
<script src="js/bootstrap-select.js"></script>


</head>
<body style="font-family: '微软雅黑';">

	<div class="main">
	    <form class="form-horizontal" role="form" action="upOrderPage" id="upOrderForm">
				<div class="input-group input-group-sm" >
					<input type="text" class="hidden" name="upOrder_id" id="upOrder_id">
				</div>			
	    </form>

		<!--/.row-->

		<div class="row">
			<div class="col-lg-12">
				<h3 class="page-header">
					订单管理
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
						<div class="input-group-addon">认刊编号</div>		 
	  				    <select  name="renkanshubianhao" id="renkanshubianhao" class="form-control selectpicker" data-live-search="true">
			 				<option value="">所有编号</option>		 	 
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
			
			<div class="col-sm-3">
					<div class="input-group input-group-sm">
						<div class="input-group-addon">屏幕</div>				
						<select  name="led" id="led" class="form-control">
							<option value="">所有屏幕</option>			
						</select>
					</div>
			</div>
			<div class="col-sm-12"><lable>&nbsp;</lable></div>
							
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
		
	<div class="modal fade " id="modal-id">
		<div class="modal-dialog ">
			<div class="modal-content col-sm-5">
				<div class="modal-body " style="text-align:center">
					<form id="form_audit" action="" class="form-horizontal" role="form">
						<input class="hidden" name="ids">
						<div class="form-group" >
							<label>确认删除所选订单吗？</label>
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
	
	
	<div class="modal fade " id="xiahua-modal-id">
		<div class="modal-dialog ">
			<div class="modal-content col-sm-12">
				<div class="modal-body " style="text-align:center">
					<form id="xiahua_form_audit" action="" class="form-horizontal" role="form">
						<input class="hidden" name="xiahua_ids">
						<div class="form-group">
			                <label for="account" class="col-sm-3 control-label">播放结束时间</label>
			                <div class="col-sm-4"><input type="date" class="form-control input-sm" name="xiahua_jieshushijian"  maxlength="20" ></div>
		                </div> 
						<div class="form-group">
							<label for="account" class="col-sm-2 control-label">下画理由</label>
							<textarea id="textarea" class="form-control" rows="6" cols="10" maxlength="100" name="xiahua_Reason"></textarea>
							<p class="help-block text-right js-textarea-help"><span class="text-muted"></span></p>
						</div>
						<div class="form-group" >
							<label>确认下画所选订单吗？</label>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal"><i class="fa fa-times-circle"></i> 取消</button>
					<button id="xiahua-ok" type="button" class="btn btn-custom-primary"><i class="fa fa-check-circle"></i> 确认</button>
				</div>
			</div><!-- /.modal-content -->
		</div><!-- /.modal-dialog -->
	</div><!-- /.modal -->
		<!--/.row-->
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
		var dateRangeSQL = "";
		
		var renkanshubianhao = new Array();
		<%
		// 这段可以用EL和JSTL等方法代替
		List<String> valueList = (List)request.getAttribute("renkanshubianhao");
		for (String currentValue : valueList) {%>
		renkanshubianhao.push("<%=currentValue%>");
		<% } %>
		function formatRenkanbianhao(cellvalue, options, rowObject){
			if(cellvalue.id == null){
				return "";
			}
			return cellvalue.name;
		}

		function formatKanhu(cellvalue, options, rowObject){
			if(cellvalue.id == null){
				return "";
			}
			return "<a  target='_blank' href='orderUpdatePage.action?yewuId="+cellvalue.id+"'>"+cellvalue.name+"</a>";
		}
		function formatLed(cellvalue, options, rowObject){
			if(cellvalue.id == null){
				return "";
			}
			return cellvalue.name;
		}

	

		$(document).ready(function() {
		    $("#client").append("<s:iterator value="#request.clients">");
		    $("#client").append("<option value='<s:property value="[0].top[0]"/>'><s:property value="[0].top[0]"/></option>");
		    $("#client").append("</s:iterator>");

	
			for (var i = 0; i < renkanshubianhao.length; i++) {
				$("#renkanshubianhao").append("<option  value='"+renkanshubianhao[i]+"'>"+renkanshubianhao[i]+"</option>");
			}
			
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
			  dateRangeSQL = "y.kaishishijian between '"+picker.startDate.format('YYYY-MM-DD')+"' and '"+picker.endDate.format('YYYY-MM-DD')+"' ";
			});


		    function e() {
		        $("#jqgrid").length > 0 && t.fluidGrid({
		            base: "#jqgrid-wrapper",
		            offset: 0
		        })
		    } 

		    var t = $("#jqgrid");
		    $("#jqgrid").length > 0 && (t.jqGrid({
		    	url:"dingdanguanliList.action",
		    	mtype:"GET",
		    	datatype:"json",
		    	colNames:['认刊编号','广告客户','业务员','类型','上画屏幕','开始时间','结束时间','时长','频次','状态',''],
		    	shrinkToFit:false,
		    	height:400,
		    	rowNum:<s:property value="@com.nfledmedia.sorm.cons.CommonConstant@DEFAULT_PAGE_SIZE"/>,
		    	rowList: [10, 20, 30],
        		pager: "jqgrid-pager",
        		multiselect:!1,
        		editurl:"deleteOrder.action",
        		sortname:"renkanshu.qiandingriqi",
        		sortorder: "asc",
        		viewrecords: !0,
        		colModel:[{
        			name:"renkanshu.renkanbianhao",
        			index:"renkanshu.renkanbianhao",
        			align:"center",
        	 		width:"100px",  
        			formatter:formatRenkanbianhao
        		},{
        			name:"kanhu",
        			index:"kanhu",
        			align:"center",
        			width:"130px" ,
        			formatter:formatKanhu
        				
        		},{
        			name:"yewuyuan",
        			index:"yewuyuan",
        			align:"center",
        			width:"80px" 
        				
        		},{
        			name:"leixing",
        			index:"leixing",
        			align:"center",
        			width:"90px"
        		},{
        			name:"led.ledName",
        			index:"led.ledName",
        			align:"center",
        			width:"100px",
        			formatter:formatLed
        		},{
        			name:"kaishishijian",
        			index:"kaishishijian",
        			align:"center",
        			width:"90px"
        		},{
        			name:"jieshushijian",
        			index:"jieshushijian",
        			align:"center",
        			width:"90px" 
        		},{
        			name:"shichang",
        			index:"shichang",
        			align:"center",
        			width:"50px" 
        		},{
        			name:"pinci",
        			index: "pinci",
        			align:"center",
        			width:"50px"
        		},{
        			name:"state",
        			index:"state",
        			align:"center",
        			width:"70px"
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
        			    xiahua = '<button class="btn btn-danger btn-xs" data-target="'+ids[i]+'" onclick="downOrder(this)">下画</button>';
        			    shanghua = '<button class="btn btn-primary btn-xs" data-target="'+ids[i]+'" onclick="upOrder(this)">上画</button>';
        			    de = '<button class="btn btn-danger btn-xs" data-target="'+ids[i]+'" onclick="deletedOrder(this)">删除</button>';
        			    t.jqGrid('setRowData',ids[i],{actions:xiahua+"  "+shanghua});
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

//		    $("#hcg").click( function() {
//			    t.setColumns(["开始时间","结束时间"]);
//			    return false;
//		    });

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
			    	}else if(searchFilter=="上"||searchFilter=="上画"){
				    	searchFilter = " where y.state!='D' and "+dateRangeSQL+" (y.renkanshu.renkanbianhao like '%"+searchFilter+"%' or y.kanhu like '%"+searchFilter+
				    	"%' or y.leixing like '%"+searchFilter+"%' or y.yewuyuan.ywyXingming like '%"+searchFilter+"%' or y.led.ledName like '%"+searchFilter+
				    	"%' or y.shichang like '%"+searchFilter+"%' or y.pinci like '%"+searchFilter+"%' or y.shuliang like '%"+searchFilter+
				    	"%' or y.shiduan like '%"+searchFilter+"%' or y.state like '%"+"N"+"%')";
			    		console.log(searchFilter);
			    		t[0].p.search = true;
			    		$.extend(t[0].p.postData,{searchString:searchFilter,searchField:"allfieldsearch",searchOper:"cn"});
			    	}else if(searchFilter=="下"||searchFilter=="下画"){
				    	searchFilter = "  where y.state!='D' and "+dateRangeSQL+" (y.renkanshu.renkanbianhao like '%"+searchFilter+"%' or y.kanhu like '%"+searchFilter+
				    	"%' or y.leixing like '%"+searchFilter+"%' or y.yewuyuan.ywyXingming like '%"+searchFilter+"%' or y.led.ledName like '%"+searchFilter+
				    	"%' or y.shichang like '%"+searchFilter+"%' or y.pinci like '%"+searchFilter+"%' or y.shuliang like '%"+searchFilter+
				    	"%' or y.shiduan like '%"+searchFilter+"%' or y.state like '%"+"U"+"%')";
			    		console.log(searchFilter);
			    		t[0].p.search = true;
			    		$.extend(t[0].p.postData,{searchString:searchFilter,searchField:"allfieldsearch",searchOper:"cn"});
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
		    	var client = $.trim($("#client").val());
		    	var led = $.trim($("#led").val()); 
		    	var renkanshubianhao = $.trim($("#renkanshubianhao").val()); 	
		    	if(dateRangeSQL === "" && client === ""&& led === ""&& renkanshubianhao==""){
		    		t[0].p.search = false;
		    		$.extend(t[0].p.postData,{searchString:"",searchField:"",searchOper:""});
		    	}else{
		    		var searchFilter="  where y.state!='D' and (";
		    		if(renkanshubianhao !== ""){
		    			searchFilter += "  y.renkanshu.renkanbianhao like '%"+renkanshubianhao+"%' and ";
		    		}
		    		if(client !== "" ){
		    			searchFilter += "  y.renkanshu.guangaokanhu like '%"+client+"%' and ";
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
	//			$("#searchButton").click();
				location.reload();
				return false;
			});
		});

		function deletedOrder(target){
			console.log($(target).data("target"));
			var target = $(target).data("target");
			if(target==null || target==""){
				return;
			}
	//		alert(target);
			$("input[name='ids']").val(target);
			$("#modal-id").modal('show');
		}
		
		$("#ok").click(function(){
        	$.ajax({
        		url:"deleteOrder.action",
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
        				alert('操作失败，未知原因');
        			}
        		},
        		error:function(XMLHttpRequest, textStatus, errorThrown){
						alert('操作失败\nXMLHttpRequest.readyState['+XMLHttpRequest.readyState+']\nXMLHttpRequest.status['+XMLHttpRequest.status+']\ntextStatus['+textStatus+']');
				}
        	})
        	$("#modal-id").modal('hide');
        });
		
		function downOrder(target){
			console.log($(target).data("target"));
			var target = $(target).data("target");
			if(target==null || target==""){
				return;
			}
	//		alert(target);
			$("input[name='xiahua_ids']").val(target);
			$("#xiahua-modal-id").modal('show');
		}
		
		$("#xiahua-ok").click(function(){
        	if($("input[name='xiahua_jieshushijian']").val() == "") {
        		alert("请输入正确的播放结束时间！");
        	} else {
	        	$.ajax({
	        		url:"downOrder.action",
	        		data:$("#xiahua_form_audit").serializeArray(),
	        		type:"post",
	        		dataType:"json",
	        		success:function(data){
	        			if(data.state===0){
	        				alert(data.info);
	        			}else{
	        				alert('操作失败，未知原因');
	        			}
	        		},
	        		error:function(XMLHttpRequest, textStatus, errorThrown){
							alert('操作失败\nXMLHttpRequest.readyState['+XMLHttpRequest.readyState+']\nXMLHttpRequest.status['+XMLHttpRequest.status+']\ntextStatus['+textStatus+']');
					}
	        	})
	        	$("#xiahua-modal-id").modal('hide');
        	}
        });
		
		function upOrder(target){
			var target = $(target).data("target");
			if(target==null || target==""){
				return;
			}
	//		alert(target);
			$("input[name='upOrder_id']").val(target);
			$("#upOrderForm").submit();
		}

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
//			loadingClient();
		});

		
	</script>
</content>