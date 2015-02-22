$(document).ready(function() {
  $(document).on("click", ".favorite-image", function(e) {
    e.preventDefault();
    var heart = $(this);
    var imageID = heart.data("image-id");
    $.post("/favorite/" + imageID, function(data) {
      heart.children().toggleClass("fa-heart fa-heart-o");
    });
    return false;
  });
});
