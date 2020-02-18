<%@page import="fr.cg44.plugin.socle.SocleUtils"%>
<%@ page contentType="text/html; charset=UTF-8" %><%
%><%@ taglib prefix="ds" tagdir="/WEB-INF/tags"%><%
%><%@ include file='/jcore/doInitPage.jspf' %><%
%><% FicheActionEducative obj = (FicheActionEducative)request.getAttribute(PortalManager.PORTAL_PUBLICATION); %>
<%
String uid = ServletUtil.generateUniqueDOMId(request, "uid");
boolean hasFigcaption = Util.notEmpty(obj.getLegende()) || Util.notEmpty(obj.getCopyright());
boolean hasImage = Util.notEmpty(obj.getImagePrincipale()) || Util.notEmpty(obj.getImageMobile());

boolean hasBlocRessource = Util.notEmpty(obj.getDocumentsJointsBlocN1()) || Util.notEmpty(obj.getDocumentsJointsBlocN2()) 
        || Util.notEmpty(obj.getDocumentsJointsBlocN3()) || Util.notEmpty(obj.getAdresseSiteInternet());

boolean hasDocRessources = Util.notEmpty(obj.getDocumentsJointsBlocN1()) || Util.notEmpty(obj.getDocumentsJointsBlocN2()) || Util.notEmpty(obj.getDocumentsJointsBlocN3());

boolean hasParcoursCollege = obj.getCategorySet().contains(channel.getCategory("$jcmsplugin.socle.ficheactioneducative.monParcoursCollege.root"));
%>
<main id="content" role="main">
    <article class="ds44-container-large">
        <ds:titleSimple title="<%= obj.getTitle() %>" date='' userLang="<%= userLang %>" alt="<%= obj.getTexteAlternatif() %>" 
        breadcrumb="true" subtitle="<%= obj.getSoustitre() %>"></ds:titleSimple>
        
        <div class="ds44-img50 ds44--l-padding-tb">
            <div class="ds44-inner-container">
                <div class="ds44-grid12-offset-1">
                    <section class="ds44-box ds44-theme">
                        <div class="ds44-innerBoxContainer">
                            <div class="grid-12-small-1 ds44-grid12-offset-1">
                                <div class='col col-<%= hasParcoursCollege ? "5" : "6"%>'>
                                    <div class="ds44-box-heading" role="heading" aria-level="3"><%= glp("jcmsplugin.socle.actuedu.infopratiques.label") %></div>
                                    <jalios:if predicate="<%= Util.notEmpty(obj.getTheme(loggedMember)) || Util.notEmpty(obj.getSoustheme(loggedMember)) || Util.notEmpty(obj.getParcoursEducationNationale(loggedMember)) %>">
                                    <div class="ds44-docListElem mts">
                                        <i class="icon icon-tag ds44-docListIco" aria-hidden="true"></i>
                                        <jalios:if predicate="<%= Util.notEmpty(obj.getTheme(loggedMember)) %>">
                                            <strong> <%= SocleUtils.formatCategories(obj.getTheme(loggedMember)) %></strong>
                                        </jalios:if>
                                        <jalios:if predicate="<%= Util.notEmpty(obj.getSoustheme(loggedMember)) %>">
                                            <jalios:if predicate="<%= Util.notEmpty(obj.getTheme(loggedMember)) %>"><br/></jalios:if>
                                            <%= SocleUtils.formatCategories(obj.getSoustheme(loggedMember)) %>
                                        </jalios:if>
                                        <jalios:if predicate="<%= Util.notEmpty(obj.getParcoursEducationNationale(loggedMember)) %>">
                                            <jalios:if predicate="<%= Util.notEmpty(obj.getTheme(loggedMember)) || Util.notEmpty(obj.getSoustheme(loggedMember)) %>"><br/></jalios:if>
                                            <%= SocleUtils.formatCategories(obj.getParcoursEducationNationale(loggedMember)) %>
                                        </jalios:if>
                                    </div>
                                    </jalios:if>
                                    <jalios:if predicate="<%= Util.notEmpty(obj.getTypeDePratique(loggedMember)) %>">
                                    <div class="ds44-docListElem mts">
                                        <strong><%= glp("jcmsplugin.socle.actuedu.typepratique.label") %></strong> <%= SocleUtils.formatCategories(obj.getTypeDePratique(loggedMember)) %>
                                    </div>
                                    </jalios:if>
                                    <jalios:if predicate="<%= Util.notEmpty(obj.getNiveau(loggedMember)) || Util.notEmpty(obj.getCapaciteDaccueil()) %>">
                                    <div class="ds44-docListElem mts">
                                        <i class="icon icon-user-group ds44-docListIco" aria-hidden="true"></i>
                                        <jalios:if predicate="<%= Util.notEmpty(obj.getNiveau(loggedMember)) %>">
                                            <%= SocleUtils.formatCategories(obj.getNiveau(loggedMember)) %>
                                        </jalios:if>
                                        <jalios:if predicate="<%= Util.notEmpty(obj.getCapaciteDaccueil()) %>">
                                            <jalios:if predicate="<%= Util.notEmpty(obj.getNiveau(loggedMember)) %>"><br/></jalios:if>
                                            <jalios:wysiwyg><%= obj.getCapaciteDaccueil() %></jalios:wysiwyg>
                                        </jalios:if>
                                    </div>
                                    </jalios:if>
                                    <jalios:if predicate="<%= Util.notEmpty(obj.getCout()) %>">
                                    <div class="ds44-docListElem mts">
                                        <i class="icon icon-cost ds44-docListIco" aria-hidden="true"></i> <jalios:wysiwyg><%= obj.getCout() %></jalios:wysiwyg>
                                    </div>
                                    </jalios:if>
                                    <div class="ds44-docListElem mts">
                                        <i class="icon icon-bus ds44-docListIco" aria-hidden="true"></i> <strong><%= glp("jcmsplugin.socle.actuedu.prisechargedeplacement.label") %></strong> <%= obj.getPriseEnChargeDeplacementLabel(userLang) %>
                                    </div>
                                    <div class="ds44-docListElem mts">
                                        <i class="icon icon-time ds44-docListIco" aria-hidden="true"></i> <jalios:wysiwyg><%= obj.getDuree() %></jalios:wysiwyg>
                                    </div>
                                    <div class="ds44-docListElem mts">
                                        <i class="icon icon-date ds44-docListIco" aria-hidden="true"></i>
                                        <jalios:wysiwyg><%= obj.getDepotDuDossier().replace("<div class=\"wysiwyg\"><p>", "<div class=\"wysiwyg\"><p>" + "<strong>" + glp("jcmsplugin.socle.actuedu.depotdossier.label") + "</strong> ") %></jalios:wysiwyg>
                                        <strong><%= glp("jcmsplugin.socle.actuedu.realisationaction.label") %></strong> <jalios:wysiwyg><%= obj.getRealisationDeLaction() %></jalios:wysiwyg>
                                    </div>
                                </div>
                                <div class="col col-<%= hasParcoursCollege ? "5" : "6"%> ds44--xl-padding-l">
                                    <p class="ds44-box-heading" role="heading" aria-level="3"><%= glp("jcmsplugin.socle.actuedu.votrecontact.label") %></p>
                                    <div class="ds44-docListElem mts">
                                        <i class="icon icon-user ds44-docListIco" aria-hidden="true"></i><%= obj.getNomEtPrenomContacts() %>
                                        <jalios:if predicate="<%= Util.notEmpty(obj.getDirection()) %>">
                                            <br/><%= obj.getDirection() %>
                                        </jalios:if>
                                        <jalios:if predicate="<%= Util.notEmpty(obj.getService()) %>">
                                            <br/><%= obj.getService() %><br/>
                                        </jalios:if>
                                        <%= SocleUtils.formatAddress(null, null, null, obj.getNdeVoie(), obj.getLibelleDeVoie(), null, obj.getCs(), obj.getCodePostal(), obj.getCommune().getTitle(), obj.getCedex()) %>
                                    </div>
                                    <div class="ds44-docListElem mts">
                                        <i class="icon icon-phone ds44-docListIco" aria-hidden="true"></i>
                                        <jalios:foreach name="itPhone" type="String" array="<%= obj.getTelephone() %>">
                                            <ds:phone number="<%= itPhone %>"></ds:phone>
                                        </jalios:foreach>
                                    </div>
                                    <div class="ds44-docListElem mts">
                                        <i class="icon icon-mail ds44-docListIco" aria-hidden="true"></i>
                                        <jalios:select>
                                            <jalios:if predicate="<%= obj.getMail().length == 1 %>">
                                            <%-- TODO : remplacer par un formulaire de contact --%>
                                            <a href="mailto:<%= obj.getMail()[0] %>" title='<%= HttpUtil.encodeForHTMLAttribute(glp("jcmsplugin.socle.actuedu.nouscontacter.label")) %>'><%= glp("jcmsplugin.socle.actuedu.nouscontacter.label") %></a>
                                            </jalios:if>
                                            <jalios:default>
                                                <jalios:foreach name="itMail" type="String" array="<%= obj.getMail() %>">
                                                <a href="mailto:<%= itMail %>" aria-label='<%= HttpUtil.encodeForHTMLAttribute(glp("jcmsplugin.socle.actuedu.contactmail.label", itMail)) %>'><%= itMail %></a>
                                                </jalios:foreach>
                                            </jalios:default>
                                        </jalios:select>
                                    </div>
                                    
                                    <%-- TODO : boutons s'inscrire et suivre ma demande --%>
                                </div>
                                <jalios:if predicate='<%= hasParcoursCollege %>'>
                                <div class="col col-2 ds44--xl-padding-l ds44-hide-mobile">
                                    <image id="imageParcoursCollege" class="medium-w25 small-w25 tiny-w50" src='<%= channel.getCategory("$jcmsplugin.socle.ficheactioneducative.monParcoursCollege.root").getImage() %>' alt=""/>
                                </div>
                                </jalios:if>
                            </div>
                        </div>
                    </section>
                </div>
            </div>
        </div>
        
        <section id="imageChapo" class="ds44-contenuArticle">
            <div class="ds44-inner-container ds44-mtb3">
                <div class="ds44-grid12-offset-1">
                    <div class="grid-<%= hasImage ? "2" : "1" %>-small-1">
                        <jalios:if predicate="<%= hasImage %>">
                        <div class='col mrl mbs<%= Util.isEmpty(obj.getImageMobile()) ? " ds44-hide-mobile" : ""%>'>
                           <jalios:if predicate="<%= hasFigcaption%>">
                           <figure role="figure">
                           <picture class="ds44-legendeContainer ds44-container-imgRatio" role="figure" aria-label='<%= HttpUtil.encodeForHTMLAttribute(obj.getLegende() + " " + JcmsUtil.glp(userLang, "jcmsplugin.socle.symbol.copyright") + " " + obj.getCopyright()) %>'>
                           </jalios:if>
                           <jalios:if predicate="<%= !hasFigcaption %>">
                           <picture class="ds44-legendeContainer ds44-container-imgRatio" role="figure">
                           </jalios:if>
                              <source media="(max-width: 36em)" srcset='<%=Util.isEmpty(obj.getImageMobile()) ? "s.gif" : obj.getImageMobile() %>'>
                              <source media="(min-width: 36em)" srcset="<%=obj.getImagePrincipale()%>">
                              <img src="<%=obj.getImagePrincipale()%>" alt='<%= Util.isEmpty(obj.getTexteAlternatif()) ? HttpUtil.encodeForHTMLAttribute(JcmsUtil.glp(userLang, "jcmsplugin.socle.illustration")) : HttpUtil.encodeForHTMLAttribute(obj.getTexteAlternatif()) %>' class="ds44-w100 ds44-imgRatio" id="<%=uid%>"/>
                           </picture>
                           <jalios:if predicate="<%= hasFigcaption%>">
                               <figcaption class="ds44-imgCaption">
                                 <jalios:if predicate="<%= Util.notEmpty(obj.getLegende())%>">
                                     <%=obj.getLegende()%>
                                 </jalios:if>
                                 <jalios:if predicate="<%= Util.notEmpty(obj.getCopyright())%>">
                                     <%= JcmsUtil.glp(userLang, "jcmsplugin.socle.symbol.copyright") %> <%=obj.getCopyright()%>
                                 </jalios:if>
                              </figcaption>
                          </figure>
                          </jalios:if>
                        </div>
                        </jalios:if>
                        <div class='col <%= hasImage ? "mll" : "" %> mbs'>
                            <p class="ds44-wsg-exergue"><%= obj.getFormat(loggedMember).first().getName() %></p>
                            <div class="ds44-mb-std"></div>
                            <div class="ds44-introduction"><jalios:wysiwyg><%= obj.getChapo() %></jalios:wysiwyg></div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        
        <section id="enDetails" class="ds44-contenuArticle">
            <div class="ds44-inner-container ds44-mtb3">
                <div class="ds44-grid12-offset-2">
                    <h3 class="h2-like" id="titreEnDetails"><%= glp("jcmsplugin.socle.titre.endetails") %></h2>
                    <jalios:wysiwyg><%= obj.getDescription() %></jalios:wysiwyg>
                </div>
            </div>
        </section>
        
        <jalios:if predicate="<%= Util.notEmpty(obj.getPublicVise()) %>">
        <section id="publicVise" class="ds44-contenuArticle">
            <div class="ds44-inner-container ds44-mtb3">
                <div class="ds44-grid12-offset-2">
                    <h3 class="h3-like" id="titrePublicVise"><%= glp("jcmsplugin.socle.titre.publicvise") %></h2>
                    <jalios:wysiwyg><%= obj.getPublicVise() %></jalios:wysiwyg>
                </div>
            </div>
        </section>
        </jalios:if>
        
        <jalios:if predicate="<%= Util.notEmpty(obj.getCalendrierEtInscription()) %>">
        <section id="calendrierInscriptions" class="ds44-contenuArticle">
            <div class="ds44-inner-container ds44-mtb3">
                <div class="ds44-grid12-offset-2">
                    <h3 class="h3-like" id="titreCalendrierInscriptions"><%= glp("jcmsplugin.socle.titre.calinscriptions") %></h2>
                    <jalios:wysiwyg><%= obj.getCalendrierEtInscription() %></jalios:wysiwyg>
                </div>
            </div>
        </section>
        </jalios:if>
        
        <jalios:if predicate="<%= Util.notEmpty(obj.getVideo()) %>">
        <section id="contentVideo" class="ds44-contenuArticle">
            <div class="ds44-inner-container ds44-mtb3">
                <div class="ds44-grid12-offset-2">
                    <jalios:if predicate="<%= Util.notEmpty(obj.getTitreVideo()) %>">
                    <h3 class="h3-like" id="titreVideo"><%= obj.getTitreVideo() %></h2>
                    </jalios:if>
                    <%-- TODO : INSERER LA VIDEO --%>
                </div>
            </div>
        </section>
        </jalios:if>
        
        <jalios:if predicate="<%= Util.notEmpty(obj.getComplementTransport()) %>">
        <section id="complementTransport" class="ds44-contenuArticle">
            <div class="ds44-inner-container ds44-mtb3">
                <div class="ds44-grid12-offset-2">
                    <div class="ds44-wsg-encadreContour">
                        <h3 class="h3-like" id="titreComplementTransport"><%= glp("jcmsplugin.socle.titre.complementtransports") %></h2>
                        <jalios:wysiwyg><%= obj.getComplementTransport() %></jalios:wysiwyg>
                    </div>
                </div>
            </div>
        </section>
        </jalios:if>
        
        <jalios:if predicate="<%= Util.notEmpty(obj.getPartenairesIntervenants()) %>">
        <section id="partenairesIntervenants" class="ds44-contenuArticle">
            <div class="ds44-inner-container ds44-mtb3">
                <div class="ds44-grid12-offset-2">
                    <h3 class="h3-like" id="titrePartenairesIntervenants"><%= glp("jcmsplugin.socle.titre.partenairesintervenants") %></h2>
                    <jalios:wysiwyg><%= obj.getPartenairesIntervenants() %></jalios:wysiwyg>
                </div>
            </div>
        </section>
        </jalios:if>
        
        <jalios:if predicate="<%= hasBlocRessource %>">
        <% boolean addLineBreak = false; %>
        <section id="blocRessources" class="ds44-contenuArticle">
            <div class="ds44-inner-container ds44-mtb3">
                <div class="ds44-grid12-offset-2">
                    <div class="ds44-wsg-encadreApplat">
                        <jalios:if predicate="<%= hasDocRessources %>">
                            <% 
                            String currentDocBlocTitle = "";
                            FileDocument[] currentDocBlocElements = new FileDocument[0];
                            
                            for (int blocDocCpt = 1; blocDocCpt <= 3; blocDocCpt++) {
                                if (Util.isEmpty(obj.getFieldValue("documentsJointsBlocN" + blocDocCpt))) continue;
                                currentDocBlocTitle = (String) obj.getFieldValue("titreEncartDocumentBlocN" + blocDocCpt);
                                currentDocBlocElements = (FileDocument[]) obj.getFieldValue("documentsJointsBlocN" + blocDocCpt);
                            %>  
                                <ul class="ds44-list">
                                <jalios:if predicate="<%= Util.notEmpty(currentDocBlocTitle) %>">
                                <p class='ds44-box-heading <%= addLineBreak ? "ds44-mt-std" : "" %>' role="heading" aria-level="2"><%= currentDocBlocTitle %></p>
                                </jalios:if>
                                <jalios:foreach name="itDoc" type="FileDocument" array="<%= currentDocBlocElements %>">
                                <li class="mts">
                                <%
                                // Récupérer l'extension du fichier
                                String fileType = FileDocument.getExtension(itDoc.getFilename()).toUpperCase();
                                // Récupérer la taille du fichier
                                String fileSize = Util.formatFileSize(itDoc.getSize(), userLocale);
                                %>
                                <p class="ds44-docListElem"><i class="icon icon-file ds44-docListIco" aria-hidden="true"></i><a href="<%= itDoc.getDownloadUrl() %>"><%= itDoc.getTitle() %></a><span class="ds44-cardFile"><%= fileType %> - <%= fileSize %></span></p>
                                </li>
                                </jalios:foreach>
                                <% addLineBreak = true; %>
                                </ul>
                            <%
                            } // end of for
                            %>
                        </jalios:if>
                        <jalios:if predicate="<%= Util.notEmpty(obj.getAdresseSiteInternet()) %>">
                            <jalios:if predicate="<%= addLineBreak %>">
                                <br/>
                                <% addLineBreak = false; %>
                            </jalios:if>
                            <jalios:if predicate="<%= Util.notEmpty(obj.getTitreEncartSiteInternet()) %>">
                            <p class='ds44-box-heading <%= addLineBreak ? "ds44-mt-std" : "" %>' role="heading" aria-level="2"><%= obj.getTitreEncartSiteInternet() %></p>
                            </jalios:if>
                            <jalios:foreach name="itAdresse" type="String" array="<%= obj.getAdresseSiteInternet() %>" counter="itSiteCpt">
                            <%
                            boolean hasAssociatedTitle = Util.isEmpty(obj.getNomDuSite()) ? false : 
                                obj.getNomDuSite().length < itSiteCpt ? false :
                                Util.notEmpty(obj.getNomDuSite()[itSiteCpt-1]);
                            String lbl = hasAssociatedTitle ? obj.getNomDuSite()[itSiteCpt-1] : itAdresse;
                            %>
                            <p class="ds44-docListElem"><i class="icon icon-link ds44-docListIco" aria-hidden="true"></i><a target="_blank" title='<%= HttpUtil.encodeForHTMLAttribute(glp("jcmsplugin.socle.nouvelonglet", lbl)) %>' href="<%= SocleUtils.parseUrl(itAdresse) %>"><%= lbl %></a></p>
                            </jalios:foreach>
                        </jalios:if>
                    </div>
                </div>
            </div>
        </section>
        </jalios:if>
    </article>
</main>