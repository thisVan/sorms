<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags"%>
<s:i18n name="decoratorsMessage.main">
<ul class="breadcrumb">
	<li><i class="fa fa-home"></i><a href='<s:property value="#session.home"/>'><s:text name="home"/></a></li>
	<s:iterator value="#request.breadCrumb" status="st">
		<s:if test="#st.last">
			<li class="active"><s:property value="[0].top[0]"/></li>
		</s:if><s:else>
			<li><a href='<s:property value="[0].top[1]"/>'><s:property value="[0].top[0]"/></a></li>
		</s:else>
	</s:iterator>
</ul>
</s:i18n>
