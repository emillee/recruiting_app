// ready = $('.companies.index').ready(function() {
// ready = $('.companies.show').ready(function() { 

ready_companies = function() {    
  if ($('.companies').length > 0 ) {
  
    // --------------------------------------------------------------------------------------------------------------
    // COMPANIES SHOW
    // --------------------------------------------------------------------------------------------------------------
  
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
