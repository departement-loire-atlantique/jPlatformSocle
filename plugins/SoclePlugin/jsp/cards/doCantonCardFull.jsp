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

Canton pub = (Canton) data;

Set<Publication> referencedElus = new TreeSet<>(ElectedMember.getComparator("nom", true));
referencedElus.addAll(pub.getLinkIndexedDataSet(ElectedMember.class));

%>

<section class="ds44-box ds44-bgGray">
    <div class="ds44--l-padding ds44-box--temoignage">
         <p role="heading" aria-level="2" class="h3-like"><%= pub.getTitle() %></p>
         <div class="grid-2">
         
            <jalios:if predicate="<%= Util.notEmpty(referencedElus) %>">
	            <jalios:foreach name="itElu" type="ElectedMember" collection="<%= referencedElus %>" counter="itCounter" max="2">
	               <%
	               String fullName = "";

	               if (Util.notEmpty(itElu.getFirstName())) fullName = itElu.getFirstName();
	               if (Util.notEmpty(itElu.getNom())) {
	                 if (Util.notEmpty(itElu.getFirstName())) fullName += " ";
	                 fullName += itElu.getNom();
	               }
	               
	               String conseillerLabel = "";
	               if (Util.notEmpty(itElu.getFunctions(loggedMember))) {
	                 if (itElu.getFunctions(loggedMember).contains(channel.getCategory("$jcmsplugin.socle.elu.conseiller"))) {
	                   conseillerLabel = itElu.getGender() ? glp("jcmsplugin.socle.elu.conseiller.masculin") : glp("jcmsplugin.socle.elu.conseiller.feminin");
	                 }
	               }
	               %>
	               <div class="col-1-small-1 ds44-mobile-reduced-mb ds44-js-card">
	                 <section class="txtcenter">
	                 
	                    <jalios:if predicate='<%= Util.notEmpty(itElu.getPicture()) %>'>
	                        <picture class="ds44-container-imgRatio ds44-container-imgRatio--profil ds44-centeredBlock">
	                            <img src="<%= itElu.getPicture() %>" alt="" class="ds44-w100 ds44-imgRatio--profil">
	                        </picture>
	                    </jalios:if>
	                    
	                     <div class="ds44-card__section">
	                       <p role="heading" aria-level="3" class="ds44-card__title"><a href="<%= itElu.getDisplayUrl(userLocale) %>" class="ds44-card__globalLink" title="<%= glp("jcmsplugin.socle.elu.ficheDetaillee", fullName) %>"><%= fullName %></a></p>
	                       <p><%= itElu.getPoliticalParty(loggedMember).first() %></p>
	                     </div>
	                 </section>
	               </div>
	               
	            </jalios:foreach>
	            
            </jalios:if>
	            
        </div>
        <a href="<%= pub.getDisplayUrl(userLocale) %>" class="ds44-btnStd ds44-fullWBtn ds44-mt-std" title="<%= glp("jcmsplugin.socle.canton.lien.title", pub.getTitle()) %>"><span class="ds44-btnInnerText"><%= glp("jcmsplugin.socle.canton.voirfiche") %></span><i class="icon icon-long-arrow-right" aria-hidden="true"></i></a>
    </div>
</section>