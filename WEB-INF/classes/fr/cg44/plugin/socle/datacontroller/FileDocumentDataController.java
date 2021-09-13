package fr.cg44.plugin.socle.datacontroller;

import java.util.Map;

import com.jalios.jcms.BasicDataController;
import com.jalios.jcms.Category;
import com.jalios.jcms.Channel;
import com.jalios.jcms.Data;
import com.jalios.jcms.FileDocument;
import com.jalios.jcms.Member;
import com.jalios.jcms.plugin.PluginComponent;
import com.jalios.util.Util;

public class FileDocumentDataController extends BasicDataController implements PluginComponent {

	private static Channel channel = Channel.getChannel();

	private static final Category classementCategory = channel.getCategory(channel.getProperty("jcmsplugin.socle.category.classementfiledoc"));

	@Override
	/* 
	 * Ajoute une catégorie de classement sur les filedocuments d'extension '.txt' (RS-1199)
	 * */
	public void beforeWrite(Data data, int op, Member mbr, Map context) {
	    
	    if (Util.notEmpty(classementCategory)) {
    	    FileDocument itFileDoc = (FileDocument) data;

    	    if (itFileDoc.getFile().getName().endsWith(".txt")) {
    	        itFileDoc.addCategory(classementCategory);
    	    }
    	    
    	    itFileDoc.addCategory(classementCategory);
	    }
	
	}


}