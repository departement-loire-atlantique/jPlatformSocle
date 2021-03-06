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

// Forcer l'affichage de liens uniquement
for (Iterator<Content> iter = collection.iterator(); iter.hasNext();) {
  Content itContent = iter.next();
  if (!(itContent instanceof Lien)) iter.remove();
}
%>

<section id="plusRecherches_<%= box.getId() %>" class="ds44-container">
    <h2 class="h4-like" id="plusRechercheTitre_<%= box.getId() %>"><%= box.getTitreVisuel(userLang) %></h2>
    <ul class="ds44-list">
	    <jalios:foreach name="itContent" type="Content" collection="<%= allContents %>" max="10">
	        <li><jalios:media data="<%= (Publication) itContent %>" template="plusRecherches"/></li>
	    </jalios:foreach>
    </ul>
</section>