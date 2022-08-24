<%@ page contentType="text/html; charset=euc-kr" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>
<head>
<title>구매 목록조회</title>

<link rel="stylesheet" href="/css/admin.css" type="text/css">
<script src="//code.jquery.com/jquery-2.1.4.js" type="text/javascript"></script>

<script type="text/javascript">
$(function(){
	$("b").bind("click",function(){
		var id = $(this).parent().parent().attr("id")
		if( $(this).text().trim() == '물건도착' ){
			location.href="/purchase/updateTranCode?tranNo="
				+$(this).attr("id")+"&tranCode=3&currentPage=${ resultPage.currentPage }";
		}else if( $(this).parent().attr("id") != 'abc' ){
			location.href="/purchase/getPurchaseFromTranId?tranId="+id;
		}else{
			location.href="/user/getUser?userId=${ list[i].buyer.userId }";
		}
	})
});
</script>

<script type="text/javascript">
function fncGetList(currentPage) {
	document.getElementById("currentPage").value = currentPage;
   	document.detailForm.submit();
}
</script>

</head>

<body bgcolor="#ffffff" text="#000000">

<div style="width: 98%; margin-left: 10px;">

<form name="detailForm" action="/purchase/listPurchase" method="post">
<!-- hidden name : menu, currentPage -->
<input type="hidden" name="menu" value="${ menu }">
<table width="100%" height="37" border="0" cellpadding="0"	cellspacing="0">
	<tr>
		<td width="15" height="37"><img src="/images/ct_ttl_img01.gif"width="15" height="37"></td>
		<td background="/images/ct_ttl_img02.gif" width="100%" style="padding-left: 10px;">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="93%" class="ct_ttl01">${ sessionScope.user.role } / ${ menu }구매 목록조회</td>
				</tr>
			</table>
		</td>
		<td width="12" height="37"><img src="/images/ct_ttl_img03.gif"	width="12" height="37"></td>
	</tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0"	style="margin-top: 10px;">
	<tr>
		<td colspan="11">전체 ${ resultPage.totalCount } 건수, 현재 ${ resultPage.currentPage } 페이지</td>
	</tr>
	<tr>
		<td class="ct_list_b" width="100">No</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">회원ID</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">회원명</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b">전화번호</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b">배송현황</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b">정보수정</td>
	</tr>
	<tr>
		<td colspan="11" bgcolor="808285" height="1"></td>
	</tr>

	<c:if test="${ fn:length(list) != 0 }">
		<c:set var="size" value="${ fn:length(list) }"/>
		
		<c:forEach var="i" begin="0" end="${ size-1 }" step="1">
			<tr class="ct_list_pop" id="${ list[i].tranId }">
				<td align="center">
					<b>${ size-i }</b>
				</td>
				<td></td>
				<td align="left" id="abc">
					<b>${ list[i].buyer.userId }</b>
				</td>
				<td></td>
				<td align="left">${ list[i].receiverName }</td>
				<td></td>
				<td align="left">${ list[i].receiverPhone }</td>
				<td></td>
				<td align="left">
				
				<c:if test="${ fn:trim(list[i].tranCode) == '1' }">
					현재 구매완료 상태 입니다.
				</c:if>
				<c:if test="${ fn:trim(list[i].tranCode) == '2' }">
					현재 배송중 상태 입니다.
				</c:if>
				<c:if test="${ fn:trim(list[i].tranCode) == '3' }">
					현재 배송완료 상태 입니다.
				</c:if>
	
				</td>
				<td></td>
	
				<c:if test="${ fn:trim(list[i].tranCode) == '2' }">
				<td align="left">
					<b id="${ list[i].tranNo }">물건도착</b>
				</td>
				</c:if>
	
			</tr>
		</c:forEach>
	</c:if>
		
	<tr>
		<td colspan="11" bgcolor="D6D7D6" height="1"></td>
	</tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top: 10px;">
	<tr>
		<td align="center">
			<input type="hidden" name="currentPage" id="currentPage" value=""/>
			<jsp:include page="../common/pageNavigator.jsp"/>
		</td>
	</tr>
</table>

<!--  페이지 Navigator 끝 -->
</form>

</div>

</body>
</html>