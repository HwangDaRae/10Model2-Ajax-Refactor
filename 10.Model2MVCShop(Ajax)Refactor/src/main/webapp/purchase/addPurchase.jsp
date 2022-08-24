<%@ page contentType="text/html; charset=euc-kr" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<title>Insert title here</title>
</head>

<body>

<form name="updatePurchase" action="/purchase/updatePurchaseView/0" method="post">
<c:forEach var="i" begin="0" end="${ fn:length(prodList) -1 }" step="1">
<table border=1>
	<tr class="ct_list_pop" id="divDataId">
		<td align="center">
			<img height="250" width="250" src="/images/uploadFiles/${ uploadList[i] }"/></td>
		<td></td>
		<td align="left">${ prodList[i].prodName }</td>
		<td></td>
		<td align="left">${ prodList[i].prodDetail }</td>
		<td></td>
		<td align="left">${ prodList[i].price }개</td>
		<td></td>
		<td align="left">${ list[i].amount }개</td>
		<td></td>
		<td align="left">${ prodList[i].price * list[i].amount }원</td>
	</tr>
</table>
</c:forEach>
<table border=1>
	<tr>
		<td>주문번호</td>
		<td>${ list[0].tranId }</td>
		<td></td>
	</tr>
	<tr>
		<td>구매자아이디</td>
		<c:if test="${ list[0].buyer.userId == 'non-member' }">
		<td>비회원</td>
		</c:if>
		<c:if test="${ list[0].buyer.userId != 'non-member' }">
		<td>${ list[0].buyer.userId }</td>
		</c:if>
		<td></td>
	</tr>
	<tr>
		<td>구매방법</td>
		<td>${ (fn:trim(list[0].paymentOption) == '1')?"현금구매":"신용구매" }</td>
		<td></td>
	</tr>
	<tr>
		<td>구매자이름</td>
		<td>${ list[0].receiverName }</td>
		<td></td>
	</tr>
	<tr>
		<td>구매자연락처</td>
		<td>${ list[0].receiverPhone }</td>
		<td></td>
	</tr>
	<tr>
		<td>구매자주소</td>
		<td>${ list[0].divyAddr }</td>
		<td></td>
	</tr>
		<tr>
		<td>구매요청사항</td>
		<td>${ list[0].divyRequest }</td>
		<td></td>
	</tr>
	<tr>
		<td>배송희망일자</td>
		<td>${ list[0].divyDate }</td>
		<td></td>
	</tr>
	<tr>
		<td>총 가격</td>
		<td>${ list[0].totalPrice }원</td>
		<td></td>
	</tr>
</table>
</form>

</body>
</html>