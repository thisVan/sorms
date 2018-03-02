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
<meta http-equiv="description" content="合同录入">

<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<link href="css/bootstrap.min.css" rel="stylesheet" media="screen">
<link href="css/datepicker3.css" rel="stylesheet">
<link href="css/bootstrap-datetimepicker.min.css" rel="stylesheet"
	media="screen">
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
    try{r1 = this.toString().split(".")[1].length;}catch(e){r1 = 0;}
    try{r2 = arg.toString().split(".")[1].length;}catch(e){r2 = 0;}
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
    try{m += s1.split(".")[1].length;}catch(e){}
    try{m += s2.split(".")[1].length;} catch(e){}
    return Number(s1.replace(".", "")) * Number(s2.replace(".", ""))/ Math.pow(10, m);
};
// 除法
Number.prototype.div = function(arg) {
    var t1 = 0, t2 = 0, r1, r2;
    try {t1 = this.toString().split(".")[1].length;}catch(e){}
    try {t2 = arg.toString().split(".")[1].length;}catch(e){}
    with (Math) {
        r1 = Number(this.toString().replace(".", ""));
        r2 = Number(arg.toString().replace(".", ""));
        return (r1 / r2) * pow(10, t2 - t1);
    }
};

Date.prototype.Format = function(fmt) { //author: wufc   
	var o = {
		"M+" : this.getMonth() + 1, //月份   
		"d+" : this.getDate(), //日   
		"h+" : this.getHours(), //小时   
		"m+" : this.getMinutes(), //分   
		"s+" : this.getSeconds(), //秒   
		"q+" : Math.floor((this.getMonth() + 3) / 3), //季度   
		"S" : this.getMilliseconds()
	//毫秒   
	};
	if (/(y+)/.test(fmt))
		fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
	for ( var k in o)
		if (new RegExp("(" + k + ")").test(fmt))
			fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
	return fmt;
};

//全局顺序标识 
var globalIdentification;
</script>
<script type="text/javascript">
	//set the contractno validation with false
	var accountValid = false;
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
		
		dm = document.getElementById("selecttype");
		var em2 = dm.value;
		if (em2 == null || em2 == '') {
			dm.focus();
			alert("请选择合同类型！");
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
		
		if(em2 <= document.getElementById("htqishiriqi").value){
			
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
		for(var i =0;i<fqje.length;i++){
			if (fqje[i].value == null || fqje[i].value == ''|| fqje[i].value < 0) {
				var j = i+1;
				var strt = "fenqifukuanjine"+j;
				document.getElementById(strt).focus();
				alert("请输入正确的金额数值！");
				return false;
			}
			/* jinezonghe += parseInt(fqje[i].value, 10); */
			jinezonghe = Number(fqje[i].value).add(jinezonghe); 
		} 
		
		if(jinezonghe != (Number(document.getElementById("htjine").value).sub(document.getElementById("zhihuanjine").value).sub($("#cpurchasecost").val()))){
			alert("请检查各期付款金额是否和合计实付金额相符！");
			return false;
		}

		var fenqifksj = $("input[name='fenqifukuanshijian']");
		for(var i =0;i<fenqifksj.length;i++){
			if (fenqifksj[i].value == null || fenqifksj[i].value == '') {
				var j = i+1;
				var strt = "fenqishijian"+j;
				document.getElementById(strt).focus();
				alert("请输入约定付款日期！");
				return false;
			}
		} 

		return true;
	}
	var fukuantablelength = $("#fukuantable tbody tr");
	if(fukuantablelength < 1){
		alert("请输入付款信息！")
	}

	function doSubmit() {
		checkContractno($("#hetongbianhao").val());
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
				<h3 class="page-header">合同录入</h3>
			</div>
		</div>
		<!--/.row-->
		<div class="row">
			<div class="col-lg-12">
	
						<form action="saveContractInfo" role="form" id="contractform"
							enctype="multipart/form-data" class="form-horizontal"
							onkeydown="if(event.keyCode==13)return false;" method="post">

							<div class="form-group ">
								<label for="htqiandingriqi" class="col-sm-2 control-label">签订日期<span
									class="text-danger">*</span></label>
								<div class="col-sm-4">
									<input type="date" id="htqiandingriqi" name="cdate"
										value="" class="form-control " onchange="fillhtbianhao()"/>
								</div>
							</div>
							<div class="form-group ">
								<label class="col-sm-2 control-label" for="selecttype">合同类型<span
									class="text-danger">*</span></label>
								<div class="col-sm-4">
									<select class="form-control" name="ctype" id="selecttype" >
										<option value="">--请选择类型--</option>
										<option value="一般合同">发布合同</option>
										<option value="框架合同">框架合同</option>
									</select>
								</div>
							</div>
							<div class="form-group ">
								<label class="col-sm-2 control-label" for="selectyewuyuan">承办/经手人<span
									class="text-danger">*</span></label>
								<div class="col-sm-2">
									<select class="form-control" name="yewuyuan.ywyBumenid"
										id="selectbumen" onchange="changeyewuyuan(this.value)">
										<option value="">--请选择部门--</option>
										<s:iterator var="bumen" value="bumens">
											<option value='<s:property value="#bumen.bmId"/>'><s:property
													value="#bumen.bmMingcheng" /></option>
										</s:iterator>
									</select>
								</div>
								<div class="col-sm-2">
									<select class="form-control" name="yewuyuan.ywyId"
										id="selectyewuyuan">
										<option value="">--请选择人员--</option>
									</select>
								</div>
							</div>
							
							<div class="form-group" style="margin-bottom:0;">
								<label for="account" class="col-sm-2 control-label"></label>
								<div class="col-sm-4">
									<ul id="accountCheck" class="text-danger hidden" style="margin-bottom:0;"><li><span></span></li></ul>
								</div>
							</div>
							<div class="form-group ">
								<label class="col-sm-2 control-label" for="hetongbianhao">合同编号<span
									class="text-danger">*</span></label>
								<div class="col-sm-4">
									<input id="hetongbianhao" type="text" name="cno"
										class="form-control " maxlength="50" oninput="checkContractno(this.value)">
								</div>
							</div>

							<div class="form-group ">
								<label class="col-sm-2 control-label" for="guanggaokanhu">客户（全称）<span
									class="text-danger">*</span></label>
								<div class="col-sm-4">
									<input class="form-control" id="guanggaokanhu"
										name="cclient" maxlength="140">
								</div>
							</div>
							<div class="form-group  ">
								<label class="col-sm-2 control-label" for="hetongneirong">合同内容<span
									class="text-danger">*</span></label>
								<div class="col-sm-4">
									<textarea id="hetongneirong" name="ccontent"
										class="form-control " rows="5" maxlength="1000"></textarea>
								</div>
							</div>

							<div class="form-group ">
								<label class="col-sm-2 control-label" for="htqishiriqi">生效日期<span
									class="text-danger">*</span></label>
								<div class="col-sm-4">
									<input id="htqishiriqi" type="date" name="cdatestart"
										class="form-control " onchange="calContractDur()"></input>
								</div>
							</div>
							<div class="form-group ">
								<label class="col-sm-2 control-label" for="htjieshuriqi">终止日期<span
									class="text-danger">*</span></label>
								<div class="col-sm-4">
									<input id="htjieshuriqi" type="date" name="cdateend"
										class="form-control " onchange="calContractDur()"></input>
								</div>
							</div>
							<div class="form-group ">
								<label class="col-sm-2 control-label" for="htyouxiaoqi">合同期（周）<span
									class="text-danger">*</span></label>
								<div class="col-sm-4">
									<input id="htyouxiaoqi" type="number"
										name="cperiodmonths" class="form-control "></input>
								</div>
							</div>

							<div class="form-group ">
								<label class="col-sm-2 control-label" for="htjine">合同金额<span
									class="text-danger">*</span></label>
								<div class="col-sm-4">
									<input id="htjine" type="number" name="camount" class="form-control" ></input>
								</div>
							</div>
							<div class="form-group ">
								<label class="col-sm-2 control-label" for="htdiscount">折扣（折）</label>
								<div class="col-sm-4">
									<input id="htdiscount" type="number" name="cdiscount" class="form-control " ></input>
								</div>
							</div>
							<div class="form-group ">
								<label class="col-sm-2 control-label" for="zhihuanneirong">置换内容</label>
								<div class="col-sm-4">
									<textarea id="zhihuanneirong" name="creplacementcontent"
										class="form-control " rows="3" maxlength="500"></textarea>
								</div>
							</div>
							<div class="form-group ">
								<label class="col-sm-2 control-label" for="htjine">置换金额</label>
								<div class="col-sm-4">
									<input id="zhihuanjine" type="number" name="creplacementamount"
										value="0" class="form-control " ></input>
								</div>
							</div>

							<!-- <div class="form-group ">
								<label class="col-sm-2 control-label" for="renkanshubeizhu">分期</label>
								<div class="col-sm-4">
									<label class="checkbox-inline"> <input type="radio"
										name="isFenqi" id="optionsRadios4" value="1"> 是
									</label> <label class="checkbox-inline"> <input type="radio"
										name="isFenqi" id="optionsRadios4" value="0" checked="checked">
										否
									</label>
								</div>
							</div> -->
							<div class="form-group " id="fenqiqishu">
								<label class="col-sm-2 control-label" for="htfenqi">分期期数<span
									class="text-danger">*</span></label>
								<div class="col-sm-4">
									<input id="htfenqi" type="number"
										name="cinstalments" value="1" class="form-control "
										oninput="switchFenqiItem(this.value)"></input>
								</div>
							</div>
							
							<div class="form-group " id="outsourcingCosts">
								<label class="col-sm-2 control-label" for="htfenqi">外购成本&nbsp;
									<input type="checkbox" name="hasOutsourcingCosts"></label>
								<div class="col-sm-4">
									<input type="text" name="contract.cpurchasecost" id="cpurchasecost" class="form-control hidden">
								</div>
							</div>
							
							<div class="form-group">
								<p class="col-sm-6" style="color: grey">注意：若有外购成本请勾选，若不知道其具体数目请留空。</p>
							</div>
							
							<script type="text/javascript">
								/* $(function() {
									$(":radio[name='isFenqi']").click(
											function() {
												var radiocheckedval = $('input:radio:checked').val();
												if (radiocheckedval == 1) {
													$("#fenqiqishu").show();
												} else {
													$("#fenqiqishu").hide();
												}
											});

								}); */
								
								$("input[name='hasOutsourcingCosts']").change(function(){
									if($("input[name='hasOutsourcingCosts']")[0].checked) {
										$("div#outsourcingCosts input[name='contract.cpurchasecost']").removeClass("hidden");
									} else {
										$("div#outsourcingCosts input[name='contract.cpurchasecost']").addClass("hidden");
									}
								})
								
									$("form#contractform").submit(function(){
										if($("input[name='hasOutsourcingCosts']")[0].checked) {
											if($("input[name='contract.cpurchasecost']").val() == "") {
												$("input[name='contract.cpurchasecost']").val(0.0);
											}
										}
									})
								
								//业务员二级联动
								function changeyewuyuan(obj) {
									var selectbumenid = obj;
									$.ajax({
												type : "post",
												dataType : "json",
												url : "fillYewuyuanList.action",
												data : {
													selectbumenid : selectbumenid
												},//提交参数
												success : function(data) {
													var jsonData = data.yewuyuanback;
													document.getElementById("selectyewuyuan").innerHTML = "";
													$("#selectyewuyuan").append("<option value=''>--请选择人员--</option>");
													for (var i = 0, n = jsonData.length; i < n; i++) {
														$("#selectyewuyuan").append("<option  value='"+jsonData[i].ywyId+"'>"+ jsonData[i].ywyXingming + "</option>");
													}
												}
											});
								}
								//分期JavaScript 
								function switchFenqiItem(tagobj) {
									$("#fukuantable tbody").html("");
									var fenqiindex = tagobj;
									var requirepay = Number(document.getElementById("htjine").value).sub(document.getElementById("zhihuanjine").value);
									var requirefill = requirepay / fenqiindex;
									var arrfukuanfangshi = [ "现金", "支票", "汇票","其他" ];
									for (var i = 1; i <= fenqiindex; i++) {
										$("#fukuantable>tbody").append('<tr><td width="15%">第'
																+ i
																+ '期<input id="fenqiming'+i+'" name="fenqimingcheng" class="hidden" value="第'+i+'期"/></td><td width="25%"><input name="fenqijine" class="form-control" type="number" id="fenqifukuanjine'+i+'" value="'+requirefill+'" /></td><td width="25%"><input class="form-control" name="fenqifukuanshijian" type="date" id="fenqishijian'+i+'" /></td><td width="20%"><select id="selectfukuanfangshi'+i+'" class="form-control" name="fukuanfangshi"></select></td><td width="15%"><input class="form-control" name="fukuanbeizhu" type="text" id="fukuanbeizhu'+i+'" /></td></tr>');

										var fukuanfangshiid = "selectfukuanfangshi"
												+ i;
										for (var j = 0; j < arrfukuanfangshi.length; j++) {
											document.getElementById(fukuanfangshiid).options.add(new Option(
															arrfukuanfangshi[j],arrfukuanfangshi[j]));
										}
									}

								}
								
								$(document).ready(function(){
								  switchFenqiItem(document.getElementById("htfenqi").value);
									if($('input:radio:checked').val() == 0) {
										 
										 var arrfukuanfangshi = [ "现金", "支票", "汇票","其他" ];
										 for (var j = 0; j < arrfukuanfangshi.length; j++) {
											 document.getElementById("selectfukuanfangshi1").options.add(new Option(
																arrfukuanfangshi[j],arrfukuanfangshi[j]));
											}
										
									 }
					
									});
								/* //不分期时填充约定付款金额
								function fillFenqijineFirst (obj) {
									if($('input:radio:checked').val() == 0) {
										$("#fenqifukuanjine1").val(obj.value);
									}
								} */
								//检查账号是否为空以及是否重复
								function checkContractno(value){
									if(value != ""){
										$.ajax({
											url:"checkContractno.action?contractnotypein="+value,
											type:"get",
											dataType:"json",
											async:false,
											success:function(data){
												if(!data.info){
													$("#accountCheck span").text("合同编号已存在！");
													$("#accountCheck").removeClass("hidden");
													accountValid = false;
												}else{
													$("#accountCheck").addClass("hidden");
													accountValid = true;
												}
											},
											error:function (){
												alert("检查合同编号失败，请稍后再试！");
											}
										});
									}else{
										$("#accountCheck").addClass("hidden");
									}
								}
								
								function calContractDur () {
									var date1 = new Date($("#htqishiriqi").val()); //开始时间
									var date2 = new Date($("#htjieshuriqi").val()); //结束时间
									var date3 = date2.getTime() - date1.getTime(); //时间差的毫秒数
									var days = Math.floor(date3 / (24 * 3600 * 1000)) + 1;
									var weeks = days.div(7);
									if(date1 && date2){
										$("#htyouxiaoqi").val(weeks.toFixed(2));
									}
								};
								function getUUID() {
									var sdstr = new Date().Format("yyyyMMdd");
									var userid = "${session.id}";
									/* 
									var userstr = "${request.name}";
									var hiddenstr = "";
									var random2 = Math.random()*90 + 10;
									var randomflag = parseInt(random2); 
									for(var i=0,l=userstr.length;i<l;i++){
									hiddenstr += userstr.charCodeAt(i);
									}
									*/
									var seqflag ;
									
									//把flag存进去
									if(sdstr == localStorage.getItem("assistantIdentify")){
										globalIdentification = parseInt(localStorage.getItem("globalIdentification"), 10) + 1;
										localStorage.setItem("globalIdentification", globalIdentification);
									}else {
										globalIdentification = 0;
										localStorage.setItem("assistantIdentify", sdstr);
										localStorage.setItem("globalIdentification", globalIdentification);
									}
									if(globalIdentification < 10){
										seqflag = "0" + globalIdentification;
									}else {
										seqflag = globalIdentification;
									}
									
									
									return "C"+sdstr+userid+seqflag;
								}
								
								function fillhtbianhao() {
									$("#hetongbianhao").val(getUUID());
								}
							</script>

							<div class="form-group ">
								<label class="col-sm-2 control-label" for="fukuantable">付款管理<span
									class="text-danger">*</span></label>

							</div>

							<div class="form-group ">
								<div class="col-sm-6 ">
									<fieldset>
										<legend></legend>
										<table id="fukuantable" class="table-condensed"
											style="table-layout:fixed;">
											<thead align="justify">
												<th>付款期次</th>
												<th>约定付款金额</th>
												<th>约定付款时间</th>
												<th>付款方式</th>
												<th>备注</th>
											</thead>
											<tbody>
											<%-- <tr><td>第1期<input id="fenqiming1" name="fenqimingcheng" class="hidden" value="第1期"/></td><td><input name="fenqijine" class="form-control" type="number" id="fenqifukuanjine1" value="" /></td><td><input class="form-control" name="fenqifukuanshijian" type="date" id="fenqishijian1" /><td><select id="selectfukuanfangshi1" class="form-control" name="fukuanfangshi"></select></td><td><input class="form-control" name="fukuanbeizhu" type="text" id="fukuanbeizhu1" /></td></tr> --%>
											</tbody>
										</table>
									</fieldset>
								</div>
							</div>

							<div class="form-group ">
								<label class="col-sm-2 control-label" for="renkanshubeizhu">备注</label>
								<div class="col-sm-4">
									<textarea id="htbeizhu" name="cremark"
										class="form-control" rows="2"></textarea>
								</div>
							</div>

							<div class="form-group col-sm-6" align="center">
								<button type="button" id="store" class="btn">保存</button>
								<button type="button" id="restore" class="btn">恢复</button>
								<button type="button" class="btn btn-primary"
									onclick="doSubmit()">提交</button>
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
		if (window.localStorage) {

		} else {
			alert('您的浏览器不支持表单保存功能');
		}

		var localStorageStateTip = "";
		//保存表单到本地

		function localFormStorageSave() {
			if ($("#htqiandingriqi").val() == null || $("#htqiandingriqi").val() == "" 
					|| $("#selecttype").val() == null || $("#selecttype").val() == "" 
					|| $("#hetongbianhao").val() == null || $("#hetongbianhao").val() == "" 
					|| $("#selectyewuyuan").val() == null || $("#selectyewuyuan").val() == "" 
					|| $("#guanggaokanhu").val() == null || $("#guanggaokanhu").val() == "" 
					|| $("#hetongneirong").val() == null || $("#hetongneirong").val() == "" 
					|| $("#htqishiriqi").val() == null || $("#htqishiriqi").val() == ""
					|| $("#htjieshuriqi").val() == null || $("#htjieshuriqi").val() == "" 
					|| $("#htjine").val() == null || $("#htjine").val() == "" 
					|| $("#htfenqi").val() == null || $("#htfenqi").val() == "") {
				localStorageStateTip = "合同或年单的必填内容为空，系统将不进行保存！";
			} else {

				localStorage.setItem("contract.qiandingriqi", $("#htqiandingriqi").val());
				localStorage.setItem("contract.selecttype", $("#selecttype").val());

				localStorage.setItem("contract.ywyBumenid", $("#selectbumen").val());
				localStorage.setItem("contract.ywyId", $("#selectyewuyuan").val());
				localStorage.setItem("contract.hetongbianhao", $("#hetongbianhao").val());
				localStorage.setItem("contract.hetongneirong", $("#hetongneirong").val());
				localStorage.setItem("contract.guanggaokanhu", $("#guanggaokanhu").val());
				localStorage.setItem("contract.htqishiriqi", $("#htqishiriqi").val());
				localStorage.setItem("contract.htjieshuriqi", $("#htjieshuriqi").val());
				localStorage.setItem("contract.htyouxiaoqi", $("#htyouxiaoqi").val());
				localStorage.setItem("contract.htjine", $("#htjine").val());
				localStorage.setItem("contract.htdiscount", $("#htdiscount").val());
				localStorage.setItem("contract.htfenqi", $("#htfenqi").val());
				localStorage.setItem("contract.htbeizhu", $("#htbeizhu").val());
				localStorage.setItem("contract.zhihuanneirong", $("#zhihuanneirong").val());
				localStorage.setItem("contract.zhihuanjine", $("#zhihuanjine").val());

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
			$("#selecttype").val(localStorage.getItem("contract.selecttype"));
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
			$("#htdiscount").val(localStorage.getItem("contract.htdiscount"));
			$("#htfenqi").val(localStorage.getItem("contract.htfenqi"));
			$("#htbeizhu").val(localStorage.getItem("contract.htbeizhu"));
			$("#zhihuanjine").val(localStorage.getItem("contract.zhihuanjine"));
			$("#zhihuanneirong").val(localStorage.getItem("contract.zhihuanneirong"));

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
											+ '</select></td><td ><div class="has-success"><input name="starttimeledtable" class="form-control" type="date" id="starttime'+j+'" /></div></td><td><div class=""><input name="endtimeledtable"  class="form-control" type="date" id="endtime'+j+'" /></div></td><td><div class=""><input name="guanggaoshuliangledtable"  class="form-control" type="text" id="guanggaoshuliang'+j+'" value="4" /></div></td><td><input name="pinciledtable" style="width:70px;" class="form-control" id="pinci'+j+'" ></input></td><td><input name="shichangledtable" style="width:64px;" class="form-control" id="shichang'+j+'" ></input></td><td style="display:none"><input name="kanlijialedtable" class="form-control hidden" id="kanlijia'
							+ j
							+ '" ></input></td><td><div class=""><input name="kanlijiaxiaojiledtable" class="form-control" value="0" id="kanlijiaxiaoji'
											+ j
											+ '" onblur="kanlijiaonchange()" ></input></div></td><td><a class="form-control" onclick="deltr(this)"><span class="glyphicon glyphicon-remove"></span></a></td><td><input name="kanlijiaclassicfenpingtable" class="hidden" id="kanlijiaclassicfenping'
							+ j
							+ '"></input></td></tr>'); */

				}
			}

		}
		function localFormStorageClean() {
			var timestampstr = localStorage.getItem("assistantIdentify");
			var indentify = localStorage.getItem("globalIdentification");
			localStorage.clear();
			var timestampstr = localStorage.getItem("assistantIdentify");
			localStorage.setItem("globalIdentification", indentify);
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
