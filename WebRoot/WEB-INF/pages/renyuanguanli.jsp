<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="com.google.gson.*"%>
<%@ page import="java.sql.*"%>
<%@ taglib uri="/struts-tags" prefix="s"%>

<!DOCTYPE HTML">
<html>
<head>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<link rel="icon" href="images/logo.png" type="image/x-icon" />
<link rel="shortcut icon" href="images/logo.png" type="image/x-icon" />
<link href="css/jquery-ui-1.8.21.custom.css" rel="stylesheet">
<link href="css/bootstrap.min.css" rel="stylesheet" media="screen">
<link href="css/bootstrap-table.css" rel="stylesheet">
<link href="css/jquery-confirm.min.css" rel="stylesheet">

<link rel="stylesheet" href="css/bootstrap-theme.css">
<link href="css/styles.css" rel="stylesheet">
<link href="css/laydate.css" rel="stylesheet">

<!--Icons-->
<script src="js/lumino.glyphs.js"></script>
<script src="js/jquery-1.8.3.min.js"></script>
<script src="js/jquery-confirm.min.js"></script>
<script src="js/bootstrap-table.js"></script>

</head>
<body style="font-family: '微软雅黑';">

	<div class="main">
	
		<!--/.row-->

		<div class="row">
			<div class="col-lg-12">
				<h3 class="page-header">
					人员管理
					</h3>
			</div>
		</div>
		<!--/.row-->

		<div class="row">
			<div class="col-lg-12">
				<div class="panel panel-default">
					<div class="panel-body">
						<div id="add-renyuan" class="row">
							&nbsp;&nbsp;<a href="addUser.action" class="btn btn-link btn-lg"><span
								class="glyphicon glyphicon-plus"></span> 添加人员
							</a>
						</div>
					</div>
					<div class="col-sm-3 pull-right">
				<div id="fuzzySearchbox" class="input-group input-group-sm searchbox">
					<input type="search" id="searchText" class="form-control" placeholder="请输入关键字...">
					<span class="input-group-btn">
						<button class="btn btn-default" type="button" id="searchButton">搜索</button>
					</span>
				</div>
			</div>
		
		<form class="form-horizontal" role="form" id="exactForm">
			<fieldset>
				<legend>&nbsp;&nbsp;查询条件</legend>
			<div class="col-sm-3">
					<div class="input-group input-group-sm">
						<div class="input-group-addon">部门</div>				
						<select  name="department" id="department" class="form-control">
							<option value="">所有部门</option>			
						</select>
					</div>
			</div>
			<div class="col-sm-3">
					<div class="input-group input-group-sm">
						<div class="input-group-addon">角色</div>				
						<select  name="role" id="role" class="form-control">
							<option value="">所有角色</option>			
						</select>
					</div>
			</div>				
			<div class="col-sm-3">
				<button class="btn btn-primary btn-sm" id="exactQuery">查询</button>
				<button class="btn btn-danger btn-sm" id="clearExactForm">清除</button>
			</div>
			<div class="col-sm-12"><lable>&nbsp;</lable></div>
			</fieldset>
		</form>
		
		<table id="jqgrid" class="table table-striped table-hover" ></table>
		<div id="jqgrid-pager"></div>
		
		<div class="col-sm-12"><lable>&nbsp;</lable></div>
		<div class="form-group" >
			<a class="btn btn-link btn-sm" id="addYwymubiao" onclick="addYwymubiao()">
			<span class="glyphicon glyphicon-plus" ></span> 添加业务目标</a>
		</div>
		<div class="col-sm-12"><lable>&nbsp;</lable></div>
		
		
		<div class="modal fade" id="addYwymubiao-modal">
		<div class="modal-dialog ">
			<div class="modal-content">
				<div class="modal-header h4">添加业务目标</div>
				<div class="modal-body " style="text-align:center">
					<form id="formAddYwymubiao" class="form-horizontal" role="form">
					
						<div class="form-group">
										
						   <label for="account" class="col-sm-3 control-label">业务员</label>
							   <div class="col-sm-3"><select class="form-control input-sm" name="bumen" id="bumen_id" onchange="changeyewuyuan(this.value)">
									<s:iterator value="bumens">
										<option value='<s:property value="bmId"/>'><s:property value="bmMingcheng"/></option>
									</s:iterator>
								</select></div>
								<div class="col-sm-3">
							    <select class="form-control input-sm" name="goalYwyId" id="Ywymubiao_goalYwy_id">
									<s:iterator value="yewuyuans" var="thisyewuyuan">
										<option value='<s:property value="ywyId"/>'><s:property value="ywyXingming"/></option>
									</s:iterator>
								</select>
							</div>
						</div>
						
						<div class="form-group">
							<label for="account" class="col-sm-3 control-label">年份<span class="text-danger">*</span></label>
							<div class="col-sm-4"><input type="number" class="form-control input-sm" name="ywymubiao.goalNiandu"  maxlength="20" ></div>
						</div>
						<div class="form-group">
							<label for="account" class="col-sm-3 control-label">业务目标<span class="text-danger">*</span></label>
							<div class="col-sm-4"><input type="number" class="form-control input-sm" name="ywymubiao.goalMubiao"  maxlength="20" >
							</div>
							<label class="col-sm-1 control-label">元</label>
						</div>
						<div class="form-group">
							<label for="account" class="col-sm-3 control-label">已完成金额</label>
							<div class="col-sm-4"><input type="number" class="form-control input-sm" name="ywymubiao.goalFinished"  maxlength="20" >
							</div>
							<label class="col-sm-1 control-label align-left" >元</label>
						</div>
						
				 		<div class="form-group">
							<label for="account" class="col-sm-3 control-label">完成率</label>
							<div class="col-sm-4"><input type="number" class="form-control input-sm" name="ywymubiao.goalWanchenglv"  maxlength="20" ></div>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button id="addYwymubiao-ok" class="btn btn-success"><i class="fa fa-check-circle"></i>确认</button>
					<button class="btn btn-danger" data-dismiss="modal"><i class="fa fa-times-circle"></i>取消</button>
				</div>
			</div><!-- /.modal-content -->
		</div><!-- /.modal-dialog -->
	</div><!-- /.modal -->
		
	 				</div>
				</div>
			</div>
		</div>

		<!--/.row-->
	</div>
	<!--/.main-->
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
	
	
	function changeyewuyuan(obj) {
		var selectbumenid = obj;
		if(selectbumenid == "") {
			$("#Ywymubiao_goalYwy_id").empty();
		} else {
			$.ajax({
				type : "post",
				dataType : "json",
				url : "fillYewuyuanList.action",
				data : {
					selectbumenid : selectbumenid
				},//提交参数
				success : function(data) {
					var jsonData = data.yewuyuanback;
					$("#Ywymubiao_goalYwy_id").empty();
					for (var i = 0, n = jsonData.length; i < n; i++) {
						$("#Ywymubiao_goalYwy_id").append("<option  value='"+jsonData[i].ywyId+"'>" + jsonData[i].ywyXingming + "</option>");
					}
				}
			});
		}
	}
	function formatUsername (cellvalue, options, rowObject){
		if(cellvalue.id == null){
			return "";
		}
//		return "<a  target='_blank' href='userUpdate.action'>"+cellvalue.name+"</a>";
		return "<a  target='_blank' href='userUpdate.action?ywyId="+cellvalue.id+"'>"+cellvalue.name+"</a>";
		
	}
	
	function deleteUser(uid, name) {
		$.confirm({
		    title: "删除用户",
		    content: "确认删除用户[" + name + "]吗？",
		    buttons: {
		       	删除: {
		       		btnClass: 'btn-danger',
		       		action: function() {
			        	$.ajax({
					  		type: "GET",
					  		dataType: "json",
					  		data: {"yewuyuan.ywyId": uid},
					  		url: "deleteUser",
					  		success: function(data) { 	
								$.dialog({
						    		title: '提示',
						    		content: '删除成功！',
								});
								$("#jqgrid").setGridParam({url: "userlist"}).trigger("reloadGrid");
					  		},
					  		error: function() {
					  			alert("error");
					  		}
						});
			        }
		       	},
				取消: function () {},
		    }
		})
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
	    	url:"userlist.action",
	    	mtype:"GET",
	    	datatype:"json",
	    	colNames:['id','用户名','姓名','部门','角色',''],
	 //   	shrinkToFit:false,
	    	height:320,
	    	rowNum:<s:property value="@com.nfledmedia.sorm.cons.CommonConstant@DEFAULT_PAGE_SIZE"/>,
	    	rowList: [10, 20, 30],
       		pager: "jqgrid-pager",
       		multiselect: !0,
//       		editurl:"deleteMessage.action",
       		sortname:"ywyId",
       		sortorder: "asc",
       		viewrecords: !0,
       		colModel:[{
       			name:"yid",
       			index:"yid",
       			width:"0%"
       		},{
       			name:"username",
       			index:"username",
       			sortable:!1,
       			search:!1,
       			align:"center",
       	 		width:"15%",
       	 		formatter:formatUsername 
       		},{
       			name:"name",
       			index:"name",
       			align:"center",
       	 		width:"20%"
       		},{
       			name:"department",
       			index:"department",
       			align:"center",
       	 		width:"20%"
       		},{
       			name:"role",
       			index:"role",
       			align:"center",
       			width:"20%" 
       		},{
       			name:"actions",
       			sortable: !1,
       			search: !1,
       			align:"center",
       			width:"10%"
       		}],
       		//['年度','目标金额','已完成','完成率']
       		subGrid : true,
			subGridUrl: "ywyMubiaolist.action",
		    subGridModel: [{ name  : ['年度','目标金额','已完成','完成率'], 
		                    width : [55,100,100,80],
							params:['yid']}] ,
       		loadComplete: function(data){
       			console.log(data.rows[0].cell[0].id);
       			var ids = t.jqGrid("getDataIDs");
       			for(var i=0;i < ids.length;i++){
       			    //console.log(ids[i]);
       			   	de = "<button class='btn btn-danger btn-xs' onclick='deleteUser(" + data.rows[ids[i]-1].cell[0].id + ",\"" + data.rows[ids[i]-1].cell[1] + "\")'>删除</button>";
       			   	console.log(de);
       				t.jqGrid('setRowData',ids[i],{actions:de});
       				var hasRead = t.jqGrid("getCell",ids[i],'hasRead');
       				if(hasRead === "false"){
       					$("#"+ids[i]).css("background","#fcfcfc").find("td").css("font-weight",700);
       				}
       			}
       		}
	    }), e(), $("#jqgrid").length > 0 && t.jqGrid("navGrid","#jqgrid-pager",{
	    	add:!1,
	    	edit:!1,
	    	del:!1,
	    	view:!1,
	    	search: !1,
       		refresh:!1
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
			    	searchFilter = " where "+" (y.username like '%"+searchFilter+"%' or y.ywyXingming like '%"+searchFilter+
			    	"%' or y.bumen.bmMingcheng like '%"+searchFilter+"%' or y.role.name like '%"+searchFilter+"%')";
		    		console.log(searchFilter);
		    		t[0].p.search = true;
		    		$.extend(t[0].p.postData,{searchString:searchFilter,searchField:"allfieldsearch",searchOper:"cn"});
		    	}
		    	t.trigger("reloadGrid",[{page:1,current:true}]);
	    });
	    
	    //精确查询
	    $("#exactQuery").click(function(){
	    	var role = $.trim($("#role").val());
	    	var department = $.trim($("#department").val());  	
	    	if(department === ""&& role === ""){
	    		t[0].p.search = false;
	    		$.extend(t[0].p.postData,{searchString:"",searchField:"",searchOper:""});
	    	}else{
	    		var searchFilter=" where(";
	    		if(department !== "" ){
	    			searchFilter += "  y.bumen.bmMingcheng like '%"+department+"%' and ";
	    		}
	    		if(role !== ""){
	    			searchFilter += "  y.role.name like '%"+role+"%' and ";
	    		}
	    		searchFilter = searchFilter.substring(0,searchFilter.lastIndexOf('and '));
	    		searchFilter += ")";;
	    		console.log(searchFilter);
	    		t[0].p.search = true;
	    		$.extend(t[0].p.postData,{searchString:searchFilter,searchField:"allfieldsearch",searchOper:"cn"});
	    	}
	    	t.trigger("reloadGrid",[{page:1,current:true}]);
	    	return false;
	    });
	    $("#clearExactForm").click(function(){
	        $("#department").val("");
	        $("#role").val("");
	        $("#searchText").val("");
			$("#searchButton").click();
			return false;
		});
	});
	
	function addYwymubiao() {
		$("#addYwymubiao-modal").modal('show');
		$("#addYwymubiao-ok").click(function(){
			if($("input[name='ywymubiao.goalNiandu']").val()=="" ||
				//$("select[name='industryId']").val()=="" ||
				$("input[name='ywymubiao.goalMubiao']").val()=="")
			{
				alert("年份和业务目标不能为空！");
				return;
			}else{
				$.ajax({
					url:"addYwymubiao.action",
					type:"post",
					data:$("#formAddYwymubiao").serializeArray(),
					dataType:"json",
					success:function(data){
						 alert(data.info);
						$("#addYwymubiao-modal").modal('hide');
					},error:function(XMLHttpRequest, textStatus, errorThrown){
						alert('保存失败\nXMLHttpRequest.readyState['+XMLHttpRequest.readyState+']\nXMLHttpRequest.status['+XMLHttpRequest.status+']\ntextStatus['+textStatus+']');
					}
				})
			}
		})
	}
	function loadingDepartment(){		 
		 $.ajax({
		  		type:"post",
		  		dataType:"json",
		  		url:"getAllDepartment.action",
		  		success:function(data){ 	
		  			var jsonData = data.info;
		  			for(var i=0, n = jsonData.length;i<n;i++){
		  				$("#department").append("<option  value='"+jsonData[i][1]+"'>"+jsonData[i][1]+"</option>");		
		  			}
		  		}
		  });	
	}
	function loadingRole(){		 
		 $.ajax({
		  		type:"post",
		  		dataType:"json",
		  		url:"getAllRole.action",
		  		success:function(data){ 	
		  			var jsonData = data.info;
		  			for(var i=0, n = jsonData.length;i<n;i++){
		  				$("#role").append("<option  value='"+jsonData[i][1]+"'>"+jsonData[i][1]+"</option>");		
		  			}
		  		}
		  });	
	}
	$(function(){
		loadingDepartment();
		loadingRole();
	});	
	</script>
</content>