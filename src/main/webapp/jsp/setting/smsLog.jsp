<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="../common/header.jsp"%>
<title>短信记录</title>

<link rel="stylesheet" href="../../css/jquery.fancybox.css"
	type="text/css" />
<link rel="stylesheet" href="../../css/viewer.min.css" type="text/css" />
<script type="text/javascript" src="../../js/jquery.fancybox.pack.js"></script>
<script type="text/javascript" src="../../js/util/extendValidate.js"></script>
<script type="text/javascript" src="../../js/viewer.min.js"></script>
</head>
<body>
	<div class="list_title">
        <span class="layui-parent-title-customer">HOME</span>
        <span class="layui-badge-dot layui-bg-title"></span>
        <span class="layui-children-title-customer">短信记录</span>
    </div>
	<div class="text_input">
	    <span class="div_search_customerBar"></span>
		<form id='fm_s'>
			<div class="form_item">
				<div class="form_item_inline">
					<label class="form_item_label3">手机号</label>
					<div class="form_item_input">
						<input name="mobile" class="easyui-textbox" style="width:60px" />
					</div>
				</div>
				<div class="form_item_inline">
					<label class="form_item_label2">时间</label>
					<div class="form_item_input">
						<input name="startTime"  type="text" class="easyui-datetimebox"/>
					</div>
					<label class="form_item_label1">至</label>
					<div class="form_item_input">
						 <input name="endTime"  type="text" class="easyui-datetimebox"/>
					</div>
				</div>
				<div class="form_item_inline">
					<input type="button" onclick="search()" class="text_input_button_search" value="查询"/>
				</div>
			</div>
		</form>
	</div>
	<div class="table_data">
        <h4 class="table_data_title"> 短信记录</h4>
        <table id="dg" style="width: 100%;"></table>
    </div>
</body>
</html>
<script type="text/javascript">
//初始化页面
$(function(){
	//初始化列表
	setAutoHeight(270,"dg"); 
	$('#dg').datagrid({
			url:'<%=request.getContextPath()%>/sms/list',
			toolbar:$('#toolbar'),
			rownumbers:true,
			columns :  [[ 
			{
				field : 'sendTime',
				title : '发送时间',
				align : 'center',
				width:'20%'
			},{
				field : 'mobile',
				title : '手机号',
				align : 'center',
				width:'20%'
			},{
				field : 'type',
				title : '短信发送类型',
				align : 'center',
				width:'20%',
				formatter: function(value,row){
					return '系统默认';
				}
			},{
				field : 'message',
				title : '短信内容',
				align : 'center',
				width:"41%"
				
			}
			]], 
			
			pagination : true,//分页控件 
			rownumbers : true,//行号 		
			singleSelect:true,//一次只能选择一行
			showFooter: true,//显示行脚
			pageList : [ 10,50,100],// 可以设置每页记录条数的列表
	        pageSize : 10 ,
	        emptyMsg:'无数据',//为空时的数据展示
	        onBeforeLoad: function(param){
  		    	$($('#fm_s').serializeArray()).each(function(){  
  		    		param[this.name]=this.value;  
  	            }); 
  			},
  			onBeforeSelect:function(){
 				return false;
 			}
		});
	var pager = $('#dg').datagrid('getPager');    // get the pager of datagrid
	$(pager).pagination({
    	pageSize : 10,//每页显示的记录条数，默认为10 
		pageList : [ 10,50,100],//可以设置每页记录条数的列表 
		links:5,
		displayMsg:'',
		layout:['prev','links','next','list']
    }); 
});

//查询方法
function search() {
	$('#dg').datagrid('load');
}

</script>