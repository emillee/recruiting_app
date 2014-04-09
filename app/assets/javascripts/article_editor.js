ready_editor = function() {   

  if ( ($('.companies').length > 0) || ($('.users').length > 0) )  {
    makeWidgetsInvisble();
    
    function makeWidgetsInvisble() {
    	window.onload = function() {
    		$('.IN-widget').addClass('visibility-hidden');
    		$('i.fa-facebook-square a').addClass('hidden');
    	}
    }    
  }
  
}

$(document).ready(ready_editor);
$(document).on('page:load', ready_editor);