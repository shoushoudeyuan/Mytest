<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html>
<head>

<title>保险维护</title>

<%@ include file="../common/header.jsp"%>
<!-- 配置文件 -->
<script type="text/javascript" src="../../ueditor/ueditor.config.js"></script>
<!-- 编辑器源码文件 -->
<script type="text/javascript" src="../../ueditor/ueditor.all.js"></script>
<!-- 语言包文件(建议手动加载语言包，避免在ie下，因为加载语言失败导致编辑器加载失败) -->
<script type="text/javascript" src="../../ueditor/lang/zh-cn/zh-cn.js"></script>
<script type="text/javascript" src="../../ueditor/ueditor.parse.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.json.js"></script>
</head>
<body>
    <div class="list_title">
        <span class="layui-parent-title-customer">HOME</span>
        <span class="layui-badge-dot layui-bg-title"></span>
        <span class="layui-children-title-customer">保险维护</span>
    </div>
    <div class="text_input">
        <span class="div_search_customerBar"></span>
        <form id='fm_s' action="" style="width: 100%;">
        	<div class="form_item">
        		<div class="form_item_inline">
        			<label class="form_item_label2">名称</label>
        			<div class="form_item_input">
        				<input type="text" id="insurancename" name="insurancename" class="easyui-textbox" style="width: 100px;" />
        			</div>
        		</div>
        		<div class="form_item_inline">
        			<label class="form_item_label4">服务城市</label>
        			<div class="form_item_input">
        				<select id="selectCity" name="selectCity" class="easyui-combobox" style="width: 100px;"></select> 
        			</div>
        		</div>
        		<div class="form_item_inline">
        			<label class="form_item_label2">车系</label>
        			<div class="form_item_input">
        				<select id="selectSeries" name="selectSeries" class="easyui-combobox"     style="width: 100px;"></select> 
        			</div>
        		</div>
        		<div class="form_item_inline">
        			<label class="form_item_label2">车型</label>
        			<div class="form_item_input">
        				<select id="selectModel" name="selectModel"  class="easyui-combobox" style="width: 100px;">
                			<option selected="selected" value="-1">请选择</option>
               			</select> 
        			</div>
        		</div>
        		<div class="form_item_inline">
        			  <input type="button" onclick="search()" class="text_input_button_search" value="查询">
        		</div>
        	</div>
        </form>
    </div>
    <div class="table_data">
        <h4 class="table_data_title"> 保险维护
        <div class="text_input_bottom">
            <div class="text_input_button_add" id="text_input_button_left"
            onclick="newVehiclePrice('${pageContext.request.contextPath}/baseInsurance/baseInsuranceAdd')">添加</div>
        <div class="text_input_button_del" id="text_input_button_left"
            onclick="destroyUser('${pageContext.request.contextPath}/baseInsurance/baseInsuranceDelete')">删除</div>
        </div>
        </h4>
        <table id="dg" style="width: 100%;"></table>
    </div>
    
	<!-- 新建页面 -->
	<div id="dlgAdd" class="easyui-dialog"
		style="width: 600px; max-height: 500px; display: none;" closed="true"
		buttons="#dlg-buttonsAdd"
		data-options="iconCls:'icon-save',closed:'true',collapsible:false,minimizable:false,maximizable:false,closable:true">
		<form id="fmAdd" method="post">
			<table class="pop_table" style="width: 90%; margin: 0 auto;">
				<tr>
					<td><span style="color: red;">*</span> 服务城市</td>
					<td><select id="servicecityid" name="servicecityid"
						class="easyui-combobox" style="width: 150px;"></select></td>
					<td><span style="color: red;">*</span> 名称</td>
					<td><input type="text" id="insurancename" name="insurancename"
						class="easyui-textbox" style="width: 150px;"
						data-options="required:true,validateOnCreate:false,validateOnBlur:true" /></td>
				</tr>
				<tr>
					<td><span style="color: red;">*</span> 车系</td>
					<td><select id="seriesid" name="seriesid"
						class="easyui-combobox" style="width: 150px;"></select></td>
					<td><span style="color: red;">*</span> 车型</td>
					<td><select id="vehiclemodelid" name="vehiclemodelid"
						class="easyui-combobox" style="width: 150px;">
							<option selected="selected" value="-1">请选择</option>
					</select></td>
				</tr>
				<tr>
					<td><span style="color: red;">*</span> 收费方式</td>
					<td><select id="chargingMode" name="chargingMode"
						class="easyui-combobox" style="width: 150px;">
							<option value="0" selected="selected">每24小时收一次费</option>
							<option value="1">一次性收费</option>
					</select></td>
					<td><span style="color: red;">*</span> 价格</td>
					<td><input type="text" id="insurancemoney"
						name="insurancemoney" class="easyui-textbox"
						style="width: 150px;" data-options="required:true,validateOnCreate:false,validateOnBlur:true"  validType="moneyNumber"/></td>
				</tr>
				<tr>
					<td><span style="color: red;">*</span> 用户选择</td>
					<td>
               	    <input type="radio" name="userChoose" value="1" checked="checked">必选
               	    <input type="radio" name="userChoose" value="0"  >非必选
               	    </td>
					<td></td>
					<td></td>
				</tr>
			</table>
		</form>
		<script type="text/javascript">
			
		</script>
	</div>

	<div id="dlg-buttonsAdd" style="display: none;clear:both">
		<div class="text_input_button_cancel"
			onclick="javascript:$('#dlgAdd').dialog('close')">取消</div>
		<div class="text_input_button_float"
			onclick="javascript:saveVehiclePrice();">保存</div>
	


	</div>

	<!-- 修改页面 -->
	<div id="dlgUpdate" class="easyui-dialog"
		style="width: 600px; max-height: 500px; display: none;" closed="true"
		buttons="#dlg-buttonsUpdate"
		data-options="iconCls:'icon-save',closed:'true',collapsible:false,minimizable:false,maximizable:false,closable:true">
		<form id="fmUpdate1" method=post>
			<input type="hidden" id="id" name="id"/>
			<table class="pop_table" style="width: 90%; margin: 0 auto;">
					<tr>
						<td><span style="color: red;">*</span> 服务城市</td>
						<td><input id="showname" name="showname"
							class="easyui-textbox" readonly /></td>
						<td><span style="color: red;">*</span> 车型</td>
						<td><input id="modelname" name="modelname"
							class="easyui-textbox" readonly /></td>
					</tr>
					<tr>
						<td><span style="color: red;">*</span> 名称</td>
						<td><input type="text" id="insurancename"
							name="insurancename" class="easyui-textbox" style="width: 100px;"
							data-options="required:true,validateOnCreate:false,validateOnBlur:true" /></td>
						<td><span style="color: red;">*</span> 价格</td>
						<td><input type="text" id="insurancemoney"
							name="insurancemoney" class="easyui-textbox"
							style="width: 100px;" data-options="required:true,validateOnCreate:false,validateOnBlur:true"   validType="moneyNumber"/></td>
					</tr>
					<tr>
					<td><span style="color: red;">*</span> 收费方式</td>
					<td><select id="chargingMode" name="chargingMode"
						class="easyui-combobox" style="width: 150px;">
							<option value="0" selected="selected">每24小时收一次费</option>
							<option value="1">一次性收费</option>
					</select></td>
					<td><span style="color: red;">*</span> 用户选择</td>
					<td><input type="radio" name="userChoose" value='1'/>必选
               	    <input type="radio" name="userChoose" value="0"  />非必选</td>
				</tr>
				</table>
				</form>
				</div>

				<div id="dlg-buttonsUpdate" style="display: none;clear:both">
					<div class="text_input_button_cancel"
						onclick="javascript:$('#dlgUpdate').dialog('close')">取消</div>
					<div class="text_input_button_float"
						onclick="javascript:saveUpdateVehiclePrice();">保存</div>
					
				</div>
				
	<!-- 保险服务介绍添加修改dialog -->
	<div id="dlgAdd_2" class="easyui-dialog"
		style="width: 650px; max-height: 800px; display: none; padding-top: 10px;" closed="true"
		buttons="#dialog_btns"
		data-options="iconCls:'icon-save',closed:'true',collapsible:false,minimizable:false,maximizable:false,closable:true,cache: false">
			<form id="fm" method="post" action="<%=request.getContextPath()%>/baseInsurance/updateInsurance">
				<input name="id" type="hidden" id="insId">
				<div style="margin-bottom:20px; margin-top: 4px;">
	               	 <font color="red" size="4px;"><b>*</b></font>&nbsp;是否在APP中显示:
	               	 <input class="isShowInApp" type="radio" name="isShowInApp" value='1' />是
	               	 <input class="isShowInApp" type="radio" name="isShowInApp" value="0" />否
	            </div>
				<div id="insContent" style="width: 99.7%; clear: both; ">
					<script id="insuranceServer" name="insuranceServer" type="text/plain"></script>
				</div>
			</form>
	</div>
	
	<!-- 保险服务介绍dialog底部按钮 -->
	<div id="dialog_btns" style="display: none;clear:both">
		<div class="text_input_button_cancel"
			onclick="javascript:$('#dlgAdd_2').dialog('close')">取消</div>
		<div class="text_input_button_float"
			onclick="javascript:updateIns();">保存</div>
		
	</div>
<script type="text/javascript">

	// 弹出保险服务介绍dialog修改页面
	function toUpdateInsServer(str) {
	    str=decodeURIComponent(str);
		var strArray = str.split('|');
		var obj = {};
		obj.id = strArray[2];
		obj.isShowInApp = strArray[1];
	 	introduceEditor = UE.getEditor('insuranceServer', {initialFrameHeight:380,scaleEnabled:true});
			introduceEditor.ready(function(){
				if (strArray[0] == 'undefined') {
	 			    introduceEditor.setContent(""); 
				} else {
	 			    introduceEditor.setContent(strArray[0]); 
				}
 		})
		$('#dlgAdd_2').dialog('open').dialog('center').dialog('setTitle', '保险服务介绍');
	    $('#fm').form('load', obj);
	}
	
	// 修改保险服务介绍
	function updateIns() {
		$.messager.confirm("提示", "您确定要修改么?", function(flag) {
			if (flag) {
				$.messager.progress();
				$('#fm').form('submit', {
					onSubmit : function() {
						if ($('input:radio[name="isShowInApp"]:checked').val() == null) {
							$.messager.alert('操作提示','请选择是否在app端显示！');
							$.messager.progress('close');
							return false;
						}
					},
					success : function(result) {
						if (result == 0) {
							$.messager.alert('操作提示','修改失败！');
							$.messager.progress('close');
						} else {
							$.messager.alert('操作提示','修改成功！', '', function() {
					        	 $('#dlgAdd_2').dialog('close');
					        	 $.messager.progress('close');
					        	 $('#dg').datagrid('reload');
							});
						}
					}
				});
			}
		});
	}
	
   //初始化页面
    $(function(){
		setAutoHeight(270,"dg");
		//初始化服务城市
    	$("#selectCity").combobox({
    		url:'<%=request.getContextPath()%>/city/getServiceCityList',
    		valueField:'id',
    		textField:'showname'
    	});
    	
    	//加载车型
    	var _chexing = $('#selectModel').combobox({
            disabled: true,
            valueField: 'id',
            textField: 'modelname'
        });
    	//加载车系
    	$('#selectSeries').combobox({
            url: '/bjyvms/carType/getSeries',
            editable: false,
            valueField: 'id',
            textField: 'serialname',
            onSelect: function (record) {
            	_chexing.combobox({
                    disabled: false,
                    url: '/bjyvms/carType/getModelBySeriesId?id='+record.id,
                    valueField: 'id',
                    textField: 'modelname'
                }).combobox('clear');
            }
        });
    	
    	//初始化列表
    	$('#dg').datagrid({
  			url:'<%=request.getContextPath()%>/baseInsurance/getBaseInsuranceList',
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
 			},{
				title : '操作',
				field : '_opt',//不对应数据库或json字段，取的名字
				width:'10%',
				formatter : function(value, rec) { //格式化函数添加一个操作列
					var showname = rec.servicecityname;
					var modelname = rec.vehiclemodelname;
					var id = rec.id;
					var insurancetype = rec.insurancetype;
					var insurancename = rec.insurancename;
					var insurancemoney = rec.insurancemoney;
					var str = showname+'|'+modelname+'|'+id+'|'+insurancetype+'|'+insurancename+'|'+insurancemoney+'|'+rec.chargingMode+'|'+rec.userChoose;
					
					var btn = btn = '<a class="editcls radiuBtn" onclick="updateVehiclePrice(\''+str+'\')" href="javascript:void(0)">编辑</a>';												
					return btn;
				}
			},
			{
 				field : 'servicecityname',
 				title : '服务城市',
 				width:'10%',
 			}, 			
 			{
 				field : 'vehicleserialname',
 				title : '车系',
 				width:'20%',
 			},
 			{
 				field : 'vehiclemodelname',
 				title : '车型',
 				width:'10%',
 			},
 			{
 				field : 'insurancename',
 				title : '名称',
 				width:'20%',
 			},
 			{
 				field : 'insurancemoney',
 				title : '价格',
 				width:'10%',
 			},
 			{
 				field : 'userChoose',
 				title : '租车用户',
 				width:'10%',
 				formatter : function(val) {
 					if('0' == val){
 						return '非必选';
 					}else if('1' == val){
 						return '必选';
 					}
 				}
 			},
 			{
 				title : '保险服务介绍',
 				field : '_insServer',
 				width:'20%',
 				formatter : function(value, row) {
 					// 解决富文本编辑器 ul、ol的bug[！！！！！！！！！！！！！]
 					var insuranceServer;
 					if (row.insuranceServer != undefined) {
 						insuranceServer = row.insuranceServer.replace(/(<ol.*?>)/gi,'<ol>');
 						insuranceServer = insuranceServer.replace(/(<ul.*?>)/gi,'<ul>');
 					}
 					var isShowInApp = row.isShowInApp;
 					var id = row.id;
 					var str = insuranceServer + '|' + isShowInApp + '|' + id;
 					str = encodeURIComponent(str);
 					if (row.isShowInApp == 1) {
 						return '<a class="datagrid_font_green" onclick="toUpdateInsServer(\''+str+'\');">文本编辑</a>&nbsp<input type="checkbox" checked="checked" disabled="disabled"/>在app中显示';
 					} else {
 						return '<a class="datagrid_font_green" onclick="toUpdateInsServer(\''+str+'\');">文本编辑</a>&nbsp<input type="checkbox" disabled="disabled"/>在app中显示';
 					}
 				}
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
					.dialog('setTitle', '添加保险');
			$('#fmAdd').form('clear');	
			$("#insurancetype1").combobox("setValue",1);
			//初始化服务城市
	    	$("#servicecityid").combobox({
	    		url:'<%=request.getContextPath()%>/city/getServiceCityList',
	    		valueField:'id',
	    		textField:'showname'
	    	});
	    	
	    	//加载车型
	    	var _chexing = $('#vehiclemodelid').combobox({
	            disabled: true,
	            valueField: 'id',
	            textField: 'modelname'
	        });
	    	//加载车系
	    	$('#seriesid').combobox({
	            url: '/bjyvms/carType/getSeries',
	            editable: false,
	            valueField: 'id',
	            textField: 'serialname',
	            onSelect: function (record) {
	            	_chexing.combobox({
	                    disabled: false,
	                    url: '/bjyvms/carType/getModelBySeriesId?id='+record.id,
	                    valueField: 'id',
	                    textField: 'modelname'
	                }).combobox('clear');
	            }
	        });
			
			
			$("#servicecityid").combobox('setValue',-1);
			$("#seriesid").combobox('setValue',-1);
			$("#vehiclemodelid").combobox('setValue',-1);
			$("#chargingMode").combobox('setValue',0);
			$('input:radio[name=userChoose]')[0].checked = true;
			url = path;
		}
		//修改页面初始化
		function updateVehiclePrice(str) {
			
			var strArray = str.split('|');
			var obj={};
			obj.showname =strArray[0];
			obj.modelname =strArray[1];
			obj.id =strArray[2];
			obj.insurancetype =strArray[3];
			obj.insurancename =strArray[4];
			obj.insurancemoney =strArray[5];
			obj.chargingMode =strArray[6];
			obj.userChoose =strArray[7];
			
			$('#dlgUpdate').dialog('open').dialog('center').dialog('setTitle',
					'修改保险');
			$('#fmUpdate1').form('load',obj);
					
		}
		//添加页面保存
		function saveVehiclePrice() {
			$('#fmAdd').form('submit', {
				url : url,
				onSubmit : function() {
					if($("#servicecityid").combobox('getValue')=='-1')
					{
						$.messager.alert("操作提示", "请选择服务城市",""); 
						return false;
					}
					if($("#seriesid").combobox('getValue')=='-1')
					{
						$.messager.alert("操作提示", "请选择车系","");
						return false;
					}
					if($("#vehiclemodelid").combobox('getValue')=='-1')
					{
						$.messager.alert("操作提示", "请选择车型","");
						return false;
					}
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
			var url = '<%=request.getContextPath()%>/baseInsurance/baseInsuranceUpdate';

						$('#fmUpdate1').form('submit', {
							url : url,
							onSubmit : function() {
								//alert(456);
								return $(this).form('validate');
							},
							success : function(result) {
								if (result == 0) {
									$.messager.alert('操作提示', "修改失败");
								}
								if (result == 4) {
									$.messager.alert('操作提示', "修改成功");
									$('#dlgUpdate').dialog('close') // close the dialog
									$('#dg').datagrid('reload'); // reload the user data
								}
								if (result == 5) {
									$.messager.alert('操作提示', "修改失败");
								}
							}
						});
					}
					//删除方法
					function destroyUser(path) {
						var rows = $('#dg').datagrid('getChecked');
						if (rows.length > 0) {
							$.messager
									.confirm(
											'确认',
											'确定要删除选中的保险记录吗?',
											function(r) {
												if (r) {

													var ids = '';
													for (var i = 0; i < rows.length; i++) {
														ids += rows[i].id + ',';
													}
													ids = ids.substring(0,
															ids.length - 1);

													$.post(path, {
														ids : ids
													}, function(result) {
														if (result == 1) {
															//alert('删除成功');
															$.messager.alert(
																	"操作提示",
																	"删除成功");
															$('#dg').datagrid(
																	'reload'); // reload the user data
														} else {
															$.messager.alert(
																	"操作提示",
																	"删除失败");
														}
													}, 'json');
												}
											});
						} else {
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
