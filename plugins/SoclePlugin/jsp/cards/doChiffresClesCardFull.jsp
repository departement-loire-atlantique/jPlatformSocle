<%@ page contentType="text/html; charset=UTF-8" %>
<%@page import="fr.cg44.plugin.socle.SocleUtils"%>
<%@ taglib prefix="ds" tagdir="/WEB-INF/tags"%>
<%@ include file='/jcore/doInitPage.jspf' %><%
%><%@ page import="com.jalios.jcms.taglib.card.*" %><%
%><%@ include file='/jcore/media/mediaTemplateInit.jspf' %><%
%><%

if (data == null) {
  return;
}

ChiffresCles pub = (ChiffresCles) data;

String uid = ServletUtil.generateUniqueDOMId(request, "uid");

// recuperation de l'url de l'icone pour le chiffre principal
String urlImage = Util.notEmpty(pub.getIconePrincipale()) ? pub.getIconePrincipale() : channel.getProperty("jcmsplugin.socle.chiffresCles.icone.url");

// recuperation de l'url du libelle et de l'attribut title du lien
String urlLien = "";
String libelleLien =  Util.notEmpty(pub.getLibelleLien()) ? pub.getLibelleLien() : glp("jcmsplugin.socle.chiffrescles.lien");
String titleLien = "";
if(Util.notEmpty(pub.getLienExterne())) {
	urlLien = pub.getLienExterne();
	titleLien = HttpUtil.encodeForHTMLAttribute(glp("jcmsplugin.socle.lien.nouvelonglet", libelleLien));
} else if(Util.notEmpty(pub.getLienInterne())) {
	urlLien = pub.getLienInterne().getDisplayUrl(userLocale);
	titleLien = HttpUtil.encodeForHTMLAttribute(libelleLien);
}

String chiffrePrincipal = pub.getChiffrePrincipal().replaceAll("[^0-9\\,]", "");
String DataStopChfrPrinc = chiffrePrincipal.replaceAll("\\,", ".");
String decorationChfrPrinc = pub.getChiffrePrincipal().replaceAll("[0-9\\,]", "");

%>

<jalios:if predicate="<%= Util.isEmpty((pub.getChiffreSecondaire())) && Util.isEmpty((pub.getLibelleChiffreSecondaire())) %>">
	<section class='ds44-box ds44-theme'>
	    <div class="ds44-innerBoxContainer ds44-flex-container ds44-flex-valign-center">
	        <img class="ds44-boxPic" src="<%= urlImage %>" alt="" />
	        <jalios:if predicate="<%= Util.notEmpty(urlLien) %>">
		        <div class="ds44-boxContent">
		    </jalios:if>
		            <div>
		                <strong>
		                	<span class="ds44-txtExergue">
		                		<span class="ds44-js-dynamic-number" data-stop="<%= DataStopChfrPrinc %>"><%= chiffrePrincipal %></span>
		                		<%= decorationChfrPrinc %>
		                	</span>
		                </strong>
	                	<jalios:wysiwyg css="ds44-block"><strong><%= pub.getLibelleChiffrePrincipal() %></strong></jalios:wysiwyg>
		                <jalios:if predicate="<%= Util.notEmpty(urlLien) %>">
			                <a href="<%= urlLien %>" class="ds44-btnLink mts" title="<%= titleLien %>" <%= Util.notEmpty(pub.getLienExterne()) ? "target=\"_blank\"" : "" %>>
			                	<span class="ds44-btnInnerText"><%= libelleLien %></span>
			                	<i class="icon icon-long-arrow-right" aria-hidden="true"></i>
			                </a>
						</jalios:if>
		            </div>
		    <jalios:if predicate="<%= Util.notEmpty(urlLien) %>">
		        </div>
	        </jalios:if>
	    </div>
	</section>
</jalios:if>

<jalios:if predicate="<%= Util.notEmpty((pub.getChiffreSecondaire())) || Util.notEmpty((pub.getLibelleChiffreSecondaire())) %>">
	<section class='ds44-innerBoxContainer ds44-borderContainer'>
	    <h2 id="idTitre-ChiffresCles<%= uid %>" class="h2-like"><%= glp("jcmsplugin.socle.chiffrescles.titre") %></h2>
	    <ul class="grid-2-tiny-1 has-gutter-l ds44-list ds44-mobile-extra-smt">
	        <li class="col-2 ds44-tiny-extra-mb">
	            <div class="ds44-flex-container ds44-flex-valign-center ds44-small-flex-col">
	                <img class="ds44-boxPic" src="<%= urlImage %>" alt="" />
	                <div class="ds44-flex-container ds44-flex-valign-center ds44-small-flex-col ds44-flex-wrap">
	                    <span class="h1-like h1-like--bigger ds44-numberIncrement ds44-js-dynamic-number" data-stop="<%= DataStopChfrPrinc %>"><%= chiffrePrincipal %></span> 
	                    <jalios:if predicate="<% Util.notEmpty(decorationChfrPrinc) %>">
		                    <span class="h1-like h1-like--bigger"><%= decorationChfrPrinc %></span>
	                    </jalios:if>
	                    <jalios:wysiwyg css="ds44-txtExergue ds44-ml1"><%= pub.getLibelleChiffrePrincipal() %></jalios:wysiwyg>
	                </div>
	            </div>
	        </li>
	        <% 
	        	String[] chfrSeconArr = pub.getChiffreSecondaire();
	        	String[] libelleChfrSeconArr = pub.getLibelleChiffreSecondaire();
	        	String[] foreachArr = chfrSeconArr.length > libelleChfrSeconArr.length ? chfrSeconArr : libelleChfrSeconArr;
	        %>
	        <jalios:foreach name="itStr" type="String" array="<%= foreachArr %>">
	        	<%
	        		int itCounterArr = itCounter - 1;
	        		String chfrSecon = chfrSeconArr.length > itCounterArr ? chfrSeconArr[itCounterArr] : "";
	        		String libelleChfrSecon = libelleChfrSeconArr.length > itCounterArr ? libelleChfrSeconArr[itCounterArr] : "";
	        	%>
		        <li class="ds44-tiny-extra-mb">
		            <div>
		            	<jalios:if predicate="<%= Util.notEmpty(chfrSecon) %>">
			            	<%
				            	String chiffreSecondaire = chfrSecon.replaceAll("[^0-9\\,]", "");
				            	String DataStopChfrSecon = chiffreSecondaire.replaceAll("\\,", ".");
				            	String decorationChfrSecon = chfrSecon.replaceAll("[0-9\\,]", "");
			            	%>
			                <span class="h1-like ds44-numberIncrement ds44-js-dynamic-number" data-stop="<%= DataStopChfrSecon %>"><%= chiffreSecondaire %></span>
			                <jalios:if predicate="<% Util.notEmpty(decorationChfrSecon) %>">
				                <span class="h1-like"><%= decorationChfrSecon %></span>
							</jalios:if>
		                </jalios:if>
		                <jalios:if predicate="<%= Util.notEmpty(libelleChfrSecon) %>">
		                	<jalios:wysiwyg css="ds44-block"><%= libelleChfrSecon %></jalios:wysiwyg>
		                </jalios:if>
		            </div>
		        </li>
	        </jalios:foreach>
	    </ul>
	    <jalios:if predicate="<%= Util.notEmpty(urlLien) %>">
		    <a href="<%= urlLien %>" class="ds44-btnStd ds44-w100 ds44-mt-std ds44-bntALeft ds44-mt2 ds44-mobile-extra-smt" 
		    		title="<%= titleLien %>" <%= Util.notEmpty(pub.getLienExterne()) ? "target=\"_blank\"" : "" %>>
		    	<span class="ds44-btnInnerText"><%= libelleLien %></span>
		    	<i class="icon icon-long-arrow-right" aria-hidden="true"></i>
		    </a>
	    </jalios:if>
	</section>
</jalios:if>