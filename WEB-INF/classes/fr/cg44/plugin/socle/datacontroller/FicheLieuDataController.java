package fr.cg44.plugin.socle.datacontroller;

import com.jalios.jcms.BasicDataController;
import com.jalios.jcms.ControllerStatus;
import com.jalios.jcms.Data;
import com.jalios.jcms.plugin.PluginComponent;
import com.jalios.util.Util;

import generated.FicheArticle;

public class FicheLieuDataController extends BasicDataController implements PluginComponent {
	
    // TODO afterWrite
    // Si le champ docs ASU n'est pas vide, ajouter pour chaque doc un groupe précis dans les droits d'accès $jcmsplugin.socle.fichelieu.groupe.asu
    
}