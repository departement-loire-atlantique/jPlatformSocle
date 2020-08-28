<%@ page import="fr.cg44.plugin.socle.SocleUtils"%>
<%@page import="com.jalios.jcms.handler.QueryHandler"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="ds" tagdir="/WEB-INF/tags"%>
<%@ include file='/jcore/doInitPage.jspf'%>
<%
PressCommunique obj = (PressCommunique)request.getAttribute(PortalManager.PORTAL_PUBLICATION);
%>
<%@ include file='/front/doFullDisplay.jspf' %>


<jalios:buffer name="coloredSectionContent">
    <div class="grid-2-small-1 ds44-grid12-offset-1">

        <%-- Col gauche --%>
        <div class="col">
            <div class="ds44-docListElem mts"><i class="icon icon-date ds44-docListIco" aria-hidden="true"></i>
                <jalios:date format="dd/MM/yyyy" date="<%= obj.getPdate() %>"/>
            </div>
            
            <jalios:if predicate='<%= Util.notEmpty(obj.getPolitiquesPubliques(loggedMember)) || Util.notEmpty(obj.getMissionsThematiques(loggedMember))%>'>
                <div class="ds44-docListElem mts"><i class="icon icon-tag ds44-docListIco" aria-hidden="true"></i>
                    <ul class="ds44-list">
                    
                    <jalios:foreach collection="<%= obj.getPolitiquesPubliques(loggedMember) %>" type="Category" name="itPolitiquePublique" >
                      <li><%= itPolitiquePublique %></li>
                    </jalios:foreach>
                    
                    <jalios:foreach collection="<%= obj.getMissionsThematiques(loggedMember) %>" type="Category" name="itMissionThematique" >
                      <li><%= itMissionThematique %></li>
                    </jalios:foreach>
                    
                    </ul>
                </div>
            </jalios:if>
            
            <jalios:if predicate='<%= Util.notEmpty(obj.getPressCommuniqueDirectory()) %>'>
                <%
                String fichier = obj.getPressCommuniqueDirectory().getDownloadUrl();
                String fileType = FileDocument.getExtension(obj.getPressCommuniqueDirectory().getFilename()).toUpperCase();
                String fileSize = Util.formatFileSize(obj.getPressCommuniqueDirectory().getSize());
                %>
                <p class="mtm"><a class="ds44-btnStd ds44-btn--invert" href="<%= fichier %>" target="_blank" title="<%= glp("jcmsplugin.socle.presscommunique.telecharger.title", obj.getPressCommuniqueDirectory().getTitle(),fileSize,fileType) %>"><span class="ds44-btnInnerText"><%= glp("jcmsplugin.socle.presscommunique.telecharger.label") %></span><i class="icon icon-pdf" aria-hidden="true"></i></a></p>

            </jalios:if>

        </div>
        
        <%-- Col droite --%>
        <div class="col ds44--xl-padding-l">
            <jalios:select>
            
                <%-- Si infos de contact pas renseignées, affichage des valeurs par défaut --%>
                
                <jalios:if predicate='<%= Util.isEmpty(obj.getPressContactName()) && Util.isEmpty(obj.getPressContactMails()) && Util.isEmpty(obj.getPressContactPhones()) %>'>
                
                    <div class="ds44-docListElem mts"><i class="icon icon-user ds44-docListIco" aria-hidden="true"></i>
                        <%= glp("jcmsplugin.socle.presscommunique.contact-presse.nom.default") %>
                    </div>
                    
                    <div class="ds44-docListElem mts"><i class="icon icon-mail ds44-docListIco" aria-hidden="true"></i>
                        <a href='mailto:<%= glp("jcmsplugin.socle.presscommunique.contact-presse.email.default") %>'
                            title='<%= HttpUtil.encodeForHTMLAttribute(
                                    glp("jcmsplugin.socle.contactmail", 
                                    glp("jcmsplugin.socle.presscommunique.contact-presse.nom.default"),
                                    glp("jcmsplugin.socle.presscommunique.contact-presse.email.default"))) %>'>
                                    
                            <%= glp("jcmsplugin.socle.presscommunique.contact-presse.email.default") %>
                        </a>
                    </div>
                    
                    <div class="ds44-docListElem mts"><i class="icon icon-phone ds44-docListIco" aria-hidden="true"></i>
                        <ds:phone number='<%= glp("jcmsplugin.socle.presscommunique.contact-presse.tel.default") %>'></ds:phone>
                    </div>
                </jalios:if>
                
                <jalios:default>
                
                   <jalios:if predicate='<%= Util.notEmpty(obj.getPressContactName()) %>'>
                       <div class="ds44-docListElem mts"><i class="icon icon-user ds44-docListIco" aria-hidden="true"></i>
                            <%= obj.getPressContactName() %>
                        </div>
                   </jalios:if>
                   
                   <jalios:if predicate='<%= Util.notEmpty(obj.getPressContactMails()) %>'>
                       <div class="ds44-docListElem mts"><i class="icon icon-mail ds44-docListIco" aria-hidden="true"></i>
                           <% String nomContact = Util.notEmpty(obj.getPressContactName()) ? obj.getPressContactName() : ""; %>
                           
                            <jalios:if predicate='<%= obj.getPressContactMails().length == 1 %>'>
                                <% String email = obj.getPressContactMails()[0]; %>
                                <a href='<%= "mailto:"+email %>'
                                   title='<%= HttpUtil.encodeForHTMLAttribute(glp("jcmsplugin.socle.contactmail", nomContact, email)) %>'
                                   data-statistic='{"name": "declenche-evenement","category": "BlocNousContacter","action": "Mailto","label": "<%= HttpUtil.encodeForHTMLAttribute(obj.getTitle()) %>"}'> 
                                    <%= email %>
                                </a>
                            </jalios:if>
    
                            <jalios:if predicate='<%= obj.getPressContactMails().length > 1 %>'>
                                <ul class="ds44-list">
                                    <jalios:foreach name="email" type="String" array='<%= obj.getPressContactMails() %>'>
                                        <li>
                                            <a href='<%= "mailto:"+email %>'
                                                title='<%= HttpUtil.encodeForHTMLAttribute(glp("jcmsplugin.socle.contactmail", nomContact, email)) %>'
                                                data-statistic='{"name": "declenche-evenement","category": "BlocNousContacter","action": "Mailto","label": "<%= HttpUtil.encodeForHTMLAttribute(obj.getTitle()) %>"}'> 
                                                <%= email %>
                                            </a>
                                        </li>
                                    </jalios:foreach>
                                </ul>
                            </jalios:if>

                        </div>
                   </jalios:if>
                   
                   <jalios:if predicate='<%= Util.notEmpty(obj.getPressContactPhones()) %>'>
                       <div class="ds44-docListElem mts"><i class="icon icon-phone ds44-docListIco" aria-hidden="true"></i>
                       
                            <jalios:if predicate='<%= obj.getPressContactPhones().length == 1 %>'>
                                <% String numTel = obj.getPressContactPhones()[0]; %>
                                <ds:phone number="<%= numTel %>" pubTitle="<%= HttpUtil.encodeForHTMLAttribute(obj.getTitle()) %>"/>
                            </jalios:if>
                    
                            <jalios:if predicate='<%= obj.getPressContactPhones().length > 1 %>'>
                                <ul class="ds44-list">
                                    <jalios:foreach name="numTel" type="String" array="<%= obj.getPressContactPhones() %>">
                                        <li>
                                            <ds:phone number="<%= numTel %>" pubTitle="<%= HttpUtil.encodeForHTMLAttribute(obj.getTitle()) %>"/>
                                        </li>
                                    </jalios:foreach>
                                </ul>
                            </jalios:if>

                        </div>
                   </jalios:if>
                   
                </jalios:default>
            </jalios:select>
        </div>
    </div>
</jalios:buffer>

<main id="content" role="main">
    <article class="ds44-container-large">
    
        <ds:titleNoImage title="<%= obj.getTitle(userLang) %>" breadcrumb="true" coloredSection="<%= coloredSectionContent %>"></ds:titleNoImage>

        <section class="ds44-contenuArticle" id="section2">
            <div class="ds44-inner-container ds44-mtb3">
                <div class="ds44-grid12-offset-2">
                
                    <%-- Chapo "En bref" --%>
                    <jalios:if predicate='<%= Util.notEmpty(obj.getSummary()) %>'>
                        <h2><%= glp("jcmsplugin.socle.enbref") %></h2>
                        <jalios:wysiwyg><%= obj.getSummary() %></jalios:wysiwyg>
                    </jalios:if>
                    
                    <%-- Boucle sur les liens externes --%>
                    <jalios:if predicate='<%= Util.notEmpty(obj.getLienExterne()) %>'>
                        <ul class="ds44-list">
                            <jalios:foreach name="itLien" type="String" counter="itCounter" array='<%=obj.getLienExterne()%>'>
                                <jalios:if predicate='<%= Util.notEmpty(obj.getLienExterne()[itCounter-1]) %>'>
                                    <%
                                    String libelleLien = glp("jcmsplugin.socle.savoirplus");
                                    if(Util.notEmpty(obj.getLibelleLien()) && itCounter <= obj.getLibelleLien().length && Util.notEmpty(obj.getLibelleLien()[itCounter-1]) ){
                                        libelleLien = obj.getLibelleLien()[itCounter-1];
                                    }
                                    
                                    %>
                                    <li>
                                        <p class="ds44-docListElem">
                                            <i class="icon icon-link ds44-docListIco" aria-hidden="true"></i>
                                            <a href="<%= obj.getLienExterne()[itCounter-1] %>" 
                                            title='<%= HttpUtil.encodeForHTMLAttribute(glp("jcmsplugin.socle.lien.site.nouvelonglet", itLien)) %>' 
                                            target="_blank">
                                            <%= libelleLien %>
                                            </a>
                                       </p>
                                    </li>
                                </jalios:if>
                            </jalios:foreach>
                        </ul>
                    </jalios:if>
            
                    <%-- Boucle sur les liens internes --%>
                    <jalios:if predicate='<%= Util.notEmpty(obj.getLienInterne()) %>'>
                        <ul class="ds44-list">
                            <jalios:foreach name="itLien" type="Publication" counter="itCounter" array='<%=obj.getLienInterne()%>'>
                                <li>
                                     <p class="ds44-docListElem">
                                         <i class="icon icon-tag ds44-docListIco" aria-hidden="true"></i>
                                         <a href="<%= itLien.getDisplayUrl(userLocale) %>"><%= itLien %></a>
                                     </p>
                                </li>
                            </jalios:foreach>
                        </ul>
                    </jalios:if>
                    
                </div>
            </div>
        </section>
 
        <jalios:if predicate="<%= Util.notEmpty(obj.getVideo()) %>">
        
            <section class="ds44-contenuArticle" id="sectionTitreVideo">
                <div class="ds44-inner-container ds44-mtb3">
                    <div class="ds44-grid12-offset-2">
                        <h2><%= glp("jcmsplugin.socle.envideo") %></h2>
                    </div>
                </div>
            </section>
            
            <jalios:foreach name="itVideo" type="generated.Video" array="<%= obj.getVideo() %>">
                <ds:articleVideo video="<%= itVideo %>"/>
            </jalios:foreach>

        </jalios:if>
        
        <jalios:if predicate="<%= Util.notEmpty(obj.getRelatedNews()) %>">
        
            <section class="ds44-contenuArticle" id="sectionActus">
                <div class="ds44-inner-container ds44-mtb3">
                    <div class="ds44-grid12-offset-2">
                        <div class="ds44-innerBoxContainer ds44-box ds44-bgGray">
                            <h2 class="ds44-box-heading"><%= glp("jcmsplugin.socle.alireaussi") %></h2>
                            <ul class="ds44-list">
                                <jalios:foreach name="itLien" type="com.jalios.jcms.Content" array="<%= obj.getRelatedNews() %>">
                                    <p class="ds44-docListElem">
                                        <i class="icon icon-tag ds44-docListIco" aria-hidden="true"></i>
                                        <a href="<%= itLien.getDisplayUrl(userLocale) %>"><%= itLien %></a>
                                    </p>
                                </jalios:foreach>
                            </ul>
                        </div>
                    </div>
                </div>
            </section>

        </jalios:if>
        
        <%-- Bannière Push (comme sur les fiches actu) --%>
        <jalios:if predicate='<%= Util.notEmpty(channel.getProperty("jcmsplugin.socle.portletPush.ficheactu.id")) %>'>
           <jalios:include id='<%= channel.getProperty("jcmsplugin.socle.portletPush.ficheactu.id") %>'/>
        </jalios:if>
        
        <%-- Sur le même thème
             Affichage de contenus catégorisés sous "Mise en  avant > En ce moment" et ayant au moins un catégorie commune parmi
             les catégories "politiques publiques" et "missions thématiques" du communiqué de presse.
        --%>
        <%
        // Récupération des catégories filles de "politiques publiques" et "missions thématiques"
        Set<Category> thematiques = new TreeSet<Category>();
        thematiques.addAll(obj.getPolitiquesPubliques(loggedMember));
        thematiques.addAll(obj.getMissionsThematiques(loggedMember));
        %>
        
        <jalios:if predicate='<%= !thematiques.isEmpty() && Util.notEmpty(channel.getProperty("$jcmsplugin.socle.category.enCeMoment.root"))%>'>
	        <% 
	        // Récupération des publications catégorisées dans "En ce moment"
	        QueryHandler qhEnCeMoment = new QueryHandler();
	        qhEnCeMoment.setCids(channel.getProperty("$jcmsplugin.socle.category.enCeMoment.root"));
	        qhEnCeMoment.setLoggedMember(loggedMember);
	        qhEnCeMoment.setTypes("Content");
	        QueryResultSet resultEnCeMomentSet = qhEnCeMoment.getResultSet();
	        SortedSet<Publication> listPubsEnCeMomentSet = resultEnCeMomentSet.getAsSortedSet(Publication.getPdateComparator());
	        
	        // Récupération des publication catégorisées dans au moins une des thématiques du communiqué courant.
	        QueryHandler qhThemes= new QueryHandler();
	        String[] themeCids = JcmsUtil.dataArrayToStringArray(thematiques.toArray(new Data[thematiques.size()]));
	        qhThemes.setCatMode("or");
	        qhThemes.setCids(themeCids);
	        qhThemes.setLoggedMember(loggedMember);
	        qhThemes.setTypes("Content");
	        QueryResultSet resultThemesSet = qhThemes.getResultSet();
	        SortedSet<Publication> listPubsThemesSet = resultThemesSet.getAsSortedSet(Publication.getPdateComparator());
	        
	        // Intersection des 2 sets
	        Set<Publication> sameThemePubSet = new TreeSet<Publication>(Publication.getPdateComparator()); 
            sameThemePubSet.addAll(Util.interSet(listPubsEnCeMomentSet, listPubsThemesSet));
	        
	        // Suppression de la pub courante
	        sameThemePubSet.remove(obj);
	        %>
	
	        <jalios:if predicate='<%= !sameThemePubSet.isEmpty() %>'>
	            <%
		        // Transfo du set en tableau pour passer au carrousel
		        Content[] sameThemePubArray = sameThemePubSet.toArray(new Content[sameThemePubSet.size()]);
		        
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
    
    <%-- TODO : partage réseaux sociaux --%>
    
    <%-- TODO : page utile --%>  


</main>