<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<%
	String name = (String) session.getAttribute("username");
	if (name != null) {
	} else {
		response.sendRedirect("login.jsp");
	}
%>
<link rel="icon" href="images/logo.png" type="image/x-icon" />
<link rel="shortcut icon" href="images/logo.png" type="image/x-icon" />

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="description" content="认刊书成功">

<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="css/bootstrap.min.css" rel="stylesheet" media="screen">
<link href="css/datepicker3.css" rel="stylesheet">
<link href="css/bootstrap-datetimepicker.min.css" rel="stylesheet"
	media="screen">
<link href="css/bootstrap-table.css" rel="stylesheet">

<link href="css/styles.css" rel="stylesheet">

<!--Icons-->
<script src="js/lumino.glyphs.js"></script>
<script type="text/javascript" src="js/jquery-1.11.1.min.js"></script>
<script type="text/javascript">
	function countDown(secs, surl) {
		//alert(surl);     
		var jumpTo = document.getElementById('jumpTo');
		jumpTo.innerHTML = secs;
		if (--secs > 0) {
			setTimeout("countDown(" + secs + ",'" + surl + "')", 1000);
		} else {
			location.href = surl;
		}
	}
</script>
</head>

<body style="font-family: '微软雅黑';">

	<div class="col-sm-9 col-lg-10 main">
	
		<!--/.row-->

		<div class="row">
			<div class="col-lg-12">
				<h3 class="page-header">
					认刊书录入
					</h1>
			</div>
		</div>
		<!--/.row-->

		<div class="row">
			<div
				class="col-xs-10 col-xs-offset-1 col-sm-8 col-sm-offset-2 col-md-4 col-md-offset-4">
				<div class="col-1g-12">
					<label>&nbsp;&nbsp;&nbsp;&nbsp;</label>
				</div>
				<div class="col-1g-12">
					<label>&nbsp;&nbsp;&nbsp;&nbsp;</label>
				</div>
				<div class="col-1g-12">
					<label>&nbsp;&nbsp;&nbsp;&nbsp;</label>
				</div>
				<div class="login-panel panel panel-default">
					<div class="panel-heading" style="color: green;" align="center">信息提交成功</div>
					<div class="panel-body">

						<div align="center" style="font-size: larger;">${session.successmessage }<br>
							系统将在<span id="jumpTo" style="color: red;font-size: large;">5</span>秒后自动跳转到信息填写页面！
							<script type="text/javascript">
								countDown(5, '/sorm/addpingmu.jsp');
							</script>
						</div>
					</div>
				</div>
			</div>
			<!-- /.col-->
		</div>
		<!-- /.row -->

		<br>
		
		<script src="js/jquery-1.11.1.min.js"></script>
		<script src="js/bootstrap.min.js"></script>

</body>
</html>
