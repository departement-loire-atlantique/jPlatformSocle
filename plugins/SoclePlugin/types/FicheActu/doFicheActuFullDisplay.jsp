<%@page import="fr.cg44.plugin.socle.SocleUtils"%>
<%@page import="fr.cg44.plugin.socle.VideoUtils" %>
<%@page import="com.jalios.jcms.handler.QueryHandler"%>
<%@ page contentType="text/html; charset=UTF-8" %><%
%><%@ taglib prefix="ds" tagdir="/WEB-INF/tags"%><%
%><%@ include file='/jcore/doInitPage.jspf' %><%
%><% FicheActu obj = (FicheActu)request.getAttribute(PortalManager.PORTAL_PUBLICATION); %><%
%><%@ include file='/front/doFullDisplay.jspf' %>

<main id="content" role="main">

<jalios:include target="SOCLE_ALERTE"/>

    <article class="ds44-container-large">
    
        <%
        String date = "";
        try {
          SimpleDateFormat sdfDateActu = new SimpleDateFormat(glp("date-format"));
          date = sdfDateActu.format(obj.getDateActu());
          } catch (Exception e) {
              // do nothing
          }   

        %>

		<ds:titleSimple pub="<%= obj %>" imagePath="<%= obj.getImagePrincipale(userLang) %>" mobileImagePath="<%= obj.getImageMobile() %>" video="<%=obj.getVideoPrincipale() %>"
		    title="<%= obj.getTitle(userLang) %>" chapo="<%= obj.getChapo(userLang) %>" legend="<%= obj.getLegende(userLang) %>" copyright="<%= obj.getCopyright(userLang) %>" 
		    breadcrumb="true" date="<%= date %>"></ds:titleSimple>
		
		<%-- Si vidéo au lieu de l'image, alors le chapo apparait au-dessus de la vidéo --%>
		<jalios:if predicate='<%=Util.isEmpty(obj.getVideoPrincipale()) && Util.notEmpty(obj.getChapo(userLang)) %>'>
		    <section class="ds44-contenuArticle">
		        <div class="ds44-inner-container ds44-mtb3">
		            <div class="ds44-grid12-offset-2">
		                <div class="ds44-introduction">
		                    <jalios:wysiwyg><%=obj.getChapo(userLang)%></jalios:wysiwyg>
		                </div>
		            </div>
		        </div>
		    </section>
		</jalios:if>
			
		<%-- Boucler sur les paragraphes --%>
		<jalios:foreach name="itParagraphe" type="String" counter="itCounter" array="<%=obj.getContenuParagraphe(userLang)%>">
		    <section id="section<%=itCounter%>" class="ds44-contenuArticle">
		        <div class="ds44-inner-container ds44-mtb3">
		            <div class="ds44-grid12-offset-2">
		                <jalios:if predicate="<%= Util.notEmpty(obj.getTitreParagraphe(userLang)) && itCounter <= obj.getTitreParagraphe(userLang).length && Util.notEmpty(obj.getTitreParagraphe(userLang)[itCounter - 1]) && Util.notEmpty(itParagraphe)%>">
		                    <h2 id="titreParagraphe<%=itCounter%>"><%=obj.getTitreParagraphe(userLang)[itCounter - 1]%></h2>
		                </jalios:if>
		                <jalios:if predicate="<%= Util.notEmpty(itParagraphe) %>">
                            <jalios:wysiwyg><%=itParagraphe%></jalios:wysiwyg>
                        </jalios:if>
                    </div>
                </div>
            </section>
        </jalios:foreach>        
        
        <%-- FAQ --%>
	    <jalios:if predicate="<%= Util.notEmpty(obj.getFaq()) %>">
	        <div class="ds44-inner-container ds44-grid12-offset-1">
	            <jalios:include id="<%= obj.getFaq().getId() %>" />
	        </div>
	    </jalios:if>
        
        <%-- Partagez cette page --%>
        <%@ include file="/plugins/SoclePlugin/jsp/portal/socialNetworksShare.jspf" %>
        
        <%-- TODO : bloc Je m'abonne --%>
        <jalios:if predicate='<%= Util.notEmpty(channel.getProperty("jcmsplugin.socle.portletPush.ficheactu.id")) %>'>
           <jalios:include id='<%= channel.getProperty("jcmsplugin.socle.portletPush.ficheactu.id") %>'/>
        </jalios:if>
        
        <%-- Sur le même thème
             Affichage de contenus catégorisés sous "Mise en  avant > En ce moment" et ayant au moins un catégorie commune parmi
             les catégories de navigation de la fiche actu (branche "Navigation des espaces")
        --%>
        <%
        // Récupération des catégories de navigation
        Category navigationDesEspacesCat = channel.getCategory(channel.getProperty("jcmsplugin.socle.site.menu.cat.root"));
        Set<Category> navCat = new TreeSet<Category>();
        if(Util.notEmpty(obj.getCategorieDeNavigation(loggedMember))){
            for(Category itCat:obj.getCategorieDeNavigation(loggedMember)){
                if(itCat.hasAncestor(navigationDesEspacesCat)){
                    navCat.add(itCat);
                }
            }
        }
        %>
        
        <jalios:if predicate='<%= obj.getSurLeMemeTheme() && !navCat.isEmpty() && Util.notEmpty(channel.getProperty("$jcmsplugin.socle.category.enCeMoment.root"))%>'>
            <% 
            String[] typesRecherches = channel.getStringArrayProperty("jcmsplugin.socle.meme-theme.ficheactu.types", new String[]{});
            
            // Récupération des publications catégorisées dans "En ce moment"
            QueryHandler qhEnCeMoment = new QueryHandler();
            qhEnCeMoment.setCids(channel.getProperty("$jcmsplugin.socle.category.enCeMoment.root"));
            qhEnCeMoment.setLoggedMember(loggedMember);
            qhEnCeMoment.setTypes(typesRecherches);
            QueryResultSet resultEnCeMomentSet = qhEnCeMoment.getResultSet();
            SortedSet<Publication> listPubsEnCeMomentSet = resultEnCeMomentSet.getAsSortedSet(Publication.getPdateComparator());
            
            // Récupération des publication catégorisées dans au moins une des thématiques du communiqué courant.
            QueryHandler qhThemes= new QueryHandler();
            String[] themeCids = JcmsUtil.dataArrayToStringArray(navCat.toArray(new Data[navCat.size()]));
            qhThemes.setCatMode("or");
            qhThemes.setCids(themeCids);
            qhThemes.setLoggedMember(loggedMember);
            qhThemes.setTypes(typesRecherches);
            QueryResultSet resultThemesSet = qhThemes.getResultSet();
            SortedSet<Publication> listPubsThemesSet = resultThemesSet.getAsSortedSet(Publication.getPdateComparator());
            
            // Intersection des 2 sets
            Set<Publication> sameThemePubSet = new TreeSet<Publication>(Publication.getPdateComparator()); 
            sameThemePubSet.addAll(Util.interSet(listPubsEnCeMomentSet, listPubsThemesSet));
                        
            // Suppression de la pub courante
            sameThemePubSet.remove(obj);
            
            // Limiter à un nombre d'éléments max
            int max = channel.getIntegerProperty("jcmsplugin.socle.meme-theme.max", 20);
            List<Publication> tmpList = new ArrayList(sameThemePubSet);
            if(tmpList.size() >= max){
                tmpList = tmpList.subList(0, max);  
            }
            %>
    
            <jalios:if predicate='<%= !sameThemePubSet.isEmpty() && tmpList.size() >= 3 %>'>
                <%
                // Transfo du set en tableau pour passer au carrousel
                Content[] sameThemePubArray = tmpList.toArray(new Content[tmpList.size()]);
                //Content[] sameThemePubArray = sameThemePubSet.toArray(new Content[sameThemePubSet.size()]);
                
                // Instanciation de la portlet carrousel avec les pubs de même thème
                PortletCarousel carouselEnCeMoment = new PortletCarousel();
                carouselEnCeMoment.setTitreDuBloc(glp("jcmsplugin.socle.memetheme"));
                carouselEnCeMoment.setTemplate("box.sliderQuatre");
                carouselEnCeMoment.setSelectionDuTheme("tuileVerticaleLight");
                carouselEnCeMoment.setPositionTitre("bl");
                carouselEnCeMoment.setFirstPublications(sameThemePubArray);
                %>
                
                <jalios:include pub="<%= carouselEnCeMoment %>"/>
                
            </jalios:if>
            
        </jalios:if>
        
    </article>
</main>
