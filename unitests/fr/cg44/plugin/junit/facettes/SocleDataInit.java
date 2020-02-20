package fr.cg44.plugin.junit.facettes;

import static com.jalios.jcms.Channel.getChannel;

import java.util.Set;

import com.jalios.jcms.Category;
import com.jalios.jcms.Channel;
import com.jalios.jcms.Member;
import com.jalios.jcms.Publication;
import com.jalios.jcms.handler.QueryHandler;
import com.jalios.servlet.http.MockHttpServletRequest;

import generated.Canton;
import generated.City;
import generated.ContenuDeTest;
import generated.Delegation;

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
		qh.setTypes("ContenuDeTest");
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
	public static City createCity(String name, int code, Category[] categories, String[] communes,  Delegation delegation, Canton... cantons) {
		City city = new City();
		city.setTitle(name);
		city.setCityCode(code);
		city.setCategories(categories);
		city.setNomDesCommunesDeleguees(communes);
		city.setCanton(cantons);	
		city.setDelegation(delegation);
		city.setAuthor(ADMIN);
		city.performCreate(ADMIN);	
		return city;
	}

	public static City createCity(String name, int code, Canton... cantons) {
		return createCity(name, code, new Category[] {}, new String[] {}, new Delegation(), cantons);
	}

	public static City createCity(String name, int code, Delegation delegation) {
		return createCity(name, code, new Category[] {}, new String[] {}, delegation);
	}

	public static City createCity(String name, int code, Category... epci) {
		return createCity(name, code, epci, new String[] {}, new Delegation());
	}

	public static City createCity(String name, int code) {
		return createCity(name, code,new Category[] {}, new String[] {}, new Delegation());
	}

	public static City createCity(String name, int code, String... communes) {
		return createCity(name, code, new Category[] {}, communes, new Delegation());
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
	 * Création d'une délégations
	 * @param name
	 * @param code
	 * @param city
	 * @return
	 */
	public static Delegation createDelegation(String name) {
		Delegation delegation = new Delegation();
		delegation.setTitle(name);
		delegation.setAuthor(ADMIN);
		delegation.performCreate(ADMIN);	
		return delegation;
	}


	/**
	 * Création d'une catégorie
	 * @param name
	 * @param parent
	 * @return
	 */
	public static Category createCategory(String name, Category parent) {
		Category cat = new Category();
		cat.setParent(parent);
		cat.setName(name);
		cat.setAuthor(ADMIN);
		cat.performCreate(ADMIN);
		return cat;
	}


	/**
	 * Création d'une EPCI (catégorie)
	 * @param name
	 * @return
	 */
	public static Category createCategoryEpci(String name) {
		Category parent = Channel.getChannel().getCategory("$jcmsplugin.socle.category.toutesLesCommunesEPCI.root");
		return createCategory(name, parent);
	}


	/**
	 * Création d'une fiche lieux avec nom et commune (optionnel canton)
	 * @param name
	 * @param city
	 * @param canton
	 * @return
	 */
	public static ContenuDeTest createPub(String name, City commune, City[] communes, Boolean allCity, Category[] categories, Delegation[] delegations, Canton... canton) {
		ContenuDeTest pub = new ContenuDeTest();
		pub.setTitle(name);
		pub.setCommune(commune);
		pub.setCommunes(communes);
		pub.setToutesLesCommunesDuDepartement(allCity);
		pub.setCategories(categories);
		pub.setCantons(canton);
		pub.setDelegations(delegations);
		pub.setAuthor(ADMIN);
		pub.performCreate(ADMIN);
		return pub;
	}


	/**
	 * Création d'une fiche lieux avec nom et canton(s)
	 * @param name
	 * @param canton
	 * @return
	 */
	public static ContenuDeTest createPub(String name, City commune, Canton... canton) {
		return createPub(name, commune, null, false, new Category[] {}, new Delegation[] {}, canton);
	}


	/**
	 * Création d'une fiche lieux avec nom et canton(s)
	 * @param name
	 * @param canton
	 * @return
	 */
	public static ContenuDeTest createPub(String name, City[] communes, Canton... canton) {
		return createPub(name, null, communes, false, new Category[] {},  new Delegation[] {}, canton);
	}


	/**
	 * Création d'une fiche lieux avec nom et canton(s)
	 * @param name
	 * @param canton
	 * @return
	 */
	public static ContenuDeTest createPub(String name, Canton... canton) {
		return createPub(name, null, null, false, new Category[] {}, new Delegation[] {}, canton);
	}


	/**
	 * Création d'une fiche lieux avec nom et canton(s)
	 * @param name
	 * @param canton
	 * @return
	 */
	public static ContenuDeTest createPub(String name, Delegation... delegations) {
		return createPub(name, null, null, false, new Category[] {}, delegations);
	}


	/**
	 * Création d'une fiche lieux avec nom et categorie(s)
	 * @param name
	 * @param canton
	 * @return
	 */
	public static ContenuDeTest createPub(String name, Category... categories) {
		return createPub(name, null, null, false, categories,  new Delegation[] {});
	}


	/**
	 * Création d'un élu avec nom et canton
	 * @param name
	 * @param city
	 * @param canton
	 * @return
	 */
	public static ContenuDeTest createPub(String name, Canton canton) {
		ContenuDeTest pub = new ContenuDeTest();
		pub.setTitle(name);
		pub.setCanton(canton);
		pub.setAuthor(ADMIN);
		pub.performCreate(ADMIN);
		return pub;
	}

}