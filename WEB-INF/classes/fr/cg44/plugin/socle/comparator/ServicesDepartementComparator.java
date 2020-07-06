package fr.cg44.plugin.socle.comparator;

import java.util.List;
import java.util.Set;

import com.jalios.jcms.Channel;
import com.jalios.jcms.JcmsUtil;
import com.jalios.jcms.Member;
import com.jalios.jcms.comparator.BasicComparator;
import com.jalios.util.Util;

import fr.cg44.plugin.socle.SocleUtils;
import generated.City;
import generated.FicheLieu;

public class ServicesDepartementComparator extends BasicComparator<FicheLieu>{

  Channel channel = Channel.getChannel();

  private City commune;

  public ServicesDepartementComparator() {
    String communeInsse = channel.getCurrentJcmsContext().getRequest().getParameter("commune");
    if(Util.notEmpty(communeInsse)) {
      this.commune = SocleUtils.getCommuneFromCode(communeInsse) ;
    }
  }

  public int compare(FicheLieu fiche_1, FicheLieu fiche_2) {


    if (fiche_1 == null) {
      return (fiche_2 == null) ? 0 : -1;
    }
    if (fiche_2 == null) {
      return 1;
    }

    // Comparaison sur service du département
    int serviceComparator = comparatorService(fiche_1, fiche_2);
    if(serviceComparator != 0) {
      return serviceComparator;
    }

    // Comparaison sur la commune de recherche
    int cityComparator = comparatorCity(fiche_1, fiche_2);
    if(cityComparator != 0) {
      return cityComparator;
    }
    
    // Comparaison sur les commune de la délégation
    int communeDelegationComparator = comparatorCommuneDelegation(fiche_1, fiche_2);
    if(communeDelegationComparator != 0) {
      return communeDelegationComparator;
    }

    return super.compare(fiche_1, fiche_2);
  }


  /**
   * Compare avec la catégorie services du département
   * @param fiche_1
   * @param fiche_2
   * @return
   */
  private int comparatorService(FicheLieu fiche_1, FicheLieu fiche_2) {
    Member loggedMember = channel.getCurrentLoggedMember();
    if(Util.notEmpty(fiche_1.getServiceDuDepartement(loggedMember)) && Util.isEmpty(fiche_2.getServiceDuDepartement(loggedMember))) {
      return -1;
    }else if(Util.notEmpty(fiche_2.getServiceDuDepartement(loggedMember)) && Util.isEmpty(fiche_1.getServiceDuDepartement(loggedMember))) {
      return 1;
    }
    return 0;
  }


  /**
   * Compare à la commune de recherche
   * @param fiche_1
   * @param fiche_2
   * @return
   */
  private int comparatorCity(FicheLieu fiche_1, FicheLieu fiche_2) {
    City commune_fiche_1 = fiche_1.getCommune();
    City commune_fiche_2 = fiche_2.getCommune();
    if(Util.isEmpty(commune)) {
      return 0;
    }
    if(JcmsUtil.isSameId(commune, commune_fiche_1) && !JcmsUtil.isSameId(commune, commune_fiche_2)) {
      return -1;
    }else if(!JcmsUtil.isSameId(commune, commune_fiche_1) && JcmsUtil.isSameId(commune, commune_fiche_2)) {
      return 1;
    }
    return 0;
  }
  
  
  /**
   * Compare au commune de la même délégation
   * @param fiche_1
   * @param fiche_2
   * @return
   */
  private int comparatorCommuneDelegation(FicheLieu fiche_1, FicheLieu fiche_2) {
    City commune_fiche_1 = fiche_1.getCommune();
    City commune_fiche_2 = fiche_2.getCommune();
    if(Util.isEmpty(commune) || Util.isEmpty(commune.getDelegation())) {
      return 0;
    } 
    
    Set<City> cityList = channel.getLinkIndexedDataSet(commune.getDelegation(), City.class, "delegation");
    
    if(cityList.contains(commune_fiche_1) && !cityList.contains(commune_fiche_2)) {
      return -1;
    }else if(!cityList.contains(commune_fiche_1) && cityList.contains(commune_fiche_2)) {
      return 1;
    }
    return 0;
  }


}
