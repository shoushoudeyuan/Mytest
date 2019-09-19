<%@ page language="java" pageEncoding="UTF-8" import="org.owasp.esapi.ESAPI" %>
<html>
<head>
<title>首次成为企业会员赠</title>
<%@ include file="../common/header.jsp"%>
</head>
<body>
	<form id="fmRegisterMember" method="post" style="padding:20px 10px 10px 30px">
		<input type="hidden" id="configId" />
       <div class="form_item">
           <div class="form_item_inline">
               <label class="model_form_item_label7"><span class="mode_form_dot">*</span>启用状态</label>
               <div class="model_form_item_input">
                    <input type="radio" name="isValidate4RegisterMember" value=1 checked='checked' />启用 
                    <input type="radio" name="isValidate4RegisterMember" value=0 />禁用
               </div>
           </div>
       </div>
       <hr/>
       <div class="form_item" style="margin-top:20px">
           <div class="form_item_inline" style="padding-left:12px">
               <label class="model_form_item_label">
                   <span class="mode_form_dot" >
                           *请选择获得优惠券的条件，可选择一项或同时选择二项，选择二项代表用户<br/>
                           必须达到二项条件才可获得；
                   </span>
               </label>
           </div>
       </div>
       <div class="model_form_item">
           <div class="model_form_item_inline" style="padding-left:12px">
               <div class="model_form_item_input" style="width:350px">
                       <input type="checkbox" id="registerEntMember" style="height:15px;width:15px;vertical-align:middle;"></input>首次成为企业会员
               </div>
           </div>
       </div>
       <div class="model_form_item">
           <div class="model_form_item_inline" style="padding-left:12px">
               <div class="model_form_item_input" style="width:450px">
                   <input type="checkbox" id="firstOrderAndPayment" style="height:15px;width:15px;vertical-align:middle;"></input>企业会员首次用车行程≥ 
                   <input type="text" id="firstOrderMileage4Ent" value="5" style="width:50px;height:20px;border:1px solid rgba(233, 236, 243, 1);text-align:center"></input>公里，并订单支付成功
                    </div>
                </div>
       </div>
	</form>

    <div class="text_input_button_cancel" onclick="$('#dlgRegisterMember').window('close')">取消</div>
    <div class="text_input_button_float" onclick="fmRegisterMemberSubmit()">保存</div>

	<script type="text/javascript">
		$(function(){
			var ec = '<%=ESAPI.encoder().encodeForJavaScript(request.getParameter("ec"))%>';
			var url = getRootPath_web()+"/giftconfig/getgiftconfig?ec="+ec;
			$.get(url).done(function(result){
				if(result.code != 100000){
					$.messager.alert('操作提示',"获取首次成为企业会员赠规则失败",'error');
					return;
				}
				
				if(result.data.isValidate == 1){
					$("input[name=isValidate4RegisterMember][value=1]").get(0).checked=true;
				}else{
					$("input[name=isValidate4RegisterMember][value=0]").get(0).checked=true;
				}
				
				$("#configId").val(result.data.id);
				if(result.data.registerEntMember){
					$("#registerEntMember").attr("checked",true);
				}
				
				if(result.data.firstOrderAndPayment){
					$("#firstOrderAndPayment").attr("checked",true);
					$("#firstOrderMileage4Ent").val(result.data.firstOrderMileage);
				}
			});
		});
		
		function fmRegisterMemberSubmit(){
			var id = $("#configId").val();
    		var isValidate = $("input[name='isValidate4RegisterMember']:checked").val();
    		var registerEntMember = $("#registerEntMember").is(":checked");
    		var firstOrderAndPayment = $("#firstOrderAndPayment").is(":checked");
    		var firstOrderMileage = $.trim($("#firstOrderMileage4Ent").val());
    		
    		if(firstOrderAndPayment && firstOrderMileage == ''){
    			$.messager.alert('操作提示',"填写行驶里程",'warn')
    			return;
    		}else if(!firstOrderAndPayment){
    			firstOrderMileage = null;
    		}
    		
    		var data = {id:id,isValidate:isValidate,registerEntMember:registerEntMember,firstOrderAndPayment:firstOrderAndPayment,firstOrderMileage:firstOrderMileage};
    		var url = getRootPath_web()+'/giftconfig/saveregisterentmemberconfig';
    		$.post(url,data).done(function(result){
    			if(result.code == 100000){
    				$.messager.alert('操作提示',"保存成功",'info',function(){
    					giftConfig.list.search();
    					$('#dlgRegisterMember').window('close')
    				});
    			}else{
    				$.messager.alert('操作提示',"保存失败",'error');
    			}
    		});
		}
	</script>
</body>
</html>