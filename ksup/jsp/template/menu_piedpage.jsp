<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@page import="com.kportal.extension.module.composant.Menu"%>
<%@page import="java.util.List"%>
<jsp:useBean id="frontOfficeBean" class="com.univ.url.FrontOfficeBean" scope="request" /><%
	/* ici, on récupère les sous-rubriques de la rubrique codeRubPiedPage, rubrique spéciale pour une barre de liens pratiques,
      qui n'apparaît pas dans la navigation principale */
	final List<Menu> menuPiedPage = frontOfficeBean.getMenuPiedDePage();
	if (menuPiedPage != null && !menuPiedPage.isEmpty()) {
		%><ul id="menu_pied_page"><!--<%
			for (Menu elementMenu : menuPiedPage) {
				%>--><li><%
				if (StringUtils.isNotBlank(elementMenu.getUrl())) {
					%><a href="<%= elementMenu.getUrl()%>"><%= elementMenu.getLibelle()%></a><%
				} else {
					%><%= elementMenu.getLibelle() %><%
				}
				%></li><!--<%
			}
		%>--></ul><!-- #menu_pied_page --><%
	}
%>
