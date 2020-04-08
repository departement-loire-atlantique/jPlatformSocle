<%@ page contentType="text/html; charset=UTF-8" %><%
%><%@ taglib prefix="ds" tagdir="/WEB-INF/tags"%><%
%><%@ include file='/jcore/doInitPage.jspf' %><%
%><% AccueilAnnuaireAgenda obj = (AccueilAnnuaireAgenda)request.getAttribute(PortalManager.PORTAL_PUBLICATION); %><%
%>

<main id="content" role="main">
    <section class="ds44-container-large">
        <ds:titleBanner imagePath="<%= obj.getImageBandeau() %>" mobileImagePath="<%= obj.getImageMobile() %>" title="<%= obj.getTitle() %>"
            legend="<%= obj.getLegende() %>" copyright="<%= obj.getLegende() %>" breadcrumb="true" pubId='<%= obj.getId() %>></ds:titleBanner>
    </section>
    
    <section class="ds44-container-large">
        <div class="ds44-mtb3 ds44--xl-padding-tb">
            <jalios:if predicate="<%= Util.notEmpty(obj.getPortletRecherche()) %>">
		        <div class="ds44-loader-text visually-hidden" tabindex="-1" aria-live="polite"></div>
		        <div class="ds44-loader hidden">
                    <div class="ds44-loader-body">
                        <svg class="ds44-loader-circular" focusable="false" aria-hidden="true">
                            <circle class="ds44-loader-path" cx="30" cy="30" r="20" fill="none" stroke-width="5" stroke-miterlimit="10"></circle>
                        </svg>
                    </div>
                </div>
		        <jalios:include pub="<%= obj.getPortletRecherche() %>"/>
		    </jalios:if>
		    
		    <div class="ds44-inner-container ds44-mt3 ds44--l-padding-t">
		        <div class="grid-12-small-1">
		            <div class='col-<%= Util.isEmpty(obj.getContenusEncadresLibres()) && Util.isEmpty(obj.getPortletsEncadres()) ? "12" : "7" %>'>
		                <%-- On part du principe qu'au moins un paragraphe est rédigé --%>
		                <jalios:foreach name="itParagraphe" type="String" counter="itCounter"
					      array="<%=obj.getContenuParagraphe()%>">
						    <section id="section<%=itCounter%>"
						      class="ds44-contenuArticle">
						        <div class="ds44-inner-container ds44-mtb3">
						            <jalios:if predicate="<%= Util.notEmpty(obj.getTitreParagraphe())
						              && itCounter <= obj.getTitreParagraphe().length && Util.notEmpty(obj.getTitreParagraphe()[itCounter - 1]) %>">
						                <h2 class="h2-like" id="titreParagraphe<%=itCounter%>"><%=obj.getTitreParagraphe()[itCounter - 1]%></h2>
						            </jalios:if>
						            <jalios:wysiwyg><%=itParagraphe%></jalios:wysiwyg>
						        </div>
						    </section>
						</jalios:foreach>
		            </div>
		            
		            <jalios:if predicate="<%= Util.notEmpty(obj.getContenusEncadresLibres()) || Util.notEmpty(obj.getPortletsEncadres()) %>">
		                <div class="col-1 grid-offset ds44-hide-tiny-to-medium"></div>

						<aside class="col-4">
							<jalios:foreach array="<%=obj.getContenusEncadresLibres()%>" type="String"
							    name="itContenu" counter="itCounter">
							    <section class="ds44-box ds44-theme mbm">
							        <div class="ds44-innerBoxContainer">
							            <jalios:if predicate="<%=Util.notEmpty(obj.getTitreEncadresLibres()) && obj.getTitreEncadresLibres().length > itCounter-1 && Util.notEmpty(obj.getTitreEncadresLibres()[itCounter - 1]) %>">
							                <p class="ds44-box-heading" role="heading" aria-level="2"><%=obj.getTitreEncadresLibres()[itCounter - 1]%></p>
							            </jalios:if>
							            <div class="mts"><%=itContenu%></div>
							        </div>
							    </section>
							</jalios:foreach>
							
							<jalios:foreach array="<%=obj.getPortletsEncadres()%>"
							    type="PortalElement" name="itPortalElem">
							    <jalios:if predicate="<%=itPortalElem instanceof PortletWYSIWYG%>">
							        <%
							            PortletWYSIWYG itWysiwyg = (PortletWYSIWYG) itPortalElem;
							        %>
							        <section class="ds44-box mbm <%= itWysiwyg.getCssClasses() %>">
							            <div class="ds44-innerBoxContainer">
							                <p class="ds44-box-heading" role="heading" aria-level="2"><%=itWysiwyg.getTitle()%></p>
							                <div class="mts"><%=itWysiwyg.getWysiwyg()%></div>
							            </div>
							        </section>
							    </jalios:if>
							</jalios:foreach>
						</aside>
					</jalios:if>
		        </div>
		    </div>
        </div>
    </section>
    
    <jalios:if predicate="<%= Util.notEmpty(obj.getFaq()) %>">
        <section class="ds44-container-fluid ds44-lightBG ds44-wave-white ds44--xxl-padding-tb">
            <jalios:include pub="<%= obj.getFaq() %>"/>
        </section>
    </jalios:if>
    
</main>