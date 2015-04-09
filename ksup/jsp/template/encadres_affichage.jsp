<%@page import="com.univ.utils.ContexteUniv"%>
<%@page import="com.kportal.ihm.utils.EncadresFrontUtils"%>
<%@page import="java.util.List"%>
<%@page import="com.univ.objetspartages.om.FicheUniv"%>
<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@page import="com.kportal.ihm.utils.EncadresFrontUtils"%>
<%@page import="com.univ.utils.ContexteUtil"%>
<%@page import="com.univ.utils.UnivWebFmt"%>
<%@page import="java.util.Map"%>
<%@page import="com.univ.objetspartages.om.SousParagrapheBean"%>
<%@page import="com.kportal.cms.objetspartages.ObjetPartageHelper"%>
<%@page import="com.kportal.frontoffice.util.JSPIncludeHelper"%>
<jsp:useBean id="frontOfficeBean" class="com.univ.url.FrontOfficeBean" scope="request" /><%
ContexteUniv ctx = ContexteUtil.getContexteUniv();
if (frontOfficeBean.isEncadrePresent()) {
	%><div id="encadres" role="complementary"><%
		if  (StringUtils.isNotBlank(frontOfficeBean.getEncadresAutoFiche())) {
			%><%= frontOfficeBean.getEncadresAutoFiche()%><%
		}
		%><jsp:include page="<%= frontOfficeBean.getJspFo() + \"/template/encadres/encadre_type.jsp\" %>">
			<jsp:param name="TYPE" value="<%= EncadresFrontUtils.FICHE %>" />
		</jsp:include>
		<jsp:include page="<%= frontOfficeBean.getJspFo() + \"/template/encadres/encadre_type.jsp\" %>">
			<jsp:param name="TYPE" value="<%= EncadresFrontUtils.NAV_AUTO %>" />
		</jsp:include>
		<jsp:include page="<%= frontOfficeBean.getJspFo() + \"/template/encadres/encadre_type.jsp\" %>">
			<jsp:param name="TYPE" value="<%= EncadresFrontUtils.RUBRIQUE %>" />
		</jsp:include>
		<jsp:include page="<%= frontOfficeBean.getJspFo() + \"/template/encadres/encadre_type.jsp\" %>">
			<jsp:param name="TYPE" value="<%= EncadresFrontUtils.GENERIQUE %>" />
		</jsp:include>
		<jsp:include page="<%= frontOfficeBean.getJspFo() + \"/template/encadres/encadre_type.jsp\" %>">
			<jsp:param name="TYPE" value="<%= EncadresFrontUtils.RECHERCHE_EXTERNE %>" />
		</jsp:include><%
		ctx.putData("indiceEncadre",0);
		for (String jspEncadreRecherche : frontOfficeBean.getEncadresRecherche()) {
			JSPIncludeHelper.includeJsp(out,getServletConfig().getServletContext(),request,response,jspEncadreRecherche);
		}
	%></div><!-- #encadres --><%
}
%>
