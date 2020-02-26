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
              <li><% if (itCategory != null) { %><a href="<%= ResourceHelper.getQuery() %>?cids=<%= itCategory.getId() %>"><%= itCategory.getAncestorString(channel.getCategory("$jcmsplugin.socle.emploiStage.typeOffre.root"), " > ", true, userLang) %></a><% } %></li>
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
  <tr class="field texteentete wysiwygEditor  <%= Util.isEmpty(obj.getTexteentete()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheEmploiStage.class, "texteentete", userLang) %><jalios:edit pub='<%= obj %>' fields='texteentete'/></td>
    <td class='field-data' <%= gfla(obj, "texteentete") %>>
            <% if (Util.notEmpty(obj.getTexteentete())) { %>
            <jalios:wysiwyg data='<%= obj %>' field='texteentete'><%= obj.getTexteentete() %></jalios:wysiwyg>            
            <% } %>
    </td>
  </tr>
  <tr class="field dateLimiteDeDepot dateEditor  <%= Util.isEmpty(obj.getDateLimiteDeDepot()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheEmploiStage.class, "dateLimiteDeDepot", userLang) %><jalios:edit pub='<%= obj %>' fields='dateLimiteDeDepot'/></td>
    <td class='field-data' >
            <%  if (obj.getDateLimiteDeDepot() != null) { %>
            <jalios:date date='<%= obj.getDateLimiteDeDepot() %>' format='<%= "short" %>'/>
            <jalios:time date='<%= obj.getDateLimiteDeDepot() %>' format='<%= "short" %>'/>
            <% } %>
    </td>
  </tr>
  <tr class="field numeroDePoste textfieldEditor  <%= Util.isEmpty(obj.getNumeroDePoste()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheEmploiStage.class, "numeroDePoste", userLang) %><jalios:edit pub='<%= obj %>' fields='numeroDePoste'/></td>
    <td class='field-data' <%= gfla(obj, "numeroDePoste") %>>
            <% if (Util.notEmpty(obj.getNumeroDePoste())) { %>
            <%= obj.getNumeroDePoste() %>
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
  <tr class="field directiondelegation categoryEditor  <%= Util.isEmpty(obj.getDirectiondelegation(loggedMember)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheEmploiStage.class, "directiondelegation", userLang) %><jalios:edit pub='<%= obj %>' fields='directiondelegation'/></td>
    <td class='field-data' >
            <% if (Util.notEmpty(obj.getDirectiondelegation(loggedMember))) { %>
            <ol>
            <jalios:foreach collection="<%= obj.getDirectiondelegation(loggedMember) %>" type="Category" name="itCategory" >
              <li><% if (itCategory != null) { %><a href="<%= ResourceHelper.getQuery() %>?cids=<%= itCategory.getId() %>"><%= itCategory.getAncestorString(channel.getCategory("$jcmsplugin.socle.emploiStage.directionDelegation.root"), " > ", true, userLang) %></a><% } %></li>
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
  <tr class="field cp textfieldEditor  <%= Util.isEmpty(obj.getCp()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheEmploiStage.class, "cp", userLang) %><jalios:edit pub='<%= obj %>' fields='cp'/></td>
    <td class='field-data' <%= gfla(obj, "cp") %>>
            <% if (Util.notEmpty(obj.getCp())) { %>
            <%= obj.getCp() %>
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
  <tr class="field missions wysiwygEditor  <%= Util.isEmpty(obj.getMissions()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheEmploiStage.class, "missions", userLang) %><jalios:edit pub='<%= obj %>' fields='missions'/></td>
    <td class='field-data' <%= gfla(obj, "missions") %>>
            <% if (Util.notEmpty(obj.getMissions())) { %>
            <jalios:wysiwyg data='<%= obj %>' field='missions'><%= obj.getMissions() %></jalios:wysiwyg>            
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
  <tr class="field filiere categoryEditor  <%= Util.isEmpty(obj.getFiliere(loggedMember)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheEmploiStage.class, "filiere", userLang) %><jalios:edit pub='<%= obj %>' fields='filiere'/></td>
    <td class='field-data' >
            <% if (Util.notEmpty(obj.getFiliere(loggedMember))) { %>
            <ol>
            <jalios:foreach collection="<%= obj.getFiliere(loggedMember) %>" type="Category" name="itCategory" >
              <li><% if (itCategory != null) { %><a href="<%= ResourceHelper.getQuery() %>?cids=<%= itCategory.getId() %>"><%= itCategory.getAncestorString(channel.getCategory("$jcmsplugin.socle.emploiStage.filiere.root"), " > ", true, userLang) %></a><% } %></li>
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
              <li><% if (itCategory != null) { %><a href="<%= ResourceHelper.getQuery() %>?cids=<%= itCategory.getId() %>"><%= itCategory.getAncestorString(channel.getCategory("$jcmsplugin.socle.emploiStage.emploi.root"), " > ", true, userLang) %></a><% } %></li>
            </jalios:foreach>
            </ol>
            <% } %>
    </td>
  </tr>
  <tr class="field grade wysiwygEditor  <%= Util.isEmpty(obj.getGrade()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheEmploiStage.class, "grade", userLang) %><jalios:edit pub='<%= obj %>' fields='grade'/></td>
    <td class='field-data' <%= gfla(obj, "grade") %>>
        <% if (Util.notEmpty(obj.getGrade())) { %>
            <ol>
            <jalios:foreach name="itString" type="String" array="<%= obj.getGrade() %>">
            <% if (Util.notEmpty(itString)) { %>
              <li>
              <jalios:wysiwyg data='<%= obj %>' field='grade'><%= itString %></jalios:wysiwyg>
              </li>
            <% } %>
            </jalios:foreach>
            </ol>
        <% } %>
    </td>
  </tr>
  <tr class="field reserveAgentsColleges categoryEditor  <%= Util.isEmpty(obj.getReserveAgentsColleges(loggedMember)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheEmploiStage.class, "reserveAgentsColleges", userLang) %><jalios:edit pub='<%= obj %>' fields='reserveAgentsColleges'/></td>
    <td class='field-data' >
            <% if (Util.notEmpty(obj.getReserveAgentsColleges(loggedMember))) { %>
            <ol>
            <jalios:foreach collection="<%= obj.getReserveAgentsColleges(loggedMember) %>" type="Category" name="itCategory" >
              <li><% if (itCategory != null) { %><a href="<%= ResourceHelper.getQuery() %>?cids=<%= itCategory.getId() %>"><%= itCategory.getAncestorString(channel.getCategory("$jcmsplugin.socle.emploiStage.reserveAgentsColleges.root"), " > ", true, userLang) %></a><% } %></li>
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
  <tr class="field connaissancesEtExperiences wysiwygEditor  <%= Util.isEmpty(obj.getConnaissancesEtExperiences()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheEmploiStage.class, "connaissancesEtExperiences", userLang) %><jalios:edit pub='<%= obj %>' fields='connaissancesEtExperiences'/></td>
    <td class='field-data' <%= gfla(obj, "connaissancesEtExperiences") %>>
            <% if (Util.notEmpty(obj.getConnaissancesEtExperiences())) { %>
            <jalios:wysiwyg data='<%= obj %>' field='connaissancesEtExperiences'><%= obj.getConnaissancesEtExperiences() %></jalios:wysiwyg>            
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
  <tr class="field contactRH textfieldEditor  <%= Util.isEmpty(obj.getContactRH()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheEmploiStage.class, "contactRH", userLang) %><jalios:edit pub='<%= obj %>' fields='contactRH'/></td>
    <td class='field-data' <%= gfla(obj, "contactRH") %>>
            <% if (Util.notEmpty(obj.getContactRH())) { %>
            <%= obj.getContactRH() %>
            <% } %>
    </td>
  </tr>
  <tr class="field uniteOrgaContactRH textfieldEditor  <%= Util.isEmpty(obj.getUniteOrgaContactRH()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheEmploiStage.class, "uniteOrgaContactRH", userLang) %><jalios:edit pub='<%= obj %>' fields='uniteOrgaContactRH'/></td>
    <td class='field-data' <%= gfla(obj, "uniteOrgaContactRH") %>>
            <% if (Util.notEmpty(obj.getUniteOrgaContactRH())) { %>
            <%= obj.getUniteOrgaContactRH() %>
            <% } %>
    </td>
  </tr>
  <tr class="field telContactRH textfieldEditor  <%= Util.isEmpty(obj.getTelContactRH()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheEmploiStage.class, "telContactRH", userLang) %><jalios:edit pub='<%= obj %>' fields='telContactRH'/></td>
    <td class='field-data' <%= gfla(obj, "telContactRH") %>>
            <% if (Util.notEmpty(obj.getTelContactRH())) { %>
            <%= obj.getTelContactRH() %>
            <% } %>
    </td>
  </tr>
  <tr class="field contactMetier textfieldEditor  <%= Util.isEmpty(obj.getContactMetier()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheEmploiStage.class, "contactMetier", userLang) %><jalios:edit pub='<%= obj %>' fields='contactMetier'/></td>
    <td class='field-data' <%= gfla(obj, "contactMetier") %>>
            <% if (Util.notEmpty(obj.getContactMetier())) { %>
            <%= obj.getContactMetier() %>
            <% } %>
    </td>
  </tr>
  <tr class="field uniteOrgaContactMetier textfieldEditor  <%= Util.isEmpty(obj.getUniteOrgaContactMetier()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheEmploiStage.class, "uniteOrgaContactMetier", userLang) %><jalios:edit pub='<%= obj %>' fields='uniteOrgaContactMetier'/></td>
    <td class='field-data' <%= gfla(obj, "uniteOrgaContactMetier") %>>
            <% if (Util.notEmpty(obj.getUniteOrgaContactMetier())) { %>
            <%= obj.getUniteOrgaContactMetier() %>
            <% } %>
    </td>
  </tr>
  <tr class="field telContactMetier textfieldEditor  <%= Util.isEmpty(obj.getTelContactMetier()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheEmploiStage.class, "telContactMetier", userLang) %><jalios:edit pub='<%= obj %>' fields='telContactMetier'/></td>
    <td class='field-data' <%= gfla(obj, "telContactMetier") %>>
            <% if (Util.notEmpty(obj.getTelContactMetier())) { %>
            <%= obj.getTelContactMetier() %>
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
  <tr class="field categoriesDeNavigation categoryEditor  <%= Util.isEmpty(obj.getCategoriesDeNavigation(loggedMember)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheEmploiStage.class, "categoriesDeNavigation", userLang) %><jalios:edit pub='<%= obj %>' fields='categoriesDeNavigation'/></td>
    <td class='field-data' >
            <% if (Util.notEmpty(obj.getCategoriesDeNavigation(loggedMember))) { %>
            <ol>
            <jalios:foreach collection="<%= obj.getCategoriesDeNavigation(loggedMember) %>" type="Category" name="itCategory" >
              <li><% if (itCategory != null) { %><a href="<%= ResourceHelper.getQuery() %>?cids=<%= itCategory.getId() %>"><%= itCategory.getAncestorString(channel.getCategory("p1_924130"), " > ", true, userLang) %></a><% } %></li>
            </jalios:foreach>
            </ol>
            <% } %>
    </td>
  </tr>
 
</table>
<jsp:include page="/front/doFullDisplayCommonFields.jsp" />
</div><%-- **********4A616C696F73204A434D53 *** SIGNATURE BOUNDARY * DO NOT EDIT ANYTHING BELOW THIS LINE *** --%><%
%><%-- egyUkR6GqGNif5DilUqUUg== --%>