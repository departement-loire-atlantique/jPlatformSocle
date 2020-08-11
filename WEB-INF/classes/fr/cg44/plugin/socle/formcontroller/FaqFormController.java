package fr.cg44.plugin.socle.formcontroller;

import java.util.Map;
import java.util.TreeSet;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;

import com.jalios.jcms.Category;
import com.jalios.jcms.Channel;
import com.jalios.jcms.ControllerStatus;
import com.jalios.jcms.Data;
import com.jalios.jcms.JcmsConstants;
import com.jalios.jcms.JcmsUtil;
import com.jalios.jcms.Member;
import com.jalios.jcms.context.JcmsContext;
import com.jalios.jcms.context.JcmsMessage;
import com.jalios.jcms.context.JcmsMessage.Level;
import com.jalios.jcms.plugin.PluginComponent;
import com.jalios.util.Util;

import fr.cg44.plugin.socle.MailUtils;
import generated.ContactForm;

public class FaqFormController implements PluginComponent {
	private static final Logger LOGGER = Logger.getLogger(FaqFormController.class);
	private static final Channel channel = Channel.getChannel();
	
 public static boolean checkIntegrity() {
  String userLang = channel.getCurrentUserLang();
  HttpServletRequest req = channel.getCurrentServletRequest();
  
 	boolean isOK = true;

  // Question
  if (Util.isEmpty(req.getParameter("question"))) {
    isOK = false;
    JcmsContext.addMsg(req, new JcmsMessage(Level.WARN, "Question"));
  }

  // Mail
  if (Util.isEmpty(req.getParameter("mail"))) {
   isOK = false;
   JcmsContext.addMsg(req, new JcmsMessage(Level.WARN, "Email"));
  }
  
  if (Util.notEmpty(req.getParameter("mail"))) {
   String regexp = JcmsConstants.EMAIL_REGEXP;
   boolean correspond = Pattern.matches(regexp, req.getParameter("mail"));
   if (!correspond) {
    isOK = false;
    JcmsContext.addMsg(req, new JcmsMessage(Level.WARN, "Email"));
   }
  } 

  // Formulaire non valide. On value le titre de la messageBox.
  if(!isOK) {
  	req.setAttribute("titreMessageBox",JcmsUtil.glp(userLang, "jcmsplugin.socle.form.invalidfields"));
  }

  req.setAttribute("formFaqSoumis", true);
  return isOK;
}

}