var ready_articles = function() {
  
  if ($('.articles').length > 0) {
  	
  	$('#new-link-a').on('click', function(e) {
  		e.preventDefault();
  		$('ul.links').prepend('<li id="new-link-li"></li>');
  		var form_url = '/articles/new';

  		$('#new-link-li').load(form_url + ' .new-job-li', function() {

  		});
  	});

  };
};

$(document).ready(ready_articles);
$(document).on('page:load', ready_articles);  


