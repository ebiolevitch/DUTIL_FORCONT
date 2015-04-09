<%@ page import="java.util.*" %>
<%@ page import="java.text.*" %>
<%@ page import="java.lang.*" %>
<%@ page import="com.univ.utils.URLResolver" %>
<%@ page import="com.univ.utils.URLResolver" %>
<%@ page import="com.univ.objetspartages.om.Libelle" %>
<%@ page import="com.univ.objetspartages.om.Structure" %>
<%@ page import="com.univ.utils.ContexteUniv" %>
<%@ page import="com.univ.utils.UnivWebFmt" %>
<%@ page import="com.kportal.core.config.MessageHelper" %>
<%@ page isErrorPage="true" buffer="100kb" %>
<%@ include file="../template/initialisations.jsp" %><%
titre = MessageHelper.getCoreMessage("ST_PAGE_NON_AUTORISEE") ;
%><%@ include file="../template/header.jsp" %>

<div id="erreur_unauthorized">
	<p><%=MessageHelper.getCoreMessage("ST_PAGE_NON_AUTORISEE_INTRO")%></p>
	<a href="<%=URLResolver.getAbsoluteUrl("/", ctx)%>"><%=MessageHelper.getCoreMessage("ST_PAGE_NON_AUTORISEE_ACCUEIL")%></a>
</div> <!-- fin #erreur_unauthorized -->

<%@ include file="../template/footer.jsp" %>