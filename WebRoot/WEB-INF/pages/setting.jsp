<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<s:i18n name="contentMessage.profile">
<html>
<head>
<meta charset="utf-8">
<title><s:text name="设置" /></title>
<meta http-equiv="expires" content="0">
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<link rel="icon" href="images/logo.png" type="image/x-icon" />
<link rel="shortcut icon" href="images/logo.png" type="image/x-icon" />
<link href="css/bootstrap.min.css" rel="stylesheet" media="screen">
<link href="css/bootstrap-table.css" rel="stylesheet">
<link rel="stylesheet" href="css/bootstrap-theme.css">
<link href="css/jquery-ui.min.css" rel="stylesheet" media="screen">
<link href="css/jquery-confirm.min.css" rel="stylesheet">
<link href="css/styles.css" rel="stylesheet">
<link href="css/laydate.css" rel="stylesheet">

<!--Icons-->
<script src="js/lumino.glyphs.js"></script>
<script src="js/jquery-1.11.1.min.js"></script>
<script src="js/bootstrap.min.js"></script>
<script src="js/jquery-ui.min.js"></script>
<script src="js/bootstrap-table.js"></script>
<script src="js/jquery-confirm.min.js"></script>
</head>
<body style="font-family: '微软雅黑';">
	<div class="main">
		<div class="row">
			<label> </label>
		</div>
		<div class="row">
			<label> </label>
		</div>
		<div id="changepw-tab">
			<form action="" class="form-horizontal" role="form"
				id="form_password">
				<div class="form-group">
					<label for="old password" class="col-sm-3 control-label">旧密码
						<span class="text-danger">*</span>
					</label>
					<div class="col-sm-4">
						<input type="password" class="form-control input-sm"
							name="oldPassword">
					</div>
				</div>
				<hr>
				<div class="form-group">
					<label for="new password" class="col-sm-3 control-label">新密码
						<span class="text-danger">*</span>
					</label>
					<div class="col-sm-4">
						<input type="password" class="form-control input-sm"
							name="newPassword">
					</div>
				</div>
				<div class="form-group">
					<label for="repeat password" class="col-sm-3 control-label">重复密码
						<span class="text-danger">*</span>
					</label>
					<div class="col-sm-4">
						<input type="password" class="form-control input-sm"
							name="repeatedNewPassword">
					</div>
				</div>
			</form>
			<p class="text-center">
				<button class="btn btn-custom-primary btn-sm" id="submit_password">
					<i class="fa fa-floppy-o"></i> 保存
				</button>
			</p>
		</div>
	</div>
	</div>
</body>
</html>
<content tag="scripts">
	<script src="js/jquery.maxlength.js"></script>
	<script src="js/jquery-confirm.min.js"></script>
	<script src="js/jquery.jqGrid.min.js"></script>
	<script src="js/jquery.jqGrid.fluid.js"></script>
	<script src="js/king-common.js"></script>
	<script src="js/moment.js"></script>
	<script>
		$(document).ready(function(){
			$("#submit_password").click(function(){
				var $oldPassword = $("input[name='oldPassword']");
				var $newPassword = $("input[name='newPassword']");
				var $repeatedNewPassword = $("input[name='repeatedNewPassword']");
				if($oldPassword.val() == ""){
					$.alert("旧密码不能为空");
					$oldPassword.focus();
					return;
				}
				if($newPassword.val() == ""){
					$.alert("新密码不能为空");
					$newPassword.focus();
					return;
				}
				if($repeatedNewPassword.val() == ""){
					$.alert("重复密码不能为空");
					$repeatedNewPassword.focus();
					return;
				}
				$.ajax({
					url:"updateMyPassword.ajax",
					type:"post",
					data:$("#form_password").serializeArray(),
					dataType:"json",
					success:function(data){
						$.alert(data.info);
						$("#form_password")[0].reset();
					},
					error:function(data){
						$.alert('修改密码失败');
					}
				})
			})
		});
	</script>
</content>
</s:i18n>