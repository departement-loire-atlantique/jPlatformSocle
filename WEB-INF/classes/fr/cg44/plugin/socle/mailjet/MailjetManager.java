package fr.cg44.plugin.socle.mailjet;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.concurrent.TimeUnit;

import org.apache.log4j.Logger;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import com.jalios.jcms.Category;
import static com.jalios.jcms.Channel.getChannel;
import com.jalios.util.Util;
import com.mailjet.client.ClientOptions;
import com.mailjet.client.MailjetClient;
import com.mailjet.client.MailjetRequest;
import com.mailjet.client.MailjetResponse;
import com.mailjet.client.errors.MailjetException;
import com.mailjet.client.resource.Contact;
import com.mailjet.client.resource.Contactdata;
import com.mailjet.client.resource.ContactslistManageContact;

import okhttp3.OkHttpClient;

public class MailjetManager {
  
  private static Logger LOGGER = Logger.getLogger(MailjetManager.class);
  
  
  /**
   * Création d'un client pour mailJet
   * @return
   */
  public static MailjetClient getMailJetClient() {    

    String apiKey = getChannel().getProperty("jcmsplugin.socle.mailjet.apiKey");
    String apiSecretKey = getChannel().getProperty("jcmsplugin.socle.mailjet.apiSecretKey");
    
    if(Util.isEmpty(apiKey) || Util.isEmpty(apiSecretKey)) {
      return null;
    }
    
    OkHttpClient customHttpClient = new OkHttpClient.Builder()
        .connectTimeout(60, TimeUnit.SECONDS)
        .readTimeout(60, TimeUnit.SECONDS)
        .writeTimeout(60, TimeUnit.SECONDS)
        .build();      
    
    ClientOptions options = ClientOptions.builder()
        .apiKey(apiKey)
        .apiSecretKey(apiSecretKey)
        .okHttpClient(customHttpClient)
        .build(); 
    
    MailjetClient client = new MailjetClient(options);    
    return client;    
  }
  
  
  /**
   * Ajoute le l'email à la liste de contact
   * Création du contact si celui-ci n'existe pas dans mailJet
   * @param email
   * @return
   * @throws JSONException 
   */
  public static boolean addContactList(String email) throws JSONException {
    
    int contactListId = getChannel().getIntegerProperty("jcmsplugin.socle.mailjet.contactList", 0);
    return addContactList(email, contactListId);
   
  }
  
  /**
   * Ajoute le l'email à la liste de contact
   * Création du contact si celui-ci n'existe pas dans mailJet
   * @param email
   * @return
   * @throws JSONException 
   */
  public static boolean addContactList(String email, int contactListId) throws JSONException {
        
    if(Util.isEmpty(email) || contactListId == 0) {
      return false;
    }
    
    MailjetClient client = getMailJetClient();
    MailjetRequest request;
    MailjetResponse response;
    request = new MailjetRequest(ContactslistManageContact.resource, contactListId)
        .property(ContactslistManageContact.PROPERTIES, "object")
        .property(ContactslistManageContact.ACTION, "addnoforce")
        .property(ContactslistManageContact.EMAIL, email);       
    
    try {
      response = client.post(request);      
    } catch (MailjetException e) {
      LOGGER.warn("Impossible d'ajouter le contact à la liste " + email, e);
      return false;
    }   
    return response.getStatus() == 201;
  }
  
  
  /**
   * Ajoute les propriétés au contact mailjet par rapport au catégories (description) JCMS
   * @param email
   * @param catId
   * @return
   */
  public static boolean addContactProperties(String email, String... catId) {
    
    // Categories de la newsletter
    Category parutionRoot = getChannel().getCategory("$jcmsplugin.socle.footer.newsletter.parutions.cat");
    Category flashRoot =  getChannel().getCategory("$jcmsplugin.socle.footer.newsletter.thematiques.cat");  
    
    List<Category> themeCat = new ArrayList<Category>();
    themeCat.addAll(parutionRoot.getChildrenSet());
    themeCat.addAll(flashRoot.getChildrenSet());
        
    if(Util.isEmpty(email) || Util.isEmpty(catId) || Util.isEmpty(themeCat)) {
      return false;
    }
    
    List<String> catIdList = Arrays.asList(catId);
    
    MailjetClient client = getMailJetClient();
    MailjetRequest request;
    MailjetResponse response;
    
    // Création du json pour les propriétés mailjet par rapport aux catégories JCMS
    JSONArray jsonArray = new JSONArray();
    for(Category itCat : themeCat) {
      if(Util.notEmpty(itCat.getDescription())) {
        JSONObject itJson = new JSONObject();
        try {
          itJson.put("Name", itCat.getDescription());
          itJson.put("Value", catIdList.contains(itCat.getId()));
          jsonArray.put(itJson);
        } catch (JSONException e) {
          LOGGER.warn("Ajout des propriétés du contact impossible dans mailjet " + email, e);
          return false;
        } 
      }
    }
    
    try {
      request = new MailjetRequest(Contactdata.resource, email)
          .property(Contactdata.DATA, jsonArray);
      response = client.put(request);
    } catch (MailjetException e) {
      LOGGER.warn("Ajout des propriétés du contact impossible dans mailjet " + email, e);
      return false;
    }
    return response.getStatus() == 200;
  }
  
  
  /**
   * Création du contact dans mailJet à partir du mail
   * @param email
   * @return
   */
  public static boolean createContact(String email) {
    if(Util.isEmpty(email)) {
      return false;
    }
    MailjetClient client = getMailJetClient();
    MailjetRequest request;
    MailjetResponse response;
    request = new MailjetRequest(Contact.resource)        
        .property(Contact.EMAIL, email);
    try {
      response = client.post(request);
    } catch (MailjetException e) {
      LOGGER.warn("Création du contact impossible dans mailjet " + email, e);
      return false;
    }
    return response.getStatus() == 201;
  }
  

}
