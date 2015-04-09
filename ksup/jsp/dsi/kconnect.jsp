<%@page import="com.kportal.cms.objetspartages.Objetpartage"%>
<%@page import="com.univ.objetspartages.om.StructureModele"%>
<%@page import="com.univ.objetspartages.om.ReferentielObjets"%>
<%@page import="com.kportal.cms.objetspartages.ObjetPartageHelper"%>
<%@page import="com.kportal.frontoffice.util.JSPIncludeHelper"%>
<%@ page import="com.univ.utils.ContexteUniv,com.univ.utils.UnivWebFmt,com.univ.objetspartages.om.Libelle,com.univ.utils.URLResolver,java.util.*,java.text.*,java.lang.*" errorPage ="./jsb_exception.jsp" %>
<%@ include file="../template/initialisations.jsp" %>
<%
if (ctx.getTemplateExterne() != null) {
	if (ctx.getTemplateExterne().equalsIgnoreCase("haut")) {
	/* Connecteur : titre de la page (piloté par l'application) */
	String specificTitle = (String) ctx.getDonneesSpecifiques().get("TITLE");
	if (specificTitle != null)
	{ titre = specificTitle; }
	
	%><%@ include file="../template/header.jsp" %><%
	}
	else if (ctx.getTemplateExterne().equalsIgnoreCase("bas"))
	{ %><%@ include file="../template/footer.jsp" %><% }
} %>