<!-- copy from 'RuleDetailList.jsp'此页面仅仅用于查看 -->
<%@ page language="java" pageEncoding="UTF-8" import="org.owasp.esapi.ESAPI" %>
<!DOCTYPE HTML>
<html>
<head>
<title>优惠券规则明细</title>
<%@ include file="../common/header.jsp"%>
<style type="text/css">
body {
	height: 100%;
	overflow: hidden;
	margin: 0px;
	padding: 0px;
}
</style>
</head>
<body>
	<table id="dgRuleDetailList" style="width: 100%; height: 350px;"></table>
	<script type="text/javascript">
	$(function($) {
	     var idf = '<%=ESAPI.encoder().encodeForJavaScript(request.getParameter("idf"))%>';
   	 $('#dgRuleDetailList').datagrid({
			url:'<%=request.getContextPath()%>/couponRule/RuleDetaillist?identification='
										+ idf,
								rownumbers : true,
								columns : [ [ {
									field : 'id',
									hidden : true,
									title : 'id'
								}, {
									field : 'presentmoney',
									title : '金额',
									width : '10%'
								}, {
									field : 'presentcoumt',
									title : '赠送数量',
									width : '15%'
								}, {
									field : 'reamark',
									title : '备注',
									width : '25%'
								}, {
									field : 'createdate',
									title : '创建时间',
									width : '25%'
								}, {
									field : 'modifydate',
									title : '最后更新时间',
									width : '25%'
								} ] ],
								pagination : true,
								pageSize : 10,
								pageList : [ 10, 20, 30, 40 ],
								layout : [ 'prev', 'links', 'next', 'list' ],
								onBeforeSelect : function() {
									return false;
								}
							});
			var pager = $('#dgRuleDetailList').datagrid().datagrid('getPager'); // get the pager of datagrid
			pager.pagination({
				pageSize : 10,
				pageList: [10,50,100],
				layout : [ 'prev', 'links', 'next', 'list' ]
			});
		});
	</script>
</body>
</html>