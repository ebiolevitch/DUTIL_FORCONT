(function($){
	// Delegate .transition() calls to .animate()
	// if the browser can't do CSS transitions.
	if (!$.support.transition) $.fn.transition = $.fn.animate;
	
	/**
	 * Locale de la page courante
	 */
	var locale = $('html').attr('lang');
	
	/**
	 * Initialisation des champs de type date
	 */
	$('.type_date').datepicker($.datepicker.regional[locale]);
 
	/**
	 * Les rubriques externes doivent s'ouvrir dans des nouvelles
	 */
	$('.type_rubrique_0004').click(function() {
        window.open(this.href);
        return false;
    });
})(jQuery.noConflict());