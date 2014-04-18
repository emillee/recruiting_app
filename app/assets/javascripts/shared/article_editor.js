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
      } else if ($table == 'users') {
        var $id = $(this).parent('.content').data('user-id');
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
      } else if ($table == 'users') {
        var $id = $(this).parent('.content').data('user-id');
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

    $('[contenteditable=true].jobs-editable').blur(function(e) {
      e.preventDefault()
      var thisObj = this;
      persistContentEditable(thisObj)
    });
    
    $('[contenteditable=true].investors-editable').blur(function(e) {
      e.preventDefault()
      var thisObj = this;
      persistContentEditable(thisObj)
    });
    
    $('[contenteditable=true].users-editable').blur(function(e) {
      e.preventDefault()
      var thisObj = this;
      persistContentEditable(thisObj)
    });    
    
    function persistContentEditable(thisObj) {
      var $id = $(thisObj).data('id');
      var $table = $(thisObj).data('table');
      var $model = $(thisObj).data('model');
      var $attribute = $(thisObj).data('attribute');
      var $newContent = $(thisObj).html();
      var $url = '/' + $table + '/' + $id
      var dataObject = {};
    
      dataObject[$model] = {};
      dataObject[$model][$attribute] = $newContent;
    
      $.ajax({
        type: 'PUT',
        url: $url,
        data: dataObject
      });      
    }
    
    function initializeEditor() {
      var editor = new Editor('.editable', { buttons: ['b', 'i', 'blockquote', 'h1', 'h2', 'h3', 'a', 'cancel']});
    };    

  }
}

$(document).ready(ready_editor);
$(document).on('page:load', ready_editor);