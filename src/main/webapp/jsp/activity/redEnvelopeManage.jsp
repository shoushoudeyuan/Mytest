<%@ page language="java" pageEncoding="UTF-8" import="org.owasp.esapi.ESAPI" %>
<!DOCTYPE HTML>
<html>
<head>

<title>红包管理</title>
<%@ include file="../common/header.jsp"%>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/upload.js"></script> 
</head>
<body>

<div class="list_title">
	<span class="layui-parent-title-customer">HOME</span>
    <span class="layui-badge-dot layui-bg-title"></span>
    <span class="layui-children-title-customer">红包管理</span>
	<a id="btnReturn" href="javascript:" style="float:right; font-size:28px;">返回上级</a>
</div>
<div class="text_input">
	<span class="div_search_customerBar"></span>
	<form id='queryForm'>
		<div class="form_item">
			<div class="form_item_inline">
				<label class="form_item_label2">编码</label>
				<div class="form_item_input">
					<input type="hidden" id="activityId" name="activityId" value=""/>
					<input type="hidden" id="couponrulename" name="couponrulename" value=""/>
					<input id="packetNum" name="packetNum" value="" class="easyui-textbox" style="width: 100px"> 
				</div>
			</div>
			<div class="form_item_inline">
				<label class="form_item_label4">是否使用</label>
				<div class="form_item_input">
					<select id="isUsed" name="isUsed" class="easyui-combobox" style="width: 100px">
						<option value="">全部</option>
						<option value="0">未使用</option>
						<option value="1">已使用</option>
					</select>
				</div>
			</div>
			<div class="form_item_inline">
				<label class="form_item_label4">是否启用</label>
				<div class="form_item_input">
					<select id="isEnable" name="isEnable" class="easyui-combobox" style="width: 100px">
						<option value="">全部</option>
						<option value="1">启用</option>
						<option value="0">禁用</option>
					</select>
				</div>
			</div>
			<div class="form_item_inline">
					<input type="button" class="text_input_button_search" onclick="search()" style="width: 100px" value="查询">
			</div>
		</div>
	</form>
</div>
      <div class="table_data">
        <h4 class="table_data_title">
        	红包管理
        	<div class="text_input_bottom">
		    	<div class="text_input_button_add" id="text_input_button_left" onclick="batchAddRedEnvelope()">批量生成</div>
				<div class="text_input_button_del" id="text_input_button_left" onclick="deleteRedEnvelope()">删除</div>
				<div class="text_input_button" id="text_input_button_left" onclick="exportRedEnvelopes()">导出</div>
			</div>
        </h4>
		<table id="dg" style="width: 100%; height: 500px;"></table>
	  </div>

	<div id="dlg_edit" class="easyui-window"
		data-options="iconCls:'icon-save',collapsible:false,minimizable:false,maximizable:false,closed:true,resizable:false"
		style="width: 450px; height: 420px; padding: 10px;">活动信息</div>
		
	<script type="text/javascript">
	//优惠券规则名称
	var _couponRuleName="";
    $(function() {
		setAutoHeight(270,"dg"); 
    	_couponRuleName='<%=ESAPI.encoder().encodeForJavaScript(request.getParameter("couponrulename"))%>';
    	//初始化隐藏域的值
    	$("#activityId").val('<%=ESAPI.encoder().encodeForJavaScript(request.getParameter("activityId"))%>');
    	$("#couponrulename").val(_couponRuleName);
    	 $('#dg').datagrid({
 			url:'<%=request.getContextPath()%>/activity/getRedEnvelopes',
 			fitColumns:true,
 			pagination : true,
 			toolbar:$('#toolbar'),
 			rownumbers:true,
			pageSize:10,
         	pageList: [10,20,30,40],
         	emptyMsg:'无数据',//为空时的数据展示
 		    columns:[[
 				{field:'ck',checkbox:true,id:'ck'}, 
 				{field:'id',hidden:true,title:'id'}, 
 				{field:'action',title:'操作',align:'center',formatter:formatAction},
 		        {field:'packetnum',title:'红包编码'},
 		       	{field:'isdisable',title:'启用状态',formatter:formatEnable},
 		        {field:'remark',title:'备注',align:'center'},
 		        {field:'rulename',title:'来源',align:'center',formatter:formatRuelName},
 		     	{field:'createdate',title:'生成时间'},
 		    	{field:'startdate',title:'生效时间'},
		        {field:'enddate',title:'失效时间'},
 		      	{field:'isused',title:'使用状态',align:'center',formatter:formatUsed}, 
 		        {field:'usingdate',title:'使用时间'},
 		        {field:'usingusername',title:'使用人'}
 		    ]],
 		    onBeforeLoad: function(param){
 		    	$($('#queryForm').serializeArray()).each(function(){  
 		    		param[this.name]=this.value;  
 	            }); 
 			},
 			onBeforeSelect:function(){
 				return false;
 			}
 		});
    	 var pager = $('#dg').datagrid().datagrid('getPager');    // get the pager of datagrid
         pager.pagination({
        	 pageSize:10,
        	 pageList: [10,50,100],
			displayMsg:'',
			emptyMsg:'无数据',
			links:5,
         	layout:['prev','links','next','list']
         });
    	 
         $("#btnReturn").click(function(){
 			location.href="<%=request.getContextPath()%>/jsp/activity/activityManage.jsp";
 		});
    });
   
    function formatAction(val,row){
        return '<a style="" class="radiuBtn" href="javascript:editRedEnvelope('+row.id+')">编辑</a>'; 
	}

	function formatEnable(val,row){
		if('1' == val){
			return  '启用';
		}else{
			return "禁用";
		}
	}
	
	function formatUsed(val,row){
		if('1' == val){
			return  '已使用';
		}else{
			return "未使用";
		}
	}	
	//格式化来源名称
	function formatRuelName(val,row){		
		//alert(_couponRuleName);
		return _couponRuleName;
	}
	
	//编辑红包
	function editRedEnvelope(id){
		$('#dlg_edit').window({href:'<%=request.getContextPath()%>/jsp/activity/editRedEnvelope.jsp?redEnvelopeId='+id})
		.window('setTitle','编辑红包')
		.window('open');
	}
	//批量生成红包
	function batchAddRedEnvelope(){
		$('#dlg_edit').window({href:'<%=request.getContextPath()%>/jsp/activity/batchAddRedEnvelope.jsp?activityId='+$("#activityId").val()})
		.window('setTitle','批量生成红包')
		.window('open');
	}
   	
    function deleteRedEnvelope(){
    	var path = '<%=request.getContextPath()%>/activity/deleteRedEnvelope';
			var rows = $('#dg').datagrid('getChecked');
			if (rows.length > 0) {
				$.messager.confirm('信息提示', '确定要删除红包么?', function(r) {
					if (r) {
						var ids = '';
						for (var i = 0; i < rows.length; i++) {
							ids += rows[i].id + ',';
						}
						ids = ids.substring(0, ids.length - 1);

						$.post(path, {
							activityRedPacketIds : ids
						}, function(result) {
							if (result > 0) {
								$.messager.alert('信息提示','操作成功');
								$('#dg').datagrid('reload'); // reload the user data
							} else {
								$.messager.alert('信息提示','操作失败');
							}
						}, 'json');
					}
				});
			} else {
				$.messager.alert('操作提示', '至少选择一条记录!');
			}
		}

		function search() {
			$('#dg').datagrid('load');
		}

		//导出红包
		function exportRedEnvelopes() {			
			var queryParam = getFormJson($("#queryForm")[0]);
			var url = "<%=request.getContextPath()%>/activity/exportRedEnvelopes?"+$.param(queryParam);
			window.open(url);
		}
		// 如：{Name:'摘取天上星',position:'IT技术'}
		// ps:注意将同名的放在一个数组里
		function getFormJson(form) {
			var o = {};
			var a = $(form).serializeArray();
			$.each(a, function() {
				if (o[this.name] !== undefined) {
					if (!o[this.name].push) {
						o[this.name] = [ o[this.name] ];
					}
					o[this.name].push(this.value || '');
				} else {
					o[this.name] = this.value || '';
				}
			});
			return o;
		}		
	</script>
</body>
</html>
