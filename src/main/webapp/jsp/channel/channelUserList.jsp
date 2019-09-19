<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="../common/header.jsp"%>
<title>渠道人员</title>
<script type="text/javascript">
			
	$(function() {
		var channelCode = '${param.channelCode}'
		if (channelCode) {
			$("#channelCode").val(channelCode);
		}
		setAutoHeight(270,"dg");   
		
		$('#dg').datagrid({
			url:'${pageContext.request.contextPath}/channel/channelUserList', 
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
			columns : [ [{
				field : 'userName',
				title : '手机号码',
				width : '20%',
				align : 'center'
			}, {
				field : 'name',
				title : '真实姓名',
				width : '15%',
				align : 'center'
			}, {
				field : 'registerDate',
				title : ' 注册时间',
				width : '20%',
				align : 'center'
			}, {
				field : 'loginDate',
				title : '登录时间',
				width : '20%',
				align : 'center'
			},{
				field : 'isApprove',
				title : '身份认证',
				width : '20%',
				align : 'center',
				formatter: function(value, row, index) {
					if (value == 1) {
						return "<font color='green'>是</font>";
					} else {
						return "<font color='red'>否</font>";
					}
				}
			}, {
				field : 'isMember',
				title : '缴纳保证金',
				width : '20%',
				align : 'center',
				formatter: function(value, row, index) {
					if (value == 1) {
						return "<font color='green'>是</font>";
					} else {
						return "<font color='red'>否</font>";
					}
				}
			},{
				field : 'isOrder',
				title : '是否下单',
				width : '20%',
				align : 'center',
				formatter: function(value, row, index) {
					if (value == 0) {
						return "<font color='green'>是</font>";
					} else {
						return "<font color='red'>否</font>";
					}
				}
			}]],
		});
		
		 var pager = $('#dg').datagrid('getPager');
	        pager.pagination({
	        	pageSize:10,
	        	pageList : [10,50,100],
				displayMsg:'',
				links:5,
	        	layout:['prev','links','next','list']
	     }); 
	});
	
	function search(){
        $('#dg').datagrid('load');
    }
	
	function exportExcel() {
		var queryParam = getFormJson($("#fm_s")[0]);
		var url = "<%=request.getContextPath()%>/channel/exportChannelUser?"+$.param(queryParam);
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
</head>
<body>
    <div class="list_title">
        <span class="layui-parent-title-customer">HOME</span>
        <span class="layui-badge-dot layui-bg-title"></span>
        <span class="layui-children-title-customer">渠道统计</span>
        <a id="btnReturn" href="<%=request.getContextPath()%>/jsp/channel/channelList.jsp"
                style="float: right; font-size: 28px;">返回上级</a>
    </div>
    <div class="text_input">
        <span class="div_search_customerBar"></span>
        <form id='fm_s' action="">
        	<div class="form_item">
        		<div class="form_item_inline">
        			<label class="form_item_label4">注册时间</label>
        			<div class="form_item_input">
        				<input id="registerStartDate" type="text" name="registerStartDate" class="easyui-datetimebox" style="width: 170px;" />
        			</div>
        			<label class="form_item_label1">-</label>
        			<div class="form_item_input">
        				<input id="registerEndDate" type="text" name="registerEndDate" class="easyui-datetimebox" style="width: 170px;"/>
        			</div>
        		</div>
        		<div class="form_item_inline">
        			<label class="form_item_label4">身份认证</label>
        			<div class="form_item_input">
	        			<select name="isApprove" class="easyui-combobox" style="width: 100px">
		                     <option value="">全部</option>
		                     <option value="0">否</option>
		                     <option value="1">是</option>
		                </select>
        			</div>
        		</div>
        		<div class="form_item_inline">
        			<label class="form_item_label5">缴纳保证金</label>
        			<div class="form_item_input">
	        			<select name="isMember" class="easyui-combobox" style="width: 100px">
		                     <option value="">全部</option>
		                     <option value="0">否</option>
		                     <option value="1">是</option>
		                </select>
        			</div>
        		</div>
        		<div class="form_item_inline">
        			    <input type="hidden" name="channelCode" id="channelCode" /> 
                		<input type="button" onclick="search()" class="text_input_button_search" value="查询">
        		</div>
        	</div>
        	<div class="form_item form_item_hidden">
        		<div class="form_item_inline">
        			<label class="form_item_label4">是否下单</label>
        			<div class="form_item_input">
	        			<select name="isCanOrder" class="easyui-combobox" style="width: 100px">
		                     <option value="">全部</option>
		                     <option value="0">否</option>
		                     <option value="1">是</option>
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
        <h4 class="table_data_title"> 渠道统计
        <div class="text_input_bottom">
            <input type="button" onclick="exportExcel()" class="text_input_button text_input_button_right" value="导出">
        </div>
        </h4>
        <table id="dg"></table> 
    </div>
    <script>
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
    </script>
</body>
</html>