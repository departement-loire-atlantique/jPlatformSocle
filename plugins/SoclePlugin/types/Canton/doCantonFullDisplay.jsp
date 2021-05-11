<%@ page import="fr.cg44.plugin.socle.SocleUtils"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="ds" tagdir="/WEB-INF/tags"%>
<%@ include file='/jcore/doInitPage.jspf'%>
<%
Canton obj = (Canton)request.getAttribute(PortalManager.PORTAL_PUBLICATION);
Set<Publication> referencedElus = new TreeSet<>(ComparatorManager.getComparator(Publication.class, "name"));
referencedElus.addAll(obj.getLinkIndexedDataSet(ElectedMember.class));

List<String> remplacants = new ArrayList<String>();

%>
<%@ include file='/front/doFullDisplay.jspf' %>


<jalios:buffer name="coloredSectionContent">
    <div class="grid-2-small-1 ds44-grid12-offset-1">
        <%-- Col gauche --%>
        <div class="col">

            <%-- Bloc "Conseillère et conseiller dép" --%>
            <jalios:if predicate="<%= Util.notEmpty(referencedElus) %>">
   
                <p role="heading" aria-level="3" class="ds44-box-heading"><%= glp("jcmsplugin.socle.canton.conseillers") %></p>
                <ul class="grid-2 ds44-list">
                    <jalios:foreach name="itElu" type="ElectedMember" collection="<%= referencedElus %>" counter="itCounter">
                         <%
                         String fullNameElu = SocleUtils.getElectedMemberFullName(itElu);
                         if(Util.notEmpty(itElu.getDeputy())){
                             remplacants.add(itElu.getDeputy());
                         }
                         %>
                         <jalios:if predicate="<%= Util.notEmpty(fullNameElu)  %>">
                             <li class="col-1-small-1 ds44-mobile-reduced-mb ds44-js-card">
                                <section class="txtcenter">
                                    <jalios:if predicate="<%= Util.notEmpty(itElu.getPicture()) %>">
		                                <picture class="ds44-container-imgRatio ds44-container-imgRatio--profil ds44-centeredBlock">
		                                    <img class="ds44-w100 ds44-imgRatio--profil" src="<%= itElu.getPicture() %>"/>
		                                </picture>
                                    </jalios:if>
                                    <div class="ds44-card__section">
                                        <p class="ds44-card__title">
                                            <a class="ds44-card__globalLink" href="<%= itElu.getDisplayUrl(userLocale) %>" title='<%= glp("jcmsplugin.socle.elu.ficheDetaillee", fullNameElu) %>'><%= fullNameElu %></a>
                                        </p>
                                    </div>
                                </section>
                             </li>
                         </jalios:if>
                    </jalios:foreach>
                </ul>
            </jalios:if>
                            
            <%-- Remplaçants --%>
            <jalios:if predicate="<%= Util.notEmpty(remplacants) %>">
                <p class="h5-like ds44-mt2" role="heading"><%= glp("jcmsplugin.socle.elu.remplacants") %></p>
                    <ul class="ds44-list">
                        <jalios:foreach name="itRemplacant" type="String" collection="<%= remplacants %>" >
                            <li class="ds44-docListElem mts"><i class="icon icon-user ds44-docListIco" aria-hidden="true"></i><%= itRemplacant %></li>
                        </jalios:foreach>
                    </ul>
                </p>
            </jalios:if>

        </div>
        
        <%-- Col droite --%>
        <div class="col ds44--xl-padding-l">
            <p role="heading" aria-level="3" class="ds44-box-heading"><%= glp("jcmsplugin.socle.canton.bref") %></p>
            
            <ul class="ds44-list">
            
                <li class="ds44-flex-container ds44-flex-valign-center ds44-mb-std">
                    <picture class="ds44-boxPic ds44-boxPic--light">
                        <img src='<%= channel.getProperty("jcmsplugin.socle.canton.logo.population") %>'/>
                    </picture>
                    <p>
                        <strong>
                            <span class="ds44-txtExergue">
                                <span class="ds44-js-dynamic-number" data-stop="<%= obj.getPopulation() %>"><%= NumberFormat.getInstance(userLocale).format(obj.getPopulation()) %></span>
                                <%= glp("jcmsplugin.socle.canton.habitants") %>
                            </span>
                        </strong>
                        <%= Util.isEmpty(obj.getCommentairePopulation()) ? glp("jcmsplugin.socle.canton.source") : obj.getCommentairePopulation() %>
                    </p>
                </li>
                
                <li class="ds44-flex-container ds44-flex-valign-center ds44-mb-std">
                    <picture class="ds44-boxPic ds44-boxPic--light">
                        <img src='<%= channel.getProperty("jcmsplugin.socle.canton.logo.superficie") %>'/>
                    </picture>
                    <p>
                        <strong>
                            <span class="ds44-txtExergue">
                                <span class="ds44-js-dynamic-number" data-stop="<%= obj.getSuperficie() %>"><%= (new DecimalFormat("#,###.##")).format(obj.getSuperficie()) %></span>
                                <%= glp("jcmsplugin.socle.km2") %>
                            </span>
                        </strong>
                        <%= glp("jcmsplugin.socle.canton.superficie") %>
                    </p>
                </li>
            
            </ul>
            
        </div>
    </div>
</jalios:buffer>

<main id="content" role="main">
    <article class="ds44-container-large">
    
        <jalios:include target="SOCLE_ALERTE"/>
    
        <ds:titleNoImage title="<%= obj.getTitle(userLang) %>" breadcrumb="true" coloredSection="<%= coloredSectionContent %>" alertText="<%= obj.getTexteIntro() %>"></ds:titleNoImage>
        
        <jalios:if predicate='<%= Util.notEmpty(obj.getDescription()) %>'>
            <section class="ds44-contenuArticle" id="section2">
                <div class="ds44-inner-container ds44-mtb3">
                    <div class="ds44-grid12-offset-2 ds44-introduction">
                        <jalios:wysiwyg><%= obj.getDescription() %></jalios:wysiwyg>
                    </div>
                </div>
            </section>
        </jalios:if>
        
        <%-- Chiffres clés --%>
        <jalios:if predicate="<%= Util.notEmpty(obj.getLienVersContenuChiffresCles()) %>">
            <section id="sectionCards" class="ds44-contenuArticle">
                <div class="ds44-inner-container ds44-mtb3">
                    <div class="ds44-grid12-offset-2">
                        <div class="grid-2-small-1">
	                        <jalios:foreach name="itChiffreCle" type="ChiffresCles" array="<%= obj.getLienVersContenuChiffresCles() %>">
				                <div class="col mrs ds44-mtb1">
				                    <jalios:media data="<%= itChiffreCle %>" template="tuileVerte" />
				                </div>
				            </jalios:foreach>
                        </div>
                    </div>
                </div>
            </section>
        </jalios:if>
        
        <%-- TODO : carte dynamique du canton --%>  
        <%
        PortalElement itPortalElem = channel.getData(PortalElement.class, channel.getProperty("jcmsplugin.socle.canton.recherche.portlet.id"));
        %>
        <jalios:if predicate="<%= Util.notEmpty(itPortalElem) %>">
            <% request.setAttribute("cantonMapSearch", obj); // nécessaire pour afficher des résultats canton. Sera supprimé une fois les éléments de recherche affichés %>
            <jalios:include pub="<%= itPortalElem %>"/>
        </jalios:if>
            
	    <%-- Partagez cette page --%>
	    <%@ include file="/plugins/SoclePlugin/jsp/portal/socialNetworksShare.jspf" %>

    </article>
    
    <%-- Page utile --%>
    <jsp:include page="/plugins/SoclePlugin/types/PageUtileForm/editFormPageUtileForm.jsp"/>


</main>
