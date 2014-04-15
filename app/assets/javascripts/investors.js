ready_investors = function() {
  
  if ($('.investors').length > 0) {
    
  }
  
}

$(document).ready(ready_investors)
$(document).on('page:load', ready_investors)


// $('ul.job-posts').on('click', '.applied', function(event) {
//   $(this).addClass('applied_already');
//   $(this).removeClass('applied');
//   var user_id = $(this).data('user-id')
//   var job_id = $(this).data('applied-job-id')
//   var this_url = "/user_jobs" + "?" + "applied_job_id=" + job_id + "&" + "user_id=" + user_id
// 
//   $.ajax({
//     type: 'POST',
//     url: this_url
//   });
// });