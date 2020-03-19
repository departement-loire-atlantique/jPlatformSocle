package fr.cg44.plugin.socle;

import static com.jalios.jcms.Channel.getChannel;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Collection;
import java.util.Date;
import java.util.Iterator;
import java.util.Map;
import java.util.Set;
import java.util.SortedSet;
import java.util.TreeSet;

import org.apache.log4j.Logger;

import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.jalios.jcms.Category;
import com.jalios.jcms.Channel;
import com.jalios.jcms.DataSelector;
import com.jalios.jcms.JcmsUtil;
import com.jalios.jcms.Member;
import com.jalios.jcms.Publication;
import com.jalios.jcms.QueryResultSet;
import com.jalios.jcms.handler.QueryHandler;
import com.jalios.jcms.taglib.ThumbnailTag;
import com.jalios.util.Util;

import generated.AbstractPortletFacette;
import generated.Canton;
import generated.City;
import generated.Delegation;
import generated.PortletAgendaInfolocale;
import generated.PortletFacetteAdresse;
import generated.PortletFacetteCategoriesLiees;
import generated.PortletFacetteCommune;
import generated.PortletFacetteCommuneAdresseLiee;

public final class SocleUtils {
	private static Channel channel = Channel.getChannel();
	
	private static final Logger LOGGER = Logger.getLogger(SocleUtils.class);
	
	// La catégorie technique qui désigne qu'un contenu est mis en avant si celui-ci y est catégorisé.
	private static final String MISE_EN_AVANT_CAT_PROP = "$id.plugin.socle.page-principale.cat";

	private SocleUtils() {
		throw new IllegalStateException("Utility class");
	}
	
	/**
	 * A partir d'une catégorie parent, retourne un TreeSet de ses enfants, trié et filtré en fonction des droits de l'utilisateur.
	 * 
	 * @param cat La catégorie parent pour laquelle on doit récupérer les enfants.
	 * @return Un TreeSet de catégories enfants, filtré et trié. Null si la catégorie n'existe pas.
	 */
	public static SortedSet<Category> getOrderedAuthorizedChildrenSet(Category cat) {
		Member loggedMember = channel.getCurrentLoggedMember();
		String userLang = channel.getCurrentJcmsContext().getUserLang();
		if(Util.notEmpty(cat)) {
			DataSelector authorizedCategoriesSelector = Category.getAuthorizedSelector(loggedMember);
			TreeSet<Category> childrenSet = new TreeSet<Category>(cat.getOrderComparator(userLang));
			childrenSet.addAll(cat.getChildrenSet());
			JcmsUtil.applyDataSelector(childrenSet, authorizedCategoriesSelector);
			return childrenSet;
		}
		return new TreeSet<Category>();
		
	}
	
	/**
	 * Permet de récupérer le contenu principal d'une catégorie si celle-ci existe
	 * @param currentCat la catégorie courante
	 * @return La publication principale de la catégorie, sinon NULL
	 */
	public static Publication getContenuPrincipal(Category currentCat) {
		if(currentCat != null && getChannel().getCategory(MISE_EN_AVANT_CAT_PROP) != null) {
			Member loggedMember = channel.getCurrentLoggedMember();		
			QueryHandler qh = new QueryHandler();
			qh.setCids(getChannel().getProperty(MISE_EN_AVANT_CAT_PROP), currentCat.getId());
			qh.setLoggedMember(loggedMember);
			qh.setExactCat(true);
			QueryResultSet result = qh.getResultSet();
			return Util.getFirst(result);
		}	
		
		return null;
	}

	/**
	 * Retire tout ce qui n'est pas décimal de la chaine de caractère
	 * Exemple 02 40-44-85 12 devient  0240448512 ou 44 000 devient 44000
	 * @param s
	 * @return
	 */
	public static String cleanNumber(String s) {
		return s.replaceAll("\\D", "");
	}

	/**
	 * Retire tout ce qui n'est pas décimal des chaines de caractère du tableau
	 * Voir cleanNumber(String s) appliqué à chaque élément du tableau
	 * @param s
	 * @return
	 */
	public static String[] cleanNumber(String[] s) {
		String[] result = new String[0];
		if(Util.notEmpty(s)) {
			result = Arrays.stream(s).map(elt -> cleanNumber(elt)).toArray(String[]::new);
		}
		return result;
	}
	
	/**
	 * Retourne un String formaté à partir d'une date
	 * @param format
	 * @param date
	 * @return
	 */
	public static String formatDate(String format, Date date) {
		if (Util.isEmpty(date)) return "";
		SimpleDateFormat sdf = new SimpleDateFormat(format);
		return sdf.format(date);
	}
	
	/**
     * G�n�re un string � partir du contenu d'un InputStream
     * @param is
     * @return
     */
    public static String convertStreamToString(InputStream is) {
        BufferedReader reader = new BufferedReader(new InputStreamReader(is));
        StringBuilder sb = new StringBuilder();
        String line = null;
        
        try {
            while ((line = reader.readLine()) != null) {
                sb.append(line + "\n");
            }
        } catch (IOException e) {
            LOGGER.error("Erreur dans convertStreamToString : " + e.getMessage());
        } finally {
            try {
                is.close();
            } catch (IOException e) {
                LOGGER.error("Erreur dans convertStreamToString : " + e.getMessage());
            }
        }
        
        return sb.toString();
    }
	
	/**
	 * Génère un string de paramètres GET à intégrer dans l'URL de requêtes
	 * @param params
	 * @return
	 */
	public static String buildGetParams(Map<String, Object> params) {
	    if (Util.isEmpty(params)) return "";
	    
	    StringBuilder urlParams = new StringBuilder();
	    
	    urlParams.append("?");
	    
	    for (Iterator<String> iter = params.keySet().iterator(); iter.hasNext();) {
	        String key = iter.next();
	        String value = params.get(key).toString();
	        urlParams.append(key + "=" + value);
	        if (iter.hasNext()) urlParams.append("&");
	    }
	    
	    return urlParams.toString();
	}
	
	/**
	 * Récupère une liste de codes Insee sous le format insee_1,insee_2,insee_3
	 * @param box
	 * @param loggedMember
	 * @return
	 */
	public static String getCodesInseeFromPortletAgenda(PortletAgendaInfolocale box, Member loggedMember) {
	    StringBuilder codesInsee = new StringBuilder();
	    
	    // récupération des Insee des délégations
	    if (Util.notEmpty(box.getDelegations())) {
	        for (Delegation itDeleg : box.getDelegations()) {
	            TreeSet<City> allCities = itDeleg.getLinkIndexedDataSet(City.class);
	            for (City itCommune : allCities) {
	                codesInsee = appendInseeFromCommune(codesInsee, itCommune);
	            }
	        }
	    }
	    
	    // récupération des Insee des communes
	    if (Util.notEmpty(box.getCommunes())) {
	        TreeSet<City> allCities = new TreeSet<>(Arrays.asList(box.getCommunes()));
            for (City itCommune : allCities) {
	            codesInsee = appendInseeFromCommune(codesInsee, itCommune);
	        }
	    }
	    
	    // Récupération des Insee des EPCIs
	    if (Util.notEmpty(box.getEpci(loggedMember))) {
	        QueryHandler qh = new QueryHandler();
	        qh.setCids(JcmsUtil.dataListToString(box.getEpci(loggedMember), ","));
	        qh.setLoggedMember(loggedMember);
	        qh.setTypes("City");
	        QueryResultSet result = qh.getResultSet();
	        SortedSet<Publication> listPubs = result.getAsSortedSet();
	        for (Publication itPub : listPubs) {
	            City itCommune = (City) itPub;
	            codesInsee = appendInseeFromCommune(codesInsee, itCommune);
	        }
	    }
	    
	    return Util.isEmpty(codesInsee.toString()) ? "" : codesInsee.toString().substring(0, codesInsee.toString().lastIndexOf(','));
	}

	/**
	 * Concatène à un StringBuilder le code Insee d'une commune
	 * @param codesInsee
	 * @param itCommune
	 * @return
	 */
    public static StringBuilder appendInseeFromCommune(StringBuilder codesInsee, City itCommune) {

        // Le code doit être supérieur à 0 (valeur vide)
        if (itCommune.getCityCode() <= 0) return codesInsee;
        
        // Il ne doit pas y avoir de doublon
        if (codesInsee.toString().contains(Integer.toString(itCommune.getCityCode()))) return codesInsee;
        
        // Le code INSEE doit appartenir au département 44
        if (!Integer.toString(itCommune.getCityCode()).startsWith("44")) return codesInsee;
        
        StringBuilder codeInseeClone = codesInsee;
        
        codeInseeClone.append(itCommune.getCityCode());
        codeInseeClone.append(",");
        
        return codeInseeClone;
    }

	/**
	 * Concatène et formate toutes les infos d'une adresse en un String sous la forme suivante :
	 * 
	 * [libelle]<br>
	 * [etageCouloirEscalier]<br>
	 * [entreBatimentImmeuble]<br>
	 * [nDeVoie] [libelleDeVoie]<br>
	 * [lieuDit]<br>
	 * CS [cs]<br>
	 * [codePostal] [commune] Cedex [cedex]
	 * 
	 * @param libelle
	 * @param etageCouloirEscalier
	 * @param entreBatimentImmeuble
	 * @param nDeVoie
	 * @param libelleDeVoie
	 * @param lieuDit
	 * @param cs
	 * @param codePostal
	 * @param commune
	 * @return un String contenant une adresse avec les informations renseignées en entrée de la méthode
	 */
	public static String formatAddress(String libelle, String etageCouloirEscalier, 
			String entreBatimentImmeuble, String nDeVoie, String libelleDeVoie, 
			String lieuDit, String cs, String codePostal, String commune, String cedex) {

		String separator = " ";
		String newLine = "<br>";
		StringBuffer sbfAddr = new StringBuffer();
		String userLang = Channel.getChannel().getCurrentUserLang();

		StringBuffer sbfAddrBis = new StringBuffer();
		String[] morcAddrArr = new String[]{ libelle, etageCouloirEscalier, entreBatimentImmeuble};
		for(String morcAddr : morcAddrArr) {
			if(Util.notEmpty(morcAddr)) {
				sbfAddrBis.append(morcAddr)
				.append(newLine);
			}
		}
		String[] morcAddrArr2 = new String[]{ nDeVoie, libelleDeVoie};
		for(String morcAddr : morcAddrArr2) {
			if(Util.notEmpty(morcAddr)) {
				sbfAddrBis.append(morcAddr)
				.append(separator);
			}
		}
		if(Util.notEmpty(sbfAddrBis.toString())) {
			sbfAddr.append(sbfAddrBis)
			.deleteCharAt(sbfAddr.length()-1)
			.append(newLine);
		}
		if(Util.notEmpty(lieuDit)) {
			sbfAddr.append(lieuDit)
			.append(newLine);
		}
		if(Util.notEmpty(cs)) {
			sbfAddr.append(JcmsUtil.glp(userLang, "jcmsplugin.socle.label.cs"))
			.append(" ")
			.append(cs)
			.append(newLine);
		}
		String[] morcAddrArr3 = new String[]{ codePostal, commune};
		for(String morcAddr : morcAddrArr3) {
			if(Util.notEmpty(morcAddr)) {
				sbfAddr.append(morcAddr)
				.append(separator);
			}
		}
		if(Util.notEmpty(cedex)) {
			sbfAddr.append(JcmsUtil.glp(userLang, "jcmsplugin.socle.label.cedex"))
			.append(" ")
			.append(cedex);
		}

		return sbfAddr.toString();

	}
	
	
	/**
	 * Créé une url oppenstreetmap à partir des coordonnées et du zoom souhaité
	 * Par exemple : https://www.openstreetmap.org/directions?engine=graphhopper_car&route=[latitude]%2C[longitude]#map=[zoom]/[latitude]/[longitude]
	 * @param latitude
	 * @param longitude
	 * @param zoom
	 * @return une url qui ouvre une page openstreetmap
	 */
	public static String formatOpenStreetMapLink(String latitude, String longitude, String zoom) {
		
		StringBuffer sbfLocalisation = new StringBuffer();
		
		if (Util.notEmpty(longitude) && Util.notEmpty(latitude)) {
			
			sbfLocalisation.append(Channel.getChannel().getProperty("jcmsplugin.socle.openstreetmap.url"))
					.append("directions?engine=graphhopper_car&route=")
					.append(latitude)
					.append("%2C")
					.append(longitude)
					.append("#map=")
					.append(zoom)
					.append("/")
					.append(latitude)
					.append("/")
					.append(longitude);
		}
		
		return sbfLocalisation.toString();
	}
	
	/**
	 * Créé une url oppenstreetmap à partir des coordonnées
	 * Par exemple : https://www.openstreetmap.org/directions?engine=graphhopper_car&route=[latitude]%2C[longitude]#map=11/[latitude]/[longitude]
	 * @param latitude
	 * @param longitude
	 * @return une url qui ouvre une page openstreetmap avec un zoom par defaut
	 */
	public static String formatOpenStreetMapLink(String latitude, String longitude) {
		
		return formatOpenStreetMapLink(latitude, longitude, "11");
	}

	/**
     * Génère un String selon une liste de catégories, de format (ici pour 3 catégories) : [nom cat1], [nom cat2], [nom cat3]
     * @param categories
     * @return
     */
    public static String formatCategories(SortedSet<Category> categories) {
        return formatCategories(categories, ", ");
    }
    
    /**
     * Génère un String selon une liste de catégories, de format (ici pour 3 catégories) : [nom cat1], [nom cat2], [nom cat3]
     * Le séparateur est sélectionné dans la méthode
     * @param categories
     * @param separator
     * @return
     */
    public static String formatCategories(SortedSet<Category> categories, String separator) {
        
        if (Util.isEmpty(categories)) return "";
        
        StringBuilder formatted = new StringBuilder();
        
        for (Iterator<Category> iter = categories.iterator(); iter.hasNext();) {
            Category itCat = (Category) iter.next();
            String title = Util.isEmpty(itCat.getExtraData("extra.Category.plugin.tools.synonyme.facet.title")) ? itCat.getName() : itCat.getExtraData("extra.Category.plugin.tools.synonyme.facet.title");
            formatted.append(title);
            if (iter.hasNext()) formatted.append(separator);
        }
        
        return formatted.toString();
    }
	
	/**
	 * Retourne une URL valide pour le front-office
	 * @param url
	 * @return
	 */
	public static String parseUrl(String url) {
	    if (Util.isEmpty(url)) return "";
	    
	    if (url.contains("http")) return url.replace("'", "").replace("\"", "");
	    
	    return "https://" + url.replace("'", "").replace("\"", "");
	}
	
	
	/**
	 * Retourne les communes sous forme de json
	 * @param communes
	 * @return
	 */
	public static JsonArray citiestoJsonArray(Publication... communes) {
		JsonArray jsonArray = new JsonArray();
		if(Util.notEmpty(communes)) {
      for(Publication itPub : communes) {
        City itCity = (City) itPub;
          JsonObject itJsonObject = new JsonObject();
          String cityCode = Integer.toString(itCity.getCityCode());
          itJsonObject.addProperty("id", cityCode);
          itJsonObject.addProperty("value", itCity.getTitle());		    
          JsonObject itJsonMetaObject = new JsonObject();
          String[] needAdress = channel.getStringArrayProperty("jcmsplugin.socle.cities.needAddress", new String[]{});
          itJsonMetaObject.addProperty("hasLinkedField", Util.arrayContains(needAdress, cityCode));    
          itJsonObject.add("metadata", itJsonMetaObject);
          jsonArray.add(itJsonObject);
      }		
    }
		return jsonArray;		
	}
	
	
	/**
	 * Retourne les communes sous forme de json
	 * @param communes
	 * @return
	 */
	public static JsonArray citiestoJsonArray(Collection<Publication> communes) {		
		return citiestoJsonArray(communes.toArray(new City[communes.size()]));
	}
	
	
	/**
	 * Retourne les communes sous forme de json
	 * @param communes
	 * @return
	 */
	public static JsonArray citiestoJsonArray(Set<City> communes) {		
		return citiestoJsonArray(communes.toArray(new City[communes.size()]));
	}
	
	
	/**
	 * Retourne une publication sous forme de json pour le moteur de la recherche à facettes
	 * @param pub
	 * @param pubListGabarit
	 * @param pubMarkerGabarit
	 * @return
	 */
	public static JsonObject publicationToJsonObject(Publication pub, String pubListGabarit, String pubMarkerGabarit, String pubFullGabarit) {
		JsonObject jsonObject = new JsonObject();
		jsonObject.addProperty("id", pub instanceof Canton ? String.valueOf(((Canton) (pub)).getCantonCode()) : pub.getId());
		jsonObject.addProperty("value", pub.getTitle());
		JsonObject jsonMetaObject = new JsonObject();
		jsonMetaObject.addProperty("url", channel.getUrl() + pub.getDisplayUrl(null));
		jsonMetaObject.addProperty("type", pub.getClass().getSimpleName());
		jsonMetaObject.addProperty("lat", pub.getExtraData("extra."+ pub.getClass().getSimpleName() +".plugin.tools.geolocation.latitude"));
		jsonMetaObject.addProperty("long", pub.getExtraData("extra."+ pub.getClass().getSimpleName() + ".plugin.tools.geolocation.longitude"));
		if(Util.notEmpty(pubListGabarit)) {
			jsonMetaObject.addProperty("html_list", pubListGabarit);
		}
		if(Util.notEmpty(pubMarkerGabarit)) {
			jsonMetaObject.addProperty("html_marker", pubMarkerGabarit);
		}
		if(Util.notEmpty(pubFullGabarit)) {
			jsonMetaObject.addProperty("html_full", pubFullGabarit);
		}
		jsonObject.add("metadata", jsonMetaObject);
		return jsonObject;
	}
		
	
	/**
	 * Retourne les Publications sous forme de json
	 * @param publications
	 * @return
	 */
	public static JsonArray publicationToJsonArray(Set<Publication> publications) {
		JsonArray jsonArray = new JsonArray();
		for(Publication itPub : publications) {
			jsonArray.add(publicationToJsonObject(itPub, null, null, null));
		}
		return jsonArray;
	}
	
	/**
	 * <p>Calcule le nombre maximum de facettes dont le poids cumulé ne dépasse pas le poids maximum en entrée.</p>
	 * <p></p>
	 * <p>Toutes les facettes pèsent 1, sauf :</p>
	 * <p>- <code>PortletFacetteCategoriesLiees</code> et <code>PortletFacetteCommuneAdresseLiees</code> comptent pour 2 ;</p>
	 * <p>- <code>PortletFacetteAdresse</code> peuvent compter pour 2 s'il affiche l'option <code>rayon</code> ;</p>
	 * <p>- <code>PortletFacetteCommune</code> peuvent compter pour 2 s'il affiche l'option <code>commune limitrophe</code> ou  <code>commune EPCI</code> ;</p>
	 * <p></p>
	 * <p>Par exemple pour <code>getNbrFacetteBeforeMaxWeight(4, member, { PortletFacetteCategoriesLiees, PortletFacetteTitre, PortletFacetteCommuneAdresseLiees})</code> :</p>
	 * <p></p>
	 * <p>PortletFacetteCategoriesLiees pèse 2 ;</p>
	 * <p>PortletFacetteTitre pèse 1, on a un poids total de 3 ;</p>
	 * <p>PortletFacetteCommuneAdresseLiees pèse 2, on a un poids total de 5 qui dépasse le poids max de 4 ;</p>
	 * <p></p>
	 * <p>Donc seules les 2 premières facettes ne dépassent pas le poids max.</p>
	 * <p>On retourne 2.</p>
	 * <p></p>
	 * @param maxWeight le poids maximum cumulé des facettes affichable
	 * @param facetteArr le tableau des facettes à afficher
	 * @param member l'utilisateur en cours de navigation
	 * @return le nombre de facettes du tableau qui peuvent être affichés avant d'atteindre le poids maximum
	 */
	public static int getNbrFacetteBeforeMaxWeight(int maxWeight, AbstractPortletFacette[] facetteArr, Member member) {
		int weight = 0;
		int maxFacettesPrincipales = 0;
		
		for(AbstractPortletFacette itFacette : facetteArr) {
			
			if(itFacette instanceof PortletFacetteCategoriesLiees 
					|| itFacette instanceof PortletFacetteCommuneAdresseLiee 
					|| (itFacette instanceof PortletFacetteCommune
							&& Util.notEmpty(((PortletFacetteCommune)itFacette).getRechercheEtendue())
							&& ( !((PortletFacetteCommune)itFacette).getRechercheEtendue().equalsIgnoreCase("aucune")))
					|| (itFacette instanceof PortletFacetteAdresse
							&& Util.notEmpty(((PortletFacetteAdresse)itFacette).getRayon(member)))) {
				
				weight += 2;
				
			} else {
				
				weight ++;
			}
			
			if(weight > maxWeight) break;
			
			maxFacettesPrincipales++;
		}
		
		return maxFacettesPrincipales;
	}


	/**
	 * Retourne une catégorie sous forme de json
	 * @param cat
	 * @return
	 */
	public static JsonObject categoryToJsonObject(Category cat) {
		JsonObject jsonObject = new JsonObject();
		jsonObject.addProperty("id", cat.getId());
		jsonObject.addProperty("value", cat.getName());
		return jsonObject;
	}
	
	
	/**
	 * Retourne les catégories sous forme de json
	 * @param categories
	 * @return
	 */
	public static JsonArray categoriesToJsonArray(Set<Category> categories) {
		JsonArray jsonArray = new JsonArray();
		for(Category itCat : categories) {
			jsonArray.add(categoryToJsonObject(itCat));
		}
		return jsonArray;
	}
	
	/**
	 * Génère une image principale formattée et renvoie son path
	 * @param imagePath
	 * @return
	 */
	public static String getUrlOfFormattedImagePrincipale(String imagePath) {
    return generateVignette(imagePath, channel.getIntegerProperty("jcmsplugin.socle.image.principale.width", 0), channel.getIntegerProperty("jcmsplugin.socle.image.principale.height", 0)); 
  }
	
	/**
   * Génère une image bandeau formattée et renvoie son path
   * @param imagePath
   * @return
   */
  public static String getUrlOfFormattedImageBandeau(String imagePath) {
    return generateVignette(imagePath, channel.getIntegerProperty("jcmsplugin.socle.image.bandeau.width", 0), channel.getIntegerProperty("jcmsplugin.socle.image.bandeau.height", 0)); 
  }
  
  /**
   * Génère une image mobile formattée et renvoie son path
   * @param imagePath
   * @return
   */
  public static String getUrlOfFormattedImageMobile(String imagePath) {
    return generateVignette(imagePath, channel.getIntegerProperty("jcmsplugin.socle.image.mobile.width", 0), channel.getIntegerProperty("jcmsplugin.socle.image.mobile.height", 0)); 
  }
  
  /**
   * Génère une image carrée formattée et renvoie son path
   * @param imagePath
   * @return
   */
  public static String getUrlOfFormattedImageCarree(String imagePath) {
    return generateVignette(imagePath, channel.getIntegerProperty("jcmsplugin.socle.image.carree.width", 0), channel.getIntegerProperty("jcmsplugin.socle.image.carree.height", 0)); 
  }
  
  /**
   * Génère une image push formattée et renvoie son path
   * @param imagePath
   * @return
   */
  public static String getUrlOfFormattedImagePush(String imagePath) {
    return generateVignette(imagePath, channel.getIntegerProperty("jcmsplugin.socle.image.push.width", 0), channel.getIntegerProperty("jcmsplugin.socle.image.push.height", 0)); 
  }
  
  /**
   * Génère une image formattée et renvoie son path
   * @param imagePath
   * @return
   */
  public static String generateVignette(String imagePath, int width, int height) {
    if (Util.notEmpty(imagePath) && Util.notEmpty(width) && Util.notEmpty(height)) {
      ThumbnailTag.buildThumbnail(imagePath, width, height, imagePath); 
    }
    return "";
  }
	
}
