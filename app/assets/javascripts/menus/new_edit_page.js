$(document).ready(function() {
  $(window).load(function(){
    setInputIdentifiers();
    setButtonsIdentifiers();
  });
  
  $('.choose.f-menu-item').click(function() {
    itemsPopup(this, 'first-course');
  });
  
  $('.choose.m-menu-item').click(function() {
    itemsPopup(this, 'main-course');
  });
  
  $('.choose.d-menu-item').click(function() {
    itemsPopup(this, 'drink');
  });
  
  $('.menu.item').click(function() {
    var slctr = '#menu-item-' + field_id;
    $(slctr).attr('value', $(this).attr('data'));
    hidePopups();
  });
  
  $('.btn.add-item-to-menu').click(function() {
    var html = " \
      <div class='course flex'> \
        <label class='menu form-element label'>Menu item:</label> \
        <div class='menu form-element input flex'> \
          <input type='text' class='menu item form-element input wth-border' \
                name='menu[items][]' id='menu' value=''> \
          <div class='menu item-buttons flex'> \
            <div class='choose f-menu-item wth-border' data='nil'><p>F</p></div> \
            <div class='choose m-menu-item wth-border' data='nil'><p>M</p></div> \
            <div class='choose d-menu-item wth-border' data='nil'><p>D</p></div> \
          </div> \
        </div> \
      </div> \
    ";
    $('.menu.form-element.courses').append(html);
  });
  
  $('.popup-close.first-course, .popup-close.main-course, .popup-close.drink'
    ).click(function() {
      hidePopups();
  });
  
  var field_id;
  
  var hidePopups = function() {
    $('.popup').hide();
  };
  
  var itemsPopup = function(obj, cls) {
    $('.popup.' + cls).show();
    field_id = $(obj).attr('data');
    wrapItemsInItemsBlocks(cls);
  };

  var setButtonsIdentifiers = function() {
    var menu_items = $('form').find('.course');
    for(var i = 0, size = menu_items.size(); i < size; i++) {
      var choose_btns = $(menu_items[i]).find('.choose');
      for(var j = 0; j < 3; j++) { $(choose_btns[j]).attr('data', i); }
    }
  };
  
  var setInputIdentifiers = function() {
    var menu_items = $('form').find('.menu.item.form-element.input');
    for(var i = 0, size = menu_items.size(); i < size; i++) {
      $(menu_items[i]).attr('id', 'menu-item-' + i);
    }
  };
  
  var wrapItemsInItemsBlocks = function(cls) {
    if ($('.popup.' + cls + ' .popup-form').find('.items-block').length == 0) {
      var items = $('.popup.' + cls + ' .popup-form').find('.menu.item');
      var items_block = "<div class='items-block'></div>";
      for (var i = 0, size = items.length; i < size; i += 2)
        $(items[i]).nextUntil(items[i + 2]).andSelf().wrapAll(items_block);
    }
  };
});