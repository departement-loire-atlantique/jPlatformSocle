package fr.cg44.plugin.socle;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;

import com.jalios.jcms.Channel;
import com.jalios.jcms.FileDocument;
import com.jalios.jcms.JcmsUtil;
import com.jalios.jcms.context.JcmsContext;
import com.jalios.jcms.mail.MailMessage;
import com.jalios.util.Util;

import generated.CandidatureSpontaneeForm;
import generated.ContactForm;

public final class MailUtils {
	private static Channel channel = Channel.getChannel();
	
	private static final Logger LOGGER = Logger.getLogger(MailUtils.class);
	
	private MailUtils() {
		throw new IllegalStateException("Utility class");
	}
	
 /**
  * Envoi d'un email de contact.
  */
 public static void envoiMailContact(ContactForm form, String emailTo) {
 		String jsp = "/plugins/SoclePlugin/jsp/mail/formulaireContactTemplate.jsp";
 	
   // Objet
   String objet = channel.getProperty("jcmsplugin.socle.email.sujet.prefix") + " - " + form.getSujet(channel.getDefaultAdmin()).first();

   // Contenu
   HashMap<Object, Object> parametersMap = new HashMap<Object, Object>();
   parametersMap.put("nom", form.getNom());
   parametersMap.put("prenom", form.getPrenom());
   parametersMap.put("email", form.getMail());
   parametersMap.put("telephone", Util.notEmpty(form.getTelephone()) ? form.getTelephone() : "");
   parametersMap.put("codepostal", form.getCodePostal());
   parametersMap.put("commune", SocleUtils.getCitynameFromZipcode(form.getCodePostal()));
   parametersMap.put("sujet", form.getSujet(channel.getDefaultAdmin()).first());
   parametersMap.put("message", form.getMessage());
   
   try {
     sendMail(objet, null, form.getMail(), emailTo, null, jsp, parametersMap);
     msgEnvoiMailContact();
   } catch (Exception e) {
     msgEchecEnvoiMailContact();
     LOGGER.error("Erreur lors de l'envoi du mail" + e.getMessage());
   }

 }

 /**
  * Envoi d'un email de contact.
  */
 public static void envoiMailCandidatureSpontanee(CandidatureSpontaneeForm form, ArrayList<File> fichiers) {
		String jsp = "/plugins/SoclePlugin/jsp/mail/formulaireCandidatureTemplate.jsp";
 	
  // Objet
  String objet = channel.getProperty("jcmsplugin.socle.email.sujet.prefix") + " - " + channel.getProperty("jcmsplugin.socle.email.candidature-spontanee.titre");

  // Contenu
  HashMap<Object, Object> parametersMap = new HashMap<Object, Object>();
  parametersMap.put("nom", form.getNom());
  parametersMap.put("prenom", form.getPrenom());
  parametersMap.put("email", form.getMail());
  parametersMap.put("telephone", Util.notEmpty(form.getTelephone()) ? form.getTelephone() : "");
  parametersMap.put("codepostal", form.getCodePostal());
  parametersMap.put("commune", SocleUtils.getCitynameFromZipcode(form.getCodePostal()));
  parametersMap.put("nature", form.getNatureRecherche(channel.getDefaultAdmin()).first());

		String emailTo = channel.getProperty("jcmsplugin.socle.form.candidature.mailTo");

		if (Util.notEmpty(emailTo)) {
			try {
				sendMail(objet, null, form.getMail(), emailTo, fichiers, jsp, parametersMap);
    msgEnvoiMailContact();
    } catch (Exception e) {
    	msgEchecEnvoiMailContact();
    	LOGGER.error("Erreur lors de l'envoi du mail de candidature spontanée" + e.getMessage());
    }

		} else {
			msgEchecEnvoiMailContact();
			LOGGER.error("Le mail de candidature spontanée n'a pas pu être envoyé car l'email par destination n'est pas défini.");
		}
 }
 

 /**
  * Envoi de mail avec le pied de mail du CG44.
  * 
  * @param subject Objet du mail
  * @param content Contenu du mail
  * @param emailFrom Email de l'expéditeur
  * @param emailTo Email du destinataire
  * @param listePieceJointe Liste des pièces jointes
  * @param jsp La JSP du template de mail à envoyer
  * @param parametersMap La map contenant les données à placer dans le template JSP
  */
 public static void sendMail(String subject, String content, String emailFrom, String emailTo, ArrayList<File> listePieceJointe, String jsp, HashMap<Object, Object> parametersMap)
     throws javax.mail.MessagingException {

   MailMessage mail = new MailMessage("Département de Loire Atlantique");
   mail.setFrom(emailFrom);
   mail.setTo(emailTo);
   mail.setSubject(subject);
   
   if(Util.notEmpty(content)) {
   	mail.setContentHtml(content);
   }else if(Util.notEmpty(jsp)) {
   	mail.setContentHtmlFromJsp(jsp, channel.getDefaultAdmin(), "fr", parametersMap, null);
   }

   if (Util.notEmpty(listePieceJointe)) {
     for (File f : listePieceJointe) {
       mail.addFile(f);
     }
   }
   // Envoi du mail
   mail.send();
 }
 
 /**
  * Envoi du message de confirmation de l'envoi du mail.
  */
 public static void msgEnvoiMailContact() {
   HttpServletRequest request = channel.getCurrentServletRequest();
   JcmsContext.setInfoMsgSession(JcmsUtil.glpd("jcmsplugin.socle.email.message.succes"), request);
   LOGGER.debug(JcmsUtil.glpd("jcmsplugin.socle.email.message.succes"));
 }

 /**
  * Envoi du message d'erreur d'envoi du mail.
  */
 public static void msgEchecEnvoiMailContact() {
   HttpServletRequest request = channel.getCurrentServletRequest();
   JcmsContext.setErrorMsgSession(JcmsUtil.glpd("jcmsplugin.socle.email.message.echec"), request);
   LOGGER.warn(JcmsUtil.glpd("jcmsplugin.socle.email.message.echec"));
 }  
 
 /**
  * Ajout des clauses à la fin du message.
  * 
  * @param contenu
  *          le message du mail.
  * @return le message avec les clauses.
  */
 public static String addClause(String contenu) {
   StringBuilder sb = new StringBuilder(contenu);
   sb.append("<br />");
   sb.append("Ce message a &eacute;t&eacute; envoy&eacute; &agrave; partir d'une adresse ne pouvant recevoir d'e-mails. Merci de ne pas y r&eacute;pondre.<br/>");
   sb.append("<br />");
   sb.append("---------------------------<br/>");
   sb.append("<br />");
   sb.append("En application de la loi n&ordm; 78-17 du 6 janvier 1978 relative &agrave; l'informatique, aux fichiers et aux libert&eacute;s, vous disposez des droits d'opposition, d'acc&egrave;s et de rectification des donn&eacute;es vous concernant. Ainsi, vous pouvez demander une mise &agrave; jour ou une suppression des informations vous concernant si elles s'av&egrave;rent inexactes, incompl&egrave;tes, &eacute;quivoques, p&eacute;rim&eacute;es ou si leur collecte ou leur utilisation, communication ou conservation est interdite.");
   return sb.toString();
 } 
}
