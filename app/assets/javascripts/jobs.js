var ready;

ready = $('.jobs.index').ready(function() {
  
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
    console.log('hello')
    
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
  $('ul.job-posts').on('click', '.save', function(event) {
    this.innerHTML = 'Saved';
    $(this).addClass('saved');
    $(this).removeClass('save');
  });

  $('ul.job-posts').on('click', '.view', function(event) {
    this.innerHTML = 'Viewed';
    $(this).addClass('viewed');
    $(this).removeClass('view');
    var user_id = $(this).data('user-id')
    var job_id = $(this).data('applied-job-id')
    var this_url = "/user_jobs" + "?" + "applied_job_id=" + job_id + "&" + "user_id=" + user_id
    
    $.ajax({
      type: "POST",
      url: this_url
    });
  });
  
});

ready = $('.companies.index').ready(function() {
    
  $('.best_in_place').best_in_place();

});

ready = $('.companies.show').ready(function() {
    
  $('.best_in_place').best_in_place();

});

ready = $('.users.show').ready(function() {
    
  $('.is-draggable').draggable({
    'containment' : '.skills',
    'cursor'      : 'move'
  });
  
  $('.is-droppable').droppable({
    drop: handleDropEvent
  });
  
  function handleDropEvent(event, ui) {
    alert('dropped')
  };

});


$(document).ready(ready);
$(document).on('page:load', ready);
