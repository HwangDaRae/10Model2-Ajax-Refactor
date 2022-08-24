<%@ page contentType="text/html; charset=euc-kr" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>
<head>
<link rel="stylesheet" href="/css/admin.css" type="text/css">
<title>구매정보 수정</title>
<script type="text/javascript" src="../javascript/calendar.js"></script>
<script src="//code.jquery.com/jquery-2.1.4.js" type="text/javascript"></script>

<script type="text/javascript">
$(function(){
	$("td.ct_btn01:contains('취소')").bind("click",function(){
		history.go(-1)
	})
	
	$("td.ct_btn01:contains('수정완료')").bind("click",function(){
		$("form").attr("method","post").attr("action","/purchase/updatePurchase").submit();
	})
		
	$("#show_calendar").bind("click",function(){
		show_calendar('document.updatePurchase.divyDate', document.updatePurchase.divyDate.value)
	})
	
	var productAmount = $("#productAmount").val();
	var number = $("#result").text()
	$("input[value='+']").bind("click",function(){
		if( number < productAmount ){
			number++;
		}else if( number == productAmount ){
			$("#limit").text("더이상 구매하실 수 없습니다");
			return;
		}
		$("#amount").val( number );
		$("#result").text( number );
	})
	
	$("input[value='-']").bind("click",function(){
		number--;
		if(number == 0){
			number = 1;
		}else{
			$("#limit").text(" ");
		}
		$("#amount").val( number );
		$("#result").text( number );
	})
});

</script>

</head>

<body bgcolor="#ffffff" text="#000000">

<form name="updatePurchase" method="post" action="/purchase/updatePurchase">
<table width="100%" height="37" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td width="15" height="37">
			<img src="/images/ct_ttl_img01.gif"  width="15" height="37"/>
		</td>
		<td background="/images/ct_ttl_img02.gif" width="100%" style="padding-left: 10px;">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="93%" class="ct_ttl01">구매정보수정</td>
					<td width="20%" align="right">&nbsp;</td>
				</tr>
			</table>
		</td>
		<td width="12" height="37">
			<img src="/images/ct_ttl_img03.gif" width="12" height="37"/>
		</td>
	</tr>
</table>

<table width="600" border="0" cellspacing="0" cellpadding="0"	align="center" style="margin-top: 13px;">
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr>
		<td width="104" class="ct_write">구매자아이디</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">${ purchaseVO.buyer.userId }</td>
		<input type="text" name="buyerId" value="${ purchaseVO.buyer.userId }">
		<input type="text" name="price" value="${ productVO.price }">
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr>
		<td width="104" class="ct_write">구매방법</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">
			<select name="paymentOption" class="ct_input_g" style="width: 100px; height: 19px" maxLength="20">
				<option value="1" ${ (fn:trim(purchaseVO.paymentOption) == '1')?"selected":"" } >현금구매</option>
				<option value="2" ${ (fn:trim(purchaseVO.paymentOption) == '2')?"selected":"" } >신용구매</option>
			</select>
		</td>
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr>
		<td width="104" class="ct_write">구매자이름</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">
			<input type="text" name="receiverName" class="ct_input_g" style="width: 100px; height: 19px" 
				maxLength="20" value="${ purchaseVO.receiverName }" />
		</td>
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr>
		<td width="104" class="ct_write">구매자 연락처</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">
			<input type="text" name="receiverPhone" class="ct_input_g" style="width: 100px; height: 19px" 
							maxLength="20" value="${ purchaseVO.receiverPhone }" />
		</td>
	</tr>

	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr>
		<td width="104" class="ct_write">구매자주소</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">
			<input 	type="text" name="divyAddr" class="ct_input_g" style="width: 100px; height: 19px" 
							maxLength="20" value="${ purchaseVO.divyAddr }" />
		</td>
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr>
		<td width="104" class="ct_write">구매요청사항</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">
			<input 	type="text" name="divyRequest" 	class="ct_input_g" style="width: 100px; height: 19px" 
							maxLength="20" value="${ purchaseVO.divyRequest }" />
		</td>
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr>
		<td width="104" class="ct_write">배송희망일자</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td width="200" class="ct_write01">
			<input type="text" name="divyDate" class="ct_input_g"
				style="width: 100px; height: 19px" maxLength="20"/>
				<img src="../images/ct_icon_date.gif" width="15" height="15" id="show_calendar" />
		</td>
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr>
		<td width="104" class="ct_write">구매수량</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">
			<input type="button" value="-">
			<b id="result">${ purchaseVO.amount }</b>
			<input type="text" id="amount" name="amount" value="${ purchaseVO.amount }">
			<input type="text" id="productAmount" name="productAmount" value="${ productVO.amount }">
			<input type="text" name="tranNo" value="${ purchaseVO.tranNo }">
			<input type="button" value="+">
			<b id="limit"></b>
		</td>
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top: 10px;">
	<tr>
		<td width="53%"></td>
		<td align="right">
		<table border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td width="17" height="23">
					<img src="/images/ct_btnbg01.gif" width="17" height="23"/>
				</td>
				<td background="/images/ct_btnbg02.gif" class="ct_btn01" style="padding-top: 3px;">
					수정완료
				</td>
				<td width="14" height="23">
					<img src="/images/ct_btnbg03.gif" width="14" height="23"/>
				</td>
				<td width="30"></td>
				<td width="17" height="23">
					<img src="/images/ct_btnbg01.gif" width="17" height="23"/>
				</td>
				<td background="/images/ct_btnbg02.gif" class="ct_btn01" style="padding-top: 3px;">
					취소
				</td>
				<td width="14" height="23">
					<img src="/images/ct_btnbg03.gif" width="14" height="23"/>
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
</form>

</body>
</html>