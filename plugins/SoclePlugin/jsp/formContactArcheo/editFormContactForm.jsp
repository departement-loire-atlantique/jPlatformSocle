<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file='/jcore/doInitPage.jspf' %>

<jalios:if predicate='<%= channel.isDataWriteEnabled() %>'>
    <jsp:include page="doEditContactForm.jsp" />
</jalios:if>