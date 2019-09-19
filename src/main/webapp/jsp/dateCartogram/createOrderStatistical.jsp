<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="../common/header.jsp"%>
<title>订单</title>
<link rel="stylesheet" href="../../css/jquery.fancybox.css"
	type="text/css" />
<script type="text/javascript" src="../../js/jquery.fancybox.pack.js"></script>
<script type="text/javascript" src="../../js/util/extendValidate.js"></script>
<body>
<div class="list_title">
	<span class="layui-parent-title-customer">HOME</span>
    <span class="layui-badge-dot layui-bg-title"></span>
    <span class="layui-children-title-customer">每日创建订单</span>
</div>
	<div class="text_input">
		<span class="div_search_customerBar"></span>
			<div class="form_item">
				<div class="form_item_inline">
					<label class="form_item_label4">起始月份</label>
					<div class="form_item_input">
						<input id="createStartTime" type="text" name="createStartTime" class="easyui-datebox" />
					</div>
				</div>
				<div class="form_item_inline">
					<label class="form_item_label4">结束月份</label>
					<div class="form_item_input">
						<input id="createEndTime" type="text" name="createEndTime" class="easyui-datebox" />
					</div>
				</div>
				<div class="form_item_inline">
					<input type="button" onclick="SetChart()" class="text_input_button_search" value="查询">
				</div>
			</div>
	</div>
	<!-- 为ECharts准备一个具备大小（宽高）的Dom -->
	  <div class="table_data">
		<h4 class="table_data_title">每日创建订单</h4>
    	<div id="main" style="height:400px"></div>
      </div>
    <!-- ECharts单文件引入 -->
    <script type="text/javascript"
	src="${pageContext.request.contextPath}/js/echarts.js"></script>
    <script src="http://echarts.baidu.com/build/dist/echarts.js"></script>
 <!--    <div id="main" style="height:400px"></div> -->
<script type="text/javascript">
	var myChart; 
	var eCharts; 
	// 路径配置
	require.config({
		paths : {
			echarts : 'http://echarts.baidu.com/build/dist'
		}
	});
	$(function(){
		   //日期初始化 add cjl
		   var curr_time = new Date();
		   var strDate = curr_time.getFullYear()+"-";
		   strDate += curr_time.getMonth()+1+"-";
		   strDate += curr_time.getDate()+"-";
		   $("#createEndTime").datebox("setValue",strDate);
		   
		   var strDate1 = curr_time.getFullYear()+"-";
		   strDate1 += curr_time.getMonth()+1+"-";
		   strDate1 += curr_time.getDate()-6+"-";
		   
		   $("#createStartTime").datebox("setValue",strDate1);
		SetChart();
	});
	
	function SetChart()
	{
		require([ 'echarts', 'echarts/chart/line', 'echarts/chart/bar' // 使用柱状图就加载bar模块，按需加载
		],  function (ec) {
			var createStartTimes = $('#createStartTime').datetimebox('getValue');
			var createEndTimes = $('#createEndTime').datetimebox('getValue');
	        // 基于准备好的dom，初始化echarts图表
	        eCharts = ec; 
	        myChart = ec.init(document.getElementById('main'));
	        myChart.showLoading({ 
	            text : "图表数据正在努力加载..." 
	        });
	        var categories = [];  
	        var values = [];  
	        $.ajax({
	            type : "POST",
	            data:{
	            	createStartTime:createStartTimes,
	            	createEndTime:createEndTimes
	            },
	            url : "<%=request.getContextPath()%>/numericalController/getCreateOrder",
	            dataType : "json",
	            async: false,//同步
	            success : function(result) {
	            	if(result.code='10000'){
	            		 categories = result.data.categories;  
	                	 values = result.data.values;  
	            	}else{
	            		$.messager.alert('操作提示', result.message);
	            	}
	            }
	        });
	
		
	        var option = {
	            //图表标题
	            title: {
	                text: "每日创建的订单数量", //正标题
	                x: "center", //标题水平方向位置
	                //正标题样式
	                textStyle: {
	                    fontSize:24
	                },
	                //副标题样式
	                subtextStyle: {
	                    fontSize:12,
	                    color:"red"
	                }
	            },
	            //数据提示框配置
	            tooltip: {
	                trigger: 'axis' //触发类型，默认数据触发，见下图，可选为：'item' | 'axis' 其实就是是否共享提示框
	            },
	            //图例配置
	            legend: {
	                data: ['订单'], //这里需要与series内的每一组数据的name值保持一致
	                y:"bottom"
	            },
	            //工具箱配置
	            toolbox: {
	                show : true,
	                feature : {
	                    restore : {show: true}, // 还原，复位原始图表，上图icon左数9，还原
	                    saveAsImage : {show: true} // 保存为图片，上图icon左数10，保存
	                }
	            },
	            calculable: true,
	            //轴配置
	            xAxis: [
	                {
	                    type: 'category',
	                    data: categories,
	                    name: "日期"
	                }
	            ],
	            //Y轴配置
	            yAxis: [
	                {
	                    type: 'value',
	                    splitArea: { show: true },
	                    name:"数值"
	                }
	            ],
	            //图表Series数据序列配置
	            series: [
	                {
	                    name: '订单',
	                    type: 'line',
	                    data: values
	                }
	            ]
	        };
	        // 为echarts对象加载数据
	        myChart.setOption(option);
	        myChart.hideLoading(); 
	    }
	);
}
</script>
</body>