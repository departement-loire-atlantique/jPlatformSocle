package fr.cg44.plugin.socle.bean;

import java.util.HashMap;
import java.util.Map;
import com.fasterxml.jackson.annotation.JsonAnyGetter;
import com.fasterxml.jackson.annotation.JsonAnySetter;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonPropertyOrder;

@JsonInclude(JsonInclude.Include.NON_NULL)
@JsonPropertyOrder({
	"sectorisation",
	"matricule",
	"libelle"
})
public class SectorResult {

	@JsonProperty("sectorisation")
	private String sectorisation;
	@JsonProperty("matricule")
	private String matricule;
	@JsonProperty("libelle")
	private String libelle;
	@JsonIgnore
	private Map<String, Object> additionalProperties = new HashMap<String, Object>();

	@JsonProperty("sectorisation")
	public String getSectorisation() {
		return sectorisation;
	}

	@JsonProperty("sectorisation")
	public void setSectorisation(String sectorisation) {
		this.sectorisation = sectorisation;
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

}