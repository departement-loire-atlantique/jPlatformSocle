<%@ include file='/jcore/doInitPage.jspf' %>
<%@ include file='/jcore/portal/doPortletParams.jspf' %>
<% 
	PortletDecorator box = (PortletDecorator) portlet;  
	ServletUtil.backupAttribute(pageContext , "ShowChildPortalElement");

	// SGU : on indique à la request que l'on est dans un contexte sombre. Ca sert aux portlets enfants (pour les tuiles).
    ServletUtil.backupAttribute(pageContext , "background-style");
    request.setAttribute("background-style","dark");
%>

<section class="ds44-container-fluid ds44-alternate-container ds44-wave-white">
    <jsp:include page="doPortletDecoratorFullDisplayInner.jsp"></jsp:include>	
</section>

<% ServletUtil.restoreAttribute(pageContext , "ShowChildPortalElement"); %>
<% ServletUtil.restoreAttribute(pageContext , "background-style"); %>