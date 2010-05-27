var isMoving = false;

$(document).ready(function() {

		var isiPad = navigator.userAgent.match(/iPad/i) != null;

		if (window.orientation == 90 || window.orientation==-90) {
			changeSizeByOrientation(true);
		} else {
			changeSizeByOrientation(false);
		}
	
		window.onorientationchange = function() {
			if (window.orientation == 90 || window.orientation==-90) {
				changeSizeByOrientation(true);
			} else {
				changeSizeByOrientation(false);
			}
		}

		$('a.ranking').bind('touchstart',function(ev){
			$(this).css('background-position','0 -51px');
		});

		$('a.ranking').bind('touchend touchmove touchcancel',function(ev){
			$(this).css('background-position','0 0');
		});
		
		$('a.profile').bind('touchstart',function(ev){
			$(this).css('background-position','0 -51px');
		});

		$('a.profile').bind('touchend touchmove touchcancel',function(ev){
			$(this).css('background-position','0 0');
		});
		
		$('a.gotomap').bind('touchstart',function(ev){
			$(this).css('background-position','0 -51px');
		});

		$('a.gotomap').bind('touchend touchmove touchcancel',function(ev){
			$(this).css('background-position','0 0');
		});
		
		
		$('div.header ul li').bind('touchmove',function(ev){
			isMoving = true;
		});
		
		$('div.header ul li').bind('touchend',function(ev){
			if (!$(this).hasClass('selected') && !isMoving) {
				removePreviousSelected();
				$(this).addClass('selected');
			} else {
				isMoving = false;
			}
		});
		
   
	});



	function showProfile() {
		$('li.you div.bottom a').fadeOut(200,function(ev){
			$('a.gotomap').fadeIn(300);
		});
		
		$("#slider").animate(
			{ left: 300 }, 
			{ duration: 300,
		    specialEasing: 'easeOutElastic'
		}).animate(
					{ left: 218 }, 
					{ duration: 200,
				    specialEasing: 'easeOutBounce',
						complete: function() {
							$('div.left_column ul li').css('background','url(../images/li_bkg_profile.png) repeat-y 0 0');
						}
					});
	}
	
	
	
	function hideProfile() {
		$('li.you div.bottom a.gotomap').fadeOut(200,function(ev){
			$('a.ranking').fadeIn(200);
			$('a.profile').fadeIn(200);
		});
		
		$('div.left_column ul li').css('background','#232323');
		
		$("#slider").animate(
			{ left: 300 }, 
			{ duration: 300,
		    specialEasing: 'easeOutElastic'
		}).animate(
					{ left: -588 }, 
					{ duration: 200,
				    specialEasing: 'easeOutBounce',
						complete: function() {

						}
			 });
	}
	
	
	function removePreviousSelected() {
		$('div.header ul li').each( function(index){
			$(this).removeClass('selected');
		});
	}
	

	
	function changeSizeByOrientation(landscape) {
		if (landscape) {
			$('ul#main_list').css('height','596px');
			$('div.profile').css('width','805px');
			$('div.profile').css('height','690px');
			$('div#map_canvas').css('width','806px');
			$('div#map_canvas').css('height','690px');
			$('div.feed_container').css('width','755px');
			$('div.feed_container').css('height','576px');
		} else {
			$('ul#main_list').css('height','852px');
			$('div.profile').css('width','549px');
			$('div.profile').css('height','946px');
			$('div#map_canvas').css('width','550px');
			$('div#map_canvas').css('height','946px');
			$('div.feed_container').css('width','498px');
			$('div.feed_container').css('height','831px');
		}
	}
	
	
	
 
	
	
	
	

	