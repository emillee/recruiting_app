$('.jobs.index').ready(function() {
  
  var wrapper = $('<div/>').css( 
    { height: 0, width: 0, 'overflow': 'hidden' }
  );
  var fileInput = $(':file').wrap(wrapper);

  fileInput.change(function(){
    $this = $(this);
    $('#file').text($this.val());
  });

  $('#file').click(function(){
    fileInput.click();
  }).show();
  
  $('.best_in_place').best_in_place();
  
});
