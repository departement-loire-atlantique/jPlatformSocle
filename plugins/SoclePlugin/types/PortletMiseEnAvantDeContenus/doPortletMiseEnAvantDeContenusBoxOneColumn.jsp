<%@ page contentType="text/html; charset=UTF-8" %><%
%><%@ include file='/jcore/doInitPage.jspf' %><%
%><%@ include file='/jcore/portal/doPortletParams.jspf' %><%
%><% PortletMiseEnAvantDeContenus obj = (PortletMiseEnAvantDeContenus)portlet; %><%
List<Content> allContents = new ArrayList<>();
if (Util.notEmpty(obj.getFirstPublications())) {
    allContents.addAll(Arrays.asList(obj.getFirstPublications()));
}
%>

<%@ include file="/types/PortletQueryForeach/doQuery.jspf" %>
<%@ include file="/types/PortletQueryForeach/doSort.jspf" %>

<%
if (Util.notEmpty(collection)) {
    allContents.addAll(collection);
}
%>

<section id="services1clic_<%= obj.getId() %>">
    <h2 class="h3-like"><%= obj.getTitreVisuel() %></h2>
    <jalios:foreach name="itContent" type="Content" collection="<%= allContents %>">
        <jalios:include pub="<%= (Publication) itContent %>" resource="tuileHorizontaleGrey"/>
    </jalios:foreach>
</section>