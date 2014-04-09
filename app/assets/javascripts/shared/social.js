ready_social = function() {   

  if ( $('.companies').length > 0 || $('.investors').length > 0 )  {

    makeWidgetsInvisble();


    $('.fa-linkedin-square').on('click', function() {
      var $widget = $(this).closest('.content').children('.IN-widget');
      $widget.children('span').children('span').click();
    })

    $('.fa-facebook-square').on('click', function() {
      var fb_link = $(this).find('a');
      var width  = 575,
          height = 400,
          left   = ($(window).width()  - width)  / 2,
          top    = ($(window).height() - height) / 2,
          url    = this.href,
          opts   = 'status=1' +
                   ',width='  + width  +
                   ',height=' + height +
                   ',top='    + top    +
                   ',left='   + left;


     window.open(fb_link.attr('href'), null, opts);

     return false;
    })

    // TWEET
    $('.popup').click(function(event) {
      var width  = 575,
          height = 400,
          left   = ($(window).width()  - width)  / 2,
          top    = ($(window).height() - height) / 2,
          url    = this.href,
          opts   = 'status=1' +
                   ',width='  + width  +
                   ',height=' + height +
                   ',top='    + top    +
                   ',left='   + left;

      window.open(url, 'twitter', opts);

      return false;
    });  

          
    function makeWidgetsInvisble() {
    	window.onload = function() {
    		$('.IN-widget').addClass('visibility-hidden');
    		$('i.fa-facebook-square a').addClass('hidden');
    	}
    }    
  }
  
}

$(document).ready(ready_social);
$(document).on('page:load', ready_social);