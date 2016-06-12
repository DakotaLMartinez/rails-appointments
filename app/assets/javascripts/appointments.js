jQuery(document).ready(function(){
  var first_time = true;
  jQuery('.datepicker').click(function(){ 
    if(first_time) {
      first_time = false;
    } else { 
      jQuery('.datepicker.dropdown-menu').toggle();
      first_time = true;
    }
  });    
});
