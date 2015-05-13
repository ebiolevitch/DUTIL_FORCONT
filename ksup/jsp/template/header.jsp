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
		<meta name="keywords" content="formation,recherche,universite,university,france,nantes" />
		<meta name="Date-Creation-yyyymmdd" content="20081212" />
		<meta name="Date-Revision-yyyymmdd" content="20111214" />
		<meta name="copyright" content="Copyright &copy; Universit&eacute; de Nantes" />
		<meta name="reply-to" content="webmaster@univ-nantes.fr" />
		<meta name="category" content="Internet" />
		<meta name="robots" content="index, follow" />
		<meta name="distribution" content="global" />
		<meta name="identifier-url" content="http://www.univ-nantes.fr/" />
		<meta name="resource-type" content="document" />
		<meta name="expires" content="-1" />
		<meta name="Generator" content="K-Sup" />
		<meta name="Formatter" content="K-Sup" />
		<link rel="stylesheet" type="text/css" media="screen" href="http://www.univ-nantes.fr/jsp/styles/defaut/scroll.css" title="defaut" />
		<link rel="stylesheet" type="text/css" media="screen" href="http://www.univ-nantes.fr/jsp/styles/defaut/formulaires.css" title="defaut" />
		<link rel="stylesheet" type="text/css" media="screen" href="http://www.univ-nantes.fr/jsp/styles/defaut/degrades.css" title="defaut" />
		<link rel="stylesheet" type="text/css" media="screen" href="http://www.univ-nantes.fr/jsp/styles/defaut/social.css" title="defaut" />
<!--			<link rel="stylesheet" type="text/css" media="screen" href="custom.css" title="defaut" /> -->

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

		<script type="text/javascript" src="http://www.univ-nantes.fr/jsp/scripts/swfobject.js"></script>
		<script type="text/javascript" src="http://www.univ-nantes.fr/adminsite/toolbox/toolbox.js"></script>
		<script type="text/javascript" src="http://www.univ-nantes.fr/jsp/scripts/carrousel.js"></script>
		<script type="text/javascript" src="http://www.univ-nantes.fr/jsp/scripts/scroll.js"></script>
		<script type="text/javascript" src="http://www.univ-nantes.fr/adminsite/utils/prototype.js"></script>
		<!--<script type="text/javascript" src="<? echo $baseurl; ?>/kosmos/agenda/js/scriptaculous/scriptaculous.js"></script>-->
		<script type="text/javascript" src="http://www.univ-nantes.fr/jsp/scripts/effects.js"></script>
		<script type="text/javascript" src="http://www.univ-nantes.fr/kosmos/agenda/js/getElementsByClassName.js"></script>
		<link rel="start" title="Accueil" href="http://www.univ-nantes.fr/" />
		<link rel="alternate" type="application/rss+xml" title="Fil RSS des dix derni&egrave;res actualit&eacute;s" href="http://www.univ-nantes.fr/rss" />
		<script type="text/javascript" src="http://www.univ-nantes.fr/jsp/scripts/fonctions.js"></script>
		<script type="text/javascript" src="http://www.univ-nantes.fr/jsp/scripts/lytebox/lytebox.js"></script>   
		<link rel="stylesheet" href="http://www.univ-nantes.fr/jsp/scripts/lytebox/lytebox.css" type="text/css" media="screen" />
		<script type="text/javascript" src="http://www.univ-nantes.fr/jsp/scripts/defaut.js"></script>
		<script type="text/javascript" src="http://www.univ-nantes.fr/jsp/scripts/menu.js"></script>

		<script type="text/javascript" src="http://s7.addthis.com/js/250/addthis_widget.js"></script>
                <script type="text/javascript">
                        addthis_pub             = 'UnivNantes';
                        addthis_logo_background = '020a23';
                        addthis_logo_color      = '020a23';
                        addthis_language        = 'fr';
                        var addthis_localize = {
                                share_caption: "Partager"
                        };
                </script>
 </head>
<% 
/* On est ici en mesure de savoir s'il y a des encadrÃ©s ou pas, et une zone de navigation ou pas :
on dÃ©cide donc de la classe qui s'applique sur le centre de la page, qui gÃ¨re la largeur de la zone centrale */
String idCentre = "contenu_sans_nav_sans_encadres";
if (frontOfficeBean.isEncadrePresent() && frontOfficeBean.isNavigationSecondairePresente()) {
	idCentre = "avec_nav_avec_encadres";
} else if (frontOfficeBean.isEncadrePresent()) {
	idCentre = "sans_nav_avec_encadres";
} else if (frontOfficeBean.isNavigationSecondairePresente()) {
	idCentre = "avec_nav_sans_encadres";
}
/* Gestion des classes appliquÃ©es au body (aka body-switching) */
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
	<div id="bandeau2">
			<script type="text/javascript" src="http://www.univ-nantes.fr/jsp/template/elements_externes.jsp?LANGUE=0&RUBRIQUE=ENS&ELEMENT=accespratiques"></script>
		<script type="text/javascript" src="http://www.univ-nantes.fr/jsp/template/elements_externes.jsp?LANGUE=0&RUBRIQUE=ENS&ELEMENT=langue">
		</script>			
			<jsp:include page="<%= frontOfficeBean.getJspFo() + \"/template/banniere.jsp\"%>" />

		        <script type="text/javascript" src="http://www.univ-nantes.fr/jsp/template/elements_externes.jsp?LANGUE=0&ELEMENT=recherche&RUBRIQUE=ENS"></script>

		<div id="profils">
		<strong>Accès par profil&nbsp;: </strong>
		<ul>
		<li><a href="http://www.univ-nantes.fr/05905336/0/fiche___pagelibre/">Entreprise</a></li>
		<li><a href="http://www.univ-nantes.fr/59193101/0/fiche___pagelibre/">Lycéen</a></li>
		<li><a href="http://www.univ-nantes.fr/45032473/0/fiche___pagelibre/">Etudiant étranger</a></li>
		<li><a href="http://www.univ-nantes.fr/1325759101442/0/fiche___pagelibre/">En reprise d'étude</a></li>
		<li><a href="http://www.univ-nantes.fr/55885317/0/fiche___pagelibre/">Ancien étudiant</a></li>
		</ul></div>
	
	</div> <!-- #bandeau2 -->
	
	<div id="menu" role="navigation">
     		    Polytech Nantes, École d'ingénieurs
	</div>
	<!-- #menu-->
<!-- 	<div id="menu" role="navigation" class="plier-deplier__contenu plier-deplier__contenu--relatif plier-deplier__contenu--clos" aria-expanded="false"> -->
<!-- 	ici est présent l'inclusion de la jsp menu_simple  -->
<!-- 	   <div class="separateur"></div> -->
<!-- 	</div> <!-- #menu -->
</header>

<main id="page">
	<div id="page_deco">	
	<jsp:include page="<%= frontOfficeBean.getJspFo() + \"/template/fil_ariane.jsp\"%>" />
	<div id="contenu-encadres"><%
	if (!frontOfficeBean.isAccueilSite()) {
		if(StringUtils.isNotBlank(frontOfficeBean.getVisuelRubrique())) {
			%><div id="bandeau" class="<%= frontOfficeBean.isNavigationSecondairePresente() ? "" : "avec_nav" %>"></div> <!-- #bandeau --><%
		}
	}
	%><div id="<%=idCentre%>" class="contenu" role="main"><%
	if (!frontOfficeBean.isAccueilSite()) {
	%>
		
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
