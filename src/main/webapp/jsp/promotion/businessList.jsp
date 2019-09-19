<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="../common/header.jsp"%>

<title>推广商户</title>
<script type="text/javascript" src="../../js/util/extendValidate.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/md5.js"></script>
<script type="text/javascript">
			
	$(function() {
		setAutoHeight(270,"dg");   
		$('#dg').datagrid({
			url:'${pageContext.request.contextPath}/promotionBusiness/businessList', 
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

                    return "<a href='javascript:;' class='radiuBtn' onclick='editBusiness(" + rowIndex + ");'>编辑</a><a href='javascript:;' class='radiuBtn' onclick='goPerson(" + rowIndex + ");'>推广人员</a><a href='javascript:;' class='radiuBtn' onclick='goRules(" + rowIndex + ");'>绩效规则</a><a href='javascript:;' class='radiuBtn' onclick='couponConfig(" + rowIndex + ");'>优惠券配置</a>";  

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
				field : 'username',
				title : '用户名',
				width : '20%',
				align : 'center'
			}, {
				field : 'name',
				title : '名称',
				width : '20%',
				align : 'center'
			}, {
				field : 'mobile',
				title : '电话',
				width : '20%',
				align : 'center'
			}, {
				field : 'address',
				title : '地址',
				width : '20%',
				align : 'center'
			}, {
				field : 'mail',
				title : '邮箱',
				width : '22%',
				align : 'center'
			}] ],
		});
		
		
		 $.extend($.fn.validatebox.defaults.rules, {
		        /*必须和某个字段相等*/
		        equalTo: { validator: function (value, param) { return $(param[0]).val() == value; }, message: '字段不匹配' }
		       });
		
		
		 var pager = $('#dg').datagrid('getPager');    // get the pager of datagrid
	        pager.pagination({
	        	pageSize:10,
	        	pageList :  [10,50,100],
				displayMsg:'',
				links:5,
	        	layout:['prev','links','next','list']
	        }); 
		 
	    $('#win').window('close');
	    $('#chPwd').window('close');
	});
	
	function couponConfig(rowIndex){
		var row = $('#dg').datagrid('getData').rows[rowIndex];
		if(row.couponPackageId){
			window.location.href='<%=request.getContextPath()%>/jsp/couponmanage/couponpackagelist.jsp?packageId='+row.couponPackageId;
			return;
		}
		
		var url = "<%=request.getContextPath()%>/promotionBusiness/couponpackageid";
		var userName = row.username;
		var id = row.id;
		var data = {businessId:id,userName:userName};
		$.post(url,data).done(function(result){
			if(result.code != 100000){
				$.messager.alert("操作提示", "获取优惠券包信息失败", "");
				return;
			}
			
			window.location.href='<%=request.getContextPath()%>/jsp/couponmanage/couponpackagelist.jsp?packageId='+result.data;
		});
	}
	
	function addCustomer() {
		//$('#fm')[0].reset();
		$('#fm').form('clear');
		//$("input[name='isdisable'][value='0']").attr("checked",true); 
		$("#username").attr("readonly",false);
		$('input:radio[name=isdisable]')[0].checked = true;
		$("tr[name='pass']").show();//编辑状态，显示密码输入框。
		$('#password').validatebox({
			required : true
		});
		$('#rePassword').validatebox({
			required : true
		});
		$('#win').window('open');
	}
	function editBusiness(rowIndex) {
		//$('#fm')[0].reset();
		$('#fm').form('clear');
		var row = $('#dg').datagrid('getData').rows[rowIndex];
		$('#win').dialog('open').dialog('center').dialog('setTitle', '修改推广商');
		$("tr[name='pass']").hide();//编辑状态，隐藏密码输入框。
		$('#password').validatebox({
			required : false
		});
		$('#rePassword').validatebox({
			required : false
		});
		$("#username").attr("readonly",true);
		$('#fm').form('load', row);
		
		
	}
	
	function saveOrUpdate(){
		var id = $("#id").val();
		var url = '${pageContext.request.contextPath}/promotionBusiness/addBusiness';
	    if (id.length > 0) {
			url = '${pageContext.request.contextPath}/promotionBusiness/updateBusiness';
		}
		$('#fm').form('submit', {
			url : url,
			onSubmit : function() {
				$("#rePassword_encrypt").val(hex_md5($("#password").val()));
				var res=$(this).form('validate');
				if(res){
					var st=$("#startdate").datetimebox('getValue');
		 			var et=$('#enddate').datetimebox('getValue');
		 			if(dateCompare(st,et)==false){
		 				$.messager.alert('信息提示','截止时间不得小于开始时间');
		 				return false;
		 	    	} 
				}
				return res;
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
	//比较日期日期大小(dt1>dt2返回false,否则返回true)
		function dateCompare(dt1,dt2){
			var starttime = new Date(dt1);
		var endtime = new Date(dt2);
		if (Date.parse(starttime) > Date.parse(endtime)) {
			return false;
		} else {
			return true;
		}
		}
	function beforeDeleteBusiness() {
		var rows = $("#dg").datagrid("getChecked");
		if (rows && rows.length > 0) 
		{
		$.messager.confirm('确认', '确定要删除选中的推广商户吗?', function(r) {
			if (r)
				deleteBusiness();
		});
		}
		else
			{
			$.messager.alert("操作提示", "请选择要删除的推广商户", "");
			}
	}

	function deleteBusiness() {

		var rows = $("#dg").datagrid("getChecked");
			var ids = "";
			for (var i = 0; i < rows.length; i++) {
				var obj = rows[i];
				ids = ids + obj.id;
				if (i != rows.length - 1) {
					ids = ids + ",";
				}
			}
			var url = '${pageContext.request.contextPath}/promotionBusiness/deleteBusiness'
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
							//$('#dg').datagrid('deleteRow', index);
							$('#dg').datagrid('reload');
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
	
	
	function goRules(rowIndex) 
	{
		var row = $('#dg').datagrid('getData').rows[rowIndex];
		url = "rulesList.jsp?businessId="+row.id;
		window.location.href = url;
	}
	
	function goPerson(rowIndex) 
	{
		var row = $('#dg').datagrid('getData').rows[rowIndex];
		url = "personList.jsp?businessId="+row.id;
		window.location.href = url;
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
     <span class="layui-children-title-customer">推广商户</span>
</div>

<div class="text_input">
		<span class="div_search_customerBar"></span>
	    	<form id='fm_s' action="">
	    		<div class="form_item">
	    			<div class="form_item_inline">
	    				<label class="form_item_label3">用户名</label>
	    				<div class="form_item_input">
	    					<input name="username" class="easyui-textbox" style="width:100px" />
	    				</div>
	    			</div>
	    			<div class="form_item_inline">
	    				<label class="form_item_label2">名称</label>
	    				<div class="form_item_input">
	    					<input name="name" class="easyui-textbox" style="width:100px" />
	    				</div>
	    			</div>
	    			<div class="form_item_inline">
	    				<label class="form_item_label2">电话</label>
	    				<div class="form_item_input">
	    					<input name="mobile" class="easyui-textbox" style="width:100px" />
	    				</div>
	    			</div>
	    			<div class="form_item_inline">
	    				<label class="form_item_label2">地址</label>
	    				<div class="form_item_input">
	    					<input name="address" class="easyui-textbox" style="width:100px"/>
	    				</div>
	    			</div>
	    			<div class="form_item_inline">
	    				<input type="button" onclick="search()" class="text_input_button_search" value="查询" />
	    			</div>
	    		</div>
	    	</form>	
</div>	
	<div class="table_data">
		<h4 class="table_data_title">
			推广商户
			<div class="text_input_bottom">
				<div class="text_input_button_add" id="text_input_button_left"
					onclick="addCustomer()">新增</div>
				<div class="text_input_button_del" id="text_input_button_left"
					onclick="beforeDeleteBusiness()">删除</div>	
			</div>
		</h4>   
		<table id="dg"></table>  
 	</div>
	<div id="win" title="添加推广商" iconCls="icon-save" class="easyui-dialog" style="width:700px;height:450px; display: none;" closed="true" buttons="#dlg-buttons" >  
	<form id="fm" method="post"  >
			<table class="order_info" height="250">
				<tr>
					<td><span style="color:red;">*</span><label for="username">用户名</label></td>
					<td><input class="easyui-validatebox validatebox-invalid_input" type="text"
						name="username" id = "username" data-options="required:true" validType = "username" maxlength="18"/></td>
				
				    <td><span style="color:red;">*</span><label for="name">名称</label></td>
					<td><input class="easyui-validatebox validatebox-invalid_input" type="text" name="name"
						data-options="required:true" maxlength="16"/></td>
				</tr>
				<tr name ="pass">
				    <td><span style="color:red;">*</span><label for="password">密码</label></td>
					<td><input class="easyui-validatebox validatebox-invalid_input" validType="password" maxlength="16" type="password" id ="password" autocomplete="off"
						/></td>
					<td><span style="color:red;">*</span><label for="rePassword">确认密码</label></td>
					<td><input class="easyui-validatebox validatebox-invalid_input" type="password" id ="rePassword"  autocomplete="off"
						validType="equalTo['#password']" invalidMessage="两次输入密码不匹配"/>
						<input id ="rePassword_encrypt" name="password" type="hidden" />
					</td>
				</tr>
				<tr>
				    <td><label for="mobile">电话</label></td>
					<td><input class="easyui-validatebox validatebox-invalid_input" type="text" name="mobile" validType="mobile" />
					</td>
					<td><label for="address">地址</label></td>
					<td><input class="easyui-validatebox validatebox-invalid_input" type="text" name="address"  maxlength="30"/>
					</td>
				</tr>
				<tr>
				    <td><label for="mobile">邮箱</label></td>
					<td><input class="easyui-validatebox validatebox-invalid_input" data-options="validType:['email']" type="text" id = "m" name="mail"/>
					</td>
					<td><label for="isdisable">禁用</label></td>
					<td><input type="radio" name="isdisable" value="0" checked="checked"  style="border:none;">&nbsp;&nbsp;否 <input type="radio" name="isdisable" value="1"  style="border:none;" >&nbsp;&nbsp;是
					</td>
				</tr>
				<tr>
				    <td><span style="color:red;">*</span><label for="startdate">统计开始时间</label></td>
					<td><input name="startdate" id="startdate" type="text" class="easyui-datebox" style="width:155px"
				 editable="false" data-options="required:true"  />
					</td>
					<td><span style="color:red;">*</span><label for="enddate">统计截止时间</label></td>
					<td><input name="enddate" id="enddate" class="easyui-datebox"
				style="width:155px" editable="false"
				data-options="required:true" />
					</td>
				</tr>
			</table>
			<input type="hidden" name = "id" id = "id" value = ''/> 
			<input type="hidden" name = "userId" id = "userId" value = ''/> 
		</form>
		</div>
		<div id="dlg-buttons" style="display: none; clear:both">
	      <div class="text_input_button_cancel" onclick="javascript:$('#win').dialog('close')">取消</div>
          <div class="text_input_button_float" onclick="javascript:saveOrUpdate()">保存</div>
        
          
</div>
</body>
</html>