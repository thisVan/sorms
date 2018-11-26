<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.opensymphony.com/sitemesh/decorator" prefix="decorator"%>
<%@taglib prefix="s" uri="/struts-tags"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
	//getScheme:协议               getServerName：服务器名称      getServerPort：端口号      path:(getContextPath)项目的名字
%>
<!DOCTYPE html>
<s:i18n name="decoratorsMessage.main">
	<!--[if lt IE 7]>      <html class="no-js lt-ie9 lt-ie8 lt-ie7"> <![endif]-->
	<!--[if IE 7]>         <html class="no-js lt-ie9 lt-ie8"> <![endif]-->
	<!--[if IE 8]>         <html class="no-js lt-ie9"> <![endif]-->
	<!--[if gt IE 8]><!-->
	<html class="no-js">
<!--<![endif]-->
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<!--使部分国产浏览器默认采用高速模式渲染页面-->
<meta name="renderer" content="webkit">
<title>南方新视界占屏率监控系统</title>
<meta name="viewport" content="width=device-width">

<!-- Place ico and apple-touch-icon.png in the root directory -->
<link rel="icon" href="images/logo.png" type="image/x-icon" />
<link rel="shortcut icon" href="images/logo.png" type="image/x-icon" />

<link href="css/bootstrap.min.css" rel="stylesheet" media="screen">
<link rel="stylesheet" href="css/bootstrap-theme.css">
<link href="css/styles.css" rel="stylesheet">
<link href="css/laydate.css" rel="stylesheet">

<!--Icons-->

<script src="js/jquery-1.11.1.min.js" type="text/javascript"></script>
<script src="js/bootstrap.min.js"></script>

<link rel="stylesheet" href="css/main.css">
<!-- CSS -->
<link rel="stylesheet" href="css/bootstrap.cosmo.css">
<link rel="stylesheet" href="css/font-awesome.min.css">

<decorator:head />
</head>
<body>
	<!--[if lte IE 7]>
            <s:text name="browserOutDate" />
        <![endif]-->

	<decorator:usePage id="thePage" />
	<s:if test='#attr.thePage.getProperty("meta.module")=="nonTopAndLeft"'>
		<decorator:body />
	</s:if>
	<s:else>
		<!-- WRAPPER -->
		<div class="wrapper">
			<jsp:include page="top.jsp" flush="true"></jsp:include>
			<!-- BOTTOM: LEFT NAV AND RIGHT MAIN CONTENT -->
			<div class="bottom">
				<!-- <div class="container"> -->
				<div class="row">
					<!-- left sidebar -->
					<div class="col-md-2 left-sidebar" id="leftBreadMenu">
						<jsp:include page="left.jsp" flush="true"></jsp:include>
					</div>
					<!-- end left sidebar -->

					<!-- content-wrapper -->
					<div class="col-md-9 content-wrapper" id="mainContentWrapper">
						<!--     <div class="row">
									<jsp:include page="breadCrumb.jsp" flush="true"></jsp:include>
								</div>  -->
						<!-- main -->
						<div class="content">
							<%-- <div class="main-header">
								<h2 style="border:0;">
									<decorator:title />
								</h2>
							</div> --%>
							<div class="main-content">
								<decorator:body />
							</div>
							<!-- /main-content -->
						</div>
						<!-- /main -->
					</div>
					<!-- /content-wrapper -->
				</div>
				<!-- /row -->
				<!--  </div>/container -->
			</div>
			<!-- END BOTTOM: LEFT NAV AND RIGHT MAIN CONTENT -->
			<div class="push-sticky-footer"></div>
		</div>
		<!-- WRAPPER -->
	</s:else>

	<script src="js/bootstrap.min.js"></script>
	<script type="text/javascript">
		$("#hideSideBar").click(function() {
			if($("#hideSideBar").hasClass("fa-angle-right")){
				$("#mainContentWrapper").removeClass("col-md-11");
				$("#mainContentWrapper").addClass("col-md-9");
			} else {
				$("#mainContentWrapper").removeClass("col-md-9");
				$("#mainContentWrapper").addClass("col-md-11");
			}
		});

	</script>
	<s:if test="#request.firstLogin">
		<script src="js/my-firstLogin.js"></script>
	</s:if>
	<decorator:getProperty property="page.scripts" />
</body>
	</html>
</s:i18n>

