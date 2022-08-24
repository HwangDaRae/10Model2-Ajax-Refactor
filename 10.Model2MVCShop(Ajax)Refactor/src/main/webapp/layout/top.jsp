<%@page import="com.model2.mvc.service.domain.User"%>
<%@ page contentType="text/html; charset=euc-kr" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
	User vo=(User)session.getAttribute("user");
%>

<html>
<head>
<title>Model2 MVC Shop git remote 연결 연습용</title>

<link href="/css/left.css" rel="stylesheet" type="text/css">
<script src="//code.jquery.com/jquery-2.1.4.js" type="text/javascript"></script>
<script type="text/javascript">

$(function() {
	 
	//==> login Event 연결처리부분
	//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
	$( "td[width='115']:contains('login')" ).on("click" , function() {
		//Debug..
		//alert(  $( "td[width='115']:contains('login')" ).html() );
		$(window.parent.frames["rightFrame"].document.location).attr("href","/user/login");
	});
	
	
	//==> login Event 연결처리부분
	//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
	$( "td[width='56']:contains('logout')" ).on("click" , function() {
		//Debug..
		//alert(  $( "td[width='56']:contains('logout')" ).html() );
		$(window.parent.document.location).attr("href","/user/logout");
	}); 
});	

</script>

</head>

<body topmargin="0" leftmargin="0">
 
<table width="100%" height="50" border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td width="800" height="30"><h2>Model2 MVC Shop</h2></td>
    <td height="30" >&nbsp;</td>
  </tr>
  <tr>
    <td height="20" align="right" background="/images/img_bg.gif">
	    <table width="200" border="0" cellspacing="0" cellpadding="0">
	        <tr> 
	          <td width="115">
		          <c:if test="${ empty user }">
						login
		           </c:if>
	          </td>
	          <td width="14">&nbsp;</td>
	          <td width="56">
		          <c:if test="${ ! empty user }">
		            	logout
		           </c:if>
	          </td>
	        </tr>
	    </table>
    </td>
    <td height="20" background="/images/img_bg.gif">&nbsp;</td>
  </tr>
</table>

</body>
</html>
