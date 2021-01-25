
package fr.cg44.plugin.socle.api.tripadvisor.bean;

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
    "ranking_string",
    "ranking_out_of",
    "geo_location_id",
    "ranking",
    "geo_location_name"
})
public class RankingData {

    @JsonProperty("ranking_string")
    private String rankingString;
    @JsonProperty("ranking_out_of")
    private String rankingOutOf;
    @JsonProperty("geo_location_id")
    private String geoLocationId;
    @JsonProperty("ranking")
    private String ranking;
    @JsonProperty("geo_location_name")
    private String geoLocationName;
    @JsonIgnore
    private Map<String, Object> additionalProperties = new HashMap<String, Object>();

    @JsonProperty("ranking_string")
    public String getRankingString() {
        return rankingString;
    }

    @JsonProperty("ranking_string")
    public void setRankingString(String rankingString) {
        this.rankingString = rankingString;
    }

    @JsonProperty("ranking_out_of")
    public String getRankingOutOf() {
        return rankingOutOf;
    }

    @JsonProperty("ranking_out_of")
    public void setRankingOutOf(String rankingOutOf) {
        this.rankingOutOf = rankingOutOf;
    }

    @JsonProperty("geo_location_id")
    public String getGeoLocationId() {
        return geoLocationId;
    }

    @JsonProperty("geo_location_id")
    public void setGeoLocationId(String geoLocationId) {
        this.geoLocationId = geoLocationId;
    }

    @JsonProperty("ranking")
    public String getRanking() {
        return ranking;
    }

    @JsonProperty("ranking")
    public void setRanking(String ranking) {
        this.ranking = ranking;
    }

    @JsonProperty("geo_location_name")
    public String getGeoLocationName() {
        return geoLocationName;
    }

    @JsonProperty("geo_location_name")
    public void setGeoLocationName(String geoLocationName) {
        this.geoLocationName = geoLocationName;
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
