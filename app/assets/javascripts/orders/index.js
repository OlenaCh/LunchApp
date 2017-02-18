$(document).ready(function() {
  $('.order-item-img').mouseover(function() {
    manipulationWithDetailsSpan(this, 'Display');
  });
  
  $('.order-item-img').mouseout(function() {
    manipulationWithDetailsSpan(this, 'Hide');
  });
  
  var hideSpan = function(obj) {
    $(obj).removeClass('displayed');
    $(obj).addClass('hidden');
  };
  
  var manipulationWithDetailsSpan = function(obj, command) {
    var upperContainer = $(obj).parent();
    var children = $(upperContainer).children();
    if (command == 'Display')
      showSpan(children[1]);
    if (command == 'Hide')
      hideSpan(children[1]);
  };
  
  var showSpan = function(obj) {
    $(obj).removeClass('hidden');
    $(obj).addClass('displayed');
  };
});