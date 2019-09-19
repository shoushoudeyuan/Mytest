<%@ page language="java" pageEncoding="UTF-8"  import="org.owasp.esapi.ESAPI" %>
<!DOCTYPE HTML>
<html>
<head>

<title>编辑红包</title>
<%@ include file="../common/header.jsp"%>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/upload.js"></script>
<style type="text/css">
body {
	height: 800px;
	overflow: hidden;
	margin: 0px;
	padding: 0px;
}
</style>

</head>
<body>
	<form id="fmEdit" method="post" style="height:800px">
		<input name="id" hidden="true" style="display:none;"> 
		<div style="margin-bottom: 10px; margin-left:30px;">
			红包编码<input name="packetnum" class="easyui-textbox"
				style="width: 225px"
				data-options="required:true,editable:false">
		</div>
		<div style="margin-bottom: 10px; margin-left:30px;">
			备　　注<input name="remark" class="easyui-textbox" style="width: 225px" data-options="required:true,validateOnCreate:false,validateOnBlur:true"/>
			<span style="color: red;">*</span>
		</div>
        
		<div style="margin-bottom: 10px; margin-left:30px;">
			生效时间<input id="startdate" name="startdate" hidden="true" class="easyui-datetimebox"  editable="false"
				style="width: 225px"
				data-options="required:true,validateOnCreate:false,validateOnBlur:true,validType:'dateTime'" />
			<span style="color: red;">*</span>
		</div>
		<div style="margin-bottom: 10px; margin-left:30px;">
			失效时间<input id='enddate'  name="enddate" class="easyui-datetimebox" style="width: 225px"  editable="false"
				data-options="required:true,validateOnCreate:false,validateOnBlur:true,validType:'dateTime'">
			<!-- 失效时间<input name="enddate" class="easyui-datetimebox" style="width: 225px"  editable="false"
				data-options="required:true,validateOnCreate:false,validateOnBlur:true,validType:'dateCompare[$(\'#startdate\').datetimebox(\'getValue\')]'"> -->
			<span style="color: red;">*</span>
		</div>
		<div style="margin-bottom: 30px; margin-left:30px;">
			是否启用<input type="radio" name="isdisable" value='1' />是 <input
				type="radio" name="isdisable" value="0" />否
		</div>
		<div>
			<table align="right" style="margin: 0px 17px 0 0px; padding: 0px;"
				cellpadding="0" cellspacing="0">
				<tr>
					<td style="padding-right: 10px;">背景图片</td>
					<td><div class="company_info_img">
							<img src="" id='imgurl_i' width="100%" height="100%" />
						</div></td>
				</tr>
				<tr>
					<td></td>
					<td align="left">
						<div class="file-box">
							<input type="hidden" name='imgurl'id='imgurl' value='' /> 
							<input type='text' name='textfield' id='imgurl_textfield' class='txt' value="点击选择图片" /> 
							<input type="file" name="imgurl_u" id="imgurl_u" class="file" size="28"
								onchange="if(this.files.length>0) document.getElementById('imgurl_textfield').value=this.files[0].name" />
							<div class="img_button" style="margin: 10px 0 0 3px;">
								<a href="javascript:evrental_upload('imgurl');">上传</a>
							</div>
						</div>
					</td>
				</tr>
			</table>
		</div>
        <div id="dlg-buttons" style="clear:both">
	      <div class="text_input_button_cancel" onclick="$('#dlg_edit').window('close');">取消</div>
          <div class="text_input_button_float" onclick="saveRedEnvelope();">保存</div>    
		</div>
	</form>
	<script type="text/javascript">
 		$(function(){
 			var redEnvelopeId = '<%=ESAPI.encoder().encodeForJavaScript(request.getParameter("redEnvelopeId"))%>';
 			if(! (redEnvelopeId == 'null')){
 				var selectPath = '<%=request.getContextPath()%>/activity/getRedEnvelope';
 	    		$.post(selectPath,{redEnvelopeId:redEnvelopeId},function(result){
 	    			if(result){
 	    			   $('#fmEdit').form('load',result);
 	    			   $('#imgurl_i').attr('src',$('#imgurl').val());
 	    			}else{
 	    				$.messager.alert('操作提示','查询红包失败!');
 	    			}
 	    		},'json');
 			}else{
 				$.messager.alert('操作提示','查询红包失败!');
 			}
 			
 		});
 		
 		function saveRedEnvelope(){
 	    	
 	        $('#fmEdit').form('submit',{
 	            url: '<%=request.getContextPath()%>/activity/saveRedEnvelope',
				onSubmit : function(param) {
					var res=$(this).form('validate');
					if(res){
						var st=$("#startdate").datetimebox('getValue');
			 			var et=$('#enddate').datetimebox('getValue');
			 			if(dateCompare(st,et)==false){
			 				$.messager.alert('操作提示','失效时间不得小于 生效时间');
			 				return false;
			 	    	} 
					}
					return res;
				},
				success : function(result) {
					if (result <= 0) {
						$.messager.alert('信息提示','保存失败');
					} else {						
						$.messager.alert('信息提示','保存成功');
						search();
						$('#dlg_edit').window('close');
					}
				}
			});
		}
 		function evrental_upload(file_id){
 			if($('#imgurl_textfield').val()=='点击选择图片'){
 				$.messager.alert('信息提示','请选择图片');
 				return;
 			}
			 $.ajaxFileUpload
			 ({
		         url: '<%=request.getContextPath()%>/upload', //用于文件上传的服务器端请求地址
				secureuri : false, //一般设置为false
				fileElementId : file_id + '_u', //文件上传控件的id属性  <input type="file" id="file" name="file" /> 注意，这里一定要有name值   
				dataType : 'json',//返回值类型 一般设置为json
				complete : function() {//只要完成即执行，最后执行
				},
				success : function(data, status) {
					if (data.code == '10000') {
						var previewImgPath = serverPath() + '/' + data.data.relativePath;
						var relativeImgPath = serverPath() + '/' + data.data.relativePath;
						$('#' + file_id + '_i').attr('src', relativeImgPath);
						$('#imgurl').val(relativeImgPath);
						$.messager.alert('信息提示','上传成功');
						$('#imgurl_textfield').val('点击选择图片');
					} else {
						$.messager.alert('信息提示',data.message);
					}
				},
				error : function(data, status, e)//服务器响应失败处理函数
				{
					alert(e);
				}
			})
		}
 		//比较日期日期大小(dt1>dt2返回false,否则返回true)
 		function dateCompare(dt1,dt2){
 			var starttime = new Date(dt1);
			var endtime = new Date(dt2);
			if (Date.parse(starttime) > Date.parse(endtime)) {
				return false;
			} else {
				return true;
			}
 		}
	</script>
	<script>
		/* //比较两个日期的大小(true:开始日期小于或等于结束日期;false:开始日期大于结束日期)
		$.extend($.fn.validatebox.defaults.rules, {
			dateCompare: {
				validator : function(value, param) {
					var starttime = new Date(param[0]);
					var endtime = new Date(value);
					if (Date.parse(starttime) > Date.parse(endtime)) {
						return false;
					} else {
						return true;
					}
				},
				message : '失效时间不得小于 生效时间:{0}.'
			}
		}); */

	</script>
</body>
</html>
