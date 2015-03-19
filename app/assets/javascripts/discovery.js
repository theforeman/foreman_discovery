$(document).on('ContentLoad', function (e) {
  inner_autocomplete = $('#inner-autocomplete')
  if (inner_autocomplete.size() > 0) {
    inner_autocomplete.scopedSearch({'delay': 250});
  }
});
