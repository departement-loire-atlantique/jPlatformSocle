<%@ page contentType="text/html; charset=UTF-8" %><%
%><%-- This file has been automatically generated. --%><%
%><%--
  @Summary: FicheActionEducative display page
  @Category: Generated
  @Author: JCMS Type Processor
  @Customizable: True
  @Requestable: True
--%><%
%><%@ include file='/jcore/doInitPage.jspf' %><%
%><% FicheActionEducative obj = (FicheActionEducative)request.getAttribute(PortalManager.PORTAL_PUBLICATION); %><%
%><%@ include file='/front/doFullDisplay.jspf' %>
<div class="fullDisplay FicheActionEducative <%= obj.canBeEditedFieldByField(loggedMember) ? "unitFieldEdition" : "" %>" itemscope="itemscope">
<%@ include file='/front/publication/doPublicationHeader.jspf' %>
<table class="fields">
  <tr class="field soustitre textfieldEditor  <%= Util.isEmpty(obj.getSoustitre()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheActionEducative.class, "soustitre", userLang) %><jalios:edit pub='<%= obj %>' fields='soustitre'/></td>
    <td class='field-data' <%= gfla(obj, "soustitre") %>>
            <% if (Util.notEmpty(obj.getSoustitre())) { %>
            <%= obj.getSoustitre() %>
            <% } %>
    </td>
  </tr>
  <tr class="field imagePrincipale imageEditor  <%= Util.isEmpty(obj.getImagePrincipale()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheActionEducative.class, "imagePrincipale", userLang) %><jalios:edit pub='<%= obj %>' fields='imagePrincipale'/></td>
    <td class='field-data' <%= gfla(obj, "imagePrincipale") %>>
            <% if (Util.notEmpty(obj.getImagePrincipale())) { %>
            <img src='<%= Util.encodeUrl(obj.getImagePrincipale()) %>' alt='' />
            <% } %>
    </td>
  </tr>
  <tr class="field imageCarree imageEditor  <%= Util.isEmpty(obj.getImageCarree()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheActionEducative.class, "imageCarree", userLang) %><jalios:edit pub='<%= obj %>' fields='imageCarree'/></td>
    <td class='field-data' <%= gfla(obj, "imageCarree") %>>
            <% if (Util.notEmpty(obj.getImageCarree())) { %>
            <img src='<%= Util.encodeUrl(obj.getImageCarree()) %>' alt='' />
            <% } %>
    </td>
  </tr>
  <tr class="field imageMobile imageEditor  <%= Util.isEmpty(obj.getImageMobile()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheActionEducative.class, "imageMobile", userLang) %><jalios:edit pub='<%= obj %>' fields='imageMobile'/></td>
    <td class='field-data' <%= gfla(obj, "imageMobile") %>>
            <% if (Util.notEmpty(obj.getImageMobile())) { %>
            <img src='<%= Util.encodeUrl(obj.getImageMobile()) %>' alt='' />
            <% } %>
    </td>
  </tr>
  <tr class="field copyright textfieldEditor  <%= Util.isEmpty(obj.getCopyright()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheActionEducative.class, "copyright", userLang) %><jalios:edit pub='<%= obj %>' fields='copyright'/></td>
    <td class='field-data' <%= gfla(obj, "copyright") %>>
            <% if (Util.notEmpty(obj.getCopyright())) { %>
            <%= obj.getCopyright() %>
            <% } %>
    </td>
  </tr>
  <tr class="field legende textfieldEditor  <%= Util.isEmpty(obj.getLegende()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheActionEducative.class, "legende", userLang) %><jalios:edit pub='<%= obj %>' fields='legende'/></td>
    <td class='field-data' <%= gfla(obj, "legende") %>>
            <% if (Util.notEmpty(obj.getLegende())) { %>
            <%= obj.getLegende() %>
            <% } %>
    </td>
  </tr>
  <tr class="field texteAlternatif textfieldEditor  <%= Util.isEmpty(obj.getTexteAlternatif()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheActionEducative.class, "texteAlternatif", userLang) %><jalios:edit pub='<%= obj %>' fields='texteAlternatif'/></td>
    <td class='field-data' <%= gfla(obj, "texteAlternatif") %>>
            <% if (Util.notEmpty(obj.getTexteAlternatif())) { %>
            <%= obj.getTexteAlternatif() %>
            <% } %>
    </td>
  </tr>
  <tr class="field theme categoryEditor  <%= Util.isEmpty(obj.getTheme(loggedMember)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheActionEducative.class, "theme", userLang) %><jalios:edit pub='<%= obj %>' fields='theme'/></td>
    <td class='field-data' >
            <% if (Util.notEmpty(obj.getTheme(loggedMember))) { %>
            <ol>
            <jalios:foreach collection="<%= obj.getTheme(loggedMember) %>" type="Category" name="itCategory" >
              <li><% if (itCategory != null) { %><a href="<%= ResourceHelper.getQuery() %>?cids=<%= itCategory.getId() %>"><%= itCategory.getAncestorString(channel.getCategory("$jcmsplugin.socle.ficheactioneducative.theme.root"), " > ", true, userLang) %></a><% } %></li>
            </jalios:foreach>
            </ol>
            <% } %>
    </td>
  </tr>
  <tr class="field soustheme categoryEditor  <%= Util.isEmpty(obj.getSoustheme(loggedMember)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheActionEducative.class, "soustheme", userLang) %><jalios:edit pub='<%= obj %>' fields='soustheme'/></td>
    <td class='field-data' >
            <% if (Util.notEmpty(obj.getSoustheme(loggedMember))) { %>
            <ol>
            <jalios:foreach collection="<%= obj.getSoustheme(loggedMember) %>" type="Category" name="itCategory" >
              <li><% if (itCategory != null) { %><a href="<%= ResourceHelper.getQuery() %>?cids=<%= itCategory.getId() %>"><%= itCategory.getAncestorString(channel.getCategory("$jcmsplugin.socle.ficheactioneducative.sousTheme.root"), " > ", true, userLang) %></a><% } %></li>
            </jalios:foreach>
            </ol>
            <% } %>
    </td>
  </tr>
  <tr class="field parcoursEducationNationale categoryEditor  <%= Util.isEmpty(obj.getParcoursEducationNationale(loggedMember)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheActionEducative.class, "parcoursEducationNationale", userLang) %><jalios:edit pub='<%= obj %>' fields='parcoursEducationNationale'/></td>
    <td class='field-data' >
            <% if (Util.notEmpty(obj.getParcoursEducationNationale(loggedMember))) { %>
            <ol>
            <jalios:foreach collection="<%= obj.getParcoursEducationNationale(loggedMember) %>" type="Category" name="itCategory" >
              <li><% if (itCategory != null) { %><a href="<%= ResourceHelper.getQuery() %>?cids=<%= itCategory.getId() %>"><%= itCategory.getAncestorString(channel.getCategory("$jcmsplugin.socle.ficheactioneducative.parcoursEduNationale.root"), " > ", true, userLang) %></a><% } %></li>
            </jalios:foreach>
            </ol>
            <% } %>
    </td>
  </tr>
  <tr class="field monParcoursCollege categoryEditor  <%= Util.isEmpty(obj.getMonParcoursCollege(loggedMember)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheActionEducative.class, "monParcoursCollege", userLang) %><jalios:edit pub='<%= obj %>' fields='monParcoursCollege'/></td>
    <td class='field-data' >
            <% if (Util.notEmpty(obj.getMonParcoursCollege(loggedMember))) { %>
            <ol>
            <jalios:foreach collection="<%= obj.getMonParcoursCollege(loggedMember) %>" type="Category" name="itCategory" >
              <li><% if (itCategory != null) { %><a href="<%= ResourceHelper.getQuery() %>?cids=<%= itCategory.getId() %>"><%= itCategory.getAncestorString(channel.getCategory("$jcmsplugin.socle.ficheactioneducative.monParcoursCollege.root"), " > ", true, userLang) %></a><% } %></li>
            </jalios:foreach>
            </ol>
            <% } %>
    </td>
  </tr>
  <tr class="field typeDePratique categoryEditor  <%= Util.isEmpty(obj.getTypeDePratique(loggedMember)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheActionEducative.class, "typeDePratique", userLang) %><jalios:edit pub='<%= obj %>' fields='typeDePratique'/></td>
    <td class='field-data' >
            <% if (Util.notEmpty(obj.getTypeDePratique(loggedMember))) { %>
            <ol>
            <jalios:foreach collection="<%= obj.getTypeDePratique(loggedMember) %>" type="Category" name="itCategory" >
              <li><% if (itCategory != null) { %><a href="<%= ResourceHelper.getQuery() %>?cids=<%= itCategory.getId() %>"><%= itCategory.getAncestorString(channel.getCategory("$jcmsplugin.socle.ficheactioneducative.typeDePratique.root"), " > ", true, userLang) %></a><% } %></li>
            </jalios:foreach>
            </ol>
            <% } %>
    </td>
  </tr>
  <tr class="field niveau categoryEditor  <%= Util.isEmpty(obj.getNiveau(loggedMember)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheActionEducative.class, "niveau", userLang) %><jalios:edit pub='<%= obj %>' fields='niveau'/></td>
    <td class='field-data' >
            <% if (Util.notEmpty(obj.getNiveau(loggedMember))) { %>
            <ol>
            <jalios:foreach collection="<%= obj.getNiveau(loggedMember) %>" type="Category" name="itCategory" >
              <li><% if (itCategory != null) { %><a href="<%= ResourceHelper.getQuery() %>?cids=<%= itCategory.getId() %>"><%= itCategory.getAncestorString(channel.getCategory("$jcmsplugin.socle.ficheactioneducative.niveau.root"), " > ", true, userLang) %></a><% } %></li>
            </jalios:foreach>
            </ol>
            <% } %>
    </td>
  </tr>
  <tr class="field capaciteDaccueil wysiwygEditor  <%= Util.isEmpty(obj.getCapaciteDaccueil(userLang)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheActionEducative.class, "capaciteDaccueil", userLang) %><jalios:edit pub='<%= obj %>' fields='capaciteDaccueil'/></td>
    <td class='field-data' <%= gfla(obj, "capaciteDaccueil") %>>
            <% if (Util.notEmpty(obj.getCapaciteDaccueil(userLang))) { %>
            <jalios:wysiwyg data='<%= obj %>' field='capaciteDaccueil'><%= obj.getCapaciteDaccueil(userLang) %></jalios:wysiwyg>            
            <% } %>
    </td>
  </tr>
  <tr class="field cout wysiwygEditor  <%= Util.isEmpty(obj.getCout(userLang)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheActionEducative.class, "cout", userLang) %><jalios:edit pub='<%= obj %>' fields='cout'/></td>
    <td class='field-data' <%= gfla(obj, "cout") %>>
            <% if (Util.notEmpty(obj.getCout(userLang))) { %>
            <jalios:wysiwyg data='<%= obj %>' field='cout'><%= obj.getCout(userLang) %></jalios:wysiwyg>            
            <% } %>
    </td>
  </tr>
  <tr class="field priseEnChargeDeplacement booleanEditor  ">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheActionEducative.class, "priseEnChargeDeplacement", userLang) %><jalios:edit pub='<%= obj %>' fields='priseEnChargeDeplacement'/></td>
    <td class='field-data' >
            <%= obj.getPriseEnChargeDeplacementLabel(userLang) %>
    </td>
  </tr>
  <tr class="field duree wysiwygEditor  <%= Util.isEmpty(obj.getDuree(userLang)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheActionEducative.class, "duree", userLang) %><jalios:edit pub='<%= obj %>' fields='duree'/></td>
    <td class='field-data' <%= gfla(obj, "duree") %>>
            <% if (Util.notEmpty(obj.getDuree(userLang))) { %>
            <jalios:wysiwyg data='<%= obj %>' field='duree'><%= obj.getDuree(userLang) %></jalios:wysiwyg>            
            <% } %>
    </td>
  </tr>
  <tr class="field depotDuDossier wysiwygEditor  <%= Util.isEmpty(obj.getDepotDuDossier(userLang)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheActionEducative.class, "depotDuDossier", userLang) %><jalios:edit pub='<%= obj %>' fields='depotDuDossier'/></td>
    <td class='field-data' <%= gfla(obj, "depotDuDossier") %>>
            <% if (Util.notEmpty(obj.getDepotDuDossier(userLang))) { %>
            <jalios:wysiwyg data='<%= obj %>' field='depotDuDossier'><%= obj.getDepotDuDossier(userLang) %></jalios:wysiwyg>            
            <% } %>
    </td>
  </tr>
  <tr class="field realisationDeLaction textfieldEditor  <%= Util.isEmpty(obj.getRealisationDeLaction()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheActionEducative.class, "realisationDeLaction", userLang) %><jalios:edit pub='<%= obj %>' fields='realisationDeLaction'/></td>
    <td class='field-data' <%= gfla(obj, "realisationDeLaction") %>>
            <% if (Util.notEmpty(obj.getRealisationDeLaction())) { %>
            <%= obj.getRealisationDeLaction() %>
            <% } %>
    </td>
  </tr>
  <tr class="field nomEtPrenomContacts textfieldEditor  <%= Util.isEmpty(obj.getNomEtPrenomContacts()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheActionEducative.class, "nomEtPrenomContacts", userLang) %><jalios:edit pub='<%= obj %>' fields='nomEtPrenomContacts'/></td>
    <td class='field-data' <%= gfla(obj, "nomEtPrenomContacts") %>>
            <% if (Util.notEmpty(obj.getNomEtPrenomContacts())) { %>
            <%= obj.getNomEtPrenomContacts() %>
            <% } %>
    </td>
  </tr>
  <tr class="field direction textfieldEditor  <%= Util.isEmpty(obj.getDirection()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheActionEducative.class, "direction", userLang) %><jalios:edit pub='<%= obj %>' fields='direction'/></td>
    <td class='field-data' <%= gfla(obj, "direction") %>>
            <% if (Util.notEmpty(obj.getDirection())) { %>
            <%= obj.getDirection() %>
            <% } %>
    </td>
  </tr>
  <tr class="field service textfieldEditor  <%= Util.isEmpty(obj.getService()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheActionEducative.class, "service", userLang) %><jalios:edit pub='<%= obj %>' fields='service'/></td>
    <td class='field-data' <%= gfla(obj, "service") %>>
            <% if (Util.notEmpty(obj.getService())) { %>
            <%= obj.getService() %>
            <% } %>
    </td>
  </tr>
  <tr class="field ndeVoie textfieldEditor  <%= Util.isEmpty(obj.getNdeVoie()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheActionEducative.class, "ndeVoie", userLang) %><jalios:edit pub='<%= obj %>' fields='ndeVoie'/></td>
    <td class='field-data' <%= gfla(obj, "ndeVoie") %>>
            <% if (Util.notEmpty(obj.getNdeVoie())) { %>
            <%= obj.getNdeVoie() %>
            <% } %>
    </td>
  </tr>
  <tr class="field cs textfieldEditor  <%= Util.isEmpty(obj.getCs()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheActionEducative.class, "cs", userLang) %><jalios:edit pub='<%= obj %>' fields='cs'/></td>
    <td class='field-data' <%= gfla(obj, "cs") %>>
            <% if (Util.notEmpty(obj.getCs())) { %>
            <%= obj.getCs() %>
            <% } %>
    </td>
  </tr>
  <tr class="field codePostal textfieldEditor  <%= Util.isEmpty(obj.getCodePostal()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheActionEducative.class, "codePostal", userLang) %><jalios:edit pub='<%= obj %>' fields='codePostal'/></td>
    <td class='field-data' <%= gfla(obj, "codePostal") %>>
            <% if (Util.notEmpty(obj.getCodePostal())) { %>
            <%= obj.getCodePostal() %>
            <% } %>
    </td>
  </tr>
  <tr class="field commune linkEditor  <%= Util.isEmpty(obj.getCommune()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheActionEducative.class, "commune", userLang) %><jalios:edit pub='<%= obj %>' fields='commune'/></td>
    <td class='field-data' >
            <% if (obj.getCommune() != null && obj.getCommune().canBeReadBy(loggedMember)) { %>
            <jalios:link data='<%= obj.getCommune() %>'/>
            <% } %>
    </td>
  </tr>
  <tr class="field cedex textfieldEditor  <%= Util.isEmpty(obj.getCedex()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheActionEducative.class, "cedex", userLang) %><jalios:edit pub='<%= obj %>' fields='cedex'/></td>
    <td class='field-data' <%= gfla(obj, "cedex") %>>
            <% if (Util.notEmpty(obj.getCedex())) { %>
            <%= obj.getCedex() %>
            <% } %>
    </td>
  </tr>
  <tr class="field telephone textfieldEditor  <%= Util.isEmpty(obj.getTelephone()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheActionEducative.class, "telephone", userLang) %><jalios:edit pub='<%= obj %>' fields='telephone'/></td>
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
  <tr class="field mail emailEditor  <%= Util.isEmpty(obj.getMail()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheActionEducative.class, "mail", userLang) %><jalios:edit pub='<%= obj %>' fields='mail'/></td>
    <td class='field-data' <%= gfla(obj, "mail") %>>
        <% if (Util.notEmpty(obj.getMail())) { %>
            <ol>
            <jalios:foreach name="itString" type="String" array="<%= obj.getMail() %>">
            <% if (Util.notEmpty(itString)) { %>
              <li>
              <a href='mailto:<%= itString %>'><%= itString %></a>
              </li>
            <% } %>
            </jalios:foreach>
            </ol>
        <% } %>
    </td>
  </tr>
  <tr class="field format categoryEditor  <%= Util.isEmpty(obj.getFormat(loggedMember)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheActionEducative.class, "format", userLang) %><jalios:edit pub='<%= obj %>' fields='format'/></td>
    <td class='field-data' >
            <% if (Util.notEmpty(obj.getFormat(loggedMember))) { %>
            <ol>
            <jalios:foreach collection="<%= obj.getFormat(loggedMember) %>" type="Category" name="itCategory" >
              <li><% if (itCategory != null) { %><a href="<%= ResourceHelper.getQuery() %>?cids=<%= itCategory.getId() %>"><%= itCategory.getAncestorString(channel.getCategory("$jcmsplugin.socle.ficheactioneducative.format.root"), " > ", true, userLang) %></a><% } %></li>
            </jalios:foreach>
            </ol>
            <% } %>
    </td>
  </tr>
  <tr class="field chapo wysiwygEditor  <%= Util.isEmpty(obj.getChapo(userLang)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheActionEducative.class, "chapo", userLang) %><jalios:edit pub='<%= obj %>' fields='chapo'/></td>
    <td class='field-data' <%= gfla(obj, "chapo") %>>
            <% if (Util.notEmpty(obj.getChapo(userLang))) { %>
            <jalios:wysiwyg data='<%= obj %>' field='chapo'><%= obj.getChapo(userLang) %></jalios:wysiwyg>            
            <% } %>
    </td>
  </tr>
  <tr class="field description wysiwygEditor  <%= Util.isEmpty(obj.getDescription()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheActionEducative.class, "description", userLang) %><jalios:edit pub='<%= obj %>' fields='description'/></td>
    <td class='field-data' <%= gfla(obj, "description") %>>
            <% if (Util.notEmpty(obj.getDescription())) { %>
            <jalios:wysiwyg data='<%= obj %>' field='description'><%= obj.getDescription() %></jalios:wysiwyg>            
            <% } %>
    </td>
  </tr>
  <tr class="field publicVise wysiwygEditor  <%= Util.isEmpty(obj.getPublicVise()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheActionEducative.class, "publicVise", userLang) %><jalios:edit pub='<%= obj %>' fields='publicVise'/></td>
    <td class='field-data' <%= gfla(obj, "publicVise") %>>
            <% if (Util.notEmpty(obj.getPublicVise())) { %>
            <jalios:wysiwyg data='<%= obj %>' field='publicVise'><%= obj.getPublicVise() %></jalios:wysiwyg>            
            <% } %>
    </td>
  </tr>
  <tr class="field calendrierEtInscription wysiwygEditor  <%= Util.isEmpty(obj.getCalendrierEtInscription()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheActionEducative.class, "calendrierEtInscription", userLang) %><jalios:edit pub='<%= obj %>' fields='calendrierEtInscription'/></td>
    <td class='field-data' <%= gfla(obj, "calendrierEtInscription") %>>
            <% if (Util.notEmpty(obj.getCalendrierEtInscription())) { %>
            <jalios:wysiwyg data='<%= obj %>' field='calendrierEtInscription'><%= obj.getCalendrierEtInscription() %></jalios:wysiwyg>            
            <% } %>
    </td>
  </tr>
  <tr class="field titreInscription textfieldEditor  <%= Util.isEmpty(obj.getTitreInscription()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheActionEducative.class, "titreInscription", userLang) %><jalios:edit pub='<%= obj %>' fields='titreInscription'/></td>
    <td class='field-data' <%= gfla(obj, "titreInscription") %>>
            <% if (Util.notEmpty(obj.getTitreInscription())) { %>
            <%= obj.getTitreInscription() %>
            <% } %>
    </td>
  </tr>
  <tr class="field commentaireInscription wysiwygEditor  <%= Util.isEmpty(obj.getCommentaireInscription()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheActionEducative.class, "commentaireInscription", userLang) %><jalios:edit pub='<%= obj %>' fields='commentaireInscription'/></td>
    <td class='field-data' <%= gfla(obj, "commentaireInscription") %>>
            <% if (Util.notEmpty(obj.getCommentaireInscription())) { %>
            <jalios:wysiwyg data='<%= obj %>' field='commentaireInscription'><%= obj.getCommentaireInscription() %></jalios:wysiwyg>            
            <% } %>
    </td>
  </tr>
  <tr class="field urlInscription urlEditor  <%= Util.isEmpty(obj.getUrlInscription()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheActionEducative.class, "urlInscription", userLang) %><jalios:edit pub='<%= obj %>' fields='urlInscription'/></td>
    <td class='field-data' <%= gfla(obj, "urlInscription") %>>
            <% if (Util.notEmpty(obj.getUrlInscription())) { %>
            <a href='<%= obj.getUrlInscription() %>' ><%= obj.getUrlInscription()%></a>
            <% } %>
    </td>
  </tr>
  <tr class="field titreSuivreUneDemande textfieldEditor  <%= Util.isEmpty(obj.getTitreSuivreUneDemande()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheActionEducative.class, "titreSuivreUneDemande", userLang) %><jalios:edit pub='<%= obj %>' fields='titreSuivreUneDemande'/></td>
    <td class='field-data' <%= gfla(obj, "titreSuivreUneDemande") %>>
            <% if (Util.notEmpty(obj.getTitreSuivreUneDemande())) { %>
            <%= obj.getTitreSuivreUneDemande() %>
            <% } %>
    </td>
  </tr>
  <tr class="field commentaireSuivreUneDemande wysiwygEditor  <%= Util.isEmpty(obj.getCommentaireSuivreUneDemande()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheActionEducative.class, "commentaireSuivreUneDemande", userLang) %><jalios:edit pub='<%= obj %>' fields='commentaireSuivreUneDemande'/></td>
    <td class='field-data' <%= gfla(obj, "commentaireSuivreUneDemande") %>>
            <% if (Util.notEmpty(obj.getCommentaireSuivreUneDemande())) { %>
            <jalios:wysiwyg data='<%= obj %>' field='commentaireSuivreUneDemande'><%= obj.getCommentaireSuivreUneDemande() %></jalios:wysiwyg>            
            <% } %>
    </td>
  </tr>
  <tr class="field urlSuivreUneDemande urlEditor  <%= Util.isEmpty(obj.getUrlSuivreUneDemande()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheActionEducative.class, "urlSuivreUneDemande", userLang) %><jalios:edit pub='<%= obj %>' fields='urlSuivreUneDemande'/></td>
    <td class='field-data' <%= gfla(obj, "urlSuivreUneDemande") %>>
            <% if (Util.notEmpty(obj.getUrlSuivreUneDemande())) { %>
            <a href='<%= obj.getUrlSuivreUneDemande() %>' ><%= obj.getUrlSuivreUneDemande()%></a>
            <% } %>
    </td>
  </tr>
  <tr class="field complementTransport wysiwygEditor  <%= Util.isEmpty(obj.getComplementTransport()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheActionEducative.class, "complementTransport", userLang) %><jalios:edit pub='<%= obj %>' fields='complementTransport'/></td>
    <td class='field-data' <%= gfla(obj, "complementTransport") %>>
            <% if (Util.notEmpty(obj.getComplementTransport())) { %>
            <jalios:wysiwyg data='<%= obj %>' field='complementTransport'><%= obj.getComplementTransport() %></jalios:wysiwyg>            
            <% } %>
    </td>
  </tr>
  <tr class="field partenairesIntervenants wysiwygEditor  <%= Util.isEmpty(obj.getPartenairesIntervenants()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheActionEducative.class, "partenairesIntervenants", userLang) %><jalios:edit pub='<%= obj %>' fields='partenairesIntervenants'/></td>
    <td class='field-data' <%= gfla(obj, "partenairesIntervenants") %>>
            <% if (Util.notEmpty(obj.getPartenairesIntervenants())) { %>
            <jalios:wysiwyg data='<%= obj %>' field='partenairesIntervenants'><%= obj.getPartenairesIntervenants() %></jalios:wysiwyg>            
            <% } %>
    </td>
  </tr>
  <tr class="field titreVideo textfieldEditor  <%= Util.isEmpty(obj.getTitreVideo()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheActionEducative.class, "titreVideo", userLang) %><jalios:edit pub='<%= obj %>' fields='titreVideo'/></td>
    <td class='field-data' <%= gfla(obj, "titreVideo") %>>
            <% if (Util.notEmpty(obj.getTitreVideo())) { %>
            <%= obj.getTitreVideo() %>
            <% } %>
    </td>
  </tr>
  <tr class="field video linkEditor  <%= Util.isEmpty(obj.getVideo()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheActionEducative.class, "video", userLang) %><jalios:edit pub='<%= obj %>' fields='video'/></td>
    <td class='field-data' >
            <% if (obj.getVideo() != null && obj.getVideo().canBeReadBy(loggedMember)) { %>
            <jalios:link data='<%= obj.getVideo() %>'/>
            <% } %>
    </td>
  </tr>
  <tr class="field titreEncartDocumentBlocN1 textfieldEditor  <%= Util.isEmpty(obj.getTitreEncartDocumentBlocN1()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheActionEducative.class, "titreEncartDocumentBlocN1", userLang) %><jalios:edit pub='<%= obj %>' fields='titreEncartDocumentBlocN1'/></td>
    <td class='field-data' <%= gfla(obj, "titreEncartDocumentBlocN1") %>>
            <% if (Util.notEmpty(obj.getTitreEncartDocumentBlocN1())) { %>
            <%= obj.getTitreEncartDocumentBlocN1() %>
            <% } %>
    </td>
  </tr>
  <tr class="field documentsJointsBlocN1 linkEditor  <%= Util.isEmpty(obj.getDocumentsJointsBlocN1()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheActionEducative.class, "documentsJointsBlocN1", userLang) %><jalios:edit pub='<%= obj %>' fields='documentsJointsBlocN1'/></td>
    <td class='field-data' >
            <% if (Util.notEmpty(obj.getDocumentsJointsBlocN1())) { %>
            <ol>
              <jalios:foreach name="itData" type="com.jalios.jcms.FileDocument" array="<%= obj.getDocumentsJointsBlocN1() %>">
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
  <tr class="field titreEncartDocumentBlocN2 textfieldEditor  <%= Util.isEmpty(obj.getTitreEncartDocumentBlocN2()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheActionEducative.class, "titreEncartDocumentBlocN2", userLang) %><jalios:edit pub='<%= obj %>' fields='titreEncartDocumentBlocN2'/></td>
    <td class='field-data' <%= gfla(obj, "titreEncartDocumentBlocN2") %>>
            <% if (Util.notEmpty(obj.getTitreEncartDocumentBlocN2())) { %>
            <%= obj.getTitreEncartDocumentBlocN2() %>
            <% } %>
    </td>
  </tr>
  <tr class="field documentsJointsBlocN2 linkEditor  <%= Util.isEmpty(obj.getDocumentsJointsBlocN2()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheActionEducative.class, "documentsJointsBlocN2", userLang) %><jalios:edit pub='<%= obj %>' fields='documentsJointsBlocN2'/></td>
    <td class='field-data' >
            <% if (Util.notEmpty(obj.getDocumentsJointsBlocN2())) { %>
            <ol>
              <jalios:foreach name="itData" type="com.jalios.jcms.FileDocument" array="<%= obj.getDocumentsJointsBlocN2() %>">
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
  <tr class="field titreEncartDocumentBlocN3 textfieldEditor  <%= Util.isEmpty(obj.getTitreEncartDocumentBlocN3()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheActionEducative.class, "titreEncartDocumentBlocN3", userLang) %><jalios:edit pub='<%= obj %>' fields='titreEncartDocumentBlocN3'/></td>
    <td class='field-data' <%= gfla(obj, "titreEncartDocumentBlocN3") %>>
            <% if (Util.notEmpty(obj.getTitreEncartDocumentBlocN3())) { %>
            <%= obj.getTitreEncartDocumentBlocN3() %>
            <% } %>
    </td>
  </tr>
  <tr class="field documentsJointsBlocN3 linkEditor  <%= Util.isEmpty(obj.getDocumentsJointsBlocN3()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheActionEducative.class, "documentsJointsBlocN3", userLang) %><jalios:edit pub='<%= obj %>' fields='documentsJointsBlocN3'/></td>
    <td class='field-data' >
            <% if (Util.notEmpty(obj.getDocumentsJointsBlocN3())) { %>
            <ol>
              <jalios:foreach name="itData" type="com.jalios.jcms.FileDocument" array="<%= obj.getDocumentsJointsBlocN3() %>">
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
  <tr class="field titreEncartSiteInternet textfieldEditor  <%= Util.isEmpty(obj.getTitreEncartSiteInternet()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheActionEducative.class, "titreEncartSiteInternet", userLang) %><jalios:edit pub='<%= obj %>' fields='titreEncartSiteInternet'/></td>
    <td class='field-data' <%= gfla(obj, "titreEncartSiteInternet") %>>
            <% if (Util.notEmpty(obj.getTitreEncartSiteInternet())) { %>
            <%= obj.getTitreEncartSiteInternet() %>
            <% } %>
    </td>
  </tr>
  <tr class="field nomDuSite textfieldEditor  <%= Util.isEmpty(obj.getNomDuSite()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheActionEducative.class, "nomDuSite", userLang) %><jalios:edit pub='<%= obj %>' fields='nomDuSite'/></td>
    <td class='field-data' <%= gfla(obj, "nomDuSite") %>>
        <% if (Util.notEmpty(obj.getNomDuSite())) { %>
            <ol>
            <jalios:foreach name="itString" type="String" array="<%= obj.getNomDuSite() %>">
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
  <tr class="field adresseSiteInternet urlEditor  <%= Util.isEmpty(obj.getAdresseSiteInternet()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheActionEducative.class, "adresseSiteInternet", userLang) %><jalios:edit pub='<%= obj %>' fields='adresseSiteInternet'/></td>
    <td class='field-data' <%= gfla(obj, "adresseSiteInternet") %>>
        <% if (Util.notEmpty(obj.getAdresseSiteInternet())) { %>
            <ol>
            <jalios:foreach name="itString" type="String" array="<%= obj.getAdresseSiteInternet() %>">
            <% if (Util.notEmpty(itString)) { %>
              <li>
              <a href='<%= itString %>'><%= itString %></a>
              </li>
            <% } %>
            </jalios:foreach>
            </ol>
        <% } %>
    </td>
  </tr>
  <tr class="field categorieDeNavigation categoryEditor  <%= Util.isEmpty(obj.getCategorieDeNavigation(loggedMember)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheActionEducative.class, "categorieDeNavigation", userLang) %><jalios:edit pub='<%= obj %>' fields='categorieDeNavigation'/></td>
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
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheActionEducative.class, "miseEnAvant", userLang) %><jalios:edit pub='<%= obj %>' fields='miseEnAvant'/></td>
    <td class='field-data' >
            <% if (Util.notEmpty(obj.getMiseEnAvant(loggedMember))) { %>
            <ol>
            <jalios:foreach collection="<%= obj.getMiseEnAvant(loggedMember) %>" type="Category" name="itCategory" >
              <li><% if (itCategory != null) { %><a href="<%= ResourceHelper.getQuery() %>?cids=<%= itCategory.getId() %>"><%= itCategory.getAncestorString(channel.getCategory("$jcmsplugin.socle.accueilannuaireagenda.miseEnAvant.root"), " > ", true, userLang) %></a><% } %></li>
            </jalios:foreach>
            </ol>
            <% } %>
    </td>
  </tr>
 
</table>
<jsp:include page="/front/doFullDisplayCommonFields.jsp" />
</div><%-- **********4A616C696F73204A434D53 *** SIGNATURE BOUNDARY * DO NOT EDIT ANYTHING BELOW THIS LINE *** --%><%
%><%-- JpmId0dkhNPtWOI7ZmzmFg== --%>