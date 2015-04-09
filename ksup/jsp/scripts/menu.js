(function($){

	var $menu = $('#menu'),
		$menuLinks = $('a, button', $menu),
		$menuButton = $('#menu-principal-bouton');
	
	// Specific cleaning
	$.collapsableCommons.registerCallback(function(){
		$('li', $menu).removeClass('menu_principal--ouvert');
	});
	
	// Triggered when a link in the menu is clicked
	$menuLinks.click(function(e){
		var $this = $(this),
			$parentLi = $this.closest('li'),
			$subMenu = $('.plier-deplier__contenu', $parentLi);
		if($subMenu.length > 0){
			e.preventDefault();
			e.stopPropagation();
			$.collapsableCommons.hideAll('.plier-deplier__contenu--relatif');
			$parentLi.addClass('menu_principal--ouvert');
			$subMenu.removeClass('plier-deplier__contenu--clos').addClass('plier-deplier__contenu--ouvert');
		}	
	});
	
	$menuButton.click(function(e){
		e.preventDefault();
		e.stopPropagation();
		var $this = $(this);
		if($menu.is('.plier-deplier__contenu--clos')){
			$menu.removeClass('plier-deplier__contenu--clos').addClass('plier-deplier__contenu--ouvert');
		} else {
			$menu.removeClass('plier-deplier__contenu--ouvert').addClass('plier-deplier__contenu--clos');
		}
	});
	
	// Handle click and focusin events outside menus to close them
	$('html').click(function() {
		if($menu.is('.plier-deplier__contenu--ouvert')){
			$menu.removeClass('plier-deplier__contenu--ouvert').addClass('plier-deplier__contenu--clos');
		}
	});
	
})(jQuery.noConflict());