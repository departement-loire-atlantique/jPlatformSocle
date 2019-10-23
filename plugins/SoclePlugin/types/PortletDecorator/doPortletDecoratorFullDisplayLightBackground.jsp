<%@ include file='/jcore/doInitPage.jspf' %>
<%@ include file='/jcore/portal/doPortletParams.jspf' %>
<% 
	PortletDecorator box = (PortletDecorator) portlet;  
	ServletUtil.backupAttribute(pageContext , "ShowChildPortalElement");
%>

<section class="ds44-container-fluid">
    <jsp:include page="doPortletDecoratorFullDisplayInner.jsp"></jsp:include>
</section>

<% ServletUtil.restoreAttribute(pageContext , "ShowChildPortalElement"); %>
