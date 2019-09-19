<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html>
<head>

<title>活动管理</title>
<%@ include file="../common/header.jsp"%>
</head>
<body>
    <div class="list_title">
        <span class="layui-parent-title-customer">HOME</span>
        <span class="layui-badge-dot layui-bg-title"></span>
        <span class="layui-children-title-customer">活动管理</span>
    </div>
    <div class="text_input">
        <span class="div_search_customerBar"></span>
        <form id='queryForm'>
        	<div class="form_item">
        		<div class="form_item_inline">
        			<label class="form_item_label4">活动名称</label>
        			<div class="form_item_input">
        				<input id="activityName" name="activityName" value="" class="easyui-textbox" />
        			</div>
        		</div>
        		<div class="form_item_inline">
        			<input type="button" class="text_input_button_search" onclick="search()" value="查询" />
        		</div>
        	</div>            
        </form>
    </div>
    <div class="table_data">
        <h4 class="table_data_title"> 活动管理
        <div class="text_input_bottom">
            <div class="text_input_button_add" id="text_input_button_left" onclick="addActivity()">新增</div>
            <div class="text_input_button_del" id="text_input_button_left" onclick="deleteActivity()">删除</div>
        </div>
        </h4>
        <table id="dg"></table>
    </div>
	
	<!-- 编辑活动弹出层Begin -->
	<div id="dlg_edit" class="easyui-window" data-options="iconCls:'icon-save',collapsible:false,minimizable:false,maximizable:false,closed:true,resizable:false" style="width: 500px; height: 500px; padding: 10px;">活动信息</div>
	<!-- 编辑活动弹出层 End-->
	<!-- 查看优惠券规则明细弹出层Begin -->
	<div id="dlg_show_rule" class="easyui-window"
		data-options="iconCls:'icon-save',collapsible:false,minimizable:false,maximizable:false,closed:true,resizable:false"
		style="width: 800px; height: 450px; padding: 10px;">优惠券规则明细</div>
	<!-- 查看优惠券规则明细弹出层 End-->
	<script type="text/javascript">
    $(function() {
		setAutoHeight(270,"dg"); 
    	//$("#activityName").textbox('readonly',true);
    	 $('#dg').datagrid({
 			url:'<%=request.getContextPath()%>/activity/getActivities',
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
 				{field:'identification',hidden:true,title:'规则标识'}, 
 				{field:'couponruleid',hidden:true,title:'优惠券规则id'}, 
 				{field:'action',title:'操作',align:'center',formatter:formatAction},
 		        {field:'activityname',title:'活动名称',width:'15%',formatter:formatActivityName},
 		       	{field:'couponrulename',title:'规则名称',formatter:formatCouponRule},
 		        {field:'isdisable',title:'启用状态',align:'center',formatter:formatEnable},
 		       {field:'ispublish',title:'发布状态',align:'center',formatter:formatPublish},
 		        {field:'createdate',title:'创建时间'},
 		        {field:'startdate',title:'生效时间'},
 		        {field:'enddate',title:'失效时间',width:'20%'},
 		        {field:'activitylink',title:'活动抢红包链接',width:'26%'}
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
        return '<a style="" class="radiuBtn" href="javascript:editActivity('+row.id+')">编辑</a>'+" "
        +'<a style="" class="radiuBtn" href="javascript:manageActivityRedPacket('+row.id+',\''+row.couponrulename+'\')">红包</a>';       
	}

	function formatEnable(val,row){
		if('1' == val){
			return  '启用';
		}else{
			return "禁用";
		}
	}
	
	function formatPublish(val,row){
		if('1' == val){
			return  '已发布';
		}else{
			return "未发布";
		}
	}	
	
	//给规则名称添加链接
	function formatCouponRule(value,row,index){
		return '<a style="" class="datagrid_font_green"  href="javascript:showCouponRuleItem(\''+row.identification+'\')" >'+value+'</a>';
	}
	
	function formatActivityName(value,row,index){
		return '<div title='+value+' style="overflow: hidden;text-overflow:ellipsis;whitespace:nowrap;">'+value+'</div>';
	}
	
	function editActivity(id){
		$('#dlg_edit').window({href:'<%=request.getContextPath()%>/jsp/activity/editActivity.jsp?activityId='+id,width:700,height:400,modal:true,resizable:false})
		.window('setTitle','修改活动')
		.window('open');
	}
	
	function addActivity(){
		$('#dlg_edit').window({href:'<%=request.getContextPath()%>/jsp/activity/editActivity.jsp',width:700,height:400,modal:true,resizable:false})
		.window('setTitle','新增活动')
		.window('open');
	}
   	
    function deleteActivity(){
    	var path = '<%=request.getContextPath()%>/activity/deleteActivity';
			var rows = $('#dg').datagrid('getChecked');
			if (rows.length > 0) {
				$.messager.confirm('信息提示', '确定要删除活动么?', function(r) {
					if (r) {
						var ids = '';
						for (var i = 0; i < rows.length; i++) {
							ids += rows[i].id + ',';
						}
						ids = ids.substring(0, ids.length - 1);

						$.post(path, {
							activityIds : ids
						}, function(result) {
							if (result>0) {
								$.messager.show({ // show error message
									title : '操作结果',
									msg : '操作成功！'
								});
								$('#dg').datagrid('reload'); // reload the user data
							} else {
								$.messager.show({ // show error message
									title : '操作结果',
									msg : '操作失败！'
								});
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
		
		function manageActivityRedPacket(activityId,couponrulename){			
			location.href="<%=request.getContextPath()%>/jsp/activity/redEnvelopeManage.jsp?activityId="+activityId+"&couponrulename="+couponrulename;
		}
		
		//显示优惠券规则明细页面
		function showCouponRuleItem(identification) {
			$('#dlg_show_rule').window({href:'<%=request.getContextPath()%>/jsp/coupon/conponRuleItemView.jsp?idf='+identification})
			.window('setTitle','优惠券规则明细')
			.window('open');
		}
	</script>
</body>
</html>
