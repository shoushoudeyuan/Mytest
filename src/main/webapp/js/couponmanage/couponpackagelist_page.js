
var couponPackage = window.NameSpace || {};
couponPackage.list = new function() {
var self = this;
	
	self.listInital = function(){
		setAutoHeight(270,"dg"); 
		$('#dg').datagrid({
			url:getRootPath_web()+'/couponpackage/list',
			toolbar : $('#toolbar'),
			rownumbers : true,
			columns : [ [
					{
						field : 'id',
						checkbox:true,
					},{
						field : 'action',
						title : '操作',
						width : '8%',
						formatter : function(value, rec) { 
							var btn = '<a style=""  class="radiuBtn" href="#" onclick="javascript:couponPackage.openEdit('+
							rec.id + ',' + rec.isEnable + ',' +
							(rec.couponUseConfig ? rec.couponUseConfig.couponType : null) +','+
							(rec.couponUseConfig ? rec.couponUseConfig.id : null) + ',' +
							'\''+rec.couponName +'\','+
							'\''+(rec.couponUseConfig ? rec.couponUseConfig.configDetail : null) +'\','+
							rec.couponCount + 

							')">编辑</a>'; 


							return btn;

						}
					}, {
						field : 'couponName',
						title : '优惠券名称',
						width : '10%',
					}, {
						field : 'couponCount',
						title : '数量',
						width : '8%',
					}, {
						field : 'configName',
						title : '规则名称',
						width : '8%',
						formatter : function(value, rec) { 
							return rec.couponUseConfig ? rec.couponUseConfig.configName : '-';
						}
					}, {
						field : 'couponType',
						title : '优惠券类型',
						width : '8%',
						formatter : function(value, rec) { 
							if(rec.couponUseConfig){
								if (rec.couponUseConfig.couponType == 1) {
									return "折扣卷";
								} else {
									return "满减卷";
								}
							}else{
								return "";
							}
						}
					} , {
						field : 'couponMoney',
						title : '金额',
						width : '8%',
						formatter : function(value, rec) { 
							if (!rec.couponUseConfig || rec.couponUseConfig.couponType == 1) {
								return "-";
							} else {
								return rec.couponUseConfig.couponMoney;
							}
						}
					} , {
						field : 'discountPercent',
						title : '折扣比例',
						width : '8%',
						formatter : function(value, rec) { 
							if (rec.couponUseConfig && rec.couponUseConfig.couponType == 1) {
								return rec.couponUseConfig.discountPercent;
							} else {
								return "-";
							}
						}
					}, {
						field : 'maxDeductionMoney',
						title : '最高减免',
						width : '8%',
						formatter : function(value, rec) { 
							if (rec.couponUseConfig && rec.couponUseConfig.couponType == 1) {
								return rec.couponUseConfig.maxDeductionMoney;
							} else {
								return "-";
							}
						}
					} , {
						field : 'configDetail',
						title : '配置详情',
						width : '10%',
						formatter:function(value,rec){
							return rec.couponUseConfig ? rec.couponUseConfig.configDetail : '原配置已被禁用';
						}
					}, {
						field : 'isValidate',
						title : '状态',
						width : '8%',
						formatter : function(value, rec) { 
							if (rec.isEnable == 1) {
								return "启用";
							} else {
								return "禁用";
							}
						}
					}, {
						field : 'createDate',
						title : '创建日期',
						width : '12%',
					}, {
						field : 'modifyDate',
						title : '最后更新日期',
						width : '12%',
					}] ],
			pagination : true,
			pageSize : 10,
			pageList : [ 5, 10, 15, 20, 50 ],
			layout:['prev','links','next','list'],
			emptyMsg : '无数据',
			onBeforeLoad : function(param) {
				$($('#fm_s').serializeArray()).each(
					function() {
						param[this.name] = this.value;
					});
				},
				onBeforeSelect : function() {
					return false;
				}
			});
		 
		var pager = $('#dg').datagrid('getPager');    // get the pager of datagrid
		pager.pagination({
			pageSize:30,
			pageList: [10,50,100],
			displayMsg:'',
			links : 5,
			layout:['prev','links','next','list']
		});     
	};
	
	self.search = function(){
		$('#dg').datagrid('load');
	};
}

couponPackage.openEdit = function(id,isValidate,couponType,configId,couponName,configDetail,couponCount){
	$('#fmAdd').form('clear');
	var obj = {};
	obj.packageItemId = id;
	obj.isValidate = isValidate == undefined ? 1 : isValidate;
	obj.couponType = couponType;
	obj.configName = configId;
	obj.couponName = couponName;
	obj.couponCount = couponCount;
	obj.configDetail=configDetail;
	$('#fmAdd').form('load',obj);
	$('#dlgCouponEdit').dialog('open').dialog('center').dialog('setTitle', '添加优惠券');
}

couponPackage.deleteCouponPackageItem = function(){
	if(isRepeatClick($("#divDeleteItem"))) 
		return ;
	
	$('#dlgDel').dialog('close');
	var rows = $("#dg").datagrid("getChecked");
	var ids = "";
	for (var i = 0; i < rows.length; i++) {
		var obj = rows[i];
		ids = ids + obj.id;
		if (i != rows.length - 1) {
			ids = ids + ",";
		}
	}
	if(ids==''){
		$.messager.alert('操作提示','请选择需要删除配置信息');
		return;
	}
	
	$('#dlgDel').window('close');
	var url = getRootPath_web()+'/couponpackage/delete';
	var data = {ids:ids};
	$.post(url,data).done(function(result){
		if(result.code == 100000){
			$.messager.alert('操作提示','删除优惠券配置信息成功！','info',function(){
				couponPackage.list.search();
			});
		}else{
			$.messager.alert('操作提示','删除优惠券配置信息失败！');
		}
	});
}

couponPackage.selectCouponPackageItemData = [];

couponPackage.getCouponeUseConfig = function(){
	var url = getRootPath_web()+'/useconfig/configdetail'
	$.get(url).done(function(result){
		if(result.code == 100000){
			couponPackage.selectCouponPackageItemData = result.data;

			$("#comboxCouponType").combobox({
				onSelect:function(rec){
					var data = couponPackage.selectCouponPackageItemData;
					if(!data){
						return;
					}
					var comboxData = [];
					if(rec.value == 1){
						for(var i in data){
							if(data[i].couponType == 1){
								comboxData.push({"text":data[i].configName,"value":data[i].id})
							}
						}
					}else if(rec.value = 2){
						for(var i in data){
							if(data[i].couponType == 2){
								comboxData.push({"text":data[i].configName,"value":data[i].id})
							}
						}
					}
					
					$("#comboxConfigName").combobox("loadData",comboxData);
					var data = $("#comboxConfigName").combobox("getData");
					$("#comboxConfigName").combobox("select",data[0].value);
				}
			}).combobox('clear');
			
			$("#comboxConfigName").combobox({
				onSelect:function(rec){
					var data = couponPackage.selectCouponPackageItemData;
					for(var i in data){
						if(rec.value == data[i].id){
							$("#fmAdd").form('load',{configDetail:data[i].configDetail});
						}
					}
				}
			});
			
		}
	});
}

couponPackage.saveCouponPackageItem = function(){
	if(!$("#fmAdd").form('validate')){
		$.messager.alert('操作提示','表单信息校验项未通过！',"warning");
		return;
	}
	
	if(isRepeatClick($("#divAddItem"))) 
		return ;
	
	var isValidate = $("input[name='isValidate']:checked").val();
	var couponName = $("#couponName").textbox('getValue');
	var couponCount = $("#couponCount").numberbox('getValue');
	var couponConfigId = $("#comboxConfigName").combobox("getValue");
	var id = $("#packageItemId").val();
	var packageId = $('#packageId').val();
	
	var url = getRootPath_web()+'/couponpackage/save';
	var data = {id:id,packageId:packageId,couponName:couponName,couponCount:couponCount,couponConfigId:couponConfigId,isEnable:isValidate}
	$.post(url,data).done(function(result){
		if(result.code == 100000){
			$.messager.alert('操作提示',"保存优惠券信息成功！","info",function(){
				$('#dlgCouponEdit').dialog('close');
				couponPackage.list.search();
			});
		}else{
			$.messager.alert('操作提示',"保存优惠券信息失败！","error");
		}
	});
}

$(function(){
	couponPackage.list.listInital();
	couponPackage.getCouponeUseConfig();
	
});