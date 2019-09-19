<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8" import="org.owasp.esapi.ESAPI" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type"
	content="text/html; charset=charset=utf-8">
<%@ include file="../common/header.jsp"%>
<script src="../../js/util/common.js" type="text/javascript"></script>
<style>
html {
	overflow: auto;
	overflow-x: hidden;
}
</style>
<title>编辑救援记录</title>
</head>
<body>
	<div class="list_title">
	 	<span class="layui-parent-title-customer">HOME</span>
		 <span class="layui-badge-dot layui-bg-title"></span>
		 <span class="layui-children-title-customer">编辑救援记录</span>
	</div>
	<div class="table_data">
		<h4 class="table_data_title">编辑救援记录</h4>
	<form id="fmData">
		<input id="id" name="id" type="hidden" value="" /> 
		<input id="orderid" name="orderid" type="hidden" value="" />
		<!-- 事件类型(0违章1故障2救援3催款) -->
		<input name=eventcategory type="hidden" value="2" />
		<table class="pop_table" style="width:40%; float:left" >			
			<tr>
				<td>订单号</td>
				<td><input type="text" id="orderno" name="orderno"
					class="easyui-textbox" style="width: 250px;" /><span
					style="color: red;">*</span> <input id="btnSearchOrder"
					type="button" class="min_botton" value="匹配订单"></td>
			</tr>
					
			<tr>
				<td>救援时间</td>
				<td><input type="text" id="eventtime" name="eventtime"
					class="easyui-datetimebox" data-options="validateOnCreate:false,validateOnBlur:true,validType:'dateTime'"  value="" style="width: 250px;" /></td>
			</tr>
			<tr>
				<td>救援地点</td>
				<td><input type="text" id="eventaddress" name="eventaddress"
					class="easyui-textbox" value="" style="width: 250px;" /></td>
			</tr>
			<tr>
				<td>救援情况</td>
				<td><input type="text" id="eventcase" name="eventcase"
					class="easyui-textbox" value="" style="width: 250px;" /></td>
			</tr>
			<tr>
				<td>联系内容</td>
				<td><input type="text" id="contactcontent" name="contactcontent"
					class="easyui-textbox" value="" style="width: 250px;" /></td>
			</tr>
			<tr>
				<td>处理时间</td>
				<td><input type="text" id="dealwithdate" name="dealwithdate"
					class="easyui-datetimebox"  data-options="validateOnCreate:false,validateOnBlur:true,validType:'dateTime'" value="" style="width: 250px;" /></td>
			</tr>
			<tr>
				<td>处理结果</td>
				<td><input type="text" id="dealwithresult"
					name="dealwithresult" class="easyui-textbox" value=""
					style="width: 250px;" /></td>
			</tr>
			<tr>
				<td>处理人</td>
				<td><input type="text" id="operator" name="operator"
					class="easyui-textbox" value="" style="width: 250px;" /></td>
			</tr>
			<tr>
				<td>客服人员</td>
				<td><input type="text" id="assistant" name="assistant"
					class="easyui-textbox" value="" style="width: 250px;" /></td>
			</tr>
			<tr>
				<td>备注</td>
				<td><input type="text" id="remark" name="remark"
					class="easyui-textbox" value="" style="width: 250px;" /></td>
			</tr>
		</table>

		<table class="pop_table" style="width:40%; float:right;">
			<tr>
				<td style=" text-align:left;">订单明细
			<table id="tabOrderDetail"  border="1" bordercolor="#ccc" cellpadding="0" cellspacing="2" style="margin-top:20px;">
						<tr>
							<td>姓名</td>
							<td><span id="sName"></span></td>
						</tr>
						<tr>
							<td>性别</td>
							<td><span id="sGender"></span></td>
						</tr>
						<tr>
							<td>联系电话</td>
							<td><span id="sMobile"></span></td>
						</tr>
						<tr>
							<td>车型</td>
							<td><span id="sVehicleModdelName"></span></td>
						</tr>
						<tr>
							<td>车牌号</td>
							<td><span id="sPlateNumber"></span></td>
						</tr>
						<tr>
							<td>租车车场</td>
							<td><span id="sRentParkingLot"></span></td>
						</tr>
						<tr>
							<td>取车时间</td>
							<td><span id="sRentTime"></span></td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
	</form>
	<table
		style="width: 98%; margin: 0px auto; border-spacing: 1px; border-top: 2px solid #22ab39; margin-top: 20px; padding-top: 15px;">
		<tr>
			<td align="center">
				<input id="btnCancel" type="button" class="text_input_button_cancel"  value="取&nbsp;&nbsp;&nbsp;消">
				<input id="btnOK" type="button" class="text_input_button_float"  value="完&nbsp;&nbsp;&nbsp;成">
			</td>
		</tr>
	</table>
</div>
	<script type="text/javascript">
	$(function() {
		//事件ID
		var serviceEventId='<%=ESAPI.encoder().encodeForJavaScript(request.getParameter("serviceEventId"))%>';
		if(serviceEventId=='null' || serviceEventId==''){
			//默认隐藏订单信息
			$("#tabOrderDetail").hide();
		}else{
			initFormData(serviceEventId);			
		}
		
		//匹配订单
		$("#btnSearchOrder").click(function(){
			if($("#orderno").val()==null || $("#orderno").val()==""){
				$.messager.alert('信息提示',"请输入订单号");
				return;
			}
			getOrderInfo();
		});
		
		//提交表单
		$("#btnOK").click(function(){
			if($("#orderid").val()==""){
				$.messager.alert('信息提示',"请先匹配订单");
				return;
			}
			saveFaultRecord();
		});
		
		$("#btnCancel").click(function(){
			location.href="<%=request.getContextPath()%>/jsp/customerService/rescueRecordManage.jsp";
		});
// 		//添加日期校验规则
// 		$(".easyui-datetimebox").validatebox({
// 			 required: true,
// 		    validType: 'date',
// 		    validateOnCreate:false,
// 		    validateOnBlur:true
// 		});
		//添加下拉框校验规则
			$(".easyui-combobox").combobox({
				onHidePanel: function() {
		          var valueField = $(this).combobox("options").valueField;
		          var val = $(this).combobox("getValue");  //当前combobox的值
		          var allData = $(this).combobox("getData");   //获取combobox所有数据
		          var result = true;      //为true说明输入的值在下拉框数据中不存在
		          	for (var i = 0; i < allData.length; i++) {
			                if (val == allData[i][valueField]) {
			                    result = false;
			                }
			            }
			            if (result) {
			                $(this).combobox("clear");
			            }
		      }
			});
	});
	//获取订单基本信息
	function getOrderInfo(){		
			var url = '/bjyoms/order/getOrderInfoByOrderNo';
			$.post(url, {
				orderNo : $("#orderno").val()
			}, function(result) {				
				if (result.code=="10000") {
					//显示订单信息
					$("#tabOrderDetail").show();
					$("#orderid").val(result.data.id);
					$('#sName').text(result.data.customerName);
					$('#sGender').text(result.data.genderName);
					$('#sMobile').text(result.data.mobile);
					$('#sVehicleModdelName').text(result.data.vehicleModelName);
					$('#sPlateNumber').text(result.data.plateNumber);
					$('#sRentParkingLot').text(result.data.rentParkName);
					$('#sRentTime').text(result.data.planusingstartdate);
				} else {
					$.messager.alert('操作提示', result.message);
				}

			}, 'json');
		}
		//保存故障记录
		function saveFaultRecord() {
			var requestUrl ='<%=request.getContextPath()%>/customerService/saveServiceEvent';
			$('#fmData').form('submit', {
				url : requestUrl,
				onSubmit : function(param) {
					return $(this).form('validate');
				},
				success : function(result) {
					result = JSON.parse(result);
					if (result.code=="10000") {
						$.messager.alert('操作提示', '保存成功!');
						location.href="<%=request.getContextPath()%>/jsp/customerService/rescueRecordManage.jsp";
					} else {
						$.messager.alert('操作提示', result.message);
					}
				}
			});
		}
		//初始化表单数据
		function initFormData(eid) {
			getServiceEventById(eid);
			
		}
		//根据服务事件ID获取服务事件
		function getServiceEventById(eid){
			var requestUrl = '<%=request.getContextPath()%>/customerService/getServiceEventById';
	    		$.post(requestUrl,{eventId:eid},function(result){
	    			if(result){
	    			   $('#fmData').form('load',result);
	    			 //编辑时显示订单信息
	    				if($("#orderno").val()!=null && $("#orderno").val()!=''){
	    					$("#tabOrderDetail").show();
	    					getOrderInfo();
	    				}
	    			}else{
	    				$.messager.alert('操作提示','查询记录失败!');
	    			}
	    		},'json');
		}
		
	</script>

</body>
</html>