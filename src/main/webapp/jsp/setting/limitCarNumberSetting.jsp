<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="../common/header.jsp"%>
<title>限号规则设置管理</title>


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
	var url = "${pageContext.request.contextPath}/limitCarNumber/limitCarNumberSettingList";
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
 			}
		,
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
		/* $("#selectCity").combobox("setValue","");
		$("#selectCity").combobox("setText","请选择"); */
		
		$('#dg').datagrid({
			columns : [ [  {
				field : 'id',
				checkbox : true,
				width:'5%'
			},
			 {field:'operation',title: '操作',align: 'center',width:'15%',  
                formatter:function(value,rowData,rowIndex){
                    //function里面的三个参数代表当前字段值，当前行数据对象，行号（行号从0开始）editCustomer
                    return "<a href='javascript:;'  class='radiuBtn' onclick='lookLimitCarNumber(" + rowIndex + ");'>查看</a><a href='javascript:;' class='radiuBtn' onclick='modifyItem(" + rowIndex + ");'>编辑</a>";  

               } 
			 },
			{
				field : 'city',
				title : '省（城市）',
				align : 'center',
				width:'10%'
			}, {
				field : 'oneLimitCarNum',
				title : '周一限号',
				align : 'center',
				width:'10%'
			}, {
				field : 'twoLimitCarNum',
				title : '周二限号',
				align : 'center',
				width:'10%'
			}, {
				field : 'threeLimitCarNum',
				title : '周三限号',
				align : 'center',
				width:'10%'
			}, {
				field : 'fourLimitCarNum',
				title : '周四限号',
				align : 'center',
				width:'10%'
			}, {
				field : 'fiveLimitCarNum',
				title : '周五限号',
				align : 'center',
				width:'10%'
			}, {
				field : 'sixLimitCarNum',
				title : '周六限号',
				align : 'center',
				width:'10%'
			}, {
				field : 'sevenLimitCarNum',
				title : '周日限号',
				align : 'center',
				width:'10%'
			}, {
				field : 'startDate',
				title : '开始日期',
				align : 'center',
				formatter:changeDate,
				width:'20%'
			}, {
				field : 'endDate',
				title : '结束日期',
				align : 'center',
				width:'20%',
				formatter:changeDate
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
/* $(function() {
}); */
function changeDate2(val)
{
	if(val.length >= 10)
	return val.substr(0,10);
	else
		return val;
}
function lookLimitCarNumber(rowIndex) 
{ 
	//alert(1111);
	var row = $('#dg').datagrid('getData').rows[rowIndex];
	formClear();
	//$ ("#myTable").css();
	//document.getElementById("myTable").innerHTML(insertText);
	$("#myTable").empty();
	$ ("#myTable")
	.append("<tr><td>省（城市）：</td><td>"+row.city+"</td></tr>");

	for(var i= 0;i< 7;i++)
	{
		var name = '周一限号';
		var name2 = "";			
		switch (i)
		{
		case 0:
			name = '周一限号';
			name2 = row.oneLimitCarNum;
			
			break;
		case 1:
			name = '周二限号';
			name2 = row.twoLimitCarNum;
			
			break;
		case 2:
			name = '周三限号';
			name2 = row.threeLimitCarNum;
			
			break;
		case 3:
			name = '周四限号';
			name2 = row.fourLimitCarNum;
			
			break;
		case 4:
			name = '周五限号';
			name2 = row.fiveLimitCarNum;
			
			break;
		case 5:
			name = '周六限号';
			name2 = row.sixLimitCarNum;
			
			break;
		case 6:
			name = '周日限号';
			name2 = row.sevenLimitCarNum;
			break;
	

		default:
			break;
		}
		if(name2 == null)
		{
			name2 = "";
		}
		$ ("#myTable")
		.append("<tr><td>"+name+"：</td><td>"+name2+"</td></tr>");
		
	}
	row.startDate = changeDate2(row.startDate);
	row.endDate = changeDate2(row.endDate);
	$ ("#myTable")
	.append("<tr><td>开始日期：</td><td>"+row.startDate+"</td></tr>");
	$ ("#myTable")
	.append("<tr><td>结束日期：</td><td>"+row.endDate+"</td></tr>");
	
	$.parser.parse();//加样式 
	$("#save-buttons").hide();
		$('#addLimitCarNumber').dialog('open').dialog('center')
		.dialog('setTitle', '车辆限号规则查看');
	
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
	.dialog('setTitle', '车辆限号规则编辑');
	
	$('#addLimitCarNumber').form('load', row);
}
function beforeDelete() {
	var rows = $("#dg").datagrid("getChecked");
	if (rows && rows.length > 0) 
	{
	$.messager.confirm('确认', '确定要删除选中的限号规则设置吗?', function(r) {
		if (r)
			deleteItem();
	});
	}
	else
		{
		$.messager.alert("操作提示", "请选择要删除的限号规则设置", "");
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
		var url = '${pageContext.request.contextPath}/limitCarNumber/deleteLimitCarNumberSetting'
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
	
	
	
	
	/* function beforeDeleteCustomer() {
		var rows = $("#dg").datagrid("getSelections");
		if (rows && rows.length > 0) 
		{
		$.messager.confirm('确认', '确定要删除选中的会员吗?', function(r) {
			if (r)
				deleteCustomer();
		});
		}
		else
			{
			$.messager.alert("操作提示", "请选择要删除的会员", "");
			}
	} */
	function changeDate(val,rec)
	{
		if(val.length >= 10)
		return val.substr(0,10);
		else
			return val;
	}
	
	function formClear() {
		$('#hiddenId').form('clear');
		/* $('#selectCity2').combobox('setValue', '');
		$("#limitDate").datebox("setValue",'');
		$('#selectLimitNum').combobox('setValue', ''); */ 
		
	}
	function addItem(){ 
		//alert(1111);
		//var row = $('#dg').datagrid('getData').rows[rowIndex];
		formClear();
		//$ ("#myTable").css();
		//document.getElementById("myTable").innerHTML(insertText);
		$("#myTable").empty();
		$ ("#myTable")
		.append("<tr id='myCity'><td><label for=selectCity2><span style='color: red;'>*</span>选择城市</label></td><td><select id='selectCity2' name='cityId' class='easyui-combobox' data-options='required:true'  validType='limitCarNum' style='width: 80px !important; margin-left: -10px !important;'></select></td></tr>");
		$("#myCity")
		.append("<td></td>");
		for(var i= 0;i< 7;i++)
		{
			var name = '周一限号';
			var name2 = "oneLimitCarNum";			
			switch (i)
			{
			case 0:
				name = '周一限号';
				name2 = "oneLimitCarNum";
				
				break;
			case 1:
				name = '周二限号';
				name2 = "twoLimitCarNum";
				
				break;
			case 2:
				name = '周三限号';
				name2 = "threeLimitCarNum";
				
				break;
			case 3:
				name = '周四限号';
				name2 = "fourLimitCarNum";
				
				break;
			case 4:
				name = '周五限号';
				name2 = "fiveLimitCarNum";
				
				break;
			case 5:
				name = '周六限号';
				name2 = "sixLimitCarNum";
				
				break;
			case 6:
				name = '周日限号';
				name2 = "sevenLimitCarNum";
				break;
		

			default:
				break;
			}
			
			$("#myTable")
			.append("<tr id='tempTr"+i+"'><td><label for='selectLimitNum'>"+name+"</label></td>"
				+"<td><select id='"+"selectLimitNum"+i+"0"+"' name='"+name2+"0"+"' class='easyui-combobox'"
					+" style='width: 80px !important; margin-left: -10px !important;'>"
						+"<option value='' selected='selected'>选择限号</option>"
						+"<option value='0'>0</option>"
						+"<option value='1'>1</option>"
						+"<option value='2'>2</option>"
						+"<option value='3'>3</option>"
						+"<option value='4'>4</option>"
						+"<option value='5'>5</option>"
						+"<option value='6'>6</option>"
						+"<option value='7'>7</option>"
						+"<option value='8'>8</option>"
						+"<option value='9'>9</option>"
						+"<option value='字母'>字母</option></select></td></tr>");
			$("#tempTr"+i)
			.append("<td><select id='"+"selectLimitNum"+i+"1"+"' name='"+name2+"1"+"' class='easyui-combobox'"
					+" style='width: 80px !important; margin-left: -10px !important;'>"
					+"<option value='' selected='selected'>选择限号</option>"
					+"<option value='0'>0</option>"
					+"<option value='1'>1</option>"
					+"<option value='2'>2</option>"
					+"<option value='3'>3</option>"
					+"<option value='4'>4</option>"
					+"<option value='5'>5</option>"
					+"<option value='6'>6</option>"
					+"<option value='7'>7</option>"
					+"<option value='8'>8</option>"
					+"<option value='9'>9</option>"
					+"<option value='字母'>字母</option></select></td>");
			$("#tempTr"+i)
			.append("<td><select id='"+"selectLimitNum"+i+"2"+"' name='"+name2+"2"+"' class='easyui-combobox'"
					+" style='width: 80px !important; margin-left: -10px !important;'>"
					+"<option value='' selected='selected'>选择限号</option>"
					+"<option value='0'>0</option>"
					+"<option value='1'>1</option>"
					+"<option value='2'>2</option>"
					+"<option value='3'>3</option>"
					+"<option value='4'>4</option>"
					+"<option value='5'>5</option>"
					+"<option value='6'>6</option>"
					+"<option value='7'>7</option>"
					+"<option value='8'>8</option>"
					+"<option value='9'>9</option>"
					+"<option value='字母'>字母</option></select></td>");
		}
		
		$("#myTable").append("<tr id='trDate'><td><label for='limitDate'><span style='color: red;'>*</span>开始日期</label></td><td><input id='startDate' name='startDate' class='easyui-datebox' data-options='required:true' style='width: 130px;'></td></tr>");
		$("#trDate").append("<td><label for='limitDate'><span style='color: red;'>*</span>结束日期</label></td><td><input id='endDate' name='endDate' class='easyui-datebox' data-options='required:true' style='width: 130px;'></td>");
			
		
		$.parser.parse();//加样式
		
		$("#save-buttons").show();
			//初始化服务城市
			$("#selectCity2").combobox({
				url:'${pageContext.request.contextPath}/limitCarNumber/cityList',
				valueField:'cityId',
				textField:'city',
				onSelect:function(obj){
				//loadCarPort(obj.id)
				}
			});
			
			$('#addLimitCarNumber').dialog('open').dialog('center')
			.dialog('setTitle', '车辆限号规则添加');
			/* $("#selectCity2").combobox("setValue","");
			$("#selectCity2").combobox("setText","请选择"); */
		//$('#chPwdff').form('load', row);
		
	}
	function setEditValues(row)
	{
		if(row.oneLimitCarNum != null && row.oneLimitCarNum.length > 0)
		{
			var strs = row.oneLimitCarNum.split("和");
			if(strs.length > 0)
			{
				$('#selectLimitNum00').combobox('setValue', strs[0]);
			}
			if(strs.length > 1)
			{
				$('#selectLimitNum01').combobox('setValue', strs[1]);
			}
			if(strs.length > 2)
			{
				$('#selectLimitNum02').combobox('setValue', strs[2]);
			}
		}
		if(row.twoLimitCarNum != null && row.twoLimitCarNum.length > 0)
		{
			var strs = row.twoLimitCarNum.split("和");
			if(strs.length > 0)
			{
				$('#selectLimitNum10').combobox('setValue', strs[0]);
			}
			if(strs.length > 1)
			{
				$('#selectLimitNum11').combobox('setValue', strs[1]);
			}
			if(strs.length > 2)
			{
				$('#selectLimitNum12').combobox('setValue', strs[2]);
			}
		}
		if(row.threeLimitCarNum != null && row.threeLimitCarNum.length > 0)
		{
			var strs = row.threeLimitCarNum.split("和");
			if(strs.length > 0)
			{
				$('#selectLimitNum20').combobox('setValue', strs[0]);
			}
			if(strs.length > 1)
			{
				$('#selectLimitNum21').combobox('setValue', strs[1]);
			}
			if(strs.length > 2)
			{
				$('#selectLimitNum22').combobox('setValue', strs[2]);
			}
		}
		if(row.fourLimitCarNum != null && row.fourLimitCarNum.length > 0)
		{
			var strs = row.fourLimitCarNum.split("和");
			if(strs.length > 0)
			{
				$('#selectLimitNum30').combobox('setValue', strs[0]);
			}
			if(strs.length > 1)
			{
				$('#selectLimitNum31').combobox('setValue', strs[1]);
			}
			if(strs.length > 2)
			{
				$('#selectLimitNum32').combobox('setValue', strs[2]);
			}
		}
		if(row.fiveLimitCarNum != null && row.fiveLimitCarNum.length > 0)
		{
			var strs = row.fiveLimitCarNum.split("和");
			if(strs.length > 0)
			{
				$('#selectLimitNum40').combobox('setValue', strs[0]);
			}
			if(strs.length > 1)
			{
				$('#selectLimitNum41').combobox('setValue', strs[1]);
			}
			if(strs.length > 2)
			{
				$('#selectLimitNum42').combobox('setValue', strs[2]);
			}
		}
		if(row.sixLimitCarNum != null && row.sixLimitCarNum.length > 0)
		{
			var strs = row.sixLimitCarNum.split("和");
			if(strs.length > 0)
			{
				$('#selectLimitNum50').combobox('setValue', strs[0]);
			}
			if(strs.length > 1)
			{
				$('#selectLimitNum51').combobox('setValue', strs[1]);
			}
			if(strs.length > 2)
			{
				$('#selectLimitNum52').combobox('setValue', strs[2]);
			}
		}
		if(row.sevenLimitCarNum != null && row.sevenLimitCarNum.length > 0)
		{
			var strs = row.sevenLimitCarNum.split("和");
			if(strs.length > 0)
			{
				$('#selectLimitNum60').combobox('setValue', strs[0]);
			}
			if(strs.length > 1)
			{
				$('#selectLimitNum61').combobox('setValue', strs[1]);
			}
			if(strs.length > 2)
			{
				$('#selectLimitNum62').combobox('setValue', strs[2]);
			}
		}
	}
	function modifyItem(rowIndex)
	{
		var row = $('#dg').datagrid('getData').rows[rowIndex];

	/* 	$('#selectCity2').combobox('setValue', row.city);
		$("#limitDate").datebox("setValue",row.date);
		$('#selectLimitNum').combobox('setValue', row.limitCarNum);
		 */
		 
		 $("#myTable").empty();
			$ ("#myTable")
			.append("<tr><td><label for=selectCity3><span style='color: red;'>*</span>选择城市</label></td><td><select id='selectCity3' name='cityId' class='easyui-combobox' data-options='required:true'  validType='limitCarNum' style='width: 80px !important; margin-left: -10px !important;'></select></td></tr>");
		
			for(var i= 0;i< 7;i++)
			{
				var name = '周一限号';
				var name2 = "oneLimitCarNum";			
				switch (i)
				{
				case 0:
					name = '周一限号';
					name2 = "oneLimitCarNum";
					
					break;
				case 1:
					name = '周二限号';
					name2 = "twoLimitCarNum";
					
					break;
				case 2:
					name = '周三限号';
					name2 = "threeLimitCarNum";
					
					break;
				case 3:
					name = '周四限号';
					name2 = "fourLimitCarNum";
					
					break;
				case 4:
					name = '周五限号';
					name2 = "fiveLimitCarNum";
					
					break;
				case 5:
					name = '周六限号';
					name2 = "sixLimitCarNum";
					
					break;
				case 6:
					name = '周日限号';
					name2 = "sevenLimitCarNum";
					break;
			

				default:
					break;
				}
				
				$("#myTable")
				.append("<tr id='tempTr"+i+"'><td><label for='selectLimitNum'>"+name+"</label></td>"
					+"<td><select id='"+"selectLimitNum"+i+"0"+"' name='"+name2+"0"+"' class='easyui-combobox'"
						+" style='width: 80px !important; margin-left: -10px !important;'>"
							+"<option value='' selected='selected'>选择限号</option>"
							+"<option value='0'>0</option>"
							+"<option value='1'>1</option>"
							+"<option value='2'>2</option>"
							+"<option value='3'>3</option>"
							+"<option value='4'>4</option>"
							+"<option value='5'>5</option>"
							+"<option value='6'>6</option>"
							+"<option value='7'>7</option>"
							+"<option value='8'>8</option>"
							+"<option value='9'>9</option>"
							+"<option value='字母'>字母</option></select></td></tr>");
				$("#tempTr"+i)
				.append("<td><select id='"+"selectLimitNum"+i+"1"+"' name='"+name2+"1"+"' class='easyui-combobox'"
						+" style='width: 80px !important; margin-left: -10px !important;'>"
						+"<option value='' selected='selected'>选择限号</option>"
						+"<option value='0'>0</option>"
						+"<option value='1'>1</option>"
						+"<option value='2'>2</option>"
						+"<option value='3'>3</option>"
						+"<option value='4'>4</option>"
						+"<option value='5'>5</option>"
						+"<option value='6'>6</option>"
						+"<option value='7'>7</option>"
						+"<option value='8'>8</option>"
						+"<option value='9'>9</option>"
						+"<option value='字母'>字母</option></select></td>");
				$("#tempTr"+i)
				.append("<td><select id='"+"selectLimitNum"+i+"2"+"' name='"+name2+"2"+"' class='easyui-combobox'"
						+" style='width: 80px !important; margin-left: -10px !important;'>"
						+"<option value='' selected='selected'>选择限号</option>"
						+"<option value='0'>0</option>"
						+"<option value='1'>1</option>"
						+"<option value='2'>2</option>"
						+"<option value='3'>3</option>"
						+"<option value='4'>4</option>"
						+"<option value='5'>5</option>"
						+"<option value='6'>6</option>"
						+"<option value='7'>7</option>"
						+"<option value='8'>8</option>"
						+"<option value='9'>9</option>"
						+"<option value='字母'>字母</option></select></td>");
			}
			
			$("#myTable").append("<tr id='trDate'><td><label for='limitDate'><span style='color: red;'>*</span>开始日期</label></td><td><input id='startDate' name='startDate' class='easyui-datebox' data-options='required:true' style='width: 130px;'></td></tr>");
			$("#trDate").append("<td><label for='limitDate'><span style='color: red;'>*</span>结束日期</label></td><td><input id='endDate' name='endDate' class='easyui-datebox' data-options='required:true' style='width: 130px;'></td>");
			
			$("#save-buttons").show();
			$.parser.parse();//加样式 
				//初始化服务城市
				$("#selectCity3").combobox({
					url:'${pageContext.request.contextPath}/limitCarNumber/cityList',
					valueField:'cityId',
					textField:'city',
					onSelect:function(obj){
					//loadCarPort(obj.id)
					}
				});
		 
		 setEditValues(row);
		$('#addLimitCarNumber').dialog('open').dialog('center')
		.dialog('setTitle', '具体限号情况编辑');
		
		$('#addLimitCarNumber').form('load', row);
	}
	function addItemSubmit() {
		
		var id = $("#hiddenId").val();
		var url = '${pageContext.request.contextPath}/limitCarNumber/addLimitCarNumberSetting';
	    if (id.length > 0) {
	    	url = '${pageContext.request.contextPath}/limitCarNumber/updateLimitCarNumberSetting';
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
        <span class="layui-children-title-customer">限号规则设置管理</span>
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
     				<input type="button" onclick="search()" class="text_input_button_search" value="查询">
     			</div>
     		</div>
        </form>
    </div>
    <div class="table_data">
        <h4 class="table_data_title"> 限号规则设置管理
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
		iconCls="icon-save" style="display: none; width: 650px; height: 500px;"
		buttons="#save-buttons">
		<form id="addItemForm" method="post">
			<table class="order_info" id="myTable">
				<!-- 	<tr>
					<td><label for=selectCity2>选择城市</label></td>
					<td><select id="selectCity2" name="cityId"
						class="easyui-combobox" data-options="required:true"
						style="width: 80px !important; margin-left: -10px !important;">
					</select></td>
				</tr> -->
				<!-- <tr>
					<td><label for="limitDate">规则日期</label></td>
					<td><input id="limitDate" name="date" class="easyui-datebox"
						data-options="required:true" style="width: 130px;"></td>
				</tr> -->
<!-- 				<tr>
					<td><label for="selectLimitNum">限制号码</label></td>
					<td><select id="selectLimitNum" name="limitCarNum"
						class="easyui-combobox" data-options="required:true"
						validType="limitCarNum"
						style="width: 80px !important; margin-left: -10px !important;">
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
					<td><select id="selectLimitNum" name="limitCarNum"
						class="easyui-combobox" data-options="required:true"
						validType="limitCarNum"
						style="width: 80px !important; margin-left: -10px !important;">
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
					<td><select id="selectLimitNum" name="limitCarNum"
						class="easyui-combobox" data-options="required:true"
						validType="limitCarNum"
						style="width: 80px !important; margin-left: -10px !important;">
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
				</tr> --> 
			</table>
			<input type="hidden" name="id" id="hiddenId" />
			<input type="hidden" name="csrftoken" value="<%=session.getAttribute("csrftoken").toString()%>"/>
		</form>

		<div id="save-buttons" style="clear:both">
			<div class="text_input_button_cancel"
				onclick="javascript:$('#addLimitCarNumber').dialog('close')">取消</div>
			<div class="text_input_button_float"
				onclick="javascript:addItemSubmit();">生成规则</div>
			

		</div>

	</div>


</body>
</html>