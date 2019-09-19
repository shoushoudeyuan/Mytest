<%@ page language="java" pageEncoding="UTF-8" import="org.owasp.esapi.ESAPI"%><html>
<head>
<title>优惠卷添加</title>
<%@ include file="../common/header.jsp"%>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/couponmanage/couponpackagelist_page.js"></script>
</head>
<body>
	<div class="list_title">
		<span class="layui-parent-title-customer">HOME</span>
	    <span class="layui-badge-dot layui-bg-title"></span>
	    <span class="layui-children-title-customer">优惠券添加</span>
	    <a id="btnReturn" href='<%=ESAPI.encoder().encodeForHTML(request.getHeader("Referer"))%>' style="float: right; font-size: 28px;">返回上级</a>
	</div>

	<div class="table_data">
		<h4 class="table_data_title">
			优惠券添加
			<div class="text_input_bottom">
				<div class="text_input_button_add" id="text_input_button_left" onclick="couponPackage.openEdit()">添加</div>
				<div class="text_input_button_del" id="text_input_button_left" onclick="$('#dlgDel').dialog('open').dialog('center').dialog('setTitle', '提示');">删除</div>
			</div>
        </h4>
		
		<form id='fm_s' action="">
			<input type="hidden" id="packageId" name="packageId" value='${pageContext.request.getParameter("packageId")}' />
		</form>
        <!-- 数据表格 -->
		<table id="dg" style="width: 100%;"></table>
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
                            <select id="comboxCouponType" class="easyui-combobox" name="couponType" style="width: 200px;">
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
                                <input type="text" id="couponCount" class="easyui-numberbox" name="couponCount" data-options="required:true,prompt:' 请输入最少1张',min:1,precision:0"></input>
                        </div>
                    </div>
            </div>
        </form>
    </div>
    <div id="dlg-buttonsAdd" style="display:none;clear:both">
        <div class="text_input_button_cancel" onclick="$('#dlgCouponEdit').dialog('close')">取消</div>
        <div class="text_input_button_float" id="divAddItem" onclick="couponPackage.saveCouponPackageItem()">保存</div>
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
        <div class="text_input_button_float" id="divDeleteItem" onclick="couponPackage.deleteCouponPackageItem()">保存</div>
    </div>
</body>

</html>