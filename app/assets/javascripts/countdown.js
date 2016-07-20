var countdown = function() {
  $('#clock').countdown({
    until: $('#remaining_time').val(),
    format: 'HMS',
    onExpiry: function() {
      alert(I18n.t("js.alert"));
      $('.submit-time-out').trigger('click');
      $('.submit-time-out').hidden();
    }
  });
}

document.addEventListener('turbolinks:load', countdown);
$(document).on('page:update', countdown);
