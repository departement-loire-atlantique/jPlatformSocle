<%@page import="fr.cg44.plugin.socle.infolocale.InfolocaleMetadataUtils"%>
<%@page import="fr.cg44.plugin.socle.infolocale.entities.DateInfolocale"%>
<%@page import="fr.cg44.plugin.socle.infolocale.util.InfolocaleUtil"%>
<%@page import="fr.cg44.plugin.socle.SocleUtils"%>
<%@page import="fr.cg44.plugin.socle.infolocale.InfolocaleEntityUtils"%>
<%@page import="fr.cg44.plugin.socle.infolocale.RequestManager"%>
<%@page import="org.json.JSONObject"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file='/jcore/doInitPage.jsp'%>
<%@ include file="/jcore/portal/doPortletParams.jspf" %>

<%
PortletAgendaInfolocale box = (PortletAgendaInfolocale) portlet;

if (Util.isEmpty(box)) return;

Map<String, Object> parameters = new HashMap<String, Object>();
if (Util.notEmpty(box.getOrganismesInfolocale())) {
    parameters.put("organisme", box.getOrganismesInfolocale());
}
if (Util.notEmpty(box.getGenresInfolocale())) {
    parameters.put("rubrique", box.getGenresInfolocale());
}

String listCodesInsee = SocleUtils.getCodesInseeFromPortletAgenda(box, loggedMember);

if (Util.notEmpty(listCodesInsee)) {
    parameters.put("codeInsee", listCodesInsee);
}

if (Util.notEmpty(box.getNombreDeResultats()) && box.getNombreDeResultats() > 0) {
  parameters.put("limit", box.getNombreDeResultats());
} else {
  parameters.put("limit", channel.getIntegerProperty("jcmsplugin.socle.infolocale.limit", 20));
}

if (Util.notEmpty(box.getGroupesDevenementsInfolocale())) {
  parameters.put("thematiquePerso", box.getGroupesDevenementsInfolocale());
}

if (Util.notEmpty(box.getGenresInfolocale()) || Util.notEmpty(box.getCategoriesInfolocale())) {
  parameters.put("rubrique", InfolocaleUtil.getAllGenresFromPortletAgendaConfig(box));
}

parameters.put("order", channel.getProperty("jcmsplugin.socle.infolocale.defaultOrder"));

SimpleDateFormat sdf = new SimpleDateFormat(channel.getProperty("jcmsplugin.socle.infolocale.date.send.format"));
Date dateDebut = Calendar.getInstance().getTime();
parameters.put("dateDebut", sdf.format(dateDebut));
Calendar calInAMonth = Calendar.getInstance();
calInAMonth.set(Calendar.DAY_OF_YEAR, Calendar.getInstance().get(Calendar.DAY_OF_YEAR) + 30);
Date dateInAMonth = calInAMonth.getTime();
parameters.put("dateFin", sdf.format(dateInAMonth));

String flux = Util.isEmpty(box.getIdDeFlux()) ? channel.getProperty("jcmsplugin.socle.infolocale.flux.default") : box.getIdDeFlux();

JSONObject extractedFlux = RequestManager.filterFluxData(flux, parameters);

boolean fluxSuccess = Boolean.parseBoolean(extractedFlux.getString("success"));
%>

<jalios:select>
    <jalios:if predicate='<%= fluxSuccess && extractedFlux.getJSONArray("result").length() > 0 %>'>
        <%
        SimpleDateFormat sdfSort = new SimpleDateFormat(channel.getProperty("jcmsplugin.socle.infolocale.date.receive.format"));
        String[] arrayIdsAExclure = null;
        if (Util.notEmpty(box.getIdsAExclure())) {
          arrayIdsAExclure = box.getIdsAExclure().split(",");
        }
        String[] arrayIdsGroupes = null;
        if (Util.notEmpty(box.getGroupeDevenements())) {
          arrayIdsGroupes = box.getGroupeDevenements().split(",");
        }
        EvenementInfolocale[] evenements = InfolocaleEntityUtils.createEvenementInfolocaleArrayFromJsonArray(extractedFlux.getJSONArray("result"), 
            box.getMetadonneesTuileCarrousel_1(), box.getMetadonneesTuileCarrousel_2(), box.getMetadonneeParDefaut(),
            Util.notEmpty(arrayIdsAExclure) ? Arrays.asList(arrayIdsAExclure) : null,
            Util.notEmpty(arrayIdsGroupes) ? Arrays.asList(arrayIdsGroupes) : null);
        List<EvenementInfolocale> allEvents = InfolocaleUtil.splitEventListFromDateFields(evenements);
        List<EvenementInfolocale> sortedEvents = InfolocaleUtil.sortEvenementsCarrousel(allEvents);
        sortedEvents = InfolocaleUtil.purgeEventListFromDuplicates(sortedEvents, new String[]{sdfSort.format(dateDebut), sdfSort.format(dateInAMonth)});
        
        if (Util.isEmpty(sortedEvents)) {
          return;
        }
        
        int maxTuiles = 0;
        if (Util.notEmpty(box.getNombreDeTuiles()) && box.getNombreDeTuiles() > 0) {
          maxTuiles = allEvents.size() <= box.getNombreDeTuiles() ? allEvents.size() : box.getNombreDeTuiles();
        } else {
          maxTuiles = allEvents.size() <= 3 ? allEvents.size() : 3;
        }
        
        %>
        
        <jalios:if predicate='<%= Util.notEmpty(box.getTitre(userLang)) %>'>
            <div class="ds44-inner-container ds44--mobile--m-padding-b">
                <header class="txtcenter ds44--l-padding-b">
                    <h2 class="h2-like center"><%= box.getTitre(userLang) %></h2>
                    <jalios:if predicate='<%= Util.notEmpty(box.getSoustitre(userLang)) %>'>
                        <p class="ds44-component-chapo ds44-centeredBlock"><%= box.getSoustitre(userLang) %></p>
                    </jalios:if>
                </header>
            </div>
        </jalios:if>
        
        <div class="ds44-container-large">
	        <div class='mod--hidden ds44-list swipper-carousel-wrap ds44-posRel' data-nb-visible-slides="<%= maxTuiles %>">
	            <div class="swiper-container">
	                <ul class="swiper-wrapper ds44-list grid-3-small-1 has-gutter-l ds44-carousel-swiper">
	                    <%
		                    request.setAttribute("metadata1", box.getMetadonneesTuileCarrousel_1());
		                    request.setAttribute("metadata2", box.getMetadonneesTuileCarrousel_1());
		                    request.setAttribute("cssCard", box.getStyleDesTuilesCarrousel());
	                    %>
	                    <jalios:foreach name="itEvent" type="EvenementInfolocale" collection="<%= sortedEvents %>">
	                        <li class="swiper-slide">
	                            <jalios:select>
							        <jalios:if predicate='<%= box.getTypeDeTuileCarrousel().equals("vertical")%>'>
							            <jalios:media data="<%= itEvent %>" template="cardVertical" />
							        </jalios:if>
							        <jalios:default>
							            <jalios:media data="<%= itEvent %>" template="card" />
							        </jalios:default>
						        </jalios:select>
	                        </li>
	                    </jalios:foreach>
	                    <%
	                    request.removeAttribute("metadata1");
	                    request.removeAttribute("metadata2");
	                    request.removeAttribute("cssCard");
	                    %>
	                </ul>
	            </div>
	            <button class="swiper-button-prev ds44-not-edge-42" type="button" title='<%= glp("jcmsplugin.socle.carrousel.precedent") %>'>
	                <i class="icon icon-left" aria-hidden="true"></i>
	                <span class="visually-hidden"><%= glp("jcmsplugin.socle.carrousel.precedent") %></span>
	            </button>
	            <button class="swiper-button-next ds44-not-edge-42" type="button" title='<%= glp("jcmsplugin.socle.carrousel.suivant") %>'>
	                <i class="icon icon-right" aria-hidden="true"></i>
	                <span class="visually-hidden"><%= glp("jcmsplugin.socle.carrousel.suivant") %></span>
	            </button>
	        </div>
        </div>
    </jalios:if>
    <jalios:if predicate='<%= fluxSuccess && extractedFlux.getJSONArray("result").length() == 0 %>'>
        <%-- Flux OK mais aucun résultat : ne rien afficher --%>
    </jalios:if>
    <jalios:default>
        <%= glp("jcmsplugin.socle.label.error.warnAdmin") %>
    </jalios:default>
</jalios:select>