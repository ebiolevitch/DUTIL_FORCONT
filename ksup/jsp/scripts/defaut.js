
/* Affichage d'une image dans une popup */
function afficheImage(source) {
	// Ouverture du pop-up
	window.open(source,'pop','status=no,directories=no,toolbar=no,location=no,menubar=no,scrollbars=yes,resizable=yes');
}

/* Fonction utilisée dans la recherche avancée pour réinitialiser les formulaires */
function viderFormulaire(criteres) {
	criteres = criteres.split(";");
	var champReinit = "";
	var valeurChamp = "";
	
	for (var i=0; i < (criteres.length); i++) {
		champReinit = eval("document.forms['recherche_avancee']." + criteres[i].substring(0, criteres[i].indexOf("=")));
		valeurChamp = criteres[i].substring(criteres[i].indexOf("=")+1);
		
		if (champReinit) {
			
			var sType = champReinit.type;
			//bouton radio
			if (!sType) {
				for (var i = 0; i < champReinit.length; i++)
					champReinit[i].checked = false;
			} 
			//checkbox
			else if(sType == 'checkbox')
				champReinit.checked = false;
			//autres
			else
			champReinit.value = valeurChamp;
		}
	}
}


/* Fonction permettant d'intervertir l'id d'un élément avec un autre */
function switchId(ancienIdItem, nouvelIdItem) {
	var itemSwitch = window.document.getElementById(ancienIdItem);
	
	if (itemSwitch != null) {
		itemSwitch.id = nouvelIdItem;
	}
}
