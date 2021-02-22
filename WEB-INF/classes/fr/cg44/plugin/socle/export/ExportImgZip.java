package fr.cg44.plugin.socle.export;

import java.io.File;
import java.util.List;

import org.apache.log4j.Logger;

import com.jalios.jcms.Channel;
import com.jalios.jcms.Content;
import com.jalios.util.Util;

public class ExportImgZip {
  
  private static final Logger LOGGER = Logger.getLogger(ExportImgZip.class);
  
  public static final String FILENAME = "exportImages.zip";
  
  /**
   * Indique si un fichier ou un dossier existe sur le disque
   * @param path
   * @return
   */
  public static boolean fileOrPathExists(String path) {
    if (Util.isEmpty(path)) return false;
    File dir = new File(path);
    return dir.exists();
  }
  
  /**
   * Indique si le fichier d'export zip existe au bon emplacement sur le disque
   * @return
   */
  public static boolean imgZipFileExists() {
    File zipFile = new File(Channel.getChannel().getProperty("jcmsplugin.socle.export.img.filepath") + FILENAME);
    return zipFile.exists();
  }
  
  /**
   * Supprime le zip d'export d'images pour libérer de la place sur le disque. A appeler avant la création d'un nouveau zip
   */
  public static void deleteImgZipFile() {
    File zipFile = new File(Channel.getChannel().getProperty("jcmsplugin.socle.export.img.filepath") + FILENAME);
    if (zipFile.delete()) {
      LOGGER.info("Le fichier " + zipFile.getAbsolutePath() + " a été supprimé.");
    } else {
      LOGGER.warn("Le fichier " + zipFile.getAbsolutePath() + " n'a pas pu être supprimé. Vérifier les droits d'accès de l'user tomcat et l'existence du fichier.");
    }
  }
  
  /**
   * Génère un fichier ZIP contenant les images principales des contenus indiqués
   * @param filepathList
   */
  public static void generateImgZipFile(List<Content> contentList) {
    // Vérifier si le dossier existe
    
    String folderPath = Channel.getChannel().getProperty("jcmsplugin.socle.export.img.filepath");
    
    if (!fileOrPathExists(folderPath)) {
      LOGGER.warn("Export d'images de contenus impossible. Le dossier " + folderPath + " n'est pas accessible.");
      return;
    }
    
    // Si le ZIP existe déjà, le supprimer
    if (imgZipFileExists()) deleteImgZipFile();
    
    
  }
  
}