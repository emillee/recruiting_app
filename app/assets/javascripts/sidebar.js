var ready = function() {
  
  // TOGGLE ROLES and REQS
  $('.roles').click(function() {
    toggleSidebarTriangle.apply(this, ['.prefs', '.prefs-sidebar-wrapper', '.roles-sidebar-wrapper']);
  });

  $('.prefs').click(function() {
    toggleSidebarTriangle.apply(this, ['.roles', '.roles-sidebar-wrapper', '.prefs-sidebar-wrapper']);
  });
  
  function toggleSidebarTriangle(selector, wrapSelector, wrapSelectorTwo) {
    $(this).addClass('selected');
    $(this).children('.arrow-down').removeClass('hidden');
    $(selector).removeClass('selected')
    $(selector).children('.arrow-down').addClass('hidden')
    $(wrapSelector).addClass('hidden');
    $(wrapSelectorTwo).removeClass('hidden');    
  };
  
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
  
  $('.bucket-input').keyup(function(event) {
    if (event.keyCode == 13) {
      $(this).parents('form:first').submit();
    };
  });
  
  $('.bucket-input').blur(function(event) {
    $(this).parents('form:first').submit();
  });
  
  // TOGGLE H1 IN SIDEBAR
  $('.sidebar-middle').on('click', 'h1', function() {
    var thisObject = this;
    toggleDropDown(thisObject);
  });
  
  // THIS DOESNT WORK, NEED TO ACCOMODATE INPUT ITEM
  $('.sidebar-middle').on('click', 'h1.salary', function() {
    var thisObject = this;
    toggleDropDown(thisObject);
  });  
  
  // CLICK CHECKBOX - CLICK CHECKBOX, SHOW ICON
  $('.sidebar-middle').on('click', 'li.job-sidebar', function(e) {
    var $checkbox = $(this).find(":checkbox")[0];
    if (e.target != $checkbox) $checkbox.checked = !$checkbox.checked
    $(this).toggleClass("selected", $checkbox.checked);
  });

  // SUBMIT FORM ON CLICK
  $('.sidebar-middle').on('click', '.job-sidebar', function() {
    $(this).parents('form:first').submit();
    $('#sidebar-search').val('');
  });

  // AJAX CALL TO REFRESH SIDEBAR AND JOBS ON SUCCESS
  $('#roles-job-filter-form').on("ajax:success", function(event, data) {  
    var $jobs = $(data).find('.job-posts');
    var $sidebar = $(data).find('#roles-job-filter-form .sidebar-middle');
    var $kaminari = $(data).find('.pagination');
    $('.job-posts').empty().html($jobs);
    $('.kaminari-wrapper').empty().html($kaminari);
    $('#roles-job-filter-form .sidebar-middle').empty().html($sidebar);
  });

  $('#pref-job-filter-form').on("ajax:success", function(event, data) {  
    var $jobs = $(data).find('.job-posts');
    var $sidebar = $(data).find('#pref-job-filter-form .sidebar-middle');
    var $kaminari = $(data).find('.pagination');
    $('.job-posts').empty().html($jobs);
    $('.kaminari-wrapper').empty().html($kaminari);
    $('#pref-job-filter-form .sidebar-middle').empty().html($sidebar);
  });  
  
  // REMOVE ALL FILTERS
  $('#clear-all-roles').click(function() {
    $('.keywords-li').click();
    $('.roles-sidebar-wrapper .job-sidebar').find(':checkbox').prop('checked', false);
    $('.roles-sidebar-wrapper .job-sidebar').removeClass('selected');
    $('#roles-job-filter-form').submit();
  });

  $('#clear-all-prefs').click(function() {
    $('.prefs-sidebar-wrapper .job-sidebar').find(':checkbox').prop('checked', false);
    $('.prefs-sidebar-wrapper .job-sidebar').removeClass('selected');
    $('#pref-job-filter-form').submit();
  });

  var toggleDropDown = function(thisObject) {
    var $ul = $(thisObject).closest('.wrapper').children('ul');
    var $checkbox_lis = $ul.children('li');
    var $checkboxes = $checkbox_lis.find(":checkbox");

    $checkboxes.each(function() {
      if (this.checked === false) {
        $(this).parent('li').toggleClass('hidden');
      };
    });

    $(thisObject).children('.fa-caret-down').toggleClass('hidden');
    $(thisObject).children('.fa-caret-right').toggleClass('hidden');    
  };

};

$(document).ready(ready);
$(document).on('page:load', ready);









