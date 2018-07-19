<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="com.google.gson.*"%>
<%@ page import="java.sql.*"%>
<%@ taglib uri="/struts-tags" prefix="s"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<link rel="icon" href="images/logo.png" type="image/x-icon" />
<link rel="shortcut icon" href="images/logo.png" type="image/x-icon" />
<link href="css/bootstrap.min.css" rel="stylesheet" media="screen">
<link href="css/bootstrap-table.css" rel="stylesheet">

<link rel="stylesheet" href="css/bootstrap-theme.css">
<link href="css/styles.css" rel="stylesheet">
<link href="css/laydate.css" rel="stylesheet">

<!--Icons-->
<script src="js/lumino.glyphs.js"></script>
<script src="js/jquery-1.11.1.min.js"></script>
<script src="js/bootstrap-table.js"></script>


</head>
<body style="font-family: '微软雅黑';">
<div class="main">
	
		<!--/.row-->

		<div class="row">
			<div class="col-lg-12">
				<h3 class="page-header">
					订单审核
					</h3>
			</div>
		</div>
		<!--/.row-->
		<div class="row">
			<div class="col-lg-12">
				<div class="panel panel-default">
					<div class="panel-body">
						<div class="col-lg-12 col-md-6">
		<form id="form_save" class="form-horizontal" role="form">
		<input type="text" class="hidden" name="ids" value='<s:property value="orderaudit.id"/>'>
		<div class="form-group">
			<label for="account" class="col-sm-2 control-label">认刊编号</label>
			<div class="col-sm-4"><p class="form-control-static"><s:property value="renkanshu.renkanbianhao"/></p></div>
		</div>
		<div class="form-group">
			<label for="account" class="col-sm-2 control-label">广告客户</label>
			<div class="col-sm-4"><p class="form-control-static"><s:property value="orderaudit.kanhu"/></p></div>
		</div>
		
		<div class="form-group">
			<label for="account" class="col-sm-2 control-label">签订日期</label>
			<div class="col-sm-4"><p class="form-control-static"><s:property value="qiandingriqi"/></p></div>
		</div>
		<div class="form-group">
			<label for="account" class="col-sm-2 control-label">业务员</label>
			<div class="col-sm-4"><p class="form-control-static"><s:property value="orderaudit.yewuyuanByYwyId.ywyXingming"/></p></div>
		</div>
		
		<div class="form-group">
			<label for="account" class="col-sm-2 control-label">广告内容</label>
			<div class="col-sm-4"><p class="form-control-static"><s:property value="orderaudit.guanggaoneirong"/></p></div>
		</div>
		
		<div class="form-group">
			<label for="account" class="col-sm-2 control-label">行业</label>
			<div class="col-sm-4"><p class="form-control-static"><s:property value="orderaudit.industry.industryDesc"/></p></div>
		</div>
		<div class="form-group">
			<label for="account" class="col-sm-2 control-label">实付合计（元）</label>
			<div class="col-sm-4"><p class="form-control-static"><s:property value="renkanshu.kanlizongjia"/></p></div>
		</div>
		
		<div class="form-group">
			<label for="role" class="col-sm-2 control-label">上画屏幕</label>
			<div class="col-sm-4"><p class="form-control-static"><s:property value="orderaudit.led.ledName"/></p></div>
		</div>
		<div class="form-group">
			<label for="account" class="col-sm-2 control-label">类型</label>
			<div class="col-sm-4"><p class="form-control-static"><s:property value="orderaudit.leixing"/></p></div>
		</div>
		<div class="form-group">
			<label for="account" class="col-sm-2 control-label">时长</label>
			<div class="col-sm-4"><p class="form-control-static"><s:property value="orderaudit.shichang"/></p></div>
		</div>
		<div class="form-group">
			<label for="account" class="col-sm-2 control-label">频次</label>
			<div class="col-sm-4"><p class="form-control-static"><s:property value="orderaudit.pinci"/></p></div>
		</div>
		<div class="form-group">
			<label for="account" class="col-sm-2 control-label">播放开始时间</label>
			<div class="col-sm-4"><p class="form-control-static"><s:property value="kaishishijian"/></p></div>
		</div>
		
 		<div class="form-group">
			<label for="account" class="col-sm-2 control-label">播放结束时间</label>
			<div class="col-sm-4"><p class="form-control-static"><s:property value="jieshushijian"/></p></div>
		</div>  
		<div class="form-group">
			<label for="account" class="col-sm-2 control-label">投放时长(周)</label>
			<div class="col-sm-4"><p class="form-control-static"><s:property value="orderaudit.shuliang"/></p></div>
		</div>
		<div class="form-group">
			<label for="account" class="col-sm-2 control-label">刊例价小计（元）</label>
			<div class="col-sm-4"><p class="form-control-static"><s:property value="orderaudit.kanlijiaxiaoji"/></p></div>
		</div>
		
<!-- 		<div class="form-group">
			<label for="account" class="col-sm-2 control-label">修改理由</label>
			<div class="col-sm-4"><p class="form-control-static"><s:property value="orderaudit.operReason"/></p></div>
		</div>   -->
		
	<!-- 	<div class="form-group">
			<label for="account" class="col-sm-2 control-label">订单状态</label>
			<div class="col-sm-4"><p class="form-control-static"><s:property value="orderaudit"/></p></div>
		</div>  -->	
	
	    <div class="form-group">
			<label for="account" class="col-sm-2 control-label">审核内容</label>
	 		<div class="col-sm-8"><p class="form-control-static">${request.remarkContent}</p></div>
	<!--		<label for="account" class="col-sm-8 control-label">${request.remark}</label>  -->
		</div>
		
		<div class="form-group">
			<label for="account" class="col-sm-2 control-label">审核理由</label>
	 		<div class="col-sm-6"><textarea class="form-control input-sm" name="auditReason" rows="5" ></textarea></div> 
	<!--		<label for="account" class="col-sm-8 control-label">${request.remark}</label>  -->
		</div>
		
		<div class="form-group">
		    <label for="account" class="col-sm-2 control-label">审核结果</label>
			<div class="simple-radio simple-radio-inline radio-green">
				<input id="pass" type="radio" name="auditResult" value="true" checked>
				<label for="pass">通过</label>
				<input id="unpass" type="radio" name="auditResult" value="false">
				<label for="unpass">不通过</label>
			</div>
		</div>
		
	</form>	
		
	<p class="text-center">
		<button type="button" class="btn btn-custom-primary btn-sm" id="back" onclick="goBack()" style="float:left;background:#AAAAAB;border:2px solid #e5e5e5;margin-left:40%;width:63px"></i>返回</button>
		<button type="button" class="btn btn-primary btn-sm" id="submit" style="margin-left:-40%"><i class="fa fa-floppy-o"></i> 提交</button>
	</p>

	<script src="js/jquery-1.11.1.min.js"></script>
	<script src="js/bootstrap.min.js"></script>
	<script type="text/javascript" src="js/bootstrap-datetimepicker.js"></script>
	<script src="js/bootstrap-datetimepicker.zh-CN.js" charset="UTF-8"></script>
	<script type="text/javascript">


		$('.form_datetime').datetimepicker({
			language : 'zh-CN',
			weekStart : 1,
			todayBtn : 1,
			autoclose : 1,
			todayHighlight : 1,
			startView : 2,
			forceParse : 0,
			showMeridian : 1
		});
		$('.form_date').datetimepicker({
			language : 'zh-CN',
			weekStart : 1,
			todayBtn : 1,
			autoclose : 1,
			todayHighlight : 1,
			startView : 2,
			minView : 2,
			forceParse : 0
		});
		$('.form_time').datetimepicker({
			language : 'zh-CN',
			weekStart : 1,
			todayBtn : 1,
			autoclose : 1,
			todayHighlight : 1,
			startView : 1,
			minView : 0,
			maxView : 1,
			forceParse : 0
		});
	</script>	
</body>
</html>
<content tag="scripts">
	<script src="js/jquery.ba-bbq.min.js"></script>
	<script src="js/grid.history.js"></script>
	<script src="js/grid.locale-cn.js"></script>
	<script>
		$.jgrid.useJSON = true;
	</script>
	<script src="js/jquery.jqGrid.min.js"></script>
	<script src="js/jquery.jqGrid.fluid.js"></script>
	<script src="js/king-common.js"></script>
	<script src="js/moment.js"></script>
	<script src="js/daterangepicker.js"></script>
	<script>

	$(document).ready(function(){
		//保存按钮的点击事件
		$("#submit").click(function(){
			$.ajax({
				url:"Audit.action",
				type:"post",
				data:$("#form_save").serializeArray(),
				dataType:"json",
				success:function(data){
					alert(data.info);
					if(data.state===0){ //操作成功
						location.replace('yewuaudit');
					}
				},
				error:function(XMLHttpRequest, textStatus, errorThrown){
					alert('提交失败\nXMLHttpRequest.readyState['+XMLHttpRequest.readyState+']\nXMLHttpRequest.status['+XMLHttpRequest.status+']\ntextStatus['+textStatus+']');
				}
			})
		})
	});
	function changeindustry(obj) {
		var selectclassifyind = obj.value;
		$.ajax({
	  		type:"post",
	  		dataType:"json",
	  		url:"fillIndustryClassify.action",
	  		data: { selectclassifyind: selectclassifyind },//提交参数
	  		success:function(data){ 	
	  			var jsonData = data.industryclassifyback;
	  			document.getElementById("industry_id").innerHTML="";
	  			for(var i=0, n = jsonData.length;i<n;i++){
	  				$("#industry_id").append("<option  value='"+jsonData[i].industryid+"'>"+jsonData[i].industryname+"</option>");		
	  			}
	  		}
	  });	
	};
	function goBack(){
		if(confirm("您确定要放弃相关操作，返回到审核列表中吗？")){
			location.replace('yewuaudit');
		}
	}
</script>
</content>
