<%@ page contentType="text/html; charset=UTF-8" %>
<%@page import="fr.cg44.plugin.socle.SocleUtils"%>
<%@ taglib prefix="ds" tagdir="/WEB-INF/tags"%>
<%@ include file='/jcore/doInitPage.jspf' %>
<% FichePublication obj = (FichePublication)request.getAttribute(PortalManager.PORTAL_PUBLICATION); %>
<%@ include file='/front/doFullDisplay.jspf' %>

<main role="main" id="content">

<jalios:include target="SOCLE_ALERTE"/>

    <article class="ds44-container-large pbm">
        <%-- Titre  --%>
        <div class='<%= Util.notEmpty(request.getAttribute("isSearchFacetPanel")) ? "ds44-js-results-card" : "ds44-lightBG ds44-posRel"%>'>
            <%-- bouton Retour a la liste --%>
            <%@ include file="/plugins/SoclePlugin/jsp/facettes/doRetourListe.jspf" %>
            
            <div class="ds44-inner-container--mag ds44--xl-padding-t ds44--m-padding-b ds44-tablette-reduced-pt">
                <div class="ds44-grid12-offset-2">
                    <div class="ds44-tablette-reduced-mt">
                        <jalios:if predicate='<%=Util.notEmpty(channel.getProperty("jcmsplugin.socle.portlet.filariane.id"))%>'>
                            <jalios:include id='<%=channel.getProperty("jcmsplugin.socle.portlet.filariane.id")%>' />
                        </jalios:if>
                    </div>
                    <h1 class="h1-like mbs mts" id="idTitre1"><%=obj.getTitle(userLang) %></h1>
                </div>
            </div>
        </div>
        <div class="ds44-img50 ds44--m-padding-t ds44--xl-padding-b">
            <div class="ds44-inner-container--mag ds44-large-noOffset">
                <div class="grid-12-small-1 grid-12-medium-1 ds44-theme">
                    <div class="col-5">

                        <jalios:if predicate='<%= Util.notEmpty(obj.getUrlLiseuse(userLang)) %>'>
                            <a href="<%= obj.getUrlLiseuse(userLang) %>" target="_blank" title="<%= HttpUtil.encodeForHTMLAttribute(glp("jcmsplugin.socle.fichepublication.lire.title",obj.getTitle(userLang)))%>">
                        </jalios:if>
                        
                        <%-- On ne prévoit pas d'image mobile --%>
                        <picture class="ds44-stl-center ds44-tablette-extra-mt">
                            <img src="<%= SocleUtils.getUrlOfFormattedImageMagazine(obj.getImagePrincipale()) %>" class="tiny-w100" alt='<%= HttpUtil.encodeForHTMLAttribute(glp("jcmsplugin.socle.fichepublication.lire.title",obj.getTitle(userLang)))%>'>
                        </picture>
                        
                        <jalios:if predicate='<%= Util.notEmpty(obj.getUrlLiseuse(userLang)) %>'>
                            </a>
                        </jalios:if>
                        
                    </div>
                    <div class="col-7 ds44-mlr4 ds44--xxl-padding-t ds44-mobile-reduced-pad ds44-mobile-reduced-mar">
                        <jalios:if predicate='<%= Util.notEmpty(obj.getTitreUne(userLang, false)) %>'>
                            <h2 class="h2-like ds44-theme"><%= obj.getTitreUne(userLang, false) %></h2>
                        </jalios:if>
                   
                        <jalios:if predicate='<%= Util.notEmpty(obj.getChapo(userLang, false)) %>'>
	                        <div class="ds44-introduction">
	                            <jalios:truncate length="250" suffix="..." advancedHtml="true"><%= obj.getChapo(userLang, false) %></jalios:truncate>
	                        </div>
                        </jalios:if>
                        
                        <jalios:if predicate='<%= Util.notEmpty(obj.getUrlLiseuse(userLang, false)) %>'>
                            <p class="ds44-mt4">
                            <% String titleBtnLiseuse = Util.notEmpty(obj.getLibelleBoutonLiseuse(userLang, false)) ? glp("jcmsplugin.socle.fichepublication.lire.title.custom", obj.getLibelleBoutonLiseuse(userLang, false), obj.getTitreUne(userLang)+" - "+obj.getTitle(userLang)) : glp("jcmsplugin.socle.fichepublication.lire.title",obj.getTitreUne(userLang)+" - "+obj.getTitle(userLang)); %>
                                <a href="<%= obj.getUrlLiseuse(userLang) %>" class="ds44-btnStd ds44-btnStd--large ds44-btn--invert ds44-bntALeft" target="_blank" title="<%= HttpUtil.encodeForHTMLAttribute(titleBtnLiseuse) %>">
                                    <span class="ds44-btnInnerText"><%= Util.notEmpty(obj.getLibelleBoutonLiseuse(userLang, false)) ? obj.getLibelleBoutonLiseuse(userLang, false) : glp("jcmsplugin.socle.fichepublication.lireenligne") %></span><i class="icon icon-long-arrow-right" aria-hidden="true"></i>
                                </a>
                            </p>
                        </jalios:if>
                        
                        <ul class="ds44-list ds44-flex-container ds44-flex-container--colMed ds44-mt4 ds44-mb2">
                        
                            <jalios:if predicate='<%= Util.notEmpty(obj.getDocumentPdf(userLang, false)) %>'>
                                <%
                                FileDocument fichierPublication = obj.getDocumentPdf(userLang, false);
                                String fileTypeFichierPublication = FileDocument.getExtension(fichierPublication.getFilename()).toUpperCase();
                                String fileSizeFichierPublication = Util.formatFileSize(fichierPublication.getSize());
                                %>
                                <li class="ds44-large-extra-mb ds44-mr-std">
                                    <a href="<%= fichierPublication.getDownloadUrl() %>" class="ds44-btnStd ds44-bntALeft" target="_blank"
                                        title="<%= HttpUtil.encodeForHTMLAttribute(glp("jcmsplugin.socle.fichepublication.telechargermagazine.title", obj.getTitle(userLang), fileTypeFichierPublication, fileSizeFichierPublication)) %>"
                                        data-statistic='{"name": "declenche-evenement","category": "Magazine","action": "Télécharger","label": "<%= HttpUtil.encodeForHTMLAttribute(obj.getTitle(userLang)) %>"}'>
                                        <span class="ds44-btnInnerText"><%= glp("jcmsplugin.socle.fichepublication.telecharger") %></span><i class="icon icon-long-arrow-right" aria-hidden="true"></i>
                                    </a>
                                </li>
                            </jalios:if>
                            
                            <jalios:if predicate='<%= Util.notEmpty(obj.getCodeEmbedSoundcloud(userLang, false)) %>'>
                                <li class="ds44-large-extra-mb ds44-mr-std">
                                    <button class="ds44-btnStd ds44-bntALeft" type="button" data-target="#overlay-ecouter" data-js="ds44-modal" 
                                    title="<%= HttpUtil.encodeForHTMLAttribute(glp("jcmsplugin.socle.fichepublication.ecoutermagazine.title", obj.getTitle(userLang))) %>" 
                                    data-statistic='{"name": "declenche-evenement","category": "Magazine","action": "Ecouter","label": "<%= HttpUtil.encodeForHTMLAttribute(obj.getTitle(userLang)) %>"}'>
                                        <span class="ds44-btnInnerText"><%= glp("jcmsplugin.socle.fichepublication.ecouter") %></span><i class="icon icon-long-arrow-right" aria-hidden="true"></i>
                                    </button>
                                </li>
                            </jalios:if>
                            
                            <jalios:if predicate='<%= Util.notEmpty(obj.getVersionDaisy(userLang, false)) %>'>
                                <%
                                FileDocument fichierDaisy = obj.getVersionDaisy(userLang, false);
                                String fileTypeFichierDaisy = FileDocument.getExtension(fichierDaisy.getFilename()).toUpperCase();
                                String fileSizeFichierDaisy = Util.formatFileSize(fichierDaisy.getSize(), userLocale,false);
                                %>
                                <li class="ds44-large-extra-mb">
                                    <a href="<%= fichierDaisy.getDownloadUrl() %>" class="ds44-btnStd ds44-bntALeft" target="_blank" 
                                        title="<%= HttpUtil.encodeForHTMLAttribute(glp("jcmsplugin.socle.fichepublication.telechargermagazine.title", obj.getTitle(userLang), fileTypeFichierDaisy, fileSizeFichierDaisy)) %>"
                                        data-statistic='{"name": "declenche-evenement","category": "Magazine","action": "Version Daisy","label": "<%= HttpUtil.encodeForHTMLAttribute(obj.getTitle(userLang)) %>"}'>
                                        <span class="ds44-btnInnerText"><%= glp("jcmsplugin.socle.fichepublication.versiondaisy") %></span><i class="icon icon-long-arrow-right" aria-hidden="true"></i>
                                    </a>
                                </li>
                            </jalios:if>
                        </ul>    
                    </div>
                </div>
            </div>
        </div>
        
    <%-- Contenu --%>
    <jalios:if predicate='<%= Util.notEmpty(obj.getFieldValue("titreRubrique1", userLang, false)) || Util.notEmpty(obj.getFieldValue("titreRubrique2", userLang, false))
      || Util.notEmpty(obj.getFieldValue("titreRubrique3", userLang, false)) || Util.notEmpty(obj.getFieldValue("titreRubrique4", userLang, false)) || Util.notEmpty(obj.getFieldValue("titreRubrique5", userLang, false)) %>'>
        <section class="ds44-contenuArticle ds44-mt2" id="section1">
            <div class="ds44-inner-container--mag">
                <div class="ds44-grid12-offset-1">
                    <h2 class="h2-like ds44-mb4"><%= glp("jcmsplugin.socle.fichepublication.ausommaire") %></h2>
                    <div class="grid-2-small-1 has-gutter-l">
                    
                        <%-- Boucle sur les 5 onglets "Rubrique" et alternance des styles "mrs" et "mls".  --%>
                        
                        <% for(int cptRubrique=1 ; cptRubrique<=5 ; cptRubrique++) { %>
                        
                            <jalios:if predicate='<%= Util.notEmpty(obj.getFieldValue("titreRubrique"+cptRubrique, userLang, false)) %>'>
                            
                                <div class="col ds44-mtb1 <%= cptRubrique%2==1 ? "mrs" : "mls" %>">
                                    <h3 id="idTitre-list<%= cptRubrique %>"><%= obj.getFieldValue("titreRubrique"+cptRubrique, userLang) %></h3>
                                    
                                    <%-- Boucle sur les liens --%>
                                    <%
                                    String[] libelleLien = (String[]) (obj.getFieldValue("libelleLienRubrique"+cptRubrique, userLang, false));
                                    Publication[] lienInterne = (Publication[]) (obj.getFieldValue("lienInterneRubrique"+cptRubrique, userLang));
                                    String[] lienExterne = (String[]) (obj.getFieldValue("lienExterneRubrique"+cptRubrique, userLang));
                                    %>
                                    <ul class="ds44-uList">
                                    
                                        <jalios:foreach name="itLien" type="String" counter="itCounter" array='<%=libelleLien%>'>
                                            <%
                                            String urlLien = "";
                                            String targetAttr = "";
                                            String titleAttr = "";
                                            String titleValue = "";
                                            boolean targetBlank = false;
                                            
                                            if(Util.notEmpty(lienInterne) && Util.notEmpty(lienInterne[itCounter-1])){
                                                Publication pub = lienInterne[itCounter-1];
                                                urlLien = pub.getDisplayUrl(userLocale);
                                            }
                                            else if(Util.notEmpty(lienExterne) && Util.notEmpty(lienExterne[itCounter-1])){
                                                urlLien = lienExterne[itCounter-1];
                                                targetBlank = true;
                                                titleValue = itLien;
                                            }
                                            
                                            // Accessibilité : on place un attribut "title" sur le lien uniquement si le lien s'ouvre dans une nouvelle fenêtre
                                            if(targetBlank){
                                              targetAttr = "target=\"_blank\" ";
                                              titleAttr = "title=\"" +  HttpUtil.encodeForHTMLAttribute(titleValue) + " " + glp("jcmsplugin.socle.accessibily.newTabLabel")+"\"";
                                              }
                                            %>
                                            <li>
                                                <jalios:select>
                                                    <jalios:if predicate="<%= Util.notEmpty(urlLien) %>">
                                                        <a href="<%= urlLien %>" <%= titleAttr %> <%= targetAttr %>><%= itLien %></a>
                                                    </jalios:if>
                                                    <jalios:default>
                                                        <%= itLien %>
                                                    </jalios:default>
                                                </jalios:select>
                                            </li>
                                        </jalios:foreach>
    
                                    </ul>
                                </div>
                                
                            </jalios:if>
                        <%} %>
                        
                    </div>
                    
                    <%-- Compléments --%>
                   
                    <jalios:if predicate='<%= Util.notEmpty(obj.getComplement(userLang, false)) %>'>
                        <section class="ds44-box ds44-theme ds44-mb3 mts">
                        <div class="ds44-innerBoxContainer">
                            <jalios:if predicate='<%= Util.notEmpty(obj.getTitreComplement(userLang, false)) %>'>
                                <p role="heading" aria-level="2" class="ds44-box-heading"><%= obj.getTitreComplement(userLang, false) %></p>
                            </jalios:if>
                            <%= obj.getComplement(userLang, false) %>
                        </div>
                        </section>
                    </jalios:if>
                    
                </div>
            </div>
        </section>
    </jalios:if>
    <%-- Modale code Soundcloud --%>
    <jalios:if predicate='<%= Util.notEmpty(obj.getCodeEmbedSoundcloud(userLang, false)) %>'>
        <section class="ds44-modal-container" id="overlay-ecouter" aria-modal="true" aria-hidden="true" role="dialog" aria-labelledby="titre-modale-ecouter">
            <div class="ds44-modal-box">
                <button class="ds44-btnOverlay--modale ds44-btnOverlay--closeOverlay" type="button" title="<%= glp("jcmsplugin.socle.ficheaide.fermerboitedialogue.label", glp("jcmsplugin.socle.fichepublication.ecouter")) %>" data-js="ds44-modal-action-close"><i class="icon icon-cross icon--xlarge" aria-hidden="true"></i><span class="ds44-btnInnerText--bottom"><%= glp("jcmsplugin.socle.fermer") %></span></button>
                <h1 class="h2-like" id="titre-modale-ecouter"><%= glp("jcmsplugin.socle.fichepublication.ecouter") %> <%= obj.getTitle(userLang) %></h2>
                <div class="ds44-modal-gab">
                    <%= obj.getCodeEmbedSoundcloud(userLang, false) %>
                </div>
                    
            </div>
        </section>
    </jalios:if>

    <%-- Partagez cette page --%>
    <%@ include file="/plugins/SoclePlugin/jsp/portal/socialNetworksShare.jspf" %>

    </article>

    <%-- Pushs --%>
    <jalios:if predicate='<%= Util.notEmpty(channel.getProperty("jcmsplugin.socle.portletPush.ficheactu.id")) %>'>
        <jalios:include id='<%= channel.getProperty("jcmsplugin.socle.portletPush.ficheactu.id") %>'/>
    </jalios:if>
    
    <%-- Page utile --%>
    <jsp:include page="/plugins/SoclePlugin/types/PageUtileForm/editFormPageUtileForm.jsp"/>   

</main>