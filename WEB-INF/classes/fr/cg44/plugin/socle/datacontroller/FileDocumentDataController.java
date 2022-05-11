package fr.cg44.plugin.socle.datacontroller;

import java.util.Map;
import java.util.TreeSet;

import com.jalios.jcms.BasicDataController;
import com.jalios.jcms.Category;
import com.jalios.jcms.Channel;
import com.jalios.jcms.Data;
import com.jalios.jcms.FileDocument;
import com.jalios.jcms.Group;
import com.jalios.jcms.Member;
import com.jalios.jcms.plugin.PluginComponent;
import com.jalios.util.Util;

import generated.FicheLieu;

public class FileDocumentDataController extends BasicDataController implements PluginComponent {

	private static Channel channel = Channel.getChannel();

	private static final Category classementCategory = channel.getCategory(channel.getProperty("jcmsplugin.socle.category.classementfiledoc"));

	@Override
	/* 
	 * Ajoute une catégorie de classement sur les filedocuments d'extension '.txt' (RS-1199)
	 * */
	public void beforeWrite(Data data, int op, Member mbr, Map context) {
	    
	    FileDocument itFileDoc = (FileDocument) data;
	    
	    if (Util.notEmpty(classementCategory)) {

    	    if (itFileDoc.getFile().getName().endsWith(".txt")) {
    	        itFileDoc.addCategory(classementCategory);
    	    }
    	    
    	    itFileDoc.addCategory(classementCategory);
	    }
	    
	    // Spécifique ASU
	    if (op == OP_CREATE) {
	        Group groupAsu = Channel.getChannel().getGroup("$jcmsplugin.socle.fichelieu.groupe.asu");
            if (Util.notEmpty(groupAsu) && Util.notEmpty(itFileDoc.getAllReferrerSet())) {
                for (Object itData : itFileDoc.getAllReferrerSet()) {
                    // Le contenu référé est une fiche lieu qui a un champ document ASU non vide
                    if (itData instanceof FicheLieu && Util.notEmpty(((FicheLieu)data).getDocumentsASU())) {
                        // on ajoute le groupe ASU aux groupes autorisés à voir le document
                        TreeSet<Group> tmpGrpSet = new TreeSet<>();
                        if (Util.notEmpty(itFileDoc.getAuthorizedGroupSet())) tmpGrpSet.addAll(itFileDoc.getAuthorizedGroupSet());
                        tmpGrpSet.add(groupAsu);
                        itFileDoc.setAuthorizedGroupSet(tmpGrpSet);
                    }
                }
            }
	    }
	
	}


}