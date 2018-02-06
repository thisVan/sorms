<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags"%>
<!-- main-nav -->
<nav class="main-nav col-lg-offset-1">
<body style="font-family: '微软雅黑';">
     <div class="row"><label>&nbsp;</label></div>
     <ul class="main-menu">
    	<s:iterator value="#request.resourcesMap">
    		<s:if test="value.size==1">
    			<li<s:if test="#request.curParentName == key"> class="active"</s:if>>
    				<a href='<s:property value="value[0].url"/>'>
    					<i class="fa fa-bullseye fa-fw"></i>
    					<span class="text"><s:property value="value[0].name"/></span>
    				</a>
    			</li>
    		</s:if><s:else>
    			<s:set name="flag" value="0"/>
    			<li>
    				<a href='<s:property value="value[0].url"/>' class="js-sub-menu-toggle">
    					<i class="fa fa-bullseye fa-fw"></i>
    					<span class="text"><s:property value="key"/></span>
    					<i class="toggle-icon fa fa-angle-left"></i>
    				</a>
    				<ul class="sub-menu<s:if test='#flag==1'> open</s:if>">
	    				<s:iterator value="value" status="st">
	    					<li>
	    						<a href='<s:property value="[0].url"/>'> 
	    							<span class="text"><s:property value="[0].name"/></span>
	    						</a>
	    					</li>
	    				</s:iterator>
    				</ul>
    			</li>
    		</s:else>
    	</s:iterator>
    </ul>
    
    </body>
</nav>
<!-- /main-nav -->
<div class="sidebar-minified js-toggle-minified">
    <i class="fa fa-angle-left"></i>
</div>
