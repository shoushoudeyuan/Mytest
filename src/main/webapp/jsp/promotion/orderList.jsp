<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8" import="org.owasp.esapi.ESAPI"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type"
	content="text/html; charset=charset=utf-8">
<%@ include file="../common/header.jsp"%>
<style>
html{
overflow:auto;
overflow-x:hidden;
}
</style>
<title>订单管理</title>
</head>
<body>

	<div class="list_title">
		 <span class="layui-parent-title-customer">HOME</span>
		 <span class="layui-badge-dot layui-bg-title"></span>
		 <span class="layui-children-title-customer">推广订单</span>
		<a id="btnReturn"
				href="javascript:history.go(-1)"
				style="float: right; font-size: 28px;">返回上级</a>
	</div>
	<!--搜索开始-->
	<div class="text_input">
		<span class="div_search_customerBar"></span>
		<form id="queryForm">
			<div class="from_item">
				<div class="form_item_inline">
					<label class="form_item_label4">姓名</label>
					<div class="form_item_input">
						<input type="hidden" name = "businessId" id = "businessId"/> 
						<input type="hidden" name = "customerID" id = "customerID"/> 
						<input type="hidden" name = "promote" id = "promote"/> 
						<input type="text" id="customerName" name="customerName" class="easyui-textbox" value="" />
					</div>
				</div>
				<div class="form_item_inline">
					<label class="form_item_label4">电话</label>
					<div class="form_item_input">
						<input type="text" id="mobile" name="mobile"
						class="easyui-textbox" value="" />
					</div>
				</div>
				<div class="form_item_inline">
					<label class="form_item_label4">订单号</label>
					<div class="form_item_input">
						<input type="text" id="orderNo" name="orderNo"
						class="easyui-textbox" value="" />
					</div>
				</div>
				<div class="form_item_inline">
					<label class="form_item_label4">车牌号</label>
					<div class="form_item_input">
						<input type="text" id="plateNumber" name="plateNumber"
						class="easyui-textbox" value="" />
					</div>
				</div>
			
				<div class="form_item_inline">
						<input id="btnSearch" type="button" class="text_input_button_search"
					style="float: right;" value="查询">
				</div>
			</div>
			
			<div class="from_item divh">
				<div class="form_item_inline">
					<label class="form_item_label4">推广商</label>
					<div class="form_item_input">
						<input type="text" id="businessName" name="businessName"
						class="easyui-textbox" value="" />
					</div>
				</div>
				<div class="form_item_inline">
					<label class="form_item_label4">地推人员</label>
					<div class="form_item_input">
						<input type="text" id="marketingAssistantName" name="marketingAssistantName"
						class="easyui-textbox" value="" />
					</div>
				</div>
				<div class="form_item_inline">
					<label class="form_item_label4">订单状态</label>
					<div class="form_item_input">
						<select id="orderStatus" name="orderStatus"
						class="easyui-combobox">
							<option value="">全部</option>
							<option value="0">待取车</option>
							<option value="10">已取车</option>
							<option value="20">已还车</option>
							<option value="40">已作废</option>
							<option value="50">已完成</option>
						</select>
					</div>
				</div>
				<div class="form_item_inline">
					<label class="form_item_label4">到账状态</label>
					<div class="form_item_input">
						<select id="accountStatus" name="accountStatus"
							class="easyui-combobox">
							<option value="">全部</option>
							<option value="0">未到账</option>
							<option value="1">已到账</option>
						</select>
					</div>
				</div>
				
			</div>
			
			<div class="from_item divh">
				<div class="form_item_inline">
					<label class="form_item_label4">应付起</label>
					<div class="form_item_input">
						<input type="text" id="payableStartAmount"
						name="payableStartAmount" class="easyui-numberbox" value="0"
						data-options="min:0,precision:2" />
					</div>
				</div>
				<div class="form_item_inline">
					<label class="form_item_label4">应付止</label>
					<div class="form_item_input">
						<input type="text" id="payableEndAmount" name="payableEndAmount"
						class="easyui-numberbox" value="0"
						data-options="min:0,precision:2" />
					</div>
				</div>
				<div class="form_item_inline">
					<label class="form_item_label4">创建开始</label>
					<div class="form_item_input">
						<input id="createStartTime" type="text" name="createStartTime"  
						class="easyui-datetimebox" />
					</div>
				</div>
				<div class="form_item_inline">
					<label class="form_item_label4">创建结束</label>
					<div class="form_item_input">
						<input type="text" id="createEndTime" name="createEndTime"  
						class="easyui-datetimebox" />
					</div>
				</div>
				
			</div>
			
			<div class="from_item divh">
				<div class="form_item_inline">
					<label class="form_item_label4">计费开始</label>
					<div class="form_item_input">
						<input type="text" id="chargeStartTime" name="chargeStartTime"  
						class="easyui-datetimebox" />
					</div>
				</div>
				<div class="form_item_inline">
					<label class="form_item_label4">计费结束</label>
					<div class="form_item_input">
						<input type="text" id="chargeEndTime" name="chargeEndTime"  
						class="easyui-datetimebox" />
					</div>
				</div>
				<div class="form_item_inline">
					<label class="form_item_label4">支付开始</label>
					<div class="form_item_input">
						<input type="text" id="payStartTime" name="payStartTime"  
						class="easyui-datetimebox" />
					</div>
				</div>
				<div class="form_item_inline">
					<label class="form_item_label4">支付结束</label>
					<div class="form_item_input">
						<input type="text" id="payEndTime" name="payEndTime" 
						class="easyui-datetimebox" />
					</div>
				</div>
			</div>
			<div class="from_item divh">
				<div class="form_item_inline">
					<label class="form_item_label4">到账开始</label>
					<div class="form_item_input">
						<input type="text" id="chargeStartTime" name="chargeStartTime"  
						class="easyui-datetimebox" />
					</div>
				</div>
				<div class="form_item_inline">
					<label class="form_item_label4">到账结束</label>
					<div class="form_item_input">
						<input type="text" id="accountEndTime" name="accountEndTime" 
						class="easyui-datetimebox" />
					</div>
				</div>
				<div class="form_item_inline">
					<label class="form_item_label4">邀请码</label>
					<div class="form_item_input">
						<input type="text" id="invitationCode" name="invitationCode"
						class="easyui-textbox" value="" />
					</div>
				</div>
			</div>
			<div class="more" style="bottom:-17px">
				<input value="更多" type="button" class="more_input"
					onclick="showOrHideQuery(this);" />
			</div>
		</form>
	</div>
	<!--搜索结束-->
	<!-- 列表开始 -->
	<div class="table_data">
		<h4 class="table_data_title">
			推广订单
			<div class="text_input_bottom">
				<input id="btnExport" type="button"
					class="text_input_button text_input_button_left" value="导出">
			</div>
		</h4>
		<table id="dgOrders" style="width: 100%;">
		</table>
	</div>


	
	<!-- 列表结束 -->
	<script type="text/javascript">
		$(function() {
			setAutoHeight(300,"dgOrders");
			var customerID = '<%=ESAPI.encoder().encodeForJavaScript(request.getParameter("customerID"))%>';
			var businessId = '${business.id}';
			var url = "/bjyoms/order/getOrders";
			if(customerID != null && customerID != "" && customerID != "null")
			{
				//url += '?customerID='+customerID;
				$("#customerID").val(customerID);
			}
			else if(businessId != null && businessId != "" && businessId != "null")
			{
				//url += '?businessId='+businessId;
				$("#businessId").val(businessId);
			}
			else
			{
				//url += '?promote=yes';
				$("#promote").val('yes');
				$("#bName").show();
			}
			
			$('#dgOrders').datagrid({
				url : url,
				queryParams : getFormJson($("#queryForm")[0]),
				pagination : true,//分页控件 
				rownumbers : true,//行号 		
				singleSelect:true,//一次只能选择一行
				showFooter: true,//显示行脚
				pageList :  [10,50,100],        // 可以设置每页记录条数的列表
		        pageSize : 10 ,
		        emptyMsg:'无数据',//为空时的数据展示
		        frozenColumns:[[
							
							{field:'orderno',title:'订单号',align:'center',formatter:function(value,rec,index){
								if(rec.id==null){
									return "<span style='float:right;'>"+value+"</span>";
								}else{
									return value;
								}
							}}
		                        ]],
				columns:[[
						  {field:'id',title:'id',hidden:'true'},
						  {field:'orderstatus',title:'orderstatus',hidden:'true'},
						  {field:'customerid',title:'customerid',hidden:'true'},
				          
				          {field:'orderTypeName',title:'类型',align:'center'},
				          {field:'customerName',title:'姓名',align:'center'},
				          {field:'invitationCode',title:'邀请码',align:'center'},
				          {field:'sourceChannelName',title:'渠道来源',align:'center'},
				          {field:'enterpriseName',title:'企业名称',align:'center'},
				          {field:'marketingAssistantName',title:'地推商/地推人员',align:'center'},
				          {field:'mobile',title:'手机号',align:'center'},
				          {field:'ordercost',title:'应付金额',align:'right',formatter:function(value,rec,index){
				        	  if(!isNaN(value)){
				        		  return value.toFixed(2);
				        	  }
				          }},
				          {field:'actualpaymentcost',title:'实付金额',align:'right',formatter:function(value,rec,index){
				        	  if(!isNaN(value)){
				        		  return value.toFixed(2);
				        	  }
				          }},
				          {field:'pushMoney',title:'提成金额',align:'center'},
				          {field:'vehicleModelName',title:'车型',align:'center'},
				          {field:'plateNumber',title:'车牌号',align:'center'},
				          {field:'rentParkName',title:'租车车场',align:'center'},
				          {field:'returnParkName',title:'还车车场',align:'center'},
				          {field:'createdate',title:'创建时间',align:'center'},
				          {field:'chargingstartdate',title:'计费时间',align:'center'},
				          {field:'returnvehicledate',title:'还车时间',align:'center'},
				          {field:'paymentdate',title:'支付时间',align:'center'},
				          {field:'payModeName',title:'支付方式',align:'center'},
				          {field:'isSuccessName',title:'到账状态',align:'center'},
				          {field:'arrivalDate',title:'到账时间',align:'center'},
				          {field:'orderStatusName',title:'订单状态',align:'center'}
				      ]]
					 });

			var p = $('#dgOrders').datagrid('getPager');
			$(p).pagination({
				pageSize : 10,//每页显示的记录条数，默认为10 
				pageList :  [10,50,100],//可以设置每页记录条数的列表 
				/*beforePageText : '第',//页数文本框前显示的汉字 
				afterPageText : '页    共 {pages} 页',
				displayMsg : '当前显示 {from} - {to} 条记录   共 {total} 条记录',*/
				links:5,
				displayMsg:'',
				layout:['prev','links','next','list']
			});
			
			/* $('#dgOrders').datagrid({
	              emptyMsg: '无数据'//为空时的数据展示
	        }); */
			
			$("#btnSearch").click(function(){
				reLoadDataGrid();
			});
			$("#btnAdd").click(function(){
				location.href="/bjyoms/jsp/order/addOrder.jsp";
			});
			$("#btnExport").click(function(){
				var queryParam = getFormJson($("#queryForm")[0]);
				var url = "/bjyoms/order/exportOrders?"+$.param(queryParam);
				window.open(url);
			});
			//初始化统计数据
			initGT24();
			initNoTake();
			initGT2000();
		});

		// 如：{Name:'摘取天上星',position:'IT技术'}
		// ps:注意将同名的放在一个数组里
		function getFormJson(form) {
			var o = {};
			var a = $(form).serializeArray();
			$.each(a, function() {
				if (o[this.name] !== undefined) {
					if (!o[this.name].push) {
						o[this.name] = [ o[this.name] ];
					}
					o[this.name].push(this.value || '');
				} else {
					o[this.name] = this.value || '';
				}
			});
			return o;
		}			
		
		function modifyOrder(orderId){
			location.href="/bjyoms/jsp/order/modifyOrder.jsp?orderId="+orderId;
		}
		function showTravelingTrack(orderId){
			location.href="/bjyoms/jsp/order/trackPlayback.jsp?orderId="+orderId;
		}
		function endOrder(orderId,customerId){
			$.messager.confirm('信息提示','您确认想要结单吗？',function(r){    
			    if (r){    
			    	var url = "/bjyoms/order/endOrder";
			        var params = $.param({ "orderId": orderId,"customerId":customerId });
			        $.getJSON(url, params, function(res) {
			        	res=eval(res);
			        	if(res.result==1){
			        		$.messager.alert('操作提示',"结单成功",'');
			        		reLoadDataGrid();
			        	}else{
			        		$.messager.alert('操作提示',"结单失败",'');
			        	}
			        });
			    }    
			}); 
			
		}
		function cancelOrder(orderId){
			$.messager.confirm('信息提示','您确认想要取消订单吗？',function(r){    
			    if (r){    
			    	var url = "/bjyoms/order/orderCancel";
			        var params = $.param({ "orderId": orderId});
			        $.getJSON(url, params, function(res) {
			        	res=eval(res);
			        	if(res.code == "10000"){
			        		$.messager.alert('操作提示',"订单取消成功",'');
			        		reLoadDataGrid();
			        	}else{
			        		$.messager.alert('操作提示',res.message,'');
			        	}
			        });
			    }    
			}); 
					
		}
		function showComment(orderId){
			alert("待完成");
		}
		function reLoadDataGrid(){
			$('#dgOrders').datagrid('options').queryParams = getFormJson($("#queryForm")[0]);
			$('#dgOrders').datagrid('load');
		}
		function initGT24(){
			var url = "/bjyoms/order/selectPass24HourCount";
	        $.getJSON(url, null, function(res) {
	        	res=eval(res);
	        	if(res.result){
	        		$("#sGT24").text(res.result);
	        	}else{
	        		//$.messager.alert('操作提示',res.message,'');
	        	}
	        });
		}
		function initNoTake(){
			var url = "/bjyoms/order/selectChargingNoGetVehicleCount";
	        $.getJSON(url, null, function(res) {
	        	res=eval(res);
	        	if(res.result){
	        		$("#sNoTake").text(res.result);
	        	}else{
	        		//$.messager.alert('操作提示',res.message,'');
	        	}
	        });
		}
		function initGT2000(){
			var url = "/bjyoms/order/selectGT2000Count";
			$.getJSON(url, null, function(res) {
				res = eval(res);
				if (res.result) {
					noTake
					$("#sGT2000").text(res.result);
				} else {
					//$.messager.alert('操作提示',res.message,'');
				}
			});
		}
		function gt24() {
			$('#dgOrders').datagrid('options').queryParams = {
				'isGT24' : 1
			};
			$('#dgOrders').datagrid('load');
		}
		function noTake() {
			$('#dgOrders').datagrid('options').queryParams = {
				'isNoTake' : 1
			};
			$('#dgOrders').datagrid('load');
		}
		function gt2000() {
			$('#dgOrders').datagrid('options').queryParams = {
				'isGT2000' : 1
			};
			$('#dgOrders').datagrid('load');
		}
		function showOrHideQuery(obj) {
			
			if ($(obj).val() == "更多") {
				//setAutoHeight(398, "dgOrders");
				$(obj).val("收起");
			} else {
				setAutoHeight(230, "dgOrders");
				$(obj).val("更多");
			}

			$(".divh").toggle();
		}
	</script>

</body>
</html>