<%@ page language="java" pageEncoding="UTF-8" import="org.owasp.esapi.ESAPI" %>
<html>
<head>
<title>首次用车结单赠</title>
<%@ include file="../common/header.jsp"%>
</head>
<body>
	<form id="fmFirstOrder" method="post" style="padding:20px 10px 10px 30px">
		<input type="hidden" id="configId" />
		<div class="form_item">
		    <div class="form_item_inline">
		        <label class="model_form_item_label7"><span class="mode_form_dot">*</span>启用状态</label>
		        <div class="model_form_item_input">
		              <input type="radio" name="isValidate4FirstOrder" value=1 checked='checked' />启用 
		                 <input type="radio" name="isValidate4FirstOrder" value=0 />禁用
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
		        	<input type="radio" name="orderStatus" value=20 checked='checked' style="height:15px;width:15px;vertical-align:middle;"></input>首次订单还车成功待支付状态
		        </div>
		    </div>
		</div>
		<div class="model_form_item">
		    <div class="model_form_item_inline" style="padding-left:12px">
		        <div class="model_form_item_input" style="width:350px">
		        	<input type="radio" name="orderStatus" value=50 style="height:15px;width:15px;vertical-align:middle;"></input>首次订单还车成功已支付状态                                            
		        </div>
		    </div>
		</div>
		<div class="form_item">
		      <div class="form_item_inline" style="padding-left:12px">
		          <label class="model_form_item_label">
		              <span class="mode_form_dot" >
		                      *请选择获得优惠券的条件，不打勾不生效，打钩后默认值为5，可修改；
		              </span>
		          </label>
		      </div>
		  </div>
		  <div class="model_form_item">
		      <div class="model_form_item_inline" style="padding-left:12px">
		          <div class="model_form_item_input" style="width:400px">
		              <input type="checkbox" id="checkFirstOrderMileage" style="height:15px;width:15px;vertical-align:middle;"></input>首次用车行程≥ <input id="firstOrderMileage" value="5" style="width:50px;height:20px;border:1px solid rgba(233, 236, 243, 1);text-align:center"></input>公里
		          </div>
		      </div>
		  </div>
	</form>

    <div class="text_input_button_cancel" onclick="$('#dlgFirstOrder').window('close')">取消</div>
    <div class="text_input_button_float" onclick="fmFirstOrderSubmit()">保存</div>
    
    <script type="text/javascript">
    	$(function(){
    		var ec = '<%=ESAPI.encoder().encodeForJavaScript(request.getParameter("ec"))%>';
			var url = getRootPath_web()+"/giftconfig/getgiftconfig?ec="+ec;
			$.get(url).done(function(result){
				if(result.code != 100000){
					$.messager.alert('操作提示',"获取首次用车结单赠规则失败",'error');
					return;
				}
				
				if(result.data.isValidate == 1){
					$("input[name=isValidate4FirstOrder][value=1]").get(0).checked=true;
				}else{
					$("input[name=isValidate4FirstOrder][value=0]").get(0).checked=true;
				}
				
				$("#configId").val(result.data.id);
				if(result.data.orderStatus == 20){
					$("input[name=orderStatus][value=20]").get(0).checked=true;
				}else{
					$("input[name=orderStatus][value=50]").get(0).checked=true;
				}
				
				if(result.data.checkFirstOrderMileage){
					$("#checkFirstOrderMileage").attr("checked",true);
					$("#firstOrderMileage").val(result.data.firstOrderMileage);
				}
			});
    	});
    	
    	function fmFirstOrderSubmit(){
     		var id = $("#configId").val();
    		var isValidate = $("input[name='isValidate4FirstOrder']:checked").val();
    		var orderStatus = $("input[name='orderStatus']:checked").val();
    		var checkFirstOrderMileage = $("#checkFirstOrderMileage").is(":checked");
    		var firstOrderMileage = $.trim($("#firstOrderMileage").val());
    		
    		if(checkFirstOrderMileage && firstOrderMileage == ''){
    			$.messager.alert('操作提示',"填写行驶里程",'warn')
    			return;
    		}else if(!checkFirstOrderMileage){
    			firstOrderMileage = null;
    		}
    		
    		var data = {id:id,isValidate:isValidate,orderStatus:orderStatus,checkFirstOrderMileage:checkFirstOrderMileage,firstOrderMileage:firstOrderMileage};
    		var url = getRootPath_web()+'/giftconfig/savefirstorderconfig';
    		$.post(url,data).done(function(result){
    			if(result.code == 100000){
    				$.messager.alert('操作提示',"保存成功",'info',function(){
    					$('#dlgFirstOrder').window('close')
    					giftConfig.list.search();
    				});
    			}else{
    				$.messager.alert('操作提示',"保存失败",'error');
    			}
    		});
     	}
    </script>
</body>
</html>