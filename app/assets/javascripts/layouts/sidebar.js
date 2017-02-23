$(document).ready(function() {
  $('.sidebar-icon').click(function() {
    $('.sidebar-icon-wrapper').css('display', 'none');
    $('.sidebar-items').css('display', 'block');
    $('.sidebar').css('width', '100%');
    $('.content').css('margin-left', '100%');
    $('.sidebar-item-close').css('display', 'block');
  });
  
  $('.sidebar-item-close').click(function() {
    $('.sidebar-icon-wrapper').css('display', 'block');
    $('.sidebar-items').css('display', 'none');
    $('.sidebar').css('width', '20%');
    $('.content').css('margin-left', '20%');
    $('.sidebar-item-close').css('display', 'none');
  });
  
  $('.sidebar-item').mouseover(function() {
    changeLinkColor(this, 'rgba(137, 200, 106, 1)');
  });
  
  $('.sidebar-item').mouseout(function() {
    changeLinkColor(this, 'rgba(255, 242, 230, 1)');
  });
  
  $('.sidebar-item.admin-login').click(function() {
    if($('.admin-login-form').hasClass('hidden'))
      $('.admin-login-form').removeClass('hidden');
    else
      $('.admin-login-form').addClass('hidden');
  });
  
  $('.admin-login-btn').click(function() {
    startSession();
  });
  
  var changeLinkColor = function(obj, color) {
    var links = $(obj).find('a');
    for (var i = 0, size = links.length; i < size; i++)
      $(links[i]).css('color', color);
  };
  
  var startSession = function() {
    $.ajax({
      url: 'admins/sign_in',
      method: 'POST',
      dataType: 'json',
      data: { admin: { 
        email: $('.admin-login-input.email').val(), 
        password: $('.admin-login-input.password').val()
      } }
    });
  };
});