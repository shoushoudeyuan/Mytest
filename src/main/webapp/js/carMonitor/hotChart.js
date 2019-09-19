(function(){
	var chart = echarts.init(document.getElementById('hot'));
	var option = {
		    backgroundColor: 'rgba(0,0,0,0)',
		    title: {
		        text: '',
		        color: 'white'
		    },
		    legend: {
		        right: 10,
		        itemHeight:200,
		        data: ['10','20'],
		        show: false,
		        formatter:function(name){
		        	if(name == '10')
		        		return '取车';
		        	else
		        		return '还车';
		        }
		    },
		    grid:{
		        x:25,
		        y:25,
		        x2:25,
		        y2:25,
		      },
		    xAxis: {
		        splitLine: {
		            lineStyle: {
		                type: 'dashed',
		                color:"rgba(0,0,0,0.8)"
		            }
		        },
		        
		        axisLabel:{
		            formatter: function (value, index) {
		            	if(value == 0)
		            		return "";
		            	
		            	var d = new Date();
		            	d.setDate(d.getDate()+(index -4));
		            	return (d.getMonth() + 1) + "/" + d.getDate();
		            },
		            align:'center',
		            textStyle:{
		            	color:"rgba(255,255,255,0.3)"
		            }
		        },
		        min:0,
		        max:300,
		        minInterval:100
		    },
		    yAxis: {
		        splitLine: {
		            lineStyle: {
		                type: 'dashed',
		                color:"rgba(0,0,0,0.8)"
		                
		            }
		        },
		        scale: true,
		        interval:6,
		        min:0,
		        max:24.1,
		        axisLabel:{
		        	textStyle:{
				          color:"rgba(255,255,255,0.3)",
				          fontSize:'12'
		        	}
		        }
		    },
		    series: [{
		        name: '10',
		        data: [],
		        
		        type: 'scatter',
		        symbolSize: function(value,params) {
	                return value[2] ;
	            },
		        label: {
		            emphasis: {
		                show: true,
		                formatter: function (param) {
		                    return param.data[3];
		                },
		                position: 'top'
		            }
		        },
		        itemStyle: {
		            normal: {
		                shadowBlur: 10,
		                shadowColor: 'rgba(120, 36, 50, 0.5)',
		                shadowOffsetY: 5,
		                color: new echarts.graphic.RadialGradient(0.4, 0.3, 1, [{
		                    offset: 0,
		                    color: 'rgba(255,255,0,1)'
		                }, {
		                    offset: 1,
		                    color: 'rgba(255,255,0,1)'
		                }])
		            }
		        }
		    },{
		        name: '20',
		        data: [],
		        type: 'scatter',
		        symbolSize: function(value,params) {
	                return value[2] ;
	            },
		        label: {
		            emphasis: {
		                show: true,
		                formatter: function (param) {
		                    return param.data[3];
		                },
		                position: 'top'
		            }
		        },
		        itemStyle: {
		            normal: {
		                shadowBlur: 10,
		                shadowColor: 'rgba(25, 100, 150, 0.5)',
		                shadowOffsetY: 5,
		                color: new echarts.graphic.RadialGradient(0.4, 0.3, 1, [{
		                    offset: 0,
		                    color:  'rgba(0,255,3,1)'
		                }, {
		                    offset: 1,
		                    color: 'rgba(0,255,3,1)'
		                }])
		            }
		        }
		    },{
		        name: '-1',
		        data: [],
		        type: 'scatter',
		        symbolSize:0,
		        itemStyle: {
		            normal: {
		                shadowBlur: 10,
		                //shadowColor: 'rgba(120, 36, 50, 0.5)',
		                shadowOffsetY: 5,
		                color: new echarts.graphic.RadialGradient(0.4, 0.3, 1, [{
		                    offset: 0,
		                    color: 'rgba(0,255,3,1)'
		                }, {
		                    offset: 1,
		                    color: 'rgba(0,255,3,1)'
		                }])
		            }
		        }
		    }]
		};
		
	chart.setOption(option);
	
	 $.ajax($('#context').val() + '/opt/hotmap').done(function(result){
		 option.series[0].data = result[0];
		 option.series[1].data = result[1];
		 option.series[2].data = result[2];
		 chart.setOption(option);
	}); 
})();