<%@ page language="java" pageEncoding="UTF-8" import="org.owasp.esapi.ESAPI"%>
<!DOCTYPE HTML>
<html>
  <head>
  	
    <title>修改积分规则</title>
  <%@ include file="../common/header.jsp" %>
   <style type="text/css">
  		 body{height:100%; overflow:hidden; margin:0px; padding:0px;}
 	</style>
 	
  </head>
<body>
	        <form id="fmIntegralRuleEdit" method="post" style="margin-left: 20px">
	            <input type="hidden" name="csrftoken" value="<%=session.getAttribute("csrftoken").toString()%>"/>
	             <div style="margin-top:10px">
	               	<input name="id" hidden="true" style="display:none;">
	               	<input name="sendtype" hidden="true" style="display:none;">
	            </div>
	            <div style="margin-bottom:10px">
	               	 &nbsp;规则描述:<input name="description" class="easyui-textbox"  style="width:50%;border-left:0px;border-top:0px;border-right:0px;border-bottom:1px;" readonly="readonly">
	               	 
	            </div>
	            <div style="margin-bottom:10px">
	               	 <span style="color: red;">*</span> 消费金额:<input name="costmoney" class="easyui-validatebox easyui-numberbox" style="width:50%" validType="length[1,6]">
	            </div>
	            <div style="margin-bottom:10px">
	               	 <span style="color: red;">*</span> 兑换积分:<input name="sendscore" class="easyui-validatebox easyui-numberbox" style="width:50%" 
	               	 data-options="required:true,validateOnCreate:false,validateOnBlur:true" validType="length[1,6]">
	            </div>
	             <div style="margin-bottom:10px">
	               	 &nbsp;是否启用:&nbsp;<input type="radio" name="status" value='1' />启用
	               	    <input type="radio" name="status" value="0" />禁用
	            </div>
	            <div class="float_div" style="clear:both">
	                <div class="text_input_button_cancel" onclick="javascript:$('#divIntegralRule').window('close');">取消</div>
	                <div class="text_input_button_float" onclick="javascript:saveRole();">保存</div>
	            </div>
		</form>
	<script type="text/javascript">
 		$(function(){	 		   	
 			var ruleId = '<%=ESAPI.encoder().encodeForJavaScript(request.getParameter("ruleid"))%>';
 			if(! (ruleId == 'null')){
 				var selectPath = '<%=request.getContextPath()%>/integralRule/selectIntegralRule';
 	    		$.post(selectPath,{ruleId:ruleId},function(result){
 	    			if(result.success){
 	    			   $('#fmIntegralRuleEdit').form('load',result.rule);
 	    			}else{
 	    				$.messager.alert('操作提示','查询规则错误!');
 	    			}
 	    			
 	    		},'json');
 			}else{
 				$.each($("input[name='status']"),function(i,v){
 	 	        	if(1==v.value){
 	 	        		v.checked='checked';
 	 	        	}
 	 	        });
 			}
 			
 			
 			
 		});
 		
		  function saveRole(){
		        $('#fmIntegralRuleEdit').form('submit',{
		            url: '<%=request.getContextPath()%>/integralRule/updateIntegralRule',
		            onSubmit: function(){
		                return $(this).form('validate');
		            },
		            success: function(result){
		                if (result == 1){
		                	$('#divIntegralRule').window('close');
		                	$('#dgScoreRuleList').datagrid('load');
		                	$.messager.alert('操作提示','操作成功!');	
		                } else if (result == 0) {	
		                	$.messager.alert('操作提示','操作失败!');	
		                }
		                else{
		                	$.messager.alert('操作提示','规则名称重复!');	
		                }
		            }
		        }); 
		    }
 		
 	</script>		
</body>
</html>
