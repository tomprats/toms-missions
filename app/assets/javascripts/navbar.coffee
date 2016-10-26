$ ->
  $(".navbar-collapse").on "show.bs.collapse", ->
    $(".navbar-toggle .fa").addClass("fa-minus").removeClass("fa-plus")

  $(".navbar-collapse").on "hide.bs.collapse", ->
    $(".navbar-toggle .fa").addClass("fa-plus").removeClass("fa-minus")

$(document).on "click", ->
  if $(".navbar-toggle .fa-minus")[0]
    $(".navbar-collapse").collapse("hide")
