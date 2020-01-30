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
%>
<main id="content" role="main">
    <article class="ds44-container-large">
        <ds:titleSimple title="<%= obj.getTitle() %>" date='' userLang="<%= userLang %>" alt="<%= obj.getTexteAlternatif() %>" 
        breadcrumb="true" subtitle="<%= obj.getSoustitre() %>"></ds:titleSimple>
        
        <%-- TODO HERE : BlOC VERT --%>
        
        <section id="imageChapo" class="ds44-contenuArticle">
            <div class="ds44-inner-container ds44-mtb3">
                <div class="ds44-grid12-offset-1">
                    <div class="grid-<%= hasImage ? "2" : "1" %>-small-1">
                        <jalios:if predicate="<%= hasImage %>">
	                    <div class='col mrl mbs<%= Util.isEmpty(obj.getImageMobile()) ? " ds44-hide-mobile" : ""%>'>
	                       <jalios:if predicate="<%= hasFigcaption%>">
			               <figure role="figure">
			               </jalios:if>
	                       <picture class="ds44-legendeContainer ds44-container-imgRatio" role="figure" aria-label='<%= obj.getLegende() %> <%= JcmsUtil.glp(userLang, "jcmsplugin.socle.symbol.copyright") %> <%= obj.getCopyright() %>'>
		                      <source media="(max-width: 36em)" srcset='<%=Util.isEmpty(obj.getImageMobile()) ? "s.gif" : obj.getImageMobile() %>'>
		                      <source media="(min-width: 36em)" srcset="<%=obj.getImagePrincipale()%>">
		                      <img src="<%=obj.getImagePrincipale()%>" alt='<%= Util.isEmpty(obj.getTexteAlternatif()) ? JcmsUtil.glp(userLang, "jcmsplugin.socle.illustration") : obj.getTexteAlternatif() %>' class="ds44-w100 ds44-imgRatio" id="<%=uid%>"/>
		                   </picture>
		                   <jalios:if predicate="<%= hasFigcaption%>">
			                   <figcaption class="ds44-imgCaption">
			                     <jalios:if predicate="<%= Util.notEmpty(obj.getLegende())%>">
			                         <%=obj.getLegende()%>
			                     </jalios:if>
			                     <jalios:if predicate="<%= Util.notEmpty(obj.getCopyright())%>">
			                         © <%=obj.getCopyright()%>
			                     </jalios:if>
			                  </figcaption>
		                  </figure>
		                  </jalios:if>
	                    </div>
	                    </jalios:if>
	                    <div class="col mll mbs">
	                        <p class="ds44-wsg-exergue"><%= obj.getFormat(loggedMember).first().getName() %></p>
	                        <div class="ds44-introduction"><jalios:wysiwyg><%= obj.getChapo() %></jalios:wysiwyg></div>
	                    </div>
                    </div>
                </div>
            </div>
        </section>
        
        <section id="enDetails" class="ds44-contenuArticle">
            <div class="ds44-inner-container ds44-mtb3">
                <div class="ds44-grid12-offset-2">
                    <h2 class="h2-like" id="titreEnDetails"><%= glp("jcmsplugin.socle.titre.endetails") %></h2>
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
	                        <jalios:if predicate="<%= Util.notEmpty(obj.getDocumentsJointsBlocN1()) %>">
	                            <jalios:if predicate="<%= Util.notEmpty(currentDocBlocTitle) %>">
	                            <p class="ds44-box-heading" role="heading" aria-level="2"><%= currentDocBlocTitle %></p>
	                            </jalios:if>
	                            <jalios:foreach name="itDoc" type="FileDocument" array="<%= currentDocBlocElements %>"><%
	                            // Récupérer l'extension du fichier
	                            String fileType = FileDocument.getExtension(itDoc.getFilename()).toUpperCase();
	                            // Récupérer la taille du fichier
	                            String fileSize = Util.formatFileSize(itDoc.getSize(), userLocale);
	                            %>
	                            <p class="ds44-docListElem"><i class="icon icon-file ds44-docListIco" aria-hidden="true"></i><a href="<%= itDoc.getDownloadUrl() %>"><%= itDoc.getTitle() %></a><span class="ds44-cardFile"><%= fileType %> - <%= fileSize %></span></p>
	                            </jalios:foreach>
	                        </jalios:if>
	                        <%
                            }
	                        %>
                        </jalios:if>
                        <jalios:if predicate="<%= Util.notEmpty(obj.getAdresseSiteInternet()) %>">
                            <jalios:if predicate="<%= Util.notEmpty(obj.getTitreEncartSiteInternet()) %>">
                            <p class="ds44-box-heading" role="heading" aria-level="2"><%= obj.getTitreEncartSiteInternet() %></p>
                            </jalios:if>
                            <jalios:foreach name="itAdresse" type="String" array="<%= obj.getAdresseSiteInternet() %>" counter="itSiteCpt">
                            <%
                            boolean hasAssociatedTitle = Util.isEmpty(obj.getNomDuSite()) ? false : 
                            	obj.getNomDuSite().length < itSiteCpt ? false :
                            	Util.notEmpty(obj.getNomDuSite()[itSiteCpt-1]);
                            String lbl = hasAssociatedTitle ? obj.getNomDuSite()[itSiteCpt-1] : itAdresse;
                            %>
                            <p class="ds44-docListElem"><i class="icon icon-link ds44-docListIco" aria-hidden="true"></i><a href="<%= itAdresse %>"><%= lbl %></a></p>
                            </jalios:foreach>
                        </jalios:if>
                    </div>
                </div>
            </div>
        </section>
        </jalios:if>
    </article>
</main>