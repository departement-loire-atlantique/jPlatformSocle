<%@page import="fr.cg44.plugin.socle.mailjet.MailjetManager"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<% request.setAttribute("inFO", true); %>
<%@ include file='/jcore/doInitPage.jspf' %>

<% request.setAttribute("title", glp("jcmsplugin.socle.newletter.title.lbl"));%>

<%@ include file='/jcore/doEmptyHeader.jspf' %>



<%-- JSP Header --%>
<jalios:include jsp="plugins/SoclePlugin/jsp/portal/headerSection.jsp"/>

<%

StringEncrypter des3Encrypter = new StringEncrypter(StringEncrypter.DESEDE_ENCRYPTION_SCHEME, channel.getProperty("jcmsplugin.socle.newsletter.encrypt.key"));

// Decode le paramètre "confirm" avec les informations de l'inscription à la newsletter
Map<String, String[]> params = URLUtils.parseUrlQueryString(des3Encrypter.decrypt(request.getParameter("confirm")));

// Récupère l'email et les segment pour mailjet
String email = Util.getFirst(params.get("newletters-mail"));
String[] segment = params.get("segmentid");
String nomList = Util.getFirst(params.get("nom-list"));
String idListString = Util.getFirst(params.get("id-list"));


// récupère la date d'expiration 
Calendar calendar = Calendar.getInstance();
calendar.setTimeInMillis(Long.parseLong(Util.getFirst(params.get("expire"))));
// Date courrante
Date currentDate = Calendar.getInstance().getTime();

boolean isExpire = currentDate.after(calendar.getTime());

boolean isValide = false;
// Newsletter avec propriétés
if(Util.notEmpty(segment) && !isExpire && MailjetManager.addContactList(email)) {
  if(MailjetManager.addContactProperties(email, segment)) {
    isValide = true;
  }
} else if(Util.notEmpty(idListString)) {
  //Newsletter sans propriété avec un id de liste de contact spécifique
  Integer idList = Integer.parseInt(idListString);
  if(idList != null && !isExpire && MailjetManager.addContactList(email, idList)) {
    isValide = true;
  }
}

%>

<jalios:buffer name="theme">
	<ul>
	
	    <jalios:if predicate='<%= Util.notEmpty(nomList) %>'>
            <li><%= nomList %></li>
        </jalios:if>
	
	     <jalios:if predicate='<%= Util.notEmpty(segment) %>'>
		    <jalios:foreach array="<%= segment %>" name="itCatId" type="String">
		        <%
		        Category itCat = channel.getCategory(itCatId);
		        %>
		        <jalios:if predicate="<%= Util.notEmpty(itCat) %>">
		            <li><%= itCat.getName(userLang) %></li>
		        </jalios:if>
		    </jalios:foreach>
		 </jalios:if>
	</ul>
</jalios:buffer>



<main role="main" id="content">
    <section class="ds44-container-large">
        <div class="ds44-wave-grey ds44-bg-pdr ds44--2xl-padding-t ds44--3xl-padding-b">
            <div class="ds44-inner-container">          
                <div class="grid-12-small-1">
                    <div class="col-12">
                        <h1 class="h2-like"><%= glp("jcmsplugin.socle.newletter.lbl") %></h1>
                        
                        <jalios:select>
	                        <jalios:if predicate="<%= isValide %>">
		                        <h2 class="h3-like mts"><%= glp("jcmsplugin.socle.newletter.mail.inscription-valide") %></h2>                      
		                        <%= glp("jcmsplugin.socle.newletter.mail.inscription-valide.content", new String[]{theme}) %> 
	                        </jalios:if>
	                        <jalios:if predicate="<%= isExpire %>">
                                <h2 class="h3-like mts"><%= glp("jcmsplugin.socle.newletter.mail.inscription-expire") %></h2>                      
                                <p><%= glp("jcmsplugin.socle.newletter.mail.inscription-expire.content", new String[]{theme}) %></p>   
                            </jalios:if>
	                        <jalios:default>
	                            <h2 class="h3-like mts"><%= glp("jcmsplugin.socle.newletter.mail.erreur") %></h2>    
	                            <p><%= glp("jcmsplugin.socle.newletter.mail.erreur.description") %>
	                        </jalios:default>                       
                        </jalios:select>
                                                                   
                    </div>
                </div>                       
            </div>
      </div>
    </section>            
</main>

<footer role="contentinfo">
    <%-- JSP Footer --%>
    <jalios:include id='<%= channel.getProperty("plugin.seo.error.footer.id") %>'/>
    
    <%-- JSP Navigation --%>
    <jalios:include id='<%= channel.getProperty("plugin.seo.error.navigationfooter.id") %>'/>
    
    <p id="backToTop" class="ds44-posRi ds44-hide-mobile ds44-btn-fixed ds44-js-button-sticky" data-is-delayed="true">
        <a class="ds44-icoLink ds44-icoLink--footer" href="#top"><i class="icon icon-arrow-up icon--sizeXL" aria-hidden="true"></i><span class="ds44-icoTxtWrapper"><%= glp("jcmsplugin.socle.hautDepage")%></span></a>
    </p>
</footer>
    
<%@ include file="/jcore/doEmptyFooter.jspf" %>    
