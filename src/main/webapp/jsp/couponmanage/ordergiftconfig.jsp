<%@ page language="java" pageEncoding="UTF-8" import="org.owasp.esapi.ESAPI" %>
<html>
<head>
<title>订单满额赠</title>
<%@ include file="../common/header.jsp"%>
</head>
<body>
	<form id="fmOrderGift" style="padding:20px 10px 10px 30px">
         <input type="hidden" id="configId" />
         <div class="form_item">
             <div class="form_item_inline">
                 <label class="model_form_item_label7"><span class="mode_form_dot">*</span>启用状态</label>
                 <div class="model_form_item_input">
                 	<input type="radio" name="isValidate4Order" value=1 checked='checked' />启用 
                    <input type="radio" name="isValidate4Order" value=0 />禁用
                 </div>
             </div>
         </div>
         <hr/>
         <div class="form_item" style="margin-top:20px">
             <div class="form_item_inline" style="padding-left:12px">
                 <label class="model_form_item_label">
                     <span class="mode_form_dot" >
                             *请选择获得优惠券的条件，单选必须选择一项条件；
                     </span>
                 </label>
             </div>
         </div>
        
         <div class="model_form_item">
             <div class="model_form_item_inline" style="padding-left:12px">
                 <div class="model_form_item_input" style="width:350px">
                         <input type="radio" name="costMode" value=1 checked='checked' style="height:15px;width:15px;vertical-align:middle;"></input>按订单应付金额
                 </div>
             </div>
         </div>
         <div class="model_form_item">
             <div class="model_form_item_inline" style="padding-left:12px">
                 <div class="model_form_item_input" style="width:350px">
                         <input type="radio" name="costMode" value=2 style="height:15px;width:15px;vertical-align:middle;"></input>按订单实付金额 
                 </div>
             </div>
         </div>
         <div class="form_item">
                 <div class="form_item_inline" style="padding-left:12px">
                     <label class="model_form_item_label">
                         <span class="mode_form_dot" >
                             *请选择获得优惠券的条件，不打勾不生效，打钩后默认值为100，可修改；
                         </span>
                     </label>
                 </div>
             </div>
             <div class="model_form_item">
                 <div class="model_form_item_inline" style="padding-left:12px">
                     <div class="model_form_item_input" style="width:400px">
                         <input type="checkbox" id="giftByPaymentOrderCost" style="height:15px;width:15px;vertical-align:middle;"></input>订单金额≥ <input id="orderCost" value="100" style="width:50px;height:20px;border:1px solid rgba(233, 236, 243, 1);text-align:center"></input>元，并支付成功
                     </div>
                 </div>
             </div>
     </form>
     <div class="text_input_button_cancel" onclick="$('#dlgOrder').window('close')">取消</div>
     <div class="text_input_button_float" onclick="fmOrderGiftSubmit()">保存</div>
     
	<script type="text/javascript">
     	$(function(){
     		var ec = '<%=ESAPI.encoder().encodeForJavaScript(request.getParameter("ec"))%>';
			var url = getRootPath_web()+"/giftconfig/getgiftconfig?ec="+ec;
			$.get(url).done(function(result){
				if(result.code != 100000){
					$.messager.alert('操作提示',"获取订单满额赠规则失败",'error');
					return;
				}
				
				if(result.data.isValidate == 1){
					$("input[name=isValidate4Order][value=1]").get(0).checked=true;
				}else{
					$("input[name=isValidate4Order][value=0]").get(0).checked=true;
				}
				
				$("#configId").val(result.data.id);
				if(result.data.costMode == 1){
					$("input[name=costMode][value=1]").get(0).checked=true;
				}else{
					$("input[name=costMode][value=2]").get(0).checked=true;
				}
				
				if(result.data.giftByPaymentOrderCost){
					$("#giftByPaymentOrderCost").attr("checked",true);
					$("#orderCost").val(result.data.orderCost);
				}
			});
     	});
     	
     	function fmOrderGiftSubmit(){
     		var id = $("#configId").val();
    		var isValidate = $("input[name='isValidate4Order']:checked").val();
    		var costMode = $("input[name='costMode']:checked").val();
    		var giftByPaymentOrderCost = $("#giftByPaymentOrderCost").is(":checked");
    		var orderCost = $.trim($("#orderCost").val());
    		
    		if(giftByPaymentOrderCost && orderCost == ''){
    			$.messager.alert('操作提示',"填写订单金额",'warn')
    			return;
    		}else if(!giftByPaymentOrderCost){
    			orderCost = null;
    		}
    		
    		var data = {id:id,isValidate:isValidate,costMode:costMode,giftByPaymentOrderCost:giftByPaymentOrderCost,orderCost:orderCost};
    		var url = getRootPath_web()+'/giftconfig/saveordergiftconfig';
    		$.post(url,data).done(function(result){
    			if(result.code == 100000){
    				$.messager.alert('操作提示',"保存成功",'info',function(){
    					giftConfig.list.search();
    					$('#dlgOrder').window('close')
    				});
    			}else{
    				$.messager.alert('操作提示',"保存失败",'error');
    			}
    		});
     	}
	</script>
</body>
</html>