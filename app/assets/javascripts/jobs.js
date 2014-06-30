var ready_jobs = function() {
  if ($('.jobs').length > 0) {

    setUpCompanyHandler();

    // --------------------------------------------------------------------------------------------------------------
    // JOB: ACTION ITEMS
    // --------------------------------------------------------------------------------------------------------------

    $('a.fa-external-link-square.unviewed').click(function(e) {
      toggleHiddenClass(this);
      createOrDestroyUserJobObject.apply(this);
    });

    $('a.fa-paw').click(function(e) {
      e.preventDefault();
      toggleHiddenClass(this);
      createOrDestroyUserJobObject.apply(this);
    });

    $('a.fa-bookmark').click(function(e) {
      e.preventDefault();
      toggleHiddenClass(this);
      createOrDestroyUserJobObject.apply(this);      
    });

    $('a.fa-times').click(function(e) {
      e.preventDefault();
      $(this).closest('li').remove();
      createOrDestroyUserJobObject.apply(this);
    })

    function toggleHiddenClass(thisObj) {
      $(thisObj).closest('span.action-span').children('span').toggleClass('hidden')
    };

    function createOrDestroyUserJobObject() {
      var $attr = $(this).data('attr')
      var $user_id = $(this).data('user-id');
      var $this_method = $(this).data('this-method');

      var $viewed_job_id = $(this).data('viewed-job-id');
      var $bookmarked_job_id = $(this).data('bookmarked-job-id');
      var $applied_via_wolfpack_job_id = $(this).data('applied-via-wolfpack-job-id');
      var $removed_job_id = $(this).data('removed-job-id')

      if ($viewed_job_id) {
        var $job_id = $viewed_job_id;
        var $attr = 'viewed_job_id';
      } else if ($bookmarked_job_id) {
        var $job_id = $bookmarked_job_id;
        var $attr = 'bookmarked_job_id';
      } else if ($applied_via_wolfpack_job_id) {
        var $job_id = $applied_via_wolfpack_job_id;
        var $attr = 'applied_via_wolfpack_job_id';
      } else if ($removed_job_id) {
        var $job_id = $removed_job_id;
        var $attr = 'removed_job_id';
      }

      var dataObject = {}
      dataObject['user_id'] = $user_id;
      dataObject[$attr] = $job_id ;

      $.ajax({
        url: 'user_jobs',
        method: $this_method,
        data: dataObject
      });    
    };

    // --------------------------------------------------------------------------------------------------------------
    // WOLPFACK APPLY POPUP
    // --------------------------------------------------------------------------------------------------------------    

    $('a.fa-paw.open-popup').on('click', function(e) {
      e.preventDefault();
      console.log('hello')
      var $job_id = $(this).data('applied-via-wolfpack-job-id');
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

    // $('#wolfpack-option').on('click', function(e) {
    //   e.preventDefault();
    //   $('li#wolfpack-option-popup').removeClass('hidden');
    //   addModalToBody();
    // });  

    // --------------------------------------------------------------------------------------------------------------
    // NEW JOB POST
    // --------------------------------------------------------------------------------------------------------------          

    $('#new-job-post').on('click', function(e) {
      e.preventDefault();
      $('.job-posts').prepend('<li id="new-job-li"></li>');
      var form_url = '/jobs/new';

      $('#new-job-li').load(form_url + ' .new-job-li', function() {
        setUpCompanyHandler();
      });
    });

    // --------------------------------------------------------------------------------------------------------------
    // TOKENINPUT
    // --------------------------------------------------------------------------------------------------------------

    // ADD EDIT FIELD AFTER CLICKING ON EMPLOYER FIELD
    function setUpCompanyHandler() {

      $('#change-company, #insert-company').on('click', function() {
        console.log('hello')
        var $job_id = $(this).data('id');
        var $url = "/jobs/" + $job_id + "/edit_company";
        var that = this;

        $.ajax({
          type: 'GET',
          url: $url,
          success: function(data) {
            var $edit_data = $(data).find(' .edit-business-card');
            $(that).children('span').addClass('hide');
            $(that).append($edit_data);
            addAutocompleteFields();
          }
        });
      });      
    };

    $('#token-input-job_company_id').on('blur', function() {
      $('ul.token-input-list').remove();    
    });

    function addAutocompleteFields() {
      $('#job_company_id').tokenInput('/companies.json', { 
        crossDomain: false, 
        allowFreeTagging: true,
        hintText: 'Type company name',
        onReady: setUpBlurHandler,
        propertyToSearch: 'name',
        tokenValue: 'id'
      });

      $('#token-input-job_company_id').css('width', '125px');
    };
    
    function setUpBlurHandler() {
      $('.token-input-delete-token').click()
      setUpPropogator();
      $(document).click(function() {
        $('.edit-business-card > form').remove();
        $('h2#change-company > span').removeClass('hide');
        $('h2#insert-company > span').removeClass('hide');
      });
    };    
    
    function setUpPropogator() {   
      $('form.edit_job > input[type="submit"]').click(function(e) {
        e.stopPropagation();
      });
      
      $('.token-input-input-token').click(function(e) {
        e.stopPropagation();
      });     
    };

    // --------------------------------------------------------------------------------------------------------------
    // INPAGE NAVBAR
    // --------------------------------------------------------------------------------------------------------------

      // ADD SELECTED CLASS TO JOB NAVBAR
    $('.job-actions-wrapper').on('click', '.fa-check, .fa-bookmark, .fa-times', function(e) {
      e.preventDefault();
      addModalToBody();
      $(this).addClass('selected');
      $('.job-actions-wrapper').css('z-index', '2');
      var $filter = $(this).data('filter');
      var $url = "/jobs/?" + "filter=" + $filter;
      
      $.ajax({
        type: 'GET',
        url: $url,
        success: function(data) {
          var $filtered_jobs = $(data).find(' .job-posts > li');
          console.log(data)
          var $new_kaminari = $(data).find(' .kaminari-wrapper');
          $('ul.job-posts').empty().html($filtered_jobs);
          $('.kaminari-wrapper').empty().html($new_kaminari);
          $('.job-posts > li').css('z-index', '2');
          $('.kaminari-wrapper').css('z-index', '2');
          $('.fa-times-circle').css('z-index', '2');
          $('.fa-times-circle').css('display', 'inline-block');
        }
      })
    }); 

    // --------------------------------------------------------------------------------------------------------------
    // EMAIL / FORWARD A JOB POST
    // --------------------------------------------------------------------------------------------------------------

    $('ul.job-posts').on('click', '.forward', function(event) {
      event.preventDefault();  
      $.ajaxSetup({ cache: false });
    
      var job_id = $(this).data('id');
      var form_url = '/jobs/' + job_id + '/forward_form';
      var div_append_id = '#div-append-' + job_id;

      $(div_append_id).load(form_url + ' .forward-form', function() {
        var $top = $(window).scrollTop() + 150 + 'px';
        $('.forward-form').css('top', $top);
        $('#email_info_email').focus();
        setUpBlurHandlers();
        addModalToBody();
      });   
    });

   

    function setUpPropagators() {
      $('.forward-form').children().click(function(e) {
        e.stopPropagation();
      });
    };

    function setUpBlurHandlers() {
      setUpPropagators();
      
      $('i.fa-times-circle').on('click', function() {
        undoModal();
      });
      
      $(document).click(function() {
        undoModal();
      });
    };
        
    function addModalToBody() {
      $('body').append('<div class="modal-background"></div>');      
    };       
    
    function undoModal() {
      $('.forward-form').hide();
      $('body').children('.modal-background').remove();
    };    
    
  };
};

$(document).ready(ready_jobs);
$(document).on('page:load', ready_jobs);



