package fr.cg44.plugin.socle.reprise;

import java.io.PrintWriter;
import java.io.Writer;
import java.util.Iterator;

import org.apache.commons.lang.StringUtils;

import com.jalios.jcms.Category;
import com.jalios.jcms.Member;
import com.jalios.jcms.Publication;
import com.jalios.jcms.QueryResultSet;
import com.jalios.jcms.handler.QueryHandler;
import com.jalios.util.HtmlUtil;
import com.jalios.util.Util;

import generated.FicheArticle;

public class RepriseFicheArticleUtil {
  public final static String separator = ";";
  public final static String newLine = "\n";

  /**
   * Détermine si l'id correspond à l'id source d'une fiche article existante
   * @param oldId
   * @return la fiche pré-existante ou null si absente
   */
  public static FicheArticle getNewFiche(String oldId) {
    QueryHandler qh = new QueryHandler();
      qh.setExactType(true);
      qh.setTypes(FicheArticle.class.getSimpleName());
      QueryResultSet result = qh.getResultSet();
      
      for(Publication itPub : result) {  
        FicheArticle itFiche = (FicheArticle) (itPub);
        if(oldId.equals(itFiche.getIdAncienContenu())) {
          return itFiche;
        }
      }    
      return null;
  }
  
  /**
   * write the CSV export of all FicheArticle of the site
   * @param out
   * @param loggedMember
   */
  public static void exportNew(Writer out, Member loggedMember) {
    // get all fiche article
    QueryHandler qh = new QueryHandler();
    qh.setExactType(true);
    qh.setTypes(FicheArticle.class.getSimpleName());
    QueryResultSet result = qh.getResultSet();
    
    if (Util.isEmpty(result)) return;

    StringBuffer csvHeader = writeHeaderCSV();
    StringBuffer csvData = writeBodyCSV(loggedMember, result);
    
    PrintWriter printWriter = new PrintWriter(out);
    printWriter.write(csvHeader.toString());
    printWriter.write(csvData.toString());
  }

  /**
   * Data part of the CSV export
   * @param loggedMember
   * @param result
   * @return
   */
  private static StringBuffer writeBodyCSV(Member loggedMember, QueryResultSet result) {
    StringBuffer csvData = new StringBuffer();
    for (Publication itPub : result) {
      if (!itPub.isInVisibleState()) continue;
      writePubLine((FicheArticle) itPub, csvData, loggedMember);
    }
    return csvData;
  }
  
  /**
   * Write the CSv line corresponding to an article
   * @param itArticle
   * @param csvData
   * @param loggedMember
   */
  private static void writePubLine(FicheArticle itArticle, StringBuffer csvData, Member loggedMember) {
    // calcul information
    StringBuffer communesConcernees = new StringBuffer();
    if (Util.notEmpty(itArticle.getCommunes())) {
        for (int i = 0; i < itArticle.getCommunes().length; i++) {
          communesConcernees.append(itArticle.getCommunes()[i]);
            if (i < itArticle.getCommunes().length-1) communesConcernees.append(", ");
        }
    } else {
      communesConcernees.append("");
    }
    
    StringBuffer epci = new StringBuffer();
    if (Util.notEmpty(itArticle.getEpci(loggedMember))) {
        for (Iterator iter = itArticle.getEpci(loggedMember).iterator(); iter.hasNext();) {
            Category itCat = (Category) iter.next();
            epci.append(itCat.getName());
            if (iter.hasNext()) epci.append(", ");
        }
    } else {
      epci.append("");
    }
    
    StringBuffer cantons = new StringBuffer();
    if (Util.notEmpty(itArticle.getCantons())) {
        for (int i = 0; i < itArticle.getCantons().length; i++) {
          cantons.append(itArticle.getCantons()[i].getTitle());
            if (i < itArticle.getCantons().length-1) cantons.append(", ");
        }
    } else {
      cantons.append("");
    }
    
    // write information
    String[] bodyValues = new String[] {
        itArticle.getId(), 
        itArticle.getTitle().replaceAll(";", ","), 
        HtmlUtil.html2text(itArticle.getChapo()).replaceAll("\n{1,}",", ").replaceAll("\r{1,}",", ").replaceAll("[, ]{2,}", ", ").replaceAll(";", ","), 
        communesConcernees.toString(), 
        String.valueOf(itArticle.getToutesLesCommunesDuDepartement()), 
        epci.toString(), 
        cantons.toString()
    };
    addLine(csvData, bodyValues);
  }

  /**
   * 
   * @return the data header used for the CSV
   */
  private static StringBuffer writeHeaderCSV() {
    StringBuffer csvHeader = new StringBuffer();
    String[] headerFields = new String[] {
        "Identifiant", "Titre", "Chapo", "Commune", "Toutes communes", "EPCI concernées", "Cantons concernés"
    };
    addLine(csvHeader, headerFields);
    return csvHeader;
  }
  
  /**
   * Useful method to write a CSV line
   * @param csv
   * @param it
   */
  private static void addLine(StringBuffer csv, String... it) {
    csv.append(StringUtils.join(it, separator));
    csv.append(separator).append(newLine);
  }
  
}
