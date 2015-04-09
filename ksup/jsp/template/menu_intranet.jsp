<%@ page import="com.kportal.core.config.PropertyHelper" %>
<%@ page import="com.univ.multisites.InfosSite" %>
<%@ page import="com.univ.multisites.Site" %>
<%@ page import="com.univ.objetspartages.processus.MotDePasseCtrl" %>
<%@ page import="com.univ.utils.ContexteUniv" %>
<%@ page import="com.univ.utils.ContexteUtil" %>
<%@ page import="com.univ.utils.URLResolver" %>
<%@ page import="com.univ.utils.UnivWebFmt" %>
<%@ page import="java.util.Collection" %>
<%@ page import="com.kportal.core.config.MessageHelper" %>
<%@ page import="com.univ.objetspartages.om.Profildsi" %>
<%@ page import="com.univ.objetspartages.om.InfosProfilDsi" %>
<jsp:useBean id="frontOfficeBean" class="com.univ.url.FrontOfficeBean" scope="request" />
<%
	if (frontOfficeBean.isActivationDSI()) {
		ContexteUniv ctx = ContexteUtil.getContexteUniv(); %>
<div id="connexion" class="plier-deplier">
	<button class="plier-deplier__bouton" aria-expanded="false"><span class="icon icon-user"></span><span class="icon-libelle"><%= MessageHelper.getCoreMessage("ACCES_DIRECTS_CONNEXION")%></span></button>
	<div class="plier-deplier__contenu plier-deplier__contenu--clos">
	<% if (!frontOfficeBean.isDsi()) {
		// pas besoin d'URLResolver, l'url de login externe est deja absolue (serveur cas)
		String urlLoginExterne = UnivWebFmt.getUrlConnexionExterne(request, ctx);
		if (!urlLoginExterne.equals("")) { %>
			<p><a id="se_connecter" href="<%=urlLoginExterne%>"><%=MessageHelper.getCoreMessage("ST_DSI_SE_CONNECTER")%></a></p>
		<% } else { %>
			<form id="se_connecter" action="<%= URLResolver.getAbsoluteUrl("/servlet/com.jsbsoft.jtf.core.SG", ctx, URLResolver.LOGIN_FRONT) %>" method="post" <%=("0".equals(PropertyHelper.getCoreProperty("utilisateur.login.autocomplete"))?"autocomplete=\"off\"":"")%>>
				<div>
					<input type="hidden" name="PROC" value="IDENTIFICATION_FRONT" />
					<input type="hidden" name="#ECRAN_LOGIQUE#" value="PRINCIPAL" />
					<input type="hidden" name="#ETAT#" value="null" />
					<input type="hidden" name="RH" value="<%=com.univ.utils.EscapeString.escapeAttributHtml(ctx.getCodeRubriquePageCourante())%>" />
					<input type="hidden" name="#FORMAT_LOGIN" value="1;0;0;64;LIB=Login;0" />
					<input type="hidden" name="#FORMAT_PASSWORD" value="1;0;0;<%=MotDePasseCtrl.getLongueurChampMotDePasse() %>;PASSWORD=YES,LIB=Mot de passe;1" />
					
					<p><label for="login_intranet"><%=MessageHelper.getCoreMessage("ST_DSI_NOM_USAGER")%></label>
					<input id="login_intranet" class="text" type="text" name="LOGIN" value="" /></p>
					
					<p><label for="password_intranet"><%=MessageHelper.getCoreMessage("ST_DSI_MOT_DE_PASSE")%></label>
					<input id="password_intranet" class="password" type="password" name="PASSWORD" value="" /></p>
					
					<input type="submit" value="<%=MessageHelper.getCoreMessage("ST_VALIDATION_OK")%>" class="submit"/>
					<p id="mot_de_passe_oublie">
						<a href="<%= URLResolver.getAbsoluteUrl(UnivWebFmt.getUrlDemandeMotDePasse(ctx),ctx) %>"><%=MessageHelper.getCoreMessage("ST_DSI_OUBLI_MDP")%></a>
					</p>
				</div>
			</form>
		<% } %>

	<% } else { %>
		<p id="personne_dsi"><%=ctx.getPrenom()%> <%=ctx.getNom()%></p>

			<% /* Liste déroulante contenant la liste des profils de l'utilisateur connecté */
			if (!ctx.getListeProfilsDsi().isEmpty()) { %>
				<form name="redirect_profil" id="profil" action="<%=URLResolver.getAbsoluteUrl("/servlet/com.kportal.servlet.ServletRedirectProfil", ctx)%>" method="post">
					<div>
						<label for="select_profil"><%=MessageHelper.getCoreMessage("ST_DSI_SELECTIONNEZ_VOTRE_PROFIL")%></label>
						<select id="select_profil" name="code" onchange="document.redirect_profil.submit();">
						<%
                        for (String codeProfil : ctx.getListeProfilsDsi()) {
                            String selected = "";
                            InfosProfilDsi infosProfil = Profildsi.renvoyerItemProfilDsi(codeProfil);
                            if (codeProfil.equals(ctx.getProfilDsi())) {
                                selected = " selected=\"selected\" ";
                            } %>
                            <option value="<%=infosProfil.getCode()%>"<%=selected%>><%=infosProfil.getIntitule()%></option>
                        <% } %>
						</select>
						<input type="submit" value="<%=MessageHelper.getCoreMessage("ST_VALIDATION_OK")%>" class="submit" />
					</div>
				</form>
			<% } %>
			<script type="text/javascript">
			//<![CDATA[
				function propageDeconnexion () {
					<%
						Collection<InfosSite> sites = Site.getListeInfosSites().values();
						for (InfosSite infosSite: sites){
							if (!infosSite.getAlias().equals(ctx.getInfosSite().getAlias()) && infosSite.isSso()){%>
								var script = document.createElement('script');
								script.src = '<%= infosSite.getSslMode()== 1 ? "https" : "http" %>://<%=infosSite.getHttpHostname()+((infosSite.getHttpPort()== 80 || infosSite.getHttpPort()== -1) ? "" : ":"+infosSite.getHttpPort())%>/servlet/com.jsbsoft.jtf.core.SG?PROC=IDENTIFICATION_FRONT&ACTION=DECONNECTER';
						    	script.id = 'deconnexion_<%=infosSite.getAlias()%>';
						    	script.type = 'text/javascript';
					    		document.body.appendChild(script);
				    		<%}
						}%>		
					setTimeout("findeconnexion()", 1000);
				}
				function findeconnexion() {
          			location.href='<%= UnivWebFmt.getUrlDeconnexion(ctx,false) %>';
				}			
				//]]>
			</script>
			<ul>
				<li><a id="accueil_dsi" href="<%= URLResolver.getAbsoluteUrl(UnivWebFmt.getUrlAccueilDsi(ctx), ctx) %>"><%=MessageHelper.getCoreMessage("ST_DSI_ACCUEIL")%></a></li>
				<li><a id="preferences" href="<%= URLResolver.getAbsoluteUrl(UnivWebFmt.getUrlPreferences(ctx), ctx) %>"><%=MessageHelper.getCoreMessage("ST_DSI_PREFERENCES")%></a></li>
				<li><a id="se_deconnecter" onclick="propageDeconnexion();return false;" href="<%= URLResolver.getAbsoluteUrl(UnivWebFmt.getUrlDeconnexion(ctx), ctx, URLResolver.DECONNECTER_FRONT) %>"><%=MessageHelper.getCoreMessage("ST_DSI_DECONNEXION")%></a></li>
			</ul>
<% 	} %>
	    </div><!-- .plier-deplier__contenu -->
	</div> <!-- #connexion -->
<% } %>
