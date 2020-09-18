package fr.cg44.plugin.socle.comparator;

import java.util.Set;

import org.apache.log4j.Logger;

import com.jalios.jcms.Category;
import com.jalios.jcms.Channel;
import com.jalios.jcms.JcmsUtil;
import com.jalios.jcms.Publication;
import com.jalios.jcms.comparator.BasicComparator;
import com.jalios.util.Util;

import fr.cg44.plugin.socle.SocleUtils;
import generated.City;


public class ServicesDepartementComparator extends BasicComparator<Publication>{

  private static final Logger LOGGER = Logger.getLogger(ServicesDepartementComparator.class);
  
  Channel channel = Channel.getChannel();

  private City commune;

  public ServicesDepartementComparator() {
    String communeInsse = channel.getCurrentJcmsContext().getRequest().getParameter("commune");
    if(Util.notEmpty(communeInsse)) {
      this.commune = SocleUtils.getCommuneFromCode(communeInsse) ;
    }
  }

  public int compare(Publication pub_1, Publication pub_2) {


    if (pub_1 == null) {
      return (pub_2 == null) ? 0 : -1;
    }
    if (pub_2 == null) {
      return 1;
    }

    // Comparaison sur service du département
    int serviceComparator = comparatorService(pub_1, pub_2);
    if(serviceComparator != 0) {
      return serviceComparator;
    }
    
    // Commune de la publication 1
    City commune_pub_1 = null;
    try {
      commune_pub_1 = (City) pub_1.getFieldValue("commune");
    } catch (NoSuchFieldException e) {      
      try {
        City[] communes_pub_1 = (City[]) pub_1.getFieldValue("communes");
        commune_pub_1 = Util.getFirst(communes_pub_1);
      } catch (NoSuchFieldException e1) {
        LOGGER.trace("Le contenu : " + pub_1 + " n'a pas de référence à commune à indexer", e);
      }           
    }
    
    // Commune de la publication 2
    City commune_pub_2 = null;
    try {
      commune_pub_2 = (City) pub_2.getFieldValue("commune");
    } catch (NoSuchFieldException e) {
      try {
        City[] communes_pub_2 = (City[]) pub_2.getFieldValue("communes");
        commune_pub_2 = Util.getFirst(communes_pub_2);
      } catch (NoSuchFieldException e1) {
        LOGGER.trace("Le contenu : " + pub_2 + " n'a pas de référence à commune à indexer", e);
      }     
    }
    
    // Comparaison sur la commune de recherche
    int cityComparator = comparatorCity(commune_pub_1, commune_pub_2);
    if(cityComparator != 0) {
      return cityComparator;
    }
    
    // Comparaison sur les commune de la délégation
    int communeDelegationComparator = comparatorCommuneDelegation(commune_pub_1, commune_pub_2);
    if(communeDelegationComparator != 0) {
      return communeDelegationComparator;
    }
    
    // Si une publication n'a pas de commune n'est pas prioritaire sur une publication avec commune
    if(commune_pub_1 != null && commune_pub_2 == null) {
      return -1;
    }else if(commune_pub_1 == null && commune_pub_2 != null) {
      return 1;
    }
    
    // Ordre alphabétique des communes
    if(commune_pub_1 != null && commune_pub_2 != null && commune_pub_1.compareTo(commune_pub_2) != 0) {
      return commune_pub_1.getTitle().compareTo(commune_pub_2.getTitle());
    }

    return super.compare(pub_1, pub_2);
  }


  /**
   * Compare avec la catégorie services du département
   * @param pub_1
   * @param pub_2
   * @return
   */
  private int comparatorService(Publication pub_1, Publication pub_2) {
    Category serviceDuDepartementCat = channel.getCategory("$jcmsplugin.socle.fichelieu.serviceDepartement.root");    
    if(pub_1.containsCategory(serviceDuDepartementCat) && !pub_2.containsCategory(serviceDuDepartementCat)) {
      return -1;
    }else if(!pub_1.containsCategory(serviceDuDepartementCat) && pub_2.containsCategory(serviceDuDepartementCat)) {
      return 1;
    }
    return 0;
  }


  /**
   * Compare à la commune de recherche
   * @param pub_1
   * @param pub_2
   * @return
   */
  private int comparatorCity(City commune_pub_1, City commune_pub_2) {    
    if(Util.isEmpty(commune)) {
      return 0;
    }
    if(JcmsUtil.isSameId(commune, commune_pub_1) && !JcmsUtil.isSameId(commune, commune_pub_2)) {
      return -1;
    }else if(!JcmsUtil.isSameId(commune, commune_pub_1) && JcmsUtil.isSameId(commune, commune_pub_2)) {
      return 1;
    }
    return 0;
  }
  
  
  /**
   * Compare au commune de la même délégation
   * @param pub_1
   * @param pub_2
   * @return
   */
  private int comparatorCommuneDelegation(City commune_pub_1, City commune_pub_2) {

    if(Util.isEmpty(commune) || Util.isEmpty(commune.getDelegation())) {
      return 0;
    } 
    
    Set<City> cityList = channel.getLinkIndexedDataSet(commune.getDelegation(), City.class, "delegation");
    
    if((commune_pub_1 != null && cityList.contains(commune_pub_1)) && (commune_pub_2 == null || !cityList.contains(commune_pub_2))) {
      return -1;
    }else if((commune_pub_1 == null || !cityList.contains(commune_pub_1)) && (commune_pub_2 != null && cityList.contains(commune_pub_2))) {
      return 1;
    }
    return 0;
  }


}
