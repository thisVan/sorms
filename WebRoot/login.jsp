<%@ page language="java" import="java.util.*" contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <meta name="module" content="nonTopAndLeft">
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">

	<meta http-equiv="description" content="登录页面">
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>登录</title>
	<link rel="icon" href="images/logo.png" type="image/x-icon" />
	<link rel="shortcut icon" href="images/logo.png" type="image/x-icon" />
	
	<link href="css/bootstrap.min.css" rel="stylesheet">
	<link href="css/datepicker3.css" rel="stylesheet">
	<link href="css/styles.css" rel="stylesheet">
	
	<script type="text/javascript" src="js/jquery-1.11.1.min.js"></script>
	<!--[if lt IE 9]>
	<script src="js/html5shiv.js"></script>
	<script src="js/respond.min.js"></script>
	<![endif]-->
	
<script type="text/javascript">
	var name=getCookie("name");
	var usernameAuto=name.split("=")[1];
	 $(document).ready(function(){ 
		$("input").keydown(function(e){ 
			var curKey = e.which; 
			if(curKey == 13){ 
			$("#btn-sub").click(); 
			return false; 
			}});
		}); 
		
    function load(){
      if(usernameAuto!=null&&usernameAuto!=""){
      document.getElementById("username").value=usernameAuto;//设置表单中元素的值
      document.getElementById("password").value="";
      document.getElementById("usernameAuto").value=usernameAuto;
      delCookie("name");
      $("#btn-sub").click();//触发按钮点击事件，提交表单，调用User_login.action
      }
    }  
    
  	function frontval() {
  		if(($("#username").val() == null || $("#username").val() == "")||($("#password").val() == null || $("#password").val() == "")){
  	  		alert("用户名和密码不能为空，请检查您的输入！");
  	  		return false;
  	  	}
  		return true;
	}
  	
  	function doFormSubmit() {
  		if (frontval()) {
			$("#logform").submit();
		}
	}
	
	function getCookie(name){
       	var arr,reg=new RegExp("(^| )"+name+"=([^;]*)(;|$)");
		if(arr=document.cookie.match(reg))
			return arr[0];
		else
			return null;
	}
	
	function delCookie(name){
		var date=new Date();           
		date.setTime(date.getTime()+(-1 * 24 * 60 * 60 * 1000));           
		document.cookie=name+"= ; expire="+date.toGMTString()+"; path=/";
	}
	
	
/* 	function autoLogin(){
		if(usernameAuto!=null){
		alert("autoLogin调用成功");
		$.ajax({
	        type:"post",
	  		dataType:"json",
	  		url:"User_login.action",
	  		data:{usernameAuto:usernameAuto},

		});
		}
	} */
  	
</script>
</head>

<body style="font-family: '微软雅黑';" onload="load()">
		<nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
			<div class="container-fluid">
				<div class="navbar-header">
					<button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#sidebar-collapse">
					<span class="sr-only">系统导航</span>
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
				</button>
					<a class="navbar-brand" href=""><img height="26" width="40" src="images/logo.png" alt="南方新视界传媒科技有限公司" /><span style="font-size: x-large;font-weight: bold;">新视界传媒</span>&nbsp;&nbsp;占屏率监控系统</a>
				</div>

			</div>
			<!-- /.container-fluid -->
		</nav>

	<div class="row">
		<div class="col-xs-10 col-xs-offset-1 col-sm-8 col-sm-offset-2 col-md-4 col-md-offset-4">
				<div class="col-1g-12"><label>&nbsp;&nbsp;&nbsp;&nbsp;</label></div>
				<div class="col-1g-12"><label>&nbsp;&nbsp;&nbsp;&nbsp;</label></div>
				<div class="col-1g-12"><label>&nbsp;&nbsp;&nbsp;&nbsp;</label></div>
			<div class="login-panel panel panel-default">
				<div align="center" class="panel-heading">用户登录</div>
				<div class="panel-body">
					<form name="login_form" id="logform" role="form" action="User_login" method="post">
						
							<div class="form-group">
								<input id="username" class="form-control" placeholder="用户名" name="username" type="text" autofocus="">
								<input id="usernameAuto" class="form-control hidden" name="usernameAuto" type="text" autofocus="">
							</div>
							<div class="form-group">
								<input id="password" class="form-control" placeholder="密码" name="password" type="password" >
							</div>
							
							<s:if test="#parameters.returnURL != null">
                        	    <s:hidden name="returnURL" value="%{#parameters.returnURL}"/>
                            </s:if>
						
						<div align="center" style="font-size: larger;color: red">${request.message }</div>
						<div class="row"><label>&nbsp;&nbsp;&nbsp;&nbsp;</label></div>
						<div align="center">
							<input type="button" id="btn-sub" class="btn btn-primary" value="登录" onclick="doFormSubmit()"/>
							<input type="reset" class="btn" value="取消"/>
							<input type="button" id="autoLoginButton" class="hidden" onclick="autoLogin()"/> 
						</div>
					</form>
					
				</div>
			</div>
		</div><!-- /.col-->
	</div><!-- /.row -->	
	
	<script src="js/bootstrap.min.js"></script>
	<script src="js/chart.min.js"></script>

	<script>
		!function ($) {
			$(document).on("click","ul.nav li.parent > a > span.icon", function(){		  
				$(this).find('em:first').toggleClass("glyphicon-minus");	  
			}); 
			$(".sidebar span.icon").find('em:first').addClass("glyphicon-plus");
		}(window.jQuery);

		$(window).on('resize', function () {
		  if ($(window).width() > 768) $('#sidebar-collapse').collapse('show')
		})
		$(window).on('resize', function () {
		  if ($(window).width() <= 767) $('#sidebar-collapse').collapse('hide')
		})
	</script>	

  </body>
</html>
