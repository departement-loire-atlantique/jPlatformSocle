<%@ page contentType="text/html; charset=UTF-8" %><%
%><%@ include file='/jcore/doInitPage.jspf' %><%
%><% FicheAide obj = (FicheAide)request.getAttribute(PortalManager.PORTAL_PUBLICATION); %>


<main role="main" id="content">

 

    <section class="ds44-container-fluid">

 

        <div class="ds44-pageHeaderContainer">
            <!-- TODO condition sur l'image mobile -->
            <picture class="ds44-pageHeaderContainer__pictureContainer">
                <img src="<%=obj.getImagePrincipale()%>" alt="" class="ds44-headerImg" />               
            </picture>
            <div class="ds44-titleContainer">
                <div class="ds44-alphaGradient ds44--xl-padding">
                    <!-- Fil d'ariane (TODO : à mettre en property) -->
                    <jalios:include id="c_1088465"/>
                    <h1 class="h1-like ds44-text--colorInvert"><%= obj.getTitle() %></h1>
                </div>
            </div>
        </div>

                    

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
                            <button class="ds44-btnStd ds44-btn--invert" type="button"><span class="ds44-btnInnerText"><%= glp("jcmsplugin.socle.demande.qui-contacter") %></span><i class="icon icon-phone icon--sizeL" aria-hidden="true"></i></button>
                        </li>
                        <li class="mrs ds44-ongletsBtnItem">
                            <button class="ds44-btnStd ds44-btn--invert" type="button"><span class="ds44-btnInnerText"><%= glp("jcmsplugin.socle.demande.faire-demande") %></span><i class="icon icon-file icon--sizeL" aria-hidden="true"></i></button>
                        </li>
                        <li class="mrs ds44-ongletsBtnItem">
                            <button class="ds44-btnStd ds44-btn--invert" type="button"><span class="ds44-btnInnerText"><%= glp("jcmsplugin.socle.demande.suivre-demande") %></span><i class="icon icon-computer icon--sizeL" aria-hidden="true"></i></button>
                        </li>
                    </ul>

                </div>

                
                <!--  En résumé -->
                <div id="id_first" class="js-tabcontent ds44-tabs__content" role="tabpanel" aria-labelledby="label_id_first">

                    <div class="grid-12-small-1">
                        <div class="col-7">
                            <jalios:if predicate="<%= Util.notEmpty(obj.getChapo()) %>">
                                <p class="ds44-introduction"><%= obj.getChapo() %></p>
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
                            <jalios:if predicate="<%= Util.notEmpty(obj.getEligibilite()) %>">
                                <h2 class="h2-like"><%= glp("jcmsplugin.socle.titre.pour-qui") %></h2>
                                <jalios:wysiwyg><%= obj.getEligibilite() %></jalios:wysiwyg>
                            </jalios:if>
                            
                            <jalios:if predicate="<%= Util.notEmpty(obj.getCestQuoi()) %>">
                                <h2 class="h2-like"><%= glp("jcmsplugin.socle.titre.quoi") %></h2>
                                <jalios:wysiwyg><%= obj.getCestQuoi() %></jalios:wysiwyg>
                            </jalios:if>
                            
                            <jalios:if predicate="<%= Util.notEmpty(obj.getCommentFaireUneDemande()) %>">
                                <h2 class="h2-like"><%= glp("jcmsplugin.socle.titre.comment-demande") %></h2>
                                <jalios:wysiwyg><%= obj.getCommentFaireUneDemande() %></jalios:wysiwyg>
                            </jalios:if>
                            
                            <jalios:if predicate="<%= Util.notEmpty(obj.getQuelsDocumentsFournir()) %>">
                                <h2 class="h2-like"><%= glp("jcmsplugin.socle.titre.fournir-documents") %></h2>
                                <jalios:wysiwyg><%= obj.getQuelsDocumentsFournir() %></jalios:wysiwyg>
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