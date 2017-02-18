$(document).ready(function() {
  $('.order-item-img img').mouseover(function() {
    manipulationWithDetailsSpan(this, 'Display');
  });
  
  $('.order-item-img img').mouseout(function() {
    manipulationWithDetailsSpan(this, 'Hide');
  });
  
  $('.order-status-current').click(function() {
    closeStatusRadioInputs(this);
  });
  
  $('.order-status-radio').click(function() {
    changeOrderStatus(this);
    closeStatusRadioInputs($(this).parent());
  });
  
  var changeOrderStatus = function(obj) {
    var upperContainers = $(obj).parents();
    var id = $(upperContainers[1]).attr('data');
    $.ajax({
      url: 'orders/' + id,
      method: 'PATCH',
      dataType: 'json',
      data: { id: id, order: { status: $(obj).val() } },
      success: function() {
        $(upperContainers[1]).children().first().text($(obj).val());
      }
    });
  };
  
  var closeStatusRadioInputs = function(obj) {
    var children = $(obj).parent().children();
    if ($(children[1]).hasClass('hidden'))
      $(children[1]).removeClass('hidden');
    else
      $(children[1]).addClass('hidden');
  };
  
  var hideSpan = function(obj) {
    $(obj).removeClass('displayed');
    $(obj).addClass('hidden');
  };
  
  var manipulationWithDetailsSpan = function(obj, command) {
    var upperContainers = $(obj).parents();
    var span = spanToShow(upperContainers[1], $(upperContainers[0]).attr('data'));
    if (command == 'Display')
      showSpan(span);
    if (command == 'Hide')
      hideSpan(span);
  };
  
  var showSpan = function(obj) {
    $(obj).removeClass('hidden');
    $(obj).addClass('displayed');
  };
  
  var spanToShow = function(obj, id) {
    var span;
    var children = $(obj).children();
    for (var i = 0, size = children.length; i < size; i++)
      if ($(children[i]).attr('data') == id)
        span = children[i];
    return span;
  };
});