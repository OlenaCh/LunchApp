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
  
  $('.add-new-item.new-menu').click(function() {
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
    ordered_meals.push($(this).attr('data-id'));
    order_sum += $(this).attr('data-price');
    order_calories += $(this).attr('data-calories');
    $('li.sidebar.item.order-preview-form').removeClass('inactive');
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
  
  var field_id;
  var ordered_meals = [];
  var order_sum = 0;
  var order_calories = 0;
  
  var hidePopups = function() {
    $('.popup-items').hide();
  };
  
  var openItemsModal = function(obj) {
    if ($(obj).attr('class').includes('f-menu-item'))
      $('.popup-items.first-course').show();
    if ($(obj).attr('class').includes('m-menu-item'))
      $('.popup-items.main-course').show();
    if ($(obj).attr('class').includes('d-menu-item'))
      $('.popup-items.drink').show();
  }

  var setButtonsIdentifiers = function() {
    var menu_items = $('form').find('.course-row');
    for(var i = 0, size = menu_items.size(); i < size; i++) {
      var choose_btns = $(menu_items[i]).find('.choose');
      for(var j = 0; j < 3; j++) { 
        $(choose_btns[j]).attr('data', i);
      }
    }
  }
  
  var setInputIdentifiers = function() {
    var menu_items = $('form').find('.input.menu-item');
    for(var i = 0, size = menu_items.size(); i < size; i++) {
      $(menu_items[i]).attr('id', 'menu-item-' + i);
    }
  }
  
  var setPageVariables = function(obj) {
    field_id = $(obj).attr('data');
  }
});