<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="../common/header.jsp"%>
<title>推广人员</title>
<script type="text/javascript" src="../../js/util/extendValidate.js"></script>
<script type="text/javascript" src="../../js/jquery.qrcode.min.js"></script>
<script type="text/javascript">
			
	$(function() {
		setAutoHeight(270,"dg");   
		
		var req_businessId = '${param.businessId}';//从推广商界面进入，可以获得
		var ses_businessId = '${business.id}';//商家登陆后，从左侧菜单点击进入，可以获得
		
		// 在推广员列表不要新增功能,如果要新增,请到推广商户列表 
		$("#text_input_button_left").hide();
		if(req_businessId != null && req_businessId != "" && req_businessId != "null" && req_businessId != 'undefined')
		{
			$("#searchBusinessId").val(req_businessId);
			$("#businessId").val(req_businessId);
			// 如果是从推广商户列表进来的,就显示可以新增
			$("#text_input_button_left").show();
		}
		else if(ses_businessId != null && ses_businessId != "" && ses_businessId != "null" && ses_businessId != 'undefined')
		{
			$("#btnReturn").remove();
			$("#searchBusinessId").val(ses_businessId);
			$("#businessId").val(ses_businessId);
		}
		
		$('#dg').datagrid({
			url:'${pageContext.request.contextPath}/promotionPerson/personList', 
			pagination:true,//分页控件 
	        rownumbers:true,//行号 
	        pageSize:10,
        	pageList :  [10,50,100],
        	emptyMsg:'无数据',
	        onBeforeLoad: function(param){
 		    	$($('#fm_s').serializeArray()).each(function(){  
 		    		param[this.name]=this.value;  
 	            }); 
 			},
 			onBeforeSelect:function(){
  				return false;
  			}
			
		});
		$('#dg').datagrid({
			columns : [ [ {
				field : 'id',
				checkbox : true,
			},{field:'operation',title: '操作',align: 'center',
                formatter:function(value,rowData,rowIndex){
                    //function里面的三个参数代表当前字段值，当前行数据对象，行号（行号从0开始）editCustomer
                    return "<a href='javascript:;' class='radiuBtn' onclick='edit(" + rowIndex + ");'>编辑</a><a href='javascript:;' class='radiuBtn' onclick='goPerformance(" + rowIndex + ");'>绩效成绩</a><a href='javascript:;' class='radiuBtn' onclick='goCustomer(" + rowIndex + ");'>注册用户</a>";  

               }  

            },{
				field : 'ordermoney',
				title : '订单金额',
				width : '10%',
				align : 'center'
			}, {
				field : 'pushmoney',
				title : '提成金额',
				width : '10%',
				align : 'center'
			}, {
				field : 'invitationCode',
				title : '二维码',
				width : '8%',
				align : 'center',
				formatter:qrcode
			}, {
				field : 'username',
				title : '用户名',
				width : '10%',
				align : 'center'
			}, {
				field : 'name',
				title : '真实姓名',
				width : '10%',
				align : 'center'
			}, {
				field : 'mobile',
				title : '手机号',
				width : '18%',
				align : 'center',
				formatter:checkBind
			}, {
				field : 'channelCode',
				title : '推广码',
				width : '18%',
				align : 'center'
			},{
				field : 'createdate',
				title : '创建时间',
				width : '15%',
				align : 'center'
			}, {
				field : 'isdisable',
				title : '状态',
				width : '8%',
				align : 'center',
				formatter:checkStatus
			}] ],
		});
		
		
		 $.extend($.fn.validatebox.defaults.rules, {
		        /*必须和某个字段相等*/
		        equalTo: { validator: function (value, param) { return $(param[0]).val() == value; }, message: '字段不匹配' }
		       });
		
		
		 var pager = $('#dg').datagrid('getPager');    // get the pager of datagrid
	        pager.pagination({
	        	pageSize:10,
	        	pageList : [10,50,100],
				displayMsg:'',
				links:5,
	        	layout:['prev','links','next','list']
	        }); 
		 
	     
	    $('#win').window('close');
	    $('#chPwd').window('close');
	});
	
	function add() {
		$('#fm').form('clear');
		$("#customer").text('');
		$("#channelCode").text('待生成');
		$('input:radio[name=isdisable]')[0].checked = true;
		$('input:radio[name=sendmsg]')[0].checked = true;
		//$('#businessId').val('${param.businessId}');
		var req_businessId = '${param.businessId}';//从推广商界面进入，可以获得
		var ses_businessId = '${business.id}';//商家登陆后，从左侧菜单点击进入，可以获得
		if(req_businessId != null && req_businessId != "" && req_businessId != "null")
		{
			$("#businessId").val(req_businessId);
		}
		else if(ses_businessId != null && ses_businessId != "" && ses_businessId != "null")
		{
			$("#businessId").val(ses_businessId);
		}
		$('#win').dialog('open').dialog('center').dialog('setTitle', '添加推广人员');
		$('#win').window('open');
		$("#unbind").show();
		$("#bind").hide();
	}
	function edit(rowIndex) {
		var row = $('#dg').datagrid('getData').rows[rowIndex];
		$('#win').dialog('open').dialog('center').dialog('setTitle', '修改推广人员');
		$('#fm').form('clear');
		$("#bindCustomer").text('');
        $("#invitationCode").text('');
		$('#fm').form('load', row);
		if(row.bindCustomerId == null || row.bindCustomerId == '')
		{
			$("#unbind").show();
			$("#bind").hide();
		}
		else
		{
			$("#unbind").hide();
			$("#bind").show();
			$("#bindCustomer").text(row.realName);
			$("#invitationCode").text(row.invitationCode);
		}
		if (row.channelCode == null || row.channelCode == '') {
			$("#channelCode").text('待生成');
		} else {
			$("#channelCode").text(row.channelCode);
		}
	}
	
	function saveOrUpdate(){
		var id = $("#id").val();
		var url = '${pageContext.request.contextPath}/promotionPerson/addPerson';
	    if (id.length > 0) {
			url = '${pageContext.request.contextPath}/promotionPerson/updatePerson';
		}
		$('#fm').form('submit', {
			url : url,
			onSubmit : function() {
				return $(this).form('validate');
			},
			success : function(result) {

				var result = eval('(' + result + ')');
				if (result.code != '10000') {
					$.messager.alert("操作提示", result.message, "");
				} else {
					$('#win').dialog('close'); // close the dialog
					$('#dg').datagrid('reload'); // reload the user data enctype="multipart/form-data"
				}
			}
		});
	}
	
	function beforeDelete() {
		var rows = $("#dg").datagrid("getChecked");
		if (rows && rows.length > 0) 
		{
		$.messager.confirm('确认', '确定要删除选中的推广用户吗?', function(r) {
			if (r)
				del();
		});
		}
		else
			{
			$.messager.alert("操作提示", "请选择要删除的推广用户", "");
			}
	}

	function del() {

		var rows = $("#dg").datagrid("getChecked");
			var ids = "";
			for (var i = 0; i < rows.length; i++) {
				var obj = rows[i];
				ids = ids + obj.id;
				if (i != rows.length - 1) {
					ids = ids + ",";
				}
			}
			var url = '${pageContext.request.contextPath}/promotionPerson/deletePerson'
			$.ajax({
				type : "GET",
				url : url,
				data : {
					ids : ids
				},
				dataType : "json",
				success : function(data) {
					if (data.code == 10000) {
						$.messager.alert("操作提示", "删除成功！", "");
						for (var i = 0; i < rows.length; i++) {
							var objr = rows[i];
							var index = $('#dg').datagrid('getRowIndex', objr);
							$('#dg').datagrid('deleteRow', index);
						}

					} else {
						$.messager.alert("操作提示", "删除失败！", "");
					}

				},
				error : function() {
					$.messager.alert("操作提示", "删除失败！", "");
				}
			});


	}
	function beforSearchCustomerByMobile()
	{
		searchCustomerByMobile($("#mobile").val())
	}
	
	function searchCustomerByMobile(mobile)
	{
		var url = '/bjycrm/customer/findCustomerByMobile'
			$.ajax({
				type : "GET",
				url : url,
				data : {
					mobile : mobile
				},
				dataType : "json",
				success : function(data) {
					if (data.code == 10000) {
						$("#customer").text(data.data.name);
						$("#bindCustomerId").val(data.data.id);

					} else {
						$("#customer").text('');
						$("#bindCustomerId").val('');
						$.messager.alert("操作提示", "没有查找到会员！", "");
					}

				}, 
				error : function() {
					$("#customer").text('');
					$("#bindCustomerId").val('');
					$.messager.alert("操作提示", "查找失败！", "");
				}
			});
	}
	
	function goPerformance(rowIndex) 
	{
		var row = $('#dg').datagrid('getData').rows[rowIndex];
		url = "performanceList.jsp?invitationCode="+row.invitationCode;
		window.location.href = url;
	}
	function goCustomer(rowIndex) 
	{
		var row = $('#dg').datagrid('getData').rows[rowIndex];
		url = "regCustomerList.jsp?recommendCode="+row.channelCode;
		window.location.href = url;
	}
	
	function qrcode(value, row, index){
		if(value !=null)
		{
			return "<a href='javascript:;' class='datagrid_font_green' onclick='code("+value+")'>查看</a>";
		}
		else
		{
			return value;
		}
		
	}
	
	function code(val)
	{
		$('#output').dialog('open').dialog('center').dialog('setTitle', '二维码:'+val);
	    //$('#output').window('open');
	    $('#output').empty();
		//$('#output').qrcode(""+val); 
	    $("#output").qrcode({ 
	        render: "table", //table方式 
	        text: ""+val 
	    }); 
	}
	
	function checkBind(value, row, index){
		if(row.bindCustomerId !=null)
		{
			return value+'(已绑定)';
		}
		else
		{
			return value;
		}
		
	}
	
	function checkStatus(value, row, index){
		if(value == '0' )
		{
			return '启用';
		}
		else
		{
			return '禁用';
		}
		
	}
	
	function getExcel()
	{
		var url = '${pageContext.request.contextPath}/promotionPerson/personExcelList';
		//alert(url);
		$('#fm_s').form('submit', {
			url : url,
			onSubmit : function() {
				//return $(this).form('validate');
			},
			success : function(result) {

				//alert(result);
			}
		});
		
	}
	
	
	
	function search(){
        $('#dg').datagrid('load');
    }
	
	
</script>
</head>
<body>
<div class="list_title">
	 <span class="layui-parent-title-customer">HOME</span>
 	 <span class="layui-badge-dot layui-bg-title"></span>
     <span class="layui-children-title-customer">推广人员</span>
	<a id="btnReturn"
				href="<%=request.getContextPath()%>/jsp/promotion/businessList.jsp"
				style="float: right; font-size: 28px;">返回上级</a></div>

<div class="text_input">
		<span class="div_search_customerBar"></span>
	    	<form id='fm_s' action="">
	    		<div class="form_item">
	    			<div class="form_item_inline">
	    				<label class="form_item_label3">用户名</label>
	    				<div class="form_item_input">
	    					<input name="username"  class="easyui-textbox"  style="width:100px" />
	    				</div>
	    			</div>
	    			<div class="form_item_inline">
	    				<label class="form_item_label2">名称</label>
	    				<div class="form_item_input">
	    					<input name="name" class="easyui-textbox" style="width:100px">
	    				</div>
	    			</div>
	    			<div class="form_item_inline">
	    				<label class="form_item_label2">电话</label>
	    				<div class="form_item_input">
	    					<input name="mobile" class="easyui-textbox" style="width:100px">
	    				</div>
	    			</div>
	    			<div class="form_item_inline">
	    				<label class="form_item_label2">状态</label>
	    				<div class="form_item_input">
	    					<select name="isdisable" class="easyui-combobox"  style="width:100px">
	    						<option value="">全部</option>
	    						<option value="0">启用</option>
	    						<option value="1">禁用</option>
	    					</select>
	    					<input type="hidden" name = "businessId" id = "searchBusinessId" /> 
	    				</div>
	    			</div>
	    			<div class="form_item_inline">
	    				<input type="button" onclick="search()" class="text_input_button_search" value="查询">
	    			</div>
	    		</div>
	    	</form>	
</div>	
	<div class="table_data">
		<h4 class="table_data_title">
			推广人员
			<div class="text_input_bottom">
				<div class="text_input_button_add" id="text_input_button_left"
					onclick="add()">新增</div>
				<div class="text_input_button_del" id="text_input_button_left"
					onclick="beforeDelete()">删除</div>
					<div class="text_input_button" id="text_input_button_left"
					onclick="getExcel()">导出</div>
			</div>
		</h4> 
		<table id="dg"></table> 
	</div>

	<div id="output" title="二维码"  class="easyui-dialog" style="width:270px;height:320px; left:15%;top:2%;" closed="true">
	</div>
	<div id="win" title="添加推人员" iconCls="icon-save" class="easyui-dialog" style="width:650px;height:450px; display: none; left:15%;top:2%;" closed="true" buttons="#dlg-buttons" >  
<form id="fm" action="" method="post"  >
			<table class="order_info" height="250">
				<tr>
					<td><span style="color: red;">*</span><label for="username">用户名:</label></td>
					<td><input class="easyui-validatebox validatebox-invalid_input" type="text"
						name="username" data-options="required:true"  validType = "username"/></td>
				
				    <td><span style="color: red;">*</span><label for="name">真实姓名:</label></td>
					<td><input class="easyui-validatebox validatebox-invalid_input" type="text" name="name"
						data-options="required:true" maxlength="16"/></td>
					
				</tr>
				<tr id="unbind" >
				    <td><label for="mobile">手机号:</label></td>
					<td><input class="easyui-validatebox validatebox-invalid_input" type="text" id = "mobile" name="mobile" validType="mobile" />
					<input type ="button" class="text_input_button" style="margin-top: 10px; width: 162px !important;" value="绑定注册用户" onclick="beforSearchCustomerByMobile()"/>
					</td>
					<td>查询用户:</td>
					<td><span id="customer" ></span></td>
				</tr>
				<tr id="bind" >
				    <td><label for="mobile">已绑定用户:</label></td>
					<td><span id="bindCustomer" ></span></td>
					<td>邀请码:</td>
					<td><span id="invitationCode" ></span></td>
				</tr>
				<tr>
					<td>推广码:</td>
					<td><span id="channelCode"></span></td>
				</tr>
				<tr>
				    <td><label for="status">状态:</label></td>
					<td><input type="radio" name="isdisable" value="0" checked="checked"  style="border:none;">&nbsp;&nbsp;启用 <input type="radio" name="isdisable" value="1"  style="border:none;" >&nbsp;&nbsp;禁用
					</td>
					<td><label for="sendmsg">发送消息:</label></td>
					<td><input type="radio" name="sendmsg" value="0" checked="checked"  style="border:none;">&nbsp;&nbsp;开启 <input type="radio" name="sendmsg" value="1"  style="border:none;" >&nbsp;&nbsp;关闭
					</td>
				</tr>
				<tr>
				    <td><label for="mobile">欢迎消息:</label></td>
					<td colspan="3">
				     <textarea name="welcomemsg" style="width: 300px;height: 100px;"></textarea>
					</td>
					
				</tr>
			</table>
			<input type="hidden" name = "id" id = "id"/>
			<input type="hidden" name = "bindCustomerId" id = "bindCustomerId"/> 
			<input type="hidden" name = "businessId" id = "businessId"/> 
		</form>
		</div>
		<div id="dlg-buttons" style="display: none;clear:both">
	      <div class="text_input_button_cancel" onclick="javascript:$('#win').dialog('close')">取消</div>
          <div class="text_input_button_float" onclick="javascript:saveOrUpdate()">保存</div>
        
        
          
</div>
</body>
</html>