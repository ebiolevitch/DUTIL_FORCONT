<%@ page import="com.jsbsoft.jtf.core.Log" %>
<%@ page import="com.jsbsoft.jtf.exception.ErreurApplicative" %>
<%@page import="com.kportal.core.config.MessageHelper"%>
<%@ page import="com.univ.utils.ExceptionLogin" %>
<%@ page import="com.univ.utils.ContexteUniv" %>
<%@ page import="com.univ.objetspartages.om.Libelle" %>
<%@ page import="com.univ.utils.UnivWebFmt" %>
<%@ page import="com.univ.utils.URLResolver" %>
<%@ page import="java.util.*"%>
<%@ page isErrorPage="true" buffer="100kb" %><%
out.clear();
%>
<%@ include file="./template/initialisations.jsp" %><%
   if(request.getAttribute("Exception")!=null) {
       exception = (Exception)request.getAttribute("Exception");
   }
   /* Si la fiche n'a pas été trouvée : elle est soit non trouvée, soit plus en ligne */
   if (exception instanceof ErreurApplicative) {
       if (exception instanceof com.univ.utils.ExceptionFicheNonTrouvee) {
           response.setStatus(HttpServletResponse.SC_NOT_FOUND);
       } else if (exception instanceof com.univ.utils.ExceptionFicheNonAccessible) {
           response.setStatus(HttpServletResponse.SC_FORBIDDEN);
       } else if (exception instanceof com.univ.utils.ExceptionFicheArchivee) {
           response.setStatus(HttpServletResponse.SC_GONE);
       } else if (exception instanceof com.univ.utils.ExceptionUrlObsolete) {
           response.setStatus(HttpServletResponse.SC_MOVED_PERMANENTLY);
           response.setHeader("Location", ((com.univ.utils.ExceptionUrlObsolete) exception).getUrlRedirect());
           return;
       }
   }
   %><%@ include file="./template/header.jsp" %><%
    if (exception instanceof ExceptionLogin) {
		UnivWebFmt.redirigerVersLogin(ctx, response, ((ExceptionLogin) exception).getUrlRedirect());
   		return;
	} else if (exception instanceof com.univ.utils.ExceptionSite) {
		UnivWebFmt.redirigerVersUrl(ctx, response, ((com.univ.utils.ExceptionSite)exception));
   		return;
	} else {
        if (exception instanceof com.jsbsoft.jtf.exception.ErreurApplicative) {
			%><%=exception.getMessage()%><%
			com.jsbsoft.jtf.database.RequeteMgr.purgerRequetesNonTerminees();
   			if( exception instanceof com.univ.utils.ExceptionFicheNonTrouvee
   				|| exception instanceof com.univ.utils.ExceptionFicheNonAccessible
   				|| exception instanceof com.univ.utils.ExceptionFicheArchivee ) { 
				Log.error(exception.getMessage());
			} else {
				Log.error(exception);
			}
		} else {
			Log.error(exception);
			%><%=MessageHelper.getCoreMessage("ST_ERREUR_SURVENUE")%> ...<%
		}
 	}
/* le bouton de retour n'est affiché que si javascript est activé, et que l'historique de navigation n'est pas vide */
%>
<script type="text/javascript">
if (history.length > 1) {
	document.write('<p><a href=\"#\" onclick=\"history.back(); return false;\"><%=MessageHelper.getCoreMessage("ST_RETOUR")%></a></p>');
}
</script>

<%@ include file="./template/footer.jsp" %>
