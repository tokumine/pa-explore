// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
// 
// 

$(document).ready(function() {
		
		$('div.profile ul.options li a.menu').click(function(ev){
			ev.stopPropagation();
			ev.preventDefault();
			
			removeAllActive();
						
			$(this).parent().addClass('active');
			
		});
		
		$('div.buttons a#showRanking').click(function(ev){
			ev.stopPropagation();
			ev.preventDefault();
			
			$('div.rank ul li.user a.go_back').show();
			
			$("#right_container").animate(
						{ left: 300 }, 
						{ duration: 300,
					    specialEasing: 'easeOutElastic'
					}).animate(
								{ left: 218 }, 
								{ duration: 200,
							    specialEasing: 'easeOutBounce',
									complete: function() {
										
										//$('div.left_column ul li').css('background','url(../images/li_bkg_profile.png) repeat-y 0 0');
										//$('div.rank ul li').css('background','url(../images/li_bkg_profile.png) repeat-y 0 0');
										
										// $('div.rank ul li').each(function(index){
										// 	if ((!$(this).hasClass('user'))&&(!$(this).hasClass('message'))) {
										// 		$(this).addClass('shadow');				
										// 	}
										// });
										
									}
								});			
		});
		
		$('div.rank ul li.user a.go_back').click(function(ev){
			ev.stopPropagation();
			ev.preventDefault();
			
			$('div.rank ul li.user a.go_back').fadeOut();
			
			$("#right_container").animate(
							{ left: 300 }, 
							{ duration: 300,
						    specialEasing: 'easeOutElastic'
						}).animate(
									{ left: -2000 }, 
									{ duration: 200,
								    specialEasing: 'easeOutBounce',
										complete: function() {

										}
									});
					
			});
		
		
  });

function removeAllActive() {
		$('div.profile ul.options li').each(function(index){
			
			if ($(this).hasClass('active')) {
				$(this).removeClass('active');				
			}
		});
}




