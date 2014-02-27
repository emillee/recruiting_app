var ready;

ready = $('.jobs.index').ready(function() {
  
  $('.best_in_place').best_in_place();

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
  
  // FORWARDING
  $('ul.job-posts').on('click', '.forward', function(event) {
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
  $('ul.job-post').on('click', '.save', function(event) {
    event.preventDefault();
  });

  $('ul.job-posts').on('click', '.apply', function(event) {
    var user_id = $(this).data('user-id')
    var job_id = $(this).data('applied-job-id')
    var this_url = "/user_jobs" + "?" + "applied_job_id=" + job_id + "&" + "user_id=" + user_id
    
    $.ajax({
      type: "POST",
      url: this_url
    });
  });
  

});

$(document).ready(ready);
$(document).on('page:load', ready);


// Comment: this was for CSV file upload, not currently being used
// var wrapper = $('<div/>').css( 
//   { height: 0, width: 0, 'overflow': 'hidden' }
// );
// 
// var fileInput = $(':file').wrap(wrapper);
// 
// fileInput.change(function(){
//   $this = $(this);
//   $('#file').text($this.val());
// });
// 
// $('#file').click(function(){
//   fileInput.click();
// }).show();