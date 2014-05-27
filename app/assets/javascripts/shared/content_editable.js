var ready_editor = function() {   

  if ( $('.companies').length > 0 || $('.investors').length > 0 || $('.users').length > 0 ) {

    initializeEditor();

    // CONTENTEDITABLE FOR TITLE
    $('[contenteditable=true].title').blur(function() {
      handleArticleBlur.apply(this, ['title']);
    });
    
    $('[contenteditable=true].body').blur(function() {
      handleArticleBlur.apply(this, ['body']);
    });
    
    $('[contenteditable=true].jobs-editable').blur(function(e) {
      persistContentEditable.apply(this);
    });
    
    $('[contenteditable=true].investors-editable').blur(function(e) {
      persistContentEditable.apply(this);
    });
    
    $('[contenteditable=true].users-editable').blur(function(e) {
      persistContentEditable.apply(this);
    });

    $('[contenteditable=true].companies-editable').blur(function(e) {
      persistContentEditable.apply(this);
    });    
        
    function handleArticleBlur(selector) {
      console.log('aaa');
      var $content = $(this).html();
      var $table = $(this).parent('.article-wrapper').data('table');
      var $article_id = $(this).parent('.article-wrapper').data('article-id');
      
      if ($table === 'companies') {
        var $id = $(this).parent('.article-wrapper').data('company-id');
      } else if ($table === 'investors') {
        var $id = $(this).parent('.article-wrapper').data('investor-id');
      } else if ($table === 'users') {
        var $id = $(this).parent('.article-wrapper').data('user-id');
      }
      
      var this_url = '/' + $table + '/' + $id + '/articles/' + $article_id;
      var dataObject = {};

      dataObject['article'] = {};
      dataObject['article'][selector] = $content;

      $.ajax({
        type: 'PUT',
        url: this_url,
        data: dataObject
      });      
    };  
    
    function persistContentEditable() {
      console.log('bbb');
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
    };
    
    function initializeEditor() {
      var editor = new Editor('.editable', { buttons: ['b', 'i', 'blockquote', 'h1', 'h2', 'h3', 'a', 'cancel']});
    };    

  };
};

$(document).ready(ready_editor);
$(document).on('page:load', ready_editor);