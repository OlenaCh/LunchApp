$('.choose-first-course, .choose-main-course, .choose-drink').click('on', function() {
  if ($(this).attr('class').includes('first'))
    $('.first-items-to-choose').show();
  if ($(this).attr('class').includes('main'))
    $('.main-items-to-choose').show();
  if ($(this).attr('class').includes('drink'))
    $('.drink-items-to-choose').show();
});