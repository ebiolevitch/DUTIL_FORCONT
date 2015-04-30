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
			
				
			<footer id="pied_deco">
				<div id="pied_page" role="contentinfo">
					<jsp:include page="<%= frontOfficeBean.getJspFo() + \"/template/menu_piedpage.jsp\"%>" />
					<span id="haut_page"><span aria-hidden="true" class="icon icon-arrow-up"></span><a href="#body"><span class="icon-libelle"><%=MessageHelper.getCoreMessage("ST_HAUT_PAGE")%></span></a></span>
				</div><!-- #pied_page -->
			</footer> <!-- #pied_deco -->
			
		<% final String urlFiche = UnivWebFmt.determinerUrlFiche(ContexteUtil.getContexteUniv(), ContexteUtil.getContexteUniv().getFicheCourante()); %>
		<a class="url-fiche" href="<%= urlFiche %>"><%= urlFiche %></a>
		<resources:script group="scriptsFo" locale="<%= locale.toString() %>"/>
		<%@ include file="/WEB-INF/jsp/sso/fo/propagation.jsp" %>
	</body>
</html>
