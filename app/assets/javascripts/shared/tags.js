var ready_tags = function() {

  if ($('.articles').length > 0) {

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
      console.log('in add tag')
      var thisObj = this;
      setUpTokenInput(thisObj); 
    });    
    
    function setUpTokenInput(thisObj) {
      console.log('in token input');
      $(thisObj).tokenInput('/tags.json', { 
        crossDomain: false, 
        allowFreeTagging: true,
        propertyToSearch: 'tag_name', 
        // onAdd: submitTokenInputForm,
        // onReady: focusTokenInputCursor,
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

  };    
};    

$(document).ready(ready_tags);
$(document).on('page:load', ready_tags);  
