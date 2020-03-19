<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file='/jcore/doInitPage.jspf' %>
<%
ListeDeContenus obj = (ListeDeContenus)request.getAttribute(PortalManager.PORTAL_PUBLICATION); 
String styleFond="";

if (Util.notEmpty(obj.getStyleDeFond()) && !obj.getStyleDeFond().equals("none")) {
	styleFond = obj.getStyleDeFond();
}
%>

<jalios:if predicate="<%=Util.notEmpty(obj.getContenus())%>">
    <p class="h4-like">Témoignages</p>
    <jalios:foreach name="itData" type="com.jalios.jcms.Content" array="<%= obj.getContenus() %>">
        <jalios:media data='<%=itData %>' template='temoignage' />
    </jalios:foreach>
</jalios:if>