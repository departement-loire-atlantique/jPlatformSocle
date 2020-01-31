package fr.cg44.plugin.socle;

import static com.jalios.jcms.Channel.getChannel;

import java.io.UnsupportedEncodingException;
import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.Locale;
import java.util.Map;
import java.util.TreeSet;
import java.util.stream.Stream;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

import com.jalios.jcms.Category;
import com.jalios.jcms.Channel;
import com.jalios.jcms.DataSelector;
import com.jalios.jcms.JcmsUtil;
import com.jalios.jcms.Member;
import com.jalios.jcms.Publication;
import com.jalios.jcms.QueryResultSet;
import com.jalios.jcms.handler.QueryHandler;
import com.jalios.util.ServletUtil;
import com.jalios.util.URLUtils;
import com.jalios.util.Util;

public final class SocleUtils {
	private static Channel channel = Channel.getChannel();
	private static final Logger LOGGER = Logger.getLogger(SocleUtils.class);
	
	// La catégorie technique qui désigne qu'un contenu est mis en avant si celui-ci y est catégorisé.
	private static final String MISE_EN_AVANT_CAT_PROP = "$id.plugin.socle.page-principale.cat";


	/**
	 * A partir d'une catégorie parent, retourne un TreeSet de ses enfants, trié et filtré en fonction des droits de l'utilisateur.
	 * 
	 * @param cat La catégorie parent pour laquelle on doit récupérer les enfants.
	 * @return Un TreeSet de catégories enfants, filtré et trié. Null si la catégorie n'existe pas.
	 */
	public static TreeSet<Category> getOrderedAuthorizedChildrenSet(Category cat) {
		Member loggedMember = channel.getCurrentLoggedMember();
		String userLang = channel.getCurrentJcmsContext().getUserLang();
		if(Util.notEmpty(cat)) {
			DataSelector authorizedCategoriesSelector = Category.getAuthorizedSelector(loggedMember);
			TreeSet<Category> childrenSet = new TreeSet<Category>(cat.getOrderComparator(userLang));
			childrenSet.addAll(cat.getChildrenSet());
			JcmsUtil.applyDataSelector(childrenSet, authorizedCategoriesSelector);
			return childrenSet;
		}
		return null;
		
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
			Publication contenuPrincipal = Util.getFirst(result);		
			return contenuPrincipal;
		}	
		
		return null;
	}

	/**
	 * Retire tout ce qui n'est pas décimal de la chaine de caractère
	 * Exemple 02 40-44-85 12 devient  0240448512 ou 44 000 devient 40000
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
	 * Concatène et formate tous les numéros de téléphone dans un tableau en un String
	 * Les duos de nombres sont séparés par des espaces insécables et les numéros de téléphone sont séparés par un tiret
	 * 
	 * @param listPhoneNumber tableau de String contenant les numéros de téléphone à concaténer
	 * @return un String contenant tous les numéros de téléphones en entrée, un String vide si le tableau est vide
	 */
	public static String formatListPhoneNumber(String[] listPhoneNumber) {

		StringBuffer sbfAllTel = new StringBuffer();

		if(Util.notEmpty(listPhoneNumber)) {

			String separatorDsTel = "&nbsp;"; //espace insecable
			String separatorEntreTel = " - ";

			String[] listPhoneNumberClean = SocleUtils.cleanNumber(listPhoneNumber);

			for(String numTel : listPhoneNumberClean) {

				StringBuffer sbfTel = new StringBuffer();
				sbfTel.append(numTel);

				for(int i = 8 ; i > 0 ; i-=2) {
					sbfTel.insert(i, separatorDsTel);
				}

				if(Util.notEmpty(sbfAllTel.toString())) {
					sbfAllTel.append(separatorEntreTel);
				}
				sbfAllTel.append(sbfTel.toString());
			}
		}

		return sbfAllTel.toString();
	}

	/**
	 * Concatène et formate toutes les infos d'une adresse en un String sous la forme suivante :
	 * 
	 * [libelle]\n
	 * [etageCouloirEscalier] [entreBatimentImmeuble] [nDeVoie] [libelleDeVoie] [lieuDit]\n
	 * [cs]\n
	 * [codePostal] [commune]\n
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
			String lieuDit, String cs, String codePostal, String commune) {

		String separator = " ";
		String newLine = "<br>";
		StringBuffer sbfAddr = new StringBuffer();

		if(Util.notEmpty(libelle)) {
			sbfAddr.append(libelle)
			.append(newLine);
		}

		StringBuffer sbfAddrBis = new StringBuffer();
		String[] morcAddrArr = new String[]{ etageCouloirEscalier, entreBatimentImmeuble, nDeVoie, libelleDeVoie, lieuDit};
		for(String morcAddr : morcAddrArr) {
			if(Util.notEmpty(morcAddr)) {
				sbfAddrBis.append(morcAddr)
				.append(separator);
			}
		}
		if(Util.notEmpty(sbfAddrBis.toString())) {
			sbfAddr.append(sbfAddrBis)
			.append(newLine);
		}
		if(Util.notEmpty(cs)) {
			sbfAddr.append(cs)
			.append(newLine);
		}
		if(Util.notEmpty(codePostal)) {
			sbfAddr.append(codePostal)
			.append(separator);
		}
		if(Util.notEmpty(commune)) {
			sbfAddr.append(commune);
		}

		return sbfAddr.toString();

	}

}
