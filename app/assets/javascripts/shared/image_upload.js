ready_image_upload = function() {   

  if ( $('.companies').length > 0 || $('.investors').length > 0 )  { 

    // INPUT A PICTURE
    $('i.fa-picture-o').on('click', function() {
      $(this).parents('.uploader').find("input[type='file']").click();
      $(this).parents('.uploader').find("input[type='file']").change(function() {
        $(this).parents('form:first').submit();
      });    
    });       
  }  
  
}

$(document).ready(ready_image_upload);
$(document).on('page:load', ready_image_upload);