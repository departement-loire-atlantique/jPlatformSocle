package fr.cg44.plugin.socle.export;

import java.text.SimpleDateFormat;
import java.util.SortedSet;

import com.jalios.jcms.Member;
import com.jalios.jcms.Publication;
import com.jalios.jcms.QueryResultSet;
import com.jalios.jcms.WorkflowConstants;
import com.jalios.jcms.handler.QueryHandler;
import com.jalios.util.Util;

import fr.cg44.plugin.socle.SocleUtils;

public class ExportCsvUtils {
  
  private static final String SEPARATOR = ";";
  private static final char DOUBLE_QUOTE = '"';
  
  /**
   * Renvoie les headers metadatas communes
   * @return
   */
  public static String getMetadataCsvHeader(){    
    StringBuilder header = new StringBuilder();
    
    header.append(DOUBLE_QUOTE + "Version" + DOUBLE_QUOTE + SEPARATOR);
    header.append(DOUBLE_QUOTE + "Auteur" + DOUBLE_QUOTE + SEPARATOR);
    header.append(DOUBLE_QUOTE + "ID auteur" + DOUBLE_QUOTE + SEPARATOR);
    header.append(DOUBLE_QUOTE + "ID catégories" + DOUBLE_QUOTE + SEPARATOR);
    header.append(DOUBLE_QUOTE + "Date de création" + DOUBLE_QUOTE + SEPARATOR);
    header.append(DOUBLE_QUOTE + "Date de publication" + DOUBLE_QUOTE + SEPARATOR);
    header.append(DOUBLE_QUOTE + "Date de modification" + DOUBLE_QUOTE + SEPARATOR);
    
    return header.toString();
  }
  
  /**
   * Renvoie les données CSV des métadonnées d'une publication
   * @param itPub
   * @return
   */
  public static String getMetadataCsvPublication(Publication itPub) {
    
    SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy hh:mm");
    
    StringBuilder chaine = new StringBuilder();
    
    chaine.append(itPub.getVersionString());
    chaine.append(itPub.getAuthor().getFullName());
    chaine.append(itPub.getAuthor().getId());
    chaine.append(SocleUtils.listCategoriesId(itPub.getCategorySet()));
    chaine.append(sdf.format(itPub.getCdate()));
    chaine.append(Util.isEmpty(itPub.getPdate()) ? "" : sdf.format(itPub.getPdate()));
    chaine.append(Util.isEmpty(itPub.getMdate()) ? "" : sdf.format(itPub.getMdate()));
    
    return chaine.toString();
    
  }
  
  /**
   * Permet d'échapper les double quotes, à utiliser pour les champs au contenu textuel
   * @param value
   * @return
   */
  public static String escapeDoubleQuote(String value){
    if(Util.notEmpty(value)){
      return value.replace("\"", "\"\"");
    }
    
    return "";
  }
  
  /**
   * Renvoie un SortedSet des contenus d'un type, visibles par un membre, et qui sont publiés
   * @param type
   * @param itMember
   * @return
   */
  public static SortedSet<Publication> getPublicationsOfType(String type, Member itMember) {
    QueryHandler qh = new QueryHandler();
    qh.setTypes(type);
    qh.setLoggedMember(itMember);
    qh.setPstatus(Integer.toString(WorkflowConstants.PUBLISHED_PSTATUS));
    
    QueryResultSet rs = qh.getResultSet();
    
    return rs.getAsSortedSet();
  }
  
  /**
   * Renvoie une valeur CSV d'une donnée, avec séparateur ou non
   * @param value
   * @return
   */
  public static String getFormattedCsvValue(String value, boolean separator) {
    StringBuilder csvValue = new StringBuilder();
    
    if (Util.isEmpty(value)) {
      csvValue.append(DOUBLE_QUOTE + DOUBLE_QUOTE);
    } else {
      csvValue.append(DOUBLE_QUOTE + escapeDoubleQuote(value) + DOUBLE_QUOTE);
    }
    if (separator) csvValue.append(SEPARATOR);
    
    return csvValue.toString();
  }
  
  public static String getFormattedCsvValue(String value) {
    return getFormattedCsvValue(value, false);
  }
  
  /**
   * Concatène les éléments d'un tableau de String avec un séparateur
   * @param strArray
   * @param separator
   * @return
   */
  public static String getFormattedCsvValueStringArray(String[] strArray, boolean separator) {
    if (Util.isEmpty(strArray)) return getFormattedCsvValue("", separator);
    
    StringBuilder concatenatedStr = new StringBuilder();
    
    String strSeparator = " / ";
    
    for (int counter = 0; counter < strArray.length; counter++) {
      if (Util.notEmpty(strArray[counter])) concatenatedStr.append(strArray[counter]);
      
      if (counter+1 < strArray.length) concatenatedStr.append(strSeparator);
    }
    
    return getFormattedCsvValue(concatenatedStr.toString(), separator);
  }
  
  public static String getFormattedCsvValueStringArray(String[] strArray) {
    return getFormattedCsvValueStringArray(strArray, false);
  }
  
}