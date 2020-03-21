<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file='/jcore/doInitPage.jspf' %>
<%
ListeDeContenus obj = (ListeDeContenus)request.getAttribute(PortalManager.PORTAL_PUBLICATION); 
%>

<jalios:if predicate="<%=Util.notEmpty(obj.getContenus())%>">
    <jalios:if predicate="<%=Util.notEmpty(obj.getLibelleTitre(userLang))%>">
        <h2 class="h3-like"><%=obj.getLibelleTitre(userLang)%></h2>
	</jalios:if>
	<jalios:foreach name="itData" type="com.jalios.jcms.Content" array="<%= obj.getContenus() %>">
        <jalios:media data='<%=itData %>' template='tuileHorizontaleGrey' />
    </jalios:foreach>
</jalios:if>