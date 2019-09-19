<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html>
<head>

<title>积分规则设置</title>
<%@ include file="../common/header.jsp"%>

</head>
<body>
	<div class="list_title">
		 <span class="layui-parent-title-customer">HOME</span>
        <span class="layui-badge-dot layui-bg-title"></span>
        <span class="layui-children-title-customer">积分规则管理</span>
	</div>
	 <div class="table_data">
        <h4 class="table_data_title">积分规则管理</h4>
		<table id="dgScoreRuleList" style="width: 100%;"></table>
	</div>

	<div id="divIntegralRule" class="easyui-window"
		data-options="iconCls:'icon-save',closed:'true',collapsible:false,minimizable:false,maximizable:false,closable:true"
		style="width: 500px; height: 330px; padding: 10px;">积分规则信息</div>

	<script type="text/javascript">
	 
	   $(function($) {
		   setAutoHeight(270,"dgScoreRuleList"); 
	    	 $('#dgScoreRuleList').datagrid({
	 			url:'<%=request.getContextPath()%>/integralRule/findintegralrule',
								toolbar : $('#toolbar'),
								rownumbers : true,
								columns : [ [
										{
											field : 'id',
											hidden : true,
											title : 'id'
										},
										{
											field : 'action',
											title : '操作',
											width : '25%',
											formatter : function(value, rec) { //格式化函数添加一个操作列
												var btn = '<a style="" class="radiuBtn"  href="#" onclick="javascript:editIntegralRule(' + rec.id + ')">编辑</a>';
												return btn;
											}
										}, {
											field : 'sendtype',
											title : '描述',
											width : '25%',
											formatter : function(value, rec) { //格式化函数添加一个操作列
												if (rec.sendtype == 1) {
													return "APP平台实际支付";
												} else if (rec.sendtype == 2){
													return "特惠订单消费";
												} else if (rec.sendtype == 3){
													return "周租订单消费";
												} else{
													return "推荐人赠送";
												}
											}
										}, {
											field : 'costmoney',
											title : '消费金额',
											width : '20%'
										}, {
											field : 'sendscore',
											title : '兑换积分',
											width : '20%'
										}
										, {
											field : 'status',
											title : '状态',
											width : '11%',
											formatter : function(value, rec) { //格式化函数添加一个操作列
												if (rec.status == 0) {
													return "禁用";
												} else {
													return "启用";
												}
											}
										}] ],
								pagination : true,
								pageSize : 10,
								pageList : [ 5, 10, 15, 20, 50 ],
								layout:['prev','links','next','list'],
								emptyMsg : '无数据',
								onBeforeLoad : function(param) {
									$($('#fm_s').serializeArray()).each(
											function() {
												param[this.name] = this.value;
											});
								},
								onBeforeSelect : function() {
									return false;
								}
							});
	    	 
	    	 var pager = $('#dgScoreRuleList').datagrid().datagrid('getPager');    // get the pager of datagrid
	            pager.pagination({
	            	pageSize:10,
	            	pageList: [10,50,100],
	            	displayMsg:'',
					links : 5,
	            	layout:['prev','links','next','list']
	            });     
		});
		
		 function editIntegralRule(id){
			 $('#divIntegralRule').window({href:'<%=request.getContextPath()%>/jsp/setting/integralRuleDetail.jsp?ruleid='
					 + id}).window('setTitle', '管理规则详细').window('open');
		 }		
	</script>
</body>
</html>
