<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="com.google.gson.*"%>
<%@ taglib uri="/struts-tags" prefix="s"%>

<!DOCTYPE html>
<html>
<head>
<link rel="icon" href="images/logo.png" type="image/x-icon" />
<link rel="shortcut icon" href="images/logo.png" type="image/x-icon" />

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="description" content="合同详情">

<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<link href="css/bootstrap.min.css" rel="stylesheet" media="screen">
<link href="css/datepicker3.css" rel="stylesheet">
<link href="css/bootstrap-datetimepicker.min.css" rel="stylesheet" media="screen">
<link href="css/bootstrap-table.css" rel="stylesheet">

<link href="css/styles.css" rel="stylesheet">

<!--Icons-->
<script src="js/lumino.glyphs.js"></script>
<style type="text/css">
.form-horizontal .control-label {
	text-align: left;
}
</style>
<!-- 本地存储和恢复 -->
<!-- 自己写本地存储和恢复 -->
<!-- <script type="text/javascript" src="js/jsLocalStore/jquery.json.js"></script>
<script type="text/javascript" src="js/jsLocalStore/jstorage.js"></script>
<script type="text/javascript" src="js/jsLocalStore/jquery.formStorage.js"></script> -->
<script type="text/javascript">
	//加
	Number.prototype.add = function(arg) {
		var r1, r2, m;
		try {
			r1 = this.toString().split(".")[1].length;
		} catch (e) {
			r1 = 0;
		}
		try {
			r2 = arg.toString().split(".")[1].length;
		} catch (e) {
			r2 = 0;
		}
		m = Math.pow(10, Math.max(r1, r2));
		return (this * m + arg * m) / m;
	};
	// 减法
	Number.prototype.sub = function(arg) {
		return this.add(-arg);
	};

	// 乘法
	Number.prototype.mul = function(arg) {
		var m = 0, s1 = this.toString(), s2 = arg.toString();
		try {
			m += s1.split(".")[1].length;
		} catch (e) {
		}
		try {
			m += s2.split(".")[1].length;
		} catch (e) {
		}
		return Number(s1.replace(".", "")) * Number(s2.replace(".", "")) / Math.pow(10, m);
	};
	// 除法
	Number.prototype.div = function(arg) {
		var t1 = 0, t2 = 0, r1, r2;
		try {
			t1 = this.toString().split(".")[1].length;
		} catch (e) {
		}
		try {
			t2 = arg.toString().split(".")[1].length;
		} catch (e) {
		}
		with (Math) {
			r1 = Number(this.toString().replace(".", ""));
			r2 = Number(arg.toString().replace(".", ""));
			return (r1 / r2) * pow(10, t2 - t1);
		}
	};
</script>
<script type="text/javascript">

	//判断表单内容是否改变
	var formIsChanged = false;
	//set the contractno validation with false
	var accountValid = true;
	/**
	 * 进行前端验证
	 */
	function frontdatavalidate() {

		var dm = document.getElementById("htqiandingriqi");
		var em1 = dm.value;
		if (em1 == null || em1 == '') {
			dm.focus();
			alert("请输入签订日期！");
			return false;
		}

		dm = document.getElementById("selectyewuyuan");
		var em2 = dm.value;
		if (em2 == null || em2 == '') {
			dm.focus();
			alert("请选择签订人/经手人！");
			return false;
		}

		dm = document.getElementById("hetongbianhao");
		var em2 = dm.value;
		if (em2 == null || em2 == '') {
			dm.focus();
			alert("请输入合同编号！");
			return false;
		}

		dm = document.getElementById("guanggaokanhu");
		var em2 = dm.value;
		if (em2 == null || em2 == '') {
			dm.focus();
			alert("请输入客户名称！");
			return false;
		}

		dm = document.getElementById("hetongneirong");
		var em2 = dm.value;
		if (em2 == null || em2 == '') {
			dm.focus();
			alert("请输入合同内容！");
			return false;
		}

		dm = document.getElementById("htqishiriqi");
		var em2 = dm.value;
		if (em2 == null || em2 == '') {
			dm.focus();
			alert("请输入合同开始日期！");
			return false;
		}

		dm = document.getElementById("htjieshuriqi");
		var em2 = dm.value;
		if (em2 == null || em2 == '') {
			dm.focus();
			alert("请输入合同结束日期！");
			return false;
		}

		if (em2 <= document.getElementById("htqishiriqi").value) {

			alert("合同结束日期不能早于开始日期！");
			return false;
		}

		dm = document.getElementById("htyouxiaoqi");
		var em2 = dm.value;
		if (em2 == null || em2 == '') {
			dm.focus();
			alert("请输入合同有效期！");
			return false;
		}

		dm = document.getElementById("htjine");
		var em2 = dm.value;
		if (em2 == null || em2 == '') {
			dm.focus();
			alert("请输入合同金额！");
			return false;
		}

		dm = document.getElementById("htfenqi");
		var em2 = dm.value;
		if (em2 == null || em2 == '') {
			dm.focus();
			alert("请输入分期次数！");
			return false;
		}

		// 前端验证分期付款填写
		var fqje = $("input[name='fenqijine']");
		var jinezonghe = 0;
		for (var i = 0; i < fqje.length; i++) {
			if (fqje[i].value == null || fqje[i].value == '' || fqje[i].value < 0) {
				var j = i + 1;
				var strt = "fenqifukuanjine" + j;
				document.getElementById(strt).focus();
				alert("请输入正确的金额数值！");
				return false;
			}
			/* jinezonghe += parseInt(fqje[i].value, 10); */
			jinezonghe = Number(fqje[i].value).add(jinezonghe);
		}

		if (jinezonghe != document.getElementById("htjine").value) {
			alert("请检查各期付款金额是否和合计实付金额相符！");
			return false;
		}

		var fenqifksj = $("input[name='fenqifukuanshijian']");
		for (var i = 0; i < fenqifksj.length; i++) {
			if (fenqifksj[i].value == null || fenqifksj[i].value == '') {
				var j = i + 1;
				var strt = "fenqishijian" + j;
				document.getElementById(strt).focus();
				alert("请输入约定付款日期！");
				return false;
			}
		}

		return true;
	}

	function doSubmit() {
		console.log(formIsChanged);
		if (formIsChanged && frontdatavalidate()) {
			$.ajax({
				url:"updateContract.action",
				data:$("#contractform").serializeArray(),
				type:"post",
				dataType:"json",
				success:function(data){
					if(data.state===0){
						alert(data.info);
						location.replace('contractManage');
					}else{
						alert(data.info);
					}
				},
				error:function(XMLHttpRequest, textStatus, errorThrown){
						alert('操作失败\nXMLHttpRequest.readyState['+XMLHttpRequest.readyState+']\nXMLHttpRequest.status['+XMLHttpRequest.status+']\ntextStatus['+textStatus+']');
				}
			}) 
		} 
		console.log(frontdatavalidate());
		if (frontdatavalidate() && accountValid) {
			$("#contractform").submit();
		}

	}
	

	/* $(document).ready(function(){
		$("input[name='cno']").maxlength({
	    	maxCharacters:50,
	    	status:false,
	    	showAlert:true,
	    	alertText:"您输入的长度过长！"
	    })
	   $("input[name='cclient']").maxlength({
	    	maxCharacters:140,
	    	status:false,
	    	showAlert:true,
	    	alertText:"您输入的长度过长！"
	    })
	}); */
</script>

<!--[if lt IE 9]>
<script src="js/html5shiv.js"></script>
<script src="js/respond.min.js"></script>
<![endif]-->

</head>

<body style="font-family: '微软雅黑';">

	<div class="main">
		<div class="row">
			<div class="col-lg-12">
				<h3 class="page-header">合同修改</h3>
			</div>
		</div>
		<!--/.row-->
		<div class="row">
			<div class="col-lg-12">
				<form action="updateContractInfo" role="form" id="contractform" enctype="multipart/form-data" class="form-horizontal" onkeydown="if(event.keyCode==13)return false;" method="post">

					<div class="form-group has-error">
						<label class="col-sm-2 control-label" for="hetongbianhao">合同编号<span class="text-danger">*</span></label>
						<div class="col-sm-4">
							<input id="hetongbianhao" type="text" name="cno" class="form-control " maxlength="50" oninput="checkContractno(this.value)" value="<s:property value="#contract.cno"/>" readonly="readonly">
						</div>
					</div>

					<div class="form-group has-error">
						<label for="htqiandingriqi" class="col-sm-2 control-label">签订日期<span class="text-danger">*</span></label>
						<div class="col-sm-4">
							<input type="date" id="htqiandingriqi" name="cdate" value="<s:date name='#contract.cdate' format="yyyy-MM-dd"/>" class="form-control " />
						</div>
					</div>
					<div class="form-group has-error">
						<label class="col-sm-2 control-label" for="selectyewuyuan">承办/经手人<span class="text-danger">*</span></label>
						<div class="col-sm-2">
							<select class="form-control" name="yewuyuan.ywyBumenid" id="selectbumen" onchange="changeyewuyuan(this.value)">
								<option value="">--请选择部门--</option>
								<s:iterator id="bumen" value="bumenList">
									<option value='<s:property value="#bumen.bmId"/>'><s:property value="#bumen.bmMingcheng" /></option>
								</s:iterator>
							</select>
						</div>
						<div class="col-sm-2">
							<select class="form-control" name="cyewuyuan" id="selectyewuyuan">
								<option value="">--请选择人员--</option>
							</select>
						</div>
					</div>

					<div class="form-group" style="margin-bottom:0;">
						<label for="account" class="col-sm-2 control-label"></label>
						<div class="col-sm-4">
							<ul id="accountCheck" class="text-danger hidden" style="margin-bottom:0;">
								<li><span></span></li>
							</ul>
						</div>
					</div>


					<div class="form-group has-error">
						<label class="col-sm-2 control-label" for="guanggaokanhu">客户（全称）<span class="text-danger">*</span></label>
						<div class="col-sm-4">
							<input class="form-control" id="guanggaokanhu" name="cclient" value="<s:property value="#contract.cclient"/>" maxlength="140" >
						</div>
					</div>
					<div class="form-group  has-error">
						<label class="col-sm-2 control-label" for="hetongneirong">合同内容<span class="text-danger">*</span></label>
						<div class="col-sm-4">
							<textarea id="hetongneirong" name="ccontent" class="form-control " rows="5" maxlength="1000"><s:property value="#contract.ccontent" /></textarea>
						</div>
					</div>

					<div class="form-group has-error">
						<label class="col-sm-2 control-label" for="htqishiriqi">生效日期<span class="text-danger">*</span></label>
						<div class="col-sm-4">
							<input id="htqishiriqi" type="date" name="cdatestart" class="form-control " value="<s:date name='#contract.cdatestart' format="yyyy-MM-dd"/>" />
						</div>
					</div>
					<div class="form-group has-error">
						<label class="col-sm-2 control-label" for="htjieshuriqi">终止日期<span class="text-danger">*</span></label>
						<div class="col-sm-4">
							<input id="htjieshuriqi" type="date" name="cdateend" value="<s:date name='#contract.cdateend' format="yyyy-MM-dd"/>" class="form-control "></input>
						</div>
					</div>
					<div class="form-group has-error">
						<label class="col-sm-2 control-label" for="htyouxiaoqi">合同期（月）<span class="text-danger">*</span></label>
						<div class="col-sm-4">
							<input id="htyouxiaoqi" type="number" name="cperiodmonths" value="<s:property value="#contract.cperiodmonths"/>" class="form-control "></input>
						</div>
					</div>

					<div class="form-group has-error">
						<label class="col-sm-2 control-label" for="htjine">合同金额<span class="text-danger">*</span></label>
						<div class="col-sm-4">
							<input id="htjine" type="number" name="camount" value="<s:property value="#contract.camount"/>" class="form-control "></input>
						</div>
					</div>
					<div class="form-group has-error" id="fenqiqishu">
						<label class="col-sm-2 control-label" for="htfenqi">分期期数<span class="text-danger">*</span></label>
						<div class="col-sm-4">
							<input id="htfenqi" type="number" name="cinstalments" value="<s:property value="#contract.cinstalments"/>" class="form-control " oninput="switchFenqiItem(this.value)"></input>
						</div>
					</div>

					<script type="text/javascript">
						var orginalYewuyuan = '<s:property value="#contract.yewuyuan.ywyId"/>';
						var orginalBumen = '<s:property value="#contract.yewuyuan.bumen.bmId"/>';
						$(function(){
							$("#selectbumen").val(orginalBumen);
							changeyewuyuan(orginalBumen);
							$("#selectyewuyuan").val(orginalYewuyuan);
						})
						//业务员二级联动
						function changeyewuyuan(obj) {
							var selectbumenid = obj;
							if(selectbumenid == "") {
								$("#selectyewuyuan").empty();
								$("#selectyewuyuan").append("<option value=''>--请选择人员--</option>");
							} else {
								$.ajax({
									type : "post",
									dataType : "json",
									url : "fillYewuyuanList.action",
									async: false,
									data : {
										selectbumenid : selectbumenid
									},//提交参数
									success : function(data) {
										var jsonData = data.yewuyuanback;
										$("#selectyewuyuan").empty();
										$("#selectyewuyuan").append("<option value=''>--请选择人员--</option>");
										for (var i = 0, n = jsonData.length; i < n; i++) {
											$("#selectyewuyuan").append("<option  value='"+jsonData[i].ywyId+"'>" + jsonData[i].ywyXingming + "</option>");
										}
									}
								});
							}
						}
						//分期JavaScript 
						function switchFenqiItem(tagobj) {
							$("#fukuantable tbody").html("");
							var fenqiindex = tagobj;
							var requirepay = document.getElementById("htjine").value;
							var requirefill = requirepay / fenqiindex;
							var arrfukuanfangshi = [ "现金", "支票", "汇票", "其他" ];
							for (var i = 1; i <= fenqiindex; i++) {
								$("#fukuantable>tbody")
										.append(
												'<tr><td width="15%">第'
														+ i
														+ '期<input id="fenqiming'+i+'" name="fenqimingcheng" class="hidden" value="第'+i+'期"/></td><td width="25%"><input name="fenqijine" class="form-control" type="number" id="fenqifukuanjine'+i+'" value="'+requirefill+'" /></td><td width="25%"><input class="form-control" name="fenqifukuanshijian" type="date" id="fenqishijian'+i+'" /></td><td width="20%"><select id="selectfukuanfangshi'+i+'" class="form-control" name="fukuanfangshi"></select></td><td width="15%"><input class="form-control" name="fukuanbeizhu" type="text" id="fukuanbeizhu'+i+'" /></td></tr>');

								var fukuanfangshiid = "selectfukuanfangshi" + i;
								for (var j = 0; j < arrfukuanfangshi.length; j++) {
									document.getElementById(fukuanfangshiid).options.add(new Option(arrfukuanfangshi[j], arrfukuanfangshi[j]));
								}
							}

						}


						//检查账号是否为空以及是否重复
						function checkContractno(value) {
							if (value) {
								$.ajax({
									url : "checkContractno.action?contractnotypein=" + value,
									type : "get",
									dataType : "json",
									success : function(data) {
										if (!data.info) {
											$("#accountCheck span").text("合同编号已存在！");
											$("#accountCheck").removeClass("hidden");
											accountValid = false;
										} else {
											$("#accountCheck").addClass("hidden");
											accountValid = true;
										}
									}
								})
							} else {
								$("#accountCheck").addClass("hidden");
							}
						}
					</script>

					<div class="form-group ">
						<label class="col-sm-2 control-label" for="fukuantable">付款管理</label>

					</div>

					<div class="form-group ">
						<div class="col-sm-6 ">
							<fieldset>
								<legend></legend>
								<table id="fukuantable" class="table-condensed" style="table-layout:fixed;">
									<thead align="justify">
										<th>付款期次</th>
										<th>约定付款金额</th>
										<th>约定付款时间</th>
										<th>付款方式</th>
										<th>备注</th>
									</thead>
									<tbody>
										<s:iterator id="fukuan" value="fukuanList" status="st">
											<tr>
												<td><s:property value="#fukuan.mingcheng" /><input id="fenqiming<s:property value="#st.count"/>" name="fenqimingcheng" class="hidden" value="<s:property value="#fukuan.mingcheng"/>" /></td>
												<td><input id="fenqifukuanjine<s:property value="#st.count"/>" name="fenqijine" class="form-control" type="number" value="<s:property value="#fukuan.jine"/>" /></td>
												<td><input id="fenqishijian<s:property value="#st.count"/>" class="form-control" name="fenqifukuanshijian" type="date" value="<s:date name='#fukuan.fukuanshijian' format='yyyy-MM-dd'/>" /></td>
												<td><s:select list="#{'现金':'现金','支票':'支票','汇票':'汇票','其他':'其他'}" name="fukuanfangshi" listKey="key" listValue="value" 
												id="selectfukuanfangshi%{#st.count}" value="#fukuan.fukuanfangshi" cssClass="form-control" ></s:select></td>
												<td><input id="fukuanbeizhu<s:property value="#st.count"/>" class="form-control" name="fukuanbeizhu" type="text" value="<s:property value="#fukuan.fukuanbeizhu"/>" /></td>
											</tr>
										</s:iterator>
									</tbody>
								</table>
							</fieldset>
						</div>
					</div>

					<div class="form-group has-error">
						<label class="col-sm-2 control-label" for="renkanshubeizhu">备注</label>
						<div class="col-sm-4">
							<textarea id="htbeizhu" name="cremark" class="form-control" rows="2"></textarea>
						</div>
					</div>
					
					<div class="form-group has-error">
						<label class="col-sm-2 control-label" for="xiugailiyou">修改理由</label>
						<div class="col-sm-4">
							<textarea id="xiugailiyou" name="cmodcomment" class="form-control" rows="1"></textarea>
						</div>
					</div>

					<div class="form-group col-sm-6" align="center">
						<button type="button" id="store" class="btn">保存</button>
						<button type="button" id="restore" class="btn">恢复</button>
						<button type="button" class="btn btn-primary" onclick="doSubmit()">提交</button>
						<button type="reset" class="btn btn-default">清空</button>

					</div>

				</form>
			</div>
			<!-- /.col-->
		</div>
		<!-- /.row -->


	</div>
	<!--/.main-->

	<script src="js/bootstrap.min.js"></script>
	<script src="js/king-common.js"></script>
	<script type="text/javascript" src="js/bootstrap-datetimepicker.js"></script>
	<script src="js/bootstrap-datetimepicker.zh-CN.js" charset="UTF-8"></script>

	<script type="text/javascript" src="js/bootstrap-table.js"></script>
	<!--
    	作者：this.van@hotmail.com
    	时间：2016-06-19
    	描述：时间选择
    -->
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

	<script type="text/javascript">
		$(document).ready(function() {
			console.log("${fukuanList}");
			//为表单元素绑定改变事件
			$("form :input").change(function () {   
				formIsChanged = true;   
			}); 
				
		})
		if (window.localStorage) {

		} else {
			alert('您的浏览器不支持表单保存功能');
		}

		var localStorageStateTip = "";
		//保存表单到本地

		function localFormStorageSave() {
			if ($("#htqiandingriqi").val() == null || $("#htqiandingriqi").val() == "" || $("#hetongbianhao").val() == null || $("#hetongbianhao").val() == "" || $("#selectyewuyuan").val() == null || $("#selectyewuyuan").val() == "" || $("#guanggaokanhu").val() == null || $("#guanggaokanhu").val() == "" || $("#hetongneirong").val() == null || $("#hetongneirong").val() == "" || $("#htqishiriqi").val() == null || $("#htqishiriqi").val() == "" || $("#htjieshuriqi").val() == null
					|| $("#htjieshuriqi").val() == "" || $("#htjine").val() == null || $("#htjine").val() == "" || $("#htfenqi").val() == null || $("#htfenqi").val() == "") {
				localStorageStateTip = "合同或年单的必填内容为空，系统将不进行保存！";
			} else {

				localStorage.setItem("contract.qiandingriqi", $("#htqiandingriqi").val());
				localStorage.setItem("contract.ywyBumenid", $("#selectbumen").val());
				localStorage.setItem("contract.ywyId", $("#selectyewuyuan").val());
				localStorage.setItem("contract.hetongbianhao", $("#hetongbianhao").val());
				localStorage.setItem("contract.hetongneirong", $("#hetongneirong").val());
				localStorage.setItem("contract.guanggaokanhu", $("#guanggaokanhu").val());
				localStorage.setItem("contract.htqishiriqi", $("#htqishiriqi").val());
				localStorage.setItem("contract.htjieshuriqi", $("#htjieshuriqi").val());
				localStorage.setItem("contract.htyouxiaoqi", $("#htyouxiaoqi").val());
				localStorage.setItem("contract.htjine", $("#htjine").val());
				localStorage.setItem("contract.htfenqi", $("#htfenqi").val());
				localStorage.setItem("contract.htbeizhu", $("#htbeizhu").val());

				var fenqimingcheng = new Array();
				$("input[name='fenqimingcheng']").each(function() {
					fenqimingcheng.push($(this).val());
				});
				var fenqijine = new Array();
				$("input[name='fenqijine']").each(function() {
					fenqijine.push($(this).val());
				});
				var fenqifukuanshijian = new Array();
				$("input[name='fenqifukuanshijian']").each(function() {
					fenqifukuanshijian.push($(this).val());
				});
				var fukuanfangshi = new Array();
				$("select[name='fukuanfangshi']").each(function() {
					fukuanfangshi.push($(this).val());
				});
				var fukuanbeizhu = new Array();
				$("input[name='fukuanbeizhu']").each(function() {
					fukuanbeizhu.push($(this).val());
				});

				localStorage.setItem("contract.fenqimingcheng", fenqimingcheng);
				localStorage.setItem("contract.fenqijine", fenqijine);
				localStorage.setItem("contract.fenqifukuanshijian", fenqifukuanshijian);
				localStorage.setItem("contract.fukuanfangshi", fukuanfangshi);
				localStorage.setItem("contract.fukuanbeizhu", fukuanbeizhu);

				localStorageStateTip = "合同保存成功！清除浏览器缓存将会清空已保存的合同信息，请谨慎操作！";
			}

		}
		function localFormStorageRestore() {
			$("#htqiandingriqi").val(localStorage.getItem("contract.qiandingriqi"));
			$("#selectbumen").val(localStorage.getItem("contract.ywyBumenid"));
			changeyewuyuan(localStorage.getItem("contract.ywyBumenid"));
			//设置100毫秒后回填业务员列表，防止无法回填
			setTimeout(function() {
				$("#selectyewuyuan").val(localStorage.getItem("contract.ywyId"));
			}, 100)

			$("#hetongbianhao").val(localStorage.getItem("contract.hetongbianhao"));
			$("#hetongneirong").val(localStorage.getItem("contract.hetongneirong"));
			$("#baogaobianhao").val(localStorage.getItem("renkanshu.baogaobianhao"));
			$("#guanggaokanhu").val(localStorage.getItem("contract.guanggaokanhu"));
			$("#htqishiriqi").val(localStorage.getItem("contract.htqishiriqi"));
			$("#htjieshuriqi").val(localStorage.getItem("contract.htjieshuriqi"));
			$("#htyouxiaoqi").val(localStorage.getItem("contract.htyouxiaoqi"));
			$("#htjine").val(localStorage.getItem("contract.htjine"));
			$("#htfenqi").val(localStorage.getItem("contract.htfenqi"));
			$("#htbeizhu").val(localStorage.getItem("contract.htbeizhu"));

			var fenqijine = localStorage.getItem("contract.fenqijine").split(",");
			var fenqifukuanshijian = localStorage.getItem("contract.fenqifukuanshijian").split(",");
			var fukuanfangshi = localStorage.getItem("contract.fukuanfangshi").split(",");
			var fukuanbeizhu = localStorage.getItem("contract.fukuanbeizhu").split(",");
			var fenqimingcheng = localStorage.getItem("contract.fenqimingcheng").split(",");

			if (localStorage.getItem("contract.fenqimingcheng").length > 0) {
				switchFenqiItem(fenqimingcheng.length);

				for (var j = 1; j <= fenqimingcheng.length; j++) {
					$("#fenqifukuanjine" + j + "").val(fenqijine[j - 1]);
					$("#fenqishijian" + j + "").val(fenqifukuanshijian[j - 1]);
					$("#selectfukuanfangshi" + j + "").val(fukuanfangshi[j - 1]);
					$("#fukuanbeizhu" + j + "").val(fukuanbeizhu[j - 1]);

					/* $("#table>tbody")
							.append(
									'<tr><td><select name="shanghuadianweiledtable"  class="form-control" id="shanghuadianwei'
											+ j
											+ '" onchange="kanliclassiconchange(this)">'
											+ optionselectHtml.join()
											+ '</select></td><td><select name="guanggaoleixingledtable"  class="form-control" id="guanggaoleixing'+j+'" >'
											+ optionselectguanggaoleixing
													.join()
											+ '</select></td><td ><div class="has-success"><input name="starttimeledtable" class="form-control" type="date" id="starttime'+j+'" /></div></td><td><div class="has-error"><input name="endtimeledtable"  class="form-control" type="date" id="endtime'+j+'" /></div></td><td><div class="has-error"><input name="guanggaoshuliangledtable"  class="form-control" type="text" id="guanggaoshuliang'+j+'" value="4" /></div></td><td><input name="pinciledtable" style="width:70px;" class="form-control" id="pinci'+j+'" ></input></td><td><input name="shichangledtable" style="width:64px;" class="form-control" id="shichang'+j+'" ></input></td><td style="display:none"><input name="kanlijialedtable" class="form-control hidden" id="kanlijia'
							+ j
							+ '" ></input></td><td><div class="has-error"><input name="kanlijiaxiaojiledtable" class="form-control" value="0" id="kanlijiaxiaoji'
											+ j
											+ '" onblur="kanlijiaonchange()" ></input></div></td><td><a class="form-control" onclick="deltr(this)"><span class="glyphicon glyphicon-remove"></span></a></td><td><input name="kanlijiaclassicfenpingtable" class="hidden" id="kanlijiaclassicfenping'
							+ j
							+ '"></input></td></tr>'); */

				}
			}

		}
		function localFormStorageClean() {
			localStorage.clear();
		}
	</script>
	<script type="text/javascript">
		$('#store, #restore').on('click', function() {
			if (this.id == 'store') {
				localFormStorageSave();
				if (localStorageStateTip.length > 0) {
					alert(localStorageStateTip);
				}
				localStorageStateTip = "";
			} else {
				if (localStorage.length > 0) {
					localFormStorageRestore();
				} else {
					alert("对不起，找不到已保存的记录！");
				}

			}

		});

		window.setInterval("localFormStorageSave()", 180000);
	</script>

	<script>
		!function($) {
			$(document).on("click", "ul.nav li.parent > a > span.icon", function() {
				$(this).find('em:first').toggleClass("glyphicon-minus");
			});
			$(".sidebar span.icon").find('em:first').addClass("glyphicon-plus");
		}(window.jQuery);

		$(window).on('resize', function() {
			if ($(window).width() > 768)
				$('#sidebar-collapse').collapse('show')
		})
		$(window).on('resize', function() {
			if ($(window).width() <= 767)
				$('#sidebar-collapse').collapse('hide')
		})
	</script>

</body>

</html>
