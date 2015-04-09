<%@ page import="com.kportal.core.config.PropertyHelper" %>
<%@ page import="com.univ.utils.EscapeString" %>
<%@ page import="com.univ.utils.UnivWebFmt" %>
<%@ page import="com.univ.utils.URLResolver" %>
<%@ page import="org.apache.commons.lang3.StringUtils"  %>
<%@ page import="java.util.Date" %>
<%@ page import="java.util.Locale" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.text.DateFormat" %>
<% /* Génération des metatags */
	String intituleSiteCourant = ctx.getInfosSite().getIntitule();
	String title = intituleSiteCourant;
	String metaKeywords = "";
	String metaDescription = "";
	DateFormat formatter = new SimpleDateFormat("yyyyMMdd");
	String creationDate = formatter.format(new Date());
	String modificationDate = formatter.format(new Date());
	String urlCanonic = "";
	/* Si on se trouve sur une fiche, on récupère les infos lui correspondant afin de les placer dans les metatags */
	if (ficheUniv != null) {
		/* Ajout du titre de la fiche courante au title, sauf s'il commence par : ,auquel cas on ne l'ajoute pas */
		if (title.length() > 0 && !ficheUniv.getLibelleAffichable().substring(0,1).equals(":")) {
			title += " - " + ficheUniv.getLibelleAffichable();
		}
		/* Meta-keywords saisis dans l'interface d'administration de la fiche */
		metaKeywords = EscapeString.escapeAttributHtml(ficheUniv.getMetaKeywords());
		/* Meta-description saisie dans l'interface d'administration de la fiche */
		metaDescription = EscapeString.escapeAttributHtml(ficheUniv.getMetaDescription());
		/* Dates de création et de modification de la fiche */ 
		creationDate = ficheUniv.getDateCreation().toString().replaceAll("-","");
		modificationDate = ficheUniv.getDateModification().toString().replaceAll("-","");
		urlCanonic = UnivWebFmt.determinerUrlFiche(ctx, ficheUniv);
		if (urlCanonic.indexOf("?")!=-1) {
			urlCanonic = urlCanonic.substring(0,urlCanonic.indexOf("?"));
		}
		Locale localeCourante = ctx.getLocale();
		String urlRelativeLogo = ctx.getInfosSite().getProprieteComplementaireString("logo");
		String metaUrlImage =  URLResolver.getRessourceUrl("images/logo.png", ctx);
		if (StringUtils.isNotBlank(urlRelativeLogo)) {
			metaUrlImage = URLResolver.getRessourceUrl(urlRelativeLogo, ctx);
		}
		metaUrlImage = EscapeString.escapeAttributHtml(metaUrlImage);
		%><meta name="description" content="<%= metaDescription %>" />
		<meta name="DC.Description" lang="<%= localeCourante.toString().replace('_','-') %>" content="<%= metaDescription %>" />
		<meta itemprop="description" content="<%= metaDescription%>" />
		<meta property="og:description" content="<%= metaDescription%>" />
		<meta itemprop="name" content="<%= EscapeString.escapeAttributHtml(ficheUniv.getLibelleAffichable()) %>" />
		<meta property="og:title" content="<%= EscapeString.escapeAttributHtml(ficheUniv.getLibelleAffichable()) %>" />
		<meta property="og:site_name" content="<%= EscapeString.escapeAttributHtml(ctx.getInfosSite().getIntitule()) %>" />
		<meta property="og:type" content="article" />
		<meta property="og:url" content="<%= URLResolver.getAbsoluteUrlFiche(ficheUniv, ctx) %>" />
		<meta itemprop="image" content="<%= metaUrlImage %>" />
		<meta property="og:image" content="<%= metaUrlImage %>" /><%
	} else {
		if (titre.length() > 0) {
			title += " - " + titre;
		}
	}
%>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<title><%=title%></title><%
if (urlCanonic.length()>0) {
	%><link rel="canonical" href="<%=urlCanonic%>" /><%
}
%><link rel="shortcut icon" type="image/x-icon" href="<%= URLResolver.getRessourceUrl(frontOfficeBean.getJspFo() + "/images/favicon.ico", ctx) %>" />
<link rel="icon" type="image/png" href="<%= URLResolver.getRessourceUrl(frontOfficeBean.getJspFo() + "/images/favicon.png", ctx) %>" />
<meta http-equiv="pragma" content="no-cache" />
<% /* Metatags Dublin Core */ %>
<link rel="schema.DC" href="http://purl.org/dc/elements/1.1/" />
<meta name="DC.Title" content="<%=title%>" />
<meta name="DC.Creator" content="<%=frontOfficeBean.getRedacteur()%>" />
<meta name="DC.Subject" lang="<%=ctx.getLocale().toLanguageTag()%>" content="<%=metaKeywords%>" />
<meta name="DC.Description" lang="<%=ctx.getLocale().toLanguageTag()%>" content="<%= metaDescription%>" />
<meta name="DC.Publisher" content="<%=frontOfficeBean.getRedacteur()%>" />
<meta name="DC.Date.created" scheme="W3CDTF" content="<%=creationDate%>" />
<meta name="DC.Date.modified" scheme="W3CDTF" content="<%=modificationDate%>" />
<meta name="DC.Language" scheme="RFC3066" content="<%=ctx.getLocale().toLanguageTag()%>" />
<meta name="DC.Rights" content="Copyright &copy; <%=intituleSiteCourant%>" />
<% /* Metatags classiques */ %>
<meta name="author" lang="<%=ctx.getLocale()%>" content="<%=frontOfficeBean.getRedacteur()%>" />
<meta name="keywords" content="<%= metaKeywords%>" />
<meta name="description" content="<%= metaDescription%>" />
<meta name="Date-Creation-yyyymmdd" content="<%=creationDate%>" />
<meta name="Date-Revision-yyyymmdd" content="<%=modificationDate%>" />
<meta name="copyright" content="Copyright &copy; <%=intituleSiteCourant%>" />
<meta name="reply-to" content="<%=StringUtils.defaultString(PropertyHelper.getCoreProperty("mail.webmaster"))%>" />
<meta name="category" content="Internet" />
<meta name="robots" content="index, follow" />
<meta name="distribution" content="global" />
<meta name="identifier-url" content="<%=URLResolver.getAbsoluteUrl("/", ctx)%>" />
<meta name="resource-type" content="document" />
<meta name="expires" content="-1" />
<meta name="Generator" content="<%=StringUtils.defaultString(PropertyHelper.getCoreProperty("application.name"))%>" />
<meta name="Formatter" content="<%=StringUtils.defaultString(PropertyHelper.getCoreProperty("application.name"))%>" />
