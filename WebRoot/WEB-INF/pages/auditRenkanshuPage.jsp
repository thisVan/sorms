<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="com.google.gson.*"%>
<%@ page import="java.sql.*"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> 
<!DOCTYPE html>
<html>
<head>
<link rel="icon" href="images/logo.png" type="image/x-icon" />
<link rel="shortcut icon" href="images/logo.png" type="image/x-icon" />
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<link href="css/bootstrap.min.css" rel="stylesheet" media="screen">
<link href="css/jquery-ui.min.css" rel="stylesheet" media="screen">
<link href="css/jquery-ui.structure.min.css" rel="stylesheet" media="screen">
<link href="css/jquery-ui.theme.min.css" rel="stylesheet" media="screen">
<link href="css/styles.css" rel="stylesheet">
<!--Icons-->
<script src="js/lumino.glyphs.js"></script>
</head>
<body style="font-family: '微软雅黑';">
    <div class="main">
        <!--/.row-->
        <div class="row">
            <div class="col-lg-12">
                <h3 class="page-header"> 认刊书审核</h3>
            </div>
        </div>
        <!--/.row-->
       
        <div class="row">
            <form class="form-horizontal" role="form" id="form_save">
            <div class="col-lg-12">
                      <input  class="form-control hidden" name="ids" id="ids" value='<s:property value="orderIds"/>' />
                      <input  class="form-control hidden" name="renkanshuaudit_id" id="renkanshuaudit_id" value='<s:property value="renkanshuaudit.id"/>' />
                  
                            <div class="col-lg-12">
                                <div class="form-group form-inline col-md-12 col-lg-6 ">
                                    <label style="width: 24%; text-align:left;" for="dtp_input2"
                                        class="control-label">签订日期<span class="text-danger">*</span></label>
                                    <input type="date" id="dtp_input2"
                                        name="renkanshu.qiandingriqi" value='<s:property value="qiandingriqi"/>' class="form-control" disabled/>
                                </div>
                                <div class="form-group form-inline col-md-12 col-lg-6 ">
                                    <label style="width: 24%; text-align:left;" class="control-label"
                                        for="selectyewuyuan">业务员<span class="text-danger">*</span></label>
                                    <input id="yewuyuans"name="yewuyuan" value='<s:property value="yewuyuan"/>' class="form-control " disabled/>
                                </div>
                                <div class="form-group form-inline col-md-12 col-lg-6 ">
                                    <label style="width: 24%; text-align:left;" class="control-label"
                                        for="renkanshubianhao">认刊书编号<span class="text-danger">*</span></label>
                                    <input id="renkanshubianhao" class="form-control"
                                        name="renkanshu.renkanbianhao" value='<s:property value="renkanshuaudit.renkanbianhao" />' disabled/>
                                </div>
                                <div class="form-group form-inline col-md-12 col-lg-6 ">
                                    <label style="width: 24%; text-align:left;" class="control-label"
                                        for="hetongbianhao">合同编号</label> 
                                        <input id="hetongbianhao" class="form-control" value='<s:property value="renkanshuaudit.hetongbianhao" />'
                                        name="renkanshu.hetongbianhao"  disabled/>
                                </div>
                                
                                <div class="form-group form-inline col-md-12 col-lg-6 ">
                                    <label style="width: 24%; text-align:left;" class="control-label"
                                        for="baogaobianhao">报告编号</label> 
                                    <input id="baogaobianhao" class="form-control" value='<s:property value="renkanshuaudit.baogaobianhao" />'
                                        name="renkanshu.baogaobianhao"  disabled/>
                                </div>
                                
                                <div class="form-group form-inline col-md-12 col-lg-6 ">
                                    <label style="width: 24%; text-align:left;" class="control-label"
                                        for="guangaokanhu">广告客户（全称）<span class="text-danger">*</span></label>
                                    <input id="guangaokanhu" class="form-control" value='<s:property value="renkanshuaudit.guangaokanhu" />'
                                        name="renkanshu.guangaokanhu"  disabled/>
                                </div>
                                <div class="form-group form-inline col-md-12 col-lg-6 ">
                                    <label style="width: 24%; text-align:left;" class="control-label"
                                        for="guanggaodailigongsi">广告代理公司（全称）</label> 
                                    <input id="guanggaodailigongsi" class="form-control" value='<s:property value="renkanshuaudit.guanggaodailigongsi" />'
                                        name="renkanshu.guanggaodailigongsi"  disabled/>
                                </div>
                                <div class="form-group form-inline col-md-12 col-lg-6 ">
                                    <label style="width: 24%; text-align:left;" class="control-label"
                                        for="agencymode">直客或代理</label> 
                                    <input id="agencymode" class="form-control" value='<s:property value="renkanshuaudit.agencymode" />'
                                        name="renkanshuaudit.agencymode"  disabled/>
                                </div>
                                <div class="form-group form-inline col-md-12 col-lg-6 ">
                                    <label style="width: 24%; text-align:left;" class="control-label"
                                        for="guanggaohangye">广告所属行业<span class="text-danger">*</span></label>
                                    <input id="industryDesc" class="form-control" value='<s:property value="renkanshuaudit.industry.industryDesc" />'
                                        name="renkanshu.industry.industryDesc"  disabled/>
                                </div>
                                <div class="form-group col-md-6 col-lg-12 ">
                                    <label class="control-label" for="baogaobianhao" style=" text-align:left;">广告内容（品牌、产品）<span
                                        class="text-danger">*</span></label>
                                    <input id="guanggaoneirong" name="renkanshu.guanggaoneirong" value='<s:property value="renkanshuaudit.guanggaoneirong" />'
                                        class="form-control " rows="3" disabled></input>
                                </div>
                            
                            
                                <div class="form-group form-inline col-md-12 col-lg-6">
                                    <label style="width: 24%; text-align:left;" class="control-label" for="gaojianlaiyuan">稿件来源</label>
                                    <input id="renkanshu.gaojianlaiyuan" class="form-control" value='<s:property value="renkanshuaudit.gaojianlaiyuan" />'
                                        name="renkanshu.gaojianlaiyuan"  disabled/>
                                </div>
                                <div class="form-group form-inline col-md-12 col-lg-6">
                                    <label style="width: 24%; text-align:left;" class="control-label" for="gaojianleibie">稿件类别</label>
                                    <input id="renkanshu.gaojianleibie" class="form-control" value='<s:property value="renkanshuaudit.gaojianleibie" />'
                                        name="renkanshu.gaojianleibie"  disabled/>
                                </div>
                                
                                <div class="col-1g-12">
                                    <div class="col-md-6 form-group form-inline">
                                        <label style="width: 24%; text-align:left;" for="kanlizongjia">刊例合计(元)</label> 
                                        <input class="form-control" id="kanlizongjia" readonly="true"
                                            value='<fmt:formatNumber type="number" pattern=",##0.00" value="${renkanshuaudit.advertisingintenttotal}" /> ' />
                                    </div>
                                    <div class="col-md-6 form-group form-inline">
                                        <label style="width: 24%; text-align:left;" for="kanliheji">实付金额(元)</label> 
                                        <input class="form-control" id="kanliheji" readonly="true"
                                            value='<fmt:formatNumber type="number" pattern=",##0.00" value="${renkanshuaudit.advertisingintentcomein}" /> ' />
                                    </div>
                                    <div class="col-md-6 form-group form-inline">
                                        <label style="width: 24%; text-align:left;" for="purchasecost">外购成本(元)</label> 
                                        <input class="form-control" id="purchasecost" readonly="true"
                                            value='<fmt:formatNumber type="number" pattern=",##0.00" value="${renkanshuaudit.purchasecost}" />' />
                                    </div>
                                    <div class="col-md-6 form-group form-inline">
                                        <label style="width: 24%; text-align:left;" for="cankaozhekou">折扣(单位/折)</label>
                                        <input class="form-control" id="zhekou" readonly="true"
                                            value='<fmt:formatNumber type="number" pattern=",##0.00" value="${renkanshuaudit.zhekou * 10}" />' />
                                    </div>
                                </div>
                                <div class="form-group col-md-12 col-lg-12 ">
                                    <label class="control-label" for="renkanshubeizhu" style=" text-align:left;">备注</label>
                                    <input id="renkanshubeizhu" name="renkanshuaudit.renkanshubeizhu"
                                        class="form-control" rows="2" value='<s:property value="renkanshuaudit.renkanshubeizhu"/>' disabled></input>
                                </div>
                                
                                <div  class="form-group col-md-12 col-lg-12" >
                					<table id="jqgrid" style="font-family: '微软雅黑';"></table>
                					<div id="jqgrid-pager"></div>
           						</div> 
           						
           						<div  class="form-group col-md-12 col-lg-12" >
                					<table id="jqgrid_fukuan" style="font-family: '微软雅黑';"></table>
                					<div id="jqgrid-pager_fukuan"></div>
           						</div>
                                
                                <div class="form-group col-md-12 col-lg-12 ">
						            <label class="control-label" style=" text-align:left;">审核理由</label>
						     		<textarea class="form-control input-sm" name="auditReason" rows="3" ></textarea>
						        </div>
                                
                                <div class="form-group form-inline col-md-12 col-lg-12 ">
                                  <table id="shenhejieguo" style="display: inline-table;">
                                  	<tr>
											<td><label class="control-label" for="shenhejieguo">审核结果</label></td>
											<td>&nbsp;</td>
											<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
											<td><div class="radio"><input id="pass" type="radio" name="auditResult" value="true" checked>
						                		<label for="pass">通过</label></div></td>
											<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
											<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
											<td><div class="radio"><input id="unpass" type="radio" name="auditResult" value="false">
						                		<label for="unpass">不通过</label></div></td>
									</tr>
                                  
                                  </table>
						           
						        </div>
							</div>   
                    	</div>
				</form>
                                
                                
                          
        </div><!-- /.row --> 
        
						<p class="text-center">
							<button type="button" class="btn btn-custom-primary btn-sm" id="back" onclick="goBack()" style="float:left;background:#AAAAAB;border:2px solid #e5e5e5;margin-left:40%;width:63px"></i>返回</button>
							<button type="button" class="btn btn-primary btn-sm" id="submit" style="margin-left:-40%"><i class="fa fa-floppy-o"></i> 提交</button>
						</p>
    
    </div>
</body>
</html>
<content tag="scripts">
    <script src="js/jquery-1.11.1.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/jquery-ui.min.js"></script>
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
    <script type="text/javascript">
    var renkanbianhao='<s:property value="renkanshuaudit.renkanbianhao"/>';
        $(document).ready(function() {
            var t = $("#jqgrid");
            var tf = $("#jqgrid_fukuan");
            function e() {
                $("#jqgrid").length > 0 && t.fluidGrid({
                    base: "#jqgrid-wrapper",
                    offset: 0
                });
            } 
            function e_fukuan() {
                $("#jqgrid_fukuan").length > 0 && tf.fluidGrid({
                    base: "#jqgrid-wrapper_fukan",
                    offset: 0
                });
            } 
            
            $("#jqgrid").length > 0 && (t.jqGrid({
            	caption:'上画点位信息',
            	url:"OrderListForNewRenkanshu.action?renkanbianhao="+renkanbianhao,
            	mtype:"GET",
            	styleUI: 'Bootstrap',//设置jqgrid的全局样式为bootstrap样式
            	shrinkToFit:true,
            	datatype:"json",
            	colNames:['上画位点','广告类型','开始时间','结束时间','投放时长（周）','广告频次','广告时长（秒）','屏签订金额'],
            	rowNum:'<s:property value="@com.nfledmedia.sorm.cons.CommonConstant@DEFAULT_PAGE_SIZE"/>',
            	rowList: [10, 20, 30],
        		pager: "jqgrid-pager",
        		multiselect:!1,
        		autowidth:true,
        		sortname:"id",
        		sortorder: "asc",
        		viewrecords: !0,
        		colModel:[{
        			name:"ledName",
        			index:"ledName",
        			align:"center",
        	 		width:"100px"
        		},{
        			name:"leixing",
        			index:"leixing",
        			align:"center",
        			width:"100px" 
        				
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
        			index:"shuliang",
        			align:"center",
        			width:"70px"
        		},{
        			name:"pinci",
        			index: "pinci",
        			align:"center",
        			width:"70px"
        		},{
        			name:"shichang",
        			index:"shichang",
        			align:"center",
        			width:"70px" 
        		},{
        			name:"kanlijiaxiaoji",
        			index:"kanlijiaxiaoji",
        			align:"center",
        			width:"70px"
        		}],
            }), e(), $("#jqgrid").length > 0 && t.jqGrid("navGrid","#jqgrid-pager",{
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
            $(window).resize(e);
            
            //付款表
             $("#jqgrid_fukuan").length > 0 && (tf.jqGrid({
            	caption:'付款信息',
            	url:"fukuanAuditPageForNewRenkanshu.action?renkanbianhao="+renkanbianhao,
            	mtype:"GET",
            	styleUI: 'Bootstrap',//设置jqgrid的全局样式为bootstrap样式
            	shrinkToFit:true,
            	datatype:"json",
            	colNames:['付款期次','约定付款金额','约定付款时间','付款方式','备注'],
            	rowNum:'<s:property value="@com.nfledmedia.sorm.cons.CommonConstant@DEFAULT_PAGE_SIZE"/>',
            	rowList: [10, 20, 30],
        		pager: "jqgrid-pager_fukuan",
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
            }), e_fukuan(), $("#jqgrid_fukuan").length > 0 && tf.jqGrid("navGrid","#jqgrid-pager",{
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
            $(window).resize(e_fukuan);
            
            
          //保存按钮的点击事件
            $("#submit").click(function(){
                $.ajax({
                    url:"renkanshuAudit.action",
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
        });
        function goBack(){
            if(confirm("您确定要放弃相关操作，返回到审核列表中吗？")){
                location.replace('renkanshuListAuditPage');
            }
        }
        
    </script>
</content>