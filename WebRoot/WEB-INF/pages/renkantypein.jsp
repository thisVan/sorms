<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html>
<html>
<head>
<link rel="icon" href="images/logo.png" type="image/x-icon" />
<link rel="shortcut icon" href="images/logo.png" type="image/x-icon" />
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="description" content="单据录入">
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="css/bootstrap.min.css" rel="stylesheet" media="screen">
<link href="css/datepicker3.css" rel="stylesheet">
<link href="css/bootstrap-datetimepicker.min.css" rel="stylesheet" media="screen">
<link href="css/bootstrap-table.css" rel="stylesheet">
<link href="css/styles.css" rel="stylesheet">
<link href="css/jquery-confirm.min.css" rel="stylesheet">
<style type="text/css">
/* 选中行样式 */
.tr_selected {
	background-color: #ffeb3b;
}
</style>
<!--Icons-->
<script src="js/lumino.glyphs.js"></script>
<script src="js/numeral.min.js"></script>
<script src="js/jquery-confirm.min.js"></script>
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
		} catch (e) {}
		try {
			m += s2.split(".")[1].length;
		} catch (e) {}
		return Number(s1.replace(".", "")) * Number(s2.replace(".", "")) / Math.pow(10, m);
	};
	// 除法
	Number.prototype.div = function(arg) {
		var t1 = 0, t2 = 0, r1, r2;
		try {
			t1 = this.toString().split(".")[1].length;
		} catch (e) {}
		try {
			t2 = arg.toString().split(".")[1].length;
		} catch (e) {}
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
		if (/(y+)/.test(fmt)) {
			fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
		}
			
		for (var k in o) {
			if (new RegExp("(" + k + ")").test(fmt)) {
				fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
			}
		}
			
		return fmt;
	};

	//全局顺序标识 
	var globalIdentification;
</script>
<script type="text/javascript">
	/**
	 * 进行前端验证
	 */
	function frontdatavalidate() {

/* 		var qiandingriqi = document.getElementById("dtp_input2").value;
		if (qiandingriqi == null || qiandingriqi == '') {
			document.getElementById("dtp_input2").focus();
			alert("请点击日期控件，输入认刊日期！");
			return false;
		} */
		
		var ledtableLength = $("select[name='shanghuadianweiledtable']").length;

		var guanggaokh = document.getElementById("guanggaokanhu").value;
		var dailigognsi = document.getElementById("guanggaodailigongsi").value;
		if ((guanggaokh == null || guanggaokh == '' ) && (dailigognsi == null || dailigognsi == '')) {
			alert("请输入广告刊户或广告代理公司！");
			document.getElementById("guanggaokanhu").focus();
			return false;
		}
	
		var agmd = document.getElementById("agencymode").value;
		if (agmd == null || agmd == '') {
			alert("请选择客户属性！");
			document.getElementById("agencymode").focus();
			return false;
		}
		
		var chlf = document.getElementById("channelfrom").value;
		if (chlf == null || chlf == '') {
			alert("请选择单据来源！");
			document.getElementById("channelfrom").focus();
			return false;
		}
		
		var amount = document.getElementById("amount").value;
		if (amount == null || amount == '') {
		} else {
			if (isNaN(amount)) {
				alert("请输入数字！");
				document.getElementById("amount").focus();
				return false;
			}
		}
		
		var fabuneirongitem = $("input[name='fabuneirongledtable']");
		if (!fabuneirongitem.length == ledtableLength) {
			$.alert("数组长度不一致，请清除浏览器缓存再试！")
			return false;
		}
		for (var i = 0; i < fabuneirongitem.length; i++) {
			if (fabuneirongitem[i].value == null || fabuneirongitem[i].value == '') {
				var j = i + 1;
				var strt = "fabuneirong" + j;
				alert("请输入发布内容！");
				document.getElementById(strt).focus();
				return false;
			}
		}		
		var kaishiriqishanghua = $("input[name='startdateledtable']");
		if (!kaishiriqishanghua.length == ledtableLength) {
			$.alert("数组长度不一致，请清除浏览器缓存再试！")
			return false;
		}
		for (var i = 0; i < kaishiriqishanghua.length; i++) {
			if (kaishiriqishanghua[i].value == null || kaishiriqishanghua[i].value == '') {
				var j = i + 1;
				var strt = "startdate" + j;
				alert("请输入开始上画日期！");
				document.getElementById(strt).focus();
				
				return false;
			}
		}

		var jieshuriqishanghua = $("input[name='enddateledtable']");
		if (!jieshuriqishanghua.length == ledtableLength) {
			$.alert("数组长度不一致，请清除浏览器缓存再试！")
			return false;
		}
		for (var i = 0; i < jieshuriqishanghua.length; i++) {
			if (jieshuriqishanghua[i].value == null || jieshuriqishanghua[i].value == '') {
				var j = i + 1;
				var strt = "enddate" + j;
				alert("请输入结束上画日期！");
				document.getElementById(strt).focus();
				return false;
			}
			if (jieshuriqishanghua[i].value < kaishiriqishanghua[i].value) {
				var j = i + 1;
				var strt = "enddate" + j;
				alert("结束日期不能在开始上画日期之前！");
				document.getElementById(strt).focus();
				return false;
			}
		}

		var pincivali = $("input[name='pinciledtable']");
		if (!pincivali.length == ledtableLength) {
			$.alert("数组长度不一致，请清除浏览器缓存再试！")
			return false;
		}
		for (var i = 0; i < pincivali.length; i++) {
			if (pincivali[i].value == null || pincivali[i].value == '') {
				var j = i + 1;
				var strt = "pinci" + j;
				document.getElementById(strt).focus();
				alert("请输入广告频次！");
				return false;
			}
			if(isNaN(pincivali[i].value)){
				var j = i + 1;
				var strt = "pinci" + j;
				
				alert("请输入数字！");
				document.getElementById(strt).focus();
				return false;
			}
		}
		var shichangvali = $("input[name='shichangledtable']");
		if(!shichangvali.length == ledtableLength){
			$.alert("数组长度不一致，请清除浏览器缓存再试！")
			return false;
		}
		for (var i = 0; i < shichangvali.length; i++) {
			if (shichangvali[i].value == null
					|| shichangvali[i].value == '') {
				var j = i + 1;
				var strt = "shichang" + j;
				alert("请输入广告时长！");
				document.getElementById(strt).focus();
				return false;
			}
			if(isNaN(shichangvali[i].value)){
				var j = i + 1;
				var strt = "shichang" + j;
				alert("请输入数字！");
				document.getElementById(strt).focus();
				return false;
			}
		}
		
		//不添加上画点位的不通过验证
		var shanghuadianweicounts = $("#table tbody tr").length;
		if(shanghuadianweicounts < 1){
			$.alert("请至少添加一条广告发布详情！");
			return false;
		}
			
		return true;
	}

	function doSubmit() {
		if (frontdatavalidate()) {
			$("#submit_button").attr('disabled', true);
			$.ajax({
				type : "post",
				url : "saveAdcontract",
				data : $("#renkanshuform").serialize(),
				cache : false,
				dataType : "json",
				success : function(data) {
					if (data.state == 0) {
						$.alert(data.info);
						location.href = "renkantypein";
					} else {
						$.alert(data.info);
					}
				},
				error : function(XMLHttpRequest, textStatus, errorThrown) {
					var errorMsg = '提交失败，请联系管理员处理！\n错误代码：XMLHttpRequest.readyState['+XMLHttpRequest.readyState+']\nXMLHttpRequest.status['+XMLHttpRequest.status+']\ntextStatus['+textStatus+']';
					$.alert(errorMsg);
					$("#submit_button").attr('disabled', false);
				}
			});
		}
	}
</script>
<!--[if lt IE 9]>
<script src="js/html5shiv.js"></script>
<script src="js/respond.min.js"></script>
<![endif]-->
</head>
<body style="font-family: '微软雅黑';">
	<div class="main">
		<!--/.row-->
		<div class="row">
			<div class="col-lg-12">
				<h3 class="page-header">单据录入</h3>
			</div>
		</div>
		<!--/.row-->
		<div class="row">
			<div class="col-lg-12">
				<div class="">
					<form role="form" id="renkanshuform" enctype="multipart/form-data" class="form-horizontal">
						<%-- <div class="form-group form-inline col-md-12 col-lg-6 ">
								<label style="width: 24%;text-align: left;" for="dtp_input2" class="control-label">认刊日期<span class="text-danger">*</span></label> 
								<input type="date" id="dtp_input2" name="adcontractdate" value="" class="form-control " onchange="fillRenkanbianhao()" />
							</div>

							<div class="form-group form-inline col-md-12 col-lg-6 ">
								<label style="width: 24%;text-align: left;" class="control-label" for="renkanshubianhao">单据编号<span class="text-danger">*</span></label> 
								<input id="renkanshubianhao" class="form-control" name="adcontract.sn">
							</div> --%>
						<div class="form-group form-inline col-md-12 col-lg-6 ">
							<label style="width: 24%; text-align: left;" class="control-label" for="guanggaokanhu">广告刊户</label> <input class="form-control input-sm" id="guanggaokanhu" name="adcontract.client" data-provide="typeahead">
						</div>
						<div class="form-group form-inline col-md-12 col-lg-6 ">
							<label style="width: 24%; text-align: left;" class="control-label" for="guanggaodailigongsi">代理公司</label> <input id="guanggaodailigongsi" name="adcontract.agency" class="form-control input-sm" data-provide="typeahead">
						</div>
						<div class="form-group form-inline col-md-12 col-lg-6 ">
							<label style="width: 24%; text-align: left;" class="control-label" for="agencymode">客户属性<span class="text-danger">*</span></label> <select name="clienttype_id" class="form-control input-sm" id="agencymode" style="width: 153px;">
								<option value="">-请选择客户属性--</option>
								<s:iterator value="#clienttypeList">
									<option value='<s:property value="id"/>'><s:property value="ctypedesc" /></option>
								</s:iterator>
							</select>
						</div>
						<div class="form-group form-inline col-md-12 col-lg-6 ">
							<label style="width: 24%; text-align: left;" class="control-label" for="channelfrom">单据类型<span class="text-danger">*</span></label> <select name="publishstyle.id" class="form-control input-sm" id="channelfrom" style="width: 153px;">
								<option value="">-请选择单据类型--</option>
								<s:iterator value="#publishstyleList">
									<option value='<s:property value="id"/>'><s:property value="name" /></option>
								</s:iterator>
							</select>
						</div>
						<div class="form-group form-inline col-md-12 col-lg-6 ">
							<label style="width: 24%; text-align: left;" class="control-label" for="channelfrom">单据来源<span class="text-danger">*</span></label> <select name="channel_id" class="form-control input-sm" id="channelfrom" style="width: 153px;">
								<!-- <option value="">-请选择单据来源--</option> -->
								<s:iterator value="#channelList">
									<option value='<s:property value="id"/>'><s:property value="channelname" /></option>
								</s:iterator>
							</select>
						</div>
						<div class="form-group form-inline col-md-12 col-lg-6 ">
							<label style="width: 24%; text-align: left;" class="control-label" for="amount">合同金额</label> <input id="amount" name="adcontract.amount" class="form-control input-sm">
						</div>
						<div class="form-group form-inline col-md-12 col-lg-6 ">
							<label style="width: 24%; text-align: left;" class="control-label" for="guanggaokanhu">下单人</label> <input class="form-control input-sm" id="placer" name="adcontract.placer">
						</div>
						<div class="form-group form-inline col-md-12 col-lg-6 ">
							<label style="width: 24%; text-align: left;" class="control-label" for="guanggaokanhu">备注</label> <input class="form-control input-sm" id="renkanshubeizhu" name="adcontract.remark">
						</div>
						<script type="text/javascript">
								//设置上画点位options
								var optionselectled = "<s:iterator value="#ledList"><option value='<s:property value="id"/>'><s:property value="name"/></option></s:iterator>";

								//设置频次
								var optionselectpinci = new Array();
								var arrledpinci = new Array("30", "60", "90", "120", "180", "240", "360");
								jQuery(function() {
									//设置频次
									optionselectpinci.length = 0;
									for (var i = 0; i < arrledpinci.length; i++) {
										optionselectpinci.push("<option value='" + arrledpinci[i] + "'>" + arrledpinci[i] + "</option>");
									}
								});

								//设置下单属性
								var optionselectguanggaoleixing = "<s:iterator value="#attributeList"><option value='<s:property value="id"/>'><s:property value="attributename"/></option></s:iterator>";

								//设置下单属性
								var optionselecthangyeleixing = "<s:iterator value="#industryList"><option value='<s:property value="industryid"/>'><s:property value="industryname"/></option></s:iterator>";
								//设置播放策略，轮播，或是包屏
								var optionselectplaystrategy = "<s:iterator value="#strategyList"><option value='<s:property value="id"/>'><s:property value="strategyname"/></option></s:iterator>";
								var optionselectshichang = new Array();
								var arrledshichang = new Array("15", "5", "10", "20", "30", "45", "60", "90");
								jQuery(function() {
									//设置时长
									optionselectshichang.length = 0;
									for (var i = 0; i < arrledshichang.length; i++) {
										optionselectshichang.push("<option value='" + arrledshichang[i] + "'>" + arrledshichang[i] + "</option>");
									}
								});

								var j = 1;
						
								jQuery(function($) {
									//添加行
									$("#addled").click(
											function() {
												var testlengtharr = new Array();
												$("select[name='shanghuadianweiledtable']").each(function() {
													testlengtharr.push($(this).val());
												});
												j = testlengtharr.length + 1;
											
												$("#table>tbody").append('<tr><td width="18%"><input name="fabuneirongledtable" class="form-control input-sm" id="fabuneirong' 
														+ j + '" data-provide="typeahead"></input></td><td width="11%"><select name="shanghuadianweiledtable"  class="form-control input-sm" id="shanghuadianwei' 
														+ j + '" onchange="setSSTime(this)">'+ optionselectled+ '</select></td><td width="6%"><select name="hangyeleixingledtable" class="form-control input-sm" id="hangyeleixing'
														+ j + '" onchange="addIndustryCustomed(this)">'+ optionselecthangyeleixing + '</select></td><td width="6%"><select name="guanggaoleixingledtable"  class="form-control input-sm" id="guanggaoleixing'
														+ j + '" >'+ optionselectguanggaoleixing + '</select></td><td width="5%"><input name="pinciledtable" class="form-control input-sm" id="pinci' 
														+ j + '" value="60"></input></td><td width="5%"><input name="shichangledtable" class="form-control input-sm" id="shichang' 
														+ j + '" value="15"></input></td><td width="13%"><input name="startdateledtable" class="form-control input-sm" type="date" max="9999-12-31" id="startdate'
														+ j + '" /></td><td width="13%"><input name="enddateledtable"  class="form-control input-sm" type="date" max="9999-12-31" id="enddate' 
														+ j + '"/></td><td width="7%"><input name="starttimeledtable" class="form-control input-sm" type="time" value="08:00:00" id="starttime'
														+ j + '" /></td><td width="7%"><input name="endtimeledtable"  class="form-control input-sm" type="time" value="22:00:00" id="endtime' 
														+ j + '" /></td><td width="6%"><select name="playstrategytable"  class="form-control input-sm" id="playstrategy'
														+ j + '" >'+ optionselectplaystrategy + '</select></td><td width="3%"><a class="form-control input-sm" onclick="deltr(this)"><span class="glyphicon glyphicon-remove"></span></a></td></tr>');

														if (j > 1) {
															var jindex = j - 1;
															$("#fabuneirong"+ j + "").val($("#fabuneirong" + jindex + "").val());
															$("#hangyeleixing"+ j + "").val($("#hangyeleixing" + jindex + "").val());
															$("#guanggaoleixing"+ j + "").val($("#guanggaoleixing" + jindex + "").val());
															$("#playstrategy"+ j + "").val($("#playstrategy" + jindex + "").val());
															$("#startdate" + j + "").val($("#startdate" + jindex + "").val());
															$("#enddate" + j + "").val($("#enddate" + jindex + "").val());
															$("#starttime" + j + "").val($("#starttime" + jindex + "").val());
															$("#endtime" + j + "").val($("#endtime" + jindex + "").val());
															$("#pinci" + j + "").val($("#pinci" + jindex + "").val());
															$("#shichang" + j + "").val($("#shichang" + jindex + "").val());
														}
														j++;
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

								function kanliclassiconchange(o) {
									for (var int = 0; int < arrayledidprice.length; int++) {
										if (arrayledidprice[int][0] == o.value) {
											kanlijiaclassic = arrayledidprice[int][1];
										}
									}

								}

								function kanlionchange(obj) {

									var id = $(obj).attr("id");
									var indexlastele = id.charAt(8);
									var confirmidshichang = "shichang" + indexlastele;
									var confirmidpinci = "pinci" + indexlastele;
									var selectshichang = document.getElementById(confirmidshichang).value;
									var selectpinci = document.getElementById(confirmidpinci).value;
									var kanlijiacal = Math.round(kanlijiaclassic * ((selectpinci - 60) / 30 * 0.3 + 1) * ((selectshichang - 15) / 15 * 0.35 + 1) + 0.5);
									document.getElementById(id).value = kanlijiacal;
									var kanlijiaxiaoji = document.getElementById("guanggaoshuliang" + indexlastele).value * kanlijiacal;
									document.getElementById("kanlijiaxiaoji" + indexlastele).value = kanlijiaxiaoji;
								}

								function calPublishPrice(obj) {
									var theid = $(obj).attr("id");
									//提取字符串中数字部分
									var index = theid.replace(/[^0-9]/ig, "");
									var starttimeid = "starttime" + index;
									var endtimeid = "endtime" + index;
									var thepointid = "shanghuadianwei" + index;
									var confirmidshichang = "shichang" + index;
									var confirmidpinci = "pinci" + index;
									var selectshichang = document.getElementById(confirmidshichang).value;
									var selectpinci = document.getElementById(confirmidpinci).value;

									var date1 = new Date($("#" + starttimeid).val()); //开始时间
									var date2 = new Date($("#" + endtimeid).val()); //结束时间
									var date3 = date2.getTime() - date1.getTime(); //时间差的毫秒数
									var days = Math.floor(date3 / (24 * 3600 * 1000)) + 1;
									var weeks = days.div(7);
									//获取刊例价
									var pPrice = returnPublishPrice($("#" + thepointid).val());
									//计算特殊刊例价系数
									//var k = 0.0007.mul(Number(selectpinci).mul(Number(selectshichang))) + 0.028.mul(Number(selectshichang)) - 0.0005.mul(Number(selectpinci)) - 0.02;
									var k = specificPublishPriceCoefficient(selectshichang, selectpinci);
									var pPrice = Math.round(pPrice.mul(k));
									var totalPrice = weeks.mul(pPrice);
									$("#guanggaoshuliang" + index).val(weeks.toFixed(2))
									$("#kanlijia" + index).val(numberFormat(totalPrice.toFixed(2)));

									kanlijiaonchange();
								}

								function returnPublishPrice(ledId) {
									var thePublishPrice = 0;
									$.ajax({
										url : "returnLedPublishPrice.action",
										type : "post",
										async : false,
										data : {
											ledId : ledId
										},
										dataType : "json",
										success : function(data) {
											thePublishPrice = data.publishPrice;
										}
									});
									return thePublishPrice;
								}
								
								function setSSTime(obj) {
									var led = $(obj).val();
									$.ajax({
											url : "returnLedSSTime.action",
											type : "post",
											async : false,
											data : {
												ledId : led
											},
											dataType : "json",
											success : function(data) {
												console.log(data.startTime);
												console.log(data.endTime);
												var tridx = parseInt(obj.id.replace(/[^0-9]/ig, ""));
												$("#starttime"+tridx).val(data.startTime);
												$("#endtime"+tridx).val(data.endTime);
											}
										});
	
								}

								function kanlijiaonchange() {
									var kanlijiaxiaojiarr = [];
									var kanlijiazongji = 0;
									$("input[name='kanlijialedtable']").each(
										function(i, o) {
											//  a.push($(o).val()); 将数据存入数组
											//前台格式化的去除格式化
											kanlijiaxiaojiarr[i] = numberUnFormat($(o).val());
											// 刊例价相加
											kanlijiazongji = Number(kanlijiazongji).add(Number(kanlijiaxiaojiarr[i]));
											numberFormat4This(o);
										});
									document.getElementById("kanliheji").value = kanlijiazongji.toFixed(2);

								}

								function hejishifuonchange(obj) {
									var kanlijiaxiaojiarr = [];
									var kanlijiazongji = 0;
									$("input[name='kanlijiaxiaojiledtable']").each(
										function(i, o) {
											//  a.push($(o).val()); 将数据存入数组
											//前台格式化的去除格式化
											kanlijiaxiaojiarr[i] = numberUnFormat($(o).val());
											// 刊例价相加
											kanlijiazongji = Number(kanlijiazongji).add(Number(kanlijiaxiaojiarr[i]));
											numberFormat4This(obj);
									});
									document.getElementById("hejishifujine").value = kanlijiazongji;
									kanlijiaonchange();

									changezhekou();

								}

								function numberUnFormat(obj) {
									return obj.replace(/,/g, '');
								}

								function unformatBeforeSubmit(obj) {
									var widgetNameSelector = "input[name='" + obj + "']";
									$(widgetNameSelector).each(
										function(i, o) {
											//  a.push($(o).val()); 将数据存入数组
											//前台格式化的去除格式化
											var numberValue = numberUnFormat($(
													o).val());
											$(o).val(numberValue);
									});
									var kanlijiaobj = $("#kanliheji");
									var shifuobj = $("#hejishifujine");
									var waigouobj = $("#purchasecost");
									kanlijiaobj.val(numberUnFormat(waigouobj.val()));
									shifuobj.val(numberUnFormat(shifuobj.val()));
									waigouobj.val(numberUnFormat(waigouobj.val()));
								}

								function numberFormat4This(obj) {
									var thisValue = $(obj).val();
									$(obj).val(numberFormat(thisValue));

								}

								function numberFormat(obj) {
									var number = numeral(obj);

									var value = number.format('0,0.00');
									// '1,000'

									return value;
								}

								function specificPublishPriceCoefficient(s, t) {
									if (s >= 15 && t >= 60) {
										return (Number(s).mul(t)).div(900);
									} else if (s < 15 && t < 60) {
										return (Number(s).mul(t)).div(625);
									} else {
										return (Number(s).mul(t)).div(750);
									}
								}

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
									var seqflag;

									//把flag存进去
									if (sdstr == localStorage.getItem("assistantIdentify")) {
										globalIdentification = parseInt(localStorage.getItem("globalIdentification"),10) + 1;
										localStorage.setItem("globalIdentification", globalIdentification);
									} else {
										globalIdentification = 0;
										localStorage.setItem("assistantIdentify", sdstr);
										localStorage.setItem("globalIdentification", globalIdentification);
									}
									if (globalIdentification < 10) {
										seqflag = "0" + globalIdentification;
									} else {
										seqflag = globalIdentification;
									}

									return sdstr + userid + seqflag;

								}

								function fillRenkanbianhao() {
									$("#renkanshubianhao").val(getUUID());
								}

								var packleixing;
								var packshichang;
								var packpinci;
								var packksshijian;
								var packjsshijian;

								function packageScreens(obj) {
									tellAdvertisingInfo(obj);
								}

								function packageScreen(obj) {
									var selbtnid = obj.id;
									var arrayledall = arrayledshort;
									arrayledall.pop();
									var arrayledgs = new Array();
									var arrayledgz = new Array();
									var arrayledsz = new Array();
									for (var i = 0, lgt = arrayledshort.length; i < lgt; i++) {
										if (arrayledshort[i][0] < 300) {
											arrayledgs.push(arrayledshort[i][0]);
											if (arrayledshort[i][0] < 200) {
												arrayledgz.push(arrayledshort[i][0]);
											} else {
												arrayledsz.push(arrayledshort[i][0]);
											}

										}
									}

									console.log("arrayledall:" + arrayledall);
									console.log("arrayledgs:" + arrayledgs);
									console.log("arrayledgz:" + arrayledgz);
									console.log("arrayledsz:" + arrayledsz);

									if ("allOwnScreens" == selbtnid) {
										arrayledall.forEach(function(elt, i) {
											console.log(elt);
											var index = i + 1;
											$("#addled").click();
											var o = $("#shanghuadianwei" + index);
											$("#guanggaoleixing" + index).val(packleixing);
											$("#shichang" + index).val(packshichang);
											$("#pinci" + index).val(packpinci);
											$("#starttime" + index).val(packksshijian);
											$("#endtime" + index).val(packjsshijian);
											o.val(elt[0]);
											calPublishPrice(o);
										});
									} else if ("gsScreens" == selbtnid) {
										arrayledgs.forEach(function(elt, i) {
											console.log(elt);
											var index = i + 1;
											$("#addled").click();
											var o = $("#shanghuadianwei" + index);
											$("#guanggaoleixing" + index).val(packleixing);
											$("#shichang" + index).val(packshichang);
											$("#pinci" + index).val(packpinci);
											$("#starttime" + index).val(packksshijian);
											$("#endtime" + index).val(packjsshijian);
											o.val(elt);
											calPublishPrice(o);
										});
									} else if ("gzScreens" == selbtnid) {
										arrayledgz.forEach(function(elt, i) {
											console.log(elt);
											var index = i + 1;
											$("#addled").click();
											var o = $("#shanghuadianwei" + index);
											$("#guanggaoleixing" + index).val(packleixing);
											$("#shichang" + index).val(packshichang);
											$("#pinci" + index).val(packpinci);
											$("#starttime" + index).val(packksshijian);
											$("#endtime" + index).val(packjsshijian);
											o.val(elt);
											calPublishPrice(o);
										});
									} else if ("szScreens" == selbtnid) {
										arrayledsz.forEach(function(elt, i) {
											console.log(elt);
											var index = i + 1;
											$("#addled").click();
											var o = $("#shanghuadianwei" + index);
											$("#guanggaoleixing" + index).val(packleixing);
											$("#shichang" + index).val(packshichang);
											$("#pinci" + index).val(packpinci);
											$("#starttime" + index).val(packksshijian);
											$("#endtime" + index).val(packjsshijian);
											o.val(elt);
											calPublishPrice(o);
										});
									}
								}

								function calRealPrice() {
									var kanlijiazongji = $("#kanliheji").val();
									var hejishifuvalue = $("#hejishifujine").val();
									var nenetrevenue = Number(hejishifuvalue).sub($("#purchasecost").val());
									if (hejishifuvalue == "") {
										alert("请输入实付合计金额，之后再点击计算刊例按钮进行计算！");
										document.getElementById("hejishifujine").focus();
									}
									var tmpvalue = 0;
									var thisKanlijia = 0;
									var thistotal = 0;
									var tblindex;
									var theobj = $("input[name='kanlijialedtable']");
									theobj.each(function(i, o) {
										tblindex = parseInt(o.id.replace(/[^0-9]/ig, ""))
										thisKanlijia = numberUnFormat($(o).val());
										tmpvalue = (Number(nenetrevenue).div(kanlijiazongji)).mul(thisKanlijia).toFixed(2);
										var o1 = $("#kanlijiaxiaoji" + tblindex);
										if (i == theobj.length - 1) {
											o1.val(Number(nenetrevenue).sub(thistotal));
										} else {
											o1.val(tmpvalue);
										}

										thistotal = thistotal.add(tmpvalue);
										console.log(o1.val());
										// 刊例价相加
										numberFormat4This(o1);
									});
									var kanlijiaobj = $("#kanliheji");
									var shifuobj = $("#hejishifujine");
									var waigouobj = $("#purchasecost");
									numberFormat4This(kanlijiaobj);
									numberFormat4This(shifuobj);
									numberFormat4This(waigouobj);
								}

								function appendScreens() {

								}

								function returnPublishPrice(ledId) {
									var thePublishPrice = 0;
									$.ajax({
										url : "returnLedPublishPrice.action",
										type : "post",
										async : false,
										data : {
											ledId : ledId
										},
										dataType : "json",
										success : function(data) {
											thePublishPrice = data.publishPrice;
										}
									});
									return thePublishPrice;
								}

								//添加行业
								function addIndustryCustomed(obj) {
									var selectedText = $(obj).find("option:selected").text();
									if(selectedText == "其他"){
										$("#addIndustry-modal").modal('show');
									}
								//确认
								$("#addIndustry-ok").click(function() {
									var industryname = $("#industryname").val();
									$.ajax({
										url : "addIndustryCustomer.action",
										type : "post",
										async : false,
										data : {
												industryname : industryname
										},
										success : function(data) {
													var data = JSON.parse(data);
													alert(data.info);
													$(obj).html();
													var options = "";
													for(var i=0;i<data.ind_ids.length;i++){
														options += "<option value='"+data.ind_ids[i]+"'>"+data.ind_names[i]+"</option>";
													}																									
													$(obj).html(options);
													$(obj).val(data.thisIndId);
													$("#addIndustry-modal").modal('hide');
										}
									});
								
								});
								}

								
								
								//输入上画信息模态框
								function tellAdvertisingInfo(obj) {
									$("#tellAdvertisingInfo-modal").modal('show');

									//确认
									$("#tellAdvertisingInfo-ok").click(function() {
										packleixing = $("#packleixing").val();
										packshichang = $("#packshichang").val();
										packpinci = $("#packpinci").val();
										packksshijian = $("#packksshijian").val();
										packjsshijian = $("#packjsshijian").val();
										if (packleixing != "" && packshichang != "" && packpinci != "" && packksshijian != "" && packjsshijian != "") {
											console.log(packleixing + " --" + packshichang + "--" + packpinci + "--" + packksshijian + "--" + packjsshijian);
											$("#tellAdvertisingInfo-modal").modal('hide');
											packageScreen(obj);
											var shifu = $("#hejishifujine").val();
											if (shifu == "") {
												$.alert("请输入实付金额！");
												document.getElementById("hejishifujine").focus();
											}
										} else {
											$.alert("请输入上画信息！");
										}
									});
								}

								function cleanScrTable() {
									$("#table tbody").html("");
								}
							</script>
						<div class="col-lg-12 col-md-12">
							<fieldset>
								<legend>
									上画点位<span class="text-danger">*</span>
								</legend>
								<div class="form-group">
									<table id="table" class="table-responsive">
										<thead>
											<tr>
												<th data-field="fabuneirong" data-sortable="true">发布内容</th>
												<th data-field="shanghuadianwei" data-sortable="true">上画点位</th>
												<th data-field="hangyeleixing" data-sortable="true">行业类型</th>
												<th data-field="xiadanshuxing" data-sortable="true">下单属性</th>
												<th data-field="pinci" data-sortable="true">频次</th>
												<th data-field="shichang" data-sortable="true">时长</th>
												<th data-field="startdate" data-sortable="true">开始日期</th>
												<th data-field="enddate" data-sortable="true">结束日期</th>
												<th data-field="starttime" data-sortable="true">开始时间</th>
												<th data-field="endtime" data-sortable="true">结束时间</th>
												<th data-field="playhstrategy" data-sortable="true">播放策略</th>
												<th data-field="operation" data-sortable="true">操作</th>
											</tr>
										</thead>
										<tbody></tbody>
									</table>
								</div>
								<div class="form-group">
									<a class="btn btn-link" id="addleds"><span id="addled" class="glyphicon glyphicon-plus" style="font-family: '微软雅黑';"> 添加</span></a>
									<button type="button" class="btn btn-danger" id="cleanScreensTable" onclick="cleanScrTable()">清空列表</button>
									<button type="button" class="btn btn-prime" id="allOwnScreens" onclick="packageScreens(this)" style="display: none;">全部自有屏</button>
									<button type="button" class="btn btn-prime" id="gsScreens" onclick="packageScreens(this)" style="display: none;">广深屏</button>
									<button type="button" class="btn btn-prime" id="gzScreens" onclick="packageScreens(this)" style="display: none;">广州屏</button>
									<button type="button" class="btn btn-prime" id="szScreens" onclick="packageScreens(this)" style="display: none;">深圳屏</button>
									<!-- <div class="pull-right">
										<button type="button" class="btn btn-danger"
											id="cleanScreensTable" onclick="cleanScrTable()">清空列表</button>
									</div> -->
								</div>
							</fieldset>
						</div>
						<div style="text-align: center;" class="col-md-12">
							<button type="button" id="store" class="btn" style="display: none;">保存</button>
							<button type="button" id="restore" class="btn" style="display: none;">恢复</button>
							<button type="button" id="submit_button" class="btn btn-primary" onclick="doSubmit()">提交</button>
							<button type="reset" class="btn btn-default">取消</button>
						</div>
					</form>
				</div>
			</div>
			<!-- /.col-->
		</div>
		<!-- /.row -->
		<div class="modal fade" id="addIndustry-modal">
			<div class="modal-dialog ">
				<div class="modal-content">
					<div class="modal-header h3">添加行业</div>
					<div class="modal-body " style="text-align: center">
						<form id="addIndustryForm" class="form-horizontal" role="form">
							<div class="form-group ">
								<label for="account" class="col-sm-3 control-label">行业名称</label>
								<div class="col-sm-4 has-success">
									<input type="text" class="form-control" id="industryname" name="industryname" maxlength="20">
								</div>
							</div>
							<!--<div class="form-group ">
								<label for="account" class="col-sm-3 control-label">描述</label>
								<div class="col-sm-4 has-success">
									<input type="text" class="form-control" id="desc"  maxlength="20">
								</div>
							</div> -->
						</form>
					</div>
					<div class="modal-footer">
						<button class="btn btn-danger" data-dismiss="modal">
							<i class="fa fa-times-circle"></i>取消
						</button>
						<button id="addIndustry-ok" class="btn btn-success">
							<i class="fa fa-check-circle"></i>确认
						</button>
					</div>
				</div>
				<!-- /.modal-content -->
			</div>
			<!-- /.modal-dialog -->
		</div>
		<!-- /.modal -->
		<div class="modal fade" id="tellAdvertisingInfo-modal">
			<div class="modal-dialog ">
				<div class="modal-content">
					<div class="modal-header h4">上画信息</div>
					<div class="modal-body " style="text-align: center">
						<form id="formeditOrder" class="form-horizontal" role="form">
							<div class="form-group ">
								<label for="role" class="col-sm-3 control-label">广告类型</label>
								<div class="col-sm-4 has-success">
									<select id="packleixing" class="form-control">
										<option value="商业广告">商业广告</option>
										<option value="互赠广告">互赠广告</option>
										<option value="部分置换">部分置换</option>
										<option value="赠播广告">赠播广告</option>
										<option value="公益广告">公益广告</option>
										<option value="其他广告">其他广告</option>
									</select>
								</div>
							</div>
							<div class="form-group ">
								<label for="account" class="col-sm-3 control-label">时长</label>
								<div class="col-sm-4 has-success">
									<input type="text" class="form-control" id="packshichang" value="15" maxlength="20">
								</div>
							</div>
							<div class="form-group ">
								<label for="account" class="col-sm-3 control-label">频次</label>
								<div class="col-sm-4 has-success">
									<input type="text" class="form-control" id="packpinci" value="60" maxlength="20">
								</div>
							</div>
							<div class="form-group ">
								<label for="account" class="col-sm-3 control-label">播放开始时间</label>
								<div class="col-sm-4 has-success">
									<input type="date" class="form-control" id="packksshijian" maxlength="20">
								</div>
							</div>
							<div class="form-group ">
								<label for="account" class="col-sm-3 control-label">播放结束时间</label>
								<div class="col-sm-4 has-success">
									<input type="date" class="form-control" id="packjsshijian" maxlength="20">
								</div>
							</div>
						</form>
					</div>
					<div class="modal-footer">
						<button class="btn btn-danger" data-dismiss="modal">
							<i class="fa fa-times-circle"></i>取消
						</button>
						<button id="tellAdvertisingInfo-ok" class="btn btn-success">
							<i class="fa fa-check-circle"></i>确认
						</button>
					</div>
				</div>
				<!-- /.modal-content -->
			</div>
			<!-- /.modal-dialog -->
		</div>
		<!-- /.modal -->
	</div>
	<!--/.main-->
	<script src="js/bootstrap.min.js"></script>
	<script src="js/king-common.js"></script>
	<script type="text/javascript" src="js/bootstrap-datetimepicker.js"></script>
	<script src="js/bootstrap-datetimepicker.zh-CN.js" charset="UTF-8"></script>
	<script type="text/javascript" src="js/bootstrap-table.js"></script>
	<script type="text/javascript" src="js/bootstrap3-typeahead.min.js"></script>
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
	
		//分期JavaScript 
		function switchFenqiItem(tagobj) {
			$("#fukuantable tbody").html("");
			var fenqiindex = tagobj;
			var requirepay = document.getElementById("hejishifujine").value;
			if (requirepay == undefined) {
				requirepay = numberUnFormat(requirepay);
			}
			var requirefill = Number(requirepay).div(Number(fenqiindex));
			var arrfukuanfangshi = [ "现金", "支票", "汇票", "其他" ];
			for (var i = 1; i <= fenqiindex; i++) {
				$("#fukuantable>tbody").append(
					'<tr><td width="15%">第' + i + '期<input id="fenqiming' + i + '" name="fenqimingcheng" class="hidden" value="第' + i + '期"/></td><td width="25%"><input name="fenqijine" class="form-control" type="number" id="fenqifukuanjine' 
					+ i + '" value="' + requirefill + '" /></td><td width="25%"><input class="form-control" name="fenqifukuanshijian" type="date" id="fenqishijian' + i + '" /></td><td width="20%"><select id="selectfukuanfangshi'
					+ i + '" class="form-control" name="fukuanfangshi"></select></td><td width="15%"><input class="form-control" name="fukuanbeizhu" type="text" id="fukuanbeizhu' + i + '" /></td></tr>'
				);
	
				var fukuanfangshiid = "selectfukuanfangshi" + i;
				for (var j = 0; j < arrfukuanfangshi.length; j++) {
					document.getElementById(fukuanfangshiid).options.add(new Option(arrfukuanfangshi[j], arrfukuanfangshi[j]));
				}
			}
	
		}
	
		$(function() {
			$("#guanggaokanhu").typeahead({
				source : function(query, process) {
/*  					var parameter = {
						keyword : query
					};
					return $.post('autocompleteclient.action', parameter, function(data) {
						process(data);
					}); */
					return $.ajax({
						url : 'autocompleteclient.action',
						type : 'post',
						data : {
							keyword : query
						},
						dataType : 'json',
						success : function(result) {
							// 这里省略resultList的处理过程，处理后resultList是一个字符串列表，
							// 经过process函数处理后成为能被typeahead支持的字符串数组，作为搜索的源
							return process(result);
						}
					});
				}
			});
	
			$("#guanggaodailigongsi").typeahead({
				source : function(query, process) {
					return $.ajax({
						url : 'autocompleteagency.action',
						type : 'post',
						data : {
							keyword : query
						},
						dataType : 'json',
						success : function(result) {
							// 这里省略resultList的处理过程，处理后resultList是一个字符串列表，
							// 经过process函数处理后成为能被typeahead支持的字符串数组，作为搜索的源
							return process(result);
						}
					});
				}
			});
	
			$("input[name='fabuneirongledtable']").typeahead({
				source : function(query, process) {
					return $.ajax({
						url : 'autocompletecontent.action',
						type : 'post',
						data : {
							keyword : query
						},
						dataType : 'json',
						success : function(result) {
							// 这里省略resultList的处理过程，处理后resultList是一个字符串列表，
							// 经过process函数处理后成为能被typeahead支持的字符串数组，作为搜索的源
							return process(result);
						}
					});
				}
			});
	
		});
	</script>
	<script type="text/javascript">
	
		var localStorageStateTip = "";
		//保存表单到本地
		function localFormStorageSave() {
			if (window.localStorage) {
	
			} else {
				alert('您的浏览器不支持表单保存功能');
				return;
			}
	
			if ($("#dtp_input2").val() == null || $("#dtp_input2").val() == "" || $("#renkanshubianhao").val() == null || $("#renkanshubianhao").val() == "" || $("#selectyewuyuan").val() == null || $("#selectyewuyuan").val() == "") {
				localStorageStateTip = "认刊书的必填内容为空，系统将不进行保存！";
			} else {
				localStorage.setItem("renkanshu.qiandingriqi", $("#dtp_input2").val());
				localStorage.setItem("yewuyuan.ywyBumenid", $("#selectbumen").val());
				localStorage.setItem("renkanshu.ywyId", $('#selectyewuyuan').val());
				localStorage.setItem("renkanshu.renkanbianhao", $("#renkanshubianhao").val());
				localStorage.setItem("renkanshu.hetongbianhao", $("#hetongbianhao").val());
				/* 			localStorage.setItem("renkanshu.baogaobianhao",$("#baogaobianhao").val()); */
				localStorage.setItem("renkanshu.guanggaokanhu", $("#guanggaokanhu").val());
				localStorage.setItem("renkanshu.guanggaodailigongsi", $("#guanggaodailigongsi").val());
				localStorage.setItem("industryclassify", $('#industryclassify').val());
				localStorage.setItem("industry.industryDesc", $('#guanggaohangye').val());
				localStorage.setItem("renkanshu.guanggaoneirong", $("#guanggaoneirong").val());
	
				localStorage.setItem("renkanshu.gaojianlaiyuan", $("input:radio[name='renkanshu.gaojianlaiyuan']:checked").val());
				localStorage.setItem("renkanshu.gaojianleibie", $("input:radio[name='renkanshu.gaojianleibie']:checked").val());
	
				localStorage.setItem("kanliheji", $('#kanliheji').val());
				localStorage.setItem("purchasecost", $('#purchasecost').val());
				localStorage.setItem("hejishifujine", $('#hejishifujine').val());
				localStorage.setItem("cankaozhekou", $('#cankaozhekou').val());
				localStorage.setItem("renkanshu.renkanshubeizhu", $('#renkanshubeizhu').val());
				localStorage.setItem("renkanshu.agencymode", $('#agencymode').val());
				localStorage.setItem("renkanshufenqi", $('#renkanshufenqi').val());
	
				var shanghuadianweiledtablelocal = new Array();
				$("select[name='shanghuadianweiledtable']").each(function() {
					shanghuadianweiledtablelocal.push($(this).val());
				});
				var guanggaoleixingledtablelocal = new Array();
				$("select[name='guanggaoleixingledtable']").each(function() {
					guanggaoleixingledtablelocal.push($(this).val());
				});
				var starttimeledtablelocal = new Array();
				$("input[name='starttimeledtable']").each(function() {
					starttimeledtablelocal.push($(this).val());
				});
				var endtimeledtablelocal = new Array();
				$("input[name='endtimeledtable']").each(function() {
					endtimeledtablelocal.push($(this).val());
				});
				var pinciledtablelocal = new Array();
				$("input[name='pinciledtable']").each(function() {
					pinciledtablelocal.push($(this).val());
				});
				var shichangledtablelocal = new Array();
				$("input[name='shichangledtable']").each(function() {
					shichangledtablelocal.push($(this).val());
				});
				var guanggaoshuliangledtablelocal = new Array();
				$("input[name='guanggaoshuliangledtable']").each(function() {
					guanggaoshuliangledtablelocal.push($(this).val());
				});
				var kanlijiaxiaojiledtablelocal = new Array();
				$("input[name='kanlijiaxiaojiledtable']").each(function() {
					kanlijiaxiaojiledtablelocal.push($(this).val());
				});
				var kanlijialedtablelocal = new Array();
				$("input[name='kanlijialedtable']").each(function() {
					kanlijialedtablelocal.push($(this).val());
				});
	
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
	
				localStorage.setItem("shanghuadianweiledtable", shanghuadianweiledtablelocal);
				localStorage.setItem("guanggaoleixingledtable", guanggaoleixingledtablelocal);
				localStorage.setItem("starttimeledtable", starttimeledtablelocal);
				localStorage.setItem("endtimeledtable", endtimeledtablelocal);
				localStorage.setItem("pinciledtable", pinciledtablelocal);
				localStorage.setItem("shichangledtable", shichangledtablelocal);
				localStorage.setItem("guanggaoshuliangledtable", guanggaoshuliangledtablelocal);
				localStorage.setItem("kanlijiaxiaojiledtable", kanlijiaxiaojiledtablelocal);
				localStorage.setItem("kanlijialedtable", kanlijialedtablelocal);
	
				localStorage.setItem("renkanshufukuan.fenqimingcheng", fenqimingcheng);
				localStorage.setItem("renkanshufukuan.fenqijine", fenqijine);
				localStorage.setItem("renkanshufukuan.fenqifukuanshijian", fenqifukuanshijian);
				localStorage.setItem("renkanshufukuan.fukuanfangshi", fukuanfangshi);
				localStorage.setItem("renkanshufukuan.fukuanbeizhu", fukuanbeizhu);
	
				localStorageStateTip = "认刊书保存成功！";
			}
	
		}
		function localFormStorageRestore() {
			var shanghuadianweiledtabletojs = localStorage.getItem("shanghuadianweiledtable").split(",");
			var guanggaoleixingledtabletojs = localStorage.getItem("guanggaoleixingledtable").split(",");
			var starttimeledtabletojs = localStorage.getItem("starttimeledtable").split(",");
			var endtimeledtabletojs = localStorage.getItem("endtimeledtable").split(",");
			var pinciledtabletojs = localStorage.getItem("pinciledtable").split(",");
			var shichangledtabletojs = localStorage.getItem("shichangledtable").split(",");
			var guanggaoshuliangledtabletojs = localStorage.getItem("guanggaoshuliangledtable").split(",");
			var kanlijiaxiaojiledtabletojs = localStorage.getItem("kanlijiaxiaojiledtable").split(",");
			var kanlijialedtabletojs = localStorage.getItem("kanlijialedtable").split(",");
			if (localStorage.getItem("shanghuadianweiledtable").length > 0) {
				for (var j = 1; j <= shanghuadianweiledtabletojs.length; j++) {
					$("#table>tbody").append(
						'<tr><td><select name="shanghuadianweiledtable"  class="form-control" id="shanghuadianwei' + j + '" onchange="kanliclassiconchange(this)">'
						+ optionselectHtml.join() + '</select></td><td><select name="guanggaoleixingledtable"  class="form-control" id="guanggaoleixing' 
						+ j + '" >' + optionselectguanggaoleixing.join() + '</select></td><td ><div class=""><input name="starttimeledtable" class="form-control" type="date" id="starttime' 
						+ j + '" /></div></td><td><div class=""><input name="endtimeledtable"  class="form-control" type="date" id="endtime' + j + '" /></div></td><td><div class=""><input name="guanggaoshuliangledtable"  class="form-control" type="text" id="guanggaoshuliang'
						+ j + '" value="4" /></div></td><td><input name="pinciledtable" class="form-control" id="pinci'
						+ j + '" ></input></td><td><input name="shichangledtable" class="form-control" id="shichang' + j + '" ></input></td><td ><input name="kanlijialedtable" class="form-control " id="kanlijia'
						+ j + '" ></input></td><td><div class=""><input name="kanlijiaxiaojiledtable" class="form-control" value="0" id="kanlijiaxiaoji'
						+ j + '" onblur="kanlijiaonchange()" ></input></div></td><td><a class="form-control" onclick="deltr(this)"><span class="glyphicon glyphicon-remove"></span></a></td></tr>');
	
				}
			}
	
			$("#dtp_input2").val(localStorage.getItem("renkanshu.qiandingriqi"));
	
			$("#selectbumen").val(localStorage.getItem("yewuyuan.ywyBumenid"));
			changeselectywy(localStorage.getItem("yewuyuan.ywyBumenid"));
			$("#selectyewuyuan").val(localStorage.getItem("renkanshu.ywyId"));
	
			$("#renkanshubianhao").val(localStorage.getItem("renkanshu.renkanbianhao"));
			$("#hetongbianhao").val(localStorage.getItem("renkanshu.hetongbianhao"));
			/* 		$("#baogaobianhao").val(localStorage.getItem("renkanshu.baogaobianhao")); */
			$("#guanggaokanhu").val(localStorage.getItem("renkanshu.guanggaokanhu"));
			$("#guanggaodailigongsi").val(localStorage.getItem("renkanshu.guanggaodailigongsi"));
	
			$("#industryclassify").val(localStorage.getItem("industryclassify"));
			changeselectindc(localStorage.getItem("industryclassify"));
			$("#guanggaohangye").val(localStorage.getItem("industry.industryDesc"));
	
			$("#guanggaoneirong").val(localStorage.getItem("renkanshu.guanggaoneirong"));
	
			$("input:radio[name='renkanshu.gaojianlaiyuan'][value='" + localStorage.getItem("renkanshu.gaojianlaiyuan") + "']").attr("checked", true);
			$("input:radio[name='renkanshu.gaojianleibie'][value='" + localStorage.getItem("renkanshu.gaojianleibie") + "']").attr("checked", true);
	
			$("#kanliheji").val(localStorage.getItem("kanliheji"));
			$("#purchasecost").val(localStorage.getItem("purchasecost"));
			$("#hejishifujine").val(localStorage.getItem("hejishifujine"));
			$("#cankaozhekou").val(localStorage.getItem("cankaozhekou"));
			$("#cankaozhekou").val(localStorage.getItem("cankaozhekou"));
			$("#renkanshubeizhu").val(localStorage.getItem("renkanshu.renkanshubeizhu"));
			$("#agencymode").val(localStorage.getItem("renkanshu.agencymode"));
			$("#renkanshufenqi").val(localStorage.getItem("renkanshufenqi"));
	
			for (var i = 1; i <= shanghuadianweiledtabletojs.length; i++) {
				$("#shanghuadianwei" + i + "").val(shanghuadianweiledtabletojs[i - 1]);
				$("#guanggaoleixing" + i + "").val(guanggaoleixingledtabletojs[i - 1]);
				$("#starttime" + i + "").val(starttimeledtabletojs[i - 1]);
				$("#endtime" + i + "").val(endtimeledtabletojs[i - 1]);
				$("#guanggaoshuliang" + i + "").val(guanggaoshuliangledtabletojs[i - 1]);
				$("#pinci" + i + "").val(pinciledtabletojs[i - 1]);
				$("#shichang" + i + "").val(shichangledtabletojs[i - 1]);
				$("#kanlijiaxiaoji" + i + "").val(kanlijiaxiaojiledtabletojs[i - 1]);
				$("#kanlijia" + i + "").val(kanlijialedtabletojs[i - 1]);
	
			}
	
			var fenqijine = localStorage.getItem("renkanshufukuan.fenqijine").split(",");
			var fenqifukuanshijian = localStorage.getItem("renkanshufukuan.fenqifukuanshijian").split(",");
			var fukuanfangshi = localStorage.getItem("renkanshufukuan.fukuanfangshi").split(",");
			var fukuanbeizhu = localStorage.getItem("renkanshufukuan.fukuanbeizhu").split(",");
			var fenqimingcheng = localStorage.getItem("renkanshufukuan.fenqimingcheng").split(",");
	
			if (localStorage.getItem("renkanshufukuan.fenqimingcheng").length > 0) {
				switchFenqiItem(fenqimingcheng.length);
				for (var j = 1; j <= fenqimingcheng.length; j++) {
					$("#fenqifukuanjine" + j + "").val(fenqijine[j - 1]);
					$("#fenqishijian" + j + "").val(fenqifukuanshijian[j - 1]);
					$("#selectfukuanfangshi" + j + "").val(fukuanfangshi[j - 1]);
					$("#fukuanbeizhu" + j + "").val(fukuanbeizhu[j - 1]);
				}
			}
	
		}
		function localFormStorageClean() {
			var timestampstr = localStorage.getItem("assistantIdentify");
			var indentify = localStorage.getItem("globalIdentification");
			localStorage.clear();
			localStorage.setItem("globalIdentification", indentify);
			localStorage.setItem("assistantIdentify", timestampstr);
		}
	
		$(function() {
			$("#addled").click();
			$("#renkanshubeizhu").width($("#guanggaokanhu").width() * 2 + 22);
		});
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
			$(document).on(
				"click",
				"ul.nav li.parent > a > span.icon",
				function() {
					$(this).find('em:first').toggleClass("glyphicon-minus");
			});
			$(".sidebar span.icon").find('em:first').addClass("glyphicon-plus");
		}(window.jQuery);

		$(window).on('resize', function() {
			if ($(window).width() > 768){
				$('#sidebar-collapse').collapse('show');
			}
		})
		$(window).on('resize', function() {
			if ($(window).width() <= 767){
				$('#sidebar-collapse').collapse('hide');
			}
		})
	</script>
</body>
</html>