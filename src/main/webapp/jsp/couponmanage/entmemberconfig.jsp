<%@ page language="java" pageEncoding="UTF-8" import="org.owasp.esapi.ESAPI"%>
<html>
<head>
<title>企业会员按时间赠</title>
<%@ include file="../common/header.jsp"%>
</head>
<body>
	<form id="fmEntMember" method="post" style="padding:20px 10px 10px 30px">
        <input type="hidden" id="configId" />                  
         <div class="form_item">
             <div class="form_item_inline">
                 <label class="model_form_item_label7"><span class="mode_form_dot">*</span>启用状态</label>
                 <div class="model_form_item_input">
                      <input type="radio" name="isValidate4EntMember" value=1 checked='checked' />启用 
                    <input type="radio" name="isValidate4EntMember" value=0 />禁用
                 </div>
             </div>
         </div>
         <hr/>
         <div class="form_item" style="margin-top:20px">
             <div class="form_item_inline" style="padding-left:12px">
                 <label class="model_form_item_label">
                     <span class="mode_form_dot" >
                             *请选择赠送的企业，未被打钩的不会赠送优惠券；
                     </span>
                 </label>
             </div>
         </div>
         <div id="divCity" class="model_form_item"></div>
         <div class="form_item" style="margin-top:20px">
             <div class="form_item_inline" style="padding-left:12px">
                 <label class="model_form_item_label">
                     <span class="mode_form_dot" >
                             *请选择赠送日期，定期会自动给企业会员发放优惠券；
                     </span>
                 </label>
             </div>
         </div>
         <div class="model_form_item">
             <div class="model_form_item_inline">
                 <label class="model_form_item_label4">发放日期</label>
                 <div class="model_form_item_input" style="font-size:14px">
                         <input type="text" id="firstGiftDate" name="giftDate" class="easyui-datebox" width="100%!important;text-align:center" value="2018-05-01"></input>
                 </div>
               
             </div>
             <div class="form_item_inline" style="float:right;margin-right:0">
                 <div class="text_input_button_add" onclick="addDate()">增加</div>
             </div>
         </div>
         <div id="divNewDate"></div>
         <div id="templateDate" class="model_form_item">
             <div class="model_form_item_inline">
                 <label class="model_form_item_label4">发放日期</label>
                 <div class="model_form_item_input" style="font-size:14px">
                         <input type="text" name="giftDate" class="easyui-datebox" width="100%!important;text-align:center" value="2018-05-02"></input>
                 </div>
             </div>
             <div class="form_item_inline">
                 <div class="text_input_button_add" style="color:red;border:1px solid red;" onclick="deleteDate(this)">删</div>
             </div>
         </div>
    </form>


	<div class="text_input_button_cancel" onclick="$('#dlgEntMember').window('close')">取消</div>
	<div class="text_input_button_float" onclick="fmEntMemberSubmit()">保存</div>
	<script type="text/javascript">
		$(function(){
			loadCompanyId(loadData);
			
			$("#templateDate").hide();
		});
		
		function loadCompanyId(callback){
			var url = getRootPath_web()+"/giftconfig/getcompany";
			$.get(url).done(function(result){
				if(result.code != 100000){
					$.messager.alert('操作提示',"获取公司信息失败！",'error');
					return;
				}
				
				var cities = result.data;
				for(var i in cities){
					var ck = '<div class="model_form_item_inline" style="padding-left:12px"><div class="model_form_item_input" style="width:200px"><input type="checkbox" name="cityId" value='+cities[i].id+' style="height:15px;width:15px;vertical-align:middle;"></input>'+cities[i].companyName+'</div></div>';
					$("#divCity").append(ck);
				}
				
				callback();
			});
		}
		
		function loadData(){
			var ec = '<%=ESAPI.encoder().encodeForJavaScript(request.getParameter("ec"))%>';
			var url = getRootPath_web()+"/giftconfig/getgiftconfig?ec="+ec;
			$.get(url).done(function(result){
				if(result.code != 100000){
					$.messager.alert('操作提示',"获取首次成为企业会员赠规则失败",'error');
					return;
				}
				
				if(result.data.isValidate == 1){
					$("input[name=isValidate4EntMember][value=1]").get(0).checked=true;
				}else{
					$("input[name=isValidate4EntMember][value=0]").get(0).checked=true;
				}
				$("#configId").val(result.data.id);
				initalCompanyId(result.data.companyId);
				initalAutoSendDate(result.data.autoSendDate);
			});
		}
		
		function addDate(){
			$("#divNewDate").append($("#templateDate").html());
		}
		
		function deleteDate(el){
			var d = $(el).parent().parent();
			$(el).parent().parent().remove();	
			alert($(d).html());
		}
		
		function fmEntMemberSubmit(){
			var id = $("#configId").val();
    		var isValidate = $("input[name='isValidate4EntMember']:checked").val();
    		var autoSendDate = new Array();
    		$("input[name=giftDate]").each(function(index,el){
    			autoSendDate.push($(el).val());
    		}); 
    		
    		var companyId = new Array();
    		$("input[name='cityId']:checked").each(function(){
    			companyId.push($(this).val());
    		});
    		
    		var data = {id:id,isValidate:isValidate,autoSendDate:autoSendDate.join(","),companyId:companyId.join(",")};
    		var url = getRootPath_web()+'/giftconfig/saveentmemberconfig';
    		$.post(url,data).done(function(result){
    			if(result.code == 100000){
    				$.messager.alert('操作提示',"保存成功",'info',function(){
    					giftConfig.list.search();
    					$('#dlgEntMember').window('close')
    				});
    			}else{
    				$.messager.alert('操作提示',"保存失败",'error');
    			}
    		});
		}
		
		function initalCompanyId(companyId){
			for(id in companyId){
				$("input[name=cityId][value="+ companyId[id] +"]").get(0).checked=true;
			}
		}
		
		function initalAutoSendDate(autoSendDate){
			if(autoSendDate.length == 1){
				$("#firstGiftDate").val(autoSendDate[0])
			}else{
				for(var i = 1; i < autoSendDate.length; i++){
					$("#templateDate input[name=giftDate]").val(autoSendDate[i]);
					$("#divNewDate").append($("#templateDate").html());
				}
			}
			
		}
	</script>
</body>
</html>