$(document).ready(function(){
	function e_industry_annual_sort() {
		        $("#jqgrid_industry_annual_sort").length > 0 && t_industry_annual_sort.fluidGrid({
		            base: "#jqgrid-wrapper_industry_annual_sort",
		            offset: 0
		        })
		    } 
		    var t_industry_annual_sort= $("#jqgrid_industry_annual_sort");
		    $("#jqgrid_industry_annual_sort").length > 0 && (t_industry_annual_sort.jqGrid({
		    	url:"getTop10_annual_Led_Occupy.action",
		    	mtype:"GET",
		    	datatype:"json",
		    	colNames:['行业','1月','2月','3月','4月','5月','6月','7月','8月','9月','10月','11月','12月','合计'],
		    	shrinkToFit:false,
		    	height:350,
		    	rowNum:10,
		    	rowList: [10, 20, 30],
        		pager: "jqgrid-pager_industry_annual_sort",
        		multiselect:!1,
        		sortname:"renkanshu.qiandingriqi",
        		sortorder: "asc",
        		viewrecords: !0,
        		colModel:[{
        			name:"goalYwy.ywyXingming",
        			index:"goalYwy.ywyXingming",
        			sortable: !1,
        			align:"center",
        	 		width:"110px"    		
        		},{
        			name:"Jan",
        			sortable: !1,
        			align:"center",
        	 		width:"70px"
        		},{
        			name:"Feb",
        			sortable: !1,
        			align:"center",
        			width:"70px" 
        		},{
        			name:"Mar",
        			sortable: !1,
        			align:"center",
        			width:"70px"
        		},{
        			name:"Apr",
        			sortable: !1,
        			align:"center",
        			width:"70px"
        		},{
        			name:"May",
        			sortable: !1,
        			align:"center",
        			width:"70px"       			
        		},{
        			name:"Jun",
        			sortable: !1,
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
        		}],
        		gridComplete: function(data){}
		    }), e_industry_annual_sort(), $("#jqgrid_industry_annual_sort").length > 0 && t_industry_annual_sort.jqGrid("navGrid","#jqgrid-pager_industry_annual_sort",{
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
		    $(window).resize(e_industry_annual_sort);	
		    
		    
		  //导出报表功能
			$("#exportExcel1-1").click(function(){
				$("#jqgrid_industry_annual_sort").jqGrid('excelExport',{url:'industryAnnualOccupyExport.action'})
			});
			
		    function e_industry_annual_sort2() {
		        $("#jqgrid_industry_annual_sort2").length > 0 && t_industry_annual_sort2.fluidGrid({
		            base: "#jqgrid-wrapper_industry_annual_sort2",
		            offset: 0
		        })
		    } 
		    var t_industry_annual_sort2= $("#jqgrid_industry_annual_sort2");
		    $("#jqgrid_industry_annual_sort2").length > 0 && (t_industry_annual_sort2.jqGrid({
		    	url:"getTop10_annual_Led_Sum.action",
		    	mtype:"GET",
		    	datatype:"json",
		    	colNames:['行业','1月','2月','3月','4月','5月','6月','7月','8月','9月','10月','11月','12月','合计'],
		    	shrinkToFit:false,
		    	height:350,
		    	rowNum:10,
		    	rowList: [10, 20, 30],
        		pager: "jqgrid-pager_industry_annual_sort2",
        		multiselect:!1,
        		sortname:"renkanshu.qiandingriqi",
        		sortorder: "asc",
        		viewrecords: !0,
        		colModel:[{
        			name:"goalYwy.ywyXingming",
        			sortable: !1,
        			align:"center",
        	 		width:"120px"    		
        		},{
        			name:"Jan",
        			sortable: !1,
        			align:"center",
        	 		width:"80px"
        		},{
        			name:"Feb",
        			sortable: !1,
        			align:"center",
        			width:"80px" 
        		},{
        			name:"Mar",
        			sortable: !1,
        			align:"center",
        			width:"80px"
        		},{
        			name:"Apr",
        			sortable: !1,
        			align:"center",
        			width:"80px"
        		},{
        			name:"May",
        			sortable: !1,
        			align:"center",
        			width:"80px"       			
        		},{
        			name:"Jun",
        			sortable: !1,
        			align:"center",
        			width:"80px" 
        		},{
        			name:"Jul",
        			sortable: !1,
        			align:"center",
        			width:"80px"
        		},{
        			name:"Aug",
        			sortable: !1,
        			align:"center",
        			width:"80px"
        		},{
        			name:"Sep",
        			sortable: !1,
        			align:"center",
        			width:"80px" 
        		},{
        			name:"Oct",
        			sortable: !1,
        			align:"center",
        			width:"80px" 
        		},{
        			name:"Nov",
        			sortable: !1,
        			align:"center",
        			width:"80px" 
        		},{
        			name:"Dec",
        			sortable: !1,
        			align:"center",
        			width:"80px"
        		},{
        			name:"total",
        			sortable: !1,
        			align:"center",
        			width:"100px"
        		}],
        		gridComplete: function(data){}
		    }), e_industry_annual_sort2(), $("#jqgrid_industry_annual_sort2").length > 0 && t_industry_annual_sort2.jqGrid("navGrid","#jqgrid-pager_industry_annual_sort2",{
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
		    $(window).resize(e_industry_annual_sort2);	
		
		    //导出报表功能
			$("#exportExcel1-2").click(function(){
				$("#jqgrid_industry_annual_sort2").jqGrid('excelExport',{url:'industryAnnualSumExport.action'})
			});
});

function AnnualIndustrySelectClick(){
	var t_industry_annual_sort= $("#jqgrid_industry_annual_sort");
	var t_industry_annual_sort2= $("#jqgrid_industry_annual_sort2");
	annualIndustry=$.trim($("#annualIndustry").val());
	annualIndustry1=$.trim($("#annualIndustry1").val());
//	alert(annualIndustry);
	t_industry_annual_sort[0].p.search = true;
	t_industry_annual_sort2[0].p.search = true;
	$.extend(t_industry_annual_sort[0].p.postData,{annualIndustry:annualIndustry,searchString:"",searchField:"allfieldsearch",searchOper:"cn"});
	$.extend(t_industry_annual_sort2[0].p.postData,{annualIndustry:annualIndustry1,searchString:"",searchField:"allfieldsearch",searchOper:"cn"});
	t_industry_annual_sort.trigger("reloadGrid",[{page:1,current:true}]);
	t_industry_annual_sort2.trigger("reloadGrid",[{page:1,current:true}]);
	return false;
}

$(function(){
	AnnualIndustrySelectClick()
});