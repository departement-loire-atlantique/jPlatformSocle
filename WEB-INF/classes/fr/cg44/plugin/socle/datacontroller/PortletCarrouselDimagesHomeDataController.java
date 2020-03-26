package fr.cg44.plugin.socle.datacontroller;

import com.jalios.jcms.BasicDataController;
import com.jalios.jcms.Channel;
import com.jalios.jcms.ControllerStatus;
import com.jalios.jcms.Data;
import com.jalios.jcms.JcmsUtil;
import com.jalios.util.Util;

import generated.PortletCarrouselDimagesHome;

public class PortletCarrouselDimagesHomeDataController extends BasicDataController {
	
	public ControllerStatus checkIntegrity(Data data) {
	  PortletCarrouselDimagesHome itPortlet = (PortletCarrouselDimagesHome) data;
				
		if (Util.notEmpty(itPortlet.getElementsDiaporamaPrincipaux()) && Util.notEmpty(itPortlet.getElementsDiaporamasSecondaires())) {
		  if (itPortlet.getElementsDiaporamaPrincipaux().length != itPortlet.getElementsDiaporamasSecondaires().length) {
		    ControllerStatus itStatus = new ControllerStatus();
		    itStatus.setMessage(JcmsUtil.glp(Channel.getChannel().getCurrentUserLang(), "jcmsplugin.socle.carrouselhome.error.differentSizes"));
		    return itStatus;
		  }
		  for (int counter = 0; counter < itPortlet.getElementsDiaporamaPrincipaux().length; counter++) {
		    if (Util.isEmpty(itPortlet.getElementsDiaporamaPrincipaux()[counter]) || Util.isEmpty(itPortlet.getElementsDiaporamasSecondaires()[counter])) {
		      ControllerStatus itStatus = new ControllerStatus();
	        itStatus.setMessage(JcmsUtil.glp(Channel.getChannel().getCurrentUserLang(), "jcmsplugin.socle.carrouselhome.error.nosibling", Integer.toString(counter+1)));
	        return itStatus;
		    }
		  }
		  
		}
		
		return super.checkIntegrity(data);
	}
	
}