function getRootPath_web() {
	// 获取当前网址，如： http://localhost:8083/uimcardprj/share/meun.jsp
	var curWwwPath = window.document.location.href;
	// 获取主机地址之后的目录，如： uimcardprj/share/meun.jsp
	var pathName = window.document.location.pathname;
	var pos = curWwwPath.indexOf(pathName);
	// 获取主机地址，如： http://localhost:8083
	var localhostPaht = curWwwPath.substring(0, pos);
	// 获取带"/"的项目名，如：/uimcardprj
	var projectName = pathName
			.substring(0, pathName.substr(1).indexOf('/') + 1);
	return (localhostPaht + projectName);
}

function serverPath() {
	// 获取当前网址，如： http://localhost:8083/uimcardprj/share/meun.jsp
	var curWwwPath = window.document.location.href;
	// 获取主机地址之后的目录，如： uimcardprj/share/meun.jsp
	var pathName = window.document.location.pathname;
	var pos = curWwwPath.indexOf(pathName);
	// 获取主机地址，如： http://localhost:8083
	var localhostPaht = curWwwPath.substring(0, pos);
	return localhostPaht;
}
function getUrlParam(name) {
	var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)");
	var r = window.location.search.substr(1).match(reg);
	if (r != null)
		return unescape(r[2]);
	return null;
};
function setAutoHeight(rootHeight,id){
//  rootHeight=document.documentElement.clientHeight-rootHeight;
//				$(".panel,.datagrid,.easyui-fluid").css("height",rootHeight+'px');
//				$(".datagrid-wrap,.panel-body,.panel-body-noheader").css("height",rootHeight-1+'px');
//				$(".datagrid-view").css("height",rootHeight-53+'px');
//				$(".datagrid-view1").css("height",rootHeight-60+'px');
//				$(".datagrid-view2").css("height",rootHeight-60+'px');
//				$(".datagrid-body").css("height",rootHeight-110+'px');

		$("#"+id).height(document.documentElement.clientHeight-rootHeight);
}
//easyui月份控件

function setEasyUIMonthControl(id)
{
	$('#'+id).datebox({    
        onShowPanel : function() {// 显示日趋选择对象后再触发弹出月份层的事件，初始化时没有生成月份层    
            span.trigger('click'); // 触发click事件弹出月份层    
            if (!tds)    
                setTimeout(function() {// 延时触发获取月份对象，因为上面的事件触发和对象生成有时间间隔    
                    tds = p.find('div.calendar-menu-month-inner td');    
                    tds.click(function(e) {    
                        e.stopPropagation(); // 禁止冒泡执行easyui给月份绑定的事件    
                        var year = /\d{4}/.exec(span.html())[0]// 得到年份    
                        , month = parseInt($(this).attr('abbr'), 10) + 1; // 月份    
                        $('#'+id).datebox('hidePanel')// 隐藏日期对象    
                        .datebox('setValue', year + '-' + month); // 设置日期的值    
                    });    
                }, 0);    
        },    
        parser : function(s) {// 配置parser，返回选择的日期    
            if (!s)    
                return new Date();    
            var arr = s.split('-');    
            return new Date(parseInt(arr[0], 10), parseInt(arr[1], 10) - 1, 1);    
        },    
        formatter : function(d) {    
            var month = d.getMonth();  
            if(month<10){  
                month = "0"+month;  
            }  
            if (d.getMonth() == 0) {    
                return d.getFullYear()-1 + '-' + 12;    
            } else {    
                return d.getFullYear() + '-' + month;    
            }    
        }// 配置formatter，只返回年月    
    });    
    var p = $('#'+id).datebox('panel'), // 日期选择对象    
    tds = false, // 日期选择对象中月份    
    span = p.find('span.calendar-text'); // 显示月份层的触发控件 
}


function isRepeatClick(el){
	var nowTime = new Date().getTime();
    var clickTime = $(el).attr("ctime");
    if(clickTime != 'undefined' && (nowTime - clickTime < 5000)){
    	$(el).attr("ctime",nowTime);
    	return true;
    }else{
    	$(el).attr("ctime",nowTime);
    	return false;
    }
}

