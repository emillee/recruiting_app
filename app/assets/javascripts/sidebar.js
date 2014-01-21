var ready;

ready = function() {
 
  $('li.job-sidebar').on('click', function(e) {
    var $checkbox = $(this).find(":checkbox")[0];
    if(e.target != $checkbox) $checkbox.checked = !$checkbox.checked
    $(this).toggleClass("selected", $checkbox.checked);
  })

  $('.job-filters').on('click', function() {
    $(this).parents('form:first').submit();
  })

  $('#job-filter-form').on("ajax:success", function(event, data) {  
    var $jobs = $(data).find('.job-posts');
    $('.job-posts').empty().html($jobs)
  })
  
};

$(document).ready(ready);
$(document).on('page:load', ready);
