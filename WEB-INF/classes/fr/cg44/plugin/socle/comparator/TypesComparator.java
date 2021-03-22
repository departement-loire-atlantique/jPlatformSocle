package fr.cg44.plugin.socle.comparator;

import com.jalios.jcms.Channel;
import com.jalios.jcms.FileDocument;
import com.jalios.jcms.Publication;
import com.jalios.jcms.comparator.BasicComparator;

import generated.AccueilAnnuaireAgenda;
import generated.Dossier;
import generated.ElectedMember;
import generated.FicheActu;
import generated.FicheAide;
import generated.FicheArticle;
import generated.FicheLieu;
import generated.PageCarrefour;

/**
 * RS-1313 Comparateur sur les types de publications.
 */
public class TypesComparator extends BasicComparator<Publication>{

  Channel channel = Channel.getChannel();
  
  public TypesComparator() {  
  }

  public int compare(Publication pub_1, Publication pub_2) {
	  
    if (pub_1 == null) {
      return (pub_2 == null) ? 0 : 1;
    }
    if (pub_2 == null) {
      return -1;
    }
    
    Class<Publication>[] clazz = new Class[] {AccueilAnnuaireAgenda.class, PageCarrefour.class, FicheAide.class, FicheArticle.class, Dossier.class, FicheActu.class, FicheLieu.class, ElectedMember.class, FileDocument.class};
    
    for(int i=0 ; i < clazz.length ; i++) {
	    if(clazz[i].isAssignableFrom(pub_1.getClass()) && !clazz[i].isAssignableFrom(pub_2.getClass())) {
	    	return -1;
	    }else if(!clazz[i].isAssignableFrom(pub_1.getClass()) && clazz[i].isAssignableFrom(pub_2.getClass())) {
	    	return 1;
	    }
    }
       
    return super.compare(pub_1, pub_2);
  }

}
