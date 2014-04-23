var nav_ready;

nav_ready = function() {

  // NAVBAR OPACITY ON SCROLL
  $(window).scroll(function() {
    if ($(window).scrollTop() > 25) {
      $('nav.navbar-wrapper').css('background-color', 'rgba(255,255,255,1)')
    } 
  }) 

  $(window).scroll(function() {
    if ($(window).scrollTop() < 25) {
      $('nav.navbar-wrapper').css('background-color', 'rgba(255,255,255,.5)')
    } 
  }) 

};

$(document).ready(nav_ready);
$(document).on('page:load', nav_ready);