<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
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
<link rel="stylesheet" href="css/bootstrap-select.css">


<link rel="stylesheet" href="css/bootstrap-theme.css">
<link href="css/styles.css" rel="stylesheet">
<link href="css/laydate.css" rel="stylesheet">
<!--Icons-->
<script src="js/lumino.glyphs.js"></script>
<script src="js/jqGrid4.4.3/jquery-1.7.2.min.js"></script>
<script src="js/jquery.jqGrid.fluid.js"></script>
<script src="js/bootstrap-select.js"></script>
</head>

<body style="font-family: '微软雅黑';">
	<div class="main">
		<!--/.row-->
		<div class="row">
			<div class="col-lg-12">
				<h3 class="page-header">收款录入</h3>
			</div>
		</div>
		<!--/.row-->
		<div class="row">
			<div class="col-lg-12">
				<div id="jqgrid-wrapper">
					<div class="col-sm-3">
						<div class="input-group input-group-sm">
							<div class="input-group-addon">刊户</div>
							<select name="client" id="client" class="form-control selectpicker" data-live-search="true">
								<option value="">--请选择刊户--</option>
							</select>
						</div>
					</div>

					<div class="col-sm-2 pull-right">
						<button class="btn btn-primary btn-sm" id="queryContract">查询认刊书（合同）</button>
					</div>

					<form id="contracts" name="contracts" action="collectionInput2" method="post">
						<div class="col-lg-12">
							<div class="col-lg-12"></div>
							<table id="contractToSelect" class="table table-striped table-hover table-bordered"></table>
							<div id="jqgrid-pager"></div>
							<div>
								<button class="btn btn-primary btn-sm" id="collectionInput">录入收款</button>
							</div>
						</div>
					</form>

				</div>
			</div>
		</div>
	</div>
	<script src="js/jqGrid4.4.3/jquery-1.7.2.min.js"></script>
	<script src="js/jquery-ui.js"></script>
	<script src="js/bootstrap.min.js"></script>
</body>
</html>

<content tag="scripts">
<script src="js/jquery.ba-bbq.min.js"></script>
<script src="js/grid.history.js"></script>
<script src="js/grid.locale-cn.js"></script>
<script>$.jgrid.useJSON = true;</script>
<script src="js/jqGrid4.4.3/jquery.jqGrid.src.js"></script>
<script src="js/jquery.jqGrid.fluid.js"></script>
<script src="js/jqGrid4.4.3/plugins/grid.setcolumns.js"></script>
<script src="js/jqGrid4.4.3/plugins/grid.jqueryui.js"></script>
<script src="js/king-common.js"></script>
<script type="text/javascript">
		/* var contractId;		//认刊书（合同）编号 */
		var salesmanId;		//业务员
		var salesmanName;		//业务员
		var signDate;		//签订日期
		var client;			//刊户
		var renkanshuId;	//认刊书编号
		
		var isSelected = false;
		
		function loadClients(){	 
			$("#client").append("<s:iterator value="#request.clients">");
		    $("#client").append("<option value='<s:property value="[0].top[1]"/>'><s:property value="[0].top[1]"/></option>");
		    $("#client").append("</s:iterator>");
		}
		
		var table = $("#contractToSelect");
		
		function e(){
			$("#contractToSelect").length > 0 && table.fluidGrid({
				base: "#jqgrid-wrapper",
				offset: 0
			})
		}
		
		$("#collectionInput").click(function(){
			var form = $("#contracts");
			var clientInput = $("<input type='hidden' name='client'/>");  
			var salesmanIdInput = $("<input type='hidden' name='salesmanId'/>"); 
			var salesmanNameInput = $("<input type='hidden' name='salesmanName'/>"); 
			var signDateInput = $("<input type='hidden' name='signDate'/>");
			var renkanshuIdInput = $("<input type='hidden' name='renkanshuId'/>");
			
		    clientInput.attr('value', client);
		    salesmanIdInput.attr('value', salesmanId);
		    salesmanNameInput.attr('value', salesmanName);
		    var newDate=/\d{4}-\d{1,2}-\d{1,2}/g.exec(signDate)	//去掉日期的时分秒
		    signDateInput.attr('value', newDate);
		    renkanshuIdInput.attr('value', renkanshuId);
		    
		    // 附加到Form  
		    form.append(clientInput);
		    form.append(salesmanIdInput);
		    form.append(salesmanNameInput);
		    form.append(signDateInput);
		    form.append(renkanshuIdInput);
		    
		    // 提交表单 
		    if(isSelected){
		    	form.submit();
		    }else{
		    	alert("请选择要录入收款的项目！")
		    }
		      
		    // 注意return false取消链接的默认动作  
		    return false;  
		})
		/* {
			$.ajax({
				type:"POST", 
				url:"collectionInput2.action", 
				data:{"contractId": contractId, "client": client, "salesman": salesman, "signDate": signDate}, //要传的值 
				success:function(data){ 
					alert("success"); 
				},
				complete:function(){
					location.href ="collectionInput2.action";
					location.href ="collectionInput2.action"+"?client="+client+"&contractId="+contractId+"&salesman="+salesman+"&signDate="+signDate; 
				}//跳转页面
			}); 
		} */
		
		$(function(){
			loadClients();
			
			$("#queryContract").click(function(){
				var client = $("#client").val(); 
		    	console.log(client);
		    	$.extend(table[0].p.postData,{client: client});
		    	table.trigger("reloadGrid",[{page:1,current:true}]); 
		    	return false;
			});
			
			
		    $("#contractToSelect").length > 0 && (table.jqGrid({
				url: "getContracts.action",
		    	mtype: "POST",
		    	datatype: "json",
		    	colNames: ['','项目类型','合同/认刊书编号','刊户','签订时间','承办人',''],
				//shrinkToFit:false,
		    	height: 400,
		    	rowNum:<s:property value="@com.nfledmedia.sorm.cons.CommonConstant@DEFAULT_PAGE_SIZE"/>,
		    	rowList: [10, 20, 30],
	       		pager: "jqgrid-pager",
	       		multiselect: !1,
	       		/* editurl:"deleteOrder.action", */
	       		//sortname:"shichang",
	       		sortorder: "asc",
	       		viewrecords: !0,
	       		colModel: [{ 
                	name: "MY_ID",
	                index: "MY_ID",
	                sortable: false,
	                align: "center",
	                width: "5%",
                	formatter: function(cellvalue, options, rowObject){
                    	return "<input type='radio' name='contractId' value='" + cellvalue + "' onclick=\"radioSelect('contractId', 'listTable')\" />";
                	}
            	},{
	       			name: "itemType",
	       			index: "itemType",
	       			align: "center",
	       	 		width: "20%"
	       		},{
	       			name: "contractId",
	       			index: "contractId",
	       			align: "center",
	       	 		width: "20%"
	       		},{
	       			name: "client",
	       			index: "client",
	       			align: "center",
	       			width: "30%"
	       				
	       		},{
	       			name: "signDate",
	       			index: "signDate",
	       			align: "center",
	       			width: "20%" 
	       				
	       		},{
	       			name: "salesmanName",
	       			index: "salesmanName",
	       			align: "center",
	       			width: "20%"
	       		},{
	       			name: "salesmanId",
	       			index: "salesmanId",
	       			align: "center",
	       			width: "20%",
	       			hidden: true
	       		}],
	       		onSelectRow: function(ids) {
                	$($(this)[0]).find("input[name='contractId']")[ids - 1].checked = true;
                	var rowData = $("#contractToSelect").jqGrid("getRowData", ids);
                	client = rowData.client;
                	salesmanId = rowData.salesmanId;
                	salesmanName = rowData.salesmanName;
                	signDate = rowData.signDate;
                	var seldata = rowData.itemType;
            		if("认刊书" == seldata){
            			renkanshuId = rowData.contractId;
            		}
                	isSelected = true;
             	}
			 }), e(), $("#contractToSelect").length > 0 && table.jqGrid("navGrid","#jqgrid-pager",{
			    	add: !1,
			    	edit: !1,
			    	del: !1,
			    	view: !1,
			    	search: !1,
	        		refresh: 0
			    },{},{},{},{
			    	multipleSearch: true,
			    	multipleGroup: true
			    })),
			    $(window).resize(e);
		});
	</script>
</content>
