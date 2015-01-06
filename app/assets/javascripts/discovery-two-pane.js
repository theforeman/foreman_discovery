$(document).on('click', ".table-two-pane .display-two-pane a", function (e) {
  if ($('.table-two-pane').length) {
    e.preventDefault();
    two_pane_open(this);
  }
});
