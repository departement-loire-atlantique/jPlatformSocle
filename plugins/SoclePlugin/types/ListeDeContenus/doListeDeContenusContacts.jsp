<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file='/jcore/doInitPage.jspf' %>
<% ListeDeContenus obj = (ListeDeContenus)request.getAttribute(PortalManager.PORTAL_PUBLICATION); %>
<jalios:if predicate="<%=Util.notEmpty(obj.getContenus())%>">
    <jalios:foreach name="itData" type="com.jalios.jcms.Content" array="<%= obj.getContenus() %>">
        <jalios:if predicate="<%=itData != null && itData instanceof FicheLieu && itData.canBeReadBy(loggedMember)%>">
            <% 
            FicheLieu itDoc = (FicheLieu)itData;
            %>
            <jalios:include pub="<%= itDoc %>" usage="embed"/>
            
        </jalios:if>
    </jalios:foreach>
</jalios:if>