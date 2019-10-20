<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html>
<head>

<title>在场车辆</title>
<%@ include file="../common/header.jsp"%>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/jquery.json.js"></script>
<script type="text/javascript" src="https://api.map.baidu.com/api?v=2.0&ak=d8Y2ytqiXP2WGUQENmcGQgjWw29aovkg"> </script>
	<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/DrawingManager_min.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/SearchInfoWindow_min.js"></script>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/DrawingManager_min.css"
	type="text/css" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/SearchInfoWindow_min.css"
	type="text/css" />

</head>
<body>
<div class="list_title">
	<span class="layui-parent-title-customer">HOME</span>
    <span class="layui-badge-dot layui-bg-title"></span>
    <span class="layui-children-title-customer">在场车辆查询</span>
</div>
<div class="text_input">
	<span class="div_search_customerBar"></span>	
		<form id='fm_s' action="">
			<div class="form_item">
				<div class="form_item_inline">
					<label class="form_item_label2">车场</label>
					<div class="form_item_input">
						<select class="easyui-combobox" style="width:100px;" id="carPortName1" name="carPortId" ></select>
					</div>
				</div>
				<div class="form_item_inline">
					<label class="form_item_label2">网点</label>
					<div class="form_item_input">
						<select class="easyui-combobox" style="width:100px;" id="serviceName1" name="serviceId" ></select>
					</div>
				</div>
				<div class="form_item_inline">
					<label class="form_item_label2">状态</label>
					<div class="form_item_input">
						<select id="statusing" name="statusing" class="easyui-combobox" style="width: 100px;">
							<option value=''>全部</option>
							<option value='7'>可用</option>
							<option value='9'>任务中</option>
							<option value='12'>待整备</option>
							<option value='14'>维修中</option>
						</select> 
					</div>
				</div>
				<div class="form_item_inline">
					<label class="form_item_label2">城市</label>
					<div class="form_item_input">
						<select id="selectCity" name="cityId" class="easyui-combobox" style="width: 100px;"></select> 
					</div>
				</div>
				<div class="form_item_inline">
					<input type="button" onclick="search()" class="text_input_button_search" value="查询">
				</div>
			</div>
		</form>
	</div>
    
    
    
     <div class="table_data">
		<h4 class="table_data_title">
			在场车辆查询
			<div class="text_input_bottom">
			    <input id="btnExport" type="button"
							class="text_input_button text_input_button_left" value="导出">
			
			</div>
		</h4>
		<table id="dg" style="width: 100%;"></table>
	</div>

	
	
    
    

	<script type="text/javascript">
	
   //初始化页面
    $(function(){
    	//初始化服务城市
    	$("#selectCity").combobox({
    		url:'<%=request.getContextPath()%>/city/getServiceCityList',
    		valueField:'id',
    		textField:'showname'
    	});
    	
    	//初始化列表
		setAutoHeight(270,"dg"); 
    	$('#dg').datagrid({
  			url:'<%=request.getContextPath()%>/numericalController/getCarParkingList',
  			toolbar:$('#toolbar'),
  			rownumbers:true,
  			columns :  [[ 
  			{
 				field : 'id',
 				hidden : true,
 				title : '序号'
 			},{
 				field : 'parkNameOrbranchname',
 				title : '车场/网点名称',
 				width : '20%'
 			}, {
 				field : 'vehiclemodelname',
 				title : '车辆型号',
 				width : '17%'
 			}, {
 				field : 'platenumber',
 				title : '车牌号',
 				width : '17%'
 			}, {
 				field : 'mileage',
 				title : '车辆电量',
 				width : '17%'
 			}, {
 				field : 'electricity',
 				title : '可行驶里程数',
 				width : '16.5%'
 			}, {
 				field : 'status',
 				title : '状态',
 				width : '14.5%',
 				formatter:formatStatus
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

   
    $("#btnExport").click(function(){
    	var queryParam = getFormJson($("#fm_s")[0]);
    	var url = "<%=request.getContextPath()%>/numericalController/allLists?"+$.param(queryParam);
 		window.open(url);
 	});
    
    
    function getFormJson(form) {
		var o = {};
		var a = $(form).serializeArray();
		$.each(a, function() {
			if (o[this.name] !== undefined) {
				if (!o[this.name].push) {
					o[this.name] = [ o[this.name] ];
				}
				o[this.name].push(this.value || '');
			} else {
				o[this.name] = this.value || '';
			}
		});
		return o;
	}

    function formatStatus(val,row){
	    var temp ='可用';
		if('7' == val){
			temp = '可用';
		}
		else if('8' == val){
			temp = '已租';
		}
		else if('9' == val){
			temp = '任务中';
		}else if('12' == val){
			temp = '待整备';
		}else if('13' == val){
			temp = '调整中';
		}else if('14' == val){
			temp = '维修中';
		}
		else if('15' == val){
			temp = '保养中';
		}
		else if('16' == val){
			temp = '换车中';
		}
		
		return temp;
	}
		
    //加载车场
    function loadCarPort(cityId)
    {
		var url = '/bjyvms/carPort/carPortNameList';
		if(cityId != null && cityId != -1)
			{
			url += '?cityId='+ cityId;
			}
		$('#carPortName1').combobox({
			url:url,
	        editable: false,
	        valueField: 'id',
	        textField: 'name',
	        value:'',
	        onSelect:function(obj)
	        {
	        	loadService(obj.id)
	    	}
	    });
    }
    $("#selectCity").combobox({
		url:'${pageContext.request.contextPath}/city/getServiceCityList',
		valueField:'id',
		textField:'showname',
		onSelect:function(obj){
		loadCarPort(obj.id)
		}
	});
    //加载网点
    function loadService(carPortId)
    {
    	var url = '/bjyvms/carPort/serviceNameList';
    	if(carPortId != null && carPortId != -1)
		{
		url += '?id='+ carPortId;
		}
		$('#serviceName1').combobox({
			url:url ,
	        editable: false,
	        valueField: 'id',
	        textField: 'branchName',
	        value:''

	    });
    }
		//查询方法
		function search() {
			$('#dg').datagrid('load');
		}
		
	</script>
</body>
</html>
