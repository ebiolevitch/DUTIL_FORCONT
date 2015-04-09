(function($){
	
	var $items_tab = $('.onglets .onglets__item'),
		$buttons = $('.onglets-section .onglets-section__bouton'),
		$contentPanels = $('.onglets-section');
	
	$items_tab.click(function(e){
		e.preventDefault();
		e.stopImmediatePropagation();		
		clearActives();
		setActives($(this));
	});
	
	$buttons.click(function(e){
		e.preventDefault();
		e.stopImmediatePropagation();
		clearActives();
		setActives($(this));		
		$('html, body').animate({ scrollTop : $('#' + $(this).closest('.onglets-section').attr('id')).offset().top}, 0);
	});
	
	function clearActives(){
		$items_tab.removeClass('onglets__item--actif');
		$buttons.removeClass('onglets-section__bouton--actif');
		$contentPanels.removeClass('onglets-section--actif');
	}
	
	function setActives($element){
		var $contentPanel, $item;
		if($element.attr('data-tab')){ // Tab case
			$contentPanel = $('#' + $element.attr('data-tab'));
			$item = $('.onglets__item', $contentPanel);
			$contentPanel.addClass('onglets-section--actif');
			$element.addClass('onglets__item--actif');
			$item.addClass('onglets-section__bouton--actif');
		}else{ // Button case
			$contentPanel = $element.closest('.onglets-section');
			$item = $('.onglets .onglets__item[data-tab="' + $contentPanel.attr('id') + '"]'); 
			$contentPanel.addClass('onglets-section--actif');
			$element.addClass('onglets-section__bouton--actif');
			$item.addClass('onglets__item--actif');
		}
	}
    
})(jQuery.noConflict());