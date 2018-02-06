<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@page import="java.util.Date"%>
<%@taglib prefix="s" uri="/struts-tags"%>

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
<link href="css/jquery-confirm.min.css" rel="stylesheet">

<link rel="stylesheet" href="css/bootstrap-theme.css">
<link href="css/styles.css" rel="stylesheet">
<link href="css/laydate.css" rel="stylesheet">

<!--Icons-->
<script src="js/lumino.glyphs.js"></script><!-- 图标 -->
<script src="js/jquery-1.8.3.min.js"></script>
<script src="js/jquery-confirm.min.js"></script>
</head>
<body style="font-family: '微软雅黑;'">
	<div class="main">
	
		<!--/.row-->

 		<div class="row">
			<div class="col-lg-12">
				<h3 class="page-header">
					添加人员
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
		<div class="form-group" style="margin-bottom:0;">
			<label for="account" class="col-sm-2 control-label"></label>
			<div class="col-sm-4">
				<ul id="accountCheck" class="text-danger hidden" style="margin-bottom:0;"><li><span></span></li></ul>
			</div>
		</div>
		<div class="form-group">
			<label for="account" class="col-sm-2 control-label">账号<span class="text-danger">*</span></label>
			<div class="col-sm-4"><input type="text" placeholder="请输入账号" class="form-control input-sm" name="yewuyuan.username" maxlength="20" onpropertychange="checkAccount(this.value)" oninput="checkAccount(this.value)"></div>
		</div>
		<div class="form-group" style="margin-bottom:0;">
			<label for="name" class="col-sm-2 control-label"></label>
			<div class="col-sm-4">
				<ul id="nameCheck" class="text-danger hidden" style="margin-bottom:0;"><li><span></span></li></ul>
			</div>
		</div>
		<div class="form-group">
			<label for="name" class="col-sm-2 control-label">姓名 <span class="text-danger">*</span></label>
			<div class="col-sm-4"><input type="text" placeholder="请输入姓名" class="form-control input-sm" name="yewuyuan.ywyXingming" maxlength="20" onpropertychange="checkName(this.value)" oninput="checkName(this.value)"></div>
		</div>
		<div class="form-group">
			<label for="role" class="col-sm-2 control-label">角色</label>
			<div class="col-sm-4">
				<select class="form-control input-sm" name="yewuyuan.role.id">
					<s:iterator value="#request.roles">
						<option value='<s:property value="[0].top[0]"/>'><s:property value="[0].top[1]"/></option>
					</s:iterator>
				</select>
			</div>
		</div>
		
		<div class="form-group">
			<label for="department" class="col-sm-2 control-label">部门</label>
			<div class="col-sm-4">
				<select class="form-control input-sm" name="yewuyuan.bumen.bmId">
					<s:iterator id="dep" value="#request.departments">
					<option value='<s:property value="[0].top[0]"/>'><s:property value="[0].top[1]"/></option>	
					</s:iterator>
				</select>
			</div>
		</div>
	</form>
	<p class="text-center">
		<button type="button" class="btn btn-custom-primary btn-sm" id="back" onclick="goBack()" style="float:left;background:#AAAAAB;border:2px solid #e5e5e5;margin-left:40%;width:63px"></i>返回</button>
		<button type="button" class="btn btn-danger btn-sm" id="save" style="margin-left:-40%"><i class="fa fa-floppy-o"></i> 保存</button>
	</p>
	
		<!--/.main-->
	<script src="js/jquery-1.11.1.min.js"></script>
	<script src="js/bootstrap.min.js"></script>
	<script type="text/javascript" src="js/bootstrap-datetimepicker.js"></script>
	<script src="js/bootstrap-datetimepicker.zh-CN.js" charset="UTF-8"></script>
</body>
</html>
<content tag="scripts">
	<script src="js/king-common.js"></script>
	<script src="js/jquery.maxlength.js"></script>
	<script>
		var accountValid = true;
		var nameValid = false;
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
						url:"addUserInfo.action",
						type:"post",
						data:$("#form_save").serializeArray(),
						dataType:"json",
						success:function(data){
							if(data.info){
								alert("保存成功");
								location.reload();
							}else{
								alert("保存失败");
							}
						},
						error:function(data){
							alert("错误！保存失败");
						}
					})
				}
			})
			


			$("input[name='yewuyuan.username']").maxlength({
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
		    })
		})
		function goBack(){
			if(confirm("您确定要放弃相关操作，返回到用户列表中吗？")){
				location.replace('renyuanguanli');
			}
		}
	</script>
</content>
