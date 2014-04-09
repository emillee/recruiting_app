// --------------------------------------------------------------------------------------------------------------
// JOBS INDEX
// --------------------------------------------------------------------------------------------------------------

// ready_jobs = $('.jobs.index').ready(function() {
ready_jobs = function() {
  if ($('.jobs').length > 0) {
  
    // EMAIL / FORWARD A JOB POST
    $('ul.job-posts').on('click', '.forward', function(event) {
      $.ajaxSetup({ cache: false });
    
      $(this).closest('li').css('border-bottom', 'none');
      var job_id = $(this).data('id');
      var form_url = '/jobs/' + job_id + '/forward_form';
      var div_append_id = '#div-append-' + job_id;

      $(div_append_id).load(form_url + ' .forward-form', function() {
        $('#email_info_email').focus();
      })
      console.log('in forward click')
      event.preventDefault();     
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
  
  };
}

$(document).ready(ready_jobs);
$(document).on('page:load', ready_jobs);

