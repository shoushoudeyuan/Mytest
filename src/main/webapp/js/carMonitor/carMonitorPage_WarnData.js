var vm = new Vue({
  el: '#warn',
  data: {
	  warnData:{"littlePowerCount":0,"workingCount":0,"offenCancelOrderCount":0,"canUseCount":0,
		  "forbiddenCount":0,"annualSurveyCount":0,"sumCommonWarnCount":0,"boxAbnormalCount":0,
		  "twoDaysNoOrderCount":0,"overtimeParkCount":0,"outOfServiceCount":0,"rentedCount":0,
		  "lowOilCount":0,"noOrderMoveCount":0,"twentyTwoHoursNoReturnCount":0,"lowPowerCount":0,
		  "insuranceCount":0,"sumSeriousWarnCount":0,"ignitionWithoutOrderCount":0,"maintainingCount":0,
		  "allVehicleCount":0,"cancelOrderOffenCount":0,"overCashPledgeLimitCount":0,"lockWithoutOrderCount":0,
		  "addOilCount":0,"rechargingCount":0,"cleaningCount":0,"dispatchingCount":0
	  },
	  unLockIn5SecCount : 0,
	  warnLog:[],
	  lsOptData:{},
	  tsOptData:{},
	  seriousContent:'asdfsadf'
  },
  /*created:function(){
	  var _self = this;
	  _self.loadWarnData();
  },*/
  filters:{
	  formatNum:function(value){
		  return Number(value).toFixed(2);
	  }
  },
  methods:{
	  loadWarnData:function(contextPath){
	      var _self=this;
		  var url= contextPath + "/vehicleMonitor/warndata";
	      $.get(url,function(result){
	    	  if (result.code != '100000') {
	    		  common.message.show("消息", result.message);
	    		  return;
	    	  }
	    	  
	    	  _self.warnData = result.data;
	      })
	  },
	  locadWarnLog:function(contextPath){
		  var _self=this;
		  var url= contextPath + "/warnlog/list?isSolve=0";
	      $.get(url,function(result){
	    	  if (result.code != '100000') {
	    		  common.message.show("消息", result.message);
	    		  return;
	    	  }
	    	  
	    	  _self.warnLog = result.data;
	      })
	  },
	  loadOptData:function(contextPath){
		  var _self=this;
		  var url= contextPath + "/opt/lswk";
	      $.get(url,function(result){
	    	  if (result.code != '100000') {
	    		  common.message.show("消息", result.message);
	    		  return;
	    	  }
	    	  _self.lsOptData = result.data;
	      });
	      url= contextPath + "/opt/tswk";
	      $.get(url,function(result){
	    	  if (result.code != '100000') {
	    		  common.message.show("消息", result.message);
	    		  return;
	    	  }
	    	  _self.tsOptData = result.data;
	      })
	  },
	  loadSeriousData:function(contextPath){
		  var _self=this;
		  var url= contextPath + "/warnlog/allList";
		  $.get(url,function(result){
			  _self.seriousContent = result.rows;
		}); 
	  }
	  
  }
});

