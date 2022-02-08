package fr.cg44.plugin.socle.mailjet;

import static com.jalios.jcms.Channel.getChannel;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.concurrent.TimeUnit;

import org.apache.log4j.Logger;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import com.jalios.jcms.Category;
import com.jalios.util.HtmlUtil;
import com.jalios.util.Util;
import com.mailjet.client.ClientOptions;
import com.mailjet.client.MailjetClient;
import com.mailjet.client.MailjetRequest;
import com.mailjet.client.MailjetResponse;
import com.mailjet.client.errors.MailjetException;
import com.mailjet.client.resource.Campaign;
import com.mailjet.client.resource.Campaigndraft;
import com.mailjet.client.resource.CampaigndraftDetailcontent;
import com.mailjet.client.resource.CampaigndraftSend;
import com.mailjet.client.resource.CampaigndraftTest;
import com.mailjet.client.resource.Contact;
import com.mailjet.client.resource.Contactdata;
import com.mailjet.client.resource.ContactslistManageContact;
import com.mailjet.client.resource.Listrecipient;
import com.mailjet.client.resource.Newsletter;
import com.mailjet.client.resource.NewsletterTest;

import okhttp3.OkHttpClient;

public class MailjetManager {
  
  private static Logger LOGGER = Logger.getLogger(MailjetManager.class);
  
  private static final int EXIT_SUCCESS = 0;
  private static final int EXIT_ERROR = 1;
  
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
  
  
  /**
   * Récupération d'une liste de campagnes
   * @param from    l'id de l'expéditeur de la campagne
   * @param limit   le nombre max de campagnes à récupérer
   * @param sort    le tri à appliquer sur la liste de campagnes
   * @return
   */
  public static JSONArray getCampaigns(String from, String limit, String sort) {
    JSONArray fluxData = new JSONArray();
    
    MailjetClient client = getMailJetClient();
    MailjetRequest request;
    MailjetResponse response;
    request = new MailjetRequest(Campaign.resource)
        .filter(Campaign.FROMID, from)
        .filter(Campaign.LIMIT, limit)
        .filter("Sort", sort);
    
    try {
      response = client.get(request);
      fluxData = response.getData();
    } catch (MailjetException e) {
      LOGGER.warn("Récupération des campagnes impossible dans mailjet ", e);
    }
    return fluxData;
  }
  
  /**
   * Récupère les emails des contacts appartenant à un groupe
   * 
   * @param id        l'id du groupe Mailjet
   * @return emails   la liste des emails des contacts du groupe
   */
  
  public static ArrayList<String> getEmailsFromGroup(String id) {

    if (Util.isEmpty(id)) {
      return null;
    }
    
    ArrayList<String> emails = new ArrayList<String>();
    JSONArray fluxData = new JSONArray();
    
    MailjetClient client = getMailJetClient();
    MailjetRequest request;
    MailjetResponse response;
    request = new MailjetRequest(Listrecipient.resource)
        .filter(Listrecipient.CONTACTSLIST, id);
    
    try {
      response = client.get(request);
      fluxData = response.getData();
      
      for(int i=0 ; i<fluxData.length() ; i++) {
        JSONObject contactData = new JSONObject();
        try {
          contactData = (JSONObject) fluxData.get(i);
          emails.add(getEmailFromContact(contactData.get("ContactID").toString()));
        } catch (JSONException e) {
          LOGGER.warn("Erreur de récupération d'un contact Mailjet à partir de la liste de contacts (id=" + id + ") ", e);
        }
      }

    } catch (MailjetException e) {
      LOGGER.warn("Récupération de la liste de contacts (id=" + id + ") impossible dans mailjet ", e);
    }
    LOGGER.warn(emails.toString());
    return emails; 

  } 
  
  
  /**
   * Récupère l'email d'un contact à partir de son ID
   * 
   * @param id      l'identifiant Mailjet du contact
   * @return email  l'email du contact
   */
  public static String getEmailFromContact(String id) {

    if (Util.isEmpty(id)) {
      return null;
    }
    
    JSONObject contactData = new JSONObject();
    
    MailjetClient client = getMailJetClient();
    MailjetRequest request;
    MailjetResponse response;
    request = new MailjetRequest(Contact.resource)
        .filter(Contact.ID, id);
    
    try {
      response = client.get(request);
      contactData = response.getData().getJSONObject(0);
      return contactData.get("Email").toString(); 
      
    } catch (JSONException e) {
      LOGGER.warn("Récupération du contact " + id + " impossible dans mailjet ", e);
      
    } catch (MailjetException e) {
      LOGGER.warn("Récupération du mail du contact " + id +" impossible dans mailjet ", e);
    }
    
    return "";
    
  }  
  
  /**
   * Envoie une newsletter à un groupe
   * 
   * @param groupId ID du groupe
   * @param senderMail Email de l'expéditeur
   * @param subject Sujet du mail
   * @param message Corps du mail en HTML
   */
  public static Integer sendNewsletter(String groupId, String senderMail, String senderName, String subject, String message, boolean isTest) {

    // Création de la newsletter  
    com.mailjet.client.MailjetClient client = MailjetManager.getMailJetClient();
    String newsletterID = new String();
    MailjetRequest request;
    MailjetResponse response;

    request = new MailjetRequest(Campaigndraft.resource)      
        .property(Campaigndraft.LOCALE, "fr_FR")
        .property(Campaigndraft.SENDER, senderName) 
        .property(Campaigndraft.SENDERNAME, senderName) 
        .property(Campaigndraft.SENDEREMAIL, senderMail)
        .property(Campaigndraft.SUBJECT, subject)
        .property(Newsletter.CONTACTSLISTID, groupId)
        .property(Campaigndraft.TITLE, subject)
        .property(Campaigndraft.EDITMODE, "html2");
    try {
      response = client.post(request);
      newsletterID = response.getData().getJSONObject(0).getString("ID");
    } catch (MailjetException | JSONException e) {
      LOGGER.warn("Erreur lors de la préparation de la newsletter par l'API Mailjet", e);
      return EXIT_ERROR;
    }


    // Ajout du gabarit à la newsletter  
    request = new MailjetRequest(CampaigndraftDetailcontent.resource, newsletterID)
        .property(CampaigndraftDetailcontent.HTMLPART, message)
        .property(CampaigndraftDetailcontent.TEXTPART, HtmlUtil.html2text(message));
    try {
      response = client.post(request);
    } catch (MailjetException e) {
      LOGGER.warn("Erreur lors de l'ajout d'un corps de texte à la newsletter par l'API Mailjet", e);
      return EXIT_ERROR;
    }
    

    // Envoi de la newsletter  
    try {
      if(isTest) {
        JSONArray jsonArrayRecipients = new JSONArray();
        JSONObject jsonRecipient = new JSONObject();
        jsonRecipient.put("Email", "support.jcms@loire-atlantique.fr");
        jsonRecipient.put("Name", "Département de Loire-Atlantique");
        jsonArrayRecipients.put(jsonRecipient);

        request = new MailjetRequest(CampaigndraftTest.resource, newsletterID)
            .property(NewsletterTest.RECIPIENTS, jsonArrayRecipients);

        response = client.post(request);

      } else {
        request = new MailjetRequest(CampaigndraftSend.resource, newsletterID);
        response = client.post(request);

      }

    } catch (MailjetException | JSONException e) {
      LOGGER.warn("Erreur lors de l'envoi de la newsletter par l'API Mailjet", e);
      return EXIT_ERROR;
    }  
    return EXIT_SUCCESS;
  }
  

}
