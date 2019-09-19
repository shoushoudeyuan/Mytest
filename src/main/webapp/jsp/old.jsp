<%@ page language="java" pageEncoding="UTF-8"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE HTML>
<html>
<head>
<title><spring:message code="site.name"/></title>
<%@ include file="./common/header.jsp"%>
<style type="text/css">
body {
	height: 100%;
	overflow: hidden;
	margin: 0px;
	padding: 0px;
	background-color: #f5f5f5;
}
.box {
	height: 100%;
	position: absolute;
	width: 100%;
}
.right {
	background: #fff;
	border-radius: 2px;
	border: 1px solid #c1c1c1;
	margin-left: 20px;
}
.panel-body ul {
	margin: 0px !important;
	padding: 0px !important;
}
.panel-body li {
	padding: 0px ;
	margin: 0px ;
	list-style: none;
	background-color: #FFF;
	border: 1px solid #e8e8e8;
	height: 35px;
	margin-bottom: 1px ;
	font-family: "Microsoft YaHei UI Light", "微软雅黑";
	text-align: left;
    padding-left: 30px !important;
	font-size: 14px;
	line-height: 35px;
	-moz-border-radius: 2px;
	-webkit-border-radius: 2px;
	border-radius: 2px;
	cursor:pointer;
}
.panel-body li a {
	color: #1e1d1d !important;
}
.panel-body li:hover {
	border: 1px solid #505b6b;
	background: url(${pageContext.request.contextPath}/img/hvoer.png) #FFF no-repeat right bottom;
}

.panel-body li.selected {
	border: 1px solid #505b6b;
	background: url(${pageContext.request.contextPath}/img/hvoer.png) #FFF no-repeat right bottom;
}
</style>
<script type="text/javascript">
	function loadHtml(url) {
		$(function() {
			document.getElementById("content").innerHTML = '<iframe style="width:100%;height:99%; border:0px;" src="'
					+ url + '" name="window"></iframe>';
		});
	}

	$(function() {
		$("#content").height($(window).height() - 110);
		$("#content").width($(window).width() - 210);
	});
</script>
</head>
<body>
	<div class="easyui-layout box">
		<div id="header" data-options="region:'north'" class="index_top" style="height:60px;line-height:60px;overflow: hidden;">
			<div class="logo">${siteName}</div>
			<dl>
				<dt>
					<img src="${pageContext.request.contextPath}/css/default/images/user_51.png" />
				</dt>
				<dd>
					<a href="#">${user.username}</a>
				</dd>
				<dt>
					<img src="${pageContext.request.contextPath}/css/default/images/out.png" />
				</dt>
				<dd>
					<a href="javascript:loginOut();"><spring:message code="site.loginout"/></a>
				</dd>
			</dl>
		</div>
		<div data-options="region:'west',noheader:'true',split:true"
			title="菜单" style="width: 175px; height: 100%; top:65px">
			<div id="aa" class="easyui-accordion">
				<c:forEach var="menuParent" items="${sessionScope.menuList}">
					<div title="${menuParent.name}">
						<ul>
							<c:forEach var="menuChildren" items="${menuParent.childrenList}">
								<li onClick="javascript:loadHtml('${menuChildren.url}');">${menuChildren.name}</li>
							</c:forEach>
						</ul>
					</div>			
				</c:forEach>
			</div>
		</div>	
		<div data-options="region:'center',noheader:'true',title:'Main Title',iconCls:'icon-ok'"
			id='content' class="right"></div>
</div>	
</body>
<script type="text/javascript">
	var tempLi;
	var leftWidth = 175;
	$(function (){
		$('li').click( function () {
			if(tempLi){
				$(tempLi).removeClass("selected");
			}
			tempLi = this;
			$(this).addClass("selected");
		});
		
		//调整左侧菜单样式
		$("#aa").css("width",leftWidth);
		$("#aa").parent().css("width",leftWidth+5);
		$($("#aa").parent()).parent().css("width",leftWidth+5);
		$($("#aa").parent()).parent().css("top",$("#header").height()+5);
		$("#content").parent().css("top",$("#header").height()+5);
		loadHtml("order/orderManage.jsp");
	});
	
	function loginOut(){
		var path = '<%=request.getContextPath()%>/sysUser/loginOut';
		var login = '<%=request.getContextPath()%>/';
		$.ajax({
			   type: "POST",
			   url: path,
			   async: false,
			   data: {},
			   dataType: "json",
			   success: function(result){
				   if (result.success){
					   $.messager.alert('操作提示','退出成功!');  
	               	 	window.location.href = login;   
	               } else {
	            	   $.messager.alert('操作提示','退出失败!');  
	               }
			   }
		});
	}
</script>
</html>
