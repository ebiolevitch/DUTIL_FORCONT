<%@page import="com.kportal.extension.module.composant.Menu"%>
<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@page import="java.util.List"%>
<jsp:useBean id="frontOfficeBean" class="com.univ.url.FrontOfficeBean" scope="request" /><%
	final List<Menu> menuPrincipal = frontOfficeBean.getMenuPrincipal();
	if (menuPrincipal != null && !menuPrincipal.isEmpty()) {
		%><ul id="menu_principal"><!--<%
			for (Menu elementMenu : menuPrincipal) {
				%>--><li <%= elementMenu.isMenuCourant() ? "class=\"menu_principal-actif\"" : ""%>><%
				if (StringUtils.isNotBlank(elementMenu.getUrl())) {
					%><a href="<%= elementMenu.getUrl()%>" class="type_rubrique_<%= elementMenu.getType() %>" aria-expanded="false"><%= elementMenu.getLibelle()%></a><%
				} else {
					%><button type="button"><%= elementMenu.getLibelle() %></button><%
				}
				if (elementMenu.getSousMenu() != null && !elementMenu.getSousMenu().isEmpty()) {
					%><ul class="plier-deplier__contenu plier-deplier__contenu--clos"><!--<%
					for (Menu elementSousMenu : elementMenu.getSousMenu()) {
						%>--><li><%
						if (StringUtils.isNotBlank(elementSousMenu.getUrl())) {
							%><a href="<%= elementSousMenu.getUrl()%>" class="type_rubrique_<%= elementSousMenu.getType() %>"><%= elementSousMenu.getLibelle()%></a><%
						} else {
							%><span><%= elementSousMenu.getLibelle() %></span><%
						}
						%></li><!--<%
					}
					%>--></ul><%
				}
				%></li><!--<%
			}
		%>--></ul><!-- #menu_principal --><%
	}
%>
