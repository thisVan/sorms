<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html>
<s:i18n name="contentMessage.userInfo">
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="description" content="占屏率监控系统">
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="icon" href="images/logo.png" type="image/x-icon" />
<link rel="shortcut icon" href="images/logo.png" type="image/x-icon" />

<link href="css/bootstrap.min.css" rel="stylesheet" media="screen">
<link rel="stylesheet" href="css/bootstrap-theme.css">
<link href="css/styles.css" rel="stylesheet">

<!--Icons-->
<script src="js/lumino.glyphs.js"></script>
<title><s:text name="详情"/></title>
</head>

	<body>
		<form action="" class="form-horizontal" role="form">
		<fieldset>
		   <div class="form-group">
				<label class="col-sm-3 control-label" ><s:text name="用户名"/></label>
				<div class="col-sm-4"><p class="form-control-static"><s:property value="yewuyuan.username"/></p></div>
			</div>
			<div class="form-group">
				<label class="col-sm-3 control-label"><s:text name="姓名"/></label>
				<div class="col-sm-4"><p class="form-control-static"><s:property value="yewuyuan.ywyXingming"/></p></div>
			</div>
			<div class="form-group">
				<label class="col-sm-3 control-label"><s:text name="role"/></label>
				<div class="col-sm-4"><p class="form-control-static"><s:property value="yewuyuan.role.name"/></p></div>
			</div>
			<div class="form-group">
				<label class="col-sm-3 control-label"><s:text name="department"/></label>
				<div class="col-sm-4"><p class="form-control-static"><s:property value="yewuyuan.bumen.bmMingcheng"/></p></div>
			</div>
			<div class="form-group">
				<label class="col-sm-3 control-label"><s:text name="部门主管"/></label>
				<div class="col-sm-4"><p class="form-control-static"><s:property value="yewuyuan.bumen.bmZhuguan"/></p></div>
			</div>
			<div class="form-group">
				<label class="col-sm-3 control-label"><s:text name="部门分管领导"/></label>
				<div class="col-sm-4"><p class="form-control-static"><s:property value="yewuyuan.bumen.bmFenguanlingdao"/></p></div>
			</div>
			<div class="form-group">
				<label class="col-sm-3 control-label"><s:text name="办公室地址"/></label>
				<div class="col-sm-4"><p class="form-control-static"><s:property value="yewuyuan.bumen.bmBangongshi"/></p></div>
			</div>
			
			
			</fieldset>
		</form>
	</body>
</html>
</s:i18n>
<content tag="scripts">
    <script src="js/jquery-1.11.1.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
	<script src="js/king-common.js"></script>
	<script src="js/jquery.maxlength.js"></script>
</content>