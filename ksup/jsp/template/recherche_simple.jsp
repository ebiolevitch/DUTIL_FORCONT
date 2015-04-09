<%@page import="com.univ.utils.ContexteUniv"%>
<%@page import="com.univ.utils.ContexteUtil"%>
<%@page import="com.univ.utils.URLResolver"%>
<%@page import="com.univ.utils.EscapeString"%>
<%@page import="com.kportal.core.config.MessageHelper"%>
<% /* Formulaire de recherche par mots-clefs */%>

<div id="recherche-simple" class="plier-deplier">
	<button class="plier-deplier__bouton" aria-expanded="false"><span class="icon icon-search"></span><span class="icon-libelle"><%=MessageHelper.getCoreMessage("ST_RECHERCHE")%></span></button>
	<div class="plier-deplier__contenu plier-deplier__contenu--clos">
		<form action="<%=URLResolver.getAbsoluteUrl("/servlet/com.jsbsoft.jtf.core.SG", ContexteUtil.getContexteUniv())%>" method="post">
				<input type="hidden" name="#ECRAN_LOGIQUE#" value="RECHERCHE" />
				<input type="hidden" name="PROC" value="RECHERCHE" />
				<input type="hidden" name="ACTION" value="VALIDER" />
				<input type="hidden" name="LANGUE_SEARCH" value="<%=EscapeString.escapeAttributHtml(ContexteUtil.getContexteUniv().getLangue())%>" />
				<input type="hidden" name="CODE_RUBRIQUE" value="" />
				<input type="hidden" name="CODE_SITE_DISTANT" value="" />
				<input type="hidden" name="SEARCH_SOUSRUBRIQUES" value="true" />
				<input type="hidden" name="SEARCH_EXCLUSIONOBJET" value="" />
				<input type="hidden" name="RH" value="<%=EscapeString.escapeAttributHtml(ContexteUtil.getContexteUniv().getCodeRubriquePageCourante())%>" />
				<input type="hidden" name="OBJET" value="TOUS" />		
				<label for="MOTS_CLEFS"><%=MessageHelper.getCoreMessage("ST_RECHERCHE")%></label>
				<input name="QUERY" role="search" type="text" id="MOTS_CLEFS" value="" placeholder="<%=MessageHelper.getCoreMessage("MOT_CLE")%>" title="<%=MessageHelper.getCoreMessage("ST_RECHERCHER_PAR_MOTS_CLES")%>" />
				<input type="submit" value="<%=MessageHelper.getCoreMessage("RECHERCHER")%>" />
		</form>
	</div><!-- .plier-deplier__contenu -->
</div><!-- #recherche-simple .plier-deplier -->