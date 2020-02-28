package fr.cg44.plugin.socle;

import static com.jalios.jcms.Channel.getChannel;

import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Collection;
import java.util.Date;
import java.util.Iterator;
import java.util.Set;
import java.util.SortedSet;
import java.util.TreeSet;

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
import com.jalios.util.Util;

import generated.City;

public final class SocleUtils {
	private static Channel channel = Channel.getChannel();
	
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
	 * Méthode qui retourne le nombre de seconde pour le timecode passé en paramètre
	 * @param timecode timecode au format hh:mm:ss
	 * @return le nombre de seconde
	 */
	public static int getSecondesByTimecode(String timecode){
		int retourSecondes = 0;
		if(Util.notEmpty(timecode)){
			String heureStr = "";
			String minuteStr = "";
			String secondeStr = "";

			heureStr = timecode.substring(0, 2);
			minuteStr = timecode.substring(3, 5);
			secondeStr = timecode.substring(6); 

			int heure = 0;
			int minute = 0;
			int seconde = 0;

			heure = Integer.parseInt(heureStr);
			heure = heure * 3600;

			minute = Integer.parseInt(minuteStr);
			minute = minute * 60;

			seconde = Integer.parseInt(secondeStr);

			retourSecondes = heure + minute + seconde;
		}

		return retourSecondes;
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
		for(Publication itPub : communes) {
			City itCity = (City) itPub;
		    JsonObject itJsonObject = new JsonObject();
		    itJsonObject.addProperty("id", Integer.toString(itCity.getCityCode()));
		    itJsonObject.addProperty("value", itCity.getTitle());		    
		    JsonObject itJsonMetaObject = new JsonObject();
		    itJsonMetaObject.addProperty("hasLinkedField", true);		    
		    itJsonObject.add("metadata", itJsonMetaObject);
		    jsonArray.add(itJsonObject);
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
		jsonObject.addProperty("id", pub.getId());
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

}
