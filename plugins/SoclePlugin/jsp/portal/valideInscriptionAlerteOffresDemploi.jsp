<%@page import="com.jalios.jcms.mail.MailThreadQueryFilter"%>
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
String mail = Util.getFirst(parametersMap.get("mail"));
String commune = Util.getFirst(parametersMap.get("commune"));
String communeHorsDept = Util.getFirst(parametersMap.get("communeHorsDept"));

String touteDelegation = Util.getFirst(parametersMap.get("touteDelegation"));
String[] delegation = parametersMap.get("delegation");
String[] type = parametersMap.get("type");
String[] domaine = parametersMap.get("domaine");
String[] categorie = parametersMap.get("categorie");
String[] filiere = parametersMap.get("filiere");



// récupère la date d'expiration 
Calendar calendar = Calendar.getInstance();
calendar.setTimeInMillis(Long.parseLong(Util.getFirst(parametersMap.get("expire"))));
// Date courrante
Date currentDate = Calendar.getInstance().getTime();

boolean isExpire = currentDate.after(calendar.getTime());

boolean isValide = false;


// Création ou maj de l'inscription à l'alerte de l'offre d'emploi dans JCMS
if(!isExpire) {
  ControllerStatus status ;
  
  // Ajout des catégories dans une même liste
  Set<String> catSet = new HashSet<String>();
  if(Util.notEmpty(delegation))
    catSet.addAll(Arrays.asList(delegation));
  if(Util.notEmpty(type))
    catSet.addAll(Arrays.asList(type));
  if(Util.notEmpty(domaine))
    catSet.addAll(Arrays.asList(domaine));
  if(Util.notEmpty(categorie))
    catSet.addAll(Arrays.asList(categorie));
  if(Util.notEmpty(filiere))
    catSet.addAll(Arrays.asList(filiere));

  AlerteOffresDemploi abonnement = EmploiUtils.getAbonnementAlertEmploi(mail);
  if(Util.notEmpty(abonnement)) {
    // Mise à jour
    abonnement.setCommune(SocleUtils.getCommuneFromCode(commune));
    abonnement.setCommuneHorsLoireAtlantique(communeHorsDept);
    if("toute".equalsIgnoreCase(touteDelegation)) {
      abonnement.setTouteLaLoireAtlantique(true);
    }else {
      abonnement.setTouteLaLoireAtlantique(false);
    }
    abonnement.setCatIdSet(catSet);
    abonnement.setPstatus(Workflow.PUBLISHED_PSTATUS);
    status = abonnement.checkAndPerformUpdate(channel.getDefaultAdmin());
    
    // Annule le commit bdd si status en erreur
    if(!status.isOK()) {
      HibernateUtil.evict(abonnement);
    }
    
  } else {
    // Création
    abonnement = new AlerteOffresDemploi();
    abonnement.setAuthor(channel.getDefaultAdmin());
    abonnement.setTitle(mail.toLowerCase());
    abonnement.setMail(mail.toLowerCase());
    abonnement.setCommune(SocleUtils.getCommuneFromCode(commune));
    abonnement.setCommuneHorsLoireAtlantique(communeHorsDept);
    if("toute".equalsIgnoreCase(touteDelegation)) {
      abonnement.setTouteLaLoireAtlantique(true);
    }else {
      abonnement.setTouteLaLoireAtlantique(false);
    }
    abonnement.setCatIdSet(catSet);
    status = abonnement.checkAndPerformCreate(channel.getDefaultAdmin());
    
  }
  isValide = status.isOK();
}

%>


<%@ include file='/plugins/SoclePlugin/jsp/forms/initMailThemeAlertEmploi.jspf' %>


<main role="main" id="content">
    <section class="ds44-container-large">
        <div class="ds44-wave-grey ds44-bg-pdr ds44--2xl-padding-t ds44--3xl-padding-b">
            <div class="ds44-inner-container">          
                <div class="grid-12-small-1">
                    <div class="col-12">
                        <h1 class="h2-like"><%= glp("jcmsplugin.socle.alert-emploi.titre") %></h1>                       
                        <jalios:select>
	                        <jalios:if predicate="<%= isValide %>">
		                        <h2 class="h3-like mts"><%= glp("jcmsplugin.socle.newletter.mail.inscription-valide") %></h2>                      		                        
		                        <%= mailTheme %>	                        
	                        </jalios:if>
	                        <jalios:if predicate="<%= isExpire %>">
                                <h2 class="h3-like mts"><%= glp("jcmsplugin.socle.newletter.mail.inscription-expire") %></h2>                      
                                <p><%= glp("jcmsplugin.socle.alert-emploi.mail.inscription-expire.content") %></p>   
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
