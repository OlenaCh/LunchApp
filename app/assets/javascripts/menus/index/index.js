$(document).ready(function() {
  $('.weekday-menu-item.small-img').click(function() {
    var parents = $(this).parents();
    hideOtherItems(parents[4], $(this).attr('data'));
    applyCSSStyles(parents);
    changeImage(this);
  });
  
  $('.main-data-details-close').click(function() {
    
  });

  var  applyCSSStyles = function(arr) {
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
        $(children[i]).addClass('flex');
        $(children[i]).addClass('part_width_padding');
      }
    }
  };
  
  var changeImage = function(obj) {
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
});