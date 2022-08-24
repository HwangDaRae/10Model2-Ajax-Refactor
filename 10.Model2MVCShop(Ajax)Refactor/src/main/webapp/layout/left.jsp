<%@page import="com.model2.mvc.service.domain.User"%>
<%@ page contentType="text/html; charset=euc-kr" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
<title>Model2 MVC Shop</title>

<link href="/css/left.css" rel="stylesheet" type="text/css">
<script src="//code.jquery.com/jquery-2.1.4.js" type="text/javascript"></script>

<script type="text/javascript">
	function history() {
		popWin = window.open( "/history.jsp", "popWin",
			"left=300, top=200, width=300, height=200, marginwidth=0, marginheight=0, scrollbars=no, scrolling=no, menubar=no, resizable=no");
	}

	//==> jQuery 적용 추가된 부분
	$(function() {
		//==> 개인정보조회 Event 연결처리부분
		//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
		$(".Depth03:contains('개인정보조회')").bind( "click",function() {
			//Debug..
			//alert(  $( ".Depth03:contains('개인정보조회')" ).html() );
			$(window.parent.frames["rightFrame"].document.location).attr("href","/user/getUser?userId=${user.userId}");
		});

		//==> 회원정보조회 Event 연결처리부분
		//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
		$(".Depth03:contains('회원정보조회')").bind( "click",function() {
			//Debug..
			//alert(  $( ".Depth03:contains('회원정보조회')" ) );
			$(window.parent.frames["rightFrame"].document.location).attr("href", "/user/listUser");
		});
		
		$(".Depth03:contains('판매상품등록')").bind( "click",function() {
			$(window.parent.frames["rightFrame"].document.location).attr("href", "/product/addProductView");
		});
		
		$(".Depth03:contains('판매상품관리')").bind( "click",function() {
			$(window.parent.frames["rightFrame"].document.location).attr("href", "/product/listProduct/manage");
		});
		
		$(".Depth03:contains('상 품 검 색')").bind( "click",function() {
			$(window.parent.frames["rightFrame"].document.location).attr("href", "/product/listProduct/search");
		});
		
		$(".Depth03:contains('구매이력조회')").bind( "click",function() {
			$(window.parent.frames["rightFrame"].document.location).attr("href", "/purchase/listPurchase");
		});
		
		$(".Depth03:contains('장바구니')").bind( "click",function() {
			$(window.parent.frames["rightFrame"].document.location).attr("href", "/cart/listCart");
		});
		
		$(".Depth03:contains('비회원주문조회')").bind( "click",function() {
			$(window.parent.frames["rightFrame"].document.location).attr("href", "/purchase/nonMemberPurchase");
		});
		
		$(".Depth03:contains('최근 본 상품')").bind( "click",function() {
			history();
		});
	});
</script>
</head>

<body background="/images/left/imgLeftBg.gif" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">

<table width="159" border="0" cellspacing="0" cellpadding="0">
<!--menu 01 line-->
<tr>
	<td valign="top">
		<table border="0" cellspacing="0" cellpadding="0" width="159">
			<tr>
				<c:if test="${ !empty user }">
					<tr>
						<td class="Depth03">개인정보조회</td>
					</tr>
				</c:if>
				<c:if test="${user.role == 'admin'}">
					<tr>
						<td class="Depth03">회원정보조회</td>
					</tr>
				</c:if>
			<tr>
				<td class="DepthEnd">&nbsp;</td>
			</tr>
		</table>
	</td>
</tr>

<c:if test="${user.role == 'admin'}">
<!--menu 02 line-->
<tr>
<td valign="top"> 
	<table  border="0" cellspacing="0" cellpadding="0" width="159">
		<tr>
			<td class="Depth03">
				<!-- <a href="/product/addProductView" target="rightFrame">판매상품등록</a> -->
				판매상품등록
			</td>
		</tr>
		<tr>
		<td class="Depth03">
				<!-- <a href="/product/listProduct/manage" target="rightFrame">판매상품관리</a> -->
				판매상품관리
			</td>
		</tr>
		<tr>
			<td class="DepthEnd">&nbsp;</td>
		</tr>
	</table>
</td>
</tr>
</c:if>

<!--menu 03 line-->
<tr>
<td valign="top">
	<table  border="0" cellspacing="0" cellpadding="0" width="159">
		<tr>
			<td class="Depth03"><!-- /menu=search -->
				<!-- <a href="/product/listProduct/search" target="rightFrame">상 품 검 색</a> -->
				상 품 검 색
			</td>
		</tr>
		<c:if test="${ !empty user && user.role == 'user'}">
		<tr>
			<td class="Depth03">
				<!-- <a href="/purchase/listPurchase" target="rightFrame">구매이력조회</a><br/> -->
				구매이력조회
			</td>
		</tr>
		</c:if>
		<tr>
			<td class="Depth03">
				<!-- <a href="/cart/listCart" target="rightFrame">장바구니</a><br/> -->
				장바구니
			</td>
		</tr>
		<c:if test="${ empty user || user.userId == 'non-member' }">
		<tr>
			<td class="Depth03">
				<!-- <a href="/purchase/nonMemberPurchase" target="rightFrame">비회원주문조회</a><br/> -->
				비회원주문조회
			</td>
		</tr>
		</c:if>
		<tr>
		<td class="DepthEnd">&nbsp;</td>
		</tr>
		<tr>
			<td class="Depth03">
			<!-- <a href="javascript:history()">최근 본 상품</a> -->
			최근 본 상품
			</td>
		</tr>
	</table>
</td>
</tr>

</table>
</body>
</html>