package fr.cg44.plugin.junit.facettes;

import static fr.cg44.plugin.junit.facettes.SocleDataInit.createCanton;
import static fr.cg44.plugin.junit.facettes.SocleDataInit.createCategoryEpci;
import static fr.cg44.plugin.junit.facettes.SocleDataInit.createDelegation;
import static fr.cg44.plugin.junit.facettes.SocleDataInit.createCity;
import static fr.cg44.plugin.junit.facettes.SocleDataInit.createPub;
import static fr.cg44.plugin.junit.facettes.SocleDataInit.getResultSearchCity;
import static org.junit.Assert.assertEquals;

import java.util.HashSet;
import java.util.Set;

import org.junit.BeforeClass;
import org.junit.Test;

import com.jalios.jcms.Category;
import com.jalios.jcms.Publication;

import com.jalios.jcms.test.JcmsTestCase4;

import generated.Canton;
import generated.City;
import generated.Delegation;
import generated.ContenuDeTest;

/**
 * Test unitaire de la classe IndexationDataController pour la ré-indexation après modification d'une commune
 * Et de la classe CityQueryFilter pour la recherche sur le code commune
 */
public class ModifSearchCityTest extends JcmsTestCase4  {

	/**
	 * TU 1 recherchePubDirectCommune
	 */
	static City city1_1 = createCity("Commune 1.1", 1110);
	// Fiche lieux sur commune 1.1
	static ContenuDeTest pub1_1 = createPub("pub 1.1", city1_1);

	
	/**
	 * TU 2 recherchePubDirectCommunes
	 */
	static City city2_1 = createCity("Commune 2.1", 1210);
	static City city2_2 = createCity("Commune 2.2", 1220);
	static City city2_3 = createCity("Commune 2.3", 1230);
	// Fiche lieux sur commune 2.1
	static ContenuDeTest pub2_1 = createPub("pub 2.1", new City[] {city2_1, city2_2, city2_3});

	
	/**
	 * TU 3 recherchePubRefCantonCommune
	 */
	// Création des cantons
	static Canton canton3_1 = createCanton("Canton 3.1");
	static Canton canton3_2 = createCanton("Canton 3.2");
	static Canton canton3_3 = createCanton("Canton 3.3");
	static Canton canton3_4 = createCanton("Canton 3.4");
	// Création des communes avec le canton 2.1
	static City city3_1 = createCity("Commune 3.1", 1310, new Canton[] {canton3_1, canton3_2});
	// ContenuDeTest sur canton 3.1
	static ContenuDeTest pub3_1 = createPub("ContenuDeTest 3.1", canton3_1);
	static ContenuDeTest pub3_2 = createPub("ContenuDeTest 3.2", canton3_1);
	// ContenuDeTest sur canton 3.2
	static ContenuDeTest pub3_3 = createPub("ContenuDeTest 3.3", canton3_2);
	static ContenuDeTest pub3_4 = createPub("ContenuDeTest 3.4", canton3_2);
	// ContenuDeTest sur canton 3.3
	static ContenuDeTest pub3_5 = createPub("ContenuDeTest 3.3", canton3_3);
	static ContenuDeTest pub3_6 = createPub("ContenuDeTest 3.4", canton3_3);
	// ContenuDeTest sur canton 3.4
	static ContenuDeTest pub3_7 = createPub("ContenuDeTest 3.3", canton3_4);
	static ContenuDeTest pub3_8 = createPub("ContenuDeTest 3.4", canton3_4);
	
	
	/**
	 * TU 4 recherchePubRefCantonsCommune
	 */
	// Création des cantons
	static Canton canton4_1 = createCanton("Canton 4.1");
	static Canton canton4_2 = createCanton("Canton 4.2");
	static Canton canton4_3 = createCanton("Canton 4.3");
	static Canton canton4_4 = createCanton("Canton 4.4");
	static Canton canton4_5 = createCanton("Canton 4.5");
	// Création des communes
	static City city4_1 = createCity("Commune 4.1", 410, canton4_1, canton4_2);
	// Fiche lieux
	static ContenuDeTest pub4_1 = createPub("ContenuDeTest 4.1", canton4_1, canton4_2, canton4_3, canton4_4);
	static ContenuDeTest pub4_2 = createPub("ContenuDeTest 4.2", canton4_1, canton4_4);
	static ContenuDeTest pub4_3 = createPub("ContenuDeTest 4.3", canton4_3, canton4_4);
	static ContenuDeTest pub4_4 = createPub("ContenuDeTest 4.4", canton4_4, canton4_5);
	
	
	/**
	 * TU 5 recherchePubRefCantonsCommune
	 */
	// Création des délégation
	static Delegation delegation5_1 = createDelegation("Delegation 5.1");
	static Delegation delegation5_2 = createDelegation("Delegation 5.2");
	static Delegation delegation5_3 = createDelegation("Delegation 5.3");
	static Delegation delegation5_4 = createDelegation("Delegation 5.4");
	// Création des communes
	static City city5_1 = createCity("Commune 4.1", 510, delegation5_1);
	// Fiche lieux
	static ContenuDeTest pub5_1 = createPub("ContenuDeTest 5.1", new Delegation[] {delegation5_1, delegation5_2, delegation5_3, delegation5_4});
	static ContenuDeTest pub5_2 = createPub("ContenuDeTest 5.2", new Delegation[] {delegation5_1, delegation5_2});
	static ContenuDeTest pub5_3 = createPub("ContenuDeTest 5.3", new Delegation[] {delegation5_2, delegation5_3});
	static ContenuDeTest pub5_4 = createPub("ContenuDeTest 5.4", new Delegation[] {delegation5_1, delegation5_4});
	

	/**
	 * TU 6 recherchePubRefEpciCommune
	 * Test 6 : Publications reliées à plusieurs EPCI
	 */
	// Création des EPCI
	static Category epci6_1 = createCategoryEpci("epci6_1");
	static Category epci6_2 = createCategoryEpci("epci6_2");
	static Category epci6_3 = createCategoryEpci("epci6_3");
	static Category epci6_4 = createCategoryEpci("epci6_4");
	// Création commune
	static City city6_1 = createCity("Commune 6.1", 610, epci6_1, epci6_2);
	// Fiche lieux sur l'EPCI
	static ContenuDeTest pub6_1 = createPub("ContenuDeTest 6.1", epci6_1);
	static ContenuDeTest pub6_2 = createPub("ContenuDeTest 6.2", epci6_2);
	static ContenuDeTest pub6_3 = createPub("ContenuDeTest 6.3", epci6_1, epci6_2);
	static ContenuDeTest pub6_4 = createPub("ContenuDeTest 6.4", epci6_1, epci6_3);
	static ContenuDeTest pub6_5 = createPub("ContenuDeTest 6.5", epci6_3, epci6_4);
	static ContenuDeTest pub6_6 = createPub("ContenuDeTest 6.6", epci6_4);
	static ContenuDeTest pub6_7 = createPub("ContenuDeTest 6.7", epci6_1, epci6_4);
	
	
	@BeforeClass
	/**
	 * Création des données de test pour chaque test unitaire
	 */
	public static void avantTest() {	
		
		// L'indexation des publications ayant lieu de manière asynchrone dans un thread dédié.
		// la recherche textuelle d'une publication immédiatement après sa création pourrait ne pas renvoyer de résultat.
		// Il est alors nécessaire de faire appel à une temporisation.
		try { Thread.sleep(1000); } catch(Exception ex) { }	
		
		// Modification données test 1
		modifDataRecherchePubDirectCommune();
		
		// Modification données test 2
		modifDataRecherchePubDirectCommunes();
		
		// Modification données test 3
		modifDataRecherchePubDirectCanton();
		
		// Modification données test 4
		modifDataRecherchePubDirectCantons();
		
		// Modification données test 5
		modifDataRecherchePubDirectDelegations();
		
		// Modification données test 6
		modifDataRecherchePubDirectEpci();
		
		// temporisation pour l'indexation de la modification
		try { Thread.sleep(1000); } catch(Exception ex) { }			
	}


	/**
	 * Modification données test 1
	 * Données de test pour recherchePubDirectCommune
	 */
	private static void modifDataRecherchePubDirectCommune() {
		// Modification du code commune de la commune 1.1
		City clone1_1 = (City) city1_1.getUpdateInstance();
		clone1_1.setCityCode(1115);
		clone1_1.performUpdate(admin);
	}


	/**
	 * Modification données test 2
	 * Données de test pour recherchePubDirectCommunes
	 */
	private static void modifDataRecherchePubDirectCommunes() {
		// Modification du code commune de la commune 1.1
		City clone2_1 = (City) city2_1.getUpdateInstance();
		clone2_1.setCityCode(1215);
		clone2_1.performUpdate(admin);
	}


	/**
	 * Modification données test 3
	 * Données de test pour recherchePubDirectCanton
	 */
	private static void modifDataRecherchePubDirectCanton() {
		// Retire un canton en ajoute deux
		// Canton3_1 et canton3_2  -> canton3_2, canton3_3 et canton3_4
		City clone3_1 = (City) city3_1.getUpdateInstance();
		clone3_1.setCanton(new Canton[] {canton3_2, canton3_3, canton3_4});
		clone3_1.performUpdate(admin);
	}
	
	
	/**
	 * Modification données test 4
	 * Données de test pour recherchePubDirectCantons
	 */
	private static void modifDataRecherchePubDirectCantons() {
		// Retire un canton en ajoute deux
		// Canton4_1 et canton4_2  -> canton4_2, canton4_3 et canton4_4
		City clone4_1 = (City) city4_1.getUpdateInstance();
		clone4_1.setCanton(new Canton[] {canton4_2, canton4_3});
		clone4_1.performUpdate(admin);
	}
	
	
	/**
	 * Modification données test 5
	 * Données de test pour recherchePubDirectDelegations
	 */
	private static void modifDataRecherchePubDirectDelegations() {
		// Change une délégation
		// delegation5_1 -> delegation5_2
		City clone5_1 = (City) city5_1.getUpdateInstance();
		clone5_1.setDelegation(delegation5_2);
		clone5_1.performUpdate(admin);
	}
	
	
	/**
	 * Modification données test 6
	 * Données de test pour recherchePubDirectEpci
	 */
	private static void modifDataRecherchePubDirectEpci() {
		// Change les epci
		// epci6_1 et epci6_2 -> epci6_2 et epci 6_3
		City clone6_1 = (City) city6_1.getUpdateInstance();
		clone6_1.setCategories(new Category[] {epci6_2, epci6_3});
		clone6_1.performUpdate(admin);
	}
	

	@Test
	/**
	 * Test 1 recherche sur commune 1.1
	 * Après modification du code commune de la commune recherchée
	 * Test sur les publications qui référencent directement la commune (champ mono)
	 */
	public void recherchePubDirectCommune() {		
		// Recherche sur commune 1.1
		// city 1.1 est référencée par : pub 1.1 et pub 1.2
		Set<Publication> resultatTestSet = new HashSet<Publication>();
		resultatTestSet.add(pub1_1);	    
	    assertEquals("Recherche sur commune 1.1 invalide", resultatTestSet, getResultSearchCity(city1_1));	
	}


	@Test
	/**
	 * Test 2 recherche
	 * Après modification du code commune de la commune recherchée
	 * Test sur les publications qui référencent directement des communes (champ multiple)
	 */
	public void recherchePubDirectCommunes() {	
		Set<Publication> resultatTestSet = new HashSet<Publication>();
		resultatTestSet.add(pub2_1);	    
	    assertEquals("Recherche sur commune 2.1 invalide", resultatTestSet, getResultSearchCity(city2_1));
	    assertEquals("Recherche sur commune 2.2 invalide", resultatTestSet, getResultSearchCity(city2_2));
	    assertEquals("Recherche sur commune 2.3 invalide", resultatTestSet, getResultSearchCity(city2_3));
	}


	@Test
	/**
	 * Test 3 recherche
	 * Après modification du canton de la commune recherchée
	 * Test sur les publications qui référencent directement un canton (champ mono)
	 */
	public void recherchePubDirectCanton() {	
		Set<Publication> resultatTestSet = new HashSet<Publication>();
		resultatTestSet.add(pub3_3);
		resultatTestSet.add(pub3_4);
		resultatTestSet.add(pub3_5);
		resultatTestSet.add(pub3_6);
		resultatTestSet.add(pub3_7);
		resultatTestSet.add(pub3_8);
	    assertEquals("Recherche sur commune 3.1 invalide", resultatTestSet, getResultSearchCity(city3_1));    
	}
	
	
	@Test
	/**
	 * Test 4 recherche
	 * Après modification du canton de la commune recherchée
	 * Test sur les publications qui référencent directement des cantons (champ multiple)
	 */
	public void recherchePubDirectCantons() {	
		Set<Publication> resultatTestSet = new HashSet<Publication>();
		resultatTestSet.add(pub4_1);
		resultatTestSet.add(pub4_3);
	    assertEquals("Recherche sur commune 4.1 invalide", resultatTestSet, getResultSearchCity(city4_1));    
	}
	
	
	@Test
	/**
	 * Test 5 recherche
	 * Après modification de la délagation de la commune recherchée
	 * Test sur les publications qui référencent directement des délégations (champ multiple)
	 */
	public void recherchePubDirectDelegations() {	
		Set<Publication> resultatTestSet = new HashSet<Publication>();
		resultatTestSet.add(pub5_1);
		resultatTestSet.add(pub5_2);
		resultatTestSet.add(pub5_3);
	    assertEquals("Recherche sur commune 5.1 invalide", resultatTestSet, getResultSearchCity(city5_1));    
	}
	
	
	@Test
	/**
	 * Test 6 recherche
	 * Après modification de l'epci de la commune recherchée
	 * Test sur les publications qui référencent directement des epci (champ multiple)
	 */
	public void recherchePubDirectEpci() {	
		Set<Publication> resultatTestSet = new HashSet<Publication>();
		resultatTestSet.add(pub6_2);
		resultatTestSet.add(pub6_3);
		resultatTestSet.add(pub6_4);
		resultatTestSet.add(pub6_5);
	    assertEquals("Recherche sur commune 6.1 invalide", resultatTestSet, getResultSearchCity(city6_1));    
	}
	
	
	@Test
	/**
	 * Test 7 recherche
	 * Après création de la commune recherchée
	 * Test sur les publications qui sont sur toutes les communes
	 */
	public void recherchePubAllCommunes() {			
		ContenuDeTest pub7_1 = createPub("ContenuDeTest 4.1", null, null, true, new Category[] {}, new Delegation[] {});		
		try { Thread.sleep(1000); } catch(Exception ex) { }		
		City city7_1 = createCity("commune 7.1", 710);		
		try { Thread.sleep(1000); } catch(Exception ex) { }		
		Set<Publication> resultatTestSet = new HashSet<Publication>();
		resultatTestSet.add(pub7_1);
	    assertEquals("Recherche sur commune 7.1 invalide", resultatTestSet, getResultSearchCity(city7_1));       
	    pub7_1.performDelete(channel.getDefaultAdmin());
	    city7_1.performDelete(channel.getDefaultAdmin());
	}

	
	
}
