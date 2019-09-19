<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
  	
<style type="text/css">
   .text_input_buttonx {
       color: rgb(255, 255, 255);
    font-family: "Microsoft YaHei UI Light", 微软雅黑;
    cursor: pointer;
    line-height: 30px;
    text-align: center;
    background-color: rgb(61, 70, 82);
    height: 32px;
    font-size: 14px;
    width: 70px;
    border-radius: 2px;
    border-width: initial !important;
    border-style: none !important;
    border-color: initial !important;
    border-image: initial !important;
   }
</style>
  
   <div class="text_input">
   		<span class="div_search_customerBar"></span>
   		<form id='fm_bt' action="" style="width:100%">
   			<div class="form_item">
   				<div class="form_item_inline">
   					<label class="form_item_label4">开始时间</label>
   					<div class="form_item_input">
   						<input id="startTime_bt" name="startTime" editable="false" class="easyui-datetimebox"
			                data-options="validateOnCreate:false,validateOnBlur:true,validType:'dateTime'" />
   					</div>
   				</div>
   				<div class="form_item_inline">
   					<label class="form_item_label4">结束时间</label>
   					<div class="form_item_input">
   						<input id='endTime_bt' name="endTime" class="easyui-datetimebox" editable="false" 
		                	data-options="required:true,validateOnCreate:false,validateOnBlur:true,validType:'dateTime'">
   					</div>
   				</div>
	   			<div class="form_item_inline">
   					<input type="button" class="text_input_buttonx" onclick="searchbt()" value="查询" />
   				</div>
   			</div>
   	</form>	
  </div>
  	 <div class="table_data">
  		<table id="dg_bt"  style="width:100%;"></table>
  	</div>
  <script type="text/javascript">
  
  $(function($) {
	 $("#dg_bt").height($("#dg_bt").parent().height()-60);
	 
  	 $('#dg_bt').datagrid({
		url:'<%=request.getContextPath()%>/sysLog/logListAction',
			toolbar:$('#toolbar'),
			rownumbers:true,
			emptyMsg:'无数据',
		    columns:[[
				{field:'ck',checkbox:false,id:'ck'}, 
				{field:'id',hidden:true,title:'id'},
		        {field:'userName',title:'用户名',width:'15%'},
		        {field:'realName',title:'真实姓名',width:'20%'},
		        {field:'operateContent',title:'操作内容',width:'30%'},
		        {field:'createTime',title:'创建时间',width:'15%'},
		        {field:'operateResult',title:'操作结果',width:'15%',formatter:formatStatus}
		    ]],
		    pagination:true,
		    pageSize: 10,
		    onBeforeLoad: function(param){
		    	$($('#fm_bt').serializeArray()).each(function(){  
		    		param[this.name]=this.value;
	            }); 
		    	param.bluetooth='bluetooth';
			},
			onBeforeSelect:function(){
				return false;
			}
		});
   	 
   	 var pager = $('#dg_bt').datagrid('getPager');    // get the pager of datagrid
        pager.pagination({
        	pageSize:10,
        	pageList: [10,50,100],
			displayMsg:'',
        	layout:['prev','links','next','list']
        }); 
   	 
   });
  
	function formatStatus(val,row){
	    var temp ='失败';
		if(1 == val){
			temp = '成功';
		}
		return temp;
	}
   
   function searchbt(){
       $('#dg_bt').datagrid('reload');
   }
   </script>
