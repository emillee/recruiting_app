var ready_landing_page = function() {
  if ($('.welcome_to_wolfpack').length > 0) {

  	var sectionTwoPosition = $('#section-2').offset().top - 44;

  	$('#tell-me-more').click(function(e) {
  		e.preventDefault();
  		console.log('a')
  		
  		$('html, body').animate({scrollTop: sectionTwoPosition}, 'slow');
  		
  		return false;
  	});

  }
}

$(document).ready(ready_landing_page);
$(document).on('page:load', ready_landing_page);
