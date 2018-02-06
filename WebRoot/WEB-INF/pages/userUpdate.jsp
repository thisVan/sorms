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
<link href="css/jquery-ui.structure.min.css" rel="stylesheet" media="screen">
<link href="css/jquery-ui.theme.min.css" rel="stylesheet" media="screen">


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
					人员修改
					</h1>
			</div>
		</div>
		<!--/.row-->
		<div class="row">
			<div class="col-lg-12">
				<div align="center" style="font-size: large;color: red">${session.erromessage }</div>
			</div>
			<div class="col-lg-12">
				<div class="panel panel-default">
					<div class="panel-body">
						<div class="col-lg-12 col-md-6">
						
			<form id="form_save" class="form-horizontal" role="form">
				
				<input type="text" class="hidden" name="yewuyuan.ywyId" id="yewuyuan_id" value='<s:property value="yewuyuan.ywyId"/>'>
				
				<div class="form-group" style="margin-bottom:0;">
					<label for="account" class="col-sm-2 control-label"></label>
					<div class="col-sm-4">
						<ul id="accountCheck" class="text-danger hidden" style="margin-bottom:0;"><li><span></span></li></ul>
					</div>
				</div>
				
				<div class="form-group">
					<label for="account" class="col-sm-2 control-label">账号<span class="text-danger">*</span></label>
					<div class="col-sm-4"><input type="text" class="form-control input-sm" name="yewuyuan.username"  value='<s:property value="yewuyuan.username"/>'maxlength="20" onpropertychange="checkAccount(this.value)" oninput="checkAccount(this.value)"></div>
				</div>
				
				<div class="form-group" style="margin-bottom:0;">
					<label for="name" class="col-sm-2 control-label"></label>
					<div class="col-sm-4">
						<ul id="nameCheck" class="text-danger hidden" style="margin-bottom:0;"><li><span></span></li></ul>
					</div>
				</div>
				
				<div class="form-group">
					<label for="name" class="col-sm-2 control-label">姓名<span class="text-danger">*</span></label>
					<div class="col-sm-4"><input type="text" placeholder="请输入姓名" class="form-control input-sm" name="yewuyuan.ywyXingming" value='<s:property value="yewuyuan.ywyXingming"/>'maxlength="20" onpropertychange="checkName(this.value)" oninput="checkName(this.value)"></div>
				</div>
				
				<div class="form-group">
					<label for="role" class="col-sm-2 control-label">角色</label>
					<div class="col-sm-4">
						<select class="form-control input-sm" name="yewuyuan.role.id" id="role_id">
							<s:iterator value="#request.roles">
								<option value='<s:property value="[0].top[0]"/>'><s:property value="[0].top[1]"/></option>
							</s:iterator>
						</select>
					</div>
				</div>
				
				<div class="form-group">
					<label for="department" class="col-sm-2 control-label text-left">部门</label>
					<div class="col-sm-4">
						<select class="form-control input-sm" name="yewuyuan.bumen.bmId" id="department_id">
							<s:iterator id="dep" value="#request.departments">
							<option value='<s:property value="[0].top[0]"/>'><s:property value="[0].top[1]"/></option>	
							</s:iterator>
						</select>
					</div>
				</div>	
			</form>
		
			<div  class="form-group " id="showFukuanTable">
				<div class="col-sm-2"></div>
				<div class="col-sm-6">
					<table id="jqgrid_ywymubiao" style="font-family: '微软雅黑';"></table>
	    			<div id="jqgrid-pager_ywymubiao"></div>
				</div>
	    		
	  		</div>
	  		
		</div>
		<p class="text-center">
			<button type="button" class="btn btn-custom-primary btn-sm" id="back" onclick="goBack()" style="float:left;background:#AAAAAB;border:2px solid #e5e5e5;margin-left:40%;width:63px"></i>返回</button>
			<button type="button" class="btn btn-danger btn-sm" id="save" style="margin-right:40%"><i class="fa fa-floppy-o"></i> 保存</button>
		</p>
		
		<div class="modal fade" id="editYwymubiao-modal">
			<div class="modal-dialog ">
				<div class="modal-content">
					<div class="modal-header h4">添加业务目标</div>
					<div class="modal-body " style="text-align:center">
						<form id="formEditYwymubiao" class="form-horizontal" role="form">
							<div class="form-group hidden">
								<input type="number" class="form-control input-sm" name="mid"  id="mid" value='<s:property value="yewuyuan.ywyId"/>' maxlength="20" >
								<input type="number" class="form-control input-sm" name="yid"  id="Ywymubiao_goalYwy_id" value='<s:property value="yewuyuan.ywyId"/>' maxlength="20" >
							</div>
							
							<div class="form-group">
								<label for="account" class="col-sm-3 control-label">年份<span class="text-danger">*</span></label>
								<div class="col-sm-4"><input type="number" class="form-control input-sm" name="ywymubiao.goalNiandu" id="goalNiandu"  maxlength="20" ></div>
							</div>
							<div class="form-group">
								<label for="account" class="col-sm-3 control-label">业务目标<span class="text-danger">*</span></label>
								<div class="col-sm-4"><input type="number" class="form-control input-sm" name="ywymubiao.goalMubiao" id="goalMubiao"  maxlength="20" >
								</div>
								<label class="col-sm-1 control-label">元</label>
							</div>
							<div class="form-group">
								<label for="account" class="col-sm-3 control-label">已完成金额</label>
								<div class="col-sm-4"><input type="number" class="form-control input-sm" name="ywymubiao.goalFinished" id="goalFinished" maxlength="20" >
								</div>
								<label class="col-sm-1 control-label align-left" >元</label>
							</div>
							
					 		<div class="form-group">
								<label for="account" class="col-sm-3 control-label">完成率</label>
								<div class="col-sm-4"><input type="number" class="form-control input-sm" name="ywymubiao.goalWanchenglv" id="goalWanchenglv" maxlength="20" ></div>
							</div>
						</form>
					</div>
					<div class="modal-footer">
						<button id="editYwymubiao-ok" class="btn btn-success"><i class="fa fa-check-circle"></i>确认</button>
						<button class="btn btn-danger" data-dismiss="modal"><i class="fa fa-times-circle"></i>取消</button>
					</div>
				</div><!-- /.modal-content -->
			</div><!-- /.modal-dialog -->
		</div><!-- /.modal -->
	
	
	</div>
	</div>
	</div>
	</div>
	</div>
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
	<script>
	
	var accountValid = true;
	var nameValid = true;
	var role = '<s:property value="yewuyuan.role.id"/>';
	var department = '<s:property value="yewuyuan.bumen.bmId"/>';
	var yid='<s:property value="yewuyuan.ywyId"/>';
	//检查账号是否为空以及是否重复
	function checkAccount(value){
		if(value){
			$.ajax({
				url:"checkAccount.action?account="+value,
				type:"get",
				dataType:"json",					
				success:function(data){
					if(!data.info){
						$("#accountCheck span").text("账号已存在");
						$("#accountCheck").removeClass("hidden");
						accountValid = false;
					}else{
						$("#accountCheck").addClass("hidden");
						accountValid = true;
					}
				}
			})
		}else{
			$("#accountCheck").addClass("hidden");
		}
	}
	//检查姓名是否为空,在输入时能够立即判断出来，与下面的判断并不重复
	function checkName(value){
		if(value!=""){
			$("#nameCheck").addClass("hidden");
			nameValid = true;
		}else{
			$("#nameCheck span").text("姓名不能为空");
			$("#nameCheck").removeClass("hidden");
			nameValid = false;
		}
	}
	
	$(document).ready(function(){
	
	    $("#role_id").val(role);
		$("#department_id").val(department);
		
		 var ty = $("#jqgrid_ywymubiao");
		 function e_ywymubiao() {
                $("#jqgrid_ywymubiao").length > 0 && ty.fluidGrid({
                    base: "#jqgrid-wrapper_ywymubiao",
                    offset: 0
                });
         }
         //付款表
         $("#jqgrid_ywymubiao").length > 0 && (ty.jqGrid({
	        	caption:'业务目标',
	        	url:"ywyMubiaolistGrid.action?yid="+yid,
	        	mtype:"GET",
	        	styleUI: 'Bootstrap',//设置jqgrid的全局样式为bootstrap样式
	        	shrinkToFit:true,
	        	datatype:"json",
	        	colNames:['年度','目标金额','已完成','完成率',''],
	        	rowNum:<s:property value="@com.nfledmedia.sorm.cons.CommonConstant@DEFAULT_PAGE_SIZE"/>,
	        	rowList: [10, 20, 30],
	    		pager: "jqgrid-pager_ywymubiao",
	    		multiselect:!1,
	    		autowidth:true,
	    		sortname:"goalNiandu",
	    		sortorder: "asc",
	    		viewrecords: !0,
	    		colModel:[{
	    			name:"goalNiandu",
	    			index:"goalNiandu",
	    			align:"center",
	    	 		width:"100px"
	    		},{
	    			name:"goalMubiao",
	    			index:"goalMubiao",
	    			align:"center",
	    			width:"100px" 
	    		},{
	    			name:"goalFinished",
	    			index:"goalFinished",
	    			align:"center",
	    			width:"100px"
	    		},{
	    			name:"goalWanchenglv",
	    			index: "goalWanchenglv",
	    			align:"center",
	    			width:"100px"
	    		},{
       			name:"actions",
       			sortable: !1,
       			search: !1,
       			align:"center",
       			width:"100px"
       		}],
       	/* 	gridComplete: function(data){
        			var ids = $("#jqgrid").jqGrid("getDataIDs");
        			for(var i=0;i < ids.length;i++){
       			    console.log(ids[i]);
        			    update = '<button class="btn btn-primary btn-xs" data-target="'+ids[i]+'" onclick="updateRenkanshu(this)">修改</button>';
        			    de = '<button class="btn btn-danger btn-xs" data-target="'+ids[i]+'" onclick="deleteRenkanshu(this)">删除</button>';
        			    t.jqGrid('setRowData',ids[i],{actions:update+"  "+de});
        			}
        		} */
       		gridComplete: function(data){
       			var ids = ty.jqGrid("getDataIDs");
       			for(var i = 0; i < ids.length; i++){
       			    console.log(ids[i]);
       			    edit = '<div class="btn btn-primary btn-xs" data-target="'+ids[i]+'" onclick="editYwymubiao(this)">修改</div>';
       			    del = '<div class="btn btn-danger btn-xs" data-target="'+ids[i]+'" onclick="deleteYwymubiao(this)">删除</div>';
       				ty.jqGrid('setRowData',ids[i],{actions:edit + " " + del});
       			}
       		}
	        }), e_ywymubiao(), $("#jqgrid_fukuan").length > 0 && ty.jqGrid("navGrid","#jqgrid-pager_ywymubiao",{
	        	add:!1,
	        	edit:!1,
	        	del:!1,
	        	view:!1,
	        	search: !1,
	    		refresh:0
	        },{
	        	multipleSearch: true,
	        	multipleGroup:true
	        })),
        $(window).resize(e_ywymubiao);
		
		$("#save").click(function(){
			if(!$("input[name='yewuyuan.username']").val()){
				accountValid = false;
				$("#accountCheck span").text("账号不能为空");
				$("#accountCheck").removeClass("hidden");
			}
			if(!$("input[name='yewuyuan.ywyXingming']").val()){
				nameValid = false;
				$("#nameCheck span").text("姓名不能为空");
				$("#nameCheck").removeClass("hidden");
			}
			if(nameValid&&accountValid){				
				$.ajax({
					url:"updateUserInfo.action",
					type:"post",
					data:$("#form_save").serializeArray(),
					dataType:"json",
					success:function(data){						
						if(data.info){
							alert("更改成功");
							location.replace('renyuanguanli');
						}else{
							alert("更改失败");
						}
					},
					error:function(data){
						alert("更改失败");
					}
				});
			}
		});
		
/*		$("input[name='yewuyuan.username']").maxlength({
	    	maxCharacters:20,
	    	status:false,
        	showAlert:true,
        	alertText:"您输入的长度过长！"
	    })
	    $("input[name='yewuyuan.ywyXingming']").maxlength({
	    	maxCharacters:20,
	    	status:false,
        	showAlert:true,
        	alertText:"您输入的长度过长！"
	    })*/
	});
	
	
	function deleteYwymubiao(target) {
		var mid =$(target).data("target");
		$.ajax({
			url:"delYwymubiao.action",
			type:"post",
			data: {mid:mid},
			dataType:"json",
			success:function(data){
				 alert(data.info);
				 $("#jqgrid_ywymubiao").trigger('reloadGrid');
			},error:function(XMLHttpRequest, textStatus, errorThrown){
				alert('保存失败\nXMLHttpRequest.readyState['+XMLHttpRequest.readyState+']\nXMLHttpRequest.status['+XMLHttpRequest.status+']\ntextStatus['+textStatus+']');
			}
		});
	}
	
	function editYwymubiao(target) {
		var goalNiandu=new Array();
		var goalMubiao=new Array();
		var goalFinished=new Array();
		var goalWanchenglv=new Array();
		$("#editYwymubiao-modal").modal('show');
		var mid =$(target).data("target");
		$("#mid").val(mid);
		if(target==null||target==""){
			return;
		}
		$.ajax({
			url:"getYwymubiaoById.action",
			type:"post",
			data: {mid:mid},
			dataType:"json",
			success:function(data){ 	
	  			goalNiandu[0] = data.goalNiandu;
	  			goalMubiao[0] = data.goalMubiao;
	  			goalFinished[0] = data.goalFinished;
	  			goalWanchenglv[0] = data.goalWanchenglv;
	  			$("#goalNiandu").val(goalNiandu[0]);
	  			$("#goalMubiao").val(goalMubiao[0]);
	  			$("#goalFinished").val(goalFinished[0]);
	  			$("#goalWanchenglv").val(goalWanchenglv[0]);
  				
	  		}
		});
		
		$("#editYwymubiao-ok").click(function(){
/* 		    alert("#goalWanchenglv:"+$("#goalWanchenglv").val());
			alert("goalWanchenglv[0]:"+goalWanchenglv[0]);
		    alert($("#goalWanchenglv").val()==goalWanchenglv[0]); */
			if($("input[name='ywymubiao.goalNiandu']").val()=="" ||
				$("input[name='ywymubiao.goalMubiao']").val()=="")
			{
				alert("年份和业务目标不能为空！");
				return;
			}else if($("#goalNiandu").val()==goalNiandu[0]&&$("#goalMubiao").val()==goalMubiao[0]&&
			         $("#goalFinished").val()==goalFinished[0]&&$("#goalWanchenglv").val()==goalWanchenglv[0]){
		        alert("没有修改信息！");
				return;
			}else{
				$.ajax({
					url:"editYwymubiao.action",
					type:"post",
					data:$("#formEditYwymubiao").serializeArray(),
					dataType:"json",
					success:function(data){
						alert(data.info);
						$("#editYwymubiao-modal").modal('hide');
						$("#jqgrid_ywymubiao").trigger('reloadGrid');
					},error:function(XMLHttpRequest, textStatus, errorThrown){
						alert('保存失败\nXMLHttpRequest.readyState['+XMLHttpRequest.readyState+']\nXMLHttpRequest.status['+XMLHttpRequest.status+']\ntextStatus['+textStatus+']');
					}
				});
			}
		});
	}
	function goBack(){
		if(confirm("您确定要放弃相关操作，返回到用户列表中吗？")){
			location.replace('renyuanguanli');
		}
	}
</script>
</content>
