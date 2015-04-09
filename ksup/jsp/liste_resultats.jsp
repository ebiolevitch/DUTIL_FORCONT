<%@page import="com.univ.objetspartages.om.InfosRubriques"%>
<%@page import="com.kportal.frontoffice.util.JSPIncludeHelper"%>
<%@page import="com.kportal.cms.objetspartages.ObjetPartageHelper"%>
<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@page import="com.univ.utils.RechercheFiche"%>
<%@page import="com.univ.utils.RechercheFicheHelper"%>
<%@page import="com.univ.utils.EscapeString"%>
<%@page import="com.univ.multisites.InfosSite"%>
<%@page import="com.univ.utils.RechercheUtil"%>
<%@page import="com.univ.utils.RequeteUtil"%>
<%@page import="com.jsbsoft.jtf.textsearch.ResultatRecherche"%>
<%@page import="com.univ.objetspartages.om.ReferentielObjets"%>
<%@page import="com.univ.objetspartages.om.FicheUniv"%>
<%@page import="com.univ.utils.ContexteUniv"%>
<%@page import="com.univ.objetspartages.om.Libelle"%>
<%@page import="com.univ.objetspartages.om.FicheUniv"%>
<%@page import="java.util.*,java.text.*,java.lang.*"%>
<%@page import="com.kportal.core.config.PropertyHelper"%>
<%@page errorPage="./jsb_exception.jsp"%>
<jsp:useBean id="infoBean" class="com.jsbsoft.jtf.core.InfoBean" scope="request" />
<%@ include file="./template/initialisations.jsp" %><%
	/* On déclare les variables utilisées par cette JSP */
	String requete = infoBean.getString(RechercheFiche.REQUETE);
	String nomObjetCherche = infoBean.getString("OBJET");
	/* Variables pour gérer les résultats */
	List<ResultatRecherche> listeFiches = (List<ResultatRecherche>)infoBean.get(RechercheFiche.SEARCH_RESULTS);
	int nbTotalPages = infoBean.getInt(RechercheFiche.NB_TOTAL_PAGES);
	int debutFenetre =  infoBean.getInt(RechercheFiche.DEBUT_FENETRE);
	int finFenetre =  infoBean.getInt(RechercheFiche.FIN_FENETRE);
	int indicePagePrecedente = infoBean.getInt(RechercheFiche.INDICE_PAGE_PRECEDENTE);
	int indiceDernierePage = infoBean.getInt(RechercheFiche.INDICE_DERNIERE_PAGE);
	int nbResultats = infoBean.getInt(RechercheFiche.NB_RESULTATS);
	boolean isRechMotsCles = RechercheFicheHelper.isFullTextSearch(infoBean);
	int nbResultatsParPage = infoBean.getInt(RechercheFiche.NB_RESULTATS_PAR_PAGE);
	/* Variables gérant le retour sur une recherche avancée */
	ctx.putData("requete",requete);
	ctx.putData("criteresRechAvancee","");
	ctx.putData("modifRecherche","&MODIFRECHERCHE=TRUE");
	String paramRubriqueHistorique = StringUtils.defaultString(request.getParameter("RH"));
	/* calcul du bloc "titre" */
	titre = ctx.getMessage("ST_RESULTATS_DE_RECHERCHE");
	if (StringUtils.isNotBlank(nomObjetCherche)) {
		titre += " " + ctx.getMessage("ST_RESULTATS_" + nomObjetCherche.toUpperCase());
	}
	%><%@ include file="./template/header.jsp" %><%
	/* Préparation du lien "modifier la recherche", dans le cas d'une recherche avancée */
	if (StringUtils.isNotBlank(nomObjetCherche)) {
		JSPIncludeHelper.includeJsp(out,getServletConfig().getServletContext(),request,response,ObjetPartageHelper.getTemplateObjet(ObjetPartageHelper.TEMPLATE_RECHERCHE_CALCUL,nomObjetCherche.toLowerCase()));
	}
	/* On a 2 possibilites : soit on est dans le cas d'un affichage de rubriques,
	soit dans un résultat de recherche (avancée ou par mots clés) */
	/* Affichage du nombre total de résultats */
	String resultats = ctx.getMessage("ST_RESULTATS_LA_RECHERCHE") + " ";
	if (isRechMotsCles) {
		resultats += ctx.getMessage("ST_RESULTATS_PORTANT_SUR") + " \"" + EscapeString.escapeHtml(EscapeString.unescapeURL(infoBean.getString(RechercheFiche.QUERY))) + "\" ";
	} else if (((String)ctx.getData("criteresRechAvancee")).length() > 0) {
		resultats += ctx.getMessage("ST_RESULTATS_PORTANT_SUR") + " " + EscapeString.escapeHtml(EscapeString.unescapeURL(((String)ctx.getData("criteresRechAvancee"))).replaceAll("\"\"","\", \"")) + " ";
	}
	if (nbResultats == 0) {
		resultats += ctx.getMessage("ST_RESULTATS_NA_DONNE") + " " + ctx.getMessage("ST_RESULTATS_AUCUN_RESULTAT");
	} else {
		resultats += ctx.getMessage("ST_RESULTATS_A_DONNE") + " " + nbResultats + " " ;
		if (nbResultats == 1) {
			resultats += ctx.getMessage("ST_RESULTATS_RESULTAT");			
		} else {
			resultats += ctx.getMessage("ST_RESULTATS_RESULTATS");			
		}
	}
%><p id="precisions_resultats"><%=resultats%></p><%
	/* On passe à l'affichage proprement dits des résultats */
	if (nbResultats > 0) {
		%><ul id="liste_resultats"><%
		/* boucle sur le nombre de fiches de la page courante*/
		int start = debutFenetre;
		int end= finFenetre;
		if (isRechMotsCles) {
			start=0;
			end= nbResultatsParPage;
			if (listeFiches.size()<end) {
				end =listeFiches.size();
			}
		}
		for (int i =start; i < end; i++) {
			ResultatRecherche resultatRecherche = listeFiches.get(i);
			%><li><%
			if (isRechMotsCles) {
				if (StringUtils.isNotEmpty(resultatRecherche.getUrl())) {
					%><a href="<%= URLResolver.getAbsoluteUrl(resultatRecherche.getUrl(), ctx) %>"><%=resultatRecherche.getTitre()%></a><%
				} else if (resultatRecherche.isResultatFicheUniv()) {
					FicheUniv fiche = RequeteUtil.lireFiche(resultatRecherche);
					%><a href="<%= URLResolver.getAbsoluteUrl(UnivWebFmt.determinerUrlFiche(ctx, fiche), ctx) %>"><%=resultatRecherche.getTitre()%></a><%
				} else {
					%><br /><%=resultatRecherche.getTitre()%><%
				}
				%><br /><span class="pertinence"><%= ctx.getMessage("ST_RESULTATS_PERTINENCE") %> <%= Float.valueOf(resultatRecherche.getScore()).intValue()%>%</span><%
				if (resultatRecherche.getHighlightedTextContent().length() > 0) {
					%><br /><%= resultatRecherche.getHighlightedTextContent()%><%
				}
				if (resultatRecherche.getHighlightedTextContentFile().length() > 0) {
					%><br /><%= ctx.getMessage("ST_RESULTATS_PIECES_JOINTES")%>&nbsp;: <%= resultatRecherche.getHighlightedTextContentFile()%><%
				}
			} else {
				FicheUniv fiche = RequeteUtil.lireFiche(resultatRecherche);
				if (fiche != null) {
					ctx.putData("fiche",fiche);
					JSPIncludeHelper.includeJsp(out,getServletConfig().getServletContext(),request,response,ObjetPartageHelper.getTemplateObjet(ObjetPartageHelper.TEMPLATE_RECHERCHE_RESULTAT,ReferentielObjets.getNomObjet(fiche).toLowerCase()));
				}
			}
			%></li><%
		}
		%></ul><%
	}
	/* Les liens "Nouvelle recherche" et "Modifier la recherche" n'apparaissent que si on est sur une recherche avancée */
  	if (!isRechMotsCles) {
  		%><p id="recherche_avancee_modification">
			<a href="<%=URLResolver.getAbsoluteUrl(RechercheFicheHelper.getUrlAdvancedSearch(nomObjetCherche,paramRubriqueHistorique), ctx).replaceAll("&", "&amp;")%>"><%=ctx.getMessage("ST_RESULTATS_NOUVELLE_RECHERCHE")%></a>
			&mdash;
			<a href="<%=URLResolver.getAbsoluteUrl(RechercheFicheHelper.getUrlAdvancedSearch(nomObjetCherche,paramRubriqueHistorique) + (String)ctx.getData("modifRecherche"), ctx).replaceAll("&", "&amp;")%>"><%=ctx.getMessage("ST_RESULTATS_MODIFIER_LA_RECHERCHE")%></a>
		</p><%
	}
	/* Navigation dans les résultats */
	if (nbResultats > 0) {
		%><p id="resultats_recherche_navigation"><%
		InfosSite siteCourant = ctx.getInfosSite();
		if (debutFenetre > 0) {
			%><a class="premier" href="<%=URLResolver.getAbsoluteUrl(RechercheFicheHelper.getUrlResults(requete,"0",paramRubriqueHistorique), ctx).replaceAll("&", "&amp;")%>"><span aria-hidden="true" class="icon icon-first"></span> <%=ctx.getMessage("ST_RESULTATS_PREMIERE_PAGE")%></a>
			<a class="precedent" href="<%=URLResolver.getAbsoluteUrl(RechercheFicheHelper.getUrlResults(requete,String.valueOf(indicePagePrecedente),paramRubriqueHistorique), ctx).replaceAll("&", "&amp;")%>"><span aria-hidden="true" class="icon icon-previous"></span> <%=ctx.getMessage("ST_RESULTATS_PAGE_PRECEDENTE")%></a><%
		}
		%><strong><%=ctx.getMessage("ST_RESULTATS_PAGE")%> <%=((debutFenetre / nbResultatsParPage)+1)%>/<%=nbTotalPages%></strong><%
		if (nbResultats > finFenetre) {
			%><a class="suivant" href="<%=URLResolver.getAbsoluteUrl(RechercheFicheHelper.getUrlResults(requete,String.valueOf(finFenetre),paramRubriqueHistorique), ctx).replaceAll("&", "&amp;")%>"><%=ctx.getMessage("ST_RESULTATS_PAGE_SUIVANTE")%> <span aria-hidden="true" class="icon icon-next"></span></a>
			<a class="dernier" href="<%=URLResolver.getAbsoluteUrl(RechercheFicheHelper.getUrlResults(requete,String.valueOf(indiceDernierePage),paramRubriqueHistorique), ctx).replaceAll("&", "&amp;")%>"><%=ctx.getMessage("ST_RESULTATS_DERNIERE_PAGE")%> <span aria-hidden="true" class="icon icon-last"></span></a><%
		}
		%></p><%
	}
%><%@ include file="./template/footer.jsp" %>