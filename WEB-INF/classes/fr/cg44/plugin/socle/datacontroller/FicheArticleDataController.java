package fr.cg44.plugin.socle.datacontroller;

import com.jalios.jcms.BasicDataController;
import com.jalios.jcms.ControllerStatus;
import com.jalios.jcms.Data;
import com.jalios.jcms.plugin.PluginComponent;
import com.jalios.util.Util;

import generated.FicheArticle;

public class FicheArticleDataController extends BasicDataController implements PluginComponent {
	
	public ControllerStatus checkIntegrity(Data data) {
		FicheArticle itFiche = (FicheArticle) data;
				
		if (! itFiche.getTypeSimple() 
				&& Util.isEmpty(itFiche.getContenuParagraphe_1()) 
				&& Util.isEmpty(itFiche.getContenuParagraphe_2())
				&& Util.isEmpty(itFiche.getContenuParagraphe_3())
				&& Util.isEmpty(itFiche.getContenuParagraphe_4())) {
			// Type est onglet, pas de contenu -> on retourne une erreur
			ControllerStatus status = new ControllerStatus();
			status.setProp("msg.edit.empty-field", "Contenu paragraphe des onglets");
			return status;
		}
		
		return super.checkIntegrity(data);
	}
	
}