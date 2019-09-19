<%@ page language="java" pageEncoding="UTF-8" import="org.owasp.esapi.ESAPI"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="../common/header.jsp"%>
<title>优惠券配置</title>
<script type="text/javascript" src="../../js/util/extendValidate.js"></script>
<script type="text/javascript">
			
	$(function() {  
		
	var businessId = '<%=ESAPI.encoder().encodeForJavaScript(request.getParameter("businessId"))%>';
	$("#businessID").val(businessId);
	setAutoHeight(270,"dg"); 
		$('#dg').datagrid({
			url:'${pageContext.request.contextPath}/couponRule/getCouponRuleItemList?businessID='+businessId, 
			pagination:true,//分页控件 
	        rownumbers:true,//行号 
	        emptyMsg:"无数据",
	        pageSize:10,
	        singleSelect:true,
        	pageList :  [10,50,100],
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
			}, */{field:'operation',title: '操作',align: 'center',width:'10%',
                formatter:function(value,rowData,rowIndex){
                    //function里面的三个参数代表当前字段值，当前行数据对象，行号（行号从0开始）editCustomer
                    return "<a href='javascript:;' class='radiuBtn' onclick='editCouponRuleItem(" + rowIndex + ");'>编辑</a><a href='javascript:;' class='radiuBtn' onclick='deleteCouponRuleItem(" + rowIndex + ");'>删除</a>";  

               }  

            },{
				field : 'ruleidentification',
				title : '规则名称',
				align : 'center',
				width:'10%',
			}, {
				field : 'presentmoney',
				title : '赠送金额',
				align : 'center',
				width:'10%',
			},{
				field : 'validday',
				title : '有效天数',
				align : 'center',
				width:'10%',
			}, {
				field : 'createdate',
				title : '创建时间',
				align : 'center',
				width:'20%',
			},{
				field : 'modifydate',
				title : '最后更新时间',
				align : 'center',
				width:'20%',
			},{
				field : 'introduction',
				title : '规则说明',
				align : 'center',
				width:'25%',
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
		  
	});
	

	function addCouponRuleItem(){
		//formClear();
		$('#fm').form('clear');
		$('#imgpathForm').form('clear');
		$('#imgpathImg').attr('src',"");
		$("#imgpathinfo").text("");
		$("#textfield1").val("点击选择图片");
		
		
		var businessId = '<%=ESAPI.encoder().encodeForJavaScript(request.getParameter("businessId"))%>';
		$("#businessID").val(businessId);
		
		//$('#fm')[0].reset();
		$("#ruleidentification").val('地推优惠券');
		$("#validday").val('30');
		$("#presentcoumt").val('1');
		
		$('#usingtype').combobox('setValue',"0");		
		$('#timecontrol').combobox('setValue',"0");
		$('#ispostpone').combobox('setValue',"0");
		$('#win').window('open');
    }
	function editCouponRuleItem(rowIndex){
		
		$('#fm').form('clear');
		$('#imgpathForm').form('clear');
		$('#imgpathImg').attr('src',"");
		$("#imgpathinfo").text("");
		$("#textfield1").val("点击选择图片");
		
		var row = $('#dg').datagrid('getData').rows[rowIndex];
		//alert(row.imgurl);
		//$('#win').window('open');
		$('#win').dialog('open').dialog('center').dialog('setTitle', '规则明细修改');
		$('#imgurl').val(row.imgurl);
		$('#imgpathImg').attr('src',"/"+row.imgurl);
		$('#fm').form('load',row);
    }

	
	
	//删除方法
	function deleteCouponRuleItem(rowIndex) 
	{
		
		//var rows = $("#dg").datagrid("getSelections");
		var row = $('#dg').datagrid('getData').rows[rowIndex];
		if (row) {
			$.messager.confirm('确认', '确定要删除选中的地推规则吗?', function(r) 
			{
				if(r)
				{
					/* var ids = "";
					for (var i = 0; i < rows.length; i++) {
						var obj = rows[i];
						ids = ids + obj.id;
						if (i != rows.length - 1) {
							ids = ids + ",";
						}
					} */
					var url = '${pageContext.request.contextPath}/couponRule/deleteCouponItem'
					$.ajax({
						type : "GET",
						url : url,
						data : {
							ids : row.id
						},
						dataType : "json",
						success : function(data) {
							if (data.code == 10000) {
								$.messager.alert("操作提示", "删除成功！", "");
								$('#dg').datagrid('reload');
								
								/* for (var i = 0; i < rows.length; i++) {
									var objr = rows[i];
									var index = $('#dg').datagrid('getRowIndex', objr);
									//$('#dg').datagrid('deleteRow', index);
									$('#dg').datagrid('reload');
								} */

							} else {
								$.messager.alert("操作提示", "删除失败！", "");
							}

						},
						error : function() {
							$.messager.alert("操作提示", "删除失败！", "");
						}
					});
					}
				
				
			});
		} else {
			$.messager.alert("操作提示", "请选择要删除的地推规则", "");
		}		
	}
	
function uploadImg(tid) {
		
		$('#' + tid + "Form").form('submit', {
			url : '${pageContext.request.contextPath}/upload',
			onSubmit : function() {
				
	        if ($(this).form('validate')) {
				var imagePath = $(this)[0].imgfile.value.toLowerCase();
					if (!/\.(png|jpg|jpeg|bmp)$/.test(imagePath)) {
						$.messager.alert("操作提示", "图片类型必须是.png,jpeg,jpg,bmp中的一种", "");
						return false;
					}
					else
						{
						return true;
						}
				}
                else {
					return false;
				}
			},
			success : function(result) {
				var result = eval('(' + result + ')');
				if (result.code != '10000') {
					$.messager.alert("操作提示", result.message, "");
				} else {
					var path = result.data.relativePath;
					var previewPath = result.data.previewPath;
					$("#" + tid).val(path);
					$("#imgurl").val(path);
					$("#" + tid +"Img").attr('src','/'+previewPath); 
					$("#" + tid + "info").text("上传成功");
				}
			}
		});
	}
	

function saveOrUpdateCouponItem(){
	var url = '${pageContext.request.contextPath}/couponRule/addOrUpdateCouponItem';
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
	
	function search() {
		$('#dg').datagrid('load');
	}
</script>
</head>
<body>
<div class="list_title">
	 <span class="layui-parent-title-customer">HOME</span>
 	 <span class="layui-badge-dot layui-bg-title"></span>
     <span class="layui-children-title-customer">优惠券配置</span>
	<a id="btnReturn"
				href="<%=request.getContextPath()%>/jsp/promotion/businessList.jsp"
				style="float: right; font-size: 28px;">返回上级</a></div>

	
	<div class="table_data">
		<h4 class="table_data_title">
			优惠券配置
			<div class="text_input_bottom">
				<div class="text_input_button_add" id="text_input_button_left"
					onclick="addCouponRuleItem()">添加</div>		
			</div>
		</h4>
		<table id="dg"></table>  
	</div>
    
    
    
    
	
	<div id="win" title="规则明细添加" iconCls="icon-save" class="easyui-dialog" style="width:800px;height:500px; display: none; left:15%;top:2%;" closed="true" buttons="#dlg-buttons" >  
	<form id="fm"  method="post"  >
			<table class="order_info" height="250">
				<tr>
					<td><label for="ruleidentification">所属规则</label></td>
					<td><input id="ruleidentification" class="easyui-validatebox validatebox-invalid_input" type="text"
						name="ruleidentification" value = "地推优惠券"  readonly="readonly" /></td>
				
				    <td><label for="presentmoney"><span style="color: red;">*</span>赠送金额</label></td>
					<td><input class="easyui-validatebox validatebox-invalid_input" type="text" name="presentmoney"
						data-options="required:true" maxlength="10" validType="moneyNumber" /></td>
					
				</tr>
				<tr >
				    <td><label for="usingtype">适用类型</label></td>
					<td><select id="usingtype" name="usingtype" class="easyui-combobox" style="width: 100px;">
							<option  value="0" selected="selected">通用</option>
							<option  value="1">机场专用</option>
							</select></td>
					<!-- <td><label for="timecontrol">时段控制</label></td>
					<td><select id="timecontrol" name="timecontrol" class="easyui-combobox" style="width: 100px;">
							<option  value="0" selected="selected">全部</option>
							<option  value="1">白天分时</option>
							<option  value="2">晚间闲时</option>
							</select></td> -->
				</tr>
				<tr>
				    <td><label for="validday"><span style="color: red;">*</span>有效天数</label></td>
					<td><input class="easyui-validatebox validatebox-invalid_input" data-options="required:true"
					maxlength="9" validType="ZNumber" type="text" value="30" id="validday" name="validday"  />
					</td>
					<td><label for="presentcoumt"><span style="color: red;">*</span>赠送数量</label></td>
					<td><input class="easyui-validatebox validatebox-invalid_input" data-options="required:true"
					maxlength="9" validType="ZNumber" type="text" value="1" name="presentcoumt" id="presentcoumt"/> </td>
				</tr>
				<tr>
				    <td><label for="ispostpone">有效期延后(多张有效)</label></td>
					<td><select id="ispostpone" name="ispostpone" class="easyui-combobox" style="width: 100px;">
							<option  value="0" selected="selected">关闭</option>
							<option  value="1">启动</option>
							</select></td>
					<td><label for="reamark">优惠券备注</label></td>
					<td><input class="easyui-validatebox validatebox-invalid_input" type="text"  name="reamark"  />
					</td>
				</tr>
				
				<tr>
					<td ><label for="introduction">规则说明</label></td>
					<td ><input class="easyui-validatebox validatebox-invalid_input" type="text" name="introduction" />
					</td>
					<td></td>
					<td></td>
				</tr>
			</table>
			<input type="hidden" name = "id" id = "id"/> 
			<input type="hidden" name = "imgurl" id = "imgurl"/> 
			<input type="hidden" name = "businessID" id = "businessID"/> 
		</form>
		
		
		<form id="imgpathForm" action="${pageContext.request.contextPath}/upload"
			method="post" enctype="multipart/form-data">
			<table style="width:40%; float:left; margin-left:60px;">
				<tr>
					<td><label for="imgfile"> 背景图片</label>
						<div class="couponRule_img">
							<img id="imgpathImg" src="" width="300" height="200"/>
						</div>
					</td>
				</tr>
				<tr>
					<td>
                    		<div class="file-box">
 							<input type='text' name='textfield' id='textfield1'name="imgfile" data-options="required:true" class='txt' value="点击选择图片" />
    							<input type="file"  class="file" name="imgfile" data-options="required:true" size="28" onchange="document.getElementById('textfield1').value=this.value" />
 							<input type="button"  class="img_button" onclick="uploadImg('imgpath')" value="上传" />
						</div>
						<span id="imgpathinfo" style="color: red;"></span>
					</td>
				</tr>
			</table>
		</form>
		
	</div>
	<div id="dlg-buttons" style="display: none;clear:both">
	      <div class="text_input_button_cancel" onclick="javascript:$('#win').dialog('close')">取消</div>
          <div class="text_input_button_float" onclick="javascript:saveOrUpdateCouponItem()">保存</div>
        
          
	</div>


</body>
</html>