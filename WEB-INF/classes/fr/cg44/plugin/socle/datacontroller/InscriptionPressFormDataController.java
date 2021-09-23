package fr.cg44.plugin.socle.datacontroller;

import java.util.Calendar;
import java.util.HashMap;
import java.util.Map;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;

import com.jalios.jcms.BasicDataController;
import com.jalios.jcms.Channel;
import com.jalios.jcms.ControllerStatus;
import com.jalios.jcms.Data;
import com.jalios.jcms.JcmsUtil;
import com.jalios.jcms.Member;
import com.jalios.jcms.context.JcmsContext;
import com.jalios.jcms.context.JcmsMessage;
import com.jalios.jcms.context.JcmsMessage.Level;
import com.jalios.jcms.plugin.PluginComponent;
import com.jalios.util.StringEncrypter;
import com.jalios.util.StringEncrypter.EncryptionException;
import com.jalios.util.URLUtils;
import com.jalios.util.Util;

import fr.cg44.plugin.socle.MailUtils;
import fr.cg44.plugin.socle.SocleUtils;
import generated.InscriptionPressForm;

public class InscriptionPressFormDataController extends BasicDataController implements PluginComponent {
  private static final Logger LOGGER = Logger.getLogger(InscriptionPressFormDataController.class);
  private static final Channel channel = Channel.getChannel();

  public ControllerStatus checkIntegrity(Data data) {
    ControllerStatus status = ControllerStatus.OK;
    InscriptionPressForm form = (InscriptionPressForm) data;
    String userLang = channel.getCurrentUserLang();
    HttpServletRequest req = channel.getCurrentServletRequest();
    boolean multilingue = channel.getBooleanProperty("jcmsplugin.socle.multilingue", false);
    
    boolean isOK = true;

    // Nom
    if (Util.isEmpty(form.getNom())) {
      isOK = false;
      JcmsContext.addMsg(req, new JcmsMessage(Level.WARN, JcmsUtil.glp(userLang, "jcmsplugin.socle.nom")));
    }

    // Prénom
    if (Util.isEmpty(form.getPrenom())) {
     isOK = false;
     JcmsContext.addMsg(req, new JcmsMessage(Level.WARN, JcmsUtil.glp(userLang, "jcmsplugin.socle.prenom")));
    }

    // Mail
    if (Util.isEmpty(form.getMail())) {
     isOK = false;
     JcmsContext.addMsg(req, new JcmsMessage(Level.WARN, JcmsUtil.glp(userLang, "jcmsplugin.socle.mail")));
    }
    
    if (Util.notEmpty(form.getMail())) {
     String regexp = EMAIL_REGEXP;
     boolean correspond = Pattern.matches(regexp, form.getMail());
     if (!correspond) {
      isOK = false;
      JcmsContext.addMsg(req, new JcmsMessage(Level.WARN, JcmsUtil.glp(userLang, "jcmsplugin.socle.mail")));
     }
     
     /* On vérifie qu'il n'existe pas déjà un membre avec cette adresse mail
      */
     if(Util.notEmpty(channel.getMemberFromLogin(form.getMail()))) {
       isOK = false;
       JcmsContext.addMsg(req, new JcmsMessage(Level.WARN, JcmsUtil.glp(userLang, "jcmsplugin.socle.form.mail-existe")));
     }
    }

    String tmpPwd = req.getParameter("password1");
    LOGGER.warn(tmpPwd);
    LOGGER.warn(Util.encodeBASE64(tmpPwd));
    try {
      LOGGER.warn(Util.encryptDES3(tmpPwd));
    } catch (EncryptionException e) {
      // TODO Auto-generated catch block
      e.printStackTrace();
    }
    // Password
    if (Util.isEmpty(req.getParameter("password1"))) {
     isOK = false;
     JcmsContext.addMsg(req, new JcmsMessage(Level.WARN, JcmsUtil.glp(userLang, "ui.fo.login.lbl.passwd")));
    } 
    if (Util.isEmpty(req.getParameter("password2"))) {
      isOK = false;
      JcmsContext.addMsg(req, new JcmsMessage(Level.WARN, JcmsUtil.glp(userLang, "ui.fo.resetpass.reset.password2.placeholder")));
    }
    if (Util.notEmpty(req.getParameter("password1")) && Util.notEmpty(req.getParameter("password2")) && !req.getParameter("password1").equals(req.getParameter("password2"))) {
      isOK = false;
      JcmsContext.addMsg(req, new JcmsMessage(Level.WARN, JcmsUtil.glp(userLang, "ui.fo.resetpass.reset.form.invalid-password")));
    }

    // Téléphone
    if (!multilingue && Util.notEmpty(form.getTelephone())) {
     String regexp = channel.getProperty("jcmsplugin.socle.regex.phone");
     boolean correspond = Pattern.matches(regexp, form.getTelephone());
     if (!correspond) {
      isOK = false;
      JcmsContext.addMsg(req, new JcmsMessage(Level.WARN, JcmsUtil.glp(userLang, "jcmsplugin.socle.telephone")));
     }
   }

    // Formulaire non valide. On value le titre de la messageBox.
    if(!isOK) {
      status = new ControllerStatus();
      req.setAttribute("titreMessageBox",JcmsUtil.glp(userLang, "jcmsplugin.socle.form.invalidfields"));
    }
    return status;
  }

   
  /* Après enregistrement du formulaire, envoi de mail de confirmation de création de compte 
   * vers l'adresse mail saisie dans le form
   * 
   */
   public void afterWrite(Data data, int op, Member mbr, @SuppressWarnings("rawtypes") Map context) {

     if (op == OP_CREATE) {
       InscriptionPressForm form = (InscriptionPressForm) data;
       HttpServletRequest request = (HttpServletRequest)context.get("request"); 
       String lienDeConfirmation = genereLien(request);
       
       MailUtils.envoiMailDemandeConfirmationCreationCompte(form, form.getMail().trim(), lienDeConfirmation);
        
     }
   }
   
   /**
    * Retourne l'URL de validation de création du compte
    * @param request
    * @return 
    */   
   private String genereLien(HttpServletRequest request) {
     String url = "";
     
     // Permet de crypter les paramètres dans l'URL envoyée par mail
     try {
       StringEncrypter des3Encrypter = new StringEncrypter(StringEncrypter.DESEDE_ENCRYPTION_SCHEME, channel.getProperty("jcmsplugin.socle.newsletter.encrypt.key"));

       // Construction de la map de paramètres à placer dans l'URL
       Map<String, String[]> parametersMap = SocleUtils.getFacetsParameters(request);
       
       // Ajout de la date d'expiration du lien de validation
       Calendar calendar = Calendar.getInstance();
       calendar.add(Calendar.HOUR_OF_DAY, Integer.parseInt(channel.getProperty("jcmsplugin.socle.footer.newsletter.expire.heure")));
       parametersMap.put("expire", new String[]{Long.toString(calendar.getTimeInMillis())});       
       
       // Encode les paramètres de la requete  pour la génération du lien de validation
       Map<String, String[]> parametersEncodeMap = new HashMap<String, String[]>();
       String decodeParamsQuery = URLUtils.getQueryString(parametersMap);
       parametersEncodeMap.put("confirm", new String[]{des3Encrypter.encrypt(decodeParamsQuery)});

       // Création du lien de confirmation
       String redirectUrl = channel.getUrl() + "plugins/SoclePlugin/jsp/portal/inscription/valideInscriptionEspacePresse.jsp";
       url = URLUtils.buildUrl(redirectUrl, parametersEncodeMap);
       

     } catch (EncryptionException e) {
       LOGGER.error("Espace presse : erreur d'encodage de l'URL de confirmation" + e.getMessage());
     }

     return url;
   }
   
   
}