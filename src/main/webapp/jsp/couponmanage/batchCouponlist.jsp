<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="../common/header.jsp"%>
<title>批量发券</title>

<link rel="stylesheet" href="../../css/jquery.fancybox.css" type="text/css"/>
<link rel="stylesheet" href="../../css/viewer.min.css" type="text/css"/>
<script type="text/javascript" src="../../js/jquery.fancybox.pack.js"></script>
<script type="text/javascript" src="../../js/util/extendValidate.js"></script>
<script type="text/javascript" src="../../js/viewer.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/couponmanage/couponpackagelist_page.js"></script>
</head>
<body>
<div class="list_title">
 <span class="layui-parent-title-customer">HOME</span>
 <span class="layui-badge-dot layui-bg-title"></span>
 <span class="layui-children-title-customer">批量发券列表</span>
</div>
	<div class="text_input">
		<span class="div_search_customerBar"></span>
	    	<form id='fm' action="">
	    		<div class="form_item">
	    			<div class="form_item_inline">
	    				<label class="form_item_label5">手机号</label>
	    				<div class="form_item_input">
	    					<input name="mobile" class="easyui-textbox">
	    				</div>
	    			</div>
	    			<div class="form_item_inline">
	    				<label class="form_item_label5">姓名</label>
	    				<div class="form_item_input">
	    					<input name="name" class="easyui-textbox">
	    				</div>
	    			</div>
	    			<div class="form_item_inline">
	    				<label class="form_item_label5">性别</label>
	    				<div class="form_item_input">
	    					<select name="gender" class="easyui-combobox"  id="gender" style="width:100px">
		    					<option value="">全部</option>
		    					<option value="1">男</option>
		    					<option value="2">女</option>
	    					</select>
	    				</div>
	    			</div>
	    			<div class="form_item_inline">
	    				<label class="form_item_label5">是否禁用</label>
	    				<div class="form_item_input">
	    					<select name="isDisable" class="easyui-combobox" >
	    						<option value="">全部</option>
	    						<option value="0">否</option>
	    						<option value="1">是</option>
	    					</select>
	    				</div>
	    			</div>
	    			<div class="form_item_inline">
	    				 <input type="button" onclick="search()" class="text_input_button_search" value="查询">
	    			</div>
	    		</div>
	    		<div class="form_item form_item_hidden">
	    			<div class="form_item_inline">
	    				<label class="form_item_label5">注册时间起</label>
	    				<div class="form_item_input">
	    					<input id="createStartTime" type="text" name="createStartTime" class="easyui-datetimebox" />
	    				</div>
	    			</div>
	    			<div class="form_item_inline">
	    				<label class="form_item_label5">注册时间止</label>
	    				<div class="form_item_input">
	    					<input id="createEndTime" type="text" name="createEndTime" class="easyui-datetimebox"/>
	    				</div>
	    			</div>
	    			<div class="form_item_inline">
	    				<label class="form_item_label5">保证金状态</label>
	    				<div class="form_item_input">
	    					<select name="memberType" class="easyui-combobox"  style="width:100px">
	    						<option value="">全部</option>
	    						<option value="0">否</option>
	    						<option value="1">是</option>
	    					</select>
	    				</div>
	    			</div>
	    			<div class="form_item_inline">
	    				<label class="form_item_label5">认证状态</label>
	    				<div class="form_item_input">
	    					<select name="identityApprove" class="easyui-combobox"  id="identityApprove" style="width:100px">
		    					<option value="">全部</option>
		    					<option value="0">未认证</option>
		    					<option value="1">认证通过</option>
		    					<option value="2">认证驳回</option>
		    					<option value="3">认证中</option>
	    					</select>
	    				</div>
	    			</div>
	    		</div>  
	    		<div class="form_item form_item_hidden">
	    			<div class="form_item_inline">
	    				<label class="form_item_label5">是否下单</label>
	    				<div class="form_item_input">
	    					<select name="isCanOrder" class="easyui-combobox" >
	    						<option value="">全部</option>
	    						<option value="0">禁止下单</option>
	    						<option value="1">可以下单</option>
	    					</select>
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
		批量发券<div class="text_input_summary" style="color: red;">（请先配置好优惠券，导入手机号或使用筛选查询出所要赠送的用户）</div>当前共 <span id="numSpan">0</span>条信息<div class="text_input_bottom" >
			<div class="text_input_button_start" id="text_input_button_left" onclick="sendCoupon()">发送</div>
			<div class="text_input_button_add" id="text_input_button_left" onclick="beforeImportExcel()">导入Excel</div>
			<div class="text_input_button_excl" id="configCoupon" onclick="configCoupon()">配置优惠券</div>
	</div>
		</h4>
		<table id="dgData"></table>  
	</div>
	
	<div id="importWin" title="导入Excel" iconCls="icon-save" class="easyui-dialog" style="width:500px;height:200px; display: none; left:15%;top:2%;" closed="true" >
		<form id="importForm" action="${pageContext.request.contextPath}/importExcel"
			method="post" enctype="multipart/form-data">
			<table >
				<tr>
					<td>
						<div class="file-box">
							<input type='text' name='textfield' id='textfield3'
								name="imgfile" data-options="required:true" class='txt'
								value="点击选择图片" /> <input type="file" name="excelFile"
								id="excelFile" class="file" data-options="required:true"
								onchange="document.getElementById('textfield3').value=this.value" />
							<input type="button" class="img_button" onclick="importExcel()"
								value="上传" />
						</div>
					</td>
				</tr>
				<tr>
					<td>
					Excel例子：<a href="${pageContext.request.contextPath}/couponBatchRecord/downExcel">模板下载</a>
					</td>
				</tr>
				<tr>
					<td>
					<img alt=""
						src="${pageContext.request.contextPath}/img/couponExcelDemo.png">
					</td>
				</tr>
			</table>
		</form>
	</div>
	
	<div id="couponConfigWin" title="配置优惠券" iconCls="icon-save" class="easyui-dialog" style="width:80%;height:460px; display: none; left:15%;top:2%;" closed="true" >
		<h4 class="table_data_title">
			优惠券添加
			<div class="text_input_bottom">
				<div class="text_input_button_add" id="text_input_button_left" onclick="couponPackage.openEdit()">添加</div>
				<div class="text_input_button_del" id="text_input_button_left" onclick="$('#dlgDel').dialog('open').dialog('center').dialog('setTitle', '提示');">删除</div>
			</div>
        </h4>
		
		<form id='fm_s' action="">
			<input type="hidden" id="packageId" name="packageId" />
		</form>
        <!-- 数据表格 -->
		<table id="dg" style="width: 98%;"></table>
	</div>
	<!-- 优惠券编辑 -->
    <div id="dlgCouponEdit" class="easyui-dialog" style="width:600px; max-height:600px; display:none;" closed="true"	buttons="#dlg-buttonsAdd"  data-options="iconCls:'icon-save',closed:'true',collapsible:false,minimizable:false,maximizable:false,closable:true">
        <form id="fmAdd" method="post" style="padding:20px 10px 10px 30px">
       		<input type="hidden" id="packageItemId" name="packageItemId"/>
            <div class="form_item">
                    <div class="form_item_inline">
                        <label class="model_form_item_label7"><span class="mode_form_dot">*</span>启用状态</label>
                        <div class="model_form_item_input">
                            <input type="radio" name="isValidate" value=1 checked='checked' />启用 
                			<input type="radio" name="isValidate" value=0 />禁用
                        </div>
                    </div>
            </div>
            <div class="form_item">
                    <div class="form_item_inline">
                        <label class="model_form_item_label7"><span class="mode_form_dot">*</span>优惠券名称</label>
                        <div class="model_form_item_input">
                            <input type="text" id="couponName" name="couponName" class="easyui-textbox" width="100%!important" data-options="required:true,prompt:'最多可输入8个字符',validType:'length[1,8]'"></input>
                        </div>
                    </div>
            </div>
            <div class="form_item">
                    <div class="form_item_inline">
                        <label class="model_form_item_label7"><span class="mode_form_dot" >*</span>优惠券类型</label>
                        <div class="model_form_item_input">
                            <select id="comboxCouponType" name="couponType" class="easyui-combobox" style="width: 200px;">
                            	<option value="1">折扣券</option>
                            	<option value="2">减免券</option>
                            </select>
                        </div>
                    </div>
            </div>
            <div class="form_item">
                    <div class="form_item_inline">
                        <label class="model_form_item_label7"><span class="mode_form_dot">*</span>配置名称</label>
                        <div class="model_form_item_input" style="width:410px!important;margin-bottom:15px;">
                            <select id="comboxConfigName" name="configName" class="easyui-combobox" style="width: 200px;">
                            </select>
                            <span style="font-size: 12px;color: red;">(请先在优惠券配置中进行优惠券配置操作)</span>
                        </div>
                    </div>
            </div>
            <div class="form_item">
                    <div class="form_item_inline">
                        <label class="model_form_item_label7"><span class="mode_form_dot">*</span>配置详情</label>
                        <div class="model_form_item_input">
                                <textarea class="model_form_item_textarea" id="configDetail" name="configDetail" disabled data-options="required:true"></textarea>
                        </div>
                    </div>
            </div>
            <div class="form_item">
                    <div class="form_item_inline">
                        <label class="model_form_item_label7"><span class="mode_form_dot">*</span>赠送数量</label>
                        <div class="model_form_item_input">
                                <input type="text" id="couponCount" name="couponCount" class="easyui-numberbox" data-options="required:true,prompt:' 请输入最少1张',min:1,precision:0"></input>
                        </div>
                    </div>
            </div>
        </form>
    </div>
    <div id="dlg-buttonsAdd" style="display:none;clear:both">
        <div class="text_input_button_cancel" onclick="$('#dlgCouponEdit').dialog('close')">取消</div>
        <div class="text_input_button_float" onclick="couponPackage.saveCouponPackageItem()">保存</div>
    </div>
	
	<!-- 删除优惠券 -->
	<div id="dlgDel" class="easyui-dialog" style="width:400px; max-height:600px; display:none;" closed="true"	buttons="#dlg-buttonsDel"  data-options="iconCls:'icon-save',closed:'true',collapsible:false,minimizable:false,maximizable:false,closable:true">
        <div style="height:100px;background:url(./img/warn.png) no-repeat 40px center">
                <p style="width:210px;margin-left:130px;padding-top:30px">
                        删除此券后不再赠送，确定删除吗？
                </p>    
        </div>
    </div>
    <div id="dlg-buttonsDel" style="display:none;clear:both">
        <div class="text_input_button_cancel" onclick="$('#dlgDel').dialog('close')">取消</div>
        <div class="text_input_button_float" onclick="couponPackage.deleteCouponPackageItem()">保存</div>
    </div>
	<script type="text/javascript">
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
	function dateFmt(res) {
		var date = new Date(res);
		var year = date.getFullYear();
		var month = date.getMonth() + 1;
		var day = date.getDate();
		if (month < 10)
			month = "0" + month;
		if (day < 10)
			day = "0" + day;
		return year + "-" + month + "-" + day;
	}
	$(function() {  
	    $('#win').window('close');
	    $('#chPwd').window('close');
	    $('.fancybox').fancybox({
	       	 closeClick : true
	    });
	    getDatagrid('init');
	});

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
	function memberTypeYesOrNo(val,rec){
		if(val=='0'){
			return '<span class="datagrid_font_red">否</span>';
		}else{
			return '是';
		}
	}
	function genderFormatter(val,rec){
		if(val=='1'){
			return '男';
		}else if(val='2'){
			return '女';
		}else{
			return '保密';	
		}
	}
	function sendStatusFormatter(val,rec){
		if(val=='1'){
			return '成功';
		}else if(val=='0'){
			return '失败';	
		}else{
			return '';
		}
	}
	function noOrYes(val,rec){ 
		if (val == '0'){ 
		    return '<span class="datagrid_font_red">否</span>'; 
		} else { 
			return '是'; 
		} 
	}
	
	function checkStatus(val,rec){ 
		if (val == '0'){ 
		    return '待审核'; 
		} else if (val == '1'){ 
			return '通过审核'; 
		}else if (val == '2'){ 
			return '审核驳回'; 
		}  
	}
	function authentication(val,rec){ 
		if (val == '0'){ 
		    return '未认证'; 
		}else if (val == '1'){ 
			return '认证通过'; 
		}else if (val == '2'){ 
			return "认证驳回"; 
		}else if (val == '3'){ 
			return '认证中'; 
		}   
	}

	function search() {
		getDatagrid('query');
	}
	
	function getDatagrid(type){
		setAutoHeight(240,"dgData"); 
		var url = '';
		if(type=='query'){
			url = '${pageContext.request.contextPath}/couponBatchRecord/batchRecordList';
		}
		$('#dgData').datagrid({
			url:url, 
			//pagination:true,//分页控件 
	        rownumbers:true,//行号 
	        emptyMsg:"无数据",
	        //pageList : [10,50,100],         // 可以设置每页记录条数的列表
	        //pageSize : 10 ,
	        onBeforeLoad: function(param){
 		    	$($('#fm').serializeArray()).each(function(){  
 		    		param[this.name]=this.value;  
 	            }); 
 			},
 			onLoadSuccess : function(data){
 				var data=$('#dgData').datagrid('getData'); 
 		        $('#numSpan').html(data.total);
 			},
 			onBeforeSelect:function(){
  				return false;
 			},
			columns : [ [ {
				field : 'customerid',
				checkbox : true,
			}, {
				field : 'mobile',
				title : '手机号',
				width:'10%',
				align : 'center'
			},  {
				field : 'name',
				title : '姓名',
				width:'10%',
				align : 'center'
			}, {
				field : 'gender',
				title : '性别',
				width:'10%',
				align : 'center',
				formatter:genderFormatter
			}, {
				field : 'regDate',
				title : '注册时间',
				width:'10%',
				align : 'center'
			}, {
				field : 'identityApprove',
				title : '认证状态',
				width:'10%',
				align : 'center',
				formatter:authentication
			},{
				field : 'memberType',
				title : '保证金状态',
				width:'10%',
				align : 'center',
				formatter:memberTypeYesOrNo
			}, {
				field : 'isCanOrder',
				title : '是否下单',
				align : 'center',
				width:'10%',
				formatter:function(value){
					if(value==0){
						return "<span class='datagrid_font_red'>否</span>";
					}
					if(value==1){
						return "<span style='color:black'>是</span>";
					}
				}
			}, {
				field : 'isDisable',
				title : '是否禁用',
				width:'10%',
				align : 'center',
				formatter:noOrYes
			}, {
				field : 'sendstatus',
				title : '发送状态',
				width:'10%',
				align : 'center',
				formatter:sendStatusFormatter
			} ,{
				field : 'sendtime',
				width:'12%',
				title : '发送时间',
				align : 'center'
			} ] ],
		});
		
		var pager = $('#dgData').datagrid('getPager');    // get the pager of datagrid
        pager.pagination({
        	pageSize:10,
        	pageList :  [10,50,100],
			displayMsg:'',
			links:5,
        	layout:['prev','links','next','list']
        });  
	}
	
	function beforeImportExcel(){
		$('#importForm').form('clear');
		$('#textfield3').val('点击选择Excel文件');
		$('#importWin').dialog('open').dialog('center');
		$('#importWin').window('open');
	}
	function importExcel() {
		var f= $("#excelFile").val();
		if(f.length == 0){
			$.messager.alert("操作提示", "请选择要导入的Excel文件", "");
			return false;
		}
		var imagePath = f.toLowerCase();
		if (!/\.(xls)$/.test(imagePath)) {
			$.messager.alert("操作提示", "Excel必须是2003格式", "");
			return false;
		}
			
		$("#importForm").form('submit', {
			url : '${pageContext.request.contextPath}/couponBatchRecord/importExcel',
			onSubmit : function() {
				$('#importWin').dialog('close');
				$.messager.progress();
			},
			success : function(result) {
				var result = $.parseJSON(result);   
				if (result.code != '10000') {
					$.messager.alert("操作提示", result.message, "");
				}else{
					$.messager.alert("操作提示", result.message, "");
					$('#numSpan').html(result.data.total);
					$("#dgData").datagrid('loadData',result.data);
				}
				$.messager.progress('close');
			}
		});
	}
	 
	 function sendCoupon(){
         var rows = $("#dgData").datagrid("getChecked");
         var ids = "";
         for (var i = 0; i < rows.length; i++) {
             var obj = rows[i];
             ids = ids + obj.customerid;
             if (i != rows.length - 1) {
                 ids = ids + ",";
             }
         }
         if(ids==''){
             $.messager.alert('操作提示','请加入用户并配置好优惠券再点击发送');
             return;
         }
         var packageId = $('#packageId').val();
         if(packageId==''){
             $.messager.alert('操作提示','请加入用户并配置好优惠券再点击发送');
             return;
         }
         $.post('${pageContext.request.contextPath}/couponBatchRecord/selectCouponPackageItemCount', {packageId:packageId}, function(result) {
				if (result==1) {
			         $.messager.confirm("提示", "请仔细核对信息，一旦确认无法撤回，确定发送吗？", function(flag) {
			 			if (flag) {
			 				$.messager.progress();
			 				$.post('${pageContext.request.contextPath}/couponBatchRecord/batchSendCoupon', {ids : ids,packageId:packageId}, function(result) {
								if (result.code == '100000') {
									$('#packageId').val('');
									$('#dg').datagrid('loadData',{total:0,rows:[]});
									$.messager.alert("操作提示","发送完成");
									$('#numSpan').html(result.data.total);
									$("#dgData").datagrid('loadData',result.data);
								} else {
									$.messager.alert("操作提示","发送失败");
								}
								$.messager.progress('close');
							}, 'json');
							$.messager.progress('close');
			 			}
			 		});
				} else if(result==0) {
					$.messager.alert('操作提示','请加入用户并配置好优惠券再点击发送');
		             return;
				}else{
					$.messager.alert("操作提示","操作失败，请稍后重试");
					return;
				}
			}, 'json');
         
     }
	 
	 function configCoupon(){
		 if($('#packageId').val()!=''){
			 $('#couponConfigWin').dialog('open').dialog('center');
				$('#couponConfigWin').window('open');  
		 }else{
			$.post('${pageContext.request.contextPath}/couponBatchRecord/getPackageId', {}, function(result) {
				if (result.code == '100000') {
					$('#packageId').val(result.data);
					$('#couponConfigWin').dialog('open').dialog('center');
					$('#couponConfigWin').window('open');
				} else {
					$.messager.alert("操作提示","操作失败");
				}
			}, 'json'); 
		 }
     }
</script>
</body>
</html>