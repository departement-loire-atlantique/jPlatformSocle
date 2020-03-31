<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file='/jcore/doInitPage.jspf' %>
<%@ include file='/jcore/media/mediaTemplateInit.jspf' %>
<%@ taglib prefix="ds" tagdir="/WEB-INF/tags"%>
<%@ page import="fr.cg44.plugin.socle.SocleUtils"%>
<%

if (data == null || ( !(data instanceof FicheLieu) )) {
  return;
}
FicheLieu obj = (FicheLieu) data;

String longitude = obj.getExtraData("extra.FicheLieu.plugin.tools.geolocation.longitude");
String latitude = obj.getExtraData("extra.FicheLieu.plugin.tools.geolocation.latitude");
String localisation = SocleUtils.formatOpenStreetMapLink(latitude, longitude);

String commune = Util.notEmpty(obj.getCommune()) ? obj.getCommune().getTitle() : "";
String adresse = SocleUtils.formatAddress("", obj.getEtageCouloirEscalier(),
        obj.getEntreeBatimentImmeuble(), obj.getNdeVoie(), obj.getLibelleDeVoie(), obj.getLieudit(), "",
        obj.getCodePostal(), commune, "");

String communeEcrire = Util.notEmpty(obj.getCommune2()) ? obj.getCommune2().getTitle() : "";
String adresseEcrire = SocleUtils.formatAdresseEcrire(obj);
%>
<section class="mbm">
	<p class="ds44-docListElem mtm" role="heading" aria-level="3">
	    <strong><i class="icon icon-user ds44-docListIco" aria-hidden="true"></i>
	        <a href="<%=obj.getDisplayUrl(userLocale)%>"><%=obj.getTitle()%></a>
	    </strong>
	</p>
	
	<jalios:if predicate='<%=Util.notEmpty(adresse)%>'>
	    <p class="ds44-docListElem mtm"><i class="icon icon-marker ds44-docListIco" aria-hidden="true"></i><%=adresse%></p>
	</jalios:if>
	
	<jalios:if predicate='<%=Util.notEmpty(obj.getTelephone())%>'>
	    <div class="ds44-docListElem mtm">
	        <i class="icon icon-phone ds44-docListIco" aria-hidden="true"></i>
	        <jalios:if predicate='<%= obj.getTelephone().length == 1 %>'>
	            <% String numTel = obj.getTelephone()[0]; %>
	            <ds:phone number="<%= numTel %>"/>
	        </jalios:if>
	
	        <jalios:if predicate='<%= obj.getTelephone().length > 1 %>'>
	            <ul class="ds44-list">
	                <jalios:foreach name="numTel" type="String" array="<%= obj.getTelephone() %>">
	                    <li>
	                        <ds:phone number="<%= numTel %>"/>
	                    </li>
	                </jalios:foreach>
	            </ul>
	        </jalios:if>
	
	    </div>
	</jalios:if>
	
	<jalios:if predicate='<%=Util.notEmpty(obj.getEmail())%>'>
	     <div class="ds44-docListElem mtm"><i class="icon icon-mail ds44-docListIco" aria-hidden="true"></i>
	         <% 
	             StringBuffer sbfAriaLabelMail = new StringBuffer();
	             sbfAriaLabelMail.append(glp("jcmsplugin.socle.ficheaide.contacter.label"))
	                 .append(" ")
	                 .append(obj.getTitle())
	                 .append(" ")
	                 .append(glp("jcmsplugin.socle.ficheaide.par-mail.label"))
	                 .append(" : ");
	             String strAriaLabelMail = HttpUtil.encodeForHTMLAttribute(sbfAriaLabelMail.toString());
	         %>
	
	         <jalios:if predicate='<%= obj.getEmail().length == 1 %>'>
	             <% String email = obj.getEmail()[0]; %>
	             <a href='<%= "mailto:"+email %>' aria-label='<%= strAriaLabelMail + email %>'> 
	                 <%
	                     StringBuffer sbfLabelMail = new StringBuffer();
	                     sbfLabelMail.append(glp("jcmsplugin.socle.ficheaide.contacter.label"))
	                         .append(" ")
	                         .append(glp("jcmsplugin.socle.ficheaide.par-mail.label"));
	                 %>
	                 <%=  sbfLabelMail.toString()  %>
	             </a>
	         </jalios:if>
	
	         <jalios:if predicate='<%= obj.getEmail().length > 1 %>'>
	             <ul class="ds44-list">
	                 <jalios:foreach name="email" type="String" array='<%= obj.getEmail() %>'>
	                     <li>
	                         <a href='<%= "mailto:"+email %>' aria-label='<%= strAriaLabelMail + email %>'> 
	                             <%= email %>
	                         </a>
	                     </li>
	                 </jalios:foreach>
	             </ul>
	         </jalios:if>
	
	    </div>
	</jalios:if>
	
	<jalios:if predicate='<%=Util.notEmpty(obj.getSiteInternet())%>'>
	    <div class="ds44-docListElem mtm"><i class="icon icon-link ds44-docListIco" aria-hidden="true"></i>
	        <% 
	            StringBuffer sbfAriaLabelSite = new StringBuffer();
	            sbfAriaLabelSite.append(glp("jcmsplugin.socle.ficheaide.visiter-site-web-de.label"))
	                .append(" ")
	                .append(obj.getTitle())
	                .append(" ")
	                .append(glp("jcmsplugin.socle.accessibily.newTabLabel"));
	            String strAriaLabelSite = HttpUtil.encodeForHTMLAttribute(sbfAriaLabelSite.toString());
	        %>
	
	        <jalios:if predicate='<%= obj.getSiteInternet().length == 1 %>'>
	            <% String site = obj.getSiteInternet()[0]; %>
	            <a href='<%= SocleUtils.parseUrl(site) %>' aria-label='<%= strAriaLabelSite %>' target="_blank">
	                <%= glp("jcmsplugin.socle.ficheaide.visiter-site.label") %>
	            </a>
	        </jalios:if>
	
	        <jalios:if predicate='<%= obj.getSiteInternet().length > 1 %>'>
	            <ul class="ds44-list">
	                <jalios:foreach name="site" type="String" array='<%= obj.getSiteInternet() %>'>
	                    <li>
	                        <a href='<%= SocleUtils.parseUrl(site) %>' aria-label='<%= strAriaLabelSite %>' target="_blank"> 
	                            <%= SocleUtils.parseUrl(site) %>
	                        </a>
	                    </li>
	                </jalios:foreach>
	            </ul>
	        </jalios:if>
	
	    </div>
	</jalios:if>
</section>  

