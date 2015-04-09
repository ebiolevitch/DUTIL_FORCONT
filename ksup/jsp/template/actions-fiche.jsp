<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@page import="com.univ.objetspartages.om.FicheUniv"%>
<%@page import="com.kportal.core.config.MessageHelper"%>
<%@page import="com.univ.utils.ContexteUtil"%>
<%@page import="com.univ.utils.ContexteUniv"%>
<%@page import="com.univ.utils.UnivWebFmt"%>
<%@page import="com.univ.utils.URLResolver"%>
<jsp:useBean id="frontOfficeBean" class="com.univ.url.FrontOfficeBean" scope="request" />
<div class="actions-fiche">
	<div class="actions-fiche__item"><%
		if (!frontOfficeBean.isApercu() && frontOfficeBean.getFicheUniv() !=null) {
			%><button title="<%=MessageHelper.getCoreMessage("ST_IMPRIMER")%>" onclick="window.print(); return false;"><span aria-hidden="true" class="icon icon-print"></span><span class="actions-fiche__libelle"><%=MessageHelper.getCoreMessage("ST_IMPRIMER")%></span></button><%
		}
	%></div>
</div>