<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html>
  <head>
    <title>渠道管理</title>
  <%@ include file="../common/header.jsp" %>
  <link rel="stylesheet" href="../../css/viewer.min.css" type="text/css"/>
  <script type="text/javascript" src="../../js/viewer.min.js"></script>
  <style type="text/css">
		 .div_lsy {
		  margin-top: 10px;
		}
  /* 		.window-header {
		    background: transparent;
		    padding: 0px 0px 6px 0px;
		    line-height: 25px;
		    height: 25px;
		    font-size: 16px !important;
		    color: #FFF;
		} */
		.a-upload {
		    padding: 4px 14px;
		    height: 20px;
		    line-height: 20px;
 		    position: relative;
		    cursor: pointer;
		    color: #888;
		    background: #fafafa;
		    border: 1px solid #ddd;
		    border-radius: 4px;
		    overflow: hidden;
		    display: inline-block;
		    *display: inline;
		    *zoom: 1
		}
		
		.a-upload  input {
		    position: absolute;
		    font-size: 100px;
		    right: 0;
		    top: 0;
		    opacity: 0;
		    filter: alpha(opacity=0);
		    cursor: pointer
		}
		
		.a-upload:hover {
		    color: #444;
		    background: #eee;
		    border-color: #ccc;
		    text-decoration: none
		}
  </style>
  </head>
<body>
<div class="list_title">
	<span class="layui-parent-title-customer">HOME</span>
    <span class="layui-badge-dot layui-bg-title"></span>
    <span class="layui-children-title-customer">渠道管理</span>	
</div>
<div class="text_input">
	<span class="div_search_customerBar"></span>
	<form id='fm_s' action="">
		<div class="form_item">
			<div class="form_item_inline">
				<label class="form_item_label4">渠道名称</label>
				<div class="form_item_input">
					<input name="channelName" class="easyui-textbox" style="width:100px" />
				</div>
			</div>
			<div class="form_item_inline">
				<label class="form_item_label4">渠道码</label>
				<div class="form_item_input">
					<input name="channelCode" class="easyui-textbox" style="width:100px" />
				</div>
			</div>
			<div class="form_item_inline">
				<label class="form_item_label4">状态</label>
				<div class="form_item_input">
					<select name="status" class="easyui-combobox" style="width: 100px">
			             <option value="">全部</option>
			             <option value="0">关闭</option>
			             <option value="1">开启</option>
			        </select>
				</div>
			</div>
			<div class="form_item_inline">
				<input type="button" class="text_input_button_search" onclick="search()" value="查询">
			</div>
		</div>
     </form> 
</div>
<div id="edit" class="easyui-dialog" closed="true"
	data-options="iconCls:'icon-save',collapsible:false,minimizable:false,maximizable:false,closable:true" style="width: 700px;height: 630px;">
		<form id="editForm" method="post" style="margin-left: 10px; margin-top: 10px;">
			<input type="hidden" id="id" name="id"/>
			<div class="div_lsy">
				<span style="color:red">*</span>
				渠道名称：<input type="text" id="channelName" name="channelName" class="easyui-textbox" style="width: 180px;" data-options="required:true"/>
			</div>
			<div class="div_lsy">
			<span style="color:red">*</span>
				是否发布：<select id="status" name="status" class="easyui-combobox" style="width: 180px;" data-options="required:true">
		             <option value="1">开启</option>
		             <option value="0">关闭</option>
		        </select>
			</div>
			<div class="div_lsy">
			<span style="color:red">*</span>
				开始时间：<input type="text" id="startDate" name="startDate" class="easyui-datetimebox" style="width: 180px;" data-options="required:true"/>
			</div>
			<div class="div_lsy">
			<span style="color:red">*</span>
				结束时间：<input type="text" id="endDate" name="endDate" class="easyui-datetimebox" style="width: 180px;" data-options="required:true"/>
			</div>
			<div class="div_lsy">
				ios&nbsp;下&nbsp;载：&nbsp;<input type="text" id="iosDownloadUrl" name="iosDownloadUrl" class="easyui-textbox" data-options="prompt:' 地址开头请带http://'" style="width: 400px;" data-options="required:true"/>
			</div>
			<div class="div_lsy">
				安卓下载：<input type="text" id="androidDownloadUrl" name="androidDownloadUrl" class="easyui-textbox" data-options="prompt:' 地址开头请带http://'" style="width: 400px;" data-options="required:true"/>
			</div>
			<input type="hidden" name="activityAppImg" id="activityAppImg"/>
			<input type="hidden" name="activityHomeImg" id="activityHomeImg"/>
		</form>
		<span id="imgs">
			<form style="margin-left: 10px;" class="div_lsy" id="homeForm" method="post" enctype="multipart/form-data">
				<span style="color:red">*</span>首页图片：<a class="a-upload" style="margin-left: 10px;"><input accept="image/gif,image/jpeg,image/jpg,image/png,image/svg" type="file" name="homeFile" id="homeFile" onchange="changeImg(event, 'homeImg', 'homeBtn');" >请选择活动首页图片</a>
				<img id="homeImg" src="" height="100px",width="100px" onclick="showImg();">
				<a id="homeBtn" class="a-upload" onclick="uploadImg('homeForm')">上传</a>
			</form>
			<form style="margin-left: 10px;" class="div_lsy" id="appForm" method="post" enctype="multipart/form-data">
				<span style="color:red">*</span>下载图片：<a class="a-upload" style="margin-left: 10px;"><input accept="image/gif,image/jpeg,image/jpg,image/png,image/svg" type="file" name="appFile" id="appFile" onchange="changeImg(event, 'appImg', 'appBtn');" >请选择APP下载图片</a>
				<img id="appImg" src="" height="100px",width="100px" onclick="showImg();">
				<a id="appBtn" class="a-upload" onclick="uploadImg('appForm')">上传</a>
			</form>
		</span>
		<div class="div_lsy" style="margin-left: 99px;"><font color="red">图片尺寸：1242 x 2208，大小在1MB以内</font></div>
		<div class="div_lsy" style="margin-left: 10px;">
			<input type="button" class="text_input_button_cancel" style="margin-right:20px;margin-left:40px" onclick="closeDialog();" value="取消">
			<input type="button" class="text_input_button_float" onclick="save();" value="保存">
			
		</div>
</div>
	<div class="table_data">
		<h4 class="table_data_title">
			渠道管理
			<div class="text_input_bottom">
					<input type="button" class="text_input_button" onclick="editChannel()" value="添加">
 					<input type="button" class="text_input_button" onclick="downloadModel()" value="下载模板">
			</div>
		</h4>
		<table id="dg"  style="width:100%;"></table>
	</div>
<script type="text/javascript">
    $(function($) {
    	var viewer = new Viewer(document.getElementById('imgs'));
    	$("#homeImg").hide();
    	$("#appImg").hide();
    	$("#homeBtn").hide();
    	$("#appBtn").hide();
    	setAutoHeight(300,"dg");
         $('#dg').datagrid({
            url:'<%=request.getContextPath()%>/channel/channelList',
            toolbar:$('#toolbar'),
            rownumbers:true,
            emptyMsg:'无数据',
            columns:[[
                {field:'id',hidden:true,title:'id'},
    			{field:'operation',title: '操作',align: 'center',
                    formatter:function(value,rowData,rowIndex){
                        return "<a href='javascript:;' class='radiuBtn' onclick='editChannel(" + rowIndex + ");'>编辑</a><a href='javascript:;' class='radiuBtn' onclick='countUser(" + rowIndex + ");'>统计</a><a href='javascript:;' class='radiuBtn' onclick='delChannel(" + rowIndex + ");'>删除</a><a href='javascript:;' class='radiuBtn' onclick='couponConfig(" + rowIndex + ");'>优惠券配置</a>";  
                   }  
                },
                {field:'channelName',title:'渠道名称',width:'10%'},
                {field:'status',title:'状态',width:'10%',formatter:function(val, row) {
                	if (val == '0') {
                		return "<font class='datagrid_font_red'><b>关闭</b></font>"
                	} else if (val == '1') {
                		return "<font class='datagrid_font_green'><b>开启</b></font>"
                	}
                }},
                {field:'createDate',title:'创建时间',width:'15%'},
                {field:'startDate',title:'开始时间',width:'15%'},
                {field:'endDate',title:'结束时间',width:'15%'},
                {field:'channelCode',title:'渠道码',width:'10%'},
                {field:'activityUrl',title:'活动链接',width:'45%'}
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
         var pager = $('#dg').datagrid('getPager');
         pager.pagination({
            pageSize:10,
            pageList: [10,50,100],
            displayMsg:'',
            layout:['prev','links','next','list']
         }); 
    });
    
    function save() {
    	$.messager.confirm("提示", "您确定要保存么?", function(flag) {
    		if (flag) {
    			$('#editForm').form('submit', {
    				url : '${pageContext.request.contextPath}/channel/saveChannel',
    				onSubmit : function() {
    					if ($("#activityHomeImg").val() == '') {
    						$.messager.alert("操作提示", "请上传活动首页图片","");
    						return false;
    					}
    					if ($("#activityAppImg").val() == '') {
    						$.messager.alert("操作提示", "请上传app下载图片","");
    						return false;
    					}
    					
    					return $(this).form('validate');
    				},
    				success : function(result) {
    					var result = eval('(' + result + ')');
    					if (result.code != '10000') {
    						$.messager.alert("操作提示", result.message, "");
    					} else {
    						$('#edit').dialog('close');
    						$('#dg').datagrid('reload');
    						$.messager.alert("操作提示", result.message,"");
    					}
    				}
    			});
    		}
    	});
    }
    
    function delChannel(rowIndex) {
    	var row = $('#dg').datagrid('getData').rows[rowIndex];
    	$.messager.confirm("提示", "您确定要删除么?", function(flag) {
    		if (flag) {
    			$.ajax({
    				url:'${pageContext.request.contextPath}/channel/deleteChannel',
    				type:"post",
    				data:{"id":row.id},
    				success: function(result) {
    					if (result.code != '10000') {
    						$.messager.alert("操作提示", result.message, "");
    					} else {
    						$('#dg').datagrid('reload');
    						$.messager.alert("操作提示", result.message,"");
    					}
    				},dataType:"json"
    			})
    		}
    	})
    }
    
    function countUser(rowIndex) {
		var row = $('#dg').datagrid('getData').rows[rowIndex];
		url = "${pageContext.request.contextPath}/jsp/channel/channelUserList.jsp?channelCode="+row.channelCode;
		window.location.href = url;
    }
    
    function editChannel(rowIndex) {
    	$("#editForm").form('clear');
    	$('#edit').dialog('open').dialog('center').dialog('setTitle', '渠道信息');
    	if (rowIndex != null) {
    		var row = $('#dg').datagrid('getData').rows[rowIndex];
        	$('#editForm').form('load', row);
        	if (row.activityAppImg != '') {
	        	 $("#appImg").show();
	        	 $("#appBtn").hide();
	             $("#appImg").attr("src", "<%=request.getContextPath()%>" + "/" + row.activityAppImg);  
        	} else {
        		$("#appImg").hide();
        		$("#appBtn").hide();
        	}
        	if (row.activityHomeImg != '') {
	        	 $("#homeImg").show();
	        	 $("#homeBtn").hide();
	             $("#homeImg").attr("src", "<%=request.getContextPath()%>" + "/" + row.activityHomeImg);  
        	} else {
        		$("#homeImg").hide();
        		$("#homeBtn").hide();
        	}
    	} else {
    		$("#homeImg").hide();
    		$("#homeBtn").hide();
    		$("#appImg").hide();
    		$("#appBtn").hide();
    		$("#appImg").attr("src", "");  
    		$("#homeImg").attr("src", "");  
    	}
    }
    
    function closeDialog() {
    	$('#edit').dialog('close');
    }
    
    function search(){
        $('#dg').datagrid('reload');
    }
    
    function showImg() {
    	viewer.show();
    }
    
    var isHomeUpload;
    var isAppUpload;
    
    function uploadImg(formId) {
    	if (!isHomeUpload && formId == 'homeForm') {
    		$.messager.alert("操作提示", "首页图片过大，请重新上传", "");
    		return;
    	}
    	if (!isAppUpload && formId == 'appForm') {
    		$.messager.alert("操作提示", "下载页图片过大，请重新上传", "");
    		return;
    	}
		$("#" + formId).form('submit', {
			url : '${pageContext.request.contextPath}/upload',
			success : function(result) {
				var result = eval('(' + result + ')');
				if (result.code != '10000') {
					$.messager.alert("操作提示", result.message, "");
				} else {
					var path = result.data.relativePath;
					if (formId == 'homeForm') {
						$("#activityHomeImg").val(path);
						$("#homeBtn").hide();
					} else if (formId == 'appForm') {
						$("#activityAppImg").val(path);
						$("#appBtn").hide();
					}
					$.messager.alert("操作提示", "上传成功", "");
				}
			}
		});
	}
    
    function couponConfig(rowIndex){
		var row = $('#dg').datagrid('getData').rows[rowIndex];
		if(row.couponPackageId){
			window.location.href='<%=request.getContextPath()%>/jsp/couponmanage/couponpackagelist.jsp?packageId='+row.couponPackageId;
			return;
		}
		
		var url = "<%=request.getContextPath()%>/channel/couponpackageid";
		var channelName = row.channelName;
		var id = row.id;
		var data = {channelId:id,channelName:channelName};
		$.post(url,data).done(function(result){
			if(result.code != 100000){
				$.messager.alert("操作提示", "获取优惠券包信息失败", "");
				return;
			}
			
			window.location.href='<%=request.getContextPath()%>/jsp/couponmanage/couponpackagelist.jsp?packageId='+result.data;
		});
	}
    
	function changeImg(e, imgId, btnId){
	     for (var i = 0; i < e.target.files.length; i++) {  
	         var file = e.target.files.item(i);  
	         if (!(/^image\/.*$/i.test(file.type))) {  
	             continue; //不是图片 就跳出这一次循环  
	         }  
	         var freader = new FileReader();  
	         freader.readAsDataURL(file);  
	         freader.onload = function(e) {  
	        	 $("#" + imgId).show();
	        	 $("#" + btnId).show();
	             $("#" + imgId).attr("src", e.target.result);  
	         }  
	         if ((Math.round(file.size / 1024 * 100) / 100) > 1024) {
	        	 if (imgId == 'homeImg') {
	        		 isHomeUpload = false;
	        	 } else if (imgId == 'appImg') {
	        		 isAppUpload = false;
	        	 }
	         } else {
	        	 isHomeUpload = true;
	        	 isAppUpload = true;
	         }
	     }  
	} 
	
	function downloadModel() {
		var url = "<%=request.getContextPath()%>/channel/downloadModel";
		window.open(url);
	}
</script>
</body>
</html>
