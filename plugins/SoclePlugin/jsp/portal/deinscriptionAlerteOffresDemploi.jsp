<%@page import="fr.cg44.plugin.socle.EmploiUtils"%>
<%@page import="fr.cg44.plugin.socle.SocleUtils"%>
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
Map<String, String[]> parametersMap = URLUtils.parseUrlQueryString(des3Encrypter.decrypt(request.getParameter("confirm")));

// Récupère l'email et les segment pour mailjet
String mail = Util.getFirst(parametersMap.get("email"));

boolean isValide = false;
boolean isUnknown = false;



// Suppresion de l'inscription à l'alerte de l'offre d'emploi dans JCMS
ControllerStatus status ;
  
AlerteOffresDemploi abonnement = EmploiUtils.getAbonnementAlertEmploi(mail);
if(Util.notEmpty(abonnement) && abonnement.isInVisibleState()) {
  // Mise à jour
  abonnement.setPstatus(Workflow.EXPIRED_PSTATUS);
  status = abonnement.checkAndPerformUpdate(channel.getDefaultAdmin());
  
  isValide = status.isOK();
  
  // Annule le commit bdd si status en erreur
  if(!isValide) {
    HibernateUtil.evict(abonnement);
  }
  
} else {
  // Membre non trouvé
  isUnknown = true;
}

%>




<main role="main" id="content">
    <section class="ds44-container-large">
        <div class="ds44-wave-grey ds44-bg-pdr ds44--2xl-padding-t ds44--3xl-padding-b">
            <div class="ds44-inner-container">          
                <div class="grid-12-small-1">
                    <div class="col-12">
                        <h1 class="h2-like"><%= glp("jcmsplugin.socle.alert-emploi.titre") %></h1>

                        <jalios:select>
	                        <jalios:if predicate="<%= isValide %>">
		                        <h2 class="h3-like mts"><%= glp("jcmsplugin.socle.newletter.mail.desincription-valide") %></h2>                      
		                        <%= glp("jcmsplugin.socle.newletter.mail.desincription-valide.content", new String[]{mail}) %> 
	                        </jalios:if>
	                        <jalios:if predicate="<%= isUnknown %>">
                                <h2 class="h3-like mts"><%= glp("jcmsplugin.socle.newletter.mail.erreur") %></h2>                      
                                <p><%= glp("jcmsplugin.socle.newletter.mail.desincription-inconnu", new String[]{mail}) %></p>   
                            </jalios:if>
	                        <jalios:default>
	                            <h2 class="h3-like mts"><%= glp("jcmsplugin.socle.newletter.mail.erreur") %></h2>    
	                            <p><%= glp("jcmsplugin.socle.newletter.mail.erreur-desincription.description") %>
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
