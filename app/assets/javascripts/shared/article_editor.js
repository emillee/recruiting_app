ready_editor = function() {   

  if ( $('.companies').length > 0 || $('.investors').length > 0 || $('.users').length > 0 ) {

    initializeEditor();

    // CONTENTEDITABLE FOR TITLE
    $('[contenteditable=true].title').blur(function() {
      event.preventDefault();

      var $title = $(this).html();
      var $table = $(this).parent('.content').data('table');
      var $article_id = $(this).parent('.content').data('articleid');
      
      if ($table === 'companies') {
        var $id = $(this).parent('.content').data('company-id');
      } else if ($table === 'investors') {
        var $id = $(this).parent('.content').data('investor-id');
      }
      
      var this_url = '/' + $table + '/' + $id + '/articles/' + $article_id;
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
      var $table = $(this).parent('.content').data('table');
      var $article_id = $(this).parent('.content').data('articleid');
      

      if ($table === 'companies') {
        var $id = $(this).parent('.content').data('company-id');
      } else if ($table === 'investors') {
        var $id = $(this).parent('.content').data('investor-id');
      }
      
      var this_url = '/' + $table + '/' + $id + '/articles/' + $article_id;


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
    
    // THIS IS ONLY FOR USERS
    $('[contenteditable=true].users').blur(function() {
      event.preventDefault()
      var $id = $(this).data('id');
      var $table = $(this).data('table');
      var $model = $(this).data('model');
      var $attribute = $(this).data('attribute');
      var $newContent = $(this).html();
      var $url = '/' + $table + '/' + $id
      var dataObject = {};

      dataObject[$model] = {};
      dataObject[$model][$attribute] = $newContent;

      $.ajax({
        type: 'PUT',
        url: $url,
        data: dataObject
      });
    });    

    function initializeEditor() {
      var editor = new Editor('.editable', { buttons: ['b', 'i', 'blockquote', 'h1', 'h2', 'h3', 'a', 'cancel']});
    };    

  }
}

$(document).ready(ready_editor);
$(document).on('page:load', ready_editor);