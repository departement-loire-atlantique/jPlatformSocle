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
                <ul>
                    <jalios:foreach name="itElu" type="ElectedMember" collection="<%= referencedElus %>" counter="itCounter">
                         <%
                         String fullNameElu = SocleUtils.getElectedMemberFullName(itElu);
                         if(Util.notEmpty(itElu.getDeputy())){
                             remplacants.add(itElu.getDeputy());
                         }
                         %>
                         <jalios:if predicate="<%= Util.notEmpty(fullNameElu)  %>">
                             <li><jalios:link data="<%= itElu %>"><%= fullNameElu %></jalios:link></li>
                         </jalios:if>
                    </jalios:foreach>
                </ul>
            </jalios:if>
                            
            <%-- Remplaçants --%>
            <jalios:if predicate="<%= Util.notEmpty(remplacants) %>">
                <p class="mtl"><strong><%= glp("jcmsplugin.socle.elu.remplacant") %></strong></p>
                    <ul>
                        <jalios:foreach name="itRemplacant" type="String" collection="<%= remplacants %>" >
                            <li><%= itRemplacant %></li>
                        </jalios:foreach>
                    </ul>
                </p>
            </jalios:if>

        </div>
        
        <%-- Col droite --%>
        <div class="col ds44--xl-padding-l">
            <p role="heading" aria-level="3" class="ds44-box-heading"><%= glp("jcmsplugin.socle.canton.bref") %></p>
            
            <div class="ds44-docListElem mtl"><i class="icon icon-map ds44-docListIco" aria-hidden="true"></i>
               <strong><%= glp("jcmsplugin.socle.canton.superficie") %></strong> <%= (new DecimalFormat("#,###.##")).format(obj.getSuperficie()) %> <%= glp("jcmsplugin.socle.km2") %>
            </div>
            
            <div class="ds44-docListElem mts"><i class="icon icon-user-group ds44-docListIco" aria-hidden="true"></i>
               <strong><%= glp("jcmsplugin.socle.canton.population") %></strong> <%= NumberFormat.getInstance(userLocale).format(obj.getPopulation()) %> <%= glp("jcmsplugin.socle.canton.habitants") %> <%= glp("jcmsplugin.socle.canton.source") %>
            </div>
        </div>
    </div>
</jalios:buffer>

<main id="content" role="main">
    <article class="ds44-container-large">
    
        <ds:titleNoImage title="<%= obj.getTitle(userLang) %>" breadcrumb="true" coloredSection="<%= coloredSectionContent %>"></ds:titleNoImage>
        
        <jalios:if predicate='<%= Util.notEmpty(obj.getDescription()) %>'>
            <section class="ds44-contenuArticle" id="section2">
                <div class="ds44-inner-container ds44-mtb3">
                    <div class="ds44-grid12-offset-2">
                        <jalios:wysiwyg><%= obj.getDescription() %></jalios:wysiwyg>
                    </div>
                </div>
            </section>
        </jalios:if>
        
        <%-- TODO : carte dynamique du canton --%>      

    </article>
    
    <%-- TODO : partage réseaux sociaux --%>
    
    <%-- TODO : page utile --%>  


</main>
