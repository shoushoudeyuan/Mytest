<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
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
<title>无标题文档</title>
</head>
<style>
body{
	width:100%;
	margin:0px auto;
	font-family:"Microsoft YaHei UI Light", "微软雅黑";
	}
.ta01{
	background-color:#22AC38;
	width:100%;
	margin:0px;
	padding:0px;
	height:50px;
	color:#FFF;
	font-family:"Microsoft YaHei UI Light", "微软雅黑";
	font-size:10px;
	}
.ta02{
	width:95%;
	margin:0px auto;
	padding:0px;
	height:80px;
	color:#22AC38;
	font-family:"Microsoft YaHei UI Light", "微软雅黑";
	font-size:12px;
	}
.tr01 td{
	min-height:45px;
	font-size:10px;
	line-height:45px;
	padding:0px;
	}
.tr01 span{
	font-size:12px;
	font-weight:bold;
	}
.dw{
	width:98%;
	padding-right:2%;
	text-align:right;
	font-size:12px;
	color:#000;
	height:50px;
	line-height:50px;
	}
hr{
	border:1px solid #22AC38;
	}
</style>


<body>

<table width="100%" border="1" bordercolor="#22AC38" cellspacing="0" cellpadding="0">
 <tr class="ta01">
    <td align="center" valign="middle">产品</td>
    <td align="center" valign="middle">北汽EV160</td>
    <td align="center" valign="middle">江淮IEV5</td>
    <td align="center" valign="middle">北汽EV200</td>
    <td align="center" valign="middle">比亚迪E5
    </td>
  </tr>


  <tr class="tr01">
    <td rowspan="3" align="center" valign="middle">分时租</td>
    <td align="center" valign="middle"><span>0.4</span>/分钟 </td>
    <td align="center" valign="middle"><span>0.5</span>/分钟 </td>
    <td align="center" valign="middle"><span>0.6</span>/分钟 </td>
    <td align="center" valign="middle"><span>0.8</span>/分钟 </td>
  </tr>
  <tr class="tr01">
    <td align="center" valign="middle"><span>0.5</span>/公里</td>
    <td align="center" valign="middle"><span>0.5</span>/公里</td>
    <td align="center" valign="middle"><span>0.5</span>/公里</td>
    <td align="center" valign="middle"><span>0.5</span>/公里</td>
  </tr>
  <tr class="tr01">
    <td colspan="4" align="left" valign="middle">计费方式为时间计费＋里程计费。</td>
  </tr>
  <tr class="tr01">
    <td rowspan="2" align="center" valign="middle">晚间特惠</td>
    <td align="center" valign="middle"><span>72</span></td>
    <td align="center" valign="middle"><span>90</span></td>
    <td align="center" valign="middle"><span>108</span></td>
    <td align="center" valign="middle"><span>144</span></td>
  </tr>
  <tr class="tr01">
    <td colspan="4" align="left" valign="middle">晚19:00至次日9:00用车，时间计费以上述价格封顶，里程另计。</td>
  </tr>
  <tr class="tr01">
    <td rowspan="2" align="center" valign="middle">全日租</td>
    <td align="center" valign="middle"><span>180</span></td>
    <td align="center" valign="middle"><span>225</span></td>
    <td align="center" valign="middle"><span>270</span></td>
    <td align="center" valign="middle"><span>360</span></td>
  </tr>
  <tr class="tr01">
    <td colspan="4" align="left" valign="middle">24小时为一个计费单位，时间计费以上述价格封顶，里程另计。</td>
  </tr>
  <tr class="tr01">
    <td rowspan="2" align="center" valign="middle">保险</td>
    <td align="center" valign="middle"><span>3</span></td>
    <td align="center" valign="middle"><span>4</span></td>
    <td align="center" valign="middle"><span>5</span></td>
    <td align="center" valign="middle"><span>6</span></td>
  </tr>
  <tr class="tr01">
    <td colspan="4" align="left" valign="middle">单次(24小时内)车损和人身理赔，最高额30万元。</td>
  </tr>
  <tr class="tr01">
    <td rowspan="2" align="center" valign="middle">司乘险</td>
    <td align="center" valign="middle"><span>3</span></td>
    <td align="center" valign="middle"><span>4</span></td>
    <td align="center" valign="middle"><span>5</span></td>
    <td align="center" valign="middle"><span>6</span></td>
  </tr>
  <tr class="tr01">
    <td colspan="4" align="left" valign="middle">单次(24小时内)司机与副驾驶理赔，最高额50万元。</td>
  </tr>
</table>

<div class="dw">单位：人民币(元)</div>

<table class="ta02" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td align="right" valign="middle"><img src="<%=request.getContextPath()%>/img/03.png" width="30"></td>
    <td valign="middle">&nbsp;&nbsp;免收押金</td>
    <td align="right" valign="middle"><img src="<%=request.getContextPath()%>/img/02.png" width="30"></td>
    <td valign="middle">&nbsp;&nbsp;全程自助</td>
    <td align="right" valign="middle"><img src="<%=request.getContextPath()%>/img/01.png" width="30"></td>
    <td valign="middle">&nbsp;&nbsp;异地还车</td>
  </tr>

  <tr>
    <td colspan="3" align="right" valign="middle">服务热线 400 068 0196　</td>
    <td colspan="3" valign="middle">　众行官网 baojia.com</td>
  </tr>
</table>


</body>
</html>
