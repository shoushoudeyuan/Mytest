<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="../common/header.jsp"%>
<title>广告管理</title>
<link rel="stylesheet" href="../../css/jquery.fancybox.css" type="text/css"/>
<script type="text/javascript" src="../../js/jquery.fancybox.pack.js"></script>
<script type="text/javascript" src="../../js/util/extendValidate.js"></script>
<script type="text/javascript">
			
	$(function() {  
	setAutoHeight(270,"dg"); 
		$('#dg').datagrid({
			url:'${pageContext.request.contextPath}/advertisement/advertisementListWeb', 
			pagination:true,//分页控件 
	        rownumbers:true,//行号 
	        emptyMsg:"无数据",
	        pageSize:10,
	        singleSelect:true,
        	pageList : [10,50,100],
	        onBeforeLoad: function(param){
 		    	$($('#fm_s').serializeArray()).each(function(){  
 		    		param[this.name]=this.value;  
 	            }); 
 			},
		});
		$('#dg').datagrid({
			columns : [ [ /* {
				field : 'id',
				checkbox : true,
			}, */{field:'operation',title: '操作',align: 'center',
                formatter:function(value,rowData,rowIndex){
                    //function里面的三个参数代表当前字段值，当前行数据对象，行号（行号从0开始）editCustomer
                    return "<a href='javascript:;' class='radiuBtn' onclick='editAdvert(" + rowIndex + ");'>编辑</a><a href='javascript:;' class='radiuBtn' onclick='deleteAdvert(" + rowIndex + ");'>删除</a>";  

               }  

            },{
				field : 'title',
				title : '标题',
				align : 'center'
			}, {
				field : 'isdisable',
				title : '状态',
				align : 'center',
				formatter:checkStatus
			},{
				field : 'imagetype',
				title : '图片类型',
				align : 'center',
				formatter:getImageType
			}, /* {
				field : 'imagetype',
				title : '图片类型',
				align : 'center',
				formatter:getImageType
			}, */{
				field : 'showorder',
				title : '显示顺序',
				align : 'center'
			},
			{field:'iosImgUrl',title:'图片(iphone)',align:'center',
            	   formatter:function(value,rowData,rowIndex){
                       //function里面的三个参数代表当前字段值，当前行数据对象，行号（行号从0开始）editCustomer
                       //return "<a href='javascript:;' onclick='scanImage(" + rowIndex + ");'>预览</a>";  
						 if(rowData.iosImgUrl != null &&  rowData.iosImgUrl != "")
						{
							 var iosImgUrl = "/"+rowData.iosImgUrl;
		 	    				return "<a class='fancybox datagrid_font_green'  href="+iosImgUrl+">预览</a>";
						}
						 else
						 {
							 //return "<a href='javascript:;' " + ">预览</a>";
							 return "未上传";
						}
                  } },{field:'androidImgUrl',title:'图片(安卓)',align:'center',
            	   			formatter:function(value,rowData,rowIndex){
                       //function里面的三个参数代表当前字段值，当前行数据对象，行号（行号从0开始）editCustomer
                       //return "<a href='javascript:;' onclick='scanImage(" + rowIndex + ");'>预览</a>";  
						 if(rowData.androidImgUrl != null &&  rowData.androidImgUrl != "")
						{
							 var androidImgUrl = "/"+rowData.androidImgUrl;
		 	    				return "<a class='fancybox datagrid_font_green'  href="+androidImgUrl+">预览</a>";
						}
						 else
						 {
							 //return "<a href='javascript:;' " + ">预览</a>";
							 return "未上传";
						}
                  } }, {
				field : 'showName',
				title : '城市',
				align : 'center',
			},  {
				field : 'imglink',
				title : '超链接',
				align : 'center',
				width:'30%',
				formatter : function(val) {
					return '<a class="datagrid_font_green" onclick="loadImgLink(\''+val+'\');">'+val+'</a>';
				}
			},  {
				field : 'createdate',
				title : '创建时间',
				align : 'center',
				width:'20%'
			}, {
				field : 'modifydate',
				title : '更新时间',
				align : 'center',
				width:'20%'
			} ] ],
		});
		
		var pager = $('#dg').datagrid('getPager');    // get the pager of datagrid
        pager.pagination({
        	pageSize:10,
        	pageList :  [10,50,100],
			displayMsg:'',
			links:5,
        	layout:['prev','links','next','list']
        });  
		
	    $("#dlgImg").window("close");
	    $('#status').combobox
	    ({    
	    		editable: false  
      });  
	    $('.fancybox').fancybox({
       	 closeClick : true
        });
	});
	function loadImgLink(imgUrl) {
		window.top.open(imgUrl, '_blank');
	}

	function addAdvert(){
    	window.location.href='<%=request.getContextPath()%>/jsp/advert/addAdvert.jsp';
    }
	
	function editAdvert(rowIndex){
		
	var row = $('#dg').datagrid('getData').rows[rowIndex];
    	window.location.href='<%=request.getContextPath()%>/jsp/advert/addAdvert.jsp?advertId='+row.id;
    }
	
	function scanImage(rowIndex)
	{
		var row = $('#dg').datagrid('getData').rows[rowIndex];
		if(row.iosImgUrl != null &&  row.iosImgUrl != "")
		{
				$("#dlgImg").dialog('open');
		 	    $("#showImg").attr("src","/"+row.iosImgUrl);
		 	   grid.datagrid("clearSelections");
		}
	}
	
	
	function checkStatus(val,rec){ 
		if (val == '0')
		{ 
		    return '禁用'; 
		} else if (val == '1'){ 
			return '启动'; 
		}  
	}
	
	function getImageType(val,rec){ 
		if (val == '1')
		{ 
		    return '广告图'; 
		} else if (val == '2'){ 
			return '活动图'; 
		}  
	}
	
	/* function getImageType(val,rec){ 
		if (val == '1')
		{ 
		    return '活动'; 
		} else if (val == '2'){ 
			return '广告'; 
		} 
		else if (val == '3')
		{
			return '价格';
		}
	} */
	
	//删除方法
	function deleteAdvert(rowIndex) 
	{
		var row = $('#dg').datagrid('getData').rows[rowIndex];
		//var rows = $("#dg").datagrid("getSelections");
		if (row) {
			
			$.messager.confirm('确认', '确定要删除选中的广告信息吗?', function(r) 
			{
				/* var ids = "";
				for (var i = 0; i < rows.length; i++) {
					var obj = rows[i];
					ids = ids + obj.id;
					if (i != rows.length - 1) {
						ids = ids + ",";
					}
				} */
				if(r)
				{
					var url = '${pageContext.request.contextPath}/advertisement/deleteAdvert'
						$.ajax({
							type : "GET",
							url : url,
							data : {
								ids : row.id
							},
							dataType : "json",
							success : function(data) {
								if (data.code == 10000) {
									$.messager.alert("操作提示", "删除成功！", "");
									//$('#dg').datagrid('deleteRow', rowIndex);
									$('#dg').datagrid('reload');
									
									/* for (var i = 0; i < rows.length; i++) {
										var objr = rows[i];
										var index = $('#dg').datagrid('getRowIndex', objr);
										$('#dg').datagrid('deleteRow', index);
									} */

								} else {
									$.messager.alert("操作提示", "删除操作！", "");
								}

							},
							error : function() {
								$.messager.alert("操作提示", "删除失败！", "");
							}
						});
					}
			});
		} else {
			$.messager.alert("操作提示", "请选择要删除的广告信息", "");
		}		
	}
	
	function search() {
		$('#dg').datagrid('load');
	}
</script>
</head>
<body>
<div class="list_title">
	<span class="layui-parent-title-customer">HOME</span>
    <span class="layui-badge-dot layui-bg-title"></span>
    <span class="layui-children-title-customer">广告管理</span>
</div>

<div class="text_input">
	<span class="div_search_customerBar"></span>
	    	<form id='fm_s' action="">
	    		<div class="form_item">
	    			<div class="form_item_inline">
	    				<label class="form_item_label2">标题</label>
	    				<div class="form_item_input">
	    					<input name="title" class="easyui-textbox" style="width:100px"/>
	    				</div>
	    			</div>
	    			<div class="form_item_inline">
	    				<label class="form_item_label4">是否启用</label>
	    				<div class="form_item_input">
	    					<select id="status" name="status" class="easyui-combobox" style="width: 100px;">
								<option  value="" selected="selected">请选择</option>
								<option  value="0">禁用</option>
								<option  value="1">启用</option>
							</select>
	    				</div>
	    			</div>
	    			<div class="form_item_inline">
	    				<label class="form_item_label4">图片类型</label>
	    				<div class="form_item_input">
	    					<select id="imageType" name="imageType" class="easyui-combobox" style="width: 100px;">
								<option  value="" selected="selected">请选择</option>
								<option  value="1">广告图</option>
								<option  value="2">活动图</option>
							</select>
	    				</div>
	    			</div>
	    			<div class="form_item_inline">
	    				<input type="button" onclick="search()" class="text_input_button_search" value="查询" />
	    			</div>
	    		</div>
	    	</form>	
	    </div>

	<div class="table_data">
		<h4 class="table_data_title">
			广告管理
			<div class="text_input_bottom">
				<div class="text_input_button_add" id="text_input_button_left"
					onclick="addAdvert()">添加</div>
					
			</div>
		</h4>
		<table id="dg"></table>  
  </div>
	<div id = "dlgImg" title = "图片预览" class="easyui-dialog" style="width:700px; display: none; left:30%;top:10%;" closed="true">
		<img id = "showImg" >
	</div>



</body>
</html>