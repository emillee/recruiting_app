var ready_jobs = function() {
  if ($('.jobs').length > 0) {

    setUpCompanyHandler();

    $('a.fa-paw').on('click', function(e) {
      e.preventDefault();
      var $job_id = $(this).data('job-id');
      console.log($job_id);
      var $url = '/jobs/' + $job_id + '/wolfpack_option';
      console.log($url);

      $.ajax({
        type: 'GET',
        url: $url,
        success: function(data) {
          console.log(data);
          var popup = $(data).find(' .wolfpack-option-popup');
          $('.main-content-wrapper').prepend(popup);
        }
      });      
    });


    $('#wolfpack-option').on('click', function(e) {
      e.preventDefault();
      $('li#wolfpack-option-popup').removeClass('hidden');
      addModalToBody();
      
    });    

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
    
    // EMAIL / FORWARD A JOB POST
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

    $('ul.job-posts').on('click', '.icon-clicked, .icon-unclicked', function(event) {
      $(this).toggleClass('icon-clicked');
      $(this).toggleClass('icon-unclicked');
    });    
 
    // SAVINGS, APPLYING, REMOVING JOBS
    $('ul.job-posts').on('click', '.save, .saved', function(event) {
      $(this).toggleClass('saved');
      $(this).toggleClass('save');
    });

    $('ul.job-posts').on('click', '.applied, .applied_already', function(event) {
      $(this).toggleClass('applied_already');
      $(this).toggleClass('applied');
    });  
  
    // REMOVE A JOB WHEN CLICK REMOVE
    $('ul.job-posts').on('click', '.remove, .removed', function(event) {
      $(this).parents('li').remove();
      $(this).toggleClass('removed');
      $(this).toggleClass('remove');
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



