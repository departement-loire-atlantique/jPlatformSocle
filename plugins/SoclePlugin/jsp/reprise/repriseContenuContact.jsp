<%@page import="com.jalios.jcms.handler.MemberQueryHandler"%>
<%@page import="java.util.regex.Matcher"%>
<%@page import="java.util.regex.Pattern"%>
<%@page import="fr.cg44.plugin.socle.SocleUtils"%>
<%@page import="com.jalios.jcms.handler.QueryHandler"%>
<%@page import="java.io.IOException" %>
<%
%><%@ include file="/jcore/doInitPage.jsp" %><%

if(!isAdmin) {
	sendForbidden(request, response);
	return;
}

%>
<%@ include file='/admin/doAdminHeader.jspf' %>

<div class="page-header"><h1>Générer les contenus Contact</h1></div>

<form>
    <input type="hidden" name="executeReprise" value="true">
    <input class="btn btn-danger modal confirm" type="submit" value="Lancer la génération"/>
</form>


<h3>Mettre à jour les Contacts depuis les Communes</h3>

<form>
    <input type="hidden" name="updateContacts" value="true">
    <input class="btn btn-danger modal confirm" type="submit" value="Lancer la mise à jour"/>
</form>

<% 

if(getBooleanParameter("executeReprise", false)) {
  
    logger.debug("Generating Contacts START");
    
    MemberQueryHandler qh = new MemberQueryHandler();
    qh.setGid(channel.getProperty("jcmsplugin.socle.group.animationSportive.id"));
    
    logger.debug("Found results : " + qh.getResultSet().size());
    
    for(Member itMember : qh.getResultSet()) {
        
              Contact itContact = SocleUtils.getContactFromMembre(itMember);
              
              logger.debug("Checking member : " + itMember);
              
              if (Util.isEmpty(itContact)) {
                logger.debug("Creating Contact.");
                itContact = new Contact();
                itContact.setTitle(itMember.getFullName());
                itContact.setNom(itMember.getName());
                itContact.setPrenom(itMember.getFirstName());
                itContact.setAdresseMail(itMember.getEmail());
                itContact.setCivilite(itMember.getSalutation());
                itContact.setTelephone(new String[]{itMember.getPhone().replaceAll(" ", "")});
                itContact.setAuthor(loggedMember);
                itContact.addCategory(channel.getCategory("$jcmsplugin.socle.cat.animationSportive.id"));
                System.out.println(itContact.checkAndPerformCreate(channel.getDefaultAdmin()));
              } else {
                logger.debug("Already created.");
              }
        
    }
    
    logger.debug("Generating Contacts END");
    
}

if (getBooleanParameter("updateContacts", false)) {
  
  logger.debug("Updating Contacts START");
  
  Set<City> allCities = channel.getAllDataSet(City.class);
  
  for (City itCity : allCities) {
    
    logger.debug("Checking City " + itCity);
    
    if (Util.isEmpty(itCity.getAnimateursSportifsInterlocuteurs())) {
      logger.debug("No animator found. Continue...");
      continue;
    }
    
    Contact itContact = SocleUtils.getContactFromMembre(itCity.getAnimateursSportifsInterlocuteurs());
    
    if (Util.notEmpty(itContact)) {
      logger.debug("Found Contact. Updating...");
      Contact contactClone = (Contact) itContact.getUpdateInstance();
      
      // Ajouter la commune
      
      List<City> contactCommunes = new ArrayList<>();
      if (Util.notEmpty(itContact.getCommunes())) {
        contactCommunes.addAll(Arrays.asList(itContact.getCommunes()));
      }
      if (contactCommunes.contains(itCity)) {
        logger.debug("City already exists for this member. Continue...");
        continue;
      }
      
      contactCommunes.add(itCity);
      contactClone.setCommunes(contactCommunes.toArray(new City[contactCommunes.size()]));
      
      contactClone.checkAndPerformUpdate(loggedMember);
      logger.debug("Update done.");
    } else {
      logger.debug("No contact found.");
    }
    
  }
  
  logger.debug("Updating Contacts END");
  
}

%>

<%@ include file='/admin/doAdminFooter.jspf' %> 