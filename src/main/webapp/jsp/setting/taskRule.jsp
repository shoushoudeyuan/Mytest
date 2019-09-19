<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html>
<head>

<title>车辆任务规则</title>
<%@ include file="../common/header.jsp"%>
</head>
<body>

    <div class="list_title">
        <span class="layui-parent-title-customer">HOME</span>
        <span class="layui-badge-dot layui-bg-title"></span>
        <span class="layui-children-title-customer"> 车管领取时间 </span>
    </div>
    <div class="text_input">
        <span class="div_search_customerBar"></span>
        <form id='queryForm'>
        	<div class="form_item">
        		<div class="form_item_inline">
        			<label class="form_item_label4">任务类型</label>
        			<div class="form_item_input">
        				<select id="selectStatus" name="selectStatus" class="easyui-combobox" style="width: 100px;">
		                    <option  value="">全部</option>
		                    <option  value="0">充电</option>
		                    <option  value="1">调度</option>
		                    <option  value="2">整备</option>
		                    <option  value="3">加油</option>
	                    </select>
        			</div>
        		</div>
        		<div class="form_item_inline">
        			<input type="button" class="text_input_button_search" onclick="search()" value="查询" />
        		</div>
        	</div>
        </form>
    </div>
    <div class="table_data">
        <h4 class="table_data_title"> 车辆任务规则
        </h4>
        <table id="dg"></table>
    </div>
    
	<!-- 规则编辑开始-->
	<div id="dlg_edit" class="easyui-window"
		data-options="iconCls:'icon-save',collapsible:false,minimizable:false,maximizable:false,closed:true,resizable:false"
		style="width: 450px; height: 320px; padding: 10px;">编辑</div>
	<!-- 规则编辑结束-->
	<script type="text/javascript">
    $(function() {
		setAutoHeight(270,"dg"); 
    	 $('#dg').datagrid({
 			url:'/bjyvms/taskRuleInfo/getVehicleRules',
 			fitColumns:true,
 			pagination : true,
 			toolbar:$('#toolbar'),
 			rownumbers:true,
			pageSize:10,
         	pageList: [10,20,30,40],
         	emptyMsg:'无数据',//为空时的数据展示
 		    columns:[[
 				{field:'id',hidden:true,title:'id',width:'5%'}, 
 				{field:'action',title:'操作',align:'center',formatter:formatAction,width:'15%'},
 		        {field:'tasktype',title:'任务类型',formatter:tasktypes,width:'40%'},
 		        {field:'timedistance',title:'倒计时时长（分钟）',width:'46%'}
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
        return '<a style="" class="radiuBtn" href="javascript:editRuleItem('+row.id+','+row.tasktype+')">编辑</a>';       
	}

	function formatEnable(val,row){
		if('1' == val){
			return  '启用';
		}else{
			return "禁用";
		}
	}
	
	function tasktypes(val,row){
		if('0' == val){
			return  '充电';
		}else if('1' == val){
			return "调度";
		}
		else if('2' == val){
			return "整备";
		}else if('3' == val){
            return "加油";
        }
	}
		
	
	//编辑
	function editRuleItem(id,tasktype){
		$('#dlg_edit').window({href:'<%=request.getContextPath()%>/jsp/setting/updateTaskRule.jsp?ruleId='+id+'&task='+tasktype})
		.window('setTitle','编辑规则明细')
		.window('open');
	}
		function search() {
			$('#dg').datagrid('load');
		}
	</script>
</body>
</html>
