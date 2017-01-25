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
  });
  
  $('.add.menu-item').click(function() {
    var html = `
      <div class='course-row'>
        <label>Menu item:</label>
        <input type='text' class='input menu-item' name='menu[items][]' id='menu'>
        <div class='choose f-menu-item' data='nil'>Choose f</div>
        <div class='choose m-menu-item' data='nil'>Choose m</div>
        <div class='choose d-menu-item' data='nil'>Choose d</div>
      </div>
    `;
    $('.courses').append(html);
  });
  
  var field_id;
  
  var openItemsModal = function(obj) {
    if ($(obj).attr('class').includes('f-menu-item'))
      $('.first-items').show();
    if ($(obj).attr('class').includes('m-menu-item'))
      $('.main-items').show();
    if ($(obj).attr('class').includes('d-menu-item'))
      $('.drinks').show();
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