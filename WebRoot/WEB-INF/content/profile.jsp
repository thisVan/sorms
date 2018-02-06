<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html>
<s:i18n name="contentMessage.profile">
<html>
<head>
<meta charset="utf-8">
<title><s:text name="title"/></title>
</head>
<body>
	<ul class="nav nav-tabs">
			<li class="active">
				<a href="#profile-tab" data-toggle="tab">
					<i class="fa fa-user"></i>个人信息
				</a>
			</li>
			<li>
				<a href="#changepw-tab" data-toggle="tab">
					<i class="fa fa-key"></i>修改密码
				</a>
			</li>
		</ul>
		<div class="tab-content profile-page">
			<div class="tab-pane active" id="profile-tab">
				<form action="" class="form-horizontal" role="form" id="form_info">
					<div class="form-group">
						<label for="account" class="col-sm-3 control-label">账号</label>
						<div class="col-sm-4"><p class="form-control-static"><s:property value="user.account"/></p></div>
					</div>
					<div class="form-group">
						<label for="name" class="col-sm-3 control-label">姓名</label>
						<div class="col-sm-4"><p class="form-control-static"><s:property value="user.name"/></p></div>
					</div>
					<div class="form-group">
						<label for="name" class="col-sm-3 control-label">部门</label>
						<div class="col-sm-4">
							<p class="form-control-static"><s:property value="user.department.name"/></p>
						</div>
					</div>
					<hr>
					<div class="form-group">
						<label for="email" class="col-sm-3 control-label">邮箱</label>
						<div class="col-sm-4"><input type="email" class="form-control input-sm" name="user.email" value='<s:property value="user.email"/>'></div>
					</div>
					<div class="form-group">
						<label for="手机" class="col-sm-3 control-label">手机</label>
						<div class="col-sm-4"><input type="text" class="form-control input-sm" name="user.cellphone" value='<s:property value="user.cellphone"/>'></div>
					</div>
				</form>
				<p class="text-center"><button class="btn btn-custom-primary btn-sm" id="sumbit_info"><i class="fa fa-floppy-o"></i> 保存</button></p>
			</div>
			<div class="tab-pane" id="changepw-tab">
				<form action="" class="form-horizontal" role="form" id="form_password">
					<div class="form-group">
						<label for="old password" class="col-sm-3 control-label">旧密码 <span class="text-danger">*</span></label>
						<div class="col-sm-4"><input type="password" class="form-control input-sm" name="oldPassword"></div>
					</div>
					<hr>
					<div class="form-group">
						<label for="new password" class="col-sm-3 control-label">新密码 <span class="text-danger">*</span></label>
						<div class="col-sm-4"><input type="password" class="form-control input-sm" name="newPassword"></div>
					</div>
					<div class="form-group">
						<label for="repeat password" class="col-sm-3 control-label">重复密码 <span class="text-danger">*</span></label>
						<div class="col-sm-4"><input type="password" class="form-control input-sm" name="repeatedNewPassword"></div>
					</div>
				</form>
				<p class="text-center"><button class="btn btn-custom-primary btn-sm" id="submit_password"><i class="fa fa-floppy-o"></i> 保存</button></p>
			</div>
		</div>
</body>
</html>
<content tag="scripts">
	<script src="js/king-common.js"></script>
	<script src="js/jquery.maxlength.js"></script>
	<script>
	$(document).ready(function(){
		$("#sumbit_info").click(function(){
			$.ajax({
				url:"updateMyInfo.ajax",
				type:"post",
				data:$("#form_info").serializeArray(),
				dataType:"json",
				success:function(data){
					if(data.state){
						alert("个人信息修改成功");
					}else{
						alert(data.info);
					}
				},
				error:function(data){
					alert('个人信息修改失败');
				}
			})
		});
		$("#submit_password").click(function(){
			var $oldPassword = $("input[name='oldPassword']");
			var $newPassword = $("input[name='newPassword']");
			var $repeatedNewPassword = $("input[name='repeatedNewPassword']");
			if($oldPassword.val() == ""){
				alert("旧密码不能为空");
				$oldPassword.focus();
				return;
			}
			if($newPassword.val() == ""){
				alert("新密码不能为空");
				$newPassword.focus();
				return;
			}
			if($repeatedNewPassword.val() == ""){
				alert("重复密码不能为空");
				$repeatedNewPassword.focus();
				return;
			}
			$.ajax({
				url:"updateMyPassword.ajax",
				type:"post",
				data:$("#form_password").serializeArray(),
				dataType:"json",
				success:function(data){
					alert(data.info);
					$("#form_password")[0].reset();
				},
				error:function(data){
					alert('修改密码失败');
				}
			})
		})
	});
	</script>
</content>
</s:i18n>