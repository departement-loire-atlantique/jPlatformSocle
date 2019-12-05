<%@ page contentType="text/html; charset=UTF-8" %><%
%><%@ include file='/jcore/doInitPage.jspf' %><%
%><% FicheActu obj = (FicheActu)request.getAttribute(PortalManager.PORTAL_PUBLICATION); %><%
%><%@ include file='/front/doFullDisplay.jspf' %>
<div class="fullDisplay FicheActu <%= obj.canBeEditedFieldByField(loggedMember) ? "unitFieldEdition" : "" %>" itemscope="itemscope">
<%@ include file='/front/publication/doPublicationHeader.jspf' %>
<table class="fields">
  <tr class="field dateActu dateEditor  <%= Util.isEmpty(obj.getDateActu()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheActu.class, "dateActu", userLang) %><jalios:edit pub='<%= obj %>' fields='dateActu'/></td>
    <td class='field-data' >
            <%  if (obj.getDateActu() != null) { %>
            <jalios:date date='<%= obj.getDateActu() %>' format='<%= "short" %>'/>
            <jalios:time date='<%= obj.getDateActu() %>' format='<%= "short" %>'/>
            <% } %>
    </td>
  </tr>
  <tr class="field imagePrincipale imageEditor  <%= Util.isEmpty(obj.getImagePrincipale(userLang)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheActu.class, "imagePrincipale", userLang) %><jalios:edit pub='<%= obj %>' fields='imagePrincipale'/></td>
    <td class='field-data' <%= gfla(obj, "imagePrincipale") %>>
            <% if (Util.notEmpty(obj.getImagePrincipale(userLang))) { %>
            <img src='<%= Util.encodeUrl(obj.getImagePrincipale(userLang)) %>' alt='' />
            <% } %>
    </td>
  </tr>
  <tr class="field imageMobile imageEditor  <%= Util.isEmpty(obj.getImageMobile(userLang)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheActu.class, "imageMobile", userLang) %><jalios:edit pub='<%= obj %>' fields='imageMobile'/></td>
    <td class='field-data' <%= gfla(obj, "imageMobile") %>>
            <% if (Util.notEmpty(obj.getImageMobile(userLang))) { %>
            <img src='<%= Util.encodeUrl(obj.getImageMobile(userLang)) %>' alt='' />
            <% } %>
    </td>
  </tr>
  <tr class="field copyright textfieldEditor  <%= Util.isEmpty(obj.getCopyright(userLang)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheActu.class, "copyright", userLang) %><jalios:edit pub='<%= obj %>' fields='copyright'/></td>
    <td class='field-data' <%= gfla(obj, "copyright") %>>
            <% if (Util.notEmpty(obj.getCopyright(userLang))) { %>
            <%= obj.getCopyright(userLang) %>
            <% } %>
    </td>
  </tr>
  <tr class="field legende textfieldEditor  <%= Util.isEmpty(obj.getLegende(userLang)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheActu.class, "legende", userLang) %><jalios:edit pub='<%= obj %>' fields='legende'/></td>
    <td class='field-data' <%= gfla(obj, "legende") %>>
            <% if (Util.notEmpty(obj.getLegende(userLang))) { %>
            <%= obj.getLegende(userLang) %>
            <% } %>
    </td>
  </tr>
  <tr class="field texteAlternatif textfieldEditor  <%= Util.isEmpty(obj.getTexteAlternatif(userLang)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheActu.class, "texteAlternatif", userLang) %><jalios:edit pub='<%= obj %>' fields='texteAlternatif'/></td>
    <td class='field-data' <%= gfla(obj, "texteAlternatif") %>>
            <% if (Util.notEmpty(obj.getTexteAlternatif(userLang))) { %>
            <%= obj.getTexteAlternatif(userLang) %>
            <% } %>
    </td>
  </tr>
  <tr class="field videoPrincipale linkEditor  <%= Util.isEmpty(obj.getVideoPrincipale()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheActu.class, "videoPrincipale", userLang) %><jalios:edit pub='<%= obj %>' fields='videoPrincipale'/></td>
    <td class='field-data' >
            <% if (obj.getVideoPrincipale() != null && obj.getVideoPrincipale().canBeReadBy(loggedMember)) { %>
            <jalios:link data='<%= obj.getVideoPrincipale() %>'/>
            <% } %>
    </td>
  </tr>
  <tr class="field surLeMemeTheme booleanEditor  ">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheActu.class, "surLeMemeTheme", userLang) %><jalios:edit pub='<%= obj %>' fields='surLeMemeTheme'/></td>
    <td class='field-data' >
            <%= obj.getSurLeMemeThemeLabel(userLang) %>
    </td>
  </tr>
  <tr class="field categorieDeNavigation categoryEditor  <%= Util.isEmpty(obj.getCategorieDeNavigation(loggedMember)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheActu.class, "categorieDeNavigation", userLang) %><jalios:edit pub='<%= obj %>' fields='categorieDeNavigation'/></td>
    <td class='field-data' >
            <% if (Util.notEmpty(obj.getCategorieDeNavigation(loggedMember))) { %>
            <ol>
            <jalios:foreach collection="<%= obj.getCategorieDeNavigation(loggedMember) %>" type="Category" name="itCategory" >
              <li><% if (itCategory != null) { %><a href="<%= ResourceHelper.getQuery() %>?cids=<%= itCategory.getId() %>"><%= itCategory.getAncestorString(channel.getCategory("$jcmsplugin.socle.ficheactu.categorieDeNavigation.root"), " > ", true, userLang) %></a><% } %></li>
            </jalios:foreach>
            </ol>
            <% } %>
    </td>
  </tr>
  <tr class="field thematiquesBesoins categoryEditor  <%= Util.isEmpty(obj.getThematiquesBesoins(loggedMember)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheActu.class, "thematiquesBesoins", userLang) %><jalios:edit pub='<%= obj %>' fields='thematiquesBesoins'/></td>
    <td class='field-data' >
            <% if (Util.notEmpty(obj.getThematiquesBesoins(loggedMember))) { %>
            <ol>
            <jalios:foreach collection="<%= obj.getThematiquesBesoins(loggedMember) %>" type="Category" name="itCategory" >
              <li><% if (itCategory != null) { %><a href="<%= ResourceHelper.getQuery() %>?cids=<%= itCategory.getId() %>"><%= itCategory.getAncestorString(channel.getCategory("$jcmsplugin.socle.ficheactu.thematiquesBesoins.root"), " > ", true, userLang) %></a><% } %></li>
            </jalios:foreach>
            </ol>
            <% } %>
    </td>
  </tr>
  <tr class="field delegations categoryEditor  <%= Util.isEmpty(obj.getDelegations(loggedMember)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheActu.class, "delegations", userLang) %><jalios:edit pub='<%= obj %>' fields='delegations'/></td>
    <td class='field-data' >
            <% if (Util.notEmpty(obj.getDelegations(loggedMember))) { %>
            <ol>
            <jalios:foreach collection="<%= obj.getDelegations(loggedMember) %>" type="Category" name="itCategory" >
              <li><% if (itCategory != null) { %><a href="<%= ResourceHelper.getQuery() %>?cids=<%= itCategory.getId() %>"><%= itCategory.getAncestorString(channel.getCategory("$jcmsplugin.socle.ficheactu.delegations.root"), " > ", true, userLang) %></a><% } %></li>
            </jalios:foreach>
            </ol>
            <% } %>
    </td>
  </tr>
  <tr class="field communes categoryEditor  <%= Util.isEmpty(obj.getCommunes(loggedMember)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheActu.class, "communes", userLang) %><jalios:edit pub='<%= obj %>' fields='communes'/></td>
    <td class='field-data' >
            <% if (Util.notEmpty(obj.getCommunes(loggedMember))) { %>
            <ol>
            <jalios:foreach collection="<%= obj.getCommunes(loggedMember) %>" type="Category" name="itCategory" >
              <li><% if (itCategory != null) { %><a href="<%= ResourceHelper.getQuery() %>?cids=<%= itCategory.getId() %>"><%= itCategory.getAncestorString(channel.getCategory("$jcmsplugin.socle.ficheactu.communes.root"), " > ", true, userLang) %></a><% } %></li>
            </jalios:foreach>
            </ol>
            <% } %>
    </td>
  </tr>
  <tr class="field toutesLesCommunesDuDepartement enumerateEditor  <%= Util.isEmpty(obj.getToutesLesCommunesDuDepartement()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheActu.class, "toutesLesCommunesDuDepartement", userLang) %><jalios:edit pub='<%= obj %>' fields='toutesLesCommunesDuDepartement'/></td>
    <td class='field-data' <%= gfla(obj, "toutesLesCommunesDuDepartement") %>>
            <% if (Util.notEmpty(obj.getToutesLesCommunesDuDepartement())) { %>
            <%= obj.getToutesLesCommunesDuDepartementLabel(obj.getToutesLesCommunesDuDepartement(), userLang) %>
            <% } %>
    </td>
  </tr>
  <tr class="field toutesLesCommunesEPCI categoryEditor  <%= Util.isEmpty(obj.getToutesLesCommunesEPCI(loggedMember)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheActu.class, "toutesLesCommunesEPCI", userLang) %><jalios:edit pub='<%= obj %>' fields='toutesLesCommunesEPCI'/></td>
    <td class='field-data' >
            <% if (Util.notEmpty(obj.getToutesLesCommunesEPCI(loggedMember))) { %>
            <ol>
            <jalios:foreach collection="<%= obj.getToutesLesCommunesEPCI(loggedMember) %>" type="Category" name="itCategory" >
              <li><% if (itCategory != null) { %><a href="<%= ResourceHelper.getQuery() %>?cids=<%= itCategory.getId() %>"><%= itCategory.getAncestorString(channel.getCategory("$jcmsplugin.socle.ficheactu.toutesLesCommunesEPCI.root"), " > ", true, userLang) %></a><% } %></li>
            </jalios:foreach>
            </ol>
            <% } %>
    </td>
  </tr>
  <tr class="field chapo textareaEditor  <%= Util.isEmpty(obj.getChapo(userLang)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheActu.class, "chapo", userLang) %><jalios:edit pub='<%= obj %>' fields='chapo'/></td>
    <td class='field-data' <%= gfla(obj, "chapo") %>>
            <% if (Util.notEmpty(obj.getChapo(userLang))) { %>
            <%= obj.getChapo(userLang) %>
            <% } %>
    </td>
  </tr>
  <tr class="field description wysiwygEditor  <%= Util.isEmpty(obj.getDescription(userLang)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheActu.class, "description", userLang) %><jalios:edit pub='<%= obj %>' fields='description'/></td>
    <td class='field-data' <%= gfla(obj, "description") %>>
            <% if (Util.notEmpty(obj.getDescription(userLang))) { %>
            <jalios:wysiwyg data='<%= obj %>' field='description'><%= obj.getDescription(userLang) %></jalios:wysiwyg>            
            <% } %>
    </td>
  </tr>
 
</table>
<jsp:include page="/front/doFullDisplayCommonFields.jsp" />
</div>