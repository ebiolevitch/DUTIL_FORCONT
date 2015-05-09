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
<%@page import="com.univ.utils.UnivWebFmt"%>
<%@page import="com.univ.utils.URLResolver"%>
<%@page import="java.lang.StringBuilder"%>
<%@page import="java.util.StringTokenizer"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Arrays"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.Map.Entry"%>
<%@page import="java.util.LinkedHashMap"%>
<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@page import="com.kportal.cms.objetspartages.Objetpartage"%>
<%@page import="com.ksup.objetspartages.om.Formation"%>
<%@page import="com.univ.objetspartages.om.Structure"%>
<%@page import="com.univ.objetspartages.om.StructureModele"%>
<%@page import="com.univ.objetspartages.om.ReferentielObjets"%>
<%@page import="com.univ.utils.ContexteUtil"%>
<%@page import="com.univ.utils.ContexteUniv"%>
<%
final ContexteUniv ctx = ContexteUtil.getContexteUniv();
final Formation formation = (Formation) ctx.getData("fiche");
final Objetpartage module = ReferentielObjets.getObjetByNom(ReferentielObjets.getNomObjet(formation));
final String titreFiche = formation.getLibelleLong();
final StringBuilder contenuResultat = new StringBuilder();
final Map<String, List<String>> fields = new LinkedHashMap<String, List<String>>();

StructureModele structure = Structure.getFicheStructure(formation.getCodeRattachement(), formation.getLangue());

if(StringUtils.isNotBlank(formation.getNiveauRecrutement())){
	fields.put(module.getMessage("ST_FORMATION_NIVEAU_X_RECRUTEMENT"), Arrays.asList(formation.getNiveauRecrutement()));
}

final List<String> modalites = new ArrayList<String>();
if (formation.isFormationInitiale()) {
	modalites.add(module.getMessage("ST_FORMATION_FORMATION_INITIALE"));
}
if (formation.isFormationContinue()) {
	modalites.add(module.getMessage("ST_FORMATION_FORMATION_CONTINUE"));
}
if (formation.isFormationAlternance()) {
	modalites.add(module.getMessage("ST_FORMATION_FORMATION_EN_ALTERNANCE"));
}
if (formation.isFormationApprentissage()) {
	modalites.add(module.getMessage("ST_FORMATION_FORMATION_EN_APPRENTISSAGE"));
}
if (formation.isModalitesFormationDistance()) {
	modalites.add(module.getMessage("ST_FORMATION_FORMATION_A_DISTANCE"));
}

if(!modalites.isEmpty()){
	fields.put("Modalités", modalites);
}

if(formation.isStageEtranger() || formation.isStageObligatoire() || formation.isStageOptionnel()){
	fields.put(module.getMessage("ST_FORMATION_STAGES"), Arrays.asList(module.getMessage("JTF_OUI")));
}else{
	fields.put(module.getMessage("ST_FORMATION_STAGES"), Arrays.asList(module.getMessage("JTF_NON")));
}

if(StringUtils.isNotBlank(formation.getDureeEtudes())){
	fields.put(module.getMessage("ST_FORMATION_DUREE_ETUDES"), Arrays.asList(formation.getDureeEtudes()));
}

final List<String> composantes = new ArrayList<String>();
final StringTokenizer stRattAutres = new StringTokenizer(formation.getCodeRattachementAutres(), ";");
StructureModele structureRattachementAutres = null;
if (structure != null) {
	composantes.add(structure.getLibelleLong());
}
while (stRattAutres.hasMoreTokens()) {
	structureRattachementAutres = Structure.getFicheStructure(stRattAutres.nextToken(), formation.getLangue());
	if (structureRattachementAutres != null) {
		composantes.add(structureRattachementAutres.getLibelleLong());
	}
}
if(!composantes.isEmpty()){
	fields.put("Composantes", composantes);
}

final List<String> villes = new ArrayList<String>();
final StringTokenizer stVilles = new StringTokenizer(formation.getLibelleVille(), ";");
while (stVilles.hasMoreTokens()) {
	final String currentVille = stVilles.nextToken();
	if(StringUtils.isNotBlank(currentVille)){
		villes.add(currentVille);
	}
}
if (!villes.isEmpty()) {
	fields.put(module.getMessage("ST_FORMATION_VILLE_S"), villes);
}
String urlFiche = URLResolver.getAbsoluteUrl(UnivWebFmt.determinerUrlFiche(ctx, formation), ctx);
if (StringUtils.isNotBlank(urlFiche)) {
	%><a href="<%= urlFiche %>"><%=formation.getLibelleAffichable()%></a><%
} else {
	%><br/><%=formation.getLibelleAffichable()%><%
}
if(!fields.isEmpty()){
	int milieu = fields.size() / 2;
	int cpt = 0;
	%><div class="colonne__pas2"><%
	for(Map.Entry<String, List<String>> currentEntry : fields.entrySet()){
		if(StringUtils.isNotBlank(currentEntry.getKey()) && !currentEntry.getValue().isEmpty()){
			if(cpt == milieu){
				%></div><div class="colonne__pas2"><%
			}
			%><span class="label"><%= currentEntry.getKey() %> : </span><%=  StringUtils.join(currentEntry.getValue().iterator(), ", ") %><br/><%
		}
	}
	%></div><%
}
%>