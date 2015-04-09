<%@page import="com.univ.utils.ContexteUniv"%>
<%@page import="com.kportal.ihm.utils.EncadresFrontUtils"%>
<%@page import="java.util.List"%>
<%@page import="com.univ.objetspartages.om.FicheUniv"%>
<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@page import="org.apache.commons.collections.CollectionUtils"%>
<%@page import="com.univ.utils.ContexteUtil"%>
<%@page import="com.univ.utils.UnivWebFmt"%>
<%@page import="java.util.Map"%>
<%@page import="com.univ.objetspartages.om.SousParagrapheBean"%>
<%@page import="com.kportal.cms.objetspartages.ObjetPartageHelper"%>
<%@page import="com.kportal.frontoffice.util.JSPIncludeHelper"%>
<jsp:useBean id="frontOfficeBean" class="com.univ.url.FrontOfficeBean" scope="request" /><%
final ContexteUniv ctx = ContexteUtil.getContexteUniv();
final String type = request.getParameter("TYPE");
final List<SousParagrapheBean> encadres = frontOfficeBean.getEncadresFiche().get(type);
if(CollectionUtils.isNotEmpty(encadres)){
	for (SousParagrapheBean sousParagraphe : encadres) {
	%>
	<div class="<%=type%> paragraphe--<%= sousParagraphe.getStyle() %>"><%
		if (StringUtils.isNotEmpty(sousParagraphe.getTitre())) {
			%><h2 class="paragraphe__titre--<%= sousParagraphe.getStyle() %>"><%= sousParagraphe.getTitre()%></h2><%
		}
		%><div class="encadre_contenu paragraphe__contenu--<%= sousParagraphe.getStyle() %>">
			<%=UnivWebFmt.formaterEnHTML(ctx, sousParagraphe.getContenu())%>
		</div><!-- .encadre_contenu .paragraphe__contenu -->
	</div><!-- .<%=type%> .paragraphe -->
<%  } 
} %>

