<%@ page language="java" pageEncoding="UTF-8"  import="org.owasp.esapi.ESAPI" %>
<!DOCTYPE HTML>
<html>
<head>
<title>规则详细列表</title>
<%@ include file="../common/header.jsp"%>

</head>
<body>
    <div class="list_title">
        <span class="layui-parent-title-customer">HOME</span>
        <span class="layui-badge-dot layui-bg-title"></span>
        <span class="layui-children-title-customer">规则详细列表</span>
        <a id="btnReturn" href="<%=request.getContextPath()%>/jsp/coupon/couponList.jsp" style="float:right; font-size:28px;">返回上级</a>
    </div>
    <div class="table_data">
        <h4 class="table_data_title"> 规则详细列表
        <div class="text_input_bottom">
            <div class="text_input_button_add" id="text_input_button_left"
            onclick="newRuleDetail()">添加</div>
            <div class="text_input_button_del" id="text_input_button_left"
            onclick="destroyRule();">删除</div>
        </div>
        </h4>
        <table id="dgRuleDetailList" style="width: 100%;"></table>
    </div>

	<div id="divRuleDetail" class="easyui-window"
		data-options="iconCls:'icon-save',closed:'true',collapsible:false,minimizable:false,maximizable:false,closable:true"
		style="width: 500px; height: 550px; padding: 10px;">规则详细</div>
	<script type="text/javascript">
	   var idf;
	   var issystem;
	   $(function($) {
		   setAutoHeight(270,"dgRuleDetailList"); 
		     idf = '<%=ESAPI.encoder().encodeForJavaScript(request.getParameter("idf"))%>';
		     issystem = '<%=ESAPI.encoder().encodeForJavaScript(request.getParameter("isSystem"))%>';
	    	 $('#dgRuleDetailList').datagrid({
	 			url:'<%=request.getContextPath()%>/couponRule/RuleDetaillist?identification='+idf,
								toolbar : $('#toolbar'),
								rownumbers : true,
								columns : [ [
										{
											field : 'ck',
											checkbox:true,
											id:'ck'
										},
										{
											field : 'id',
											hidden : true,
											title : 'id'
										},
										{
											field : 'action',
											title : '操作',
											width : '10%',
											formatter : function(value, rec) { //格式化函数添加一个操作列
												var btn = '<a style="" class="radiuBtn" href="#" onclick="javascript:editRuleDetail(' + rec.id + ')">编辑</a>';
												return btn;
											}
										}, 
										{
											field : 'type',
											title : '优惠券类型',
											width : '10%',
											formatter : function(value, rec) { 
												if (rec.type == 1) {
													return "折扣优惠券";
												} else if(rec.type == 0) {
													return "减免优惠券";
												}
											}
										},
										{
											field : 'presentmoney',
											title : '优惠券金额(元)',
											width : '10%',
										},
										{
											field : 'discount',
											title : '折扣比例',
											width : '10%',
											formatter : function(value, rec) { 
												if(rec.discount == null){
													return "---";
												}else{
													return rec.discount+"%";
												}
												
										}
										},{
											field : 'topDiscountMoney',
											title : '折扣减免上限（元）',
											width : '10%',
											formatter : function(value, rec) { 
												if(rec.topDiscountMoney == 0){
													return "---";
												}else{
													return rec.topDiscountMoney;
												}
											}
											
										}, {
											field : 'presentcoumt',
											title : '赠送数量',
											width : '20%',
										}, {
											field : 'reamark',
											title : '备注',
											width : '20%',
										} , {
											field : 'createdate',
											title : '创建时间',
											width : '20%',
										} , {
											field : 'modifydate',
											title : '最后更新时间',
											width : '20%',
										} ] ],
								pagination : true,
								pageSize : 10,
								pageList : [ 5, 10, 15, 20, 50 ],
								layout:['prev','links','next','list'],
								emptyMsg : '无数据',
								onBeforeSelect : function() {
									return false;
								}
							});
	    	 
	    	 var pager = $('#dgRuleDetailList').datagrid('getPager');    // get the pager of datagrid
	            pager.pagination({
	            	pageSize:10,
	            	pageList: [10,50,100],
	            	displayMsg:'',
					links : 5,
	            	layout:['prev','links','next','list']
	            });    
		});
		
		 function newRuleDetail(){
			 	var idfOne = '<%=ESAPI.encoder().encodeForJavaScript(request.getParameter("idf"))%>';
		    	$('#divRuleDetail').window({href:'<%=request.getContextPath()%>/jsp/coupon/updateRuleDetail.jsp?idf='+idfOne+'&cusFlag='+idf})
		    	.window('setTitle','新增规则详细')
		    	.window('open');//
		    }
		 
		 function editRuleDetail(id){	
		    	$('#divRuleDetail').window({href:'<%=request.getContextPath()%>/jsp/coupon/updateRuleDetail.jsp?ruledetailId='+ id+'&cusFlag='+idf
							}).window('setTitle', '修改优惠券规则').window('open');//
		}
		 
		    function destroyRule(){
		    var path = '<%=request.getContextPath()%>/couponRule/deleteRuleDetail';
		    var rows = $('#dgRuleDetailList').datagrid('getChecked');
	        
	        if (rows.length>0){
				$.messager.confirm('警告', '确定要删除规则么?', function(yes) {
					if (yes) {
						var ids = '';
						for(var i =0 ;i<rows.length;i++){
							ids += rows[i].id + ',' ;
						}
						ids = ids.substring(0 , ids.length-1);
						
						$.post(path, {
							ids : ids
						}, function(result) {
							if (result == 1) {
								$('#dgRuleDetailList').datagrid('reload'); // reload the user data
								$.messager.alert('操作提示','操作完成!');
							} else {
								$.messager.alert('操作提示','删除失败!');
							}
						}, 'json');
					}
				});
			} else {
				$.messager.alert('操作提示', '至少选择一条记录!');
			}
		}
	</script>
</body>
</html>