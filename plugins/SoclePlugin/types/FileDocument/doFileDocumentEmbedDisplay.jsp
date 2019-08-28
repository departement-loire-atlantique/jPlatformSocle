<%@ page contentType="text/html; charset=UTF-8" %><%
%><%@ include file='/jcore/doInitPage.jspf' %><%
%><% 
FileDocument obj = (FileDocument)request.getAttribute(PortalManager.PORTAL_PUBLICATION); %><%
%>

<jalios:link data="<%=obj %>">
<jalios:card>
    <jalios:cardBlock>
        <jalios:icon src="<%=obj.getDataIcon()%>"/> <%=obj.getTitle()%> - <%=obj.getGenericContentType()%> - <%= Util.formatFileSize(obj.getSize(), userLocale) %>
        (<jalios:date date="<%=obj.getMdate() %>" format="dd/MM/yyyy"/>)
    </jalios:cardBlock>
</jalios:card>
</jalios:link>
