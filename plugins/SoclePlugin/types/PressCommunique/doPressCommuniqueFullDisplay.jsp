<%@ page import="fr.cg44.plugin.socle.SocleUtils"%>
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
               <%= SocleUtils.formatDate("dd/MM/yyyy", obj.getPdate()) %>
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
                <p><a class="ds44-btnStd ds44-btn--invert" href="<%= fichier %>" target="_blank" title="<%= glp("jcmsplugin.socle.presscommunique.telecharger.title", obj.getPressCommuniqueDirectory().getTitle(),fileSize,fileType) %>"><span class="ds44-btnInnerText"><%= glp("jcmsplugin.socle.presscommunique.telecharger.label") %></span><i class="icon icon-pdf" aria-hidden="true"></i></a></p>

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
			        <jalios:if predicate='<%= Util.notEmpty(obj.getLibelleLien()) %>'>
                        <div class="ds44-docListElem mts"><i class="icon icon-link ds44-docListIco" aria-hidden="true"></i>
				            <ul class="ds44-list">
				                <jalios:foreach name="itLien" type="String" counter="itCounter" array='<%=obj.getLibelleLien()%>'>
				                    <jalios:if predicate='<%= Util.notEmpty(obj.getLienExterne()) && itCounter <= obj.getLienExterne().length && Util.notEmpty(obj.getLienExterne()[itCounter-1]) %>'>
				                        <li>
				                            <a href="<%= obj.getLienExterne()[itCounter-1] %>" 
				                            title='<%= HttpUtil.encodeForHTMLAttribute(glp("jcmsplugin.socle.lien.site.nouvelonglet", itLien)) %>' 
				                            target="_blank">
				                            <%= itLien %>
				                            </a>
				                        </li>
				                    </jalios:if>
				                </jalios:foreach>
				            </ul>
                        </div>
			        </jalios:if>
			
			        <%-- Boucle sur les liens internes --%>
			        <jalios:if predicate='<%= Util.notEmpty(obj.getLienInterne()) %>'>
                        <div class="ds44-docListElem mts"><i class="icon icon-tag ds44-docListIco" aria-hidden="true"></i>
				            <ul class="ds44-list">
				                <jalios:foreach name="itLien" type="Publication" counter="itCounter" array='<%=obj.getLienInterne()%>'>
				                    <li>
				                        <a href="<%= itLien.getDisplayUrl(userLocale) %>"><%= itLien %></a>
				                    </li>
				                </jalios:foreach>
				            </ul>
                        </div>
			        </jalios:if>
			        
                </div>
            </div>
        </section>
        


    </article>
    
    <%-- TODO : partage réseaux sociaux --%>
    
    <%-- TODO : page utile --%>  


</main>