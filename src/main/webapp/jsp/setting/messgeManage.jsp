<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html>
<head>

<title>通知设置</title>
<%@ include file="../common/header.jsp"%>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.json.js"></script>

<style>
.botton{
    background-color: #eb9939 !important;
	height: 32px !important;
	border: none !important;
	color: #FFF;
	font-size: 14px !important;
	width: 50px !important;
	-moz-border-radius: 5px 5px 5px 5px;
	-webkit-border-radius: 5px 5px 5px 5px;
	border-radius: 5px 5px 5px 5px;
	font-family: "Microsoft YaHei UI Light", "微软雅黑";
	cursor: pointer;
	line-height: 30px;
	text-align: center;
	margin:0px 0px;
	}

</style>

</head>
<body>

    <div class="list_title">
        <span class="layui-parent-title-customer">HOME</span>
        <span class="layui-badge-dot layui-bg-title"></span>
        <span class="layui-children-title-customer">通知设置</span>
    </div>
    <div class="text_input">
        <span class="div_search_customerBar"></span>
        <form id='fm_s' action=""  style="width:100%;">
        	<div class="form_item">
        		<div class="form_item_inline">
        			<label class="form_item_label6">发送信息别称</label>
        			<div class="form_item_input">
        				<input type="text" id="identification" name="identification" class="easyui-textbox" style="width:100px;"/>	
        			</div>
        		</div>
        		<div class="form_item_inline">
        			<label class="form_item_label6">发送信息内容</label>
        			<div class="form_item_input">
        				<input type="text" id="content" name="content" class="easyui-textbox" style="width:100px;"/>	
        			</div>
        			
        		</div>
        		<div class="form_item_inline">
        			<input type="button"  onclick="search();" class="text_input_button_search" data-options="iconCls:'icon-search'" value="查询"/>
        			如内容含有敏感词汇将导致保存或发送失败，具体请见<a href="${pageContext.request.contextPath}/baseMessageTemplate/downSensitiveWords">《敏感词范例》</a>
        		</div>
        	</div>        
        </form>
    </div>
    <div class="table_data">
        <h4 class="table_data_title"> 通知模板列表（请勿修改编辑内容文案中的代码，如有修改必要，只修改文字即可）</h4>
        <table id="dg" style="width: 100%;"></table>
    </div>
    <!-- 修改页面 -->
	<div id="dlgUpdate" class="easyui-dialog" style="width: 600px; max-height:500px; display:none;" closed="true"
		buttons="#dlg-buttonsUpdate" data-options="iconCls:'icon-save',closed:'true',collapsible:false,minimizable:false,maximizable:false,closable:true">
		<form id="fmUpdate1" method=post>
			<table class="pop_table" style="width:80%; margin: 0 auto;">
			<input type="hidden" id='id' name='id'/>
				<tr>
					<td>
					<span style="color:red;">*</span>
						通知类型
					</td>
					<td>
						<input type="checkbox" name="messageType" value="1" />&nbsp;短信
						<input type="checkbox" name="messageType" value="2" />&nbsp;站内信
					</td>
				</tr>
				<tr>
					<td>
					<span style="color:red;">*</span>
						状态
					</td>
					<td>
						<select id="status1" name="status" class="easyui-combobox" style="width: 200px;" data-options="required:true">
							<option value="1" selected="selected">启用</option>
							<option value="0">禁用</option>
						</select>
					</td>
				</tr>	
				<tr>
					<td>
					<span style="color:red;">*</span>
						发送信息标题
					</td>
					<td>
						<input type="text" id="title" name="title" class="easyui-textbox" style="width:200px;" data-options="required:true"/>
					</td>
				</tr>
				<tr>
					<td>
						发送信息内容
					</td>
					<td>
						<textarea rows="" cols=""  id="content" name="content" style="width:200px;margin-left: 10px;height: 100px;"></textarea>
					</td>
				</tr>
			</table>
		</form>			
	</div>
    
    <div id="dlg-buttonsUpdate" style="display:none;clear:both">
    	  <div class="text_input_button_cancel" onclick="javascript:$('#dlgUpdate').dialog('close')">取消</div>
		<div class="text_input_button_float" onclick="javascript:saveUpdateVehiclePrice();">保存</div>
	</div>
	<script type="text/javascript">
	
   //初始化页面
    $(function(){
    	
		setAutoHeight(270,"dg");
		
    	//初始化列表
    	$('#dg').datagrid({
  			url:'<%=request.getContextPath()%>/baseMessageTemplate/getMessageTemplateList',
  			toolbar:$('#toolbar'),
  			rownumbers:true,
  			columns :  [[ {
 				field : 'id',
 				hidden : true,
 				title : 'id'
 			}, {
				title : '操作',
				field : '_opt',//不对应数据库或json字段，取的名字
				formatter : function(value, rec,rowIndex) { //格式化函数添加一个操作列
					var btn = '<a class="editcls radiuBtn" onclick="updateVehiclePrice(' + rowIndex + ')" href="javascript:void(0)">编辑</a>';												
					return btn;
				}
			},{
 				field : 'status',
 				title : '状态',
 				formatter : function(value, rec) {
 					if(value==1){
 						return "启用";
 					}else{
 						return "禁用"
 					}
 				}
 			},{
 				field : 'messageType',
 				title : '通知类型',
 				formatter : function(value, rec) {
 					var res =  '';
 					if(value.indexOf('1')!=-1){
 						res+=' 短信 ';
 					}
 					if(value.indexOf('2')!=-1){
 						res+=' 站内信  ';
 					}
					return res;
 				}
 			},{
 				field : 'identification',
 				title : '别称',
 				formatter : function(value, rec) {
 					return "<span style='float:left;'>"+value+"</span>";
 				}
 			},{
 				field : 'title',
 				title : '发送信息标题',
 				formatter : function(value, rec) {
 					return "<span style='float:left;'>"+value+"</span>";
 				}
 			}, {
 				field : 'content',
 				title : '发送信息内容',
 				formatter : function(value, rec) {
 					return "<span style='float:left;'>"+value+"</span>";
 				}
 			}]],
  		    pagination:true,
  		    pageSize: 10,
  			pageList:[10,50,100] ,
  			emptyMsg:"无数据",
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
			links : 5,
         	layout:['prev','links','next','list']
         });
    });

		var url;
		//修改页面初始化
		function updateVehiclePrice(rowIndex) {
			var row = $('#dg').datagrid('getData').rows[rowIndex];
			$('#dlgUpdate').dialog('open').dialog('center').dialog('setTitle','修改通知模板');
			$('#fmUpdate1').form('load',row);	
			var checkBoxArray =row.messageType.split(","); 
	        for(var i=0;i<checkBoxArray.length;i++){  
	            $("input[name='messageType']").each(function(){  
	                if($(this).val()==checkBoxArray[i]){ 
	                    $(this).prop("checked",true);  
	                }  
	            })  
	        }
	        if(row.identification=='SMSCODE_SMSCODE_LOGIN'||row.identification=='FAULTREPORT'){
	        	 $("input[name='messageType']").attr('disabled',true);
	        }else{
	        	$("input[name='messageType']").attr('disabled',false);
	        }
		}

		//修改页面保存
		function saveUpdateVehiclePrice() {
			var url = '<%=request.getContextPath()%>/baseMessageTemplate/messageTemplateUpdate';
			
			$('#fmUpdate1').form('submit', {
				url : url,
				onSubmit : function() {
					//alert(456);
					return $(this).form('validate');
				},
				success : function(result) {
					if (result==1) {
						$.messager.alert('操作提示', "修改成功");
						$('#dlgUpdate').dialog('close'); // close the dialog
						$('#dg').datagrid('reload'); // reload the user data
					}else if(result == 2){
						$.messager.alert('操作提示', "信息别称已经存在");
					}else if (result==0) {
						$.messager.alert('操作提示', "修改失败");
					}else{
						var result = eval('(' + result + ')');
						if (result.code=='3') {
							$.messager.alert('操作提示', result.message);
						}
					}
				}
			});
		}
		
		//查询方法
		function search() {
			$('#dg').datagrid('load');
		}
		
		function downloadSensitiveWords(url){
			window.open(url);
		}
		
		
	</script>
</body>
</html>
