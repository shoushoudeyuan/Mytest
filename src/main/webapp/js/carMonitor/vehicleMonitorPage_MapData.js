var map = {
	vehicleWarnData : [],
	warnTypeData : [],
	geoData : [],
	unLockIn5Sec : [],
	mapOptions : {},
	mapDataSet : {},
	bmap : {},
	infoBox : {},
	curShowWarnType : '',
	loadMonitorMap : function(contextPath,city){
		var bmap = map.initMap(contextPath,city);
		map.bmap = bmap;
		map.requestVehicleGeoData();
		map.mapDataSet = new mapv.DataSet(map.loadMapDataSet(map.warnTypeData));
		map.mapOptions = map.setOptions(bmap);
		map.draw(bmap,map.mapDataSet,map.mapOptions);
		map.initInfoBox();
	},
	refresh : function(){
		map.requestVehicleGeoData();
		var dataSet = map.loadMapDataSet(map.warnTypeData);
		map.mapDataSet.set(dataSet);
	},
	initMap:function(contextPath,city){
		$("#map").height($(window).height());
		
		this.contextPath = contextPath;
		bmap = new BMap.Map("map", {
            enableMapClick: false
        });    // 创建Map实例
		bmap.centerAndZoom(city);  // 初始化地图,设置中心点坐标和地图级别
        bmap.enableScrollWheelZoom(true); // 开启鼠标滚轮缩放
        bmap.setMapStyle({
			 styleJson:[
			            {
		                    "featureType": "background",
		                    "elementType": "all",
		                    "stylers": {
		                              "color": "#12142aff"
		                    }
			          },
			          {
		                    "featureType": "land",
		                    "elementType": "all",
		                    "stylers": {
		                              "color": "#12142aff"
		                    }
			          },
			          {
		                    "featureType": "boundary",
		                    "elementType": "all",
		                    "stylers": {
		                              "color": "#383b5cff"
		                    }
			          },
			          {
		                    "featureType": "road",
		                    "elementType": "all",
		                    "stylers": {
		                              "color": "#1c1f3eff"
		                    }
			          },
			          {
		                    "featureType": "poilabel",
		                    "elementType": "labels.text.stroke",
		                    "stylers": {
		                              "color": "#515267ff"
		                    }
			          },
			          {
		                    "featureType": "highway",
		                    "elementType": "labels.text.fill",
		                    "stylers": {
		                              "color": "#a1a3b6ff"
		                    }
			          },
			          {
		                    "featureType": "administrative",
		                    "elementType": "labels.text.fill",
		                    "stylers": {
		                              "color": "#000000ff"
		                    }
			          },
			          {
		                    "featureType": "administrative",
		                    "elementType": "labels.text.stroke",
		                    "stylers": {
		                              "color": "#515267ff"
		                    }
			          },
			          {
		                    "featureType": "poilabel",
		                    "elementType": "labels.text.fill",
		                    "stylers": {
		                              "color": "#000000ff"
		                    }
			          },
			          {
		                    "featureType": "water",
		                    "elementType": "all",
		                    "stylers": {
		                              "color": "#00021cff"
		                    }
			          },
			          {
		                    "featureType": "road",
		                    "elementType": "labels.icon",
		                    "stylers": {
		                              "visibility": "off"
		                    }
			          },
			          {
		                    "featureType": "poilabel",
		                    "elementType": "labels.icon",
		                    "stylers": {
		                              "visibility": "off"
		                    }
			          },
			          {
		                    "featureType": "district",
		                    "elementType": "labels.text.fill",
		                    "stylers": {
		                              "color": "#b7b8c4ff"
		                    }
			          }]
        });
        return bmap;
	},
	initInfoBox:function(){
		map.infoBox = new BMapLib.InfoBox(map.bmap,"正在努力为您加载数据中...",{
			boxStyle:{
				width: "270px",
				height: "300px",
				background: "#090909",
				color: "white"
			},
			//closeIconMargin: "3px 0 0 247px",
			disableCloseButton: false,
			enableAutoPan: true,
			align: INFOBOX_AT_TOP
		});
	},
	requestVehicleGeoData: function(){
		var url = this.contextPath + '/vehicleMonitor/positon';
		$.ajax({
			  url: url,
			  async: false
			}).done(function(result){
			if (result.code != '100000') {
        		common.message.show("消息", result.message);
        		return;
        	}
			
			var data = result.data;
			map.vehicleWarnData = data.vehicleWarn;
			map.warnTypeData = data.warnType;
			map.geoData = data.geo;
		});
	},
	loadMapDataSet : function(warnTypeData) {
		var geoData = [];
		var data = warnTypeData;
		for (var i = 0; i < data.length; i++) {
			var geoCoord = map.geoData[data[i].name];//经纬度
			if (data[i].value == 0) {
				geoData.push({
					geometry: {
	                    type: 'Point',
	                    coordinates: [geoCoord[0], geoCoord[1]]
	                },
	                properties:{
	                	sn:data[i].name
	                },
	                count: 0,
	                size:10,
				});
			}
			if (data[i].value == 1) {
				geoData.push({
					geometry: {
	                    type: 'Point',
	                    coordinates: [geoCoord[0], geoCoord[1]]
	                },
	                properties:{
	                	sn:data[i].name
	                },
	                count: 1,
	                size:30,
				});
			}
			if (data[i].value == 2) {
				geoData.push({
					geometry: {
	                    type: 'Point',
	                    coordinates: [geoCoord[0], geoCoord[1]]
	                },
	                properties:{
	                	sn:data[i].name
	                },
	                count: 2,
	                size:20,
				});
			}
		}
		
		return geoData;
	},
	setOptions : function(bmap){
		options = {
	            strokeStyle: 'rgba(255, 250, 50, 0.6)',
	            shadowColor: '#333',
	            shadowBlur: 10,
	            styleType: 'stroke',
	            globalCompositeOperation: 'lighter',
	            methods: {
					mousemove: function(item) { 
						if(item == null){
							map.infoBox.hide();
							return;
						}
						/*var opts = {
							width: 300, // 信息窗口宽度
							height: 290, // 信息窗口高度
							//title: "车辆状态信息", // 信息窗口标题
							enableMessage: false//设置允许信息窗发送短息
						};
						
						var infowindow = new BMap.InfoWindow("正在努力为您加载数据中...",opts);
						bmap.openInfoWindow(infowindow, new BMap.Point(item.geometry.coordinates[0], item.geometry.coordinates[1]));
						map.requestDetail(item.properties.sn);*/
						
						map.requestDetail(item.properties.sn);
						if(map.infoBox.getPosition() == undefined){
							map.infoBox.open(new BMap.Point(item.geometry.coordinates[0], item.geometry.coordinates[1]));
						}
						else{
							map.infoBox.setPosition(new BMap.Point(item.geometry.coordinates[0], item.geometry.coordinates[1]));
							map.infoBox.show();
						}
					}
	            },
	            splitList: { 
	                0: 'rgba(0,139,0,50)',
	                1: 'rgba(189,1,1,50)',
	                2: 'rgba(220,165,0,50)'
	            },
	            draw: 'category'
	            
	        }
		
		return options;
	},
	draw : function(bmap,dataSet,options){
		var layer = new mapv.baiduMapAnimationLayer(bmap, dataSet, options);
		//layer.show();
	},
	requestDetail:function(sn){
		if(sn.indexOf("-unlock") > 0)
			sn = sn.split("-",1);
		var url = this.contextPath + '/vehicleMonitor/detail?sn='+sn;
		$.get(url,function(result){
			var data = result.data;
			var content = "<div style='margin:5px'>"
			content += "车型车牌：" +  data.vehicleModel + "&nbsp;-&nbsp;" + data.plateNumber + "<br />";
			content += "取车网点：" + data.rentLocation == null ? '' :  data.rentLocation  + "<br />";
			content += "停车网点：" + data.returnLocation == null ? '' :  + data.returnLocation + "<br />";
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
			content += "</div>";
			//$(".BMap_bubble_content").html(content);
			map.infoBox.setContent(content);
		});
	},
	changeWarnType : function(warnType){
		var data = map.vehicleWarnData;
		var warnData = map.warnTypeData;
		var curWarnType = [];
		
		map.curShowWarnType = warnType;
		//全部车辆
		if(warnType == ''){
			var dataSet = map.loadMapDataSet(map.warnTypeData);
			map.mapDataSet.set(dataSet);
			map.draw(bmap,map.mapDataSet,map.mapOptions);
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
		
		var dataSet = map.loadMapDataSet(curWarnType);
		map.mapDataSet.set(dataSet);
	},
	
	
	
	getUnlockIn5Sec(contextPath){
		var url = contextPath + '/vehicleMonitor/getUnlockIn5Sec';
		$.get(url).done(function(result){
			for(var i = 0; i < result.length; i++){
				map.generateLockWarnIn5Sec(JSON.parse(result[i]));
			}
		});
	},
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
		
		map.unLockIn5Sec.push(result);
		map.geoData[resultSN] = [result.lng,result.lat];
		
		vm.unLockIn5SecCount = map.unLockIn5Sec.length;
		vm.warnData.sumCommonWarnCount +=1;
		
		map.warnTypeData.push({
			name : resultSN,
			value : 2,
		});
		
		map.vehicleWarnData.push({
			"sn" : resultSN,
			"isUnlock" : "true",
			"warningType":2,
		})
		
		if(map.curShowWarnType == 'isUnlock')
			map.changeWarnType(map.curShowWarnType);
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


