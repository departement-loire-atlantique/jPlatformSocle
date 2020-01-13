<%@ page contentType="text/html; charset=UTF-8" %><%
%><%@ taglib prefix="ds" tagdir="/WEB-INF/tags"%><%
%><%@ include file='/jcore/doInitPage.jspf' %><%
%><% FicheAide obj = (FicheAide)request.getAttribute(PortalManager.PORTAL_PUBLICATION); 
String imageFile = obj.getImageBandeau() ;
String imageMobileFile = Util.notEmpty(obj.getImageMobile()) ? obj.getImageMobile() : "s.gif";
String title = obj.getTitle();
String legende = obj.getLegende(userLang);
String copyright = obj.getCopyright(userLang);
%>


<main role="main" id="content">

    <section class="ds44-container-fluid">
        <jalios:select> 
	        <jalios:if predicate="<%=Util.notEmpty(obj.getImageBandeau()) %>">
	            <ds:titleBanner imagePath="<%= imageFile %>" mobileImagePath="<%= imageMobileFile %>" title="<%= title %>" legend="<%=legende %>" copyright="<%=copyright%>" breadcrumb="true"></ds:titleBanner>
	        </jalios:if>        
	        <jalios:default>
	           <ds:titleNoBanner title="<%= title %>" breadcrumb="true"></ds:titleNoBanner>
	        </jalios:default>
        </jalios:select>
        <section class="ds44-ongletsContainer">

            <div class="js-tabs ds44-tabs" data-existing-hx="h2" data-tabs-prefix-class="ds44" id="onglets">

                <div class="ds44-theme ds44-flex-container ds44-flex-wrap-large">
                    <!-- Résumé / détail / FAQ -->
                    <ul class="js-tablist ds44-tabs__list ds44-fg1 ds44-flex-container ds44-list" role="tablist" id="tabs">
                        <li class="js-tablist__item ds44-tabs__item ds44-fg1" role="presentation" id="tabs__1">
                            <a class="js-tablist__link ds44-tabs__link" id="label_id_first" role="tab" aria-controls="id_first" tabindex="0" aria-selected="true"><%= glp("jcmsplugin.socle.onglet.resume") %></a>
                        </li>
                        <li class="js-tablist__item ds44-tabs__item ds44-fg1" role="presentation" id="tabs__2">
                            <a class="js-tablist__link ds44-tabs__link" id="label_id_second" role="tab" aria-controls="id_second" tabindex="-1" aria-selected="false"><%= glp("jcmsplugin.socle.onglet.detail") %></a>
                        </li>
                        <li class="js-tablist__item ds44-tabs__item ds44-fg1" role="presentation" id="tabs__3">
                            <a class="js-tablist__link ds44-tabs__link" id="label_id_third" role="tab" aria-controls="id_third" tabindex="-1" aria-selected="false"><%= glp("jcmsplugin.socle.onglet.faq") %></a>
                        </li>
                    </ul>
                    
                    <!-- Contact / faire demande / suivre demande  -->
                    <ul class="ds44-flex-container ds44-fse ds44--l-padding-tb ds44-flex-grow1-large ds44-blocBtnOnglets ds44-list">
                        <li class="mrs mls ds44-ongletsBtnItem">
                            <button class="ds44-btnStd ds44-btn--invert" type="button" data-target="#overlay-qui-contacter" data-js="ds44-modal"><span class="ds44-btnInnerText"><%= glp("jcmsplugin.socle.demande.qui-contacter") %></span><i class="icon icon-phone icon--sizeL" aria-hidden="true"></i></button>
                        </li>

                        <li class="mrs ds44-ongletsBtnItem">
                            <button class="ds44-btnStd ds44-btn--invert" type="button" data-target="#overlay-faire-demande" data-js="ds44-modal"><span class="ds44-btnInnerText"><%= glp("jcmsplugin.socle.demande.faire-demande") %></span><i class="icon icon-file icon--sizeL" aria-hidden="true"></i></button>

                        </li>
                        
                        <li class="mrs ds44-ongletsBtnItem">
                            <!-- TODO faire une demande et traduire les libellés -->
                            <button class="ds44-btnStd ds44-btn--invert" type="button" data-target="#overlay-suivre-demande" data-js="ds44-modal"><span class="ds44-btnInnerText"><%= glp("jcmsplugin.socle.demande.suivre-demande") %></span><i class="icon icon-computer icon--sizeL" aria-hidden="true"></i></button>

                            
                        </li>
                    </ul>

                </div>

                
                <!--  En résumé -->
                <div id="id_first" class="js-tabcontent ds44-tabs__content" role="tabpanel" aria-labelledby="label_id_first">

                    <div class="grid-12-small-1">
                        <div class="col-7">
                            <jalios:if predicate="<%= Util.notEmpty(obj.getChapo()) %>">
                                <div class="ds44-introduction"><jalios:wysiwyg><%= obj.getChapo() %></jalios:wysiwyg></div>
                            </jalios:if>
                            <jalios:if predicate="<%= Util.notEmpty(obj.getPourQui()) %>">
                                <h2 class="h2-like mtm"><%= glp("jcmsplugin.socle.titre.pour-qui") %></h2>
                                <jalios:wysiwyg><%= obj.getPourQui() %></jalios:wysiwyg>  
                            </jalios:if>                                      
                        </div>

                        <div class="col-1 grid-offset"></div>

                        <aside class="col-4">     
                            <%@ include file="doFicheAideEncadre.jspf" %>                     
                        </aside>
                        
                    </div>

                </div>

 
                <!-- En détail -->
                <div id="id_second" class="js-tabcontent ds44-tabs__content" role="tabpanel" aria-labelledby="label_id_second" aria-hidden="true">      
                
                    <div class="grid-12-small-1">
                        <div class="col-7">
                            <jalios:if predicate="<%= Util.notEmpty(obj.getIntro()) %>">
                                <div class="ds44-introduction"><jalios:wysiwyg><%= obj.getIntro()%></jalios:wysiwyg></div>
                            </jalios:if>                         
                            <jalios:if predicate="<%= Util.notEmpty(obj.getEligibilite()) %>">
                                <section class="ds44-contenuArticle" id="section1">    
                                    <h2 class="h2-like"><%= glp("jcmsplugin.socle.titre.pour-qui") %></h2>
                                    <jalios:wysiwyg><%= obj.getEligibilite() %></jalios:wysiwyg>
                                </section>
                            </jalios:if>
                            
                            <jalios:if predicate="<%= Util.notEmpty(obj.getCestQuoi()) %>">
                                <section class="ds44-contenuArticle" id="section2">
                                    <h2 class="h2-like"><%= glp("jcmsplugin.socle.titre.quoi") %></h2>
                                    <jalios:wysiwyg><%= obj.getCestQuoi() %></jalios:wysiwyg>
                                </section>
                            </jalios:if>
                            
                            <jalios:if predicate="<%= Util.notEmpty(obj.getCommentFaireUneDemande()) %>">
                                <section class="ds44-contenuArticle" id="section3">                                                                    
                                    <h2 class="h2-like"><%= glp("jcmsplugin.socle.titre.comment-demande") %></h2>
                                    <jalios:wysiwyg><%= obj.getCommentFaireUneDemande() %></jalios:wysiwyg>
                                </section>
                            </jalios:if>
                            
                            <jalios:if predicate="<%= Util.notEmpty(obj.getQuelsDocumentsFournir()) %>">
                                <section class="ds44-contenuArticle" id="section4">
                                    <h2 class="h2-like"><%= glp("jcmsplugin.socle.titre.fournir-documents") %></h2>
                                    <jalios:wysiwyg><%= obj.getQuelsDocumentsFournir() %></jalios:wysiwyg>
                                </section>
                            </jalios:if>
                        </div>

                        <div class="col-1 grid-offset"></div>
 
                        <aside class="col-4">                   
                            <%@ include file="doFicheAideEncadre.jspf" %>                               
                        </aside>

                    </div>
                </div>

 
                <!-- FAQ -->
                <div id="id_third" class="js-tabcontent ds44-tabs__content" role="tabpanel" aria-labelledby="label_id_third" aria-hidden="true">
                    <p>FAQ à compléter</p>
                </div>

 

            </div>

        </section>

    </section>

 


</main>

<div class="ds44-modal-container" id="overlay-faire-demande" aria-hidden="true" role="dialog">
    <div class="ds44-modal-box">
        <button class="ds44-btnOverlay--modale ds44-btnOverlay--closeOverlay" type="button" aria-label='Fermer la boite de dialogue : <%= glp("jcmsplugin.socle.demande.faire-demande") %>' data-js="ds44-modal-action-close"><i class="icon icon-cross icon--xlarge" aria-hidden="true"></i><span class="ds44-btnInnerText--bottom">Fermer</span></button>

        <h1 class="h2-like" id="titre-faire-demande"><%= glp("jcmsplugin.socle.demande.faire-demande") %></h2>

        <div class="ds44-modal-gab">

            <p><%= HtmlUtil.html2text(obj.getIntroFaireUneDemande(userLang)) %></p>

            <div class="ds44-mt3 grid-12-small-1">
                <div class='col-<%= Util.notEmpty(obj.getEdemarche(loggedMember)) ? "6" : "12" %> ds44-modal-column'>
                    <h2 class="h3-like"><%= glp("jcmsplugin.socle.ficheaide.docutils.label") %></h3>

                    <jalios:select>
                        <jalios:if predicate="<%= Util.isEmpty(obj.getDocumentsUtiles()) %>">
                            <p><%= glp("jcmsplugin.socle.ficheaide.nodoc.label") %>
                        </jalios:if>
                        <jalios:default>
                            <ul class="ds44-list">
                                <jalios:foreach name="itDoc" type="FileDocument" collection="<%= Arrays.asList(obj.getDocumentsUtiles()) %>">
                                    <li class="mtm">
                                        <% 
                                        // Récupérer l'extension du fichier
                                        String fileType = FileDocument.getExtension(itDoc.getFilename()).toUpperCase();
                                        // Récupérer la taille du fichier
                                        String fileSize = Util.formatFileSize(itDoc.getSize(), userLocale);
                                        %>
                                        <p class="ds44-docListElem"><i class="icon icon-file ds44-docListIco" aria-hidden="true"></i><a href="<%= itDoc.getDownloadUrl() %>"><%= itDoc.getTitle() %></a><span class="ds44-cardFile"><%= fileType %> - <%= fileSize %></span></p>
                                    </li>
                                </jalios:foreach>
                            </ul>
                        </jalios:default>
                    </jalios:select>

                </div>
                <jalios:if predicate="<%= Util.notEmpty(obj.getEdemarche(loggedMember)) %>">
                    <div class="col-6 ds44-modal-column">

                        <h2 class="h3-like"><%= glp("jcmsplugin.socle.ficheaide.enligne.label") %></h3>

                        <p><a class="ds44-btnStd ds44-btn--invert" href="<%= obj.getUrlEdemarche(userLang)  %>" title='<%= glp("jcmsplugin.socle.ficheaide.fairedemandeligne.label") %>'><span class="ds44-btnInnerText"><%= glp("jcmsplugin.socle.ficheaide.fairedemandeligne.label") %></span><i class="icon icon-computer icon--sizeL" aria-hidden="true"></i></a></p>
                        <p><%= glp("jcmsplugin.socle.ficheaide.duree.label") %> <%= obj.getDureeEdemarche() %></p>
                    </div>
                </jalios:if>
            </div>
        </div>
    </div>  
</div>

<div class="ds44-modal-container" id="overlay-suivre-demande" aria-hidden="true" role="dialog">
    <div class="ds44-modal-box">
        <button class="ds44-btnOverlay--modale ds44-btnOverlay--closeOverlay" type="button" aria-label='Fermer la boite de dialogue : <%= glp("jcmsplugin.socle.ficheaide.suivre.label") %>' data-js="ds44-modal-action-close"><i class="icon icon-cross icon--xlarge" aria-hidden="true"></i><span class="ds44-btnInnerText--bottom">Fermer</span></button>

        <h1 class="h2-like" id="titre-suivre-demande"><%= glp("jcmsplugin.socle.ficheaide.suivre.label") %></h2>

        <div class="ds44-modal-gab">
            <p><%= HtmlUtil.html2text(obj.getIntroSuivreUneDemande(userLang)) %></p>

            <div class="ds44-mt3 grid-12-small-1">
                <div class="col-6 ds44-modal-column">
                    <h2 class="h3-like">Vous avez un code de suivi :</h3>

                    <p>Saisissez votre code de suivi (transmis à l’enregistrement de votre demande en ligne).</p>

                    <div class="ds44-form__container">
                        <label for="name" class="ds44-formLabel ds44-mb-std"><span class="ds44-labelTypePlaceholder ds44-moveLabel">Code de suivi</span> <input type="text" id="name" class="ds44-inpStd" required /></label>

                        <button class="ds44-btnStd ds44-btn--invert" type="button"><span class="ds44-btnInnerText">Valider</span><i class="icon icon-long-arrow-right" aria-hidden="true"></i></button>
                    </div>
                </div>
                <div class="col-6 ds44-modal-column">

                    <h2 class="h3-like">Vous n’avez pas de code de suivi :</h3>

                    <p><button class="ds44-btnStd ds44-btn--invert" type="button"><span class="ds44-btnInnerText">Connectez-vous</span><i class="icon icon-computer icon--sizeL" aria-hidden="true"></i></button></p>

                </div>
            </div>
        </div>
    </div>   
</div>