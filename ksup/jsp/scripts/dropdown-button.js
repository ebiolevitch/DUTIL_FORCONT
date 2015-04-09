(function($){
	
	/**
	 * Handles default menu behaviors.
	 */
	
	// Handle click and focusin events outside menus to close them
	$('html').click(function() {
		$.collapsableCommons.hideAll('.plier-deplier__contenu--relatif');
	});
	
	// Handle click and focusin events so it doesn't bubble to the html element
	$('.plier-deplier__contenu').click(function(e){
		e.stopPropagation();
	});
	$('.plier-deplier').focusin(function(e){
		e.stopPropagation();
	});
	
	// Triggers the opening of submenu
	$('.plier-deplier:not(.plier-deplier__contenu--relatif) .plier-deplier__bouton:not(#menu-principal-bouton)').click(function(e){
		e.preventDefault();
		e.stopPropagation();
		
		var $this = $(this),
			$content = $this.closest('.plier-deplier').find('.plier-deplier__contenu');
		
		if($content.is('.plier-deplier__contenu--clos')){
			$.collapsableCommons.hideAll();
			$content.removeClass('plier-deplier__contenu--clos').addClass('plier-deplier__contenu--ouvert');
			$this.attr('aria-expanded', true);
			// Focus le premier input d'un menu
			if($content.find('input').length > 0){
				$('input', $content).filter(':visible:first').focus();
			}
		}else{
			$.collapsableCommons.hideAll();
		}
	});
	
})(jQuery.noConflict());