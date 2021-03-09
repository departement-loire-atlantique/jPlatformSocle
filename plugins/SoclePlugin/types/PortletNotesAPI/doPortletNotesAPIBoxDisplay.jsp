<%@page import="fr.cg44.plugin.socle.api.tripadvisor.bean.TripadvisorPlaceBean"%>
<%@page import="fr.cg44.plugin.socle.api.ApiNotesCacheManager"%>
<%@page import="fr.cg44.plugin.socle.api.google.bean.GooglePlaceBean"%>
<%@page import="fr.cg44.plugin.socle.SocleUtils"%>
<%@ include file="/jcore/doInitPage.jspf" %>
<%@ include file="/jcore/portal/doPortletParams.jspf" %>
<% PortletNotesAPI box = (PortletNotesAPI) portlet; %>
<%

String partageExperience = Util.isEmpty(box.getTitreAffiche(userLang, false)) ? glp("jcmsplugin.socle.partagerVotreExperience") : box.getTitreAffiche(userLang, false);
String hashtagLabel = Util.isEmpty(box.getSoustitre(userLang, false)) ? glp("jcmsplugin.socle.monExperience.hashtag") : box.getSoustitre(userLang, false);

String urlGoogle = Util.isEmpty(box.getUrlPageGoogle()) ? "#" : box.getUrlPageGoogle();
String urlFacebook = Util.isEmpty(box.getUrlPageFacebook()) ? "#" : box.getUrlPageFacebook();
String urlTripadvisor = Util.isEmpty(box.getUrlPageTripadvisor()) ? "#" : box.getUrlPageTripadvisor();

ApiNotesCacheManager notesCache = ApiNotesCacheManager.INSTANCE;

String noteGoogle = Util.isEmpty(box.getSurchargeNoteGoogle()) ? Double.toString(notesCache.getGoogleNote()) : box.getSurchargeNoteGoogle(); 
String nbReviewsGoogle = Util.isEmpty(box.getSurchargeNbReviewsGoogle()) ? Integer.toString(notesCache.getGoogleNbReviews()) : Integer.toString(box.getSurchargeNbReviewsGoogle()); 
String noteFb = Util.isEmpty(box.getSurchargeNoteFacebook()) ? Double.toString(notesCache.getFacebookNote()) : box.getSurchargeNoteFacebook(); 
String nbReviewsFb = Util.isEmpty(box.getSurchargeNbReviewsFacebook()) ? Integer.toString(notesCache.getFacebookNbReviews()) : Integer.toString(box.getSurchargeNbReviewsFacebook());
String noteTripadvisor = Util.isEmpty(box.getSurchargeNoteTripadvisor()) ? Double.toString(notesCache.getTripadvisorNote()) : box.getSurchargeNoteTripadvisor(); 
String nbReviewsTripadvisor = Util.isEmpty(box.getSurchargeNbReviewsTripadvisor()) ? Integer.toString(notesCache.getTripadvisorNbReviews()) : Integer.toString(box.getSurchargeNbReviewsTripadvisor());

%>

<section class="ds44-container-large ds44-mt-std ds44-partage-patrimoine">
   <div class="grid-12-small-1">
      <div class="col-6-small-1">
         <section class="ds44-partage-sliderHome ds44-theme ds44-flex-container ds44-flex-valign-center">
            <div class="ds44-fg2">
               <p role="heading" aria-level="2"><%= partageExperience %></p>
               <p class="hashtag"><%= hashtagLabel %></p>
            </div>
            <%@ include file="/plugins/SoclePlugin/jsp/portal/socialNetworksCommon.jspf" %>
                  <ul class="ds44-list ds44-flex-container ds44-fg1">
                  <%
                  for(int i=0; i<socialNetworksLabelsList.size(); i++){
                    String url = socialNetworksUrlsList.get(i);
                    String title = glp("jcmsplugin.socle.socialnetworks.title")+" "+socialNetworksLabelsList.get(i); 
                    if(! SocleUtils.isURLInterne(url)) title = title + " " + glp("jcmsplugin.socle.accessibily.newTabLabel");
                  %>
                      <li class="ds44-flex-align-center">
                        <a href='<%= url %>' target="_blank" class="ds44-rsLink" title='<%= title %>'><i class="icon icon-<%=socialNetworksLabelsList.get(i).toLowerCase().replaceAll("\\s","")%>" aria-hidden="true"></i><span class="visually-hidden"><%= title %></span></a>
                      </li>
                  <%
                  }
                  %>
                  </ul>
         </section>
      </div>
      <div class="col-6-small-1 ds44-bgGray ds44-noteRS ">
         <ul class="ds44-list ds44-flex-container ds44-flex-valign-center">
            <%-- Tripadvisor --%>
            <jalios:if predicate="<%= Util.notEmpty(noteTripadvisor) %>">
            <li class="ds44-flex-align-center">
               <a href="<%= urlTripadvisor %>">
                  <i class="icon icon-tripadvisor" aria-hidden="true"></i>
                  <p>
                     <span class="h1-like ds44-block"><%= noteTripadvisor %>/5</span>
                     <span class="ds44-block"><%= glp("jcmsplugin.socle.nbavis", nbReviewsTripadvisor) %></span>
                     <span class="ds44-block"><%= glp("jcmsplugin.socle.tripadvisor") %></span>
                  </p>
               </a>
            </li>
            </jalios:if>
            <%-- Google --%>
            <jalios:if predicate="<%= Util.notEmpty(noteGoogle) %>">
            <li class="ds44-flex-align-center">
               <a href="<%= urlGoogle %>">
                  <i class="icon icon-google" aria-hidden="true"></i>
                  <p>
                     <span class="h1-like ds44-block"><%= noteGoogle %>/5</span>
                     <span class="ds44-block"><%= glp("jcmsplugin.socle.nbavis", nbReviewsGoogle) %></span>
                     <span class="ds44-block"><%= glp("jcmsplugin.socle.google") %></span>
                  </p>
               </a>
            </li>
            </jalios:if>
            <%-- Facebook --%>
            <jalios:if predicate="<%= Util.notEmpty(noteFb) %>">
            <li class="ds44-flex-align-center">
               <a href="<%= urlFacebook %>">
                  <i class="icon icon-facebook" aria-hidden="true"></i>
                  <p>
                     <span class="h1-like ds44-block"><%= noteFb %>/5</span>
                     <span class="ds44-block"><%= glp("jcmsplugin.socle.nbavis", nbReviewsFb) %></span>
                     <span class="ds44-block"><%= glp("jcmsplugin.socle.facebook") %></span>
                  </p>
               </a>
            </li>
            </jalios:if>
         </ul>
      </div>
   </div>
</section>