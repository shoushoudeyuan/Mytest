<%@ page language="java" pageEncoding="UTF-8"  import="org.owasp.esapi.ESAPI" %>
<!DOCTYPE HTML>
<html>
  <head>
  	
    <title>广告新增</title>
  <%@ include file="../common/header.jsp" %>
  <!-- 配置文件 -->  
  <script type="text/javascript" src="../../ueditor/ueditor.config.js"></script>  
  <!-- 编辑器源码文件 -->  
  <script type="text/javascript" src="../../ueditor/ueditor.all.js"></script>  
  <!-- 语言包文件(建议手动加载语言包，避免在ie下，因为加载语言失败导致编辑器加载失败) -->  
  <script type="text/javascript" src="../../ueditor/lang/zh-cn/zh-cn.js"></script> 
  <script type="text/javascript" src="../../ueditor/ueditor.parse.min.js"></script> 
   </head>
<style>
html{
	overflow: auto;
}

#iup{
    font-size: 14px !important;
    border: 0;
    margin: 0 0 0 10px;
    padding: 4px;
    height: 22px !important;
    line-height: 22px !important;
    white-space: normal;
    outline-style: none;
    text-align: left !important;
    resize: none;
    vertical-align: top;
    width:162px !important;
    -moz-border-radius: 5px 5px 5px 5px;
    -webkit-border-radius: 5px 5px 5px 5px;
    border-radius: 5px 5px 5px 5px;
    font-family: "Microsoft YaHei UI Light", "瀵邦喛钂嬮梿鍛寸拨";
    border: 1px solid #ccc;
}
#edui1{
	border:none;
}

</style>
  
<body>
	<div class="list_title">
		<span class="layui-parent-title-customer">HOME</span>
        <span class="layui-badge-dot layui-bg-title"></span>
        <span class="layui-children-title-customer">广告信息</span>
	</div>
	<div class="table_data" style="height:650px">
		<h4 class="table_data_title">广告信息</h4>
		<div class = "advert_info"></div>
		<div id = "ll" ><!-- style="display: none;" -->
		<form id="fm" method="post">
			<input name="id" type="hidden">
			<input id="advertImgPath" name="advertImgPath" type="hidden">
			<input id="advertImgPathA" name="advertImgPathA" type="hidden">
			<table style="width:30%;float:left;margin: 20px 0px;" class="pop_table" >
				<tr>
					<td><label>图片用途</label></td>
					<td>
						<select id="imagetype" name="imagetype" class="easyui-combobox" style="width:172px;" >
						<option value="1" selected="selected">广告图</option>
						<option value="2">活动图</option>
			</select>
					</td>
				</tr>
				<tr> 
					<td><label><span style="color:red;">*</span>标题</label></td>
					<td><input name="title" class="easyui-textbox"
		               	 data-options="required:true,validateOnCreate:false,validateOnBlur:true"></td>
				</tr> 
	
				 <tr id='linkTr'> 
					<td><label>超链接</label></td>
					<td><input name="imglink" class="easyui-textbox"></td>
				</tr> 
				<tr> 
					<td><label>是否启用</label></td>
					<td>
						<select id="isdisable" name="isdisable" class="easyui-combobox"  style="width:172px;">
								<option value="1" selected="selected">启用</option>
								<option value="0">禁用</option>
						</select>
					</td>
				</tr>
				<tr> 
					<td><label><span style="color:red;">*</span>显示顺序</label></td>
					<td><input name="showorder" class="easyui-validatebox"
						validType="ZNumber" maxlength="2"  id="iup"
		               	 data-options="required:true,validateOnCreate:false,validateOnBlur:true"></td>
				</tr>
				<tr> 
					<td><label>城市</label></td>
					<td>
						<select id="cityid" name="cityid" class="easyui-combobox" style="width:172px;" >
						</select>
					</td>
				</tr>
				<!-- <tr>
					<td><label>内容</label></td>
					<td>
						<textarea id = "content" name ="content" style="width:165px; height:50px; margin-left:10px;" ></textarea>
					</td>				
				</tr> -->
			 
			 </table>
			 
			 <!-- <div id="contentDiv" style = "width: 98% ; clear: both;margin-top: 100px;display:none;">
			 	<script id="content" name="content" type="text/plain" ></script>
				<script type="text/javascript">
				/**
				$(document).ready(function(){
					
					
					UE.Editor.prototype._bkGetActionUrl = UE.Editor.prototype.getActionUrl;
	
				     UE.Editor.prototype.getActionUrl = function(action) {
	
				     //判断路径   这里是config.json 中设置执行上传的action名称  http://localhost:8080/bagechuxing/
	
				         if (action == 'uploadimage') {
				        	 alert('dddd');
	
				             return '/bjycrm/ueditor/uploadimage';
	
				         } else if (action == 'uploadvideo') {
	
				             return '';
	
				         } else {
	
				             return this._bkGetActionUrl.call(this, action);
	
				         }
	
				     }
				     
					
	    				introduceEditor = UE.getEditor('content');
				        
				     introduceEditor.ready(function(){
				    	 introduceEditor.setContent("ddd");    
				    	})
					
				});
				*/
				</script>
			 </div> -->
			 
			 </form>
			 
			 <div style="position:absolute ;width:68%;;right: 1%" >
			 
			 <form id="advertImg_f" action="${pageContext.request.contextPath}/upload"
				method="post" enctype="multipart/form-data">
			<table style="width:50%;float:left; margin: 0px 0px;" class="pop_table" >
			 <tr>
			 	<td >
					<label>iphone<br>图片</label>
					</td>
					<td>
						<!-- class="company_info_img" -->
						<div class="company_info_img">
						    	<img src="" id='advertImg_i' style ="width:100%;height:100%;"/>
						 </div>
					</td>
			 </tr>
			 <tr>
			 	<td></td>
					<td align="left">
	                 
	                 	<div class="file-box"  style="width:300px !important;">
	 
	 					<input type='text' name='advertImg_u' id='advertImg'name="advertImg_u" data-options="required:true" class='txt' value="&nbsp;点击选择图片" />
	   
	    					<input type="file"  class="file" name="advertImg_u" data-options="required:true" size="28" onchange="document.getElementById('advertImg').value=this.value" />
	 					<input type="button"  class="img_button" onclick="uploadImg('advertImg')" value="上传" />
						
						<span id="advertImgWarming" style="color: red;" >iphone广告图须上传1242x2208的图片</span>
					</div>
	                 </td>
			 </tr>	
			 <tr>
			 	<td></td>
			 	<td>
			 		<span id="advertImginfo" style="color: red;" ></span>
			 	</td>
			 </tr>		  
			 </table>
			 	 		 
		</form>
		<form id="advertImgA_f" action="${pageContext.request.contextPath}/upload"
				method="post" enctype="multipart/form-data">
			<table style="width:50%;float:left; margin: 0px 0px;" class="pop_table" >
				<tr>
			 	<td >
					<label>安卓<br>图片</label>
					</td>
					<td>
						<div class="company_info_img">
						    	<img src="" id='advertImgA_i' style ="width:100%;height:100%;"/>
						 </div>
					</td>
			 </tr>
			 <tr>
			 	<td></td>
					<td align="left">
	                 
	                 	<div class="file-box"  style="width:300px !important;">
	 
	 					<input type='text' name='advertImgA_u' id='advertImgA' data-options="required:true" class='txt' value="&nbsp;点击选择图片" />
	   
	    					<input type="file"  class="file" name="advertImgA_u" data-options="required:true" size="28" onchange="document.getElementById('advertImgA').value=this.value" />
	 					<input type="button"  class="img_button" onclick="uploadImg('advertImgA')" value="上传" />
						
						<span id="advertImgWarmingA" style="color: red;" >安卓手机广告图须上传1080x1920的图片</span>
					</div>
	                 </td>
			 </tr>
			 <tr>
			 	<td></td>
			 	<td>
			 		<span id="advertImgAinfo" style="color: red;" ></span>
			 	</td>
			 </tr>
			</table>
		</form>
		</div>
		
		
		</div>	
		
	    <div style=" width:98%; margin:0px auto; margin-top:20px; border-top: 2px solid #22ab39; clear:both; padding-top:20px;">
	    	<div class="text_input_button_cancel" onclick="javascript:saveAdvertCancel();">取消</div>
	    	<div class="text_input_button_float"  onclick="javascript:saveAdvert();">保存</div>
	    
	 </div>
				    
</div>    
           
	<script type="text/javascript">
 		$(function(){
 			
 			//加载Editor
 			introduceEditor = UE.getEditor('content');
	 		   	
 			var advertId = '<%=ESAPI.encoder().encodeForJavaScript(request.getParameter("advertId"))%>';
 			if(! (advertId == 'null')){
 			
 			 $("#imagetype").combobox({  
                    disabled:true  
                }); 
 			/* $("#imagetype1").combobox({  
                disabled:true  
            }); */ 
 			var selectPath = '<%=request.getContextPath()%>/advertisement/selectAdvert';
 	    		$.post(selectPath,{advertId:advertId},function(result)
 	    				{
 	    			if(result.success){
					//alert("/"+ result.advert.iosImgUrl);
					//alert("androidImgUrl"+result.advert.androidImgUrl);
 	    				var peo = result.advert.imagetype;
 	    				if(peo == "2")
 	    				{
 	    					//$('#ll').css('display',"block");
                       	   //$("#hh").css('display',"none");
 	    					$('#fm').form('load',result.advert);
 		 		        	$('#advertImg_u').val(result.advert.iosImgUrl_pre);
 	 	    			    $('#advertImg_i').attr('src',"/"+ result.advert.iosImgUrl);
 	 	    			  	$('#advertImgA_u').val(result.advert.androidImgUrl_pre);
	 	    			    $('#advertImgA_i').attr('src',"/"+ result.advert.androidImgUrl);
 	 	    			    $('#imagetype').combobox('setValue',"2");
 	 	    			    //$('#imagetype1').combobox('setValue',"2");
 	 	    			   // $("#contentDiv").css("display","block");
 	    				}
 	    				else
 	    				{
 	    					//$('#ll').css('display',"none");
                         //$("#hh").css('display',"block");
 	    					$('#fm').form('load',result.advert);
 		 		        	$('#advertImg_u').val(result.advert.iosImgUrl_pre);
 	 	    			    $('#advertImg_i').attr('src',"/"+ result.advert.iosImgUrl);
 	 	    				$('#advertImgA_u').val(result.advert.androidImgUrl_pre);
 	 	    			    $('#advertImgA_i').attr('src',"/"+ result.advert.androidImgUrl);
 	 	    			  	$('#imagetype').combobox('setValue',"1");
	 	    			   	//$('#imagetype1').combobox('setValue',"1");
 	 	    			   // $("#contentDiv").css("display","none");
 	    				}
 	    				
 	    				//Editor加载数据
 	    				 introduceEditor.ready(function(){
 	    			    	 introduceEditor.setContent(result.advert.content);    
 	    			    	})
 	    				
 	    			}else{
 	    				$.messager.alert('操作提示','查询错误!');
 	    			}
 	    			
 	    		},'json');
 			}/* else{
 				$.each($("input[name='gender']"),function(i,v){
 	 	        	if(0==v.value){
 	 	        		v.checked='checked';
 	 	        	}
 	 	        });
 				$.each($("input[name='status']"),function(i,v){
 	 	        	if(0==v.value){
 	 	        		v.checked='checked';
 	 	        	}
 	 	        });
 			} */
 			
//  			$("#linkTr").hide();
 			$('#imagetype').combobox({
                editable:false ,
                onChange:function(record){
                        var peo = $('#imagetype').combobox('getValue');
                        if(peo=="2"){	
                                /* $('#ll').css('display',"block");
                                $("#hh").css('display',"none"); */
//                                 $("#linkTr").show();
                                $("#advertImgWarming").text("iphone活动图须上传1010x1152的图片");
                                $("#advertImgWarmingA").text("安卓活动图须上传1010x1152的图片");
                                //$("#contentDiv").css("display","block");
                        }
                        else{
                        		/* $('#imagetype1').combobox('setValue',"1");
                        		$('#ll').css('display',"none");
                            $("#hh").css('display',"block"); */
//                                 $("#linkTr").hide();
                        		$("#advertImgWarming").text("iphone广告图须上传1242x2208的图片");
                        		$("#advertImgWarmingA").text("安卓手机广告图须上传1080x1920的图片");
                        	//$("#contentDiv").css("display","none");
                        }
                } 
        		});
 			
 			$('#imagetype1').combobox({
                editable:false/* ,
                onChange:function(record){
                        var peo = $('#imagetype1').combobox('getValue');
                        
                        if(peo=="2"){
                        			
                        			$('#imagetype').combobox('setValue',"2");
                                $('#ll').css('display',"block");
                                $("#hh").css('display',"none");
                        }
                        else{
                        		$('#ll').css('display',"none");
                            $("#hh").css('display',"block");
                        }
                } */
        		});
 		});
 		
 		//获取城市列表
 		$('#cityid').combobox({
	        url:'${pageContext.request.contextPath}/advertisement/getCityList',
	        valueField:'cityID',
	        textField:'showName',
	        editable: false,
	        	onSelect:function(obj){
	        		
	        	},
	        	 onLoadSuccess: function () 
	        	 { //加载完成后,设置选中第一项
	        		 var data = $('#cityid').combobox('getData');
	         	 $("#cityid").combobox('select',data[0].cityID);	                 
	          }
	    });  
 		
 		
 		 function uploadImg(tid){
 			 
 			$('#' + tid + "_f").form('submit', {
 				url : '${pageContext.request.contextPath}/upload',
 				onSubmit : function() {
 		        if ($(this).form('validate')) {
 		        	var pathTmp = document.getElementById(tid).value 
 					var imagePath = pathTmp.toLowerCase();
 						if (!/\.(png|jpg|jpeg|bmp)$/.test(imagePath)) {
 							$.messager.alert("操作提示", "图片类型必须是.png,jpeg,jpg,bmp中的一种", "");
 							return false;
 						}
 						else
 							{
 							return true;
 							}
 					}
 	                else {
 						return false;
 					}
 				},
 				success : function(result) {
 					var result = eval('(' + result + ')');
 					if (result.code != '10000') {
 						$.messager.alert("操作提示", result.message, "");
 					} else {
 						var path = result.data.relativePath;
 						var previewPath = result.data.previewPath;
 						
 						if(/* tid == "advertImg1" ||  */tid == "advertImg")
 						{
 							$("#advertImgPath").val(path);
 	 						//$("#advertImgPath1").val(path);
 						}
 						else if(/* tid == "advertImg1A" || */ tid == "advertImgA")
 						{
 							$("#advertImgPathA").val(path);
 	 						//$("#advertImgPath1A").val(path);
 						}
 						
 						//$("#advertImgPath").val(path);
 						//$("#advertImgPath1").val(path);
 						$("#" + tid +"_u").val(path);
 						$("#" + tid +"_i").attr('src','/'+previewPath);
 						$("#" + tid + "info").text("上传成功");
 					}
 				}
 			});
 			 
 			 
 			
 		 }
 		 
 		 
 		  function saveAdvert(){
 			<%-- var peo = $('#imagetype').combobox('getValue');
 			var peo1 = $('#imagetype1').combobox('getValue');

 			 if( peo == "1" || peo1=="1")
 			 {
 				$('#fm1').form('submit',{
 		            url: '<%=request.getContextPath()%>/advertisement/updateAdvert',
 		            onSubmit: function(){
 		                return $(this).form('validate');
 		            },
 		            success: function(result){
 		            	
 		            	var result = eval('('+result+')');
 		                if (result.code == '10000'){
 		                	
 		                	$.messager.alert("操作提示", result.message,"");
	 		             window.location.href = '<%=request.getContextPath()%>/jsp/advert/advertList.jsp';
	 		            
 		                	
 		                } else {
 		                	$.messager.show({
 		                		title:'提示',
 		                		msg:'<div style=" text-align:center; width:100%; font-size:20px;">系统错误！</div>',
 		                		showType:'show',
 								timeout:150000,
 		                		style:{
 		                			right:'',
 		                			top:'300px',
 		                		}
 		                	});
 		                }
 		            }
 		        });
 			 }
 			 else
 			{ --%>
 				$('#fm').form('submit',{
 		            url: '<%=request.getContextPath()%>/advertisement/updateAdvert',
 		            onSubmit: function(){
 		                return $(this).form('validate');
 		            },
 		            success: function(result){
 		            	
 		            	var result = eval('('+result+')');
 		                if (result.code == '10000'){
 		                	
 		                	 $.messager.confirm('操作结果',result.message,function(r){
 		    				if(r){ 
 		   	                window.location.href = '<%=request.getContextPath()%>/jsp/advert/advertList.jsp';
 		    				 }
 		             	});  
 		                	
 		                	
 		                	//$.messager.alert("操作提示", result.message,"");
	 		            //window.location.href = '<%=request.getContextPath()%>/jsp/advert/advertList.jsp';
	 		            
 		                	
 		                } else {
 		                	$.messager.show({
 		                		title:'提示',
 		                		msg:'<div style=" text-align:center; width:100%; font-size:20px;">系统错误！</div>',
 		                		showType:'show',
 								timeout:150000,
 		                		style:{
 		                			right:'',
 		                			top:'300px',
 		                		}
 		                	});
 		                }
 		            }
 		        });
 			//}
 			  
 		        
 		    }
 		
 		function saveAdvertCancel(){
 			/* $.messager.confirm('操作结果','确定退出？',function(r){
 				if(r){ */
	                window.location.href = '<%=request.getContextPath()%>/jsp/advert/advertList.jsp';
 				/* }
          	});  */
         }
 		
 		
 	</script>		
</body>
</html>
