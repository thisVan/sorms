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
					增加订单
					</h1>
			</div>
		</div>
		<!--/.row-->
		<div class="row">
			<div class="col-lg-12">
				<div align="center" style="font-size: large;color: red">${session.erromessage }</div>
			</div>
			<div class="col-lg-12">
				<div class="panel panel-default">
					<div class="panel-body">
						<div class="col-lg-12 col-md-6">
		<form id="form_save" class="form-horizontal" role="form">
		<input type="text" class="hidden" name="tid" value='<s:property value="yewu.yewuId"/>'>
		<div class="form-group">
			<label for="account" class="col-sm-2 control-label">认刊编号</label>
			<div class="col-sm-4"><input type="text" class="form-control input-sm" name="yewu.renkanshu.renkanbianhao"  value='<s:property value="yewu.renkanshu.renkanbianhao"/>'maxlength="20" disabled></div>
		</div>
		<div class="form-group">
			<label for="account" class="col-sm-2 control-label">广告客户</label>
			<div class="col-sm-4"><input type="text" class="form-control input-sm" name="yewu.kanhu"  value='<s:property value="yewu.kanhu"/>'maxlength="20" disabled></div>
		</div>
		
		<div class="form-group">
			<label for="account" class="col-sm-2 control-label">业务员</label>
			<div class="col-sm-4"><input type="text" class="form-control input-sm" name="yewu.yewuyuan.ywyXingming"  value='<s:property value="yewu.yewuyuan.ywyXingming"/>'maxlength="20" disabled></div>
		</div>
		
		<div class="form-group">
			<label for="account" class="col-sm-2 control-label">类型</label>
			<div class="col-sm-4"><input type="text" class="form-control input-sm" name="yewu.leixing"  value='<s:property value="yewu.leixing"/>'maxlength="20" disabled></div>
		</div>
		<div class="form-group">
			<label for="account" class="col-sm-2 control-label">签订日期</label>
			<div class="col-sm-4"><input type="text" class="form-control input-sm" name="yewu.renkanshu.qiandingriqi"  value='<s:property value="qiandingriqi"/>' maxlength="20" disabled></div>
		</div>
		
		<div class="form-group">
			<label for="account" class="col-sm-2 control-label">广告内容</label>
			<div class="col-sm-4"><textarea class="form-control input-sm " rows="3" name="guanggaoneirong" maxlength="150"></textarea></div>
		</div>
		
		<div class="form-group">
			<label for="account" class="col-sm-2 control-label">行业</label>
			<div class="col-sm-2"><select class="form-control input-sm" name="industryclassifyId" id="industryclassifyid" onchange="changeindustry(this)">
					<s:iterator value="#request.industryclassifys">
						<option value='<s:property value="[0].top[0]"/>'><s:property value="[0].top[1]"/></option>
					</s:iterator>
				</select></div>
				<div class="col-sm-2">
			<select class="form-control input-sm" name="industryId" id="industry_id">
					<s:iterator value="#request.industry">
						<option value='<s:property value="[0].top[0]"/>'><s:property value="[0].top[1]"/></option>
					</s:iterator>
				</select>
			</div>
		</div>
		
		<div class="form-group">
			<label for="role" class="col-sm-2 control-label">上画屏幕</label>
			<div class="col-sm-4">
				<select class="form-control input-sm" name="ledId" id="led_id">
					<s:iterator value="#request.leds">
						<option value='<s:property value="[0].top[0]"/>'><s:property value="[0].top[1]"/></option>
					</s:iterator>
				</select>
			</div>
		</div>
		
		<div class="form-group">
			<label for="account" class="col-sm-2 control-label">时长</label>
			<div class="col-sm-4"><input type="text" class="form-control input-sm" name="shichang"  maxlength="20" ></div>
		</div>
		<div class="form-group">
			<label for="account" class="col-sm-2 control-label">频次</label>
			<div class="col-sm-4"><input type="text" class="form-control input-sm" name="pinci"  maxlength="20" ></div>
		</div>
		<div class="form-group">
			<label for="account" class="col-sm-2 control-label">播放开始时间</label>
			<div class="col-sm-4"><input type="date" class="form-control input-sm" name="kaishishijian"  maxlength="20" ></div>
		</div>
		
 		<div class="form-group">
			<label for="account" class="col-sm-2 control-label">播放结束时间</label>
			<div class="col-sm-4"><input type="date" class="form-control input-sm" name="jieshushijian"  maxlength="20" ></div>
		</div>  
		<div class="form-group">
			<label for="account" class="col-sm-2 control-label">数量(周)</label>
			<div class="col-sm-4"><input type="text" class="form-control input-sm" name="shuliang"  maxlength="20" ></div>
		</div>
		
		<div class="form-group">
			<label for="account" class="col-sm-2 control-label">上画理由</label>
			<div class="col-sm-4"><textarea class="form-control input-sm " rows="3" name="addReason" maxlength="150"></textarea></div>
		</div>
		
<!-- 	<div class="form-group">
			<label for="account" class="col-sm-2 control-label">订单状态</label>
			<div class="col-sm-4">
				<select class="form-control input-sm" name="state" id="state">					
					<option value="N">上画</option>
					<option value="U">下画</option>
				</select>
			</div>
		</div>  
		
		<div class="form-group">
			<label for="account" class="col-sm-2 control-label">备注</label>
			<label for="account" class="col-sm-8 control-label">${request.remark}</label>
		</div>  -->
		
	</form>
	<p class="text-center">
		<button type="button" class="btn btn-custom-primary btn-sm" id="back" onclick="goBack()" style="float:left;background:#AAAAAB;border:2px solid #e5e5e5;margin-left:40%;width:63px"></i>返回</button>
		<button type="button" class="btn btn-danger btn-sm" id="save" style="margin-left:-40%"><i class="fa fa-floppy-o"></i> 保存</button>
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
	
	var nameValid = true;

	$(document).ready(function(){
		
//		alert(originalIndustyClassify);
		//保存按钮的点击事件
		$("#save").click(function(){
//			alert('<s:text name="%{#request.kaishishijian}"/>');
			if(nameValid){
				if($("select[name='ledId']").val()=="" ||
						$("select[name='industryId']").val()=="" ||
						$("input[name='shichang']").val()=="" ||
						$("input[name='pinci']").val()=="" ||
						$("input[name='kaishishijian']").val()=="" ||
						$("input[name='jieshushijian']").val()=="" ||
						$("input[name='shuliang']").val()=="" ||
						$("input[name='guanggaoneirong']").val()=="" ||
						$("select[name='state']").val()=="")
				{
					alert("请将信息填完整");
					return;
				}
			}
			if(nameValid){
				$.ajax({
					url:"upOrder.action",
					type:"post",
					data:$("#form_save").serializeArray(),
					dataType:"json",
					success:function(data){
						alert(data.info);
						if(data.state===0){ //操作成功
							location.replace('dingdanguanli');
						}
					},
					error:function(XMLHttpRequest, textStatus, errorThrown){
						alert('保存失败\nXMLHttpRequest.readyState['+XMLHttpRequest.readyState+']\nXMLHttpRequest.status['+XMLHttpRequest.status+']\ntextStatus['+textStatus+']');
					}
				})
			}
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
		if(confirm("您确定要放弃相关操作，返回到订单列表中吗？")){
			location.replace('dingdanguanli');
		}
	}
</script>
</content>
