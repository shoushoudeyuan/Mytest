<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="../common/header.jsp"%>
<title>推广人员</title>
<script type="text/javascript" src="../../js/util/extendValidate.js"></script>
<script type="text/javascript">
			
	$(function() {
		setAutoHeight(270,"dg");   
		$('#dg').datagrid({
			url:'${pageContext.request.contextPath}/promotionPerson/performanceList', 
			pagination:true,//分页控件 
	        rownumbers:true,//行号 
	        pageSize:10,
        	pageList :  [10,50,100],
        	emptyMsg:'无数据',
	        onBeforeLoad: function(param){
 		    	$($('#fm_s').serializeArray()).each(function(){  
 		    		param[this.name]=this.value;  
 	            }); 
 			},
 			onBeforeSelect:function(){
  				return false;
  			}
			
		});
		$('#dg').datagrid({
			columns : [ [ {
				field : 'orderNo',
				title : '订单号',
				width : '20%',
				align : 'center'
			}, {
				field : 'userName',
				title : '用户名',
				width : '10%',
				align : 'center'
			}, {
				field : 'name',
				title : '姓名',
				width : '10%',
				align : 'center'
			}, {
				field : 'actualPaymentCost',
				title : '订单实付金额',
				width : '12%',
				align : 'center'
			}, {
				field : 'pushPercent',
				title : '提成百分比',
				width : '10%',
				align : 'center',
				formatter:per
			}, {
				field : 'pushMoney',
				title : '提成金额',
				width : '10%',
				align : 'center'
			}, {
				field : 'finishDate',
				title : '订单完成时间',
				width : '20%',
				align : 'center'
			}, {
				field : 'startDays',
				title : '绩效周期起始日',
				width : '15%',
				align : 'center'
			}, {
				field : 'endDays',
				title : '绩效周期截止日',
				width : '15%',
				align : 'center'
			}] ],
		});
		
		
		 $.extend($.fn.validatebox.defaults.rules, {
		        /*必须和某个字段相等*/
		        equalTo: { validator: function (value, param) { return $(param[0]).val() == value; }, message: '字段不匹配' }
		       });
		
		
		 var pager = $('#dg').datagrid('getPager');    // get the pager of datagrid
	        pager.pagination({
	        	pageSize:10,
	        	pageList :  [10,50,100],
				displayMsg:'',
				links:5,
	        	layout:['prev','links','next','list']
	        }); 
		 
	   
	});
	
	
	
	function per(val,rec){ 
		return val+'%';
	}
	function getExcel()
	{
		var url = '${pageContext.request.contextPath}/promotionPerson/performanceExcelList';
		$('#fm_s').form('submit', {
			url : url,
			onSubmit : function() {
				//return $(this).form('validate');
			},
			success : function(result) {

				//alert(result);
			}
		});
		
	}
	
	function search(){
        $('#dg').datagrid('load');
    }
	
	
</script>
</head>
<body>
<div class="list_title">
        <span class="layui-parent-title-customer">HOME</span>
        <span class="layui-badge-dot layui-bg-title"></span>
        <span class="layui-children-title-customer">绩效成绩</span>
        <a id="btnReturn" href="javascript:history.go(-1)" style="float: right; font-size: 28px;">返回上级</a>
    </div>
    <div class="text_input">
        <span class="div_search_customerBar"></span>
        <form id='fm_s' action="">
        	<div class="form_item">
        		<div class="form_item_inline">
        			<label class="form_item_label4">完成日期</label>
        			<div class="form_item_input">
        				<input name="startDate" class="easyui-datebox" style="width:100px">
        			</div>
        			<label class="form_item_label1">-</label>
        			<div class="form_item_input">
        				 <input name="endDate" class="easyui-datebox" style="width:100px">
        				 <input type="hidden" name = "invitationCode" value = "${param.invitationCode}"/> 
        			</div>
        		</div>
        		<div class="form_item_inline">
        			  
                        <input type="button" onclick="search()" class="text_input_button_search" value="查询">
        		</div>
        	</div>
        </form> 
    </div>
    <div class="table_data">
        <h4 class="table_data_title"> 绩效成绩
        <div class="text_input_bottom">
            <div class="text_input_button" id="text_input_button_left" onclick="getExcel()">导出</div>
        </div>
        </h4>
        <table id="dg"></table>  
    </div>
	   
</div>
</body>
</html>