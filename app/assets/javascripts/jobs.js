var ready_jobs = function() {
  if ($('.jobs').length > 0) {
  
    // ADD SELECTED CLASS TO JOB NAVBAR
    $('.job-nav-item').on('click', function(e) {
      e.preventDefault();
      addModalToBody();
      $(this).addClass('selected');
      $(this).css('z-index', '2');
      var $filter = $(this).data('filter');
      var $url = "/jobs/?" + "filter=" + $filter;
      
      $.ajax({
        type: 'GET',
        url: $url,
        success: function(data) {
          var $filtered_jobs = $(data).find(' .job-posts > li');
          var $new_kaminari = $(data).find(' .kaminari-wrapper');
          $('ul.job-posts').empty().html($filtered_jobs);
          $('.kaminari-wrapper').empty().html($new_kaminari);
          $('.job-posts > li').css('z-index', '2');
          $('.kaminari-wrapper').css('z-index', '2');
          $('.job-nav.fa-times-circle').css('z-index', '2');
          $('.job-nav.fa-times-circle').show();
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
    
    function setUpBlurHandlers() {
      setUpPropagators();
      
      $('i.fa-times-circle').on('click', function() {
        undoModal();
      });
      
      $(document).click(function() {
        undoModal();
      });
    };
    
    function setUpPropagators() {
      $('.forward-form').children().click(function(e) {
        e.stopPropagation();
      });
    };
    
    function undoModal() {
      $('.forward-form').hide();
      $('body').children('.modal-background').remove();
    };
    
    function addModalToBody() {
      $('body').append('<div class="modal-background"></div>');      
    };    
  
    // SAVINGS, APPLYING, REMOVING JOBS
    $('ul.job-posts').on('click', '.save, .saved', function(event) {
      // this.innerHTML = 'Interested';
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
    
  };
};

$(document).ready(ready_jobs);
$(document).on('page:load', ready_jobs);



