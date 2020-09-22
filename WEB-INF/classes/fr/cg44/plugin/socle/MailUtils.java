package fr.cg44.plugin.socle;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;

import com.jalios.jcms.Channel;
import com.jalios.jcms.JcmsUtil;
import com.jalios.jcms.Publication;
import com.jalios.jcms.context.JcmsContext;
import com.jalios.jcms.mail.MailMessage;
import com.jalios.util.ServletUtil;
import com.jalios.util.Util;

import generated.CandidatureForm;
import generated.CandidatureSpontaneeForm;
import generated.ContactForm;
import generated.FicheEmploiStage;

public final class MailUtils {
	private static Channel channel = Channel.getChannel();

	private static final Logger LOGGER = Logger.getLogger(MailUtils.class);
	private static final String NEWLINE = "<br>";

	private MailUtils() {
		throw new IllegalStateException("Utility class");
	}

	/**
	 * Envoi d'un email de contact.
	 */
	public static void envoiMailContact(ContactForm form, String emailTo) {
		String jsp = "/plugins/SoclePlugin/jsp/mail/formulaireContactTemplate.jsp";

		// Objet
		String objet = JcmsUtil.glp(channel.getDefaultAdmin().getLanguage(), "jcmsplugin.socle.email.contact.objet", form.getSujet(channel.getDefaultAdmin()).first().getName());

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
			sendMail(objet, null, form.getMail(), emailTo, null, null, jsp, parametersMap);
			msgEnvoiMailContact();
		} catch (Exception e) {
			msgEchecEnvoiMailContact();
			LOGGER.error("Erreur lors de l'envoi du mail" + e.getMessage());
		}

	}

	/**
	 * Envoi du mail de candidature spontanée.
	 * Le mail va être reçu par notre outil "AdmiMail" qui ne supporte que le format texte et un poids total < 5Mo
	 */
	public static void envoiMailCandidatureSpontanee(CandidatureSpontaneeForm form, ArrayList<File> fichiers) {
		// Objet
		String objet = JcmsUtil.glp(channel.getDefaultAdmin().getLanguage(), "jcmsplugin.socle.email.candidature-spontanee.objet");

    // Contenu
    StringBuilder contenu = new StringBuilder("Expediteur : ");
    contenu.append(form.getNom() + " " + form.getPrenom() + " a envoyé une candidature spontanée" + NEWLINE);
    contenu.append("Nom : ").append(form.getNom()).append(NEWLINE);
    contenu.append("Prenom : ").append(form.getPrenom()).append(NEWLINE);
    contenu.append("Email expediteur : ").append(form.getMail()).append(NEWLINE);
    contenu.append("Telephone : ");
    if (Util.notEmpty(form.getTelephone())) {
      contenu.append(form.getTelephone());
    }
    contenu.append(NEWLINE);
    contenu.append("Code postal : ").append(form.getCodePostal()).append(NEWLINE);
    contenu.append("Code postal delegation : ").append(form.getCodePostal()).append(NEWLINE);
    contenu.append("Commune : ").append(SocleUtils.getCitynameFromZipcode(form.getCodePostal())).append(NEWLINE);
    contenu.append("Nature : ").append(form.getNatureRecherche(channel.getDefaultAdmin()).first()).append(NEWLINE);
    contenu.append("---------------------------").append(NEWLINE);
    contenu.append("Pieces jointes : CV, lettre de motivation et pièce complémentaire");		

    // Destinataire
		String emailTo = channel.getProperty("jcmsplugin.socle.form.candidature.mailTo");

		if (Util.notEmpty(emailTo)) {
			try {
				sendMail(objet, contenu.toString(), form.getMail(), emailTo, fichiers);
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
	 * Envoi d'un email de candidature (réponse à une offre).
	 * Si un email spécifique a été saisi dans la fiche emploi, alors on envoi en CC
	 */
	public static void envoiMailCandidature(CandidatureForm form, ArrayList<File> fichiers, String idFicheEmploi) {
		// Récupération de l'offre d'emploi
		String jobTitle = "";
		String emailSpecifique = "";
		FicheEmploiStage job = (FicheEmploiStage)channel.getPublication(idFicheEmploi);

		if (Util.isEmpty(job)) {
			LOGGER.error("Formulaire de candidature : aucune FicheEmploiStage trouvée à partir de la référence " + form.getReference());
		}else{
			jobTitle = job.getTitle();
			emailSpecifique = job.getEmailSpecifique();
		}
		
		// Destinataire
		String emailTo = channel.getProperty("jcmsplugin.socle.form.candidature.mailTo");
	    
	    ArrayList<String> listeEmailCC = new ArrayList<>();
	    if(Util.notEmpty(emailSpecifique)){
	      listeEmailCC.add(emailSpecifique);
	    }

		// Objet
		String objet = JcmsUtil.glp(channel.getDefaultAdmin().getLanguage(), "jcmsplugin.socle.email.candidature.objet", form.getReference());

		StringBuilder contenu = new StringBuilder("Expediteur : ");
		contenu.append("  " + form.getNom() + " "+ form.getPrenom() + " a repondu à l'annonce " + form.getReference() + " – " + jobTitle + NEWLINE);
		contenu.append("  Nom : " + form.getNom() + NEWLINE);
		contenu.append("  Prenom : " + form.getPrenom() + NEWLINE);
		contenu.append("  Email expediteur : " + form.getMail() + NEWLINE);
		contenu.append("  Telephone : ");
		if (Util.notEmpty(form.getTelephone())) {
			contenu.append(form.getTelephone());
		}
		contenu.append(NEWLINE);
		contenu.append("  Code postal : " + form.getCodePostal() + NEWLINE);
		contenu.append("  Code postal delegation : "+ EmploiUtils.getCodePostalDelegationFromJob(job) + NEWLINE);
		contenu.append("  Nature : " + job.getTypeDoffre(channel.getDefaultAdmin()).first() + NEWLINE);
		contenu.append("  ---------------------------" + NEWLINE);
		contenu.append("  Pieces jointes : CV, lettre de motivation et pièce complémentaire");

		if (Util.notEmpty(emailTo)) {
			try {
				sendMail(objet, contenu.toString(), form.getMail(), emailTo,  Util.notEmpty(listeEmailCC) ? listeEmailCC : null, fichiers, null, null);
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
	 * Envoi de l'email du formaulaire FAQ.
	 */
	public static boolean envoiMailFAQ(HttpServletRequest request, String emailTo) {
	  boolean result = false;
		String jsp = "/plugins/SoclePlugin/jsp/mail/formulaireFaqTemplate.jsp";
		
		// Objet
		String objet = JcmsUtil.glpd("jcmsplugin.socle.email.faq.objet");

		// Publication concernée par la FAQ
		Publication pub = channel.getPublication(request.getParameter("id[value]"));
		// Contenu
		HashMap<Object, Object> parametersMap = new HashMap<Object, Object>();
		parametersMap.put("publication", pub.getTitle());
		parametersMap.put("lien", ServletUtil.getBaseUrl(request)+pub.getDisplayUrl(channel.getLocale()));
		parametersMap.put("question", request.getParameter("question[value]"));
		parametersMap.put("codepostal", Util.notEmpty(request.getParameter("commune[value]")) ? request.getParameter("commune[value]") : "");
		parametersMap.put("commune", Util.notEmpty(request.getParameter("commune[text]")) ? request.getParameter("commune[text]") : "");
		parametersMap.put("email", request.getParameter("mail[value]"));

		if (Util.notEmpty(emailTo)) {
			try {
				sendMail(objet, null, request.getParameter("mail[value]"), emailTo, null, null, jsp, parametersMap);
				result = true;
			} catch (Exception e) {
				result = false;
				LOGGER.error("Erreur lors de l'envoi du mail de FAQ" + e.getMessage());
			}

		} else {
			result = false;
			LOGGER.error("Le mail de FAQ n'a pas pu être envoyé car l'email par destination n'est pas défini.");
		}

		return result;
	}
	
  /**
   * Envoi de l'email du formulaire "Page utile"
   * Le destinataire est le rédacteur de la publication
   * Un autre destinaire peut être paramétré en prop du site pour en voi en CC. 
   * 
   */
  public static boolean envoiMailPageUtile(boolean pageUtile, String titre, String url, String commentaire, String date, String motif, String emailRedacteur) {
    String emailFrom = channel.getDefaultAdmin().getEmail();
    String emailCC = channel.getProperty("jcmsplugin.socle.pageutile.mailto");
    
    ArrayList<String> listeEmailCC = new ArrayList<>();
    if(Util.notEmpty(emailCC)){
      listeEmailCC.add(emailCC);
    }
    
    // Check adresses email
    if(Util.isEmpty(emailRedacteur) || Util.isEmpty(emailCC)) {
      return false;
    }
    
    boolean result = false;
    String jsp = "/plugins/SoclePlugin/jsp/mail/formulairePageUtileTemplate.jsp";
    
    // Objet
    StringBuffer objet = new StringBuffer();
    objet.append(channel.getName()).append(" / ");
    objet.append(pageUtile ? JcmsUtil.glpd("jcmsplugin.socle.email.pageutile.objet.utile") : JcmsUtil.glpd("jcmsplugin.socle.email.pageutile.objet.inutile"));

    // Contenu
    HashMap<Object, Object> parametersMap = new HashMap<Object, Object>();
    parametersMap.put("date", date);
    parametersMap.put("avis", pageUtile ? JcmsUtil.glpd("jcmsplugin.socle.email.pageutile.libelle-avis.utile") : JcmsUtil.glpd("jcmsplugin.socle.email.pageutile.libelle-avis.inutile"));
    parametersMap.put("titre", titre);
    parametersMap.put("lien", url);
    parametersMap.put("commentaire", commentaire);
    parametersMap.put("motif", motif);
    
    if (Util.notEmpty(emailRedacteur)) {
      try {
        sendMail(objet.toString(), null, emailFrom, emailRedacteur, Util.notEmpty(listeEmailCC) ? listeEmailCC : null, null, jsp, parametersMap);
        result = true;
      } catch (Exception e) {
        result = false;
        LOGGER.error("Erreur lors de l'envoi du mail Page utile" + e.getMessage());
      }

    } else {
      result = false;
      LOGGER.error("Le mail de Page utile n'a pas pu être envoyé car l'email par destination n'est pas défini.");
    }

    return result;
  }	
	

	/**
	 * Envoi de mail
	 * 
	 * @param subject Objet du mail
	 * @param content Contenu du mail
	 * @param emailFrom Email de l'expéditeur
	 * @param emailTo Email du destinataire
	 * @param listePieceJointe Liste des pièces jointes
	 * @param jsp La JSP du template de mail à envoyer
	 * @param parametersMap La map contenant les données à placer dans le template JSP
	 */
	@SuppressWarnings("deprecation")
  public static void sendMail(String subject, String content, String emailFrom, String emailTo, ArrayList<String> listeEmailCC, ArrayList<File> listePieceJointe, String jsp, HashMap<Object, Object> parametersMap)
			throws javax.mail.MessagingException {

		MailMessage mail = new MailMessage("Département de Loire Atlantique");
		mail.setFrom(emailFrom);
		mail.setTo(emailTo);
		
		if(Util.notEmpty(listeEmailCC)) {
		  for(String itEmailCC : listeEmailCC) {
		    mail.addCc(itEmailCC);
		  }
		}
		mail.setSubject(subject);
		

		if(Util.notEmpty(content)) {
		  mail.setContentText(Util.html2Ascii(content));
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
   * Envoi de mail simple
   * 
   * @param subject Objet du mail
   * @param content Contenu du mail
   * @param emailFrom Email de l'expéditeur
   * @param emailTo Email du destinataire
   */
  public static void sendMail(String subject, String content, String emailFrom, String emailTo)
      throws javax.mail.MessagingException {
    
    sendMail(subject, content, emailFrom, emailTo, null, null, null, null);
  }
  
  /**
   * Envoi de mail avec PJ
   * 
   * @param subject Objet du mail
   * @param content Contenu du mail
   * @param emailFrom Email de l'expéditeur
   * @param emailTo Email du destinataire
   * @param listePieceJointe Liste des pièces jointes
   */
  public static void sendMail(String subject, String content, String emailFrom, String emailTo, ArrayList<File> listePieceJointe)
      throws javax.mail.MessagingException {
    
    sendMail(subject, content, emailFrom, emailTo, null, listePieceJointe, null, null);
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
		sb.append(NEWLINE);
		sb.append("Ce message a &eacute;t&eacute; envoy&eacute; &agrave; partir d'une adresse ne pouvant recevoir d'e-mails. Merci de ne pas y r&eacute;pondre.");
		sb.append(NEWLINE);
		sb.append("---------------------------");
		sb.append(NEWLINE);
		sb.append("En application de la loi n&ordm; 78-17 du 6 janvier 1978 relative &agrave; l'informatique, aux fichiers et aux libert&eacute;s, vous disposez des droits d'opposition, d'acc&egrave;s et de rectification des donn&eacute;es vous concernant. Ainsi, vous pouvez demander une mise &agrave; jour ou une suppression des informations vous concernant si elles s'av&egrave;rent inexactes, incompl&egrave;tes, &eacute;quivoques, p&eacute;rim&eacute;es ou si leur collecte ou leur utilisation, communication ou conservation est interdite.");
		return sb.toString();
	} 
}
