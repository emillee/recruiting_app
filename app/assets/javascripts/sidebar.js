var ready;

ready = function() {
 
  $('li.job-sidebar').on('click', function(e) {
    var $checkbox = $(this).find(":checkbox")[0];
    if (e.target != $checkbox) $checkbox.checked = !$checkbox.checked
    $(this).toggleClass("selected", $checkbox.checked);
  });

  $('.job-filters').on('click', function() {
    $(this).parents('form:first').submit();
  });

  $('#job-filter-form').on("ajax:success", function(event, data) {  
    var $jobs = $(data).find('.job-posts');
    $('.job-posts').empty().html($jobs)
  });
  
  $('#clear-all').click(function() {
    $('.keywords-li').click();
    $('.job-sidebar').find(':checkbox').prop('checked', false);
    $('.job-sidebar').removeClass('selected');
    $('.job-filters').parents('form:first').submit();
  });
  
  $('#sidebar-search').keyup(function(event) {
    if (event.keyCode == 13) {
      $(this).parents('form:first').submit();

      if ($('.keywords-li').length > 0) {
        $('.keywords-ul').prepend('<li class="selected keywords-li job-sidebar"><i class="fa fa-check-circle"></i>' + 
          $('#sidebar-search')[0].value + "</li>")
      } else {
        $('.keywords-wrapper').removeClass('hidden');
        $('.keywords-ul').append('<li class="selected keywords-li job-sidebar"><i class="fa fa-check-circle"></i>' + 
          $('#sidebar-search')[0].value + "</li>")
      };
    };
    
  });
  
  $('.keywords-ul').on('click', 'li', function() {
    $(this).remove();
    
    if ($('.keywords-li').length === 0) {
      $('.keywords-wrapper').addClass('hidden');
    };
  });
  
  $('#sidebar-search-button').click(function() {
    $(this).parents('form:first').submit();
  });
  
};

$(document).ready(ready);
$(document).on('page:load', ready);









