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
<link href="css/bootstrap.min.css" rel="stylesheet">
<link href="css/bootstrap-table.css" rel="stylesheet">

<link href="css/bootstrap.min.css" rel="stylesheet" media="screen">

<link rel="stylesheet" href="css/bootstrap-theme.css">

<link href="css/styles.css" rel="stylesheet">
<link href="css/laydate.css" rel="stylesheet">

<!--Icons-->
<script src="js/lumino.glyphs.js"></script>
<script src="js/jquery-1.11.1.min.js"></script>
<script src="js/bootstrap-table.js"></script>


</head>

<body style="font-family: '微软雅黑';">
	<!--/.sidebar-->
	<div class="main">

		<!--/.row-->

		<div class="row">
			<div class="col-lg-12">
				<h3 class="page-header">屏幕管理</h3>
			</div>
		</div>
		<!--/.row-->

		<div class="row">
			<div class="col-lg-12">
				<div class="panel panel-default">

					<div class="panel-body">
						<h3>
							<div id="add-pingmu" class="row">
								&nbsp;&nbsp;&nbsp;&nbsp; <a href="addpingmu.action"
									class="btn btn-link btn-lg"> <span
									class="glyphicon glyphicon-plus"></span> 添加屏幕
								</a>
							</div>
						</h3>
					</div>
				</div>

				<div class="row" style="margin-bottom:10px;">
					<div class="col-sm-3 pull-right">
						<div id="fuzzySearchbox"
							class="input-group input-group-sm searchbox">
							<input type="search" id="searchText" class="form-control"
								placeholder="请输入关键字..."> <span class="input-group-btn">
								<button class="btn btn-default" type="button" id="searchButton">搜索</button>
							</span>
						</div>
					</div>
				</div>
				<table id="jqgrid"
					class="table table-striped table-hover table-bordered"></table>
				<div id="jqgrid-pager"></div>
			</div>
		</div>
		<!--/.row-->
	</div>
	<!--/.main-->

	<script src="js/jquery-1.11.1.min.js"></script>
	<script src="js/bootstrap.min.js"></script>
	<script src="js/chart.min.js"></script>
</body>
</html>
<content tag="scripts">
<script src="js/jquery.ba-bbq.min.js"></script>
<script src="js/grid.history.js"></script>
<script src="js/grid.locale-cn.js"></script>
<script>$.jgrid.useJSON = true;</script>
<script src="js/jquery.jqGrid.min.js"></script>
<script src="js/jquery.jqGrid.fluid.js"></script>
<script src="js/king-common.js"></script> <script src="js/moment.js"></script>
<script src="js/daterangepicker.js"></script>
<script>

	function formatLed(cellvalue, options, rowObject) {
		if (cellvalue.id == null) {
			return "";
		}
		return "<a  target='_blank' href='ledUpdatePage.action?ledId=" + cellvalue.id + "'>" + cellvalue.name + "</a>";
	}

	$(document).ready(function() {
		function e() {
			$("#jqgrid").length > 0 && t.fluidGrid({
				base : "#jqgrid-wrapper",
				offset : 0
			})
		}

		var t = $("#jqgrid");
		t.length > 0 && (t.jqGrid({
			url : "pingmuguanliList.action",
			mtype : "GET",
			datatype : "json",
			colNames : [ '屏幕ID ', '屏幕代码', '屏幕名称', '安装位置', '可播时长', '典型刊例价格（60次/15秒）', '状态', '' ],
			//	    	shrinkToFit:false,
			height : 320,
			rowNum : '<s:property value="@com.nfledmedia.sorm.cons.CommonConstant@DEFAULT_PAGE_SIZE"/>',
			rowList : [ 10, 20, 30 ],
			pager : "jqgrid-pager",
			multiselect : 1,
			editurl : "deleteLed.action",
			sortname : "ledId",
			sortorder : "asc",
			viewrecords : !0,
			colModel : [ {
				name : "ledId",
				index : "ledId",
				align : "center",
				width : "50px",
			}, {
				name : "ledDaima",
				index : "ledDaima",
				align : "center",
				width : "80px",
			}, {
				name : "ledName",
				index : "ledName",
				align : "center",
				width : "100px",
				formatter : formatLed
			}, {
				name : "ledWeizhi",
				index : "ledWeizhi",
				align : "center",
				width : "110px",
			}, {
				name : "ledBofangshichang",
				sortable : !1,
				search : !1,
				align : "center",
				width : "80px"
			}, {
				name : "ledKanliprice",
				sortable : !1,
				search : !1,
				align : "center",
				width : "120px"
			}, {
				name : "state",
				index : "state",
				align : "center",
				width : "50px"
			}, {
				name : "actions",
				sortable : !1,
				search : !1,
				align : "center",
				width : "50px"
			} ],
			gridComplete : function(data) {
				var ids = $("#jqgrid").jqGrid("getDataIDs");
				for (var i = 0; i < ids.length; i++) {
					console.log(ids[i]);
					de = '<button class="btn btn-danger btn-xs" data-target="' + ids[i] + '" onclick="$(\'#jqgrid\').delGridRow(\'' + ids[i] + '\')">删除</button>';
					t.jqGrid('setRowData', ids[i], {
						actions : de
					});
				}
			}
		}), e(), $("#jqgrid").length > 0 && t.jqGrid("navGrid", "#jqgrid-pager", {
			add : !1,
			edit : !1,
			del : !0,
			view : !1,
			search : !1,
			refresh : 0
		}, {}, {}, {}, {
			multipleSearch : true,
			multipleGroup : true
		})),
		$(window).resize(e);



		//模糊搜索
		$("#searchText").keypress(function(event) {
			if (event.keyCode == "13") {
				$("#searchButton").click();
			}
		});
		$("#searchButton").click(function() {
			var searchFilter = $("#searchText").val();
			//		alert(searchFilter);
			if (searchFilter.length === 0) {
				t[0].p.search = false;
				$.extend(t[0].p.postData, {
					searchString : "",
					searchField : "",
					searchOper : ""
				});
			} else if (searchFilter == "未激活" || searchFilter == "未" || searchFilter == "未激") {
				searchFilter = " where l.state!='D' and " + " (l.ledDaima like '%" + searchFilter + "%' or l.ledName like '%" + searchFilter +
					"%' or l.ledWeizhi like '%" + searchFilter + "%' or l.state like '%" + "U" + "%')";
				console.log(searchFilter);
				t[0].p.search = true;
				$.extend(t[0].p.postData, {
					searchString : searchFilter,
					searchField : "allfieldsearch",
					searchOper : "cn"
				});
			} else {
				searchFilter = " where l.state!='D' and " + " (l.ledDaima like '%" + searchFilter + "%' or l.ledName like '%" + searchFilter +
					"%' or l.ledWeizhi like '%" + searchFilter + "%' or l.state like '%" + searchFilter + "%')";
				console.log(searchFilter);
				t[0].p.search = true;
				$.extend(t[0].p.postData, {
					searchString : searchFilter,
					searchField : "allfieldsearch",
					searchOper : "cn"
				});
			}
			t.trigger("reloadGrid", [ {
				page : 1,
				current : true
			} ]);
		});
	});
</script>
</content>
