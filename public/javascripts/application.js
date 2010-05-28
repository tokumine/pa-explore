

$(document).ready(function() {
	$('#map_canvas').css('height',window.innerHeight+'px');
	$('#map_canvas').css('width',window.innerWidth-220+'px');
	window.onresize = function() {
		$('#map_canvas').css('height',window.innerHeight+'px');
		$('#map_canvas').css('width',window.innerWidth-220+'px');
	}
	

	$.ajax({
	   type: "GET",
	   url: "users/rank",
	   success: function(result) {	

				console.log(result);
				for (var i=0; i<result.length; i++) {
					if (!result[i].current_user) {
						var li_html = '<li class="other_user"><div class="image"><img src="'+result[i].avatar+'" alt="'+result[i].username+'"/></div><div class="data"><p class="username">'+result[i].username+'<sup>(1th)</sup></p><p class="amount">'+result[i].meters_explored+'m<small>('+result[i].meters_different+'m)</small></p></div></li>';
						$('div.rank ul').append(li_html);
					} else {
						var li_html = 'asdf';
						$('div.rank ul').append(li_html);
					}
				}
	   }
	 });
		
		
		$('div.profile ul.options li a.menu').click(function(ev){
			ev.stopPropagation();
			ev.preventDefault();
			
			removeAllActive();
						
			$(this).parent().addClass('active');
						
			if ($(this).attr("id") == 'your_feed') {
				$('div.information div.feed').show();
				$('div.information div.badges').hide();
				$('div.information div.account_settings').hide();				
			} else if ($(this).attr("id") == 'your_badges') {
				$('div.information div.feed').hide();
				$('div.information div.badges').show();
				$('div.information div.account_settings').hide();	
			}else if ($(this).attr("id") == 'account_settings') {
				$('div.information div.feed').hide();
				$('div.information div.badges').hide();
				$('div.information div.account_settings').show();
			}
		});
		
		
		
		$('div.buttons a#showRanking').click(function(ev){
			ev.stopPropagation();
			ev.preventDefault();
			
			var widthRightContainer = $('div#right_container').width();

			$('div#right_container').css('left',-widthRightContainer);
			$('div#right_container').show();
			
			$('div.rank ul li.user a.go_back').show();
			
			$("#right_container").animate(
						{ left: 300 }, 
						{ duration: 300,
					    specialEasing: 'easeOutElastic'
					}).animate(
								{ left: 220 }, 
								{ duration: 200,
							    specialEasing: 'easeOutBounce',
									complete: function() {
										$('div.rank ul li.other_user').css('background','url(../images/li_bkg_profile.png) repeat-y 0 0');										
									}
								});			
		});
		
		$('div.rank ul li.user a.go_back').click(function(ev){
			ev.stopPropagation();
			ev.preventDefault();
			
			var widthRightContainer = $('div#right_container').width();
			
			$('div.rank ul li.user a.go_back').fadeOut();
			
			$("#right_container").animate(
							{ left: 300 }, 
							{ duration: 300,
						    specialEasing: 'easeOutElastic'
						}).animate(
									{ left: -widthRightContainer }, 
									{ duration: 200,
								    specialEasing: 'easeOutBounce',
										complete: function() {

										}
									});
			
				$('div#right_container').fadeOut();
				$('div.rank ul li.other_user').css('background','none');										
			});
			
		
		
  });

function removeAllActive() {
		$('div.profile ul.options li').each(function(index){
			
			if ($(this).hasClass('active')) {
				$(this).removeClass('active');				
			}
		});
}




