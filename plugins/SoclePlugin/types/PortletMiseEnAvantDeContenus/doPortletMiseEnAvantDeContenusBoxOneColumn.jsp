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
    <p role="heading" aria-level="2" class="ds44-box-heading"><%= box.getTitreVisuel(userLang) %></p>
    <jalios:foreach name="itContent" type="Content" collection="<%= allContents %>" max="<%= box.getMaxResults() %>">
        <jalios:media data="<%= (Publication) itContent %>" template="tuileHorizontaleDark"/>
    </jalios:foreach>
</section>