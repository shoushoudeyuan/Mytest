<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html>
  <head>
  	
    <title>提供租车服务的城市管理</title>
  <%@ include file="../common/header.jsp" %>

 	
  </head>
<body>
    <div class="list_title">
        <span class="layui-parent-title-customer">HOME</span>
        <span class="layui-badge-dot layui-bg-title"></span>
        <span class="layui-children-title-customer">提供租车服务的城市管理</span>
    </div>
    <div class="text_input">
        <span class="div_search_customerBar"></span>
        <form id='fm_s' action="">
        	<div class="form_item">
        		<div class="form_item_inline">
        			<label class="form_item_label3">城市名</label>
        			<div class="form_item_input">
        				<input name="showName" class="easyui-textbox" style="width:100px" />
        			</div>
        		</div>
        		<div class="form_item_inline">
        			 <input type="button" class="text_input_button_search" onclick="search()" value="查询" />
        		</div>
        	</div>
        </form>
    </div>
    <div class="table_data">
        <h4 class="table_data_title"> 提供租车服务的城市管理
        <div class="text_input_bottom">
            <div class="text_input_button_add" id="text_input_button_left" onclick="newCity()">添加</div>
            <div class="text_input_button_del" id="text_input_button_left" onclick="destroy()">删除</div>
        </div>
        </h4>
        <table id="dg"  style="width:100%;"></table>
    </div>

    <div id="modify" class="easyui-window"
	     data-options="iconCls:'icon-save',collapsible:false,minimizable:false,maximizable:false,closed:true" style="width:480px;height:500px;padding:10px;">
       	 	城市信息
    </div>    	
    <script type="text/javascript">
    $(function($) {
		setAutoHeight(270,"dg");
    	 $('#dg').datagrid({
 			url:'<%=request.getContextPath()%>/city/getAllCityList',
 			toolbar:$('#toolbar'),
 			rownumbers:true,
 		    columns:[[
 				{field:'ck',checkbox:true,id:'ck'}, 
 				{field:'id',hidden:true,title:'id'}, 
 				{field:'action',title:'操作',width:'15%',formatter:formatAction},
 		        {field:'countyid',title:'城市真实ID',width:'15%',formatter:formatId},
 		        {field:'showname',title:'城市显示名',width:'15%'},
 		        {field:'status',title:'状态',width:'10%',formatter:formatStatus},
 		        {field:'showorder',title:'显示顺序',width:'15%'},
 		        {field:'citylon',title:'城市经度',width:'15%'},
 		        {field:'citylat',title:'城市纬度',width:'14.8%'}
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
   
    function formatAction(val,row){
        return '<a style="" class="radiuBtn" href="#" onclick="javascript:editCity('+row.id+')">编辑</a>';
	}
    
    function formatId(val,row){
    	var temp =row.countyid;
		if('' == val||null==val){
			temp = row.cityid;
		}
		return temp;
 	}

	function formatStatus(val,row){
	    var temp ='启用';
		if('0' == val){
			temp = '禁用';
		}
		return temp;
	}
	
	var userId;	
	
    function newCity(){
		$('#modify').window({href:'<%=request.getContextPath()%>/jsp/base/modifyServiceCity.jsp',width:700,height:400,modal:true,resizable:false})
    	.window('setTitle','新增服务城市')//
    	.window('open');//
    }
    function editCity(id){
    	$('#modify').window({href:'<%=request.getContextPath()%>/jsp/base/modifyServiceCity.jsp?id='+id, width:700,height:400,modal:true,resizable:false})
    	.window('setTitle','修改服务城市')
    	.window('open');//
    }
    

    function destroy(){
    	var path = '<%=request.getContextPath()%>/city/delete';
        var rows = $('#dg').datagrid('getChecked');
        if (rows.length>0){
            $.messager.confirm('Confirm','确定要删除服务城市么?',function(r){
                if (r){
                	var ids = '';
					for(var i =0 ;i<rows.length;i++){
						ids += rows[i].id + ',' ;
					}
					ids = ids.substring(0 , ids.length-1);

                    $.post(path,{ids:ids},function(result){
                        if (result.success){
                        	$.messager.alert('操作提示','操作成功!');
                            $('#dg').datagrid('reload');    // reload the user data
                        }else if(result.message=='该服务城市下有车辆，不能删除'){
                        	$.messager.alert('操作提示','该服务城市下有车辆，不能删除！');
                        } else {
                        	$.messager.alert('操作提示','操作失败!');
                        }
                    },'json');
                }
            });
        }else{
        	$.messager.alert('操作提示','至少选择一条记录!');
        }
    }
    
    
    function search(){
        $('#dg').datagrid('load');
    }
    </script>
</body>
</html>
