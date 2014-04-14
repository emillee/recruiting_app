var ready;

ready = function() {

  // TOGGLE ROLES and REQS
  $('.roles').click(function() {
    $(this).addClass('selected');
    $('.prefs').removeClass('selected')
    $('.prefs').children('.arrow-down').addClass('hidden')
    $(this).children('.arrow-down').removeClass('hidden');

    $('.roles-sidebar-wrapper').removeClass('hidden');
    $('.prefs-sidebar-wrapper').addClass('hidden');
  })

  $('.prefs').click(function() {
    $(this).addClass('selected');
    $('.roles').removeClass('selected')
    $('.roles').children('.arrow-down').addClass('hidden')
    $(this).children('.arrow-down').removeClass('hidden');
    
    $('.roles-sidebar-wrapper').addClass('hidden');
    $('.prefs-sidebar-wrapper').removeClass('hidden');
  })
  
  // NAVBAR OPACITY ON SCROLL
  $(window).scroll(function() {
    if ($(window).scrollTop() > 25) {
      $('nav.navbar-wrapper').css('background-color', 'rgba(255,255,255,1)')
    } 
  }) 

  $(window).scroll(function() {
    if ($(window).scrollTop() < 25) {
      $('nav.navbar-wrapper').css('background-color', 'rgba(255,255,255,.5)')
    } 
  })  
  
  // SEARCH: GET RID OF KEYWORD BANNER IF NO KEYWORDS
  $('.keywords-ul').on('click', 'li', function() {
    if ($('.keywords-li').length === 0) {
      $('.keywords-wrapper').addClass('hidden');
    };
  });  
  
  // SEARCH FORM - SUBMIT ON CLICK
  $('i.fa-search').click(function() {
    $(this).parents('form:first').submit();
    $('#sidebar-search').val('');
  });

  // SEARCH FORM - SUBMIT ON ENTER
  $('#sidebar-search').keyup(function(event) {
    if (event.keyCode == 13) {
      $(this).parents('form:first').submit();

      if ($('.keywords-li').length > 0) {
        $('.keywords-ul').prepend('<li class="selected keywords-li job-sidebar"><i class="fa fa-check-circle"></i>' + 
          $('#sidebar-search')[0].value + "</li>")
          $('#sidebar-search').val('');
      } else {
        $('.keywords-wrapper').removeClass('hidden');
        $('.keywords-ul').append('<li class="selected keywords-li job-sidebar"><i class="fa fa-check-circle"></i>' + 
          $('#sidebar-search')[0].value + "</li>")
          $('#sidebar-search').val('');
      };
    };
  });
  
  // DEPARTMENT FILTER - EXPAND / COLLAPSE
  $('.sidebar-middle').on('click', 'h1.department', function() {
    var $ul = $(this).closest('.wrapper').children('ul');
    var $checkbox_lis = $ul.children('li');
    var $checkboxes = $checkbox_lis.find(":checkbox");
    
    $checkboxes.each(function() {
      if (this.checked === false) {
        $(this).parent('li').toggleClass('hidden');
      }
    })
    
    $('.department .fa-caret-down').toggleClass('hidden');
    $('.department .fa-caret-right').toggleClass('hidden');
  });
  
  // SUB DEPT FILTER - EXPAND / COLLAPSE
  $('.sidebar-middle').on('click', 'h1.sub_dept', function() {
    var $ul = $(this).closest('.wrapper').children('ul');
    var $checkbox_lis = $ul.children('li');
    var $checkboxes = $checkbox_lis.find(":checkbox");
    
    $checkboxes.each(function() {
      if (this.checked === false) {
        $(this).parent('li').toggleClass('hidden');
      }
    })
    
    $('.sub_dept .fa-caret-down').toggleClass('hidden');
    $('.sub_dept .fa-caret-right').toggleClass('hidden');
  });
  
  // EXPERIENCE FILTER - EXPAND / COLLAPSE
  $('.sidebar-middle').on('click', 'h1.experience', function() {
    var $ul = $(this).closest('.wrapper').children('ul');
    var $checkbox_lis = $ul.children('li');
    var $checkboxes = $checkbox_lis.find(":checkbox");
    
    $checkboxes.each(function() {
      if (this.checked === false) {
        $(this).parent('li').toggleClass('hidden');
      }
    })
    
    $(this).find('.fa-caret-down').toggleClass('hidden');
    $(this).find('.fa-caret-right').toggleClass('hidden');
  });
  
  // KEY SKILLS FILTER - EXPAND / COLLAPSE
  $('.sidebar-middle').on('click', 'h1.key-skills', function() {
    var $ul = $(this).closest('.wrapper').children('ul');
    var $wrapper = $ul.children('div.key-skills-wrapper');
    $wrapper.toggleClass('hidden')
    
    $('.key-skills .fa-caret-down').toggleClass('hidden');
    $('.key-skills .fa-caret-right').toggleClass('hidden');
  });
  
  // CLICK CHECKBOX - CLICK CHECKBOX, SHOW ICON
  $('.sidebar-middle').on('click', 'li.job-sidebar', function(e) {
    var $checkbox = $(this).find(":checkbox")[0];
    if (e.target != $checkbox) $checkbox.checked = !$checkbox.checked
    $(this).toggleClass("selected", $checkbox.checked);
  });

  // CLICK CHECKBOX FOR DEGREES
  $('.sidebar-middle').on('click', 'li.degree', function(e) {
   var $checkbox = $(this).find(":checkbox")[0];
   if (e.target != $checkbox) $checkbox.checked = !$checkbox.checked
   $(this).toggleClass("selected", $checkbox.checked);
   $(this).closest('.fa-check').toggleClass('hidden');
 });

  // SUBMIT FORM ON CLICK
  $('.sidebar-middle').on('click', '.job-sidebar', function() {
    $(this).parents('form:first').submit();
    $('#sidebar-search').val('');
  });

  // AJAX CALL TO REFRESH SIDEBAR AND JOBS ON SUCCESS
  $('#job-filter-form').on("ajax:success", function(event, data) {  
    var $jobs = $(data).find('.job-posts');
    var $sidebar = $(data).find('.sidebar-middle');
    var $kaminari = $(data).find('.pagination');
    $('.job-posts').empty().html($jobs);
    $('.sidebar-middle').empty().html($sidebar);
    $('.pagination').empty().html($kaminari);
  });
  
  // REMOVE ALL FILTERS
  $('#clear-all').click(function() {
    $('.keywords-li').click();
    $('.job-sidebar').find(':checkbox').prop('checked', false);
    $('.job-sidebar').removeClass('selected');
    $('.job-filters').parents('form:first').submit();
  });
  
};

$(document).ready(ready);
$(document).on('page:load', ready);









