package fr.cg44.plugin.socle;

import static com.jalios.jcms.Channel.getChannel;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collection;
import java.util.Date;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.SortedSet;
import java.util.TreeSet;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.ArrayUtils;
import org.apache.log4j.Logger;

import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.jalios.jcms.Category;
import com.jalios.jcms.Channel;
import com.jalios.jcms.DataSelector;
import com.jalios.jcms.HttpUtil;
import com.jalios.jcms.JcmsUtil;
import com.jalios.jcms.Member;
import com.jalios.jcms.Publication;
import com.jalios.jcms.QueryResultSet;
import com.jalios.jcms.handler.QueryHandler;
import com.jalios.jcms.taglib.ThumbnailTag;
import com.jalios.util.Util;

import generated.AbstractPortletFacette;
import generated.AccueilAnnuaireAgenda;
import generated.Canton;
import generated.City;
import generated.Contact;
import generated.Delegation;
import generated.ElectedMember;
import generated.FicheEmploiStage;
import generated.FicheLieu;
import generated.PortletAgendaInfolocale;
import generated.PortletFacetteAdresse;
import generated.PortletFacetteCategoriesLiees;
import generated.PortletFacetteCommune;
import generated.PortletFacetteCommuneAdresseLiee;
import generated.PortletPortalRedirect;

public final class SocleUtils {
	private static Channel channel = Channel.getChannel();
	
	private static final Logger LOGGER = Logger.getLogger(SocleUtils.class);
	
	// La catégorie technique qui désigne qu'un contenu est mis en avant si celui-ci y est catégorisé.
	private static final String MISE_EN_AVANT_CAT_PROP = "$id.plugin.socle.page-principale.cat";
	
	// Messages répétés de log de debug
	private static final String debugNoImagePrincipale = "pas d'image principale";
	private static final String debugNoImageBandeau = "pas d'image bandeau";
	private static final String debugNoImageMobile = "pas d'image mobile";
	private static final String debugNoImageCarree = "pas d'image carrée";

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
	 * Permet de récupérer la portlet Redirection d'une catégorie si celle-ci existe
	 * @param currentCat la catégorie courante
	 * @return la portlet redirecton de la catégorie, sinon NULL
	 */
	public static PortletPortalRedirect getPortalRedirect(Category currentCat) {
	  if(currentCat != null) {
      Member loggedMember = channel.getCurrentLoggedMember();   
      QueryHandler qh = new QueryHandler();
      qh.setCids(currentCat.getId());
      qh.setLoggedMember(loggedMember);
      qh.setExactCat(true);
      qh.setTypes(PortletPortalRedirect.class.getSimpleName());
      QueryResultSet result = qh.getResultSet();
      return (PortletPortalRedirect) Util.getFirst(result);
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
	 * <p>Concatène et formate toutes les infos d'une adresse en un String sous la forme suivante :</p>
	 * <p></p>
	 * <p>[libelle]<br></p>
	 * <p>[etageCouloirEscalier]<br></p>
	 * <p>[entreBatimentImmeuble]<br></p>
	 * <p>[nDeVoie] [libelleDeVoie]<br></p>
	 * <p>[lieuDit]<br></p>
	 * <p>CS [cs]<br></p>
	 * <p>[codePostal] [commune] Cedex [cedex]</p>
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
			sbfAddr.append(cedex);
		}

		return sbfAddr.toString();

	}
	
	/**
	 * <p>Concatène et formate toutes les infos d'une adresse en un String à partir d'une FicheLieu sous la forme suivante :</p>
	 * <p>Règle de gestion : </p>
	 * <p>- Si tous les champs de l'adresse postale sont vides on n'affiche rien. </p>
	 * <p>- Si seuls les champs "cedex" et "CS" de l'adresse postale sont remplis on récupère les autres champs de l'adresse physique. </p>
	 * <p>- Si le champ "libellé de voie" de l'adresse postale est renseigné alors on affiche les autres champs de l'adresse postale et</p>
	 * <p> on n'affiche aucun champ de l'adresse physique.</p>
	 * <p></p>
	 * <p>[libelle]<br\></p>
	 * <p>[etageCouloirEscalier]<br\></p>
	 * <p>[entreBatimentImmeuble]<br\></p>
	 * <p>[nDeVoie] [libelleDeVoie]<br\></p>
	 * <p>[lieuDit]<br\></p>
	 * <p>CS [cs]<br\></p>
	 * <p>[codePostal] [commune] Cedex [cedex]</p>
	 * 
	 * @param fichelieu
	 * @return un String contenant l'adresse physique de la FicheLieu ou null si le libellé, le CP et la commune sont vide.
	 */
	public static String formatAdresseEcrire(FicheLieu fichelieu) {
		boolean getInfosAdressePhysique = Util.notEmpty(fichelieu.getLibelleDeVoie2()) ? false : (Util.notEmpty(fichelieu.getCs2()) || Util.notEmpty(fichelieu.getCedex2()));

		String communeEcrire = Util.notEmpty(fichelieu.getCommune2()) ? fichelieu.getCommune2().getTitle() : (Util.notEmpty(fichelieu.getCommune()) && getInfosAdressePhysique) ? fichelieu.getCommune().getTitle() : "";
		String etageCouloirEscalier =  Util.notEmpty(fichelieu.getEtageCouloirEscalier2()) ? fichelieu.getEtageCouloirEscalier2() : (Util.notEmpty(fichelieu.getEtageCouloirEscalier()) && getInfosAdressePhysique) ? fichelieu.getEtageCouloirEscalier() : "";
		String entreeBatimentImmeuble =  Util.notEmpty(fichelieu.getEntreeBatimentImmeuble2()) ? fichelieu.getEntreeBatimentImmeuble2() : (Util.notEmpty(fichelieu.getEntreeBatimentImmeuble()) && getInfosAdressePhysique) ? fichelieu.getEntreeBatimentImmeuble() : "";
		String ndeVoie =  Util.notEmpty(fichelieu.getNdeVoie2()) ? fichelieu.getNdeVoie2() : (Util.notEmpty(fichelieu.getNdeVoie()) && getInfosAdressePhysique) ? fichelieu.getNdeVoie() : "";
		String libelleDeVoie =  Util.notEmpty(fichelieu.getLibelleDeVoie2()) ? fichelieu.getLibelleDeVoie2() : (Util.notEmpty(fichelieu.getLibelleDeVoie()) && getInfosAdressePhysique) ? fichelieu.getLibelleDeVoie() : "";
		String lieudit =  Util.notEmpty(fichelieu.getLieudit2()) ? fichelieu.getLieudit2() : (Util.notEmpty(fichelieu.getLieudit()) && getInfosAdressePhysique) ? fichelieu.getLieudit() : "";
		String codePostal =  Util.notEmpty(fichelieu.getCodePostal2()) ? fichelieu.getCodePostal2() : (Util.notEmpty(fichelieu.getCodePostal()) && getInfosAdressePhysique) ? fichelieu.getCodePostal() : "";

		if(Util.isEmpty(etageCouloirEscalier) &&  Util.isEmpty(entreeBatimentImmeuble) && Util.isEmpty(ndeVoie) 
				&& Util.isEmpty(libelleDeVoie)	&& Util.isEmpty(lieudit) && Util.isEmpty(codePostal) 
				&& Util.isEmpty(communeEcrire) && Util.isEmpty(fichelieu.getCs2()) && Util.isEmpty(fichelieu.getCedex2())) {
				return "";
		}
		

		return SocleUtils.formatAddress(fichelieu.getLibelleAutreAdresse(),
				etageCouloirEscalier, entreeBatimentImmeuble, ndeVoie,
				libelleDeVoie, lieudit, fichelieu.getCs2(), codePostal, communeEcrire,
				fichelieu.getCedex2());
	}
	
	
	/**
	 * <p>Concatène et formate toutes les infos d'une adresse en un String à partir d'une Delegation sous la forme suivante :</p>
	 * <p>Règle de gestion : </p>
	 * <p>- Si tous les champs de l'adresse postale sont vides on n'affiche rien. </p>
	 * <p>- Si seuls les champs "cedex" et "CS" de l'adresse postale sont remplis on récupère les autres champs de l'adresse physique. </p>
	 * <p>- Si le champ "libellé de voie" de l'adresse postale est renseigné alors on affiche les autres champs de l'adresse postale et</p>
	 * <p> on n'affiche aucun champ de l'adresse physique.</p>
	 * <p></p>
	 * <p>[libelle]<br\></p>
	 * <p>[etageCouloirEscalier]<br\></p>
	 * <p>[entreBatimentImmeuble]<br\></p>
	 * <p>[nDeVoie] [libelleDeVoie]<br\></p>
	 * <p>[lieuDit]<br\></p>
	 * <p>CS [cs]<br\></p>
	 * <p>[codePostal] [commune] Cedex [cedex]</p>
	 * 
	 * @param delegation
	 * @return un String contenant l'adresse de la FicheLieu
	 */
	public static String formatAdresseEcrire(Delegation delegation) {
		
		String communeEcrire = Util.notEmpty(delegation.getCommune2()) ? delegation.getCommune2().getTitle() : Util.notEmpty(delegation.getCommune()) ? delegation.getCommune().getTitle() : "";
		String etageCouloirEscalier =  Util.notEmpty(delegation.getEtageCouloirEscalier2()) ? delegation.getEtageCouloirEscalier2() : delegation.getEtageCouloirEscalier();
		String entreeBatimentImmeuble =  Util.notEmpty(delegation.getEntreeBatimentImmeuble2()) ? delegation.getEntreeBatimentImmeuble2() : delegation.getEntreeBatimentImmeuble();
		String ndeVoie =  Util.notEmpty(delegation.getNdeVoie2()) ? delegation.getNdeVoie2() : delegation.getNdeVoie();
		String libelleDeVoie =  Util.notEmpty(delegation.getLibelleDeVoie2()) ? delegation.getLibelleDeVoie2() : delegation.getLibelleDeVoie();
		String lieudit =  Util.notEmpty(delegation.getLieudit2()) ? delegation.getLieudit2() : delegation.getLieudit();
		String codePostal =  Util.notEmpty(delegation.getCodePostal2()) ? delegation.getCodePostal2() : delegation.getCodePostal();
		
		return SocleUtils.formatAddress(delegation.getLibelleAutreAdresse(),
				etageCouloirEscalier, entreeBatimentImmeuble, ndeVoie,
				libelleDeVoie, lieudit, delegation.getCs2(), codePostal, communeEcrire,
				delegation.getCedex2());
	}

	/**
	 * <p>Concatène et formate toutes les infos d'une adresse en un String à partir d'une Delegation sous la forme suivante :</p>
	 * <p>[libelle]<br\></p>
	 * <p>[etageCouloirEscalier]<br\></p>
	 * <p>[entreBatimentImmeuble]<br\></p>
	 * <p>[nDeVoie] [libelleDeVoie]<br\></p>
	 * <p>[lieuDit]<br\></p>
	 * <p>CS [cs]<br\></p>
	 * <p>[codePostal] [commune] Cedex [cedex]</p>
	 * 
	 * @param fichelieu
	 * @return un String contenant l'adresse physique de la FicheLieu
	 */
	public static String formatAdressePhysique(FicheLieu fichelieu) {
	
		return SocleUtils.formatAddress("", fichelieu.getEtageCouloirEscalier(), fichelieu.getEntreeBatimentImmeuble(),
				fichelieu.getNdeVoie(), fichelieu.getLibelleDeVoie(), fichelieu.getLieudit(),
				"", fichelieu.getCodePostal(), Util.notEmpty(fichelieu.getCommune()) ? fichelieu.getCommune().getTitle() : "", "");
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
    public static String formatCategories(Set<Category> categories) {
        return formatCategories(new ArrayList<Category>(categories), ", ");
    }
    
    /**
     * Génère un String selon une liste de catégories, de format (ici pour 3 catégories) : [nom cat1], [nom cat2], [nom cat3]
     * @param categories
     * @return
     */
    public static String formatCategories(Set<Category> categories, String separator) {
        return formatCategories(new ArrayList<Category>(categories), separator);
    }
    
    /**
     * Génère un String selon une liste de catégories, de format (ici pour 3 catégories) : [nom cat1], [nom cat2], [nom cat3]
     * @param categories
     * @return
     */
    public static String formatCategories(List<Category> categories) {
        return formatCategories(categories, ", ");
    }
    
    /**
     * Génère un String selon une liste de catégories, de format (ici pour 3 catégories) : [nom cat1], [nom cat2], [nom cat3]
     * Le séparateur est sélectionné dans la méthode
     * @param categories
     * @param separator
     * @return
     */
    public static String formatCategories(List<Category> categories, String separator) {
        
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
		if(Util.notEmpty(pubFullGabarit)) {
		  jsonObject.addProperty("content_html", pubFullGabarit);
    }
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
	 * Retourne l'URL d'une image principale ou d'un substitut pour le contenu indiqué
	 * @param pub
	 * @return
	 */
	public static String getImagePrincipale(Publication pub) {
	  String image = "";
	  
	  LOGGER.debug("getImagePrincipale " + pub);
	  try {
      image = (String) pub.getFieldValue("imagePrincipale");
      if (Util.notEmpty(image)) return image;
    } catch (Exception e) {
      LOGGER.debug(debugNoImagePrincipale);
    }
	  try {
      image = (String) pub.getFieldValue("image");
      if (Util.notEmpty(image)) return image;
    } catch (Exception e) {
      LOGGER.debug(debugNoImagePrincipale);
    }
	  try {
      image = (String) pub.getFieldValue("imageBandeau");
      if (Util.notEmpty(image)) return image;
    } catch (Exception e) {
      LOGGER.debug(debugNoImageBandeau);
    }
	  try {
      image = (String) pub.getFieldValue("imageMobile");
      if (Util.notEmpty(image)) return image;
    } catch (Exception e) {
      LOGGER.debug(debugNoImageMobile);
    }
	  
	  return "";
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
   * Retourne l'URL d'une image bandeau ou d'un substitut pour le contenu indiqué
   * @param pub
   * @return
   */
	public static String getImageBandeau(Publication pub) {
	  String image = "";
    
    LOGGER.debug("getImageBandeau " + pub);
    try {
      image = (String) pub.getFieldValue("imageBandeau");
      if (Util.notEmpty(image)) return image;
    } catch (Exception e) {
      LOGGER.debug(debugNoImageBandeau);
    }
    try {
      image = (String) pub.getFieldValue("imagePrincipale");
      if (Util.notEmpty(image)) return image;
    } catch (Exception e) {
      LOGGER.debug(debugNoImagePrincipale);
    }
    try {
      image = (String) pub.getFieldValue("image");
      if (Util.notEmpty(image)) return image;
    } catch (Exception e) {
      LOGGER.debug(debugNoImagePrincipale);
    }
    try {
      image = (String) pub.getFieldValue("imageMobile");
      if (Util.notEmpty(image)) return image;
    } catch (Exception e) {
      LOGGER.debug(debugNoImageMobile);
    }
    
    return "";
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
   * Retourne l'URL d'une image mobile ou d'un substitut pour le contenu indiqué
   * @param pub
   * @return
   */
  public static String getImageMobile(Publication pub) {
    String image = "";
    
    LOGGER.debug("getImageMobile " + pub);
    try {
      image = (String) pub.getFieldValue("imageMobile");
      if (Util.notEmpty(image)) return image;
    } catch (Exception e) {
      LOGGER.debug(debugNoImageMobile);
    }
    try {
      image = (String) pub.getFieldValue("imagePrincipale");
      if (Util.notEmpty(image)) return image;
    } catch (Exception e) {
      LOGGER.debug(debugNoImagePrincipale);
    }
    try {
      image = (String) pub.getFieldValue("image");
      if (Util.notEmpty(image)) return image;
    } catch (Exception e) {
      LOGGER.debug(debugNoImagePrincipale);
    }
    try {
      image = (String) pub.getFieldValue("imageBandeau");
      if (Util.notEmpty(image)) return image;
    } catch (Exception e) {
      LOGGER.debug(debugNoImageBandeau);
    }
    
    return "";
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
   * Retourne l'URL d'une image carree ou d'un substitut pour le contenu indiqué
   * @param pub
   * @return
   */
  public static String getImageCarree(Publication pub) {
    String image = "";
    
    LOGGER.debug("getImageCarree " + pub);
    
    try {
      image = (String) pub.getFieldValue("imageCarree");
      if (Util.notEmpty(image)) return image;
    } catch (Exception e) {
      LOGGER.debug(debugNoImageCarree);
    }
    try {
      image = (String) pub.getFieldValue("imageMobile");
      if (Util.notEmpty(image)) return image;
    } catch (Exception e) {
      LOGGER.debug(debugNoImageMobile);
    }
    try {
      image = (String) pub.getFieldValue("imagePrincipale");
      if (Util.notEmpty(image)) return image;
    } catch (Exception e) {
      LOGGER.debug(debugNoImagePrincipale);
    }
    try {
      image = (String) pub.getFieldValue("image");
      if (Util.notEmpty(image)) return image;
    } catch (Exception e) {
      LOGGER.debug(debugNoImagePrincipale);
    }
    try {
      image = (String) pub.getFieldValue("imageBandeau");
      if (Util.notEmpty(image)) return image;
    } catch (Exception e) {
      LOGGER.debug(debugNoImageBandeau);
    }
    
    return "";
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
   * Génère une image témoignage formattée et renvoie son path
   * @param imagePath
   * @return
   */
  public static String getUrlOfFormattedImageTemoignage(String imagePath) {
    return generateVignette(imagePath, channel.getIntegerProperty("jcmsplugin.socle.image.temoignage.width", 0), channel.getIntegerProperty("jcmsplugin.socle.image.temoignage.height", 0)); 
  }  
  
  /**
   * Génère une image carrousel desktop pour le bloc accueil et renvoie son path
   * @param imagePath
   * @return
   */
  public static String getUrlOfFormattedImageCarouselAccueilFull(String imagePath) {
    return generateVignette(imagePath, channel.getIntegerProperty("jcmsplugin.socle.image.carrouselaccueil.full.width", 0), channel.getIntegerProperty("jcmsplugin.socle.image.carrouselaccueil.full.height", 0)); 
  }
  
  /**
   * Génère une image carrousel mobile pour le bloc accueil et renvoie son path
   * @param imagePath
   * @return
   */
  public static String getUrlOfFormattedImageCarouselAccueilMobile(String imagePath) {
    return generateVignette(imagePath, channel.getIntegerProperty("jcmsplugin.socle.image.carrouselaccueil.mobile.width", 0), channel.getIntegerProperty("jcmsplugin.socle.image.carrouselaccueil.mobile.height", 0)); 
  }
  
  /**
   * Génère une image carrousel carrée pour le bloc accueil et renvoie son path
   * @param imagePath
   * @return
   */
  public static String getUrlOfFormattedImageCarouselAccueilCarree(String imagePath) {
    return generateVignette(imagePath, channel.getIntegerProperty("jcmsplugin.socle.image.carrouselaccueil.carree.width", 0), channel.getIntegerProperty("jcmsplugin.socle.image.carrouselaccueil.carree.height", 0)); 
  }
  
  /**
   * Génère une image formattée pour le type "Fiche publication" et renvoie son path
   * @param imagePath
   * @return
   */
  public static String getUrlOfFormattedImageMagazine(String imagePath) {
    return generateVignette(imagePath, channel.getIntegerProperty("jcmsplugin.socle.image.magazine.width", 0), channel.getIntegerProperty("jcmsplugin.socle.image.magazine.height", 0)); 
  }  
  
  /**
   * Génère une image formattée et renvoie son path
   * @param imagePath
   * @return
   */
  public static String generateVignette(String imagePath, int width, int height) {
    if (Util.notEmpty(imagePath) && Util.notEmpty(width) && Util.notEmpty(height)) {
      return ThumbnailTag.buildThumbnail(imagePath, width, height, imagePath); 
    }
    return "";
  }
  
  /**
   * Récupère une commune à partir de son code ville
   * @param communeName
   * @return
   */
  public static City getCommuneFromCode(String communeCode) {
    if (Util.isEmpty(communeCode)) {
      return null;
    }
    Set<City> setCities = channel.getDataSet(City.class);
    for (City itCity : setCities) {
      if (itCity.getCityCode() == Integer.parseInt(communeCode)) {
        return itCity;
      }
    }
    return null;
  }
    
  /**
   * Renvoie les paramètres de la recherche à facette dans un format standard dans une hashMap
   * @param request
   * @return
   */
  public static Map<String, String[]> getFacetsParameters(HttpServletRequest request) {
    Enumeration<String> enumParams = request.getParameterNames();
    Map<String, String[]> parametersMap = new HashMap<String, String[]>();
    while(enumParams.hasMoreElements()) {
      String nameParam = enumParams.nextElement();
      String itNameKey = null;
      if(nameParam.contains(JcmsUtil.glpd("jcmsplugin.socle.facette.form-element")) && nameParam.contains("[value]")){
        // paramètre classique de la recherche à facettes
        itNameKey = nameParam.substring(0, nameParam.indexOf(JcmsUtil.glpd("jcmsplugin.socle.facette.form-element")));
      } else if(nameParam.startsWith("map")){
        // Position de la carte
        itNameKey = nameParam.replace("[0]", "[long]").replace("[1]", "[lat]");
      } else if(nameParam.contains("[latitude]") || nameParam.contains("[longitude]")) {
        // Adresses de précisse (provenant de la BAN)
        if(nameParam.contains("[latitude]")) {
          itNameKey = "latitude";
        } else {
          itNameKey = "longitude";
        }
      }
      else if(nameParam.contains("[value]")) {
    	  itNameKey = nameParam.replace("[value]", "");
      }
      // Enregistre les paramètres dans une map dans un format plus classique pour le serveur
      if(Util.notEmpty(itNameKey)) {
        if(parametersMap.containsKey(itNameKey)){
          parametersMap.put(itNameKey, (String[])ArrayUtils.add(parametersMap.get(itNameKey), request.getParameter(nameParam)));
        }else {
          parametersMap.put(itNameKey, new String[]{request.getParameter(nameParam)});
        }
      }
    }
    // Action spéciale pour la facette délégation
    // Transforme la commune en délégation
    if(parametersMap.containsKey("delegationSearch") && parametersMap.containsKey("commune")) {
      String codeCommune = Util.getFirst(parametersMap.get("commune"));
      City commune = SocleUtils.getCommuneFromCode(codeCommune);
      parametersMap.put("delegation", new String[] {commune.getDelegation().getId()});
      parametersMap.remove("commune");      
    }
    return parametersMap;
  }
  
  /**
   * Renvoie les paramètres du formulaire en ajoutant les paramètres nécessaires à JCMS :
   * Les champs visibles du formulaire sont envoyés via le JS via les paramètres NOMDUCHAMP[text] et NOMDUCHAMP[value]
   * Les champs cachés sont envoyés avec seulement NOMDUCHAMP[value]
   * Il faut donc rajouter les champs initiaux NOMDUCHAMP à la requete pour pouvoir être traités par JCMS.
   * Par ailleurs pour les champs cachés, il n'est pas utile de renvoyer le paramètre NOMDUCHAMP[value]
   * @param request
   * @return
   */
  public static Map<String, String[]> getFormParameters(HttpServletRequest request) {
    Enumeration<String> enumParams = request.getParameterNames();
    Map<String, String[]> parametersMap = new HashMap<String, String[]>();
    while(enumParams.hasMoreElements()) {
      String nameParam = enumParams.nextElement();  
      String itNameKey = null;
      String itNameKeyText = null;
      String itNameKeyValue = null;
      // On ajoute les paramètres nécessaires au JS (paramètres NOMDUCHAMP[text] et NOMDUCHAMP[value])
      if(nameParam.contains("[text]")){  
      	itNameKey = nameParam.replaceAll("\\[text\\]","");
      	itNameKeyText = itNameKey+"[text]";
      	itNameKeyValue = itNameKey+"[value]";
      	parametersMap.put(HttpUtil.encodeForURL(itNameKeyText), new String[]{request.getParameter(itNameKeyText)});
      	parametersMap.put(HttpUtil.encodeForURL(itNameKeyValue), new String[]{request.getParameter(itNameKeyValue)});
       } 
      // On ajoute les autres champs du formulaire natif JCMS. On enlève le [value] du nom du champ.
       else if(nameParam.contains("[value]")) {
       	itNameKey = nameParam.replace("[value]", "");
       	parametersMap.put(itNameKey, new String[]{request.getParameter(nameParam)});
       }

    }
    return parametersMap;
  }  
  
  /**
   * Retourne la fonction d'un membre élu, en commençant ou non par une majuscule
   * @param pub
   * @param majuscule
   * @return
   */
  public static String getElectedMemberFunction(ElectedMember pub, Boolean majuscule) {
    String position = "";
    // Cas : est président / présidente
    if (pub.getFunctions(channel.getCurrentLoggedMember()).contains(channel.getCategory("$jcmsplugin.socle.elu.president"))) {
      position = pub.getGender() ? JcmsUtil.glp(channel.getCurrentUserLang(), "jcmsplugin.socle.elu.president.masculin") : JcmsUtil.glp(channel.getCurrentUserLang(), "jcmsplugin.socle.elu.president.feminin");
    }
    // Cas : est vice-président / vice-présidente
    if (pub.getFunctions(channel.getCurrentLoggedMember()).contains(channel.getCategory("$jcmsplugin.socle.elu.vicepresident"))) {
      if(majuscule) {
        position = pub.getGender() ? JcmsUtil.glp(channel.getCurrentUserLang(), "jcmsplugin.socle.elu.vicepresident.masculin.maj") : JcmsUtil.glp(channel.getCurrentUserLang(), "jcmsplugin.socle.elu.vicepresident.feminin.maj");
      } else {
        position = pub.getGender() ? JcmsUtil.glp(channel.getCurrentUserLang(), "jcmsplugin.socle.elu.vicepresident.masculin.min") : JcmsUtil.glp(channel.getCurrentUserLang(), "jcmsplugin.socle.elu.vicepresident.feminin.min");
      }
    }
    for (Category itCat : pub.getFunctions(channel.getCurrentLoggedMember())) {
      if (itCat.getParent().equals(channel.getCategory("$jcmsplugin.socle.elu.vicepresident"))) {
        if (Util.isEmpty(position)) {
          if(majuscule) {
            position = pub.getGender() ? JcmsUtil.glp(channel.getCurrentUserLang(), "jcmsplugin.socle.elu.vicepresident.masculin.maj") + " " : JcmsUtil.glp(channel.getCurrentUserLang(), "jcmsplugin.socle.elu.vicepresident.feminin.maj") + " ";
          } else {
            position = pub.getGender() ? JcmsUtil.glp(channel.getCurrentUserLang(), "jcmsplugin.socle.elu.vicepresident.masculin.min") + " " : JcmsUtil.glp(channel.getCurrentUserLang(), "jcmsplugin.socle.elu.vicepresident.feminin.min") + " ";
          }
        } else {
          position += " ";
        }
        position += itCat.getName();
        return position;
      }
    }
    return position;
  }
  
  /**
   * Retourne la fonction d'un membre élu
   * @param pub
   * @return
   */
  public static String getElectedMemberFunction(ElectedMember pub) {
	  return getElectedMemberFunction(pub, true);
  }
  
  /**
   * Retourne le binôme d'un membre élu
   * @param pub
   */
  public static ElectedMember getElectedMemberBinome(ElectedMember elu) {
    if (Util.isEmpty(elu) || Util.isEmpty(elu.getCanton())) {
      return null;
    }
    
    Canton mbrCanton = elu.getCanton();
    TreeSet<ElectedMember> linkedElus = (TreeSet<ElectedMember>) mbrCanton.getLinkIndexedDataSet(ElectedMember.class).clone();
    
    linkedElus.remove(elu);
    
    return linkedElus.first();
  }
  
  /**
   * Retourne le nom complet de l'élu
   * @param elu
   * @return
   */
  public static String getElectedMemberFullName(ElectedMember elu) {
    String fullName = "";
    if(Util.notEmpty(elu.getFirstName())) {
    	fullName = elu.getFirstName()+" ";
    }
    if(Util.notEmpty(elu.getFirstName()) && Util.notEmpty(elu.getNom())) {
    	fullName += " ";
    }
    if(Util.notEmpty(elu.getNom())) {
    	fullName += elu.getNom();
    }
    return fullName;
  }
  
  /**
   * Retourne l'intitulé de mission de l'élu
   * @param elu
   * @return
   */
  public static String getElectedMemberMissionString(ElectedMember elu) {
		
		if(Util.isEmpty(elu.getMissionThematique(channel.getCurrentLoggedMember()))) return "";
		
		StringBuffer sbfMission = new StringBuffer();
		sbfMission.append(JcmsUtil.glp(channel.getCurrentUserLang(), "jcmsplugin.socle.elu.mission-thematique")).
			append(" ");
		for(Category itCat : elu.getMissionThematique(channel.getCurrentLoggedMember())) {
			sbfMission.append(itCat.getName())
				.append(" ");
		}
		ElectedMember linkedElu = elu.getVicepresidentLie();
		if(Util.notEmpty(linkedElu)) {
			sbfMission.append(JcmsUtil.glp(channel.getCurrentUserLang(), "jcmsplugin.socle.elu.en-lien-avec"))
				.append(" ");
			if(Util.notEmpty(getElectedMemberFullName(linkedElu))) {
				sbfMission.append(getElectedMemberFullName(linkedElu))
					.append(", ");
			}
			String roleLinkedElu = getElectedMemberFunction(linkedElu, false);
			if(Util.notEmpty(roleLinkedElu)) {
				sbfMission.append(roleLinkedElu);
			}
		}
		return sbfMission.toString();
  }
  
  /**
   * Retourne la fonction complète de vice-president de l'élu
   * @param elu
   * @return
   */
  public static String getElectedMemberFullFunctionVicePresident(ElectedMember elu) {
		if(Util.notEmpty(elu.getFunctions(channel.getCurrentLoggedMember()))) {
			Category catVicePresident = null;
			for(Category itCat : elu.getFunctions(channel.getCurrentLoggedMember())) {
				Category itParent = itCat.getParent();
				if (itParent.equals(channel.getCategory("$jcmsplugin.socle.elu.vicepresident"))) {
					catVicePresident = itCat;
					break;
				}
			}
			if (Util.notEmpty(catVicePresident)) {
				String fullRole = elu.getGender() ? JcmsUtil.glp(channel.getCurrentUserLang(), "jcmsplugin.socle.elu.vicepresident.masculin.maj") : JcmsUtil.glp(channel.getCurrentUserLang(), "jcmsplugin.socle.elu.vicepresident.feminin.maj");
				return "<b>" + fullRole + " " + catVicePresident.getName() + "</b>";
			}
		}
		return "";
  }
  
  /**
   * Retourne le label de l'année d'éléction de l'élu
   * @param elu
   * @return
   */
  public static String getElectedMemberElectionYear(ElectedMember elu) {
		int anneeElection = elu.getFirstElectionYear();
		if(Util.notEmpty(anneeElection) && anneeElection > 0) {
			String labelAnneeElection = "";
			if(elu.getNouvelEluOuReelu()) {
				if(elu.getGender()) {
					labelAnneeElection = JcmsUtil.glp(channel.getCurrentUserLang(), "jcmsplugin.socle.elu.elu-en", anneeElection);
				} else {
					labelAnneeElection = JcmsUtil.glp(channel.getCurrentUserLang(), "jcmsplugin.socle.elu.elue-en", anneeElection);
				}
			} else {
				if(elu.getGender()) {
					labelAnneeElection = JcmsUtil.glp(channel.getCurrentUserLang(), "jcmsplugin.socle.elu.reelu-en", anneeElection);
				} else {
					labelAnneeElection = JcmsUtil.glp(channel.getCurrentUserLang(), "jcmsplugin.socle.elu.reelue-en", anneeElection);
				}
			}
			return labelAnneeElection;
		}
		return "";
  }
  
  /**
   * Indique si une publication peut être rechercheable ou pas
   * Se base sur une catégorie de classement.
   * Si la propriété est inexistante ou vide, renvoie false.
   * @param pub
   * @return <code>true</code> si la publication doit être masquée sinon <code>false</code> 
   * 
   */
  public static boolean isNonRepertoriee(Publication pub) {
  	return pub.containsCategory(channel.getCategory("$jcmsplugin.socle.recherche.nonrepertoriee.cat"));
  }  
  
  /**
   * Renvoie un prix formatté à un format propre. Exemple : 45000 -> 45 000
   * @param price
   * @return
   */
  public static String formatPrice(String price) {
    if (Util.isEmpty(price)) return "";
    
    String invertedPrice = new StringBuilder(price).reverse().toString();
    invertedPrice = invertedPrice.replaceAll("...", "$0 ");
    
    return new StringBuilder(invertedPrice).reverse().toString();
  }
  
  /**
   * Renvoie un prix formatté à un format propre. Exemple : 45000 -> 45 000
   * @param price
   * @return
   */
  public static String formatPrice (Integer price) {
    if (Util.isEmpty(price)) return "";
    return formatPrice(price.toString());
  }
  
  /**
   * Renvoie la fiche contact associée à un membre, si elle existe
   * @param mbr
   * @return
   */
  public static Contact getContactFromMembre(Member mbr) {
    QueryHandler qh = new QueryHandler();
    qh.setExactType(true);
    qh.setTypes("Contact");
    qh.setText(mbr.getFullName());
    qh.setLoggedMember(Channel.getChannel().getCurrentLoggedMember());
    QueryResultSet result = qh.getResultSet();
    
    if (Util.notEmpty(result)) {
      return (Contact) result.getAsSortedSet().first();
    }
    
    return null;
  }
	
  
  /**
   * Retourne le libellé avec des règles spécifiques pour la classe concernée (ne correspond pas au libellé en BO)
   * @param pub
   * @param userLang
   * @return
   */
  public static String getTypeLibelle(Publication pub, String userLang) {
    String libelle = "";
    if(pub instanceof ElectedMember) {
      // Pour les élus suivant le genre
      ElectedMember elu = (ElectedMember) pub;
      libelle = elu.getGender() ? JcmsUtil.glp (userLang, "jcmsplugin.socle.elu.conseiller.masculin") : JcmsUtil.glp(userLang, "jcmsplugin.socle.elu.conseiller.feminin");      
    }else if(pub instanceof FicheEmploiStage) {
      // Pour les emplois suivant le type d'emploi
      FicheEmploiStage ficheEmploi = (FicheEmploiStage) pub;
      Category typeRootCat = channel.getCategory("$jcmsplugin.socle.emploiStage.typeOffre.root");
      Category typeCat = ficheEmploi.getFirstTypeDoffre(channel.getCurrentLoggedMember());
      while(!JcmsUtil.isSameId(typeCat.getParent(), typeRootCat)) {
        typeCat = typeCat.getParent();
      }
      libelle = JcmsUtil.glp(userLang, "jcmsplugin.socle.recherche.type." +  ficheEmploi.getClass().getSimpleName() + "." + typeCat.getId());
    }else if(pub instanceof AccueilAnnuaireAgenda) {
      // Pour l'agenda/annuaire
      AccueilAnnuaireAgenda accueil = (AccueilAnnuaireAgenda) pub;
      libelle = accueil.getTypeAnnuaire() ? JcmsUtil.glp (userLang, "jcmsplugin.socle.recherche.type.AccueilAnnuaireAgenda.annuaire") : JcmsUtil.glp(userLang, "jcmsplugin.socle.recherche.type.AccueilAnnuaireAgenda.agenda");
    }else if( !JcmsUtil.glp(userLang, "jcmsplugin.socle.recherche.type." + pub.getClass().getSimpleName()).equals("jcmsplugin.socle.recherche.type." + pub.getClass().getSimpleName())) {
      // Si un nom existe en proprité de langue prendre celui-ci en priorité
      libelle = JcmsUtil.glp(userLang, "jcmsplugin.socle.recherche.type." + pub.getClass().getSimpleName());
    }else {
      // Prend le nom du BO
      libelle = Util.recapitalize(channel.getTypeLabel(pub.getClass(), userLang));
    }
    return libelle;
  }
  
}
