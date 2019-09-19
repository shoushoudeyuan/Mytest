<%@ page language="java" pageEncoding="UTF-8" import="org.owasp.esapi.ESAPI" %>
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
    	body,html{width: 100%;min-height: 100%;overflow:hidden;background-image: url(../../img/back2.jpg);background-repeat: no-repeat;background-size: 100% auto;}
    </style>
</head>
<body>
		<div class="input_box input_box1">
			<input type="tel" placeholder="请输入手机号" class="input phonenum">
				<div class="code">
					<input type="text" placeholder="请设置密码" class="input pwd">
				</div>
			<input type="submit" value="确定领取" class="btn subBtn">
		</div>
</body>
<script>
$(function(){
    function findstr(str,n){
        var tmp=0;
        for(var i=0;i<str.length;i++){
            if(str.charAt(i)==n){
                tmp++;
            }
        }
        return tmp;
    };
    $(".pwd").focus(function(){
        viewError('推荐使用6-8位字母、数字、下划线的组合');
    });
    $(".subBtn").click(function(){
        var pwdVal=$(".pwd").val();
        var reg=/[^a-zA-Z]/g;
        var reg1=/\D/g;
        var m=findstr(pwdVal,pwdVal[0]);
        if(pwdVal.value==''){
            viewError('密码不能为空');
        }else if(pwdVal.length<6||pwdVal.length>8){
            viewError('密码长度在6-8位之间');
        } 
        /* else{
            viewError('领取成功');
        	window.location.href="registerSuccess.jsp";
        } */
        
        var phoneVal = '<%=ESAPI.encoder().encodeForJavaScript(request.getParameter("phoneVal"))%>';
        var codeVal = '<%=ESAPI.encoder().encodeForJavaScript(request.getParameter(request.getParameter("codeVal"))%>';
    	var password=$(".pwd").val();	 
    	$.ajax({
    		type:"post",
    		url:"<%=request.getContextPath()%>/customer/doRegister",
    		dataType:"json",
    		data:{"username":phoneVal,"password":password,"zipCode":codeVal,"source":"offlinePromotion"},
    		success:function (result) {
    			if(result.code == 10002){
    				viewError("请输入密码");
    			}else if(result.code == 40000){
    				viewError("验证码已过期");
    			}else if(result.code == 10001){
    				viewError("请重新获取验证码");
    			}else if(result.code == 10000){
    				window.location.href="<%=request.getContextPath()%>/jsp/activity/registerSuccess.jsp";
    			}
    		}
    	});	
        
        
    })
})

$(".phonenum").focus(function() {
			$("html,body").css("overflow","auto")
		});
</script>
</html>