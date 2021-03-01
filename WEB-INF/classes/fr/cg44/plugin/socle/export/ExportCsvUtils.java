package fr.cg44.plugin.socle.export;

import java.text.SimpleDateFormat;
import java.util.SortedSet;

import com.jalios.jcms.Member;
import com.jalios.jcms.Publication;
import com.jalios.jcms.QueryResultSet;
import com.jalios.jcms.WorkflowConstants;
import com.jalios.jcms.handler.QueryHandler;
import com.jalios.util.HtmlUtil;
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
    header.append(DOUBLE_QUOTE + "Latitude" + DOUBLE_QUOTE + SEPARATOR);
    header.append(DOUBLE_QUOTE + "Longitude" + DOUBLE_QUOTE + SEPARATOR);
    
    return header.toString();
  }
  
  /**
   * Renvoie les données CSV des métadonnées d'une publication
   * @param itPub
   * @return
   */
  public static String getMetadataCsvPublication(Publication itPub, String itType) {
    
    SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy hh:mm");
    
    StringBuilder chaine = new StringBuilder();
    
    String extraDataLat = "extra." + itType + ".plugin.tools.geolocation.latitude";
    String extraDataLon = "extra." + itType + ".plugin.tools.geolocation.longitude";
    
    chaine.append(getFormattedCsvValue(itPub.getVersionString(), true));
    chaine.append(getFormattedCsvValue(itPub.getAuthor().getFullName(), true));
    chaine.append(getFormattedCsvValue(itPub.getAuthor().getId(), true));
    chaine.append(getFormattedCsvValue(SocleUtils.listCategoriesId(itPub.getCategorySet()), true));
    chaine.append(getFormattedCsvValue(sdf.format(itPub.getCdate()), true));
    chaine.append(getFormattedCsvValue(Util.isEmpty(itPub.getPdate()) ? "" : sdf.format(itPub.getPdate()), true));
    chaine.append(getFormattedCsvValue(Util.isEmpty(itPub.getMdate()) ? "" : sdf.format(itPub.getMdate()), true));
    chaine.append(getFormattedCsvValue(Util.isEmpty(itPub.getExtraData(extraDataLat)) ? "" : itPub.getExtraData(extraDataLat), true));
    chaine.append(getFormattedCsvValue(Util.isEmpty(itPub.getExtraData(extraDataLon)) ? "" : itPub.getExtraData(extraDataLon), true));
    
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
      csvValue.append(DOUBLE_QUOTE + " " + DOUBLE_QUOTE);
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
  
  /**
   * Concatène les éléments d'un tableau de String WYSIWYG, sans HTML, avec un séparateur
   * @return
   */
  public static String getFormattedCsvValueStringArrayWysiwyg(String[] strArray, boolean separator) {
    if (Util.isEmpty(strArray)) return getFormattedCsvValue("", separator);
    
    StringBuilder concatenatedStr = new StringBuilder();
    
    String strSeparator = " / ";
    
    for (int counter = 0; counter < strArray.length; counter++) {
      if (Util.notEmpty(strArray[counter])) concatenatedStr.append(strArray[counter]);
      
      if (counter+1 < strArray.length) concatenatedStr.append(strSeparator);
    }
    
    return getFormattedCsvValueWysiwyg(concatenatedStr.toString(), separator);
  }
  
  public static String getFormattedCsvValueStringArrayWysiwyg(String[] strArray) {
    return getFormattedCsvValueStringArrayWysiwyg(strArray, false);
  }
  
  /**
   * Renvoie une valeur CSV pour les contenus WYSIWYG afin d'en retirer le HTML
   * @param wysiwyg
   * @param separator
   * @return
   */
  public static String getFormattedCsvValueWysiwyg(String wysiwyg, boolean separator) {
    if (Util.isEmpty(wysiwyg)) return getFormattedCsvValue("", separator);
    return getFormattedCsvValue(HtmlUtil.html2text(wysiwyg), separator);
  }
  
  public static String getFormattedCsvValueWysiwyg(String wysiwyg) {
    return getFormattedCsvValueWysiwyg(wysiwyg, false);
  }
  
}