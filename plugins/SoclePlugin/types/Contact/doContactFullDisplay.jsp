<%@ page contentType="text/html; charset=UTF-8" %><%
%><%@ include file='/jcore/doInitPage.jspf' %><%
%><% Contact obj = (Contact)request.getAttribute(PortalManager.PORTAL_PUBLICATION); %><%
%><%@ include file='/front/doFullDisplay.jspf' %>
<div class="fullDisplay Contact <%= obj.canBeEditedFieldByField(loggedMember) ? "unitFieldEdition" : "" %>" itemscope="itemscope">
<%@ include file='/front/publication/doPublicationHeader.jspf' %>
<table class="fields">
  <tr class="field nom textfieldEditor  <%= Util.isEmpty(obj.getNom()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(Contact.class, "nom", userLang) %><jalios:edit pub='<%= obj %>' fields='nom'/></td>
    <td class='field-data' <%= gfla(obj, "nom") %>>
            <% if (Util.notEmpty(obj.getNom())) { %>
            <%= obj.getNom() %>
            <% } %>
    </td>
  </tr>
  <tr class="field prenom textfieldEditor  <%= Util.isEmpty(obj.getPrenom()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(Contact.class, "prenom", userLang) %><jalios:edit pub='<%= obj %>' fields='prenom'/></td>
    <td class='field-data' <%= gfla(obj, "prenom") %>>
            <% if (Util.notEmpty(obj.getPrenom())) { %>
            <%= obj.getPrenom() %>
            <% } %>
    </td>
  </tr>
  <tr class="field civilite enumerateEditor  <%= Util.isEmpty(obj.getCivilite()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(Contact.class, "civilite", userLang) %><jalios:edit pub='<%= obj %>' fields='civilite'/></td>
    <td class='field-data' <%= gfla(obj, "civilite") %>>
            <% if (Util.notEmpty(obj.getCivilite())) { %>
            <%= obj.getCiviliteLabel(obj.getCivilite(), userLang) %>
            <% } %>
    </td>
  </tr>
  <tr class="field photoDidentite imageEditor  <%= Util.isEmpty(obj.getPhotoDidentite()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(Contact.class, "photoDidentite", userLang) %><jalios:edit pub='<%= obj %>' fields='photoDidentite'/></td>
    <td class='field-data' <%= gfla(obj, "photoDidentite") %>>
            <% if (Util.notEmpty(obj.getPhotoDidentite())) { %>
            <img src='<%= Util.encodeUrl(obj.getPhotoDidentite()) %>' alt='' />
            <% } %>
    </td>
  </tr>
  <tr class="field fonction textfieldEditor  <%= Util.isEmpty(obj.getFonction(userLang)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(Contact.class, "fonction", userLang) %><jalios:edit pub='<%= obj %>' fields='fonction'/></td>
    <td class='field-data' <%= gfla(obj, "fonction") %>>
            <% if (Util.notEmpty(obj.getFonction(userLang))) { %>
            <%= obj.getFonction(userLang) %>
            <% } %>
    </td>
  </tr>
  <tr class="field lieuDeRattachement linkEditor  <%= Util.isEmpty(obj.getLieuDeRattachement()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(Contact.class, "lieuDeRattachement", userLang) %><jalios:edit pub='<%= obj %>' fields='lieuDeRattachement'/></td>
    <td class='field-data' >
            <% if (obj.getLieuDeRattachement() != null && obj.getLieuDeRattachement().canBeReadBy(loggedMember)) { %>
            <jalios:link data='<%= obj.getLieuDeRattachement() %>'/>
            <% } %>
    </td>
  </tr>
  <tr class="field telephone textfieldEditor  <%= Util.isEmpty(obj.getTelephone()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(Contact.class, "telephone", userLang) %><jalios:edit pub='<%= obj %>' fields='telephone'/></td>
    <td class='field-data' <%= gfla(obj, "telephone") %>>
        <% if (Util.notEmpty(obj.getTelephone())) { %>
            <ol>
            <jalios:foreach name="itString" type="String" array="<%= obj.getTelephone() %>">
            <% if (Util.notEmpty(itString)) { %>
              <li>
              <%= itString %>
              </li>
            <% } %>
            </jalios:foreach>
            </ol>
        <% } %>
    </td>
  </tr>
  <tr class="field adresseMail emailEditor  <%= Util.isEmpty(obj.getAdresseMail()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(Contact.class, "adresseMail", userLang) %><jalios:edit pub='<%= obj %>' fields='adresseMail'/></td>
    <td class='field-data' <%= gfla(obj, "adresseMail") %>>
            <% if (Util.notEmpty(obj.getAdresseMail())) { %>
            <a href='mailto:<%= obj.getAdresseMail() %>'><%= obj.getAdresseMail()%></a>
            <% } %>
    </td>
  </tr>
  <tr class="field contactPourLesFichesLieux linkEditor  <%= Util.isEmpty(obj.getContactPourLesFichesLieux()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(Contact.class, "contactPourLesFichesLieux", userLang) %><jalios:edit pub='<%= obj %>' fields='contactPourLesFichesLieux'/></td>
    <td class='field-data' >
            <% if (Util.notEmpty(obj.getContactPourLesFichesLieux())) { %>
            <ol>
              <jalios:foreach name="itData" type="generated.FicheLieu" array="<%= obj.getContactPourLesFichesLieux() %>">
              <% if (itData != null && itData.canBeReadBy(loggedMember)) { %>
              <li>
              <jalios:link data='<%= itData %>'/>
              </li>
              <% } %>
              </jalios:foreach>
            </ol>
            <% } %>
    </td>
  </tr>
  <tr class="field categorieDeNavigation categoryEditor  <%= Util.isEmpty(obj.getCategorieDeNavigation(loggedMember)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(Contact.class, "categorieDeNavigation", userLang) %><jalios:edit pub='<%= obj %>' fields='categorieDeNavigation'/></td>
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
    <td class='field-label'><%= channel.getTypeFieldLabel(Contact.class, "miseEnAvant", userLang) %><jalios:edit pub='<%= obj %>' fields='miseEnAvant'/></td>
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
  <tr class="field typeDeContact categoryEditor  <%= Util.isEmpty(obj.getTypeDeContact(loggedMember)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(Contact.class, "typeDeContact", userLang) %><jalios:edit pub='<%= obj %>' fields='typeDeContact'/></td>
    <td class='field-data' >
            <% if (Util.notEmpty(obj.getTypeDeContact(loggedMember))) { %>
            <ol>
            <jalios:foreach collection="<%= obj.getTypeDeContact(loggedMember) %>" type="Category" name="itCategory" >
              <li><% if (itCategory != null) { %><a href="<%= ResourceHelper.getQuery() %>?cids=<%= itCategory.getId() %>"><%= itCategory.getAncestorString(channel.getCategory("$jcmsplugin.socle.contact.typeContact.root"), " > ", true, userLang) %></a><% } %></li>
            </jalios:foreach>
            </ol>
            <% } %>
    </td>
  </tr>
  <tr class="field communes linkEditor  <%= Util.isEmpty(obj.getCommunes()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(Contact.class, "communes", userLang) %><jalios:edit pub='<%= obj %>' fields='communes'/></td>
    <td class='field-data' >
            <% if (Util.notEmpty(obj.getCommunes())) { %>
            <ol>
              <jalios:foreach name="itData" type="generated.City" array="<%= obj.getCommunes() %>">
              <% if (itData != null && itData.canBeReadBy(loggedMember)) { %>
              <li>
              <jalios:link data='<%= itData %>'/>
              </li>
              <% } %>
              </jalios:foreach>
            </ol>
            <% } %>
    </td>
  </tr>
  <tr class="field toutesLesCommunesDuDepartement booleanEditor  ">
    <td class='field-label'><%= channel.getTypeFieldLabel(Contact.class, "toutesLesCommunesDuDepartement", userLang) %><jalios:edit pub='<%= obj %>' fields='toutesLesCommunesDuDepartement'/></td>
    <td class='field-data' >
            <%= obj.getToutesLesCommunesDuDepartementLabel(userLang) %>
    </td>
  </tr>
  <tr class="field delegations linkEditor  <%= Util.isEmpty(obj.getDelegations()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(Contact.class, "delegations", userLang) %><jalios:edit pub='<%= obj %>' fields='delegations'/></td>
    <td class='field-data' >
            <% if (Util.notEmpty(obj.getDelegations())) { %>
            <ol>
              <jalios:foreach name="itData" type="generated.Delegation" array="<%= obj.getDelegations() %>">
              <% if (itData != null && itData.canBeReadBy(loggedMember)) { %>
              <li>
              <jalios:link data='<%= itData %>'/>
              </li>
              <% } %>
              </jalios:foreach>
            </ol>
            <% } %>
    </td>
  </tr>
  <tr class="field epci categoryEditor  <%= Util.isEmpty(obj.getEpci(loggedMember)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(Contact.class, "epci", userLang) %><jalios:edit pub='<%= obj %>' fields='epci'/></td>
    <td class='field-data' >
            <% if (Util.notEmpty(obj.getEpci(loggedMember))) { %>
            <ol>
            <jalios:foreach collection="<%= obj.getEpci(loggedMember) %>" type="Category" name="itCategory" >
              <li><% if (itCategory != null) { %><a href="<%= ResourceHelper.getQuery() %>?cids=<%= itCategory.getId() %>"><%= itCategory.getAncestorString(channel.getCategory("$jcmsplugin.socle.category.toutesLesCommunesEPCI.root"), " > ", true, userLang) %></a><% } %></li>
            </jalios:foreach>
            </ol>
            <% } %>
    </td>
  </tr>
  <tr class="field cantons linkEditor  <%= Util.isEmpty(obj.getCantons()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(Contact.class, "cantons", userLang) %><jalios:edit pub='<%= obj %>' fields='cantons'/></td>
    <td class='field-data' >
            <% if (Util.notEmpty(obj.getCantons())) { %>
            <ol>
              <jalios:foreach name="itData" type="generated.Canton" array="<%= obj.getCantons() %>">
              <% if (itData != null && itData.canBeReadBy(loggedMember)) { %>
              <li>
              <jalios:link data='<%= itData %>'/>
              </li>
              <% } %>
              </jalios:foreach>
            </ol>
            <% } %>
    </td>
  </tr>
 
</table>
<jsp:include page="/front/doFullDisplayCommonFields.jsp" />
</div>