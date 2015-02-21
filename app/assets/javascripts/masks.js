$(document).ready(function() {
  $.mask.definitions["!"]="^[a-z0-9_-]$";
  $("#user_username").mask("!!!?!?!?!?!?!?!?!?!?!?!?!?!?!", { placeholder: "", autoclear: false });
});
