<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html;  charset=GB2312">
	<title>芒果出行</title>
	<meta name="keywords" content="" />
    <meta name="renderer" content="webkit|ie-comp|ie-stand">
    <meta http-equiv="Cache-Control" content="no-siteapp" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="browsermode" content="application" />
    <meta name="format-detection" content="telephone=no,email=no,adress=no" />
    <meta name="apple-mobile-web-app-capable" content="yes" />
    <meta name="apple-mobile-web-app-status-bar-style" content="black" />
    <link rel="stylesheet" href="http://css.baojia.com/s4/c/css/reset.css">
    <link rel="stylesheet" type="text/css" href="../../css/style.css">
    <script type="text/javascript" src="../../js/flexible.js"></script>
    <script src="https://cdn.bootcss.com/jquery/3.1.1/jquery.min.js"></script>
    <script type="text/javascript" src="../../js/jquery.bj.help.js"></script>
    <style>
    	body,html{width: 100%;min-height: 100%;overflow:hidden;background-image: url(../../img/back1.jpg);background-repeat: no-repeat;background-size: 100% auto;}
    </style>
</head>
<body>
		<div class="input_box">
			<input type="tel" placeholder="请输入手机号" class="input phonenum" maxlength="11">
			<div class="code">
				<input type="text" placeholder="请输验证码" class="input codenum">
				<input type="button" value="获取验证码" class="btn sendcode">
			</div>
			<input type="submit" value="获取优惠券" class="btn subBtn">
		</div>
</body>
<script>
	$(function(){
		var validCode=true;
		$(".sendcode").click (function  () {
			var time=30;
			var code1=$(this);
			if (validCode) {
				validCode=false;
				code1.addClass("on");
			var t=setInterval(function(){
					time--;
					code1.val(time+"秒重新获取");
					if (time==0) {
						clearInterval(t);
					code1.val("重新获取");
						validCode=true;
					code1.removeClass("on");

					}
				},800)
			}
		});
		$(".sendcode").click(function(){
					var phoneVal=$(".phonenum").val();	
					$.ajax({
					type:"post",
					url:"<%=request.getContextPath()%>/customer/sendValidateCode",
					dataType:"json",
					data:{"type":"1","isSend":"1","phone":phoneVal},
					success:function (result) {
						if(result.code == 10000){
							viewError("发送成功");
						}else if(result.code == 10003){
							viewError("发送失败");
						}else if(result.code == 10001){
							viewError("手机号码已经存在");
						}
					}
				});			
			});
		$(".subBtn").click(function(){
			var phoneVal=$(".phonenum").val();
			var codeVal=$(".codenum").val();
			var reg=/^1(3|4|5|7|8)\d{9}$/;
			if(phoneVal==""){
				viewError('请输入手机号');
			}else if(phoneVal.length<11){
				viewError('手机号位数不够，请重新输入');
			}else if(!reg.test(phoneVal)){
				viewError('请输入正确的手机号');
			}else if(codeVal==""){
				viewError('请输入验证码');
			}else{
				window.location.href="registerPage.jsp?phoneVal="+phoneVal+"&codeVal="+codeVal;
			}
		})
	})
	
	$(".phonenum").focus(function() {
			$("html,body").css("overflow","auto")
		});
</script>
</html>