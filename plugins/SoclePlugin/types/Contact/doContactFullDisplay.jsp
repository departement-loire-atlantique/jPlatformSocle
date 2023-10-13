<%@page import="fr.cg44.plugin.socle.SocleUtils"%>
<%@ page import="fr.cg44.plugin.socle.VideoUtils" %>
<%@ page contentType="text/html; charset=UTF-8" %><%
%><%@ taglib prefix="ds" tagdir="/WEB-INF/tags"%><%
%><%@ include file='/jcore/doInitPage.jspf' %><%
%><% Contact obj = (Contact)request.getAttribute(PortalManager.PORTAL_PUBLICATION); %><%
%><%@ include file='/front/doFullDisplay.jspf' %>

<main id="content" role="main">

<jalios:include target="SOCLE_ALERTE"/>

    <article class="ds44-container-large">
		
		<%@page import="com.jalios.jcms.HttpUtil"%>
		<%
		    String imageFile = obj.getImagePrincipale();
		    String imageMobileFile = "";
		    String title = obj.getPrenom()+" "+obj.getNom()+", "+obj.getFonction(userLang);
		    String legende = "";
		    String copyright = "";
		%>
		
		<ds:titleSimple pub="<%= obj %>" title="<%= title %>" breadcrumb="true"></ds:titleSimple>
		
		<section>
		    <div>		
		        <%
		        String[] currentTitresParagraphes = new String[0];
		        String[] currentContenusParagraphes = new String[0];
		        String[] currentTitresEncadres = new String[0];
		        String[] currentContenusEncadres = new String[0];
		        PortalElement[] currentContenusPortlets = new PortalElement[0];
		        boolean chapoDisplayed = false;
		        boolean encadresCommunsFound = false;		        
		        
		        if(Util.notEmpty(obj.getFieldValue("contenuParagraphe", userLang))) {
		            currentTitresParagraphes = (String[]) (obj.getFieldValue("titreParagraphe", userLang));
		            currentContenusParagraphes = (String[]) (obj.getFieldValue("contenuParagraphe", userLang));
		        }
		        if(Util.notEmpty(obj.getFieldValue("bottomportlets", userLang))) {
		          currentContenusPortlets = (PortalElement[]) (obj.getFieldValue("bottomportlets", userLang));
		        }
		        %>
		        
		        <div class='ds44-inner-container ds44-xl-margin-tb'>
		        
		           <div class="grid-12-small-1">
		               <div class="col-7">
		
		                    <jalios:if predicate="<%=Util.notEmpty(obj.getIntro(userLang)) && !chapoDisplayed%>">
		                        <div class="ds44-introduction">
		                            <jalios:wysiwyg><%=obj.getIntro(userLang)%></jalios:wysiwyg>
		                        </div>
		                    </jalios:if>
		                    <% chapoDisplayed = true; %>
		                    
		                    <%-- Boucler sur les paragraphes --%>
		                    <jalios:foreach name="itContenu" type="String" counter="itCounter"
		                        array="<%=currentContenusParagraphes%>">
		                        <section id="section<%=itCounter%>" class="ds44-contenuArticle">
		                            <jalios:if predicate="<%= Util.notEmpty(currentTitresParagraphes) && (itCounter <= currentTitresParagraphes.length) 
		                                                    && Util.notEmpty(currentTitresParagraphes[itCounter - 1]) %>">
		                                <h2 class="h2-like" id="titreParagraphe<%=itCounter%>"><%=currentTitresParagraphes[itCounter - 1]%></h2>
		                            </jalios:if>
		                            <jalios:wysiwyg><%=itContenu%></jalios:wysiwyg>
		                        </section>
		                    </jalios:foreach>
		                    
		               </div>
		               
		               <div class="col-1 grid-offset ds44-hide-tiny-to-medium"></div>
		
		                <aside class="col-4 asideCards">
							
							<img alt='<%= obj.getPrenom()+" "+obj.getNom() %>' src="<%= obj.getPhotoDidentite() %>"/>
							
							<% FicheLieu ficheLieu = obj.getLieuDeRattachement(); %>
							
							<jalios:if predicate="<%= Util.notEmpty(ficheLieu) %>">
							 
							     <section class="ds44-box ds44-theme mbm">
	                                <div class="ds44-innerBoxContainer">
	                                    
	                                    <p class="ds44-box-heading" role="heading" aria-level="2"><%= glp("ui.com.lbl.contact") %></p>
	                        
	                                    <div class="mbm">
	                                       <div>
		                                       <i class="icon icon-marker" aria-hidden="true"></i> 
		                                       <%= SocleUtils.formatAdressePhysique(ficheLieu).replaceAll("<br>", ", ") %>
	                                       </div>
	                                       <jalios:if predicate="<%= Util.notEmpty(obj.getTelephone()) %>">
		                                       <div>
		                                           <jalios:foreach name="numTel" type="String" array="<%= obj.getTelephone() %>">
	                                                   <jalios:if predicate="<%= itCounter>1 %>">, </jalios:if>
	                                                   <i class="icon icon-phone" aria-hidden="true"></i> 
	                                                   <span><ds:phone number="<%= numTel %>" pubTitle="<%= obj.getTitle() %>"/></span>
	                                               </jalios:foreach>
		                                       </div>
	                                       </jalios:if>
	                                       <jalios:if predicate="<%= Util.notEmpty(obj.getAdresseMail()) %>">
	                                           <div>
	                                               <i class="icon icon-mail" aria-hidden="true"></i> 
	                                               <%= obj.getAdresseMail() %>
	                                           </div>
	                                       </jalios:if>
	                                    </div>
	                                    <jalios:if predicate="<%= Util.notEmpty(obj.getComplementContact(userLang)) %>">
		                                    <div class="mbs">
		                                       <jalios:wysiwyg>
		                                          <%= obj.getComplementContact(userLang) %>
		                                       </jalios:wysiwyg>
		                                    </div>
	                                    </jalios:if>
	                                    
	                                    <jalios:if predicate="<%= Util.notEmpty(obj.getLienExterne()) %>">
		                                    <div class="mbm">
			                                    <jalios:foreach name="itUrl" type="String" array="<%= obj.getLienExterne() %>">
			                                       <div class="mbs">
				                                       <a href="<%= itUrl %>">
					                                       <button class="ds44-btnStd ds44-fullWBtn ds44-bntALeft">
					                                         <span class="ds44-btnInnerText">
					                                           <% 
					                                           if(Util.notEmpty(Util.notEmpty(obj.getLibelleLien(userLang)))) {
					                                             String libelle = obj.getLibelleLien(userLang).length < itCounter || Util.isEmpty(obj.getLibelleLien(userLang)[itCounter-1]) ?
					                                                 itUrl : obj.getLibelleLien(userLang)[itCounter-1];
					                                             %><%= libelle %><%
					                                           } else {
					                                             %><%= itUrl %><%
					                                           }
					                                           %>
					                                         </span>
					                                       </button>
				                                       </a>
			                                       </div>
			                                    </jalios:foreach>
		                                    </div>
	                                    </jalios:if>
	                              </div>
	                            </section>
							
							</jalios:if>
							
					         
		                </aside>
		        
		           </div>
		           
		        </div>		       
		    
		    </div>
		
		</section>
		
		<jalios:if predicate='<%= Util.notEmpty(obj.getBottomportlets()) %>'>
	        <jalios:foreach name="portlet" type="PortalElement" array='<%= obj.getBottomportlets() %>'>
	            <jalios:include pub='<%= portlet %>'></jalios:include>
	        </jalios:foreach>
	    </jalios:if>
	    
	    <%-- Partagez cette page --%>
        <%@ include file="/plugins/SoclePlugin/jsp/portal/socialNetworksShare.jspf" %>
		
    </article>
    
</main>
