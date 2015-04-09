<%@page import="com.univ.utils.ContexteUtil"%>
<%@page import="com.univ.utils.ContexteUniv"%>
<%@page import="com.univ.utils.URLResolver"%>
<%@page import="com.univ.utils.EscapeString"%><%
ContexteUniv ctx = ContexteUtil.getContexteUniv();
int indiceEncadre = (Integer)ctx.getData("indiceEncadre");
String titreEncadreRecherche = ctx.getDataAsString("titreEncadreRecherche");
%>
<div class="encadre_recherche<%=ctx.getDataAsString("encadreAutreClasse")%>"><%
	%>
  <h2><%=ctx.getMessage("ST_ENCADRE_RECHERCHE_RECHERCHE")%>&nbsp;<%=titreEncadreRecherche%></h2>

  <form id="form_recherche_<%=indiceEncadre %>" action="<%= URLResolver.getAbsoluteUrl("/servlet/com.jsbsoft.jtf.core.SG", ctx) %>">
    <fieldset>
  	  <legend><%=ctx.getMessage("ST_ENCADRE_RECHERCHE_RECHERCHE")%>&nbsp;<%=titreEncadreRecherche%></legend>
  	  <input type="hidden" name="#ECRAN_LOGIQUE#" value="RECHERCHE" />
  	  <input type="hidden" name="PROC" value="RECHERCHE" />
  	  <input type="hidden" name="ACTION" value="VALIDER" />
  	  <input type="hidden" name="RH" value="<%=EscapeString.escapeAttributHtml(ctx.getCodeRubriquePageCourante())%>" />
  	  <% /* Pour afficher tous les résultats, quelle que soit la langue, supprimer la ligne suivante */%>
