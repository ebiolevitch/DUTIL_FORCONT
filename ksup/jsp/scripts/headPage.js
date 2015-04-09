/*
 * Specific front-office scripts wich handles "actions" and "haut_pages" behaviours
 */

(function($){	
	var isHeadPageVisible = false,								// Is the header frame visible
		criticalPoint;									
	
	$(window).load(function() {
		var $haut_page = $('#haut_page');
		
		$(window).scroll(onWindowScroll);
		
		// Clear content in JS mode
		var $link = $('a', $haut_page).html('').detach();
		$haut_page.children().remove();
		$('<span class="icon icon-arrow-up3">').appendTo($link);	// TODO : autre icone ?
		$link.appendTo($haut_page);		
		
		// Specific values for initialization
		$haut_page.transition({y: "+=100", opacity: "0"}, function(){
			handleButton();
		});
	});	

	// Determine if "haut_page" should be visible according to the "window.scrollTop" value
	function handleButton(){
		var $window = $(window),
		$hautPage = $('#haut_page'),
		criticalPoint = $('#page').position().top;
	
		if($window.scrollTop() > criticalPoint){
			if(!isHeadPageVisible){
				$hautPage.transition({y: "-=100", opacity: "1"});
				isHeadPageVisible = true;
			}
		}
		
		if($window.scrollTop() > 0 && $window.scrollTop() < criticalPoint){
			if(isHeadPageVisible){
				$hautPage.transition({y: "+=100", opacity: "0"});
				isHeadPageVisible = false;
			}
		}
	}
	
	// Triggered when the window is scrolled
	function onWindowScroll(){
		handleButton();
	}
	
	// Triggered when 'haut_page' button is clicked
	$('#haut_page').click(function(){
		$(this).transition({y: "+=100", opacity: "0"});
		isHeadPageVisible = false;
	});
	
})(jQuery.noConflict());