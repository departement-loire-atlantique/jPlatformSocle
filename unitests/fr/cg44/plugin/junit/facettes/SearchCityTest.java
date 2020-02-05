package fr.cg44.plugin.junit.facettes;

import static org.junit.Assert.assertEquals;

import static fr.cg44.plugin.junit.facettes.SocleDataInit.createCity;
import static fr.cg44.plugin.junit.facettes.SocleDataInit.createCanton;
import static fr.cg44.plugin.junit.facettes.SocleDataInit.createFicheLieu;
import static fr.cg44.plugin.junit.facettes.SocleDataInit.createElu;
import static fr.cg44.plugin.junit.facettes.SocleDataInit.getResultSearchCity;

import java.util.HashSet;
import java.util.Set;

import org.junit.BeforeClass;
import org.junit.Test;

import com.jalios.jcms.Publication;
import com.jalios.jcms.test.JcmsTestCase4;

import generated.Canton;
import generated.City;
import generated.ElectedMember;
import generated.FicheLieu;

/**
 * Test unitaire de la classe PublicationFacetedSearchCityEnginePolicyFilter pour la ré-indexation complète (sur les communes)
 * Et de la classe CityQueryFilter pour la recherche sur le code commune
 */
public class SearchCityTest extends JcmsTestCase4  {

	/**
	 * TU 1 recherchePubDirectCommune
	 */
	// Création des communes sans canton
	static City city1_1 = createCity("Commune 1.1", 110);
	static City city1_2 = createCity("Commune 1.2", 120);
	// Création des fiches lieux sur commune 1.1
	static FicheLieu ficheLieu1_1 = createFicheLieu("FicheLieu 1.1", city1_1);
	static FicheLieu ficheLieu1_2 = createFicheLieu("FicheLieu 1.2", city1_1);
	// Création des fiches lieux sur commune 1.2
	static FicheLieu ficheLieu1_3 = createFicheLieu("FicheLieu 1.3", city1_2);
	
	/**
	 * TU 2 recherchePubRefCantonCommune
	 */
	// Création des cantons sans commune
	static Canton canton2_1 = createCanton("Canton 2.1");
	static Canton canton2_2 = createCanton("Canton 2.2");
	// Création des communes avec le canton 2.1
	static City city2_1 = createCity("Commune 2.1", 210, canton2_1);
	static City city2_2 = createCity("Commune 2.2", 220, canton2_1);
	// Création des communes avec le canton 2.2
	static City city2_3 = createCity("Commune 2.3", 230, canton2_2);
	// Fiche lieux sur canton 2.1
	static ElectedMember elu2_1 = createElu("FicheLieu 2.1", canton2_1);
	static ElectedMember elu2_2 = createElu("FicheLieu 2.2", canton2_1);
	// Fiche lieux sur canton 2.2
	static ElectedMember elu2_3 = createElu("FicheLieu 2.3", canton2_2);
	
	
	
	/**
	 * Création des données de test pour chaque test unitaire
	 */
	@BeforeClass
	public static void avantTest() {			
		// L'indexation des publications ayant lieu de manière asynchrone dans un thread dédié.
		// la recherche textuelle d'une publication immédiatement après sa création pourrait ne pas renvoyer de résultat.
		// Il est alors nécessaire de faire appel à une temporisation.
		try { Thread.sleep(1000); } catch(Exception ex) { }		
	}
		 
	
	/*-----------------------------------------------------------------------------------/
	 * Test 1
	 * Fiche lieux -> Commune
	 * Test de recherche sur des fiches lieux
	 * Les fiches lieux référencement directement la commune dans leur champ "commune"
	 *-----------------------------------------------------------------------------------*/

	@Test
	/**
	 * Test recherche sur commune 1.1
	 */
	public void recherchePubDirectCommune1_1() {			
		// Recherche sur commune 1.1
		// city 1.1 est référencée par : FicheLieu 1.1 et FicheLieu 1.2
		Set<Publication> resultatTestSet = new HashSet<Publication>();
		resultatTestSet.add(ficheLieu1_1);
		resultatTestSet.add(ficheLieu1_2);   	    
		assertEquals("Recherche sur commune 1.1 invalide", resultatTestSet, getResultSearchCity(city1_1));
	}

	@Test
	/**
	 * Test recherche sur commune 1.2
	 */
	public void recherchePubDirectCommune1_2() {
		// Recherche sur commune 1.2
		// city 1.2 est référencée par : FicheLieu 1.3
		Set<Publication> resultatTestSet = new HashSet<Publication>();
		resultatTestSet.add(ficheLieu1_3);    
		assertEquals("Recherche sur commune 1.2 invalide", resultatTestSet, getResultSearchCity(city1_2));
	}
	
		
	/*-----------------------------------------------------------------------------------/
	 * Test 2
	 * Elu -> Canton <- Commune
	 * Test de recherche sur des Elus
	 * Les Elus référencement indirectement la commune dans leur champ "canton" (le canton référence la commune)
	 * Chaque commune référence son canton (exemple réel : ((Commune) Saint-Lumine-de-Clisson, Clisson, Gétigné) -> ((Canton) Clisson) )
	 *-----------------------------------------------------------------------------------*/
	
	@Test
	/**
	 * Test recherche sur commune 2.1
	 */
	public void recherchePubRefCantonCommune2_1() {			
		// Recherche sur commune 2.1
		// city 2.1 est référencée par : FicheLieu 2.1 et FicheLieu 2.2
		Set<Publication> resultatTestSet = new HashSet<Publication>();
		resultatTestSet.add(elu2_1);
		resultatTestSet.add(elu2_2);   	    
	    assertEquals("Recherche sur commune 2.1 invalide", resultatTestSet, getResultSearchCity(city2_1));		    
	}
	
	@Test
	/**
	 * Test recherche sur commune 2.2
	 */
	public void recherchePubRefCantonCommune2_2() {			
		// Recherche sur commune 2.2
		// city 2.2 est référencée par : FicheLieu 2.1 et FicheLieu 2.2
		Set<Publication> resultatTestSet = new HashSet<Publication>();
		resultatTestSet.add(elu2_1);
		resultatTestSet.add(elu2_2);		    	    	    
	    assertEquals("Recherche sur commune 2.2 invalide", resultatTestSet, getResultSearchCity(city2_2));		    
	}
	
	@Test
	/**
	 * Test recherche sur commune 2.2
	 */
	public void recherchePubRefCantonCommune2_3() {			
		// Recherche sur commune 2.2
		// city 2.3 est référencée par : FicheLieu 2.3
		Set<Publication> resultatTestSet = new HashSet<Publication>();
		resultatTestSet.add(elu2_3);    	    
	    assertEquals("Recherche sur commune 2.3 invalide", resultatTestSet, getResultSearchCity(city2_3));		    
	}

	
}
