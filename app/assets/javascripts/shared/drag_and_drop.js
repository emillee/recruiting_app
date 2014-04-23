ready_drag_and_drop = function() {   

  if ( $('.companies').length > 0 || $('.users').length > 0 ) { 

    addDraggableEvents();
    addDroppableEvents();
    
    // REMOVE OUTLINE BOX AFTER DONE WITH EDIT MODE
    $('.article.skills').on('click', '#save-skills', function() {
      event.preventDefault();
      $(this).addClass('hidden')
      $('#edit-skills').removeClass('hidden');
      $('.box-of-logos').addClass('hidden');
      $('.skill-dropzone').removeClass('is-droppable');
      $('#add-skill').addClass('hidden');
    })
    
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
    }   

  };
};

$(document).ready(ready_drag_and_drop);
$(document).on('page:load', ready_drag_and_drop);

