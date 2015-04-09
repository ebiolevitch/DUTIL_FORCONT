<%@page import="com.kportal.cms.objetspartages.Objetpartage"%>
<%@page import="com.univ.objetspartages.om.StructureModele"%>
<%@page import="com.univ.objetspartages.om.ReferentielObjets"%>
<%@page import="com.kportal.cms.objetspartages.ObjetPartageHelper"%>
<%@page import="com.kportal.frontoffice.util.JSPIncludeHelper"%>
<%@ page import="com.univ.utils.ContexteUniv,com.univ.utils.UnivWebFmt,com.univ.objetspartages.om.Libelle,com.univ.utils.URLResolver,java.util.*,java.text.*,java.lang.*" errorPage ="./jsb_exception.jsp" %>
<%@ include file="./template/initialisations.jsp" %>
<%
	JSPIncludeHelper.includeJsp(out,getServletContext(),request,response,ObjetPartageHelper.getTemplateObjet(ObjetPartageHelper.TEMPLATE_ENTETE_FICHE,ReferentielObjets.getNomObjet(ficheUniv).toLowerCase()));
	if (ctx.getData("surtitre")!=null){
		surtitre = ctx.getDataAsString("surtitre");
	}
	if (ctx.getData("titre")!=null){
		titre = ctx.getDataAsString("titre");
	}
	if (ctx.getData("soustitre")!=null){
		soustitre = ctx.getDataAsString("soustitre");
	}
%>
<%@ include file="./template/header.jsp" %>
<%
	JSPIncludeHelper.includeJsp(out,getServletContext(),request,response,ObjetPartageHelper.getTemplateObjet(ObjetPartageHelper.TEMPLATE_FICHE,ReferentielObjets.getNomObjet(ficheUniv).toLowerCase()));
%>
<%@ include file="./template/footer.jsp" %>
