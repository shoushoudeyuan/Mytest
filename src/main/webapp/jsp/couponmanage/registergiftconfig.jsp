<%@ page language="java" pageEncoding="UTF-8" import="org.owasp.esapi.ESAPI" %>
<html>
<head>
<title>注册用户赠</title>
<%@ include file="../common/header.jsp"%>
</head>
<body>
	
   <form id="fmRegister" style="padding:10px 20px">
   		<input type="hidden" id="configId" />
       <div class="form_item">
           <div class="form_item_inline">
               <label class="model_form_item_label7"><span class="mode_form_dot">*</span>启用状态</label>
               <div class="model_form_item_input" style="margin-top:5px">
                       <input type="radio" name="isValidate4Register" value=1 checked='checked' />启用 
                       <input type="radio" name="isValidate4Register" value=0 />禁用
               </div>
           </div>
       </div>
       <hr/>
       <div class="form_item" >
               <div class="form_item_inline" style="padding-left:12px">
                   <label class="model_form_item_label">
                       <span class="mode_form_dot" >
                            *请选择获得优惠券的条件，可选择一项或同时选择二项，选择二项代表用户必须达到二项条件才可获得，不选择代表不赠送；
                       </span>
                   </label>
               </div>
           </div>
       <div class="model_form_item">
           <div class="model_form_item_inline" style="padding-left:12px">
               
               <div class="model_form_item_input" style="width:300px">
                       <input type="checkbox" id="userRegistered" name="userRegistered" style="height:15px;width:15px;vertical-align:middle;"></input>用户注册成功
               </div>
           </div>
       </div>
       <div class="model_form_item">
           <div class="model_form_item_inline" style="padding-left:12px">
               <div class="model_form_item_input" style="width:300px">
                       <input type="checkbox" id="userIdentified" name="userIdentified" style="height:15px;width:15px;vertical-align:middle;"></input>身份认证成功
               </div>
           </div>
       </div>
       <div class="model_form_item">
           <div class="model_form_item_inline" style="padding-left:12px">
               <div class="model_form_item_input" style="width:300px">
                       <input type="checkbox" id="payDeposit" name="payDeposit" style="height:15px;width:15px;vertical-align:middle;"></input>保证金缴纳成功
               </div>
           </div>
       </div>
   </form>

   <div class="text_input_button_cancel" onclick="$('#dlgRegister').window('close')">取消</div>
   <div class="text_input_button_float" onclick="fmRegisterSubmit()">保存</div>

	<script>
		$(function(){
			var ec = '<%=ESAPI.encoder().encodeForJavaScript(request.getParameter("ec"))%>';
			var url = getRootPath_web()+"/giftconfig/getgiftconfig?ec="+ec;
			$.get(url).done(function(result){
				if(result.code != 100000){
					$.messager.alert('操作提示',"获取用户注册赠规则失败",'error');
					return;
				}
				
				if(result.data.isValidate == 1){
					$("input[name=isValidate4Register][value=1]").get(0).checked=true;
				}else{
					$("input[name=isValidate4Register][value=0]").get(0).checked=true;
				}
				
				$("#configId").val(result.data.id);
				if(result.data.userRegistered){
					$("#userRegistered").attr("checked",true);
				}
				
				if(result.data.userIdentified){
					$("#userIdentified").attr("checked",true);
				}
				
				if(result.data.payDeposit){
					$("#payDeposit").attr("checked",true);
				}
			});
		});
		
		function fmRegisterSubmit(){
			var isValidate = $("input[name='isValidate4Register']:checked").val();
			var userRegistered = $("#userRegistered").is(":checked");
			var userIdentified = $("#userIdentified").is(":checked");
			var payDeposit = $("#payDeposit").is(":checked");
			var id = $("#configId").val();
			
			var data = {id:id,isValidate:isValidate,userRegistered:userRegistered,userIdentified:userIdentified,payDeposit:payDeposit};
			var url = getRootPath_web()+'/giftconfig/saveregisterconfig';
			$.post(url,data).done(function(result){
				if(result.code == 100000){
					$.messager.alert('操作提示',"保存成功",'info',function(){
						giftConfig.list.search();
						$('#dlgRegister').window('close')
					});
				}else{
					$.messager.alert('操作提示',"保存失败",'error');
				}
			});
		}
	</script>
</body>
</html>