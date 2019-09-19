<%@ page language="java" pageEncoding="UTF-8"%><html>
<head>
<title>券码管理</title>
<%@ include file="../common/header.jsp"%>

<style type="text/css">
body {
	height: 100%;
	overflow: hidden;
	margin: 0px;
	padding: 0px;
}

.model_form_item_inputx {
	float: left;
	width: 300px;
	display: inline-block;
	vertical-align: middle;
}

.model_form_item_inputx .textbox {
	position: relative;
	border: 1px solid #ccc;
	background-color: #fff;
	vertical-align: top;
	display: inline-block;
	overflow: hidden;
	white-space: nowrap;
	margin: 0 0px 0 0px;
	padding: 0;
	height: 30px;
	/* min-width: 130px; */
	font-family: "微软雅黑", "Microsoft YaHei UI Light" !important;
}
</style>
</head>
<body style="background-color: rgba(233, 236, 243, 1)">
	<div class="list_title">
		<span class="layui-parent-title-customer">HOME</span> <span
			class="layui-badge-dot layui-bg-title"></span> <span
			class="layui-children-title-customer">劵码管理</span>
	</div>
	<div class="text_input">
		<span class="div_search_customerBar"></span>
		<form id='fm_s' action="">
			<div class="form_item">
				<div class="form_item_inline">
					<label class="form_item_label2">名称</label>
					<div class="form_item_input">
						<input class="easyui-textbox" name="activityName" />
					</div>
				</div>
				<div class="form_item_inline">
					<input type="button" class="text_input_button_search"
						onclick="search()" value="查询">
				</div>
			</div>
		</form>
	</div>

	<div class="table_data">
		<h4 class="table_data_title">
			劵码管理
			<div class="text_input_bottom">
				<div class="text_input_button_add" id="text_input_button_left"
					onclick=" newCouponExActivity()">添加</div>
				<div class="text_input_button_del" id="text_input_button_left"
					onclick="delCouponExActivity()">删除</div>
				<div class="text_input_button_del" id="text_input_button_left"
					onclick="btnExport()">导出</div>
			</div>
		</h4>
		<!-- 数据表格 -->
		<table id="couponActivityTable" style="width: 100%;"></table>
	</div>
	<!-- 新建页面 -->
	<div id="dlgAdd" class="easyui-dialog"
		style="width: 600px; min-height: 500px; max-height: 600px; display: none;"
		closed="true" buttons="#dlg-buttonsAdd"
		data-options="iconCls:'icon-save',closed:'true',collapsible:false,minimizable:false,maximizable:false,closable:true">
		<form id="fmAdd" method="post" style="padding: 20px 10px 10px 30px">
			<div class="form_item">
				<div class="form_item_inline" style="text-indent: 1em">
					<label class="model_form_item_label"> <span
						class="mode_form_dot"> 请填好数量后点击保存即可生成券码，保存后数量不可编辑，请确认
							好生成数量; </span>
					</label>
				</div>
			</div>
			<div class="form_item">
				<div class="form_item_inline">
					<label class="model_form_item_label7"><span
						class="mode_form_dot">*</span>启用状态</label>
					<div class="model_form_item_input">
						<input type="radio" name="isEnable" id="isEnable_add" value='1'
							checked='checked' />启用 <input type="radio" name="isEnable"
							value="2" />禁用
					</div>
				</div>
			</div>
			<div class="model_form_item">
				<div class="model_form_item_inline" style="float: left">
					<label class="model_form_item_label7"><span
						class="mode_form_dot">*</span>活动名称</label>
					<div class="model_form_item_inputx" style="width: 300px">
						<input type="text" id="activityName_add" name="activityName"
							class="easyui-textbox" data-options="prompt:'最多可输入18个字符'"
							style="height: 30px; width: 400px !important; padding: 0 0px; border: 1px solid rgb(204, 204, 204); padding-left: 4px"></input>
					</div>
				</div>
			</div>
			<div class="model_form_item">
				<div class="model_form_item_inline">
					<label class="model_form_item_label7">备注详情</label>
					<div class="model_form_item_input">
						<textarea class="model_form_item_textarea" name="remark"
							style="background: #fff; width: 399px; height: 130px;"></textarea>
					</div>
				</div>
			</div>
			<div class="model_form_item">
				<div class="model_form_item_inline">
					<label class="model_form_item_label7"><span
						class="mode_form_dot">*</span>有效截止日期</label>
					<div class="model_form_item_input" style="font-size: 14px">
						<input type="text" id="endDate_add" name="endDate"
							class="easyui-datebox" width="100%!important"></input>
					</div>
				</div>
			</div>
			<div class="model_form_item">
				<div class="model_form_item_inline">
					<label class="model_form_item_label7"><span
						class="mode_form_dot">*</span>生成数量</label>
					<div class="model_form_item_input" style="font-size: 14px">
						<input type="text" id="exchangeCount_add" name="exchangeCount"
							class="easyui-numberbox" style=""
							data-options="prompt:'  输入数字代表生成数量'" width="100%!important" />
					</div>
				</div>
			</div>
		</form>
	</div>
	<div id="dlg-buttonsAdd" style="display: none; clear: both">
		<div class="text_input_button_cancel" onclick="closeWindow('dlgAdd')">取消</div>
		<div class="text_input_button_float" id="divAddActivity" onclick="addCouponExchangeActivity()">保存</div>
	</div>
	<!-- 编辑页面 -->
	<div id="dlgEdit" class="easyui-dialog"
		style="width: 600px; min-height: 500px; max-height: 600px; display: none;" closed="true"
		buttons="#dlg-buttonsEdit"
		data-options="iconCls:'icon-save',closed:'true',collapsible:false,minimizable:false,maximizable:false,closable:true">
		<form id="fmEdit" method="post" style="padding: 20px 10px 10px 30px">
		    <input type="hidden" name="id"/>
			<div class="form_item">
				<div class="form_item_inline">
					<label class="model_form_item_label7"><span
						class="mode_form_dot">*</span>启用状态</label>
					<div class="model_form_item_input">
						<input type="radio" name="isEnable" value='1' checked='checked' />启用
						<input type="radio" name="isEnable" value="2" />禁用
					</div>
				</div>
			</div>
			<div class="model_form_item">
				<div class="model_form_item_inline" style="float: left">
					<label class="model_form_item_label7"><span
						class="mode_form_dot">*</span>活动名称</label>
					<div class="model_form_item_inputx" style="width: 300px">
						<input type="text" id="activityName_edit" name="activityName" class="easyui-textbox" data-options="prompt:'最多可输入18个字符',validType:'maxLengthc'"
                            style="height: 30px; width: 400px !important; padding: 0 0px; border: 1px solid rgb(204, 204, 204); padding-left: 4px">
                            </input>
					</div>
				</div>
			</div>
			<div class="model_form_item">
                <div class="model_form_item_inline">
                    <label class="model_form_item_label7">备注详情</label>
                    <div class="model_form_item_input">
                        <textarea class="model_form_item_textarea" name="remark"
                            style="background: #fff; width: 399px; height: 130px;"></textarea>
                    </div>
                </div>
            </div>
			<div class="model_form_item">
				<div class="model_form_item_inline">
					<label class="model_form_item_label7"><span
						class="mode_form_dot">*</span>有效截止日期</label>
					<div class="model_form_item_input" style="font-size: 14px">
						<input type="text" name="endDate" class="easyui-datebox" id="endDate_edit"
							width="100%!important"></input>
					</div>
				</div>
			</div>

		</form>
	</div>
	<div id="dlg-buttonsEdit" style="display: none; clear: both">
		<div class="text_input_button_cancel" onclick="closeWindow('dlgEdit')">取消</div>
		<div class="text_input_button_float" onclick="editCouponExchangeActivity()">保存</div>
	</div>
	<!-- 删除优惠券 -->
	<div id="dlgDel" class="easyui-dialog"
		style="width: 400px; max-height: 600px; display: none;" closed="true"
		buttons="#dlg-buttonsDel"
		data-options="iconCls:'icon-save',closed:'true',collapsible:false,minimizable:false,maximizable:false,closable:true">
		<div
			style="height: 100px; background: url(../../img/warn.png) no-repeat 40px center">
			<p style="width: 210px; margin-left: 130px; padding-top: 30px">
				删除此记录后，未兑换成功的券码将全部失效。</p>
		</div>
	</div>
	<div id="dlg-buttonsDel" style="display: none; clear: both">
		<div class="text_input_button_cancel" onclick="closeWindow('dlgDel')">取消</div>
		<div class="text_input_button_float" onclick="deleteCouponExchangeActivity()">确认</div>
	</div>
    
    <div id="dlgDetail" class="easyui-window"
        data-options="iconCls:'icon-save',closed:'true',collapsible:false,minimizable:false,maximizable:false,closable:true" style="width:810px;height:600px;">
                                    券码列表
    </div>
	<script>
	    function newCouponExActivity() {
	        $('#dlgAdd').dialog('open').dialog('center')
	                .dialog('setTitle', ' 添加券码');
	        
	        $('#fmAdd').form('clear');
	        $('#fmAdd').form('load',{isEnable:'1'});
	    }
	    function editCoupon(row){
	    	$('#dlgEdit').dialog('open').dialog('center')
            .dialog('setTitle', '编辑活动');
    
		    $('#fmEdit').form('clear');
		    $('#fmEdit').form('load',row);
	    }
	    function delCouponExActivity(){
	    	var rows = $("#couponActivityTable").datagrid("getSelections");
	    	if(!rows || rows.length==0){
	    		$.messager.alert("操作提示", "请先选择要删除的数据","");
	    		return;
	    	}
	        $('#dlgDel').dialog('open').dialog('center').dialog('setTitle', '提示');
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
            $('#couponActivityTable').datagrid('load');
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
	    	setAutoHeight(300,"couponActivityTable"); 
            $('#couponActivityTable').datagrid({
               url:'<%=request.getContextPath()%>/couponExchangeActivity/getExActivityList',
                rownumbers : true,
                columns : [[
                        {field : 'ck', checkbox:true,id:'ck'},
                        {field : 'id',hidden : true,title : 'id'},
                        {field : 'action',title : '操作',width : '18%',formatter : function(value, row) { //格式化函数添加一个操作列
                        	
                            var btn = '<a style="" class="radiuBtn" href="javascript:void(0)" onclick=\'javascript:editCoupon('+JSON.stringify(row)+')\'>编辑</a>';
                            btn += '<a style="" class="radiuBtn" href="#" onclick="javascript:couponDetail(' + row.id + ')">详情</a>';
                            btn += '<a style=""  class="radiuBtn" href="'+ getRootPath_web() +'/jsp/couponmanage/couponpackagelist.jsp?packageId='+ row.couponPackageId +'">配券</a>';
                            return btn;
                        }}, 
                        {field : 'activityName',title : '活动名称',width : '15%'}, 
                        {field : 'isEnable',title : '状态',width : '10%',formatter:function(val){
                        	if(val =='1'){
                        		return "启用";
                        	}else if(val == '2'){
                        		return "禁用";
                        	}
                        	return val;
                        }}, 
                        {field : 'exchangeCount',title : '总生成数量',width : '10%'},
                        {field : 'usedCount',title : '已兑换',width : '8%'}, 
                        {field : 'notUsedCount',title : '剩余兑换',width : '8%',formatter:function(val,row){
                        	return row.exchangeCount-row.usedCount;
                        }} ,
                        {field : 'createDate',title : '创建日期',width : '15%'} ,
                        {field : 'endDate',title : '过期日期',width : '15%'} ,
                        {field : 'remark',title : '备注',width : '18%'}
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
            
            var pager = $('#couponActivityTable').datagrid('getPager');    // get the pager of datagrid
               pager.pagination({
                   pageSize:10,
                   pageList: [10,50,100],
                   displayMsg:'',
                   links : 5,
                   layout:['prev','links','next','list']
               });     
	    	
	    });
	    
        function addCouponExchangeActivity(){
        	if(isRepeatClick($("#divAddActivity"))) 
        		return ;
        	
            $('#fmAdd').form('submit', {
                url : "<%=request.getContextPath()%>/couponExchangeActivity/addActivity",
                onSubmit : function() {
                    var val=$('#fmAdd input:radio[name="isEnable"]:checked').val();
                    if(!val){
                        $.messager.alert("操作提示", "请选择是否启用","");
                        return false;
                    }
                    if(!$("#activityName_add").textbox('getValue')){
                        $.messager.alert("操作提示", "请填写活动名称","");
                        return false;
                    }
                    if(!$("#endDate_add").datebox('getValue')){
                        $.messager.alert("操作提示", "请填写有效截止日期","");
                        return false;
                    }
                    var count = $("#exchangeCount_add").numberbox('getValue');
                    if(!count){
                        $.messager.alert("操作提示", "请填写生成数量","");
                        return false;
                    }
                    if(checkNoNum(count)){
                        $.messager.alert("操作提示", "请输入正确的生成数量","");
                        return false;
                    }
                    return true;
                },
                success : function(result) {
                    var result = $.parseJSON(result);
                    if (result&&result.code==100000) {
                    	$.messager.alert("操作提示", "操作成功","");
                        $('#dlgAdd').dialog('close'); 
                        $('#couponActivityTable').datagrid('reload'); 
                    }else {
                    	$.messager.alert("操作提示", result.message,"");
                    }
                }
            }); 
        }
        
        function editCouponExchangeActivity(){
        	if(isRepeatClick($("#divAddActivity")))  return ;
        	
            $('#fmEdit').form('submit', {
                url : "<%=request.getContextPath()%>/couponExchangeActivity/editActivity",
                onSubmit : function() {
                    var val=$('#fmEdit input:radio[name="isEnable"]:checked').val();
                    if(!val){
                        $.messager.alert("操作提示", "请选择是否启用","");
                        return false;
                    }
                    if(!$("#activityName_edit").textbox('getValue')){
                        $.messager.alert("操作提示", "请填写活动名称","");
                        return false;
                    }
                    if(!$("#endDate_edit").datebox('getValue')){
                        $.messager.alert("操作提示", "请填写有效截止日期","");
                        return false;
                    }
                    return true;
                },
                success : function(result) {
                    var result = $.parseJSON(result);
                    if (result&&result.code==100000) {
                        $.messager.alert("操作提示", "操作成功","");
                        $('#dlgEdit').dialog('close'); 
                        $('#couponActivityTable').datagrid('reload'); 
                    }else {
                        $.messager.alert("操作提示", result.message,"");
                    }
                }
            });
        }
        
        function deleteCouponExchangeActivity(){
        	var rows = $("#couponActivityTable").datagrid("getSelections");
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
                url: "<%=request.getContextPath()%>/couponExchangeActivity/deleteActivity",
                async: false,
                data: {ids:strids},
                dataType: "json",
                success: function(result){
                    if (result && result.code==100000){
                        $.messager.alert('操作提示','操作成功!');
                        $('#couponActivityTable').datagrid('reload');
                        $('#dlgDel').dialog('close')
                   } else {
                	   $.messager.alert('操作提示','操作失败!');
                	   return;
                   }
                }
           });
        }
        
	    function btnExport(){
	    	var rows = $("#couponActivityTable").datagrid("getSelections");
            if(!rows || rows.length==0){
            	 var queryParam = getFormJson($("#fm_s")[0]);
                 var url = "<%=request.getContextPath()%>/couponExchangeActivity/exportActivity?"+ $.param(queryParam);
            }else{
	            var strids = '';
	            for(var i = 0; i<rows.length; i++){
	            	if(i==0){
	            		strids += rows[i].id;
	            	}else{
	            		strids+=','+rows[i].id;
	            	}
	            }
	            var url = "<%=request.getContextPath()%>/couponExchangeActivity/exportActivity?selectIds="+ strids;
            }
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