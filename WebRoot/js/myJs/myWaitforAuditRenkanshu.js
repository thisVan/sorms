$(document).ready(function(){
	function e_waitForAudit() {
	    $("#jqgrid_waitForAudit").length > 0 && t_waitForAudit.fluidGrid({
	            base: "#jqgrid-wrapper_waitForAudit",
	            offset: 0
	        })
	    } 
	    var t_waitForAudit= $("#jqgrid_waitForAudit");
	    $("#jqgrid_waitForAudit").length > 0 && (t_waitForAudit.jqGrid({
	    	url:"myRenkanshuWaitForAuditList.action",
	    	mtype:"GET",
	    	datatype:"json",
	    	colNames:['认刊编号','广告刊户','广告代理公司','签订日期','操作类型',''],
	    	shrinkToFit:true,
	    	height:360,
	    	width:800,
	    	rowNum:10,
	    	rowList: [10, 20, 30],
			pager: "jqgrid-pager_waitForAudit",
			multiselect:!1,
			sortname:"operTimestamp",
			sortorder: "asc",
			viewrecords: !0,
			colModel:[{
				name:"renkanbianhao",
				sortable: 1,
				search: !1,
				align:"center",
				width:"120px" 
			},{
				name:"guangaokanhu",
				sortable: 1,
				search: !1,
				align:"center",
				width:"150px" 
			},{
				name:"guanggaodailigognsi",
				sortable: 1,
				search: !1,
				align:"center",
				width:"150px" 
			},{
				name:"qiandingriqi",
				sortable: 1,
				search: !1,
				align:"center",
				width:"80px" 
			},{
				name:"operType",
				sortable: 1,
				search: !1,
				align:"center",
				width:"50px"
			},{
				name:"actions",
				sortable: !1,
				search: !1,
				align:"center",
				width:"50px"
			}],
			loadComplete: function(data){
				var ids = $("#jqgrid_waitForAudit").jqGrid("getDataIDs");
				for(var i=0;i < ids.length;i++){
					console.log(ids[i]);
					var rowData = $("#jqgrid_waitForAudit").jqGrid('getRowData',ids[i]);
					var operType= rowData.operType; //获取某行的operType值
					console.log(operType);
					if("添加"==operType){
						myAdd_update = '<button class="btn btn-primary btn-xs" data-target="'+ids[i]+'" onclick="myAddRenkanshuaudit(this)">修改</button>';
						t_waitForAudit.jqGrid('setRowData',ids[i],{actions:myAdd_update});
					}else{
						update = '<button class="btn btn-primary btn-xs" data-target="'+ids[i]+'" onclick="myUpdateRenkanshuaudit(this)">修改</button>';
						t_waitForAudit.jqGrid('setRowData',ids[i],{actions:update});
					}
				}
                $("li#wait4Audit a span").addClass("badge");
                $("li#wait4Audit a span")[0].innerHTML = data.records;
			}
	    }), e_waitForAudit(), $("#jqgrid_waitForAudit").length > 0 && t_waitForAudit.jqGrid("navGrid","#jqgrid-pager_waitForAudit",{
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
	    $(window).resize(e_waitForAudit);	
	
	    
	  //模糊搜索
	    $("#searchText2").keypress(function(event){
	    	if(event.keyCode == "13"){
	    		$("#searchButton2").click();
	    	}
	    });   
});
function myAddRenkanshuaudit(target){
	var target =$(target).data("target");
	if(target==null||target==""){
		return;
	}
	$("input[name='renkanshuaudit.id']").val(target);
	$("#updateMyAddRenkanshuForm").submit();
}
function myUpdateRenkanshuaudit(target){
	var target =$(target).data("target");
	if(target==null||target==""){
		return;
	}
	$("input[name='renkanshuaudit.id']").val(target);
	$("#updateMyRenkanshuForm").submit();
}