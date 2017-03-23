$(document).ready(function() {
  
  // ------------ CREATE ORDER PREVIEW -----------------------------------------
  
  $('.shopping-cart-img').click(function() {
    var parents = $(this).parents();
    var children = $(parents[2]).children();
    closeItemDetailedInfo($(children[1]).children().first());
    if (ordered_meals.includes($(this).attr('data-id')) == false) {
      enlargeOrderVariables(this);
      prepareOrderPreview();
    }
  });

  $('.order-preview-form').click(function() {
    $('.sidebar-icon-wrapper').css('display', 'block');
    $('.sidebar-items').css('display', 'none');
    $('.sidebar').css('width', '20%');
    $('.content').show();
    $('.sidebar-item-close').css('display', 'none');
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
  
  var ordered_meals = [];
  var order_sum = 0;
  var order_calories = 0;

  var countTotalCalories = function() {
    var txt = 'Calories: ' + Math.round(order_calories);
    $('.preview-calories').text(txt);
  };
  
  var countTotalSum = function() {
    var txt = 'Sum: ' + Math.round(order_sum);
    $('.preview-sum').text(txt);
  };
  
  var enlargeOrderCalorie = function(calorie) {
    if (isNaN(calorie) == false && calorie != undefined)
      order_calories += calorie;
  };
  
  var enlargeOrderSum = function(sum) {
    if (isNaN(sum) == false && sum != undefined)
      order_sum += sum;
  };
  
  var enlargeOrderVariables = function(obj) {
    ordered_meals.push($(obj).attr('data-id'));
    enlargeOrderSum(parseFloat($(obj).attr('data-price')));
    enlargeOrderCalorie(parseFloat($(obj).attr('data-calorie')));
  };
  
  var formOrderPreview = function() {
    var order_items = $('.popup.order-preview').find('.preview-item.hidden');
    for(var i = 0, size = order_items.length; i < size; i++)
      if(ordered_meals.includes($(order_items[i]).attr('data'))) {
        $(order_items[i]).removeClass('hidden');
        $(order_items[i]).addClass('flex');
      }
  };
  
  var lessenOrderCalorie = function(calorie) {
    if (isNaN(calorie) == false && calorie != undefined)
      order_calories -= calorie;
  };
  
  var lessenOrderSum = function(sum) {
    if (isNaN(sum) == false && sum != undefined)
      order_sum -= sum;
  };

  var lessenOrderVariables = function(obj) {
    var ind = ordered_meals.indexOf($(obj).attr('data-id'));
    if(ind != -1)
    	ordered_meals.splice(ind, 1);
    lessenOrderSum(parseFloat($(obj).attr('data-price')));
    lessenOrderCalorie(parseFloat($(obj).attr('data-calorie')));
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
  
  // ------------ CHANGE CSS STYLES WHEN DETAILED INFO ABOUT ITEM IS OPENED ----
  
  $('.weekday-menu-item.small-img').click(function() {
    var parents = $(this).parents();
    hideOtherItems(parents[4], $(this).attr('data'));
    applyCSSStyles(parents);
    enlargeImage(this);
  });
  
  var applyCSSStyles = function(arr) {
    applyCSSStyleToImgWrapperDiv(arr[0]);
    applyCSSStyleToMainDataGeneralDiv(arr[1]);
    applyCSSStyleToMainDataDiv(arr[2]);
    $(arr[3]).addClass('full_width');
  };
  
  var applyCSSStyleToImgWrapperDiv = function(obj) {
    $(obj).addClass('part_width_padding');
  };
  
  var applyCSSStyleToMainDataDiv = function(obj) {
    $(obj).addClass('full_width');
    var children = $(obj).children();
    for (var i = 0, size = children.length; i < size; i++){
      if ($(children[i]).hasClass('hidden'))
        $(children[i]).removeClass('hidden');
    }
  };
  
  var applyCSSStyleToMainDataGeneralDiv = function(obj) {
    $(obj).addClass('part_width');
    var children = $(obj).children();
    for (var i = 0, size = children.length; i < size; i++){
      if ($(children[i]).hasClass('hidden')) {
        $(children[i]).removeClass('hidden');
        $(children[i]).addClass('part_width_padding');
      }
    }
  };
  
  var enlargeImage = function(obj) {
    $(obj).removeClass('small-img');
    $(obj).addClass('enlarged-img');
  };

  var hideOtherItems = function(obj, id) {
    var items = $(obj).find('.weekday-menu-item');
    for(var i = 0, size = items.length; i < size; i++) {
      if($(items[i]).attr('data') != id)
        $(items[i]).addClass('hidden');
    }
  };
  
  $('.main-data-details-close').click(function() {
    closeItemDetailedInfo(this);
  });
  
  var closeItemDetailedInfo = function(obj) {
      idOfItemToBeClosed = $(obj).attr('data');
      var parents = $(obj).parents();
      showOtherItems(parents[3]);
      reverseAppliedCSSStyles(parents);
    };
    
  var compressImage = function(obj) {
    for(var i = 0, size = obj.length; i < size; i++)
      if($(obj[i]).attr('data') == idOfItemToBeClosed) {
        $(obj[i]).removeClass('enlarged-img');
        $(obj[i]).addClass('small-img');
      }
    idOfItemToBeClosed = '';
  };
  
  var idOfItemToBeClosed;
  
  var reverseAppliedCSSStyles = function(arr) {
    $(arr[0]).addClass('hidden');
    reverseCSSStyleOfMainDataDiv(arr[1]);
    reverseCSSStyleOfMainDataGeneralDiv(arr[1])
    $(arr[2]).removeClass('full_width');
  };
  
  var reverseCSSStyleOfImgWrapperDiv = function(obj) {
    if ($(obj).hasClass('img-wrapper')) {
      $(obj).removeClass('part_width_padding');
      compressImage($('.img-wrapper img'));
    }
  };
  
  var reverseCSSStyleOfMainDataDiv = function(obj) {
    $(obj).removeClass('full_width');
  };
  
  var reverseCSSStyleOfMainDataGeneralDiv = function(obj) {
    var children = $(obj).children();
    for (var i = 0, size = children.length; i < size; i++){
      if ($(children[i]).hasClass('main-data-general'))
        reverseCSSStyleOfMainDataGeneralDivChildren(children[i]);
    }
  };
  
  var reverseCSSStyleOfMainDataGeneralDivChildren = function(obj) {
    var children = $(obj).children();
    for (var i = 0, size = children.length; i < size; i++){
      reverseCSSStyleOfShoppingDetailsDiv(children[i]);
      reverseCSSStyleOfImgWrapperDiv(children[i]);
    }
  };
  
  var reverseCSSStyleOfShoppingDetailsDiv = function(obj) {
    if ($(obj).hasClass('shopping-details'))
      $(obj).addClass('hidden');
  };
  
  var showOtherItems = function(obj) {
    var items = $(obj).find('.weekday-menu-item');
    for(var i = 0, size = items.length; i < size; i++) {
      if($(items[i]).hasClass('hidden'))
        $(items[i]).removeClass('hidden');
    }
  };
});