<%@page import="com.univ.utils.ContexteUtil"%>
<%@page import="com.kportal.core.config.MessageHelper"%>
</fieldset>
    <p class="validation">
		  <input class="reset" type="reset" value="<%=MessageHelper.getCoreMessage("ST_ENCADRE_RECHERCHER_EFFACER")%>" />
		  <input class="submit" type="submit" value="<%=MessageHelper.getCoreMessage("ST_ENCADRE_RECHERCHER_VALIDER")%>" />
    </p>
  </form>
</div> <!-- encadre_fiche <%=ContexteUtil.getContexteUniv().getDataAsString("encadreAutreClasse")%> -->
