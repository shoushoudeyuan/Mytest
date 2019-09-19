<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html>
<head>
<title>批量新增优惠券</title>
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




<form id="fmLotCouponEdit" method="post" style="margin-left: 20px">

	<div  name = "choseType">
				&nbsp;&nbsp;	<td><span style="color: red;">*</span>优惠券类型</td>
				<td><input type="radio" name="type" value='0'checked='checked' class="radio1"/> <span class="radio1" >减免优惠券</span>
					      <input type="radio" name="type" value="1"  class="radio2" /><span class="radio2" >折扣优惠券</span>
				</td>
				<div>
				&nbsp;&nbsp;&nbsp;
				</div>
		</div>
		<table width="95%" border="0" cellspacing="0" cellpadding="0" class="pop_table" style="margin: 0px !important;">
			<tr  class="money" style="position:relative;left:18px;display:block">
				<td><span style="color: red;">*</span> 优惠券金额</td>
				<td><input name="couponmoney" class="easyui-textbox"
					style="width: 200px;" />
					</td>
			</tr>
			<tr class="zhekou" style="display:none;position:relative;left:38px;">
				<td><span style="color: red;" >*</span>折扣比例</td>
				<td><input name="discount" min="10" max="100" class="input easyui-numberbox" precision="0"
					style="width: 200px;">%
					</td>
			</tr>
			<tr class="zhekou" style="display:none;position:relative;left:38px;">
				<td><span style="color: red;">*</span>最高减免</td>
				<td><input name="topDiscountMoney" class="easyui-textbox"
					style="width: 200px;">
					</td>
			</tr>
		</table>
<table width="95%" border="0" cellspacing="0" cellpadding="0" class="pop_table" style="margin:0px !important;">
<!--   <tr>
    <td>优惠券金额</td>
    <td>
    <input name="couponmoney" class="easyui-textbox"
				style="width: 200px;"
				data-options="required:true,validateOnCreate:false,validateOnBlur:true,validType:'currency'">
    <span style="color: red;">*</span>
    </td>
  </tr> -->
  <tr>
    <td>失效日期</td>
    <td><input id="enddateNew" type="text" name="enddateNew" style="width: 200px;"
				class="easyui-datebox"
				data-options="required:true,validateOnCreate:false,validateOnBlur:true" />
			<span style="color: red;">*</span></td>
  </tr>
  <tr>
    <td>是否启用</td>
    <td>&nbsp;<input type="radio" name="isdisable" value='1' checked='checked' />
    启用
    <input type="radio" name="isdisable" value="0" />
    禁用</td>
  </tr>
  <tr>
    <td>生成数量</td>
    <td> <input name="produceCount" class="easyui-textbox" style="width: 200px;"
				data-options="required:true,validateOnCreate:false,validateOnBlur:true,validType:'number'">
    <span style="color: red;">*</span></td>
  </tr>
  <tr>
    <td>适用类型</td>
    <td><select id="coupontype" name="coupontype"
				class="easyui-combobox" style="width: 200px;">
				<option value="0">通用</option>
			</select></td>
  </tr>
  <!-- <tr>
    <td>时段控制</td>
    <td><select id="istimecontrol" name="istimecontrol"
				class="easyui-combobox" style="width: 200px;">
				<option value="0">全部</option>
				<option value="1">白天分时</option>
				<option value="2">晚间闲时</option>
			</select></td>
  </tr> -->

  
  <tr>
  <td>备注</td>
  <td><input name="remark" class="easyui-textbox" style="width: 200px;"
				data-options="validateOnCreate:false,validateOnBlur:true"></td>
  
  </tr>
  
   <tr>
  <td>第三方</td>
  <td>&nbsp;<input type="radio" name="isthirdparty" value='1' />
    是
    <input type="radio" name="isthirdparty" value="0" checked='checked' />
    否</td>
  
  </tr>
  
     <tr>
  <td>第三方名称</td>
  <td> <input name="thirdpartyname" class="easyui-textbox" style="width: 200px;"
				data-options="validateOnCreate:false,validateOnBlur:true"></td>
  
  </tr>
  
  
</table>


  
  
  
  
  
  <div class="float_div" style="clear:both">
  	<div class="text_input_button_cancel" onclick="javascript:$('#divLotCoupon').window('close');">取消</div>
    <div class="text_input_button_float"	onclick="javascript:saveRole();">保存</div>
    
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
 			
 		});
 		
		  function saveRole(){
		        $('#fmLotCouponEdit').form('submit',{
		            url: '<%=request.getContextPath()%>/couponCustomer/updateLotCoupon',
								onSubmit : function() {
									return $(this).form('validate');
								},
								success : function(result) {
									if (result == 1) {
										$('#divLotCoupon').window('close');
										$('#dgCSCouponList').datagrid('reload');
										$.messager.alert('操作提示','操作成功!');
									} else {
										$.messager.alert('操作提示','操作失败!');
									}
								}
							});
		}
	</script>
</body>
</html>
