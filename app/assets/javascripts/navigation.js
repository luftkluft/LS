$(document).ready(function () {
  $("#navigation-ru").click(function (e) {
    e.preventDefault();
    window.location.href = "/set_current_locale?current_locale=ru";
  })

  $("#navigation-en").click(function (e) {
    e.preventDefault();
    window.location.href = "/set_current_locale?current_locale=en";
  })
});