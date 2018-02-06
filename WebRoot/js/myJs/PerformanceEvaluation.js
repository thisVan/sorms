$(document).ready(function(){
	function e_performance_evaluation() {
		        $("#jqgrid_performance_evaluation").length > 0 && t_performance_evaluation.fluidGrid({
		            base: "#jqgrid-wrapper_performance_evaluation",
		            offset: 0
		        })
		    } 
		    var t_performance_evaluation= $("#jqgrid_performance_evaluation");
		    $("#jqgrid_performance_evaluation").length > 0 && (t_performance_evaluation.jqGrid({
		    	url:"ywyyejilist.action",
		    	mtype:"GET",
		    	datatype:"json",
		    	colNames:['部门','业务员','1月','2月','3月','4月','5月','6月','7月','8月','9月','10月','11月','12月','合计','全年目标','完成比例'],
		    	shrinkToFit:false,
		    	height:400,
		    	rowNum:10,
		    	rowList: [10, 20, 30],
        		pager: "jqgrid-pager_performance_evaluation",
        		multiselect:!1,
        		sortname:"goalId",
        		sortorder: "asc",
        		viewrecords: !0,
        		colModel:[{
        			name:"goalYwy.bumen.bmMingcheng",
        			index:"goalYwy.bumen.bmMingcheng",
        			search:!1,
        			align:"center",
        	 		width:"100px", 
        		},{
        			name:"goalYwy.ywyXingming",
        			index:"goalYwy.ywyXingming",
        			align:"center",
        	 		width:"80px"    		
        		},{
        			name:"Jan",
        			index:"Jan",
        			sortable:!1,
        			align:"center",
        	 		width:"70px"
        		},{
        			name:"Feb",
        			index:"Feb",
        			sortable:!1,
        			align:"center",
        			width:"70px" 
        		},{
        			name:"Mar",
        			index:"Mar",
        			sortable:!1,
        			align:"center",
        			width:"70px"
        		},{
        			name:"Apr",
        			index:"Apr",
        			sortable:!1,
        			align:"center",
        			width:"70px"
        		},{
        			name:"May",
        			index:"May",
        			sortable:!1,
        			align:"center",
        			width:"70px"       			
        		},{
        			name:"Jun",
        			index:"Jun",
        			sortable:!1,
        			align:"center",
        			width:"70px" 
        		},{
        			name:"Jul",
        			sortable: !1,
        			align:"center",
        			width:"70px"
        		},{
        			name:"Aug",
        			sortable: !1,
        			align:"center",
        			width:"70px"
        		},{
        			name:"Sep",
        			sortable: !1,
        			align:"center",
        			width:"70px" 
        		},{
        			name:"Oct",
        			sortable: !1,
        			align:"center",
        			width:"70px" 
        		},{
        			name:"Nov",
        			sortable: !1,
        			align:"center",
        			width:"70px" 
        		},{
        			name:"Dec",
        			sortable: !1,
        			align:"center",
        			width:"70px"
        		},{
        			name:"total",
        			sortable: !1,
        			align:"center",
        			width:"80px"
        		},{
        			name:"goalMubiao",
        			sortable: !1,
        			align:"center",
        			width:"100px"
        		},{
        			name:"ratio",
        			sortable: !1,
        			align:"center",
        			width:"100px"
        		}],
        		gridComplete: function(data){}
		    }), e_performance_evaluation(), $("#jqgrid_performance_evaluation").length > 0 && t_performance_evaluation.jqGrid("navGrid","#jqgrid-pager_performance_evaluation",{
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
		    $(window).resize(e_performance_evaluation);	
		    
		  //模糊搜索
		    $("#searchText3").keypress(function(event){
		    	if(event.keyCode == "13"){
		    		$("#searchButton3").click();
		    	}
		    });
		    
		    $("#searchButton3").click(function(){
				var searchFilter = $("#searchText3").val();
				var annualYeji=$.trim($("#annualYeji").val());
//				alert(annualYeji);
		    	if(searchFilter.length !== 0){
		    		t_performance_evaluation[0].p.search = false; 
		    		$.extend(t_performance_evaluation[0].p.postData,{searchString:"",searchField:"",searchOper:""});
			    	searchFilter = " and ( y.goalYwy.bumen.bmMingcheng like '%"+searchFilter+"%' or y.goalYwy.ywyXingming like '%"+searchFilter+"%' )";
		    		console.log(searchFilter);
		    		t_performance_evaluation[0].p.search = true;
		    		$.extend(t_performance_evaluation[0].p.postData,{annualYeji:annualYeji,searchString:searchFilter,searchField:"allfieldsearch",searchOper:"cn"});
		    	}
		    	t_performance_evaluation.trigger("reloadGrid",[{page:1,current:true}]);
		    });
		
		  //导出报表功能
			$("#exportExcel3").click(function(){
				$("#jqgrid_performance_evaluation").jqGrid('excelExport',{url:'ywyyejilistExport.action'})
			});
});

function AnnualPerformanceSelect(){
	var t_performance_evaluation= $("#jqgrid_performance_evaluation");
	var annualYeji=$.trim($("#annualYeji").val());
//	alert(annualYeji);
	t_performance_evaluation[0].p.search = true;
	$.extend(t_performance_evaluation[0].p.postData,{annualYeji:annualYeji,searchString:"",searchField:"allfieldsearch",searchOper:"cn"});
	t_performance_evaluation.trigger("reloadGrid",[{page:1,current:true}]);
	return false;
}
$(function(){
	AnnualPerformanceSelect()
});