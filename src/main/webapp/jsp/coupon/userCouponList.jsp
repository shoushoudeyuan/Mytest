<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html>
<head>
<title>优惠券列表</title>
<%@ include file="../common/header.jsp"%>
<style type="text/css">
body {
	height: 100%;
	overflow: hidden;
	margin: 0px;
	padding: 0px;
}
</style>

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
					<label class="form_item_label5">优惠券编号</label>
					<div class="form_item_input">
						<input name="couponNumber" class="easyui-textbox" style="width: 100px" />
					</div>
				</div>
				<div class="form_item_inline">
					<label class="form_item_label3">手机号</label>
					<div class="form_item_input">
						<input name="customerTel" class="easyui-textbox" style="width: 100px" />
					</div>
				</div>
				<div class="form_item_inline">
					<label class="form_item_label4">使用状态</label>
					<div class="form_item_input">
						<select
							id="useStatus" name="useStatus" class="easyui-combobox"
							style="width: 6%;">
							<option value="">全部</option>
							<option value="1">已用</option>
							<option value="0">未用</option>
						</select>
					</div>
				</div>
				<div class="form_item_inline">
					<label class="form_item_label4">第三方</label>
					<div class="form_item_input">
						<select id="thirdParty" name="thirdParty"
							class="easyui-combobox" style="width: 6%;">
							<option value="">全部</option>
							<option value="1">是</option>
							<option value="0">否</option>
						</select>
					</div>
				</div>
				<div class="form_item_inline">
					 <input type="button" onclick="search()" class="text_input_button_search" value="查询">
				</div>
			
			</div>
			<div class="form_item form_item_hidden">
				<div class="form_item_inline">
					<label class="form_item_label5">第三方名称</label>
					<div class="form_item_input">
						<input name="thirdPartyName" class="easyui-textbox"
							style="width: 100px">
						</select> 
					</div>
				</div>
				<div class="form_item_inline">
					<label class="form_item_label3">来源</label>
					<div class="form_item_input">
						<select id="fromenum" name="fromenum" class="easyui-combobox" style="width: 6%;">
							<option value="">全部</option>
							<option value="0">注册</option>
							<option value="1">邀请码赠送</option>
							<option value="2">积分兑换</option>
							<option value="3">活动红包兑换</option>
							<option value="4">共享计划赠送</option>
							<option value="5">满额送</option>
							<option value="6">节假日送</option>
							<option value="7">首次结单送</option>
							<option value="8">首次推荐送</option>
							<option value="10">渠道码赠送</option>
							<option value="99">系统录入</option>
						</select>
					</div>
				</div>
				<div class="form_item_inline">
					<label class=" form_item_label4">开始时间</label>
					<div class="form_item_input">
						<input id="startTime" type="text" name="startTime" class="easyui-datetimebox" />
					</div>
				</div>
				<div class="form_item_inline">
					<label class=" form_item_label4">结束时间</label>
					<div class="form_item_input">
						<input id="endTime" type="text" name="endTime" class="easyui-datetimebox" />
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
			优惠券列表
			<div class="text_input_bottom">
				<div class="text_input_button_del" id="text_input_button_left"
					onclick="destroyCoupon();">删除</div>
				<div class="text_input_button_excl" onclick = "btnExport()" id="btnExport">导出</div>	
			</div>
		</h4>
		<table id="dgCSCouponList" style="width: 100%;"></table>
	</div>
	

	<div id="divCoupon" class="easyui-window"
		data-options="iconCls:'icon-save',closed:'true',collapsible:false,minimizable:false,maximizable:false,closable:true"
		style="width: 500px; height: 450px; padding: 10px;">优惠卷信息</div>
	<div id="divLotCoupon" class="easyui-window"
		data-options="iconCls:'icon-save',closed:'true',collapsible:false,minimizable:false,maximizable:false,closable:true"
		style="width: 500px; height: 450px; padding: 10px;">优惠卷信息</div>
	

	<script type="text/javascript">
	Date.prototype.format = function(fmt) { 
	    var o = { 
	       "M+" : this.getMonth()+1,                 //月份 
	       "d+" : this.getDate(),                    //日 
	       "h+" : this.getHours(),                   //小时 
	       "m+" : this.getMinutes(),                 //分 
	       "s+" : this.getSeconds(),                 //秒 
	       "q+" : Math.floor((this.getMonth()+3)/3), //季度 
	       "S"  : this.getMilliseconds()             //毫秒 
	   }; 
	   if(/(y+)/.test(fmt)) {
	           fmt=fmt.replace(RegExp.$1, (this.getFullYear()+"").substr(4 - RegExp.$1.length)); 
	   }
	    for(var k in o) {
	       if(new RegExp("("+ k +")").test(fmt)){
	            fmt = fmt.replace(RegExp.$1, (RegExp.$1.length==1) ? (o[k]) : (("00"+ o[k]).substr((""+ o[k]).length)));
	        }
	    }
	   return fmt; 
	} 
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
	   $(function($) {
		   setAutoHeight(300,"dgCSCouponList"); 
	    	 $('#dgCSCouponList').datagrid({
	 			url:'<%=request.getContextPath()%>/couponCustomer/customerCouponList',
								toolbar : $('#toolbar'),
								rownumbers : true,
								columns : [ [
										{
											field : 'ck',
											checkbox:true,
											id:'ck'
										},
										{
											field : 'id',
											hidden : true,
											title : 'id'
										},
										{
											field : 'action',
											title : '操作',
											width : '8%',
											formatter : function(value, rec) { //格式化函数添加一个操作列
												var btn = '<a style="" class="radiuBtn" href="#" onclick="javascript:editCoupon(' + rec.id + ')">编辑</a>';
												return btn;
											}
										}, {
											field : 'couponcode',
											title : '优惠券编号',
											width : '15%',
										}, {
											field : 'orderno',
											title : '订单编号',
											width : '15%'
										},{
											field : 'remark',
											title : '备注',
											width : '20%'
										}, {
											field : 'thirdpartyname',
											title : '第三方名称',
											width : '10%'
										} ,{
											field : 'type',
											title : '优惠券类型',
											width : '10%',
											formatter : function(value, rec) { 
												if (rec.type == 1) {
													return "折扣券";
												} else if(rec.type == 0) {
													return "减免券";
												}
											}
										} ,
										{
											field : 'couponmoney',
											title : '优惠券金额',
											width : '10%'
										} ,
										{
											field : 'discount',
											title : '折扣比例',
											width : '10%',
											formatter : function(value, rec) { 
												   if(rec.discount == null){
													   return "";
												   }else{
													   return rec.discount+"%";   
												   }
													
											}
										} ,{
											field : 'topDiscountMoney',
											title : '最高减免',
											width : '10%'
										} , {
											field : 'isdisable',
											title : '是否启用',
											width : '8%',
											formatter : function(value, rec) { //格式化函数添加一个操作列
												if (rec.isdisable == 1) {
													return "启用";
												} else {
													return "禁用";
												}
											}
										} , {
											field : 'usestatus',
											title : '是否使用',
											width : '8%',
											formatter : function(value, rec) { //格式化函数添加一个操作列
												if (rec.usestatus == 1) {
													return "已用";
												} else {
													return "未用";
												}
											}
										}, {
											field : 'fromenum',
											title : '来源',
											width : '10%',
											formatter : function(value, rec) { //格式化函数添加一个操作列
												if (rec.fromenum == 0) {
													return "注册";
												} else if (rec.fromenum == 1) {
													return "邀请码赠送";
												} else if (rec.fromenum == 2) {
													return "积分兑换";
												} else if (rec.fromenum == 3){
													return "活动红包兑换";
												} else if (rec.fromenum == 4){
													return "共享计划赠送";
												} else if (rec.fromenum == 5){
													return "满额送";
												} else if (rec.fromenum == 6){
													return "节假日送";
												} else if (rec.fromenum == 7){
													return "首次结单送";
												} else if (rec.fromenum == 8){
													return "首次推荐送";
												}  else if (rec.fromenum == 10) {
													return "渠道码赠送";
												}else{
													return "系统录入";
												}
											}
										} , {
											field : 'mobile',
											title : '手机号',
											width : '10%'
										} , {
											field : 'createdate',
											title : '生成日期',
											width : '15%'
										} , {
											field : 'startdate',
											title : '生效日期',
											width : '15%',
											formatter : function(value, rec) { //格式化函数添加一个操作列
												var startdate = new Date(rec.startdate)
												return startdate.format('yyyy-MM-dd');
											}
										} , {
											field : 'enddate',
											title : '失效日期',
											width : '15%',
											formatter : function(value, rec) { //格式化函数添加一个操作列
												var enddate = new Date(rec.enddate)
												return enddate.format('yyyy-MM-dd');
											}
										} , {
											field : 'usingdate',
											title : '使用时间',
											width : '15%'
										}  ] ],
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
	    	 
	    	 var pager = $('#dgCSCouponList').datagrid('getPager');    // get the pager of datagrid
	            pager.pagination({
	            	pageSize:10,
	            	pageList: [10,50,100],
					displayMsg:'',
					links : 5,
	            	layout:['prev','links','next','list']
	            });     
		});

		function search() {
			$('#dgCSCouponList').datagrid('load');
		}	
		
		 function newCoupon(){
		    	$('#divCoupon').window({href:'<%=request.getContextPath()%>/jsp/coupon/updateCoupon.jsp'})
		    	.window('setTitle','新增优惠券')
		    	.window('open');//
		    }
		 
		 function newLotCoupon(){
		    	$('#divLotCoupon').window({href:'<%=request.getContextPath()%>/jsp/coupon/updateLotCoupon.jsp'})
		    	.window('setTitle','批量新增优惠券')
		    	.window('open');//
		    }
		 
		 function editCoupon(id){		    	
		    	$('#divCoupon').window({href:'<%=request.getContextPath()%>/jsp/coupon/updateCoupon.jsp?couponId='
										+ id
							}).window('setTitle', '修改优惠券').window('open');//
		}
		 
		    function destroyCoupon(){
		    	var path = '<%=request.getContextPath()%>/couponCustomer/deleteCoupon';
			var rows = $('#dgCSCouponList').datagrid('getChecked');

			if (rows.length > 0) {
				$.messager.confirm('警告', '确定要删除优惠券么?', function(yes) {
					if (yes) {

						var ids = '';
						for (var i = 0; i < rows.length; i++) {
							ids += rows[i].id + ',';
						}
						ids = ids.substring(0, ids.length - 1);

						$.post(path, {
							ids : ids
						}, function(result) {
							if (result == 1) {
								$('#dgCSCouponList').datagrid('reload'); // reload the user data
							} else {
								$.messager.show({ // show error message
									title : 'Error',
									msg : '删除失败'
								});
							}
						}, 'json');
					}
				});
			} else {
				$.messager.alert('操作提示', '至少选择一条记录!');
			}
		}
		    
	    function btnExport(){
			var queryParam = getFormJson($("#fm_s")[0]);
			var url = "<%=request.getContextPath()%>/couponCustomer/exportCouponList?"+$.param(queryParam);
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