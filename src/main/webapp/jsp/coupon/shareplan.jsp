<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html>
<head>

<title>共享计划</title>
<%@ include file="../common/header.jsp"%>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.json.js"></script>


</head>
<body>

<div class="list_title"><span>共享计划</span></div>

	<div class="text_input">
		<form id='fm_s' action=""  style="width:100%;">
			用户名<input type="text" id="username" name="username" class="easyui-textbox" style="width:100px;"/>
			车牌号<input type="text" id="platenumber" name="platenumber" class="easyui-textbox" style="width:100px;"/>
			截止日期<input id="starttime" type="text" name="starttime" class="easyui-datebox" />
			-<input id="endtime" type="text" name="endtime" class="easyui-datebox" />
			<input type="button"  onclick="search();" class="text_input_button" data-options="iconCls:'icon-search'" value="查询"/>
		</form>
	</div>
    
   
	<table id="dg" style="width: 100%;"></table>
 	<div class="text_input_bottom">
        <div class="text_input_button_add" id="text_input_button_left" onclick="newVehiclePrice('${pageContext.request.contextPath}/shareplan/sharePlanAdd')">添加</div>
        <div class="text_input_button_del" id="text_input_button_left" onclick="destroyUser('${pageContext.request.contextPath}/shareplan/sharePlanDelete')">删除</div>
    </div>
	<!-- 新建页面 -->
	<div id="dlgAdd" class="easyui-dialog" style="width:600px; max-height:500px; display:none;" closed="true"	buttons="#dlg-buttonsAdd"  data-options="iconCls:'icon-save',closed:'true',collapsible:false,minimizable:false,maximizable:false,closable:true">
		<form id="fmAdd" method="post">
			
			<table class="pop_table" style="width:50%; margin: 0 auto;">
				<tr>
					<td>
					<span style="color:red;">*</span>
						用户名
					</td>
					<td>
						<input type="text" id="username1" name="username" class="easyui-textbox" style="width:100px;" data-options="required:true"/>
					</td>
					<td>
					<input type="button"  onclick="CheckUser();" class="min_botton" data-options="iconCls:'icon-search'" value="确认"/>
					</td>
					<td></td>
				</tr>
				<tr>
					<td>
						车牌号
					</td>
					<td>
						<input type="text" id="platenumber" name="platenumber" class="easyui-validatebox easyui-textbox" style="width:100px;" validType="length[5,8]"/>
					</td>
				</tr>
				<tr>
					<td>
					<span style="color:red;">*</span>
						开始时间
					</td>
					<td>
						<input id="starttime" type="text" name="starttime" class="easyui-datebox" editable="false" data-options="required:true" />
					</td>
					
				</tr>
				<tr>
					<td>
					<span style="color:red;">*</span>
						截止时间	
					</td>
					<td>
						<input id="endtime" type="text" name="endtime" class="easyui-datebox" editable="false" data-options="required:true" />
					</td>
				</tr>
				
			</table>
			<script type="text/javascript">
				//验证用户名
				function CheckUser()
				{
					var url = '<%=request.getContextPath()%>/shareplan/sharePlanCheckUser';
					var username=$("#username1").textbox('getValue');
					$.post(url,{username:username},function(result){
						if (result==0) {
							$.messager.alert('操作提示', "验证失败");
						}
						if (result==1) {
							$.messager.alert('操作提示', "用户不存在");
						}
						if (result==2) {
							$.messager.alert('操作提示', "用户已删除");
						}
						if (result==3) {
							$.messager.alert('操作提示', "用户已禁用");
						}
						if (result==4) {
							$.messager.alert('操作提示', "验证成功");
						}
					});
				}
			
			</script>
		</form>
	</div>
	
	<div id="dlg-buttonsAdd" style="display:none">
    
		<div class="text_input_button_float button_margin_02" onclick="javascript:saveVehiclePrice();">保存</div>
        <div class="text_input_button_float button_margin_03" onclick="javascript:$('#dlgAdd').dialog('close')">取消</div>
    

	</div>

    <!-- 修改页面 -->
	<div id="dlgUpdate" class="easyui-dialog" style="width: 600px; max-height:500px; display:none;" closed="true"
		buttons="#dlg-buttonsUpdate" data-options="iconCls:'icon-save',closed:'true',collapsible:false,minimizable:false,maximizable:false,closable:true">
		<form id="fmUpdate1" method=post>
			<table class="pop_table" style="width:50%; margin: 0 auto;">
				<tr>
					<td>
					<span style="color:red;">*</span>
						用户名
					</td>
					<td>
						<input type="text" id="username2" name="username" class="easyui-textbox" style="width:100px;" data-options="required:true"/>
						<input type="text" id="id" name="id" style="display:none;" />
					</td>
					<td>
					<input type="button"  onclick="CheckUser1();" class="min_botton" data-options="iconCls:'icon-search'" value="确认"/>
					</td>
					<td></td>
				</tr>
				<tr>
					<td>
						车牌号
					</td>
					<td>
						<input type="text" id="platenumber" name="platenumber" class="easyui-validatebox easyui-textbox" style="width:100px;" validType="length[5,8]"/>
					</td>
				</tr>
				<tr>
					<td>
					<span style="color:red;">*</span>
						开始时间
					</td>
					<td>
						<input id="starttime" type="text" name="starttime" class="easyui-datebox" editable="false" data-options="required:true" />
					</td>
					
				</tr>
				<tr>
					<td>
					<span style="color:red;">*</span>
						截止时间	
					</td>
					<td>
						<input id="endtime" type="text" name="endtime" class="easyui-datebox" editable="false" data-options="required:true" />
					</td>
				</tr>
			</table>
			<script type="text/javascript">
				//验证用户名
				function CheckUser1()
				{
					var url = '<%=request.getContextPath()%>/shareplan/sharePlanCheckUser';
					var username=$("#username2").textbox('getValue');
					$.post(url,{username:username},function(result){
						if (result==0) {
							$.messager.alert('操作提示', "验证失败");
						}
						if (result==1) {
							$.messager.alert('操作提示', "用户不存在");
						}
						if (result==2) {
							$.messager.alert('操作提示', "用户已删除");
						}
						if (result==3) {
							$.messager.alert('操作提示', "用户已禁用");
						}
						if (result==4) {
							$.messager.alert('操作提示', "验证成功");
						}
					});
				}
			
			</script>
		</form>
	</div>
    
    <div id="dlg-buttonsUpdate" style="display:none">
    
		<div class="text_input_button_float button_margin_02" onclick="javascript:saveUpdateVehiclePrice();">保存</div>
        <div class="text_input_button_float button_margin_03" onclick="javascript:$('#dlgUpdate').dialog('close')">取消</div>
    

	</div>


	<script type="text/javascript">
	
   //初始化页面
    $(function(){
		

		setAutoHeight(120,"dg");
		
    	
    	//初始化列表
    	$('#dg').datagrid({
  			url:'<%=request.getContextPath()%>/shareplan/getSharePlanList',
  			toolbar:$('#toolbar'),
  			rownumbers:true,
  			columns :  [[ {
 				field : 'ck',
 				checkbox : true,
 				id : 'ck'
 			}, {
 				field : 'id',
 				hidden : true,
 				title : 'id'
 			}, 
 			{
				title : '操作',
				field : '_opt',//不对应数据库或json字段，取的名字
				formatter : function(value, rec) { //格式化函数添加一个操作列
					
					var id = rec.id;
					var username = rec.username;
					var starttime = rec.starttime;
					var endtime = rec.endtime;
					var platenumber = rec.platenumber==undefined?'':rec.platenumber;
					var str = id+'|'+username+'|'+starttime+'|'+endtime +'|'+platenumber;
					
					var btn = btn = '<a class="editcls" onclick="updateVehiclePrice(\''+str+'\')" href="javascript:void(0)">编辑</a>';												
					return btn;
				}
			},
 			{
 				field : 'username',
 				title : '用户名'
 			},
 			{
 				field : 'name',
 				title : '姓名'
 			},
 			{
 				field : 'platenumber',
 				title : '车牌号'
 			}, 
 			{
 				field : 'starttime',
 				title : '起始日期'
 			}, {
 				field : 'endtime',
 				title : '截止日期'
 			}]],
  		    pagination:true,
  		    pageSize: 10,
  			pageList:[10,50,100] ,
  			emptyMsg:"无数据",
  		    onBeforeLoad: function(param){
  		    	$($('#fm_s').serializeArray()).each(function(){  
  		    		param[this.name]=this.value;  
  	            }); 
  			},
  			onBeforeSelect:function(){
 				return false;
 			}
  		});
    	 var pager = $('#dg').datagrid('getPager');    // get the pager of datagrid
         pager.pagination({
         	pageSize:10,
         	pageList: [10,50,100],
			displayMsg:'',
			links : 5,
         	layout:['prev','links','next','list']
         });
    });

		var url;
		//添加页面初始化
		function newVehiclePrice(path) {
			$('#dlgAdd').dialog('open').dialog('center')
					.dialog('setTitle', '添加共享计划');
			$('#fmAdd').form('clear');
			url = path;
		}
		//修改页面初始化
		function updateVehiclePrice(str) {
			
			var strArray = str.split('|');
			var obj={};
			obj.id =strArray[0];
			obj.username =strArray[1];
			obj.starttime =strArray[2];
			obj.endtime =strArray[3];
			obj.platenumber= strArray[4];
			$('#dlgUpdate').dialog('open').dialog('center').dialog('setTitle',
					'修改共享计划');
			$('#fmUpdate1').form('load',obj);
					
		}
		//添加页面保存
		function saveVehiclePrice() {
			$('#fmAdd').form('submit', {
				url : url,
				onSubmit : function() {
					return $(this).form('validate');
				},
				success : function(result) {
					if (result==0) {
						$.messager.alert('操作提示', "添加失败");
					}
					if (result==1) {
						$.messager.alert('操作提示', "用户不存在");
					}
					if (result==2) {
						$.messager.alert('操作提示', "用户已删除");
					}
					if (result==3) {
						$.messager.alert('操作提示', "用户已禁用");
					}
					if (result==4) {
						$.messager.alert('操作提示', "添加成功");
						$('#dlgAdd').dialog('close'); // close the dialog
						$('#dg').datagrid('reload'); // reload the user data
					}
					if (result==5) {
						$.messager.alert('操作提示', "添加失败");
					}
				}
			});
		}
		//修改页面保存
		function saveUpdateVehiclePrice() {
			var url = '<%=request.getContextPath()%>/shareplan/sharePlanUpdate';
			
			$('#fmUpdate1').form('submit', {
				url : url,
				onSubmit : function() {
					//alert(456);
					return $(this).form('validate');
				},
				success : function(result) {
					if (result==0) {
						$.messager.alert('操作提示', "修改失败");
					}
					if (result==1) {
						$.messager.alert('操作提示', "用户不存在");
					}
					if (result==2) {
						$.messager.alert('操作提示', "用户已删除");
					}
					if (result==3) {
						$.messager.alert('操作提示', "用户已禁用");
					}
					if (result==4) {
						$.messager.alert('操作提示', "修改成功");
						$('#dlgUpdate').dialog('close') // close the dialog
						$('#dg').datagrid('reload'); // reload the user data
					}
					if (result==5) {
						$.messager.alert('操作提示', "修改失败");
					}
				}
			});
		}
		//删除方法
		function destroyUser(path) {
			var rows = $('#dg').datagrid('getChecked');
			if (rows.length > 0) {
				$.messager.confirm('确认', '确定要删除选中的共享计划吗?', function(r) {
					if (r) {

						var ids = '';
						for (var i = 0; i < rows.length; i++) {
							ids += rows[i].id + ',';
						}
						ids = ids.substring(0, ids.length - 1);

						$.post(path, {
							ids : ids
						}, function(result) {
							if (result==1) {
								//alert('删除成功');
								$.messager.alert("操作提示", "删除成功");
								$('#dg').datagrid('reload'); // reload the user data
							} else {
								$.messager.alert("操作提示", "删除失败");
							}
						}, 'json');
					}
				});
			}
			else{
				$.messager.alert("操作提示", "请选择要删除的记录");
			}
		}
		//查询方法
		function search() {
			$('#dg').datagrid('load');
		}
		
		
	</script>
</body>
</html>
