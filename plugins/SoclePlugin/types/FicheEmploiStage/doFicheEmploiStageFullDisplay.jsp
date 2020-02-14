<%@ page contentType="text/html; charset=UTF-8" %><%
%><%-- This file has been automatically generated. --%><%
%><%--
  @Summary: FicheEmploiStage display page
  @Category: Generated
  @Author: JCMS Type Processor
  @Customizable: True
  @Requestable: True
--%><%
%><%@ include file='/jcore/doInitPage.jspf' %><%
%><% FicheEmploiStage obj = (FicheEmploiStage)request.getAttribute(PortalManager.PORTAL_PUBLICATION); %><%
%><%@ include file='/front/doFullDisplay.jspf' %>
<div class="fullDisplay FicheEmploiStage <%= obj.canBeEditedFieldByField(loggedMember) ? "unitFieldEdition" : "" %>" itemscope="itemscope">
<%@ include file='/front/publication/doPublicationHeader.jspf' %>
<table class="fields">
  <tr class="field typeDoffre categoryEditor  <%= Util.isEmpty(obj.getTypeDoffre(loggedMember)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheEmploiStage.class, "typeDoffre", userLang) %><jalios:edit pub='<%= obj %>' fields='typeDoffre'/></td>
    <td class='field-data' >
            <% if (Util.notEmpty(obj.getTypeDoffre(loggedMember))) { %>
            <ol>
            <jalios:foreach collection="<%= obj.getTypeDoffre(loggedMember) %>" type="Category" name="itCategory" >
              <li><% if (itCategory != null) { %><a href="<%= ResourceHelper.getQuery() %>?cids=<%= itCategory.getId() %>"><%= itCategory.getAncestorString(channel.getCategory("p2_67096"), " > ", true, userLang) %></a><% } %></li>
            </jalios:foreach>
            </ol>
            <% } %>
    </td>
  </tr>
  <tr class="field duree textfieldEditor  <%= Util.isEmpty(obj.getDuree()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheEmploiStage.class, "duree", userLang) %><jalios:edit pub='<%= obj %>' fields='duree'/></td>
    <td class='field-data' <%= gfla(obj, "duree") %>>
            <% if (Util.notEmpty(obj.getDuree())) { %>
            <%= obj.getDuree() %>
            <% } %>
    </td>
  </tr>
  <tr class="field texteEntete wysiwygEditor  <%= Util.isEmpty(obj.getTexteEntete()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheEmploiStage.class, "texteEntete", userLang) %><jalios:edit pub='<%= obj %>' fields='texteEntete'/></td>
    <td class='field-data' <%= gfla(obj, "texteEntete") %>>
            <% if (Util.notEmpty(obj.getTexteEntete())) { %>
            <jalios:wysiwyg data='<%= obj %>' field='texteEntete'><%= obj.getTexteEntete() %></jalios:wysiwyg>            
            <% } %>
    </td>
  </tr>
  <tr class="field dateLimiteDepot dateEditor  <%= Util.isEmpty(obj.getDateLimiteDepot()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheEmploiStage.class, "dateLimiteDepot", userLang) %><jalios:edit pub='<%= obj %>' fields='dateLimiteDepot'/></td>
    <td class='field-data' >
            <%  if (obj.getDateLimiteDepot() != null) { %>
            <jalios:date date='<%= obj.getDateLimiteDepot() %>' format='<%= "short" %>'/>
            <jalios:time date='<%= obj.getDateLimiteDepot() %>' format='<%= "short" %>'/>
            <% } %>
    </td>
  </tr>
  <tr class="field reference textfieldEditor  <%= Util.isEmpty(obj.getReference()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheEmploiStage.class, "reference", userLang) %><jalios:edit pub='<%= obj %>' fields='reference'/></td>
    <td class='field-data' <%= gfla(obj, "reference") %>>
            <% if (Util.notEmpty(obj.getReference())) { %>
            <%= obj.getReference() %>
            <% } %>
    </td>
  </tr>
  <tr class="field positionHierarchique textfieldEditor  <%= Util.isEmpty(obj.getPositionHierarchique()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheEmploiStage.class, "positionHierarchique", userLang) %><jalios:edit pub='<%= obj %>' fields='positionHierarchique'/></td>
    <td class='field-data' <%= gfla(obj, "positionHierarchique") %>>
            <% if (Util.notEmpty(obj.getPositionHierarchique())) { %>
            <%= obj.getPositionHierarchique() %>
            <% } %>
    </td>
  </tr>
  <tr class="field directionDelegations categoryEditor  <%= Util.isEmpty(obj.getDirectionDelegations(loggedMember)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheEmploiStage.class, "directionDelegations", userLang) %><jalios:edit pub='<%= obj %>' fields='directionDelegations'/></td>
    <td class='field-data' >
            <% if (Util.notEmpty(obj.getDirectionDelegations(loggedMember))) { %>
            <ol>
            <jalios:foreach collection="<%= obj.getDirectionDelegations(loggedMember) %>" type="Category" name="itCategory" >
              <li><% if (itCategory != null) { %><a href="<%= ResourceHelper.getQuery() %>?cids=<%= itCategory.getId() %>"><%= itCategory.getAncestorString(channel.getCategory("c_1155051"), " > ", true, userLang) %></a><% } %></li>
            </jalios:foreach>
            </ol>
            <% } %>
    </td>
  </tr>
  <tr class="field service textfieldEditor  <%= Util.isEmpty(obj.getService()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheEmploiStage.class, "service", userLang) %><jalios:edit pub='<%= obj %>' fields='service'/></td>
    <td class='field-data' <%= gfla(obj, "service") %>>
            <% if (Util.notEmpty(obj.getService())) { %>
            <%= obj.getService() %>
            <% } %>
    </td>
  </tr>
  <tr class="field lieuDeTravail textfieldEditor  <%= Util.isEmpty(obj.getLieuDeTravail()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheEmploiStage.class, "lieuDeTravail", userLang) %><jalios:edit pub='<%= obj %>' fields='lieuDeTravail'/></td>
    <td class='field-data' <%= gfla(obj, "lieuDeTravail") %>>
            <% if (Util.notEmpty(obj.getLieuDeTravail())) { %>
            <%= obj.getLieuDeTravail() %>
            <% } %>
    </td>
  </tr>
  <tr class="field rue textfieldEditor  <%= Util.isEmpty(obj.getRue()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheEmploiStage.class, "rue", userLang) %><jalios:edit pub='<%= obj %>' fields='rue'/></td>
    <td class='field-data' <%= gfla(obj, "rue") %>>
            <% if (Util.notEmpty(obj.getRue())) { %>
            <%= obj.getRue() %>
            <% } %>
    </td>
  </tr>
  <tr class="field codePostal textfieldEditor  <%= Util.isEmpty(obj.getCodePostal()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheEmploiStage.class, "codePostal", userLang) %><jalios:edit pub='<%= obj %>' fields='codePostal'/></td>
    <td class='field-data' <%= gfla(obj, "codePostal") %>>
            <% if (Util.notEmpty(obj.getCodePostal())) { %>
            <%= obj.getCodePostal() %>
            <% } %>
    </td>
  </tr>
  <tr class="field commune linkEditor  <%= Util.isEmpty(obj.getCommune()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheEmploiStage.class, "commune", userLang) %><jalios:edit pub='<%= obj %>' fields='commune'/></td>
    <td class='field-data' >
            <% if (obj.getCommune() != null && obj.getCommune().canBeReadBy(loggedMember)) { %>
            <jalios:link data='<%= obj.getCommune() %>'/>
            <% } %>
    </td>
  </tr>
  <tr class="field image imageEditor  <%= Util.isEmpty(obj.getImage()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheEmploiStage.class, "image", userLang) %><jalios:edit pub='<%= obj %>' fields='image'/></td>
    <td class='field-data' <%= gfla(obj, "image") %>>
            <% if (Util.notEmpty(obj.getImage())) { %>
            <img src='<%= Util.encodeUrl(obj.getImage()) %>' alt='' />
            <% } %>
    </td>
  </tr>
  <tr class="field mission wysiwygEditor  <%= Util.isEmpty(obj.getMission()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheEmploiStage.class, "mission", userLang) %><jalios:edit pub='<%= obj %>' fields='mission'/></td>
    <td class='field-data' <%= gfla(obj, "mission") %>>
            <% if (Util.notEmpty(obj.getMission())) { %>
            <jalios:wysiwyg data='<%= obj %>' field='mission'><%= obj.getMission() %></jalios:wysiwyg>            
            <% } %>
    </td>
  </tr>
  <tr class="field activites wysiwygEditor  <%= Util.isEmpty(obj.getActivites()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheEmploiStage.class, "activites", userLang) %><jalios:edit pub='<%= obj %>' fields='activites'/></td>
    <td class='field-data' <%= gfla(obj, "activites") %>>
            <% if (Util.notEmpty(obj.getActivites())) { %>
            <jalios:wysiwyg data='<%= obj %>' field='activites'><%= obj.getActivites() %></jalios:wysiwyg>            
            <% } %>
    </td>
  </tr>
  <tr class="field filieres categoryEditor  <%= Util.isEmpty(obj.getFilieres(loggedMember)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheEmploiStage.class, "filieres", userLang) %><jalios:edit pub='<%= obj %>' fields='filieres'/></td>
    <td class='field-data' >
            <% if (Util.notEmpty(obj.getFilieres(loggedMember))) { %>
            <ol>
            <jalios:foreach collection="<%= obj.getFilieres(loggedMember) %>" type="Category" name="itCategory" >
              <li><% if (itCategory != null) { %><a href="<%= ResourceHelper.getQuery() %>?cids=<%= itCategory.getId() %>"><%= itCategory.getAncestorString(channel.getCategory("t1_19239"), " > ", true, userLang) %></a><% } %></li>
            </jalios:foreach>
            </ol>
            <% } %>
    </td>
  </tr>
  <tr class="field categorieDemploi categoryEditor  <%= Util.isEmpty(obj.getCategorieDemploi(loggedMember)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheEmploiStage.class, "categorieDemploi", userLang) %><jalios:edit pub='<%= obj %>' fields='categorieDemploi'/></td>
    <td class='field-data' >
            <% if (Util.notEmpty(obj.getCategorieDemploi(loggedMember))) { %>
            <ol>
            <jalios:foreach collection="<%= obj.getCategorieDemploi(loggedMember) %>" type="Category" name="itCategory" >
              <li><% if (itCategory != null) { %><a href="<%= ResourceHelper.getQuery() %>?cids=<%= itCategory.getId() %>"><%= itCategory.getAncestorString(channel.getCategory("t1_8955"), " > ", true, userLang) %></a><% } %></li>
            </jalios:foreach>
            </ol>
            <% } %>
    </td>
  </tr>
  <tr class="field cadreDemploi wysiwygEditor  <%= Util.isEmpty(obj.getCadreDemploi()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheEmploiStage.class, "cadreDemploi", userLang) %><jalios:edit pub='<%= obj %>' fields='cadreDemploi'/></td>
    <td class='field-data' <%= gfla(obj, "cadreDemploi") %>>
        <% if (Util.notEmpty(obj.getCadreDemploi())) { %>
            <ol>
            <jalios:foreach name="itString" type="String" array="<%= obj.getCadreDemploi() %>">
            <% if (Util.notEmpty(itString)) { %>
              <li>
              <jalios:wysiwyg data='<%= obj %>' field='cadreDemploi'><%= itString %></jalios:wysiwyg>
              </li>
            <% } %>
            </jalios:foreach>
            </ol>
        <% } %>
    </td>
  </tr>
  <tr class="field metierEnTension booleanEditor  ">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheEmploiStage.class, "metierEnTension", userLang) %><jalios:edit pub='<%= obj %>' fields='metierEnTension'/></td>
    <td class='field-data' >
            <%= obj.getMetierEnTensionLabel(userLang) %>
    </td>
  </tr>
  <tr class="field competencesAttendues wysiwygEditor  <%= Util.isEmpty(obj.getCompetencesAttendues()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheEmploiStage.class, "competencesAttendues", userLang) %><jalios:edit pub='<%= obj %>' fields='competencesAttendues'/></td>
    <td class='field-data' <%= gfla(obj, "competencesAttendues") %>>
            <% if (Util.notEmpty(obj.getCompetencesAttendues())) { %>
            <jalios:wysiwyg data='<%= obj %>' field='competencesAttendues'><%= obj.getCompetencesAttendues() %></jalios:wysiwyg>            
            <% } %>
    </td>
  </tr>
  <tr class="field conditionsARemplir wysiwygEditor  <%= Util.isEmpty(obj.getConditionsARemplir()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheEmploiStage.class, "conditionsARemplir", userLang) %><jalios:edit pub='<%= obj %>' fields='conditionsARemplir'/></td>
    <td class='field-data' <%= gfla(obj, "conditionsARemplir") %>>
            <% if (Util.notEmpty(obj.getConditionsARemplir())) { %>
            <jalios:wysiwyg data='<%= obj %>' field='conditionsARemplir'><%= obj.getConditionsARemplir() %></jalios:wysiwyg>            
            <% } %>
    </td>
  </tr>
  <tr class="field specificitesDuPoste wysiwygEditor  <%= Util.isEmpty(obj.getSpecificitesDuPoste()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheEmploiStage.class, "specificitesDuPoste", userLang) %><jalios:edit pub='<%= obj %>' fields='specificitesDuPoste'/></td>
    <td class='field-data' <%= gfla(obj, "specificitesDuPoste") %>>
            <% if (Util.notEmpty(obj.getSpecificitesDuPoste())) { %>
            <jalios:wysiwyg data='<%= obj %>' field='specificitesDuPoste'><%= obj.getSpecificitesDuPoste() %></jalios:wysiwyg>            
            <% } %>
    </td>
  </tr>
  <tr class="field modalitesDeCandidature wysiwygEditor  <%= Util.isEmpty(obj.getModalitesDeCandidature()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheEmploiStage.class, "modalitesDeCandidature", userLang) %><jalios:edit pub='<%= obj %>' fields='modalitesDeCandidature'/></td>
    <td class='field-data' <%= gfla(obj, "modalitesDeCandidature") %>>
            <% if (Util.notEmpty(obj.getModalitesDeCandidature())) { %>
            <jalios:wysiwyg data='<%= obj %>' field='modalitesDeCandidature'><%= obj.getModalitesDeCandidature() %></jalios:wysiwyg>            
            <% } %>
    </td>
  </tr>
  <tr class="field contacts wysiwygEditor  <%= Util.isEmpty(obj.getContacts()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheEmploiStage.class, "contacts", userLang) %><jalios:edit pub='<%= obj %>' fields='contacts'/></td>
    <td class='field-data' <%= gfla(obj, "contacts") %>>
            <% if (Util.notEmpty(obj.getContacts())) { %>
            <jalios:wysiwyg data='<%= obj %>' field='contacts'><%= obj.getContacts() %></jalios:wysiwyg>            
            <% } %>
    </td>
  </tr>
  <tr class="field titreEncartDocument textfieldEditor  <%= Util.isEmpty(obj.getTitreEncartDocument()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheEmploiStage.class, "titreEncartDocument", userLang) %><jalios:edit pub='<%= obj %>' fields='titreEncartDocument'/></td>
    <td class='field-data' <%= gfla(obj, "titreEncartDocument") %>>
        <% if (Util.notEmpty(obj.getTitreEncartDocument())) { %>
            <ol>
            <jalios:foreach name="itString" type="String" array="<%= obj.getTitreEncartDocument() %>">
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
  <tr class="field documentsMultiple linkEditor  <%= Util.isEmpty(obj.getDocumentsMultiple()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheEmploiStage.class, "documentsMultiple", userLang) %><jalios:edit pub='<%= obj %>' fields='documentsMultiple'/></td>
    <td class='field-data' >
            <% if (Util.notEmpty(obj.getDocumentsMultiple())) { %>
            <ol>
              <jalios:foreach name="itData" type="com.jalios.jcms.FileDocument" array="<%= obj.getDocumentsMultiple() %>">
              <% if (itData != null && itData.canBeReadBy(loggedMember)) { %>
              <li>
              <jalios:link data='<%= itData %>' params='details=true' ><jalios:fileicon doc='<%= itData %>' /></jalios:link>
              <jalios:link data='<%= itData %>'/>
              - <jalios:filesize doc='<%= itData %>'/>
              <jalios:pdf doc='<%= itData %>' />
              </li>
              <% } %>
              </jalios:foreach>
            </ol>
            <% } %>
    </td>
  </tr>
 
</table>
<jsp:include page="/front/doFullDisplayCommonFields.jsp" />
</div><%-- **********4A616C696F73204A434D53 *** SIGNATURE BOUNDARY * DO NOT EDIT ANYTHING BELOW THIS LINE *** --%><%
%><%-- jqccYQRlnRSO0ptYGhEXnQ== --%>