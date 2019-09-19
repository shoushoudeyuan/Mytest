<%@ page language="java" pageEncoding="UTF-8"%><html>
<head>
<title>优惠卷配置</title>
<%@ include file="../common/header.jsp"%>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/couponmanage/useconfiglist_page.js?v=20180731"></script>
</head>
<body style="background-color: rgba(233, 236, 243, 1)">
	<div class="list_title">
		<span class="layui-parent-title-customer">HOME</span>
	    <span class="layui-badge-dot layui-bg-title"></span>
	    <span class="layui-children-title-customer">优惠券配置</span>
	</div>
<!-- 查询条件 -->
	<div class="text_input">
		<span class="div_search_customerBar"></span>
		<form id='fm_s' action="">
			<div class="form_item">
				<div class="form_item_inline">
					<label class="form_item_label4">配置名称</label>
					<div class="form_item_input">
						<input id="queryConfigName" name="queryConfigName" class="easyui-textbox"  />
					</div>
				</div>
				<div class="form_item_inline">
					<label class="form_item_label4">类型</label>
					<div class="form_item_input">
                            <select id="queryCouponType" name="queryCouponType" class="easyui-combobox">
                                <option value="">全部</option>
                                <option value="1">折扣券</option>
                                <option value="2">减免券</option>
                            </select>
					</div>
				</div>
				<div class="form_item_inline">
					<label class="form_item_label4">启用状态</label>
					<div class="form_item_input">
						<select id="queryIsValidate" name="queryIsValidate" class="easyui-combobox">
							<option value="">全部</option>
							<option value="1">启用</option>
							<option value="0">禁用</option>
						</select>
					</div>
				</div>
				<div class="form_item_inline">
					 <input type="button" class="text_input_button_search" value="查询" onclick="couponConfig.list.search()">
				</div>
			</div>
		</form>
	</div>

	<div class="table_data">
		<h4 class="table_data_title">
			优惠券配置
			<div class="text_input_bottom">
				<div class="text_input_button_add" id="text_input_button_left" onclick="couponConfig.createConfig()">添加</div>
				<div class="text_input_button_del" id="text_input_button_left" onclick="$('#dlgDel').dialog('open').dialog('center').dialog('setTitle', '提示');">删除</div>
			</div>
        </h4>
<!-- 数据表格 -->
		<table id="dg" class="easyui-datagrid" style="width: 100%;"></table>
	</div>
<!-- 新建页面 -->
    <div id="dlgAdd" class="easyui-dialog" style="width:800px; max-height:600px; display:none;" closed="true"	buttons="#dlg-buttonsAdd"  data-options="iconCls:'icon-save',closed:'true',collapsible:false,minimizable:false,maximizable:false,closable:true">
         <form id="fmAdd" method="post" style="padding:20px 10px 10px 30px">
	         <div class="model_form_item" >
	             <div class="model_form_item_inline">
	                 <label class="model_form_item_label7"><span class="mode_form_dot">*</span>优惠券类型</label>
	                 <div class="model_form_item_input">
	                         <select id="couponType" name="couponType" class="easyui-combobox" style="width: 200px;">
	                             <option value="1" >折扣券</option>
	                             <option value="2">减免券</option>
	                         </select>
	                 </div>
	             </div>
	             <div class="model_form_item_inline">
	                 <label class="model_form_item_label7"><span class="mode_form_dot">*</span>配置名称</label>
	                 <div class="model_form_item_input">
	                     <input type="text" id="configName" class="easyui-textbox" width="100%!important" data-options="required:true,prompt:'例如：10元券 限字符10个',validType:'maxLengthb'"></input>
	                 </div>
	             </div>
	         </div>
	         <div class="model_form_item discount">
	             <div class="model_form_item_inline">
                     <label class="model_form_item_label7"><span class="mode_form_dot">*</span>折扣(%)</label>
                     <div class="model_form_item_input">
                         <input type="text" id="discountPercent" class="easyui-numberbox" width="100%!important" data-options="required:true,min:0,max:99,precision:0,prompt:'例如“50”是5折的意思'"></input>
                     </div>
                 </div>
                 <div class="model_form_item_inline">
                     <label class="model_form_item_label7"><span class="mode_form_dot">*</span>最高减免</label>
                     <div class="model_form_item_input">
                         <input type="text" id="maxDeductionMoney" class="easyui-textbox" width="100%!important" data-options="required:true,prompt:'订单折扣的减免金额上限'"></input>
                     </div>
                 </div>
	         </div>
	         <div class="model_form_item discountDay">
	             <div class="model_form_item_inline">
	                 <label class="model_form_item_label7"><span class="mode_form_dot">*</span>有效天数</label>
	                 <div class="model_form_item_input">
	                     <input type="text" id="zkValidateDay" class="easyui-numberbox" width="100%!important" data-options="required:true,min:1,precision:0,prompt:'按天输入数字'"></input>
	                 </div>
	             </div>
	         </div>
	         <div class="model_form_item derate" style="display:none">
	             <div class="model_form_item_inline">
	                     <label class="model_form_item_label7"><span class="mode_form_dot">*</span>优惠券金额</label>
	                     <div class="model_form_item_input">
	                         <input type="text" id="couponMoney" class="easyui-textbox" width="100%!important" data-options="required:true,prompt:'订单折扣的减免金额上限'"></input>
	                     </div>
	                 </div>
	                 <div class="model_form_item_inline">
	                     <label class="model_form_item_label7"><span class="mode_form_dot">*</span>有效天数</label>
	                     <div class="model_form_item_input">
	                         <input type="text" id="mjValidateDay" class="easyui-numberbox" width="100%!important" data-options="required:true,min:0,precision:0,prompt:' 按天输入数字'"></input>
	                     </div>
	                 </div>
	         </div>
	             
             <div class="model_form_item">
                 <div class="model_form_item_inline">
                     <div class="model_form_item_input" style="font-size:14px;padding-left:14px">
                         <input id="ckExUseConfig" type="checkbox" class="model_form_item_checkbox" data-options="required:true"></input> 配置规则生效
                     </div>
                     <span class="mode_form_dot" style="margin-left:-50px">（打钩生效， 打钩后至少选择一项个性化配置，不打钩则该券为通用券）</span>
                 </div>
             </div>
             <div id="divExUseConfig" disabled>
	             <h4 style="border-bottom:1px solid #eee;margin-bottom:20px"></h4>
	             <div class="model_form_item">
	                 <div class="model_form_item_block">
	                     <label class="model_form_item_label8">选择可使用地区：</label>
	                     <div id="divServiceCity" class="model_form_item_input" style="font-size:14px">
	                     </div>
	                 </div>
	             </div>
	             <div class="model_form_item">
	                     <div class="model_form_item_block">
	                         <label class="model_form_item_label8">选择周时间限制：</label>
	                         <div class="model_form_item_input" style="font-size:14px">
	                             <input type="checkbox" name = "weekDay" value="1" class="model_form_item_checkbox"></input>周一
	                             <input type="checkbox" name = "weekDay" value="2" class="model_form_item_checkbox model_form_item_checkbox_left"></input>周二
	                             <input type="checkbox" name = "weekDay" value="3" class="model_form_item_checkbox model_form_item_checkbox_left"></input>周三
	                             <input type="checkbox" name = "weekDay" value="4" class="model_form_item_checkbox model_form_item_checkbox_left"></input>周四
	                             <input type="checkbox" name = "weekDay" value="5" class="model_form_item_checkbox model_form_item_checkbox_left"></input>周五
	                             <input type="checkbox" name = "weekDay" value="6" class="model_form_item_checkbox model_form_item_checkbox_left"></input>周六
	                             <input type="checkbox" name = "weekDay" value="7" class="model_form_item_checkbox model_form_item_checkbox_left"></input>周日
	                          
	                         </div>
	                     </div>
	             </div>
	             <div class="model_form_item">
	                 <div class="model_form_item_inline">
	                     <label class="model_form_item_label8">选择可使用时段：</label>
	                     <div class="model_form_item_input" style="font-size:14px">
	                             <input id="useLowerTime" type="text" class="time_input"/>
	                         
	                     </div>
	                     <label class="model_form_item_label1">-</label>
	                     <div class="model_form_item_input" style="font-size:14px">
	                             <input id="useUpperTime" type="text"  class="time_input"/>
	                     </div>
	                 </div>
	             </div>
	             
	             <div class="model_form_item">
	                 <div class="model_form_item_inline">
	                     <label class="model_form_item_label8">单个订单费用满：</label>
	                     <div class="model_form_item_input" style="font-size:14px">
	                         <input  type="text" id="baseOrderMoney"  class="easyui-textbox" />
	                     </div>
	                     <label class="model_form_item_label6" style="padding-left:0">元，可使用;</label>
	                  
	                 </div>
	             </div>
	             <div class="model_form_item">
	                 <div class="model_form_item_block" style="float:left">
	                     <label class="model_form_item_label8">选择可使用车型：</label>
	                     <div id="divCarMode" class="model_form_item_input" style="font-size:14px;border:1px solid #eee;width:550px;min-height:50px">
	                     </div> 
	                 </div>
	             </div>
	             <div class="model_form_item">
	                 <div class="model_form_item_block" style="float:left">
	                     <label class="model_form_item_label8">APP显示详情文案：</label>
	                     <div class="model_form_item_input" style="font-size:14px;border:0px solid #eee;width:545px;min-height:50px">
	                             <textarea id="appDiscription" class="model_form_item_textarea" style="width:100%;height:100%;background:#fff;border:1px solid #eee;padding:none" placeholder="请输入优惠券的详细文案，在APP优惠券显示；并且支持换行显示"></textarea>
	                     </div>      
	                 </div>
	             </div>

	            <div class="form_item">
	                <div class="form_item_inline">
	                    <label class="model_form_item_label7"><span class="mode_form_dot">*</span>启用状态</label>
	                    <div class="model_form_item_input">
	                            <input type="radio" name="isdisable" value='1' checked='checked' />启用 
	                            <input type="radio" name="isdisable" value="0" />禁用
	                    </div>
	                </div>
	            </div>
			</div>
        </form>
     </div>
     <div id="dlg-buttonsAdd" style="display:none;clear:both">
         <div class="text_input_button_cancel" onclick="couponConfig.closeNewConfig()">取消</div>
         <div class="text_input_button_float" id="divAddConfig" onclick="couponConfig.saveNewConfig()">保存</div>
     </div>
     <!-- 删除优惠券 -->
     <div id="dlgDel" class="easyui-dialog" style="width:400px; max-height:600px; display:none;" closed="true"	buttons="#dlg-buttonsDel"  data-options="iconCls:'icon-save',closed:'true',collapsible:false,minimizable:false,maximizable:false,closable:true">
         <div style="height:100px;background:url(../../img/warn.png) no-repeat 40px center">
             <p style="width:210px;margin-left:130px;padding-top:30px">
                     删除优惠券模板后，凡是使用此优惠券的规则不再生效，已发放给用户的优惠券不受影响
             </p>
         </div>
     </div>
      <div id="dlg-buttonsDel" style="display:none;clear:both">
         <div class="text_input_button_cancel" onclick="$('#dlgDel').window('close');">取消</div>
         <div class="text_input_button_float" id="divDeleteConfig"  onclick="couponConfig.deleteConfig()">保存</div>
     </div>
     <!-- 编辑 -->
     <div id="dlgEdit" class="easyui-dialog" style="width:400px; max-height:600px; display:none;" closed="true"	buttons="#dlg-buttonsEdits"  data-options="iconCls:'icon-save',closed:'true',collapsible:false,minimizable:false,maximizable:false,closable:true">
         <div class="form_item_inline" style="width:90%;height:100px;line-height:100px">
             <label class="model_form_item_label5"></label>
             <div class="model_form_item_input" >
             	<input type="hidden" id="selectedId" value="" />
             	<input type="hidden" id="csrftoken" value="<%=session.getAttribute("csrftoken").toString()%>"/>
                <input type="radio" name="isValidate" value='1' checked='checked' />启用 
                <input type="radio" name="isValidate" value="0" style="margin-left:50px"/>禁用
             </div>
         </div>
     </div>
     <div id="dlg-buttonsEdits" style="display:none;clear:both">
         <div class="text_input_button_cancel" onclick="javascript:$('#dlgEdit').window('close');">取消</div>
         <div class="text_input_button_float" onclick="couponConfig.setValidate();">保存</div>
     </div>
         
     
</body>
</html>