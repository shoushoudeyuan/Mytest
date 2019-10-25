<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
	<!-- BEGIN HEAD -->
    <head>
    	<meta http-equiv="Content-Security-Policy" content="default-src * data: cdvfile: gap:; style-src * 'unsafe-inline'; script-src * 'unsafe-inline' 'unsafe-eval'"/>
        <meta charset="utf-8" />
        <title>统计信息</title>
        <%@ include file="../common/header.jsp"%>

        <link href="${pageContext.request.contextPath}/metronic/assets/global/plugins/bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css" />

        <link href="${pageContext.request.contextPath}/metronic/assets/global/css/components.min.css" rel="stylesheet" id="style_components" type="text/css" />

		<style>
			body {
				font-family: "微软雅黑"!important;
				font-size: 14px;
				color: #333;
			}
			.page-content-wrapper .page-content {
				margin-left: 50px;
				margin-right: 50px;
				margin-top: 0;
				min-height: 600px;
				padding: 25px 20px 10px;
			}
			.col-lg-1, .col-lg-10, .col-lg-11, .col-lg-12, .col-lg-2, .col-lg-3, .col-lg-4, .col-lg-5, .col-lg-6, .col-lg-7, .col-lg-8, .col-lg-9, .col-md-1, .col-md-10, .col-md-11, .col-md-12, .col-md-2, .col-md-3, .col-md-4, .col-md-5, .col-md-6, .col-md-7, .col-md-8, .col-md-9, .col-sm-1, .col-sm-10, .col-sm-11, .col-sm-12, .col-sm-2, .col-sm-3, .col-sm-4, .col-sm-5, .col-sm-6, .col-sm-7, .col-sm-8, .col-sm-9, .col-xs-1, .col-xs-10, .col-xs-11, .col-xs-12, .col-xs-2, .col-xs-3, .col-xs-4, .col-xs-5, .col-xs-6, .col-xs-7, .col-xs-8, .col-xs-9 {
				position: relative;
				min-height: 1px;
				padding-left: 0.5%;
				padding-right: 0.5%;
			}

			.widget-thumb .widget-thumb-body .widget-thumb-subtitle {
				margin-bottom:6px;
			}
			.bg-purple1 {
			    background: #2AB4C0 !important;
			}
			.bg-purple2 {
			    background: #51B3DF !important;
			}
			.bg-purple3 {
			    background: #5C9BD1 !important;
			}
			.bg-purple4 {
			    background: #746590 !important;
			}
			ul,li{
				list-style:none;
			}
			.widget-thumb .widget-thumb-body .widget-thumb-body-stat {
			    float:left
			}
			.pie-charts-title{
				height:40px;
				color: #FFFFFF;
				font-size: 14;
				font-family: .PingFangSC-Medium;
				letter-spacing: -0.1px;
				padding: 12px 20px 15px;
				font-weight: 700 !important;
			}
			.pie-charts-txt{
				margin-top:10px;
				font-size:14;
				font-weight: 600;
				color: #8e9daa;
			}
			.pie-charts-label{
				font-weight: 600;
				color: #3e4f5e;
			}
			.icon-cars-customer{
				display:inline-block;
				width:30px;
				height:40px;
				background:url(${pageContext.request.contextPath}/img/car.png) no-repeat center 5px;
				background-size:30px 30px;
			}
		</style>
	</head>
    <!-- END HEAD -->

    <body class="page-header-fixed page-sidebar-closed-hide-logo">
        <!-- BEGIN HEADER & CONTENT DIVIDER -->
        <div class="clearfix"> </div>
        <!-- END HEADER & CONTENT DIVIDER -->
        <!-- BEGIN CONTAINER -->
        <div class="page-container">
            <!-- BEGIN CONTENT -->
            <div class="page-content-wrapper">
                <!-- BEGIN CONTENT BODY -->
                <div class="page-content">
                    <div class="row widget-row">
                        <div class="col-md-3" style="padding-right: 1%;">
                            <!-- BEGIN WIDGET THUMB -->
                            <div class="widget-thumb widget-bg-color-white text-uppercase margin-bottom-20 bordered" style="height:280px;">
                                <h4 class="widget-thumb-heading">累计订单租金总收入</h4>
                                <div class="widget-thumb-wrap"  style="height:108px">
									<i class="widget-thumb-icon bg-purple1" style="font-size:30px;font-style:normal">￥</i>
                                    <div class="widget-thumb-body">
                                        <span class="widget-thumb-subtitle" title="累计订单应付金额">订单租金收入</span>
                                        <div  class="widget-thumb-body-stat" ><span id="allOrderCost" data-counter="counterup" data-value="">0</span><span style="font-size: 13px;margin-top:12px;">元</span></div>
                                    </div>
                                </div>
								 <div class="widget-thumb-wrap"  style="height:108px">
									<i class="widget-thumb-icon bg-purple1 icon-wallet" ></i>
                                    <div class="widget-thumb-body">
                                        <span class="widget-thumb-subtitle" style="margin-bottom:6px;" title="累计订单实付金额">订单实际收入</span>
                                        <div  class="widget-thumb-body-stat" ><span id="allActualPaymentCost"  data-counter="counterup" data-value="">0</span><span style="font-size: 13px;margin-top:10px;">元</span></div>
                                    </div>
                                </div>
                            </div>
                            <!-- END WIDGET THUMB -->
                        </div>
                        <div class="col-md-3" style="padding-right: 1%;padding-left: 1%;">
                            <!-- BEGIN WIDGET THUMB -->
                            <div class="widget-thumb widget-bg-color-white text-uppercase margin-bottom-20 bordered" style="height:280px;">
                                <h4 class="widget-thumb-heading">本日订单租金总收入</h4>
                                <div class="widget-thumb-wrap"  style="height:108px">
									<i class="widget-thumb-icon bg-purple2" style="font-size:30px;font-style:normal">￥</i>
                                    <div class="widget-thumb-body">
                                        <span class="widget-thumb-subtitle"  title="本日订单应付金额">订单租金收入</span>
                                        <div  class="widget-thumb-body-stat" ><span id="orderCost" data-counter="counterup" data-value="">0</span><span style="font-size: 13px;margin-top:12px;">元</span></div>
                                    </div>
                                </div>
								<div class="widget-thumb-wrap"  style="height:108px">
									<i class="widget-thumb-icon bg-purple2 icon-wallet"></i>
                                    <div class="widget-thumb-body">
                                        <span class="widget-thumb-subtitle" title="本日订单实付金额">订单实际收入</span>
                                        <div  class="widget-thumb-body-stat" ><span id="actualPaymentCost" class="widget-thumb-body-stat" data-counter="counterup" data-value="">0</span><span style="font-size: 13px;margin-top:12px;">元</span></div>
                                    </div>
                                </div>
                            </div>

                            <!-- END WIDGET THUMB -->
                        </div>
                        <div class="col-md-3" style="padding-right: 1%;padding-left: 1%;">
                            <!-- BEGIN WIDGET THUMB -->
                            <div class="widget-thumb widget-bg-color-white text-uppercase margin-bottom-20 bordered" style="height:280px;">
                                <h4 class="widget-thumb-heading">订单数量</h4>
                                <div class="widget-thumb-wrap" style="height:108px">
                                    <i class="widget-thumb-icon bg-purple3 icon-bar-chart"></i>
                                    <div class="widget-thumb-body">
                                        <span class="widget-thumb-subtitle" title="支付的订单数总和">总成交支付单数</span>
                                        <span id="allPayCount" class="widget-thumb-body-stat" data-counter="counterup" data-value="">0</span>
                                    </div>
                                </div>
								<div class="widget-thumb-wrap" style="height:108px">
                                    <i class="widget-thumb-icon bg-purple3  icon-graph"></i>
                                    <div class="widget-thumb-body">
                                        <span class="widget-thumb-subtitle" title="当日完成支付的订单数">本日成交支付单数</span>
                                        <span id="payCount" class="widget-thumb-body-stat" data-counter="counterup" data-value="">0</span>
                                    </div>
                                </div>
                            </div>
                            <!-- END WIDGET THUMB -->
                        </div>
                        <div class="col-md-3" style="padding-left: 1%;">
                            <!-- BEGIN WIDGET THUMB -->
                            <div class="widget-thumb widget-bg-color-white text-uppercase margin-bottom-20 bordered" style="height:280px;">
                                <h4 class="widget-thumb-heading">实时数据</h4>
                                <div class="widget-thumb-wrap"   style="height:75px">
                                    <i class="widget-thumb-icon bg-purple4 icon-users"></i>
                                    <div class="widget-thumb-body">
                                        <span class="widget-thumb-subtitle" title="七天之内下单用户数量">周活跃</span>
                                        <div  class="widget-thumb-body-stat" ><span id="weekActiveCount" data-counter="counterup" data-value="">0</span><span style="font-size: 13px;margin-top:10px;">人次</span></div>
                                    </div>
                                </div>
								<div class="widget-thumb-wrap"   style="height:75px">
                                    <i class="widget-thumb-icon bg-purple4 "><em class="icon-cars-customer"></em></i>
                                    <div class="widget-thumb-body">
                                        <span class="widget-thumb-subtitle" title="已被下单的车辆">在租车辆</span>
                                        <div  class="widget-thumb-body-stat" ><span id="rentCarCount" data-counter="counterup" data-value="">0</span><span style="font-size: 13px;margin-top:10px;">辆</span></div>
                                    </div>
                                </div>
								<div class="widget-thumb-wrap"   style="height:75px">
                                    <i class="widget-thumb-icon bg-purple4 icon-user-following"></i>
                                    <div class="widget-thumb-body">
                                        <span class="widget-thumb-subtitle" title="上班状态的员工">在岗人员</span>
                                        <div  class="widget-thumb-body-stat" ><span id="atWorkManagerCount" data-counter="counterup" data-value="">0</span><span style="font-size: 13px;margin-top:10px;">人</span></div>
                                    </div>
                                </div>
                            </div>
                            <!-- END WIDGET THUMB -->
                        </div>
                    </div>
					 <!-- BEGIN ROW -->
					<div class="row">
						<div class="col-md-12">
							<!-- BEGIN CHART PORTLET-->
							<div class="portlet light bordered">
								<div class="portlet-title">
									<div class="caption">
										<i class="icon-bar-chart font-green-haze"></i>
										<span class="caption-subject bold uppercase font-green-haze">实际收入折线图</span>
									</div>
								</div>
								<div class="portlet-body">
									<div id="myachart" class="chart" style="height: 400px;"> </div>
								</div>
							</div>
							<!-- END CHART PORTLET-->
						</div>
					</div>
					<div class="row">
                        <div class="col-md-4">
							<div style="background: #F36F60;" class="pie-charts-title">车辆信息</div>
                            <div class="portlet light portlet-fit bordered">
                                <div class="portlet-body" style="position:relative;">
                                    <div id="echarts_pie" style="height:380px;"></div>
                                    <div style="position:absolute;top:6%;right:10%;">
										<ul>
											<li class="pie-charts-txt">运营车辆：<label class="pie-charts-label" id="operatingvehicleCount"></label></li>
											<li class="pie-charts-txt">全部车辆：<label class="pie-charts-label" id="allvehicle"></label></li>
										</ul>

									</div>
                                </div>
                            </div>
                        </div>
						<div class="col-md-4">
							<div class="pieFont pie-charts-title" style="background: #53A8E2;">车场信息</div>
                            <div class="portlet light portlet-fit bordered">
                                <div class="portlet-body" style="position:relative;">
                                    <div id="echarts_pie2" style="height:380px;"></div>
                                    <div style="position:absolute;top:6%;right:10%;">
										<ul>
											<li class="pie-charts-txt">车场总数：<label class="pie-charts-label" id="parklotCount"></label></li>
											<li class="pie-charts-txt">网点总数：<label class="pie-charts-label" id="branckCount"></label></li>
											<li class="pie-charts-txt">已占车位：<label class="pie-charts-label" id="usedParking"></label></li>
											<li class="pie-charts-txt">可用车位：<label class="pie-charts-label" id="canuseParking"></label></li>
											<li class="pie-charts-txt">全部车位：<label class="pie-charts-label" id="allParking"></label></li>
										</ul>

									</div>
                                </div>
                            </div>
                        </div>
						<div class="col-md-4">
							<div class="pieFont pie-charts-title" style="background: #FAA729;">用户信息</div>
                            <div class="portlet light portlet-fit bordered">
                                <div class="portlet-body" style="position:relative;">
	                            	<div id="echarts_pie3" style="height:380px;"></div>
	                                <div style="position:absolute;top:6%;right:10%;">
										<ul>
											<li class="pie-charts-txt">保证金用户：<label class="pie-charts-label" id="bondUserCount"></label></li>
											<li class="pie-charts-txt">&nbsp;&nbsp;认证用户：<label class="pie-charts-label" id="authenticationCount"></label></li>
											<li class="pie-charts-txt">&nbsp;&nbsp;注册用户：<label class="pie-charts-label" id="regCount"></label></li>
										</ul>
									</div>
	                        	</div>
                            </div>
                        </div>
                    </div>
					<!-- END ROW -->
				</div>
                <!-- END CONTENT BODY -->
            </div>
            <!-- END CONTENT -->
        </div>
        <!-- END CONTAINER -->
        <!-- BEGIN CORE PLUGINS -->


<script src="//frontend.mofangchuxing.com/amcharts/amcharts.js"></script>
<script src="//frontend.mofangchuxing.com/amcharts/serial.js"></script>
<script src="//frontend.mofangchuxing.com/echarts/echarts.js"></script>

<script type="text/javascript">
jQuery(document).ready(function() {
    $.ajax({
        type : "POST",
        url : "<%=request.getContextPath()%>/statisticIndex/statisticDataInfo",
        dataType : "json",
        async: false,//同步
        success : function(result) {
        	if(result.code='10000'){
        		//累计订单租金收入
        		// $("#allOrderCost").attr("data-value",result.data.allOrderCost);
    			// $("#allOrderCost").counterUp();
    			$("#allOrderCost").text(result.data.allOrderCost);

    			//累计订单实际收入
    			// $("#allActualPaymentCost").attr("data-value",result.data.allActualPaymentCost);
    			// $("#allActualPaymentCost").counterUp();
    			$("#allActualPaymentCost").text(result.data.allActualPaymentCost);

    			//成交总数
    			// $("#allPayCount").attr("data-value",result.data.allPayCount);
    			// $("#allPayCount").counterUp();
    			$("#allPayCount").text(result.data.allPayCount);

    			//本日订单租金收入
    			// $("#orderCost").attr("data-value",result.data.orderCost);
    			// $("#orderCost").counterUp();
    			$("#orderCost").text(result.data.orderCost);

    			//本日订单实际收入
    			// $("#actualPaymentCost").attr("data-value",result.data.actualPaymentCost);
    			$("#actualPaymentCost").text(result.data.actualPaymentCost);

    			//本日成交总数
    			$("#payCount").text(result.data.payCount);
    			// $("#payCount").counterUp();

    			//周活跃
    			$("#weekActiveCount").text(result.data.weekActiveCount);
    			// $("#weekActiveCount").counterUp();

    			//在租车辆
    			$("#rentCarCount").text(result.data.rentCarCount);
    			// $("#rentCarCount").counterUp();

    			//在岗人员
    			$("#atWorkManagerCount").text(result.data.atWorkManagerCount);
    			// $("#atWorkManagerCount").counterUp();

        	}else{
        		$.messager.alert('操作提示', result.message);
        	}
        }
    });

    //车辆信息
    var myChart1Data = [];
        $.ajax({
            type : "POST",
            url : "<%=request.getContextPath()%>/statisticIndex/vehicleInfoCount",
            dataType : "json",
            async: false,//同步
            success : function(result) {
            	if(result.code='10000'){
            		myChart1Data = result.data.charts;
            		$('#operatingvehicleCount').text(result.data.operatingvehicleCount+"台");
            		$('#allvehicle').text(result.data.allCount+'台');
            	}else{
            		$.messager.alert('操作提示', result.message);
            	}
            }
        });

      //车场信息
    var myChart2Data = [];
        $.ajax({
            type : "POST",
            url : "<%=request.getContextPath()%>/statisticIndex/vehicleParkInfoCount",
            dataType : "json",
            async: false,//同步
            success : function(result) {
            	if(result.code='10000'){
            		myChart2Data = result.data.charts;
            		//alert("全部车位"+result.data.allCount+"已占"+result.data.usedCount+"可用"+result.data.canUseCount+"车场总数"+result.data.parklotCount+"网点总数"+result.data.branckCount);
            		$('#parklotCount').text(result.data.parklotCount);
            		$('#branckCount').text(result.data.branckCount);
            		$('#usedParking').text(result.data.usedCount);
            		$('#canuseParking').text(result.data.canUseCount);
            		$('#allParking').text(result.data.allCount);
            	}else{
            		$.messager.alert('操作提示', result.message);
            	}
            }
        });
    //用户信息
    var myChart3Data = [];
    $.ajax({
        type : "POST",
        url : "<%=request.getContextPath()%>/statisticIndex/userInfoCount",
        dataType : "json",
        async: false,//同步
        success : function(result) {
        	if(result.code='10000'){
        		myChart3Data = result.data.charts;
        		$('#bondUserCount').text(result.data.bondUserCount);
        		$('#authenticationCount').text(result.data.authenticationCount);
        		$('#regCount').text(result.data.allCount);
        	}else{
        		$.messager.alert('操作提示', result.message);
        	}
        }
    });

	var myChart1 = echarts.init(document.getElementById('echarts_pie'));
	myChart1.setOption({
		tooltip: {
			show: true,
			formatter: "{a} <br/>{b} : {c} ({d}%)"
		},
		legend: {
			orient: 'horizontal',
			y: 'bottom',
			x:'16%',
			data: ['运营车辆', '下线车辆']
		},
		//饼图颜色设置
		color:['#F36F60','#FACAC5'],
		calculable: true,
		series: [ {
			type: 'pie',
			clockWise: true,
			startAngle: 135,
			center: ['33%', '50%'],
			//设置图的大小
			radius: ['38%', '60%'],
			itemStyle: {
				normal: {
					label: {
						show: false
					},
					labelLine: {
						show: false
					}
				},
				emphasis: {
					color: function(params) {
						// 鼠标放到饼图上颜色设置
						var colorList = [
						  '#E24E3D','#E24E3D'
						];
						return colorList[params.dataIndex]
					},
					label: {
						show: true,
						position: 'center',
						formatter: "{d}%",
						textStyle: {
							color: '#E24E3D',
							fontSize: '30',
							fontFamily: 'Open Sans',
							fontWeight: 'bold'
						}
					}
				}
			},
			data: myChart1Data
		}]
	});
	//图位置自适应
	$("#echarts_pie").resize(function(){
		  $(myChart1).resize();
	   })

	var myChart2 = echarts.init(document.getElementById('echarts_pie2'));
	myChart2.setOption({
		tooltip: {
			show: true,
			formatter: "{a} <br/>{b} : {c} ({d}%)"
		},
		legend: {
			orient: 'horizontal',
			y: 'bottom',
			x:'16%',
			data: ['可用车位', '已占车位']
		},
		//饼图颜色设置
		color:['#53A8E2','#87CEFF'],
		calculable: true,
		series: [ {
			type: 'pie',
			clockWise: true,
			startAngle: 135,
			center: ['33%', '50%'],
			//设置图的大小
			radius: ['38%', '60%'],
			itemStyle: {
				normal: {
					label: {
						show: false
					},
					labelLine: {
						show: false
					}
				},
				emphasis: {
					color: function(params) {
						// 鼠标放到饼图上颜色设置
						var colorList = [
						  '#378FCA','#378FCA'
						];
						return colorList[params.dataIndex]
					},
					label: {
						show: true,
						position: 'center',
						formatter: "{d}%",
						textStyle: {
							color: '#378FCA',
							fontSize: '30',
							fontFamily: 'Open Sans',
							fontWeight: 'bold'
						}
					}
				}
			},
			data: myChart2Data
		}]
	});
	//图位置自适应
	$("#echarts_pie2").resize(function(){
	  $(myChart2).resize();
    })

	var myChart3 = echarts.init(document.getElementById('echarts_pie3'));
	myChart3.setOption({
		tooltip: {
			show: true,
			formatter: "{a} <br/>{b} : {c} ({d}%)"
		},
		legend: {
			orient: 'horizontal',
			y: 'bottom',
			x:'5%',
			data: ['普通用户', '保证金用户', '意向用户']
		},
		//饼图颜色设置
		color:['#FAA729','#FFD173','#FFE2B7'],
		calculable: true,
		series: [ {
			type: 'pie',
			clockWise: true,
			startAngle: 135,
			center: ['33%', '50%'],
			//设置图的大小
			radius: ['38%', '60%'],
			itemStyle: {
				normal: {
					label: {
						show: false
					},
					labelLine: {
						show: false
					}
				},
				emphasis: {
					color: function(params) {
						// 鼠标放到饼图上颜色设置
						var colorList = [
						  '#E6961D','#E6961D','#E6961D','#E6961D'
						];
						return colorList[params.dataIndex]
					},
					label: {
						show: true,
						position: 'center',
						formatter: "{d}%",
						textStyle: {
							color: '#E6961D',
							fontSize: '30',
							fontFamily: 'Open Sans',
							fontWeight: 'bold'
						}
					}
				}
			},
			data: myChart3Data
		}]
	});
	//图位置自适应

	$("#echarts_pie3").resize(function(){
		$(myChart3).resize();
	})

    var amChartsData = [];
    $.ajax({
            type : "POST",
            url : "<%=request.getContextPath()%>/statisticIndex/realIncomeMoney",
            dataType : "json",
            async: false,//同步
            success : function(result) {
            	if(result.code='10000'){
            		 amChartsData = result.data;
            	}else{
            		$.messager.alert('操作提示', result.message);
            		myChart.setOption(option);
            	}
            }
        });
    initChartSample(amChartsData);

    //折线图
    function initChartSample(amChartsData) {
        var chart = AmCharts.makeChart("myachart", {
        	"type": "serial",
        	"theme": "light",

        	"fontFamily": 'Open Sans',
        	"color":    '#485465',

        	"pathToImages": "//frontend.mofangchuxing.com/amcharts/images/",

        	"dataProvider": amChartsData,
        	"valueAxes": [{
        		//"duration": "mm",
        		//"durationUnits": {
        		//	"hh": "h ",
        		//	"mm": "min"
        		//},
        		"axisAlpha": 0
        	}],
        	"graphs": [{
        		"bullet": "square",
        		"bulletBorderAlpha": 1,
        		"bulletBorderThickness": 1,
        		"fillAlphas": 0.3,
        		"fillColorsField": "lineColor",
        		"legendValueText": "[[value]]",
        		"lineColorField": "lineColor",
        		"title": "duration",
        		"valueField": "duration"
        	}],
        	"chartCursor": {
        		"categoryBalloonDateFormat": "YYYY-MM-DD",
        		"cursorAlpha": 0,
        		"zoomable": false
        	},
        	"dataDateFormat": "YYYY-MM-DD",
        	"categoryField": "date",

        	"categoryAxis": {
        		"dateFormats": [{
        			"period": "DD",
        			"format": "MM-DD"
        		}, {
        			"period": "MM",
        			"format": "MM-DD"
        		}, {
        			"period": "YYYY",
        			"format": "MM-DD"
        		}],
        		"parseDates": true,
        		"autoGridCount": false,
        		"axisColor": "#555555",
        		"gridAlpha": 0,
        		"gridCount": 50
        	}
        });

        $('#myachart').closest('.portlet').find('.fullscreen').click(function() {
        	chart.invalidateSize();
        });
    }
});
</script>
</body>

</html>
