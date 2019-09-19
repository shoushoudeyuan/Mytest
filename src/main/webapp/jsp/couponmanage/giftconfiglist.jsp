<%@ page language="java" pageEncoding="UTF-8"%><html>
<head>
<title>优惠券规则</title>
<%@ include file="../common/header.jsp"%>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/couponmanage/giftconfiglist_page.js"></script>
</head>
<body style="background-color: rgba(233, 236, 243, 1)">
	<div class="list_title">
		<span class="layui-parent-title-customer">HOME</span>
	    <span class="layui-badge-dot layui-bg-title"></span>
	    <span class="layui-children-title-customer">优惠券规则</span>
	</div>
	<div class="text_input">
		<span class="div_search_customerBar"></span>
		<form id='fm_s' action="">
			<div class="form_item">
				<div class="form_item_inline">
					<label class="form_item_label2">名称</label>
					<div class="form_item_input">
						<input id="couponRuleName" name="couponRuleName" class="easyui-textbox"  />
					</div>
				</div>
				<div class="form_item_inline">
					 <input type="button"  class="text_input_button_search" value="查询" onclick="giftConfig.list.search()">
				</div>
			</div>
		</form>
	</div>

	<div class="table_data">
		<h4 class="table_data_title">
            优惠券规则
        </h4>
        <!-- 数据表格 -->
		<table id="dg" style="width: 100%;"></table>
	</div>
	
	<!-- 用户注册赠对话框 -->
	<div id="dlgRegister" class="easyui-dialog" style="width:600px; max-height:600px;height:600px; display:none;" closed="true" data-options="iconCls:'icon-save',closed:'true',collapsible:false,minimizable:false,maximizable:false,closable:true"></div>
	<!-- 邀请好友赠对话框 -->
	<div id="dlgInvite" class="easyui-dialog" style="width:600px; max-height:700px;height:650px; display:none;" closed="true" data-options="iconCls:'icon-save',closed:'true',collapsible:false,minimizable:false,maximizable:false,closable:true"></div>	
	<!-- 订单满额赠对话框 --> 
	<div id="dlgOrder" class="easyui-dialog" style="width:600px; max-height:600px; height:600px; display:none;" closed="true" data-options="iconCls:'icon-save',closed:'true',collapsible:false,minimizable:false,maximizable:false,closable:true"></div>
	<!-- 首次用车结单赠对话框 -->
	<div id="dlgFirstOrder" class="easyui-dialog" style="width:600px; max-height:600px; height:600px; display:none;" closed="true" data-options="iconCls:'icon-save',closed:'true',collapsible:false,minimizable:false,maximizable:false,closable:true"></div>
	<!-- 首次成为企业会员赠 -->
	<div id="dlgRegisterMember" class="easyui-dialog" style="width:600px; max-height:600px; height:600px; display:none;" closed="true" data-options="iconCls:'icon-save',closed:'true',collapsible:false,minimizable:false,maximizable:false,closable:true"></div>
	<!-- 企业会员按时间赠 -->
	<div id="dlgEntMember" class="easyui-dialog" style="width:600px; max-height:600px; height:600px; display:none;" closed="true" data-options="iconCls:'icon-save',closed:'true',collapsible:false,minimizable:false,maximizable:false,closable:true"></div>
</body>
</html>