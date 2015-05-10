<%@page import="com.kportal.frontoffice.util.JSPIncludeHelper"%>
<%@ page import="com.univ.utils.ContexteUniv,com.univ.utils.UnivWebFmt,com.univ.objetspartages.om.Libelle,com.univ.utils.URLResolver,java.util.*,java.text.*,java.lang.*" errorPage ="./jsb_exception.jsp" %>
<%@page import="com.kportal.ihm.utils.AdminsiteUtils"%>
<%@page import="com.kportal.cms.objetspartages.Objetpartage"%>
<%@page import="com.univ.objetspartages.om.StructureModele"%>
<%@page import="com.kportal.ihm.utils.FrontUtil"%>
<jsp:useBean id="infoBean" class="com.jsbsoft.jtf.core.InfoBean" scope="request" />
<%@ include file="./template/initialisations.jsp" %>
<%
titre = FrontUtil.getTitrePageCourante(infoBean);
%>
<%@ include file="./template/header.jsp" %>

<jsp:include page="<%=infoBean.getEcranPhysique()%>" />


<%@ include file="./template/footer.jsp" %>
