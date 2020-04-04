<%@ page contentType="text/html; charset=UTF-8" %>
<%@page import="fr.cg44.plugin.socle.SocleUtils"%>
<%@ include file='/jcore/doInitPage.jspf' %><%
%><%@ page import="com.jalios.jcms.taglib.card.*" %><%
%><%@ include file='/jcore/media/mediaTemplateInit.jspf' %><%

if (data == null) {
  return;
}

Lien pub = (Lien) data;
%>

<jalios:select>
    <jalios:if predicate="<%= Util.notEmpty( pub.getLienExterne() ) %>">
        <a class="ds44-arrowLink" href="<%= pub.getLienExterne() %>" target="_blank" title='<%= glp("jcmsplugin.socle.site.nouvelonglet", pub.getTitle()) %>'><%= pub.getTitle() %><i class="icon icon-arrow-right"></i></a>
    </jalios:if>
    <jalios:default>
        <%
        String urlContent = pub.getDisplayUrl(userLocale);
        if (Util.notEmpty(pub.getLienInterne())) {
          url = pub.getLienInterne().getDisplayUrl(userLocale);
        }
        %>
        <a class="ds44-arrowLink" href="<%= urlContent %>"><%= pub.getTitle() %><i class="icon icon-arrow-right"></i></a>
    </jalios:default>
</jalios:select>