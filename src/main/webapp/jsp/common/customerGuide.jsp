<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8" import="org.owasp.esapi.ESAPI" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<!-- <meta charset="utf-8">
<meta name="viewport"
	content="width=device-width,inital-scale=1.0,minimum-scale=0.5,maximum-scale=2.0,user-scalable=no"> -->
<meta charset="UTF-8">
<!-- 和屏幕一样宽，缩放比例是1，不允许手动缩放 -->
<meta name="viewport"
	content="width=device-width, initial-scale=1,maximum-scale=1.0,user-scalable=0">
<title>用户指南</title>
<%@ include file="../common/header.jsp"%>
</head>
<%
	String titleId = request.getParameter("titleId");
%>
<body>
	<div style="margin-left: 15px;margin-right: 15px;" id="customerGuide" name="customerGuide"></div>
</body>
<script type="text/javascript">
	$(function(){
		var titleId = '<%=ESAPI.encoder().encodeForJavaScript(titleId)%>';
		var url = '<%=request.getContextPath()%>/sysGuide/getSysGuideById?id='+titleId;
			$.post(url,function(result){
				var divshow = $("#customerGuide");
				divshow.append(result.sysGuide.content);
		},'json');
	});
</script>
</html>

