$(document).ready(function(){
	$("#addContact").click(function(){
		$("#contactsView").append("<table id='jqgrid-addFirst' class='table table-striped table-hover' ></table>" +
				"<div id='jqgrid-pager-addFirst'></div>"+
				'<button type="button" class="btn btn-danger btn-sm" data-target="#c{row_index}" onclick="deleteB(this);">删除</button>');
		
		function e() {
		    $("#jqgrid-addFirst").length > 0 && t1.fluidGrid({
		        base: "#jqgrid-wrapper",
		        offset: 0
		    })
		} 
		
		 var t1= $("#jqgrid-addFirst");
		    $("#jqgrid-addFirst").length > 0 && (t1.jqGrid({
		    	url:"yewulist.action",
		    	mtype:"GET",
		    	datatype:"json",
		    	colNames:['id','认刊编号','行业','刊户','类型','业务员','屏幕','时长','频次','开始时间','结束时间','数量','刊例价效绩','时段'],
		    	shrinkToFit:false,
		    	height:320,
		    	rowNum:10,
		    	rowList: [10, 20, 30],
     		pager: "jqgrid-pager-addFirst",
     		multiselect: !1,
     		sortname:"yewuId",
     		sortorder: "asc",
     		viewrecords: !0,
     		colModel:[{
     			name:"yewuId",
     			index:"yewuId",
     			sortable:!1,
     			search:!1,
     			align:"center",
     	 		width:"40px", 
     		},{
     			name:"renkanshu.renkanbianhao",
     			index:"renkanshu.renkanbianhao",
     			align:"center",
     	 		width:"120px",  
     			formatter:formatRenkanbianhao
     		},{
     			name:"renkanshu.hangye.hangyename",
     			index:"renkanshu.hangye.hangyename",
     			align:"center",
     	 		width:"150px"
     		},{
     			name:"kanhu",
     			index:"kanhu",
     			align:"center",
     			width:"100px" 
     		},{
     			name:"leixing",
     			index:"leixing",
     			align:"center",
     			width:"100px"
     		},{
     			name:"yewuyuan.username",
     			index:"yewuyuan.username",
     			align:"center",
     			width:"100px",
     			formatter:formatYewuyuan
     		},{
     			name:"led.ledName",
     			index:"led.ledName",
     			align:"center",
     			width:"100px",
     			formatter:formatLed
     		},{
     			name:"shichang",
     			index:"shichang",
     			align:"center",
     			width:"80px" 
     		},{
     			name:"pinci",
     			sortable: !1,
     			search: !1,
     			align:"center",
     			width:"80px"
     		},{
     			name:"kaishishijian",
     			sortable: !1,
     			search: !1,
     			align:"center",
     			width:"100px"
     		},{
     			name:"jieshushijian",
     			sortable: !1,
     			search: !1,
     			align:"center",
     			width:"100px" 
     		},{
     			name:"shuliang",
     			sortable: !1,
     			search: !1,
     			align:"center",
     			width:"80px" 
     		},{
     			name:"kanlijiaxiaoji",
     			sortable: !1,
     			search: !1,
     			align:"center",
     			width:"80px" 
     		},{
     			name:"shiduan",
     			sortable: !1,
     			search: !1,
     			align:"center",
     			width:"100px"
     		}],
     		gridComplete: function(data){
     			var ids = $("#jqgrid-addFirst").jqGrid("getDataIDs");
     		}
		    }), e(), $("#jqgrid-addFirst").length > 0 && t1.jqGrid("navGrid","#jqgrid-pager-addFirst",{
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
	})
})
