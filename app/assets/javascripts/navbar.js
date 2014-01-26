$(document).ready(function() {
  
  $('.coming-soon').delay(1000).fadeOut();
  
  $('.coming-soon-icon').on('click', function() {
    $('.coming-soon').fadeIn().delay(1000).fadeOut();
  })

})