package fr.cg44.plugin.socle;

import static com.jalios.jcms.Channel.getChannel;

import java.io.BufferedReader;
import java.io.File;
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
import java.util.Locale;
import java.util.Map;
import java.util.Set;
import java.util.SortedSet;
import java.util.TreeSet;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.ArrayUtils;
import org.apache.log4j.Logger;

import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.jalios.io.ImageFormat;
import com.jalios.jcms.Category;
import com.jalios.jcms.Channel;
import com.jalios.jcms.Content;
import com.jalios.jcms.DataSelector;
import com.jalios.jcms.FileDocument;
import com.jalios.jcms.HttpUtil;
import com.jalios.jcms.JcmsUtil;
import com.jalios.jcms.Member;
import com.jalios.jcms.Publication;
import com.jalios.jcms.QueryResultSet;
import com.jalios.jcms.context.JcmsJspContext;
import com.jalios.jcms.handler.QueryHandler;
import com.jalios.jcms.portlet.PortalElement;
import com.jalios.jcms.taglib.ThumbnailTag;
import com.jalios.jcms.wysiwyg.WysiwygRenderer;
import com.jalios.util.Util;

import generated.AbstractPortletFacette;
import generated.AccueilAnnuaireAgenda;
import generated.Canton;
import generated.CarouselElement;
import generated.City;
import generated.Contact;
import generated.Delegation;
import generated.ElectedMember;
import generated.FaqEntry;
import generated.FicheEmploiStage;
import generated.FicheLieu;
import generated.Lien;
import generated.PortletAgendaInfolocale;
import generated.PortletFacetteAdresse;
import generated.PortletFacetteCategoriesLiees;
import generated.PortletFacetteCommune;
import generated.PortletFacetteCommuneAdresseLiee;
import generated.PortletFaq;
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
	
	private static final String defaultSeparator = " / ";

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
	public static String formatAdressePhysique(FicheLieu fichelieu, boolean hideCs) {
	
		return SocleUtils.formatAddress("", fichelieu.getEtageCouloirEscalier(), fichelieu.getEntreeBatimentImmeuble(),
				fichelieu.getNdeVoie(), fichelieu.getLibelleDeVoie(), fichelieu.getLieudit(),
				hideCs ? null : fichelieu.getCs2(), fichelieu.getCodePostal(), Util.notEmpty(fichelieu.getCommune()) ? fichelieu.getCommune().getTitle() : "", fichelieu.getCedex2());
	}	
	
	public static String formatAdressePhysique(FicheLieu fichelieu) {
	    return formatAdressePhysique(fichelieu, false);
	}

	
	/**
	 * <p>Concatène et formate toutes les infos d'une adresse en un String à partir d'une Commune sous la forme suivante :</p>adresse
	 * <p>[adresse mairie]<br\></p>
	 * <p>CS [cs]<br\></p>
	 * <p>[codePostal] [commune]</p>
	 * 
	 * @param commune
	 * @return un String contenant l'adresse physique de la commune
	 */
	public static String formatAdresseCommune(City city) {
	
		String adresseMairie = city.getCouncilBuildingAddress().replaceAll("[\\r\\n]+", "");
		
	    if(adresseMairie.replaceAll("[\\r\\n]+", "").lastIndexOf("</p></div>") != -1){
	        adresseMairie = adresseMairie.substring(0, adresseMairie.replaceAll("[\\r\\n]+", "").lastIndexOf("</p></div>"));
	    }
	    
	    return adresseMairie + "<br/>" + SocleUtils.formatAddress(null, null, null, null, null, null, city.getPostalBox(), city.getZipCode(), city.getTitle(), null) + "</p></div>";
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
        if (Util.isEmpty(categories)) return "";
        return formatCategories(new ArrayList<Category>(categories), ", ");
    }
    
    /**
     * Génère un String selon une liste de catégories, de format (ici pour 3 catégories) : [nom cat1], [nom cat2], [nom cat3]
     * @param categories
     * @return
     */
    public static String formatCategories(Set<Category> categories, String separator) {
      if (Util.isEmpty(categories)) return "";
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
            String title = Util.isEmpty(itCat.getExtraData("extra.Category.plugin.tools.synonyme.facet.title")) ? itCat.getName(channel.getCurrentUserLang()) : itCat.getExtraData("extra.Category.plugin.tools.synonyme.facet.title");
            formatted.append(title);
            if (iter.hasNext()) formatted.append(separator);
        }
        
        return formatted.toString();
    }
    
    /**
     * Liste les IDs d'un set de catégories selon un séparateur
     * @param treeSet
     * @return
     */
    public static String listCategoriesId(Set<Category> treeSet) {
      
      if (Util.isEmpty(treeSet)) return "";
      
      String separator = ", ";
      
      StringBuilder formatted = new StringBuilder();
      
      for (Iterator<Category> iter = treeSet.iterator(); iter.hasNext();) {
        Category itCat = (Category) iter.next();
        formatted.append(itCat.getId());
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
		return 	citiestoJsonArray(false, communes);
	}
	
	
	/**
	 * Retourne les communes sous forme de json
	 * @param communes
	 * @param forceLinkedField
	 * @return
	 */
	public static JsonArray citiestoJsonArray(boolean allCommunes, boolean forceLinkedField, Publication... communes) {
	  JsonArray jsonArray = new JsonArray();
	  if(Util.notEmpty(communes)) {
	    for(Publication itPub : communes) {
	      City itCity = (City) itPub;
	      JsonObject itJsonObject = new JsonObject();
	      String cityCode = Integer.toString(itCity.getCityCode());
	      itJsonObject.addProperty("id", cityCode);
	      itJsonObject.addProperty("value", itCity.getTitle());       
	      JsonObject itJsonMetaObject = new JsonObject();
	      if(!allCommunes) {
	        String[] needAdress = channel.getStringArrayProperty("jcmsplugin.socle.cities.needAddress", new String[]{});
	        itJsonMetaObject.addProperty("hasLinkedField", Util.arrayContains(needAdress, cityCode) || forceLinkedField); 
	      }
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
	public static JsonArray citiestoJsonArray(boolean allCommunes, Publication... communes) {
	  return citiestoJsonArray(allCommunes, false, communes);
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
  public static JsonArray citiestoJsonArray(boolean allCommunes, Collection<Publication> communes) {   
    return citiestoJsonArray(allCommunes, false, communes.toArray(new City[communes.size()]));
  }
  
  /**
   * Retourne les communes sous forme de json
   * @param communes
   * @return
   */
  public static JsonArray citiestoJsonArray(boolean allCommunes, boolean forceLinkedField, Collection<Publication> communes) {   
    return citiestoJsonArray(allCommunes, forceLinkedField, communes.toArray(new City[communes.size()]));
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
   * Retourne les communes sous forme de json
   * @param communes
   * @return
   */
  public static JsonArray citiestoJsonArray(boolean allCommunes, Set<City> communes) {   
    return citiestoJsonArray(allCommunes, communes.toArray(new City[communes.size()]));
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
		String id = pub instanceof Canton ? String.valueOf(((Canton) (pub)).getCantonCode()) : pub.getId();
		
		jsonObject.addProperty("value", pub.getTitle());
		if(Util.notEmpty(pubFullGabarit)) {
		  jsonObject.addProperty("content_html", pubFullGabarit);
		}
		JsonObject jsonMetaObject = new JsonObject();
		// Cas particulier pour les type de contenu Lien
		String url = channel.getUrl() + pub.getDisplayUrl(null);
		if(pub instanceof Lien) {
			Lien lien = (Lien) pub;
			if(Util.notEmpty(lien.getLienInterne())) {
				url = channel.getUrl() + lien.getLienInterne().getDisplayUrl(null);
				id =  lien.getLienInterne().getId();
			} else {
				url = lien.getLienExterne();
				jsonObject.addProperty("redirectUrl", true);
				jsonObject.addProperty("target", "_blank");
			}			
		}
		jsonObject.addProperty("id", id);
		jsonMetaObject.addProperty("url", url);
	  // Cas particulier pour le type de contenu Contact
    if (pub instanceof Contact) {
      jsonObject.remove("id");
      jsonObject.addProperty("id", "-1");
    }
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
   * Génère une image en avant formattée et renvoie son path
   * @param imagePath
   * @return
   */
  public static String getUrlOfFormattedImageEnAvant(String imagePath) {
    return generateVignette(imagePath, channel.getIntegerProperty("jcmsplugin.socle.image.enavant.width", 0), channel.getIntegerProperty("jcmsplugin.socle.image.enavant.height", 0)); 
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
   * Génère une image card formattée et renvoie son path
   * @param imagePath
   * @return
   */
  public static String getUrlOfFormattedImageCard(String imagePath) {
    return generateVignette(imagePath, channel.getIntegerProperty("jcmsplugin.socle.image.card.width", 0), channel.getIntegerProperty("jcmsplugin.socle.image.card.height", 0)); 
  }
  
  /**
   * Génère une image carrousel formattée et renvoie son path
   * @param imagePath
   * @return
   */
  public static String getUrlOfFormattedImageCarrousel(String imagePath) {
    return generateVignette(imagePath, channel.getIntegerProperty("jcmsplugin.socle.image.carrousel.width", 0), channel.getIntegerProperty("jcmsplugin.socle.image.carrousel.height", 0)); 
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
   * Génère une image formattée pour les images desktop dans un diaporama
   * @param imagePath
   * @return
   */
  public static String getUrlOfFormattedImageDiaporamaDesktop(String imagePath) {
    return generateVignette(imagePath, channel.getIntegerProperty("jcmsplugin.socle.image.diaporama.desktop.width", 0), channel.getIntegerProperty("jcmsplugin.socle.image.diaporama.desktop.height", 0)); 
  }
  
  /**
   * Génère une image formattée pour les images mobiles dans un diaporama
   * @param imagePath
   * @return
   */
  public static String getUrlOfFormattedImageDiaporamaMobile(String imagePath) {
    return generateVignette(imagePath, channel.getIntegerProperty("jcmsplugin.socle.image.diaporama.mobile.width", 0), channel.getIntegerProperty("jcmsplugin.socle.image.diaporama.mobile.height", 0)); 
  }
  
  /**
   * Génère une image formattée pour les vignettes dans un diaporama
   * @param imagePath
   * @return
   */
  public static String getUrlOfFormattedImageDiaporamaVignette(String imagePath) {
    return generateVignette(imagePath, channel.getIntegerProperty("jcmsplugin.socle.image.diaporama.vignette.width", 0), channel.getIntegerProperty("jcmsplugin.socle.image.diaporama.vignette.height", 0)); 
  }
  
  /**
   * Génère une image formattée pour les vignettes dans un format customisé
   * La largeur est fixe mais la hauteur dépend du ratio de l'image. 
   * @param imagePath
   * @return
   */
  public static String getUrlOfFormattedImageCustomMobile(String imagePath) {
    double ratio = SocleUtils.getRatio(imagePath);
    int imageWidth = channel.getIntegerProperty("jcmsplugin.socle.image.col4.width", 0);
    int imageHeight = (int)Math.round(imageWidth / ratio);
    return generateVignette(imagePath, imageWidth, imageHeight); 
  }  


	/**
	 * Fonction qui s'occupe de récupérer la bonne url en fonction du contexte, de la langue de l'utilisateur et de la contribution
	 * @param obj l'element carousel qui possède l'image dont on veut l'url
	 * @param userLang la langue de l'utilisateur
	 * @param jcmsContext contexte de navigation
	 * @return l'url de l'image a utiliser dans le carousel
	 */
	public static String getUrlImageElementCarousel(CarouselElement obj, String userLang, JcmsJspContext jcmsContext) {
		String urlImage = "";
		if (!jcmsContext.getBrowser().isSmallDevice()) {
			urlImage = obj.getImage(userLang, false);

			if (Util.isEmpty(urlImage)) {
				urlImage = obj.getImageMobile(userLang, false);
			}

			urlImage = getUrlOfFormattedImageDiaporamaDesktop(urlImage);
		} else {
			urlImage = obj.getImageMobile(userLang, false);

			if (Util.isEmpty(urlImage)) {
				urlImage = obj.getImage(userLang, false);
			}

			urlImage = getUrlOfFormattedImageDiaporamaMobile(urlImage);
		}
		return urlImage;
	}

	/**
	 * Retourne l'URL de l'image utilisée surles réseaux sociaux pour le contenu indiqué
	 * Permet d'alimenter la valeur de l'attribut "content" de la balise <meta property="og:image" content="XXX" /> 
	 * @param pub
	 * @return l'URL de l'image ou  une chaine vide
	 */
	public static String getImageForSocialNetworks(Publication pub) {
		String imagePath = getImagePrincipale(pub);
		if(Util.isEmpty(imagePath)) {
			imagePath = pub.getDataImage();
		}
		return imagePath;
	}
	
	/**
	 * Construit un tableau de CarouselElement a deux dimensions a partir d'un tableau simple et d'une dimension des sous tableaux.
	 * Par exemple : initCarouselElement2DArr({a, b, c, d, e}, 2) => {{a, b}, {c, d}, {e, null}} ;
	 *               initCarouselElement2DArr({a, b, c, d, e}, 3) => {{a, b, c}, {d, e, null}} ;
	 * @param allElemArr le tableau contenant tous les CarouselElement
	 * @param nbrElemDsSubArr la dimension des sous tableaux
	 * @return un tableau de CarouselElement à deux dimensions
	 */
	public static CarouselElement[][] initCarouselElement2DArr(CarouselElement[] allElemArr, int nbrElemDsSubArr) {
		int nbrTotalElem = allElemArr.length;
		
		int sizeArr = nbrTotalElem / nbrElemDsSubArr;
		if(nbrTotalElem % nbrElemDsSubArr > 0) sizeArr++;
		
		CarouselElement[][] elemCarousel2DArr = new CarouselElement[sizeArr][nbrElemDsSubArr];
		
		for(int i = 0; i < nbrTotalElem; i++) {
			elemCarousel2DArr[i/nbrElemDsSubArr][i%nbrElemDsSubArr] = allElemArr[i];
		}
		return elemCarousel2DArr;
	}
	
  /**
   * Vérifie si le lien est interne (soit qu'il référence un contenu du site), ou externe (soit une url qui pointe sur un autre site web)
   * @param url à vérifier
   * @return true si l'url est interne, false si l'url est externe
   */
  public static boolean isURLInterne(String url) {
    return (url.charAt(0) == '/' || url.startsWith(channel.getUrl()));
  }
  
  /**
   * Génère une image formattée et renvoie son path
   * @param imagePath
   * @return
   */
  public static String generateVignette(String imagePath, int width, int height) {       
    if (Util.notEmpty(imagePath) && Util.notEmpty(width) && Util.notEmpty(height)) {            
      File file = ThumbnailTag.createThumbnail(null, new File(channel.getRealPath(imagePath)), null, ImageFormat.JPEG, width, height);
      if(file != null) {
        return channel.getRelativePath(file);
      } else {
        LOGGER.debug("Echec de la génération de miniature pour " + imagePath);
      }
    }
    return imagePath;
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
    try {
        Set<City> setCities = channel.getDataSet(City.class);
        for (City itCity : setCities) {
          if (itCity.getCityCode() == Integer.parseInt(communeCode)) {
            return itCity;
          }
        }
    }
    catch (Exception e) {
        LOGGER.warn("Anomalie sur getCommuneFromCode : " + e.getMessage());
    }
    return null;
  }
  
  /**
   * Retourner le code INSEE d'une commune depuis son nom. Celui-ci doit être trouvé dans un QueryFilter
   * @param commune
   * @return
   */
  public static City getCommuneFromName(String commune) {
      QueryHandler qh = new QueryHandler();
      qh.setTypes(new String[] { City.class.getName() } );
      qh.setText(commune);
      QueryResultSet qrs = qh.getResultSet();
      SortedSet<Publication> set = qrs.getAsSortedSet();
      if (Util.isEmpty(set)) return null;
      return ((City)set.first());
  }
  
  /**
   * Récupère une commune à partir de son code postal
   * @param zipCode
   * @return
   */
  public static String getCitynameFromZipcode(String zipCode) {

   if (Util.isEmpty(zipCode)) {
     return "?";
   }

   if (zipCode.equals("44000") || zipCode.equals("44100") || zipCode.equals("44200") || zipCode.equals("44300")) {
     return "Nantes";
   }

   if (!zipCode.substring(0, 2).equals("44")) {
     return "hors département";
   }

   Set<City> setCities = channel.getDataSet(City.class);
   for (City itCity : setCities) {
   	if (itCity.getZipCode().trim().equals(zipCode)) {
 				return itCity.getTitle();
 			}
   }
   
   return "?";

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
      boolean skip = false;
      if(nameParam.contains("[value]") && nameParam.startsWith("agenda-date") && nameParam.contains("[form")) {
        // paramètre sur l'agenda, particulièrement sur les périodes choisies à la main
        itNameKey = "agenda-date";
        if (nameParam.contains("[position]")) {
          skip = true;
        }
      } else if (nameParam.startsWith("accessibilite")) {
        itNameKey = "accessibilite";
      } else if(nameParam.contains(JcmsUtil.glpd("jcmsplugin.socle.facette.form-element")) && nameParam.contains("[value]")){
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
      } else if(nameParam.contains("[value]") && (nameParam.startsWith("limitrophe") || nameParam.startsWith("epci"))) {
        itNameKey = "commune";
      }
      else if(nameParam.contains("[value]")) {
    	  itNameKey = nameParam.replace("[value]", "");
      }else if(!nameParam.contains("[")) {
        itNameKey = nameParam;
      }
      // Enregistre les paramètres dans une map dans un format plus classique pour le serveur
      if(Util.notEmpty(itNameKey) && !skip) {
        if(parametersMap.containsKey(itNameKey)){
          parametersMap.put(itNameKey, (String[])ArrayUtils.add(parametersMap.get(itNameKey), request.getParameter(nameParam)));
        }else {
          parametersMap.put(itNameKey, new String[]{request.getParameter(nameParam)});
        }
      }
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
    	fullName = elu.getFirstName();
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
			// Ajout de != null pour la vérification SonarCloud
			if (catVicePresident != null && Util.notEmpty(catVicePresident)) {
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
   * Renvoie un prix formatté à un format propre. Exemple : 45000 -> 45 000
   * @param price
   * @return
   */
  public static String formatPrice (Double price) {
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
      libelle = Util.notEmpty(typeCat.getExtraData("extra.Category.plugin.tools.synonyme.facet.title")) ? typeCat.getExtraData("extra.Category.plugin.tools.synonyme.facet.title") : typeCat.getName() ;    
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
  
  /**
   * Renvoie le nom d'un fichier sans son extension depuis une URL
   * Exemple : http://www.site.fr/docs/filename.docx retournera filename
   * @param url
   * @return
   */
  public static String getFilenameFromUrl(String url) {
    if (Util.isEmpty(url) || !url.contains("/") || url.charAt(url.length()-1) == '/') {
      return "";
    }
    return url.substring(url.lastIndexOf("/") + 1, url.lastIndexOf("."));
  }
  
  /**
   * Renvoie l'extension d'un fichier sans son nom depuis une URL
   * Exemple : http://www.site.fr/docs/filename.docx retournera docx
   * @param url
   * @return
   */
  public static String getFileExpensionFromUrl(String url) {
    if (Util.isEmpty(url) || !url.contains(".") || url.charAt(url.length()-1) == '.') {
      return "";
    }
    return url.substring(url.lastIndexOf(".") + 1);
  }
  
  
  /**
   * Récupère l'ID d'une vidéo dans un URL youtube
   * @param url
   * @return
   */
  public static String getIdOfYoutubeUrl(String url) {
    if (Util.isEmpty(url)) return "";
    String pattern = "(?<=watch\\?v=|/videos/|embed\\/|youtu.be\\/|\\/v\\/|\\/e\\/|watch\\?v%3D|watch\\?feature=player_embedded&v=|%2Fvideos%2F|embed%\u200C\u200B2F|youtu.be%2F|%2Fv%2F)[^#\\&\\?\\n]*";
    Pattern compiledPattern = Pattern.compile(pattern);
    Matcher matcher = compiledPattern.matcher(url);
    String ytId = "";
    if (matcher.find()) {
      ytId = matcher.group();
    }
    if (Util.notEmpty(ytId)) {
      return ytId;
    }
    return "";
  }

  
	/**
	 * Permet de récupérer la "PortletFaq" d'une catégorie si celle-ci existe
	 * et si son paramètrage s'applique à la catégorie du portail
	 * @param currentCat la catégorie courante
	 * @param portalCat la catégorie de navigation du portail
	 * @return La "PortletFaq" de la catégorie, sinon NULL
	 */
	public static PortletFaq getPortletFaq(Category itCat, Category portalCat) {
		Member loggedMember = channel.getCurrentLoggedMember();		
		QueryHandler qh = new QueryHandler();
		qh.setTypes("PortletFaq");
		qh.setCids(itCat.getId());
		qh.setLoggedMember(loggedMember);
		qh.setExactCat(true);
		QueryResultSet result = qh.getResultSet();
		LOGGER.debug(result.size()+ " PortletFAQ trouvée(s) dans la catégorie "+itCat.getName() + " / " + itCat.getId());
		LOGGER.debug(qh.getQueryString()+"\r\n");
		
		// Si on a trouvé une portlet FAQ, on regarde si elle s'applique à la catégorie courante.
		if(!result.isEmpty()) {
			PortletFaq itPortletFaq = (PortletFaq) Util.getFirst(result);
			
			// Si mode "catégorie exacte courante" et que la catégorie de nav de la portlet = catégorie du portail 
			if(	itPortletFaq.getRefine().equals("CurrentExact") &&
				itPortletFaq.getCategorieDeNavigation(loggedMember).first().equals(portalCat)) {
				return itPortletFaq;
			}
			// Si mode "catégorie courante" et que la catégorie de nav de la portlet est un parent de la catégorie du portail
			if(	itPortletFaq.getRefine().equals("Current") && 
				(portalCat.hasAncestor(itPortletFaq.getCategorieDeNavigation(loggedMember).first()) || 
				  itPortletFaq.getCategorieDeNavigation(loggedMember).first().equals(portalCat))) {
				return itPortletFaq;
			}
		}
		return null;
	}
	/**
	 * Cherche une "PortletFaq" dans la catégorie de portail courant ou dans les catégories parentes si non trouvée
	 * @param portalCat la catégorie courante du portail
	 * @return La "PortletFaq" trouvée, sinon NULL
	 */
	public static PortletFaq searchPortletFaq(Category portalCat) {
		if(portalCat != null) {
			List<Category> ancestors  = new ArrayList<Category>();
			ancestors.add(portalCat);
			ancestors.addAll(portalCat.getAncestorList(channel.getCategory(channel.getProperty("jcmsplugin.socle.site.menu.cat.root")), false));

			for (Category itCat : ancestors) {
				PortletFaq portletFaq = getPortletFaq(itCat, portalCat);
				if(Util.notEmpty(portletFaq)){
					LOGGER.debug("FAQ trouvée : "+portletFaq);
					return portletFaq;
				}
			}

		}	
		
		return null;
	}	
	
	/**
   * Récupérer uniquement l'URL qui doit être retournée depuis un contenu Lien
   * @param itLien
   * @return
   */
  public static String getUrlPubFromLien(Lien itLien) {
    
    Locale userLocale = Channel.getChannel().getCurrentUserLocale();
    
    if (Util.notEmpty(itLien.getLienInterne())) {
      if (itLien.getLienInterne() instanceof FileDocument) {
        FileDocument itDoc = (FileDocument) itLien.getLienInterne();
        return itDoc.getDownloadUrl();
      } else {
        return itLien.getLienInterne().getDisplayUrl(userLocale);
      }
    } else if (Util.notEmpty(itLien.getLienExterne())) {
      return itLien.getLienExterne();
    }
    
    return "";
  }
  
  /**
   * Récupérer uniquement le texte alternatif qui doit être retournée depuis un contenu Lien
   * @param itLien
   * @return
   */
  public static String getAltFromLien(Lien itLien) {
    
	if (Util.notEmpty(itLien.getTexteAlternatif())) {
		return itLien.getTexteAlternatif();
	}
	  
    if (Util.notEmpty(itLien.getLienInterne())) {
      if (itLien.getLienInterne() instanceof FileDocument) {
        FileDocument itDoc = (FileDocument) itLien.getLienInterne();
        String fileType = FileDocument.getExtension(itDoc.getFilename()).toUpperCase();
        String fileSize = Util.formatFileSize(itDoc.getSize());
        return JcmsUtil.glp(Channel.getChannel().getCurrentJcmsContext().getUserLang(), "jcmsplugin.socle.lien.document.nouvelonglet", itLien.getTitle(), fileSize, fileType);
      }
    } else if (Util.notEmpty(itLien.getLienExterne())) {
      return JcmsUtil.glp(Channel.getChannel().getCurrentJcmsContext().getUserLang(), "jcmsplugin.socle.lien.site.nouvelonglet", itLien.getTitle());
    }
    
    return "";
  }
  
  /**
   * Déterminer si un lien doit ouvrir un nouvel onglet ou non
   * @param itLien
   * @return
   */
  public static Boolean isLienExterne(Lien itLien) {
    if (Util.notEmpty(itLien.getLienInterne())) {
      return (itLien.getLienInterne() instanceof FileDocument);
    } else {
      return Util.notEmpty(itLien.getLienExterne());
    }
  }
  
  /**
   * Récupère la fiche lieu du service ressource correspondant à la Délégation
   * Se base sur le fichier plugin.prop
   * @param cat la catégorie de la délégation concernée
   * @return la fiche lieu associée
   */
  public static FicheLieu getServiceRessources(Category cat) {
    
    if(cat.equals(channel.getCategory("$jcmsplugin.socle.emploiStage.delegation.stnazaire"))){
      if(Util.notEmpty(channel.getPublication("$jcmsplugin.socle.emploiStage.serviceRessource.stnazaire"))) {
        return (FicheLieu) channel.getPublication("$jcmsplugin.socle.emploiStage.serviceRessource.stnazaire"); 
      }
    }
    if(cat.equals(channel.getCategory("$jcmsplugin.socle.emploiStage.delegation.nantes"))){
      if(Util.notEmpty(channel.getPublication("$jcmsplugin.socle.emploiStage.serviceRessource.nantes"))) {
        return (FicheLieu) channel.getPublication("$jcmsplugin.socle.emploiStage.serviceRessource.nantes"); 
      }
    }    
    if(cat.equals(channel.getCategory("$jcmsplugin.socle.emploiStage.delegation.vignoble"))){
      if(Util.notEmpty(channel.getPublication("$jcmsplugin.socle.emploiStage.serviceRessource.vignoble"))) {
        return (FicheLieu) channel.getPublication("$jcmsplugin.socle.emploiStage.serviceRessource.vignoble"); 
      }
    }
    if(cat.equals(channel.getCategory("$jcmsplugin.socle.emploiStage.delegation.paysderetz"))){
      if(Util.notEmpty(channel.getPublication("$jcmsplugin.socle.emploiStage.serviceRessource.paysderetz"))) {
        return (FicheLieu) channel.getPublication("$jcmsplugin.socle.emploiStage.serviceRessource.paysderetz"); 
      }
    }    
    if(cat.equals(channel.getCategory("$jcmsplugin.socle.emploiStage.delegation.chateaubriant"))){
      if(Util.notEmpty(channel.getPublication("$jcmsplugin.socle.emploiStage.serviceRessource.chateaubriant"))) {
        return (FicheLieu) channel.getPublication("$jcmsplugin.socle.emploiStage.serviceRessource.chateaubriant"); 
      }
    }
    if(cat.equals(channel.getCategory("$jcmsplugin.socle.emploiStage.delegation.ancenis"))){
      if(Util.notEmpty(channel.getPublication("$jcmsplugin.socle.emploiStage.serviceRessource.ancenis"))) {
        return (FicheLieu) channel.getPublication("$jcmsplugin.socle.emploiStage.serviceRessource.ancenis"); 
      }
    }    
    
    return null;
  }
  
  /**
   * Renvoie le texte alternatif d'un contenu pour une illustration
   * @param pub
   * @return
   */
  public static String getAltTextFromPub(Publication pub) {
    String userLang = Channel.getChannel().getCurrentUserLang();

    String altText = "";
    String legendText = "";
    boolean hasCopyright = false;
    try {
      altText = (String) pub.getFieldValue("texteAlternatif", userLang, false);
    } catch (Exception e) {}
    try {
      legendText = (String) pub.getFieldValue("legende", userLang, false);
    } catch (Exception e) {}
    try {
      hasCopyright = Util.notEmpty((String) pub.getFieldValue("copyright", userLang, false));
    } catch (Exception e) {}
    
    if(Util.isEmpty(altText)) {
      // Champ alt vide, mais légende
      if (Util.notEmpty(legendText)) {
        altText = legendText;
      }
      // Légende vide, mais copyright présent
      else if (hasCopyright && Util.notEmpty(pub)) {
        altText = pub.getTitle();
      }
    }
    
    return HttpUtil.encodeForHTMLAttribute(altText);
  }

  /**
   * Récupère les caractères précédent un chiffre dans une chaine de caractères comprenant du texte et des chiffres
   * Exemple : si chaine = "+ 12,40 %", renvoie "+ "
   * @param chaine La chaine de caractères à traiter
   * @return les caractères précédents le 1er chiffre trouvé, ou vide.
   */
  public static String getNumberPrefixe(String chaine) {
    if (Util.isEmpty(chaine)) return "";
    String pattern = "^[^0-9]*";
    String prefixe = "";
    Pattern compiledPattern = Pattern.compile(pattern);
    Matcher matcher = compiledPattern.matcher(chaine);
    
    if (matcher.find()) {
      prefixe = matcher.group();
    }

    return prefixe;
  }  
  
  /**
   * Récupère les caractères suivant le dernier chiffre dans une chaine de caractères comprenant du texte et des chiffres
   * Exemple : si chaine = "+ 12,40 %", renvoie " %"
   * @param chaine La chaine de caractères à traiter
   * @return les caractères suivant le dernier chiffre trouvé, ou vide.
   */
  public static String getNumberSuffixe(String chaine) {
    if (Util.isEmpty(chaine)) return "";
    String pattern = "[^0-9]*$";
    String prefixe = "";
    Pattern compiledPattern = Pattern.compile(pattern);
    Matcher matcher = compiledPattern.matcher(chaine);
    
    if (matcher.find()) {
      prefixe = matcher.group();
    }

    return prefixe;
  }
	
	/**
	 * Récupère le champ description de la catégorie renseigné par le contributeur, récupère la description de la première catégorie si le champ n'a pas été rempli.
	 * @param valeurChampCat la valeur du champ category, peut-être vide
	 * @param userLang la langue de l'utilisateur actuel
	 * @param racineChampCat la catégorie racine du champ category, permet de récupérer la valeur par défaut dans le cas où le champ serait vide, peut-être vide
	 * @return le champ description d'une catégorie
	 */
	public static String getDescriptionChampCategorie(TreeSet<Category> valeurChampCat, String userLang, Category racineChampCat) {
				
		if(Util.notEmpty(valeurChampCat)) {
			
			Category iconeCat = valeurChampCat.first();
			
			return iconeCat.getDescription(userLang);
			
		//si vide, on recupere par defaut la description de la premiere categorie enfant
		} else if(Util.notEmpty(racineChampCat)) {
			
			Iterator<Category> listeIcone = racineChampCat.getChildrenSet().iterator();
			if(listeIcone.hasNext()) {
				
				return listeIcone.next().getDescription(userLang);
			}
		}
		return "";
	}
	
	/**
	 * Retourne une liste de titres d'un tableau de PortalElement, dans le format "titre 1 / titre 2 / titre 3"
	 * Utilisé principalement pour l'export CSV
	 * @param string 
	 * @param contentList
	 * @return
	 */
	public static String listNameOfPortalElements(PortalElement[] portalElements, String separator) {
	  if (Util.isEmpty(portalElements) || portalElements.length <= 0) return "";
	  
	  Channel channel = Channel.getChannel();
	  String userLang = channel.getCurrentUserLang();
	  
	  StringBuilder listNames = new StringBuilder();
	  
	  List<PortalElement> listContent = new ArrayList<>(Arrays.asList(portalElements));
	  
	  for (Iterator<PortalElement> iter = listContent.iterator(); iter.hasNext();) {
	    PortalElement itPortalElement = iter.next();
	    listNames.append(itPortalElement.getTitle(userLang));
	    if (iter.hasNext()) listNames.append(separator);
	  }
	  
	  return listNames.toString();
	}
	
	public static String listNameOfPortalElements(PortalElement[] portalElements) {
	  return listNameOfPortalElements(portalElements, defaultSeparator);
	}
	 
  /**
   * Retourne une liste de titres d'un tableau de Content, dans le format "titre 1 / titre 2 / titre 3"
   * Utilisé principalement pour l'export CSV
   * @param contentList
   * @param separator 
   * @return
   */
  public static String listNameOfContent(List<Content> contentList, String separator) {
    if (Util.isEmpty(contentList) || contentList.size() <= 0) return "";
    
    Channel channel = Channel.getChannel();
    String userLang = channel.getCurrentUserLang();
    
    StringBuilder listNames = new StringBuilder();
    
    for (Iterator<Content> iter = contentList.iterator(); iter.hasNext();) {
      Content itContent = iter.next();
      // La possibilité d'un contenu sans titre a été repérée
      if (Util.isEmpty(itContent) || Util.isEmpty(itContent.getTitle())) continue;
      listNames.append(itContent.getTitle(userLang));
      if (iter.hasNext()) listNames.append(separator);
    }
    
    return listNames.toString();
  }
  
  public static String listNameOfContent(List<Content> contentList) {
    return listNameOfContent(contentList, defaultSeparator);
  }
  
  public static String listNameOfContent(Content[] contentArray, String separator) {
    if (Util.isEmpty(contentArray) || contentArray.length <= 0) return "";
    
    return listNameOfContent(Arrays.asList(contentArray), separator);
  }
  
  public static String listNameOfContent(Content[] contentArray) {
    return listNameOfContent(contentArray, defaultSeparator);
  }

	/**
	 * Récupère la liste des (sous-)catégories "branches", ou les (sous-)catégories de navigation d'une publication
	 * @param pub la publication dont on veut connaitre les catégories de navigation (ou les sous-catégories)
	 * @param niveau la proximité de parenté avec les catégories de navigation (0 = catégorie de navigation, 1 = enfant de catégorie de navigation, 2 = enfant d'enfant de catégorie de navigation...)
	 * @return un set avec la liste des (sous-)catégories de navigation, un set vide si la publication est null
	 */
	public static Set<Category> getCategorieDeNavigation(Publication pub, int niveau) {

		Set<Category> allCategorieDeNavigation = new TreeSet<>();

		if(Util.notEmpty(pub)) {
			for(Category cat : pub.getCategorySet()) {
				Category catNav = getCategorieParentDeNavigation(cat, niveau);
				if(Util.notEmpty(catNav)) allCategorieDeNavigation.add(catNav);
			}
		}

		return allCategorieDeNavigation;
	}
	
	/**
	 * Récupère la liste des catégories "branches" qui sont enfant de navigation d'une publication
	 * @param pub la publication dont on veut connaitre les catégories de navigation
	 * @return un set avec la liste des catégories de navigation, un set vide si la publication est null
	 */
	public static Set<Category> getCategorieDeNavigation(Publication pub) {
		return getCategorieDeNavigation(pub, 0);
	}
	
	/**
	 * Retourne la catégorie parent qui est une catégorie de navigation (ou une sous-catégorie)
	 * @param cat la catégorie dont on veut la catégorie de navigation (ou la sous-catégorie)
	 * @param niveau la proximité de parenté avec les catégories de navigation (0 = catégorie de navigation, 1 = enfant de catégorie de navigation, 2 = enfant d'enfant de catégorie de navigation...)
	 * @return cat si c'est une (sous-)catégorie de navigation, une (sous-)catégorie navigation si un des parents de cat l'est, null s'il n'y en a pas ou que cat est null
	 */
	public static Category getCategorieParentDeNavigation(Category cat, int niveau) {

		if(Util.notEmpty(cat)) {
			
			Category catRacine = channel.getCategory("$jcmsplugin.socle.cat.root");
			Category catRacineNavigation = channel.getCategory("$jcmsplugin.socle.category.navigationDesEspaces.root");
			
			Category catParentTeste = cat;

			for(int i = 0; i < niveau; i++) {
				if(Util.isEmpty(catParentTeste.getParent())) break;
				catParentTeste = catParentTeste.getParent();
			}
			
			if(catRacine.equals(cat)) {
				return null;
			} else if(catRacineNavigation.getChildrenSet().contains(catParentTeste)) {
				return cat;
			} else {
				return getCategorieParentDeNavigation(cat.getParent(), niveau);
			}
		} 
		return null;
	}
	
  /**
   * Regarde si une publication est dans telle branche de catégorie
   * @param pub la publication à tester
   * @param cat la catégorie racine de la branche à tester
   * @return true si la publication pub est bien dans la branche de la catégorie cat. Sinon false.
   */ 
  public static boolean hasAncestorCat(Publication pub, Category ancestorCat) {
    for (Category itCat : pub.getCategorySet()) {
      if(catHasAncestor(itCat, ancestorCat)) {
        return true;
      }
    }
    return false;
  } 
  
  /**
   * Regarde si une catégorie a une autre catégorie en tant qu'ancêtre
   * @param catTest
   * @param ancestorCat
   * @return true si la catégorie catTest a ancestorCat en ancêtre, sinon false
   */
  public static boolean catHasAncestor(Category catTest, Category ancestorCat) {
      return (catTest.hasAncestor(ancestorCat) || catTest.equals(ancestorCat));
  }
  
  /**
   * Calcule le ratio d'une image afin de générer la vignette au bon ratio 
   * @param imagePath le chemin de l'image à tester
   * @return le ratio de l'image
   */ 
  public static double getRatio(String imagePath) {
    double ratio = 0.0;
    FileDocument file = FileDocument.getFileDocumentFromFilename(imagePath);
    if(null != file) {
      ratio = (double)file.getWidth() / (double)file.getHeight();
    }
    return ratio;
  }   
  
  /**
   * Récupérer la commune associée à un code INSEE
   * Renvoie NULL si aucune commune n'a été trouvée
   * @param insee
   * @return
   */
  public static City getCommuneFromInsee(Integer insee) {
      // Le code INSEE doit commencer par 44
      if (Util.isEmpty(insee) || !insee.toString().startsWith("44")) {
          return null;
      }
      
      TreeSet<City> allCommunes = channel.getAllDataSet(City.class);
      
      for (City itCity : allCommunes) {
          if (itCity.getCityCode() == insee) {
              return itCity;
          }
      }
      
      return null;
  }
  
  /**
   * Récupérer la commune associée à un code INSEE
   * Renvoie NULL si aucune commune n'a été trouvée
   * @param insee
   * @return
   */
  public static City getCommuneFromInsee(String inseeStr) {
      if (Util.isEmpty(inseeStr)) return null;
      try {
      return getCommuneFromInsee(Integer.parseInt(inseeStr));
      } catch (Exception e) {
          LOGGER.error("Erreur dans getCommuneFromInsee -> le code INSEE " + inseeStr + " n'est pas un nombre.");
          return null;
      }
  }
  
  /**
   * Regarde si une catégorie contient certains types de contenus
   * @param cat la catégorie à tester
   * @param types les types à rechercher
   * @param exactCat indique si on doit chercher dans les catégories filles ou non
   * @return true si des contenus ont été trouvés, false sinon
   */
  public static boolean containsPublications(Category cat, String[] types, boolean exactCat) {
    Member loggedMember = channel.getCurrentLoggedMember();   
    QueryHandler qh = new QueryHandler();
    qh.setTypes(types);
    qh.setCids(cat.getId());
    qh.setLoggedMember(loggedMember);
    qh.setExactCat(exactCat);
    QueryResultSet result = qh.getResultSet();
    LOGGER.debug(result.size()+ " publications trouvées dans la catégorie "+cat.getName() + " / " + cat.getId());
    LOGGER.debug(qh.getQueryString()+"\r\n");
    
    if(!result.isEmpty()) {
      return true;
    }
    return false;
  }  
  
  /**
   * Renvoie une valeur hh:mm:ss en une quantité de secondes
   * Par exemple : 00:03:23 renverra 203, car 3600*0 + 60*3 + 23
   * @param timestamp
   * @return
   */

  public static int getTimeInSecondsFromHhMmSs(String timestamp) {
      try {
          String[] separatedTImestamps = timestamp.split(":");
          int secondsInHours = 3600 * Integer.parseInt(separatedTImestamps[0]);
          int secondsInMinutes = 60 * Integer.parseInt(separatedTImestamps[1]);
          int seconds = Integer.parseInt(separatedTImestamps[2]);
          
          return secondsInHours + secondsInMinutes + seconds;
      } catch (Exception e) {
          LOGGER.warn("Erreur en essayant de convertir " + timestamp + " en secondes : " + e.getMessage());
          return -1;
      }
  }


  /**
   * Génération de flux json pour données de FAQ
   * @param faqEntrySet le Set de FaqEntry à retourner dans le flux json
   * @param userLang la langue de l'utilisateur courant
   * @return un objet json contenant les donénes de FAQ formatées pour les moteurs de recherche.
   */
  
  public static JsonObject faqToJson(Set<FaqEntry> faqEntrySet, String userLang) {
    
    if(Util.notEmpty(faqEntrySet)) {
      
      // Construction de l'objet FAQPage
      JsonObject faqJsonObject = new JsonObject();
      faqJsonObject.addProperty("@context", "https://schema.org");
      faqJsonObject.addProperty("@type", "FAQPage");
      
      // Construction du tableau de questions
      JsonArray questionsJsonArray = new JsonArray();
      
      for(FaqEntry itFaq : faqEntrySet) {
  
        // Construction de l'objet Answer
        JsonObject itAnswerJsonObject = new JsonObject();
        itAnswerJsonObject.addProperty("@type", "Answer");
        itAnswerJsonObject.addProperty("text", WysiwygRenderer.processWysiwyg(itFaq.getAnswer(userLang), channel.getCurrentUserLocale()));
          
        // Construction de l'objet Question
        JsonObject itQuestionJsonObject = new JsonObject();
        itQuestionJsonObject.addProperty("@type", "Question");
        itQuestionJsonObject.addProperty("name", HttpUtil.encodeForHTMLAttribute(itFaq.getTitle(userLang)));
        itQuestionJsonObject.add("acceptedAnswer", itAnswerJsonObject);
          
        questionsJsonArray.add(itQuestionJsonObject);
      }
      
      faqJsonObject.add("mainEntity", questionsJsonArray);
      
      return faqJsonObject;
    }
    
    return null;
  
  }


}