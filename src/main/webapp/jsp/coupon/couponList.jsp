<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html>
<head>
<title>优惠券规则</title>
<%@ include file="../common/header.jsp"%>

</head>
<body>
    <div class="list_title">
        <span class="layui-parent-title-customer">HOME</span>
        <span class="layui-badge-dot layui-bg-title"></span>
        <span class="layui-children-title-customer">优惠券规则</span>
    </div>
    <div class="text_input">
        <span class="div_search_customerBar"></span>
        <form id='fm_s' action="">
        	<div class="form_item">
        		<div class="form_item_inline">
        			<label class="form_item_label4">规则名称</label>
        			<div class="form_item_input">
        				<input name="RuleName" class="easyui-textbox" style="width: 100px" />
        			</div>
        		</div>
        		<div class="form_item_inline">
        			<input type="button" onclick="search()" class="text_input_button_search" value="查询" />
        		</div>
        	</div>
        </form>
    </div>
    <div class="table_data">
        <h4 class="table_data_title"> 优惠券规则
        <div class="text_input_bottom">
            <div class="text_input_button_add" id="text_input_button_left"
            onclick="newRule()">添加</div>
            <!-- 
            <div class="text_input_button_del" id="text_input_button_left"
            onclick="destroyRule();">删除</div>
             -->
        </div>
        </h4>
        <table id="dgRuleList" style="width: 100%;"></table>
    </div>
    
	<div id="divRule" class="easyui-window"
		data-options="iconCls:'icon-save',closed:'true',collapsible:false,minimizable:false,maximizable:false,closable:true"
		style="width: 500px; height: 300px; padding: 10px;">规则信息</div>
	<div id="divDetail" class="easyui-window"
		data-options="iconCls:'icon-save',closed:'true',collapsible:false,minimizable:false,maximizable:false,closable:true"
		style="width: 500px; height: 300px; padding: 10px;">规则详细</div>

	<script type="text/javascript">
	 
	   $(function($) {
		   setAutoHeight(270,"dgRuleList"); 
	    	 $('#dgRuleList').datagrid({
	 			url:'<%=request.getContextPath()%>/couponRule/Rulelist',
								toolbar : $('#toolbar'),
								rownumbers : true,
								columns : [ [
										{
											field : 'ck',
											width:'5%',
											formatter : function(value, rec,
													index) {
												if (rec.issystem == 1) {
													return '<input type="checkbox" name="ck" disabled="disabled" />';
												} else {
													return '<input type="checkbox" name="ck" value='+ rec.id +' />';
												}
											}
										},
										{
											field : 'id',
											hidden : true,
											title : 'id',
											
										},
										{
											field : 'action',
											title : '操作',
											width : '15%',
											formatter : function(value, rec) { //格式化函数添加一个操作列
												var btn = '<a style=""  class="radiuBtn" href="#" onclick="javascript:editRule(' + rec.id + ','+ rec.issystem +')">编辑</a>';
												btn +=" ";
												btn+='<a style=""  class="radiuBtn" href="<%=request.getContextPath()%>/jsp/coupon/ruleDetailList.jsp?idf='+ rec.identification +'">详细</a>';
												/*  btn +='<a style=""  href="#" onclick="javascript:RuleDetail(' + rec.id + ')">详细</a>';*/
												return btn;
											}
										}, {
											field : 'rulename',
											title : '规则名称',
											width : '30%',
										}, {
											field : 'status',
											title : '状态',
											width : '25%',
											formatter : function(value, rec) { //格式化函数添加一个操作列
												if (rec.status == 1) {
													return "启用";
												} else {
													return "禁用";
												}
											}
										}, {
											field : 'issystem',
											title : '级别',
											width : '26%',
											formatter : function(value, rec) { //格式化函数添加一个操作列
												if (rec.issystem == 0) {
													return "自定义";
												} else {
													return "系统";
												}
											}
										} ] ],
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
	    	 
	    	 var pager = $('#dgRuleList').datagrid('getPager');    // get the pager of datagrid
	            pager.pagination({
	            	pageSize:10,
	            	pageList: [10,50,100],
	            	displayMsg:'',
					links : 5,
	            	layout:['prev','links','next','list']
	            });     
		});

		function search() {
			$('#dgRuleList').datagrid('load');
		}
		
		 function RuleDetail(idf){
			 $('#divDetail').window({href:'<%=request.getContextPath()%>/jsp/coupon/ruleDetailList.jsp?idf='
					 + idf}).window('setTitle', '管理规则详细').window('open');
		 }
		
		 function newRule(){
		    	$('#divRule').window({href:'<%=request.getContextPath()%>/jsp/coupon/updateRule.jsp'})
		    	.window('setTitle','新增规则')
		    	.window('open');//
		    }
		 
		 function editRule(id,issystem){		    	
		    	$('#divRule').window({href:'<%=request.getContextPath()%>/jsp/coupon/updateRule.jsp?ruleId='
										+ id+'&isSystem='+issystem
							}).window('setTitle', '修改优惠券规则').window('open');//
		}
		 
		    function destroyRule(){
		    	var path = '<%=request.getContextPath()%>/couponRule/deleteRule';

			var spCodesTemp = "";
			$('input:checkbox[name=ck]:checked').each(function(i) {
				if (0 == i) {
					spCodesTemp = $(this).val();
				} else {
					spCodesTemp += ("," + $(this).val());
				}
			});

			if (spCodesTemp != "") {
				$.messager.confirm('警告', '确定要删除规则么?', function(yes) {
					if (yes) {
						$.post(path, {
							ids : spCodesTemp
						}, function(result) {
							if (result == 1) {								
								$('#dgRuleList').datagrid('reload'); // reload the user data
								$.messager.alert('操作提示', '操作完成，但可能规则有活动使用，不能删除!');
							} else {
								$.messager.alert('操作提示', '删除失败!');
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