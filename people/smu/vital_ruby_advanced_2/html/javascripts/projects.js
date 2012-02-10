$(function() {
  $('.solution').hide();

  $('h4').click (function () {
    $(this).next('.solution').toggle();
  });
});
