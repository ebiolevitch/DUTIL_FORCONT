<%@page import="com.univ.objetspartages.om.ParagrapheBean"%>
<%@page import="com.kportal.ihm.utils.FrontUtil"%>
<%@page import="java.util.Collection"%>
<% /* Styles Dynamiques */ %>
<style type="text/css" media="screen">

/*  remplacer par variable bandeau (de site) usine à sites */
#bandeau {
	<% if (StringUtils.isNotBlank(frontOfficeBean.getVisuelRubrique())) { %>
		background-image : url(<%= URLResolver.getRessourceUrl(frontOfficeBean.getVisuelRubrique(), ctx) %>);
	<% } %>
}

<%
Collection<ParagrapheBean> paragraphesFiche = FrontUtil.getParagrapheDepuisFicheCourante(ficheUniv);
if (!paragraphesFiche.isEmpty()) {
	%>
	@media screen and (min-width: 50em) {<%
		for (ParagrapheBean paragraphe : paragraphesFiche) {
			%>.ligne_<%=paragraphe.getLigne() %> > .colonne_<%= paragraphe.getColonne() %> {
				width : <%= paragraphe.getLargeur() %>%;
			}<%
		}
	%>
	}<%
	// Ajout du support pour ie7 et 8 sur le positionnement des paragraphes de la page
	for (ParagrapheBean paragraphe : paragraphesFiche) {
		%>.ie7 .ligne_<%=paragraphe.getLigne() %> > .colonne_<%= paragraphe.getColonne() %>,
		.ie8 .ligne_<%=paragraphe.getLigne() %> > .colonne_<%= paragraphe.getColonne() %> {
			width : <%= paragraphe.getLargeur() %>%;
		}<%
	}
}
%>

</style>