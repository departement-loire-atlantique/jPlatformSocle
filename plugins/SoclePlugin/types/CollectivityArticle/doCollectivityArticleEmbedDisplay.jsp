<%@ page contentType="text/html; charset=UTF-8" %><%
%><%@ include file='/jcore/doInitPage.jspf' %><%
%><%
CollectivityArticle obj = (CollectivityArticle)request.getAttribute(PortalManager.PORTAL_PUBLICATION); %><%
%>
<jalios:link data="<%=obj %>">
<jalios:card css="card-small">
    <jalios:if predicate='<%=Util.notEmpty(obj.getMainIllustration()) %>'>
        <jalios:cardImage src="<%=obj.getMainIllustration() %>" thumbnailWidth="300" />  
    </jalios:if>
    <jalios:cardBlock>
        <%=obj.getTitle()%>
    </jalios:cardBlock>
</jalios:card>
</jalios:link>
