<%@page import="com.jalios.jcms.context.JcmsMessage"%><%
%><%@page import="fr.cg44.plugin.socle.MailUtils"%><%
%><%@ include file='/jcore/doInitPage.jspf' %>

<%
StringEncrypter des3Encrypter = new StringEncrypter(StringEncrypter.DESEDE_ENCRYPTION_SCHEME, channel.getProperty("jcmsplugin.socle.newsletter.encrypt.key"));

// Decode le paramètre "confirm" avec les informations de l'inscription
Map<String, String[]> params = URLUtils.parseUrlQueryString(des3Encrypter.decrypt(request.getParameter("confirm")));

// Récupération des champs nécessaires à la création du membre
String nom = Util.getFirst(params.get("nom"));
String prenom = Util.getFirst(params.get("prenom"));
String mail = Util.getFirst(params.get("mail"));
String telephone = Util.getFirst(params.get("telephone"));
String medium = Util.getFirst(params.get("media"));
String password = Util.getFirst(params.get("password1"));

// Vérification de la date d'expiration du lien 
Calendar calendar = Calendar.getInstance();
calendar.setTimeInMillis(Long.parseLong(Util.getFirst(params.get("expire"))));
Date currentDate = Calendar.getInstance().getTime();

boolean isExpire = currentDate.after(calendar.getTime());

if(!isExpire){
    // Création du membre
    Member opAuthor = channel.getDefaultAdmin();
    
    Member member = new Member();
    member.setLogin(mail);
    member.setName(nom);
    member.setFirstName(prenom);
    member.setEmail(mail);
    member.setPhone(telephone);
    member.setPassword(channel.crypt(password));
    
    if(Util.notEmpty(medium)) {
      member.setJobTitle(medium);
    }
    
    // Ajout au groupe Presse
    Group groupePresse = channel.getGroup("$jcmsplugin.socle.form.inscription-presse.groupe-presse");
    if(Util.notEmpty(groupePresse)){
      member.addGroup(groupePresse);
    }
    
    // Check and perform the update
    ControllerStatus status = member.checkAndPerformCreate(opAuthor);
    if (!status.isOK()) {
      String msg = status.getMessage(opAuthor.getLanguage());
      logger.error("Impossible de créer le membre suivant dans l'espace presse : " + mail + " / " + msg);
      jcmsContext.setErrorMsgSession(msg);
    }
    else{
      // Envoi du mail de confirmation à l'utilisateur
      if(! MailUtils.envoiMailConfirmationCreationCompte(mail)){
        // Erreur d'envoi de mail.
        jcmsContext.setErrorMsgSession(glp("jcmsplugin.socle.form.inscription-presse.inscription-echec"));
        logger.error("Impossible d'envoyer le mail de confirmation suite à la création du membre suivant dans l'espace presse : " + mail);
      }
      else{
        jcmsContext.setInfoMsgSession(glp("jcmsplugin.socle.form.inscription-presse.inscription-succes"));
      }
      
      // Envoi du mail de confirmation à l'espace presse
      MailUtils.envoiMailNotificationCreationComptePresse(nom, prenom, mail, telephone, medium);
    }
    
}
else{
  // ERREUR Lien expiré
  jcmsContext.setErrorMsgSession(glp("jcmsplugin.socle.form.inscription-presse.inscription-expire"));
}


// Redirection vers espace presse

Publication redirectPub = channel.getPublication("$jcmsplugin.socle.login.pub");
String redirectUrl = redirectPub.getDisplayUrl(userLocale);
      
String url = URLUtils.buildUrl(redirectUrl, request.getParameterMap());
      
sendRedirect(url);

%>
