package fr.cg44.plugin.socle.bean;

import com.jalios.jcms.Data;
import com.jalios.jcms.db.DBData;

public class FacetSearch extends Data implements DBData {

	private static final long serialVersionUID = 1L;
	private Integer cpt;
	private String guid;
	private String query;
	
	public FacetSearch() {
	}

	public FacetSearch(Integer jRowId, Integer cpt, String guid, String query) {
		super();
		this.cpt = cpt;
		this.guid = guid;
		this.query = query;
	}
		

	public Integer getCpt() {
    return cpt;
  }

  public void setCpt(Integer cpt) {
    this.cpt = cpt;
  }

  public String getGuid() {
		return guid;
	}

	public void setGuid(String guid) {
		this.guid = guid;
	}

	public String getQuery() {
		return query;
	}

	public void setQuery(String query) {
		this.query = query;
	}
		
}
