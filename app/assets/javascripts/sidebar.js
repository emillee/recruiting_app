var ready;

ready = function() {
  
  // SEARCH FORM
  $('#sidebar-search-button').click(function() {
    $(this).parents('form:first').submit();
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
  
  $('.sidebar-middle').on('click', 'h1.department', function() {
    var $ul = $(this).closest('.wrapper').children('ul');
    var $checkbox_lis = $ul.children('li');
    var $checkboxes = $checkbox_lis.find(":checkbox");
    
    $checkboxes.each(function() {
      if (this.checked === false) {
        $(this).parent('li').toggleClass('hidden');
      }
    })
    
    $('.department .fa-minus-circle').toggleClass('hidden');
    $('.department .fa-plus-square-o').toggleClass('hidden');
  });
  
  $('.sidebar-middle').on('click', 'h1.sub_dept', function() {
    console.log('hello')
    var $ul = $(this).closest('.wrapper').children('ul');
    var $checkbox_lis = $ul.children('li');
    var $checkboxes = $checkbox_lis.find(":checkbox");
    
    $checkboxes.each(function() {
      if (this.checked === false) {
        $(this).parent('li').toggleClass('hidden');
      }
    })
    
    $('.sub_dept .fa-minus-circle').toggleClass('hidden');
    $('.sub_dept .fa-plus-square-o').toggleClass('hidden');
  });
  
  $('.sidebar-middle').on('click', 'h1.experience', function() {
    var $ul = $(this).closest('.wrapper').children('ul');
    var $checkbox_lis = $ul.children('li');
    var $checkboxes = $checkbox_lis.find(":checkbox");
    
    $checkboxes.each(function() {
      if (this.checked === false) {
        $(this).parent('li').toggleClass('hidden');
      }
    })
    
    $('.experience .fa-minus-circle').toggleClass('hidden');
    $('.experience .fa-plus-square-o').toggleClass('hidden');
  });
 
  $('.sidebar-middle').on('click', 'li.job-sidebar', function(e) {
    var $checkbox = $(this).find(":checkbox")[0];
    if (e.target != $checkbox) $checkbox.checked = !$checkbox.checked
    $(this).toggleClass("selected", $checkbox.checked);
    $(this).closest('.fa-check').toggleClass('hidden');
  });

  $('.sidebar-middle').on('click', '.job-filters', function() {
    $(this).parents('form:first').submit();
  });

  $('#job-filter-form').on("ajax:success", function(event, data) {  
    var $jobs = $(data).find('.job-posts');
    var $sidebar = $(data).find('.sidebar-middle');
    $('.job-posts').empty().html($jobs);
    $('.sidebar-middle').empty().html($sidebar);
  });
  
  $('#clear-all').click(function() {
    $('.keywords-li').click();
    $('.job-sidebar').find(':checkbox').prop('checked', false);
    $('.job-sidebar').removeClass('selected');
    $('.job-filters').parents('form:first').submit();
  });
  
  $('.keywords-ul').on('click', 'li', function() {
    $(this).remove();
    
    if ($('.keywords-li').length === 0) {
      $('.keywords-wrapper').addClass('hidden');
    };
  });
  
};

$(document).ready(ready);
$(document).on('page:load', ready);









