<%@page import="fr.cg44.plugin.socle.infolocale.entities.DossierPresse"%>
<%@page import="fr.cg44.plugin.socle.SocleUtils"%>
<%@page import="fr.cg44.plugin.socle.infolocale.entities.Langue"%>
<%@page import="org.json.JSONObject"%>
<%@page import="fr.cg44.plugin.socle.infolocale.InfolocaleEntityUtils"%>
<%@page import="fr.cg44.plugin.socle.infolocale.RequestManager"%>
<%@page import="fr.cg44.plugin.socle.infolocale.util.InfolocaleUtil"%>
<%@page import="fr.cg44.plugin.socle.infolocale.entities.DateInfolocale"%>
<%@ page contentType="text/html; charset=UTF-8" %><%
%><%@ taglib prefix="ds" tagdir="/WEB-INF/tags"%><%
%><%@ include file='/jcore/doInitPage.jspf' %><%
%><% EvenementInfolocale obj = (EvenementInfolocale)request.getAttribute(PortalManager.PORTAL_PUBLICATION); %><%

DateInfolocale currentDisplayedDate = InfolocaleUtil.getClosestDate(obj);

String urlPhoto = "";
String legend = "";
String credit = "";

if (Util.notEmpty(obj.getPhotos()) && obj.getPhotos().length > 0) {
  urlPhoto = obj.getPhotos()[0].getPath();
  legend = obj.getPhotos()[0].getLegend();
  credit = obj.getPhotos()[0].getCredit();
}

String labelLegendCopyright = legend;
if (Util.notEmpty(legend) && Util.notEmpty(credit)) {
  labelLegendCopyright += " " + glp("jcmsplugin.socle.symbol.copyright") + " ";
}
labelLegendCopyright += credit;

String displayedTitle = Util.notEmpty(obj.getTitreLibre()) ? obj.getTitreLibre() : obj.getTitle();

boolean texteCourtEmpty = Util.isEmpty(obj.getTexteCourt()) || "null".equals(obj.getTexteCourt());
boolean descEmpty = Util.isEmpty(obj.getDescription()) || "null".equals(obj.getDescription());
%>

<main role="main" id="content">
   <article class="ds44-container-large">
      <div class="ds44-lightBG ds44-posRel">
         <div class="ds44-inner-container ds44--xl-padding-t ds44--m-padding-b ds44-mobile-reduced-pt">
            <jalios:if predicate='<%= Util.notEmpty(Channel.getChannel().getProperty("jcmsplugin.socle.portlet.filariane.id")) %>'>
                <jalios:include id='<%=Channel.getChannel().getProperty("jcmsplugin.socle.portlet.filariane.id") %>'/>
            </jalios:if>
            <div class="ds44-grid12-offset-2">
               <h1 class="h1-like mbl mts ds44-mobile-reduced-mb ds44-mobile-reduced-mt"><%= displayedTitle %></h1>
            </div>
         </div>
      </div>
      
      <jalios:buffer name="eventSummary">
        <div class="ds44-img50 ds44-img50--event">
            <div class="ds44-inner-container">
                <div class="ds44-grid12-offset-1">
                    <div class="ds44-theme ds44-flex-valign-center ds44-flex-container ds44-fse ds44--l-padding ">
			           <span class="ds44-docListElem h4-like ds44-inlineBlock">
			              <i class="icon icon-date icon--sizeM ds44-docListIco ds44-posTop7" aria-hidden="true"></i>
			              <jalios:select>
			                 <jalios:if predicate="<%= InfolocaleUtil.infolocaleDateIsSingleDay(currentDisplayedDate) %>">
			                    <%= InfolocaleUtil.getDayOfMonthLabel(currentDisplayedDate.getDebut()) %> <%= InfolocaleUtil.getMonthLabel(currentDisplayedDate.getDebut(), false) %>
			                 </jalios:if>
			                 <jalios:default>
			                    <%= InfolocaleUtil.getDayOfMonthLabel(currentDisplayedDate.getDebut()) %> <%= InfolocaleUtil.getMonthLabel(currentDisplayedDate.getDebut(), false) %>
			                    -
			                    <%= InfolocaleUtil.getDayOfMonthLabel(currentDisplayedDate.getFin()) %> <%= InfolocaleUtil.getMonthLabel(currentDisplayedDate.getFin(), false) %>
			                 </jalios:default>
			              </jalios:select>
			           </span>
			           <jalios:if predicate="<%= Util.notEmpty(obj.getGenre()) %>">
			              <span class="ds44-docListElem"><i class="icon icon-tag ds44-docListIco" aria-hidden="true"></i><%= obj.getGenre().getLibelle() %></span>
			           </jalios:if>
			           <jalios:if predicate="<%= Util.notEmpty(obj.getLieu()) && Util.notEmpty(obj.getLieu().getCommune()) %>">
			              <span class="ds44-docListElem"><i class="icon icon-marker ds44-docListIco" aria-hidden="true"></i><%= obj.getLieu().getCommune().getNom() %></span>
			           </jalios:if>
			           <jalios:if predicate="<%= Util.notEmpty(currentDisplayedDate.getHoraire()) %>">
			              <span class="ds44-docListElem"><i class="icon icon-time ds44-docListIco" aria-hidden="true"></i><%= InfolocaleUtil.getHoraireDisplay(currentDisplayedDate)%></span>
			           </jalios:if>
			           <jalios:if predicate="<%= Util.notEmpty(obj.getDuree()) && Util.notEmpty(InfolocaleUtil.getLabelDuree(obj.getDuree())) %>">
			              <span class="ds44-docListElem"><i class="icon icon-time ds44-docListIco" aria-hidden="true"></i><%= InfolocaleUtil.getLabelDuree(obj.getDuree()) %></span>
			           </jalios:if>
			           <jalios:if predicate="<%= Util.notEmpty(obj.getNombreDeParticipants()) && obj.getNombreDeParticipants() > 0 %>">
			              <span class="ds44-docListElem"><i class="icon icon-user ds44-docListIco" aria-hidden="true"></i><%= obj.getNombreDeParticipants() %> <%= glp("jcmsplugin.socle.participants") %></span>
			           </jalios:if>
			        </div>
                </div>
            </div>
        </div>
      </jalios:buffer>
      
      <jalios:select>
              
                    <jalios:if predicate='<%= (Util.notEmpty(obj.getOrganismeId()) && channel.getProperty("jcmsplugin.socle.infolocale.organisme.dep.id.list").contains(Integer.toString(obj.getOrganismeId()))) || (texteCourtEmpty && descEmpty) %>'>
                        <div class="ds44-inner-container">
                           <div class="ds44-grid12-offset-1">
                              <figure class="ds44-legendeContainer ds44-container-imgRatio" role="figure" aria-label="<%= labelLegendCopyright %>">
                                 <img src="<%= urlPhoto %>" alt="<%= labelLegendCopyright %>" class="ds44-w100 ds44-imgRatio">
                                 <figcaption class="ds44-imgCaption"><%= labelLegendCopyright %></figcaption>
                              </figure>
                              <%= eventSummary %>
                           </div>
                        </div>
                    </jalios:if>
                    
                    <jalios:default>
                        <%= eventSummary %>
                         <section class="ds44-contenuArticle" id="sectionPicture">
                             <div class="ds44-inner-container ds44-mtb5">
                                <div class="ds44-grid12-offset-1">
									<jalios:select>
										<jalios:if predicate="<%=Util.notEmpty(urlPhoto)%>">
											<div class="grid-2-small-1">
												<div class="col mrl mbs">
													<figure class="ds44-legendeContainer ds44-container-imgRatio" role="figure" aria-label="<%=labelLegendCopyright%>">
														<img src="<%=urlPhoto%>" alt=""
															class="ds44-w100 ds44-imgRatio">
														<figcaption class="ds44-imgCaption"><%=labelLegendCopyright%></figcaption>
													</figure>
												</div>
												<div class="col mll mbs">
													<p class="ds44-introduction"><%=!texteCourtEmpty ? obj.getTexteCourt() : obj.getDescription()%></p>
												</div>
											</div>
										</jalios:if>
										<jalios:default>
											<div class="grid-1-small-1">
												<div class="col mll mbs">
													<p class="ds44-introduction"><%=!texteCourtEmpty ? obj.getTexteCourt() : obj.getDescription()%></p>
												</div>
											</div>
										</jalios:default>
									</jalios:select>
		
								</div>
                             </div>
                         </section>
                    </jalios:default>
              </jalios:select>
      
      <section class="ds44-contenuArticle" id="sectionVideo">
         <div class="ds44-inner-container ds44-mtb3">
            <div class="ds44-grid12-offset-2">
               <jalios:if predicate="<%= Util.notEmpty(obj.getUrlVideos()) %>">
                    <jalios:foreach name="itVideoUrl" type="String" collection="<%= obj.getUrlVideos() %>">
	                    <div class="ds44-negativeOffset-2 ds44-mtb3">
	                       <div class="ds44-js-youtube-video" data-video-id="<%= SocleUtils.getIdOfYoutubeUrl(itVideoUrl) %>"></div>
		                </div>
                    </jalios:foreach>
               </jalios:if>
               <%-- TODO : texte long -> en attente d'une mise à jour infolocale --%>
            </div>
         </div>
      </section>
      <section class="ds44-contenuArticle" id="sectionInformations">
         <div class="ds44-inner-container">
            <div class="ds44-grid12-offset-2">
               <div class="grid-2-small-1">
                  <div class="col">
                     <jalios:if predicate="<%= obj.getGratuit() || Util.notEmpty(obj.getTarifNormal(userLang)) || Util.notEmpty(obj.getTarifReduit(userLang)) || Util.notEmpty(obj.getTarifAutre(userLang)) %>">
	                     <div class="ds44-mb3">
	                        <h2 class="h3-like"><%= glp("jcmsplugin.socle.tarifs") %></h2>
	                        <ul class="ds44-uList">
	                           <jalios:select>
	                                <jalios:if predicate="<%= obj.getGratuit() %>">
	                                <li>
	                                    <span class="ds44-wsg-exergue"><%= glp("jcmsplugin.socle.gratuit") %></span>
		                            </li>
	                                </jalios:if>
	                                <% String euro = glp("jcmsplugin.socle.symbol.euro"); %>
	                                <jalios:default>
	                                    <jalios:if predicate='<%= Util.notEmpty(obj.getTarifNormal(userLang)) && !obj.getTarifNormal(userLang).equals("0") %>'>
	                                        <li><%= glp("jcmsplugin.socle.tarif.normal") %> <%= obj.getTarifNormal(userLang) %><%= obj.getTarifNormal(userLang).contains(euro) ? "" : " "+euro %></li>
	                                    </jalios:if>
	                                    <jalios:if predicate='<%= Util.notEmpty(obj.getTarifReduit(userLang)) && !obj.getTarifReduit(userLang).equals("0") %>'>
	                                        <li><%= glp("jcmsplugin.socle.tarif.reduit") %> <%= obj.getTarifReduit(userLang) %><%= obj.getTarifReduit(userLang).contains(euro) ? "" : " "+euro %></li>
	                                    </jalios:if>
	                                    <jalios:if predicate='<%= Util.notEmpty(obj.getTarifAutre(userLang)) && !obj.getTarifAutre(userLang).equals("0") %>'>
	                                        <li><%= obj.getTarifAutre(userLang) %></li>
	                                    </jalios:if>
	                                </jalios:default>
	                           </jalios:select>
	                        </ul>
	                     </div>
                     </jalios:if>
                     <div class="ds44-mb3">
                        <h2 class="h3-like"><%= glp("jcmsplugin.socle.adresse") %></h2>
                        <div class="ds44-ml1">
                           <p class="ds44-docListElem mtm">
                              <i class="icon icon-marker ds44-docListIco" aria-hidden="true"></i>
                              <%= obj.getLieu().getNom() %><jalios:if predicate="<%= Util.notEmpty(obj.getLieu().getNom()) && (Util.notEmpty(obj.getLieu().getAdresse()) || Util.notEmpty(obj.getLieu().getCommune())) %>"><br></jalios:if>
                              <%= obj.getLieu().getAdresse() %><jalios:if predicate="<%= Util.notEmpty(obj.getLieu().getAdresse()) && (Util.notEmpty(obj.getLieu().getCommune())) %>"><br></jalios:if>
                              <%= obj.getLieu().getCommune().getNom() %>
                           </p>
                           <p class="ds44-docListElem mts">
                              <i class="icon icon-directions ds44-docListIco" aria-hidden="true"></i><a href="<%= SocleUtils.formatOpenStreetMapLink(obj.getLieu().getLatitude(), obj.getLieu().getLongitude()) %>" title='<%= glp("jcmsplugin.socle.serendrea", obj.getLieu().getAdresse()) %>' target="_blank"><%= glp("jcmsplugin.socle.syrendre") %></a>
                           </p>
                        </div>
                     </div>
                     <jalios:if predicate="<%= Util.notEmpty(obj.getCategorieDage()) || (Util.notEmpty(obj.getAgeMinimum()) && obj.getAgeMinimum() > 0) || (Util.notEmpty(obj.getAgeMaximum()) && obj.getAgeMaximum() > 0) %>">
	                     <div>
	                        <h2 class="h3-like"><%= glp("jcmsplugin.socle.public") %></h2>
	                        <ul class="ds44-uList">
	                           <jalios:if predicate="<%= Util.notEmpty(obj.getCategorieDage()) %>">
	                                <li>
			                           <jalios:foreach name="itPublic" type="String" array="<%= obj.getCategorieDage() %>">
			                                <%= itPublic %><%= itCounter < obj.getCategorieDage().length ? ", " : "" %>
			                           </jalios:foreach>
			                        </li>
	                           </jalios:if>
	                           <jalios:select>
	                                <jalios:if predicate="<%= Util.notEmpty(obj.getAgeMinimum()) && obj.getAgeMinimum() > 0 && (Util.isEmpty(obj.getAgeMaximum()) || obj.getAgeMaximum() <= 0 || obj.getAgeMaximum() >= 100) %>">
	                                    <li><%= glp("jcmsplugin.socle.age.apartirde", obj.getAgeMinimum()) %></li>
	                                </jalios:if>
	                                <jalios:if predicate="<%= Util.notEmpty(obj.getAgeMaximum()) && obj.getAgeMaximum() > 0 && obj.getAgeMaximum() < 100 && (Util.isEmpty(obj.getAgeMinimum()) || obj.getAgeMinimum() <= 0) %>">
	                                    <li><%= glp("jcmsplugin.socle.age.jusqua", obj.getAgeMaximum()) %></li>
	                                </jalios:if>
	                                <jalios:if predicate="<%= Util.notEmpty(obj.getAgeMinimum()) && obj.getAgeMinimum() > 0 && obj.getAgeMinimum() < 100 && Util.notEmpty(obj.getAgeMaximum()) && obj.getAgeMaximum() > 0%>">
	                                    <li><%= glp("jcmsplugin.socle.age.de.a", obj.getAgeMinimum(), obj.getAgeMaximum()) %></li>
	                                </jalios:if>
	                                <jalios:if predicate='<%= Util.notEmpty(obj.getAgeMaximum()) && obj.getAgeMaximum() >= 100 && Util.notEmpty(obj.getCategorieDage()) && !(Arrays.asList(obj.getCategorieDage()).contains(glp("jcmsplugin.socle.age.tous"))) %>'>
	                                    <li><%= glp("jcmsplugin.socle.age.tous") %></li>
	                                </jalios:if>
	                           </jalios:select>
	                        </ul>
	                     </div>
                     </jalios:if>
                  </div>
                  
                  <div class="col ds44--xl-padding-l">
                     <jalios:if predicate="<%= Util.notEmpty(obj.getContacts()) && obj.getContacts().length > 0 %>">
                         <% fr.cg44.plugin.socle.infolocale.entities.Contact eventContact = obj.getContacts()[0]; %>
	                     <div class="ds44-mb3">
	                        <h2 class="h3-like"><%= eventContact.getTypeId() == 1 ? glp("jcmsplugin.socle.contact") : glp("jcmsplugin.socle.contactreservations") %></h2>
	                        <div class="ds44-ml1">
	                           <jalios:if predicate="<%= Util.notEmpty(eventContact.getTelephone1()) || Util.notEmpty(eventContact.getTelephone2()) %>">
	                           <div class="ds44-docListElem mtm">
	                              <i class="icon icon-phone ds44-docListIco" aria-hidden="true"></i>
	                              <jalios:if predicate="<%= Util.notEmpty(eventContact.getTelephone1()) %>">
                                       <ds:phone number="<%= eventContact.getTelephone1() %>"/>
                                  </jalios:if>
                                  <jalios:if predicate="<%= Util.notEmpty(eventContact.getTelephone1()) && Util.notEmpty(eventContact.getTelephone2()) %>">
                                   - 
                                  </jalios:if>
                                  <jalios:if predicate="<%= Util.notEmpty(eventContact.getTelephone2()) %>">
                                       <ds:phone number="<%= eventContact.getTelephone2() %>"/>
                                  </jalios:if>
	                           </div>
	                           </jalios:if>
	                           <jalios:if predicate="<%= Util.notEmpty(eventContact.getEmail()) %>">
		                           <p class="ds44-docListElem mts">
		                              <i class="icon icon-mail ds44-docListIco" aria-hidden="true"></i><a href="mailto:<%= eventContact.getEmail() %>" aria-label='<%= glp("jcmsplugin.socle.ficheaide.contacter-x-par-mail.label", obj.getLieu().getNom(), eventContact.getEmail()) %>'><%= glp("jcmsplugin.socle.ficheaide.contacter-par-mail.label") %></a>
		                           </p>
	                           </jalios:if>
	                           <jalios:if predicate="<%= Util.notEmpty(eventContact.getUrl()) %>">
		                           <p class="ds44-docListElem mts">
		                              <i class="icon icon-link ds44-docListIco" aria-hidden="true"></i><a href="<%= eventContact.getUrl() %>" title='<%= glp("jcmsplugin.socle.lien.site.nouvelonglet", eventContact.getUrl()) %>' target="_blank"><%= glp("jcmsplugin.socle.siteinternet") %></a>
		                           </p>
	                           </jalios:if>
	                           <jalios:if predicate="<%= Util.notEmpty(obj.getReservation()) %>">
		                           <p class="ds44-docListElem mts">
		                              <i class="icon icon-right ds44-docListIco" aria-hidden="true"></i><%= obj.getReservation() %>
		                           </p>
	                           </jalios:if>
	                           <jalios:if predicate="<%= obj.getMentionEvenementComplet() %>">
		                           <p class="ds44-docListElem mts">
		                              <i class="icon icon-right ds44-docListIco" aria-hidden="true"></i><%= glp("jcmsplugin.socle.complet") %>
		                           </p>
	                           </jalios:if>
	                           <jalios:if predicate="<%= Util.notEmpty(obj.getUrlBilletterie()) %>">
		                           <p>
		                              <a href="<%= obj.getUrlBilletterie() %>" target="_blank" class="ds44-btnStd ds44-btn--invert" title='<%= glp("jcmsplugin.socle.reserverlien", displayedTitle) %>'><span class="ds44-btnInnerText"><%= glp("jcmsplugin.socle.reserver") %></span><i class="icon icon-long-arrow-right" aria-hidden="true"></i></a>
		                           </p>
	                           </jalios:if>
	                        </div>
	                     </div>
                     </jalios:if>
                     <jalios:if predicate="<%= obj.getMentionAccessibleHandicapVisuel() || obj.getMentionAccessibleHandicapMoteur() || obj.getMentionAccessibleHandicapMental() || obj.getMentionAccessibleHandicapAuditif() %>">
	                     <div class="ds44-mb3">
	                        <h2 class="h3-like"><%= glp("jcmsplugin.socle.accessibilite") %></h2>
	                        <div class="ds44-ml1">
	                           <jalios:if predicate="<%= obj.getMentionAccessibleHandicapVisuel() %>">
	                           <p class="ds44-docListElem mtm">
	                              <i class="icon icon-handicap-visuel ds44-docListIco" aria-hidden="true"></i><%= glp("jcmsplugin.socle.infolocale.label.accessibilite.handicapvisuel") %>
	                           </p>
	                           </jalios:if>
	                           <jalios:if predicate="<%= obj.getMentionAccessibleHandicapMoteur() %>">
	                           <p class="ds44-docListElem mtm">
	                              <i class="icon icon-handicap-moteur ds44-docListIco" aria-hidden="true"></i><%= glp("jcmsplugin.socle.infolocale.label.accessibilite.handicapmoteur") %>
	                           </p>
	                           </jalios:if>
	                           <jalios:if predicate="<%= obj.getMentionAccessibleHandicapMental() %>">
	                           <p class="ds44-docListElem mtm">
	                              <i class="icon icon-handicap-mental ds44-docListIco" aria-hidden="true"></i><%= glp("jcmsplugin.socle.infolocale.label.accessibilite.handicapmental") %>
	                           </p>
	                           </jalios:if>
	                           <jalios:if predicate="<%= obj.getMentionAccessibleHandicapAuditif() %>">
	                           <p class="ds44-docListElem mtm">
	                              <i class="icon icon-handicap-auditif ds44-docListIco" aria-hidden="true"></i><%= glp("jcmsplugin.socle.infolocale.label.accessibilite.handicapauditif") %>
	                           </p>
	                           </jalios:if>
	                        </div>
	                     </div>
                     </jalios:if>
                     <jalios:if predicate='<%= Util.notEmpty(obj.getLangues()) 
                         && !(obj.getLangues().length == 1 && obj.getLangues()[0].getLangueLibelle().toLowerCase().equals(channel.getProperty("fr.lang").toLowerCase())) %>'>
	                     <div>
	                        <h2 class="h3-like"><%= glp("jcmsplugin.socle.langues") %></h2>
	                        <ul class="ds44-uList">
	                           <jalios:foreach name="itLangue" type="Langue" array="<%= obj.getLangues() %>">
	                               <li><%= itLangue.getLangueLibelle() %></li>
	                           </jalios:foreach>
	                        </ul>
	                     </div>
                     </jalios:if>
                  </div>
               </div>
            </div>
         </div>
      </section>
      
      <jalios:if predicate="<%= Util.notEmpty(obj.getDossiersDePresse()) %>">
	      <section class="ds44-contenuArticle" id="evenementAllerPlusLoin">
	         <div class="ds44-inner-container ds44-mtb3">
	            <div class="ds44-grid12-offset-2">
	               <div class="ds44-wsg-encadreContour">
	                  <p role="heading" aria-level="2" class="h2-like"><%= glp("jcmsplugin.socle.allerplusloin") %></p>
	                  <jalios:foreach name="itDossierPresse" type="DossierPresse" collection="<%= obj.getDossiersDePresse() %>">
	                  <p class="ds44-docListElem">
	                     <i class="icon icon-file ds44-docListIco" aria-hidden="true"></i>
	                     <a href="<%= itDossierPresse.getUrl() %>" title='<%= glp("jcmsplugin.socle.lien.nouvelonglet", itDossierPresse.getFilename() + " - " + itDossierPresse.getFormat().toUpperCase()) %>'>
	                       <%= itDossierPresse.getFilename() %>
	                     </a>
	                     <span class="ds44-cardFile"><%= itDossierPresse.getFormat().toUpperCase() %></span>
	                  </p>
	                  </jalios:foreach>
	               </div>
	            </div>
	         </div>
	      </section>
      </jalios:if>
      
      <%-- TODO : liens de partage --%>
      
      <%--
      <section class="ds44-partage ds44-flex-container ds44-flex-align-center pal ds44-mb35">
         <h2 class="h4-like" id="idPartageRS"><%= glp("jcmsplugin.socle.partagerpage") %></h2>
         <ul class="ds44-list ds44-flex-container ds44-flex-align-center ds44-fse">
            <li><a href="#" target="_blank" class="ds44-rsLink" title="Partager cette page sur Facebook - nouvelle fenêtre" data-statistic="{&quot;name&quot;: &quot;declenche-evenement&quot;,&quot;category&quot;: &quot;Partage page&quot;,&quot;action&quot;: &quot;Facebook&quot;}"><i class="icon icon-facebook icon--sizeL" aria-hidden="true"></i><span class="visually-hidden"><%= glp("jcmsplugin.socle.partager.fb") %></span></a></li>
            <li><a href="#" target="_blank" class="ds44-rsLink" title="Partager cette page sur Twitter - nouvelle fenêtre" data-statistic="{&quot;name&quot;: &quot;declenche-evenement&quot;,&quot;category&quot;: &quot;Partage page&quot;,&quot;action&quot;: &quot;Twitter&quot;}"><i class="icon icon-twitter icon--sizeL" aria-hidden="true"></i><span class="visually-hidden"><%= glp("jcmsplugin.socle.partager.twitter") %></span></a></li>
            <li><a href="#" target="_blank" class="ds44-rsLink" title="Partager cette page sur Linkedin - nouvelle fenêtre" data-statistic="{&quot;name&quot;: &quot;declenche-evenement&quot;,&quot;category&quot;: &quot;Partage page&quot;,&quot;action&quot;: &quot;Linkedin&quot;}"><i class="icon icon-linkedin icon--sizeL" aria-hidden="true"></i><span class="visually-hidden"><%= glp("jcmsplugin.socle.partager.linkedin") %></span></a></li>
            <li><a href="#" target="_blank" class="ds44-rsLink" title="Contacter le Département de Loire-Atlantique - nouvelle fenêtre" data-statistic="{&quot;name&quot;: &quot;declenche-evenement&quot;,&quot;category&quot;: &quot;Partage page&quot;,&quot;action&quot;: &quot;Loire-Atlantique&quot;}"><i class="icon icon-mail icon--sizeL" aria-hidden="true"></i><span class="visually-hidden"><%= glp("jcmsplugin.socle.contacterdept") %></span></a></li>
         </ul>
      </section>
      --%>
      
   </article>
</main>

