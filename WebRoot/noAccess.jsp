<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
    <head>
        <meta charset="utf-8">
        <meta name="module" content="nonTopAndLeft">
        <meta name="module2" content="nonFooter">
    </head>
    <body>
    	<script>
			alert('<s:text name="%{#request.messageCode}"/>');
			history.go(-1);
		</script>
	</body>
</html>