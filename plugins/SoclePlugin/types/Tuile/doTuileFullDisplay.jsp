<%@ page contentType="text/html; charset=UTF-8" %><%<%
%><%@ include file='/jcore/doInitPage.jspf' %><%
%><% Tuile obj = (Tuile)request.getAttribute(PortalManager.PORTAL_PUBLICATION); %><%
%><%@ include file='/front/doFullDisplay.jspf' %>
<div class="fullDisplay Tuile <%= obj.canBeEditedFieldByField(loggedMember) ? "unitFieldEdition" : "" %>" itemscope="itemscope">
<%@ include file='/front/publication/doPublicationHeader.jspf' %>


<jsp:include page="/front/doFullDisplayCommonFields.jsp" />
</div>