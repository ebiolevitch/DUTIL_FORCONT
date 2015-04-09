<%@page import="java.util.List"%>
<%@page import="java.util.Locale"%>
<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@page import="com.jsbsoft.jtf.core.LangueUtil"%>
<%@page import="com.kportal.extension.module.composant.Menu"%>
<%@page import="com.univ.utils.ContexteUtil"%>
<jsp:useBean id="frontOfficeBean" class="com.univ.url.FrontOfficeBean" scope="request" />
<% /* affichage des liens vers les pages d'accueil de chaque version linguistique, s'il y en a plus d'une */
final Locale currentLocale = ContexteUtil.getContexteUniv().getLocale();
final List<Menu> menuLangue = frontOfficeBean.getMenuLangue();
if (menuLangue != null && !menuLangue.isEmpty() && menuLangue.size() > 1) {

	%><div id="versions" class="plier-deplier">
		<button class="plier-deplier__bouton versions__item" aria-expanded="false"><%= currentLocale.getLanguage() %></button>
		<div class="plier-deplier__contenu plier-deplier__contenu--clos"><!--
		--><ul><!--<%
		for (Menu elementMenu : menuLangue) {
			final Locale localeMenu = LangueUtil.getLocale(elementMenu.getLangue());
			if (!currentLocale.equals(localeMenu)) {
			    %>--><li class="versions__item versions_<%= localeMenu.getLanguage()%>"  lang="<%=localeMenu.getLanguage()%>"><%
                if (StringUtils.isNotBlank(elementMenu.getUrl())) {
                    %><a href="<%= elementMenu.getUrl()%>" hreflang="<%=localeMenu.getLanguage()%>">
                        <%= localeMenu.getLanguage()%>
                      </a><%
                } else {
                    %><%= localeMenu.getLanguage() %><%
                }
                %></li><!--<%
            }
		}
	%>--></ul><!-- 
	--></div><!-- .plier-deplier__contenu -->
	</div><!-- #versions -->
	<%
}
%>