$(document).on "click", ".favorite-image, .favorite-link", (e) ->
  e.preventDefault()
  heart = $(@)
  $.post "/f/#{heart.data("image-id")}", ->
    heart.children().toggleClass("fa-heart fa-heart-o")
  false
