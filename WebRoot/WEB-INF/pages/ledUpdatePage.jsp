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
					屏幕修改
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
						<input type="text" class="hidden" name="led.ledId" id="led_id" value='<s:property value="led.ledId"/>'>
		<div class="form-group">
			<label for="account" class="col-sm-2 control-label">屏幕ID</label>
			<div class="col-sm-4"><input type="text" class="form-control input-sm" name="led.ledId"  value='<s:property value="led.ledId"/>' maxlength="20" disabled></div>
		</div>
		<div class="form-group">
			<label for="account" class="col-sm-2 control-label">屏幕代码</label>
			<div class="col-sm-4"><input type="text" class="form-control input-sm" name="led.ledDaima"  value='<s:property value="led.ledDaima"/>'maxlength="20" ></div>
		</div>
		<div class="form-group">
			<label for="account" class="col-sm-2 control-label">屏幕名称</label>
			<div class="col-sm-4"><input type="text" class="form-control input-sm" name="led.ledName"  value='<s:property value="led.ledName"/>'maxlength="20" ></div>
		</div>
		<div class="form-group">
			<label for="account" class="col-sm-2 control-label">安装位置</label>
			<div class="col-sm-4"><input type="text" class="form-control input-sm" name="led.ledWeizhi"  value='<s:property value="led.ledWeizhi"/>'maxlength="20" ></div>
		</div>
		<div class="form-group">
			<label for="account" class="col-sm-2 control-label">播放时长</label>
			<div class="col-sm-4"><input type="text" class="form-control input-sm" name="led.ledBofangshichang"  value='<s:property value="led.ledBofangshichang"/>' maxlength="20" ></div>
		</div>
		<div class="form-group">
			<label for="account" class="col-sm-2 control-label">播放开始时间</label>
			<div class="col-sm-4"><input type="text" class="form-control input-sm" name="led.ledBofangkaishishijian"  value='<s:property value="led.ledBofangkaishishijian"/>'maxlength="20" ></div>
		</div>
		<div class="form-group">
			<label for="account" class="col-sm-2 control-label">播放结束时间</label>
			<div class="col-sm-4"><input type="text" class="form-control input-sm" name="led.ledBofangjieshushijian"  value='<s:property value="led.ledBofangjieshushijian"/>'maxlength="20" ></div>
		</div>
		<div class="form-group">
			<label for="account" class="col-sm-2 control-label">间歇时长</label>
			<div class="col-sm-4"><input type="text" class="form-control input-sm" name="led.ledJianxieshichang"  value='<s:property value="led.ledJianxieshichang"/>'maxlength="20" ></div>
		</div>
		<div class="form-group">
			<label for="account" class="col-sm-2 control-label">间歇开始时间</label>
			<div class="col-sm-4"><input type="text" class="form-control input-sm" name="led.ledJianxiestart"  value='<s:property value="led.ledJianxiestart"/>'maxlength="20" ></div>
		</div>
		<div class="form-group">
			<label for="account" class="col-sm-2 control-label">间歇结束时间</label>
			<div class="col-sm-4"><input type="text" class="form-control input-sm" name="led.ledJianxieend"  value='<s:property value="led.ledJianxieend"/>'maxlength="20" ></div>
		</div>
		<div class="form-group">
			<label for="account" class="col-sm-2 control-label">屏幕长度</label>
			<div class="col-sm-4"><input type="text" class="form-control input-sm" name="led.ledChangdu"  value='<s:property value="led.ledChangdu"/>'maxlength="20" ></div>
		</div>
		<div class="form-group">
			<label for="account" class="col-sm-2 control-label">屏幕宽度</label>
			<div class="col-sm-4"><input type="text" class="form-control input-sm" name="led.ledKuangdu"  value='<s:property value="led.ledKuangdu"/>'maxlength="20" ></div>
		</div>
		<div class="form-group">
			<label for="account" class="col-sm-2 control-label">屏幕面积</label>
			<div class="col-sm-4"><input type="text" class="form-control input-sm" name="led.ledMianji"  value='<s:property value="led.ledMianji"/>'maxlength="20" ></div>
		</div>
		<div class="form-group">
			<label for="account" class="col-sm-2 control-label">屏幕分辨率</label>
			<div class="col-sm-4"><input type="text" class="form-control input-sm" name="led.ledFenbianlv"  value='<s:property value="led.ledFenbianlv"/>'maxlength="20" ></div>
		</div>
		<div class="form-group">
			<label for="account" class="col-sm-2 control-label">屏幕类型</label>
			<div class="col-sm-4"><input type="text" class="form-control input-sm" name="led.ledLeixing"  value='<s:property value="led.ledLeixing"/>'maxlength="20" ></div>
		</div>
		<div class="form-group">
			<label for="account" class="col-sm-2 control-label">屏幕典型刊例价格（60次/15秒）</label>
			<div class="col-sm-4"><input type="text" class="form-control input-sm" name="led.ledKanliprice"  value='<s:property value="led.ledKanliprice"/>'maxlength="20" ></div>
		</div>
		
		<div class="form-group">
			<label for="account" class="col-sm-2 control-label">屏幕状态</label>
			<div class="col-sm-4">
				<select class="form-control input-sm" name="led.state" id="state">					
					<option value="A">激活</option>
					<option value="U">未激活</option>
				</select>
			</div>
		</div>	
	</form>
	</div>
	<p class="text-center">
		<button type="button" class="btn btn-custom-primary btn-sm" id="back" onclick="goBack()" style="float:left;background:#AAAAAB;border:2px solid #e5e5e5;margin-left:40%;width:63px"></i>返回</button>
		<button type="button" class="btn btn-custom-primary btn-sm" id="save" style="margin-right:40%"><i class="fa fa-floppy-o"></i> 保存</button>
	</p>
	</div>
	</div>
	</div>
	</div>
	</div>
</body>
</html>
<content tag="scripts">
    <script src="js/jquery-1.11.1.min.js"></script>
	<script src="js/bootstrap.min.js"></script>
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

	var originalledId = '<s:property value="led.ledId"/>';
	var originalledDaima = '<s:property value="led.ledDaima"/>';
	var originalledName ='<s:text name="%{#request.ledname}"/>';
	var originalledWeizhi = '<s:text name="%{#request.weizhi}"/>';
	var originalledBofangshichang = '<s:property value="led.ledBofangshichang"/>';
	var originalledBofangkaishishijian = '<s:property value="led.ledBofangkaishishijian"/>';
	var originalledBofangjieshushijian = '<s:property value="led.ledBofangjieshushijian"/>';
	var originalledJianxieshichang = '<s:property value="led.ledJianxieshichang"/>';
	var originalledJianxiestart ='<s:property value="led.ledJianxiestart"/>';
	var originalledJianxieend = '<s:property value="led.ledJianxieend"/>';
	var originalledChangdu = '<s:property value="led.ledChangdu"/>';
	var originalledKuangdu = '<s:property value="led.ledKuangdu"/>';
	var originalledMianji = '<s:property value="led.ledMianji"/>';
	var originalledFenbianlv = '<s:text name="%{#request.fenbianlv}"/>';
	var originalledLeixing = '<s:property value="led.ledLeixing"/>';
//	var originalledLeixing = '<s:text name="%{#request.leixing}"/>';
	var originalledKanliprice = '<s:property value="led.ledKanliprice"/>';
	var originalstate = '<s:property value="led.state"/>';

	var nameValid = true;
	
	$(document).ready(function(){
		$("#state").val(originalstate);
		
		//保存按钮的点击事件
		$("#save").click(function(){
//			alert(originalledName+"  "+ledName);
//			alert(originalledName==ledName);
			var ledId = $("input[name='led.ledId']").val();
	        var ledDaima = $("input[name='led.ledDaima']").val();
	        var ledName =$("input[name='led.ledName']").val();
	        var ledWeizhi = $("input[name='led.ledWeizhi']").val();
	        var ledBofangshichang = $("input[name='led.ledBofangshichang']").val();
	        var ledBofangkaishishijian = $("input[name='led.ledBofangkaishishijian']").val();
	        var ledBofangjieshushijian = $("input[name='led.ledBofangjieshushijian']").val();
	        var ledJianxieshichang = $("input[name='led.ledJianxieshichang']").val();
	        var ledJianxiestart =$("input[name='led.ledJianxiestart']").val();
	        var ledJianxieend = $("input[name='led.ledJianxieend']").val();
	        var ledChangdu = $("input[name='led.ledChangdu']").val();
	        var ledKuangdu = $("input[name='led.ledKuangdu']").val();
	        var ledMianji = $("input[name='led.ledMianji']").val();
	        var ledFenbianlv = $("input[name='led.ledFenbianlv']").val();
	        var ledLeixing = $("input[name='led.ledLeixing']").val();
	        var ledKanliprice = $("input[name='led.ledKanliprice']").val();
			var state = $("select[name='led.state']").val();
			
	//		alert(originalledFenbianlv+"  "+ledFenbianlv);
			
			if(nameValid){
				if(originalledId==ledId && originalledDaima==ledDaima && originalledName==ledName &&
						originalledWeizhi==ledWeizhi && originalledBofangshichang==ledBofangshichang &&originalledBofangkaishishijian==ledBofangkaishishijian &&
						originalledBofangjieshushijian==ledBofangjieshushijian && originalledJianxieshichang==ledJianxieshichang &&
						originalledJianxiestart==ledJianxiestart && originalledJianxieend==ledJianxieend && originalledChangdu==ledChangdu &&
						originalledKuangdu==ledKuangdu && originalledMianji==ledMianji && originalledFenbianlv==ledFenbianlv &&
						originalledLeixing==ledLeixing && originalledKanliprice==ledKanliprice && originalstate==state)
				{
					alert("您没有更改信息！");
					return;
				}
			}
			if(nameValid){
				$.ajax({
					url:"updateLed.action",
					type:"post",
					data:$("#form_save").serializeArray(),
					dataType:"json",
					success:function(data){
						alert(data.info);
						if(data.state===0){ //操作成功
							location.replace('pingmuguanli');
						}
					},
					error:function(XMLHttpRequest, textStatus, errorThrown){
						alert('保存失败\nXMLHttpRequest.readyState['+XMLHttpRequest.readyState+']\nXMLHttpRequest.status['+XMLHttpRequest.status+']\ntextStatus['+textStatus+']');
					}
				})
			}
		})
	})
	function goBack(){
		if(confirm("您确定要放弃相关操作，返回到屏幕列表中吗？")){
			location.replace('pingmuguanli');
		}
	}
</script>
</content>
