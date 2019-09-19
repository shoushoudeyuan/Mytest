<%@ page language="java" pageEncoding="UTF-8" import="org.owasp.esapi.ESAPI"%>
<!DOCTYPE HTML>
<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>添加审核设置</title>
<%@ include file="../common/header.jsp"%>
<style type="text/css">
body {
	height: 100%;
	overflow: hidden;
	margin: 0px;
	padding: 0px;
}
</head>
<body>
	<form id="fmAuditEdit" method="post" style="margin-left: 20px">
		<div style="margin-top: 10px; text-align: right;">
			<input name="id" hidden="true" style="display: none;"> <input
				name="couponcode" hidden="true" style="display: none;">
		</div>
		<table width="95%" border="0" cellspacing="0" cellpadding="0"
			class="pop_table" style="margin: 0px !important;">
			<tr>
				<td><span style="color: red;">*</span>级别名称</td>
				<td><input name="classname" class="easyui-textbox validatebox"
					style="width: 200px;"
					data-options="required:true,validateOnCreate:false,validateOnBlur:true,validType:'maxLength[20]'">
					</td>
			</tr>
			<tr>
				<td><span style="color: red;">*</span>服务城市</td>
				<td>
					<select id="cityid" name="cityid" class="easyui-combobox"
					style="width: 200px;"></select>
				</td>
			</tr>
			<tr>
				<td><span style="color: red;">*</span>积分小于</td>
				<td><input name="score" class="easyui-numberbox validatebox"
					style="width: 200px;"
					data-options="validateOnCreate:false,validateOnBlur:true,validType:'maxLength[6]'"></td>
			</tr>
	 		<tr>
				<td><span style="color: red;">*</span>适用类型</td>
				<td><select id="classtype" name="classtype"
					class="easyui-combobox" style="width: 200px;">
						<option value="0">拒绝</option>
						<option value="1">通过</option>
				</select></td>
			</tr>			
		</table>
		<div class="float_div">
			<div class="text_input_button_float button_margin"
				onclick="javascript:saveAudit();">保存</div>
			<div class="text_input_button_float button_margin"
				onclick="javascript:$('#divAudit').window('close');">取消</div>

		</div>
	</form>
	<script type="text/javascript">
	$(function(){		    	
    	$("#classtype").combobox({
    		editable: false
    	});
    	
    	var varAuditId = '<%=ESAPI.encoder().encodeForJavaScript(request.getParameter("auditId"))%>';
 			
 			if(! (varAuditId == 'null')){
 				var selectPath = '<%=request.getContextPath()%>/auditCus/selectAuditCustomer';
 	    		$.post(selectPath,{auditId:varAuditId},function(result){
 	    			if(result.success){
 	    			   $('#fmAuditEdit').form('load',result.cusaudit);

 	    			   //初始化服务城市
				    	$("#cityid").combobox({
				    		url:'<%=request.getContextPath()%>/city/getServiceCityList?id='+result.cusaudit.cityid,
				    		editable: false,
				    		valueField:'id',
				    		textField:'showname'
				    	});
 	    			}else{
 	    				$.messager.alert('操作提示','查询审核设置错误!');
 	    			}
 	    			
 	    		},'json');
 			}else{
 				//初始化服务城市
		    	$("#cityid").combobox({
		    		url:'<%=request.getContextPath()%>/city/getServiceCityList',
		    		editable: false,
		    		valueField:'id',
		    		textField:'showname'
		    	});
    	
 				$.each($("input[name='status']"),function(i,v){
 	 	        	if(1==v.value){
 	 	        		v.checked='checked';
 	 	        	}
 	 	        });
 			}
	});

	function saveAudit()
	{
		 $('#fmAuditEdit').form('submit',{
	            url: '<%=request.getContextPath()%>/auditCus/addAuditCustomer',
	            onSubmit: function(){
	            	if($("#cityid").combobox('getValue')=='-1')
					{
						//alert("请选择服务城市");
						$.messager.alert("操作提示", "请选择服务城市",""); 
						return false;
					}
	            	
	            	if(!$(this).form('validate'))
	            	{
	            		return false; 
	            	}            		           
	            },
	            success: function(result){
	                if (result==0){
	                	$.messager.alert("操作提示", "添加失败!");
	                } else if(result==1) {
	                	$.messager.alert("操作提示", "添加成功!");
	                	$('#dgAuditList').datagrid('reload'); // reload the user data
	                	$('#divAudit').window('close');	
	                }else if(result==2)
                	{
                		$.messager.alert("操作提示", "级别名称不能重复");
                	}
	            }
	        }); 
	}
	</script>
</body>
</html>