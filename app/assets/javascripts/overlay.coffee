$(document).on "click", ".overlay-link", (e) ->
  e.preventDefault()

  options = {
    urlProperty: "src",
    index: $(".overlay-link").index(@),
    container: "#blueimp-gallery",
    continuous: false,
    onslide: (index, slide) ->
      $("#blueimp-gallery .link").attr("href", @list[index].link)
  }
  images = $(".overlay-link").map ->
    {
      src: $(@).data("large"),
      link: $(@).attr("href")
    }
  gallery = blueimp.Gallery(images, options)

  false
