var ready_companies = function() {    
  if ($('.companies').length > 0 ) {

    // --------------------------------------------------------------------------------------------------------------
    // WOLPFACK APPLY POPUP
    // --------------------------------------------------------------------------------------------------------------    

    $('div.open-popup').on('click', function(e) {
      e.preventDefault();
      var $job_id = $(this).find('.popup-option').data('applied-via-wolfpack-job-id');
      var $url = '/jobs/' + $job_id + '/wolfpack_option';

      console.log($url)

      $.ajax({
        type: 'GET',
        url: $url,
        success: function(data) {
          var popup = $(data).find(' .wolfpack-option-popup');
          addModalToBody();
          $('.main-content-wrapper').prepend(popup);
          var $top = $(window).scrollTop() + 50 + 'px';
          $('.wolfpack-option-popup').css('top', $top);
        }
      });      
    });    

    function addModalToBody() {
      $('body').append('<div class="modal-background"></div>');      
    };     
  
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
        preventDuplicates: true,
        tokenValue: property_to_search
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













