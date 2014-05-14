var ready_sessions = function() {
  if ($('.sessions').length > 0) {

  	setupSelectedHandler();

  	function setupSelectedHandler() {
	  	$('a.not-selected').on('click', function(e) {
	  		e.preventDefault();
	  		$('a.selected').toggleClass('selected').toggleClass('not-selected');
	  		$(this).removeClass('not-selected').addClass('selected');
	  		$('div.session-returning-user-form').toggleClass('hidden');
	  		$('div.session-new-user-form').toggleClass('hidden');
	  	});		
  	};

   };
};

$(document).ready(ready_sessions);
$(document).on('page:load', ready_sessions);
 	