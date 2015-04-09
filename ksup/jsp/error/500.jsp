<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
<%@ page import="java.lang.*"%>
<%@ page import="org.apache.commons.validator.routines.EmailValidator" %>
<%@ page import="org.apache.commons.lang3.StringUtils" %>
<%@ page import="com.kportal.core.config.MessageHelper" %>
<%@ page import="com.kportal.core.config.PropertyHelper"%>
<%@ page import="com.univ.utils.EscapeString"%>
<%@ page import="com.univ.utils.ContexteUniv" %>
<%@ page import="com.univ.utils.UnivWebFmt" %>
<%@ page import="com.univ.objetspartages.om.Structure" %>
<%@ page import="com.univ.objetspartages.om.Libelle" %>
<%@ page import="com.univ.utils.URLResolver" %>
<%@ page import="com.univ.utils.URLResolver" %>
<%@ page isErrorPage="true" buffer="100kb" %>
<%@ include file="../template/initialisations.jsp" %><%
titre = MessageHelper.getCoreMessage("ST_PAGE_ERREUR_SERVEUR") ;
%><%@ include file="../template/header.jsp" %><%
String urlDemandee = StringUtils.defaultString(request.getParameter("URL_DEMANDEE"));
if (StringUtils.isNotBlank(urlDemandee)) {
	urlDemandee = java.net.URLDecoder.decode(urlDemandee, "UTF-8");
} else {
	urlDemandee = request.getRequestURL().toString();
	if (StringUtils.isNotBlank(request.getQueryString())) {
		urlDemandee += "?" + request.getQueryString();
	}
}
%><div id="erreur_not_found">
	<p><%=MessageHelper.getCoreMessage("ST_PAGE_ERREUR_SERVEUR_INTRO")%></p>
	<a href="<%=URLResolver.getAbsoluteUrl("/", ctx)%>"><%=MessageHelper.getCoreMessage("ST_PAGE_ERREUR_SERVEUR_ACCUEIL")%></a><%
	String replyToWebmaster = StringUtils.defaultString(PropertyHelper.getCoreProperty("mail.webmaster"));
	if (StringUtils.isNotBlank(replyToWebmaster) && EmailValidator.getInstance().isValid(replyToWebmaster)) {
		String[] tmail = replyToWebmaster.split("@");
		%><p><%=MessageHelper.getCoreMessage("ST_PAGE_ERREUR_SERVEUR_OUTRO")%> <a href="javascript:melA('<%=tmail[0]%>','<%= MessageHelper.getCoreMessage("ST_PAGE_ERREUR_SERVEUR_CONTACT_SUJET") %>','<%= EscapeString.escapeJavaScript(urlDemandee)%>','<%= tmail[1] %>');"><%=MessageHelper.getCoreMessage("ST_PAGE_ERREUR_SERVEUR_CONTACT")%></a> <%=MessageHelper.getCoreMessage("ST_PAGE_ERREUR_SERVEUR_OUTRO_2")%></p><%
	}
%></div> <!-- fin #erreur_not_found -->

<%@ include file="../template/footer.jsp" %>