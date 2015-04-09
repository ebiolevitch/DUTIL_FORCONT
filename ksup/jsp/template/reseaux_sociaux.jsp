<%@page import="com.kportal.core.config.MessageHelper"%>
<%@page import="com.kportal.extension.module.composant.Menu"%>
<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@page import="java.util.List"%>
<jsp:useBean id="frontOfficeBean" class="com.univ.url.FrontOfficeBean" scope="request" />
<%
	final List<Menu> menuReseauSociaux = frontOfficeBean.getMenuReseauxSociaux();
	if (menuReseauSociaux != null && !menuReseauSociaux.isEmpty()) {
%>
	<div class="reseaux-sociaux">
		<div>
			<span class="reseaux-sociaux__libelle"><%= MessageHelper.getCoreMessage("MENU_RESEAUX_SOCIAUX") %></span>
			<ul class="reseaux-sociaux__liste">
			<% for(Menu currentMenu : menuReseauSociaux) { %>
				<li class="reseaux-sociaux__item">
					<a href="<%= currentMenu.getUrl() %>" class="reseaux-sociaux__type-rubrique_<%= currentMenu.getType() %>" title="<%= currentMenu.getLibelle() %>"><%
					if (StringUtils.isNotBlank(currentMenu.getPicto())) {
						%><img src="<%= currentMenu.getPicto() %>" alt="picto-<%= currentMenu.getLibelle() %>" /><%
					} else {
						%><%= currentMenu.getLibelle()%><%
					}
					%></a>
				</li>
			<% } %>
			</ul>
		</div>
	</div><!-- .reseaux-sociaux -->
<%
	}
%>