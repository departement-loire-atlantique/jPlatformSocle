package fr.cg44.plugin.socle.queryfilter;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

import static com.jalios.jcms.Channel.getChannel;
import com.jalios.jcms.Category;
import com.jalios.jcms.JcmsUtil;
import com.jalios.jcms.handler.QueryHandler;
import com.jalios.util.Util;

/**
 * Classe utilitaire pour la recherche à facettes sur les catégories
 * La facette catégorie ne possède pas de query filter pour ses filtres,
 */
public class CategoryFacetUtil {

 
  /**
   * créé autant de requête de recherche que de branches de catégories
   * @param qh
   * @param cidBranches
   * @param cids
   * @return
   */
  public static QueryHandler[] getFacetCategoryQuery(QueryHandler qh, String[] cidBranches, String[] cids, Boolean isCatModNivUnion) {
    // Création d'autant de query qu'il y a de branche de catégories dans la recherche à facettes plus deux
    QueryHandler[] queries = new QueryHandler[cidBranches.length];  
    // Récupère la liste cids de la query
    List<String> cidsParamList = Util.notEmpty(cids) ? Arrays.asList(cids) : new ArrayList<String>();   
    List<Category> cidsParamCatList = JcmsUtil.idCollectionToDataList(cidsParamList, Category.class);
    // Itération sur chacune des branches de la recherche.
    // Chaque branche à sa propre query et cette query ne doit avoir que les cids enfants de sa branche
    for(int i = 0 ; i < cidBranches.length ; i++){

      // Récupère la query de la recherche pour modifier son paramètre cids
      QueryHandler itQh = new QueryHandler(qh);  
      itQh.setLoggedMember(getChannel().getCurrentLoggedMember());
      itQh.setCatMode(isCatModNivUnion ? "or" : "and");
      
      // Si un enfant d'une catégorie est sélectionné alors
      // la catégorie parente est retirée des cids            
//      List<Category> cidsParamParentCatList = cidsParamCatList.stream().map(Category::getParent).collect(Collectors.toList());
      
      // Tous les asscendants d'une catégorie séléctionné sont retirés
      List<Category> cidsParamParentCatList = new ArrayList<Category>();
      for(Category itCat : cidsParamCatList) {
        cidsParamParentCatList.addAll(itCat.getAncestorList());
      }           
      List<String> cidsFilterCatIdList = cidsParamCatList.stream().filter(e -> !cidsParamParentCatList.contains(e) ).map(Category::getId).collect(Collectors.toList());

      
      // Récupère les catégories enfants de cette branche de catégorie (permettra de filtrer seulement sur les cids de cette branche)
      String itCidBranche = cidBranches[i];
      Category itCatBranche = getChannel().getCategory(itCidBranche);     
      Set<Category> itCatDescendantBrancheSet = itCatBranche.getDescendantSet();          
      List<String> itCatDescendantBrancheIdSet = JcmsUtil.dataCollectionToIdList(itCatDescendantBrancheSet);  

      // Ne retient que les cids de la branche courante sans les parents d'une catégorie déjà sélectionnée            
      itCatDescendantBrancheIdSet.retainAll(cidsFilterCatIdList);  
      // Si aucun cids de branche de retenu alors garde les cids par défaut de la recherche à facettes
      if(Util.notEmpty(itCatDescendantBrancheIdSet)) {
        itQh.setCids(itCatDescendantBrancheIdSet.toArray(new String[itCatDescendantBrancheIdSet.size()]) ); 
      }
      // La query est ajoutée au tableau des query pour être éxécutée
      queries[i] =  itQh;
    }
    return queries;
  }
  

}
