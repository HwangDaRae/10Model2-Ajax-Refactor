<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
<link rel="stylesheet" href="/css/admin.css" type="text/css">
<script src="//code.jquery.com/jquery-2.1.4.js" type="text/javascript"></script>
<script type="text/javascript">
$(function(){
	//구매버튼 클릭 => 배송정보 입력 페이지로 이동
	$("input[value='구매']").bind("click",function(){
		var checkbox = $("input[type='checkbox']")
		/*
		checkbox.each(function(index, item){
			if($(checkbox[index]).is(":checked")  == true){
				//체크한 상품번호와 체크한 상품의 수량을 넘긴다
				var amount = $(checkbox[index]).parent().parent().find("#amount").val();
				var elemCreate1 = "<input type='text' name='amount' value='" + amount + "'>";
				$(elemCreate1).appendTo("#result");
				$(item).appendTo("#result");
			}
		})
		*/

		$("form").submit();
	})
	
	//체크한 상품 삭제
	$("input[value='선택 삭제'").bind("click",function(){
		if(confirm('정말 삭제하시겠습니까?')){
			$("form").attr("method","post").attr("action","/cart/deleteCart").submit();
		}
	})
	
	//수량 plus
	$("input[value='+']").bind("click",function(){
		//화면에 보이는 수량
		var countAmount = $(this).parent().children("#result").text();
		//상품재고수량
		var prodAmount = $(this).parent().children("#prodAmount").val();
		
		if(parseInt(countAmount) < parseInt(prodAmount)){
			countAmount = parseInt(countAmount) +1;
		}else if(parseInt(countAmount) == parseInt(prodAmount)){
			$(this).parent().children("#limit").text("더이상 구매하실 수 없습니다");
		}
		
		$(this).parent().parent().children("td").children("#printAmount").text(countAmount);
		var printPrice = $(this).parent().parent().children("td").children("#printPrice").text();
		$(this).parent().parent().children("td").children("#printTotalPrice").text( parseInt(countAmount) * parseInt(printPrice) );
		$(this).parent().children("#result").text(countAmount);
		$(this).parent().children("#amount").val(countAmount);
	})
	
	//수량 minus
	$("input[value='-']").bind("click",function(){
		//화면에 보이는 수량
		var countAmount = $(this).parent().children("#result").text();
		//상품재고수량
		var prodAmount = $(this).parent().children("#prodAmount").val();
		
		if(parseInt(countAmount) == 1){
			countAmount = 1;
		}else if(parseInt(countAmount) > 1){
			countAmount = parseInt(countAmount) -1;
			$(this).parent().children("#limit").text(" ");
		}
		
		$(this).parent().parent().children("td").children("#printAmount").text(countAmount);
		var printPrice = $(this).parent().parent().children("td").children("#printPrice").text();
		$(this).parent().parent().children("td").children("#printTotalPrice").text( parseInt(countAmount) * parseInt(printPrice) );
		$(this).parent().children("#result").text(countAmount);
		$(this).parent().children("#amount").val(countAmount);
	})
	
	//전체선택 체크박스 클릭시 모든 체크박스 선택됨
	$("#allDeleteCheckBox").bind("click",function(){		
		var arrayCheckBox = $("input[name='deleteCheckBox']")
		
		if( $("#allDeleteCheckBox").is(':checked') == true ){
			$("#checkCount").text(arrayCheckBox.length);
			arrayCheckBox.each(function( index, elem ){
				$( arrayCheckBox[index] ).prop("checked",true);
			})			
			
		}else if( $("#allDeleteCheckBox").is(':checked') == false ){
			$("#checkCount").text(0);
			arrayCheckBox.each(function( index, elem ){
				$( arrayCheckBox[index] ).prop("checked",false);
			})
		}
	})
	
	//상품 체크박스 상태가 변경되면 전체상품의 개수 변경
	$("input[name='deleteCheckBox']").bind("change",function(){
		var arrayCheckBox = $("input[name='deleteCheckBox']")
		var checkCount = 0;
		
		arrayCheckBox.each(function(index){
			if($(arrayCheckBox[index]).is(":checked") == true ){
				checkCount++;
			}
		})
		
		if(checkCount == arrayCheckBox.length){
			$("input[name='allDeleteCheckBox']").prop("checked",true);
		}else{
			$("input[name='allDeleteCheckBox']").prop("checked",false);
		}
		$("#checkCount").text(checkCount);
	})
	
})
</script>
</head>
<body bgcolor="#ffffff" text="#000000">
	<div style="width: 98%; margin-left: 10px;">
		<form name="detailForm" action="/cart/deliveryCart" method="post">
			<table width="100%" height="37" border="0" cellpadding="0" cellspacing="0">
				<tr>
					<td width="15" height="37"><img src="/images/ct_ttl_img01.gif" width="15" height="37" /></td>
					<td background="/images/ct_ttl_img02.gif" width="100%" style="padding-left: 10px;">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="93%" class="ct_ttl01">${ sessionScope.user.role } 장바구니</td>
							</tr>
						</table>
					</td>
					<td width="12" height="37"><img src="/images/ct_ttl_img03.gif" width="12" height="37" /></td>
				</tr>
			</table>



			<table id="dataTable" width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top: 10px;">
				<tr>
					<td colspan="11">
						<a href="">
							<input type="checkbox" id="allDeleteCheckBox" name="allDeleteCheckBox">전체선택&nbsp;&nbsp;
							<b id="checkCount">0</b>&nbsp;/&nbsp;${ count }</a>&nbsp;&nbsp;
						<input type="button" value="선택 삭제">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<input type="button" value="구매">
					</td>

				</tr>
				<tr>
					<td class="ct_list_b" width="100">No</td>
					<td class="ct_line02"></td>
					<td class="ct_list_b" width="150">상품이미지</td>
					<td class="ct_line02"></td>
					<td class="ct_list_b" width="150">상품정보</td>
					<td class="ct_line02"></td>
					<td class="ct_list_b">수량</td>
					<td class="ct_line02"></td>
					<td class="ct_list_b">가격</td>
				</tr>
				<tr>
					<td colspan="11" bgcolor="808285" height="1"></td>
				</tr>
					<!-- list시작 회원-->
					<c:set var="size" value="${ fn:length(list) }"/>
					<c:if test="${ count > 0 && user.userId != 'non-member' }">
					<c:forEach var="i" begin="0" end="${ size-1 }" step="1">
					<tr class="ct_list_pop">
						<td align="center">
							<c:if test="${ count > 0 }">
							<input type="checkbox" id="deleteCheckBox" name="deleteCheckBox" value="${ list[i].prod_no }"></td>
							</c:if>
						<td></td>
						<td align="left"><img height="250" width="250" src="/images/uploadFiles/${ uploadList[i] }"/></td>
						<td></td>
						<td align="left">${ list[i].prod_name }</td>
						<td></td>
						<td align="left">
							<input type="button" value="-">
							<b id="result">${ list[i].amount }</b>
							<input type="hidden" id="amount" name="amount" value="${ list[i].amount }">
							<input type="hidden" id="prodAmount" value="${ list[i].prod_amount }">
							<input type="hidden" id="addPurchaseCheckBox" name="addPurchaseCheckBox" value="${ list[i].prod_no }">
							<input type="button" value="+">
							<b id="limit"></b>
						</td>
						<td></td>
						<td align="left">
							<b id="printPrice">${ list[i].price }</b>원 * 
							<b id="printAmount">${ list[i].amount }</b>개 = 
							<b id="printTotalPrice">${ list[i].price * list[i].amount }</b>원
						</td>
					</tr>
					</c:forEach>
					</c:if>					
					
					<c:set var="size" value="${ fn:length(list) }"/>
					<c:if test="${ count > 0 && user.userId == 'non-member' }">
						<c:forEach var="i" begin="0" end="${ size-1 }" step="1">
							<tr class="ct_list_pop">
								<td align="center">
								<c:if test="${ count > 0 }">
								<input type="checkbox" id="deleteCheckBox" name="deleteCheckBox" value="${ list[i].prod_no }"></td>
								</c:if>
								<td></td>
								<td align="left"><img height="250" width="250" src="/images/uploadFiles/${ uploadList[i] }"/></td>
								<td></td>
								<td align="left">${ list[i].prod_name }</td>
								<td></td>
								<td align="left">
									<input type="button" value="-">
									<b id="result">${ list[i].amount }</b>
									<input type="text" id="amount" name="amount" value="${ list[i].amount }">
									<input type="text" id="prodAmount" value="${ list[i].prod_amount }">
									<input type="text" id="addPurchaseCheckBox" name="addPurchaseCheckBox" value="${ list[i].prod_no }">
									<input type="button" value="+">
									<b id="limit"></b>
								</td>
								<td></td>
								<td align="left">
									<b id="printPrice">${ list[i].price }</b>원 * 
									<b id="printAmount">${ amountList[i].amount }</b>개 = 
									<b id="printTotalPrice">${ list[i].price * list[i].amount }</b>원
								</td>
							</tr>
							<tr>
								<td colspan="11" bgcolor="D6D7D6" height="1"></td>
							</tr>
						</c:forEach>
					</c:if>
					
			</table>



			<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top: 10px;">
				<tr>
					<td align="center"></td>
				</tr>
			</table>

		</form>

	</div>
</html>