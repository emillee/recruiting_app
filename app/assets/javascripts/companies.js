// ready = $('.companies.index').ready(function() {
// ready = $('.companies.show').ready(function() { 

ready_companies = function() {    
  if ($('.companies').length > 0 ) {

  // --------------------------------------------------------------------------------------------------------------
  // COMPANIES INDEX
  // --------------------------------------------------------------------------------------------------------------  
    $('.best_in_place').best_in_place();

    $('.company-navbar').on('click', 'a', function() {
      event.preventDefault();
      var $company = $(this).data('company');
      var $section = $(this).data('section');
      $('.' + $section + '.' + $company).insertAfter('div#' + $company + '-top-id');
    });  
  
    // --------------------------------------------------------------------------------------------------------------
    // COMPANIES SHOW
    // --------------------------------------------------------------------------------------------------------------
    initializeEditor();


    function initializeEditor() {
      var editor = new Editor('.editable', { buttons: ['b', 'i', 'blockquote', 'h1', 'h2', 'h3', 'a', 'cancel']});
    };

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

    // INPUT A PICTURE
    $('i.fa-picture-o').on('click', function() {
      $(this).parents('.uploader').find("input[type='file']").click();
      $(this).parents('.uploader').find("input[type='file']").change(function() {
        $(this).parents('form:first').submit();
      });    
    });

    // CONTENTEDITABLE FOR TITLE
    $('[contenteditable=true].title').blur(function() {
      event.preventDefault();

      var $title = $(this).html();
      var $company_id = $(this).parent('.content').data('company-id');
      var $article_id = $(this).parent('.content').data('articleid');
      var this_url = '/companies/' + $company_id + '/articles/' + $article_id;
      var dataObject = {};

      dataObject['article'] = {};
      dataObject['article']['title'] = $title;


      $.ajax({
        type: 'PUT',
        url: this_url,
        data: dataObject
      });  
    });

    // CONTENTEDITABLE FOR BODY
    $('[contenteditable=true].body').blur(function() {

      var $body = $(this).html();
      var $company_id = $(this).parent('.content').data('company-id');
      var $article_id = $(this).parent('.content').data('articleid');
      var this_url = '/companies/' + $company_id + '/articles/' + $article_id
      console.log(this_url)
      var dataObject = {}

      dataObject['article'] = {};
      dataObject['article']['body'] = $body;

      $.ajax({
        type: 'PUT',
        url: this_url,
        data: dataObject
      });
    
      event.preventDefault();
    });  
  
    // $('.best_in_place').best_in_place();
    // 
    // $('.company-navbar').on('click', 'a', function() {
    //   event.preventDefault();
    //   var $company = $(this).data('company');
    //   var $section = $(this).data('section');
    //   $('.' + $section + '.' + $company).insertAfter('div#' + $company + '-top-id');
    // });
  }
}
$(document).ready(ready_companies);
$(document).on('page:load', ready_companies);
