<%@page import="com.kportal.core.config.MessageHelper"%>
<%@page import="com.kportal.extension.module.composant.Menu"%>
<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@page import="java.util.List"%>
<jsp:useBean id="frontOfficeBean" class="com.univ.url.FrontOfficeBean" scope="request" />
<%
	final List<Menu> menuAccesDirect = frontOfficeBean.getMenuAccesDirect();
	if (menuAccesDirect != null && !menuAccesDirect.isEmpty()) {
	%>
	<div id="acces-directs" class="plier-deplier">
		<button class="plier-deplier__bouton" aria-expanded="false"><span class="icon icon-plus"></span><span class="icon-libelle"><%=MessageHelper.getCoreMessage("ACCES_DIRECTS")%></span></button>
		<div class="plier-deplier__contenu plier-deplier__contenu--clos">
			<ul>
			<% for(Menu currentMenu : menuAccesDirect) { %>
				<li>
				<% if (StringUtils.isNotBlank(currentMenu.getUrl())) { 
					%><a href="<%= currentMenu.getUrl()%>" class="type_rubrique_<%= currentMenu.getType() %>"><%= currentMenu.getLibelle() %></a><%
				   } else {
					%><%= currentMenu.getLibelle() %><%
				   }%>
				</li>
			<% } %>
			</ul>
		</div><!-- .plier-deplier__contenu -->
	</div><!-- #acces-directs .plier-deplier -->
	<%
}
%>