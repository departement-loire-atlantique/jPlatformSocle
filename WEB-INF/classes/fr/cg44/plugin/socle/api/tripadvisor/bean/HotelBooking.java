
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
    "bookable",
    "booking_url"
})
public class HotelBooking {

    @JsonProperty("bookable")
    private Boolean bookable;
    @JsonProperty("booking_url")
    private String bookingUrl;
    @JsonIgnore
    private Map<String, Object> additionalProperties = new HashMap<String, Object>();

    @JsonProperty("bookable")
    public Boolean getBookable() {
        return bookable;
    }

    @JsonProperty("bookable")
    public void setBookable(Boolean bookable) {
        this.bookable = bookable;
    }

    @JsonProperty("booking_url")
    public String getBookingUrl() {
        return bookingUrl;
    }

    @JsonProperty("booking_url")
    public void setBookingUrl(String bookingUrl) {
        this.bookingUrl = bookingUrl;
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
