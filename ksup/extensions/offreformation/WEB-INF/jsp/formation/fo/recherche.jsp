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
<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@page import="com.kportal.cms.objetspartages.Objetpartage"%>
<%@page import="com.univ.objetspartages.om.ReferentielObjets"%>
<%@page import="com.univ.utils.ContexteUtil"%>
<%@page import="com.univ.utils.ContexteUniv"%>
<%@page import="com.univ.utils.UnivWebFmt"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.Map.Entry"%>
<jsp:useBean id="infoBean" class="com.jsbsoft.jtf.core.InfoBean" scope="request" />
<jsp:useBean id="fmt" class="com.jsbsoft.jtf.core.FormateurJSP" scope="page" />
<jsp:useBean id="univFmtKsup" class="com.ksup.utils.UnivFmt" scope="page" />
<%
	ContexteUniv ctx = ContexteUtil.getContexteUniv();
 	Objetpartage module = ReferentielObjets.getObjetByNom("formation");
 	%>
	<p>
		<label for="LIBELLE"><%=module.getMessage("ST_RECHERCHE_FICHE_FORMATION_INTITULE")%></label>
		<%fmt.insererChampSaisie(out, infoBean, "LIBELLE", fmt.SAISIE_FACULTATIF , fmt.FORMAT_TEXTE, 0, 20);%>
	</p>
	<p>
		<label for="TYPE_FORMATION"><%=module.getMessage("ST_RECHERCHE_FICHE_FORMATION_TYPE_FORMATION")%></label>
		<%fmt.insererComboHashtable(out, infoBean, "TYPE_FORMATION", fmt.SAISIE_FACULTATIF , "LISTE_TYPE_FORMATIONS","");%>
	</p>
	<p>
		<label for="VILLE"><%=module.getMessage("ST_RECHERCHE_FICHE_FORMATION_VILLE")%></label>
		<%fmt.insererComboHashtable(out, infoBean, "VILLE", fmt.SAISIE_FACULTATIF , "LISTE_VILLES");%>
	</p>
	<p>
		<label for="NIVEAU_RECRUTEMENT"><%=module.getMessage("ST_RECHERCHE_FICHE_FORMATION_NIVEAU_ENTREE")%></label>
		<%fmt.insererCombo(out, infoBean, "NIVEAU_RECRUTEMENT", fmt.SAISIE_FACULTATIF, module.getIdExtension(), "niveau_recrutement", "Niveau_recrutement");%>
	</p>
 	
	
	

	
	<fieldset>
		<legend><%= module.getMessage("ST_RECHERCHE_FICHE_FORMATION_MODALITE_ENSEIGNEMENT") %></legend>
		<ul class="sans_puce">
		<% final Map<String, String> modalities = (Map<String, String>) infoBean.get("LISTE_MODALITES_ENSEIGNEMENTS"); %>
		<% for(Map.Entry<String, String> currentModality : modalities.entrySet()) { %>
			<li>
				<input id="<%= currentModality.getKey() %>" class="checkbox" type="checkbox" name="<%= currentModality.getKey() %>" value="1"/>
				<label class="no_float" for="<%= currentModality.getKey() %>"><%= currentModality.getValue() %></label>
			</li>
		<% } %>
		</ul>
	</fieldset>
  	<% ctx.putData("criteresRechAvancee","LIBELLE=;DOMAINE_FORMATION_ETABLISSEMENT=0000;TYPE_FORMATION=0000;VILLE=0000;NIVEAU_RECRUTEMENT=0000;DISCIPLINE=0000;MODALITES_FORMATION_DISTANCE=0;FORMATION_ALTERNANCE=0;MIXTE_DISTANCE=0;FORMATION_APPRENTISSAGE=0;FORMATION_CONTINUE=0;FORMATION_INITIALE=0"); %>