package fr.cg44.plugin.socle.export;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.SortedSet;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

import org.apache.log4j.Logger;

import com.jalios.jcms.Channel;
import com.jalios.jcms.Publication;
import com.jalios.util.Util;

public class ExportImgZip {
  
  private static final Logger LOGGER = Logger.getLogger(ExportImgZip.class);
  
  public static final String FILENAME = "exportImages.zip";
  
  private static final String rootPath = Channel.getChannel().getWebappPath();
  
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
    File zipFile = new File(getZipFilePath());
    return zipFile.exists();
  }
  
  /**
   * Renvoie le chemin du fichier ZIP
   * @return
   */
  public static String getZipFilePath() {
    return rootPath + Channel.getChannel().getProperty("jcmsplugin.socle.export.img.filepath") + FILENAME;
  }
  
  /**
   * Renvoie le chemin du fichier ZIP sans le chemin de la webapp
   * @return
   */
  public static String getZipRelativeFilePath() {
    return Channel.getChannel().getProperty("jcmsplugin.socle.export.img.filepath") + FILENAME;
  }
  
  /**
   * Supprime le zip d'export d'images pour libérer de la place sur le disque. A appeler avant la création d'un nouveau zip
   */
  public static void deleteImgZipFile() {
    File zipFile = new File(getZipFilePath());
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
  public static void generateImgZipFile(SortedSet<Publication> contentList) {
    
    if (Util.isEmpty(contentList)) return;
    
    // Vérifier si le dossier existe
    
    String folderPath = rootPath + Channel.getChannel().getProperty("jcmsplugin.socle.export.img.filepath");
    
    if (!fileOrPathExists(folderPath)) {
      LOGGER.warn("Export d'images de contenus impossible. Le dossier " + folderPath + " n'est pas accessible.");
      return;
    }
    
    // Si le ZIP existe déjà, le supprimer
    if (imgZipFileExists()) deleteImgZipFile();
    
    try {
      FileOutputStream fos = new FileOutputStream(getZipFilePath());
      ZipOutputStream zos = new ZipOutputStream(fos);
      byte[] buffer = new byte[1024];
      
      for (Publication itPub : contentList) {
        try {
          // On récupère le fichier à ajouter
          String imgPath = (String) itPub.getFieldValue("imagePrincipale");
          File itFile = new File(rootPath + imgPath);
          
          // Pas d'image à ajouter
          if (!itFile.exists()) continue;
          
          // On va ajouter les données du fichier au ZIP
          FileInputStream fis = new FileInputStream(itFile);
          
          zos.putNextEntry(new ZipEntry(itFile.getName()));
          
          int length;
          
          // On écrit les données dans le zip
          while ((length = fis.read(buffer)) > 0) {
            zos.write(buffer, 0, length);
          }

          // Fermeture des streams qui ne servent plus
          zos.closeEntry();
          fis.close();
          
        } catch (Exception e) {
          LOGGER.warn("Erreur lors d'un import d'image dans le ZIP d'export : " + e.getMessage());
        }
      }
      
      // Fermeture des streams qui ne servent plus
      zos.close();
      fos.close();
    } catch (IOException e) {
      LOGGER.warn("Anomalie export d'images en ZIP : " + e.getMessage());
    }
   
    return;
  }
   
}