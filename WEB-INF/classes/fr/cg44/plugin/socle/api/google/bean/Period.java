
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
    "close",
    "open"
})
public class Period {

    @JsonProperty("close")
    private Close close;
    @JsonProperty("open")
    private Open open;
    @JsonIgnore
    private Map<String, Object> additionalProperties = new HashMap<String, Object>();

    @JsonProperty("close")
    public Close getClose() {
        return close;
    }

    @JsonProperty("close")
    public void setClose(Close close) {
        this.close = close;
    }

    @JsonProperty("open")
    public Open getOpen() {
        return open;
    }

    @JsonProperty("open")
    public void setOpen(Open open) {
        this.open = open;
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
