<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<!-- uc强制竖屏 -->
    <meta name="screen-orientation" content="portrait">
    <!-- QQ强制竖屏 -->
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
            padding:0.1px;
            height:100%;
        }
        form{
            width:83%;
            display:block;
            margin:8.3rem auto 0.37rem;  
            opacity:0.7;
            padding:20px;
        }
        form>div{
            width:100%;
            height:1.17rem;
            border-bottom:1px solid rgba(74,75,91,1);
        }
        form>div>input{
            outline:none;
            border:none;
            font-size:0.4rem;
            color:rgba(74,75,91,1);
            -webkit-appearance:none;
            outline:0;
            height:100%;
            width:70%;
            vertical-align: middle;
            background:none;
            /* margin-top:0.5rem; */
            margin-bottom:0.37rem;
            opacity:0.6;
        }
        .tel,.validCode{
            box-sizing:border-box; 
        }
        .validCode{
            margin-bottom:0.52rem;
        }
        input[type='submit'],input[type='reset'],input[type='button']{
            -webkit-appearance:none;
            outline:0;
        }
        input::-webkit-input-placeholder { /* WebKit browsers */
            color:rgba(74,75,91,1);
        }
        input:-moz-placeholder { /* Mozilla Firefox 4 to 18 */
             color:rgba(74,75,91,1);
        }
        input::-moz-placeholder { /* Mozilla Firefox 19+ */
            color:rgba(74,75,91,1);
        }
        input:-ms-input-placeholder { /* Internet Explorer 10+ */
            color:rgba(74,75,91,1);
        }
        .btn{
            width:100%;
            background:rgba(74,75,91,1) ;
            font-size:0.45rem;
            color:rgba(255,255,255,1);
            text-align:center;
            line-height:1.17rem;
        }
        .sendCode{
            /* display:inline-block; */
            border:1px solid rgba(74,75,91,1);
            padding:0.13rem  0.18rem;
            color:rgba(74,75,91,1);
            font-size:0.35rem;
            float:right;
            margin-top:0.2rem;
        }
        p{
            color:rgba(74,75,91,1);
            font-size: 0.32rem;
            height: 0.5rem;
            line-height:0.5rem;
            width:83%;
            margin:0 auto;
        }
        .sendCodeActive{
            border:1px solid rgba(74,75,91,1);
            padding:0.17rem  0.19rem;
            color:rgba(74,75,91,1);
            font-size:0.35rem;
            float:right;
            margin-top:0.2rem;
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
    </style>
</head>
<body>
	<input id="PageContext" type="hidden" value="${pageContext.request.contextPath}" />
    <section class="bg">
        <form>
		<span id="channelCodeSpan"></span>
            <div class="tel">
                <input type="number" class="telPhone" placeholder="请输入手机号">
            </div>
            <div class="validCode">
                <input type="number" id="verifycodeInp" placeholder="输入图形验证码">
                <span><img alt="" src="${pageContext.request.contextPath}/imgverifycode" id="verification" onclick="refreshcode();"/></span>
            </div>
            <div class="validCode">
                <input type="number" class="code" placeholder="输入验证码">
                <span class="sendCode">获取验证码</span>
            </div>
            <div class="btn">
                确定
            </div>
        </form>
    </section>
    <div id="tip"></div>
    <script src="https://code.jquery.com/jquery-3.2.1.js"></script>
    <script>
        //解决弹出键盘页面高度变化bug
        var viewHeight = window.innerHeight; //获取可视区域高度
        $("input").focus(function()
        {
            $("section").css("height",viewHeight);
        }).blur(function()
        {
            $("section").css("height","100%");
        });
        $('#channelCodeSpan').html("渠道码："+getURLParams('channelCode'));
	    function checkPhone(){
	        var phone =  $('.telPhone').val();
	        if(!(/^1(3|4|5|7|8)\d{9}$/.test(phone))){
	            $('#tip').html('请输入正确的手机号').show().fadeOut(3000);
	            return false;
	        }
	        return true;
	    }
	    
	    //短信验证码
	    function checkZipCode(){
	        var zipCode = $('.code').val();
	        if(zipCode==''){
	            $('#tip').html('请填写获取的验证码').show().fadeOut(3000);
	            return false;
	        }
	        return true;
	    }
	    
	  //图形验证码
	    function checkVerifyCode(){
	        var verifyCode = $('#verifycodeInp').val();
	        if(verifyCode==''){
	            $('#tip').html('请填写图形验证码').show().fadeOut(3000);
	            return false;
	        }
	        return true;
	    }
	  
	    function refreshcode(){
	    	document.getElementById("verification").src= "<%=request.getContextPath()%>/imgverifycode?"+Math.random();
	      }
	    
	    function isValidate(){
	        if(!checkPhone()){
	            return false;
	        }
	        if(!checkZipCode()){
	            return false;
	        }
	        if(!checkVerifyCode()){
	            return false;
	        }
	        return true;
	    }
    
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
        //定时器变量
        var t ;
        //发送请求获取验证码信息
        $('.sendCode').on('click',function(){
        	if (!checkPhone()) {
        		return;
        	}
        	if (!checkVerifyCode()) {
        		return;
        	}
            if($('.sendCode').attr('class') == 'sendCode'){
            	refreshcode();
                $('.sendCode').addClass('sendCodeActive');
                $('.sendCode').html( 60 + "s后失效");
                var time = 59;
                t = setInterval(function(){
                    if(time<0){
                        clearInterval(t);
                        $('.sendCode').removeClass('sendCodeActive');
                        $('.sendCode').html("获取验证码");
                    }else{ 
                        $('.sendCode').html( time + "s后失效");
                    }
                    time--;
                },1000);
                //发送验证码请求
                $.ajax({
                	type:"post",
                	url:"<%=request.getContextPath()%>/channel/sendVerificationCode4h5",
                	data:{"phone":$('.telPhone').val(),verifyCode:$('#verifycodeInp').val()},
                	dataType:"json",
                	success: function(result) {
                        //判断发送验证码请求是否成功
                        if(result.code=='10000'){

                        }else if(result.code=='11113'){
                        	clearInterval(t);
                            $('.sendCode').removeClass('sendCodeActive');
                            $('.sendCode').html("获取验证码");
                            $('#tip').html(result.message).show().fadeOut(3000);
                        }else{
                            clearInterval(t);
                            $('#tip').html(result.message).show().fadeOut(3000);
                        }
                	}
                });
                
            }else{
                console.log('60s后可点击');
            }
        });
        //提交注册接口
        $('.btn').on('click',function(){
        	$('.btn').attr('disabled', true);
        	if (isValidate()) {
	            var param = {
	                verificationCode:$('.code').val(),//验证码
	                channelCode:getURLParams('channelCode'),//渠道码
	                username:$('.telPhone').val()//用户手机号
	            };
	            //新用户注册
// 	            var register = common('',param);
                $.ajax({
                	type:"post",
                	url:"<%=request.getContextPath()%>/channel/channelRegister4h5",
                	data:param,
                	dataType:"json",
                	success: function(result) {
                		$('.btn').attr('disabled', false);
        	            if(result.code == '10000'){
        	                location.href = 'baojiafenshi.jsp?channelCode=' + getURLParams('channelCode');//跳转到下载app页面
        	            }else{
        	                $('#tip').html(result.message).show().fadeOut(3000); 
        	            }
                	}
                });

        	}
        });
        //获取信息
        //获取渠道信息
        $.ajax({
        	type:"post",
        	url:"<%=request.getContextPath()%>/channel/h5ChannelInfo",
        	data:{channelCode:getURLParams('channelCode')},
        	dataType:"json",
        	success: function(info) {
                if(info.code=='10000'){
                    $('.bg').css("background","url(/" + info.data.activityHomeImg + ")");
                    $('.bg').css("background-size","100% 100%");
                }else{
                    $('body').html('');
                }
        	}
        });
    </script>
</body>
</html>