var ready_companies = function() {    
  if ($('.companies').length > 0 ) {
  
    // --------------------------------------------------------------------------------------------------------------
    // COMPANIES SHOW
    // --------------------------------------------------------------------------------------------------------------
    $('.company-navbar').on('click', 'a', function() {
      event.preventDefault();
      var $company = $(this).data('company');
      var $section = $(this).data('section');
      $('.' + $section + '.' + $company).insertAfter('div#' + $company + '-top-id');
    });

    // --------------------------------------------------------------------------------------------------------------
    // TOKEN INPUT
    // --------------------------------------------------------------------------------------------------------------
    $('#skill_skill_name').click(function() {
      setUpTokenInput.apply(this, ['/skills/name.json', 'skill_name']);
    });

    $('#skill_skill_dept').click(function() {
      setUpTokenInput.apply(this, ['/skills/dept.json', 'skill_dept']);
    });

    $('#skill_skill_sub_dept').click(function() {
      setUpTokenInput.apply(this, ['/skills/sub_dept.json', 'skill_sub_dept']);
    });    

    function setUpTokenInput(url_path, property_to_search, input_selector) {
      $(this).tokenInput(url_path, {
        crossDomain: false,
        allowFreeTagging: true,
        propertyToSearch: property_to_search,
        onReady: focusTokenInputCursor(),
        preventDuplicates: true
      });
    };

    // this isn't working
    function focusTokenInputCursor() {
      $('#token-input-skill_skill_name').focus();  
    };
    
  };
};

$(document).ready(ready_companies);
$(document).on('page:load', ready_companies);













