var nav_ready = function() {

  $('.fa-cog').click(function() {
    $(this).addClass('selected');
    $('ul.nav-cog-options').removeClass('hidden');
  });

  // NAVBAR OPACITY ON SCROLL
  $(window).scroll(function() {
    if ($(window).scrollTop() > 25) {
      $('nav.navbar-wrapper').css('background-color', 'rgba(255,255,255,1)');
    };
  });

  $(window).scroll(function() {
    if ($(window).scrollTop() < 25) {
      $('nav.navbar-wrapper').css('background-color', 'rgba(255,255,255,.5)');
    };
  });

  $('.fa-pencil-square-o, #contact-us-link').on('click', function() {
    event.preventDefault();
    $.ajaxSetup({ cache: false });

    var form_url = '/contact_us'
    $('<div id="contact-us"></div>').insertAfter('.navbar-wrapper');
    
    $('#contact-us').load(form_url + ' .forward-form', function() {
      var $top = $(window).scrollTop() + 250 + 'px';
      $('#contact-us').css('position', 'absolute');
      $('#contact-us').css('left', '250px');
      $('.forward-form').css('top', $top);
      $('#email_info_sender_email').focus();
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

$(document).ready(nav_ready);
$(document).on('page:load', nav_ready);