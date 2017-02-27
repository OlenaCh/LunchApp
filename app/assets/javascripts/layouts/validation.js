$(document).ready(function() {
  $('#item_price, #item_title').click(function() {
    validationHint(this, 1, 'hide'); 
  });
  
  $('#item_price, #item_title').focusout(function() {
    if ($(this).val() == '' || $(this).val() == undefined) {
      validationHint(this, 1, 'show');
    }
  });
  
  $('#item_item_type_first_course, #item_item_type_main_course, \
     #item_item_type_drink').click(function() {
    validationHint(this, 3, 'hide'); 
  });
  
  $('#order-input-type-name, #order-input-type-address').click(function() {
    validationHint(this, 0, 'hide'); 
  });
  
  $('#order-input-type-name, #order-input-type-address').focusout(function() {
    if ($(this).val() == '' || $(this).val() == undefined) {
      validationHint(this, 0, 'show'); 
    }
  });

  var validationHint = function(obj, index, actn) {
    var parents = $(obj).parents();
    var validation = $(parents[index]).find('p');
    if (actn == 'hide')
      $(validation).addClass('hidden');
    else
      $(validation).removeClass('hidden');
  };
});