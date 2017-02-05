$(document).ready(function() {
  $(document).on('click', '.choose', function() {
    setInputIdentifiers();
    setButtonsIdentifiers();
    openItemsModal(this);
    setPageVariables(this);
  });
  
  $('.item').click(function() {
    var slctr = '#menu-item-' + field_id;
    $(slctr).attr('value', $(this).attr('data'));
    hidePopups();
  });
  
  $('.btn.add-item-to-menu').click(function() {
    var html = `
      <div class='course-row'>
        <label class='item-label menu-new'>Menu item:</label>
          <div class='item-input menu-new'>
            <input type='text' class='input menu-item' name='menu[items][]' id='menu' value="">
            <div class='menu-new item-buttons'>
              <div class='choose f-menu-item' data='nil'><p>F</p></div>
              <div class='choose m-menu-item' data='nil'><p>M</p></div>
              <div class='choose d-menu-item' data='nil'><p>D</p></div>
            </div>
          </div>
      </div>
    `;
    $('.form-element.courses').append(html);
  });
  
  $('.first-items-close, .main-items-close, .drinks-close').click(function() {
    hidePopups();
  });
  
  $('.shopping-cart-img').click(function() {
    enlargeOrderVariables(this);
    formOrderPreview();
    countTotalCalories();
    countTotalSum();
    setNewOrderParams();
    $('.sidebar-item.order-preview-form').removeClass('inactive');
  });
  
  $('.preview-img').click(function() {
    $('.menu-item-details').show();
  });
  
  $('.menu-item-details-close').click(function() {
    $('.menu-item-details').hide();
  });
  
  $('.order-preview-form').click(function() {
    $('.popup-order-preview').show();
  });
  
  $('.order-preview-close').click(function() {
    $('.popup-order-preview').hide();
  });
  
  $('.remove-item-from-order').click(function() {
    var shown_items = $('.popup-order-preview').find('.order-preview-item.flex');
    for(var i = 0, size = shown_items.length; i < size; i++) {
      if($(this).attr('data-id') == $(shown_items[i]).attr('data')) {
        $(shown_items[i]).removeClass('flex');
        $(shown_items[i]).addClass('hidden');
      }
    }
    lessenOrderVariables(this);
    countTotalCalories();
    countTotalSum();
    setNewOrderParams();
  });
  
  $('.menus-list-item.small').click(function() {
    var menu_list = $('.menus-list').find('.hidden-data');
    for (var i = 0, size = menu_list.length; i < size; i++) {
      if ($(this).attr('data') == $(menu_list[i]).attr('data')) {
        $(menu_list[i]).removeClass('hidden-data');
        $(menu_list[i]).addClass('shown-data');
      }
    }
  });
  
  $('.menus-list-item-enlarged-close').click(function() {
    var menu_list = $('.menus-list').find('.shown-data');
    for (var i = 0, size = menu_list.length; i < size; i++) {
      $(menu_list[i]).removeClass('shown-data');
      $(menu_list[i]).addClass('hidden-data');
    }
  });

  var field_id;
  var ordered_meals = [];
  var order_sum = 0;
  var order_calories = 0;
  
  var countTotalCalories = function() {
    var txt = 'Calories: ' + order_calories;
    $('.order-preview-calories').text(txt);
  };
  
  var countTotalSum = function() {
    var txt = 'Sum: ' + order_sum;
    $('.order-preview-sum').text(txt);
  };
  
  var enlargeOrderVariables = function(obj) {
    ordered_meals.push($(obj).attr('data-id'));
    order_sum += $(obj).attr('data-price');
    order_calories += $(obj).attr('data-calories');
  };
  
  var formOrderPreview = function() {
    var order_items = $('.popup-order-preview').find('.order-preview-item.hidden');
    for(var i = 0, size = order_items.length; i < size; i++) {
      if(ordered_meals.includes($(order_items[i]).attr('data'))) {
        $(order_items[i]).removeClass('hidden');
        $(order_items[i]).addClass('flex');
      }
    }
  };
  
  var hidePopups = function() {
    $('.popup-items').hide();
  };
  
  var lessenOrderVariables = function(obj) {
    var ind = ordered_meals.indexOf($(obj).attr('data-id'));
    if(ind != -1) {
    	ordered_meals.splice(ind, 1);
    }
    order_sum -= $(obj).attr('data-price');
    order_calories -= $(obj).attr('data-calories');
    console.log(ordered_meals);
  };
  
  var openItemsModal = function(obj) {
    if ($(obj).attr('class').includes('f-menu-item'))
      $('.popup-items.first-course').show();
    if ($(obj).attr('class').includes('m-menu-item'))
      $('.popup-items.main-course').show();
    if ($(obj).attr('class').includes('d-menu-item'))
      $('.popup-items.drink').show();
  };

  var setButtonsIdentifiers = function() {
    var menu_items = $('form').find('.course-row');
    for(var i = 0, size = menu_items.size(); i < size; i++) {
      var choose_btns = $(menu_items[i]).find('.choose');
      for(var j = 0; j < 3; j++) { 
        $(choose_btns[j]).attr('data', i);
      }
    }
  };
  
  var setInputIdentifiers = function() {
    var menu_items = $('form').find('.input.menu-item');
    for(var i = 0, size = menu_items.size(); i < size; i++) {
      $(menu_items[i]).attr('id', 'menu-item-' + i);
    }
  };
  
  var setPageVariables = function(obj) {
    field_id = $(obj).attr('data');
  };
  
  var setNewOrderParams = function() {
    $('.place-order-href').attr('href', '/orders/new?items_ids=' + ordered_meals.join(','));
  };
});