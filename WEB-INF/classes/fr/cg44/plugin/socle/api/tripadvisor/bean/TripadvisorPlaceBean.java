
package fr.cg44.plugin.socle.api.tripadvisor.bean;

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
    "address_obj",
    "latitude",
    "rating",
    "location_id",
    "trip_types",
    "write_review",
    "ancestors",
    "longitude",
    "hours",
    "percent_recommended",
    "hotel_booking",
    "review_rating_count",
    "subratings",
    "ranking_data",
    "photo_count",
    "location_string",
    "web_url",
    "price_level",
    "rating_image_url",
    "awards",
    "name",
    "num_reviews",
    "category",
    "subcategory",
    "see_all_photos"
})
public class TripadvisorPlaceBean {

    @JsonProperty("address_obj")
    private AddressObj addressObj;
    @JsonProperty("latitude")
    private String latitude;
    @JsonProperty("rating")
    private String rating;
    @JsonProperty("location_id")
    private String locationId;
    @JsonProperty("trip_types")
    private List<TripType> tripTypes = null;
    @JsonProperty("write_review")
    private String writeReview;
    @JsonProperty("ancestors")
    private List<Ancestor> ancestors = null;
    @JsonProperty("longitude")
    private String longitude;
    @JsonProperty("hours")
    private Object hours;
    @JsonProperty("percent_recommended")
    private Object percentRecommended;
    @JsonProperty("hotel_booking")
    private HotelBooking hotelBooking;
    @JsonProperty("review_rating_count")
    private ReviewRatingCount reviewRatingCount;
    @JsonProperty("subratings")
    private List<Subrating> subratings = null;
    @JsonProperty("ranking_data")
    private RankingData rankingData;
    @JsonProperty("photo_count")
    private String photoCount;
    @JsonProperty("location_string")
    private String locationString;
    @JsonProperty("web_url")
    private String webUrl;
    @JsonProperty("price_level")
    private String priceLevel;
    @JsonProperty("rating_image_url")
    private String ratingImageUrl;
    @JsonProperty("awards")
    private List<Award> awards = null;
    @JsonProperty("name")
    private String name;
    @JsonProperty("num_reviews")
    private String numReviews;
    @JsonProperty("category")
    private Category category;
    @JsonProperty("subcategory")
    private List<Subcategory> subcategory = null;
    @JsonProperty("see_all_photos")
    private String seeAllPhotos;
    @JsonIgnore
    private Map<String, Object> additionalProperties = new HashMap<String, Object>();

    @JsonProperty("address_obj")
    public AddressObj getAddressObj() {
        return addressObj;
    }

    @JsonProperty("address_obj")
    public void setAddressObj(AddressObj addressObj) {
        this.addressObj = addressObj;
    }

    @JsonProperty("latitude")
    public String getLatitude() {
        return latitude;
    }

    @JsonProperty("latitude")
    public void setLatitude(String latitude) {
        this.latitude = latitude;
    }

    @JsonProperty("rating")
    public String getRating() {
        return rating;
    }

    @JsonProperty("rating")
    public void setRating(String rating) {
        this.rating = rating;
    }

    @JsonProperty("location_id")
    public String getLocationId() {
        return locationId;
    }

    @JsonProperty("location_id")
    public void setLocationId(String locationId) {
        this.locationId = locationId;
    }

    @JsonProperty("trip_types")
    public List<TripType> getTripTypes() {
        return tripTypes;
    }

    @JsonProperty("trip_types")
    public void setTripTypes(List<TripType> tripTypes) {
        this.tripTypes = tripTypes;
    }

    @JsonProperty("write_review")
    public String getWriteReview() {
        return writeReview;
    }

    @JsonProperty("write_review")
    public void setWriteReview(String writeReview) {
        this.writeReview = writeReview;
    }

    @JsonProperty("ancestors")
    public List<Ancestor> getAncestors() {
        return ancestors;
    }

    @JsonProperty("ancestors")
    public void setAncestors(List<Ancestor> ancestors) {
        this.ancestors = ancestors;
    }

    @JsonProperty("longitude")
    public String getLongitude() {
        return longitude;
    }

    @JsonProperty("longitude")
    public void setLongitude(String longitude) {
        this.longitude = longitude;
    }

    @JsonProperty("hours")
    public Object getHours() {
        return hours;
    }

    @JsonProperty("hours")
    public void setHours(Object hours) {
        this.hours = hours;
    }

    @JsonProperty("percent_recommended")
    public Object getPercentRecommended() {
        return percentRecommended;
    }

    @JsonProperty("percent_recommended")
    public void setPercentRecommended(Object percentRecommended) {
        this.percentRecommended = percentRecommended;
    }

    @JsonProperty("hotel_booking")
    public HotelBooking getHotelBooking() {
        return hotelBooking;
    }

    @JsonProperty("hotel_booking")
    public void setHotelBooking(HotelBooking hotelBooking) {
        this.hotelBooking = hotelBooking;
    }

    @JsonProperty("review_rating_count")
    public ReviewRatingCount getReviewRatingCount() {
        return reviewRatingCount;
    }

    @JsonProperty("review_rating_count")
    public void setReviewRatingCount(ReviewRatingCount reviewRatingCount) {
        this.reviewRatingCount = reviewRatingCount;
    }

    @JsonProperty("subratings")
    public List<Subrating> getSubratings() {
        return subratings;
    }

    @JsonProperty("subratings")
    public void setSubratings(List<Subrating> subratings) {
        this.subratings = subratings;
    }

    @JsonProperty("ranking_data")
    public RankingData getRankingData() {
        return rankingData;
    }

    @JsonProperty("ranking_data")
    public void setRankingData(RankingData rankingData) {
        this.rankingData = rankingData;
    }

    @JsonProperty("photo_count")
    public String getPhotoCount() {
        return photoCount;
    }

    @JsonProperty("photo_count")
    public void setPhotoCount(String photoCount) {
        this.photoCount = photoCount;
    }

    @JsonProperty("location_string")
    public String getLocationString() {
        return locationString;
    }

    @JsonProperty("location_string")
    public void setLocationString(String locationString) {
        this.locationString = locationString;
    }

    @JsonProperty("web_url")
    public String getWebUrl() {
        return webUrl;
    }

    @JsonProperty("web_url")
    public void setWebUrl(String webUrl) {
        this.webUrl = webUrl;
    }

    @JsonProperty("price_level")
    public String getPriceLevel() {
        return priceLevel;
    }

    @JsonProperty("price_level")
    public void setPriceLevel(String priceLevel) {
        this.priceLevel = priceLevel;
    }

    @JsonProperty("rating_image_url")
    public String getRatingImageUrl() {
        return ratingImageUrl;
    }

    @JsonProperty("rating_image_url")
    public void setRatingImageUrl(String ratingImageUrl) {
        this.ratingImageUrl = ratingImageUrl;
    }

    @JsonProperty("awards")
    public List<Award> getAwards() {
        return awards;
    }

    @JsonProperty("awards")
    public void setAwards(List<Award> awards) {
        this.awards = awards;
    }

    @JsonProperty("name")
    public String getName() {
        return name;
    }

    @JsonProperty("name")
    public void setName(String name) {
        this.name = name;
    }

    @JsonProperty("num_reviews")
    public String getNumReviews() {
        return numReviews;
    }

    @JsonProperty("num_reviews")
    public void setNumReviews(String numReviews) {
        this.numReviews = numReviews;
    }

    @JsonProperty("category")
    public Category getCategory() {
        return category;
    }

    @JsonProperty("category")
    public void setCategory(Category category) {
        this.category = category;
    }

    @JsonProperty("subcategory")
    public List<Subcategory> getSubcategory() {
        return subcategory;
    }

    @JsonProperty("subcategory")
    public void setSubcategory(List<Subcategory> subcategory) {
        this.subcategory = subcategory;
    }

    @JsonProperty("see_all_photos")
    public String getSeeAllPhotos() {
        return seeAllPhotos;
    }

    @JsonProperty("see_all_photos")
    public void setSeeAllPhotos(String seeAllPhotos) {
        this.seeAllPhotos = seeAllPhotos;
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
