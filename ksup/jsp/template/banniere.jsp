<%@page import="com.univ.utils.ContexteUtil"%>
<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@page import="com.kportal.extension.module.composant.Menu"%>
<%@page import="com.kportal.ihm.utils.FrontUtil"%>
<%@page import="java.util.List"%>
<%@page import="com.univ.utils.URLResolver"%>
<%@page import="com.kportal.core.config.MessageHelper"%>
<%
final String baselineName = ContexteUtil.getContexteUniv().getInfosSite().getIntitule();
%>
<div class="banniere" role="banner">
	<div>
		<% if( StringUtils.isNotBlank(FrontUtil.getLogoUrl())) { %>
		<a href="<%=URLResolver.getAbsoluteUrl("/", ContexteUtil.getContexteUniv())%>" class="banniere__logo" title="<%=MessageHelper.getCoreMessage("ST_RETOUR_ACCUEIL")%>">
	        <img src="<%= URLResolver.getAbsoluteUrl(FrontUtil.getLogoUrl(), ContexteUtil.getContexteUniv()) %>" alt="logo-<%=baselineName%>" title="<%= MessageHelper.getCoreMessage("ST_RETOUR_ACCUEIL") %>" />
	    </a>
	    <% } %>
	    <% if(StringUtils.isNotBlank(FrontUtil.getBaseline())){
		%><span class="banniere__baseline"><%= FrontUtil.getBaseline() %></span><%
		} %>
	</div>
</div><!-- .banniere -->
