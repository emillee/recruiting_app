var ready;

// --------------------------------------------------------------------------------------------------------------
// GROUPS SHOW
// --------------------------------------------------------------------------------------------------------------

ready = $('.groups.show').ready(function() {

  initializeEditor();
  
  $(document).on('mousemove', function(e) {
    $('#add_image_button').css({
      top: e.pageY
    })
  })

  function initializeEditor() {
    var editor = new Editor('.editable', { buttons: ['b', 'i', 'blockquote', 'h1', 'h2', 'h3', 'a', 'cancel']});
  };
  
});


// --------------------------------------------------------------------------------------------------------------
// JOBS INDEX
// --------------------------------------------------------------------------------------------------------------
ready = $('.jobs.index').ready(function() {
  
  // EMAIL / FORWARD A JOB POST
  $('ul.job-posts').on('click', '.forward', function(event) {
    
    event.preventDefault();
    $.ajaxSetup({ cache: false });
    
    $(this).closest('li').css('border-bottom', 'none');
    var job_id = $(this).data('id');
    var form_url = '/jobs/' + job_id + '/forward_form';
    var div_append_id = '#div-append-' + job_id;

    $(div_append_id).load(form_url + ' .forward-form', function() {
      $('#email_info_email').focus();
    })
  });
  
  // SAVING AND APPLYING TO JOBS
  $('ul.job-posts').on('click', '.save', function(event) {
    this.innerHTML = 'Interested';
    $(this).addClass('saved');
    $(this).removeClass('save');
  });
  
  $('ul.job-posts').on('click', '.applied', function(event) {
    $(this).addClass('applied_already');
    $(this).removeClass('applied');
    var user_id = $(this).data('user-id')
    var job_id = $(this).data('applied-job-id')
    var this_url = "/user_jobs" + "?" + "applied_job_id=" + job_id + "&" + "user_id=" + user_id
    
    $.ajax({
      type: 'POST',
      url: this_url
    });
  });
  
  // REMOVE A FILTER WHEN CLICKED
  $('ul.job-posts').on('click', '.remove', function(event) {
    $(this).parents('li').remove();
  });
  
});


// --------------------------------------------------------------------------------------------------------------
// COMPANIES INDEX
// --------------------------------------------------------------------------------------------------------------
ready = $('.companies.index').ready(function() {
    
  $('.best_in_place').best_in_place();
  
  $('.company-navbar').on('click', 'a', function() {
    event.preventDefault();
    var $company = $(this).data('company');
    var $section = $(this).data('section');
    $('.' + $section + '.' + $company).insertAfter('div#' + $company + '-top-id');
  });  

});


// --------------------------------------------------------------------------------------------------------------
// COMPANIES SHOW
// --------------------------------------------------------------------------------------------------------------
ready = $('.companies.show').ready(function() {  

  initializeEditor();
  
  $('#add_image_button').mouseover(function(e) {
    window.document.execCommand('insertImage', false, 'lksadjf');
  })
  
  function initializeEditor() {
    var editor = new Editor('.editable', { buttons: ['b', 'i', 'blockquote', 'h1', 'h2', 'h3', 'a', 'cancel']});
  };
  
  $('[contenteditable=true].title').blur(function() {
    event.preventDefault();

    var $title = $(this).html();
    var $company_id = $(this).parent('.content').data('id');
    var $article_id = $(this).parent('.content').data('articleid');
    var this_url = '/companies/' + $company_id + '/articles/' + $article_id;
    var dataObject = {};

    dataObject['article'] = {};
    dataObject['article']['title'] = $title;
    
    
    $.ajax({
      type: 'PUT',
      url: this_url,
      data: dataObject
    });  
  });

  $('[contenteditable=true].body').blur(function() {
    event.preventDefault();

    var $body = $(this).html();
    var $company_id = $(this).parent('.content').data('id');
    var $article_id = $(this).parent('.content').data('articleid');
    var this_url = '/companies/' + $company_id + '/articles/' + $article_id
    var dataObject = {}

    dataObject['article'] = {};
    dataObject['article']['body'] = $body;

    $.ajax({
      type: 'PUT',
      url: this_url,
      data: dataObject
    });
  });  

  // NOT IN USE
  $('[contenteditable=true].editable').blur(function() {
    event.preventDefault();
    var $id = $(this).data('id');
    var $table = $(this).data('table');
    var $model = $(this).data('model');
    var $attribute = $(this).data('attribute');
    var $newContent = $(this).html();
    var $url = '/' + $table + '/' + $id;
    var dataObject = {};

    dataObject[$model] = {};
    dataObject[$model][$attribute] = $newContent;

    $.ajax({
      type: 'PUT',
      url: $url,
      data: dataObject
    });  
  });
  
  $('.best_in_place').best_in_place();
  
  $('.company-navbar').on('click', 'a', function() {
    event.preventDefault();
    var $company = $(this).data('company');
    var $section = $(this).data('section');
    $('.' + $section + '.' + $company).insertAfter('div#' + $company + '-top-id');
  });
   
});


// --------------------------------------------------------------------------------------------------------------
// USERS SHOW
// --------------------------------------------------------------------------------------------------------------
ready = $('.users.show').ready(function() {
  addDraggableEvents();
  addDroppableEvents();
  
  // SUBMIT FORM FOR USER SKILL DEGREES ON CLICK
  $('.skills-ul').on('click', 'input[type="radio"]', function() {
    $(this).parents('form:first').submit();
  })
  
  // AFTER FORM SUBMISSION AJAX CALL
  $('.skills-ul').on('ajax:success', '.edit_user_skill', function(event, data) {
    var $skills = $(data).find(' .skills-ul');
    $('.skills-ul').empty().html($skills);
  })
  
  // ADD BOX OUTILNE WHEN IN EDIT MODE
  $('.article.skills').on('click', '#edit-skills', function() {
    event.preventDefault();
    $(this).addClass('hidden');
    $('#save-skills').removeClass('hidden');
    $('.box-of-logos').removeClass('hidden');
    $('.skill-dropzone').addClass('is-droppable');
    $('#add-skill').removeClass('hidden');
    addDroppableEvents();
  })
  
  // REMOVE OUTLINE BOX AFTER DONE WITH EDIT MODE
  $('.article.skills').on('click', '#save-skills', function() {
    event.preventDefault();
    $(this).addClass('hidden')
    $('#edit-skills').removeClass('hidden');
    $('.box-of-logos').addClass('hidden');
    $('.skill-dropzone').removeClass('is-droppable');
    $('#add-skill').addClass('hidden');
  })
  
  // SAVE CONTENT FOR EDIT IN PLACE
  $('[contenteditable=true]').blur(function() {
    event.preventDefault()
    var $id = $(this).data('id');
    var $table = $(this).data('table');
    var $model = $(this).data('model');
    var $attribute = $(this).data('attribute');
    var $newContent = $(this).html();
    var $url = '/' + $table + '/' + $id
    var dataObject = {};

    dataObject[$model] = {};
    dataObject[$model][$attribute] = $newContent;
    
    $.ajax({
      type: 'PUT',
      url: $url,
      data: dataObject
    });
  });
  
  // ADD DRAGABLE HANDLER
  function addDraggableEvents() {
    $('.is-draggable').draggable({
      'containment' : '.skills',
      'cursor'      : 'move'
    }); 
  };
  
  // ADD DROPPABLE HANDLER
  function addDroppableEvents() {
    $('.skill-dropzone.is-droppable').droppable({
      drop: createUserSkill
    });

    $('.box-of-logos.is-droppable').droppable({
      drop: destroyUserSkill
    });    
  }
  
  // POST TO USER_SKILL TABLE 
  function createUserSkill(event, ui) {
    var draggable = ui.draggable;
    var user_id = draggable.closest('li').data('user');
    var skill = draggable.closest('li').data('skill');
    var post_to_url = '/user_skills/?user_id=' + user_id + '&' + 'skill=' + skill
    
    $.ajax({
      type: 'POST',
      url: post_to_url,
      success: function(data) {
        draggable.remove();
        var $skills = $(data).find(' .skills-ul');
        $('ul.skills-ul').empty().html($skills);
        addDraggableEvents();
      }
    })
  };
  
  // REMOVE USER_SKILL
  function destroyUserSkill(event, ui) {
    var draggable = ui.draggable;
    var userskill_id = draggable.closest('li').data('userskill');
    var this_url = '/user_skills/' + userskill_id
        
    $.ajax({
      type: 'POST',
      data: {"_method":"delete"},
      url: this_url,
      success: function(data) {
        draggable.parent('li').remove();
        var $box_of_logos = $(data).find(' .box-of-logos-ul')
        $('ul.box-of-logos-ul').empty().html($box_of_logos);
        addDroppableEvents();
        addDraggableEvents();
      }
    })
  };      
  
});

$(document).ready(ready);
$(document).on('page:load', ready);







