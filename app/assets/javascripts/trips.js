// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

$(document).ready(function() {
  $("#trip_start_date").pickadate({
    format: "mm/dd/yyyy"
  });

  $("#trip_end_date").pickadate({
    format: "mm/dd/yyyy"
  });
});
