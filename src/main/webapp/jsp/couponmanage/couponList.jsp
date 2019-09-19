<%@ page language="java" pageEncoding="UTF-8"%><html>
<head>
<title>优惠卷列表</title>
<%@ include file="../common/header.jsp"%>
</head>
<body>
<div class="list_title">
		<span class="layui-parent-title-customer">HOME</span>
	    <span class="layui-badge-dot layui-bg-title"></span>
	    <span class="layui-children-title-customer">优惠券列表</span>
	</div>
	<div class="text_input">
		<span class="div_search_customerBar"></span>
		<form id='fm_s' action="">
			<div class="form_item">
				<div class="form_item_inline">
					<label class="form_item_label4">编号</label>
					<div class="form_item_input">
						<input  class="easyui-textbox" name="couponNo" />
					</div>
				</div>
				<div class="form_item_inline">
					<label class="form_item_label4">手机号</label>
					<div class="form_item_input">
						<input  class="easyui-textbox"  name="mobile" />
					</div>
				</div>
				<div class="form_item_inline">
					<label class="form_item_label4">使用状态</label>
					<div class="form_item_input">
						<select class="easyui-combobox" name="isUsed" >
							<option value="">全部</option>
							<option value="1">未用</option>
							<option value="2">已用</option>
							<option value="3">已过期</option>
						</select>
					</div>
				</div>
				<div class="form_item_inline">
					<label class="form_item_label4">来源</label>
					<div class="form_item_input">
						<select class="easyui-combobox" name="sourceType">
							<option value="">全部</option>
							<option value="1">注册用户赠</option>
							<option value="2">邀请好友赠</option>
							<option value="3">订单满额赠</option>
							<option value="4">首次用车结单赠</option>
							<option value="5">首次成为企业用户赠</option>
							<option value="6">企业会员按时间赠</option>
							<option value="7">后台录入</option>
							<option value="8">券码兑换</option>
							<option value="9">渠道</option>
							<option value="10">推广</option>
						</select>
					</div>
				</div>
				<div class="form_item_inline">
					 <input type="button"  class="text_input_button_search" onclick="search()" value="查询">
				</div>
			
			</div>
			<div class="form_item">
				<div class="form_item_inline">
					<label class=" form_item_label4">开始时间</label>
					<div class="form_item_input">
						<input id="startTime" type="text" name="createDateStart" class="easyui-datetimebox" />
					</div>
				</div>
				<div class="form_item_inline">
					<label class=" form_item_label4">结束时间</label>
					<div class="form_item_input">
						<input id="endTime" type="text" name="createDateEnd" class="easyui-datetimebox" />
					</div>
				</div>
			
			</div>
		</form>
	</div>

	<div class="table_data">
		<h4 class="table_data_title">
			优惠券列表
			<div class="text_input_bottom">
				<div class="text_input_button_add" id="text_input_button_left" onclick="newCoupon()">添加</div>
				<div class="text_input_button_del" id="text_input_button_left" onclick="del()">删除</div>
				<div class="text_input_button_excl" onclick="btnExport()">导出</div>	
			</div>
        </h4>
        <!-- 数据表格 -->
		<table id="couponTable" style="width: 100%;"></table>
	</div>

		<!-- 新建页面 -->
        <div id="dlgAdd" class="easyui-dialog" style="width:600px; max-height:600px; display:none;" closed="true"	buttons="#dlg-buttonsAdd"  data-options="iconCls:'icon-save',closed:'true',collapsible:false,minimizable:false,maximizable:false,closable:true">
                <form id="fmAdd" method="post" style="padding:20px 10px 10px 30px">
                        <div class="form_item" >
                       		<input type="hidden" name="customerId" id="customerId" value="" />
                            <div class="form_item_inline">
                                <label class="model_form_item_label7"><span class="mode_form_dot">*</span>用户名</label>
                                <div class="model_form_item_input">
                                    <input type="text"  class="easyui-textbox" width="100%!important" id="mobile_s" name="mobile" data-options="required:true"></input>
                                </div>
                            </div>
                            <div class="form_item_inline">
                                <div class="text_input_button_add" id="text_input_button_left" onclick="findUser()">查找</div>
                            </div>
                            <div class="form_item_inline">
                                <span class="tip_msg_color" id="tip_user" ></span>
                            </div>
                        </div>
                        <div class="form_item">
                                <div class="form_item_inline">
                                    <label class="model_form_item_label7"><span class="mode_form_dot">*</span>启用状态</label>
                                    <div class="model_form_item_input">
                                            <input type="radio" name="isEnable" value='1' checked='checked' />启用 
                                            <input type="radio" name="isEnable" value="2" />禁用
                                    </div>
                                </div>
                        </div>
                        <div class="form_item">
                                <div class="form_item_inline">
                                    <label class="model_form_item_label7"><span class="mode_form_dot">*</span>优惠券名称</label>
                                    <div class="model_form_item_input">
                                        <input type="text" name="couponName" id="couponName" class="easyui-textbox" width="100%!important" data-options="required:true,prompt:'最多可输入8个字符',validType:'length[1,8]'"></input>
                                    </div>
                                </div>
                        </div>
                        <div class="form_item">
                                <div class="form_item_inline">
                                    <label class="model_form_item_label7"><span class="mode_form_dot" >*</span>优惠券类型</label>
                                    <div class="model_form_item_input">
                                        <select class="easyui-combobox" id="couponType_s" name="couponType" style="width: 200px;">
                                        	<option value="">全部</option>
                                            <option value="1">折扣券</option>
                                            <option value="2">减免券</option>
                                        </select>
                                    </div>
                                </div>
                        </div>
                        <div class="form_item">
                                <div class="form_item_inline" style="display:block">
                                    <label class="model_form_item_label7"><span class="mode_form_dot">*</span>配置名称</label>
                                    <div class="model_form_item_input" style="width:410px!important;margin-bottom:15px;">
                                        <select id="couponConfigId" name="couponConfigId" class="easyui-combobox" style="width: 200px;">
                                            
                                        </select>
                                        <span style="font-size: 12px;color: red;">(请先在优惠券配置中进行优惠券配置操作)</span>
                                    </div>
                                </div>
                        </div>
                        <div class="form_item">
                                <div class="form_item_inline">
                                    <label class="model_form_item_label7"><span class="mode_form_dot">*</span>配置详情</label>
                                    <div class="model_form_item_input">
                                            <textarea class="model_form_item_textarea" id="configDetail" name="configDetail"></textarea>
                                    </div>
                                </div>
                        </div>
                    </form>
            </div>
            <div id="dlg-buttonsAdd" style="display:none;clear:both">
                <div class="text_input_button_cancel" onclick="closeWindow('dlgAdd')">取消</div>
                <div class="text_input_button_float" onclick="addCustomerCouponNew()">保存</div>
            </div>
            	<!-- 编辑页面 -->
        	<div id="dlgEdit" class="easyui-dialog" style="width:600px; max-height:600px; display:none;" closed="true"	buttons="#dlg-buttonsEdit"  data-options="iconCls:'icon-save',closed:'true',collapsible:false,minimizable:false,maximizable:false,closable:true">
                <form id="fmEdit" method="post" class="model_form_padding">
                        <input type="hidden" name="id" id="id_edit" value="" />
                        <div class="form_item" >
                                <div class="form_item_inline">
                                    <label class="model_form_item_label7"><span class="mode_form_dot">*</span>用户名</label>
                                    <div class="model_form_item_input">
                                        <input type="text"  class="easyui-textbox" name="mobile" disabled></input>
                                    </div>
                                </div>
                        </div>
                        <div class="form_item">
                                <div class="form_item_inline">
                                    <label class="model_form_item_label7"><span class="mode_form_dot">*</span>启用状态</label>
                                    <div class="model_form_item_input">
                                            <input type="radio" name="isEnable" value='1' checked='checked' />启用 
                                            <input type="radio" name="isEnable" value="2" />禁用
                                    </div>
                                </div>
                        </div>
                        <div class="form_item">
                                <div class="form_item_inline">
                                    <label class="model_form_item_label7"><span class="mode_form_dot">*</span>优惠券类型</label>
                                    <div class="model_form_item_input">
                                         <input type="text" name="couponTypeText" class="easyui-textbox" disabled></input>
                                    </div>
                                </div>
                        </div>
                        <div class="form_item">
                                <div class="form_item_inline">
                                    <label class="model_form_item_label7"><span class="mode_form_dot">*</span>优惠券名称</label>
                                    <div class="model_form_item_input">
                                        <input type="text" name="couponName" class="easyui-textbox" disabled></input>
                                    </div>
                                </div>
                        </div>
                        <div class="form_item">
                                <div class="form_item_inline">
                                    <label class="model_form_item_label7"><span class="mode_form_dot">*</span>配置详情</label>
                                    <div class="model_form_item_input">
                                            <textarea class="model_form_item_textarea" name="configDetail" disabled readonly></textarea>
                                    </div>
                                </div>
                        </div>
                        <div class="form_item">
                                <div class="form_item_inline">
                                    <label class="model_form_item_label7"><span class="mode_form_dot">*</span>生成日期</label>
                                    <div class="model_form_item_input">
                                            <input type="text" name="createDate" class="easyui-textbox" data-options="required:true" disabled="disabled"></input>
                                    </div>
                                </div>
                        </div>
                        <div class="form_item">
                                <div class="form_item_inline">
                                    <label class="model_form_item_label7"><span class="mode_form_dot">*</span>过期日期</label>
                                    <div class="model_form_item_input">
                                            <input type="text" id="expireDate"  name="expireDate" class="easyui-textbox easyui-datebox" data-options="required:true"></input>
                                    </div>
                                </div>
                        </div>
                    </form>
            </div>
            <div id="dlg-buttonsEdit" style="display:none;clear:both">
                <div class="text_input_button_cancel" onclick="closeWindow('dlgEdit')">取消</div>
                <div class="text_input_button_float" onclick="editCustomerCouponNew()">保存</div>
            </div>
            <!-- 删除优惠券 -->
            <div id="dlgDel" class="easyui-dialog" style="width:400px; max-height:600px; display:none;" closed="true"	buttons="#dlg-buttonsDel"  data-options="iconCls:'icon-save',closed:'true',collapsible:false,minimizable:false,maximizable:false,closable:true">
                <div style="height:100px;background:url(../../img/warn.png) no-repeat 40px center">
                        <p style="width:210px;margin-left:130px;padding-top:30px">
                                                                                    确定要删除该优惠券 ？                                                   
                        </p>    
                </div>
            </div>
            <div id="dlg-buttonsDel" style="display:none;clear:both">
                <div class="text_input_button_cancel" onclick="closeWindow('dlgDel')">取消</div>
                <div class="text_input_button_float" onclick="deleteCustomerCouponNew()">确定</div>
            </div>
              <script>
            	function newCoupon() {
            		$("#fmAdd")[0].reset();
                    $('#dlgAdd').dialog('open').dialog('center')
                            .dialog('setTitle', ' 添加优惠券');
                    $('#fmAdd').form('clear');
                    $('#fmAdd').form('load',{isEnable:1});
                    $("#tip_user").html("");
                }
                function edit(row){
                    $('#dlgEdit').dialog('open').dialog('center').dialog('setTitle', '编辑');
                    if(row.couponType==1){
		                row.couponTypeText = "折扣券";
		            }else if(row.couponType==2){
		                row.couponTypeText = "减免券";
		            }
                    $('#fmEdit').form('clear');
                    $('#fmEdit').form('load',row);
                }
                function del(){
                    $('#dlgDel').dialog('open').dialog('center')
                            .dialog('setTitle', '提示');
                }
                function couponDetail(activityId){
        	    	$('#dlgDetail').window({href:'<%=request.getContextPath()%>/jsp/couponmanage/couponExchangeCode.jsp?activityId='+activityId})
                    .window('setTitle','详情')
                    .window('open');//
        	    }
        	    function closeWindow(id){
        	    	$('#'+id).dialog('close');
        	    }
        	    function search() {
                    $('#couponTable').datagrid('load');
                }
        	    
                function checkNoNum(value) { 
                    var re = /^\d+(?=\.{0,1}\d+$|$)/ 
                    if (value != "") {
                        if (!re.test(value)) { 
                            return true 
                        } 
                    }
                    return false;
                }
        	    $(function(){
        	    	setAutoHeight(300,"couponTable"); 
                    $('#couponTable').datagrid({
                       url:'<%=request.getContextPath()%>/customerCouponNew/getCustomerCouponNewList',
                        rownumbers : true,
                        columns : [[
                                {field : 'ck', checkbox:true,id:'ck'},
                                {field : 'id',hidden : true,title : 'id'},
                                {field : 'action',title : '操作',width : '12%',formatter : function(value, row) { //格式化函数添加一个操作列
                                    var btn = '<a style="" class="radiuBtn" href="javascript:void(0)" onclick=\'javascript:edit('+JSON.stringify(row)+')\'>编辑</a>';
                                    return btn;
                                }}, 
                                {field : 'mobile',title : '用户手机号',width : '12%'}, 
                                {field : 'isUsed',title : '使用状态',width : '12%',formatter:function(val){
                                	if(val == 1){
                                		return "<span style='color:#3598dc'>未用</span>";
                                	}else if(val == 2){
                                		return "已用";
                                	}else if(val == 3){
                                		return "<span style='color:#ff0000'>过期</span>";
                                	}
                                	return val;
                                }},
                                {field : 'usedDate',title : '使用时间',width : '15%',formatter:function(val){
                                	if(!val){
                                		return "-";
                                	}
                                	return val;
                                }}, 
                                {field : 'orderNo',title : '订单编号',width : '18%',formatter:function(val){
                                	if(!val){
                                		return "-";
                                	}
                                	return val;
                                }}, 
                                {field : 'couponNo',title : '优惠券编号',width : '18%'}, 
                                {field : 'couponType',title : '优惠券类型',width : '12%',formatter:function(val){
                                	if(val == 1){
                                		return "折扣券";
                                	}else if(val == 2){
                                		return "减免券";
                                	}
                                	return val;
                                }}, 
                                {field : 'couponName',title : '优惠券名称',width : '15%'}, 
                                {field : 'couponMoney',title : '金额',width : '12%',formatter:function(val,rec){
                                	if(rec.couponType == 1){
                                		return "-";
                                	}
                                	return val;
                                }}, 
                                {field : 'discountPercent',title : '折扣比例',width : '12%',formatter:function(val,rec){
                                	if(rec.couponType == 2){
                                		return "-";
                                	}
                                	return val+"%";
                                }}, 
                                {field : 'maxDeductionMoney',title : '最高减免',width : '12%',formatter:function(val,rec){
                                	if(rec.couponType == 2){
                                		return "-";
                                	}
                                	return val;
                                }}, 
                                {field : 'configDetail',title : '配置详情',width : '50%'}, 
                                {field : 'sourceType',title : '来源',width : '15%',formatter:function(val){
                                	if(val == 1){
                                		return "注册用户赠";
                                	}else if(val == 2){
                                		return "邀请好友赠";
                                	}else if(val == 3){
                                		return "订单满额赠";
                                	}else if(val == 4){
                                		return "首次用车结单赠";
                                	}else if(val == 5){
                                		return "首次成为企业用户赠";
                                	}else if(val == 6){
                                		return "企业会员按时间赠";
                                	}else if(val == 7){
                                		return "后台录入";
                                	}else if(val == 8){
                                		return "券码兑换";
                                	}else if(val == 9){
                                		return "渠道";
                                	}else if(val == 10){
                                		return "推广";
                                	}else if(val == 11){
                                		return "邀请好友赠";
                                	}
                                	return val;
                                }},
                                {field : 'isEnable',title : '启用状态',width : '10%',formatter:function(val){
                                	if(val =='1'){
                                		return "<span style='color:#3598dc'>启用<span>";
                                	}else if(val == '2'){
                                		return "<span style='color:#ff0000'>禁用</span>";
                                	}
                                	return val;
                                }},
                                {field : 'createDate',title : '生成日期',width : '15%'} ,
                                {field : 'expireDate',title : '过期日期',width : '15%',formatter:function(val){
                                	if(!val){
                                		return '-';
                                	}
                                	return val.substring(0,10);
                                }} 
                        ]],
                        pagination : true,
                        pageSize : 10,
                        pageList : [ 5, 10, 15, 20, 50 ],
                        layout:['prev','links','next','list'],
                        emptyMsg : '无数据',
                        onBeforeLoad : function(param) {
                            $($('#fm_s').serializeArray()).each(
                                function() {
                                    param[this.name] = this.value;
                                }
                            );
                        }
                    });
                    
                    var pager = $('#couponTable').datagrid('getPager');    // get the pager of datagrid
                    pager.pagination({
                        pageSize:10,
                        pageList: [10,50,100],
                        displayMsg:'',
                        links : 5,
                        layout:['prev','links','next','list']
                    });
                    
                    $("#couponType_s").combobox({onChange:function(){
                    	getConponConfig();
                    }});
                    $("#couponConfigId").combobox({valueField:'id',textField:'configName',onChange:function(){
                    	loadConfigDetail();
                    }});
                    getConponConfig();
        	    	
        	    });
        	    
        	    function findUser(){
        	    	var mobile = $("#mobile_s").val();
        	    	if(!mobile){
        	    		$.messager.alert("操作提示", "请填写手机号","");
        	    		return;
        	    	}
        	    	$.ajax({
                        type: "POST",
                        url: "/bjycrm/customer/findCustomerByMobile",
                        async: false,
                        data: {mobile:mobile},
                        dataType: "json",
                        success: function(result){
                           if (result && result.code==10000){
                        	   $("#customerId").val(result.data.id);
                               $("#tip_user").html("用户存在").css({color:'green'});
                           } else {
                        	   $("#customerId").val('');
                        	   $("#tip_user").html("用户不存在").css({color:'red'});
                           }
                        }
                   });
        	    }
        	    var conponConfigList;
        	    function getConponConfig(){
        	    	var queryCouponType = $("#couponType_s").combobox('getValue');
        	    	
        	    	$.ajax({
                        type: "POST",
                        url: "<%=request.getContextPath()%>/useconfig/list4Combobox",
                        async: false,
                        data: {queryIsValidate:1,queryCouponType:queryCouponType},
                        dataType: "json",
                        success: function(result){
                           if (result && !result.code){
                        	   conponConfigList = result;
                        	   $("#couponConfigId").combobox('clear').combobox('loadData',result);
                           }
                        }
                   });
        	    }
        	    
        	    function loadConfigDetail(){
        	    	var couponConfigId = $("#couponConfigId").combobox('getValue');
        	    	if(!couponConfigId || !conponConfigList){
        	    		$("#configDetail").empty();
        	    	}else{
        	    		for(var i=0;i<conponConfigList.length;i++){
        	    			if(conponConfigList[i].id==couponConfigId){
        	    				$("#fmAdd").form('load',{configDetail:conponConfigList[i].configDetail});
        	    				return;
        	    			}
        	    		}
        	    	}
        	    }
        	    
                function addCustomerCouponNew(){
                	if(!$("#fmAdd").form('validate')){
                		$.messager.alert('操作提示','表单信息校验项未通过！',"warning");
                		return;
                	}
                	
                    $('#fmAdd').form('submit', {
                        url : "<%=request.getContextPath()%>/customerCouponNew/addCustomerCouponNew",
                        onSubmit : function() {
                        	if(!$("#customerId").val()){
                        		$.messager.alert("操作提示", "请填写用户名并检查是否存在","");
                                return false;
                        	}
                            var val=$('#fmAdd input:radio[name="isEnable"]:checked').val();
                            if(!val){
                                $.messager.alert("操作提示", "请选择是否启用","");
                                return false;
                            }
                            if(!$("#couponName").textbox('getValue')){
                                $.messager.alert("操作提示", "请填写优惠券名称","");
                                return false;
                            }
                            
                            var couponType = $("#couponType_s").combobox('getValue');
                            if(!couponType){
                            	$.messager.alert("操作提示", "请选择优惠券类型","");
                                return false;
                            }
                            
                            var couponConfigId = $("#couponConfigId").combobox('getValue');
                            if(!couponConfigId){
                                $.messager.alert("操作提示", "请选择配置名称","");
                                return false;
                            }

                            return true;
                        },
                        success : function(result) {
                            var result = $.parseJSON(result);
                            if (result&&result.code==100000) {
                            	$.messager.alert("操作提示", "操作成功","");
                                $('#dlgAdd').dialog('close'); 
                                $('#couponTable').datagrid('reload'); 
                            }else {
                            	$.messager.alert("操作提示", result.message,"");
                            }
                        }
                    });
                }
                function editCustomerCouponNew(){
                    $('#fmEdit').form('submit', {
                        url : "<%=request.getContextPath()%>/customerCouponNew/editCustomerCouponNew",
                        onSubmit : function() {
                        	if(!$("#id_edit").val()){
                                $.messager.alert("操作提示", "id不存在","");
                                return false;
                            }
                            var val=$('#fmEdit input:radio[name="isEnable"]:checked').val();
                            if(!val){
                                $.messager.alert("操作提示", "请选择是否启用","");
                                return false;
                            }
                            if(!$("#expireDate").datebox('getValue')){
                                $.messager.alert("操作提示", "请选择失效日期","");
                                return false;
                            }
                            return true;
                        },
                        success : function(result) {
                            var result = $.parseJSON(result);
                            if (result&&result.code==100000) {
                                $.messager.alert("操作提示", "操作成功","");
                                $('#dlgEdit').dialog('close'); 
                                $('#couponTable').datagrid('reload'); 
                            }else {
                                $.messager.alert("操作提示", result.message,"");
                            }
                        }
                    });
                }
                
                function deleteCustomerCouponNew(){
                	var rows = $("#couponTable").datagrid("getSelections");
                    if(!rows || rows.length==0){
                        $.messager.alert("操作提示", "请先选择要删除的数据","");
                        return;
                    }
                    var strids = '';
                    for(var i = 0; i<rows.length; i++){
                    	if(i==0){
                    		strids += rows[i].id;
                    	}else{
                    		strids+=','+rows[i].id;
                    	}
                    }
                    
                   $.ajax({
                        type: "POST",
                        url: "<%=request.getContextPath()%>/customerCouponNew/deleteCustomerCouponNew",
                        async: false,
                        data: {ids:strids},
                        dataType: "json",
                        success: function(result){
                            if (result && result.code==100000){
                                $.messager.alert('操作提示','操作成功!');
                                $('#couponTable').datagrid('reload');
                                $('#dlgDel').dialog('close')
                           } else {
                        	   $.messager.alert('操作提示','操作失败!');
                        	   return;
                           }
                        }
                   });
                }
                
        	    function btnExport(){
                    var queryParam = getFormJson($("#fm_s")[0]);
                    var url = "<%=request.getContextPath()%>/customerCouponNew/exportCustomerCouponNew?"
        					+ $.param(queryParam);
        			window.open(url);
        		}
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
            </script>
</body>
</html>