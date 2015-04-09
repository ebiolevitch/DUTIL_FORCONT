<%@page import="com.univ.objetspartages.om.FicheUniv"%>
<%@page import="com.univ.utils.ContexteUniv"%>
<%@page import="com.univ.utils.ContexteUtil"%>
<jsp:useBean id="frontOfficeBean" class="com.univ.url.FrontOfficeBean" scope="request" /><% 
   	ContexteUniv ctx = ContexteUtil.getContexteUniv();
	ctx.setJsp(this);
   	ctx.setJspWriter(out);
	FicheUniv ficheUniv = frontOfficeBean.getFicheUniv();
	if (ficheUniv != null) {
		ficheUniv.setCtx(ctx);
	}
	/* Déclaration de variables globales, utilisables par toutes les fiches (ie les JSP principales) */
	String titre = "";
	String surtitre = "";
	String soustitre = "";
%>