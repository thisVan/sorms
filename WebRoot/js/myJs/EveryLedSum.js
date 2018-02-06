$(document).ready(function(){
	function e_EveryLed_sum() {
		        $("#jqgrid_EveryLed_sum").length > 0 && t_EveryLed_sum.fluidGrid({
		            base: "#jqgrid-wrapper_EveryLed_sum",
		            offset: 0
		        })
		    } 
		    var t_EveryLed_sum= $("#jqgrid_EveryLed_sum");
		    $("#jqgrid_EveryLed_sum").length > 0 && (t_EveryLed_sum.jqGrid({
		    	url:"getLedSum.action",
		    	mtype:"GET",
		    	datatype:"json",
		    	colNames:['屏幕','收入合计'],
		    	shrinkToFit:true,
		    	height:360,
		    	width:800,
		    	rowNum:10,
		    	rowList: [10, 20, 30],
        		pager: "jqgrid-pager_EveryLed_sum",
        		multiselect:!1,
        		sortname:"y.led.ledId",
        		sortorder: "asc",
        		viewrecords: !0,
        		colModel:[{
        			name:"y.led.ledName",
        			index:"y.led.ledName",
        	//		sortable: !1,
        			align:"center",
        	 		width:"120px"    		
        		},{
        			name:"sum(y.totalpublishprice)",
        			index:"sum(y.totalpublishprice)",
        			align:"center",
        			width:"100px"
        		}],
        		gridComplete: function(data){}
		    }), e_EveryLed_sum(), $("#jqgrid_EveryLed_sum").length > 0 && t_EveryLed_sum.jqGrid("navGrid","#jqgrid-pager_EveryLed_sum",{
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
		    $(window).resize(e_EveryLed_sum);	
		
		    
		  //模糊搜索
		    $("#searchText2").keypress(function(event){
		    	if(event.keyCode == "13"){
		    		$("#searchButton2").click();
		    	}
		    });
		    
		    $("#searchButton2").click(function(){
				var searchFilter = $("#searchText2").val();
			    	if(searchFilter.length !== 0){
			    		t_EveryLed_sum[0].p.search = false; 
			    		$.extend(t_EveryLed_sum[0].p.postData,{searchString:"",searchField:"",searchOper:""});
				    	searchFilter = " and y.state!='D' and "+" ( y.led.ledName like '%"+searchFilter+"%' )";
			    		console.log(searchFilter);
			    		t_EveryLed_sum[0].p.search = true;
			    		$.extend(t_EveryLed_sum[0].p.postData,{searchString:searchFilter,searchField:"allfieldsearch",searchOper:"cn"});
			    	}
			    	t_EveryLed_sum.trigger("reloadGrid",[{page:1,current:true}]);
		    });
		    
		  //导出报表功能
			$("#exportExcel2").click(function(){
				$("#jqgrid_EveryLed_sum").jqGrid('excelExport',{url:'ledSumListExport.action'})
			});

});

function AnnualLedSumSelect(){
	var t_EveryLed_sum= $("#jqgrid_EveryLed_sum");
	annualLedSum=$.trim($("#annualLedSum").val());
//	alert(annualYeji);
	t_EveryLed_sum[0].p.search = true;
	$.extend(t_EveryLed_sum[0].p.postData,{annualLedSum:annualLedSum,searchString:"",searchField:"allfieldsearch",searchOper:"cn"});
	t_EveryLed_sum.trigger("reloadGrid",[{page:1,current:true}]);
	return false;
}
$(function(){
	AnnualLedSumSelect()
});