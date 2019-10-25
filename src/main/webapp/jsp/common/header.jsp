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



<script src="//frontend.mofangchuxing.com/manage/config.json"></script>
<!-- 引入JQuery -->
<script src="//frontend.mofangchuxing.com/jquery-3.2.1.js"></script>
<!-- 引入EasyUI -->
<script src="//frontend.mofangchuxing.com/jquery-easyui-1.5/jquery.easyui.min.js" ></script>
<script src="//frontend.mofangchuxing.com/jquery-easyui-1.5/datagrid-groupview.js" ></script>
<!-- 引入EasyUI的中文国际化js，让EasyUI支持中文 -->
<script src="//frontend.mofangchuxing.com/jquery-easyui-1.5/locale/easyui-lang-zh_CN.js"></script>
<!-- 引入EasyUI的样式文件-->
<link rel="stylesheet" href="//frontend.mofangchuxing.com/jquery-easyui-1.5/themes/default2/easyui.css" stype="text/css" />
<!-- 引入EasyUI的中文国际化js，让EasyUI支持中文 -->
<script src="//frontend.mofangchuxing.com/jquery-easyui-1.5/locale/easyui-lang-zh_CN.js"></script>
<!-- 引入EasyUI的样式文件-->
<link rel="stylesheet" href="//frontend.mofangchuxing.com/jquery-easyui-1.5/themes/default2/easyui.css" stype="text/css" />
<link rel="stylesheet" href="//frontend.mofangchuxing.com/manage/admin/index2.css" type="text/css" />
<!-- 引入EasyUI的图标样式文件-->
<link rel="stylesheet" href="//frontend.mofangchuxing.com/jquery-easyui-1.5/themes/icon.css" type="text/css" />
<!-- 引入内层样式文件-->
<link rel="stylesheet" href="//frontend.mofangchuxing.com/manage/admin/skin_inner.css" type="text/css" />
<script src="//frontend.mofangchuxing.com/manage/util/common.js"></script>
<script src="//frontend.mofangchuxing.com/manage/util/extendValidate.js"></script>
	<!-- 引入时间控件 -->
<script src="//frontend.mofangchuxing.com/laydate/laydate.js"></script>
