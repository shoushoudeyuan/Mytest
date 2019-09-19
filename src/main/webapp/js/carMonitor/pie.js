var chart1 = echarts.init(document.getElementById('pie'));
var option1 = {
		backgroundColor: 'rgba(0,0,0,0)',
	    tooltip : {
	        trigger: 'item',
	        formatter: "{a} <br/>{b} : {c} ({d}%)"
	    },
	    legend: {
	        orient: 'vertical',
	        left: 'left',
	        data: ['本周','上周'],
	        show:false
	    },
	    series : [{
            type: 'pie',
            center: ['50%', '60%'],
            radius:[0,40],
            data:[{
            	name: '本周',
            	value:0,
            	itemStyle:{
            		normal:{color: 'rgb(34,139,34)'}
            	}
            },{
            	name: '上周',
            	value:0,
            	itemStyle:{
            		normal:{color: 'rgba(122,124,216,1)'}
            	}
            }],
            itemStyle: {
                emphasis: {
                	shadowBlur: 10,
                    shadowOffsetX: 0,
                    shadowColor: 'rgba(0, 0, 0, 0.5)'
                }
            }
        }]
	};
	
chart1.setOption(option1);
var twUser = lwUser = 0;
$.ajax({
	url:$('#context').val()+'/opt/lswk',
	async: false
}).done(function(result){
 	lwUser = result.data.memberUserCount;
}); 

$.ajax({
	url:$('#context').val()+'/opt/tswk',
	async: false
}).done(function(result){
	 twUser = result.data.memberUserCount;
	 option1.series[0].data[0].name = '本周(' + twUser + ')';
	 option1.series[0].data[0].value = twUser;
	 option1.series[0].data[1].name = '上周(' + lwUser + ')';
	 option1.series[0].data[1].value = lwUser;
	 chart1.setOption(option1);
});