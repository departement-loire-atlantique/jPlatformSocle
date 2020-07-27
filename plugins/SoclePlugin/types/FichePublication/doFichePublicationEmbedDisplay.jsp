<%@ page contentType="text/html; charset=UTF-8" %>
<%@page import="fr.cg44.plugin.socle.SocleUtils"%>
<%@ taglib prefix="ds" tagdir="/WEB-INF/tags"%>
<%@ include file='/jcore/doInitPage.jspf' %>
<% FichePublication obj = (FichePublication)request.getAttribute(PortalManager.PORTAL_PUBLICATION); %>


    <%-- Titre  --%>
    <div class="ds44-lightBG ds44-posRel">
        <div class="ds44-inner-container--mag ds44--xl-padding-t ds44--m-padding-b ds44-tablette-reduced-pt">
            <div class="ds44-grid12-offset-1">
                <h2 class="h1-like mbs mts" id="idTitre1"><%=obj.getTitle(userLang) %></h1>
            </div>
        </div>
    </div>
    <div class="ds44-img50 ds44--m-padding-t ds44--xl-padding-b">
        <div class="ds44-inner-container--mag ds44-large-noOffset">
            <div class="grid-12-small-1 grid-12-medium-1 ds44-theme">
                <div class="col-5">

                    <jalios:if predicate='<%= Util.notEmpty(obj.getUrlLiseuse()) %>'>
	                     <a href="<%= obj.getUrlLiseuse() %>" target="_blank" title="<%= HttpUtil.encodeForHTMLAttribute(glp("jcmsplugin.socle.fichepublication.lire.title",obj.getTitle(userLang)))%>">
	                </jalios:if>
	        
			        <%-- On ne prévoit pas d'image mobile --%>
			        <picture class="ds44-stl-center ds44-tablette-extra-mt">
	                    <img src="<%= SocleUtils.getUrlOfFormattedImageMagazine(obj.getImagePrincipale()) %>" class="tiny-w100">
			        </picture>
			        
			        <jalios:if predicate='<%= Util.notEmpty(obj.getUrlLiseuse()) %>'>
	                    </a>
	                </jalios:if>
                    
                </div>
                <div class="col-7 ds44-mlr4 ds44--xxl-padding-t ds44-mobile-reduced-pad ds44-mobile-reduced-mar">
                    <h3 class="h2-like ds44-theme"><%= obj.getTitreUne(userLang) %></h2>
               
                    <div class="ds44-introduction">
                        <jalios:truncate length="250" suffix="..." advancedHtml="true"><%= obj.getChapo(userLang) %></jalios:truncate>
                    </div>
                    
                    <jalios:if predicate='<%= Util.notEmpty(obj.getUrlLiseuse()) %>'>
                        <p class="ds44-mt4">
                         <a href="<%= obj.getUrlLiseuse() %>" class="ds44-btnStd ds44-btnStd--large ds44-btn--invert ds44-bntALeft" target="_blank" title="<%= HttpUtil.encodeForHTMLAttribute(glp("jcmsplugin.socle.fichepublication.lire.title",obj.getTitle(userLang))) %>">
                             <span class="ds44-btnInnerText"><%= Util.notEmpty(obj.getLibelleBoutonLiseuse()) ? obj.getLibelleBoutonLiseuse() : glp("jcmsplugin.socle.fichepublication.lireenligne") %></span><i class="icon icon-long-arrow-right" aria-hidden="true"></i>
                         </a>
                        </p>
                    </jalios:if>
           
                </div>
            </div>
            
            <div class="ds44-grid12-offset-1 ds44-theme ptl pbl">
				<ul class="ds44-list ds44-flex-container ds44-flex-container--colMed">
				
				<jalios:if predicate='<%= Util.notEmpty(obj.getDocumentPdf()) %>'>
					<%
					FileDocument fichierPublication = obj.getDocumentPdf();
					String fileTypeFichierPublication = FileDocument.getExtension(fichierPublication.getFilename()).toUpperCase();
					String fileSizeFichierPublication = Util.formatFileSize(fichierPublication.getSize(), userLocale,false);
					%>
					<li class="ds44-large-extra-mb ds44-mr-std">
					    <a href="<%= fichierPublication.getDownloadUrl() %>" class="ds44-btnStd ds44-bntALeft" target="_blank"
					     title="<%= HttpUtil.encodeForHTMLAttribute(glp("jcmsplugin.socle.fichepublication.telechargermagazine.title", obj.getTitle(userLang), fileTypeFichierPublication, fileSizeFichierPublication)) %>"
					     data-statistic='{"name": "declenche-evenement","category": "Magazine","action": "Télécharger","label": "<%= HttpUtil.encodeForHTMLAttribute(obj.getTitle()) %>"}'>
					     <span class="ds44-btnInnerText"><%= glp("jcmsplugin.socle.fichepublication.telecharger") %></span><i class="icon icon-long-arrow-right" aria-hidden="true"></i>
					    </a>
					</li>
					</jalios:if>
					
					<jalios:if predicate='<%= Util.notEmpty(obj.getCodeEmbedSoundcloud()) %>'>
					<li class="ds44-large-extra-mb ds44-mr-std">
					 <button class="ds44-btnStd ds44-bntALeft" type="button" data-target="#overlay-ecouter" data-js="ds44-modal" 
					 title="<%= HttpUtil.encodeForHTMLAttribute(glp("jcmsplugin.socle.fichepublication.ecoutermagazine.title", obj.getTitle(userLang))) %>" 
					data-statistic='{"name": "declenche-evenement","category": "Magazine","action": "Ecouter","label": "<%= HttpUtil.encodeForHTMLAttribute(obj.getTitle()) %>"}'>
					  <span class="ds44-btnInnerText"><%= glp("jcmsplugin.socle.fichepublication.ecouter") %></span><i class="icon icon-long-arrow-right" aria-hidden="true"></i>
					 </button>
					</li>
					</jalios:if>
					
					<jalios:if predicate='<%= Util.notEmpty(obj.getVersionDaisy()) %>'>
					<%
					FileDocument fichierDaisy = obj.getVersionDaisy();
					String fileTypeFichierDaisy = FileDocument.getExtension(fichierDaisy.getFilename()).toUpperCase();
					String fileSizeFichierDaisy = Util.formatFileSize(fichierDaisy.getSize(), userLocale,false);
					%>
					<li class="ds44-large-extra-mb">
					    <a href="<%= fichierDaisy.getDownloadUrl() %>" class="ds44-btnStd ds44-bntALeft" target="_blank" 
					     title="<%= HttpUtil.encodeForHTMLAttribute(glp("jcmsplugin.socle.fichepublication.telechargermagazine.title", obj.getTitle(userLang), fileTypeFichierDaisy, fileSizeFichierDaisy)) %>"
					     data-statistic='{"name": "declenche-evenement","category": "Magazine","action": "Version Daisy","label": "<%= HttpUtil.encodeForHTMLAttribute(obj.getTitle()) %>"}'>
					     <span class="ds44-btnInnerText"><%= glp("jcmsplugin.socle.fichepublication.versiondaisy") %></span><i class="icon icon-long-arrow-right" aria-hidden="true"></i>
					    </a>
					</li>
					</jalios:if>
				</ul>
        </div>
            
        </div>
    </div>
    
<%-- Modale code Soundcloud --%>
<jalios:if predicate='<%= Util.notEmpty(obj.getCodeEmbedSoundcloud()) %>'>
 <section class="ds44-modal-container" id="overlay-ecouter" aria-hidden="true" role="dialog" aria-labelledby="titre-modale-ecouter">
  <div class="ds44-modal-box">
   <button class="ds44-btnOverlay--modale ds44-btnOverlay--closeOverlay" type="button" title="<%= glp("jcmsplugin.socle.ficheaide.fermerboitedialogue.label", glp("jcmsplugin.socle.fichepublication.ecouter")) %>" data-js="ds44-modal-action-close"><i class="icon icon-cross icon--xlarge" aria-hidden="true"></i><span class="ds44-btnInnerText--bottom">Fermer</span></button>
   <h1 class="h2-like" id="titre-modale-ecouter"><%= glp("jcmsplugin.socle.fichepublication.ecouter") %> <%= obj.getTitle(userLang) %></h2>
         <div class="ds44-modal-gab">
             <%= obj.getCodeEmbedSoundcloud() %>
         </div>
          
  </div>
 </section>
</jalios:if>

<%-- TODO : Partage réseaux sociaux --%>

