$(document).ready(function() {
  $('.shopping-cart-img').click(function() {
    enlargeOrderVariables(this);
    prepareOrderPreview();
  });

  $('.order-preview-form').click(function() {
    $('.popup.order-preview').show();
  });
  
  $('.popup-close.order-preview').click(function() {
    $('.popup.order-preview').hide();
  });
  
  $('.remove-item-from-preview').click(function() {
    removeChosenItem(this);
    lessenOrderVariables(this);
    countTotalCalories();
    countTotalSum();
    setNewOrderParams();
  });
  
  $('.weekday-menu-item.small-img').click(function() {
    var parents = $(this).parents();
    $(this).removeClass('small-img');
    $(this).addClass('enlarged-img');
    $(parents[2]).removeClass('flex');
    var x = $(parents[2]).children();
    
    var y = $(parents[1]).children();
    for (var i = 0, size = x.size(); i < size; i++){
      if ($(x[i]).hasClass('hidden'))
        $(x[i]).removeClass('hidden');
    }
    
    for (var i = 0, size = y.size(); i < size; i++){
      if ($(y[i]).hasClass('hidden'))
        $(y[i]).removeClass('hidden');
    }
  });
  
  $('.weekday-menu-item.enlarged-img.close').click(function() {
    var menu_list = $('.weekday-menu-items').find('.shown-data');
    for (var i = 0, size = menu_list.length; i < size; i++) {
      $(menu_list[i]).removeClass('shown-data');
      $(menu_list[i]).addClass('hidden-data');
    }
  });
  
  var ordered_meals = [];
  var order_sum = 0;
  var order_calories = 0;
  
  var countTotalCalories = function() {
    var txt = 'Calories: ' + order_calories;
    $('.preview-calories').text(txt);
  };
  
  var countTotalSum = function() {
    var txt = 'Sum: ' + order_sum;
    $('.preview-sum').text(txt);
  };
  
  var enlargeOrderVariables = function(obj) {
    ordered_meals.push($(obj).attr('data-id'));
    order_sum += $(obj).attr('data-price');
    order_calories += $(obj).attr('data-calories');
  };
  
  var formOrderPreview = function() {
    var order_items = $('.popup.order-preview').find('.preview-item.hidden');
    for(var i = 0, size = order_items.length; i < size; i++)
      if(ordered_meals.includes($(order_items[i]).attr('data'))) {
        $(order_items[i]).removeClass('hidden');
        $(order_items[i]).addClass('flex');
      }
  };
  
  var lessenOrderVariables = function(obj) {
    var ind = ordered_meals.indexOf($(obj).attr('data-id'));
    if(ind != -1)
    	ordered_meals.splice(ind, 1);
    order_sum -= $(obj).attr('data-price');
    order_calories -= $(obj).attr('data-calories');
  };
  
  var prepareOrderPreview = function() {
    formOrderPreview();
    countTotalCalories();
    countTotalSum();
    setNewOrderParams();
    $('.sidebar-item.order-preview-form').removeClass('hidden');
  };
  
  var removeChosenItem = function(obj) {
    var shown_items = $('.popup.order-preview').find('.preview-item.flex');
    for(var i = 0, size = shown_items.length; i < size; i++) {
      if($(obj).attr('data-id') == $(shown_items[i]).attr('data')) {
        $(shown_items[i]).removeClass('flex');
        $(shown_items[i]).addClass('hidden');
      }
    }
  };

  var setNewOrderParams = function() {
    var link = '/orders/new?items_ids=' + ordered_meals.join(',');
    $('.place-order-href').attr('href', link);
  };
});