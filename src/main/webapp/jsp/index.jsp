<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8" />
<meta http-equiv="Content-Security-Policy" content="default-src * data: cdvfile: gap:; style-src * 'unsafe-inline'; script-src * 'unsafe-inline' 'unsafe-eval'"/>
<title>魔方分时租赁服务管理平台</title>
<link href="/favicon.ico" rel="shortcut icon" type="image/x-icon" />
<link href="${pageContext.request.contextPath}/css/reset.css" rel="stylesheet">
<link
	href="http://cdn.bootcss.com/jquery-datetimepicker/2.5.1/jquery.datetimepicker.min.css"
	rel="stylesheet">
<link href="${pageContext.request.contextPath}/css/main.css?v=20170724" rel="stylesheet">
<link href="${pageContext.request.contextPath}/css/common.css"
	rel="stylesheet">
<!-- 主题样式文件-->
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/themes/<spring:message code='site.theme'/>.css" type="text/css" />

    <link rel="stylesheet" href="../css/viewer.min.css" type="text/css"/>
    
	<script src="http://icss2.baojia.com/scripts/jquery-2.1.1.min.js"></script>
	<script src="http://icss2.baojia.com/scripts/iscroll.min.js"></script>

    <script type="text/javascript" src="../js/viewer.min.js"></script>
</head>
<body class="p_body">
	<header>
		<div class="header cl">
			<div class="logo">
				<span class="cloud"></span>
				<div class="con">
					<h1>
						<c:choose>
							<c:when test="${canVisitStatisticPage eq true }">
								<a href="${pageContext.request.contextPath}/jsp/index.jsp" rel="noopener noreferrer"><font color="#000"><b>${siteName}</b></font></a>
							</c:when>
							<c:otherwise>
								<font color="#000"><b>${siteName}</b></font>
							</c:otherwise>
						</c:choose>
					</h1>
				</div>
			</div>
			<div class="title cl">
				<ul>
				    <li>
                     <a href="${pageContext.request.contextPath}/img/saasServicePrice.pdf" target="_blank"  title="魔方出行系统服务价格明细.pdf">
                                                                          服务明细
                     </a>
                    </li>
					<li>
					 <a href="${pageContext.request.contextPath}/updateLog.html" target="_blank"  title="更新列表" class="icon legend3" >
					 </a>
					</li>
					<c:choose>
						<c:when test="${ifShowBell eq true }">
							<li id="yesEm" style="display: none;">
							 <a  mid="11"  href="javascript:loadHtmlCustomer('customer/customerlist.jsp');" class="icon legend1" >
							 	<em style="display:block;position:absolute;top:5px;right:4px;width:15px;height:15px;border-radius:15px;background:red;color:#fff;text-align:center;line-height:15px;font-size:8px;" id="identityCount"></em>
							 </a>
							</li>
							<li id="noEm" style="display: block;">
							 <a  mid="11"  href="javascript:;" class="icon legend1" >
							 </a>
							</li>
						</c:when>
						<c:otherwise>
							<li>
							 <a  mid="11"  href="javascript:;" class="icon legend1" >
							 </a>
							</li>
						</c:otherwise>
					</c:choose>
					<li>
					 <a href="javascript:;" class="icon legend2" ></a>
					</li>
					<c:choose>
						<c:when test="${isManager eq true }">
							<li class="division"><a target="_blank" class="company" onclick="gotoEam()" href="${eamLoginUrl}">${user.username}</a></li> 
						</c:when>
						<c:otherwise>
							<li class="division"><a class="company">${user.username}</a></li>
						</c:otherwise>
					</c:choose>
					
					<c:if test="${ifEnterprise eq false }">
						<li style="position:relative;">
							<a class="cardistance">车管端地址</a>
							<div class="distance" style="position:fixed;margin-top:-25px;background:#fff;width:85px;display:none;">
								<a href="javascript:;" style="display:block;text-align:center;line-height:25px;font-size:13px;" id="downUrl2" target="_blank">iOS</a>
								<a href="javascript:;" style="display:block;text-align:center;line-height:25px;font-size:13px;" id="downUrl1"" target="_blank">Android</a>
							</div>
						</li>
					</c:if>
					<li>|</li>
										
					<li><a href="javascript:logout();" class="company">
						<spring:message code="site.loginout" /></a></li>
						
					
					<%-- <li><a href="javascript:;"><span
							class="icon pasmanage"></span>
							${user.username}</a></li> --%>
				</ul>
			</div>
		</div>
	</header>
	<div class="cont">
		<div class="left">
			<div id="menuWrapper" class="sysScroll">
				<div id="scroller" class="curscroller">
					<div class="menuList">
						<!-- <div class="togg">
							<div class="line">
								<p></p>
								<p></p>
								<p></p>
							</div>
						</div> -->

						<c:forEach var="menuParent" items="${sessionScope.menuList}">
							<div class="menu cl" id="m${menuParent.id}">
								<span class="first"> <b>${menuParent.name}</b></span>
								<div>
									<p class=""><span class="icon${menuParent.id}" id="ss${menuParent.id}"></span> ${menuParent.name}</p>
									<ul style="display: none;">
										<c:forEach var="menuChildren" items="${menuParent.childrenList}">
											<c:if test="${!menuChildren.url.contains('activity/activityManage.jsp')}">
                                                 <li><%-- <span class=""> <i mid="11"
                                                        class="icon newicon3"></i><b>${menuChildren.name}</b></span> --%> 
                                                    <c:choose>
                                                        <c:when test="${menuChildren.url.contains('carPosition.jsp')}">
                                                            <a mid="11" href="vehicle/carPosition.jsp" title="${menuChildren.name}" target="_blank">${menuChildren.name}</a>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <a mid="11" href="javascript:loadHtml('${menuChildren.url}');" title="${menuChildren.name}" id="a${menuChildren.id}">${menuChildren.name}</a>
                                                        </c:otherwise>
                                                    </c:choose> 
                                                </li>
                                            </c:if>
										</c:forEach>
									</ul>
								</div>
							</div>
						</c:forEach>
					</div>
				</div>
			</div>
		</div>

		<div id="rightcontent" class="right cl">
			<div class="curMenu" style="display: none;">
				<h1>&nbsp;</h1>
				<ul>
					<li><a href="javascript:;">&nbsp;</a></li>
				</ul>
				<div id="menuActIcon" class="menuAct"></div>
			</div>
			<div class="curCont" id="curCont">
				<c:choose>
					<c:when test="${canVisitStatisticPage eq true }">
						<iframe id="contentFrame" name="contentFrame"
						src="dateCartogram/statisticIndex.jsp" style="width: 100%; min-height: 700px;"
						frameborder="0"></iframe>
					</c:when>
					<c:otherwise>
						<iframe id="contentFrame" name="contentFrame"
							src="" style="width: 100%; min-height: 700px;"
							frameborder="0"></iframe>
					</c:otherwise>
				</c:choose>
			</div>
		</div>

	</div>
	<iframe name="logout_bms" width="0px" height="0px"></iframe>
	<!-- /退出 -->

	
	<div id="lookPicx" style="display:none;">
        
    </div>
	<script src="http://css.baojia.com/s4/c/js/jquery.datetimepicker.full.min.js" type="text/javascript"></script>

	<script language="javascript">
		var menudata = [];
	    var url = '<%=request.getServerName()%>';
		if(url=="rental1.baojia.com"){
			//alert(1);
		}
		(function ($) {
			$.fn.dragDivResize = function () {
				var deltaX, deltaY, _startX, _startY;
				var resizeW, resizeH;
				var size = 400;
				var minSize = 20;
				var scroll = getScrollOffsets();
				var _this = this;
				for (var i = 0; i < _this.length; i++) {
					var target = this[i];
					$(target).on("mouseover mousemove", overHandler);
				}
				function outHandler() {
					for (var i = 0; i < _this.length; i++) {
						target.style.outline = "none";
					}
					document.body.style.cursor = "default";
				}
				function overHandler(event) {
					target = event.target || event.srcElement;
					var startX = event.clientX + scroll.x;
					var startY = event.clientY + scroll.y;
					var w = $(target).width();
					var h = $(target).height();
					_startX = parseInt(startX);
					_startY = parseInt(startY);
					if ((0 < target.offsetLeft + w - _startX && target.offsetLeft + w - _startX < size) || (0 < target.offsetTop + h - _startY && target.offsetTop + h - _startY < size)) {
						target.style.outline = "2px dashed #333";
						if ((0 > target.offsetLeft + w - _startX || target.offsetLeft + w - _startX > size) && 0 < target.offsetTop + h - _startY && target.offsetTop + h - _startY < size) {
							resizeW = false;
							resizeH = true;
							document.body.style.cursor = "s-resize";
						}
						if (0 < target.offsetLeft + w - _startX && target.offsetLeft + w - _startX < size && (0 > target.offsetTop + h - _startY || target.offsetTop + h - _startY > size)) {
							resizeW = true;
							resizeH = false;
							document.body.style.cursor = "w-resize";
						}
						if (0 < target.offsetLeft + w - _startX && target.offsetLeft + w - _startX < size && 0 < target.offsetTop + h - _startY && target.offsetTop + h - _startY < size) {
							resizeW = true;
							resizeH = true;
							document.body.style.cursor = "se-resize";
						}
						$(target).on('mousedown', downHandler);
					} else {
						resizeW = false;
						resizeH = false;
						$(target).off('mousedown', downHandler);
					}
				}
				function downHandler(event) {
					target = event.target || event.srcElement;
					var startX = event.clientX + scroll.x;
					var startY = event.clientY + scroll.y;
					_startX = parseInt(startX);
					_startY = parseInt(startY);
					if (document.addEventListener) {
						document.addEventListener("mousemove", moveHandler, true);
						document.addEventListener("mouseup", upHandler, true);
					} else if (document.attachEvent) {
						target.setCapture();
						target.attachEvent("onlosecapeture", upHandler);
						target.attachEvent("onmouseup", upHandler);
						target.attachEvent("onmousemove", moveHandler);
					}
					if (event.stopPropagation) {
						event.stopPropagation();
					} else {
						event.cancelBubble = true;
					}
					if (event.preventDefault) {
						event.preventDefault();
					} else {
						event.returnValue = false;
					}
				}
				function moveHandler(e) {
					if (!e) e = window.event;
					var w, h;
					var startX = parseInt(e.clientX + scroll.x);
					var startY = parseInt(e.clientY + scroll.y);
					target = target || e.target || e.srcElement;
					if (target == document.body) {
						return;
					}
					if (resizeW) {
						deltaX = startX - _startX;
						w = $(target).width() + deltaX < minSize ? minSize : $(target).width() + deltaX;
						target.style.width = w + "px";
						_startX = startX;
					}
					if (resizeH) {
						deltaY = startY - _startY;
						h = $(target).height() + deltaY < minSize ? minSize : $(target).height() + deltaY;
						target.style.height = h + "px";
						_startY = startY;
					}
					if (e.stopPropagation) {
						e.stopPropagation();
					} else {
						e.cancelBubble = true;
					}
				}
				function upHandler(e) {
					if (!e) {
						e = window.event;
					}
					resizeW = false;
					resizeH = false;
					target = e.target || e.srcElement;
					$(target).on("mouseout", outHandler);
					if (document.removeEventListener) {
						document.removeEventListener("mousemove", moveHandler, true);
						document.removeEventListener("mouseup", upHandler, true);
					} else if (document.detachEvent) {
						target.detachEvent("onlosecapeture", upHandler);
						target.detachEvent("onmouseup", upHandler);
						target.detachEvent("onmousemove", moveHandler);
						target.releaseCapture();
					}
					if (e.stopPropagation) {
						e.stopPropagation();
					} else {
						e.cancelBubble = true;
					}
				}
				function getScrollOffsets(w) {
					w = w || window;
					if (w.pageXOffset != null) {
						return { x: w.pageXOffset, y: w.pageYOffset };
					}
					var d = w.document;
					if (document.compatMode == "CSS1Compat") {
						return { x: d.documentElement.scrollLeft, y: d.documentElement.scrollTop };
					}
					return { x: d.body.scrollLeft, y: d.body.scrollTop };
				}
			}
		}(jQuery));
	</script>
	<script language="javascript">
		var menuScroll;
		var subMenuList =  new Array();
		function loaded() {
			menuScroll = new IScroll('#menuWrapper', {
				mouseWheel: false,
				click: false
			});
			loadCustomerCount();
		}
		
		$(".menuList ul li a").click(function(){
			$(".menuList ul li a").removeClass('on');
			$(this).addClass("on");
		})
		function toggleRight(){
			  var obj = $("#rightcontent");
			  if(obj.hasClass('on')) {
				$(".curMenu h1").show();
				$(".curMenu ul").show();
				$(".curMenu").css("width","15%");
				$(".curCont").css("width","85%");			
				$(".curMenu .menuAct").css("left","14%");	
				$(".curMenu").css({"min-height": $(window).height() - $(".header").innerHeight()});			
				obj.removeClass('on');
			  }
			  else
			  {
				$(".curMenu h1").hide();
				$(".curMenu ul").hide();
				$(".curMenu").css("width","0px");
				$(".curMenu .menuAct").css("left","0px");
				$(".curMenu").css({"min-height": 0,});			
				$(".curCont").css("width","100%");
				obj.addClass('on');
			  }
		}
		
		function showRight()
		{
				var obj = $("#rightcontent");
				$(".curMenu h1").show();
				$(".curMenu ul").show();
				$(".curMenu").css("width","15%");
				$(".curCont").css("width","85%");			
				$(".curMenu .menuAct").css("left","14%");	
				$(".curMenu").css({"min-height": $(window).height() - $(".header").innerHeight()});			
				obj.removeClass('on')
		}
		
		// utility function called by getCookie()
		function getCookieVal(offset) {
			var endstr = document.cookie.indexOf(";", offset);
			if (endstr == -1) {
				endstr = document.cookie.length;
			}
			return unescape(document.cookie.substring(offset, endstr));
		}		
		
		// primary function to retrieve cookie by name
		function getCookie(name) {
			var arg = name + "=";
			var alen = arg.length;
			var clen = document.cookie.length;
			var i = 0;
			while (i < clen) {
				var j = i + alen;
				if (document.cookie.substring(i, j) == arg) {
					return getCookieVal(j);
				}
				i = document.cookie.indexOf(" ", i) + 1;
				if (i == 0) break;
			}
			return null;
		}
		 
		// store cookie value with optional details as needed
		function setCookie(name, value, expires, path, domain, secure) {
			document.cookie = name + "=" + escape(value) +
			((expires) ? "; expires=" + expires : "") +
			((path) ? "; path=" + path : "") +
			((domain) ? "; domain=" + domain : "") +
			((secure) ? "; secure" : "");
		}
		
		// remove the cookie by setting ancient expiration date
		function deleteCookie(name, path, domain) {
			if (getCookie(name)) {
				document.cookie = name + "=" +
			  ((path) ? "; path=" + path : "") +
			  ((domain) ? "; domain=" + domain : "") +
			  "; expires=Thu, 01-Jan-1970 00:00:01 GMT";
			}
		}

		function returnOld()
		{
			setCookie("nobar","0");
			deleteCookie("nobar");
		}
		
		document.addEventListener('touchmove', function(e) {
			e.preventDefault();
		}, false);
		
		function transUrl(url){
		   //if(!item){
		   //	  return "order/orderManage.jsp";
		   //}
		   //var url = item.url;
		   return url;
		}

		var menuAct = {
			curTree:null,
			init: function() {
				menuAct.initDom();
			},
			initAct:function(){
				$(".togg").click(function() {
					if ($(".cont").hasClass('cont2')) {
						$(".cont").removeClass('cont2');
						$(this).find("div").addClass('line')
					} else {
						$(".cont").addClass('cont2');
						$(this).find("div").removeClass('line')
					}
				})

				$(".menuList").click(function(e) {
					if (e.target.tagName == "SPAN") {
						var objMenu = $(e.target).parents(".menu");
						menuAct.menuOpen($(objMenu[0]));
					}
					if (e.target.tagName == "P") {
						var objMenu = $(e.target).parents(".menu");
						menuAct.menuOpen($(objMenu[0]));
					}
					if (e.target.tagName == "A"||e.target.tagName == "I") {
					  var mid = $(e.target).attr("mid");
					  $(e.target).addClass("on");
					  $(e.target).parent().siblings().find("a").removeClass("on");
					  menuAct.initMenu(mid);
					}
				});		

				$("#rightconnt .menuAct").click(function(e) {
					  var obj = $(e.target).parents(".right");
					  if(obj.hasClass('on')) {
						obj.removeClass('on')
					  }else{
						obj.addClass('on')
					  }
				});
			},
			initDom:function(){	
				if(!menuScroll){
					menuScroll = new IScroll('#menuWrapper', {
						mouseWheel: false,
					    click: true, 
					    tap: true
					});
				}
				menuScroll.refresh();
				$(".left ul").slideUp();
				menuAct.initAct();
			},
			initLi: function() {
				var obj = $(".left .cur");
				if (obj.length == 0) return;
				var objMenu = obj.parents(".menu");
				menuAct.menuOpen($(objMenu[0]));
			},
			menuOpen: function(menu) {
				if (!menu) return;
				$(".left ul").slideUp();
				$(".left .on").removeClass('on');
				var objul = menu.find('ul');
				if (!objul.is(':visible')) {
					objul.slideDown();
					menu.find("p").addClass('on');
					menu.find("span").addClass('on');
					$(".curscroller").css({
						"transform": "translate(0px, 0px)"
					});
				};
				//menuScroll.refresh();
			},
			initMenu:function(id){
				$(".right").removeClass('on');
				var menus = subMenuList[id];
				if(menus && menus.submenu)
				{			
					var menu_content = '';
					menu_content += '<h1>'+menus.title+'</h1>';
					menu_content += '    <ul>';
					var summenus  = menus.submenu;
					for(var i=0;i<summenus.length;i++){
						menu_content += '    <li><a href="'+transUrl(summenus[i])+'#nobar"  target="'+(summenus[i].target?summenus[i].target:"contentFrame")+'" title="'+summenus[i].title+'">'+summenus[i].title+'</a></li>';
					}
					menu_content += '    </ul>';			
					menu_content += '    <div id="menuActIcon" class="menuAct" onclick="toggleRight()"></div>';
					$(".curMenu").show();
					$(".curMenu").html(menu_content);
					$("#curCont").css("width","85%");
					$(".curMenu").dragDivResize();
					$(".curMenu ul li a").each(function(){
						$(this).click(function(){
							$(".curMenu ul li a").removeClass('on');
							$(this).addClass("on");
						});
					});
					
					showRight();
				}
				else
				{
					$(".curMenu").hide();
					//$("#contentFrame").attr("src",transUrl(menus)+"#nobar");
					$("#contentFrame").attr("src","");
					$("#curCont").css("width","100%");
				}			
			},
		}
		
		function loadHtml(url){
			$("#contentFrame").attr("src",url);
			loadCustomerCount();
		}
		
		/* function loadHtmlCustomer(url){
			$(".left ul").slideUp();
			$(".left .on").removeClass('on');
			$("#contentFrame").attr("src",url+"?identityapprove=3");
			$('#s51').addClass("on");
			$('#p51').addClass("on");
			$('#ss51').addClass("on");
			$('#u51').attr("style","display: block;");
			$('#a52').addClass("on");
			toggleRight();
			loadCustomerCount();
		} */
		function loadHtmlCustomer(url){
			$("#contentFrame").attr("src",url+"?identityapprove=3");
			$(".left ul").slideUp();
			$(".left .on").removeClass('on');
			var menu = $('#m51')
			var objul = menu.find('ul');
			if (!objul.is(':visible')) {
				objul.slideDown();
				menu.find("p").addClass('on');
				menu.find("span").addClass('on');
				$('#a52').addClass("on");
				$(".curscroller").css({
					"transform": "translate(0px, 0px)"
				});
			};
			loadCustomerCount();
		}
		
		function logout(){
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
		               	   window.location.href = login;   
		               } else {
		            	   alert('退出失败!');
		               }
				   }
			});
		}
		
		$(function()
		{
			var viewHeight = $(window).height() - $(".header").innerHeight();
			$(".sysScroll").css({
				"min-height": viewHeight,
			});
			
			$(".left").css({
				"min-height": viewHeight,
				"top": $(".header").innerHeight()
			});

			$(".right").css({
				"min-height": $(window).height(), 
				"top": $(".header").innerHeight(),
				"overflow": "hidden"
			});
			
			$(".curMenu").css({
				"min-height": $(window).height() - $(".header").innerHeight(),
			});
			
			$("#contentFrame").css({
				"min-height": $(window).height() - $(".header").innerHeight(),
				"top": $(".header").innerHeight(),
			});
					
			menuAct.init();
			loaded();
			
			$(window).resize();
		});
		function loadCustomerCount(){
			$.ajax({   
		    	url:'<%=request.getContextPath()%>/sysUser/loadCustomerCount',
				type : 'post', //数据发送方式   
				dataType : 'json',//接受数据格式   
				async : false,
				success : function(result) {
					if (result>0) {
						$('#identityCount').text(result);
						$('#yesEm').attr('style','display: block;');
						$('#noEm').attr('style','display: none;');
					}else {
						$('#yesEm').attr('style','display: none;');
						$('#noEm').attr('style','display: block;');
					}
				}
			});
		}
		function getCarManagerDownUrl(){
			$.ajax({   
		    	url:'<%=request.getContextPath()%>/sysUser/getCarManagerDownUrl',
				type : 'post', //数据发送方式   
				dataType : 'json',//接受数据格式   
				async : false,
				success : function(result) {
					$('#downUrl'+result[0].clientType).attr("href",result[0].carManagerDownUrl);	
					$('#downUrl'+result[1].clientType).attr("href",result[1].carManagerDownUrl);	
				}
			});
		}
		$(".cardistance").click(function(){
			 if($(".distance").is(":visible")){
				$(".distance").css("display","none");
			}else{
				$(".distance").css("display","block");
			} 
			 getCarManagerDownUrl();
		});
		
       

		var viewer;
	
		//imgUrlStr以","拼接
	    function picFun(imgUrlStr){
	    	
	    	var htmlStr = '';
	    	var imgUrlArr = new Array();
	    	if(imgUrlStr.indexOf(',')>-1){
	    		imgUrlArr = imgUrlStr.split(/,/g);
	    	}else{
	    		imgUrlArr[0] = imgUrlStr;
	    	}
	    	for(var i = 0; i<imgUrlArr.length; i++){
	    		var picUrl = '<%=request.getContextPath()%>/'+imgUrlArr[i];
	    		htmlStr+="<img data-original='"+picUrl+"' src='"+picUrl+"' />";
	    	}
	        
	    	$("#lookPicx").empty().append(htmlStr);
	    	if(!viewer){
                viewer = new Viewer(document.getElementById('lookPicx'),{
                    url: 'data-original'
                });
            }else{
            	viewer.destroy();
            	viewer = new Viewer(document.getElementById('lookPicx'),{
                    url: 'data-original'
                });
            }
	        viewer.show();
	    }
	    
		function downloadImg(imgUrl){
	        var url = "<%=request.getContextPath()%>/customer/downLoadForImg?imgUrl="+imgUrl;
	        window.open(url);
	    }
		
		
		function gotoEam(){
			$.ajax({   
		    	url:'<%=request.getContextPath()%>/entMng/beforeGotoEam?id=${user.id}',
				type : 'get', //数据发送方式   
				async : false,
				success : function(result) {
					if(result == 1)
						return true;
					else
						return false;
				}
			});
		}
		
		
    </script>
    
</body>
</html>