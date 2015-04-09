<% 
java.util.Enumeration<com.univ.objetspartages.om.ServiceBean> enumServicesPush = ctx.calculerListeServicesPush().elements();
com.univ.objetspartages.om.ServiceBean service = null;
if (enumServicesPush.hasMoreElements()) { %>
<form name="redirect_service" id="services" action="/servlet/com.kportal.servlet.ServletRedirectService" method="post">
  <fieldset>
	  <legend><%=ctx.getMessage("ST_SERVICES_ACCES_SERVICES")%></legend>
	  <label for="selectservices"><%=ctx.getMessage("ST_SERVICES")%></label>
	  <select id="selectservices" name="code" onchange="document.redirect_service.submit();">
		<!-- <option value=""><%=ctx.getMessage("ST_SERVICES_SELECTIONNER_UN_SERVICE")%></option> -->
		<% while (enumServicesPush.hasMoreElements()) {
			service = enumServicesPush.nextElement();
		%>
			<option value="<%=service.getCode()%>" ><%=service.getIntitule() %></option>
		<%	} %>
	  </select>
	  <input type="submit" value="<%=ctx.getMessage("ST_VALIDATION_OK")%>" class="submit" />
  </fieldset>
</form>
<% } %>
