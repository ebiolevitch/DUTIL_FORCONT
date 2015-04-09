<%@ page import="com.kportal.core.config.MessageHelper" %>
<%@ page import="com.kportal.core.config.PropertyHelper" %>
<%@ page import="com.kportal.ihm.utils.EncadresFrontUtils" %>
<%@ page import="com.univ.objetspartages.om.Metatag" %>
<%@ page import="com.univ.objetspartages.om.ReferentielObjets" %>
<%@ page import="com.univ.url.UrlManager" %>
<%@ page import="com.univ.utils.URLResolver" %>
<%@ page import="com.univ.utils.UnivWebFmt" %>
<%@ page import="org.apache.commons.lang3.StringUtils" %>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Map"%>
<%@ taglib prefix="resources" uri="http://kportal.kosmos.fr/tags/web-resources" %><%

 %><!DOCTYPE html>
<!--[if lte IE 7]> <html class="ie7 oldie no-js" xmlns="http://www.w3.org/1999/xhtml" lang="<%=ctx.getLocale().getLanguage()%>" xml:lang="<%=ctx.getLocale().getLanguage()%>"> <![endif]-->
<!--[if IE 8]> <html class="ie8 oldie no-js" xmlns="http://www.w3.org/1999/xhtml" lang="<%=ctx.getLocale().getLanguage()%>" xml:lang="<%=ctx.getLocale().getLanguage()%>"> <![endif]-->
<!--[if gt IE 8]><!--> <html class="no-js" xmlns="http://www.w3.org/1999/xhtml" lang="<%=ctx.getLocale().getLanguage()%>" xml:lang="<%=ctx.getLocale().getLanguage()%>"> <!--<![endif]-->

<head>
<%@ include file="./metatags.jsp" %>

<link rel="stylesheet" type="text/css" media="screen" href="<%= URLResolver.getAbsoluteUrl(frontOfficeBean.getJspFo() + "/styles/fonts/icones/IcoMoon.css",ctx) %>" />

<link rel="stylesheet" type="text/css" media="screen" href="<%= URLResolver.getAbsoluteUrl(frontOfficeBean.getJspFo() + "/styles/fonts.css",ctx) %>" />

<link rel="stylesheet" type="text/css" media="screen" href="<%= URLResolver.getAbsoluteUrl(frontOfficeBean.getJspFo() + "/styles/extension-galerie.css",ctx) %>" />

<!--[if lte IE 7]><!-->
	<link rel="stylesheet" href="<%= URLResolver.getAbsoluteUrl(frontOfficeBean.getJspFo() + "/styles/fonts/icones/ie7/ie7.css",ctx) %>">
	<script src="<%= URLResolver.getAbsoluteUrl(frontOfficeBean.getJspFo() + "/styles/fonts/icones/ie7/ie7.js",ctx) %>"></script>
<!--<![endif]-->

<!--[if lte IE 8]>
	<link rel="stylesheet" type="text/css" media="screen" href="<%= URLResolver.getAbsoluteUrl(frontOfficeBean.getJspFo() + "/styles/all-old-ie.css",ctx) %>" />
	<script>'header|footer|main|article|section|audio|video|source'.replace(/\w+/g,function(t){document.createElement(t)})</script>
	<script type="text/javascript" src="<%= URLResolver.getAbsoluteUrl("/adminsite/scripts/libs/ie8-shims.js",ctx) %>"></script>
<![endif]-->

<!--[if gt IE 8]><!-->
	<link rel="stylesheet" type="text/css" media="screen" href="<%= URLResolver.getAbsoluteUrl(frontOfficeBean.getJspFo() + "/styles/screen.css",ctx) %>" />
<!--<![endif]-->

<resources:link media="screen" group="styles"/>

<script type="text/javascript">
	var html = document.getElementsByTagName('html')[0];
	html.className = html.className.replace('no-js', 'js');
	// document.getElementsByTagName("html")[0].className = document.getElementsByTagName("html")[0].className.replace("no-js", "js");	
</script>

<resources:link media="screen" group="jQueryCSS"/>

<meta name="viewport" content="width=device-width" />

<resources:script group="scripts"/>
<script type="text/javascript" src="<%= URLResolver.getAbsoluteUrl("/adminsite/fcktoolbox/fckeditor/fckeditor.js",ctx) %>"></script><%
if (frontOfficeBean.isDsi() || frontOfficeBean.isSaisieFront()) {
	%><resources:link media="screen" group="styles-dsi"/><%
}
%><resources:link media="print" group="styles-print"/>
<%@ include file="./styles_dynamiques.jsp" %><% 
/* Connecteur : fichiers javascript et css de l'application externe */
String specificInclude = (String) ctx.getDonneesSpecifiques().get("INCLUDE_HEAD");
if (StringUtils.isNotBlank(specificInclude)) {
	%><%= specificInclude %><%
}

	/* Quelques liens de navigation standards, utilisés en particulier dans Mozilla/FireFox/... */ %>
   <link rel="start" title="Accueil" href="<%=URLResolver.getAbsoluteUrl("/", ctx)%>" />

    <% /* Flux RSS de K-Portal : les 10 dernières actualités du site courant */%>
    <link rel="alternate" type="application/rss+xml" title="<%=MessageHelper.getCoreMessage("ST_DIX_DERNIERES_ACTUALITES")%>" href="<%=URLResolver.getAbsoluteUrl("/adminsite/webservices/export_rss.jsp?NOMBRE=10&amp;CODE_RUBRIQUE=" + ctx.getInfosSite().getCodeRubrique() + "&amp;LANGUE=" + ctx.getLangue(), ctx)%>" />
</head>
<% 
/* On est ici en mesure de savoir s'il y a des encadrés ou pas, et une zone de navigation ou pas :
on décide donc de la classe qui s'applique sur le centre de la page, qui gère la largeur de la zone centrale */
String idCentre = "contenu_sans_nav_sans_encadres";
if (frontOfficeBean.isEncadrePresent() && frontOfficeBean.isNavigationSecondairePresente()) {
	idCentre = "avec_nav_avec_encadres";
} else if (frontOfficeBean.isEncadrePresent()) {
	idCentre = "sans_nav_avec_encadres";
} else if (frontOfficeBean.isNavigationSecondairePresente()) {
	idCentre = "avec_nav_sans_encadres";
}
/* Gestion des classes appliquées au body (aka body-switching) */
String classBody = StringUtils.EMPTY;
if (frontOfficeBean.isCollaboratif()) {
	classBody = "collaboratif ";
} else if (ficheUniv != null) {
	classBody = "fiche ";
} else {
	classBody = "recherche";
}
if (ficheUniv != null) {
	classBody += ReferentielObjets.getNomObjet(ReferentielObjets.getCodeObjetParClasse(ficheUniv.getClass().getName())).toLowerCase();
}
if (frontOfficeBean.isAccueilSite()) {
 	classBody += " accueil";
}
if (frontOfficeBean.isAccueilRubrique()) {
 	classBody += " rubrique";
}
if (frontOfficeBean.isDsi()) {
    classBody+=" connecte";
}
if (frontOfficeBean.isApercu()) {
    classBody+=" apercu";
}
%><body id="body" class="<%=classBody%>"><% 
if (frontOfficeBean.isApercu()) {
	%><p id="en_mode_apercu"><%=MessageHelper.getCoreMessage("ST_VISUALISATION_EN_MODE_APERCU")%><%
	Metatag metatag = frontOfficeBean.getMetatag();
	if (metatag!=null && !metatag.getMetaNbHits().equals(new Long(0))){%>
		- <a href="<%=UrlManager.calculerUrlFiche(ctx,metatag.getMetaNbHits())%>">Voir la fiche en ligne</a><%
	}
	%></p><%
}
%>
<header>
<%@ include file="headerperso.jsp" %>
</header>

<main id="page">
	<div id="page_deco">	
	<div id="contenu-encadres"><%
	if (!frontOfficeBean.isAccueilSite()) {
		if(StringUtils.isNotBlank(frontOfficeBean.getVisuelRubrique())) {
			%><div id="bandeau" class="<%= frontOfficeBean.isNavigationSecondairePresente() ? "" : "avec_nav" %>"></div> <!-- #bandeau --><%
		}
	}
	%><div id="<%=idCentre%>" class="contenu" role="main"><%
	if (!frontOfficeBean.isAccueilSite()) {
	%>
		<jsp:include page="<%= frontOfficeBean.getJspFo() + \"/template/fil_ariane.jsp\"%>" />
		<%
		if (StringUtils.isNotBlank(surtitre)) {
			%><%=surtitre%><%
		}
		if (StringUtils.isNotBlank(titre)) {
			%><h1><%=titre%></h1><%
		}
		if (StringUtils.isNotBlank(soustitre)) { 
			%><%=soustitre%><%
		}
	}
%>
