<%@ page contentType="text/html; charset=UTF-8" %><%
%><%-- This file has been automatically generated. --%><%
%><%--
  @Summary: CarouselElement display page
  @Category: Generated
  @Author: JCMS Type Processor
  @Customizable: True
  @Requestable: True
--%><%
%><%@ include file='/jcore/doInitPage.jspf' %><%
%><% CarouselElement obj = (CarouselElement)request.getAttribute(PortalManager.PORTAL_PUBLICATION); %><%
%><%@ include file='/front/doFullDisplay.jspf' %>
<div class="fullDisplay CarouselElement <%= obj.canBeEditedFieldByField(loggedMember) ? "unitFieldEdition" : "" %>" itemscope="itemscope">
<%@ include file='/front/publication/doPublicationHeader.jspf' %>
<table class="fields">
  <tr class="field summary textareaEditor  <%= Util.isEmpty(obj.getSummary(userLang)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(CarouselElement.class, "summary", userLang) %><jalios:edit pub='<%= obj %>' fields='summary'/></td>
    <td class='field-data' <%= gfla(obj, "summary") %>>
            <% if (Util.notEmpty(obj.getSummary(userLang))) { %>
            <%= obj.getSummary(userLang) %>
            <% } %>
    </td>
  </tr>
  <tr class="field image imageEditor  <%= Util.isEmpty(obj.getImage()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(CarouselElement.class, "image", userLang) %><jalios:edit pub='<%= obj %>' fields='image'/></td>
    <td class='field-data' <%= gfla(obj, "image") %>>
            <% if (Util.notEmpty(obj.getImage())) { %>
            <img src='<%= Util.encodeUrl(obj.getImage()) %>' alt='' />
            <% } %>
    </td>
  </tr>
  <tr class="field imageLegend textfieldEditor  <%= Util.isEmpty(obj.getImageLegend(userLang)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(CarouselElement.class, "imageLegend", userLang) %><jalios:edit pub='<%= obj %>' fields='imageLegend'/></td>
    <td class='field-data' <%= gfla(obj, "imageLegend") %>>
            <% if (Util.notEmpty(obj.getImageLegend(userLang))) { %>
            <%= obj.getImageLegend(userLang) %>
            <% } %>
    </td>
  </tr>
  <tr class="field imageCopyright textfieldEditor  <%= Util.isEmpty(obj.getImageCopyright(userLang)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(CarouselElement.class, "imageCopyright", userLang) %><jalios:edit pub='<%= obj %>' fields='imageCopyright'/></td>
    <td class='field-data' <%= gfla(obj, "imageCopyright") %>>
            <% if (Util.notEmpty(obj.getImageCopyright(userLang))) { %>
            <%= obj.getImageCopyright(userLang) %>
            <% } %>
    </td>
  </tr>
  <tr class="field linkTitle textfieldEditor  <%= Util.isEmpty(obj.getLinkTitle(userLang)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(CarouselElement.class, "linkTitle", userLang) %><jalios:edit pub='<%= obj %>' fields='linkTitle'/></td>
    <td class='field-data' <%= gfla(obj, "linkTitle") %>>
            <% if (Util.notEmpty(obj.getLinkTitle(userLang))) { %>
            <%= obj.getLinkTitle(userLang) %>
            <% } %>
    </td>
  </tr>
  <tr class="field internalLink linkEditor  <%= Util.isEmpty(obj.getInternalLink()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(CarouselElement.class, "internalLink", userLang) %><jalios:edit pub='<%= obj %>' fields='internalLink'/></td>
    <td class='field-data' >
            <% if (obj.getInternalLink() != null && obj.getInternalLink().canBeReadBy(loggedMember)) { %>
            <jalios:link data='<%= obj.getInternalLink() %>'/>
            <% } %>
    </td>
  </tr>
  <tr class="field externalLink urlEditor  <%= Util.isEmpty(obj.getExternalLink()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(CarouselElement.class, "externalLink", userLang) %><jalios:edit pub='<%= obj %>' fields='externalLink'/></td>
    <td class='field-data' <%= gfla(obj, "externalLink") %>>
            <% if (Util.notEmpty(obj.getExternalLink())) { %>
            <a href='<%= obj.getExternalLink() %>' ><%= obj.getExternalLink()%></a>
            <% } %>
    </td>
  </tr>
  <tr class="field newTab booleanEditor  ">
    <td class='field-label'><%= channel.getTypeFieldLabel(CarouselElement.class, "newTab", userLang) %><jalios:edit pub='<%= obj %>' fields='newTab'/></td>
    <td class='field-data' >
            <%= obj.getNewTabLabel(userLang) %>
    </td>
  </tr>
  <tr class="field miseEnAvant categoryEditor  <%= Util.isEmpty(obj.getMiseEnAvant(loggedMember)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(CarouselElement.class, "miseEnAvant", userLang) %><jalios:edit pub='<%= obj %>' fields='miseEnAvant'/></td>
    <td class='field-data' >
            <% if (Util.notEmpty(obj.getMiseEnAvant(loggedMember))) { %>
            <ol>
            <jalios:foreach collection="<%= obj.getMiseEnAvant(loggedMember) %>" type="Category" name="itCategory" >
              <li><% if (itCategory != null) { %><a href="<%= ResourceHelper.getQuery() %>?cids=<%= itCategory.getId() %>"><%= itCategory.getAncestorString(channel.getCategory("c_1088868"), " > ", true, userLang) %></a><% } %></li>
            </jalios:foreach>
            </ol>
            <% } %>
    </td>
  </tr>
 
</table>
<jsp:include page="/front/doFullDisplayCommonFields.jsp" />
</div><%-- **********4A616C696F73204A434D53 *** SIGNATURE BOUNDARY * DO NOT EDIT ANYTHING BELOW THIS LINE *** --%><%
%><%-- Ae19r2PPFa3bx8w560/D3w== --%>