<%@ page language="java" pageEncoding="UTF-8" import="org.owasp.esapi.ESAPI"%>
<!DOCTYPE HTML>
<html>
<head>

<title>编辑车辆任务规则</title>
<%@ include file="../common/header.jsp"%>
<style type="text/css">
body {
	height: 100%;
	overflow: hidden;
	margin: 0px;
	padding: 0px;
}
</style>

</head>
<body>
	<div style="width: 85%; margin: 0px auto; margin-top: 20px;">
		<form id="fmEdit">
			<input type="hidden" name="csrftoken" value="<%=session.getAttribute("csrftoken").toString()%>"/>
			<input type="hidden" id="id" name="id" /> 
			<input type="hidden" name="vehicleruleid" value="<%=ESAPI.encoder().encodeForHTML(request.getParameter("ruleId"))%>" />
			<input type="hidden" id="tasktype" name="tasktype" /> 
			<div style="margin-bottom: 10px; text-align: right; padding-right: 35px;">
				<span style="color: red;">*</span>任务类型<input id="tasktype1" name="tasktype1"  class="easyui-textbox"
					style="width: 50%" disabled="disabled" 
					data-options="required:true,validateOnCreate:false,validateOnBlur:true,validType:['tasktype','tasktype']">
				
			</div>
			<div style="margin-bottom: 10px; text-align: right; padding-right: 35px;">
                <span style="color: red;">*</span>倒计时时长（分）<input id="timedistance" name="timedistance" class="easyui-numberbox"
					style="width: 50%"
					data-options="required:true,validateOnCreate:false,validateOnBlur:true,validType:['numberws','isBlank']">
			</div>
			
			
		</form>

	</div>
			<div style="width: 100%;clear:both" class="div_button">
				<div class="text_input_button_cancel"
					onclick="$('#dlg_edit').window('close');">取消</div>
				<div class="text_input_button_float"
					onclick="saveTask();">保存</div>
		</div>
	<script type="text/javascript">
 		$(function(){
 			var ruleItemId = '<%=ESAPI.encoder().encodeForJavaScript(request.getParameter("ruleId"))%>';
 			var ruletype = '<%=ESAPI.encoder().encodeForJavaScript(request.getParameter("task"))%>';
 			if(ruletype==0){
 				$('#tasktype1').val('充电');
 			}
 			else if(ruletype==1){
 				$('#tasktype1').val('调度');
 			}
 			else if(ruletype==2){
 				$('#tasktype1').val('整备');
 			}else if(ruletype==3){
                $('#tasktype1').val('加油');
            }
 			
 			
 			if(! (ruleItemId == 'null')){
 				
 				var selectPath = '/bjyvms/taskRuleInfo/select';
 	    		$.post(selectPath,{ruleItemId:ruleItemId},function(result){
 	    			
	    			
 	    			if(result){
 	    				$('#fmEdit').form('load',result.taskrule);
 	    				
 	    			 
 	    			 }else{
 	    				$.messager.alert('操作提示','查询失败!');
 	    			}
 	    			
 	    			
 	    			
 	    		},'json');
 	    		
 	    		
 	 			
 		
 			}
 			else{
 				$.each($("input[name='isenablecoupon']"),function(i,v){
 	 	        	if(1==v.value){
 	 	        		v.checked='checked';
 	 	        	}
 	 	        });
 				
 				
 			}
 			
 			
 		});
 		
 	
 		
 		  function saveTask(){
			 var tasktype = $('#tasktype').val();
			 var timedistance = $('#timedistance').val();
			var id = $('#id').val();
		
			 $('#fmEdit').form('submit',{
		            url: '/bjyvms/taskRuleInfo/update?tasktype='+tasktype+'&timedistance='+timedistance+'&id='+id,
		           
		            onSubmit: function(){
		            	if($(this).form('validate')){
		            		
		            		submitFlag = true;
		            		return true;
		            	}else{
		            		
		            		return false;
		            	}
		            	
		                
		            },
		            success: function(result){
		            	result = eval('('+result+')');
		            	 if (!result.success){
		            		 alert(result.success);
                        	 return;  
                        	 
                         } else{
                        	 $('#dg').datagrid('reload');
	   	                	 $('#dlg_edit').dialog('close')
	   	                	 $.messager.alert('操作提示','操作成功!');
                         }
		            }
		        }); 
			 
			}
		
 		
 	
	</script>

</body>
</html>
