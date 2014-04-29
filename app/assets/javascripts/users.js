var ready_users = function() {
  if ($('.users').length > 0) {

    // FOR USER PROFILE SIDEBAR
    $('.sidebar-wrapper.profile-sidebar').on('click', 'h1', function() {
      moveTaggedToTop.apply(this);
    });
    
    $('.sidebar-wrapper.profile-sidebar').on('click', 'li', function() {
      moveTaggedToTop.apply(this);
    });    
    
    function moveTaggedToTop() {
      var $tag_id = $(this).data('tag-id');
      var tag_class_id = ".tag-id-" + $tag_id;
      $(tag_class_id).insertAfter('#top-id');      
    }

    // --------------------------------------------------------------------------------------------------------------
    // TOKENINPUT
    // --------------------------------------------------------------------------------------------------------------

    // ADD EDIT FIELD AFTER CLICKING ON EMPLOYER FIELD
    $('#employer').on('click', function() {
      var $user_id = $(this).data('id');
      var $url = "/users/" + $user_id + "/edit";

      $.ajax({
        type: 'GET',
        url: $url,
        success: function(data) {
          var $edit_data = $(data).filter(' .edit-business-card');
          $('h2#employer').addClass('hide');
          $('div.bcard-employer').append($edit_data);
          addAutocompleteFields();
        }
      });
    });
    
    $('#token-input-user_company_id').on('blur', function() {
      $('ul.token-input-list').remove();    
    });

    function addAutocompleteFields() {
      $('#user_company_id').tokenInput('/companies.json', { 
        crossDomain: false, 
        allowFreeTagging: true,
        hintText: 'Type company name',
        onReady: setUpBlurHandler,
      });
      $('#token-input-user_company_id').css('width', '125px');
    };
    
    function setUpBlurHandler() {
      setUpPropogator();
      $(document).click(function() {
        $('.edit-business-card > form').remove();
        $('h2#employer').removeClass('hide');
      });
    };    
    
    function setUpPropogator() {   
      $('form.edit_user > input[type="submit"]').click(function(e) {
        e.stopPropagation();
      });
      
      $('.token-input-input-token').click(function(e) {
        e.stopPropagation();
      });     
    };
        
  };
};

$(document).ready(ready_users);
$(document).on('page:load', ready_users);