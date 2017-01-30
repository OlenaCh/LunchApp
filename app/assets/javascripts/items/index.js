$(document).ready(function() {
  $('.add-new-item').click(function(){
    $('.new-item-form').show();
  });
  
  $('.add-new-item-btn-close').click(function(){
    hideNewItemForm();
  });
  
  $('.add-new-item-btn').click(function(){
    hideNewItemForm();
    $.ajax({
      url: '/items',
      type: 'POST',
      data: { item: { item_type: $('input[name=item_type]:checked').val(), 
                      title: $('input[name=item_title]').val(), 
                      price: $('input[name=item_price]').val(), 
                      image: $('input[name=item_image]').val() } },
      dataType: 'json',
      success: function(response) {
        alert('hello');
      }
    });
  });
  
  var hideNewItemForm = function() {
    $('.new-item-form').hide();
  };
});