<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="../common/header.jsp"%>
<title>推广商户</title>
<script type="text/javascript" src="../../js/util/extendValidate.js"></script>
<script type="text/javascript">
			
	$(function() {
		setAutoHeight(300,"dg");   
		$('#dg').datagrid({
			url:'${pageContext.request.contextPath}/promotionRules/rulesList', 
			pagination:true,//分页控件 
	        rownumbers:true,//行号 
	        pageSize:10,
        	pageList :  [10,50,100],
        	emptyMsg:'无数据',
	        onBeforeLoad: function(param){
 		    	$($('#fm_s').serializeArray()).each(function(){  
 		    		param[this.name]=this.value;  
 	            }); 
 			},
 			onBeforeSelect:function(){
  				return false;
  			}
			
		});
		$('#dg').datagrid({
			columns : [ [ {
				field : 'id',
				checkbox : true,
			},{field:'operation',title: '操作',align: 'center',
                formatter:function(value,rowData,rowIndex){
                    //function里面的三个参数代表当前字段值，当前行数据对象，行号（行号从0开始）editCustomer
                    return "<a href='javascript:;' class='radiuBtn' onclick='editRules(" + rowIndex + ");'>编辑</a>";  
               }  

            },{
				field : 'startdays',
				title : '起始天数',
				width : '10%',
				align : 'center'
			}, {
				field : 'enddays',
				title : '结束天数',
				width : '10%',
				align : 'center'
			}, {
				field : 'pushpercent',
				title : '提成百分比',
				width : '25%',
				align : 'center',
				formatter:per
			}, {
				field : 'createdate',
				title : '创建时间',
				width : '25%',
				align : 'center'
			}, {
				field : 'userName',
				title : '创建人',
				width : '25%',
				align : 'center'
			}] ],
		});
		
		
		 $.extend($.fn.validatebox.defaults.rules, {
		        /*必须和某个字段相等*/
		        equalTo: { validator: function (value, param) { return $(param[0]).val() == value; }, message: '字段不匹配' }
		       });
		
		
		 var pager = $('#dg').datagrid('getPager');    // get the pager of datagrid
	        pager.pagination({
	        	pageSize:10,
	        	pageList : [10,50,100],
				displayMsg:'',
				links:5,
	        	layout:['prev','links','next','list']
	        }); 
		 
	    
	    $('#win').window('close');
	    $('#chPwd').window('close');
	});
	function per(val,rec){ 
		return val+'%';
	}
	function addRules() {
		$('#fm').form('clear');
		$('#businessId').val('${param.businessId}');
		$('#win').dialog('open').dialog('center').dialog('setTitle', '添加规则');
		$('#win').window('open');
	}
	function editRules(rowIndex) {
		$('#fm').form('clear');
		var row = $('#dg').datagrid('getData').rows[rowIndex];
		$('#win').dialog('open').dialog('center').dialog('setTitle', '修改规则');
		$('#fm').form('load', row);
		
	}
	
	function saveOrUpdate(){
		var id = $("#id").val();
		var url = '${pageContext.request.contextPath}/promotionRules/addRules';
	    if (id.length > 0) {
			url = '${pageContext.request.contextPath}/promotionRules/updateRules';
		}
		$('#fm').form('submit', {
			url : url,
			onSubmit : function() {
				var f = $(this).form('validate');
				if(f)
				{
					if($("#enddays").val()*1 < $("#startdays").val()*1 && $("#enddays").val()*1!= 0)
						{
						   $.messager.alert("操作提示", "结束天数需大于等于开始天数", "");
						   return false;
						}
					
				}
				else
				{
					return false;
				}
			},
			success : function(result) {

				var result = eval('(' + result + ')');
				if (result.code != '10000') {
					$.messager.alert("操作提示", result.message, "");
				} else {
					$('#win').dialog('close'); // close the dialog
					$('#dg').datagrid('reload'); // reload the user data enctype="multipart/form-data"
				}
			}
		});
	}
	
	
	function beforeDeleteRules() {
		var rows = $("#dg").datagrid("getChecked");
		if (rows && rows.length > 0) 
		{
		$.messager.confirm('确认', '确定要删除选中的规则吗?', function(r) {
			if (r)
				del();
		});
		}
		else
			{
			$.messager.alert("操作提示", "请选择要删除的规则", "");
			}
	}

	function del() {

		var rows = $("#dg").datagrid("getChecked");
			var ids = "";
			for (var i = 0; i < rows.length; i++) {
				var obj = rows[i];
				ids = ids + obj.id;
				if (i != rows.length - 1) {
					ids = ids + ",";
				}
			}
			var url = '${pageContext.request.contextPath}/promotionRules/deleteRules'
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
	
	function goPerson(rowIndex) 
	{
		var row = $('#dg').datagrid('getData').rows[rowIndex];
		url = "personList.jsp?businessId="+row.id;
		window.location.href = url;
	}
	
	function search(){
        $('#dg').datagrid('load');
    }
	
	
</script>
</head>
<body>
<div class="list_title">
        <span class="layui-parent-title-customer">HOME</span>
        <span class="layui-badge-dot layui-bg-title"></span>
        <span class="layui-children-title-customer">推广商绩效规则</span>
        <a id="btnReturn"
                href="<%=request.getContextPath()%>/jsp/promotion/businessList.jsp"
                style="float: right; font-size: 28px;">返回上级</a>
    </div>
    <form id='fm_s' action="">
         <input type="hidden" name = "businessId" value = "${param.businessId}"/> 
    </form>
    <div class="table_data">
        <h4 class="table_data_title"> 推广商绩效规则
        <div class="text_input_bottom">
            <div class="text_input_button_add" id="text_input_button_left"
            onclick="addRules()">新增</div>
            <div class="text_input_button_del" id="text_input_button_left"
            onclick="beforeDeleteRules()">删除</div>
        </div>
        </h4>
        <table id="dg"></table>
    </div>

	<div id="win" title="添加地推绩效规则" iconCls="icon-save" class="easyui-dialog" style="width:700px;height:400px; display: none; left:15%;top:2%;" closed="true" buttons="#dlg-buttons" >  
    <form id="fm" action="${pageContext.request.contextPath}/customer/addCustomer" method="post"  >
			<table class="order_info" height="250">
				<tr>
					<td><span style="color: red;">*</span><label for="username">起始天数:</label></td>
					<td><input class="easyui-validatebox validatebox-invalid_input" type="text"
						name="startdays" id = "startdays" data-options="required:true" validType="ZNumber" /></td>
				
				    <td><span style="color: red;">*</span><label for="name">结束天数:</label></td>
					<td><input class="easyui-validatebox validatebox-invalid_input" type="text" name="enddays"
						id="enddays" data-options="required:true" validType="ZNumber" maxlength="5"/></td>
					
				</tr>
				<tr name ="pass">
				    <td><span style="color: red;">*</span><label for="password">提成百分比:</label></td>
					<td><input class="easyui-validatebox validatebox-invalid_input" data-options="required:true" validType="percentNumber" maxlength="16" type="text"
						name="pushpercent"  /></td>
					<td></td>
					<td></td>
				</tr>
			</table>
			<input type="hidden" name = "id" id = "id"/> 
			<input type="hidden" name = "businessId"  id = "businessId" value = "${param.businessId}"/> 
		</form>
		</div>
		<div id="dlg-buttons" style="display: none;clear:both">
	      <div class="text_input_button_cancel" onclick="javascript:$('#win').dialog('close')">取消</div>
          <div class="text_input_button_float" onclick="javascript:saveOrUpdate()">保存</div>
        
          
</div>
</body>
</html>