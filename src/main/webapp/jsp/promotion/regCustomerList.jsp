<%@ page language="java" pageEncoding="UTF-8" import="org.owasp.esapi.ESAPI" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="../common/header.jsp"%>
<title>注册用户管理</title>


<script type="text/javascript" src="../../js/util/extendValidate.js"></script>
<script type="text/javascript">
			
	$(function() {  
	setAutoHeight(300,"dg");
	var recommendCode = '<%=ESAPI.encoder().encodeForJavaScript(request.getParameter("recommendCode"))%>';//从推广商界面进入，可以获得
	var businessId = '${business.id}';//商家登陆后，从左侧菜单点击进入，可以获得
	
	var url = "/bjycrm/customer/getRegisterCustomers";
	if(recommendCode != null && recommendCode != "" && recommendCode != "null" && recommendCode != 'undefined')
	{
		$("#recommendCode").val(recommendCode);
		//url += '?recommendCode='+recommendCode;
	}
	else if(businessId != null && businessId != "" && businessId != "null" && businessId != 'undefined')
	{
		$("#businessId").val(businessId);
		//url += '?businessId='+businessId;
	}
	else
	{
		$("#promote").val('yes');
		//url += '?promote=yes';
	}
		
		$('#dg').datagrid({
			url:url, 
			pagination:true,//分页控件 
	        rownumbers:true,//行号 
	        singleSelect:true,
	        pageSize:10,
        	pageList :  [10,50,100],
	        emptyMsg:'无数据',
	        onBeforeLoad: function(param){
 		    	$($('#fm_s').serializeArray()).each(function(){  
 		    		param[this.name]=this.value;  
 	            }); 
 			},
		});
		$('#dg').datagrid({
			columns : [ [ /* {
				field : 'id',
				checkbox : true,
			}, */{
				field : 'username',
				title : '用户名',
				align : 'center',
				width:'10%'
			}, {
				field : 'name',
				title : '姓名',
				align : 'center',
				width:'10%'
			},  {
				field : 'mobile',
				title : '手机',
				align : 'center',
				width:'20%'
			},  {
				field : 'recommendName',
				title : '地推人员',
				align : 'center',
				width:'15%'
			}, {
				field : 'isdisable',
				title : '是否禁用',
				align : 'center',
				width:'10%',
				formatter:noOrYes
			}, /* {
				field : 'auditstatus',
				title : '审核状态',
				align : 'center',
				formatter:checkStatus
			}, */ {
				field : 'identityapprove',
				title : '身份认证状态',
				align : 'center',
				width:'15%',
				formatter:authentication
			},  {field:'ordernum',title: '订单数量',align: 'center',
                formatter:function(value,rowData,rowIndex){
                    //function里面的三个参数代表当前字段值，当前行数据对象，行号（行号从0开始）editCustomer
                    return "<a href='javascript:;' onclick='goToOrderList(" + rowIndex + ");'>"+value+"</a>";  

               }  

            },   {
				field : 'createdate',
				title : '创建时间',
				align : 'center',
				width:'25%'
			} ] ],
		
			
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
	    $('#auditStatus').combobox
	    ({    
	    		editable: false  
      }); 
	    $('#identityApprove').combobox
	    ({    
	    		editable: false  
      }); 
	    $('#isDisable').combobox
	    ({    
	    		editable: false  
      }); 
	});
	
	function goToOrderList(rowIndex)
	{
		var row = $('#dg').datagrid('getData').rows[rowIndex];
		window.location.href='<%=request.getContextPath()%>/jsp/promotion/orderList.jsp?customerID='+row.id;
	}
	
	
	function noOrYes(val,rec){ 
		if (val == '0')
		{ 
		    return '启用'; 
		} else { 
			return '禁用'; 
		} 
	}
	function authentication(val,rec){ 
		if (val == '0')
		{ 
		    return '未认证'; 
		} else if (val == '1'){ 
			return '认证通过'; 
		}else if (val == '2'){ 
			return '认证驳回'; 
		}else if (val == '3'){ 
			return '认证中'; 
		}   
	}
	
	function checkStatus(val,rec){ 
		if (val == '0')
		{ 
		    return '待审核'; 
		} else if (val == '1'){ 
			return '通过审核'; 
		}else if (val == '2'){ 
			return '审核驳回'; 
		}  
	}

	function getExcel()
	{
		<%-- alert("hhh");
		var queryParam = getFormJson($("#fm_s")[0]);
		alert(queryParam);
		var url = "<%=request.getContextPath()%>/customer/exportRegCustomers?"+$.param(queryParam);
		alert(url);
		window.open(url); --%>
		
		 
		var url = '/bjycrm/customer/exportRegCustomers';
		$('#fm_s').form('submit', {
			url : url,
			onSubmit : function() {
				return $(this).form('validate');
			},
			success : function(result) {

				//alert(result);
			}
		});
		
	}
	
	
	
	function beforeDeleteCustomer() {
		var rows = $("#dg").datagrid("getSelections");
		if (rows && rows.length > 0) 
		{
		$.messager.confirm('确认', '确定要删除选中的会员吗?', function(r) {
			if (r)
				deleteCustomer();
		});
		}
		else
			{
			$.messager.alert("操作提示", "请选择要删除的会员", "");
			}
	}

	

	function search() {
		$('#dg').datagrid('load');
	}
</script>
</head>
<body>
<div class="list_title">
	 <span class="layui-parent-title-customer">HOME</span>
	 <span class="layui-badge-dot layui-bg-title"></span>
	 <span class="layui-children-title-customer">注册用户管理</span>
<%if(request.getParameter("recommendCode")!=null){ %>
<a id="btnReturn"
				href="javascript:history.go(-1)"
				style="float: right; font-size: 28px;">返回上级</a>
<%} %>
</div>
<div class="text_input">
	<span class="div_search_customerBar"></span>
	<form id='fm_s' >
			<div class="form_item">
				<div class="form_item_inline">
					<label class="form_item_label6">企业名</label>
					<div class="form_item_input">
							<input type="hidden" name = "businessId" id = "businessId"/> 
							<input type="hidden" name = "recommendCode" id = "recommendCode"/> 
							<input type="hidden" name = "promote" id = "promote"/> 
							<input name="companyName" class="easyui-textbox" />
					</div>
				</div>
				<div class="form_item_inline">
					<label class="form_item_label5">用户名</label>
					<div class="form_item_input">
						<input name="username" class="easyui-textbox" />
					</div>
				</div>
				<div class="form_item_inline">
					<label class="form_item_label4">手机号</label>
					<div class="form_item_input">
						<input name="mobile" class="easyui-textbox" />
					</div>
				</div>
				<div class="form_item_inline">
					<label class="form_item_label4">姓名</label>
					<div class="form_item_input">
						<input name="name" class="easyui-textbox" />
					</div>
				</div>
				<div class="form_item_inline">
					<input type="button" onclick="search()" class="text_input_button_search" value="查询">
				</div>
			</div>
			<div class="form_item form_item_hidden">
				<div class="form_item_inline">
					<label class="form_item_label6">身份认证状态</label>
					<div class="form_item_input">
							<select id="identityapprove" name="identityapprove" class="easyui-combobox" style="width: 80px !important;">
								<option  value="" selected="selected">身份认证状态</option>
								<option  value="0" >未认证</option>
								<option  value="1">认证通过</option>
								<option  value="2">认证驳回</option>
								<option  value="3">认证中</option>
							</select>
					</div>
				</div>
				<div class="form_item_inline">
					<label class="form_item_label5">启用/禁用</label>
					<div class="form_item_input">
							<select id="isdisable" name="isdisable" class="easyui-combobox" style="width: 80px !important;">
								<option  value="" selected="selected">启用/禁用</option>
								<option  value="0" >启用</option>
								<option  value="1">禁用</option>
							</select>
					</div>
				</div>
				<div class="form_item_inline">
					<label class="form_item_label4">注册时间</label>
					<div class="form_item_input">
						<input name="startcreatedate" class="easyui-datebox" style="width:130px;" >
					</div>
					<label class="form_item_label1">-</label>
					<div class="form_item_input">
						<input name="endcreatedate" class="easyui-datebox" style="width:130px;" >
					</div>
				</div>
			</div>
			<div class="form_item form_item_hidden">
				<div class="form_item_inline">
					<label class="form_item_label6">地推人员</label>
					<div class="form_item_input">
						<input name="recommendName" class="easyui-textbox">
					</div>
				</div>
			</div>
		</form>	
		<div class="form_more_item">
              <span class="form_item_more form_show" > 更多</span>
              <span class="form_item_less"> 收起</span>
       	</div>
	  </div>	
	<div class="table_data">
		<h4 class="table_data_title">
			注册用户管理
			<div class="text_input_bottom">
				<input type="button" onclick="getExcel()" class="text_input_button text_input_button_right" value="导出">
			</div>
		</h4>
		<table id="dg"></table>   
	</div> 
	<script>
	  //显示更多
	  $(".form_item_more").on("click",function(){
	        $(".form_item_more").removeClass('form_show');
	        $(".form_item_less").addClass('form_show');
	        $(".form_item_hidden").toggle();
	       /*  $(".form_item_hidden").css("display","block"); */
	  });
	  //收起查询的字段信息
	  $(".form_item_less").on("click",function(){
	        $(".form_item_less").removeClass('form_show');
	        $(".form_item_more").addClass('form_show');
	        $(".form_item_hidden").toggle();
	        /* $(".form_item_hidden").css("display","none"); */
	  })
	</script>
</body>
</html>