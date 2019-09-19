<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="../common/header.jsp"%>
<title>每月车场回款钱数</title>
<link rel="stylesheet" href="../../css/jquery.fancybox.css"
	type="text/css" />
<script type="text/javascript" src="../../js/jquery.fancybox.pack.js"></script>
<script type="text/javascript" src="../../js/util/extendValidate.js"></script>
<style type="text/css">
.datebox-button
{
	display:none;
}
</style>
<body>
<div class="list_title">
	<span class="layui-parent-title-customer">HOME</span>
   	<span class="layui-badge-dot layui-bg-title"></span>
   	<span class="layui-children-title-customer">每月车场回款钱数</span>
</div>
	<div class="text_input">
		<span class="div_search_customerBar"></span>
		<div class="form_item">
			<div class="form_item_inline">
				<label class="form_item_label4">起始日期</label>
				<div class="form_item_input">
					<input id="createStartTime" type="text" name="createStartTime" class="easyui-datebox" />
				</div>
			</div>
			<div class="form_item_inline">
				<label class="form_item_label4">结束日期</label>
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
		<h4 class="table_data_title">每月车场回款钱数</h4>
    	<div id="main" style="height:400px"></div>
    </div>
    <!-- ECharts单文件引入 -->
    <script type="text/javascript"
	src="${pageContext.request.contextPath}/js/echarts.js"></script>
    <script src="http://echarts.baidu.com/build/dist/echarts.js"></script>
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

		setEasyUIMonthControl("createStartTime");
		setEasyUIMonthControl("createEndTime");
		      
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
	        var legends = {};  
	        var series = []; 
	        $.ajax({
	            type : "POST",
	            data:{
	            	createStartTime:createStartTimes,
	            	createEndTime:createEndTimes
	            },
	            url : "<%=request.getContextPath()%>/customerStatic/payParkByMonth",
	            dataType : "json",
	            async: false,//同步
	            success : function(result) {
	            	if(result.code='10000'){
	            		 categories = result.data.categories;  
	            		 legends = result.data.legends;
	                	 series = JSON.parse(result.data.series);
	                	 $("#createStartTime").datebox("setValue",result.data.createStartTimeTemp);
	                	 $("#createEndTime").datebox("setValue",result.data.createEndTimeTemp);
	            			
	            	}else{
	            		$.messager.alert('操作提示', result.message);
	            	}
	            }
	        });
	
	
	        var option = {
	            //图表标题
	            title: {
	                text: "每月车场回款钱数", //正标题
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
		            data:legends,
		            y:"bottom",
		            padding:-0.1
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
	            series: series
	        };
	        // 为echarts对象加载数据
	        myChart.setOption(option);
	        myChart.hideLoading(); 
	    }
	);
}
</script>


</body>