<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file='/jcore/doInitPage.jspf' %>
<%@ include file='/jcore/portal/doPortletParams.jspf' %>
<% 
	// PAS TERMINE !

	PortletFacetteCategorie obj = (PortletFacetteCategorie)portlet; 

	String idFormElement = ServletUtil.generateUniqueDOMId(request, "form-element");
%>

<div class="ds44-form__container">
	<div class="ds44-select__shape ds44-inpLarge">
		<p class="ds44-selectLabel" id='<%= "label-" + idFormElement %>'>
			<%= Util.notEmpty(obj.getLabel()) ? obj.getLabel() : obj.getCategoriesRacines(loggedMember).first().getName() %><%= obj.getFacetteObligatoire() ? "<sup aria-hidden=\"true\">*</sup>" : "" %>
		</p>
		<p id='<%= idFormElement %>' class="ds44-selectDisplay" <%= obj.getFacetteObligatoire() ? "data-required=\"true\"" : ""%>></p>
		<button type="button" class="ds44-btnIco ds44-posAbs ds44-posRi ds44-btnOpen" 
				aria-labelledby='<%= "label-" + idFormElement %>' 
				aria-expanded="false"
				aria-controls='<%= "list-select-" + idFormElement %>'>
			<i class="icon icon-down icon--sizeXL" aria-hidden="true"></i><span class="visually-hidden"><%= glp("jcmsplugin.socle.facette.category.hidden-label") %></span>
		</button>
	</div>
	
	<div class="ds44-select-container hidden" role="combobox" id='<%= "list-select-" + idFormElement %>'>
		<div class="ds44-listSelect">
			<ul class="ds44-list" role="listbox" id='<%= "listbox-" + idFormElement %>'>
				<%
					String nameType = obj.getTypeDeSelection() ? "name-check-" : "name-radio-";
					StringBuffer sbfNameCheck = new StringBuffer();
					sbfNameCheck.append(nameType)
						.append(idFormElement);
					
					int nbrTotalCat = 0;
				%>
				<jalios:foreach name="itRootCat" type="Category" collection="<%= obj.getCategoriesRacines(loggedMember) %>">
					<jalios:foreach name="itCat" type="Category" collection="<%= itRootCat.getChildrenSet() %>">
						<%
							nbrTotalCat++;
							StringBuffer sbfNameCheckCat = new StringBuffer();
							sbfNameCheckCat.append(sbfNameCheck.toString())
								.append("-")
								.append(nbrTotalCat);
						%>
						<li class="ds44-select-list_elem" role="option">
							<%
								String typeInput = obj.getTypeDeSelection() ? "checkbox" : "radio";
								StringBuffer sbfClassInput = new StringBuffer();
								sbfClassInput.append("ds44-")
									.append(typeInput);
								
								String labelInput = obj.getTypeDeSelection() ? "box" : "radio";
								StringBuffer sbfClassLabelInput = new StringBuffer();
								sbfClassLabelInput.append("ds44-")
									.append(labelInput)
									.append("Label");
							%>
							<div class="ds44-form__container ds44-checkBox-radio_list ">
								<input type='<%= typeInput %>' value='<%= nbrTotalCat %>' id='<%= sbfNameCheckCat.toString() %>' class='<%= sbfClassInput.toString() %>' 
										<%= obj.getTypeDeSelection() ? "" : "name='" + idFormElement + "'" %>/>
								<label for='<%= sbfNameCheckCat.toString() %>' class='<%= sbfClassLabelInput %>' 
										<%= obj.getTypeDeSelection() ? "" : "for='" + sbfNameCheckCat.toString() + "'" %>>
									<%= itCat.getName() %>
								</label>
							</div>
						</li>
					</jalios:foreach>
				</jalios:foreach>
			</ul>
		</div>
		<button type="button" class="ds44-fullWBtn ds44-btnSelect ds44-theme" aria-label="Valider Choix 2" aria-hidden="true" tabindex="-1">
			<span class="ds44-btnInnerText" aria-hidden="true"><%= glp("jcmsplugin.socle.valider") %></span>
			<i class="icon icon-long-arrow-right ds44-noLineH" aria-hidden="true"></i>
		</button>
	</div>
</div>