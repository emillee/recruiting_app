var ready_groups = function() {    
  if ($('.groups').length > 0) {
  
    $(document).on('mousemove', function(e) {
      $('#add_image_button').css({
        top: e.pageY - 10
      });
    });

    $('#add_image_button').on('click', function() {
      var testDiv = document.getElementById('test');
      execCommandOnElement(testDiv, 'insertImage', 'red');
    });

  };
};
  
$(document).ready(ready_groups);
$(document).on('page:load', ready_groups);  




