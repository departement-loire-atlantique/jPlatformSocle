<%@ page contentType="text/html; charset=UTF-8" %><%
%><%@ include file='/jcore/doInitPage.jspf' %><%
%><%@ include file='/jcore/media/mediaTemplateInit.jspf' %><%
%><%
CarouselElement obj = (CarouselElement)request.getAttribute(PortalManager.PORTAL_PUBLICATION); %><%
%>

<%@include file="doCarouselElement.jspf" %>
<section class="ds44-card ds44-card--horizontal">

    <jalios:if predicate="<%=Util.notEmpty(urlCard)%>">
        <a href="<%= urlCard %>" class="ds44-card__globalLink ds44-flex-container ds44-flex-valign-center" title="<%= title.toString() %>" <%=target%>>
    </jalios:if>
    <jalios:if predicate='<%=Util.notEmpty(obj.getDataImage()) %>'>
        <picture class="ds44-cardPicture--hcardPicture">
            <jalios:thumbnail path="<%=obj.getDataImage() %>" width="140" height="140" css="ds44-card__img" square="true" format="jpeg" alt="<%= altValue.toString() %>"></jalios:thumbnail>
        </picture>
    </jalios:if>       
    <div class="ds44-card__section--horizontal">
        <p role="heading" aria-level="2" class="ds44-card__title"><%=obj.getTitle()%></p>
        <jalios:if predicate="<%=obj.getInternalLink() instanceof FileDocument %>">
            <% FileDocument fd = (FileDocument) obj.getInternalLink();%>
            <p class="ds44-cardFile"><%=fd.getGenericContentType().toUpperCase()%> - <%= Util.formatFileSize(fd.getSize(), userLocale) %></p>
        </jalios:if>
    </div>            
    <jalios:if predicate="<%=Util.notEmpty(urlCard)%>">
        </a>
    </jalios:if>

</section>