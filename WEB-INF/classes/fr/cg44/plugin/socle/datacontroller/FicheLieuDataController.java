package fr.cg44.plugin.socle.datacontroller;

import java.util.Map;
import java.util.TreeSet;

import com.jalios.jcms.BasicDataController;
import com.jalios.jcms.Channel;
import com.jalios.jcms.Data;
import com.jalios.jcms.FileDocument;
import com.jalios.jcms.Group;
import com.jalios.jcms.Member;
import com.jalios.jcms.plugin.PluginComponent;
import com.jalios.util.Util;

import generated.FicheLieu;

public class FicheLieuDataController extends BasicDataController implements PluginComponent {
	
    // Si le champ docs ASU n'est pas vide, ajouter pour chaque doc un groupe précis dans les droits d'accès 
    public void afterWrite(Data data, int op, Member mbr, Map context) {
        if (op != OP_CREATE && op != OP_UPDATE) {
          return;
        }
        
        FicheLieu itFiche = (FicheLieu) data;
        
        if (Util.notEmpty(itFiche.getDocumentsASU())) {
            Group groupAsu = Channel.getChannel().getGroup("$jcmsplugin.socle.fichelieu.groupe.asu");
            if (Util.notEmpty(groupAsu)) {
                for (FileDocument itDoc : itFiche.getDocumentsASU()) {
                    if (Util.isEmpty(itDoc.getAuthorizedGroupSet()) || itDoc.getAuthorizedGroupSet().contains(groupAsu)) {
                        FileDocument docClone = (FileDocument) itDoc.getUpdateInstance();
                        TreeSet<Group> tmpGrpSet = new TreeSet<>();
                        if (Util.notEmpty(docClone.getAuthorizedGroupSet())) tmpGrpSet.addAll(docClone.getAuthorizedGroupSet());
                        tmpGrpSet.add(groupAsu);
                        docClone.setAuthorizedGroupSet(tmpGrpSet);
                        docClone.checkAndPerformUpdate(mbr);
                    }
                }
            }
        }
    }
}