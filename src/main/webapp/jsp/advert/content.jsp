<%@ page language="java" pageEncoding="UTF-8" import="org.owasp.esapi.ESAPI" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
<%@ include file="../common/header.jsp"%>
<title>详情</title>
<style>
html
{
 overflow: auto;
}
</style>
<script type="text/javascript">
			
	$(function() {  
		
		var id = '<%=ESAPI.encoder().encodeForJavaScript(request.getParameter("id"))%>';
		var url = '${pageContext.request.contextPath}/advertisement/getContent'
			$.ajax({
				type : "GET",
				url : url,
				data : {
					id : id
				},
				dataType : "json",
				success : function(data) {
					if (data.success == true) {
						if(data.advert.imglink != null && data.advert.imglink.length > 0)
							{
						     self.location.href = data.advert.imglink;
							}
						else
							{
							$("#body").append(data.advert.content);
							}

					} else {
						$.messager.alert("操作提示", "操作失败！", "");
					}

				},
				error : function() {
					$.messager.alert("操作提示", "操作失败！", "");
				}
			});
	
	});

</script>
</head>
<body id='body'>

</body>
</html>