package fr.cg44.plugin.socle.bean;

import java.util.HashMap;
import java.util.Map;
import com.fasterxml.jackson.annotation.JsonAnyGetter;
import com.fasterxml.jackson.annotation.JsonAnySetter;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonPropertyOrder;

@JsonInclude(JsonInclude.Include.NON_NULL)
@JsonPropertyOrder({
	"sectorisation",
	"matricule",
	"libelle"
})
@JsonIgnoreProperties(ignoreUnknown = true)
public class SectorResult {
	
	@JsonProperty("entite_id")
	private String entiteId;	
	@JsonProperty("sectorisation")
	private String sectorisation;
	@JsonProperty("origine_matricule_id")
	private String origineMatriculeId;
	@JsonProperty("matricule")
	private String matricule;
	@JsonProperty("libelle")
	private String libelle;
	@JsonIgnore
	private Map<String, Object> additionalProperties = new HashMap<String, Object>();

		
	@JsonProperty("entite_id")
	public String getEntiteId() {
		return entiteId;
	}

	@JsonProperty("entite_id")
	public void setEntiteId(String entiteId) {
		this.entiteId = entiteId;
	}
	
	@JsonProperty("sectorisation")
	public String getSectorisation() {
		return sectorisation;
	}

	@JsonProperty("sectorisation")
	public void setSectorisation(String sectorisation) {
		this.sectorisation = sectorisation;
	}
		
	@JsonProperty("origine_matricule_id")
	public String getOrigineMatriculeId() {
		return origineMatriculeId;
	}

	@JsonProperty("origine_matricule_id")
	public void setOrigineMatriculeId(String origineMatriculeId) {
		this.origineMatriculeId = origineMatriculeId;
	}

	@JsonProperty("matricule")
	public String getMatricule() {
		return matricule;
	}

	@JsonProperty("matricule")
	public void setMatricule(String matricule) {
		this.matricule = matricule;
	}

	@JsonProperty("libelle")
	public String getLibelle() {
		return libelle;
	}

	@JsonProperty("libelle")
	public void setLibelle(String libelle) {
		this.libelle = libelle;
	}

	@JsonAnyGetter
	public Map<String, Object> getAdditionalProperties() {
		return this.additionalProperties;
	}

	@JsonAnySetter
	public void setAdditionalProperty(String name, Object value) {
		this.additionalProperties.put(name, value);
	}

	/**
	 * Renvoie un idendifiant unique de l'entité
	 */
	public String getUniqueId() {
		return "1".equals(getOrigineMatriculeId()) ? getMatricule() : getEntiteId();
	}
}