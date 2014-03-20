var ready;

ready = $('.jobs.index').ready(function() {
  
  // FORWARDING
  $('ul.job-posts').on('click', '.forward', function(event) {
    console.log('hello')
    
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
    this.innerHTML = 'Saved';
    $(this).addClass('saved');
    $(this).removeClass('save');
  });

  $('ul.job-posts').on('click', '.view', function(event) {
    this.innerHTML = 'Viewed';
    $(this).addClass('viewed');
    $(this).removeClass('view');
    var user_id = $(this).data('user-id')
    var job_id = $(this).data('applied-job-id')
    var this_url = "/user_jobs" + "?" + "applied_job_id=" + job_id + "&" + "user_id=" + user_id
    
    $.ajax({
      type: 'POST',
      url: this_url
    });
  });
  
  $('ul.job-posts').on('click', '.remove', function(event) {
    $(this).parents('li').remove();
  });
  
});

ready = $('.companies.index').ready(function() {
    
  $('.best_in_place').best_in_place();

});

ready = $('.companies.show').ready(function() {
    
  $('.best_in_place').best_in_place();

});

ready = $('.users.show').ready(function() {
    
  addDraggableEvents();
  addDroppableEvents();
  
  $('.skills-ul').on('click', 'input[type="radio"]', function() {
    $(this).parents('form:first').submit();
  })

  $('.skills-ul').on('ajax:success', '.edit_user_skill', function(event, data) {
    var $skills = $(data).find(' .skills-ul');
    $('.skills-ul').empty().html($skills);
  })
  
  $('.article.skills').on('click', '#edit-skills', function() {
    event.preventDefault();
    $(this).addClass('hidden');
    $('#save-skills').removeClass('hidden');
    $('.box-of-logos').removeClass('hidden');
    $('.skill-dropzone').addClass('is-droppable');
    $('#add-skill').removeClass('hidden');
    addDroppableEvents();
  })
  
  $('.article.skills').on('click', '#save-skills', function() {
    event.preventDefault();
    $(this).addClass('hidden')
    $('#edit-skills').removeClass('hidden');
    $('.box-of-logos').addClass('hidden');
    $('.skill-dropzone').removeClass('is-droppable');
    $('#add-skill').addClass('hidden');
  })
  
  $('[contenteditable=true]').blur(function() {
    event.preventDefault()
    var $id = $(this).data('id');
    var $table = $(this).data('model');
    var $model = $table.slice(0, -1);
    var $attribute = $(this).data('attribute');
    var $newContent = $(this).html();
    var $url = '/' + $table + '/' + $id
    var dataObject = {}

    dataObject[$model] = {}
    dataObject[$model][$attribute] = $newContent
    
    $.ajax({
      type: 'PUT',
      url: $url,
      data: dataObject
    })
  })
  
  function addDraggableEvents() {
    $('.is-draggable').draggable({
      'containment' : '.skills',
      'cursor'      : 'move'
    }); 
  };
  
  function addDroppableEvents() {
    $('.skill-dropzone.is-droppable').droppable({
      drop: createUserSkill
    });

    $('.box-of-logos.is-droppable').droppable({
      drop: destroyUserSkill
    });    
  }
  
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

// // Show pagination on hover
// $('div.jobs-wrapper').on('mouseenter', function() {
//   $('.next > a').addClass('visibility-visible');
//   $('.prev > a').addClass('visibility-visible');
// })
// 
// $('div.jobs-wrapper').on('mouseleave', function() {
//   $('.next > a').removeClass('visibility-visible');
//   $('.prev > a').removeClass('visibility-visible');
// })





