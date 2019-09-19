<%@ page language="java" pageEncoding="UTF-8"  import="org.owasp.esapi.ESAPI"%>
<!DOCTYPE HTML>
<html>
  <head>
  	
    <title>规则管理</title>
  <%@ include file="../common/header.jsp" %>
   <style type="text/css">
  		 body{height:100%; overflow:hidden; margin:0px; padding:0px;}
 	</style>
 	
  </head>
<body>
	        <form id="fmRuleEdit" method="post" style="margin-left: 20px">
	            
	             <div style="margin-top:10px">
	               	<input name="id" hidden="true" style="display:none;">
	            </div>
	            <div style="margin-bottom:10px">
	               	 <span style="color: red;">*</span> 规则名称<input name="rulename" class="easyui-textbox" style="width:50%" 
	               	 data-options="required:true,validateOnCreate:false,validateOnBlur:true">	              
	            </div>
	            <div style="margin-bottom:10px">
	               	 <span style="color: red;">*</span> 标识名称<input id="identification" name="identification" class="easyui-textbox validatebox" style="width:50%" 
	               	 data-options="required:true,validateOnCreate:false,validateOnBlur:true,validType:'maxLength[15]'">
	            </div>
	             <div style="margin-bottom:10px">
	               	 &nbsp;是否启用 <input type="radio" name="status" value='1' />启用
	               	    <input type="radio" name="status" value="0" />禁用
	            </div>
	            <div class="float_div" style="clear:both">
	                <div class="text_input_button_cancel" onclick="javascript:$('#divRule').window('close');">取消</div>
	                <div class="text_input_button_float" onclick="javascript:saveRole();">保存</div>
	            </div>
		</form>
	<script type="text/javascript">
 		$(function(){	 		   	
 			var ruleId = '<%=ESAPI.encoder().encodeForJavaScript(request.getParameter("ruleId"))%>';
 			var system = '<%=ESAPI.encoder().encodeForJavaScript(request.getParameter("isSystem"))%>';
 			
 			if(system == 1){
 				$("#identification").attr("disabled","disabled");
 			}
 			
 			if(! (ruleId == 'null')){
 				var selectPath = '<%=request.getContextPath()%>/couponRule/selectRule';
 	    		$.post(selectPath,{ruleId:ruleId},function(result){
 	    			if(result.success){
 	    			   $('#fmRuleEdit').form('load',result.rule);
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
		        $('#fmRuleEdit').form('submit',{
		            url: '<%=request.getContextPath()%>/couponRule/updateRule',
		            onSubmit: function(){
		                return $(this).form('validate');
		            },
		            success: function(result){
		                if (result == 1){
		                	$('#divRule').window('close');
		                	$('#dgRuleList').datagrid('load');
		                	$.messager.alert('操作提示','操作成功!');	
		                } else if (result == 0) {	
		                	$.messager.alert('操作提示','操作失败!');	
		                }
		                else{
		                	$.messager.alert('操作提示','规则名称/标识名称重复!');	
		                }
		            }
		        }); 
		    }
 		
 	</script>		
</body>
</html>
