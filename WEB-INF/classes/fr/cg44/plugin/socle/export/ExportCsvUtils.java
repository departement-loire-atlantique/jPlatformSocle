package fr.cg44.plugin.socle.export;

import java.io.File;
import java.io.PrintWriter;
import java.io.Writer;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Iterator;
import java.util.SortedSet;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.apache.log4j.Logger;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

import com.jalios.jcms.Channel;
import com.jalios.jcms.Content;
import com.jalios.jcms.Data;
import com.jalios.jcms.Member;
import com.jalios.jcms.Publication;
import com.jalios.jcms.QueryResultSet;
import com.jalios.jcms.TypeFieldEntry;
import com.jalios.jcms.WorkflowConstants;
import com.jalios.jcms.handler.QueryHandler;
import com.jalios.jcms.portlet.PortalElement;
import com.jalios.util.HtmlUtil;
import com.jalios.util.Util;

import fr.cg44.plugin.socle.SocleUtils;

public class ExportCsvUtils {
  
  private static final String SEPARATOR = ";";
  private static final char DOUBLE_QUOTE = '"';
  
  private static final Logger LOGGER = Logger.getLogger(ExportCsvUtils.class);
    
  /**
   * Renvoie le fichier XML associé à un type de contenu, si le fichier / type existe
   * @param type
   * @return
   */
  public static File getXmlFileForType(String type) {
    File xmlFile = new File(Channel.getChannel().getDataPath("/types/" + type + "/" + type + ".xml"));
    if (xmlFile.exists()) return xmlFile;
    return null;
  }
  
  /**
   * Renvoie des headers CSV à partir des champs déclarés dans un CSV, suivant une langue
   * @param typeName
   * @param userLang
   * @return
   */
  public static String getCsvHeaderFromXml(String typeName, String userLang) {
    if (Util.isEmpty(typeName) || Util.isEmpty(userLang)) return "";
    
    StringBuilder header = new StringBuilder();
    
    File itXml = getXmlFileForType(typeName);
    
    if (Util.isEmpty(itXml)) return null;
      
    // Récupérer les nodes 'field'
      
    NodeList nodeList = getNodeListFieldsFromXml(itXml);
    
    for (int nodeIndex = 0; nodeIndex < nodeList.getLength(); nodeIndex++) {
      Node node = nodeList.item(nodeIndex);
      header.append(getFormattedCsvValueWysiwyg(getXmlFieldLabel(node, userLang)) + SEPARATOR);
    }
    
    return header.toString();
  }
  
  public static String getCsvHeaderFromXml(String typeName) {
    return getCsvHeaderFromXml(typeName, Channel.getChannel().getLanguage());
  }
  
  /**
   * Renvoie le NodeList associé aux nodes "field" du XML d'un type
   * @param itXml
   * @return
   */
  public static NodeList getNodeListFieldsFromXml(File itXml) {
    
    if (Util.isEmpty(itXml) || !itXml.exists()) return null;
    
    try {

      DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
      
      DocumentBuilder db = dbf.newDocumentBuilder();
      
      Document doc = db.parse(itXml);
      
      doc.getDocumentElement().normalize();
      
      // Récupérer les nodes 'field'
      
      NodeList nodeList = doc.getElementsByTagName("field");
      
      return nodeList;
    
    } catch (Exception e) {
      LOGGER.warn("Exception sur getNodeListFieldsFromXml : " + e.getMessage());
      return null;
    }
  }
  
  /**
   * Renvoie le libellé d'un champ d'un type depuis un node XML
   * @param itNode
   * @return
   */
  public static String getXmlFieldLabel(Node itNode, String userLang) {
    if (!(itNode instanceof Element)) return "";
    
    Element itElement = (Element) itNode;
    
    NodeList labelNodeList = itElement.getElementsByTagName("label");
    
    for (int index = 0; index < labelNodeList.getLength(); index++) {
      Node itLabelNode = labelNodeList.item(index);
      if (itLabelNode.getAttributes().getNamedItem("xml:lang").getNodeValue().equals(userLang)) {
        return itLabelNode.getTextContent();
      }
    }
    
    return "";
  }
  
  /**
   * Renvoie une ligne CSV contenant les valeurs des champs d'une publication.
   * Dans le cas de ce process, toute donnée ayant un Contenu ou une Portlet affichera son nom
   * @param itContent
   * @param userLang
   * @param typeName
   * @return
   */
  public static String getXmlFieldValuesFromPublication(Publication itPub, String userLang, String typeName, Member itMember) {
    
    if (Util.isEmpty(itPub) || Util.isEmpty(userLang) || Util.isEmpty(typeName)) return "";

    File itXmlFile = getXmlFileForType(typeName);
    
    if (Util.isEmpty(itXmlFile)) return "";
    
    StringBuilder csvLine = new StringBuilder();
    
    NodeList fieldsNodeList = getNodeListFieldsFromXml(itXmlFile);
            
    for (int index = 0; index < fieldsNodeList.getLength(); index++) {
      
      Node itFieldNode = fieldsNodeList.item(index);
      csvLine.append(HtmlUtil.html2text(getXmlFieldValueFromPublication(itPub, userLang, itFieldNode, itMember)));
      csvLine.append(SEPARATOR);
    }
    
    return csvLine.toString();
  }
  
  /**
   * Renvoie la valeur d'un champ d'un contenu à partir de son nom technique dans un XML associé
   * @param itContent
   * @param userLang
   * @param itNode
   * @return
   */
  public static String getXmlFieldValueFromPublication(Publication itPub, String userLang, Node itNode, Member itMember) {
    
    if (Util.isEmpty(itPub) || Util.isEmpty(userLang) || Util.isEmpty(itNode)) return "";
        
    // Récupérer le nom technique
    String fieldName = itNode.getAttributes().getNamedItem("name").getNodeValue();
    
    // Récupérer le type de donnée du node
    String dataType = itNode.getAttributes().getNamedItem("type").getNodeValue();
    
    // Récupérer l'éditeur du node (pour un cas particulier)
    String editorType = itNode.getAttributes().getNamedItem("editor").getNodeValue();

    try {
      
    switch(editorType) {
    
      case "link":
        // Data -> Content ou PortalElement
        if (dataType.contains("[]")) {
          return listNameOfData( (Data[])itPub.getFieldValue(fieldName, userLang) );
        } else {
          return getNameOfData ( (Data)itPub.getFieldValue(fieldName, userLang) );
        }
        
      case "category":
        // Catégories
        return SocleUtils.formatCategories(itPub.getCategoryFieldValue(fieldName, itMember), " ## ");
        
      case "date":
        // Objet date
        SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
        return sdf.format(((Date)itPub.getFieldValue(fieldName, userLang)));
        
      case "boolean":
        // Booléen. Pas de multivalué :)
        return getBooleanLabelValue(itPub, fieldName, userLang, ((Boolean) itPub.getBooleanFieldValue(fieldName)));
        
      case "int":
        // Nombre entier
        return Integer.toString((int) itPub.getIntFieldValue(fieldName));
        
      case "double":
        // Utilisation d'un 'double'
        return Double.toString((double) itPub.getDoubleFieldValue(fieldName));
        
      case "duration":
        // Utilisation d'un float
        return Long.toString((long) itPub.getLongFieldValue(fieldName));
        
      default:
        // Tout ce qui peut être donné directement en String
        if (dataType.contains("[]")) {
          return formatStringArray((String[]) itPub.getFieldValue(fieldName, userLang));
        } else {
          return renderStringSafeForCsv((String)itPub.getFieldValue(fieldName, userLang));
        }
    }
    
    } catch (Exception e) {
      LOGGER.info("Anomalie sur getXmlFieldValueFromPublication (" + fieldName + ", " + dataType + ", " + editorType + ") -> " + e.getMessage());
    }
    
    return "";
  }
  
  /**
   * Renvoie le label localisée de la valeur d'un boolean pour un champ de contenu
   * @param itPub
   * @param userLang
   * @return
   */
  public static String getBooleanLabelValue(Publication itPub, String fieldName, String userLang, boolean value) {
    if (Util.isEmpty(itPub) || Util.isEmpty(fieldName) || Util.isEmpty(userLang)) return "";
    try {
      TypeFieldEntry[] entries = (TypeFieldEntry[]) itPub.getClass().getMethod("getTypeFieldEntries").invoke(itPub.getClass());
      for (int entryCounter = 0; entryCounter < entries.length; entryCounter++) {
        if (entries[entryCounter].getName().equals(fieldName)) {    
            return value ? entries[entryCounter].getOnLabel(userLang) : entries[entryCounter].getOffLabel(userLang);
        }
      }
    } catch (Exception e) {
      LOGGER.warn("Anomalie dans getBooleanLabelValue : " + e.getMessage());
      return "";
    }
    return "";
  }

  /**
   * Renvoie le nom d'une donnée "Data"
   * @param fieldValue
   * @return 
   */
  private static String getNameOfData(Data itData) {
    if (Util.isEmpty(itData)) return "";
    if (itData instanceof PortalElement) {
      return ((PortalElement)itData).getTitle();
    }
    return ((Content)itData).getTitle();
  }

  /**
   * Liste les noms d'un array de Data avec un séparateur
   * @param itData
   */
  private static String listNameOfData(Data[] itData) {
    if (Util.isEmpty(itData) || Util.isEmpty(itData[0])) return "";
    if (itData[0] instanceof PortalElement) {
      return SocleUtils.listNameOfPortalElements((PortalElement[])itData);
    }
    return SocleUtils.listNameOfContent((Content[])itData);
  }
  
  /**
   * Print un CSV pour l'export d'un type de contenu
   * @param type
   * @param userLang
   */
  public static void printCsvFileForPublicationType(String type, String userLang, Member itMember, Writer paramWriter) {
    PrintWriter localPrintWriter = new PrintWriter(paramWriter);
   
    StringBuilder csvContent = new StringBuilder();
    
    SortedSet<Publication> sortedPubs = ExportCsvUtils.getPublicationsOfType(type, itMember);
    
    // Header
    csvContent.append(getCommonPrefixCsvHeader());
    csvContent.append(getCsvHeaderFromXml(type));
    csvContent.append(getMetadataCsvHeader());
    // Print header
    localPrintWriter.println(csvContent);
        
    for (Iterator<Publication> iter = sortedPubs.iterator(); iter.hasNext();) {
      
      // Reset Csv Content pour la ligne
      csvContent = new StringBuilder();
      
      Publication itPub = iter.next();
      
      csvContent.append(getCommonPrefixCsvValues(itPub));
      
      csvContent.append(getXmlFieldValuesFromPublication(itPub, userLang, type, itMember));
      
      csvContent.append(ExportCsvUtils.getMetadataCsvPublication(itPub, type));
      
      localPrintWriter.println(csvContent);
    }
  }

  /**
   * Renvoie la valeur CSV des noms de colonnes pour les éléments communs en préfixe.
   * @return
   */
  public static String getCommonPrefixCsvHeader(){
    StringBuilder header = new StringBuilder();
    
    header.append(DOUBLE_QUOTE + "ID" + DOUBLE_QUOTE + SEPARATOR);
    header.append(DOUBLE_QUOTE + "Title" + DOUBLE_QUOTE + SEPARATOR);
    
    return header.toString();
  }
  
  /**
   * Renvoie les valeurs CSV pour les éléments communs en préfixe
   * @param itPub
   * @return
   */
  public static String getCommonPrefixCsvValues(Publication itPub) {
    StringBuilder prefix = new StringBuilder();
    
    prefix.append(getFormattedCsvValue(itPub.getId(), true));
    prefix.append(getFormattedCsvValue(itPub.getTitle(), true));
    
    return prefix.toString();
  }
  
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
   * Formatte un array de String en une valeur unique
   * @param strArray
   * @return
   */
  public static String formatStringArray(String[] strArray) {
    if (Util.isEmpty(strArray)) return "";
    
    StringBuilder concatenatedStr = new StringBuilder();
    
    String strSeparator = " ## ";
    
    for (int counter = 0; counter < strArray.length; counter++) {
      if (Util.notEmpty(strArray[counter])) concatenatedStr.append(renderStringSafeForCsv(strArray[counter]));
      
      if (counter+1 < strArray.length) concatenatedStr.append(strSeparator);
    }
    
    return concatenatedStr.toString();
  }
  
  /**
   * Concatène les éléments d'un tableau de String avec un séparateur
   * @param strArray
   * @param separator
   * @return
   */
  public static String getFormattedCsvValueStringArray(String[] strArray, boolean separator) {
    if (Util.isEmpty(strArray)) return getFormattedCsvValue("", separator);
    
    return getFormattedCsvValue(formatStringArray(strArray), separator);
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
    
    return getFormattedCsvValueWysiwyg(formatStringArray(strArray), separator);
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
  
  /**
   * Rend un String safe pour l'import dans un CSV en remplaçant les caractères sensibles par des caractères différents
   * @param originalTxt
   * @return
   */
  public static String renderStringSafeForCsv(String originalTxt) {
    return originalTxt.replaceAll(SEPARATOR, ":").replaceAll("\"", "'");
  }
  
}