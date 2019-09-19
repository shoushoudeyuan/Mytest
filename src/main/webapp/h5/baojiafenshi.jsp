<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta name="screen-orientation" content="portrait">
	<meta name="x5-orientation" content="portrait">
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <script src="http://g.tbcdn.cn/mtb/lib-flexible/0.3.4/??flexible_css.js,flexible.js"></script>
    <style>
        html{
            height:100%;
            font-size:75px;
        }
        body{
            height:100%;
        }
        section{
            width:100%; 
            padding:3rem 0 6.5rem;
        }
        .icon{
            width:100%;
            height: 1.49rem;
            background:url('../img/tubiao.png') no-repeat center center;
            background-size:1.49rem 1.49rem;
           
        }
        .content{
            color:rgba(255,255,255,1);
            font-size:0.43rem;
            text-align:center;
            margin:0.6rem 0 3.3rem;
            opacity:0;
            
        }
        .btn{
            width:87%;
            height:1.17rem;
            margin:0 auto;
           background:rgba(74,75,91,1); 
           color:rgba(255,255,255,1);
           font-size:0.45rem;
           text-align:center;
           line-height:1.17rem;
           opacity:0.5;
           /* margin-bottom:5.96rem; */
        }
        #tip{
            padding:0.1rem 0.5rem;
            background:black;
            text-align:center;
            line-height: 1rem;
            position:fixed;
            bottom:2rem;
            left:50%;
            transform:translate(-50%,0);
            color:white;
            display:none;
        }
        #errorModel{
            position: fixed;  
            top: 0;  
            right:0;  
            bottom:0;  
            left:0;  
            width:100%;  
            height:100%;  
            z-index: 10; 
            background-color:rgba(0,0,0,0.4);
            background-image:url(live_weixin.png);
            background-repeat:no-repeat;
            background-position:30px 0;
            background-size:90% 95%;
            display:none;
        }
    </style>
</head>
<body>
    <section class="bg">
        <div class="icon">
        </div>
        <p class="content">注册成功下载APP立即领取</p>
        <div class="btn">我要下载app</div>
    </section>
    <div id="tip"></div>
    <div id="errorModel"></div>
    <script src="https://code.jquery.com/jquery-3.2.1.js"></script>
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
        $.ajax({
            	type:"post",
            	url:"<%=request.getContextPath()%>/channel/h5ChannelInfo",
            	data:{channelCode:getURLParams('channelCode')},
            	dataType:"json",
            	success: function(info) {
                    //判断请求是否成功
                    if(info.code == '10000'){
                        $('.bg').css("background","url(/" + info.data.activityAppImg + ")");
                        $('.bg').css("background-size","100% 100%");
                            //点击我要下载app，跳转对应系统的下载页面
                        $('.btn').on('click',function(){
                               //android手机
                        if(getVersion()=='1'){
                            if(isWeixin()){
                                //提示在浏览器中打开下载链接
                                $("#errorModel").show();
                            }else{
                                location.href = info.data.androidDownloadUrl;
                            }
                           //苹果手机 
                        }else if(getVersion()=='2'){
                            location.href = info.data.iosDownloadUrl;
                        }else{
                            location.href = info.data.androidDownloadUrl;
                        }
                        });
                     
                    }else{
                        $('#tip').html(info.message).show().fadeOut(3000); 
                    }
            	}
            });
        //弹出提示隐藏
        $('#errorModel').on('click',function(){
            $('#errorModel').hide();
        });
    </script>
</body>
</html>