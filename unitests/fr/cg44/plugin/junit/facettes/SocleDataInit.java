package fr.cg44.plugin.junit.facettes;

import static com.jalios.jcms.Channel.getChannel;

import java.util.Set;

import com.jalios.jcms.Member;
import com.jalios.jcms.Publication;
import com.jalios.jcms.handler.QueryHandler;
import com.jalios.servlet.http.MockHttpServletRequest;

import generated.Canton;
import generated.City;
import generated.ElectedMember;
import generated.FicheLieu;

/**
 * Permet la création de données pour les tests unitaires
 *
 */
public class SocleDataInit   {
	
	
	private static final Member ADMIN = getChannel().getDefaultAdmin();
	
	
	/**
	 * Lance la recherche sur une commune
	 * Retoune les fiches lieux corrspondantes à la recherche
	 * @return
	 */
	public static Set<Publication> getResultSearchCity(City city){
		MockHttpServletRequest request = new MockHttpServletRequest();
		request.addParameter("commune", city.getCityCode() + "");
		QueryHandler qh = new QueryHandler();
		//qh.setTypes("FicheLieu");
		qh.setRequest(request);
		return qh.getResultSet();
	}
	
	/**
	 * Création d'une commune
	 * @param name
	 * @param code
	 * @param canton
	 * @return
	 */
	public static City createCity(String name, int code, Canton... cantons) {
		City city = new City();
		city.setTitle(name);
		city.setCityCode(code);
		city.setCanton(cantons);
		city.setAuthor(ADMIN);
		city.performCreate(ADMIN);	
		return city;
	}

	public static City createCity(String name, int code) {
		return createCity(name, code, new Canton[]{});
	}
	
	/**
	 * Création d'un canton
	 * @param name
	 * @param code
	 * @param city
	 * @return
	 */
	public static Canton createCanton(String name, int code) {
		Canton canton = new Canton();
		canton.setTitle(name);
		canton.setCantonCode(code);
		canton.setAuthor(ADMIN);
		canton.performCreate(ADMIN);	
		return canton;
	}

	
	public static Canton createCanton(String name) {
		return createCanton(name, 0);
	}

	/**
	 * Création d'une fiche lieux avec nom et commune (optionnel canton)
	 * @param name
	 * @param city
	 * @param canton
	 * @return
	 */
	public static FicheLieu createFicheLieu(String name, City city, Canton... canton) {
		FicheLieu ficheLieu = new FicheLieu();
		ficheLieu.setTitle(name);
		ficheLieu.setCommune(city);
		ficheLieu.setCantons(canton);
		ficheLieu.setAuthor(ADMIN);
		ficheLieu.performCreate(ADMIN);
		return ficheLieu;
	}
	
	
	/**
	 * Création d'une fiche lieux avec nom et canton(s)
	 * @param name
	 * @param canton
	 * @return
	 */
	public static FicheLieu createFicheLieu(String name, Canton... canton) {
		return createFicheLieu(name, null, canton);
	}
	
	
	/**
	 * Création d'un élu avec nom et canton
	 * @param name
	 * @param city
	 * @param canton
	 * @return
	 */
	public static ElectedMember createElu(String name, Canton canton) {
		ElectedMember elu = new ElectedMember();
		elu.setTitle(name);
		elu.setCanton(canton);
		elu.setAuthor(ADMIN);
		elu.performCreate(ADMIN);
		return elu;
	}


}