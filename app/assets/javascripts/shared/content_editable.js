var ready_editor = function() {   

  if ( $('.companies').length > 0 || $('.investors').length > 0 || $('.users').length > 0 || $('.jobs').length > 0 || $('.articles').length > 0 ) {

    // to fix -- initializing editor interferes with handle article blur
    // initializeEditor();

    // CONTENTEDITABLE FOR TITLE
    $('[contenteditable=true].title').blur(function() {
      handleArticleBlur.apply(this, ['title']);
    });
    
    $('[contenteditable=true].body').blur(function() {
      handleArticleBlur.apply(this, ['body']);
    });

    $('[contenteditable=true].link').blur(function() {
      handleArticleBlur.apply(this, ['link']);
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

    $('[contenteditable=true].articles-editable').blur(function(e) {
      persistContentEditable.apply(this);
    });    
        
    function handleArticleBlur(selector) {
      var $content = $(this).html();
      var $table = $(this).parent('.article-wrapper').data('table');
      var $article_id = $(this).parent('.article-wrapper').data('article-id');
      
      var this_url = '/articles/' + $article_id;
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