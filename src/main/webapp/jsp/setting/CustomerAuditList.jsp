<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html>
<head>

<title>用户审核设置</title>
<%@ include file="../common/header.jsp"%>

</head>
<body>
	<div class="list_title">
		<span>用户审核设置</span>
	</div>

	<table id="dgAuditList" style="width: 100%;"></table>

	<div class="text_input_bottom">
		<div class="text_input_button_add" id="text_input_button_left"
			onclick="newAuditSet()">添加</div>
		<div class="text_input_button_del" id="text_input_button_left"
			onclick="destroyAudit();">删除</div>
	</div>
	<div id="divAudit" class="easyui-window"
		data-options="iconCls:'icon-save',closed:'true',collapsible:false,minimizable:false,maximizable:false,closable:true"
		style="width: 500px; height: 400px; padding: 10px;">审核设置信息</div>

	<script type="text/javascript">
	 
	   $(function($) {
		   setAutoHeight(70,"dgAuditList"); 
	    	 $('#dgAuditList').datagrid({
	 			url:'<%=request.getContextPath()%>/auditCus/getAuditList',
								toolbar : $('#toolbar'),
								rownumbers : true,
								columns : [ [
										{
											field : 'ck',
											checkbox:true,
											id:'ck'
										},{
											field : 'id',
											hidden : true,
											title : 'id'
										},
										{
											field : 'action',
											title : '操作',
											width : '25%',
											formatter : function(value, rec) { //格式化函数添加一个操作列
												var btn = '<a style=""  href="#" onclick="javascript:editIntegralRule(' + rec.id + ')">编辑</a>';
												return btn;
											}
										}, {
											field : 'classname',
											title : '级别名称',
											width : '20%'
										}, {
											field : 'score',
											title : '级别积分',
											width : '20%'
										}
										, {
											field : 'classtype',
											title : '级别类型',
											width : '10%',
											formatter : function(value, rec) { //格式化函数添加一个操作列
												if (rec.classtype == 0) {
													return "拒绝";
												} else {
													return "通过";
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
	    	 
	    	 var pager = $('#dgAuditList').datagrid().datagrid('getPager');    // get the pager of datagrid
	            pager.pagination({
	            	pageSize:10,
	            	pageList: [10,50,100],
	            	displayMsg:'',
					links : 5,
	            	layout:['prev','links','next','list']
	            });     
		});
		
		 function editIntegralRule(id){
			 $('#divAudit').window({href:'<%=request.getContextPath()%>/jsp/setting/updateAudit.jsp?auditId='
										+ id
							}).window('setTitle', '管理规则详细').window('open');
		}
		 
		 function newAuditSet(){
		    	$('#divAudit').window({href:'<%=request.getContextPath()%>/jsp/setting/updateAudit.jsp'})
		    	.window('setTitle','新增审核设置')
		    	.window('open');//
		    }
		 
		 function destroyAudit(){
		    	var path = '<%=request.getContextPath()%>/auditCus/deleteAuditCustomer';
			var rows = $('#dgAuditList').datagrid('getChecked');

			if (rows.length > 0) {
				$.messager.confirm('警告', '确定要删除审核设置么?', function(yes) {
					if (yes) {

						var ids = '';
						for (var i = 0; i < rows.length; i++) {
							ids += rows[i].id + ',';
						}
						ids = ids.substring(0, ids.length - 1);

						$.post(path, {
							ids : ids
						}, function(result) {
							if (result == 1) {
								$('#dgAuditList').datagrid('reload'); // reload the user data
							} else {
								$.messager.show({ // show error message
									title : 'Error',
									msg : '删除失败'
								});
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
