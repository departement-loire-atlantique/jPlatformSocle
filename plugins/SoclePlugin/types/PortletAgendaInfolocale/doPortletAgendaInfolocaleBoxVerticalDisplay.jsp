<%@page import="fr.cg44.plugin.socle.infolocale.InfolocaleMetadataUtils"%>
<%@page import="fr.cg44.plugin.socle.infolocale.entities.DateHoraires"%>
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
   
   %>
<%@ include file='agendaInfolocaleCommon.jspf' %>
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
             box.getMetadonneesTuileCarrousel_1(), box.getMetadonneesTuileCarrousel_2(), box.getMetadonneeParDefaut());
         List<EvenementInfolocale> allEvents = InfolocaleUtil.splitEventListFromDateFields(evenements);
         List<EvenementInfolocale> sortedEvents = InfolocaleUtil.sortEvenementsCarrousel(allEvents);
         sortedEvents = InfolocaleUtil.purgeEventListFromDuplicates(sortedEvents, new String[]{sdfSort.format(dateDebut), sdfSort.format(dateInAMonth)});
         
         if (Util.isEmpty(sortedEvents)) {
           return;
         }
         
         %>
      <jalios:if predicate="<%= Util.notEmpty(box.getTitre()) %>">
         <p role="heading" aria-level="2" class="ds44-box-heading"><%= box.getTitre(userLang, false) %></p>
      </jalios:if>
      <%
         request.setAttribute("metadata1", box.getMetadonneesTuileCarrousel_1());
         request.setAttribute("metadata2", box.getMetadonneesTuileCarrousel_2());
         request.setAttribute("defaultMetadata", box.getMetadonneeParDefaut());
         request.setAttribute("cssCard", box.getStyleDesTuilesCarrousel());
         %>
      <jalios:foreach name="itEvent" type="EvenementInfolocale" collection="<%= sortedEvents %>" max="<%= box.getNombreDeTuiles() %>">
         <jalios:select>
            <jalios:if predicate='<%= box.getTypeDeTuileCarrousel().equals("vertical")%>'>
               <jalios:media data="<%= itEvent %>" template="cardVerticalCarrousel" />
            </jalios:if>
            <jalios:default>
               <jalios:media data="<%= itEvent %>" template="card" />
            </jalios:default>
         </jalios:select>
      </jalios:foreach>
      <%
         request.removeAttribute("metadata1");
         request.removeAttribute("metadata2");
         request.removeAttribute("defaultMetadata");
         request.removeAttribute("cssCard");
         %>
   </jalios:if>
   <jalios:if predicate='<%= fluxSuccess && extractedFlux.getJSONArray("result").length() == 0 %>'>
      <%-- Flux OK mais aucun résultat : ne rien afficher --%>
   </jalios:if>
   <jalios:default>
      <%= glp("jcmsplugin.socle.label.error.warnAdmin") %>
   </jalios:default>
</jalios:select>