<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags"%>
<s:i18n name="decoratorsMessage.top">
	<script>
		function getMessage() {
			$.ajax({
				url : "countNotReadMessage.action",
				type : 'post',
				dataType : 'json',
				success : function(data) {
					var showCount = data;
					if (data > 99) {
						showCount = "99+";
					}
					if (data != null) {
						$("#msgnum").html(
							"<span class='nav-counter'>" + showCount
							+ "</span>");
					}
				}
			});
		//			  setTimeout("getMessage()",500);
		}
		$(document).ready(function() {
			getMessage();
		});
	</script>
	<!-- TOP BAR -->
	<div class="navbar navbar-inverse navbar-fixed-top" role="navigation">
		<div class="container-fluid">
			<div class="navbar-header">
				<button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#sidebar-collapse">
					<span class="sr-only">系统导航</span> <span class="icon-bar"></span> <span class="icon-bar"></span> <span class="icon-bar"></span>
				</button>
				<a class="navbar-brand" href="">
					<img height="26" width="40" src="images/logo.png" style="display: inline-block;" alt="南方新视界传媒科技有限公司" />
					<span style="font-size: x-large;font-weight: bold;display: inline-block;">新视界传媒</span>&nbsp;&nbsp;占屏率监控系统
				</a>
				<ul class="user-menu">
					<li class="dropdown pull-right">
						<!-------------------- 新添加的有关消息的管理（上面导航栏的图标）---------------------->
						<div class="btn-group" style="margin-right:20px;">
							<a href="message.action" class="btn btn-link nav-link" title="消息管理"> <svg class="glyph stroked email">
									<use xlink:href="#stroked-email" /></svg>
								<div id="msgnum"></div>
							</a>
						</div> <a href="#" class="dropdown-toggle" data-toggle="dropdown"><svg class="glyph stroked male-user"> <use xlink:href="#stroked-male-user"></use></svg> <s:property
								value="#request.name" /> <span class="caret"></span></a>
						<ul class="dropdown-menu" role="menu">
							<li><a href='<s:url action="userInfo" namespace="/"/>'><svg class="glyph stroked male-user">
								<use xlink:href="#stroked-male-user"></use></svg> 详情</a></li>
							<li><a href='<s:url action="setting" namespace="/"/>'><svg class="glyph stroked gear"> <use xlink:href="#stroked-gear"></use></svg> 设置</a></li>
							<li><a href="logout.jsp"><svg class="glyph stroked cancel">
								<use xlink:href="#stroked-cancel"></use></svg> 退出</a></li>
						</ul>
					</li>
			</div>
			</ul>
		</div>

	</div>
	<!-- /.container-fluid -->
	</nav>
</s:i18n>
