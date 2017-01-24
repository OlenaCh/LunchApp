$(document).ready(function() {
  $('.choose').click(function() {
    if ($(this).attr('class').includes('first-course'))
      $('.first-items').show();
    if ($(this).attr('class').includes('main-course'))
      $('.main-items').show();
    if ($(this).attr('class').includes('drink'))
      $('.drinks').show();
    setPageVariables(this);
  });
  
  $('.item').click(function() {
    var slctr = '#menu_' + getInputId(field_class) + field_id;
    $(slctr).attr('value', $(this).attr('data'));
  });
  
  var field_class;
  var field_id;
  
  var getCourseType = function(str) {
    if(str.includes('first'))
      return 'f';
    if(str.includes('main'))
      return 'm';
    if(str.includes('drink'))
      return 'drink';
  }
  
  var getInputId = function(str) {
    if(str == 'drink')
      return 'drink_id_';
    return str + '_course_id_';
  }
  
  var setPageVariables = function(obj) {
    field_class = getCourseType($(obj).attr('class'));
    field_id = $(obj).attr('data');
  }
});