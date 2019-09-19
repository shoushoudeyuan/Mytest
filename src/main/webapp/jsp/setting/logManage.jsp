<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html>
<head>
<title>日志</title>
<%@ include file="../common/header.jsp" %>
</head>
<body>
    <div class="list_title">
        <span class="layui-parent-title-customer">HOME</span>
        <span class="layui-badge-dot layui-bg-title"></span>
        <span class="layui-children-title-customer">全站日志</span>
    </div>
	<div id="tt" class="easyui-tabs" data-options="border:false" style="width:100%;">
		
	    <div title="车辆日志" style="display:none;width:100%;height:100%" href="${pageContext.request.contextPath}/jsp/setting/opLogList.jsp">
	    </div>
	    <div title="后台日志" style="display:none;width:100%;height:100%" href="${pageContext.request.contextPath}/jsp/setting/sysLogList.jsp">
	    </div>
<%-- 	    <div title="蓝牙日志" style="display:none;width:100%;height:100%" href="${pageContext.request.contextPath}/jsp/setting/bluetoothLogList.jsp"> --%>
<!-- 	    </div> -->
	</div>
</body>
</html>