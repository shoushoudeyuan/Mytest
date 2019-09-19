<%@ page language="java" pageEncoding="UTF-8" import="org.owasp.esapi.ESAPI" %>
<!DOCTYPE HTML>
<html>
<head>

<title>编辑客服反馈问题</title>
<%@ include file="../common/header.jsp"%>


</head>
<body>

	<div style="width: 85%; margin: 0px auto; margin-top: 20px;">
		<form id="fmEdit" method="post">
			<input type="hidden" name="csrftoken" value="<%=session.getAttribute("csrftoken").toString()%>"/>
			<input name="id" type="hidden" value=""> 
			<input type="hidden" id="orderid" name="orderid" value="0" />
			<div style="margin-bottom: 10px">
				顾客电话<input name="customermobile" class="easyui-textbox"
					style="width: 50%"
					data-options="required:true,validateOnCreate:false,validateOnBlur:true">
				<span style="color: red;">*</span>
			</div>
			<div style="margin-bottom: 10px">
				顾客姓名<input id="customername" name="customername" style="width: 50%;"
					class="easyui-textbox"
					data-options="required:true,validateOnCreate:false,validateOnBlur:true,validType:'length[0,10]'">
				<span style="color: red;">*</span>
			</div>
			<div style="margin-bottom: 10px">
				问题分类<select id="questioncategoryid" name="questioncategoryid"
					style="width: 50%" class="easyui-combobox" data-options="required:true,validateOnCreate:false,validateOnBlur:true">					
				</select>
				<span style="color: red;">*</span>
			</div>
			<div style="margin-bottom: 10px">
				状　　态<select id="dealwithstatus" name="dealwithstatus"
					style="width: 50%" class="easyui-combobox">
					<option value="1">上报中</option>
                        <option value="2">疑难问题</option>
                        <option value="3">已解决</option>
				</select>
			</div>
			<div style="margin-bottom: 10px">
				问题描述<input name="remark" class="easyui-textbox" style="width: 50%" />
			</div>
			<div style="margin-bottom: 10px">
				订单编号<input id="orderno" name="orderno" class="easyui-textbox" style="width: 50%" />
				<input id="btnSearchOrder"
					type="button" class="min_botton" value="匹配订单">
			</div>
			<div>
			<div>订单明细
				
					<table style=" border:1px solid #ccc; border-radius:5px; float:right; margin-right:126px; width:195px; padding:10px;" id="tabOrderDetail" cellpadding="0" cellspacing="0">
						<tr style="height: 40px;">
							<td>姓　　名</td>
							<td width="100"><span id="sName"></span></td>
						</tr>
						<tr style="height: 40px;">
							<td>性　　别</td>
							<td><span id="sGender"></span></td>
						</tr>
						<tr style="height: 40px;">
							<td>联系电话</td>
							<td><span id="sMobile"></span></td>
						</tr>
						<tr style="height: 40px;">
							<td>车　　型</td>
							<td><span id="sVehicleModdelName"></span></td>
						</tr>
						<tr style="height: 40px;">
							<td>车牌号</td>
							<td><span id="sPlateNumber"></span></td>
						</tr>
						<tr style="height: 40px;">
							<td>租车车场</td>
							<td><span id="sRentParkingLot"></span></td>
						</tr>
						<tr style="height: 40px;">
							<td>取车时间</td>
							<td><span id="sRentTime"></span></td>
						</tr>
					</table>
				</div>
			</div>
			<div style="width: 110%; margin-top:20px; clear:both" class="div_button">
				<div class="text_input_button_cancel"
					onclick="$('#dlg_edit').window('close');">取消</div>
				<div class="text_input_button_float"
					onclick="saveQuestion();">保存</div>
			
			</div>
		</form>

	</div>
	<script type="text/javascript">
 		$(function(){
 			getQuestionCategories();
 			var questionId = '<%=ESAPI.encoder().encodeForJavaScript(request.getParameter("questionId"))%>';
 			if(! (questionId == 'null')){
 				
 				var selectPath = '<%=request.getContextPath()%>/customerService/getQuestionById';
 	    		$.post(selectPath,{questionId:questionId},function(result){
 	    			if(result){
 	    			   $('#fmEdit').form('load',result);
 	    			  if($("#orderid").val()!="" && $("#orderid").val()!="0"){
	 	  					$("#tabOrderDetail").show();
	 	  					getOrderInfo();
 	  					}else{
 	  						$("#tabOrderDetail").hide();
 	  					}
 	    			  	
 	    			}else{
 	    				$.messager.alert('操作提示','查询问题失败!');
 	    			}
 	    			
 	    		},'json');
 			}
 			else{
 				//默认隐藏订单信息
 				$("#tabOrderDetail").hide();
 			}
 			//匹配订单
 			$("#btnSearchOrder").click(function(){
 				if($("#orderno").val()==null || $("#orderno").val()==""){
 					$.messager.alert('信息提示',"请输入订单号");
 					return;
 				}
 				getOrderInfo();
 			});
 			//下拉框如果不存在数据,则清空输入框
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
 		function saveQuestion(){
 			if($("#orderno").val()!=null && $("#orderno").val()!=""){
 				if( $("#orderid").val() =="" || $("#orderid").val() =="0"){
					$.messager.alert('信息提示',"订单号有误");
					return;
				}
				}	
 				
 			$('#fmEdit').form('submit',{
 	            url: '<%=request.getContextPath()%>/customerService/saveQuestion',
				onSubmit : function(param) {
					return res=$(this).form('validate');
				},
				success : function(result) {
					result=JSON.parse(result);
					if (result.code == '10000') {
						$.messager.alert('操作提示','保存成功!');
						search();
						$('#dlg_edit').window('close');
					} else {
						$.messager.alert('操作提示',result.message);
					}
				}
			});
		}
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
 						$('#sRentTime').text(result.data.chargingstartdate);
 					} else {
 						$.messager.alert('信息提示', result.message);
 					}

 				}, 'json');
 			}
 		//获取问题分类
 		function getQuestionCategories(){
 			var requestUrl="<%=request.getContextPath()%>/customerService/getQuestionCategories";
	    	$('#questioncategoryid').combobox({    
			    url:requestUrl,    
			    valueField:'id',    
			    textField:'name',
			    groupField:'parentname',
			    groupFormatter: function(group){
					return '<span style="color:black">' + group + '</span>';
				},
				formatter: function(row){
					var opts = $(this).combobox('options');
					return "　"+row[opts.textField];
				}

			})
 		}
	</script>

</body>
</html>
