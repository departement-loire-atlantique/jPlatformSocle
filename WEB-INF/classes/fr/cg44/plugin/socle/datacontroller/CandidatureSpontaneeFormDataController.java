package fr.cg44.plugin.socle.datacontroller;

import java.io.File;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.Enumeration;
import java.util.GregorianCalendar;
import java.util.List;
import java.util.Map;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.fileupload.FileItem;
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
import com.jalios.jcms.upload.DocUploadInfo;
import com.jalios.util.Util;

import fr.cg44.plugin.socle.MailUtils;
import generated.CandidatureForm;
import generated.CandidatureSpontaneeForm;

public class CandidatureSpontaneeFormDataController extends BasicDataController implements PluginComponent {
	private static final Logger LOGGER = Logger.getLogger(CandidatureSpontaneeFormDataController.class);
	private static final Channel channel = Channel.getChannel();
 private static final String REQUEST_CV = "curriculumVitae";
 private static final String REQUEST_LM = "lettreMotivation";
 private static final String REQUEST_PC1 = "pieceComplementaire1";
 private static final String REQUEST_PC2 = "pieceComplementaire2";
 private static final String REQUEST_PC3 = "pieceComplementaire3";
 private static final String FILE_NAME_CV = "cv";
 private static final String FILE_NAME_LM = "lettre_motivation";
 private static final String FILE_NAME_PC1 = "complement1";
 private static final String FILE_NAME_PC2 = "complement2";
 private static final String FILE_NAME_PC3 = "complement3";
 private static final String repertoireCand = channel.getUploadPath("/")+"candidatures/";
 
 /**
  * On modifie le nom du formulaire, et on place la date d'archivage à J + 1 mois
  */  
 @Override
 public void beforeWrite(Data data, int op, Member mbr, Map context) {
  if(op==OP_CREATE){
  	CandidatureSpontaneeForm form = (CandidatureSpontaneeForm) data;
	  
	  GregorianCalendar gc = new GregorianCalendar();
	  gc.setTime(new Date());
	  gc.add(GregorianCalendar.MONTH, 1);
	  Date dateArchivage = gc.getTime();

	  String typeNatureRecherche = ((Category)form.getNatureRecherche(mbr).first()).getName();
	  form.setAdate(dateArchivage);
	  form.setTitle(CandidatureSpontaneeForm.getTypeEntry().getLabel(channel.getLanguage())+ " "+typeNatureRecherche);
  }
 }
 
 public ControllerStatus checkIntegrity(Data data) {
  ControllerStatus status = ControllerStatus.OK;
  CandidatureSpontaneeForm form = (CandidatureSpontaneeForm) data;
  String userLang = channel.getCurrentUserLang();
  HttpServletRequest req = channel.getCurrentServletRequest();
  
 	boolean isOK = true;

  // NatureRecherche
  if (Util.isEmpty(form.getNatureRecherche(channel.getDefaultAdmin()))) {
  	isOK = false;
  	JcmsContext.addMsg(req, new JcmsMessage(Level.WARN, channel.getTypeFieldLabel(CandidatureSpontaneeForm.class, "natureRecherche", userLang)));
  }
  
  // Nom
  if (Util.isEmpty(form.getNom())) {
    isOK = false;
    JcmsContext.addMsg(req, new JcmsMessage(Level.WARN, channel.getTypeFieldLabel(CandidatureSpontaneeForm.class, "nom", userLang)));
  }

  // Prénom
  if (Util.isEmpty(form.getPrenom())) {
   isOK = false;
   JcmsContext.addMsg(req, new JcmsMessage(Level.WARN, channel.getTypeFieldLabel(CandidatureSpontaneeForm.class, "prenom", userLang)));
  }

  // Mail
  if (Util.isEmpty(form.getMail())) {
   isOK = false;
   JcmsContext.addMsg(req, new JcmsMessage(Level.WARN, channel.getTypeFieldLabel(CandidatureSpontaneeForm.class, "email", userLang)));
  }
  
  if (Util.notEmpty(form.getMail())) {
   String regexp = EMAIL_REGEXP;
   boolean correspond = Pattern.matches(regexp, form.getMail());
   if (!correspond) {
    isOK = false;
    JcmsContext.addMsg(req, new JcmsMessage(Level.WARN, channel.getTypeFieldLabel(CandidatureSpontaneeForm.class, "email", userLang)));
   }
  } 

  // Code postal
 	if(Util.isEmpty(form.getCodePostal())) {
   isOK = false;
   JcmsContext.addMsg(req, new JcmsMessage(Level.WARN, channel.getTypeFieldLabel(CandidatureSpontaneeForm.class, "codePostal", userLang)));
 	}
 	
  if (Util.notEmpty(form.getCodePostal())) {
   String regexp = channel.getProperty("jcmsplugin.socle.regex.postalcode");
   boolean correspond = Pattern.matches(regexp, form.getCodePostal());
   if (!correspond) {
    isOK = false;
    JcmsContext.addMsg(req, new JcmsMessage(Level.WARN, channel.getTypeFieldLabel(CandidatureSpontaneeForm.class, "codePostal", userLang)));
   }
 }  
  
  // Téléphone
  if (Util.notEmpty(form.getTelephone())) {
   String regexp = channel.getProperty("jcmsplugin.socle.regex.phone");
   boolean correspond = Pattern.matches(regexp, form.getTelephone());
   if (!correspond) {
    isOK = false;
    JcmsContext.addMsg(req, new JcmsMessage(Level.WARN, channel.getTypeFieldLabel(CandidatureSpontaneeForm.class, "telephone", userLang)));
   }
 }

  // CurriculumVitae
  if (Util.isEmpty(form.getCurriculumVitae())) {
  	isOK = false;
  	JcmsContext.addMsg(req, new JcmsMessage(Level.WARN, channel.getTypeFieldLabel(CandidatureSpontaneeForm.class, "curriculumVitae", userLang)));
  }

  // LettreMotivation
  if (Util.isEmpty(form.getLettreMotivation())) {
  	isOK = false;
  	JcmsContext.addMsg(req, new JcmsMessage(Level.WARN, channel.getTypeFieldLabel(CandidatureSpontaneeForm.class, "lettreMotivation", userLang)));
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

   if (op == OP_CREATE) {

     // Récupération des fichiers
     HttpServletRequest request = channel.getCurrentServletRequest();
     String userLang = channel.getCurrentUserLang();
     
     ArrayList<File> fichiers = new ArrayList<File>();
     File cv = null;
     File lettreMotivation = null;
     File pieceComplementaire1 = null;
     File pieceComplementaire2 = null;
     File pieceComplementaire3 = null;

     try {
       cv = getUpload(request, REQUEST_CV);
       lettreMotivation = getUpload(request, REQUEST_LM);
       pieceComplementaire1 = getUpload(request, REQUEST_PC1);
       pieceComplementaire2 = getUpload(request, REQUEST_PC2);
       pieceComplementaire3 = getUpload(request, REQUEST_PC3);
       if (Util.notEmpty(cv)) {
       	fichiers.add(cv);
       }
       if (Util.notEmpty(lettreMotivation)) {
       	fichiers.add(lettreMotivation);
       }
       if (Util.notEmpty(pieceComplementaire1)) {
       	fichiers.add(pieceComplementaire1);
       }
       if (Util.notEmpty(pieceComplementaire2)) {
       	fichiers.add(pieceComplementaire2);
       }
       if (Util.notEmpty(pieceComplementaire3)) {
       	fichiers.add(pieceComplementaire3);
       }
       
       // Vérifier la taille des fichiers upload
       for(File itFile : fichiers) {
         if(itFile != null && itFile.length() > channel.getIntegerProperty("jcmsplugin.socle.form.candidature.file.size.max", 1048576)) {
           ControllerStatus fileStatus = new ControllerStatus();
           request.setAttribute("titreMessageBox",JcmsUtil.glp(userLang, "jcmsplugin.socle.form.error.taille"));
           // supprime les fichiers uploades du formulaire
           deleteFiles(fichiers);
           return fileStatus;
         }
       }
       
       
       
     } catch (Exception e) {
       LOGGER.warn(e.getMessage());
       return new ControllerStatus("Une erreur s'est produite pendant le téléchargement de votre candidature");
     }

     // envoi du mail
     if (data instanceof CandidatureSpontaneeForm) {
       MailUtils.envoiMailCandidatureSpontanee((CandidatureSpontaneeForm) data, fichiers);
     }
     else if (data instanceof CandidatureForm) {
    	String idFiche = request.getParameter("idFiche");
     	MailUtils.envoiMailCandidature((CandidatureForm) data, fichiers, idFiche);
     }
     else {
       LOGGER.error("The application form is not an ApplicationForm or ApplicationFreeForm object.");
     }

     // Suppression des fichiers
     deleteFiles(fichiers);    

   }
   return super.checkWrite(data, op, mbr, checkIntegrity, context);
 }
 
 
 /**
  * Suppression des fichiers
  * @param files
  */
 public void deleteFiles(List<File> files) {
   for (File itFile : files) {
     if (!itFile.delete()) {
       LOGGER.warn("Le fichier " + itFile.getName() + " n'a pas pu être supprimé.");
     }
   }
 }
 

 /**
  * Méthode faisant l'upload du fichier et renvoie le fichier.
  * 
  * @param request
  * @param field
  * @return Le fichier uploadé.
  * @throws Exception
  */
 public File getUpload(HttpServletRequest request, String field) throws Exception {
   LOGGER.debug("datacontroller.PostulerController.getUpload(");

   // Retrieve FileItem from request attribute
   Object value = request.getSession().getAttribute(field);

   // Perform checks
   if (value == null) {
     return null;
   }
   if (value instanceof FileItem) {
     FileItem item = (FileItem) value;
     Calendar cal = new GregorianCalendar();
     String filename = cal.getTimeInMillis() + "_";
     String extension = item.getName().substring(item.getName().lastIndexOf("."));
     if(field.equals(REQUEST_CV)){
   	  filename += FILE_NAME_CV + extension;
     }else if(field.equals(REQUEST_LM)){
   	  filename += FILE_NAME_LM + extension;
     }else if( field.equals(REQUEST_PC1)){
   	  filename += FILE_NAME_PC1 + extension;
     }else if( field.equals(REQUEST_PC2)){
   	  filename += FILE_NAME_PC2 + extension;
     }else if( field.equals(REQUEST_PC3)){
   	  filename += FILE_NAME_PC3 + extension;
     }
     File fichier = new File(repertoireCand, filename);
     item.write(fichier);
     return fichier;
   }

   // Retrieve linked File
   DocUploadInfo dui = new DocUploadInfo();
   dui.doUpload((FileItem) value, false, false);
   return dui.getFile();
 }

 private String getPath(HttpServletRequest request) {
   String initPath = request.getServletContext().getRealPath("");
   if (!initPath.endsWith("/")) {
     initPath = initPath + "/";
   }

   String finalPath = initPath + Channel.getChannel().getProperty("jcmsplugin.socle.form.candidature.folder");

   return finalPath;
 }  
}