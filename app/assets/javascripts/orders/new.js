$(document).ready(function() {
  $(window).load(function() {
    displayTotalSum();
  });
  
  $('.ordered-amount').focusout(function() {
    displayTotalSum();
  });
  
  var displayTotalSum = function(ctr) {
    $('.total-sum-of-ordered-items').text('Total: ' + countTotalSum());
  };
  
  var countTotalSum = function() {
    var total_sum = 0;
    $('.ordered-item-price').each(function() {
      var ctr = parseInt($(this).next().children().first().val());
      total_sum += parseFloat($(this).html()) * ctr;                     
    });
    return total_sum;
  };
});