package fr.cg44.plugin.socle.infolocale.fluxdata;

import org.json.JSONObject;

public class FluxExtraction extends FluxBase {
    
    int page;
    int pageCount;
    int limit;
    int resultCount;
    JSONObject[] result;
    
    public int getPage() {
        return page;
    }
    public void setPage(int page) {
        this.page = page;
    }
    public int getPageCount() {
        return pageCount;
    }
    public void setPageCount(int pageCount) {
        this.pageCount = pageCount;
    }
    public int getLimit() {
        return limit;
    }
    public void setLimit(int limit) {
        this.limit = limit;
    }
    public int getResultCount() {
        return resultCount;
    }
    public void setResultCount(int resultCount) {
        this.resultCount = resultCount;
    }
    public JSONObject[] getResult() {
        return result;
    }
    public void setResult(JSONObject[] result) {
        this.result = result;
    }
    
}