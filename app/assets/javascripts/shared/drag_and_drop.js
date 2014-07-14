var ready_drag_and_drop = function() {   

  if ( $('.companies').length > 0 || $('.users').length > 0 ) { 

    addDraggableEvents();
    addDroppableEvents();

    // SHOW AND HIDE DIFF SKILL SETS BASED ON DEPT
    $('span.dept-selector').on('click', function() {
      var selected_dept = $(this).data('dept');
      console.log(selected_dept);
      var selector = 'a' + '.' + selected_dept;
      console.log(selector);
      $('.group > a').addClass('hidden');
      $(selector).removeClass('hidden');
    });      

    // SHOW AND HIDE DIFF SKILL SETS BASED ON SUB DEPT
    $('.box-of-logos-ul').on('click', 'a', function(e) {
      e.preventDefault();
      var selected_skill = $(this).data('selected');
      var selector = '.box-of-logos-ul > li' + '.' + selected_skill;
      $('.box-of-logos-ul > li').addClass('hidden');
      $(selector).removeClass('hidden');
    });    

    // ADD BOX OUTILNE WHEN IN EDIT MODE
    $('h1').on('click', '#edit-skills', function() {
      event.preventDefault();
      toggleBoxOfLogos();
      addDroppableEvents();
    });

    // REMOVE OUTLINE BOX AFTER DONE WITH EDIT MODE
    $('h1').on('click', '#save-skills', function(event) {
      event.preventDefault();
      toggleBoxOfLogos();
    });
    
    // SUBMIT FORM FOR USER SKILL DEGREES ON CLICK
    $('.skills-ul').on('click', 'input[type="radio"]', function() {
      $(this).parents('form:first').submit();
    });

    // AFTER FORM SUBMISSION AJAX CALL
    $('.skills-ul').on('ajax:success', '.edit_object_skill', function(event, data) {
      var $skills = $(data).find(' .skills-ul');
      $('.skills-ul').empty().html($skills);
    });

    // SHOW BOX OF LOGOS
    function toggleBoxOfLogos() {
      $('.box-of-logos').toggleClass('hidden');
      $('.skills-ul').toggleClass('is-droppable');
      $('#edit-skills').toggleClass('hidden');      
      $('#save-skills').toggleClass('hidden');
      $('#add-skill').toggleClass('hidden');
      $('span.add-skill').toggleClass('hidden');
    };     

    // ADD DRAGABLE HANDLER
    function addDraggableEvents() {
      $('.is-draggable').draggable({
        'containment' : '.skills',
        'cursor'      : 'move'
      }); 
    };

    // ADD DROPPABLE HANDLER
    function addDroppableEvents() {
      $('.skills-ul.is-droppable').droppable({
        drop: createObjectSkill
      });

      $('.box-of-logos.is-droppable').droppable({
        drop: destroyObjectSkill
      });    
    };

    // POST TO OBJECT_SKILL TABLE 
    function createObjectSkill(event, ui) {
      var draggable = ui.draggable;
      var object_id = draggable.closest('li').data('object-id');
      var object_class = draggable.closest('li').data('object-class');
      var object_class_id_url = object_class + "_id=";
      var skill_id = draggable.closest('li').data('skill-id');
      var post_to_url = '/object_skills/?' + object_class_id_url + object_id + '&' + 'skill_id=' + skill_id;
      var ul_identifier = ' .skills-ul' + "." + object_class + "-" + object_id;

      $.ajax({
        type: 'POST',
        url: post_to_url,
        success: function(data) {
          draggable.remove();
          var $skills = $(data).find(ul_identifier);
          $('ul.skills-ul').empty().html($skills);
          $('.skills-ul').children('#add-skill').toggleClass('hidden');
          addDraggableEvents();
        }
      });
    };

    // REMOVE OBJECT_SKILL
    function destroyObjectSkill(event, ui) {
      var draggable = ui.draggable;
      var object_skill_id = draggable.closest('li').data('object-skill-id');
      var this_url = '/object_skills/' + object_skill_id

      $.ajax({
        type: 'POST',
        data: {"_method":"delete"},
        url: this_url,
        success: function(data) {
          draggable.remove();
          var $box_of_logos = $(data).find(' .box-of-logos-ul');
          $('ul.box-of-logos-ul').empty().html($box_of_logos);
          addDroppableEvents();
          addDraggableEvents();
        }
      });
    };

  };
};

$(document).ready(ready_drag_and_drop);
$(document).on('page:load', ready_drag_and_drop);

