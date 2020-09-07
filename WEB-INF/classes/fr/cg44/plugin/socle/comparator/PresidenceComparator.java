package fr.cg44.plugin.socle.comparator;

import com.jalios.jcms.Category;
import com.jalios.jcms.Channel;
import com.jalios.jcms.comparator.BasicComparator;

import generated.ElectedMember;

/**
 * RS-1371 Comparateur sur les élus. 
 * En premier le Président du département, puis ordre de vice-présidence, cf l'ordre explicite de la branche c_5316
 */
public class PresidenceComparator extends BasicComparator<ElectedMember>{

  Channel channel = Channel.getChannel();
  Category presidence = channel.getCategory("$jcmsplugin.socle.elu.president");
  
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
    if(elu_1.getFunctions(channel.getDefaultAdmin()).contains(presidence)) {
    	return -1;
    } else if(elu_2.getFunctions(channel.getDefaultAdmin()).contains(presidence)) {
    	return 1;
    }
    
    // Vise présidence
    
    
    return super.compare(elu_1, elu_2);
  }

}
