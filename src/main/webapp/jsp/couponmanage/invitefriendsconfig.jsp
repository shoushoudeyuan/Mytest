<%@ page language="java" pageEncoding="UTF-8" import="org.owasp.esapi.ESAPI" %>
<html>
<head>
<title>邀请好友赠</title>
<%@ include file="../common/header.jsp"%>
</head>
<body>
	<form id="fmInvite" style="padding:20px 10px 10px 30px">
		<input type="hidden" id="configId" />
       <div class="form_item">
           <div class="form_item_inline">
               <label class="model_form_item_label7"><span class="mode_form_dot">*</span>启用状态</label>
               <div class="model_form_item_input">
                       <input type="radio" name="isValidate4Invite" value=1 checked='checked' />启用 
                       <input type="radio" name="isValidate4Invite" value=0 />禁用
               </div>
           </div>
       </div>
       <hr/>
       <div class="form_item" style="margin-top:20px">
           <div class="form_item_inline" style="padding-left:12px">
               <label class="model_form_item_label">
                   <span class="mode_form_dot" >
                           A=邀请人，B=被邀请人，A邀请B，B注册成功后必须兑换邀请码进行绑定邀请关系，A和B是否都获得优惠券，以及获得的条件请选择；
                   </span>
               </label>
           </div>
       </div>
       <div class="form_item" >
           <div class="form_item_inline" style="padding-left:12px">
               <label class="model_form_item_label">
                   被邀请人获得优惠券条件
                   <span class="mode_form_dot" >
                         （至少选择一项，不选择代表不赠送被邀请人优惠券）
                   </span>
               </label>
           </div>
       </div>
       <div class="model_form_item">
           <div class="model_form_item_inline" style="padding-left:12px">
               
               <div class="model_form_item_input" style="width:350px">
                       <input type="checkbox" id="inviteeRegistedAndUseInviteCode4Invitee" style="height:15px;width:15px;vertical-align:middle;"></input>被邀请人注册成功并兑换邀请码绑定关系
               </div>
           </div>
       </div>
       <div class="model_form_item">
           <div class="model_form_item_inline" style="padding-left:12px">
               <div class="model_form_item_input" style="width:350px">
                       <input type="checkbox" id="inviteeIdentified4Invitee" style="height:15px;width:15px;vertical-align:middle;"></input>被邀请人身份认证成功
               </div>
           </div>
       </div>
       <div class="model_form_item">
           <div class="model_form_item_inline" style="padding-left:12px">
               <div class="model_form_item_input" style="width:300px">
                       <input type="checkbox" id="inviteePayDeposit4Invitee" style="height:15px;width:15px;vertical-align:middle;"></input>被邀请人缴纳保证金成功
               </div>
           </div>
       </div>

       <div class="form_item">
           <div class="form_item_inline" style="padding-left:12px">
               <label class="model_form_item_label">
                   邀请人获得优惠券条件
                   <span class="mode_form_dot" >
                         （至少选择一项，不选择代表不赠送邀请人优惠券）
                   </span>
               </label>
           </div>
           </div>
           <div class="model_form_item">
               <div class="model_form_item_inline" style="padding-left:12px">
                   
                   <div class="model_form_item_input" style="width:350px">
                           <input type="checkbox" id="inviteeIdentified4Inviter" style="height:15px;width:15px;vertical-align:middle;"></input>被邀请人身份认证成功
                   </div>
               </div>
           </div>
           <div class="model_form_item">
               <div class="model_form_item_inline" style="padding-left:12px">
                   <div class="model_form_item_input" style="width:350px">
                           <input type="checkbox" id="inviteePayDeposit4Inviter" style="height:15px;width:15px;vertical-align:middle;"></input>被邀请人缴纳保证金成功
                   </div>
               </div>
           </div>
           <div class="model_form_item">
               <div class="model_form_item_inline" style="padding-left:12px">
                   <div class="model_form_item_input" style="width:400px">
                           <input type="checkbox" id="inviteeFirstRentCarAndPayment4Inviter" style="height:15px;width:15px;vertical-align:middle;"></input>被邀请人首次用车行程≥
                           <input type="text" id="inviteeFirstDriverMileage4Inviter" style="width:50px;height:20px;border:1px solid rgba(233, 236, 243, 1);text-align:center"></input>公里，并订单支付成功
                   </div>
               </div>
           </div>
           <div class="form_item_inline" style="padding-left:12px">
                <span class="mode_form_dot" ><label class="model_form_item_label"> 注：邀请好友文案,请在基本设置-文本编辑修改；</label></span>
           </div>
   </form>
   
    <div class="text_input_button_cancel" onclick="$('#dlgInvite').window('close')">取消</div>
    <div class="text_input_button_float" onclick="fmInviteSubmit()">保存</div>
    
    <script type="text/javascript">
	$(function(){
		var ec = '<%=ESAPI.encoder().encodeForJavaScript(request.getParameter("ec"))%>';
		var url = getRootPath_web()+"/giftconfig/getgiftconfig?ec="+ec;
		$.get(url).done(function(result){
			if(result.code != 100000){
				$.messager.alert('操作提示',"获取邀请好友赠规则失败",'error');
				return;
			}
			
			if(result.data.isValidate == 1){
				$("input[name=isValidate4Invite][value=1]").get(0).checked=true;
			}else{
				$("input[name=isValidate4Invite][value=0]").get(0).checked=true;
			}
			
			$("#configId").val(result.data.id);
			if(result.data.inviteeRegistedAndUseInviteCode4Invitee){
				$("#inviteeRegistedAndUseInviteCode4Invitee").attr("checked",true);
			}
			
			if(result.data.inviteeIdentified4Invitee){
				$("#inviteeIdentified4Invitee").attr("checked",true);
			}
			
			if(result.data.inviteePayDeposit4Invitee){
				$("#inviteePayDeposit4Invitee").attr("checked",true);
			}
			
			if(result.data.inviteeIdentified4Inviter){
				$("#inviteeIdentified4Inviter").attr("checked",true);
			}
			
			if(result.data.inviteePayDeposit4Inviter){
				$("#inviteePayDeposit4Inviter").attr("checked",true);
			}
			
			if(result.data.inviteeFirstRentCarAndPayment4Inviter){
				$("#inviteeFirstRentCarAndPayment4Inviter").attr("checked",true);
				$("#inviteeFirstDriverMileage4Inviter").val(result.data.inviteeFirstDriverMileage4Inviter);
			}
		});
	});
	
	function fmInviteSubmit(){
		var id = $("#configId").val();
		var isValidate = $("input[name='isValidate4Invite']:checked").val();
		var inviteeRegistedAndUseInviteCode4Invitee = $("#inviteeRegistedAndUseInviteCode4Invitee").is(":checked");
		var inviteeIdentified4Invitee = $("#inviteeIdentified4Invitee").is(":checked");
		var inviteePayDeposit4Invitee = $("#inviteePayDeposit4Invitee").is(":checked");
		var inviteeIdentified4Inviter = $("#inviteeIdentified4Inviter").is(":checked");
		var inviteePayDeposit4Inviter = $("#inviteePayDeposit4Inviter").is(":checked");
		var inviteeFirstRentCarAndPayment4Inviter = $("#inviteeFirstRentCarAndPayment4Inviter").is(":checked");
		var inviteeFirstDriverMileage4Inviter = $.trim($("#inviteeFirstDriverMileage4Inviter").val());
		
		if(inviteeFirstRentCarAndPayment4Inviter && inviteeFirstDriverMileage4Inviter == ''){
			$.messager.alert('操作提示',"填写行驶里程",'warn')
			return;
		}else if(!inviteeFirstRentCarAndPayment4Inviter){
			inviteeFirstDriverMileage4Inviter = null;
		}
		
		var data = {id:id,isValidate:isValidate,
				inviteeRegistedAndUseInviteCode4Invitee:inviteeRegistedAndUseInviteCode4Invitee,
				inviteeIdentified4Invitee:inviteeIdentified4Invitee,
				inviteePayDeposit4Invitee:inviteePayDeposit4Invitee,
				inviteeIdentified4Inviter:inviteeIdentified4Inviter,
				inviteePayDeposit4Inviter:inviteePayDeposit4Inviter,
				inviteeFirstRentCarAndPayment4Inviter:inviteeFirstRentCarAndPayment4Inviter,
				inviteeFirstDriverMileage4Inviter:inviteeFirstDriverMileage4Inviter
		};
		var url = getRootPath_web()+'/giftconfig/saveinvitefriends';
		$.post(url,data).done(function(result){
			if(result.code == 100000){
				$.messager.alert('操作提示',"保存成功",'info',function(){
					giftConfig.list.search();
					$('#dlgInvite').window('close')
				});
			}else{
				$.messager.alert('操作提示',"保存失败",'error');
			}
		});
	}
</script>
</body>

</html>