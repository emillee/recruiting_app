var ready;

ready = function() {
  
  $('h1.department').on('click', function() {
    var $ul = $(this).closest('.dept-wrapper').children('ul');
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
  
  $('h1.sub_dept').on('click', function() {
    var $ul = $(this).closest('.dept-wrapper').children('ul');
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
  
  $('h1.experience').on('click', function() {
    var $ul = $(this).closest('.dept-wrapper').children('ul');
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
 
  $('li.job-sidebar').on('click', function(e) {
    var $checkbox = $(this).find(":checkbox")[0];
    if (e.target != $checkbox) $checkbox.checked = !$checkbox.checked
    $(this).toggleClass("selected", $checkbox.checked);
    $(this).closest('.fa-check').toggleClass('hidden');
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









