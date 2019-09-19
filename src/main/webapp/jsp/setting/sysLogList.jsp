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
        <form id='fm_sx' action="" style="width:100%">
        	<div class="form_item">
        		<div class="form_item_inline">
        			<label class="form_item_label4">角色类型</label>
        			<div class="form_item_input">
        				<select name="roleId" id="roleId" class="easyui-combobox" style="width: 60px"></select>
        			</div>
        		</div>
        		<div class="form_item_inline">
        			<label class="form_item_label3">用户名</label>
        			<div class="form_item_input">
        				<input name="userName" class="easyui-textbox" style="width:60px" >
        			</div>
        		</div>
        		<div class="form_item_inline">
        			<label class="form_item_label4">真实姓名</label>
        			<div class="form_item_input">
        				<input name="realName" class="easyui-textbox" style="width:60px">
        			</div>
        		</div>
        		<div class="form_item_inline">
        			<label class="form_item_label4">开始时间</label>
        			<div class="form_item_input">
        				<input id="startTime" name="startTime" editable="false" class="easyui-datetimebox"
			                data-options="validateOnCreate:false,validateOnBlur:true,validType:'dateTime'" />
        			</div>
        		</div>
        		<div class="form_item_inline">
        			<input type="button" class="text_input_button_search" onclick="searchx()" value="查询">
        		</div>
        	</div>
   			 <div class="form_item form_item_hidden">
        		<div class="form_item_inline">
        			<label class="form_item_label4">结束时间</label>
        			<div class="form_item_input">
        				<input id='endTime' name="endTime" class="easyui-datetimebox" editable="false" 
		                data-options="required:true,validateOnCreate:false,validateOnBlur:true,validType:'dateTime'">
        			</div>
        		</div>
        		<div class="form_item_inline">
        			<label class="form_item_label3">关键字</label>
        			<div class="form_item_input">
        				<input name="operateContent" class="easyui-textbox" style="width:60px">
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
        <h4 class="table_data_title"> 操作日志</h4>
        <table id="dgx"  style="width:100%;"></table>
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
  $(function($) {
	  setAutoHeight(300,"dgx");
	/*  $("#dgx").height($("#dgx").parent().height()-60); */
	 
	 $('#roleId').combobox({
		    url:'/bjyadmin/sysRole/roleList4Combobox',
		    valueField:'roleId',
		    textField:'roleName'
	 });
	 
  	 $('#dgx').datagrid({
		url:'/bjyvms/sysLog/logListAction',
			toolbar:$('#toolbar'),
			rownumbers:true,
			emptyMsg:'无数据',
		    columns:[[
			
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
		    	$($('#fm_sx').serializeArray()).each(function(){  
		    		param[this.name]=this.value;  
	            }); 
			},
			onBeforeSelect:function(){
				return false;
			}
		});
   	 
   	 var pager = $('#dgx').datagrid('getPager');    // get the pager of datagrid
        pager.pagination({
        	pageSize:10,
        	pageList: [10,50,100],
		displayMsg:'',
        	layout:['prev','links','next','list']
        }); 
   	 
   });
   function formatType(val,row){
   	if(val=='1'){
   		return "开锁";
   	}else if(val=='2'){
   		return "锁门";
   	}else if(val=='3'){
   		return "还车";
   	}else if(val=='4'){
   		return "鸣笛";
   	}else if(val=='5'){
   		return "恢复供电";
   	}
   }
function formatStatus(val,row){
    var temp ='失败';
	if(1 == val){
		temp = '成功';
	}
	return temp;
}
   
   function searchx(){
       $('#dgx').datagrid('reload');
   }
   
   </script>
