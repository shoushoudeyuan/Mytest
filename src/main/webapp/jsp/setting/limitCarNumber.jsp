<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="../common/header.jsp"%>
<title>具体限号规则管理</title>

<script type="text/javascript" src="../../js/util/extendValidate.js"></script>
<script type="text/javascript">
/* formatterDate = function(date) 
{
	var day = date.getDate() > 9 ? date.getDate() : "0" + date.getDate();
	var month = (date.getMonth() + 1) > 9 ? (date.getMonth() + 1) : "0"
	+ (date.getMonth() + 1);
	return date.getFullYear() + '-' + month + '-' + day;
};
window.onload = function ()
{ 
	$('#startTime').datebox('setValue', formatterDate(new Date()));
} */
	
	$(function() {  
	setAutoHeight(270,"dg");
 	<%-- var recommendCode = '<%=request.getParameter("recommendCode")%>';
	var url = "/bjycrm/customer/getRegisterCustomers";
	if(recommendCode != null && recommendCode != "" && recommendCode != "null")
	{
		url = '/bjycrm/customer/getRegisterCustomers?recommendCode='+recommendCode
	} --%>
	var url = "${pageContext.request.contextPath}/limitCarNumber/limitCarNumberList";
		$('#dg').datagrid({
			url:url, 
			pagination:true,//分页控件 
	        rownumbers:true,//行号 
	        pageList : [10,30,60],          // 可以设置每页记录条数的列表
	        pageSize : 10 ,
	        emptyMsg:'无数据',
	        onBeforeLoad: function(param){
 		    	$($('#fm_s').serializeArray()).each(function(){  
 		    		param[this.name]=this.value; 
 		    		/* alert(this.name);
 		    		alert(this.value); */
 	            }); 
 			},
 			onBeforeSelect:function(){
  				return false;
  			}
		});
		//初始化服务城市
		$("#selectCity").combobox({
			url:'${pageContext.request.contextPath}/limitCarNumber/cityList',
			valueField:'cityId',
			textField:'city',
			onSelect:function(obj){
			//loadCarPort(obj.id)
			}
		});
		//初始化服务城市
		$("#selectCity2").combobox({
			url:'${pageContext.request.contextPath}/limitCarNumber/cityList',
			valueField:'cityId',
			textField:'city',
			onSelect:function(obj){
			//loadCarPort(obj.id)
			}
		});
		$('#dg').datagrid({
			columns : [ [  {
				field : 'id',
				checkbox : true,
			},
			{field:'operation',title: '操作',align: 'center',width:'24%',  
                formatter:function(value,rowData,rowIndex){
                    //function里面的三个参数代表当前字段值，当前行数据对象，行号（行号从0开始）editCustomer
                    return "<a href='javascript:;' class='radiuBtn' onclick='modifyItem(" + rowIndex + ");'>编辑</a>";  

               }  

            }, 
			{
				field : 'city',
				title : '省（城市）',
				align : 'center',
				width : '25%',
			}, {
				field : 'date',
				title : '规则日期',
				align : 'center',
				width : '25%',
				formatter:changeDate
			}, {
				field : 'limitCarNum',
				title : '限制号码',
				align : 'center',
				width : '25%',
			} /* {field:'ordernum',title: '订单数量',align: 'center',
                formatter:function(value,rowData,rowIndex)
                {
                    //function里面的三个参数代表当前字段值，当前行数据对象，行号（行号从0开始）editCustomer
                    return "<a href='javascript:;' onclick='goToOrderList(" + rowIndex + ");'>"+value+"</a>";  

               }  

            }, */    ] ],
		
			
		});
		
		var pager = $('#dg').datagrid('getPager');    // get the pager of datagrid
        pager.pagination({
        	pageSize:10,
        	pageList: [10,50,100],
			displayMsg:'',
			links:5,
        	layout:['prev','links','next','list']
        });  
		
		
	    $('#addLimitCarNumber').window('close');
	
	});
	

function changeDate(val,rec)
{
	if(val.length >= 10)
	return val.substr(0,10);
	else
		return val;
}
	
/* function editLimitCarNumber(rowIndex) 
{
	formClear();
	var row = $('#dg').datagrid('getData').rows[rowIndex];
} */
function beforeDelete() {
	var rows = $("#dg").datagrid("getChecked");
	if (rows && rows.length > 0) 
	{
	$.messager.confirm('确认', '确定要删除选中的限号规则吗?', function(r) {
		if (r)
			deleteItem();
	});
	}
	else
		{
		$.messager.alert("操作提示", "请选择要删除的限号规则", "");
		}
}

function deleteItem() {

	var rows = $("#dg").datagrid("getChecked");
		var ids = "";
		for (var i = 0; i < rows.length; i++) {
			var obj = rows[i];
			ids = ids + obj.id;
			if (i != rows.length - 1) {
				ids = ids + ",";
			}
		}
		var url = '${pageContext.request.contextPath}/limitCarNumber/deleteLimitCarNumber'
		$.ajax({
			type : "GET",
			url : url,
			data : {
				ids : ids
			},
			dataType : "json",
			success : function(data) {
				if (data.code == 10000) {
					$.messager.alert("操作提示", "删除成功！", "");
					for (var i = 0; i < rows.length; i++) {
						var objr = rows[i];
						var index = $('#dg').datagrid('getRowIndex', objr);
						//$('#dg').datagrid('deleteRow', index);
						$('#dg').datagrid('reload');
					}

				} else {
					$.messager.alert("操作提示", "删除失败！", "");
				}

			},
			error : function() {
				$.messager.alert("操作提示", "删除失败！", "");
			}
		});


}

	
	
	
<%-- 	function goToOrderList(rowIndex)
	{
		var row = $('#dg').datagrid('getData').rows[rowIndex];
		window.location.href='<%=request.getContextPath()%>/jsp/promotion/orderList.jsp?customerID='+row.id;
	} --%>
	

	function formClear() {
		$('#hiddenId').form('clear');
		$('#selectCity2').combobox('setValue', '');
		$("#limitDate").datebox("setValue",'');
		$('#selectLimitNum').combobox('setValue', ''); 
		
	}
	function addItem(){ 
		//alert(rowIndex);
		//var row = $('#dg').datagrid('getData').rows[rowIndex];
		formClear();
		$('#addLimitCarNumber').dialog('open').dialog('center')
		.dialog('setTitle', '具体限号情况添加');
		//$('#chPwdff').form('load', row);
		
	}
	function modifyItem(rowIndex)
	{
		var row = $('#dg').datagrid('getData').rows[rowIndex];
	/* 	$('#selectCity2').combobox('setValue', row.city);
		$("#limitDate").datebox("setValue",row.date);
		$('#selectLimitNum').combobox('setValue', row.limitCarNum);
		 */
		$('#addLimitCarNumber').dialog('open').dialog('center')
		.dialog('setTitle', '具体限号情况编辑');
		
		$('#addLimitCarNumber').form('load', row);
	}
	function addItemSubmit() {
		
		var id = $("#hiddenId").val();
		var url = '${pageContext.request.contextPath}/limitCarNumber/addLimitCarNumber';
	    if (id.length > 0) {
	    	url = '${pageContext.request.contextPath}/limitCarNumber/updateLimitCarNumber';
		}
		
		$('#addItemForm').form('submit', {
			url : url,
			onSubmit : function() 
			{
				return $(this).form('validate');
			},
			success : function(result) {

				var result = eval('(' + result + ')');
				if (result.code != '10000') {
					$.messager.alert("操作提示", result.message, "");
				} else {
					$.messager.alert("操作提示", "操作成功",""); 
					$('#addLimitCarNumber').dialog('close'); // close the dialog
					$('#dg').datagrid('reload'); // reload the user data enctype="multipart/form-data"
				}
			}
		});
	}
	
	function search()
	{
		$('#dg').datagrid('load');//刷新
	}
</script>
</head>
<body>
    <div class="list_title">
        <span class="layui-parent-title-customer">HOME</span>
        <span class="layui-badge-dot layui-bg-title"></span>
        <span class="layui-children-title-customer">具体限号规则管理</span>
    </div>
    <div class="text_input">
        <span class="div_search_customerBar"></span>
        <form id='fm_s'>
			<div class="form_item">
				<div class="form_item_inline">
					<label class="form_item_label4">选择城市</label>
					<div class="form_item_input">
						<select id="selectCity" name="cityId" class="easyui-combobox" style="width: 80px !important; margin-left: -10px !important;"></select>
					</div>
				</div>
				<div class="form_item_inline">
					<label class="form_item_label6">规则开始日期</label>
					<div class="form_item_input">
						<input name="startDate" class="easyui-datebox" style="width: 130px;" />
					</div>
				</div>
				<div class="form_item_inline">
					<label class="form_item_label6">规则结束日期</label>
					<div class="form_item_input">
						<input name="endDate" class="easyui-datebox" style="width: 130px;" />
					</div>
				</div>
				<div class="form_item_inline">
					 <input type="button" onclick="search()" class="text_input_button_search" value="查询" />
				</div>
			</div>
        </form>
    </div>
    <div class="table_data">
        <h4 class="table_data_title"> 具体限号规则管理
        <div class="text_input_bottom">
            <div class="text_input_button_add" id="text_input_button_left"
            onclick="addItem()">新增</div>
            <div class="text_input_button_del" id="text_input_button_left"
            onclick="beforeDelete()">删除</div>
        </div>
        </h4>
        <table id="dg"></table>
    </div>
    
	<div id="addLimitCarNumber" class="easyui-dialog" title="具体限号情况添加"
		iconCls="icon-save" style="display: none; width: 450px; height: 300px;"
		buttons="#chPwd-buttons">
		<form id="addItemForm" method="post">
			<table class="order_info">
				<tr>
					<td><label for=selectCity2><span style='color: red;'>*</span>选择城市</label></td>
					<td><select id="selectCity2" name="cityId"
						class="easyui-combobox" data-options="required:true" validType="limitCarNum"
						style="width: 100px !important; margin-left: -10px !important;">
					</select></td>
				</tr>
				<tr>
					<td><label for="limitDate"><span style='color: red;'>*</span>规则日期</label></td>
					<td><input id="limitDate" name="date" class="easyui-datebox" data-options="required:true"
						style="width: 130px;"></td>
				</tr>
				<tr>
					<td><label for="selectLimitNum"><span style='color: red;'>*</span>限制号码</label></td>
					<td><select id="selectLimitNum" name="limitCarNum"
						class="easyui-combobox" data-options="required:true"  validType="limitCarNum"
						style="width: 100px !important; margin-left: -10px !important;">
							<option value="" selected="selected">选择限号</option>
							<option value="0">0</option>
							<option value="1">1</option>
							<option value="2">2</option>
							<option value="3">3</option>
							<option value="4">4</option>
							<option value="5">5</option>
							<option value="6">6</option>
							<option value="7">7</option>
							<option value="8">8</option>
							<option value="9">9</option>
							<option value="字母">字母</option>
					</select></td>
				</tr>
			</table>
			<input type="hidden" name="id" id="hiddenId" />
		</form>

		<div id="save-buttons" style="clear:both">
			<div class="text_input_button_cancel"
				onclick="javascript:$('#addLimitCarNumber').dialog('close')">取消</div>
			<div class="text_input_button_float"
				onclick="javascript:addItemSubmit();">保存</div>
		

		</div>

	</div>


</body>
</html>