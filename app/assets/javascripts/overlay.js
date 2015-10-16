$(document).on("click", ".overlay-link", function(e) {
  e.preventDefault();

  var options = {
    urlProperty: "src",
    index: $(".overlay-link").index(this),
    container: "#blueimp-gallery",
    continuous: false,
    onslide: function (index, slide) {
      $("#blueimp-gallery .link").attr("href", this.list[index].link);
    }
  };
  var images = $(".overlay-link").map(function() {
    return {
      src: $(this).data("large"),
      link: $(this).attr("href")
    };
  });
  var gallery = blueimp.Gallery(images, options);

  return false;
});
