<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="com.google.gson.*"%>
<%@ page import="java.sql.*"%>
<%@ taglib uri="/struts-tags" prefix="s"%>

<!DOCTYPE HTML>
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
<link href="css/jquery-confirm.min.css" rel="stylesheet">

<link rel="stylesheet" href="css/bootstrap-theme.css">
<link href="css/jquery-ui.min.css" rel="stylesheet" media="screen">
<link href="css/styles.css" rel="stylesheet">
<link href="css/laydate.css" rel="stylesheet">

<!--Icons-->
<script src="js/lumino.glyphs.js"></script>
<script src="js/jquery-1.11.1.min.js"></script>
<script src="js/bootstrap.min.js"></script>
<script src="js/jquery-ui.min.js"></script>
<script src="js/bootstrap-table.js"></script>
<script src="js/jquery-confirm.min.js"></script>


</head>
<body style="font-family: '微软雅黑';">
	<div class="main">

		<!--/.row-->

		<div class="row">
			<div class="col-lg-12">
				<h3 class="page-header">
					修改认刊书
				</h3>
			</div>
		</div>
		<!--/.row-->
		<div class="row">

			<div class="col-lg-12">

				<div class="col-lg-12 col-md-6">
					<form id="form_save" class="form-horizontal" role="form">
						<input type="number" class="hidden" name="tid"
							value='<s:property value="renkanshuaudit.id"/>'>
						<div class="form-group">
							<label for="account" class="col-sm-2 control-label">认刊编号</label>
							<div class="col-sm-4">
								<input type="text" class="form-control input-sm"
									name="renkanshuaudit.renkanbianhao"
									value='<s:property value="renkanshuaudit.renkanbianhao"/>'
									maxlength="20" disabled>
							</div>
						</div>
						<div class="form-group">
							<label for="account" class="col-sm-2 control-label">合同编号</label>
							<div class="col-sm-4">
								<input type="text" class="form-control input-sm"
									name="renkanshuaudit.hetongbianhao"
									value='<s:property value="renkanshuaudit.hetongbianhao"/>'
									maxlength="20">
							</div>
						</div>

						<div class="form-group">
							<label for="account" class="col-sm-2 control-label">签订日期</label>
							<div class="col-sm-4">
								<input type="date" class="form-control input-sm"
									name="renkanshuaudit.qiandingriqi"
									value='<s:property value="qiandingriqi" />' maxlength="20">
							</div>
						</div>


						<div class="form-group">
							<label for="account" class="col-sm-2 control-label">业务员</label>
							<div class="col-sm-2">
								<select class="form-control input-sm" name="bumen" id="bumen_id"
									onchange="changeyewuyuan(this.value)">
									<s:iterator value="bumens">
										<option value='<s:property value="bmId"/>'><s:property
												value="bmMingcheng" /></option>
									</s:iterator>
								</select>
							</div>
							<div class="col-sm-2">
								<select class="form-control input-sm"
									name="renkanshuaudit.ywyId" id="yewuyuan_id">
									<s:iterator value="yewuyuans" var="thisyewuyuan">
										<option value='<s:property value="ywyId"/>'><s:property
												value="ywyXingming" /></option>
									</s:iterator>
								</select>
							</div>
						</div>

						<div class="form-group">
							<label for="account" class="col-sm-2 control-label">广告客户</label>
							<div class="col-sm-4">
								<input type="text" class="form-control input-sm"
									name="renkanshuaudit.guangaokanhu"
									value='<s:property value="renkanshuaudit.guangaokanhu"/>'
									maxlength="20">
							</div>
						</div>
						<div class="form-group">
							<label for="account" class="col-sm-2 control-label">广告代理公司</label>
							<div class="col-sm-4">
								<input type="text" class="form-control input-sm"
									name="renkanshuaudit.guanggaodailigongsi"
									value='<s:property value="renkanshuaudit.guanggaodailigongsi"/>'
									maxlength="20">
							</div>
						</div>

						<div class="form-group">
							<label for="account" class="col-sm-2 control-label">行业</label>
							<div class="col-sm-2">
								<select class="form-control input-sm" name="industryclassifyId"
									id="industryclassifyid" onchange="changeIndustry(this)">
									<s:iterator value="#request.industryclassifys">
										<option value='<s:property value="[0].top[0]"/>'><s:property
												value="[0].top[1]" /></option>
									</s:iterator>
								</select>
							</div>
							<div class="col-sm-2">
								<select class="form-control input-sm"
									name="renkanshuaudit.industry.industryId" id="industry_id">
									<s:iterator value="#request.industry">
										<option value='<s:property value="[0].top[0]"/>'><s:property
												value="[0].top[1]" /></option>
									</s:iterator>
								</select>
							</div>
						</div>

						<div class="form-group">
							<label for="account" class="col-sm-2 control-label">广告内容</label>
							<div class="col-sm-4">
								<textarea class="form-control input-sm " rows="3"
									name="renkanshuaudit.guanggaoneirong" maxlength="150"><s:property
										value="renkanshuaudit.guanggaoneirong" /></textarea>
							</div>
						</div>

						<div class="form-group">
							<label for="account" class="col-sm-2 control-label">稿件来源</label>
							<div class="col-sm-4">
								<select type="text" class="form-control input-sm"
									name="renkanshuaudit.gaojianlaiyuan" id="gaojianlaiyuan_id"
									value='<s:property value="renkanshuaudit.gaojianlaiyuan"/>'>
									<option value='刊户设计'>刊户设计</option>
									<option value='广告公司设计'>广告公司设计</option>
									<option value='新视界设计'>新视界设计</option>
								</select>
							</div>
						</div>
						<div class="form-group">
							<label for="account" class="col-sm-2 control-label">稿件类别</label>
							<div class="col-sm-4">
								<select type="text" class="form-control input-sm"
									name="renkanshuaudit.gaojianleibie" id="gaojianleibie_id"
									value='<s:property value="renkanshuaudit.gaojianleibie"/>'>
									<option value='AVI'>AVI</option>
									<option value='MPG'>MPG</option>
									<option value='DVD'>DVD</option>
									<option value='其他'>其他</option>
								</select>
							</div>
						</div>

						<div class="form-group">
							<label for="account" class="col-sm-2 control-label">刊例总价</label>
							<div class="col-sm-4">
								<input type="text" class="form-control input-sm"
									id="kanlizongjia" name="renkanshuaudit.advertisingintenttotal"
									value='<s:property value="renkanshuaudit.advertisingintenttotal"/>'
									maxlength="20">
							</div>
						</div>
						
						<div class="form-group">
							<label for="renkanshuaudit.purchasecost"
								class="col-sm-2 control-label">外购成本</label>
							<div class="col-sm-4">
								<input type="text" class="form-control input-sm"
									name="renkanshuaudit.purchasecost"
									value='<s:property value="renkanshuaudit.purchasecost"/>'
									maxlength="20">
							</div>
						</div>
						<div class="form-group">
							<label for="account" class="col-sm-2 control-label">折扣</label>
							<div class="col-sm-4">
								<input type="text" class="form-control input-sm"
									name="renkanshuaudit.zhekou"
									value='<s:property value="renkanshuaudit.zhekou"/>'
									maxlength="20">
							</div>
						</div>
						<div class="form-group">
							<label for="account" class="col-sm-2 control-label">实付金额</label>
							<div class="col-sm-4">
								<input type="text" class="form-control input-sm"
									name="renkanshuaudit.dingjin"
									value='<s:property value="renkanshuaudit.advertisingintentcomein"/>'
									maxlength="20">
							</div>
						</div>

						<%-- 	<div class="form-group">
		<label for="account" class="col-sm-2 control-label">分期期数</label>
			<div class="col-sm-4"><input type="number" class="form-control input-sm" name="renkanshuaudit.fenqi"  value='<s:property value="renkanshuaudit.fenqi"/>' oninput="switchFenqiItem(this.value)" maxlength="20" ></div>
			<label style="width: 24%;text-align: left;" for="renkanshufenqi">分期期数<span class="text-danger">*</span></label>
				<input id="renkanshufenqi" type="number"
				name="renkanshuaudit.fenqi" placeholder="请输入分期数" class="form-control"
				oninput="switchFenqiItem(this.value)"></input>
		</div> --%>

						<div class="form-group">
							<a class="btn btn-link" id="showFenqi" onclick="showFukuan()">
								<span class="glyphicon glyphicon-plus"></span> 显示付款信息
							</a>
						</div>

						<div class="col-lg-12 col-md-12 hidden" id="showFukuanTable">
							<fieldset>
								<div class="form-group">
									<table id="fukuantable" class="table-condensed "
										style="table-layout:fixed;">
										<thead align="justify">
											<th>付款期次</th>
											<th>约定付款金额</th>
											<th>约定付款时间</th>
											<th>付款方式</th>
											<th>备注</th>
											<th>操作</th>
										<tbody>
										</tbody>
									</table>
								</div>
								<div class="form-group">
									<a class="btn btn-link" id="addFenqi"><span
										class="glyphicon glyphicon-plus"></span> 添加期数</a>
								</div>
							</fieldset>
						</div>

						<div class="form-group">
							<label for="account" class="col-sm-2 control-label"></label>
						</div>

						<div class="form-group">
							<table id="jqgrid"
								class="table table-striped table-hover table-bordered"></table>
							<div id="jqgrid-pager"></div>
						</div>


						<div class="form-group">
							<label for="account" class="col-sm-2 control-label">认刊书备注</label>
							<div class="col-sm-4">
								<textarea class="form-control input-sm " rows="3"
									name="renkanshuaudit.renkanshubeizhu" maxlength="150"><s:property
										value="renkanshuaudit.renkanshubeizhu" /></textarea>
							</div>
						</div>



						<div class="form-group">
							<label for="account" class="col-sm-2 control-label">修改理由</label>
							<div class="col-sm-4">
								<textarea class="form-control input-sm " rows="3"
									name="updateReason" maxlength="150"></textarea>
							</div>
						</div>

						<div class="form-group">
							<label for="account" class="col-sm-2 control-label">备注</label> <label
								for="account" class="col-sm-8 control-label">${request.remark}</label>
						</div>

					</form>
					<p class="text-center">
						<button type="button" class="btn btn-custom-primary btn-sm"
							id="back" onclick="goBack()"
							style="float:left;background:#AAAAAB;border:2px solid #e5e5e5;margin-left:40%;width:63px">
							</i>返回
						</button>
						<button type="button" class="btn btn-danger btn-sm" id="save"
							style="margin-left:-40%">
							<i class="fa fa-floppy-o"></i> 保存
						</button>
					</p>
				</div>
			</div>
		</div>
	</div>

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
	var renkanshuauditidforfukuanaudit='${renkanshuaudit.id}';	
	var originalHetongbianhao='${renkanshuaudit.hetongbianhao}';
	var originalQiandingriqi='${qiandingriqi}';
	var orginalYewuyuan = '<s:property value="#request.yewuyuanID"/>';
	var orginalBumen = '<s:property value="#request.bumenID"/>';
	var originalGuangaokanhu='${renkanshuaudit.guangaokanhu}';
	var originalguanggaodailigongsi='${renkanshuaudit.guanggaodailigongsi}';
	var originalIndustry = '<s:property value="renkanshuaudit.industry.industryId"/>';
	var originalIndustyClassify = '<s:property value="renkanshuaudit.industry.industryclassify.id"/>';
	var orginalGuanggaoneirong = '${renkanshuaudit.guanggaoneirong}';
	
	var originalGaojianlaiyuan='${renkanshuaudit.gaojianlaiyuan}';
	var originalGaojianleibie='${renkanshuaudit.gaojianleibie}';
	var originalKanlizongjia='${renkanshuaudit.kanlizongjia}';
	var originalPurchasecost='${renkanshuaudit.purchasecost}';
	var originalZhekou='${renkanshuaudit.zhekou}';
	var originalDingjin='${renkanshuaudit.dingjin}';
	var originalRenkanshubeizhu='${renkanshuaudit.renkanshubeizhu}';
	var fenqi='${renkanshuaudit.fenqi}';
	var arrayid=new Array();
	var arrayfukuanfangshi=new Array();
	var arrayjine=new Array();
	var arrayfukuanbeizhu=new Array();
	var arrayfukuanshijian=new Array();
	var openfukuanflag=false;
	
	function changeyewuyuan(obj) {
		var selectbumenid = obj;
		if(selectbumenid == "") {
			$("#yewuyuan_id").empty();
		} else {
			$.ajax({
				type : "post",
				dataType : "json",
				url : "fillYewuyuanList.action",
				data : {
					selectbumenid : selectbumenid
				},//提交参数
				success : function(data) {
					var jsonData = data.yewuyuanback;
					$("#yewuyuan_id").empty();
					for (var i = 0, n = jsonData.length; i < n; i++) {
						$("#yewuyuan_id").append("<option  value='"+jsonData[i].ywyId+"'>" + jsonData[i].ywyXingming + "</option>");
					}
				}
			});
		}
	}
	
	function formatDuration(cellvalue, options, rowObject){
		return cellvalue + "秒";
	}
	
	function formatFreq(cellvalue, options, rowObject){
		return cellvalue + "次/天";
	}
	
	function changeIndustry(obj) {
		var selectclassifyind = obj.value;
		$.ajax({
	  		type:"post",
	  		dataType:"json",
	  		url:"fillIndustryClassify.action",
	  		data: {selectclassifyind: selectclassifyind},//提交参数
	  		success:function(data){
	  			var jsonData = data.industryclassifyback;
	  			$("#industry_id").empty();
	  			for(var i = 0; i < jsonData.length; i++){
	  				$("#industry_id").append("<option  value='"+jsonData[i].industryid+"'>"+jsonData[i].industryname+"</option>");		
	  			}
	  		}
	  });	
	};
	
	$.ajax({
	  		type:"post",
	  		dataType:"json",
	  		url:"getFukuanauditsByRenkanbianhao.action",
	  		data: { renkanshuauditidforfukuanaudit: renkanshuauditidforfukuanaudit },//提交参数
	  		success:function(data){ 	
	  			var jsonData = data.fukuansBack;
	  			document.getElementsByTagName("tbody").innerHTML="";
  				for(var j=0, n = jsonData.length;j<n;j++){
  			    	arrayid[j]=jsonData[j].id;
  			    	arrayfukuanfangshi[j]=jsonData[j].fukuanfangshi;
  			    	arrayjine[j]=jsonData[j].jine;
  			    	arrayfukuanbeizhu[j]=jsonData[j].fukuanbeizhu;
  			    	arrayfukuanshijian[j]=jsonData[j].fukuanshijianString;
  				}
	  		}
  		});	
	  			//保存按钮的点击事件
		$("#save").click(function(){
/* 		alert("arrayfukuanfangshi[1]:"+arrayfukuanfangshi[1]);
		alert("arrayfukuanshijian[1]:"+arrayfukuanshijian[1]); */
			var flag=true;
			var testlengtharr = new Array();
			$("select[name='fukuanfangshi']").each(function(){  
					testlengtharr.push($(this).val());
			});
			var tdnumber=testlengtharr.length;
			if(openfukuanflag){
				if(tdnumber!=fenqi){
	  				flag=false;
			  	}
	//		  	alert("flag1:"+flag);
			  	if(flag){
	  				for(var j=0, n = fenqi;j<n;j++){
	  			    	var i=j+1;
	  		/* 	    	alert("#fenqiid:"+$("#fenqiid"+i).val()+"  arrayid[j]:"+arrayid[j]);
	  			    	alert($("#fenqiid"+i).val()!=arrayid[j]);
	  			    	alert($("#fenqifukuanjine"+i).val()+"  "+arrayjine[j]);
	  			    	alert($("#fenqifukuanjine"+i).val()!=arrayjine[j]);
	  			    	alert($("#fenqishijian"+i).val()+"  "+arrayfukuanshijian[j]);
	  			    	alert($("#fenqishijian"+i).val()!=arrayfukuanshijian[j]);
	  			    	alert($("#selectfukuanfangshi"+i).val()+"  "+arrayfukuanfangshi[j]);
	  			    	alert($("#selectfukuanfangshi"+i).val()!=arrayfukuanfangshi[j]);
	  			    	alert($("#fukuanbeizhu"+i).val()+"  "+arrayfukuanbeizhu[j]);
	  			    	alert($("#fukuanbeizhu"+i).val()!=arrayfukuanbeizhu[j]); */
	  			    	if($("#fenqiid"+i).val()!=arrayid[j]||
	  			    	   $("#fenqifukuanjine"+i).val()!=arrayjine[j]||
	  			    	   $("#fenqishijian"+i).val()!=arrayfukuanshijian[j]||
	  			    	   $("#selectfukuanfangshi"+i).val()!=arrayfukuanfangshi[j]||
	  			    	   $("#fukuanbeizhu"+i).val()!=arrayfukuanbeizhu[j]){
	  			    		flag=false;
	  			    	}
	  				}
	  			}
			}
  //			alert("flag2:"+flag);
  			if(flag&&$("input[name='renkanshuaudit.hetongbianhao']").val()==originalHetongbianhao &&
				$("input[name='renkanshuaudit.qiandingriqi']").val()==originalQiandingriqi &&
				$("input[name='renkanshuaudit.qiandingriqi']").val()==originalQiandingriqi &&
				$("select[name='renkanshuaudit.ywyId']").val()==orginalYewuyuan &&
				$("input[name='renkanshuaudit.guangaokanhu']").val()==originalGuangaokanhu &&
				$("input[name='renkanshuaudit.guanggaodailigongsi']").val()==originalguanggaodailigongsi &&
				$("select[name='renkanshuaudit.industry.industryId']").val()==originalIndustry &&
				$("textarea[name='renkanshuaudit.guanggaoneirong']").val()==orginalGuanggaoneirong &&
				$("select[name='renkanshuaudit.gaojianlaiyuan']").val()==originalGaojianlaiyuan &&
				$("select[name='renkanshuaudit.gaojianleibie']").val()==originalGaojianleibie &&
				$("input[name='renkanshuaudit.kanlizongjia']").val()==originalKanlizongjia &&
				$("input[name='renkanshuaudit.purchasecost']").val()==originalPurchasecost &&
				$("input[name='renkanshuaudit.zhekou']").val()==originalZhekou &&
				$("input[name='renkanshuaudit.dingjin']").val()==originalDingjin &&
				$("textarea[name='renkanshuaudit.renkanshubeizhu']").val()==originalRenkanshubeizhu)
			{
				alert("您没有修改信息！");
				return;
			}else{
				/* var nullflag=true;
				for(var x=0;x<tdnumber;x++){
					alert("fenqishijian:"+$("#fenqishijian"+x).val());
					if($("#fenqishijian"+x).val()==null){
						nullflag=false;
					}				}
				if(nullflag){ */
					$.ajax({
						url:"updateRenkanshuaudit.action",
						type:"post",
						data:$("#form_save").serializeArray(),
						dataType:"json",
						success:function(data){
							alert(data.info);
							if(data.state===0){ //操作成功
								location.replace('myAuditOrderListPage');
							}
						},
						error:function(XMLHttpRequest, textStatus, errorThrown){
							alert('保存失败\nXMLHttpRequest.readyState['+XMLHttpRequest.readyState+']\nXMLHttpRequest.status['+XMLHttpRequest.status+']\ntextStatus['+textStatus+']');
						}
					})
			/* 	}else{
					alert("请将分期付款信息填写完整！");
				} */
			}
		});
		
		var flag=true;
	function showFukuan() {
		openfukuanflag=true;
	   if($("#showFukuanTable").is(":hidden")){
	       $("#showFukuanTable").removeClass("hidden");
//		   $("#showFukuanDiv").append('');
		   if(flag){
			   $.ajax({
		  		type:"post",
		  		dataType:"json",
		  		url:"getFukuanauditsByRenkanbianhao.action",
		  		data: { renkanshuauditidforfukuanaudit: renkanshuauditidforfukuanaudit },//提交参数
		  		success:function(data){ 	
		  			var jsonData = data.fukuansBack;
	//	  			alert(jsonData.length);
		  			document.getElementsByTagName("tbody").innerHTML="";
		  			var arrfukuanfangshi = [ "现金", "支票", "汇票","其他" ];
		  			for(var j=0, n = jsonData.length;j<n;j++){
		  			    var i=j+1;
		  				$("#fukuantable>tbody").append('<tr><td width="10%">第'
					+ i+ '期<input id="fenqiming'+i+'" name="fenqimingcheng" class="hidden" value="第'
					+i+'期"/><input id="fenqiid'+i+'" name="fenqiid" class="form-control hidden" type="number" value='+jsonData[j].id+' /></td><td width="20%"><input name="fenqijine" class="form-control" type="number" id="fenqifukuanjine'
					+i+'" value='+jsonData[j].jine+' /></td><td width="20%"><input class="form-control input-sm" name="fenqifukuanshijian" type="date" id="fenqishijian'+
					i+'" value='+jsonData[j].fukuanshijian+'/></td><td width="15%"><select id="selectfukuanfangshi'+
					i+'" class="form-control" name="fukuanfangshi" value="'+jsonData[j].fukuanfangshi+'"></select></td><td width="35%"><input class="form-control" name="fukuanbeizhu" type="text" id="fukuanbeizhu'+i
					+'" value="'+jsonData[j].fukuanbeizhu+'"/></td><td><a class="form-control" onclick="deltr(this)"><span class="glyphicon glyphicon-remove"></span></a></td></tr>');		
		  				var fukuanfangshiid = "selectfukuanfangshi"+ i;
						for (var x = 0; x < arrfukuanfangshi.length; x++) {
							document.getElementById(fukuanfangshiid).options.add(new Option(
											arrfukuanfangshi[x],arrfukuanfangshi[x]));
		  				}
		  				}
		  			}
		  		});	
		  		flag=false;
		   } 
	   }else{
	   	  $("#showFukuanTable").addClass("hidden");
	   }
	}
	  
	//添加行
	jQuery(function($) {
		$("#addFenqi").click(
			function() {
				var testlengtharr = new Array();
				$("select[name='fukuanfangshi']").each(function(){  
					testlengtharr.push($(this).val());
				});
				var i=testlengtharr.length+1;
	//			alert("i:"+i);
				var arrfukuanfangshi = [ "现金", "支票", "汇票","其他" ];
				$("#fukuantable>tbody").append('<tr><td width="10%">第'
					+ i+ '期<input id="fenqiming'+i+'" name="fenqimingcheng" class="hidden" value="第'
					+i+'期"/><input id="fenqiid'+i+'" name="fenqiid" class="hidden" type="text" value="'
					+0+'"/></td><td width="20%"><input name="fenqijine" class="form-control" type="number" id="fenqifukuanjine'
					+i+'" value="'+0+'" /></td><td width="20%"><input class="form-control" name="fenqifukuanshijian" type="date" id="fenqishijian'
					+i+'" /></td><td width="15%"><select id="selectfukuanfangshi'
					+i+'" class="form-control" name="fukuanfangshi" ></select></td><td width="35%"><input class="form-control" name="fukuanbeizhu" type="text" id="fukuanbeizhu'+i
					+'" /></td><td><a class="form-control" onclick="deltr(this)"><span class="glyphicon glyphicon-remove"></span></a></td></tr>');		
		  				var fukuanfangshiid = "selectfukuanfangshi"+ i;
						for (var x = 0; x < arrfukuanfangshi.length; x++) {
							document.getElementById(fukuanfangshiid).options.add(new Option(
											arrfukuanfangshi[x],arrfukuanfangshi[x]));
		  				}
			});
		});
	
	
	//删除行的函数，必须要放domready函数外面
	function deltr(delbtn) {
		$(delbtn).parents("tr").remove();
	};
	jQuery(function($) {
		//定义删除按钮事件绑定
		//写里边，防止污染全局命名空间
		function deltr() {
			$(this).parents("tr").remove();
		}
		;
		//已有删除按钮初始化绑定删除事件
		$("#table .del").click(deltr);
		//添加行
	});

	$(".td").click(function() {
		this.width("150px");
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
		if(confirm("您确定要放弃相关操作，返回到认刊书列表中吗？")){
			location.replace('myAuditOrderListPage');
		}
	}	
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
	return Number(s1.replace(".", "")) * Number(s2.replace(".", ""))
			/ Math.pow(10, m);
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
</content>
