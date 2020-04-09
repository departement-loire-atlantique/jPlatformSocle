<%@ page contentType="text/html; charset=UTF-8" %><%
%><%@ include file='/jcore/doInitPage.jspf' %><%
%><%@ include file='/jcore/portal/doPortletParams.jspf' %><%
%><% PortletMiseEnAvantDeContenus box = (PortletMiseEnAvantDeContenus)portlet; %>

<section>
    <p role="heading" aria-level="2" class="ds44-box-heading"><%= Util.notEmpty(box.getTitreVisuel()) ? box.getTitreVisuel() : channel.getProperty("jcmsplugin.socle.titre.temoignage") %></p>
    
    <%@ include file="/types/PortletQueryForeach/doQuery.jspf" %>
    <%@ include file="/types/PortletQueryForeach/doSort.jspf" %>

    <%@ include file="/types/PortletQueryForeach/doForeachHeader.jspf" %>

    <jalios:media data='<%=itPub %>' template='temoignage' />

    <%@ include file="/types/PortletQueryForeach/doForeachFooter.jspf" %>
    <%@ include file="/types/PortletQueryForeach/doPager.jspf" %>

</section>