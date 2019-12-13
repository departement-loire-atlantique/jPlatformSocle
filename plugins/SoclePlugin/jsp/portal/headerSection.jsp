<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file='/jcore/doInitPage.jsp'%>
<%@ include file='/jcore/portal/doPortletParams.jsp' %>
<%@ taglib prefix="ds" tagdir="/WEB-INF/tags"%>
<%@ page import="fr.cg44.plugin.socle.SocleUtils"%>


<%
String[] headerCatListId = channel.getStringArrayProperty("jcmsplugin.socle.site.header.cat", new String[] {});
Category[] headerCatList = JcmsUtil.stringArrayToDataArray (Category.class, headerCatListId);

String menuRootCatId = channel.getProperty("jcmsplugin.socle.site.menu.cat.root");
Category menuRootCat = channel.getCategory(menuRootCatId);
Set<Category> menuCatList = Util.notEmpty(menuRootCat) ? SocleUtils.getOrderedAuthorizedChildrenSet(menuRootCat) : new HashSet<Category>();

String subMenuRootCatId = channel.getProperty("jcmsplugin.socle.site.submenu.cat.root");
Category subMenuRootCat = channel.getCategory(subMenuRootCatId);
Set<Category> subMenuCatList = Util.notEmpty(subMenuRootCat) ? SocleUtils.getOrderedAuthorizedChildrenSet(subMenuRootCat) : new HashSet<Category>();

String appliMenuRootCatId = channel.getProperty("jcmsplugin.socle.site.applimenu.cat.root");
Category appliMenuRootCat = channel.getCategory(appliMenuRootCatId);
Set<Category> appliMenuCatList = Util.notEmpty(appliMenuRootCat) ? SocleUtils.getOrderedAuthorizedChildrenSet(appliMenuRootCat) : new HashSet<Category>();

boolean displaySearchMenu = channel.getBooleanProperty("jcmsplugin.socle.site.header.show.rechercher", true);
%>


<header role="banner" id="top" class="ds44-container-fluid ds44-header">
    <div class="ds44-blocBandeau">
	    <ul class="ds44-list">
	        <li><a href="#content" class="ds44-skiplinks--link">Aller au contenu</a></li>
	        <li><a href="#menu" class="ds44-skiplinks--link">Aller au menu</a></li>
	        <li><a href="#search" class="ds44-skiplinks--link">Aller à la recherche</a></li>
	        <li><a href="#" class="ds44-skiplinks--link">Aller à la page d'accessibilité</a></li>
	    </ul>
	
	    <div class="ds44-flex-container ds44-flex-valign-center">
	        <div class="ds44-colLeft">
	            <a href="index.jsp" class="ds44-logoContainer">
	                <picture class="ds44-logo">
	                    <img src="<%= channel.getProperty("jcmsplugin.socle.site.src.logo") %>" alt="<%= glp("jcmsplugin.socle.site.alt.logo") %>" />
	                </picture>
	            </a>
	        </div>
	        <div class="ds44-colRight">            
	            <jalios:if predicate="<%= displaySearchMenu %>">
	                <button class="ds44-btnIcoText--maxi ds44--xl-padding-tb" type="button" aria-label="Ouvrir la recherche"><span class="ds44-btnInnerText">Rechercher</span><i class="icon icon-magnifier icon--large" aria-hidden="true"></i></button>
	            </jalios:if>
	            <jalios:foreach array="<%= headerCatList %>" name="itCat" type="Category">
	                <a href="<%= itCat.getDisplayUrl(userLocale) %>" class="ds44-btnIcoText--maxi ds44--xl-padding" aria-label='<%= glp("jcmsplugin.socle.header.ouvrir", itCat.getName()) %>'><span class="ds44-btnInnerText"><%= itCat.getName() %></span><i class="icon <%= itCat.getIcon() %> icon--large" aria-hidden="true"></i></a>                          
	            </jalios:foreach>
	            <button class="ds44-btnIcoText--maxi ds44-btn--contextual ds44-btn--menu ds44--xl-padding" type="button" aria-label="Ouvrir le menu de navigation"><span class="ds44-btnInnerText">Menu</span><i class="icon icon-burger icon--xlarge" aria-hidden="true"></i></button>
	        </div>
	    </div>
    </div>
    
    <div class="ds44-blocMenu">
            <section id="menu" class="ds44-menuBox">
	            <section id="nav1" class="ds44-overlay ds44-theme ds44-bgCircle ds44-bg-br ds44-overlay--navNiv1" role="dialog" aria-label="Menu principal niveau 1">
				    <p role="heading" aria-level="1" class="visually-hidden">Menu</p>
				        
				    <button class="ds44-btnOverlay ds44-btnOverlay--closeOverlay" type="button" aria-label="fermer le menu de navigation"><i class="icon icon-cross icon--xlarge" aria-hidden="true"></i><span class="ds44-btnInnerText--bottom">Fermer</span></button>
				
				    <nav role="navigation" class="ds44-navContainer ds44-flex-container--column ds44-flex-valign-center" aria-label="Menu de navigation">
				        <div class="ds44-inner-container ds44-flex-container--column ds44-flex-mauto">
				            <ul class="ds44-navList ds44-multiCol ds44-xl-gap ds44-list">
				            <% int i = 1; %>
				            <jalios:foreach collection="<%= menuCatList %>" name="itCat" type="Category">
				                <%
				                    i++;
				                    String navId = "nav"+i;
				                %>
				                <li>
				                    <button type="button" class="ds44-menuBtn" data-ssmenu='<%= navId %>'><%= itCat.getName(userLang) %><i class="icon icon-right" aria-hidden="true"></i></button>
				                    <ds:levelTwoMenu rootCat="<%= itCat %>" id='<%= navId %>' userLocale="<%= userLocale %>" userLang="<%= userLang %>"/>
				                </li>
				            </jalios:foreach>
				            </ul>
				            <hr class="ds44-navSep" />
				            <ul class="ds44-navList ds44-multiCol ds44-xl-gap ds44-list">
	                        <jalios:foreach collection="<%= subMenuCatList %>" name="itCat" type="Category">
	                            <ds:menuLink itCategory="<%= itCat %>" userLang="<%= userLang %>" userLocale="<%= userLocale %>"/>
	                        </jalios:foreach>
	                        </ul>
				        </div>
				
				        <div class="ds44-container-fixed ds44-posBot ds44-container-relmob">
				            <div class="ds44-flex-container ds44-flex-align-center">
				                <p class="h4-like mbm ds44-hide-mobile">Suivez-nous sur les réseaux</p>
				                <ul class="ds44-list ds44-flex-container ds44-list">                
				                    <li><a href="https://www.facebook.com/loireatlantique" class="ds44-rsHeadLink" title="Le Département Loire Atlantique sur Facebook"><i class="icon icon-facebook" aria-hidden="true"></i><span class="visually-hidden">Le Département Loire Atlantique sur Facebook</span></a></li>
				                    <li><a href="https://twitter.com/loireatlantique" class="ds44-rsHeadLink" title="Le Département Loire Atlantique sur Twitter"><i class="icon icon-twitter" aria-hidden="true"></i><span class="visually-hidden">Le Département Loire Atlantique sur Twitter</span></a></li>
				                    <li><a href="http://instagram.com/loireatlantique" class="ds44-rsHeadLink" title="Le Département Loire Atlantique sur Instagram"><i class="icon icon-instagram" aria-hidden="true"></i><span class="visually-hidden">Le Département Loire Atlantique sur Instagram</span></a></li>
				                    <li><a href="http://www.youtube.com/user/LoireAtlantiqueTV" class="ds44-rsHeadLink" title="Le Département Loire Atlantique sur Youtube"><i class="icon icon-youtube" aria-hidden="true"></i><span class="visually-hidden">Le Département Loire Atlantique sur Youtube</span></a></li>
				                    <li><a href="https://www.loire-atlantique.fr/lemag" class="ds44-rsHeadLink" title="Le Département Loire Atlantique sur Mag Web"><i class="icon icon-magweb" aria-hidden="true"></i><span class="visually-hidden">Le Département Loire Atlantique sur Magweb</span></a></li>
				                </ul>
				            </div>
				            <button type="button" class="ds44-fullWBtn ds44-btn--invert" id="ds44-btn-applis"><span class="ds44-btnInnerText">Sites et applis du Département</span><i class="icon icon-down" aria-hidden="true"></i></button>
	                        <section class="ds44-overlay ds44-overlay--navApplis ds44-wave-grey ds44-bg-b" role="dialog" aria-label="Menu des sites et applications du département" id="navApplis">
	        
							    <button class="ds44-btnOverlay ds44-btnOverlay--closeOverlay" type="button" aria-label="fermer le menu des sites et applications"><i class="icon icon-cross icon--xlarge" aria-hidden="true"></i><span class="ds44-btnInnerText--bottom">Fermer</span></button>
							
							    <nav role="navigation">
							            <div class="ds44-inner-container">
							    
							                <div class="ds44-container-menuBackLink ds44-hide-mobile">
										        <button type="button" title="Retour au menu de navigation" class="ds44-btn-backOverlay"><i class="icon icon-arrow-left icon--xlarge" aria-hidden="true"></i><span class="ds44-btnInnerText--bottom">Retour</span></button>
										        <p role="heading" aria-level="1" class="ds44-menuBackLink">Sites et applis du département</p>
										    </div>
										
										    <div class="ds44-container-menuBackLink ds44-show-mobile">
										        <p role="heading" aria-level="1" class="ds44-menuBackLink">Sites et applis du département</p>
										    </div>
							
							                <ul class="ds44-navListApplis ds44-multiCol ds44-multiCol--3 ds44-multiCol--border ds44-m-gap ds44-m-fluid-margin ds44-list">
							                <jalios:foreach collection="<%= appliMenuCatList %>" name="itCat" type="Category">
							                    <li>
							                        <p role="heading" aria-level="2" class="ds44-menuApplisTitle"><%= itCat.getName() %></p>
							                        <ul class="ds44-list">
							                        <jalios:foreach collection="<%= itCat.getChildrenSet() %>" name="itSubCat" type="Category">
							                            <ds:menuLink itCategory="<%= itSubCat %>" userLang="<%= userLang %>" userLocale="<%= userLocale %>"/>
							                        </jalios:foreach>
							                        </ul>
							                    </li>
							                </jalios:foreach>
							                </ul>
							            </div>
							        </nav>
							
							</section>
				        </div>
				    </nav>
				
				</section>
			</section>
	</div>
    
</header>

