<%@page import="java.util.Date"%>
<%@ page language="java" pageEncoding="UTF-8" import="org.owasp.esapi.ESAPI"%>
<!DOCTYPE HTML>
<html>
<head>

<title>规则管理</title>
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
	<form id="fmRuleDetailEdit" method="post" style="margin-left: 20px">
		<div style="margin-top: 10px">
			<input id="id" name="id" hidden="true" style="display: none;">
		</div>
		<div style="margin-top: 10px">
			<input type="hidden" id="ruleidentification"
				name="ruleidentification">
		</div>
		<div id="divGetMoney" style="margin-bottom: 10px">
		<span style="color: red;">*</span> 满&nbsp;&nbsp;额<input name="basicmoney" class="easyui-numberbox"
				style="width: 50%"
				data-options="required:true,validateOnCreate:false,validateOnBlur:true,validType:'maxLength[6]'" value="50">
		</div>
		<div id="divNeedIntegral" style="margin-bottom: 10px">
			<span style="color: red;">*</span> 所需积分<input name="needintegrate" class="easyui-numberbox"
				style="width: 50%"
				data-options="required:true,validateOnCreate:false,validateOnBlur:true,validType:'maxLength[6]'" value="100">
		</div>
		<div  name = "choseType" style="margin-left:-20px;">
				&nbsp;&nbsp;	<td><span style="color: red;">*</span>优惠券类型</td>
				<td>       <input type="radio" name="type" value='0'checked='checked' class="radio1"/> <span class="radio1" >减免优惠券</span>
					      <input type="radio" name="type" value="1"  class="radio2" /><span class="radio2" >折扣优惠券</span>
				</td>
				<div>
				&nbsp;&nbsp;&nbsp;
				</div>
		</div>
		<div style="margin-bottom: 10px">
		<!-- 	<span style="color: red;">*</span> 赠送金额<input name="presentmoney" class="easyui-numberbox"
				style="width: 50%"
				data-options="required:true,validateOnCreate:false,validateOnBlur:true,validType:'maxLength[6]'"> -->
					<table width="95%" border="0" cellspacing="0" cellpadding="0" class="pop_table" style="margin: 0px !important;">
			<tr  class="money" style="position:relative;left:4px;">
				<td style="width:75px!important"><span style="color: red;">*</span>赠送金额</td>
				<td><input name="presentmoney" class="easyui-textbox"
					style="width: 222px;" />
					<!-- data-options="required:true,validateOnCreate:false,validateOnBlur:true,validType:'currency'" -->
					</td>
			</tr>
			<tr class="zhekou" style="display:none;position:relative;left:4px;">
				<td><span style="color: red;" >*</span>折扣比例</td>
				<td><input name="discount"  min="10" max="100" class="input easyui-numberbox" precision="0"
					style="width: 222px;">%
					<!-- data-options="required:true,validateOnCreate:false,validateOnBlur:true,validType:'currency'" -->
					</td>
			</tr>
			<tr class="zhekou" style="display:none;position:relative;left:4px;">
				<td><span style="color: red;">*</span>最高减免</td>
				<td><input name="topDiscountMoney" class="easyui-textbox"
					style="width: 222px;">
				<!-- 	data-options="required:true,validateOnCreate:false,validateOnBlur:true,validType:'currency'" -->
					</td>
			</tr>
		</table>
		</div>
		<div id="divHoliday" style="margin-bottom: 10px;">
			<span style="color: red;">*</span> 节 假 日<input name="holiday" class="easyui-datebox"
				style="width: 50%"
				data-options="required:true,validateOnCreate:false,validateOnBlur:true" value=<%=new Date() %> >
		</div>
<!-- 		<div id="divSendTimes" style="margin-bottom: 10px"> -->
<!-- 			<span style="color: red;">*</span> 累计次数<input name="accumulativenum" class="easyui-numberbox" -->
<!-- 				style="width: 50%" -->
<!-- 				data-options="required:true,validateOnCreate:false,validateOnBlur:true,validType:'maxLength[6]'" value="100"> -->
<!-- 		</div> -->
		<div style="margin-bottom: 10px;">
			<span style="color: red;">*</span> 有效天数<input name="validday" class="easyui-numberbox"
				style="width: 50%"
				data-options="required:true,validateOnCreate:false,validateOnBlur:true,validType:'maxLength[3]'">
		</div>
		<div style="margin-bottom: 10px;padding-left:8px">
			&nbsp;使用类型<select id="usingtype" name="usingtype" class="easyui-combobox"
				style="width: 50%;" data-options="editable:false">
				<option value="0">通用</option>
			</select>
		</div>
		<!-- <div style="margin-bottom: 10px;padding-left:8px">
			&nbsp;时段控制<select id="timecontrol" name="timecontrol"
				class="easyui-combobox" style="width: 50%;" data-options="editable:false">
				<option value="0">全部</option>
				<option value="1">白天分时</option>
				<option value="2">晚间闲时</option>
			</select>
		</div> -->
		<div style="margin-bottom: 10px;padding-left:30px">
			&nbsp;备&nbsp;&nbsp;注<input name=reamark class="easyui-textbox" style="width: 222px;"
				data-options="validateOnCreate:false,validateOnBlur:true">
		</div>
		<div style="margin-bottom: 10px;padding-left:30px">
			&nbsp;说&nbsp;&nbsp;明<input name=introduction class="easyui-textbox"
				style="width: 222px;"
				data-options="validateOnCreate:false,validateOnBlur:true">
		</div>
		<div id="divSendCount" style="margin-bottom: 10px;padding-left:8px">
			<span style="color: red;">*</span>  赠送数量<input name=presentcoumt class="easyui-numberbox"
				style="width: 222px;"
				data-options="required:true,validateOnCreate:false,validateOnBlur:true,validType:'maxLength[2]'"
				value="1">
		</div>
		<div id="divIspostpone" style="margin-bottom: 10px;margin-left:-4px;">
			有效期延后<select id="ispostpone" name="ispostpone" 
				class="easyui-combobox" style="width: 222px;" data-options="editable:false">
				<option value="0">关闭</option>
				<option value="1">开启</option>
			</select>(多张有效)
		</div>


		<div class="float_div" style="clear:both">
			<div class="text_input_button_cancel"
				onclick="javascript:$('#divRuleDetail').window('close');">取消</div>
			<div class="text_input_button_float"
				onclick="javascript:saveRole();">保存</div>
			

		</div>


	</form>
	<script type="text/javascript">
		$(function(){
			
				$(".radio1").click(function(){
					$(".money").css("display","block");
					$(".zhekou").css("display","none");
					$(".zhekou input").val(null);
				});
				$(".radio2").click(function(){
					$(".money").css("display","none");
					$(".zhekou").css("display","block");
					$(".money input").val(null);
				})
		})
	</script>
	<script type="text/javascript">
 		$(function(){ 			
 			var ruleDetailId = '<%=ESAPI.encoder().encodeForJavaScript(request.getParameter("ruledetailId"))%>';	
 			var cusFlag = '<%=ESAPI.encoder().encodeForJavaScript(request.getParameter("cusFlag"))%>';
			
 			$("#divSendCount").show();
			$("#divIspostpone").show();
			$("#divGetMoney").show();
// 			$("#divSendTimes").show();
			$("#divHoliday").show();
			$("#divNeedIntegral").show();
			
			//注册
			if(cusFlag == "CUSTOMER_REG"){
				$("#divSendCount").hide();
				$("#divIspostpone").hide();		
				$("#divGetMoney").hide();
// 				$("#divSendTimes").hide();
				$("#divHoliday").hide();
				$("#divNeedIntegral").hide();
			}
			//满额送
			else if(cusFlag == "FULL_PRESENT"){
				$("#divSendCount").hide();
				$("#divIspostpone").hide();
				$("#divHoliday").hide();
// 				$("#divSendTimes").hide();
				$("#divNeedIntegral").hide();
			}
			//推荐用户送
			else if(cusFlag == "CUSTOMER_Recommend"){
				$("#divSendCount").hide();
				$("#divIspostpone").hide();
				$("#divGetMoney").hide();
				$("#divHoliday").hide();
				$("#divNeedIntegral").hide();
			}
			//节假日送
			else if(cusFlag == "HOLIDAY_PRESENT"){
				$("#divSendCount").hide();
				$("#divIspostpone").hide();
// 				$("#divSendTimes").hide();
				$("#divNeedIntegral").hide();
			}
			//兑换积分送
			else if(cusFlag == "INTEGRAL_EXCHANGE"){
				$("#divGetMoney").hide();
// 				$("#divSendTimes").hide();
				$("#divHoliday").hide();
				$("#divSendCount").hide();
				$("#divIspostpone").hide();
			}
			else{
				$("#divGetMoney").hide();
// 				$("#divSendTimes").hide();
				$("#divHoliday").hide();
				$("#divNeedIntegral").hide();
			}		
				
 			if(!(ruleDetailId == 'null')){
 				$("#id").val(ruleDetailId);
 				var selectPath = '<%=request.getContextPath()%>/couponRule/selectRuleDetail';
 	    		$.post(selectPath,{ruleDetailId:ruleDetailId},function(result){
 	    			if(result.success){
 	    			   $('#fmRuleDetailEdit').form('load',result.ruleDetail);
 	    			  if(result.ruleDetail.type==0){
	  	    			   	$(".money").css("display","inline-block");
	  						$(".zhekou").css("display","none");
	  					  	$(".radio1").css("display","inline-block");
	  						$(".radio2").css("display","none");
	  	    			 } 
	  	    		  if(result.ruleDetail.type==1){
	  	    			 $(".money").css("display","none");
	  	   				 $(".zhekou").css("display","inline-block");
	  	   				 $(".radio2").css("display","inline-block");
						 $(".radio1").css("display","none");
	 	    			 } 
 	    			}else{
 	    				$.messager.alert('操作提示','查询规则错误!');
 	    			}
 	    			
 	    		},'json');
 			}else{
 				var idf = '<%=ESAPI.encoder().encodeForJavaScript(request.getParameter("idf"))%>';	
 				$("#ruleidentification").val(idf);						
 			} 			
 		});
 		
		  function saveRole(){
		        $('#fmRuleDetailEdit').form('submit',{
		            url: '<%=request.getContextPath()%>/couponRule/updateRuleDetail',
								onSubmit : function() {
								/* 	return $(this).form('validate'); */
								},
								success : function(result) {
									if (result == 1) {
										$('#divRuleDetail').window('close');
										$('#dgRuleDetailList').datagrid(
												'reload');
										$.messager.alert('操作提示', '操作成功!');
									} else if (result == 0) {
										$.messager.alert('操作提示', '操作失败!');
									} else {
										$.messager.alert('操作提示', '未知错误!');
									}
								}
							});
		}
	</script>
</body>
</html>
