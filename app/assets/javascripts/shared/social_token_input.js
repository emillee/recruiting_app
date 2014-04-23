ready_social = function() {   

  if ( $('.companies').length > 0 || $('.investors').length > 0 || $('.users').length > 0 ) {

    makeWidgetsInvisble();
    setUpTagDeleteHandler();
    
    // UPDATE TAG LIST ON AJAX SUCCESS
    $('form.new_tagging').on('ajax:success', function(event, data) {
      var $article_id = $(this).data('article-id');
      var $ul_selector = ".article-tags-" + $article_id;
      var $newData = $(data).find($ul_selector);

      $('.existing-tags').removeClass('hidden');      
      $($ul_selector).empty().html($newData);
      setUpTagDeleteHandler();
    });
    
    // IMPLEMENT TOKENINPUT ON CLICK
    $('.add-tag').click(function() {
      var thisObj = this;
      setUpTokenInput(thisObj); 
    });    
    
    function setUpTokenInput(thisObj) {
      $(thisObj).tokenInput('/tags.json', { 
        crossDomain: false, 
        allowFreeTagging: true,
        propertyToSearch: 'tag_name', 
        onAdd: submitTokenInputForm,
        onReady: focusTokenInputCursor,
        preventDuplicates: true } 
      );      
    };

    // GET HELP FROM BACKNOL ON THIS
    function setUpTagDeleteHandler() {
      $('.existing-tag-li').click(function(event) {
        event.preventDefault();
        $tagging_id = $(this).data('id');
        $(this).remove();

        $.ajax({
          url: '/taggings/' + $tagging_id,
          type: 'DELETE'
        });
      });   
    };
    
    function focusTokenInputCursor() {
      $('#token-input-tagging_tag_id').on('focus', function() {
        setUpBlurHandler()
      });    
      $('#token-input-tagging_tag_id').focus();
    };
    
    function submitTokenInputForm() {
      $('form#new_tagging').submit();
      $('#token-input-tagging_tag_id').blur();
      $('#tagging_tag_id').click();
    };
    
    function setUpBlurHandler() {
      $('#token-input-tagging_tag_id').on('blur', function(event, data) {
        $('ul.token-input-list').remove();
        $('input#tagging_tag_id').show();
        $('input#tagging_tag_id').val('');
      });      
    };
    
    $('.fa-linkedin-square').on('click', function() {
      var $widget = $(this).closest('.content').children('.IN-widget');
      $widget.children('span').children('span').click();
    });

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
    });

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
    	};
    }; 

  };
};

$(document).ready(ready_social);
$(document).on('page:load', ready_social);