<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html>
  <head>
  	
    <title>车辆日志</title>
  </head>
<body>
        <div class="text_input">
            <span class="div_search_customerBar"></span>
	    	<form id='fm_s' action="">
	    		<div class="form_item">
	    			<div class="form_item_inline">
	    				<label class="form_item_label4">角色类型</label>
	    				<div class="form_item_input">
	    					<select name="sourceType" class="easyui-combobox" style="width: 100px">
			               	 	<option value="0" selected="selected">驾客人员</option>
			               	 	<option value="1">后台管理</option>
			               	 	<option value="2">车管人员</option>
			               	 </select>
	    				</div>
	    			</div>
	    			<div class="form_item_inline">
	    				<label class="form_item_label4">操作类型</label>
	    				<div class="form_item_input">
		    				<select name="opType" class="easyui-combobox" style="width: 100px">
		               	 	<option value="">全部</option>
		               	 	<option value="7">开锁</option>
		               	 	<option value="1">开锁通电</option>
		               	 	<option value="8">锁门</option>
		               	 	<option value="2">锁门断电</option>
		               	 	<option value="3">还车</option>
		               	 	<option value="4">鸣笛</option>
		               	 	<option value="5">恢复供电</option>
		               	 	<option value="6">强制结单</option>
		               	 	<option value="9">蓝牙开锁</option>
		               	 	<option value="10">蓝牙锁门</option>
		               	 	<option value="11">还车范围判断</option>
			               	 </select>
	    				</div>
	    			</div>
	    			<div class="form_item_inline">
	    				<label class="form_item_label3">订单号</label>
	    				<div class="form_item_input">
		    				<input name="orderNo" class="easyui-textbox" style="width:100px" >
	    				</div>
	    			</div>
	    			<div class="form_item_inline">
	    				<label class="form_item_label3">车牌号</label>
	    				<div class="form_item_input">
		    				<input name="plateNumber" class="easyui-textbox" style="width:100px">
	    				</div>
	    			</div>
	    			<div class="form_item_inline">
	    				 <input type="button" class="text_input_button_search" onclick="search()" value="查询">
	    			</div>
	    		</div>
	    	</form>	
	    </div>
	    
     <div class="table_data">
     	<h4 class="table_data_title">车辆日志</h4>
        <table id="dg"  style="width:100%;"></table>
    </div>
    
    <script type="text/javascript">
    
    $(function($) {
    	setAutoHeight(300,"dg"); 
    	/* $("#dg").height($("#dg").parent().height()-60); */
    	 $('#dg').datagrid({
 			url:'/bjyvms/operateLog/logListAction',
 			toolbar:$('#toolbar'),
 			rownumbers:true,
 			emptyMsg:'无数据',
 		    columns:[[
 				
 				{field:'id',hidden:true,title:'id'},
 		        {field:'cusName',title:'操作人',width:'10%'},
 		        {field:'orderNo',title:'订单号',width:'15%'},
 		        {field:'plateNumber',title:'车牌号',width:'15%'},
 		        {field:'operatetype',title:'操作类型',width:'15%',formatter:formatType},
 		        {field:'createdate',title:'创建日期',width:'15%'},
 		        {field:'operateresult',title:'操作结果',width:'15%',formatter:formatStatus},
                {field:'resultContent',title:'失败原因',width:'25%',formatter:function(val,row){
                	//强制结单
                    if('6' == row.operatetype){
                        return val;
                    }
                	if(val && val.indexOf('刷新操作')>0){
                		if('1' == row.operateresult){
	                           return val;
	                    } 
                	}else{
	                	if('1' == row.operateresult || '27' == row.operateresult ||'28' == row.operateresult ||'29' == row.operateresult){
	                           return '';
	                    } 
                	}
                    return val;
               }}
 		    ]],
 		    pagination:true,
 		    pageSize: 10,
 		    onBeforeLoad: function(param){
 		    	$($('#fm_s').serializeArray()).each(function(){  
 		    		param[this.name]=this.value;  
 	            }); 
 			},
 			onBeforeSelect:function(){
 				return false;
 			}
 		});
    	 
    	 var pager = $('#dg').datagrid('getPager');    // get the pager of datagrid
         pager.pagination({
         	pageSize:10,
         	pageList: [10,50,100],
			displayMsg:'',
         	layout:['prev','links','next','list']
         }); 
    	 
    });
    function formatType(val,row){
    	var type = "";
        if(row.logsource=='1'){
        	if(val=='1'){
	        	type = "开锁(蓝牙)";
	        }else if(val=='2'){
	        	type = "锁门(蓝牙)";
	        }else if(val=='4'){
	        	type = "鸣笛(蓝牙)";
	        }
        }else{
	        if(val=='1'){
	        	type = "开锁通电";
	        }else if(val=='2'){
	        	type = "锁门断电";
	        }else if(val=='3'){
	        	type = "还车";
	        }else if(val=='4'){
	        	type = "鸣笛";
	        }else if(val=='5'){
	        	type = "恢复供电";
	        }else if(val=='6'){
	        	type = "强制结单";
	        }else if(val=='7'){
	        	type = "开锁";
	        }else if(val=='8'){
	        	type = "锁门";
	        }else if(val=='11'){
	        	type = "还车范围判断";
	        }
        }
        return type;
    }
	function formatStatus(val,row){
	    var temp ='失败';
		if('1' == val || '27' == val ||'28' == val ||'29' == val  ){
			temp = '成功';
		}
		return temp;
	}
    
    function search(){
        $('#dg').datagrid('reload');
    }
    
    </script>
</body>
</html>
