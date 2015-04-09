/**
 * Expose common functions for collapsable elements handling (.plier-deplier__contenu)
 */

(function($) {

	var callbacks = [];
	
	$.collapsableCommons = {  
		// Hide every opened menu
		hideAll : function (exceptions){
			var $ = jQuery,
				$opened = $('.plier-deplier__contenu--ouvert');
			
			// Filters exceptions
			if(typeof exceptions === 'string'){
				$opened = $opened.filter(':not(' + exceptions + ')');
			} else if(Object.prototype.toString.call( exceptions ) === '[object Array]'){
				$.each(exceptions, function(i, element){
					$opened = $opened.filter(':not(' + element + ')');
				});
			}
			
			// Handles states
			$opened.removeClass('plier-deplier__contenu--ouvert').addClass('plier-deplier__contenu--clos');
			$opened.closest('.plier-deplier').find('.plier-deplier__bouton').attr('aria-expanded', false);
			
			// triggers registered callbacks
			$.each(callbacks, function(index, callback){
				callback();
			});			
		},
		registerCallback : function (callback){
			if(callback && {}.toString.call(callback) === '[object Function]'){
				callbacks.push(callback);
			}
		}
	};

})(jQuery);