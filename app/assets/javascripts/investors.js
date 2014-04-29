var ready_investors = function() {
  if ($('.investors').length > 0) {

	  // FOR INVESTORS PROFILE SIDEBAR
	  $('.sidebar-wrapper.user_profile').on('click', 'h1', function() {
	    var $tag_id = $(this).data('tag-id');
	    var tag_class_id = ".tag-id-" + $tag_id;
	    $(tag_class_id).insertAfter('#top-id');
	  });

  };
};

$(document).ready(ready_investors);
$(document).on('page:load', ready_investors);


