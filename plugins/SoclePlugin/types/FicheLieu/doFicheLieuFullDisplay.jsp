<%@ page contentType="text/html; charset=UTF-8" %><%
%><%@ include file='/jcore/doInitPage.jspf' %><%
%><% FicheLieu obj = (FicheLieu)request.getAttribute(PortalManager.PORTAL_PUBLICATION); %><%
%><%@ include file='/front/doFullDisplay.jspf' %>
<div class="fullDisplay FicheLieu <%= obj.canBeEditedFieldByField(loggedMember) ? "unitFieldEdition" : "" %>" itemscope="itemscope">
<%@ include file='/front/publication/doPublicationHeader.jspf' %>
<table class="fields">
  <tr class="field idReferentiel textfieldEditor  <%= Util.isEmpty(obj.getIdReferentiel(userLang)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheLieu.class, "idReferentiel", userLang) %><jalios:edit pub='<%= obj %>' fields='idReferentiel'/></td>
    <td class='field-data' <%= gfla(obj, "idReferentiel") %>>
            <% if (Util.notEmpty(obj.getIdReferentiel(userLang))) { %>
            <%= obj.getIdReferentiel(userLang) %>
            <% } %>
    </td>
  </tr>
  <tr class="field soustitre textfieldEditor  <%= Util.isEmpty(obj.getSoustitre(userLang)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheLieu.class, "soustitre", userLang) %><jalios:edit pub='<%= obj %>' fields='soustitre'/></td>
    <td class='field-data' <%= gfla(obj, "soustitre") %>>
            <% if (Util.notEmpty(obj.getSoustitre(userLang))) { %>
            <%= obj.getSoustitre(userLang) %>
            <% } %>
    </td>
  </tr>
  <tr class="field serviceDuDepartement enumerateEditor  <%= Util.isEmpty(obj.getServiceDuDepartement()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheLieu.class, "serviceDuDepartement", userLang) %><jalios:edit pub='<%= obj %>' fields='serviceDuDepartement'/></td>
    <td class='field-data' <%= gfla(obj, "serviceDuDepartement") %>>
            <% if (Util.notEmpty(obj.getServiceDuDepartement())) { %>
            <%= obj.getServiceDuDepartementLabel(obj.getServiceDuDepartement(), userLang) %>
            <% } %>
    </td>
  </tr>
  <tr class="field typeDeLieu categoryEditor  <%= Util.isEmpty(obj.getTypeDeLieu(loggedMember)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheLieu.class, "typeDeLieu", userLang) %><jalios:edit pub='<%= obj %>' fields='typeDeLieu'/></td>
    <td class='field-data' >
            <% if (Util.notEmpty(obj.getTypeDeLieu(loggedMember))) { %>
            <ol>
            <jalios:foreach collection="<%= obj.getTypeDeLieu(loggedMember) %>" type="Category" name="itCategory" >
              <li><% if (itCategory != null) { %><a href="<%= ResourceHelper.getQuery() %>?cids=<%= itCategory.getId() %>"><%= itCategory.getAncestorString(channel.getCategory("$jcmsplugin.socle.fichelieu.typeLieu.root"), " > ", true, userLang) %></a><% } %></li>
            </jalios:foreach>
            </ol>
            <% } %>
    </td>
  </tr>
  <tr class="field imagePrincipale imageEditor  <%= Util.isEmpty(obj.getImagePrincipale(userLang)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheLieu.class, "imagePrincipale", userLang) %><jalios:edit pub='<%= obj %>' fields='imagePrincipale'/></td>
    <td class='field-data' <%= gfla(obj, "imagePrincipale") %>>
            <% if (Util.notEmpty(obj.getImagePrincipale(userLang))) { %>
            <img src='<%= Util.encodeUrl(obj.getImagePrincipale(userLang)) %>' alt='' />
            <% } %>
    </td>
  </tr>
  <tr class="field copyright textfieldEditor  <%= Util.isEmpty(obj.getCopyright(userLang)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheLieu.class, "copyright", userLang) %><jalios:edit pub='<%= obj %>' fields='copyright'/></td>
    <td class='field-data' <%= gfla(obj, "copyright") %>>
            <% if (Util.notEmpty(obj.getCopyright(userLang))) { %>
            <%= obj.getCopyright(userLang) %>
            <% } %>
    </td>
  </tr>
  <tr class="field legende textfieldEditor  <%= Util.isEmpty(obj.getLegende(userLang)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheLieu.class, "legende", userLang) %><jalios:edit pub='<%= obj %>' fields='legende'/></td>
    <td class='field-data' <%= gfla(obj, "legende") %>>
            <% if (Util.notEmpty(obj.getLegende(userLang))) { %>
            <%= obj.getLegende(userLang) %>
            <% } %>
    </td>
  </tr>
  <tr class="field texteAlternatif textfieldEditor  <%= Util.isEmpty(obj.getTexteAlternatif(userLang)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheLieu.class, "texteAlternatif", userLang) %><jalios:edit pub='<%= obj %>' fields='texteAlternatif'/></td>
    <td class='field-data' <%= gfla(obj, "texteAlternatif") %>>
            <% if (Util.notEmpty(obj.getTexteAlternatif(userLang))) { %>
            <%= obj.getTexteAlternatif(userLang) %>
            <% } %>
    </td>
  </tr>
  <tr class="field enBref textareaEditor  <%= Util.isEmpty(obj.getEnBref(userLang)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheLieu.class, "enBref", userLang) %><jalios:edit pub='<%= obj %>' fields='enBref'/></td>
    <td class='field-data' <%= gfla(obj, "enBref") %>>
            <% if (Util.notEmpty(obj.getEnBref(userLang))) { %>
            <%= obj.getEnBref(userLang) %>
            <% } %>
    </td>
  </tr>
  <tr class="field plusDeDetailInterne linkEditor  <%= Util.isEmpty(obj.getPlusDeDetailInterne()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheLieu.class, "plusDeDetailInterne", userLang) %><jalios:edit pub='<%= obj %>' fields='plusDeDetailInterne'/></td>
    <td class='field-data' >
            <% if (obj.getPlusDeDetailInterne() != null && obj.getPlusDeDetailInterne().canBeReadBy(loggedMember)) { %>
            <jalios:link data='<%= obj.getPlusDeDetailInterne() %>'/>
            <% } %>
    </td>
  </tr>
  <tr class="field plusDeDetailExterne urlEditor  <%= Util.isEmpty(obj.getPlusDeDetailExterne(userLang)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheLieu.class, "plusDeDetailExterne", userLang) %><jalios:edit pub='<%= obj %>' fields='plusDeDetailExterne'/></td>
    <td class='field-data' <%= gfla(obj, "plusDeDetailExterne") %>>
            <% if (Util.notEmpty(obj.getPlusDeDetailExterne(userLang))) { %>
            <a href='<%= obj.getPlusDeDetailExterne(userLang) %>' ><%= obj.getPlusDeDetailExterne(userLang)%></a>
            <% } %>
    </td>
  </tr>
  <tr class="field etageCouloirEscalier textfieldEditor  <%= Util.isEmpty(obj.getEtageCouloirEscalier(userLang)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheLieu.class, "etageCouloirEscalier", userLang) %><jalios:edit pub='<%= obj %>' fields='etageCouloirEscalier'/></td>
    <td class='field-data' <%= gfla(obj, "etageCouloirEscalier") %>>
            <% if (Util.notEmpty(obj.getEtageCouloirEscalier(userLang))) { %>
            <%= obj.getEtageCouloirEscalier(userLang) %>
            <% } %>
    </td>
  </tr>
  <tr class="field entreeBatimentImmeuble textfieldEditor  <%= Util.isEmpty(obj.getEntreeBatimentImmeuble(userLang)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheLieu.class, "entreeBatimentImmeuble", userLang) %><jalios:edit pub='<%= obj %>' fields='entreeBatimentImmeuble'/></td>
    <td class='field-data' <%= gfla(obj, "entreeBatimentImmeuble") %>>
            <% if (Util.notEmpty(obj.getEntreeBatimentImmeuble(userLang))) { %>
            <%= obj.getEntreeBatimentImmeuble(userLang) %>
            <% } %>
    </td>
  </tr>
  <tr class="field ndeVoie textfieldEditor  <%= Util.isEmpty(obj.getNdeVoie(userLang)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheLieu.class, "ndeVoie", userLang) %><jalios:edit pub='<%= obj %>' fields='ndeVoie'/></td>
    <td class='field-data' <%= gfla(obj, "ndeVoie") %>>
            <% if (Util.notEmpty(obj.getNdeVoie(userLang))) { %>
            <%= obj.getNdeVoie(userLang) %>
            <% } %>
    </td>
  </tr>
  <tr class="field libelleDeVoie textfieldEditor  <%= Util.isEmpty(obj.getLibelleDeVoie(userLang)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheLieu.class, "libelleDeVoie", userLang) %><jalios:edit pub='<%= obj %>' fields='libelleDeVoie'/></td>
    <td class='field-data' <%= gfla(obj, "libelleDeVoie") %>>
            <% if (Util.notEmpty(obj.getLibelleDeVoie(userLang))) { %>
            <%= obj.getLibelleDeVoie(userLang) %>
            <% } %>
    </td>
  </tr>
  <tr class="field lieudit textfieldEditor  <%= Util.isEmpty(obj.getLieudit(userLang)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheLieu.class, "lieudit", userLang) %><jalios:edit pub='<%= obj %>' fields='lieudit'/></td>
    <td class='field-data' <%= gfla(obj, "lieudit") %>>
            <% if (Util.notEmpty(obj.getLieudit(userLang))) { %>
            <%= obj.getLieudit(userLang) %>
            <% } %>
    </td>
  </tr>
  <tr class="field codePostal textfieldEditor  <%= Util.isEmpty(obj.getCodePostal(userLang)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheLieu.class, "codePostal", userLang) %><jalios:edit pub='<%= obj %>' fields='codePostal'/></td>
    <td class='field-data' <%= gfla(obj, "codePostal") %>>
            <% if (Util.notEmpty(obj.getCodePostal(userLang))) { %>
            <%= obj.getCodePostal(userLang) %>
            <% } %>
    </td>
  </tr>
  <tr class="field planDacces linkEditor  <%= Util.isEmpty(obj.getPlanDacces(userLang)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheLieu.class, "planDacces", userLang) %><jalios:edit pub='<%= obj %>' fields='planDacces'/></td>
    <td class='field-data' >
            <% if (Util.notEmpty(obj.getPlanDacces(userLang))) { %>
            <ol>
              <jalios:foreach name="itData" type="com.jalios.jcms.FileDocument" array="<%= obj.getPlanDacces(userLang) %>">
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
  <tr class="field libelleAutreAdresse textfieldEditor  <%= Util.isEmpty(obj.getLibelleAutreAdresse(userLang)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheLieu.class, "libelleAutreAdresse", userLang) %><jalios:edit pub='<%= obj %>' fields='libelleAutreAdresse'/></td>
    <td class='field-data' <%= gfla(obj, "libelleAutreAdresse") %>>
            <% if (Util.notEmpty(obj.getLibelleAutreAdresse(userLang))) { %>
            <%= obj.getLibelleAutreAdresse(userLang) %>
            <% } %>
    </td>
  </tr>
  <tr class="field cs textfieldEditor  <%= Util.isEmpty(obj.getCs(userLang)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheLieu.class, "cs", userLang) %><jalios:edit pub='<%= obj %>' fields='cs'/></td>
    <td class='field-data' <%= gfla(obj, "cs") %>>
            <% if (Util.notEmpty(obj.getCs(userLang))) { %>
            <%= obj.getCs(userLang) %>
            <% } %>
    </td>
  </tr>
  <tr class="field cedex textfieldEditor  <%= Util.isEmpty(obj.getCedex(userLang)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheLieu.class, "cedex", userLang) %><jalios:edit pub='<%= obj %>' fields='cedex'/></td>
    <td class='field-data' <%= gfla(obj, "cedex") %>>
            <% if (Util.notEmpty(obj.getCedex(userLang))) { %>
            <%= obj.getCedex(userLang) %>
            <% } %>
    </td>
  </tr>
  <tr class="field telephone textfieldEditor  <%= Util.isEmpty(obj.getTelephone(userLang)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheLieu.class, "telephone", userLang) %><jalios:edit pub='<%= obj %>' fields='telephone'/></td>
    <td class='field-data' <%= gfla(obj, "telephone") %>>
        <% if (Util.notEmpty(obj.getTelephone(userLang))) { %>
            <ol>
            <jalios:foreach name="itString" type="String" array="<%= obj.getTelephone(userLang) %>">
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
  <tr class="field email emailEditor  <%= Util.isEmpty(obj.getEmail(userLang)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheLieu.class, "email", userLang) %><jalios:edit pub='<%= obj %>' fields='email'/></td>
    <td class='field-data' <%= gfla(obj, "email") %>>
        <% if (Util.notEmpty(obj.getEmail(userLang))) { %>
            <ol>
            <jalios:foreach name="itString" type="String" array="<%= obj.getEmail(userLang) %>">
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
  <tr class="field siteInternet urlEditor  <%= Util.isEmpty(obj.getSiteInternet(userLang)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheLieu.class, "siteInternet", userLang) %><jalios:edit pub='<%= obj %>' fields='siteInternet'/></td>
    <td class='field-data' <%= gfla(obj, "siteInternet") %>>
        <% if (Util.notEmpty(obj.getSiteInternet(userLang))) { %>
            <ol>
            <jalios:foreach name="itString" type="String" array="<%= obj.getSiteInternet(userLang) %>">
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
  <tr class="field communes linkEditor  <%= Util.isEmpty(obj.getCommunes()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheLieu.class, "communes", userLang) %><jalios:edit pub='<%= obj %>' fields='communes'/></td>
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
  <tr class="field autresLieuxAssocies linkEditor  <%= Util.isEmpty(obj.getAutresLieuxAssocies()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheLieu.class, "autresLieuxAssocies", userLang) %><jalios:edit pub='<%= obj %>' fields='autresLieuxAssocies'/></td>
    <td class='field-data' >
            <% if (Util.notEmpty(obj.getAutresLieuxAssocies())) { %>
            <ol>
              <jalios:foreach name="itData" type="generated.FicheLieu" array="<%= obj.getAutresLieuxAssocies() %>">
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
  <tr class="field besoins categoryEditor  <%= Util.isEmpty(obj.getBesoins(loggedMember)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheLieu.class, "besoins", userLang) %><jalios:edit pub='<%= obj %>' fields='besoins'/></td>
    <td class='field-data' >
            <% if (Util.notEmpty(obj.getBesoins(loggedMember))) { %>
            <ol>
            <jalios:foreach collection="<%= obj.getBesoins(loggedMember) %>" type="Category" name="itCategory" >
              <li><% if (itCategory != null) { %><a href="<%= ResourceHelper.getQuery() %>?cids=<%= itCategory.getId() %>"><%= itCategory.getAncestorString(channel.getCategory("$jcmsplugin.socle.fichelieu.besoins.root"), " > ", true, userLang) %></a><% } %></li>
            </jalios:foreach>
            </ol>
            <% } %>
    </td>
  </tr>
  <tr class="field delegations categoryEditor  <%= Util.isEmpty(obj.getDelegations(loggedMember)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheLieu.class, "delegations", userLang) %><jalios:edit pub='<%= obj %>' fields='delegations'/></td>
    <td class='field-data' >
            <% if (Util.notEmpty(obj.getDelegations(loggedMember))) { %>
            <ol>
            <jalios:foreach collection="<%= obj.getDelegations(loggedMember) %>" type="Category" name="itCategory" >
              <li><% if (itCategory != null) { %><a href="<%= ResourceHelper.getQuery() %>?cids=<%= itCategory.getId() %>"><%= itCategory.getAncestorString(channel.getCategory("$jcmsplugin.socle.fichelieu.delegations.root"), " > ", true, userLang) %></a><% } %></li>
            </jalios:foreach>
            </ol>
            <% } %>
    </td>
  </tr>
  <tr class="field communesDintervention linkEditor  <%= Util.isEmpty(obj.getCommunesDintervention()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheLieu.class, "communesDintervention", userLang) %><jalios:edit pub='<%= obj %>' fields='communesDintervention'/></td>
    <td class='field-data' >
            <% if (Util.notEmpty(obj.getCommunesDintervention())) { %>
            <ol>
              <jalios:foreach name="itData" type="generated.City" array="<%= obj.getCommunesDintervention() %>">
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
  <tr class="field toutesLesCommunesDuDepartement enumerateEditor  <%= Util.isEmpty(obj.getToutesLesCommunesDuDepartement()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheLieu.class, "toutesLesCommunesDuDepartement", userLang) %><jalios:edit pub='<%= obj %>' fields='toutesLesCommunesDuDepartement'/></td>
    <td class='field-data' <%= gfla(obj, "toutesLesCommunesDuDepartement") %>>
            <% if (Util.notEmpty(obj.getToutesLesCommunesDuDepartement())) { %>
            <%= obj.getToutesLesCommunesDuDepartementLabel(obj.getToutesLesCommunesDuDepartement(), userLang) %>
            <% } %>
    </td>
  </tr>
  <tr class="field toutesLesCommunesEPCI categoryEditor  <%= Util.isEmpty(obj.getToutesLesCommunesEPCI(loggedMember)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheLieu.class, "toutesLesCommunesEPCI", userLang) %><jalios:edit pub='<%= obj %>' fields='toutesLesCommunesEPCI'/></td>
    <td class='field-data' >
            <% if (Util.notEmpty(obj.getToutesLesCommunesEPCI(loggedMember))) { %>
            <ol>
            <jalios:foreach collection="<%= obj.getToutesLesCommunesEPCI(loggedMember) %>" type="Category" name="itCategory" >
              <li><% if (itCategory != null) { %><a href="<%= ResourceHelper.getQuery() %>?cids=<%= itCategory.getId() %>"><%= itCategory.getAncestorString(channel.getCategory("$jcmsplugin.socle.fichelieu.toutesLesCommunesEPCI.root"), " > ", true, userLang) %></a><% } %></li>
            </jalios:foreach>
            </ol>
            <% } %>
    </td>
  </tr>
  <tr class="field canton linkEditor  <%= Util.isEmpty(obj.getCanton()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheLieu.class, "canton", userLang) %><jalios:edit pub='<%= obj %>' fields='canton'/></td>
    <td class='field-data' >
            <% if (obj.getCanton() != null && obj.getCanton().canBeReadBy(loggedMember)) { %>
            <jalios:link data='<%= obj.getCanton() %>'/>
            <% } %>
    </td>
  </tr>
  <tr class="field typeDacces enumerateEditor  <%= Util.isEmpty(obj.getTypeDacces()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheLieu.class, "typeDacces", userLang) %><jalios:edit pub='<%= obj %>' fields='typeDacces'/></td>
    <td class='field-data' <%= gfla(obj, "typeDacces") %>>
        <% if (Util.notEmpty(obj.getTypeDacces())) { %>
            <ol>
            <jalios:foreach name="itString" type="String" array="<%= obj.getTypeDacces() %>">
            <% if (Util.notEmpty(itString)) { %>
              <li>
            <%= obj.getTypeDaccesLabel(itString, userLang) %>
              </li>
            <% } %>
            </jalios:foreach>
            </ol>
        <% } %>
    </td>
  </tr>
  <tr class="field complementTypeDacces textfieldEditor  <%= Util.isEmpty(obj.getComplementTypeDacces(userLang)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheLieu.class, "complementTypeDacces", userLang) %><jalios:edit pub='<%= obj %>' fields='complementTypeDacces'/></td>
    <td class='field-data' <%= gfla(obj, "complementTypeDacces") %>>
            <% if (Util.notEmpty(obj.getComplementTypeDacces(userLang))) { %>
            <%= obj.getComplementTypeDacces(userLang) %>
            <% } %>
    </td>
  </tr>
  <tr class="field pourQui wysiwygEditor  <%= Util.isEmpty(obj.getPourQui(userLang)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheLieu.class, "pourQui", userLang) %><jalios:edit pub='<%= obj %>' fields='pourQui'/></td>
    <td class='field-data' <%= gfla(obj, "pourQui") %>>
            <% if (Util.notEmpty(obj.getPourQui(userLang))) { %>
            <jalios:wysiwyg data='<%= obj %>' field='pourQui'><%= obj.getPourQui(userLang) %></jalios:wysiwyg>            
            <% } %>
    </td>
  </tr>
  <tr class="field publicVise categoryEditor  <%= Util.isEmpty(obj.getPublicVise(loggedMember)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheLieu.class, "publicVise", userLang) %><jalios:edit pub='<%= obj %>' fields='publicVise'/></td>
    <td class='field-data' >
            <% if (Util.notEmpty(obj.getPublicVise(loggedMember))) { %>
            <ol>
            <jalios:foreach collection="<%= obj.getPublicVise(loggedMember) %>" type="Category" name="itCategory" >
              <li><% if (itCategory != null) { %><a href="<%= ResourceHelper.getQuery() %>?cids=<%= itCategory.getId() %>"><%= itCategory.getAncestorString(channel.getCategory("$jcmsplugin.socle.fichelieu.publicVise.root"), " > ", true, userLang) %></a><% } %></li>
            </jalios:foreach>
            </ol>
            <% } %>
    </td>
  </tr>
  <tr class="field modalitesDaccueil wysiwygEditor  <%= Util.isEmpty(obj.getModalitesDaccueil(userLang)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheLieu.class, "modalitesDaccueil", userLang) %><jalios:edit pub='<%= obj %>' fields='modalitesDaccueil'/></td>
    <td class='field-data' <%= gfla(obj, "modalitesDaccueil") %>>
            <% if (Util.notEmpty(obj.getModalitesDaccueil(userLang))) { %>
            <jalios:wysiwyg data='<%= obj %>' field='modalitesDaccueil'><%= obj.getModalitesDaccueil(userLang) %></jalios:wysiwyg>            
            <% } %>
    </td>
  </tr>
  <tr class="field horairesEtAcces wysiwygEditor  <%= Util.isEmpty(obj.getHorairesEtAcces(userLang)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheLieu.class, "horairesEtAcces", userLang) %><jalios:edit pub='<%= obj %>' fields='horairesEtAcces'/></td>
    <td class='field-data' <%= gfla(obj, "horairesEtAcces") %>>
            <% if (Util.notEmpty(obj.getHorairesEtAcces(userLang))) { %>
            <jalios:wysiwyg data='<%= obj %>' field='horairesEtAcces'><%= obj.getHorairesEtAcces(userLang) %></jalios:wysiwyg>            
            <% } %>
    </td>
  </tr>
  <tr class="field transportsEnCommun wysiwygEditor  <%= Util.isEmpty(obj.getTransportsEnCommun(userLang)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheLieu.class, "transportsEnCommun", userLang) %><jalios:edit pub='<%= obj %>' fields='transportsEnCommun'/></td>
    <td class='field-data' <%= gfla(obj, "transportsEnCommun") %>>
            <% if (Util.notEmpty(obj.getTransportsEnCommun(userLang))) { %>
            <jalios:wysiwyg data='<%= obj %>' field='transportsEnCommun'><%= obj.getTransportsEnCommun(userLang) %></jalios:wysiwyg>            
            <% } %>
    </td>
  </tr>
  <tr class="field parkings wysiwygEditor  <%= Util.isEmpty(obj.getParkings(userLang)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheLieu.class, "parkings", userLang) %><jalios:edit pub='<%= obj %>' fields='parkings'/></td>
    <td class='field-data' <%= gfla(obj, "parkings") %>>
            <% if (Util.notEmpty(obj.getParkings(userLang))) { %>
            <jalios:wysiwyg data='<%= obj %>' field='parkings'><%= obj.getParkings(userLang) %></jalios:wysiwyg>            
            <% } %>
    </td>
  </tr>
  <tr class="field enDetails wysiwygEditor  <%= Util.isEmpty(obj.getEnDetails(userLang)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheLieu.class, "enDetails", userLang) %><jalios:edit pub='<%= obj %>' fields='enDetails'/></td>
    <td class='field-data' <%= gfla(obj, "enDetails") %>>
            <% if (Util.notEmpty(obj.getEnDetails(userLang))) { %>
            <jalios:wysiwyg data='<%= obj %>' field='enDetails'><%= obj.getEnDetails(userLang) %></jalios:wysiwyg>            
            <% } %>
    </td>
  </tr>
  <tr class="field video linkEditor  <%= Util.isEmpty(obj.getVideo()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheLieu.class, "video", userLang) %><jalios:edit pub='<%= obj %>' fields='video'/></td>
    <td class='field-data' >
            <% if (Util.notEmpty(obj.getVideo())) { %>
            <ol>
              <jalios:foreach name="itData" type="generated.VideoChapitree" array="<%= obj.getVideo() %>">
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
  <tr class="field portletBas linkEditor  <%= Util.isEmpty(obj.getPortletBas()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheLieu.class, "portletBas", userLang) %><jalios:edit pub='<%= obj %>' fields='portletBas'/></td>
    <td class='field-data' >
            <% if (Util.notEmpty(obj.getPortletBas())) { %>
            <ol>
              <jalios:foreach name="itData" type="com.jalios.jcms.portlet.PortalElement" array="<%= obj.getPortletBas() %>">
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
  <tr class="field arretsDeTransportsEnCommunAccess booleanEditor  ">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheLieu.class, "arretsDeTransportsEnCommunAccess", userLang) %><jalios:edit pub='<%= obj %>' fields='arretsDeTransportsEnCommunAccess'/></td>
    <td class='field-data' >
            <%= obj.getArretsDeTransportsEnCommunAccessLabel(userLang) %>
    </td>
  </tr>
  <tr class="field presenceDunePlacePMRSurLespacePu booleanEditor  ">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheLieu.class, "presenceDunePlacePMRSurLespacePu", userLang) %><jalios:edit pub='<%= obj %>' fields='presenceDunePlacePMRSurLespacePu'/></td>
    <td class='field-data' >
            <%= obj.getPresenceDunePlacePMRSurLespacePuLabel(userLang) %>
    </td>
  </tr>
  <tr class="field presenceDunePlacePMRDansLERP booleanEditor  ">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheLieu.class, "presenceDunePlacePMRDansLERP", userLang) %><jalios:edit pub='<%= obj %>' fields='presenceDunePlacePMRDansLERP'/></td>
    <td class='field-data' >
            <%= obj.getPresenceDunePlacePMRDansLERPLabel(userLang) %>
    </td>
  </tr>
  <tr class="field handicapAuditif enumerateEditor  <%= Util.isEmpty(obj.getHandicapAuditif()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheLieu.class, "handicapAuditif", userLang) %><jalios:edit pub='<%= obj %>' fields='handicapAuditif'/></td>
    <td class='field-data' <%= gfla(obj, "handicapAuditif") %>>
            <% if (Util.notEmpty(obj.getHandicapAuditif())) { %>
            <%= obj.getHandicapAuditifLabel(obj.getHandicapAuditif(), userLang) %>
            <% } %>
    </td>
  </tr>
  <tr class="field handicapMental enumerateEditor  <%= Util.isEmpty(obj.getHandicapMental()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheLieu.class, "handicapMental", userLang) %><jalios:edit pub='<%= obj %>' fields='handicapMental'/></td>
    <td class='field-data' <%= gfla(obj, "handicapMental") %>>
            <% if (Util.notEmpty(obj.getHandicapMental())) { %>
            <%= obj.getHandicapMentalLabel(obj.getHandicapMental(), userLang) %>
            <% } %>
    </td>
  </tr>
  <tr class="field deficiencePsychiqueEtMaladieMent enumerateEditor  <%= Util.isEmpty(obj.getDeficiencePsychiqueEtMaladieMent()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheLieu.class, "deficiencePsychiqueEtMaladieMent", userLang) %><jalios:edit pub='<%= obj %>' fields='deficiencePsychiqueEtMaladieMent'/></td>
    <td class='field-data' <%= gfla(obj, "deficiencePsychiqueEtMaladieMent") %>>
            <% if (Util.notEmpty(obj.getDeficiencePsychiqueEtMaladieMent())) { %>
            <%= obj.getDeficiencePsychiqueEtMaladieMentLabel(obj.getDeficiencePsychiqueEtMaladieMent(), userLang) %>
            <% } %>
    </td>
  </tr>
  <tr class="field batimentHandicapAuditif enumerateEditor  <%= Util.isEmpty(obj.getBatimentHandicapAuditif()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheLieu.class, "batimentHandicapAuditif", userLang) %><jalios:edit pub='<%= obj %>' fields='batimentHandicapAuditif'/></td>
    <td class='field-data' <%= gfla(obj, "batimentHandicapAuditif") %>>
            <% if (Util.notEmpty(obj.getBatimentHandicapAuditif())) { %>
            <%= obj.getBatimentHandicapAuditifLabel(obj.getBatimentHandicapAuditif(), userLang) %>
            <% } %>
    </td>
  </tr>
  <tr class="field batimentHandicapMoteur enumerateEditor  <%= Util.isEmpty(obj.getBatimentHandicapMoteur()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheLieu.class, "batimentHandicapMoteur", userLang) %><jalios:edit pub='<%= obj %>' fields='batimentHandicapMoteur'/></td>
    <td class='field-data' <%= gfla(obj, "batimentHandicapMoteur") %>>
            <% if (Util.notEmpty(obj.getBatimentHandicapMoteur())) { %>
            <%= obj.getBatimentHandicapMoteurLabel(obj.getBatimentHandicapMoteur(), userLang) %>
            <% } %>
    </td>
  </tr>
  <tr class="field batimentHandicapVisuel enumerateEditor  <%= Util.isEmpty(obj.getBatimentHandicapVisuel()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheLieu.class, "batimentHandicapVisuel", userLang) %><jalios:edit pub='<%= obj %>' fields='batimentHandicapVisuel'/></td>
    <td class='field-data' <%= gfla(obj, "batimentHandicapVisuel") %>>
            <% if (Util.notEmpty(obj.getBatimentHandicapVisuel())) { %>
            <%= obj.getBatimentHandicapVisuelLabel(obj.getBatimentHandicapVisuel(), userLang) %>
            <% } %>
    </td>
  </tr>
  <tr class="field batimentDeficiencePsychiqueEtMal enumerateEditor  <%= Util.isEmpty(obj.getBatimentDeficiencePsychiqueEtMal()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheLieu.class, "batimentDeficiencePsychiqueEtMal", userLang) %><jalios:edit pub='<%= obj %>' fields='batimentDeficiencePsychiqueEtMal'/></td>
    <td class='field-data' <%= gfla(obj, "batimentDeficiencePsychiqueEtMal") %>>
            <% if (Util.notEmpty(obj.getBatimentDeficiencePsychiqueEtMal())) { %>
            <%= obj.getBatimentDeficiencePsychiqueEtMalLabel(obj.getBatimentDeficiencePsychiqueEtMal(), userLang) %>
            <% } %>
    </td>
  </tr>
  <tr class="field visiophone booleanEditor  ">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheLieu.class, "visiophone", userLang) %><jalios:edit pub='<%= obj %>' fields='visiophone'/></td>
    <td class='field-data' >
            <%= obj.getVisiophoneLabel(userLang) %>
    </td>
  </tr>
  <tr class="field sonette booleanEditor  ">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheLieu.class, "sonette", userLang) %><jalios:edit pub='<%= obj %>' fields='sonette'/></td>
    <td class='field-data' >
            <%= obj.getSonetteLabel(userLang) %>
    </td>
  </tr>
  <tr class="field signaletiqueDirectionnelle booleanEditor  ">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheLieu.class, "signaletiqueDirectionnelle", userLang) %><jalios:edit pub='<%= obj %>' fields='signaletiqueDirectionnelle'/></td>
    <td class='field-data' >
            <%= obj.getSignaletiqueDirectionnelleLabel(userLang) %>
    </td>
  </tr>
  <tr class="field entreeDePlainpied booleanEditor  ">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheLieu.class, "entreeDePlainpied", userLang) %><jalios:edit pub='<%= obj %>' fields='entreeDePlainpied'/></td>
    <td class='field-data' >
            <%= obj.getEntreeDePlainpiedLabel(userLang) %>
    </td>
  </tr>
  <tr class="field portesAutomatiques booleanEditor  ">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheLieu.class, "portesAutomatiques", userLang) %><jalios:edit pub='<%= obj %>' fields='portesAutomatiques'/></td>
    <td class='field-data' >
            <%= obj.getPortesAutomatiquesLabel(userLang) %>
    </td>
  </tr>
  <tr class="field rampeFixe booleanEditor  ">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheLieu.class, "rampeFixe", userLang) %><jalios:edit pub='<%= obj %>' fields='rampeFixe'/></td>
    <td class='field-data' >
            <%= obj.getRampeFixeLabel(userLang) %>
    </td>
  </tr>
  <tr class="field ascenseurMontecharge booleanEditor  ">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheLieu.class, "ascenseurMontecharge", userLang) %><jalios:edit pub='<%= obj %>' fields='ascenseurMontecharge'/></td>
    <td class='field-data' >
            <%= obj.getAscenseurMontechargeLabel(userLang) %>
    </td>
  </tr>
  <tr class="field presenceDePersonnelALaccueil booleanEditor  ">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheLieu.class, "presenceDePersonnelALaccueil", userLang) %><jalios:edit pub='<%= obj %>' fields='presenceDePersonnelALaccueil'/></td>
    <td class='field-data' >
            <%= obj.getPresenceDePersonnelALaccueilLabel(userLang) %>
    </td>
  </tr>
  <tr class="field personnelDaccueilFormeAuxDiffere booleanEditor  ">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheLieu.class, "personnelDaccueilFormeAuxDiffere", userLang) %><jalios:edit pub='<%= obj %>' fields='personnelDaccueilFormeAuxDiffere'/></td>
    <td class='field-data' >
            <%= obj.getPersonnelDaccueilFormeAuxDiffereLabel(userLang) %>
    </td>
  </tr>
  <tr class="field personnelDaccueilFormeALaLangueD booleanEditor  ">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheLieu.class, "personnelDaccueilFormeALaLangueD", userLang) %><jalios:edit pub='<%= obj %>' fields='personnelDaccueilFormeALaLangueD'/></td>
    <td class='field-data' >
            <%= obj.getPersonnelDaccueilFormeALaLangueDLabel(userLang) %>
    </td>
  </tr>
  <tr class="field siOuiHorairesDePresence textareaEditor  <%= Util.isEmpty(obj.getSiOuiHorairesDePresence(userLang)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheLieu.class, "siOuiHorairesDePresence", userLang) %><jalios:edit pub='<%= obj %>' fields='siOuiHorairesDePresence'/></td>
    <td class='field-data' <%= gfla(obj, "siOuiHorairesDePresence") %>>
            <% if (Util.notEmpty(obj.getSiOuiHorairesDePresence(userLang))) { %>
            <%= obj.getSiOuiHorairesDePresence(userLang) %>
            <% } %>
    </td>
  </tr>
  <tr class="field accueilHandicapAuditif enumerateEditor  <%= Util.isEmpty(obj.getAccueilHandicapAuditif()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheLieu.class, "accueilHandicapAuditif", userLang) %><jalios:edit pub='<%= obj %>' fields='accueilHandicapAuditif'/></td>
    <td class='field-data' <%= gfla(obj, "accueilHandicapAuditif") %>>
            <% if (Util.notEmpty(obj.getAccueilHandicapAuditif())) { %>
            <%= obj.getAccueilHandicapAuditifLabel(obj.getAccueilHandicapAuditif(), userLang) %>
            <% } %>
    </td>
  </tr>
  <tr class="field accueilHandicapMoteur enumerateEditor  <%= Util.isEmpty(obj.getAccueilHandicapMoteur()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheLieu.class, "accueilHandicapMoteur", userLang) %><jalios:edit pub='<%= obj %>' fields='accueilHandicapMoteur'/></td>
    <td class='field-data' <%= gfla(obj, "accueilHandicapMoteur") %>>
            <% if (Util.notEmpty(obj.getAccueilHandicapMoteur())) { %>
            <%= obj.getAccueilHandicapMoteurLabel(obj.getAccueilHandicapMoteur(), userLang) %>
            <% } %>
    </td>
  </tr>
  <tr class="field accueilHandicapVisuel enumerateEditor  <%= Util.isEmpty(obj.getAccueilHandicapVisuel()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheLieu.class, "accueilHandicapVisuel", userLang) %><jalios:edit pub='<%= obj %>' fields='accueilHandicapVisuel'/></td>
    <td class='field-data' <%= gfla(obj, "accueilHandicapVisuel") %>>
            <% if (Util.notEmpty(obj.getAccueilHandicapVisuel())) { %>
            <%= obj.getAccueilHandicapVisuelLabel(obj.getAccueilHandicapVisuel(), userLang) %>
            <% } %>
    </td>
  </tr>
  <tr class="field accueilHandicapMental enumerateEditor  <%= Util.isEmpty(obj.getAccueilHandicapMental()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheLieu.class, "accueilHandicapMental", userLang) %><jalios:edit pub='<%= obj %>' fields='accueilHandicapMental'/></td>
    <td class='field-data' <%= gfla(obj, "accueilHandicapMental") %>>
            <% if (Util.notEmpty(obj.getAccueilHandicapMental())) { %>
            <%= obj.getAccueilHandicapMentalLabel(obj.getAccueilHandicapMental(), userLang) %>
            <% } %>
    </td>
  </tr>
  <tr class="field accueilDeficiencePsychiqueEtMala enumerateEditor  <%= Util.isEmpty(obj.getAccueilDeficiencePsychiqueEtMala()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheLieu.class, "accueilDeficiencePsychiqueEtMala", userLang) %><jalios:edit pub='<%= obj %>' fields='accueilDeficiencePsychiqueEtMala'/></td>
    <td class='field-data' <%= gfla(obj, "accueilDeficiencePsychiqueEtMala") %>>
            <% if (Util.notEmpty(obj.getAccueilDeficiencePsychiqueEtMala())) { %>
            <%= obj.getAccueilDeficiencePsychiqueEtMalaLabel(obj.getAccueilDeficiencePsychiqueEtMala(), userLang) %>
            <% } %>
    </td>
  </tr>
  <tr class="field sanitairesHandicapAuditif enumerateEditor  <%= Util.isEmpty(obj.getSanitairesHandicapAuditif()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheLieu.class, "sanitairesHandicapAuditif", userLang) %><jalios:edit pub='<%= obj %>' fields='sanitairesHandicapAuditif'/></td>
    <td class='field-data' <%= gfla(obj, "sanitairesHandicapAuditif") %>>
            <% if (Util.notEmpty(obj.getSanitairesHandicapAuditif())) { %>
            <%= obj.getSanitairesHandicapAuditifLabel(obj.getSanitairesHandicapAuditif(), userLang) %>
            <% } %>
    </td>
  </tr>
  <tr class="field sanitairesHandicapMoteur enumerateEditor  <%= Util.isEmpty(obj.getSanitairesHandicapMoteur()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheLieu.class, "sanitairesHandicapMoteur", userLang) %><jalios:edit pub='<%= obj %>' fields='sanitairesHandicapMoteur'/></td>
    <td class='field-data' <%= gfla(obj, "sanitairesHandicapMoteur") %>>
            <% if (Util.notEmpty(obj.getSanitairesHandicapMoteur())) { %>
            <%= obj.getSanitairesHandicapMoteurLabel(obj.getSanitairesHandicapMoteur(), userLang) %>
            <% } %>
    </td>
  </tr>
  <tr class="field sanitairesHandicapVisuel enumerateEditor  <%= Util.isEmpty(obj.getSanitairesHandicapVisuel()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheLieu.class, "sanitairesHandicapVisuel", userLang) %><jalios:edit pub='<%= obj %>' fields='sanitairesHandicapVisuel'/></td>
    <td class='field-data' <%= gfla(obj, "sanitairesHandicapVisuel") %>>
            <% if (Util.notEmpty(obj.getSanitairesHandicapVisuel())) { %>
            <%= obj.getSanitairesHandicapVisuelLabel(obj.getSanitairesHandicapVisuel(), userLang) %>
            <% } %>
    </td>
  </tr>
  <tr class="field salleDattenteHandicapMental enumerateEditor  <%= Util.isEmpty(obj.getSalleDattenteHandicapMental()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheLieu.class, "salleDattenteHandicapMental", userLang) %><jalios:edit pub='<%= obj %>' fields='salleDattenteHandicapMental'/></td>
    <td class='field-data' <%= gfla(obj, "salleDattenteHandicapMental") %>>
            <% if (Util.notEmpty(obj.getSalleDattenteHandicapMental())) { %>
            <%= obj.getSalleDattenteHandicapMentalLabel(obj.getSalleDattenteHandicapMental(), userLang) %>
            <% } %>
    </td>
  </tr>
  <tr class="field salleDattenteDeficiencePsychique enumerateEditor  <%= Util.isEmpty(obj.getSalleDattenteDeficiencePsychique()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheLieu.class, "salleDattenteDeficiencePsychique", userLang) %><jalios:edit pub='<%= obj %>' fields='salleDattenteDeficiencePsychique'/></td>
    <td class='field-data' <%= gfla(obj, "salleDattenteDeficiencePsychique") %>>
            <% if (Util.notEmpty(obj.getSalleDattenteDeficiencePsychique())) { %>
            <%= obj.getSalleDattenteDeficiencePsychiqueLabel(obj.getSalleDattenteDeficiencePsychique(), userLang) %>
            <% } %>
    </td>
  </tr>
  <tr class="field bureauHandicapAuditif enumerateEditor  <%= Util.isEmpty(obj.getBureauHandicapAuditif()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheLieu.class, "bureauHandicapAuditif", userLang) %><jalios:edit pub='<%= obj %>' fields='bureauHandicapAuditif'/></td>
    <td class='field-data' <%= gfla(obj, "bureauHandicapAuditif") %>>
            <% if (Util.notEmpty(obj.getBureauHandicapAuditif())) { %>
            <%= obj.getBureauHandicapAuditifLabel(obj.getBureauHandicapAuditif(), userLang) %>
            <% } %>
    </td>
  </tr>
  <tr class="field bureauHandicapMoteur enumerateEditor  <%= Util.isEmpty(obj.getBureauHandicapMoteur()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheLieu.class, "bureauHandicapMoteur", userLang) %><jalios:edit pub='<%= obj %>' fields='bureauHandicapMoteur'/></td>
    <td class='field-data' <%= gfla(obj, "bureauHandicapMoteur") %>>
            <% if (Util.notEmpty(obj.getBureauHandicapMoteur())) { %>
            <%= obj.getBureauHandicapMoteurLabel(obj.getBureauHandicapMoteur(), userLang) %>
            <% } %>
    </td>
  </tr>
  <tr class="field bureauHandicapVisuel enumerateEditor  <%= Util.isEmpty(obj.getBureauHandicapVisuel()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheLieu.class, "bureauHandicapVisuel", userLang) %><jalios:edit pub='<%= obj %>' fields='bureauHandicapVisuel'/></td>
    <td class='field-data' <%= gfla(obj, "bureauHandicapVisuel") %>>
            <% if (Util.notEmpty(obj.getBureauHandicapVisuel())) { %>
            <%= obj.getBureauHandicapVisuelLabel(obj.getBureauHandicapVisuel(), userLang) %>
            <% } %>
    </td>
  </tr>
  <tr class="field bureauHandicapMental enumerateEditor  <%= Util.isEmpty(obj.getBureauHandicapMental()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheLieu.class, "bureauHandicapMental", userLang) %><jalios:edit pub='<%= obj %>' fields='bureauHandicapMental'/></td>
    <td class='field-data' <%= gfla(obj, "bureauHandicapMental") %>>
            <% if (Util.notEmpty(obj.getBureauHandicapMental())) { %>
            <%= obj.getBureauHandicapMentalLabel(obj.getBureauHandicapMental(), userLang) %>
            <% } %>
    </td>
  </tr>
  <tr class="field bureauDeficiencePsychiqueEtMalad enumerateEditor  <%= Util.isEmpty(obj.getBureauDeficiencePsychiqueEtMalad()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheLieu.class, "bureauDeficiencePsychiqueEtMalad", userLang) %><jalios:edit pub='<%= obj %>' fields='bureauDeficiencePsychiqueEtMalad'/></td>
    <td class='field-data' <%= gfla(obj, "bureauDeficiencePsychiqueEtMalad") %>>
            <% if (Util.notEmpty(obj.getBureauDeficiencePsychiqueEtMalad())) { %>
            <%= obj.getBureauDeficiencePsychiqueEtMaladLabel(obj.getBureauDeficiencePsychiqueEtMalad(), userLang) %>
            <% } %>
    </td>
  </tr>
  <tr class="field salleDeReunionHandicapAuditif enumerateEditor  <%= Util.isEmpty(obj.getSalleDeReunionHandicapAuditif()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheLieu.class, "salleDeReunionHandicapAuditif", userLang) %><jalios:edit pub='<%= obj %>' fields='salleDeReunionHandicapAuditif'/></td>
    <td class='field-data' <%= gfla(obj, "salleDeReunionHandicapAuditif") %>>
            <% if (Util.notEmpty(obj.getSalleDeReunionHandicapAuditif())) { %>
            <%= obj.getSalleDeReunionHandicapAuditifLabel(obj.getSalleDeReunionHandicapAuditif(), userLang) %>
            <% } %>
    </td>
  </tr>
  <tr class="field salleDeReunionHandicapMoteur enumerateEditor  <%= Util.isEmpty(obj.getSalleDeReunionHandicapMoteur()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheLieu.class, "salleDeReunionHandicapMoteur", userLang) %><jalios:edit pub='<%= obj %>' fields='salleDeReunionHandicapMoteur'/></td>
    <td class='field-data' <%= gfla(obj, "salleDeReunionHandicapMoteur") %>>
            <% if (Util.notEmpty(obj.getSalleDeReunionHandicapMoteur())) { %>
            <%= obj.getSalleDeReunionHandicapMoteurLabel(obj.getSalleDeReunionHandicapMoteur(), userLang) %>
            <% } %>
    </td>
  </tr>
  <tr class="field salleDeReunionHandicapVisuel enumerateEditor  <%= Util.isEmpty(obj.getSalleDeReunionHandicapVisuel()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheLieu.class, "salleDeReunionHandicapVisuel", userLang) %><jalios:edit pub='<%= obj %>' fields='salleDeReunionHandicapVisuel'/></td>
    <td class='field-data' <%= gfla(obj, "salleDeReunionHandicapVisuel") %>>
            <% if (Util.notEmpty(obj.getSalleDeReunionHandicapVisuel())) { %>
            <%= obj.getSalleDeReunionHandicapVisuelLabel(obj.getSalleDeReunionHandicapVisuel(), userLang) %>
            <% } %>
    </td>
  </tr>
  <tr class="field salleDeReunionHandicapMental enumerateEditor  <%= Util.isEmpty(obj.getSalleDeReunionHandicapMental()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheLieu.class, "salleDeReunionHandicapMental", userLang) %><jalios:edit pub='<%= obj %>' fields='salleDeReunionHandicapMental'/></td>
    <td class='field-data' <%= gfla(obj, "salleDeReunionHandicapMental") %>>
            <% if (Util.notEmpty(obj.getSalleDeReunionHandicapMental())) { %>
            <%= obj.getSalleDeReunionHandicapMentalLabel(obj.getSalleDeReunionHandicapMental(), userLang) %>
            <% } %>
    </td>
  </tr>
  <tr class="field salleDeReunionDeficiencePsychiqu enumerateEditor  <%= Util.isEmpty(obj.getSalleDeReunionDeficiencePsychiqu()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheLieu.class, "salleDeReunionDeficiencePsychiqu", userLang) %><jalios:edit pub='<%= obj %>' fields='salleDeReunionDeficiencePsychiqu'/></td>
    <td class='field-data' <%= gfla(obj, "salleDeReunionDeficiencePsychiqu") %>>
            <% if (Util.notEmpty(obj.getSalleDeReunionDeficiencePsychiqu())) { %>
            <%= obj.getSalleDeReunionDeficiencePsychiquLabel(obj.getSalleDeReunionDeficiencePsychiqu(), userLang) %>
            <% } %>
    </td>
  </tr>
  <tr class="field planningDeMiseEnAccessibiliteDuS textfieldEditor  <%= Util.isEmpty(obj.getPlanningDeMiseEnAccessibiliteDuS(userLang)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheLieu.class, "planningDeMiseEnAccessibiliteDuS", userLang) %><jalios:edit pub='<%= obj %>' fields='planningDeMiseEnAccessibiliteDuS'/></td>
    <td class='field-data' <%= gfla(obj, "planningDeMiseEnAccessibiliteDuS") %>>
            <% if (Util.notEmpty(obj.getPlanningDeMiseEnAccessibiliteDuS(userLang))) { %>
            <%= obj.getPlanningDeMiseEnAccessibiliteDuS(userLang) %>
            <% } %>
    </td>
  </tr>
  <tr class="field boucleInductionMagnetiqueAccueil enumerateEditor  <%= Util.isEmpty(obj.getBoucleInductionMagnetiqueAccueil()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheLieu.class, "boucleInductionMagnetiqueAccueil", userLang) %><jalios:edit pub='<%= obj %>' fields='boucleInductionMagnetiqueAccueil'/></td>
    <td class='field-data' <%= gfla(obj, "boucleInductionMagnetiqueAccueil") %>>
            <% if (Util.notEmpty(obj.getBoucleInductionMagnetiqueAccueil())) { %>
            <%= obj.getBoucleInductionMagnetiqueAccueilLabel(obj.getBoucleInductionMagnetiqueAccueil(), userLang) %>
            <% } %>
    </td>
  </tr>
  <tr class="field ascenseur enumerateEditor  <%= Util.isEmpty(obj.getAscenseur()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheLieu.class, "ascenseur", userLang) %><jalios:edit pub='<%= obj %>' fields='ascenseur'/></td>
    <td class='field-data' <%= gfla(obj, "ascenseur") %>>
            <% if (Util.notEmpty(obj.getAscenseur())) { %>
            <%= obj.getAscenseurLabel(obj.getAscenseur(), userLang) %>
            <% } %>
    </td>
  </tr>
  <tr class="field rampeAmovible enumerateEditor  <%= Util.isEmpty(obj.getRampeAmovible()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheLieu.class, "rampeAmovible", userLang) %><jalios:edit pub='<%= obj %>' fields='rampeAmovible'/></td>
    <td class='field-data' <%= gfla(obj, "rampeAmovible") %>>
            <% if (Util.notEmpty(obj.getRampeAmovible())) { %>
            <%= obj.getRampeAmovibleLabel(obj.getRampeAmovible(), userLang) %>
            <% } %>
    </td>
  </tr>
  <tr class="field informationsComplementaires wysiwygEditor  <%= Util.isEmpty(obj.getInformationsComplementaires(userLang)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheLieu.class, "informationsComplementaires", userLang) %><jalios:edit pub='<%= obj %>' fields='informationsComplementaires'/></td>
    <td class='field-data' <%= gfla(obj, "informationsComplementaires") %>>
            <% if (Util.notEmpty(obj.getInformationsComplementaires(userLang))) { %>
            <jalios:wysiwyg data='<%= obj %>' field='informationsComplementaires'><%= obj.getInformationsComplementaires(userLang) %></jalios:wysiwyg>            
            <% } %>
    </td>
  </tr>
  <tr class="field adresse textfieldEditor  <%= Util.isEmpty(obj.getAdresse(userLang)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheLieu.class, "adresse", userLang) %><jalios:edit pub='<%= obj %>' fields='adresse'/></td>
    <td class='field-data' <%= gfla(obj, "adresse") %>>
            <% if (Util.notEmpty(obj.getAdresse(userLang))) { %>
            <%= obj.getAdresse(userLang) %>
            <% } %>
    </td>
  </tr>
  <tr class="field latitude textfieldEditor  <%= Util.isEmpty(obj.getLatitude(userLang)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheLieu.class, "latitude", userLang) %><jalios:edit pub='<%= obj %>' fields='latitude'/></td>
    <td class='field-data' <%= gfla(obj, "latitude") %>>
            <% if (Util.notEmpty(obj.getLatitude(userLang))) { %>
            <%= obj.getLatitude(userLang) %>
            <% } %>
    </td>
  </tr>
  <tr class="field longitude textfieldEditor  <%= Util.isEmpty(obj.getLongitude(userLang)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheLieu.class, "longitude", userLang) %><jalios:edit pub='<%= obj %>' fields='longitude'/></td>
    <td class='field-data' <%= gfla(obj, "longitude") %>>
            <% if (Util.notEmpty(obj.getLongitude(userLang))) { %>
            <%= obj.getLongitude(userLang) %>
            <% } %>
    </td>
  </tr>
 
</table>
<jsp:include page="/front/doFullDisplayCommonFields.jsp" />
</div>