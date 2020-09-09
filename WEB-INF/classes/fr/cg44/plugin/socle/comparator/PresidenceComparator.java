package fr.cg44.plugin.socle.comparator;

import java.util.Set;
import java.util.TreeSet;

import com.jalios.jcms.Category;
import com.jalios.jcms.Channel;
import com.jalios.jcms.comparator.BasicComparator;
import com.jalios.util.Util;

import generated.ElectedMember;

/**
 * RS-1371 Comparateur sur les élus. 
 * En premier le Président du département, puis ordre de vice-présidence, cf l'ordre explicite de la branche c_5316
 */
public class PresidenceComparator extends BasicComparator<ElectedMember>{

  Channel channel = Channel.getChannel();
  Category presidenceCat = channel.getCategory("$jcmsplugin.socle.elu.president");
  Category vicePresidenceCat = channel.getCategory("$jcmsplugin.socle.elu.vicepresident");
  
  public PresidenceComparator() {  
  }

  public int compare(ElectedMember elu_1, ElectedMember elu_2) {
    if (elu_1 == null) {
      return (elu_1 == null) ? 0 : -1;
    }
    if (elu_2 == null) {
      return 1;
    }
    
    // Présidence
    if(elu_1.containsCategory(presidenceCat)) {
    	return -1;
    } else if(elu_2.containsCategory(presidenceCat)) {
    	return 1;
    }
       
   
    // Vice présidence / Conseiller départemental
    if(Util.notEmpty(elu_1.getDescendantCategorySet(vicePresidenceCat, true)) && Util.isEmpty(elu_2.getDescendantCategorySet(vicePresidenceCat, true))) {
      return -1;
    } else if(Util.notEmpty(elu_2.getDescendantCategorySet(vicePresidenceCat, true)) && Util.isEmpty(elu_1.getDescendantCategorySet(vicePresidenceCat, true))) {
      return 1;
    }
    
    // Ordre Enfant Vice présidence
    if(Util.notEmpty(elu_1.getDescendantCategorySet(vicePresidenceCat)) || Util.notEmpty(elu_2.getDescendantCategorySet(vicePresidenceCat))) {
      Set<Category> vpCatSet = new TreeSet<Category>(Category.getDeepOrderComparator());
      vpCatSet.addAll(vicePresidenceCat.getDescendantSet());
      for(Category itCat : vpCatSet) {
        if(elu_1.containsCategory(itCat) && !elu_2.containsCategory(itCat)) {
          return -1;
        }else if(elu_2.containsCategory(itCat) && !elu_1.containsCategory(itCat)){
          return 1;
        }
      }
    }
    
    return elu_1.getNom().compareTo(elu_2.getNom());
  }

}
