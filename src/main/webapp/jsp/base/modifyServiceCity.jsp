<%@ page language="java" pageEncoding="UTF-8"  import="org.owasp.esapi.ESAPI" %>
<!DOCTYPE HTML>
<html>
  <head>
  	<meta http-equiv="Content-Security-Policy" content="default-src * data: cdvfile: gap:; style-src * 'unsafe-inline'; script-src * 'unsafe-inline' 'unsafe-eval'"/>
    <title>提供租车服务的城市</title>
  <%@ include file="../common/header.jsp" %>

 	
  </head>
<body>
	<form id="fm" method="post">
		<input type="hidden" name="csrftoken" value="<%=session.getAttribute("csrftoken").toString()%>"/>
		<div class="model_form_item">
			<div class="model_form_item_inline_left">
				<label class="model_form_item_label6"><span class="mode_form_dot">*</span>省/直辖市</label>
				<div class="model_form_item_input">
					<input name="id" hidden="true" style="display: none;">
					<input id="provinceid" name="provinceid" style="width: 170px;" class="easyui-combobox" data-options="required:true,validateOnCreate:false,validateOnBlur:true">
				</div>
			</div>
			<div class="model_form_item_inline_right">
				<label class="model_form_item_label6"><span class="mode_form_dot">*</span>市</label>
				<div class="model_form_item_input">
					<input id="cityid" name="cityid" style="width: 50%;" class="easyui-combobox" data-options="required:true,validateOnCreate:false,validateOnBlur:true"></td>
				</div>
			</div>
		</div>
		<div class="model_form_item">
			<div class="model_form_item_inline_left">
				<label class="model_form_item_label6">县</label>
				<div class="model_form_item_input">
					<input id="countyid" name="countyid" style="width: 50%;" class="easyui-combobox" data-options="validateOnCreate:false,validateOnBlur:true">
				</div>
			</div>
			<div class="model_form_item_inline_right">
				<label class="model_form_item_label6"><span class="mode_form_dot">*</span>城市真实ID</label>
				<div class="model_form_item_input">
					<input id="county" name="county" class="easyui-textbox"  style="width:50%" data-options="required:true,validateOnCreate:false,validateOnBlur:true" readOnly />
				</div>
			</div>
		</div>
		<div class="model_form_item">
			<div class="model_form_item_inline_left">
				<label class="model_form_item_label6"><span class="mode_form_dot">*</span>城市真实姓名</label>
				<div class="model_form_item_input">
					<input id="realname" name="realname" class="easyui-textbox"  style="width:50%" data-options="required:true,validateOnCreate:false,validateOnBlur:true" readOnly />
				</div>
			</div>
			<div class="model_form_item_inline_right">
				<label class="model_form_item_label6"><span class="mode_form_dot">*</span>城市显示名</label>
				<div class="model_form_item_input">
					<input id="showname" name="showname" class="easyui-textbox"  style="width:50%" data-options="required:true,validateOnCreate:false,validateOnBlur:true">
				</div>
			</div>
		</div>
		<div class="model_form_item">
			<div class="model_form_item_inline_left">
				<label class="model_form_item_label6">状态</label>
				<div class="model_form_item_input">
					<input type="radio" name="status" value='0' />禁用
               	    <input type="radio" name="status" value="1"  />启用
				</div>
			</div>
			<div class="model_form_item_inline_right">
				<label class="model_form_item_label6"><span class="mode_form_dot">*</span>显示顺序</label>
				<div class="model_form_item_input">
					<input id="showorder" name="showorder" class="easyui-textbox"  style="width:50%" data-options="required:true,validateOnCreate:false,validateOnBlur:true">
				</div>
			</div>
		</div>
		<div class="model_form_item">
			<div class="model_form_item_inline_left">
				<label class="model_form_item_label6"><span class="mode_form_dot">*</span>城市经度</label>
				<div class="model_form_item_input">
					<input id="citylon" name="citylon" class="easyui-textbox"  style="width:50%" data-options="required:true,validateOnCreate:false,validateOnBlur:true">
				</div>
			</div>
			<div class="model_form_item_inline_right">
				<label class="model_form_item_label6"><span class="mode_form_dot">*</span>城市纬度</label>
				<div class="model_form_item_input">
					<input id="citylat" name="citylat" class="easyui-textbox"  style="width:50%" data-options="required:true,validateOnCreate:false,validateOnBlur:true">
				</div>
			</div>
		</div>
		
		
	<!-- 	<input name="id" hidden="true" style="display: none;">
            <table class="pop_table">
            <tr>
            <td><span style="color: red;">*</span>省/直辖市</td>
            <td><input id="provinceid" name="provinceid" style="width: 50%;"
				class="easyui-combobox"
				data-options="required:true,validateOnCreate:false,validateOnBlur:true">
				</td>
            </tr>
            <tr>
            <td><span style="color: red;">*</span>市</td>
            <td><input id="cityid" name="cityid" style="width: 50%;"
				class="easyui-combobox"
				data-options="required:true,validateOnCreate:false,validateOnBlur:true"></td>
            </tr>
            <tr>
            <td>县</td>
            <td><input id="countyid" name="countyid" style="width: 50%;"
				class="easyui-combobox"
				data-options="validateOnCreate:false,validateOnBlur:true"></td>
            </tr>
            <tr>
            <td>城市真实ID</td>
            <td><input id="county" name="county" class="easyui-textbox"  style="width:50%"
            	   data-options="required:true,validateOnCreate:false,validateOnBlur:true" readOnly /></td>
            </tr>
            <tr>
            <td>城市真实姓名</td>
            <td> <input id="realname" name="realname" class="easyui-textbox"  style="width:50%"
            	   data-options="required:true,validateOnCreate:false,validateOnBlur:true" readOnly /></td>
            </tr>
            <tr>
            <td><span style="color: red;">*</span>城市显示名</td>
            <td><input id="showname" name="showname" class="easyui-textbox"  style="width:50%"
            	   data-options="required:true,validateOnCreate:false,validateOnBlur:true"></td>
            </tr>
            <tr>
            <td>状态</td>
            <td><input type="radio" name="status" value='0' />禁用
               	    <input type="radio" name="status" value="1"  />启用</td>
            </tr>
            <tr>
            <td>显示顺序</td>
            <td><input id="showorder" name="showorder" class="easyui-textbox"  style="width:50%"
              	 data-options="required:true,validateOnCreate:false,validateOnBlur:true"></td>
            </tr>
            <tr>
            <td><span style="color: red;">*</span>城市经度</td>
            <td><input id="citylon" name="citylon" class="easyui-textbox"  style="width:50%"
             	 data-options="required:true,validateOnCreate:false,validateOnBlur:true"></td>
            </tr>
            <tr>
            <td><span style="color: red;">*</span>城市纬度</td>
            <td><input id="citylat" name="citylat" class="easyui-textbox"  style="width:50%"
             	 data-options="required:true,validateOnCreate:false,validateOnBlur:true"></td>
            </tr>
            </table> -->
            <div class="float_div" style="clear:both">
            	<div class="text_input_button_cancel" onclick="$('#modify').window('close');">取消</div>
                <div class="text_input_button_float" onclick="save();">保存</div>
            </div>
       </form>
	<script type="text/javascript">
	
		//车场下列表是否第一次加载(用于编辑页面三连动)
	    var isCityLoad=false;
	  	//网点下拉列表是否第一次加载(用于编辑页面三连动)
	    var isCountyLoad=false;
  	
 		$(function(){			
 			var serviceCityId = '<%=ESAPI.encoder().encodeForJavaScript(request.getParameter("id"))%>';
 			if(! (serviceCityId == 'null')){
 				//每点击一次默认第一次加载页面
 		    	isProvinceLoad=true;
 		    	isCityLoad=true;
 		    	isCountyLoad=true;
 				var selectPath = '<%=request.getContextPath()%>/city/select';
 	    		$.post(selectPath,{id:serviceCityId},function(result){
 	    			if(result.success){
 	    				//加载服务城市
 	 		    		  getCityList(result.serviceCity.provinceid,result.serviceCity.cityid,result.serviceCity.countyid);
 	 		    		  var _chexing = $('#selectModel_').combobox({
 	 		                  disabled: true,
 	 		                  valueField: 'id',
 	 		                  textField: 'modelname'
 	 		              });

 	    			  $('#fm').form('load',result.serviceCity);
 	    			 $("#county").textbox('setValue',result.serviceCity.countyid)
 	    			 }else{
 	    				$.messager.alert('操作提示','查询用户错误!');
 	    			}
 	    			
 	    		},'json');
 			}else{
 				getCityLists();
 				$.each($("input[name='status']"),function(i,v){
 	 	        	if(0==v.value){
 	 	        		v.checked='checked';
 	 	        	}
 	 	        });
 			}
 			
 		});
 		
		  function save(){
		        $('#fm').form('submit',{
		            url: '<%=request.getContextPath()%>/city/update',
		            onSubmit: function(){
	                	return $(this).form('validate');
	                },
		            success: function(result){
		                if (result==2){
		                	$.messager.alert('操作提示','操作失败!');
		                    $('#modify').window('close');
		                }else if(result==4){
		                	$.messager.alert('操作提示','该服务城市下有车辆，不能禁用');
		                }else if(result==3){
		                	$.messager.alert('操作提示','服务城市数量超过2个，不可添加');
		                }  else {
		                	$('#dg').datagrid('reload');
		                	$('#modify').window('close');
		                	$.messager.alert('操作提示','操作成功!');
		                }
		            }
		        }); 
		    }
 			function getCityLists(){		
				var requestUrl="<%=request.getContextPath()%>/area/getProvince";
				$('#provinceid').combobox({    
				    url:requestUrl,    
				    valueField:'id',    
				    textField:'name',
				    onSelect: function(requestUrl){   
				    	$("#county").textbox('setValue',requestUrl.id),
				    	$("#realname").textbox('setValue',requestUrl.full_name)
				    	//$("#showname").textbox('setValue',requestUrl.name)
				    	var requestUrl="<%=request.getContextPath()%>/area/getCityOrCounty?id="+requestUrl.id;    
			            $('#cityid').combobox({
			            	url:requestUrl,    
			    		    valueField:'id',    
			    		    textField:'name',
			    		    onSelect:function(requestUrl){	
			    		    	$("#county").textbox('setValue',requestUrl.id),
	    				    	$("#realname").textbox('setValue',requestUrl.full_name)
	    				    	//$("#showname").textbox('setValue',requestUrl.name)
			    		    	var requestUrl="<%=request.getContextPath()%>/area/getCityOrCounty?id="	+ requestUrl.id;
			    		    	$('#countyid').combobox({    
			    				    url:requestUrl,    
			    				    valueField:'id',    
			    				    textField:'name',
			    				    onSelect:function(requestUrl){
			    				    	$("#county").textbox('setValue',requestUrl.id),
			    				    	$("#realname").textbox('setValue',requestUrl.full_name),
			    				    	//$("#showname").textbox('setValue',requestUrl.name),
			    				    	$("#showorder").textbox('setValue',"1")
			    				    }
			    				}).combobox('clear'); 
			    		    }
			            }).combobox('clear');    
			        }
				});  
			}

 		 //1.获取可服务城市列表
 			function getCityList(proid,cityid,countyid){		
 				var requestUrl="<%=request.getContextPath()%>/area/getProvince";
 				$('#provinceid').combobox({    
 				    url:requestUrl,    
 				    valueField:'id',    
 				    textField:'name',
 				    onSelect: function(requestUrl){   
 				    	$("#county").textbox('setValue',requestUrl.id),
				    	$("#realname").textbox('setValue',requestUrl.full_name)
				    	//$("#showname").textbox('setValue',requestUrl.name)
 				    	getParkListByCity(requestUrl.id,cityid,countyid);
 				    	//console.log('1.getCityList>>onSelect');
 			        },
 			        onLoadSuccess:function(list){
 			        	//alert(11);
 			        	//console.log('1.getCityList>>onLoadSuccess');
 			        	//console.log('1.getCityList>>onSelect');
 			        	if(proid != null && list.length>1  && isProvinceLoad==true){//本应判断length>0即可.But数据源中有一个请选择,你懂的.
 			        		//console.log('1.getCityList>>onLoadSuccess>>if&isFirstLoad='+isProvinceLoad);
 			        		$('#provinceid').combobox('setValue', proid);
 			        		isProvinceLoad=false;
 			        	}
 			        }
 				});  
 		 	}
 		 	
 		 	//2.根据服务城市获取车场列表
 			function getParkListByCity(proid,cityid,countyid){
 				var requestUrl="<%=request.getContextPath()%>/area/getCityOrCounty?id="+proid; 
 		        $('#cityid').combobox({
 		        	url:requestUrl,    
 				    valueField:'id',    
 				    textField:'name',
 				    onSelect:function(requestUrl){
 				    	$("#county").textbox('setValue',requestUrl.id),
				    	$("#realname").textbox('setValue',requestUrl.full_name)
				    	//$("#showname").textbox('setValue',requestUrl.name)
 				    	//console.log('2.getParkListByCity>>onSelect');
 				    	getBranchListByPark(requestUrl.id,countyid);	    		    	
 				    },
 			        onLoadSuccess:function(list){
 			        	//alert(cityid);
 			        	//console.log('2.getParkListByCity>>onLoadSuccess');
 			        	if(cityid != null && list.length>0 && isCityLoad==true){
 			        		$('#cityid').combobox('setValue', cityid);
 			        		//console.log('bid='+bid);
 				        		isCityLoad=false;
 			        	}
 			        }
 		        }).combobox('clear');    
 		 	}
 		 	
 			//3.根据车场ID获取网点列表
 			function getBranchListByPark(cityid,countyid){
 				var requestUrl="<%=request.getContextPath()%>/area/getCityOrCounty?id="+cityid;
 		    	$('#countyid').combobox({    
 				    url:requestUrl,    
 				    valueField: 'id',
 			        textField: 'name',
 			       onSelect:function(requestUrl){
 			    	  $("#county").textbox('setValue',requestUrl.id),
				    	$("#realname").textbox('setValue',requestUrl.full_name)
				    	//$("#showname").textbox('setValue',requestUrl.name)   		    	
				    },
 			        onLoadSuccess:function(list){
 			        	//console.log('3.getBranchListByPark>>onLoadSuccess');
 			        	//alert(33);
 			        	if(countyid != null && list.length>1 && isCountyLoad==true){
 			        		//console.log('3.getBranchListByPark>>onLoadSuccess>>if&isFirstLoad='+isCountyLoad);
 			        		$('#countyid').combobox('setValue', countyid);
 			        		isCountyLoad=false;
 			        	}
 			        }
 				}).combobox('clear'); 
 		 	}
 	</script>		
</body>
</html>
