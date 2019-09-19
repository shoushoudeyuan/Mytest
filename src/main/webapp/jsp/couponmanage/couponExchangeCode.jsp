<%@ page language="java" pageEncoding="UTF-8" import="org.owasp.esapi.ESAPI"%>
<html>

<div class="table_data">
    <form id='fm_s_excode' action="">
        <input type="hidden" name="activityId" value="<%=ESAPI.encoder().encodeForHTML(request.getParameter("activityId")) %>"/>
    </form>
	<!-- 数据表格 -->
	<table id="couponExCodeTable" style="width: 100%;height:450px;"></table>
</div>
	
<script>
    $(function(){
    	   //setAutoHeight(300,"couponExCodeTable"); 
           $('#couponExCodeTable').datagrid({
              url:'<%=request.getContextPath()%>/couponExchangeActivity/getCouponExchangeCodeList',
               rownumbers : true,
               fitColumns:true,
               columns : [[
                       {field : 'id',hidden : true,title : 'id'},
                       {field : 'code',title : '券码',width : '25%'}, 
                       {field : 'isExchanged',title : '兑换状态',width : '25%',formatter:function(val){
	                       	if(val =='1'){
	                       		return "未兑换";
	                       	}else if(val == '2'){
	                       		return "已兑换";
	                       	}
	                       	return val;
                       }}, 
                       {field : 'exchangeDate',title : '兑换日期',width : '25%',formatter:function(val){
                    	    if(val){
                    	    	return val;
                    	    }
                    	    return '-';
                       }},
                       {field : 'customerMobile',title : '用户手机号',width : '25%',formatter:function(val){
                           if(val){
                               return val;
                           }
                           return '-';
                      }}
               ]],
               pagination : true,
               pageSize : 10,
               pageList : [ 5, 10, 15, 20, 50 ],
               layout:['prev','links','next','list'],
               emptyMsg : '无数据',
               onBeforeLoad : function(param) {
                   $($('#fm_s_excode').serializeArray()).each(
                       function() {
                           param[this.name] = this.value;
                       }
                   );
               }
           });
           
           var pager = $('#couponExCodeTable').datagrid('getPager');    // get the pager of datagrid
           pager.pagination({
               pageSize:10,
               pageList: [10,50,100],
               displayMsg:'',
               links : 5,
               layout:['prev','links','next','list']
           });     
    	
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
	
</script>