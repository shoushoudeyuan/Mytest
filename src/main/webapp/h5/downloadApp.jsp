<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title></title>
    <script src="http://g.tbcdn.cn/mtb/lib-flexible/0.3.4/??flexible_css.js,flexible.js"></script>
    <script src="https://code.jquery.com/jquery-3.2.1.js"></script>
    <style>
        html{
        height:100%;
        font-size:75px;
        }
        body{
        height:100%;
        }
        h3{
            position:fixed;
            z-index:1;
            width:100%;
            height:1.71rem;
            text-align:center;
            line-height:1.71rem;
            color:rgba(51,51,51,1) ;
            font-size:0.45rem !important;
            background:white;
            text-indent:-0.77rem;
            border-bottom: 1px solid  #f3f4f5;  
        }
        h3>a{
            float:left;
            width:0.77rem;
            height:1.71rem;
            background:url(../img/icon_back.png) no-repeat 0.1rem center;
            background-size:100% 0.77rem;
            text-decoration:none;
        }
        #empty{
            height:1.71rem;
            width:100%;
        }
        section{
            width:89%;
            margin:0.71rem auto 0;
            border-radius:8px;
            box-shadow:1px 1px  15px 1px
            rgba(189,189,189,0.5) ,-1px -1px  15px 1px rgba(189,189,189,0.5) ;
            background:url(./Combined@3x.png) no-repeat center;
            background-size:100% 100%;
        }
        section>.con>p.down{
            margin:0 auto 0.75rem;
            height:0.75rem; 
            font-size:0.53rem;
            color:rgba(74,75,91,1);
            line-height:0.75rem;
            text-align:center;
        }
        section>.con{
            padding:0.99rem 0.61rem 0 0.61rem;
        } 
        section>.con>p.content{
            margin:auto;
            height:1.6rem; 
            font-size:0.37rem;
            color:rgba(155,155,155,1);
            line-height:0.53rem;
            text-align:center;
        }
        .contentInfo{
            font-size:0.37rem;
            font-style:normal;
        }
        section>.con>.line{
            width:90%;
            border-bottom:2px dashed rgba(221,221,221,1);
            margin:1.37rem auto 0;
        }
        section>.code{
            padding:0.55rem 0.61rem 0.85rem 0.61rem;
        }
        section>.code>p{
            text-align:center;
        }
        section>.code>p.tipName{
            height:0.64rem; 
            font-size:0.45rem;
            color:rgba(74,75,91,1);
            line-height:0.64rem;
        }
        section>.code>p.codeNum{
            margin-top:0.51rem;
            height:1.19rem; 
            font-size:0.99rem;
            color:rgba(0,182,120,1);
            line-height:1.19rem;
        }
        .download{
            width:92%;
            height: 1.17rem;
       
            color:rgba(255,255,255,1);
            font-size:0.4rem;
            text-align:center;
            line-height:1.17rem;
            margin:1.5rem auto 1rem;
        }
        #errorModel{
            position: fixed;  
            top: 0;  
            right:0;  
            bottom:0;  
            left:0;  
            z-index: 10; 
            background-color:rgba(0,0,0,0.4);
            background-image: url("live_weixin.png");
            background-repeat:no-repeat;
            background-position:30px 0;
            background-size:90% 85%;
            /*display:none;*/
        }
        #errorModel>.errTip{
            position:absolute;
            top:0;
            right:0;
            bottom:0;
            left:0;
            margin: auto;
            width:76%;
            height:5.3rem;
            background:white;
        }
        #errorModel>.errTip>p{
        text-align:center;
        height:0.56rem;
        color:rgba(51,51,51,1) ;
        font-size:0.4rem;
        margin-bottom:0.2rem;
        margin-top:0.2rem;
        }
        #errorModel>.errTip>.topTip{
        width:100%;
        height:1.33rem;
        background:url(./tankuang-zhuyi.png) no-repeat center;
        background-size:1.33rem 1.33rem;
        margin:0.75rem 0 0.4rem 0;
        }
        .toLogin{
            width:100%;
            height: 1.52rem;
            text-align:center;
            line-height:1.52rem;
            border-top:1px solid rgba(204,204,204,0.7000000000000001) ;
            color:rgba(19,184,214,1) ;
            font-size:0.45rem;
            margin-top:0.7rem;
        }
        section>.con>p.down2{
            margin:0;
            height:3rem; 
            font-size:0.53rem;
            color:rgba(74,75,91,1);
            line-height:4rem;
            text-align:center;
        }
        section>.con>.line2{
            width:90%;
            border-bottom:1px dashed rgba(221,221,221,1);
            margin:1.2rem auto 0;
        }
</style>
</head>
<body>
	<input id="PageContext" type="hidden" value="${pageContext.request.contextPath}" />
    <h3>
        <a  id="back" href="javascript:history.back()"></a>
        邀请好友
    </h3> 
    <div id="empty"></div>
    <section>
        <div class="con">
            <p class="down">下载APP注册账号</p>
            <p class="content">在我的账户-优惠券输入此专用邀请码兑换成功即可获得“<i class="contentInfo"></i>”</p>
            <div class="line2"></div>
        </div>
        <div class="code">
            <p class="tipName">专用邀请码</p>
            <p class="codeNum"></p>
        </div>
    </section>
    <p class="download">下载APP 一键用车</p>
    <div id="errorModel" style="display:none" >
    <script>
        //获用户inviteCode参数
        function getURLParams(name){
                var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)");
                var r   = window.location.search.substr(1).match(reg);
                if(r!=null){
                    return decodeURIComponent(r[2]);
                }else{
                    return null;
                }
        }
        //获取系统信息
        /**
         * @method 获取用户手机系统版本号
         * @return {string} 返回版本号
        */
        function getVersion(){
            var str = navigator.userAgent.toLowerCase();
            var version = '';
            if(/android/i.test(str)){
                //系统为安卓
                version = 1;
            }
            if(/(iPhone|iPad|iPod|iOS)/i.test(str)){
                //苹果系统
                version = 2;
            }
            return version;
        }
        //判断是否是微信内置浏览器
        function isWeixin(){  
            var ua = navigator.userAgent.toLowerCase();  
            if(ua.match(/MicroMessenger/i)=="micromessenger") {  
                return true;
            } else {  
                return false;
            }  
        } 
        //邀请码
        $('.codeNum').text(getURLParams('inviteCode'));
        
        //请求信息
        $.ajax({
        	type:'post',
        	url:'/bjycrm/customer/inviteFriendsAfter',
        	dataType:'json',
        	success: function(result) {
                if(result.code=='10000'){
                	$('title').text(result.data.inviteBrandName);
                    if(result.data.content){
                        //内容
                        $('.contentInfo').text(result.data.content);
                      	
                   }else{
                       //没有内容时
                       $('.content').hide();
                       //设置样式
                       $('.down').addClass('down2');
                       $('.line2').addClass('line');
                   }
                    
                }else{

                }

                //点击我要下载app，跳转对应系统的下载页面
                $('.download').on('click',function(){
                    if(getVersion()=='1'){
                        if(isWeixin()){
                            $('#errorModel').show();
                        }else{
                            location.href = result.data.androidDownloadUrl;
                        }
                        
                    }else if(getVersion()=='2'){
                        location.href = result.data.iosDownloadUrl;
                    }else{
                        location.href = result.data.androidDownloadUrl;
                    }
                });
        	}
        })
        
        //关闭弹框
        $('.toLogin').on('click',function(){
            $('#errorModel').hide();
        })

        $('#errorModel').on('click', function() {
        	 $('#errorModel').hide();
        });
		var arrs = [
    {
        "color": "#39c64b",
        "domain": "bgcx.yun.baojia.com"
    },
    {
        "color": "#02b2e4",
        "domain": "bycx.yun.baojia.com"
    },
    {
        "color": "#C4D85B",
        "domain": "db.yun.baojia.com"
    },
    {
        "color": "#FDD000",
        "domain": "ddgx.yun.baojia.com"
    },
    {
        "color": "#2e93d1",
        "domain": "elcx.yun.baojia.com"
    },
    {
        "color": "#33aacc",
        "domain": "fs.ezu163.com"
    },
    {
        "color": "#009943",
        "domain": "ftgx.yun.baojia.com"
    },
    {
        "color": "#EC6D20",
        "domain": "fs.gongchewuyou.com"
    },
    {
        "color": "#1B692E",
        "domain": "gpcx.yun.baojia.com"
    },
    {
        "color": "#2D2B68",
        "domain": "hecx.yun.baojia.com"
    },
    {
        "color": "#41A531",
        "domain": "jhcx.yun.baojia.com"
    },
    {
        "color": "#46C11B",
        "domain": "jlcx.yun.baojia.com"
    },
    {
        "color": "#2ed146",
        "domain": "lxzc.yun.baojia.com"
    },
    {
        "color": "#ea5414",
        "domain": "mgcx.yun.baojia.com"
    },
    {
        "color": "#00A03F",
        "domain": "pacx.yun.baojia.com"
    },
    {
        "color": "#fe0054",
        "domain": "rxcx.yun.baojia.com"
    },
    {
        "color": "#634581",
        "domain": "sxcx.yun.baojia.com"
    },
    {
        "color": "#0062a8",
        "domain": "tldcx.yun.baojia.com"
    },
    {
        "color": "#8ABA29",
        "domain": "vgo.yun.baojia.com"
    },
    {
        "color": "#C12C31",
        "domain": "xgcx.yun.baojia.com"
    },
    {
        "color": "#AE252E",
        "domain": "xlfc.yun.baojia.com"
    },
    {
        "color": "#E1031F",
        "domain": "yjcx.yun.baojia.com"
    },
    {
        "color": "#6b6b6b",
        "domain": "zdcx.yun.baojia.com"
    },
    {
        "color": "#009944",
        "domain": "zhcx.yun.baojia.com"
    },
    {
        "color": "#33aacc",
        "domain": "fscs.yun.baojia.com"
    },
    {
        "color": "#33aacc",
        "domain": "fscs1.yun.baojia.com"
    },
    {
        "color":"#D23B10",
        "domain":"lycx.yun.baojia.com"
    },{
        "color":"#2689BE",
        "domain":"leocar.yun.baojia.com"
    },{
        "color":"#5DB431",
        "domain":"gtzc.yun.baojia.com"
    },

    {
        "color": "#33aacc",
        "domain": "fscs2.yun.baojia.com"
    },{
		"color":"#47AE3E",
		"domain":"db.yun.baojia.com"
	}];
		function company(){
			var url = window.location.href;
			for(var i = 0,len = arrs.length;i< len;i++){
				if(url.indexOf(arrs[i].domain)>0){
					return arrs[i].color;
				}
			}
			 return "#33aacc";
			
		}
		$('.download').css('background',company());
    </script>
</body>
</html>