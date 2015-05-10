<%@page import="com.kportal.frontoffice.util.JSPIncludeHelper"%>
<%@page import="com.univ.utils.ContexteUtil"%>
<%@page import="com.univ.utils.UnivWebFmt" %>
<%@page import="java.util.Locale"%>
<%@ page import="com.univ.collaboratif.om.Espacecollaboratif" %>
<%@ page import="org.apache.commons.lang3.StringUtils"%>
<%@ page import="java.text.DateFormat"%>
<%@ page import="com.kportal.cms.objetspartages.ObjetPartageHelper"%>
<%@ page import="com.kportal.core.config.MessageHelper" %>
<%@ page import="com.jsbsoft.jtf.core.Formateur"%>
<%@taglib prefix="resources" uri="http://kportal.kosmos.fr/tags/web-resources" %><%
Locale locale = ContexteUtil.getContexteUniv().getLocale();
if(!frontOfficeBean.isAccueilSite()){
	%><jsp:include page="<%= frontOfficeBean.getJspFo() + \"/template/actions-fiche.jsp\" %>" /><%
}
JSPIncludeHelper.includePluginFicheTemplates(out, getServletContext(), request, response); %>
</div> <!-- .contenu -->
<jsp:include page="<%= frontOfficeBean.getJspFo() + \"/template/encadres_affichage.jsp\"%>" />

</div><!-- #contenu-encadres -->

		<% if (frontOfficeBean.isNavigationSecondairePresente()) { %>
			<div id="navigation" role="navigation">
				<h2><%=MessageHelper.getCoreMessage("DANS_LA_MEME_RUBRIQUE")%></h2>
				<a href="http://www.polytech.univ-nantes.fr/"><img alt="logo rubrique" src="../../fc/jsp/styles/img/polytech.jpg"></img></a>
				<br></br>
				<jsp:include page="<%= frontOfficeBean.getJspFo() + \"/template/menu_secondaire.jsp\" %>" />
			</div><!-- #navigation -->
		<% } %>

				</div><!-- #page_deco -->
				<div class="separateur"></div>
			</main> <!-- #page -->
			
			
		<script type="text/javascript" src="http://www.univ-nantes.fr/jsp/template/elements_externes.jsp?LANGUE=0&RUBRIQUE=PRES&ELEMENT=footer"></script>
			<script type="text/javascript" src="http://s7.addthis.com/js/250/addthis_widget.js"></script>
			
		<% final String urlFiche = UnivWebFmt.determinerUrlFiche(ContexteUtil.getContexteUniv(), ContexteUtil.getContexteUniv().getFicheCourante()); %>
		<a class="url-fiche" href="<%= urlFiche %>"><%= urlFiche %></a>
		<resources:script group="scriptsFo" locale="<%= locale.toString() %>"/>
		<%@ include file="/WEB-INF/jsp/sso/fo/propagation.jsp" %>
	</body>
</html>
