$(document).ready(function() {
  $("#file-upload").fileupload({
    sequentialUploads: true,
    change: function (e, data) {
      $.each(data.files, function (index, file) {
        var bar = $('<div class="progress"><div class="progress-bar progress-bar-striped active">' + file.name + ' - <span class="progress-percent">0%</span></div></div>').attr("id", file.name);
        $("#progress-bars").append(bar);
      });
    },
    progress: function (e, data) {
      var progress = parseInt(data.loaded / data.total * 100, 10);
      var loader = $('#progress-bars [id="'+data.files[0]['name']+'"] .progress-bar')
        .width(progress + "%");
      loader.find(".progress-percent").text(progress + "%");
      if(progress == 100) {
        loader.removeClass("active");
      }
    },
    progressall: function(e, data) {
      var progress = parseInt(data.loaded / data.total * 100, 10);
      $("#progress-bars").removeClass("hidden");
      $("#total-progress").css("width", progress + "%");
      $("#total-progress .progress-percent").text(progress + "%");
      if(progress == 100) {
        $("#total-progress").removeClass("active");
      } else {
        $("#total-progress").addClass("active");
      }
    }
  });
});
