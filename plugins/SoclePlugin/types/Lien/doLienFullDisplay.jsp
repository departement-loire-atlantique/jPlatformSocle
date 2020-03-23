<%@ page contentType="text/html; charset=UTF-8" %><%
%><%-- This file has been automatically generated. --%><%
%><%--
  @Summary: Lien display page
  @Category: Generated
  @Author: JCMS Type Processor
  @Customizable: True
  @Requestable: True
--%><%
%><%@ include file='/jcore/doInitPage.jspf' %><%
%><% Lien obj = (Lien)request.getAttribute(PortalManager.PORTAL_PUBLICATION); %><%
%><%@ include file='/front/doFullDisplay.jspf' %>
<div class="fullDisplay Lien <%= obj.canBeEditedFieldByField(loggedMember) ? "unitFieldEdition" : "" %>" itemscope="itemscope">
<%@ include file='/front/publication/doPublicationHeader.jspf' %>
<table class="fields">
  <tr class="field soustitre textfieldEditor  <%= Util.isEmpty(obj.getSoustitre()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(Lien.class, "soustitre", userLang) %><jalios:edit pub='<%= obj %>' fields='soustitre'/></td>
    <td class='field-data' <%= gfla(obj, "soustitre") %>>
            <% if (Util.notEmpty(obj.getSoustitre())) { %>
            <%= obj.getSoustitre() %>
            <% } %>
    </td>
  </tr>
  <tr class="field imagePrincipale imageEditor  <%= Util.isEmpty(obj.getImagePrincipale(userLang)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(Lien.class, "imagePrincipale", userLang) %><jalios:edit pub='<%= obj %>' fields='imagePrincipale'/></td>
    <td class='field-data' <%= gfla(obj, "imagePrincipale") %>>
            <% if (Util.notEmpty(obj.getImagePrincipale(userLang))) { %>
            <img src='<%= Util.encodeUrl(obj.getImagePrincipale(userLang)) %>' alt='' />
            <% } %>
    </td>
  </tr>
  <tr class="field imageCarree imageEditor  <%= Util.isEmpty(obj.getImageCarree()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(Lien.class, "imageCarree", userLang) %><jalios:edit pub='<%= obj %>' fields='imageCarree'/></td>
    <td class='field-data' <%= gfla(obj, "imageCarree") %>>
            <% if (Util.notEmpty(obj.getImageCarree())) { %>
            <img src='<%= Util.encodeUrl(obj.getImageCarree()) %>' alt='' />
            <% } %>
    </td>
  </tr>
  <tr class="field picto textfieldEditor  <%= Util.isEmpty(obj.getPicto()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(Lien.class, "picto", userLang) %><jalios:edit pub='<%= obj %>' fields='picto'/></td>
    <td class='field-data' <%= gfla(obj, "picto") %>>
            <% if (Util.notEmpty(obj.getPicto())) { %>
            <%= obj.getPicto() %>
            <% } %>
    </td>
  </tr>
  <tr class="field lienSurContenu linkEditor  <%= Util.isEmpty(obj.getLienSurContenu()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(Lien.class, "lienSurContenu", userLang) %><jalios:edit pub='<%= obj %>' fields='lienSurContenu'/></td>
    <td class='field-data' >
            <% if (obj.getLienSurContenu() != null && obj.getLienSurContenu().canBeReadBy(loggedMember)) { %>
            <jalios:link data='<%= obj.getLienSurContenu() %>'/>
            <% } %>
    </td>
  </tr>
  <tr class="field lienExterne urlEditor  <%= Util.isEmpty(obj.getLienExterne()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(Lien.class, "lienExterne", userLang) %><jalios:edit pub='<%= obj %>' fields='lienExterne'/></td>
    <td class='field-data' <%= gfla(obj, "lienExterne") %>>
            <% if (Util.notEmpty(obj.getLienExterne())) { %>
            <a href='<%= obj.getLienExterne() %>' ><%= obj.getLienExterne()%></a>
            <% } %>
    </td>
  </tr>
  <tr class="field categorieDeNavigation categoryEditor  <%= Util.isEmpty(obj.getCategorieDeNavigation(loggedMember)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(Lien.class, "categorieDeNavigation", userLang) %><jalios:edit pub='<%= obj %>' fields='categorieDeNavigation'/></td>
    <td class='field-data' >
            <% if (Util.notEmpty(obj.getCategorieDeNavigation(loggedMember))) { %>
            <ol>
            <jalios:foreach collection="<%= obj.getCategorieDeNavigation(loggedMember) %>" type="Category" name="itCategory" >
              <li><% if (itCategory != null) { %><a href="<%= ResourceHelper.getQuery() %>?cids=<%= itCategory.getId() %>"><%= itCategory.getAncestorString(channel.getCategory("$jcmsplugin.socle.category.categorieDeNavigation.root"), " > ", true, userLang) %></a><% } %></li>
            </jalios:foreach>
            </ol>
            <% } %>
    </td>
  </tr>
  <tr class="field miseEnAvant categoryEditor  <%= Util.isEmpty(obj.getMiseEnAvant(loggedMember)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(Lien.class, "miseEnAvant", userLang) %><jalios:edit pub='<%= obj %>' fields='miseEnAvant'/></td>
    <td class='field-data' >
            <% if (Util.notEmpty(obj.getMiseEnAvant(loggedMember))) { %>
            <ol>
            <jalios:foreach collection="<%= obj.getMiseEnAvant(loggedMember) %>" type="Category" name="itCategory" >
              <li><% if (itCategory != null) { %><a href="<%= ResourceHelper.getQuery() %>?cids=<%= itCategory.getId() %>"><%= itCategory.getAncestorString(channel.getCategory("$jcmsplugin.socle.miseEnAvant.root"), " > ", true, userLang) %></a><% } %></li>
            </jalios:foreach>
            </ol>
            <% } %>
    </td>
  </tr>
 
</table>
<jsp:include page="/front/doFullDisplayCommonFields.jsp" />
</div><%-- **********4A616C696F73204A434D53 *** SIGNATURE BOUNDARY * DO NOT EDIT ANYTHING BELOW THIS LINE *** --%><%
%><%-- YAcpVM0WySveYNFUd3Dduw== --%>