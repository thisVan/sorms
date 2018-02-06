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
<link href="css/jquery-ui.structure.min.css" rel="stylesheet" media="screen">
<link href="css/jquery-ui.theme.min.css" rel="stylesheet" media="screen">

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
					认刊书审核
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
		<input type="text" class="hidden" name="auditIds" value='<s:property value="renkanshuaudit.id"/>'>
		<div class="form-group">
			<label for="account" class="col-sm-2 control-label">认刊编号</label>
			<div class="col-sm-4"><input type="text" class="form-control input-sm" name="renkanshuaudit.renkanbianhao"  value='<s:property value="renkanshuaudit.renkanbianhao"/>'maxlength="20" disabled></div>
		</div>
		
		<div class="form-group">
			<label for="account" class="col-sm-2 control-label">合同编号</label>
			<div class="col-sm-4"><input type="text" class="form-control input-sm" name="renkanshuaudit.hetongbianhao"  value='<s:property value="renkanshuaudit.hetongbianhao"/>'maxlength="20" disabled></div>
		</div>

		<div class="form-group">
			<label for="account" class="col-sm-2 control-label">签订日期</label>
			<div class="col-sm-4"><input type="date" class="form-control input-sm" name="renkanshuaudit.qiandingriqi"  value='<s:property value="qiandingriqi" />' maxlength="20" disabled></div>
		</div>
		
		
		<div class="form-group">
			<label for="account" class="col-sm-2 control-label">业务员</label>
			<div class="col-sm-4"><input type="text" class="form-control input-sm" name="renkanshuaudit.yewuyuanByYwyId.ywyId"  value='<s:property value="renkanshuaudit.yewuyuanByYwyId.ywyXingming"/>'maxlength="20" disabled></div>
		</div>
		
		<div class="form-group">
			<label for="account" class="col-sm-2 control-label">广告客户</label>
			<div class="col-sm-4"><input type="text" class="form-control input-sm" name="renkanshuaudit.guangaokanhu"  value='<s:property value="renkanshuaudit.guangaokanhu"/>'maxlength="20" disabled></div>
		</div>
		<div class="form-group">
			<label for="account" class="col-sm-2 control-label">广告代理公司</label>
			<div class="col-sm-4"><input type="text" class="form-control input-sm" name="renkanshuaudit.guanggaodailigongsi"  value='<s:property value="renkanshuaudit.guanggaodailigongsi"/>'maxlength="20" disabled></div>
		</div>
		
		<div class="form-group">
			<label for="account" class="col-sm-2 control-label">行业</label>
			<div class="col-sm-4"><input type="text" class="form-control input-sm" name="renkanshuaudit.industry.industryId"  value='<s:property value="renkanshuaudit.industry.industryDesc"/>'maxlength="20" disabled></div>
		</div>
		
		<div class="form-group">
			<label for="account" class="col-sm-2 control-label">广告内容</label>
			<div class="col-sm-4"><textarea class="form-control input-sm " rows="3" name="renkanshuaudit.guanggaoneirong"  maxlength="150" disabled><s:property value="renkanshuaudit.guanggaoneirong"/></textarea></div>
		</div>
		
		<div class="form-group">
			<label for="account" class="col-sm-2 control-label">稿件来源</label>
			<div class="col-sm-4">
				<select type="text" class="form-control input-sm" name="renkanshuaudit.gaojianlaiyuan" id="gaojianlaiyuan_id" value='<s:property value="renkanshuaudit.gaojianlaiyuan"/>' disabled >
					<option value='刊户设计'>刊户设计</option>
					<option value='广告公司设计'>广告公司设计</option>
					<option value='新视界设计'>新视界设计</option>
				</select></div>
		</div>
		<div class="form-group">
			<label for="account" class="col-sm-2 control-label">稿件类别</label>
			<div class="col-sm-4">
				<select type="text" class="form-control input-sm" name="renkanshuaudit.gaojianleibie" id="gaojianleibie_id" value='<s:property value="renkanshuaudit.gaojianleibie"/>'  disabled>
					<option value='AVI'>AVI</option>
					<option value='MPG'>MPG</option>
					<option value='DVD'>DVD</option>
					<option value='其他'>其他</option>
				</select></div>
		</div>
		
		<div class="form-group">
			<label for="account" class="col-sm-2 control-label">刊例总价</label>
			<div class="col-sm-4"><input type="text" class="form-control input-sm" name="renkanshuaudit.kanlizongjia"  value='<s:property value="renkanshuaudit.kanlizongjia"/>'maxlength="20" disabled></div>
		</div>
		<div class="form-group">
			<label for="renkanshu.purchasecost" class="col-sm-2 control-label">外购成本</label>
			<div class="col-sm-4"><input type="text" class="form-control input-sm" name="renkanshuaudit.purchasecost"  value='<s:property value="renkanshuaudit.purchasecost"/>'maxlength="20" disabled></div>
		</div>
		<div class="form-group">
			<label for="account" class="col-sm-2 control-label">折扣</label>
			<div class="col-sm-4"><input type="text" class="form-control input-sm" name="renkanshuaudit.zhekou"  value='<s:property value="renkanshuaudit.zhekou"/>'maxlength="20" disabled></div>
		</div>
		<div class="form-group">
			<label for="account" class="col-sm-2 control-label">定金</label>
			<div class="col-sm-4"><input type="text" class="form-control input-sm" name="renkanshuaudit.dingjin"  value='<s:property value="renkanshuaudit.dingjin"/>'maxlength="20" disabled></div>
		</div>
		
		<%-- <div class="form-group" >
			<a class="btn btn-link" id="showFenqi" onclick="showFukuan()">
			<span class="glyphicon glyphicon-plus" ></span> 显示付款信息</a>
		</div> --%>
		
		<div  class="form-group col-md-12 col-lg-12 " id="showFukuanTable">
    		<table id="jqgrid_fukuanaudit" style="font-family: '微软雅黑';"></table>
    		<div id="jqgrid-pager_fukuanaudit"></div>
  		</div>
		
		
		<div class="form-group">
			<label for="account" class="col-sm-2 control-label">认刊书备注</label>
			<div class="col-sm-4"><textarea class="form-control input-sm " rows="3" name="renkanshuaudit.renkanshubeizhu"  maxlength="150" disabled><s:property value="renkanshuaudit.renkanshubeizhu"/></textarea></div>
		</div>
		
<!-- 		<div class="form-group">
			<label for="account" class="col-sm-2 control-label">修改理由</label>
			<div class="col-sm-4"><textarea class="form-control input-sm " rows="3" name="updateReason" maxlength="150" disabled><s:property value="renkanshuaudit.operReason"/></textarea></div>
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

	var nameValid = true;
	var renkanshuauditid='<s:property value="renkanshuaudit.id"/>';
/* 	var renkanbianhao='${renkanshuaudit.renkanbianhao}'; */

	function showFukuan() {;
		openfukuanflag=true;
	   if($("#showFukuanTable").is(":hidden")){
	       $("#showFukuanTable").removeClass("hidden");
	   }else{
	   	  $("#showFukuanTable").addClass("hidden");
	   }
	}
	
	
	$(document).ready(function(){
		$("#submit").click(function(){
			$.ajax({
				url:"RenkanshuAlterAudit.action",
				type:"post",
				data:$("#form_save").serializeArray(),
				dataType:"json",
				success:function(data){
					alert(data.info);
					if(data.state===0){ //操作成功
						location.replace('renkanshuListAuditPage');
					}
				},
				error:function(XMLHttpRequest, textStatus, errorThrown){
					alert('提交失败\nXMLHttpRequest.readyState['+XMLHttpRequest.readyState+']\nXMLHttpRequest.status['+XMLHttpRequest.status+']\ntextStatus['+textStatus+']');
				}
			})
		})
		
		 var tf = $("#jqgrid_fukuanaudit");
		 function e_fukuanaudit() {
                $("#jqgrid_fukuanaudit").length > 0 && tf.fluidGrid({
                    base: "#jqgrid-wrapper_fukuanaudit",
                    offset: 0
                });
         }
         //付款表
         $("#jqgrid_fukuanaudit").length > 0 && (tf.jqGrid({
	        	caption:'付款信息',
	        	url:"fukuanAuditAlterPageRenkanshu.action?renkanshuauditid="+renkanshuauditid,
	        	mtype:"GET",
	        	styleUI: 'Bootstrap',//设置jqgrid的全局样式为bootstrap样式
	        	shrinkToFit:true,
	        	datatype:"json",
	        	colNames:['付款期次','约定付款金额','约定付款时间','付款方式','备注'],
	        	rowNum:<s:property value="@com.nfledmedia.sorm.cons.CommonConstant@DEFAULT_PAGE_SIZE"/>,
	        	rowList: [10, 20, 30],
	    		pager: "jqgrid-pager_fukuanaudit",
	    		multiselect:!1,
	    		autowidth:true,
	    		sortname:"mingcheng",
	    		sortorder: "asc",
	    		viewrecords: !0,
	    		colModel:[{
	    			name:"mingcheng",
	    			index:"mingcheng",
	    			align:"center",
	    	 		width:"100px"
	    		},{
	    			name:"jine",
	    			index:"jine",
	    			align:"center",
	    			width:"100px" 
	    				
	    		},{
	    			name:"fukuanshijian",
	    			sortable: !1,
	    			search: !1,
	    			align:"center",
	    			width:"100px"
	    		},{
	    			name:"fukuanfangshi",
	    			index:"fukuanfangshi",
	    			align:"center",
	    			width:"70px"
	    		},{
	    			name:"fukuanbeizhu",
	    			index: "fukuanbeizhu",
	    			align:"center",
	    			width:"150px"
	    		}],
	        }), e_fukuanaudit(), $("#jqgrid_fukuanaudit").length > 0 && tf.jqGrid("navGrid","#jqgrid-pager_fukuanaudit",{
	        	add:!1,
	        	edit:!1,
	        	del:!1,
	        	view:!1,
	        	search: !1,
	    		refresh:0
	        },{
	        	multipleSearch: true,
	        	multipleGroup:true
	        })),
        $(window).resize(e_fukuanaudit);
             
	});

	function goBack(){
		if(confirm("您确定要放弃相关操作，返回审核列表吗？")){
			location.replace('renkanshuListAuditPage');
		}
	}
</script>
</content>
