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

parameters.put("limit", channel.getIntegerProperty("jcmsplugin.socle.infolocale.limit", 20));
parameters.put("order", channel.getProperty("jcmsplugin.socle.infolocale.defaultOrder"));

SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy");
parameters.put("dateDebut", sdf.format(Calendar.getInstance().getTime()));
Calendar calInAMonth = Calendar.getInstance();
calInAMonth.set(Calendar.YEAR, Calendar.getInstance().get(Calendar.DAY_OF_YEAR) + 30);
parameters.put("dateFin", sdf.format(calInAMonth.getTime()));

String flux = Util.isEmpty(box.getIdDeFlux()) ? channel.getProperty("jcmsplugin.socle.infolocale.flux.default") : box.getIdDeFlux();

JSONObject extractedFlux = RequestManager.filterFluxData(flux, parameters);

boolean fluxSuccess = Boolean.parseBoolean(extractedFlux.getString("success"));
%>

<jalios:select>
    <jalios:if predicate='<%= fluxSuccess && extractedFlux.getJSONArray("result").length() > 0 %>'>
        <%
        EvenementInfolocale[] evenements = InfolocaleEntityUtils.createEvenementInfolocaleArrayFromJsonArray(extractedFlux.getJSONArray("result"));
        List<EvenementInfolocale> allEvents = InfolocaleUtil.splitEventListFromDateFields(evenements);
        List<EvenementInfolocale> sortedEvents = InfolocaleUtil.sortEvenementsCarrousel(allEvents);
        int maxTuiles = evenements.length <= 3 ? evenements.length : 3;
        %>
        <div class="mod--hidden ds44-list swipper-carousel-wrap ds44-posRel ds44-container-large" data-nb-visible-slides="<%= maxTuiles %>">
            <div class="swiper-container">
                <ul class="swiper-wrapper ds44-list grid-3-small-1 has-gutter-l ds44-carousel-swiper">
                    <jalios:foreach name="itEvent" type="EvenementInfolocale" collection="<%= sortedEvents %>">
                    <%
                    DateInfolocale currentDisplayedDate = InfolocaleUtil.getClosestDate(itEvent);
                    %>
                        <li class="swiper-slide">
                            <section class="ds44-card ds44-card--horizontal <%= box.getStyleDesTuilesCarrousel() %>">
                                <div class="ds44-flex-container ds44-flex-valign-center">
                                    <jalios:if predicate="<%= Util.notEmpty(currentDisplayedDate) %>">
	                                    <jalios:select>
	                                        <jalios:if predicate="<%= InfolocaleUtil.infolocaleDateIsSingleDay(currentDisplayedDate) %>">
	                                        <div class="ds44-card__dateContainer ds44-flex-container ds44-flex-align-center ds44-flex-valign-center" aria-hidden="true">
	                                            <p>
		                                            <span class="ds44-cardDateNumber">
		                                                <%= InfolocaleUtil.getDayOfMonthLabel(currentDisplayedDate.getDebut()) %>
		                                            </span>
		                                            <span class="ds44-cardDateMonth">
		                                                <%= InfolocaleUtil.getMonthLabel(currentDisplayedDate.getDebut(), true) %>
		                                            </span>
	                                            </p>
	                                        </div>
	                                        </jalios:if>
	                                        <jalios:default>
	                                        <div class="ds44-card__dateContainer ds44-flex-container ds44-flex-align-center ds44-flex-valign-center ds44-two-dates" aria-hidden="true">
	                                            <p>
		                                            <span class="ds44-cardDateNumber">
		                                               <%= InfolocaleUtil.getDayOfMonthLabel(currentDisplayedDate.getDebut()) %>
		                                            </span>
		                                            <span class="ds44-cardDateMonth">
		                                               <%= InfolocaleUtil.getMonthLabel(currentDisplayedDate.getDebut(), true) %>
		                                            </span>
	                                            </p>
	                                            <i class="icon icon-down" aria-hidden="true"></i>
	                                            <p>
		                                            <span class="ds44-cardDateNumber">
		                                               <%= InfolocaleUtil.getDayOfMonthLabel(currentDisplayedDate.getFin()) %>
		                                            </span>
		                                            <span class="ds44-cardDateMonth">
		                                               <%= InfolocaleUtil.getMonthLabel(currentDisplayedDate.getFin(), true) %>
		                                            </span>
	                                            </p>
	                                        </div>
	                                        </jalios:default>
	                                    </jalios:select>
                                    </jalios:if>
                                    <div class="ds44-card__section--horizontal">
                                        <p role="heading" aria-level="2" class="ds44-card__title"><a href="#" class="ds44-card__globalLink"><%= itEvent.getTitre() %></a></p>
                                        <p class="visually-hidden"><%= InfolocaleUtil.getFullStringFromEventDate(currentDisplayedDate) %></p>
                                        <jalios:if predicate="<%= Util.notEmpty(itEvent.getLieu()) %>">
                                        <p class="ds44-cardLocalisation"><i class="icon icon-marker" aria-hidden="true"></i>
                                        <span class="ds44-iconInnerText"><%= itEvent.getLieu().getCommune().getNom() %></span></p>
                                        </jalios:if>
                                        <i class="icon icon-arrow-right ds44-cardArrow" aria-hidden="true"></i>
                                        <span class="visually-hidden"><%= itEvent.getTitre() %></span>
                                    </div>
                                </div>
                            </section>
                        </li>
                    </jalios:foreach>
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
    </jalios:if>
    <jalios:if predicate='<%= fluxSuccess && extractedFlux.getJSONArray("result").length() == 0 %>'>
        <%-- Flux OK mais aucun résultat : ne rien afficher --%>
    </jalios:if>
    <jalios:default>
        <%= glp("jcmsplugin.socle.label.error.warnAdmin") %>
    </jalios:default>
</jalios:select>