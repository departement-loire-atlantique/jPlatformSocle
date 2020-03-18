<%@ page contentType="text/html; charset=UTF-8" %><%
%><%@ include file='/jcore/doInitPage.jspf' %><%
%><%@ include file='/jcore/portal/doPortletParams.jspf' %><%
%><% PortletMiseEnAvantDeContenus box = (PortletMiseEnAvantDeContenus)portlet; %><%
List<Content> allContents = new ArrayList<>();
if (Util.notEmpty(box.getFirstPublications())) {
    allContents.addAll(Arrays.asList(box.getFirstPublications()));
}
%>

<%@ include file="/types/PortletQueryForeach/doQuery.jspf" %>
<%@ include file="/types/PortletQueryForeach/doSort.jspf" %>

<%
if (Util.notEmpty(collection)) {
    allContents.addAll(collection);
}
%>

<section id="services1clic_<%= box.getId() %>">
    <h2 class="h3-like"><%= box.getTitreVisuel() %></h2>
    <jalios:foreach name="itContent" type="Content" collection="<%= allContents %>">
        <jalios:media data="<%= (Publication) itContent %>" template="tuileHorizontaleGrey"/>
    </jalios:foreach>
</section>