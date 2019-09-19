<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html>
<head>

<title>车辆问题记录</title>
<%@ include file="../common/header.jsp"%>
</head>
<body>
	<div class="list_title">
		 <span class="layui-parent-title-customer">HOME</span>
		 <span class="layui-badge-dot layui-bg-title"></span>
		 <span class="layui-children-title-customer">车辆问题记录</span>
	</div>
	<div class="text_input">
		<span class="div_search_customerBar"></span>
		<form id='queryForm'>
			<div class="form_item">
				<div class="form_item_inline">
					<label class="form_item_label2">车牌</label>
					<div class="form_item_input">
						<input name="plateNumber" class="easyui-textbox" />
					</div>
				</div>
				<div class="form_item_inline">
					<label class="form_item_label2">手机</label>
					<div class="form_item_input">
						<input name="customerMobile" class="easyui-textbox" />
					</div>
				</div>
				<div class="form_item_inline">
					<label class="form_item_label4">订单编号</label>
					<div class="form_item_input">
						<input name="orderNo" class="easyui-textbox" />
					</div>
				</div>
				<div class="form_item_inline">
					<input type="button" class="text_input_button_search" onclick="search()" value="查询">
				</div>
			</div>
		</form>
	</div>
	
	<div class="table_data">
		<h4 class="table_data_title">
			车辆问题记录
			<div class="text_input_bottom">
				<div class="text_input_button_add" id="text_input_button_left"
					onclick="addQuestion()">新增</div>
			</div>
		</h4>
		<table id="dg"></table>
	</div>

	<!-- 编辑弹出层Begin -->
	<div id="dlg_edit" class="easyui-window"
		data-options="iconCls:'icon-save',collapsible:false,minimizable:false,maximizable:false,closed:true,resizable:false"
		style="width: 500px; height: 500px; padding: 10px;">问题信息</div>
	<!-- 编辑弹出层 End-->
	<script type="text/javascript">
    $(function() {
		setAutoHeight(270,"dg"); 
    	//$("#activityName").textbox('readonly',true);
    	 $('#dg').datagrid({
 			url:'<%=request.getContextPath()%>/customerService/getAnswerQuestions',
 			fitColumns:true,
 			pagination : true,
 			toolbar:$('#toolbar'),
 			rownumbers:true,
			pageSize:10,
         	pageList: [10,20,30,40],
         	emptyMsg:'无数据',//为空时的数据展示
 		    columns:[[
 				{field:'id',hidden:true,title:'id'}, 
 				{field:'action',title:'操作',align:'center',formatter:formatAction},
 				{field:'orderno',title:'订单编号'}, 
 				{field:'customername',title:'用户名称',width:'10%'}, 
 		        {field:'customermobile',title:'手机',width:'10%'},
 		       {field:'platenumber',title:'车牌号',width:'15%'},
 		       	{field:'questioncategoryname',title:'问题类型',width:'10%'},
 		        {field:'remark',title:'备注',align:'center',width:'20%'},
 		       {field:'dealwithstatusname',title:'状态',align:'center',width:'15%'},
 		        {field:'createdate',title:'反馈时间',width:'20%'}
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
    	 var pager = $('#dg').datagrid('getPager');    // get the pager of datagrid
         pager.pagination({
        	 pageSize:10,
        	 pageList: [10,50,100],
          	links:5,
			displayMsg:'',
			emptyMsg:'无数据',
         	layout:['prev','links','next','list']
         });
    });
   
    function formatAction(val,row){
        return '<a style="" class="radiuBtn" href="javascript:editQuestion('+row.id+')">编辑</a>';       
	}
    
	function editQuestion(id){
		$('#dlg_edit').window({href:'<%=request.getContextPath()%>/jsp/customerService/editAnswerQuestion.jsp?questionId='+id})
		.window('setTitle','编辑问题')
		.window('open');
	}
	
	function addQuestion(){
		$('#dlg_edit').window({href:'<%=request.getContextPath()%>/jsp/customerService/editAnswerQuestion.jsp'})
		.window('setTitle','新增问题')
		.window('open');
	}
   	
		function search() {
			$('#dg').datagrid('load');
		}
	</script>
</body>
</html>
