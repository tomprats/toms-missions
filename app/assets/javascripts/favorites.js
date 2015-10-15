$(document).on("click", ".favorite-image, .favorite-link", function(e) {
  e.preventDefault();
  var heart = $(this);
  var imageID = heart.data("image-id");
  $.post("/f/" + imageID, function(data) {
    heart.children().toggleClass("fa-heart fa-heart-o");
  });
  return false;
});
