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

GooglePlaceBean googlePlace = notesCache.getGooglePlace();
TripadvisorPlaceBean tripadvisorPlace = notesCache.getTripadvisorPlace();
// TODO FB

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
                  <%
                  Map<String, String> mapSocialNetworks = new HashMap<>();
                  for (int counter = 0; counter < socialNetworksLabels.length; counter++) {
                    mapSocialNetworks.put(socialNetworksLabels[counter], socialNetworksUrls[counter]);
                  }
                        
                  String[] socialNetworkToShow = channel.getStringArrayProperty("jcmsplugin.socle.socialnetworks.carrouselImagesHome", new String[]{});
                  %>
                  <ul class="ds44-list ds44-flex-container ds44-fg1">
                      <jalios:foreach name="itRs" type="String" array="<%= socialNetworkToShow %>">
                      <li class="ds44-flex-align-center">
                        <a href='<%= mapSocialNetworks.get(glp("jcmsplugin.socle.socialnetwork." + itRs)) %>' target="_blank" class="ds44-rsLink" title='<%= glp("jcmsplugin.socle.socialnetwork.depsur." + itRs) %> <%= glp("jcmsplugin.socle.accessibily.newTabLabel") %>'><i class="icon icon-<%= itRs %>" aria-hidden="true"></i><span class="visually-hidden"><%= glp("jcmsplugin.socle.socialnetwork.depsur." + itRs) %></span></a>
                      </li>
                      </jalios:foreach>
                  </ul>
         </section>
      </div>
      <div class="col-6-small-1 ds44-bgGray ds44-noteRS ">
         <ul class="ds44-list ds44-flex-container ds44-flex-valign-center">
            <jalios:if predicate="<%= Util.notEmpty(tripadvisorPlace) %>">
            <%
            String ratingTripadvisor = tripadvisorPlace.getRating().replaceAll(" ", "").replaceAll(".",",");
            %>
            <li class="ds44-flex-align-center">
               <a href="<%= urlTripadvisor %>">
                  <i class="icon icon-tripadvisor" aria-hidden="true"></i>
                  <p>
                     <span class="h1-like ds44-block"><%= ratingTripadvisor %>/5</span>
                     <span class="ds44-block"><%= glp("jcmsplugin.socle.nbavis", tripadvisorPlace.getNumReviews()) %></span>
                     <span class="ds44-block"><%= glp("jcmsplugin.socle.tripadvisor") %></span>
                  </p>
               </a>
            </li>
            </jalios:if>
            <jalios:if predicate="<%= Util.notEmpty(googlePlace) && Util.notEmpty(googlePlace.getResult()) %>">
            <%
            String ratingGoogle = googlePlace.getResult().getRating().toString().replaceAll(" ", "").replaceAll(".",",");
            %>
            <li class="ds44-flex-align-center">
               <a href="<%= urlGoogle %>">
                  <i class="icon icon-google" aria-hidden="true"></i>
                  <p>
                     <span class="h1-like ds44-block"><%= ratingGoogle %>/5</span>
                     <span class="ds44-block"><%= glp("jcmsplugin.socle.nbavis", googlePlace.getResult().getReviews().size()) %></span>
                     <span class="ds44-block"><%= glp("jcmsplugin.socle.google") %></span>
                  </p>
               </a>
            </li>
            </jalios:if>
            <%-- TODO FB --%>
            <li class="ds44-flex-align-center">
               <a href="<%= urlFacebook %>">
                  <i class="icon icon-facebook" aria-hidden="true"></i>
                  <p>
                     <span class="h1-like ds44-block">4,7/5</span>
                     <span class="ds44-block"><%= glp("jcmsplugin.socle.nbavis", "78") %></span>
                     <span class="ds44-block"><%= glp("jcmsplugin.socle.facebook") %></span>
                  </p>
               </a>
            </li>
         </ul>
      </div>
   </div>
</section>