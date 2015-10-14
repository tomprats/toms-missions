// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require jquery.turbolinks
//= require bootstrap
//= require pickadate/picker
//= require pickadate/picker.date
//= require_tree .

$(document).ready(function() {
  $(".navbar-collapse").on("show.bs.collapse", function() {
    $(".navbar-toggle .fa").addClass("fa-minus").removeClass("fa-plus");
  });

  $(".navbar-collapse").on("hide.bs.collapse", function() {
    $(".navbar-toggle .fa").addClass("fa-plus").removeClass("fa-minus");
  });

  $(document).on("click", function() {
    if($(".navbar-toggle .fa-minus").length) {
      $(".navbar-collapse").collapse("hide");
    }
  });
});
