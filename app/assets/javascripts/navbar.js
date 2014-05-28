var nav_ready = function() {

  setUpNavDropdown();

  function setUpNavDropdown() {
    $('.fa-cog, .navbar-guest-a').click(function(e) {
      e.preventDefault();
      e.stopPropagation();
      showNavDropDown();        
    });
  };

  function showNavDropDown() {
    $('.fa-cog').addClass('selected');
    $('ul.nav-cog-options').removeClass('hidden');
    setUpNavBlur();
  };

  function setUpNavBlur() {
    setUpPropagators('ul.nav-cog-options');

    $(document).click(function() {
      $('ul.nav-cog-options').addClass('hidden');
      $('.fa-cog').removeClass('selected');
      $(document).off('click', setUpNavBlur);
      setUpNavBlur();
    });
  };

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

  $('.nav-contact-us').on('click', function() {
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
      setUpBlurHandler.apply(this, ['i.fa-times-circle', '.forward-form']);
      addModalToBody();
    });
  });

  function setUpBlurHandler(xIcon, propagatorSelector) {
    setUpPropagators(propagatorSelector);
    
    $(xIcon).on('click', function() {
      undoModalRemoveItem(propagatorSelector);
    });
    
    $(document).click(function() {
      undoModalRemoveItem(propagatorSelector);
    });
  };

  function setUpPropagators(propagatorSelector) {
    $(propagatorSelector).children().click(function(e) {
      e.stopPropagation();
    });
  };
      
  function addModalToBody() {
    $('body').append('<div class="modal-background"></div>');      
  };       
  
  function undoModalRemoveItem(propagatorSelector) {
    $(propagatorSelector).hide();
    $('body').children('.modal-background').remove();
  };

};

$(document).ready(nav_ready);
$(document).on('page:load', nav_ready);