<%@ include file="/jcore/doInitPage.jspf" %>
<%@ include file="/jcore/portal/doPortletParams.jspf" %>
<% 
PortletQueryForeach box = (PortletQueryForeach) portlet;  
%>
<%@ include file="/types/PortletQueryForeach/doQuery.jspf" %>
<%@ include file="/types/PortletQueryForeach/doSort.jspf" %><%


String lng = request.getParameter("lng");
String lat = request.getParameter("lat");
String rayon = request.getParameter("rayon");

%>

<script src='https://api.tiles.mapbox.com/mapbox-gl-js/v1.3.0/mapbox-gl.js'></script>
<link href='https://api.tiles.mapbox.com/mapbox-gl-js/v1.3.0/mapbox-gl.css' rel='stylesheet' />


<style>
.block-list {
    min-height: 63px;
    margin-bottom: 25px;
    display: block;
}

.block-date {
    display: inline-block;
    background-color: #ffd883;
    width: 150px;
    height: 100%;
    text-align: center;
}

.block-text {
    display: inline-block;
    background-color: #f5f5f5;
    height: 100%;
    padding-left: 15px;
}
</style>

<style>
body { margin:0; padding:0; }
#map { height: 650px}
</style>


<%

String query =  box.getQueries() != null ? box.getQueries()[0] : "";


Set<String> panier = (Set<String>) session.getAttribute(box.getId());

%>

<div class="container-fluid">


<div class="col-md-12">

  <form style="margin-top: 20px;">
     longitude : <input type="text" name="lng" value="<%= lng %>">
     latitude : <input type="text" name="lat" value="<%= lat %>">    
     rayon : <input type="text" name="rayon" value="<%= rayon %>">
     <button type="submit" name="search" value="opSearch">Rechercher</button>
  </form>
  
  <div>Ma selection (<span id="nb-selection"><%= Util.notEmpty(panier) ? panier.size() : "0" %></span>) <span id="indicator"></span></div>
  
</div>


    
    <div id='list' class="col-md-6">
    
    Chargement en cours...
    
    </div>

    <div class="col-md-6">
        <div id='map'></div>
        <div id='distance' class='distance-container'></div>
        <div class="panier2">hey</div>
    </div>

</div>

<script>

;(function() {
    
var center = new mapboxgl.LngLat(<%= lng %>, <%= lat %>);
var radius = <%= rayon %>;
var bounds = center.toBounds(radius).toArray();

mapboxgl.accessToken = 'Xu3oYUrAHUfq6Imd96ms';
var map = new mapboxgl.Map({
container: 'map',
style: 'https://maps.tilehosting.com/styles/basic/style.json?key=Xu3oYUrAHUfq6Imd96ms', // stylesheet location
bounds: bounds
});

map.on('load', function() {
    map.addControl(new mapboxgl.NavigationControl());
    refreshResultAjax();    
});

map.on('moveend', function() {  
    refreshResultAjax();    
});



//Recalcul les résultats de la liste des que la position de la carte change
//La liste est rafraichie seulement si la nouvelle liste de résultat envoyée est différente de l'ancienne
function refreshResultAjax(){
    
    var httpRequest = new XMLHttpRequest();
    
    
        document.getElementById("indicator").innerHTML = "Chargement en cours...";
    
     
        httpRequest.onreadystatechange = function(data) {       
        if (this.readyState === XMLHttpRequest.DONE && this.status === 200) {
            // La liste est rafraichie seulement si la nouvelle liste de résultat envoyée est différente de l'ancienne              
            if(document.getElementById("list").innerHTML.trim() != this.responseText.trim()) {     
              document.getElementById("list").innerHTML = this.responseText.trim();
              updateCartListener();
            }       
            document.getElementById("indicator").innerHTML = "";
         }              
        };
    
    // TODO CHANNEL + jsp dans le plugin dossier jsp
    httpRequest.open("GET", "plugins/ChartePlugin/types/PortletQueryForeach/displayResult.jsp" +
            "?northWestLat=" + map.getBounds().getNorthWest().lat +
            "&northWestLng=" + map.getBounds().getNorthWest().lng +
            "&southEastLat=" + map.getBounds().getSouthEast().lat + 
            "&southEastLng=" + map.getBounds().getSouthEast().lng +
            "&cartId=<%= box.getId() %>" +
            "&query=<%= HttpUtil.encodeForURL(query) %>");
    
    httpRequest.send();
}




var markersMap = new Map();

//Affiche les markers sur la carte si non présent


function updateMarker(data) {
    
    // Récupère la position des markers depuis la liste de résultats
    var resultList = document.getElementById("result-list");    
    var resultLi = resultList.querySelectorAll("li");
    

    resultLi.forEach(function(itLi) {
        var dataId = itLi.getAttribute("data-id");
        var lat = itLi.getAttribute("data-lat");
        var lng = itLi.getAttribute("data-lng");
        
        // Ajoute le marker sur la carte si non présent
        if(markersMap.get(dataId) == null) {
        
          var marker = new mapboxgl.Marker()
           .setLngLat([lng, lat])
           .addTo(map);
        
           markersMap.set(dataId, marker);
        }        
        
    });
}





// Relance l'affichage des markers dès que la liste des résultats change

const targetNode  = document.getElementById("list");
const config = { attributes: false, childList: true, subtree: true };

const callback = function(mutationsList, observer) {
    for(let mutation of mutationsList) {
        if (mutation.type === 'childList') {    
            updateMarker();                                            
        }
    }
};

const observer = new MutationObserver(callback);
observer.observe(targetNode, config);




function updateCartListener() {
    var panier = document.getElementsByClassName('panier');
    for (var i = 0; i < panier.length; i++) {
    	const elt = panier[i];
    	const eltId = elt.getAttribute("data-id");   	
        panier[i].addEventListener('click', function(e){updateCartAjax(elt, "<%= box.getId() %>", eltId)}, false);
    }
}


function updateCartAjax(elt, portletId, EltId) {	
	var httpRequest = new XMLHttpRequest();
	httpRequest.onreadystatechange = function(data) {       
	    if (this.readyState === XMLHttpRequest.DONE && this.status === 200) {
	    	var nbPanierElt = document.getElementById("nb-selection");
	    	if(this.responseText.indexOf("add") != -1) {
	    		elt.innerHTML = "Retirer du panier";
	    		nbPanierElt.innerHTML = parseInt(nbPanierElt.innerHTML, 10) + 1;
	    	}else {
	    		elt.innerHTML = "Ajouter au panier";
	    		nbPanierElt.innerHTML = parseInt(nbPanierElt.innerHTML, 10) - 1;
	    	}
	    }	    
    };
    httpRequest.open("GET", "plugins/ChartePlugin/types/PortletQueryForeach/doCart.jsp?panierId=" + portletId + "&panierEltId=" + EltId);    
    httpRequest.send();
}


})();










</script>
