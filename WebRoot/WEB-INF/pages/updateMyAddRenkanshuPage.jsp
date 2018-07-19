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
	<div class="main">	<!--/.row-->
		<div class="row">
			<div class="col-lg-12">
				<h3 class="page-header">修改认刊书</h3>
				<div id="operState" class="hidden">${renkanshuaudit.operState}</div>
				<div id="unapprovedReason" class="alert alert-error hidden" ></div>
			</div>
		</div>
		<!--/.row-->
		<div class="row">
			<div class="col-lg-12">
				<div align="center" style="font-size: large;color: red">${session.erromessage }</div>
			</div>
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
									name="renkanshuaudit.advertisingintentcomein"
									value='<s:property value="renkanshuaudit.advertisingintentcomein"/>'
									maxlength="20">
							</div>
						</div>

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

					<div class="modal fade" id="downOrder-modal">
						<div class="modal-dialog ">
							<div class="modal-content">
								<div class="modal-header h4">停刊</div>
								<div class="modal-body " style="text-align:center">
									<form id="xiahua_form_audit" action="" class="form-horizontal"
										role="form">
										<input class="hidden" name="orderauditId">
										<div class="form-group">
											<label for="account" class="col-sm-3 control-label">播放结束时间</label>
											<div class="col-sm-4">
												<input type="date" class="form-control input-sm"
													name="xiahua_jieshushijian" maxlength="20">
											</div>
										</div>
										<div class="form-group">
											<label for="account" class="col-sm-3 control-label">停刊理由</label>
											<div class="col-sm-8">
												<textarea id="textarea" class="form-control" rows="4"
													cols="10" maxlength="100" name="xiahua_Reason"></textarea>
											</div>
											<p class="help-block text-right js-textarea-help">
												<span class="text-muted"></span>
											</p>
										</div>
										<div class="form-group">
											<label>确认停刊所选点位吗？</label>
										</div>
									</form>
								</div>
								<div class="modal-footer">
									<button id="downOrder-ok" class="btn btn-success">
										<i class="fa fa-check-circle"></i>确认
									</button>
									<button class="btn btn-danger" data-dismiss="modal">
										<i class="fa fa-times-circle"></i>取消
									</button>
								</div>
							</div>
							<!-- /.modal-content -->
						</div>
						<!-- /.modal-dialog -->
					</div>
					<!-- /.modal -->

					<div class="modal fade" id="upOrder-modal">
						<div class="modal-dialog ">
							<div class="modal-content">
								<div class="modal-header h4">上画</div>
								<div class="modal-body " style="text-align:center">
									<form id="formUpOrder" action="" class="form-horizontal"
										role="form">
										<div class="form-group">
											<label for="account" class="col-sm-2 control-label">上画理由</label>
											<div class="col-sm-8">
												<textarea id="textarea" class="form-control" rows="4"
													cols="10" maxlength="100" name="upReason"></textarea>
											</div>
											<p class="help-block text-right js-textarea-help">
												<span class="text-muted"></span>
											</p>
										</div>
										<div class="form-group">
											<label>确认在该点位上画吗？</label>
										</div>
									</form>
								</div>
								<div class="modal-footer">
									<button id="upOrder-ok" class="btn btn-success">
										<i class="fa fa-check-circle"></i>确认
									</button>
									<button class="btn btn-danger" data-dismiss="modal">
										<i class="fa fa-times-circle"></i>取消
									</button>
								</div>
							</div>
							<!-- /.modal-content -->
						</div>
						<!-- /.modal-dialog -->
					</div>
					<!-- /.modal -->

					<div class="modal fade" id="addOrder-modal">
						<div class="modal-dialog ">
							<div class="modal-content">
								<div class="modal-header h4">添加点位</div>
								<div class="modal-body " style="text-align:center">
									<form id="formAddOrder" class="form-horizontal" role="form">
										<%-- <input type="text" class="hidden" name="tid" value='<s:property value="yewu.yewuId"/>'> --%>
										<input type="text" class="hidden" name="renkanshuauditId" />
										<div class="form-group">
											<label for="role" class="col-sm-3 control-label">上画屏幕</label>
											<div class="col-sm-4">
												<select class="form-control input-sm" name="ledId"
													id="led_id">
													<s:iterator value="#request.leds">
														<option value='<s:property value="[0].top[0]"/>'><s:property
																value="[0].top[1]" /></option>
													</s:iterator>
												</select>
											</div>
										</div>

										<div class="form-group">
											<label for="role" class="col-sm-3 control-label">广告类型</label>
											<div class="col-sm-4">
												<select class="form-control input-sm" name="leixing"></select>
											</div>
										</div>

										<div class="form-group">
											<label for="account" class="col-sm-3 control-label">时长</label>
											<div class="col-sm-4">
												<input type="text" class="form-control input-sm"
													name="shichang" maxlength="20">
											</div>
										</div>
										<div class="form-group">
											<label for="account" class="col-sm-3 control-label">频次</label>
											<div class="col-sm-4">
												<input type="text" class="form-control input-sm"
													name="pinci" maxlength="20">
											</div>
										</div>
										<div class="form-group">
											<label for="account" class="col-sm-3 control-label">播放开始时间</label>
											<div class="col-sm-4">
												<input type="date" class="form-control input-sm"
													name="kaishishijian" maxlength="20">
											</div>
										</div>

										<div class="form-group">
											<label for="account" class="col-sm-3 control-label">播放结束时间</label>
											<div class="col-sm-4">
												<input type="date" class="form-control input-sm"
													name="jieshushijian" maxlength="20">
											</div>
										</div>
										<div class="form-group">
											<label for="account" class="col-sm-3 control-label">数量(周)</label>
											<div class="col-sm-4">
												<input type="text" class="form-control input-sm"
													name="shuliang" maxlength="20">
											</div>
										</div>

										<div class="form-group">
											<label for="account" class="col-sm-3 control-label">刊例价小计</label>
											<div class="col-sm-4">
												<input type="text" class="form-control input-sm"
													name="kanlixiaoji" maxlength="20">
											</div>
										</div>

										<div class="form-group">
											<label for="account" class="col-sm-3 control-label">上画理由</label>
											<div class="col-sm-8">
												<textarea class="form-control input-sm " rows="3"
													name="addReason" maxlength="150"></textarea>
											</div>
										</div>
									</form>
								</div>
								<div class="modal-footer">
									<button id="addOrder-ok" class="btn btn-success">
										<i class="fa fa-check-circle"></i>确认
									</button>
									<button class="btn btn-danger" data-dismiss="modal">
										<i class="fa fa-times-circle"></i>取消
									</button>
								</div>
							</div>
							<!-- /.modal-content -->
						</div>
						<!-- /.modal-dialog -->
					</div>
					<!-- /.modal -->

					<div class="modal fade" id="editOrder-modal">
						<div class="modal-dialog ">
							<div class="modal-content">
								<div class="modal-header h4">修改订单</div>
								<div class="modal-body " style="text-align:center">
									<form id="formeditOrder" class="form-horizontal" role="form">
										<%-- <input type="text" class="hidden" name="tid" value='<s:property value="yewu.yewuId"/>'> --%>
										<input type="text" class="hidden" name="orderauditId" />
										<div class="form-group">
											<label for="role" class="col-sm-3 control-label">上画屏幕</label>
											<div class="col-sm-4">
												<select class="form-control input-sm" name="ledId"
													id="led_id">
													<s:iterator value="#request.leds">
														<option value='<s:property value="[0].top[0]"/>'><s:property
																value="[0].top[1]" /></option>
													</s:iterator>
												</select>
											</div>
										</div>

										<div class="form-group">
											<label for="role" class="col-sm-3 control-label">广告类型</label>
											<div class="col-sm-4">
												<select class="form-control input-sm" name="leixing"></select>
											</div>
										</div>

										<div class="form-group">
											<label for="account" class="col-sm-3 control-label">时长</label>
											<div class="col-sm-4">
												<input type="text" class="form-control input-sm"
													name="shichang" maxlength="20">
											</div>
										</div>
										<div class="form-group">
											<label for="account" class="col-sm-3 control-label">频次</label>
											<div class="col-sm-4">
												<input type="text" class="form-control input-sm"
													name="pinci" maxlength="20">
											</div>
										</div>
										<div class="form-group">
											<label for="account" class="col-sm-3 control-label">播放开始时间</label>
											<div class="col-sm-4">
												<input type="date" class="form-control input-sm"
													name="kaishishijian" maxlength="20">
											</div>
										</div>

										<div class="form-group">
											<label for="account" class="col-sm-3 control-label">播放结束时间</label>
											<div class="col-sm-4">
												<input type="date" class="form-control input-sm"
													name="jieshushijian" maxlength="20">
											</div>
										</div>
										<div class="form-group">
											<label for="account" class="col-sm-3 control-label">数量(周)</label>
											<div class="col-sm-4">
												<input type="text" class="form-control input-sm"
													name="shuliang" maxlength="20">
											</div>
										</div>

										<div class="form-group">
											<label for="account" class="col-sm-3 control-label">刊例价小计</label>
											<div class="col-sm-4">
												<input type="text" class="form-control input-sm"
													name="kanlixiaoji" maxlength="20">
											</div>
										</div>

										<div class="form-group">
											<label for="account" class="col-sm-3 control-label">修改理由</label>
											<div class="col-sm-8">
												<textarea class="form-control input-sm " rows="3"
													name="updateReason" maxlength="150"></textarea>
											</div>
										</div>
									</form>
								</div>
								<div class="modal-footer">
									<button id="editOrder-ok" class="btn btn-success">
										<i class="fa fa-check-circle"></i>确认
									</button>
									<button class="btn btn-danger" data-dismiss="modal">
										<i class="fa fa-times-circle"></i>取消
									</button>
								</div>
							</div>
							<!-- /.modal-content -->
						</div>
						<!-- /.modal-dialog -->
					</div>
					<!-- /.modal -->
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
	
	$(function(){
		if($("#operState").html() == "U") {
			$("#unapprovedReason").html("<strong>不通过理由：</strong>${renkanshuaudit.auditReason}");
			$("#unapprovedReason").removeClass("hidden");
		}
	})
	
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
	
	function downOrder(target){
		var target = $(target).data("target");
		if(target==null || target==""){
			return;
		}
		$("input[name='orderauditId']").val(target);
		$("#downOrder-modal").modal('show');
	}
	
	//修改订单模态框
	function editOrder(target){
		var target = $(target).data("target");
		if(target==null || target==""){
			return;
		}
		var index = 0;
		for(var i = 0; i < orderInfo.rows.length; i++) {
			if(orderInfo.rows[i].id == target) {
				index = i;
			}
		}
		//设置表单为原始数据
		var prevLed = orderInfo.rows[index].cell[9];
		var prevType = orderInfo.rows[index].cell[1];
		var prevDuration = orderInfo.rows[index].cell[4];
		var prevFreq = orderInfo.rows[index].cell[5];
		var prevStartTime = orderInfo.rows[index].cell[2];
		var prevEndTime = orderInfo.rows[index].cell[3];
		var prevOrderPrice = orderInfo.rows[index].cell[8];
		var prevWeeks = orderInfo.rows[index].cell[7];
		$("#editOrder-modal select[name='ledId']").val(prevLed);
		$("#editOrder-modal select[name='leixing']").val(prevType);
		$("#editOrder-modal input[name='shichang']").val(prevDuration);
		$("#editOrder-modal input[name='pinci']").val(prevFreq);
		$("#editOrder-modal input[name='kaishishijian']").val(prevStartTime);
		$("#editOrder-modal input[name='jieshushijian']").val(prevEndTime);
		$("#editOrder-modal input[name='kanlixiaoji']").val(prevOrderPrice);
		$("#editOrder-modal input[name='shuliang']").val(prevWeeks);
		$("#editOrder-modal input[name='orderauditId']").val(target);
		
		$("#editOrder-modal").modal('show');
		
		//确认修改订单
		$("#editOrder-ok").click(function(){
			if($("#editOrder-modal select[name='ledId']").val() == prevLed
			&& $("#editOrder-modal select[name='leixing']").val() == prevType
			&& $("#editOrder-modal input[name='shichang']").val() == prevDuration
			&& $("#editOrder-modal input[name='pinci']").val() == prevFreq
			&& $("#editOrder-modal input[name='kaishishijian']").val() == prevStartTime
			&& $("#editOrder-modal input[name='jieshushijian']").val() == prevEndTime
			&& $("#editOrder-modal input[name='kanlixiaoji']").val() == prevOrderPrice
			&& $("#editOrder-modal input[name='shuliang']").val() == prevWeeks) {
				$.alert("您没有修改信息！");
			} else {
				$.ajax({
					url: "updateOrderForRenkanshuaudit",
					type: "post",
					data: $("#formeditOrder").serializeArray(),
					dataType:"json",
					success:function(data){
						$.alert(data.info);
						$("#editOrder-modal").modal('hide');
					},
					error:function(XMLHttpRequest, textStatus, errorThrown){
						alert('保存失败\nXMLHttpRequest.readyState['+XMLHttpRequest.readyState+']\nXMLHttpRequest.status['+XMLHttpRequest.status+']\ntextStatus['+textStatus+']');
					}
				})
			}
		})
	}
	
	//上画订单模态框
	function upOrder(target) {
		$("#upOrder-modal").modal('show');
		//确认上画订单
		$("#upOrder-ok").click(function(){
			$.ajax({
		  		type: "GET",
		  		dataType: "JSON",
		  		data: {"tid": $(target).data("target"), "upReason": $("textarea[name='upReason']").val()},
		  		url: "upOrder",
		  		success: function(data) {
					$.dialog({
					    title: '提示',
					    content: '您的上画信息已成功提交，请耐心等候审核结果！',
					});
		  		},
		  		error: function() {
		  			alert("error");
		  		}
			});
			$("#upOrder-modal").modal('hide');
		})
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
		
	$(document).ready(function(){		
		$("#industryclassifyid").val(originalIndustyClassify);
		$("#industry_id").val(originalIndustry);
		$("#bumen_id").val(orginalBumen);
		$("#yewuyuan_id").val(orginalYewuyuan);
		$("#gaojianlaiyuan_id").val(originalGaojianlaiyuan);
		$("#gaojianleibie_id").val(originalGaojianleibie);
        //填充类型选择下拉菜单
		$("select[name='leixing']").append("<option value='商业广告'>商业广告</option>"
										+"<option value='公益广告'>公益广告</option>"
										+"<option value='赠播广告'>赠播广告</option>"
										+"<option value='互赠广告'>互赠广告</option>"
										+"<option value='其他'>其他</option>")
		
		//填充订单信息
		var table = $("#jqgrid");
//		var renkanshuauditId = $("input[name='renkanshuaudit.id']").val();
	    function e() {
	        table.length > 0 && table.fluidGrid({
	            base: "#jqgrid-wrapper",
	            offset: 0
	        })
	    } 

	    table.length > 0 && (table.jqGrid({
	    	url: "orderauditList?renkanshuauditId=" + renkanshuauditidforfukuanaudit,
	    	mtype: "GET",
	    	datatype: "JSON",
	    	styleUI: "Bootstrap",
	    	colNames: ['上画屏幕', '类型', '开始时间', '结束时间', '时长', '频次', '状态', '操作'],
	    	shrinkToFit: true,
	    	caption: "<span style='font-size: 16px'>上画点位信息</span>&nbsp;&nbsp;&nbsp;<span class='btn btn-primary btn-sm glyphicon glyphicon-plus' id='addOrder'>添加</span>",
	    	rowNum: <s:property value="@com.nfledmedia.sorm.cons.CommonConstant@DEFAULT_PAGE_SIZE"/>,
	    	rowList: [10, 20, 30],
       		pager: "jqgrid-pager",
       		multiselect: !1,
       		//editurl: "deleteOrder.action",
       		sortname: "operTimestamp",
       		sortorder: "asc",
       		viewrecords: !0,
       		colModel: [{
       			name:"led.ledName",
       			index:"led.ledName",
       			align:"center",
       			width:"24%",
       		},{
       			name:"leixing",
       			index:"leixing",
       			align:"center",
       			width:"10%"
       		},{
       			name:"kaishishijian",
       			index:"kaishishijian",
       			align:"center",
       			width:"15%"
       		},{
       			name:"jieshushijian",
       			index:"jieshushijian",
       			align:"center",
       			width:"15%"
       		},{
       			name:"shichang",
       			index:"shichang",
       			align:"center",
       			width:"10%",
       			formatter: formatDuration,
       		},{
       			name:"pinci",
       			index: "pinci",
       			align:"center",
       			width:"8%",
       			formatter: formatFreq,
       		},{
       			name:"state",
       			index:"state",
       			align:"center",
       			width:"8%"
       		},{
       			name:"actions",
       			sortable: !1,
       			search: !1,
       			align:"center",
       			width:"15%"
       		}],
       		loadComplete: function(data){
       			orderInfo = data;
       			var ids = table.jqGrid("getDataIDs");
       			for(var i = 0; i < ids.length; i++){
       			    down = '<div class="btn btn-danger btn-xs" data-target="'+ids[i]+'" onclick="downOrder(this)">停刊</div>';
       			    up = '<div class="btn btn-primary btn-xs" data-target="'+ids[i]+'" onclick="upOrder(this)">上画</div>';
       			    edit = '<div class="btn btn-warning btn-xs" data-target="'+ids[i]+'" onclick="editOrder(this)">修改</div>';
       			    if(data.rows[i].cell[6] == "上画") {
       			    	table.jqGrid('setRowData',ids[i],{actions:down + " " + edit});
       			    } else if(data.rows[i].cell[6] == "下画") {
       			    	table.jqGrid('setRowData',ids[i],{actions:up + " " + edit});
       			    }
       			}
       		}
	    }), e(), table.length > 0 && table.jqGrid("navGrid","#jqgrid-pager",{
	    	add:!1,
	    	edit:!1,
	    	del:!1,
	    	view:!1,
	    	search: !1,
       		refresh:0
	    },{},{},{},{
	    	multipleSearch: true,
	    	multipleGroup:true
	    })),
	    $(window).resize(e);
		
		$("#downOrder-ok").click(function(){
        	if($("input[name='xiahua_jieshushijian']").val() == "") {
        		$.alert("请输入正确的结束时间！");
        	} else {
	        	$.ajax({
	        		url:"downOrderForRenkanshuaudit.action",
	        		data:$("#xiahua_form_audit").serializeArray(),
	        		type:"post",
	        		dataType:"json",
	        		success:function(data){
	        			if(data.state===0){
	        				$.dialog({
	        					title: '提示',
	        					content: data.info,
	        				});
	        			}else{
	        				alert('操作失败，未知原因');
	        			}
	        		},
	        		error:function(XMLHttpRequest, textStatus, errorThrown){
							alert('操作失败\nXMLHttpRequest.readyState['+XMLHttpRequest.readyState+']\nXMLHttpRequest.status['+XMLHttpRequest.status+']\ntextStatus['+textStatus+']');
					}
	        	})
	        	$("#downOrder-modal").modal('hide');
        	}
        });
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
		})
		
		//模态框隐藏时清空表单
		$(".modal").on('hide.bs.modal', function(){
	  		for(var i = 0; i < $(".modal form").length; i++) {
	  			$(".modal form")[i].reset();
	  			$("#editOrder-ok").off("click");
	  		}
	  		$("#editOrder-ok").off("click");
	  		$("#addOrder-ok").off("click");
		})
		
		//添加订单模态框
		$("#addOrder").click(function(){
			$("#addOrder-modal").modal('show');
			//确认添加订单
			$("#addOrder-ok").click(function(){
				if(nameValid){
					if($("select[name='ledId']").val()=="" ||
						//$("select[name='industryId']").val()=="" ||
						$("input[name='shichang']").val()=="" ||
						$("input[name='pinci']").val()=="" ||
						$("input[name='kaishishijian']").val()=="" ||
						$("input[name='jieshushijian']").val()=="" ||
						$("input[name='shuliang']").val()=="" ||
						$("input[name='guanggaoneirong']").val()=="" ||
						$("select[name='state']").val()=="")
					{
						$.alert("请将信息填写完整！");
						return;
					}
				}
				if(nameValid){
					$("input[name='renkanshuauditId']").attr("value", '<s:property value="renkanshuaudit.id"/>');
					$.ajax({
						url:"addOrderForRenkanshuaudit",
						type:"post",
						data:$("#formAddOrder").serializeArray(),
						dataType:"json",
						success:function(data){
							$.dialog({
							    title: '提示',
							    content: data.info,
							});
							$("#addOrder-modal").modal('hide');
						},
						error:function(XMLHttpRequest, textStatus, errorThrown){
							alert('保存失败\nXMLHttpRequest.readyState['+XMLHttpRequest.readyState+']\nXMLHttpRequest.status['+XMLHttpRequest.status+']\ntextStatus['+textStatus+']');
						}
					})
				}
			})
		})
		
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
