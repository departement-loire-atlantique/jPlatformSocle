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

boolean displaySearchMenu = channel.getBooleanProperty("jcmsplugin.socle.site.header.show.rechercher", true);
%>


<header role="banner" id="topPage">
    <div class="ds44-blocBandeau ds44-header">
        <div class="ds44-container-large">
    
            <ul class="ds44-list ds44-skiplinks">
                <li><a href="#content" class="ds44-skiplinks--link"><%= glp("jcmsplugin.socle.skiplinks.content") %></a></li>
                <li><a href="#menu" class="ds44-skiplinks--link"><%= glp("jcmsplugin.socle.skiplinks.menu") %></a></li>
                <li><a href="#" class="ds44-skiplinks--link"><%= glp("jcmsplugin.socle.skiplinks.search") %></a></li>
                <li><a href="#" class="ds44-skiplinks--link"><%= glp("jcmsplugin.socle.skiplinks.accessibility") %></a></li>
            </ul>
    
            <div class="ds44-flex-container ds44-flex-valign-center">
                <div class="ds44-colLeft">
                    <a href="index.jsp" class="ds44-logoContainer">
                        <picture class="ds44-logo">
                            <jalios:if predicate='<%= Util.notEmpty(channel.getProperty("jcmsplugin.socle.site.src.logomobile")) %>'>
                                <source media='(max-width: 47.9375em)' srcset='<%= channel.getProperty("jcmsplugin.socle.site.src.logomobile") %>'>
                                <source media='(min-width: 47.9375em)' srcset='<%= channel.getProperty("jcmsplugin.socle.site.src.logo") %>'>
                            </jalios:if>
                            <img src='<%= channel.getProperty("jcmsplugin.socle.site.src.logo") %>' alt="<%= HttpUtil.encodeForHTMLAttribute(glp("jcmsplugin.socle.retour.accueil")) %> <%=channel.getName() %>" />
                        </picture>
                    </a>
                </div>
                <div class="ds44-colRight">            
                    <jalios:if predicate="<%= displaySearchMenu %>">
                        <button class="ds44-btnIcoText--maxi ds44--xl-padding" type="button">
                           <span class="ds44-btnInnerText"><%=glp("jcmsplugin.socle.rechercher")%></span><i class="icon icon-magnifier icon--large" aria-hidden="true"></i>
                        </button>
                    </jalios:if>
                    <jalios:foreach array="<%= headerCatList %>" name="itCat" type="Category">
                        <a href="<%= itCat.getDisplayUrl(userLocale) %>" class="ds44-btnIcoText--maxi ds44--xl-padding" title='<%= glp("jcmsplugin.socle.header.ouvrir", itCat.getName()) %>' data-open-overlay="true"><span class="ds44-btnInnerText"><%= itCat.getName() %></span><i class="icon <%= itCat.getIcon() %> icon--large" aria-hidden="true"></i></a>                          
                    </jalios:foreach>
                    <button class="ds44-btn--menu ds44-btnIcoText--maxi ds44-btn--contextual ds44--xl-padding" type="button" aria-label="<%=glp("jcmsplugin.socle.menu.ouvrir")%>" aria-controls="menu">
                       <span class="ds44-btnInnerText"><%=glp("jcmsplugin.socle.menu")%></span><i class="icon icon-burger icon--xlarge" aria-hidden="true"></i>
                    </button>
                </div>
            </div>
        </div>
    </div>
    
    <div class="ds44-blocMenu">
        <section class="ds44-menuBox" id="menu">
            <div class="ds44-overlay ds44-theme ds44-bgCircle ds44-bg-br ds44-overlay--navNiv1" role="dialog" aria-label="<%=glp("jcmsplugin.socle.menu.principal1")%>" id="nav1">
                <button class="ds44-btnOverlay ds44-btnOverlay--closeOverlay" type="button" aria-label="<%=glp("jcmsplugin.socle.menu.fermer")%>"><i class="icon icon-cross icon--xlarge" aria-hidden="true"></i><span class="ds44-btnInnerText--bottom"><%=glp("jcmsplugin.socle.fermer")%></span></button>
                
                <p role="heading" aria-level="1" class="visually-hidden"><%=glp("jcmsplugin.socle.menu")%></p>
        
                <nav role="navigation" class="ds44-navContainer ds44-flex-container--column" aria-label="<%=glp("jcmsplugin.socle.menu.navigation")%>">
                    <div class="ds44-inner-container ds44-flex-mauto">
                        <ul class="ds44-navList ds44-multiCol ds44-xl-gap ds44-list">

                        <% Map<Category, String> listCatNavId = new HashMap<Category, String>(); %>

                        <jalios:foreach collection="<%= menuCatList %>" name="itCat" type="Category">
                            <%
                                String navId = "nav"+itCounter + 1;
                            %>
                            <li>
                                <jalios:select>
                                    <jalios:if predicate='<%= itCat.equals(channel.getCategory("$jcmsplugin.socle.site.pdcv.cat.id")) %>'>
                                        <%-- Bloc près de chez vous --%>
                                         <button type="button" class="ds44-menuBtn" data-ssmenu="navPdcv" aria-expanded="true" data-bkp-aria-hidden="" data-bkp-tabindex=""><%= glp("jcmsplugin.socle.menu.pdcv") %><i class="icon icon-right" aria-hidden="true"></i></button>
                                    </jalios:if>
                                    <%String libelleCat = Util.notEmpty(itCat.getExtraData("extra.Category.plugin.tools.synonyme.facet.title")) ? itCat.getExtraData("extra.Category.plugin.tools.synonyme.facet.title") : itCat.getName(userLang); %>
                                    
                                    <%-- Si présence de contenu principal dans la catégorie, alors lien vers ce contenu,
                                         sinon génération des enfants ou lien direct vers la catégorie si pas d'enfants. --%>
                                         
                                    <%Publication itContenuPrincipal = SocleUtils.getContenuPrincipal(itCat);%>
                                    <jalios:if predicate="<%= Util.isEmpty(itCat.getChildrenSet()) || Util.notEmpty(itContenuPrincipal) %>">
                                        <%
                                        String cible= "";
                                        String title = "";
                                        String lien = "";
                                        if(Util.notEmpty(itContenuPrincipal)){
                                        	lien = itContenuPrincipal.getDisplayUrl(userLocale);
                                        }
                                        else{
                                        	lien = itCat.getDisplayUrl(userLocale);
                                        }
                                        boolean targetBlank = "true".equals(itCat.getExtraData("extra.Category.plugin.tools.blank")) ? true : false;
                                        if(targetBlank){
                                            cible="target=\"_blank\" ";
                                            title = "title=\"" + libelleCat + " " + JcmsUtil.glp(userLang, "jcmsplugin.socle.accessibily.newTabLabel")+"\"";
                                        }
                                        %>
                                        <a class="ds44-menuBtn" href="<%= lien %>" <%=title%> <%=cible%>><%= libelleCat %><i class="icon icon-right" aria-hidden="true"></i></a>
                                    </jalios:if>
                                    <jalios:default>
                                        <button type="button" class="ds44-menuBtn" data-ssmenu='<%= navId %>'><%= libelleCat %><i class="icon icon-right" aria-hidden="true"></i></button>
                                        <% listCatNavId.put(itCat, navId); %>
                                    </jalios:default>
                                </jalios:select>
                                
                            </li>
                        </jalios:foreach>
                        </ul>
                        <hr class="ds44-navSep" />
                        <ul class="ds44-multiCol ds44-xl-gap ds44-list">
                           <jalios:foreach collection="<%= subMenuCatList %>" name="itCat" type="Category">
                               <ds:menuLink itCategory="<%= itCat %>" userLang="<%= userLang %>" userLocale="<%= userLocale %>"/>
                           </jalios:foreach>
                           </ul>
                    </div>
            
                    <div class="ds44-flex-container ds44-flex-align-center ds44-rsHeaderContainer">
<%--                         <jsp:include page="socialNetworksHeader.jspf"/>  --%>
                        <%@ include file='socialNetworksHeader.jspf' %>
                    </div>   
                    <%-- Navigation sites et applis --%>
                    <button type="button" class="ds44-fullWBtn ds44-btn--invert" id="ds44-btn-applis"><span class="ds44-btnInnerText"><%=glp("jcmsplugin.socle.sitesapplis")%></span><i class="icon icon-down" aria-hidden="true"></i></button>
                  </nav>
            </div>
        </section>
        
        <jalios:foreach name="itCatSsMenu" type="Category" collection="<%= listCatNavId.keySet() %>">
            <ds:levelTwoMenu rootCat="<%= itCatSsMenu %>" id='<%= listCatNavId.get(itCatSsMenu) %>' userLocale="<%= userLocale %>" userLang="<%= userLang %>"/>
        </jalios:foreach>
        
        <%-- Bloc près de chez vous --%>
        <jalios:if predicate='<%= Util.notEmpty(channel.getCategory("$jcmsplugin.socle.site.pdcv.cat.id")) %>'>
        <%@ include file='/plugins/SoclePlugin/jsp/portal/blocMenuPDCV.jspf' %>
        </jalios:if>
        
        <section class="ds44-overlay ds44-overlay--navFromBottom ds44-wave-grey ds44-bg-b" role="dialog" aria-label="<%=glp("jcmsplugin.socle.sitesapplis.menu")%>" id="navApplis">
        
        <div class="ds44-container-menuBackLink">
            <button type="button" title="Retour au menu de navigation" class="ds44-btn-backOverlay">
                 <i class="icon icon-arrow-left icon--xlarge" aria-hidden="true"></i><span class="ds44-btnInnerText--bottom"><%=glp("jcmsplugin.socle.retour")%></span>
            </button>
            <p role="heading" aria-level="1" class="ds44-menuBackLink"><%=glp("jcmsplugin.socle.sitesapplis")%></p>
        </div>
        
        <button class="ds44-btnOverlay ds44-btnOverlay--closeOverlay" type="button" aria-label="<%=glp("jcmsplugin.socle.sitesapplis.menu.fermer")%>"><i class="icon icon-cross icon--xlarge" aria-hidden="true"></i><span class="ds44-btnInnerText--bottom"><%= glp("jcmsplugin.socle.fermer") %></span></button>
        
        <%-- Inclusion liste des sites et applis --%>
        <%@include file="sitesEtApplis.jspf" %>

                            
        </section>        
        
    </div>
    
</header>

