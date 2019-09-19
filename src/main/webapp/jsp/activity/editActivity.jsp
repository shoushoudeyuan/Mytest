<%@ page language="java" pageEncoding="UTF-8" import="org.owasp.esapi.ESAPI" %>
<!DOCTYPE HTML>
<html>
<head>

<title>活动管理</title>
<meta http-equiv="Content-Security-Policy" content="default-src * data: cdvfile: gap:; style-src * 'unsafe-inline'; script-src * 'unsafe-inline' 'unsafe-eval'"/>
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
	<div class="text_input">
		<form id="fmEdit" method="post">
			<div class="model_form_item">
				<div class="model_form_item_inline_left">
					<label class="model_form_item_label5">
						<span class="mode_form_dot">*</span>
						活动名称
					</label>
					<div class="model_form_item_input">
						<input name="id" hidden="true" style="display:none;"> <input type="hidden" name="activitylink" />
						<input name="activityname" class="easyui-textbox" style="width: 50%" data-options="required:true,validateOnCreate:false,validateOnBlur:true">
						
					</div>
				</div>
				<div class="model_form_item_inline_right">
					<label class="model_form_item_label5">
						<span class="mode_form_dot">*</span>
						规　　则
					</label>
					<div class="model_form_item_input">
						<input id="couponruleid" name="couponruleid" style="width: 50%;" class="easyui-combobox" data-options="required:true,validateOnCreate:false,validateOnBlur:true">
					</div>
				</div>
			</div>
			<div class="model_form_item">
				<div class="model_form_item_inline_left">
					
					<label class="model_form_item_label5">
						<span class="mode_form_dot">*</span>
						生效时间
					</label>
					<div class="model_form_item_input">
						<input id="startdate" name="startdate" hidden="true"  editable="true" class="easyui-datetimebox" style="width: 50%" data-options="required:true,validateOnCreate:false,validateOnBlur:true,validType:'dateTime'" />
					</div>
				</div>
				<div class="model_form_item_inline_right">
					<label class="model_form_item_label5">
						<span class="mode_form_dot">*</span>
						失效时间
					</label>
					<div class="model_form_item_input">
						<input id='enddate' name="enddate" class="easyui-datetimebox"  editable="true" style="width: 50%" data-options="required:true,validateOnCreate:false,validType:'dateTime'">
					</div>
				</div>
			</div>
			<div class="model_form_item">
				<div class="model_form_item_inline_left">
					<label class="model_form_item_label5">启　　用</label>
					<div class="model_form_item_input">
						<input type="radio" name="isdisable" value='1' />是 
						<input type="radio" name="isdisable" value="0" />否
					</div>
				</div>
				<div class="model_form_item_inline_right">
					<label class="model_form_item_label5">发　　布</label>
					<div class="model_form_item_input">
						<input type="radio" name="ispublish" value='1' />是 
						<input type="radio" name="ispublish" value="0" />否
					</div>
				</div>
			</div>
			<div class="model_form_item">
				<div class="model_form_item_inline_left">
					<label class="model_form_item_label5">
						<span class="mode_form_dot">*</span>
						兑换限制
					</label>
					<div class="model_form_item_input">
						<select id="exchangelimit" name="exchangelimit" style="width: 50%;" class="easyui-combobox">
							<option value="0">无限制</option>
							<option value="1">活动期间注册用户</option>
						</select> 
					</div>
				</div>
				<div class="model_form_item_inline_right">
					<label class="model_form_item_label5">备　　注</label>
					<div class="model_form_item_input">
						<input name="remark" class="easyui-textbox" style="width: 50%" />
					</div>
				</div>
			</div>
			<div  class="model_form_item_inline div_button">
				<div class="text_input_button_cancel"
					onclick="$('#dlg_edit').window('close');">取消</div>
				<div class="text_input_button_float"
					onclick="saveActivity();">保存</div>
			</div>
		</form>
	
	</div>
	
	
	<!-- <div style="width: 85%; margin: 0px auto; margin-top: 20px;">
		<form id="fmEdit" method="post">
			<input name="id" hidden="true" style="display:none;"> <input type="hidden"
				name="activitylink" />
			<div style="margin-bottom: 10px">
				活动名称<input name="activityname" class="easyui-textbox"
					style="width: 50%"
					data-options="required:true,validateOnCreate:false,validateOnBlur:true">
				<span style="color: red;">*</span>
			</div>
			<div style="margin-bottom: 10px">
				规　　则<input id="couponruleid" name="couponruleid" style="width: 50%;"
					class="easyui-combobox"
					data-options="required:true,validateOnCreate:false,validateOnBlur:true">
				<span style="color: red;">*</span>
			</div>
			<div style="margin-bottom: 10px">
				生效时间<input id="startdate" name="startdate" hidden="true"  editable="true"
					class="easyui-datetimebox" style="width: 50%"
					data-options="required:true,validateOnCreate:false,validateOnBlur:true,validType:'dateTime'" />
				生效时间<input id="startdate" name="startdate" hidden="true"  editable="true"
				class="easyui-datetimebox" style="width: 50%"
				data-options="required:true,validateOnCreate:false,validateOnBlur:true,validType:'formatValidate'" />
				<span style="color: red;">*</span>
			</div>
			<div style="margin-bottom: 10px">
				失效时间<input id='enddate' name="enddate" class="easyui-datetimebox"  editable="true"
					style="width: 50%"
					data-options="required:true,validateOnCreate:false,validType:'dateTime'">
				<span style="color: red;">*</span>
			</div>
			<div style="margin-bottom: 10px">
				启　　用&nbsp;<input type="radio" name="isdisable" value='1' />是 <input
					type="radio" name="isdisable" value="0" />否
			</div>
			<div style="margin-bottom: 10px">
				发　　布&nbsp;<input type="radio" name="ispublish" value='1' />是 <input
					type="radio" name="ispublish" value="0" />否
			</div>
			<div style="margin-bottom: 10px">
				兑换限制<select id="exchangelimit" name="exchangelimit"
					style="width: 50%;" class="easyui-combobox">
					<option value="0">无限制</option>
					<option value="1">活动期间注册用户</option>
				</select> <span style="color: red;">*</span>
			</div>
			<div style="margin-bottom: 10px">
				备　　注<input name="remark" class="easyui-textbox" style="width: 50%" />
			</div>
			<div style="width: 110%;clear:both" class="div_button">
				<div class="text_input_button_cancel"
					onclick="$('#dlg_edit').window('close');">取消</div>
				<div class="text_input_button_float"
					onclick="saveActivity();">保存</div>
				

			</div>
		</form>

	</div> -->
	<script type="text/javascript">
 		$(function(){
 			var requestUrl="<%=request.getContextPath()%>/couponRule/getCouponRuleKeyValueList";
	    	$('#couponruleid').combobox({    
			    url:requestUrl,    
			    valueField:'id',    
			    textField:'rulename'
			})
 			var activityId = '<%=ESAPI.encoder().encodeForJavaScript(request.getParameter("activityId"))%>';
 			if(! (activityId == 'null')){
 				var selectPath = '<%=request.getContextPath()%>/activity/getActivity';
 	    		$.post(selectPath,{activityId:activityId},function(result){
 	    			if(result){
 	    			   $('#fmEdit').form('load',result);
 	    			}else{
 	    				$.messager.alert('操作提示','查询活动失败!');
 	    			}
 	    			
 	    		},'json');
 			}else{
 				$.each($("input[name='isdisable']"),function(i,v){
 	 	        	if(1==v.value){
 	 	        		v.checked='checked';
 	 	        	}
 	 	        });
 				$.each($("input[name='ispublish']"),function(i,v){
 	 	        	if(1==v.value){
 	 	        		v.checked='checked';
 	 	        	}
 	 	        });
 			}
 			
 		});
 		//比较日期日期大小(dt1>dt2返回false,否则返回true)
 		function dateCompare(dt1,dt2){
 			var starttime = new Date(dt1);
			var endtime = new Date(dt2);
			if (Date.parse(starttime) > Date.parse(endtime)) {
				return false;
			} else {
				return true;
			}
 		}
 		function saveActivity(){
 			/* var st=$('input[name="startdate"]').datetimebox('getValue');
 			var et=$('input[name="enddate"]').datetimebox('getValue');
 			if(!dateCompare(st,et)){
 				$.messager.alert('操作提示','失效时间不得小于 生效时间');
 				return;
 	    	} */
 	        $('#fmEdit').form('submit',{
 	            url: '<%=request.getContextPath()%>/activity/saveActivity',
				onSubmit : function(param) {
					var res=$(this).form('validate');
					if(res){
						var st=$("#startdate").datetimebox('getValue');
			 			var et=$('#enddate').datetimebox('getValue');
			 			if(dateCompare(st,et)==false){
			 				$.messager.alert('操作提示','失效时间不得小于 生效时间');
			 				return false;
			 	    	} 
					}
					return res;
				},
				success : function(result) {
					if (result <= 0) {
						$.messager.alert('操作提示','保存失败!');
					} else {
						$.messager.alert('操作提示','保存成功!');
						search();
						$('#dlg_edit').window('close');
					}
				}
			});
		}
 		
	</script>
	<script>
	//这个方法的兼容性不太好,ie9不支持.暂时不用.
/*validType:'dateCompare[$(\'#startdate\').datetimebox(\'getValue\')]'">*/
		//比较两个日期的大小(true:开始日期小于或等于结束日期;false:开始日期大于结束日期)
// 		$.extend($.fn.validatebox.defaults.rules, {
// 			dateCompare: {
// 				validator : function(value, param) {
// 					var starttime = new Date(param[0]);
// 					var endtime = new Date(value);
// 						return false;
// 					if (Date.parse(starttime) > Date.parse(endtime)) {
// 						return false;
// 					} else {
// 						return true;
// 					}
// 				},
// 				//message : '失效时间不得小于 生效时间:{0}.'
// 				message : '失效时间不得小于 生效时间'
// 			},
// 			formatValidate:{//校验输入格式是否正确
// 				validator:function(value){
// 					try{
// 						var date = new Date(value)						
// 						if(date==null || date=='Invalid Date'){
// 							return false;
// 						}
// 						return true;
// 					}
// 					catch(Exception){
// 						return false;
// 					}
// 				},
// 				message:'日期格式不正确'
// 			}
// 		}); 

	</script>

</body>
</html>
