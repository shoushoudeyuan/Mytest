var common = {};

common.message = {
		show : function(title,msg){
			$("#msgModalBody").text(msg);
			$("#msgModalLabel").text(title);
			$("#msgModal").modal('show');
		},
		hide: function(){
			$("#msgModal").modal('hide');
		}
};

common.stringFormat = function() {
    if (arguments.length == 0)
        return null;
    var str = arguments[0];
    for (var i = 1; i < arguments.length; i++) {
        var re = new RegExp('\\\\{' + (i - 1) + '\\\\}', 'gm');
        str = str.replace(re, arguments[i]);
    }
    return str;
};

/**
 * long类型日期转  yyyy-MM-dd HH:mm:ss 字符串
 * @param date
 * @returns {String}
 */
common.longDate2FormatStr = function(date) {
	var date = new Date(date);
	var year = date.getFullYear() + '-';
	var month = date.getMonth() + 1 + '-';
	var day = date.getDate();//getDate返回一个月中的第几天, getDay返回一周中的第几天
	var hours = date.getHours() + ':';
	var minutes = date.getMinutes() + ':';
	var seconds = date.getSeconds();
	return year + month + day + " " + hours + minutes + seconds;
};

/**
 * 计算两个date类型的日期之间相差的分钟数
 * @param date_1
 * @param date_2
 * @returns
 */
common.getMinitesBetween2Days = function(date_1, date_2) {
	var t1 = date_1.getTime();
	var t2 = date_2.getTime();
	return Math.ceil(((t2 - t1) * 1.0) / 1000 / 60 / 1.0);
};

/**
 * 分钟数转 n天n时n分
 * @param minutes
 * @returns {String}
 */
common.minutes2Str = function(minutes) {
	var fmt = "";
	if (minutes >= 60 && minutes < 1440) { // 如果超过1小时小于1天
		fmt = Math.floor(minutes/60) + "时" + (minutes%60) + "分";
	} else if (minutes > 1440) { // 如果超过1天
		var days = Math.floor(minutes/1440); // 天数
		fmt += days + "天";
		var lastMinutes = minutes - (1440 * days); // 减去天后剩余的分钟数
		if (lastMinutes >= 60) { // 如果剩余的分钟数大于1小时
			fmt += Math.floor(lastMinutes/60) + "时" + (lastMinutes%60) + "分";
		} else { // 如果小于1小时
			fmt += "0时" + lastMinutes + "分";
		}
	} else {
		fmt = minutes + "分";
	}
	return fmt;
};
