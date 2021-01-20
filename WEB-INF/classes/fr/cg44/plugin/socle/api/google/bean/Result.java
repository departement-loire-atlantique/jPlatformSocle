
package fr.cg44.plugin.socle.api.google.bean;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import com.fasterxml.jackson.annotation.JsonAnyGetter;
import com.fasterxml.jackson.annotation.JsonAnySetter;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonPropertyOrder;

@JsonInclude(JsonInclude.Include.NON_NULL)
@JsonPropertyOrder({
    "address_components",
    "adr_address",
    "formatted_address",
    "formatted_phone_number",
    "geometry",
    "icon",
    "id",
    "international_phone_number",
    "name",
    "place_id",
    "rating",
    "reference",
    "reviews",
    "types",
    "url",
    "utc_offset",
    "vicinity",
    "website"
})
public class Result {

    @JsonProperty("address_components")
    private List<AddressComponent> addressComponents = null;
    @JsonProperty("adr_address")
    private String adrAddress;
    @JsonProperty("formatted_address")
    private String formattedAddress;
    @JsonProperty("formatted_phone_number")
    private String formattedPhoneNumber;
    @JsonProperty("geometry")
    private Geometry geometry;
    @JsonProperty("icon")
    private String icon;
    @JsonProperty("id")
    private String id;
    @JsonProperty("international_phone_number")
    private String internationalPhoneNumber;
    @JsonProperty("name")
    private String name;
    @JsonProperty("place_id")
    private String placeId;
    @JsonProperty("rating")
    private Double rating;
    @JsonProperty("reference")
    private String reference;
    @JsonProperty("reviews")
    private List<Review> reviews = null;
    @JsonProperty("types")
    private List<String> types = null;
    @JsonProperty("url")
    private String url;
    @JsonProperty("utc_offset")
    private Integer utcOffset;
    @JsonProperty("vicinity")
    private String vicinity;
    @JsonProperty("website")
    private String website;
    @JsonIgnore
    private Map<String, Object> additionalProperties = new HashMap<String, Object>();

    @JsonProperty("address_components")
    public List<AddressComponent> getAddressComponents() {
        return addressComponents;
    }

    @JsonProperty("address_components")
    public void setAddressComponents(List<AddressComponent> addressComponents) {
        this.addressComponents = addressComponents;
    }

    @JsonProperty("adr_address")
    public String getAdrAddress() {
        return adrAddress;
    }

    @JsonProperty("adr_address")
    public void setAdrAddress(String adrAddress) {
        this.adrAddress = adrAddress;
    }

    @JsonProperty("formatted_address")
    public String getFormattedAddress() {
        return formattedAddress;
    }

    @JsonProperty("formatted_address")
    public void setFormattedAddress(String formattedAddress) {
        this.formattedAddress = formattedAddress;
    }

    @JsonProperty("formatted_phone_number")
    public String getFormattedPhoneNumber() {
        return formattedPhoneNumber;
    }

    @JsonProperty("formatted_phone_number")
    public void setFormattedPhoneNumber(String formattedPhoneNumber) {
        this.formattedPhoneNumber = formattedPhoneNumber;
    }

    @JsonProperty("geometry")
    public Geometry getGeometry() {
        return geometry;
    }

    @JsonProperty("geometry")
    public void setGeometry(Geometry geometry) {
        this.geometry = geometry;
    }

    @JsonProperty("icon")
    public String getIcon() {
        return icon;
    }

    @JsonProperty("icon")
    public void setIcon(String icon) {
        this.icon = icon;
    }

    @JsonProperty("id")
    public String getId() {
        return id;
    }

    @JsonProperty("id")
    public void setId(String id) {
        this.id = id;
    }

    @JsonProperty("international_phone_number")
    public String getInternationalPhoneNumber() {
        return internationalPhoneNumber;
    }

    @JsonProperty("international_phone_number")
    public void setInternationalPhoneNumber(String internationalPhoneNumber) {
        this.internationalPhoneNumber = internationalPhoneNumber;
    }

    @JsonProperty("name")
    public String getName() {
        return name;
    }

    @JsonProperty("name")
    public void setName(String name) {
        this.name = name;
    }

    @JsonProperty("place_id")
    public String getPlaceId() {
        return placeId;
    }

    @JsonProperty("place_id")
    public void setPlaceId(String placeId) {
        this.placeId = placeId;
    }

    @JsonProperty("rating")
    public Double getRating() {
        return rating;
    }

    @JsonProperty("rating")
    public void setRating(Double rating) {
        this.rating = rating;
    }

    @JsonProperty("reference")
    public String getReference() {
        return reference;
    }

    @JsonProperty("reference")
    public void setReference(String reference) {
        this.reference = reference;
    }

    @JsonProperty("reviews")
    public List<Review> getReviews() {
        return reviews;
    }

    @JsonProperty("reviews")
    public void setReviews(List<Review> reviews) {
        this.reviews = reviews;
    }

    @JsonProperty("types")
    public List<String> getTypes() {
        return types;
    }

    @JsonProperty("types")
    public void setTypes(List<String> types) {
        this.types = types;
    }

    @JsonProperty("url")
    public String getUrl() {
        return url;
    }

    @JsonProperty("url")
    public void setUrl(String url) {
        this.url = url;
    }

    @JsonProperty("utc_offset")
    public Integer getUtcOffset() {
        return utcOffset;
    }

    @JsonProperty("utc_offset")
    public void setUtcOffset(Integer utcOffset) {
        this.utcOffset = utcOffset;
    }

    @JsonProperty("vicinity")
    public String getVicinity() {
        return vicinity;
    }

    @JsonProperty("vicinity")
    public void setVicinity(String vicinity) {
        this.vicinity = vicinity;
    }

    @JsonProperty("website")
    public String getWebsite() {
        return website;
    }

    @JsonProperty("website")
    public void setWebsite(String website) {
        this.website = website;
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
