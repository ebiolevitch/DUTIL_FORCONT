(function($){
	
	// Backward compatibility
	var $oldVideos = $('div[flv_url]');
	$oldVideos.each(function(index){
		var $this = $(this),
			$divMedia = $('<div>').addClass('media'),
			$video = $('<video>');

		var loop = $this.attr('flv_loop') && $this.attr('flv_loop') != 0;
		if(loop) $video.attr('loop', '');
		$video.attr({
			'id' : $this.attr('iddivplayer'),
			'style' : $this.attr('style'),
			'poster' : $this.attr('flv_imgurl'),
			'width' : $this.attr('flv_width'),
			'height' : $this.attr('flv_height'),
			'controls' : ''
		});
		
		$('<source>').attr({'src' : $this.attr('flv_url'), 'type' : 'video/flv'}).appendTo($video);
		
		var $flashObject = $('<object>').attr({
			'width': $this.attr('flv_width'), 
			'height': $this.attr('flv_height'),
			'type': 'application/x-shockwave-flash',
			'data': window.location.origin + '/adminsite/scripts/libs/mediaElement/flashmediaelement.swf'
		});
		$('<param>').attr({'name' : 'movie', 'value' : window.location.origin + '/adminsite/scripts/libs/mediaElement/flashmediaelement.swf'}).appendTo($flashObject);
		$('<param>').attr({'name' : 'flashvars', 'value' : 'controls=true&amp;file=' + $this.attr('flv_url')}).appendTo($flashObject);
		$('<param>').attr({'name' : 'allowFullScreen', 'value' : 'true'}).appendTo($flashObject);
		$flashObject.appendTo($video);
		$video.appendTo($divMedia);
		$this.replaceWith($divMedia);
	});
	
	var $oldAudios = $('span[kaudio_span]');
	$oldAudios.each(function(index){
		var $this = $(this),
			$divMedia = $('<div>').addClass('media'),
			$audio = $('<audio>');

		var loop = $this.attr('_kaudio_autoreplay') && $this.attr('_kaudio_autoreplay') != 0;
		if(loop) $audio.attr('loop', '');
		$audio.attr({
			'id' : $this.find('div').attr('id'),
			'controls' : ''
		});
		
		$('<source>').attr({'src' : $this.attr('_kaudio_url'), 'type' : 'audio/mpeg'}).appendTo($audio);
		$audio.appendTo($divMedia);
		$this.replaceWith($divMedia);
	});
	
	// Media tags handling	
	if(!$('html').is('.ie8')){ // Classic fallback
		$('video, audio').mediaelementplayer({
		    // remove or reorder to change plugin priority
		    plugins: ['flash','silverlight'],
		    pauseOtherPlayers: true,
		    pluginPath : window.location.origin + '/adminsite/scripts/libs/mediaElement/'
		});
	}else{
		// For backward compatibility purpose : may be removed in future release
		$('audio').mediaelementplayer({
		    // remove or reorder to change plugin priority
		    plugins: ['flash','silverlight'],
		    pauseOtherPlayers: true,
		    pluginPath : window.location.origin + '/adminsite/scripts/libs/mediaElement/'
		});
	}
	
})(jQuery.noConflict());
