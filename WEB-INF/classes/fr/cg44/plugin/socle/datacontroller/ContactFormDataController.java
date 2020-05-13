package fr.cg44.plugin.socle.datacontroller;

import java.util.Map;
import java.util.TreeSet;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;

import com.jalios.jcms.BasicDataController;
import com.jalios.jcms.Category;
import com.jalios.jcms.Channel;
import com.jalios.jcms.ControllerStatus;
import com.jalios.jcms.Data;
import com.jalios.jcms.JcmsUtil;
import com.jalios.jcms.Member;
import com.jalios.jcms.context.JcmsContext;
import com.jalios.jcms.context.JcmsMessage;
import com.jalios.jcms.context.JcmsMessage.Level;
import com.jalios.jcms.plugin.PluginComponent;
import com.jalios.util.Util;

import fr.cg44.plugin.socle.MailUtils;
import generated.ContactForm;

public class ContactFormDataController extends BasicDataController implements PluginComponent {
	private static final Logger LOGGER = Logger.getLogger(ContactFormDataController.class);
	private static final Channel channel = Channel.getChannel();
	
 public ControllerStatus checkIntegrity(Data data) {
  ControllerStatus status = ControllerStatus.OK;
  ContactForm form = (ContactForm) data;
  String userLang = channel.getCurrentUserLang();
  HttpServletRequest req = channel.getCurrentServletRequest();
  
 	boolean isOK = true;

  // Nom
  if (Util.isEmpty(form.getNom())) {
    isOK = false;
    JcmsContext.addMsg(req, new JcmsMessage(Level.WARN, channel.getTypeFieldLabel(ContactForm.class, "nom", userLang)));
  }

  // Prénom
  if (Util.isEmpty(form.getPrenom())) {
   isOK = false;
   JcmsContext.addMsg(req, new JcmsMessage(Level.WARN, channel.getTypeFieldLabel(ContactForm.class, "prenom", userLang)));
  }

  // Mail
  if (Util.isEmpty(form.getMail())) {
   isOK = false;
   JcmsContext.addMsg(req, new JcmsMessage(Level.WARN, channel.getTypeFieldLabel(ContactForm.class, "email", userLang)));
  }
  
  if (Util.notEmpty(form.getMail())) {
   String regexp = EMAIL_REGEXP;
   boolean correspond = Pattern.matches(regexp, form.getMail());
   if (!correspond) {
    isOK = false;
    JcmsContext.addMsg(req, new JcmsMessage(Level.WARN, channel.getTypeFieldLabel(ContactForm.class, "email", userLang)));
   }
  } 

  // Code postal
 	if(Util.isEmpty(form.getCodePostal())) {
   isOK = false;
   JcmsContext.addMsg(req, new JcmsMessage(Level.WARN, channel.getTypeFieldLabel(ContactForm.class, "codePostal", userLang)));
 	}
 	
  if (Util.notEmpty(form.getCodePostal())) {
   String regexp = channel.getProperty("jcmsplugin.socle.regex.postalcode");
   boolean correspond = Pattern.matches(regexp, form.getCodePostal());
   if (!correspond) {
    isOK = false;
    JcmsContext.addMsg(req, new JcmsMessage(Level.WARN, channel.getTypeFieldLabel(ContactForm.class, "codePostal", userLang)));
   }
 }  
  
  // Téléphone
 	if(Util.isEmpty(form.getTelephone())) {
   isOK = false;
   JcmsContext.addMsg(req, new JcmsMessage(Level.WARN, channel.getTypeFieldLabel(ContactForm.class, "telephone", userLang)));
 	}
 	
  if (Util.notEmpty(form.getTelephone())) {
   String regexp = channel.getProperty("jcmsplugin.socle.regex.phone");
   boolean correspond = Pattern.matches(regexp, form.getTelephone());
   if (!correspond) {
    isOK = false;
    JcmsContext.addMsg(req, new JcmsMessage(Level.WARN, channel.getTypeFieldLabel(ContactForm.class, "telephone", userLang)));
   }
 }

  // Sujet
  if (Util.isEmpty(form.getSujet(channel.getDefaultAdmin()))) {
  	isOK = false;
  	JcmsContext.addMsg(req, new JcmsMessage(Level.WARN, channel.getTypeFieldLabel(ContactForm.class, "sujet", userLang)));
  }

  // Message
  if (Util.isEmpty(form.getMessage())) {
  	isOK = false;
  	JcmsContext.addMsg(req, new JcmsMessage(Level.WARN, channel.getTypeFieldLabel(ContactForm.class, "message", userLang)));
  }

  // Formulaire non valide. On value le titre de la messageBox.
  if(!isOK) {
  	status = new ControllerStatus();
  	req.setAttribute("titreMessageBox",JcmsUtil.glp(userLang, "jcmsplugin.socle.form.invalidfields"));
  }
  return status;
}


 public void afterWrite(Data data, int op, Member mbr, @SuppressWarnings("rawtypes") Map context) {

   if (op == OP_CREATE) {
     ContactForm form = (ContactForm) data;

     // Si la catégorie du sujet a une description, utiliser cette dernière
     // comme email destinataire
     // sinon prendre l'email défini dans le module
     @SuppressWarnings("unchecked")
     Category sujet = ((TreeSet<Category>) form.getSujet(channel.getDefaultAdmin())).first();
     String contactMail = Util.notEmpty(sujet.getDescription()) ? sujet.getDescription() : channel.getProperty("jcmsplugin.socle.email.emailParDefaut");

     if (Util.notEmpty(contactMail)) {
     	contactMail = contactMail.trim();
       if (Pattern.matches(EMAIL_REGEXP, contactMail)) {
         LOGGER.debug("Envoi du mail de contact à l'adresse : " + contactMail);
         MailUtils.envoiMailContact(form, contactMail);
       } else {
         LOGGER.error("L'adresse e-mail du destinataire des mails de contact (\"jcmsplugin.socle.email.emailParDefaut\") ne respecte pas le Pattern : "
             + EMAIL_REGEXP);
         MailUtils.msgEchecEnvoiMailContact();
       }
     } else {
       LOGGER.error("L'adresse e-mail du destinataire des mails de contact (\"jcmsplugin.socle.email.emailParDefaut\") est vide");
       MailUtils.msgEchecEnvoiMailContact();
     }
   }
 }

}