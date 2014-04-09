// ready = $('.groups.show').ready(function() {
ready_groups = function() {    
  if ($('.groups').length > 0) {
    // initializeEditor();
  
    $(document).on('mousemove', function(e) {
      $('#add_image_button').css({
        top: e.pageY - 10
      });
    });

    $('#add_image_button').on('click', function() {
      var testDiv = document.getElementById('test');
      execCommandOnElement(testDiv, 'insertImage', 'red');
    });

    // function initializeEditor() {
    //   var editor = new Editor('.editable', { buttons: ['b', 'i', 'blockquote', 'h1', 'h2', 'h3', 'a', 'cancel']});
    // };
    // 
    // function execCommandOnElement(el, commandName, value) {
    //   if (typeof value == 'undefined') {
    //     value = null;
    //   }
    // 
    //   if (typeof window.getSelection != 'undefined') {
    //     // Non IE
    //     var sel = window.getSelection();
    //   
    //     // Save the current selection
    //     var savedRanges = [];
    //     for (var i=0, len = sel.rangeCount; i < len; i++) {
    //       savedRanges[i] = sel.getRangeAt(i).cloneRange();
    //     }
    //   
    //     // Temporarily enable designMode so that 
    //     // document.execCommand will work
    //     document.designMode = 'on';
    //   
    //     // Select the element's content
    //     sel = window.getSelection();
    //     var range = document.createRange();
    //     range.selectNodeContents(el);
    //     sel.removeAllRanges();
    //     sel.addRange(range);
    //   
    //     // Execute the command
    //     document.execCommand(commandName, false, value);
    //   
    //     // Disable designMode
    //     document.designMode = 'off';
    //   
    //     // Restore the previous selection
    //     sel = window.getSelection();
    //     sel.removeAllRanges();
    //     for (var i=0, len=savedRanges.length; i < len; i++) {
    //       sel.addRange(savedRanges[i]);
    //     } 
    //   } else if (typeof document.body.createTextRange != 'undefined' ){
    //     // IE Case
    //     var textRange = document.body.createTextRange();
    //     textRange.moveToElementText(el);
    //     textRange.execCOmmand(commandName, false, value);
    //   }
    // }
  }
}
  
$(document).ready(ready_groups);
$(document).on('page:load', ready_groups);  




