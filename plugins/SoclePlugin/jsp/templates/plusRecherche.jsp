<%@ page contentType="text/html; charset=UTF-8" %>
<%@page import="fr.cg44.plugin.socle.SocleUtils"%>
<%@ include file='/jcore/doInitPage.jspf' %><%
%><%@ page import="com.jalios.jcms.taglib.card.*" %><%
%><%@ include file='/jcore/media/mediaTemplateInit.jspf' %><%

if (data == null) {
  return;
}

Publication pub = (Publication) data;
%>

<jalios:select>
    <jalios:if predicate="<%= (pub instanceof Lien) && Util.notEmpty( ((Lien)pub).getLienExterne() ) %>">
        <a class="ds44-arrowLink" href="<%= ((Lien)pub).getLienExterne() %>" target="_blank" aria-label='<%= glp("jcmsplugin.socle.nouvelonglet", ((Lien)pub).getLienExterne()) %>'><%= pub.getTitle() %><i class="icon icon-arrow-right"></i></a>
    </jalios:if>
    <jalios:default>
        <%
        String urlContent = pub.getDisplayUrl(userLocale);
        if ((pub instanceof Lien) && Util.notEmpty(((Lien)pub).getLienInterne())) {
          url = ((Lien)pub).getLienInterne().getDisplayUrl(userLocale);
        }
        %>
        <a class="ds44-arrowLink" href="<%= urlContent %>"><%= pub.getTitle() %><i class="icon icon-arrow-right"></i></a>
    </jalios:default>
</jalios:select>