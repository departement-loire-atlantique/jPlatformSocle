package fr.cg44.plugin.socle.comparator;


import java.util.Arrays;
import java.util.Set;
import java.util.stream.Collectors;

import com.jalios.jcms.Category;
import com.jalios.jcms.Channel;
import com.jalios.jcms.Publication;
import com.jalios.jcms.comparator.BasicComparator;
import com.jalios.util.Util;

/**
 * Comparateur entre une catégorie principale et une catégorie secondaire
 * donne la priorioté aux publications catégorisée dans la catégorie principale
 *
 */
public class CategoryComparator extends BasicComparator<Publication>{

  Channel channel = Channel.getChannel();
  
  String categoryPrincipal;
  String categorySecondaire;


  public CategoryComparator(String cat1, String cat2) {
	  categoryPrincipal = cat1;
	  categorySecondaire = cat2;
  }

  public int compare(Publication pub_1, Publication pub_2) {

    if (pub_1 == null) {
      return (pub_2 == null) ? 0 : -1;
    }
    if (pub_2 == null) {
      return 1;
    }

    
    if(Util.notEmpty(categoryPrincipal) && Util.notEmpty(categorySecondaire)) {
    	
    	Set<String> pub1CatSet = Arrays.stream(pub_1.getCategories()).map(Category::getId).collect(Collectors.toSet());
    	Set<String> pub2CatSet = Arrays.stream(pub_2.getCategories()).map(Category::getId).collect(Collectors.toSet()); ;
    	
    	if(pub1CatSet.contains(categoryPrincipal) && !pub2CatSet.contains(categoryPrincipal)) {
    		return -1;
    	} else if(pub2CatSet.contains(categoryPrincipal) && !pub1CatSet.contains(categoryPrincipal)) {
    		return 1;
    	}
    }
    
    return super.compare(pub_1, pub_2);
  }

}
