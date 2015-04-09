<%@ page import="org.apache.commons.lang3.StringUtils" %>
<%@ page import="com.kportal.core.config.MessageHelper" %>
<%@ page import="com.jsbsoft.jtf.exception.ErreurApplicative" %>
<%@ page import="com.kportal.cms.objetspartages.ObjetPartageHelper" %>
<%@ page import="com.kportal.frontoffice.util.JSPIncludeHelper" %>
<%@ page import="com.univ.objetspartages.om.ReferentielObjets" %>
<%@ page import="com.univ.utils.EscapeString" %>
<%@ page import="com.univ.utils.ContexteUniv" %>
<%@ page import="com.univ.utils.UnivWebFmt" %>
<%@ page import="com.jsbsoft.jtf.core.LangueUtil" %>
<%@ page import="com.univ.objetspartages.om.Structure" %>
<%@ page import="com.univ.objetspartages.om.Libelle" %>
<%@ page import="com.univ.utils.URLResolver" %>
<%@ page import="java.lang.*" %>
<%@ page import="java.text.*" %>
<%@ page import="java.util.*" %>
<%@ page errorPage="./jsb_exception.jsp" %>
<jsp:useBean id="infoBean" class="com.jsbsoft.jtf.core.InfoBean" scope="request" />
<jsp:useBean id="mapParam" class="java.util.HashMap" scope="request" />
<jsp:useBean id="fmt" class="com.jsbsoft.jtf.core.FormateurJSP" scope="page" />
<jsp:useBean id="univFmt" class="com.univ.utils.UnivFmt" scope="page" />
<%@ include file="./template/initialisations.jsp" %><%
	ctx.setRequete(request.getQueryString());
	String nomObjet = infoBean.getString("OBJET");
	if (StringUtils.isEmpty(nomObjet)) {
		throw new ErreurApplicative("Impossible d'effectuer une recherche avancée sans préciser l'objet");
	} else if (!ReferentielObjets.getObjetByNom(nomObjet).isRecherchable()) {
		throw new ErreurApplicative("Impossible d'effectuer une recherche avancée sur l'objet " + EscapeString.escapeHtml(nomObjet) + ".");
	}
	titre = MessageHelper.getCoreMessage("ST_RECHERCHE_FICHE_RECHERCHER") + " " + MessageHelper.getCoreMessage("ST_RECHERCHE_FICHE_" + nomObjet);
	soustitre = "<p id=\"recherche_precisions\">" + MessageHelper.getCoreMessage("ST_RECHERCHE_FICHE_PRECISIONS") + "</p>";
%>
<%@ include file="./template/header.jsp" %>
<form id="recherche_avancee" class="" action="<%=URLResolver.getAbsoluteUrl("/servlet/com.jsbsoft.jtf.core.SG", ctx)%>" method="post">
	<div class="fieldset">
		<% fmt.insererVariablesCachees(out, infoBean); %>
		<input type="hidden" name="OBJET" value="<%=nomObjet%>" />
		<input type="hidden" name="LANGUE" value="<%=ctx.getLangue()%>" />
		<% JSPIncludeHelper.includeJsp(out, getServletConfig().getServletContext(), request, response, ObjetPartageHelper.getTemplateObjet(ObjetPartageHelper.TEMPLATE_RECHERCHE, nomObjet.toLowerCase())); %>
	</div><!-- .fieldset -->
	<p class="validation">
		<input class="reset" value="<%=MessageHelper.getCoreMessage("ST_RECHERCHE_EFFACER")%>" type="reset" onclick="viderFormulaire('<%=mapParam.get("criteresRechAvancee")%>'); return false;" />
		<input class="submit" value="<%=MessageHelper.getCoreMessage("ST_RECHERCHE_VALIDER")%>" type="submit" />
	</p>
</form>
<%@ include file="./template/footer.jsp" %>
