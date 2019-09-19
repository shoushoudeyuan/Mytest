<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>	
<%
    String bjymktms = "bjymktms";
    String bjyadmin = "bjyadmin";
    String bjycrm = "bjycrm";
    String bjyvms = "bjyvms";
    String bjyoms = "bjyoms";
%>  
<!-- 引入JQuery -->
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/jquery-easyui-1.5/jquery.min.js"></script>
<!-- 引入EasyUI -->
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/jquery-easyui-1.5/jquery.easyui.min.js" ></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/jquery-easyui-1.5/datagrid-groupview.js" ></script>
<!-- 引入EasyUI的中文国际化js，让EasyUI支持中文 -->
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/jquery-easyui-1.5/locale/easyui-lang-zh_CN.js" ></script>
<!-- 引入EasyUI的样式文件-->
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/js/jquery-easyui-1.5/themes/default2/easyui.css"
	type="text/css" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/index2.css" type="text/css" />
<!-- 引入EasyUI的图标样式文件-->
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/js/jquery-easyui-1.5/themes/icon.css"
	type="text/css" />
<!-- 引入内层样式文件-->
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/default/skin_inner.css"
	type="text/css" />
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/util/common.js?v20180705"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/util/extendValidate.js"></script>
	<!-- 引入时间控件 -->
	<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/laydate/laydate.js"></script>
