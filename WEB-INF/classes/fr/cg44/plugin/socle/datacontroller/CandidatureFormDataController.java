package fr.cg44.plugin.socle.datacontroller;

import java.io.File;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.Map;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;

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

import fr.cg44.plugin.socle.EmploiUtils;
import generated.CandidatureForm;

public class CandidatureFormDataController extends CandidatureSpontaneeFormDataController implements PluginComponent {
	private static final Logger LOGGER = Logger.getLogger(CandidatureFormDataController.class);
	private static final Channel channel = Channel.getChannel();

 
 /**
  * On modifie le nom du formulaire, et on place la date d'archivage à J + 1 mois
  */  
 @Override
 public void beforeWrite(Data data, int op, Member mbr, Map context) {
  if(op==OP_CREATE){
  	CandidatureForm form = (CandidatureForm) data;
	  
	  GregorianCalendar gc = new GregorianCalendar();
	  gc.setTime(new Date());
	  gc.add(GregorianCalendar.MONTH, 1);
	  Date dateArchivage = gc.getTime();

	  form.setAdate(dateArchivage);
  }
 }

 
 public ControllerStatus checkIntegrity(Data data) {
  ControllerStatus status = ControllerStatus.OK;
  CandidatureForm form = (CandidatureForm) data;
  String userLang = channel.getCurrentUserLang();
  HttpServletRequest req = channel.getCurrentServletRequest();
  
 	boolean isOK = true;

  // Référence de l'offre : vide ou ne correspondant pas à un numéro de poste publié
  if (Util.isEmpty(form.getReference()) || (Util.notEmpty(form.getReference()) && Util.isEmpty(EmploiUtils.getJobByReference(form.getReference())) ) ) {
  	isOK = false;
  	JcmsContext.addMsg(req, new JcmsMessage(Level.WARN, JcmsUtil.glp(userLang, "jcmsplugin.socle.form.candidature.reference-invalide")));
  }
  
  // Nom
  if (Util.isEmpty(form.getNom())) {
    isOK = false;
    JcmsContext.addMsg(req, new JcmsMessage(Level.WARN, channel.getTypeFieldLabel(CandidatureForm.class, "nom", userLang)));
  }

  // Prénom
  if (Util.isEmpty(form.getPrenom())) {
   isOK = false;
   JcmsContext.addMsg(req, new JcmsMessage(Level.WARN, channel.getTypeFieldLabel(CandidatureForm.class, "prenom", userLang)));
  }

  // Mail
  if (Util.isEmpty(form.getMail())) {
   isOK = false;
   JcmsContext.addMsg(req, new JcmsMessage(Level.WARN, channel.getTypeFieldLabel(CandidatureForm.class, "email", userLang)));
  }
  
  if (Util.notEmpty(form.getMail())) {
   String regexp = EMAIL_REGEXP;
   boolean correspond = Pattern.matches(regexp, form.getMail());
   if (!correspond) {
    isOK = false;
    JcmsContext.addMsg(req, new JcmsMessage(Level.WARN, channel.getTypeFieldLabel(CandidatureForm.class, "email", userLang)));
   }
  } 

  // Code postal
 	if(Util.isEmpty(form.getCodePostal())) {
   isOK = false;
   JcmsContext.addMsg(req, new JcmsMessage(Level.WARN, channel.getTypeFieldLabel(CandidatureForm.class, "codePostal", userLang)));
 	}
 	
  if (Util.notEmpty(form.getCodePostal())) {
   String regexp = channel.getProperty("jcmsplugin.socle.regex.postalcode");
   boolean correspond = Pattern.matches(regexp, form.getCodePostal());
   if (!correspond) {
    isOK = false;
    JcmsContext.addMsg(req, new JcmsMessage(Level.WARN, channel.getTypeFieldLabel(CandidatureForm.class, "codePostal", userLang)));
   }
 }  
  
  // Téléphone
  if (Util.notEmpty(form.getTelephone())) {
   String regexp = channel.getProperty("jcmsplugin.socle.regex.phone");
   boolean correspond = Pattern.matches(regexp, form.getTelephone());
   if (!correspond) {
    isOK = false;
    JcmsContext.addMsg(req, new JcmsMessage(Level.WARN, channel.getTypeFieldLabel(CandidatureForm.class, "telephone", userLang)));
   }
 }

  // CurriculumVitae
  if (Util.isEmpty(form.getCurriculumVitae())) {
  	isOK = false;
  	JcmsContext.addMsg(req, new JcmsMessage(Level.WARN, channel.getTypeFieldLabel(CandidatureForm.class, "curriculumVitae", userLang)));
  }

  // LettreMotivation
  if (Util.isEmpty(form.getLettreMotivation())) {
  	isOK = false;
  	JcmsContext.addMsg(req, new JcmsMessage(Level.WARN, channel.getTypeFieldLabel(CandidatureForm.class, "lettreMotivation", userLang)));
  }

  // Formulaire non valide. On value le titre de la messageBox.
  if(!isOK) {
  	status = new ControllerStatus();
  	req.setAttribute("titreMessageBox",JcmsUtil.glp(userLang, "jcmsplugin.socle.form.invalidfields"));
  }
  return status;
}

 /**
  * Vérification du formulaire :
  * 
  * @see com.jalios.jcms.BasicDataController#checkWrite(com.jalios.jcms.Data,
  *      int, com.jalios.jcms.Member, boolean, java.util.Map)
  */
 @Override
 public ControllerStatus checkWrite(Data data, int op, Member mbr, boolean checkIntegrity, Map context) {
   return super.checkWrite(data, op, mbr, checkIntegrity, context);
 }
 
 /**
  * Méthode faisant l'upload du fichier et renvoie le fichier.
  * 
  * @param request
  * @param field
  * @return Le fichier uploadé.
  * @throws Exception
  */
 @Override
 public File getUpload(HttpServletRequest request, String field) throws Exception {
   return super.getUpload(request, field);
 }
 
}