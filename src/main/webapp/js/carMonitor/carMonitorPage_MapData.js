var map = {
	mapWidget : echarts.init(document.getElementById('map')),
	curProvince : 'china',
	dbKey : '',
	vehicleWarnData : [],
	warnTypeData : [],
	getData : [],
	unLockIn5Sec : [],
	init:function(contextPath,province){
		this.contextPath = contextPath;
		map.curProvince = province;
	},
	mapClick : function(){
		map.mapWidget.on("click",function(param){
			for(var i in map.provincesText){
				if(map.provincesText[i] == param.name){					
					map.changeMap(map.provinces[i]);
					return;
				}
			}
		})
	},
	// list<jsonObj> data:name(sn) value(waringType)
	// map geoCoordMap: key->sn  value->经纬度[]
	loadMapData : function(data,geoCoordMap) {
		this.data = data;
		this.geoCoordMap = geoCoordMap;
		this.normalGeoCoordData = [];// name->sn value -> [经度,纬度,warningType]
		this.commonGeoCoordData = [];
		this.seriousGeoCoordData = [];
		for (var i = 0; i < data.length; i++) {
			var geoCoord = this.geoCoordMap[data[i].name];//经纬度
			if (data[i].value == 0) {
				this.normalGeoCoordData.push({
					name: data[i].name,
					value: geoCoord.concat(data[i].value),
				});
			}
			if (data[i].value == 1) {
				this.seriousGeoCoordData.push({
					name: data[i].name,
					value: geoCoord.concat(data[i].value),
				});
			}
			if (data[i].value == 2) {
				this.commonGeoCoordData.push({
					name: data[i].name,
					value: geoCoord.concat(data[i].value),
				});
			}
		}
	},
	requestGeoData: function(isRefresh){
		var url = this.contextPath + '/vehicleMonitor/positon';
		$.get(url,function(result){
			if (result.code != '100000') {
        		common.message.show("消息", result.message);
        		return;
        	}
			
			var data = result.data;
			map.vehicleWarnData = data.vehicleWarn;
			map.warnTypeData = data.warnType;
			map.geoData = data.geo;
			map.loadMapData(data.warnType,data.geo);
			map.reloadLockWarnIn5Sec();
			map.draw(map.curProvince,isRefresh);
    		
		});
	},
	requestDetail:function(params, ticket, callback){
		if(params.name.indexOf("-unlock") > 0)
			params.name = params.name.split("-",1);
		var url = this.contextPath + '/vehicleMonitor/detail?sn='+params.name;
		$.get(url,function(result){
			var data = result.data;
			var content = "车型车牌：" +  data.vehicleModel + "&nbsp;-&nbsp;" + data.plateNumber + "<br />";
			content += "取车网点：" + data.rentLocation + "<br />";
			content += "停车网点：" + data.returnLocation + "<br />";
			content += "当前位置：" + data.currentLocation + "<br />";
			content += "————————————————————<br />";
			if(data.vehicleType == 1)
				content += "油量剩余：" + data.canWorkOil + "L&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
			else
				content += "剩余电量：" + Math.floor(data.canWorkPower * 100) + "%&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
			content += "预计续航：" + data.canRunMileage + "公里<br />";
			content += "大表里程：" + data.runedMileage + "KM<br />";
			content += "电瓶电压：" + data.voltage + "V&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
			content += "充电状态：" + (data.isCharging ? "充电" : "未充电") + "<br />";
			content += "————————————————————<br />";
			if (data.boxAbnormal) { // 盒子离线
				content += "<font color='red'>盒子状态：离线&nbsp;-&nbsp;上次定位" + (data.gpsTime == null ? '' : common.minutes2Str(common.getMinitesBetween2Days(new Date(data.gpsTime), new Date()))) + "前</font><br />";
			} else {
				content += "<font color='green'>盒子状态：在线&nbsp;&nbsp;" + (data.speed == 0 ? "静止" : "运动") + "&nbsp;&nbsp;" + "上次定位" + (data.gpsTime == null ? '' : common.minutes2Str(common.getMinitesBetween2Days(new Date(data.gpsTime), new Date()))) + "前</font><br />";
				if (data.speed == 0 || data.vehicleStatus == 7) { // 静止或可用
					content += "静止时长：" + common.minutes2Str(data.unmoveTime) + " <br />";
				}
			}
			content += "定位时间：" + (data.gpsTime == null ? '' : common.longDate2FormatStr(data.gpsTime)) + "<br />";
			if (data.vehicleStatus == 8) { // 已租
				content += "————————————————————<br />";
				content += "车辆状态：已租(即时)<br />";
				content += "取车时间：" + common.longDate2FormatStr(data.rentTime) + "<br />";
			}
			callback(ticket,content);
		});
	},
	generateGeoData : function(geoCoordData){
		this.geoCoordData = geoCoordData;	
	},
	draw : function(mapName,isRefresh){
		$("#map").height($(window).height());
		var options = map.setOptions(mapName);
		if(!isRefresh){
			map.mapWidget.clear();
			map.mapWidget.resize();
			
			if(mapName == "china")
				options.geo.center = [106.23293566160564,35.53321993787478];
			else
				options.geo.center = null;
		}
		map.mapWidget.setOption(options);
	},
	changeMap : function(name){
		if(name == 'china'){
			map.loadMapData(map.warnTypeData,map.geoData);
		}
		map.curProvince = name;
		$.get(this.contextPath + '/js/carMonitor/map/' + name + '.json', function (geoJson) {
			echarts.registerMap(name, geoJson);			 
			map.draw(name,false);
		});
	},
	changeWarnType : function(warnType){
		var data = map.vehicleWarnData;
		var warnData = map.warnTypeData;
		var curWarnType = [];
		
		//全部车辆
		if(warnType == ''){
			map.loadMapData(map.warnTypeData,map.geoData);
			map.draw(map.curProvince,true);
			return;
		}
		
		for (var i = 0; i < data.length; i++) {
			for(var field in data[i]){
				if(field == warnType){
					if(data[i][field] || (warnType == "isLockWithoutOrder" && !data[i]["isLockWithoutOrder"]) ){
						for(var j = 0; j < warnData.length; j++){
							if(warnData[j].name == data[i].sn){
								curWarnType.push(warnData[j]);
								break;
							}
						}
					}
					
					break;
				}
			}
		}
		
		
		map.loadMapData(curWarnType,map.geoData);
		map.draw(map.curProvince,true);
	},
	setOptions : function(mapName){
		var option = {
			   backgroundColor: '#000314',
		       /*title: {
		           text: '宝 驾 分 时 租 赁 实 时 监 控 告 警',
		           subtext: '',
		           sublink: '',
		           left: 'center',
		           textStyle: {
		               color: '#fff',
		               fontSize: 26
		           }
		       },*/
		       tooltip : {
		           trigger: 'item'
		       },
		       legend: {
		           orient: 'vertical',
		           y: 'bottom',
		           x:'right',
		           data:[],
		           textStyle: {
		               color: '#fff'
		           }
		       },
		       /*dataZoom : [
		            {
		                type: 'slider',
		                show: false,
		                start: 0,
		                end: 100,
		            },
		            {
		                type: 'inside',
		                start: 0,
		                end: 100
		            }
		        ],
		        xAxis : [
                    {
                        type : 'value',
                        scale: true
                    }
                ],
                yAxis : [
                    {
                        type : 'value',
                        scale: true,
                    }
                ],*/
		       geo: {
		           map: mapName,
		           label: {
		               emphasis: {
		                   show: false
		               }
		           },
		           roam: true, //控制滚轮缩放和拖拽
		           itemStyle: {
		               normal: {
		                   areaColor: '#22243B',
		                   borderColor: '#111'
		               },
		               emphasis: {
		                   areaColor: '#2a333d'
		               }
		           }
		           /*center:[106.23293566160564,35.53321993787478]
		           layoutCenter: ['50%', '50%'],
		           layoutSize: 500*/
		       },
		       series : [
		           {
		               name: '监控告警',
		               type: 'scatter',
		               coordinateSystem: 'geo',
		               data : this.normalGeoCoordData,
		               symbolSize: 7,
		               label: {
		                   normal: {
		                       formatter: '{b}',
		                       position: 'right',
		                       show: false
		                   },
		                   emphasis: {
		                       show: false
		                   }
		               },
		               itemStyle: {
		                   normal: {
		                       color: 'rgba(0,139,0,50)'
		                   }
		               },
		               tooltip:{
		            	   formatter:function (params, ticket, callback){
		            		   map.requestDetail(params,ticket,callback);
		            		   return "Loading...";
		            	   },
		            	   backgroundColor:'black'
		               }
		           },
		           {
		               name: '一般告警',
		               type: 'effectScatter',
		               coordinateSystem: 'geo',
		               data : this.commonGeoCoordData,
		               symbolSize: 20,
		               showEffectOn: 'render',
		               rippleEffect: {
		                   brushType: 'stroke'
		               },
		               hoverAnimation: true,
		               label: {
		                   normal: {
		                       formatter: '{b}',
		                       position: 'right',
		                       show: false
		                   },
		                   emphasis: {
		                       show: false
		                   }
		               },
		               itemStyle: {
		                   normal: {
		                	   color: 'rgba(220,165,0,50)',
		                       shadowBlur: 10,
		                       shadowColor: '#333'
		                   }
		               },
		               tooltip:{
		            	   formatter:function (params, ticket, callback){
		            		   map.requestDetail(params,ticket,callback);
		            		   return "Loading...";
		            	   },
		            	   backgroundColor:'black'
		               }
		           },
		           {
		               name: '严重告警',
		               type: 'effectScatter',
		               coordinateSystem: 'geo',
		               data : this.seriousGeoCoordData,
		               symbolSize: 20,
		               showEffectOn: 'render',
		               rippleEffect: {
		                   brushType: 'stroke'
		               },
		               hoverAnimation: true,
		               label: {
		                   normal: {
		                       formatter: '{b}',
		                       position: 'right',
		                       show: false
		                   },
		                   emphasis: {
		                       show: false
		                   }
		               },
		               itemStyle: {
		                   normal: {
		                       color: 'rgba(189,1,1,50)',
	                    	   shadowBlur: 10,
		                       shadowColor: '#333'
		                   }
		               },
		               tooltip:{
		            	   formatter:function (params, ticket, callback){
		            		   map.requestDetail(params,ticket,callback);
		            		   return "Loading...";
		            	   },
		            	   backgroundColor:'black'
		               }
		           }
		       ]
		   };
		
		return option;
	},
	provinces : ['shanghai', 'hebei','shanxi','neimenggu','liaoning','jilin','heilongjiang','jiangsu','zhejiang','anhui','fujian','jiangxi','shandong','henan','hubei','hunan','guangdong','guangxi','hainan','sichuan','guizhou','yunnan','xizang','shanxi1','gansu','qinghai','ningxia','xinjiang', 'beijing', 'tianjin', 'chongqing', 'xianggang', 'aomen'],
	provincesText : ['上海', '河北', '山西', '内蒙古', '辽宁', '吉林','黑龙江',  '江苏', '浙江', '安徽', '福建', '江西', '山东','河南', '湖北', '湖南', '广东', '广西', '海南', '四川', '贵州', '云南', '西藏', '陕西', '甘肃', '青海', '宁夏', '新疆', '北京', '天津', '重庆', '香港', '澳门'],
	

	subscribe : function(dbKey){
		var socket = new SockJS('http://' + window.location.host+this.contextPath+'/socket');
	    var stompClient = Stomp.over(socket);
	    this.socket = stompClient;
	    map.dbKey = dbKey;
	    stompClient.connect({}, function(frame) {
	    	/*stompClient.subscribe('/topic/recycle/'+dbKey,function(greeting){
	        	console.log(greeting.body);
	        }); */
	    	stompClient.subscribe('/topic/lockMonitor/'+ map.dbKey,function(result){
	    		map.generateLockWarnIn5Sec(JSON.parse(result.body));
	        }); 
	    });
	},
	closeSubscibe : function(){
		if (this.socket != null) {
			this.socket.disconnect();
    	}
	},
	generateLockWarnIn5Sec : function(result){		
		result.sn = result.sn + "-unlock";
		var resultSN = result.sn;
		for(var i = 0; i < map.unLockIn5Sec.length; i++){
			if(map.unLockIn5Sec[i].sn == resultSN){
				if(result.isWarn == "false"){
					map.unLockIn5Sec.splice(i,1);
					vm.unLockIn5SecCount = map.unLockIn5Sec.length;
					vm.warnData.sumCommonWarnCount -=1;
					break;
				}else{
					vm.unLockIn5SecCount = map.unLockIn5Sec.length;
					return;
				}
			}
		}
		
		for(var i = 0 ;i < this.commonGeoCoordData.length; i++){
			if(this.commonGeoCoordData[i].name == resultSN){
				if(result.isWarn == "false"){
					this.commonGeoCoordData.splice(i,1);
					break;
				}
			}
		}
		
		for(var i = 0; i < map.warnTypeData.length;i++){
			if(map.warnTypeData[i].name == resultSN){
				if(result.isWarn == "false"){
					map.warnTypeData.splice(i,1);
					break;
				}
			}
		}
		
		for(var i = 0; i < map.vehicleWarnData.length; i++){
			if(map.vehicleWarnData[i].sn == resultSN){
				if(result.isWarn == "false"){
					map.vehicleWarnData.splice(i,1);
					break;
				}
			}
		}
		
		if(result.isWarn == "false"){
			map.draw(map.curProvince,true);
			return;
		}
		
		map.unLockIn5Sec.push(result);
		map.geoData[resultSN] = [result.lng,result.lat];
		
		vm.unLockIn5SecCount = map.unLockIn5Sec.length;
		vm.warnData.sumCommonWarnCount +=1;
		
		var geoCoord = [result.lng,result.lat];
		this.commonGeoCoordData.push({
			name: resultSN,
			value: geoCoord.concat(2),
		});
		
		map.warnTypeData.push({
			name : resultSN,
			value : 2,
		});
		
		map.vehicleWarnData.push({
			"sn" : resultSN,
			"isUnlock" : "true",
			"warningType":2,
		})
		
		map.draw(map.curProvince,true);
	},
	reloadLockWarnIn5Sec : function(){
		for(var i = 0; i < map.unLockIn5Sec.length; i++){
			var result = map.unLockIn5Sec[i];
			var geoCoord = [result.lng,result.lat];
			this.commonGeoCoordData.push({
				name: result.sn,
				value: geoCoord.concat(2),
			});
		}
	}
};


