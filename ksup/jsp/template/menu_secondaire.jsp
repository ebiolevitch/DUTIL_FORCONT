<%@page import="com.kportal.extension.module.composant.Menu"%>
<%@page import="com.kportal.ihm.utils.FrontUtil"%>
<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@page import="com.univ.objetspartages.om.InfosRubriques"%>
<%@page import="com.univ.utils.ContexteUtil"%>
<%@page import="com.univ.objetspartages.om.FicheUniv"%>
<%@page import="com.univ.utils.ContexteUniv"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<jsp:useBean id="frontOfficeBean" class="com.univ.url.FrontOfficeBean" scope="request" /><%
	final List<Menu> menuSecondaire = frontOfficeBean.getMenuSecondaire();
	if (menuSecondaire != null && !menuSecondaire.isEmpty()) {
		ContexteUniv ctx = ContexteUtil.getContexteUniv();
		FicheUniv ficheUniv = frontOfficeBean.getFicheUniv();		
		%><ul id="menu_secondaire"><%
			for (Menu elementMenu : menuSecondaire) {
				%><li <%= elementMenu.isMenuCourant() && !FrontUtil.hasActiveChild(elementMenu) ? "class=\"menu_secondaire-actif\"" : "" %>><%
				if (StringUtils.isNotBlank(elementMenu.getUrl())) {
					%><a href="<%= elementMenu.getUrl()%>" class="type_rubrique_<%= elementMenu.getType() %>"><%= elementMenu.getLibelle()%></a><%
				} else {
					%><%= elementMenu.getLibelle() %><%
				}
				if (elementMenu.isMenuCourant()) {
					if (elementMenu.getSousMenu() != null && !elementMenu.getSousMenu().isEmpty()) {
						%><ul><%
						for (Menu elementSousMenu : elementMenu.getSousMenu()) {
							%><li <%= elementSousMenu.isMenuCourant() ? "class=\"sousmenu_secondaire-actif\"" : "" %>><%
							if (StringUtils.isNotBlank(elementSousMenu.getUrl())) {
								%><a href="<%= elementSousMenu.getUrl()%>" class="type_rubrique_<%= elementSousMenu.getType() %>"><%= elementSousMenu.getLibelle()%></a><%
							} else {
								%><%= elementSousMenu.getLibelle() %><%
							}
							%></li><%
						}
						%></ul><%
					}
				}
				%></li><%
			}
		%></ul><!-- #menu_secondaire --><%
	}
%>