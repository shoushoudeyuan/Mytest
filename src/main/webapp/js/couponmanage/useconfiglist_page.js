var couponConfig = window.NameSpace || {};
couponConfig.list = new function() {
	var self = this;
	
	self.listInital = function(){
		setAutoHeight(270,"dg"); 
		$('#dg').datagrid({
			url:getRootPath_web()+'/useconfig/list',
			toolbar : $('#toolbar'),
			rownumbers : true,
			columns : [ [
					{
						field : 'id',
						width:'5%',
						checkbox:true,
					},{
						field : 'action',
						title : '操作',
						width : '10%',
						formatter : function(value, rec) { 
							var btn = '<a style=""  class="radiuBtn" href="#" onclick="javascript:couponConfig.openCouponEdit('+ rec.id +','+ rec.isValidate +')">编辑</a>';
							return btn;
						}
					}, {
						field : 'configName',
						title : '配置名称',
						width : '10%',
					}, {
						field : 'couponType',
						title : '优惠券类型',
						width : '8%',
						formatter : function(value, rec) { 
							if (rec.couponType == 1) {
								return "折扣卷";
							} else {
								return "减免卷";
							}
						}
					} , {
						field : 'couponMoney',
						title : '金额',
						width : '8%',
						formatter : function(value, rec) { 
							if (rec.couponType == 1) {
								return "-";
							} else {
								return rec.couponMoney;
							}
						}
					} , {
						field : 'discountPercent',
						title : '折扣比例',
						width : '8%',
						formatter : function(value, rec) { 
							if (rec.couponType == 1) {
								return rec.discountPercent;
							} else {
								return "-";
							}
						}
					}, {
						field : 'maxDeductionMoney',
						title : '最高减免',
						width : '8%',
						formatter : function(value, rec) { 
							if (rec.couponType == 1) {
								return rec.maxDeductionMoney;
							} else {
								return "-";
							}
						}
					} , {
						field : 'configDetail',
						title : '配置详情',
						width : '60%',
					}, {
						field : 'isValidate',
						title : '状态',
						width : '8%',
						formatter : function(value, rec) { 
							if (rec.isValidate == 1) {
								return "<span style='color:#3598dc'>启用<span>";
							} else {
								return "<span style='color:#ff0000'>禁用</span>";
							}
						}
					}, {
						field : 'createTime',
						title : '创建日期',
						width : '15%',
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
			pageSize:10,
			pageList: [10,50,100],
			displayMsg:'',
			links : 5,
			layout:['prev','links','next','list']
		});     
	};
	
	self.search = function(){
		$('#dg').datagrid('load');
	};
};


couponConfig.createConfig = function(){
	$("#fmAdd")[0].reset();
	var url = getRootPath_web()+'/useconfig/carmodeandctiy';
	$("#divServiceCity").html("");
	$("#divCarMode").html("");
	
	$.get(url).done(function(result){
		if(result.code != "100000"){
			$.messager.alert('操作提示',"新建优惠卷配置失败！");
			return;
		}
		
		var carMode = result.data.carMode;
		var city = result.data.city;
		
		for(var i in city){
			var ck = "<input type='checkbox' name='serviceCity' class='model_form_item_checkbox model_form_item_checkbox_left' value=" + city[i].id + " />" + city[i].name;
			$("#divServiceCity").append(ck);
		}
		
		for(var i in carMode){
			var ck = "<input type='checkbox' name='carMode' class='model_form_item_checkbox model_form_item_checkbox_left' value=" + carMode[i].id + " />" + carMode[i].serialName + ":" + carMode[i].modeName;
			$("#divCarMode").append(ck);
		}
		$('#dlgAdd').dialog('open').dialog('center').dialog('setTitle', ' 添加优惠券');
		//设置时间空间不跟随移动问题改为移动时间弹框消失
		$('#dlgAdd').scroll(function(){
			$('#layui-laydate2').css('display','none');
			$('#useUpperTime').blur();
			$('#layui-laydate1').css('display','none');
			$('#useLowerTime').blur()
		})
		//checkbox按钮置灰
		$('#divExUseConfig input[type="checkbox"]').attr('disabled',true);
		$('#appDiscription').attr('disabled',true);
	});
	
	url = getRootPath_web()+'/useconfig/couponName';
	$.get(url).done(function(result){
		if(result.code == 100000){
			couponConfig.lstCouponName = result.data;
		}
	});
};

couponConfig.openCouponEdit = function(id,isValidate){
	$('#dlgEdit #selectedId').val(id);
	if(isValidate == 1){
		$("input[name='isValidate'][value=1]").prop("checked", "checked");
	}else{
		$("input[name='isValidate'][value=0]").prop("checked", "checked");
	}
	
	$('#dlgEdit').dialog('open').dialog('center').dialog('setTitle', '编辑');
};

couponConfig.setValidate = function(){
	var id = $('#dlgEdit #selectedId').val();
	var isValidate = $("input[name='isValidate']:checked").val();
	var url = getRootPath_web()+'/useconfig/setvalidate';
	var data = {id:id,isValidate:isValidate}
	$.ajax({
		   type: "POST",
		   url: url,
		   async: false,
		   data: data,
		   headers:{csrftoken:$('#csrftoken').val()},
		   success: function(result){
			   if(result.code == 100000){
					$.messager.alert('操作提示',result.message,'info',function(){
						couponConfig.list.search();
					});
				}else{
					$.messager.alert('操作提示',result.message,'warning')
				}
		   }
		});
	
	$('#dlgEdit').window('close');
}

couponConfig.deleteConfig = function(){
	if(isRepeatClick($("#divDeleteConfig"))) 
		return ;
	
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
	var url = getRootPath_web()+'/useconfig/deleteconfig';
	var data = {ids:ids};
	$.post(url,data).done(function(result){
		if(result.code == 100000){
			$.messager.alert('操作提示','删除优惠券配置信息成功！','info',function(){
				couponConfig.list.search();
			});
		}else{
			$.messager.alert('操作提示','删除优惠券配置信息失败！');
		}
	});
}

couponConfig.closeNewConfig = function(){
	$('#dlgAdd').window('close');
}

couponConfig.saveNewConfig = function(){	
	if(isRepeatClick($("#divAddConfig"))) 
		return ;
	
	var configName = $("#configName").textbox('getValue');
	var couponType = $("#couponType").combobox('getValue');
	var discountPercent = $("#discountPercent").textbox('getValue');
	var maxDeductionMoney = $("#maxDeductionMoney").textbox('getValue');
	var validateDay = 0;
	var couponMoney = $("#couponMoney").textbox('getValue');
	var appDiscription = $("#appDiscription").val();
	var isValidate = $("input[name='isValidate']:checked").val();
	
	if(configName == '' || couponType == ''){
		$.messager.alert('操作提示',"请填写优惠券配置！","warning");
		return;
	}
	var zkValidateDay = $("#zkValidateDay").textbox('getValue');
	var mjValidateDay = $("#mjValidateDay").textbox('getValue');
	
	if(couponType == 2 && couponMoney == '' && mjValidateDay == ''){
		$.messager.alert('操作提示',"请填写优惠券配置！","warning");
		return;
	}
	
	if(couponType == 1 && (discountPercent == '' || maxDeductionMoney == '' || zkValidateDay== '')){
		$.messager.alert('操作提示',"请填写优惠券配置！","warning");
		return;
	}
	
	if(couponConfig.lstCouponName){
		var ret = $.inArray(configName, couponConfig.lstCouponName);
		if(ret >= 0){
			$.messager.alert('操作提示',"规则名称已存在，请重新填写！","warning");
			return;
		}
	}
	
	if(couponType == 1)
		validateDay = zkValidateDay;
	else
		validateDay = mjValidateDay;
	
	var isExConfig = $("#ckExUseConfig").is(':checked');

	var arr = new Array();
//	$("input[name='serviceCity']").each(function(){
//		arr.push($(this).val());
//	});
//	var useCityId = arr.join(",");
	var useCityId = "";
	
//	arr.length = 0;
//	$("input[name='carMode']").each(function(){
//		arr.push($(this).val());
//	});
//	var useVehicleModeId = arr.join(",");
	var useVehicleModeId = "";
	
	arr.length = 0;
	$("input[name='weekDay']").each(function(){
		arr.push($(this).val());
	});
	var useWeekDay = arr.join(",");
	
	var useLowerTime = "";
	var useUpperTime = "";
	var baseOrderMoney = 0;
	
	if(isExConfig){
		var arr = new Array();
		$("input[name='serviceCity']:checked").each(function(){
			arr.push($(this).val());
		});
		var useCityId = arr.join(",");
		
		arr.length = 0;
		$("input[name='carMode']:checked").each(function(){
			arr.push($(this).val());
		});
		var useVehicleModeId = arr.join(",");
		
		arr.length = 0;
		$("input[name='weekDay']:checked").each(function(){
			arr.push($(this).val());
		});
		var useWeekDay = arr.join(",");
		var useLowerTime = $("#useLowerTime").val();
		var useUpperTime = $("#useUpperTime").val();
		var baseOrderMoney = $("#baseOrderMoney").textbox('getValue');
		
		if(useCityId == "" && useVehicleModeId == "" && (useLowerTime == "" || useUpperTime == "") && baseOrderMoney == ""&&useWeekDay==""){
			$.messager.alert('操作提示',"请选择个性化配置！","warning");
			return;
		}
		if(useWeekDay == ''){
			useWeekDay = "1,2,3,4,5,6,7";
		}
	}
	
	var data = {configName:configName,couponType:couponType,discountPercent:discountPercent,maxDeductionMoney:maxDeductionMoney,validateDay:validateDay,
			couponMoney:couponMoney,useCityId:useCityId,useVehicleModeId:useVehicleModeId,baseOrderMoney:baseOrderMoney,appDiscription,appDiscription,
			useWeekDay:useWeekDay,useLowerTime:useLowerTime,useUpperTime:useUpperTime,isValidate:isValidate
		};
	
	var url = getRootPath_web()+'/useconfig/saveconfig';
	$.post(url,data).done(function(result){
		if(result.code == 100000){
			$.messager.alert('操作提示',"添加优惠卷配置成功！","info",function(){
				couponConfig.closeNewConfig();
				couponConfig.list.search();
			});
		}else{
			$.messager.alert('操作提示',"添加优惠卷配置失败！","error");
		}
	});
}


$(function(){
	couponConfig.list.listInital();
	/**初始化时间控件标签*/
	laydate.render({
		  elem: '#useLowerTime',
		  type: 'time',
		  format:'HH:MM'
		});
	laydate.render({
		  elem: '#useUpperTime',
		  type: 'time',
		  format:'HH:MM'
		});
	$("#couponType").combobox({
	    onChange:function(newValue,oldValue){
	        if(newValue==='2'){
	            $(".discount").css('display','none');
	            $(".discountDay").css('display','none');
	            $('.derate').css('display','block');
	        }else{
	            $(".discount").css('display','block');
	            $(".discountDay").css('display','block');
	            $('.derate').css('display','none');
	        }
	     }
	});
	
	$('#divExUseConfig input[type="checkbox"]').attr('disabled',true);
	$('#appDiscription').attr('disabled',true);
	$('#useLowerTime').attr('disabled',true);
	$('#useUpperTime').attr('disabled',true);
	$('#baseOrderMoney').textbox('textbox').attr('disabled',true);
	$("#ckExUseConfig").click(function(){
		var ischecked = $(this).is(':checked');
		if(ischecked){
			$('#divExUseConfig input[type="checkbox"]').attr('disabled',false);
			$('#appDiscription').attr('disabled',false);
			$('#useLowerTime').attr('disabled',false);
			$('#useUpperTime').attr('disabled',false);
			$('#baseOrderMoney').textbox('textbox').attr('disabled',false);
		}else{
			$('#divExUseConfig input[type="checkbox"]').attr('disabled',true);
			$('#appDiscription').attr('disabled',true);
			$('#useLowerTime').attr('disabled',true);
			$('#useUpperTime').attr('disabled',true);
			$('#baseOrderMoney').textbox('textbox').attr('disabled',true);
		}	   
	})
});