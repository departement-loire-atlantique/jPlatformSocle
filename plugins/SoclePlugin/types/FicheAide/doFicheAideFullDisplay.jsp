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
                            <button class="ds44-btnStd ds44-btn--invert" type="button"><span class="ds44-btnInnerText">Qui contacter</span><i class="icon icon-phone icon--sizeL" aria-hidden="true"></i></button>
                        </li>
                        <li class="mrs ds44-ongletsBtnItem">
                            <button class="ds44-btnStd ds44-btn--invert" type="button"><span class="ds44-btnInnerText">Faire une demande</span><i class="icon icon-file icon--sizeL" aria-hidden="true"></i></button>
                        </li>
                        <li class="mrs ds44-ongletsBtnItem">
                            <button class="ds44-btnStd ds44-btn--invert" type="button"><span class="ds44-btnInnerText">Suivre ma demande</span><i class="icon icon-computer icon--sizeL" aria-hidden="true"></i></button>
                        </li>
                    </ul>

                </div>

                
                <!--  En résumé -->
                <div id="id_first" class="js-tabcontent ds44-tabs__content" role="tabpanel" aria-labelledby="label_id_first">

                    <div class="grid-12-small-1">
                        <div class="col-7">
                            <p class="ds44-introduction"><%= obj.getChapo() %></p>
                            <h2 class="h2-like mtm"><%= glp("jcmsplugin.socle.titre.pour-qui") %></h2>
                            <jalios:wysiwyg><%= obj.getPrecisionsBeneficiaires() %></jalios:wysiwyg>                                        
                        </div>

                        <div class="col-1 grid-offset"></div>

                        <aside class="col-4">     
                            <!-- Bon à savoir -->              
                            <section class="ds44-box ds44-theme ds44-mb3">
                                <div class="ds44-innerBoxContainer">
                                    <p role="heading" aria-level="2" class="ds44-box-heading"><%= obj.getTitreEncartBonASavoir() %></p>
                                    <jalios:wysiwyg><%= obj.getBonASavoir() %></jalios:wysiwyg>
                                </div>
                            </section>

                            <!-- Témoignages -->  
                            <section class="ds44-box">
                                <p role="heading" aria-level="2" class="ds44-box-heading"><%= glp("jcmsplugin.socle.temoignage") %></p>
                                <div class="ds44-bgGray">
                                  <picture><img src="../../assets/images/sample-media.jpg" alt="" class="ds44-card__img" /><span class="ds44-mediaIndicator"><i class="icon icon-play" aria-hidden="true"></i></span></picture>
                                  <div class="ds44--m-padding">
                                    <p role="heading" aria-level="3"><a href="#">Monique a aménagé son logement</a></p>
                                    <p>86 ans - Retraitée - Nantes</p>
                                  </div>
                                </div>
                            </section>
                            
                            <!-- Potlet encadrés -->
                            <jalios:foreach array="<%= obj.getPortletEncadres() %>" name="itPortlet" type="Portlet">
                                <jalios:include pub="<%= itPortlet %>" />
                            </jalios:foreach>
                            
                        </aside>
                    </div>

                </div>

 
                <!-- En détail -->
                <div id="id_second" class="js-tabcontent ds44-tabs__content" role="tabpanel" aria-labelledby="label_id_second" aria-hidden="true">      
                
                    <div class="grid-12-small-1">
                        <div class="col-7">                 
                            <h2 class="h2-like"><%= glp("jcmsplugin.socle.titre.pour-qui") %></h2>
                            <jalios:wysiwyg><%= obj.getEligibilite() %></jalios:wysiwyg>
                            
                            <h2 class="h2-like"><%= glp("jcmsplugin.socle.titre.quoi") %></h2>
                            <jalios:wysiwyg><%= obj.getDescription() %></jalios:wysiwyg>

                            <h2 class="h2-like"><%= glp("jcmsplugin.socle.titre.comment-demande") %></h2>
                            <jalios:wysiwyg><%= obj.getModalites() %></jalios:wysiwyg>
        
                            <h2 class="h2-like"><%= glp("jcmsplugin.socle.titre.fournir-documents") %></h2>
                            <jalios:wysiwyg><%= obj.getPiecesAFournir() %></jalios:wysiwyg>
                        </div>

                        <div class="col-1 grid-offset"></div>
 
                        <aside class="col-4">                   
                            <!-- Bon à savoir --> 
                            <section class="ds44-box ds44-theme ds44-mb3">
                                <div class="ds44-innerBoxContainer">
                                    <p role="heading" aria-level="2" class="ds44-box-heading"><%= obj.getTitreEncartBonASavoir() %></p>
                                    <jalios:wysiwyg><%= obj.getBonASavoir() %></jalios:wysiwyg>
                                </div>
                            </section>
                       
                            <!-- Témoignages --> 
                            <section class="ds44-box">
                                <p role="heading" aria-level="2" class="ds44-box-heading">Témoignages</p>
                                <div class="ds44-bgGray">
                                  <picture><img src="../../assets/images/sample-media.jpg" alt="" class="ds44-card__img" /><span class="ds44-mediaIndicator"><i class="icon icon-play" aria-hidden="true"></i></span></picture>
                                  <div class="ds44--m-padding">
                                    <p role="heading" aria-level="3"><a href="#">Monique a aménagé son logement</a></p>
                                    <p>86 ans - Retraitée - Nantes</p>
                                  </div>
                                </div>
                             </section>
                              
                             <!-- Potlet encadrés -->
                             <jalios:foreach array="<%= obj.getPortletEncadres() %>" name="itPortlet" type="Portlet">
                                <jalios:include pub="<%= itPortlet %>" />
                             </jalios:foreach>                              
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