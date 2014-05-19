//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .

$(function() {
  $('a#close_notice_btn').click(function() {
    $(this).parent().hide();
    return false;
  });
});
