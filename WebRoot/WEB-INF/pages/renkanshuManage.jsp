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
<script src="js/bootstrap.min.js"></script>
<script src="js/bootstrap-select.js"></script>
</head>
<body style="font-family: '微软雅黑';">

	<div class="main">
		<form class="form-horizontal" role="form" action="updateOrderPage"
			id="updateRenkanshuForm">
			<div class="input-group input-group-sm">
				<input type="text" class="hidden" name="orderid"
					id="update_order_id">
			</div>
		</form>

		<!--/.row-->

		<div class="row">
			<div class="col-lg-12">
				<h3 class="page-header">单据管理</h3>
			</div>
		</div>
		<!--/.row-->

		<div class="row">
			<div class="col-lg-12">
				<div id="jqgrid-wrapper">

					<div class="row" style="margin-bottom:10px;">
						<div class="col-sm-3 pull-right">
							<div id="fuzzySearchbox"
								class="input-group input-group-sm searchbox">
								<input type="search" id="searchText" class="form-control"
									placeholder="请输入关键字..."> <span class="input-group-btn">
									<button class="btn btn-default" type="button" id="searchButton">搜索</button>
								</span>
							</div>

						</div>
					</div>
					<form class="form-horizontal" role="form" id="exactForm">
						<fieldset>
							<legend>查询条件</legend>
							<div class="row">
							<div class="col-sm-3">
								<div class="input-group input-group-sm">
									<div class="input-group-addon">时间段</div>
									<input type="text" id="daterange-default" class="form-control">
									<span class="input-group-addon"><span
										class="glyphicon glyphicon-calendar"></span></span>
								</div>
							</div>
							
							<div class="col-sm-3">
								<div class="input-group input-group-sm">
									<div class="input-group-addon">时间条件</div>
									<select name="timecond" id="timecondition" class="form-control" >
										<option value="0">按刊播日期</option>
										<option value="1">按上刊日期</option>
										<option value="2">按录入日期</option>
									</select>
								</div>
							</div>

							<div class="col-sm-3">
								<div class="input-group input-group-sm">
									<div class="input-group-addon">屏幕</div>
									<select name="led" id="ledlist"
										class="form-control selectpicker" data-live-search="true">
										<option value="">所有屏幕</option>
									</select>
								</div>
							</div>

							<div class="col-sm-3">
								<div class="input-group input-group-sm">
									<div class="input-group-addon">客户</div>
									<select name="client" id="client"
										class="form-control selectpicker" data-live-search="true">
										<option value="">所有客户</option>
									</select>
								</div>
							</div>
							
							</div>
							
							<div class="row">
							<div class="col-sm-0 pull-right">
								<button type="button" class="btn btn-primary btn-sm" id="exactQuery">查询</button>
								<button class="btn btn-danger btn-sm" id="clearExactForm">清除</button>
							</div>
							<div class="col-sm-5 pull-right">
								<button type="button" class="btn btn-success btn-sm" id="exportExcel">资源管理表</button>
								<button type="button" class="btn btn-success btn-sm" id="exportContentStatisticExcel">广告发布内容汇总表</button>
								<button type="button" class="btn btn-success btn-sm" id="exportContentArrangementExcel">广告发布安排表</button>
							</div>
							</div>
							<div class="row">

							</div>
			
						</fieldset>
					</form>

					<table id="jqgrid"
						class="table table-striped table-hover table-bordered"></table>
					<div id="jqgrid-pager"></div>

				</div>


			</div>
		</div>


		<div class="modal fade " id="chooseLeds">
			<div class="modal-dialog ">
				<div class="modal-content col-sm-12">
					<div class="modal-body " >
						<div class="form-group">
							<label>请选择需要导出的屏幕</label>
							<div class="form-group" id="showSelectedLeds"></div>
							<div class="form-group" >
								<label>选择屏幕：</label>
								<s:select list="#ledList"
									listKey="id" listValue="name"
									id="selectLeds4Modal"
									value="" 
									headerKey="" headerValue="请点击选择屏幕"
									cssClass="form-control form-inline" onclick="addLed2LedArray(this)"></s:select>
							</div>
						</div>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal">
							<i class="fa fa-times-circle"></i> 取消
						</button>
						<button id="checkLedList" type="button"
							class="btn btn-custom-primary">
							<i class="fa fa-check-circle"></i> 确认
						</button>
					</div>
				</div>
				<!-- /.modal-content -->
			</div>
			<!-- /.modal-dialog -->
		</div>
		<!-- /.modal -->
		
		<div class="modal fade " id="deleteRenkanshu-modal-id">
			<div class="modal-dialog ">
				<div class="modal-content col-sm-12">
					<div class="modal-body " style="text-align:center">
						<form id="deleteRenkanshu_form" action="" class="form-horizontal" role="form">
							<input class="hidden" name="order.id">
							<div class="form-group">
								<label>确认删除所选订单吗？</label>
							</div>
							<div id="showorderdetail"></div>
						</form>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal">
							<i class="fa fa-times-circle"></i> 取消
						</button>
						<button id="ok" type="button" class="btn btn-custom-primary">
							<i class="fa fa-check-circle"></i> 确认
						</button>
					</div>
				</div>
				<!-- /.modal-content -->
			</div>
			<!-- /.modal-dialog -->
		</div>
		<!-- /.modal -->

	</div>
	<!--/.main-->
</body>
</html>
<content tag="scripts">
<script src="js/grid.locale-cn.js"></script>
<script>$.jgrid.useJSON = true;</script>
<script src="js/jquery.jqGrid.min.js"></script>
<script src="js/jquery.jqGrid.fluid.js"></script>
<script src="js/king-common.js"></script>
<script src="js/moment.js"></script>
<script src="js/daterangepicker.js"></script>
<script>
		var dateRangeSQL = "";
		var dateRangeSQLByDateStart = "";
		var dateRangeSQLByCreateDate = "";
		var startTime = "";
		var endTime = "";
		
		var ledArray = new Array();
		var ledNameArray = new Array();
		
		var t = $("#jqgrid");

		$(document).ready(function() {
			
			//时间范围控件
			$("#daterange-default").daterangepicker({
				format: 'YYYY/MM/DD',
				showDropdowns: !0,
				language: 'zh-CN',
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
			  dateRangeSQLByDateStart = "";
			  dateRangeSQLByCreateDate = "";
			});
			$('#daterange-default').on('apply.daterangepicker', function(ev, picker) {
			  startTime = picker.startDate.format('YYYY-MM-DD');
			  endTime = picker.endDate.format('YYYY-MM-DD');
			  //console.log("start:"+startTime+"\nend:"+endTime);
			  dateRangeSQL = "o.enddate >= '"+picker.startDate.format('YYYY-MM-DD')+"' and o.startdate <= '"+picker.endDate.format('YYYY-MM-DD')+"' ";
			  dateRangeSQLByDateStart = "o.startdate >= '"+picker.startDate.format('YYYY-MM-DD')+"' and o.startdate <= '"+picker.endDate.format('YYYY-MM-DD')+"' ";
			  dateRangeSQLByCreateDate = "o.adcontract.createtime >= '"+picker.startDate.format('YYYY-MM-DD')+"' and o.adcontract.createtime <= '"+picker.endDate.format('YYYY-MM-DD')+"' ";
			});


		    function e() {
		        t.length > 0 && t.fluidGrid({
		            base: "#jqgrid-wrapper",
		            offset: 0
		        })
		    } 

		    t.length > 0 && (t.jqGrid({
		    	url:"renkanshuManageList.action",
		    	mtype:"GET",
		    	datatype:"json",
		    	colNames:['上画点位','客户','发布内容','下单属性','频次','增加','时长','起止日期','时段','备注',''],
		    	height:400,
		    	rowNum:'<s:property value="@com.nfledmedia.sorm.cons.CommonConstant@DEFAULT_PAGE_SIZE"/>',
		    	rowList: [10, 20, 30],
        		pager: "jqgrid-pager",
        		multiselect:!1,
        		editurl:"deleteOrder.action",
        		sortname:"led.name",
        		sortorder: "asc",
        		viewrecords: !0,
        		colModel:[{
        			name:"led",
        			index:"led",
        			align:"center",
        	 		width:"100px"
        		},{
        			name:"client",
        			index:"client",
        			align:"center",
        			width:"130px" 
        		},{
            		name:"content",
            		index:"content",
            		align:"center",
            		width:"100px"
            	},{
            		name:"attribute",
            		index:"attribute",
            		align:"center",
            		width:"100px"
            	},{
        			name:"frequency",
        			index:"frequency",
        			align:"center",
        			width:"80px" 
        		},{
        			name:"addfreq",
        			index:"addfreq",
        			align:"center",
        			width:"80px" 
        		},{
        			name:"duration",
        			index:"duration",
        			align:"center",
        			width:"80px" 
        		},{
        			name:"daterange",
        			index:"daterange",
        			align:"center",
        			width:"130px" 
        		},{
        			name:"timerange",
        			index:"timerange",
        			align:"center",
        			width:"130px" 
        		},{
        			name:"remark",
        			index:"remark",
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
       			    //console.log(ids[i]);
        			    update = '<button class="btn btn-primary btn-xs" data-target="'+ids[i]+'" onclick="updateRenkanshu(this)">修改</button>';
        			    de = '<button class="btn btn-danger btn-xs" data-target="'+ids[i]+'" onclick="deleteRenkanshu(this)">删除</button>';
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
				    	searchFilter = " where o.state='" + "<s:property value='@com.nfledmedia.sorm.cons.TypeCollections@ORDER_STATE_ACTIVE'/>" + "' and "+dateRangeSQL+" (o.adcontract.client like '%"+searchFilter+
				    	"%' or o.adcontract.agency like '%"+searchFilter+"%' or o.content like '%"+searchFilter+"%' or o.led.name like '%"+searchFilter+"%')";
			    		//console.log(searchFilter);
			    		t[0].p.search = true;
			    		$.extend(t[0].p.postData,{searchString:searchFilter,searchField:"allfieldsearch",searchOper:"cn"});
			    	}
			    	t.trigger("reloadGrid",[{page:1,current:true}]);
		    });
		    
		    //精确查询
		    $("#exactQuery").click(function(){
		    	var sthcond = $("#timecondition").val();
		    	switch(sthcond){
		    		case "0":
  						exactQuery();
  						break;
					case "1":
  						exactQueryByDateStart();
  						break;
					case "2":
  						exactQueryByCreateDate();
 						break;
				}
		    });
		    
		    $("#clearExactForm").click(function(){
				location.reload();
				return false;
			});
			
			loadingClient();
		});
		
			function exactQuery(){	   
		    	var client = $.trim($("#client").val());
		    	var ledname = $.trim($("#ledlist").val()); 	
		    	if(dateRangeSQL === "" && client === "" && ledname ===""){
		    		t[0].p.search = false;
		    		$.extend(t[0].p.postData,{searchString:"",searchField:"",searchOper:""});
		    	}else{
		    		var searchFilter="  where o.state='"+ "<s:property value='@com.nfledmedia.sorm.cons.TypeCollections@ORDER_STATE_ACTIVE'/>" +"' and (";
		    		if(ledname !== "" ){
		    			searchFilter += " o.led.name ='"+ledname+"' and ";
		    		}
		    		if(client !== "" ){
		    			searchFilter += " o.adcontract.client like '%"+client+"%' or o.adcontract.agency like '%"+client+"%' and ";
		    		}
		    		if(dateRangeSQL !== ""){
		    			searchFilter += " "+ dateRangeSQL;
		    		}else{
		    			searchFilter = searchFilter.substring(0,searchFilter.lastIndexOf('and '));
		    		}
		    		searchFilter += ")";
		    		//console.log(searchFilter);
		    		t[0].p.search = true;
		    		$.extend(t[0].p.postData,{searchString:searchFilter,searchField:"allfieldsearch",searchOper:"cn"});
		    	}
		    	t.trigger("reloadGrid",[{page:1,current:true}]);
		    	return false;
		    }

		    function exactQueryByDateStart(){
		    	var client = $.trim($("#client").val());
		    	var ledname = $.trim($("#ledlist").val()); 	
		    	if(dateRangeSQL === "" && client === "" && ledname ===""){
		    		t[0].p.search = false;
		    		$.extend(t[0].p.postData,{searchString:"",searchField:"",searchOper:""});
		    	}else{
		    		var searchFilter="  where o.state='"+ "<s:property value='@com.nfledmedia.sorm.cons.TypeCollections@ORDER_STATE_ACTIVE'/>" +"' and (";
		    		if(ledname !== "" ){
		    			searchFilter += " o.led.name ='"+ledname+"' and ";
		    		}
		    		if(client !== "" ){
		    			searchFilter += " o.adcontract.client like '%"+client+"%' or o.adcontract.agency like '%"+client+"%' and ";
		    		}
		    		if(dateRangeSQL !== ""){
		    			searchFilter += " "+ dateRangeSQLByDateStart;
		    		}else{
		    			searchFilter = searchFilter.substring(0,searchFilter.lastIndexOf('and '));
		    		}
		    		searchFilter += ")";
		    		//console.log(searchFilter);
		    		t[0].p.search = true;
		    		$.extend(t[0].p.postData,{searchString:searchFilter,searchField:"allfieldsearch",searchOper:"cn"});
		    	}
		    	t.trigger("reloadGrid",[{page:1,current:true}]);
		    	return false;
		    }
		    
		    function exactQueryByCreateDate(){
		    	var client = $.trim($("#client").val());
		    	var ledname = $.trim($("#ledlist").val()); 	
		    	if(dateRangeSQL === "" && client === "" && ledname ===""){
		    		t[0].p.search = false;
		    		$.extend(t[0].p.postData,{searchString:"",searchField:"",searchOper:""});
		    	}else{
		    		var searchFilter="  where o.state='"+ "<s:property value='@com.nfledmedia.sorm.cons.TypeCollections@ORDER_STATE_ACTIVE'/>" +"' and (";
		    		if(ledname !== "" ){
		    			searchFilter += " o.led.name ='"+ledname+"' and ";
		    		}
		    		if(client !== "" ){
		    			searchFilter += " o.adcontract.client like '%"+client+"%' or o.adcontract.agency like '%"+client+"%' and ";
		    		}
		    		if(dateRangeSQL !== ""){
		    			searchFilter += " "+ dateRangeSQLByCreateDate;
		    		}else{
		    			searchFilter = searchFilter.substring(0,searchFilter.lastIndexOf('and '));
		    		}
		    		searchFilter += ")";
		    		//console.log(searchFilter);
		    		t[0].p.search = true;
		    		$.extend(t[0].p.postData,{searchString:searchFilter,searchField:"allfieldsearch",searchOper:"cn"});
		    	}
		    	t.trigger("reloadGrid",[{page:1,current:true}]);
		    	return false;
		    }

		function deleteRenkanshu(target){
			var orderdetaildata = "上画点位："+$(target).parents("tr").children("td:nth-child(1)").text()+"<br>";
			orderdetaildata += "客户："+$(target).parents("tr").children("td:nth-child(2)").text()+"<br>";
			orderdetaildata += "发布内容："+$(target).parents("tr").children("td:nth-child(3)").text()+"<br>";
			orderdetaildata += "频次："+$(target).parents("tr").children("td:nth-child(4)").text()+"<br>";
			orderdetaildata += "时长："+$(target).parents("tr").children("td:nth-child(6)").text()+"<br>";
			orderdetaildata += "起止日期："+$(target).parents("tr").children("td:nth-child(7)").text()+"<br>";
			orderdetaildata += "起止时间："+$(target).parents("tr").children("td:nth-child(8)").text()+"<br>";
			var target = $(target).data("target");
			if(target==null || target==""){
				return;
			}
			$("input[name='order.id']").val(target);
			
			$("#showorderdetail").html(orderdetaildata);
			$("#deleteRenkanshu-modal-id").modal('show');
		}
		
 		$("#ok").click(function(){
        	$.ajax({
        		url:"deletethisOrder.action",
        		data:$("#deleteRenkanshu_form").serializeArray(),
        		type:"post",
        		dataType:"json",
        		success:function(data){
        			if(data.state===0){
        				alert(data.info);
        				location.replace("renkanshuManage");
        			}else{
        				alert('操作失败，未知原因');
        			}
        		},
        		error:function(XMLHttpRequest, textStatus, errorThrown){
						alert('操作失败\nXMLHttpRequest.readyState['+XMLHttpRequest.readyState+']\nXMLHttpRequest.status['+XMLHttpRequest.status+']\ntextStatus['+textStatus+']');
				}
        	})
        	$("#deleteRenkanshu-modal-id").modal('hide');
        });
        

        $("#exportExcel").click(function(){
        	var led = $.trim($("#ledlist").val());
        	//判断时间和屏幕是否选择
        	if("" != startTime && "" != endTime && "" != led){
				var url = "publishResourceExport.action?startTime="+startTime+"&endTime="+endTime+"&ledId="+led;
				//console.log(url);
				$("#jqgrid").jqGrid('excelExport',{url:url});
        	}else {
        		alert("请选定起止日期和屏幕！");
        	}

		});
		
		$("#exportContentStatisticExcel").click(function(){
			var led = $.trim($("#ledlist").val());
        	//判断时间和屏幕是否选择
        	if("" != startTime && "" != endTime){
				var url = "adcontentStatisticExport.action?startTime="+startTime+"&endTime="+endTime+"&ledId="+led;
				//console.log(url);
				$("#jqgrid").jqGrid('excelExport',{url:url});
        	}else {
        		alert("请选定起止日期！");
        	}

		});
		
		$("#exportContentArrangementExcel").click(function(){
			$("#chooseLeds").modal('show');

		});
        
        $("#checkLedList").click(function(){
        	//判断时间和屏幕是否选择
        	if("" != startTime && "" != endTime && ledArray.length != 0){
				var url = "publishArrangementExport.action?startTime="+startTime+"&endTime="+endTime;
				for(var i=0;i<ledArray.length;i++){
        			url += "&ledsArray="+ledArray[i];
        		}
				//console.log(url);
				$("#jqgrid").jqGrid('excelExport',{url:url});
        	}else {
        		alert("请选定起止日期和屏幕！");
        	}
        	$("#chooseLeds").modal('hide');
        });
        
        function addLed2LedArray(obj){
        	var ledid = $(obj).val();
        	var ledname = $(obj).find("option:selected").text(); 
        	if($.inArray(ledname, ledNameArray) == -1 && ledid.length > 0){
        		ledArray.push(ledid);
        		ledNameArray.push(ledname);
        	}
        	var divshow = $("#showSelectedLeds");
            divshow.text("");// 清空数据
        	for(var i=0;i<ledNameArray.length;i++){
        		var buttonStr = "<button type='button' class='btn btn-primary btn-sm'>"+ledNameArray[i]+"</button>"
                divshow.append(buttonStr); // 添加Html内容
        	}
        
        }
        
		function updateRenkanshu(target){
			var target =$(target).data("target");
			if(target==null||target==""){
				return;
			}
			$("input[name='orderid']").val(target);
			$("#updateRenkanshuForm").submit();
		}
		    
		    $("#ledlist").append("<s:iterator value='#ledList' id='led'>");
		    $("#ledlist").append("<option value='<s:property value='name'/>'><s:property value='name'/></option>");
		    $("#ledlist").append("</s:iterator>");
			
		function loadingClient(){		 
			 $.ajax({
			  		type:"post",
			  		dataType:"json",
			  		url:"getAllClients.action",
			  		success:function(data){
			  			var jsonData = data.clients;
			  			for(var i=0, n = jsonData.length;i<n;i++){
			  				//console.log(jsonData[i]);
			  				$("#client").append("<option value='"+jsonData[i]+"'>"+jsonData[i]+"</option>");		
			  			}
						$("#client").selectpicker('refresh');
						//$("#client").selectpicker('render');
			  		}
			  });	
		}
		
	</script> </content>