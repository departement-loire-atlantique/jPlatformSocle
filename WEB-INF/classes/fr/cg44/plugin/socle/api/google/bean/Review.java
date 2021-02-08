
package fr.cg44.plugin.socle.api.google.bean;

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
    "author_name",
    "author_url",
    "language",
    "profile_photo_url",
    "rating",
    "relative_time_description",
    "text",
    "time"
})
public class Review {

    @JsonProperty("author_name")
    private String authorName;
    @JsonProperty("author_url")
    private String authorUrl;
    @JsonProperty("language")
    private String language;
    @JsonProperty("profile_photo_url")
    private String profilePhotoUrl;
    @JsonProperty("rating")
    private Integer rating;
    @JsonProperty("relative_time_description")
    private String relativeTimeDescription;
    @JsonProperty("text")
    private String text;
    @JsonProperty("time")
    private Integer time;
    @JsonIgnore
    private Map<String, Object> additionalProperties = new HashMap<String, Object>();

    @JsonProperty("author_name")
    public String getAuthorName() {
        return authorName;
    }

    @JsonProperty("author_name")
    public void setAuthorName(String authorName) {
        this.authorName = authorName;
    }

    @JsonProperty("author_url")
    public String getAuthorUrl() {
        return authorUrl;
    }

    @JsonProperty("author_url")
    public void setAuthorUrl(String authorUrl) {
        this.authorUrl = authorUrl;
    }

    @JsonProperty("language")
    public String getLanguage() {
        return language;
    }

    @JsonProperty("language")
    public void setLanguage(String language) {
        this.language = language;
    }

    @JsonProperty("profile_photo_url")
    public String getProfilePhotoUrl() {
        return profilePhotoUrl;
    }

    @JsonProperty("profile_photo_url")
    public void setProfilePhotoUrl(String profilePhotoUrl) {
        this.profilePhotoUrl = profilePhotoUrl;
    }

    @JsonProperty("rating")
    public Integer getRating() {
        return rating;
    }

    @JsonProperty("rating")
    public void setRating(Integer rating) {
        this.rating = rating;
    }

    @JsonProperty("relative_time_description")
    public String getRelativeTimeDescription() {
        return relativeTimeDescription;
    }

    @JsonProperty("relative_time_description")
    public void setRelativeTimeDescription(String relativeTimeDescription) {
        this.relativeTimeDescription = relativeTimeDescription;
    }

    @JsonProperty("text")
    public String getText() {
        return text;
    }

    @JsonProperty("text")
    public void setText(String text) {
        this.text = text;
    }

    @JsonProperty("time")
    public Integer getTime() {
        return time;
    }

    @JsonProperty("time")
    public void setTime(Integer time) {
        this.time = time;
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
