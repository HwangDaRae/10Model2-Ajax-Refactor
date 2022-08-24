<%@ page contentType="text/html; charset=euc-kr"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:if test="${ resultPage.beginUnitPage != 1 }">
	<b id="navigator_start">처음으로</b>
</c:if>
<c:if test="${ resultPage.beginUnitPage != 1 }">
	<b id="navigator_before">이전&nbsp;</b>
</c:if>
<c:forEach var="i" begin="0" end="${ resultPage.pageUnit-1 }" step="1">
	<c:if test="${ resultPage.beginUnitPage+i <= resultPage.endUnitPage }">
		<a href="javascript:fncGetList('${ resultPage.beginUnitPage+i }')">${ resultPage.beginUnitPage+i }</a>
	</c:if>
</c:forEach>
<c:if test="${ resultPage.endUnitPage != resultPage.maxPage }">
	<b id="navigator_after">&nbsp;다음</b>
</c:if>
<c:if test="${ resultPage.endUnitPage != resultPage.maxPage }">
	<b id="navigator_end">끝으로</b>
	<%-- <a href="javascript:fncGetList('${ resultPage.maxPage }')">끝으로</a> --%>
</c:if>
