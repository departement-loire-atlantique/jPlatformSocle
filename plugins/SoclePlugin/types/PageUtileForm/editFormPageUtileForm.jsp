<%@ page contentType="text/html; charset=UTF-8" %><%
%><%@ include file='/jcore/doInitPage.jspf' %>

<jalios:if predicate='<%= channel.isDataWriteEnabled() && ! channel.getBooleanProperty("jcmsplugin.socle.page-utile.disabled", true) && Util.isEmpty(request.getAttribute("isSearchFacetPanel")) %>'>
        <jsp:include page="doEditPageUtileForm.jsp" />
</jalios:if>

