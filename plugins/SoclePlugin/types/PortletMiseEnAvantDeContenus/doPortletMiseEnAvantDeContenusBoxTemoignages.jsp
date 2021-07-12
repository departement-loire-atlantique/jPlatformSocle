<%@ page contentType="text/html; charset=UTF-8" %><%
%><%@ include file='/jcore/doInitPage.jspf' %><%
%><%@ include file='/jcore/portal/doPortletParams.jspf' %><%
%><% PortletMiseEnAvantDeContenus box = (PortletMiseEnAvantDeContenus)portlet; %>

<section>
    <h2 class="h4-like ds44-box-heading"><%= Util.notEmpty(box.getTitreVisuel()) ? box.getTitreVisuel(userLang) : channel.getProperty("jcmsplugin.socle.titre.temoignages") %></h2>
    
    <%@ include file="/types/PortletQueryForeach/doQuery.jspf" %>
    <%@ include file="/types/PortletQueryForeach/doSort.jspf" %>

    <%@ include file="/types/PortletQueryForeach/doForeachHeader.jspf" %>

    <jalios:media data='<%=itPub %>' template='temoignage' />

    <%@ include file="/types/PortletQueryForeach/doForeachFooter.jspf" %>
    <%@ include file="/types/PortletQueryForeach/doPager.jspf" %>

</section>