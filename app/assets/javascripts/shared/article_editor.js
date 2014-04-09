ready_editor = function() {   

  if ( $('.companies').length > 0 || $('.investors').length > 0 )  {

    initializeEditor();

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

    function initializeEditor() {
      var editor = new Editor('.editable', { buttons: ['b', 'i', 'blockquote', 'h1', 'h2', 'h3', 'a', 'cancel']});
    };    

  }
}

$(document).ready(ready_editor);
$(document).on('page:load', ready_editor);