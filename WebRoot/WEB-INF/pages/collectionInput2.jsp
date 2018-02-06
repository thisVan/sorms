<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> 
<!DOCTYPE html>
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
	<link rel="stylesheet" href="css/bootstrap-select.css">

	
	<link rel="stylesheet" href="css/bootstrap-theme.css">
	<link href="css/styles.css" rel="stylesheet">
	<link href="css/jquery-confirm.min.css" rel="stylesheet">
	<link href="css/laydate.css" rel="stylesheet">
	<!--Icons-->
	<script src="js/lumino.glyphs.js"></script>
	<script src="js/jquery-confirm.min.js"></script>
	<script src="js/jquery.jqGrid.fluid.js"></script>
	<script src="js/bootstrap-select.js"></script>

</head>
<body>
<div class="main">
	<!--/.row-->
	<div class="row">
		<div class="col-lg-12">
			<h3 class="page-header">收款录入</h3>
		</div>
	</div>
</div>

<div class="row" >
	<div class="col-lg-12">
		<div align="center" style="font-size: large;color: red">${session.errMessage }</div>
	</div>
	<div class="col-lg-12">
		<form action="saveCollection" role="form" id="collectionForm" enctype="multipart/form-data" class="form-horizontal" onkeydown="if(event.keyCode==13)return false;" method="post">
			<div class="col-lg-12">
			<div class="form-group form-inline col-md-12 col-lg-6 hidden" >
						<input type="text" id="orderpayId" name="orderpayId" value=" ${thisorderpayid }" class="form-control" readOnly="true"/>
				</div>
				<div class="form-group form-inline col-md-12 col-lg-6 " id="renkanshubianhaolable">
					<label style="width: 30%; text-align: left" for="dtp_input2" class="control-label">认刊书编号</label>
						<input type="text" id="renkanshuId" name="renkanshuId" value="<%=request.getParameter("renkanshuId")%>" class="form-control" readOnly="true"/>
				</div>
				<div class="form-group form-inline col-md-12 col-lg-6" id="hetongbianhaolable">
					<label style="width: 30%; text-align: left" for="dtp_input2" class="control-label">合同编号</label>
						<input type="text" id="contractId" name="skContractno" value="<%=request.getParameter("contractId")%>" class="form-control" readOnly="true"/>
				</div>
				<div class="form-group form-inline col-md-12 col-lg-6">
					<label style="width: 30%;text-align: left;" for="dtp_input2" class="control-label">签订日期</label>
						<input type="date" id="signDate" name="signDate" value="<%=request.getParameter("signDate")%>" class="form-control" readOnly="true"/>
				</div>
				<div class="form-group form-inline col-md-12 col-lg-6">
					<label style="width: 30%;text-align: left;" for="dtp_input2" class="control-label">刊户</label>
						<input type="text" id="client" name="client" value="<%=request.getParameter("client")%>" class="form-control" readOnly="true"/>
				</div>
				<div class="form-group form-inline col-md-12 col-lg-6">
					<label style="width: 30%;text-align: left;" for="dtp_input2" class="control-label">承办人</label>
						<input type="text" id="chengbanren" name="chengbanren" value="<%=request.getParameter("salesmanName") %>" class="form-control" readOnly="true"/>
						<input type="hidden" id="yewuyuanid" name="skYwyid" value="<%=request.getParameter("salesmanId") %>" class="form-control" />
				</div>
				<div class="form-group form-inline col-md-12 col-lg-6">
					<label style="width: 30%;text-align: left;" for="dtp_input2" class="control-label">应付总额</label>
						<input type="text" id="yingfuzonge" name="yingfuzonge" value='<fmt:formatNumber type="number" value="${amount}" /> ' class="form-control" readOnly="true"/>
				</div>
				<div class="form-group form-inline col-md-12 col-lg-6">
					<label style="width: 30%;text-align: left;" for="dtp_input2" class="control-label">已收款</label>
						<input type="text" id="yishoukuan" name="yishoukuan" value='<fmt:formatNumber type="number" value="${haspaid}" />' class="form-control" readOnly="true"/>
				</div>
					<div class="form-group form-inline col-md-12 col-lg-12">
						<%-- ${collectionremark } --%>
						<fieldset>
						<legend><div style="font-size: medium;">回款情况</div></legend>
						
						<div class="col-md-6 ">
							<table id="fukuantable" class="table-condensed" style="table-layout:fixed;">
								<thead align="justify">
									<th>付款期次</th>
									<th>约定付款金额</th>
									<th>约定付款时间</th>
									<th>付款方式</th>
								</thead>
								<tbody>
									<s:iterator id="fukuan" value="fukuanList" status="st">
										<tr>
											<td><s:property value="#fukuan.mingcheng" /></td>
											<td><fmt:formatNumber type="number" value="${fukuan.jine}" /></td>
											<td><s:date name='#fukuan.fukuanshijian' format='yyyy-MM-dd' /></td>
											<td><s:property value="#fukuan.fukuanfangshi" /></td>
											
										</tr>
									</s:iterator>
								</tbody>
							</table>
						</div>
						<div class="col-md-6 ">
							<table id="fukuantable" class="table-condensed" style="table-layout:fixed;">
								<thead align="justify">
									<th>到款期次</th>
									<th>到款金额</th>
									<th>到款时间</th>
									<th>到款方式</th>
								</thead>
								<tbody>
									<s:iterator id="shoukuan" value="shoukuanList" status="st">
										<tr>
											<td>第<s:property value='#st.count' />次</td>
											<td><s:property value="#shoukuan.skShoukuanjine" /></td>
											<td><s:date name='#shoukuan.skShoukuanshijian' format='yyyy-MM-dd' /></td>
											<td><s:property value="#shoukuan.skShoukuanfangshi" /></td>
										</tr>
									</s:iterator>
								</tbody>
							</table>
						</div>
						</fieldset>
					</div>
					
					<div class="form-group form-inline col-md-12 col-lg-6">
					<label style="width: 30%;text-align: left;" for="dtp_input2" class="control-label">收款日期<span style="color: red">*</span></label>
						<input type="datetime-local" id="collectionDate" name="skShoukuanshijian" class="form-control"/>
						<input type="hidden" id="collectionDateHidden" name="shoukuanshijian" value="" class="form-control"/>
				</div>
				<div class="form-group form-inline col-md-12 col-lg-6">
					<label style="width: 30%;text-align: left;" for="dtp_input2" class="control-label">收款金额(元)<span style="color: red">*</span></label>
						<input type="text" id="collectionAmount" name="skShoukuanjine" value="" class="form-control"/>
				</div>
				<div class="form-group form-inline col-md-12 col-lg-6">
					<label style="width: 30%;text-align: left;" for="dtp_input2" class="control-label">收款方式<span style="color: red">*</span></label>
						<select id="collectionMethod" name="skShoukuanfangshi" class="form-control">
							<option value="">--请选择收款方式--</option>
							<option value="现金">现金</option>
							<option value="支票">支票</option>
							<option value="汇票">汇票</option>
							<option value="其他">其他</option>
						</select>
				</div>
				<div class="form-group form-inline col-md-12 col-lg-6" hidden="hidden">
					<label style="width: 30%;text-align: left;" for="dtp_input2" class="control-label">交易快照</label>
						<input type="text" id="bankTransaction" name="skYinhangliushui" value="" class="form-control"/>
				</div>
				<div class="form-group col-md-12 col-lg-10">
					<label style="width: 30%;text-align: left;" for="dtp_input2" class="control-label">收款备注</label>
						<textarea id="collectionRemark" name="skShoukuanbeizhu" class="form-control" rows="3"></textarea>
				</div>
				<div align="center" class="col-md-12">
					<button type="button" id="save" class="btn">保存</button>
					<button type="button" id="restore" class="btn">恢复</button>
					<button type="button" class="btn btn-primary" id="submitbttn">提交</button>
					<button type="reset"  id="reset" class="btn btn-default">清空</button>
				</div>
			</div>
		</form>
	</div>
	</div>
<script src="js/jqGrid4.4.3/jquery-1.7.2.min.js"></script>
<script src="js/jquery-ui.js"></script>
<script src="js/bootstrap.min.js"></script>
<script type="text/javascript">
	//set the contractno validation with false
	var isValid = false;
	/**
	 * 进行前端验证
	 */
	function frontEndValidate() {

		var dm = document.getElementById("collectionDate");
		var em1 = dm.value;
		if (em1 == null || em1 == '') {
			dm.focus();
			alert("请输入完整的收款时间！");
			return false;
		}
		
		dm = document.getElementById("collectionAmount");
		var em2 = dm.value;
		if (em2 == null || em2 == '') {
			dm.focus();
			alert("请输入收款金额！");
			return false;
		}
		
		dm = document.getElementById("collectionMethod");
		var em2 = dm.value;
		if (em2 == null || em2 == '') {
			dm.focus();
			alert("请选择收款方式！");
			return false;
		}
		
		//此项改为非必填项2016-03-16 23:59
/* 		dm = document.getElementById("bankTransaction");
		var em2 = dm.value;
		if (em2 == null || em2 == '') {
			dm.focus();
			alert("请输入银行流水！");
			return false;
		} */
		
		return true;
	}

	/* function doSubmit() {

		if (frontEndValidate()) {
			$("#collectionForm").submit();
		}
	} */
	
	$(document).ready(function(){
		if($("#renkanshuId").val() == "null" || $("#renkanshuId").val() == ""){
			$("#renkanshubianhaolable").hide();
			$("#renkanshuId").val(null);
		}else{
			$("#hetongbianhaolable").hide();
			$("#contractId").val(null);
		}
		
		$("#submitbttn").click(function(){
			if(confirm("你输入的收款金额为：\n\n"+ChinaCost($("#collectionAmount").val())+"\n")){
				formatDatetime();
				if(frontEndValidate()){
					$.ajax({
						url:"saveCollection.action",
						type:"post",
						data:$("#collectionForm").serializeArray(),
						dataType:"json",
						success:function(data){
							if(data.info){
								alert("保存成功");
								location.href="collectionInput";
							}else{
								alert("保存失败");
							}
						},
						error:function(data){
							alert("保存失败");
						}
					})
				}
			}

		})
	});
	
	function formatDatetime(){
	    var x=document.getElementById("collectionDate").value;
	    var format = x.replace("T", " ");
	    format += ":00";
	    document.getElementById("collectionDateHidden").value = format;
	}
	
	function ChinaCost(numberValue){
		var numberValue=new String(Math.round(numberValue*100)); // 数字金额
		var chineseValue=""; // 转换后的汉字金额
		var String1 = "零壹贰叁肆伍陆柒捌玖"; // 汉字数字
		var String2 = "万仟佰拾亿仟佰拾万仟佰拾元角分"; // 对应单位
		var len=numberValue.length; // numberValue 的字符串长度
		var Ch1; // 数字的汉语读法
		var Ch2; // 数字位的汉字读法
		var nZero=0; // 用来计算连续的零值的个数
		var String3; // 指定位置的数值
		if(len>15){
		alert("超出计算范围");
		return "";
		}
		if (numberValue==0){
		chineseValue = "零元整";
		return chineseValue;
		}

		String2 = String2.substr(String2.length-len, len); // 取出对应位数的STRING2的值
		for(var i=0; i<len; i++){
		String3 = parseInt(numberValue.substr(i, 1),10); // 取出需转换的某一位的值
		if ( i != (len - 3) && i != (len - 7) && i != (len - 11) && i !=(len - 15) ){
		if ( String3 == 0 ){
		Ch1 = "";
		Ch2 = "";
		nZero = nZero + 1;
		}
		else if ( String3 != 0 && nZero != 0 ){
		Ch1 = "零" + String1.substr(String3, 1);
		Ch2 = String2.substr(i, 1);
		nZero = 0;
		}
		else{
		Ch1 = String1.substr(String3, 1);
		Ch2 = String2.substr(i, 1);
		nZero = 0;
		}
		}
		else{ // 该位是万亿，亿，万，元位等关键位
		if( String3 != 0 && nZero != 0 ){
		Ch1 = "零" + String1.substr(String3, 1);
		Ch2 = String2.substr(i, 1);
		nZero = 0;
		}
		else if ( String3 != 0 && nZero == 0 ){
		Ch1 = String1.substr(String3, 1);
		Ch2 = String2.substr(i, 1);
		nZero = 0;
		}
		else if( String3 == 0 && nZero >= 3 ){
		Ch1 = "";
		Ch2 = "";
		nZero = nZero + 1;
		}
		else{
		Ch1 = "";
		Ch2 = String2.substr(i, 1);
		nZero = nZero + 1;
		}
		if( i == (len - 11) || i == (len - 3)){ // 如果该位是亿位或元位，则必须写上
		Ch2 = String2.substr(i, 1);
		}
		}
		chineseValue = chineseValue + Ch1 + Ch2;
		}

		if ( String3 == 0 ){ // 最后一位（分）为0时，加上“整”
		chineseValue = chineseValue + "整";
		}

		return chineseValue;
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
</body>
</html>