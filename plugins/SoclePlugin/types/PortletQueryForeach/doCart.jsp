<%@ include file='/jcore/doInitPage.jspf' %>

<%

String panierPortletId = request.getParameter("panierId");
String panierOp = request.getParameter("panierOp");
String panierEltId = request.getParameter("panierEltId");

Set<String> panier = (Set<String>) session.getAttribute(panierPortletId);


if(Util.isEmpty(panier)){
	panier = new HashSet<String>();
}

if(panier.contains(panierEltId)) {
	panier.remove(panierEltId);
	out.print("remove");
}else {
	panier.add(panierEltId);
    out.print("add");
}


session.setAttribute(panierPortletId, panier);

%>