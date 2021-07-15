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
String adressePhysique = SocleUtils.formatAdressePhysique(obj);
boolean pubNonRepertoriee = SocleUtils.isNonRepertoriee(obj);
%>
<section class="pbm">
	<p class="ds44-docListElem mtm">
	    <strong><i class="icon icon-user ds44-docListIco" aria-hidden="true"></i>
	       <jalios:select>
	           <jalios:if predicate='<%= pubNonRepertoriee %>'>
	               <%= obj.getTitle(userLang) %>
	           </jalios:if>
	               
	           <jalios:default>
	               <a class="ds44-titleLink" href="<%=obj.getDisplayUrl(userLocale)%>"><%=obj.getTitle(userLang)%></a>
	           </jalios:default>
	        </jalios:select>
	    </strong>
	</p>
	
	<jalios:if predicate='<%=Util.notEmpty(adressePhysique)%>'>
	    <p class="ds44-docListElem mtm"><i class="icon icon-marker ds44-docListIco" aria-hidden="true"></i><%=adressePhysique%></p>
	</jalios:if>
	
	<jalios:if predicate='<%=Util.notEmpty(obj.getTelephone())%>'>
	    <jalios:select>
		    <jalios:if predicate='<%= obj.getTelephone().length > 1 %>'>
		        <div class="ds44-docListElem mtm">
		    </jalios:if>
		    <jalios:default>
		      <p class="ds44-docListElem mtm">
		    </jalios:default>
	    </jalios:select>
	    
        <i class="icon icon-phone ds44-docListIco" aria-hidden="true"></i>
        
        <jalios:if predicate='<%= obj.getTelephone().length == 1 %>'>
            <% String numTel = obj.getTelephone()[0]; %>
            <ds:phone number="<%= numTel %>" pubTitle="<%= HttpUtil.encodeForHTMLAttribute(obj.getTitle(userLang)) %>"/>
        </jalios:if>

        <jalios:if predicate='<%= obj.getTelephone().length > 1 %>'>
            <ul class="ds44-list">
                <jalios:foreach name="numTel" type="String" array="<%= obj.getTelephone() %>">
                    <li>
                        <ds:phone number="<%= numTel %>" pubTitle="<%= HttpUtil.encodeForHTMLAttribute(obj.getTitle(userLang)) %>"/>
                    </li>
                </jalios:foreach>
            </ul>
        </jalios:if>
	    <jalios:select>
            <jalios:if predicate='<%= obj.getTelephone().length > 1 %>'>
                </div>
            </jalios:if>
            <jalios:default>
              </p>
            </jalios:default>
        </jalios:select>
	</jalios:if>
	
	<jalios:if predicate='<%=Util.notEmpty(obj.getEmail())%>'>
        <jalios:select>
           <jalios:if predicate='<%= obj.getEmail().length > 1 %>'>
               <div class="ds44-docListElem mtm">
           </jalios:if>
           <jalios:default>
             <p class="ds44-docListElem mtm">
           </jalios:default>
       </jalios:select>
	   
	   <i class="icon icon-mail ds44-docListIco" aria-hidden="true"></i>
	
       <jalios:if predicate='<%= obj.getEmail().length == 1 %>'>
           <% String email = obj.getEmail()[0]; %>
           <a href='<%= "mailto:"+email %>' title='<%= HttpUtil.encodeForHTMLAttribute(glp("jcmsplugin.socle.ficheaide.contacter-x-par-mail.label", obj.getTitle(userLang), email)) %>'
                 data-statistic='{"name": "declenche-evenement","category": "Contacts","action": "Mailto","label": "<%= HttpUtil.encodeForHTMLAttribute(obj.getTitle(userLang)) %>"}' > 
               <%=  glp("jcmsplugin.socle.ficheaide.contacter-par-mail.label")  %>
           </a>
       </jalios:if>

       <jalios:if predicate='<%= obj.getEmail().length > 1 %>'>
           <ul class="ds44-list">
               <jalios:foreach name="email" type="String" array='<%= obj.getEmail() %>'>
                   <li>
                       <a href='<%= "mailto:"+email %>' title='<%= HttpUtil.encodeForHTMLAttribute(glp("jcmsplugin.socle.ficheaide.contacter-x-par-mail.label", obj.getTitle(userLang), email)) %>'
                         data-statistic='{"name": "declenche-evenement","category": "Contacts","action": "Mailto","label": "<%= HttpUtil.encodeForHTMLAttribute(obj.getTitle(userLang)) %>"}'> 
                           <%= email %>
                       </a>
                   </li>
               </jalios:foreach>
           </ul>
       </jalios:if>
       
       <jalios:select>
           <jalios:if predicate='<%= obj.getEmail().length > 1 %>'>
               </div>
           </jalios:if>
           <jalios:default>
             </p>
           </jalios:default>
       </jalios:select>
       
	</jalios:if>
	
	<jalios:if predicate='<%=Util.notEmpty(obj.getSiteInternet())%>'>
		<jalios:select>
			<jalios:if predicate='<%=obj.getSiteInternet().length > 1%>'>
				<div class="ds44-docListElem mtm">
			</jalios:if>
			<jalios:default>
				<p class="ds44-docListElem mtm">
			</jalios:default>
		</jalios:select>
		
		<i class="icon icon-link ds44-docListIco" aria-hidden="true"></i>
	
        <jalios:if predicate='<%= obj.getSiteInternet().length == 1 %>'>
            <% String site = obj.getSiteInternet()[0]; %>
            <a href='<%= SocleUtils.parseUrl(site) %>' title='<%= glp("jcmsplugin.socle.lien.site.nouvelonglet", obj.getTitle(userLang)) %>' target="_blank"
   	            data-statistic='{"name": "declenche-evenement","category": "Contacts","action": "Site web","label": "<%= HttpUtil.encodeForHTMLAttribute(obj.getTitle(userLang)) %>"}'>
                <%= glp("jcmsplugin.socle.ficheaide.visiter-site.label") %>
            </a>
        </jalios:if>

        <jalios:if predicate='<%= obj.getSiteInternet().length > 1 %>'>
            <ul class="ds44-list">
                <jalios:foreach name="site" type="String" array='<%= obj.getSiteInternet() %>'>
                    <li>
                        <a href='<%= SocleUtils.parseUrl(site) %>' title='<%= glp("jcmsplugin.socle.lien.site.nouvelonglet", site) %>' target="_blank"
                           data-statistic='{"name": "declenche-evenement","category": "Contacts","action": "Site web","label": "<%= HttpUtil.encodeForHTMLAttribute(obj.getTitle(userLang)) %>"}'> 
                            <%= SocleUtils.parseUrl(site) %>
                        </a>
                    </li>
                </jalios:foreach>
            </ul>
        </jalios:if>
	
       <jalios:select>
           <jalios:if predicate='<%= obj.getSiteInternet().length > 1 %>'>
               </div>
           </jalios:if>
           <jalios:default>
             </p>
           </jalios:default>
       </jalios:select>
       
	</jalios:if>
</section>  

