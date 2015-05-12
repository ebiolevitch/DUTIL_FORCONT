<%--

    Copyright (C) 2013 Kosmos <contact@kosmos.fr>

    Projet: webapp
    Version: 6.01.00

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.

--%>
<%@page import="com.ksup.objetspartages.util.FormationHelper"%>
<%@page import="com.ksup.objetspartages.om.Formation"%>
<%@page import="com.univ.objetspartages.om.ReferentielObjets"%>
<%@page import="com.kportal.cms.objetspartages.Objetpartage"%>
<%@page import="com.univ.objetspartages.om.Libelle"%>
<%@page import="com.univ.utils.UnivWebFmt"%>
<%@page import="com.univ.utils.ContexteUtil"%>
<%@page import="com.univ.utils.ContexteUniv"%>
<%@page import="com.jsbsoft.jtf.core.LangueUtil"%>
<jsp:useBean id="frontOfficeBean" class="com.univ.url.FrontOfficeBean" scope="request" />
<% 
ContexteUniv ctx = ContexteUtil.getContexteUniv();
Objetpartage module = ReferentielObjets.getObjetByNom("formation");
int indiceEncadre = (Integer)ctx.getData("indiceEncadre");
ctx.putData("indiceEncadre",indiceEncadre++);
ctx.putData("titreEncadreRecherche",module.getMessage("ST_ENCADRE_RECHERCHE_FORMATION"));
%><jsp:include page="<%= frontOfficeBean.getJspFo() + \"/template/encadres/recherche_debut.jsp\"  %>" />

<input type="hidden" name="OBJET" value="FORMATION" />

<p>
	<label for="LIBELLE<%=indiceEncadre%>"><%=module.getMessage("ST_ENCADRE_RECHERCHE_FORMATION_INTITULE")%></label>
	<input type="text" class="champ-saisie" id="LIBELLE<%=indiceEncadre%>" name="LIBELLE" />
</p>


<p>
  <label for="TYPE_FORMATION<%=indiceEncadre%>"><%=module.getMessage("ST_ENCADRE_RECHERCHE_FORMATION_TYPE_FORMATION")%></label>
  <select id="TYPE_FORMATION<%=indiceEncadre%>" name="TYPE_FORMATION">
	  <option value="0000"><%=module.getMessage("ST_TOUS")%></option>
	  <%=UnivWebFmt.insererCombo(Libelle.getListe("90", ctx.getLocale()), "", false) %>
  </select>
</p>



<p>
  <label for="VILLE<%=indiceEncadre%>"><%=module.getMessage("ST_ENCADRE_RECHERCHE_FORMATION_VILLE")%></label>
  <select id="VILLE<%=indiceEncadre%>" name="VILLE">
	  <option value="0000"><%=module.getMessage("ST_TOUTES")%></option>
	  <%=UnivWebFmt.insererCombo(Libelle.getListe("22",  ctx.getLocale()), "", true) %>
  </select>
</p>

<p>
  <label for="NIVEAU_RECRUTEMENT<%=indiceEncadre%>"><%=module.getMessage("ST_ENCADRE_RECHERCHE_FORMATION_NIVEAU_ENTREE")%></label>
  <select id="NIVEAU_RECRUTEMENT<%=indiceEncadre%>" name="NIVEAU_RECRUTEMENT">
	  <option value="0000"><%=module.getMessage("ST_TOUS")%></option>
	  <%=UnivWebFmt.insererComboFichier(module.getIdExtension(),"niveau_recrutement", ctx.getLocale(), "", true) %>
  </select>
</p>




<jsp:include page="<%= frontOfficeBean.getJspFo() + \"/template/encadres/recherche_fin.jsp\"  %>" />
