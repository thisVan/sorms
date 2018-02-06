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
		<!--/.row-->

		<div class="row">
			<div class="col-lg-12">
				<h3 class="page-header">
					订单修改
					</h3>
			</div>
		</div>
		<!--/.row-->

		<form id="form_save" class="form-horizontal" role="form">
		<input type="text" class="hidden" name="tid" value='<s:property value="yewu.yewuId"/>'>
		<div class="form-group">
			<label for="account" class="col-sm-2 control-label">认刊编号</label>
			<div class="col-sm-4"><input type="text" class="form-control input-sm" name="yewu.renkanshu.renkanbianhao"  value='<s:property value="yewu.renkanshu.renkanbianhao"/>'maxlength="20" disabled></div>
		</div>
		
		<div class="form-group">
			<label for="account" class="col-sm-2 control-label">广告客户</label>
			<div class="col-sm-4"><input type="text" class="form-control input-sm" name="kanhu"  value='<s:property value="yewu.kanhu"/>'maxlength="20" disabled></div>
		</div>
		
		
		<div class="form-group">
			<label for="account" class="col-sm-2 control-label">签订日期</label>
			<div class="col-sm-4"><input type="text" class="form-control input-sm" name="yewu.renkanshu.qiandingriqi"  value='<s:property value="qiandingriqi"/>' maxlength="20" disabled></div>
		</div>
		
		<div class="form-group">
			<label for="account" class="col-sm-2 control-label">业务员</label>
			<div class="col-sm-2">
			<input type="text" class="form-control input-sm" name="bumen"  value='<s:property value="yewu.yewuyuan.bumen.bmMingcheng"/>'maxlength="20" disabled>
			    <%-- <select class="form-control input-sm" name="bumen" id="bumen_id" onchange="changeyewuyuan(this)">
					<s:iterator value="bumens">
						<option value='<s:property value="bmId"/>'><s:property value="bmMingcheng"/></option>
					</s:iterator>
			    </select> --%>
			</div>
			<div class="col-sm-2">
			<input type="text" class="form-control input-sm" name="yewuyuan"  value='<s:property value="yewu.yewuyuan.ywyXingming"/>'maxlength="20" disabled>
			    <%-- <select class="form-control input-sm" name="yewuyuan" id="yewuyuan_id">
					<s:iterator value="yewuyuans" var="thisyewuyuan" >
						<option value='<s:property value="ywyId"/>'><s:property value="ywyXingming"/></option>
					</s:iterator>
				</select> --%>
			</div>
		</div>
		
		<div class="form-group">
			<label for="account" class="col-sm-2 control-label">广告内容</label>
			<div class="col-sm-4"><textarea class="form-control input-sm " rows="3" name="guanggaoneirong" maxlength="150"><s:property value="yewu.guanggaoneirong"/></textarea></div>
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
			<label for="account" class="col-sm-2 control-label">合计实付(元)</label>
			<div class="col-sm-4"><input type="text" class="form-control input-sm" name="kanlizongjia"  value='<s:property value="yewu.renkanshu.kanlizongjia"/>'maxlength="20" readonly="readonly"></div>
		</div>
		<div class="form-group">
			<label for="account" class="col-sm-2 control-label">外购成本(元)</label>
			<div class="col-sm-4"><input type="text" class="form-control input-sm" name="purchasecost"  value='<s:property value="yewu.purchasecost"/>'maxlength="20" readonly="readonly"></div>
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
			<label for="account" class="col-sm-2 control-label">类型</label>
			<div class="col-sm-4"><input type="text" class="form-control input-sm" name="leixing"  value='<s:property value="yewu.leixing"/>'maxlength="20" disabled></div>
		</div>
		<div class="form-group">
			<label for="account" class="col-sm-2 control-label">时长</label>
			<div class="col-sm-4"><input type="text" class="form-control input-sm" name="shichang"  value='<s:property value="yewu.shichang"/>'maxlength="20" ></div>
		</div>
		<div class="form-group">
			<label for="account" class="col-sm-2 control-label">频次</label>
			<div class="col-sm-4"><input type="text" class="form-control input-sm" name="pinci"  value='<s:property value="yewu.pinci"/>'maxlength="20" ></div>
		</div>
		<div class="form-group">
			<label for="account" class="col-sm-2 control-label">播放开始时间</label>
			<div class="col-sm-4"><input type="date" class="form-control input-sm" name="kaishishijian"  value='<s:property value="kaishishijian"/>' maxlength="20" ></div>
		</div>
		
 		<div class="form-group">
			<label for="account" class="col-sm-2 control-label">播放结束时间</label>
			<div class="col-sm-4"><input type="date" class="form-control input-sm" name="jieshushijian"  value='<s:property value="jieshushijian"/>'maxlength="20" ></div>
		</div>  
		<div class="form-group">
			<label for="account" class="col-sm-2 control-label">投放时长(周)</label>
			<div class="col-sm-4"><input type="text" class="form-control input-sm" name="shuliang"  value='<s:property value="yewu.shuliang"/>'maxlength="20" ></div>
		</div>
		<div class="form-group">
			<label for="account" class="col-sm-2 control-label">刊例价小计(元)</label>
			<div class="col-sm-4"><input type="text" class="form-control input-sm" name="kanlixiaoji"  value='<s:property value="yewu.kanlijiaxiaoji"/>'maxlength="20" ></div>
		</div>
		<div class="form-group">
			<label for="account" class="col-sm-2 control-label">修改理由</label>
			<div class="col-sm-4"><textarea class="form-control input-sm " rows="3" name="updateReason" maxlength="150"></textarea></div>
		</div>
		
		<div class="form-group">
			<label for="account" class="col-sm-2 control-label">备注</label>
	<!-- 		<div class="col-sm-4"><textarea class="form-control input-sm" name="xiugaibeizhu" rows="2" ></textarea></div>  -->
			<label for="account" class="col-sm-8 control-label">${request.remark}</label>
		</div>
		
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
	var originalIndustry = '<s:property value="yewu.industry.industryId"/>';
	var originalIndustyClassify = '<s:property value="yewu.industry.industryclassify.id"/>';
	var originalLed = '<s:property value="yewu.led.ledId"/>';
	var originalShichang = '<s:property value="yewu.shichang"/>';
	var originalPinci ='<s:property value="yewu.pinci"/>';
	var originalKaishishijian = '<s:property value="#request.kaishishijian"/>';
	var originalJieshushijian = '<s:property value="#request.jieshushijian"/>';
	var originalShuliang = '<s:property value="yewu.shuliang"/>';
	var orginalGuanggaoneirong = '${yewu.guanggaoneirong}';

	var orginalYewuyuan = '<s:property value="#request.yewuyuanID"/>';
	var orginalBumen = '<s:property value="#request.bumenID"/>';

	var nameValid = true;

	$(document).ready(function(){
		$("#led_id").val(originalLed);
		$("#industry_id").val(originalIndustry);
		$("#industryclassifyid").val(originalIndustyClassify);

		$("#bumen_id").val(orginalBumen);
		$("#yewuyuan_id").val(orginalYewuyuan);
//		$("#state").val(originalstate);
//		alert(originalIndustyClassify);
		//保存按钮的点击事件
		$("#save").click(function(){
	//		alert('<s:text name="%{#request.kaishishijian}"/>');
			if(nameValid){
				if($("select[name='ledId']").val()==originalLed &&
						$("select[name='yewuyuan']").val()==orginalYewuyuan &&
						$("select[name='industryId']").val()==originalIndustry &&
						$("input[name='shichang']").val()==originalShichang &&
						$("input[name='pinci']").val()==originalPinci &&
						$("input[name='kaishishijian']").val()==originalKaishishijian &&
						$("input[name='jieshushijian']").val()==originalJieshushijian &&
						$("input[name='shuliang']").val()==originalShuliang &&
						$("textarea[name='guanggaoneirong']").val()==orginalGuanggaoneirong)
				{
					alert("您没有更改信息！");
					return;
				}
			}
			if(nameValid){
				$.ajax({
					url:"updateOrder.action",
					type:"post",
					data:$("#form_save").serializeArray(),
					dataType:"json",
					success:function(data){
						alert(data.info);
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

	//业务员二级联动
	function changeyewuyuan(obj) {
		var selectbumenid = obj.value;
		$.ajax({
	  		type:"post",
	  		dataType:"json",
	  		url:"fillYewuyuanList.action",
	  		data: { selectbumenid: selectbumenid },//提交参数
	  		success:function(data){ 	
	  			var jsonData = data.yewuyuanback;
	  			document.getElementById("yewuyuan_id").innerHTML="";
	  			for(var i=0, n = jsonData.length;i<n;i++){
	  				$("#yewuyuan_id").append("<option  value='"+jsonData[i].ywyId+"'>"+jsonData[i].ywyXingming+"</option>");		
	  			}
	  		}
	  });
	}
	
	function goBack(){
		if(confirm("您确定要放弃相关操作，返回到订单列表中吗？")){
			location.replace('dingdanguanli');
		}
	}
</script>
</content>
