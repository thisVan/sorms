<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta name="module" content="nonTopAndLeft">
    </head>
    <body>
		<p>
			<strong>业务异常：</strong>
			<s:property value="exception.message"/>
		</p>
	</body>
</html>