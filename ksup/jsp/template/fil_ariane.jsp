<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@page import="com.univ.utils.UnivWebFmt"%>
<%@page import="com.univ.utils.URLResolver"%>
<%@page import="com.kportal.core.config.MessageHelper"%>
<%@page import="com.univ.utils.ContexteUtil"%>
<%@page import="com.univ.utils.ContexteUniv"%>
<%@page import="com.kportal.ihm.utils.FrontUtil"%>
<%@page import="com.univ.objetspartages.om.Rubrique"%>
<%@page import="com.univ.objetspartages.om.InfosRubriques"%>
<% /* Pour créer le fil d'ariane, on remonte l'arborescence des rubriques depuis la rubrique à laquelle la fiche courante est rattachée */
	ContexteUniv ctx = ContexteUtil.getContexteUniv();
	InfosRubriques rubriquePageCourante = Rubrique.renvoyerItemRubrique(ctx.getCodeRubriquePageCourante());
	if (rubriquePageCourante != null) {
		InfosRubriques rubAriane = rubriquePageCourante;
		String filAriane = "";
		String separateur = "";
		String elementParticulierDebut = "<em>";
		String elementParticulierFin = "</em>";
		int niveauMaxi = 2;
		while (rubAriane != null && rubAriane.getNiveau() >= niveauMaxi) {
			if ("0000".equals(rubAriane.getCategorie()) || StringUtils.isBlank(rubAriane.getCategorie()) || FrontUtil.CATEGORIE_LANGUE.equals(rubAriane.getCategorie())) {
				filAriane = "<a href=\"" + URLResolver.getAbsoluteUrl(UnivWebFmt.renvoyerUrlAccueilRubrique(ctx, rubAriane.getCode()), ctx) + "\">" + elementParticulierDebut + rubAriane.getOnglet() + elementParticulierFin + "</a>" + separateur + filAriane;
				separateur = " &rarr; ";
				elementParticulierDebut = "";
				elementParticulierFin = "";
			}
			rubAriane = rubAriane.getRubriqueMere();
		}
		if (filAriane.length() > 0) {
			%><p id="fil_ariane"><span><%=MessageHelper.getCoreMessage("ST_FIL_ARIANE_VOUS_ETES_ICI")%>&nbsp;:</span> <%=filAriane%></p><%
		}
	}%>
