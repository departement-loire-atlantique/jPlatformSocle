<%@ page contentType="text/html; charset=UTF-8" %><%<%
%><%@ include file='/jcore/doInitPage.jspf' %><%
%><% Dossier obj = (Dossier)request.getAttribute(PortalManager.PORTAL_PUBLICATION); %><%
%><%@ include file='/front/doFullDisplay.jspf' %>
<div class="fullDisplay Dossier <%= obj.canBeEditedFieldByField(loggedMember) ? "unitFieldEdition" : "" %>" itemscope="itemscope">
<%@ include file='/front/publication/doPublicationHeader.jspf' %>

<%= obj.getTitle() %>

<jsp:include page="/front/doFullDisplayCommonFields.jsp" />
</div><%-- **********4A616C696F73204A434D53 *** SIGNATURE BOUNDARY * DO NOT EDIT ANYTHING BELOW THIS LINE *** --%><%
%><%-- M4iU/A4IeJ8bK2epVE/X7w== --%>