$(document).ready(function() {
  var previewNode = document.querySelector("#dropzone-template");
  previewNode.id = "";
  var previewTemplate = previewNode.parentNode.innerHTML;
  previewNode.parentNode.removeChild(previewNode);

  var dropzone = new Dropzone("#file-upload", {
    maxFileSize: 10,
    paramName: "image",
    parallelUploads: 1,
    uploadMultiple: false,
    acceptedFiles: "image/png,image/gif,image/jpeg",
    createImageThumbnails: false,
    previewTemplate: previewTemplate,
    previewsContainer: "#current-uploads",
    clickable: "#file-upload-dropzone"
  });
  dropzone.on("complete", function(file) {
    error = JSON.parse(file.xhr.response).error;
    previewElement = $(file.previewElement);
    previewElement.find(".progress").removeClass("active");
    if(error) {
      previewElement.find(".error").text(error);
      previewElement.find(".progress-bar").addClass("progress-bar-danger");
      previewElement.find("[data-dz-uploadprogress]").text("Error");
    } else {
      previewElement.find("[data-dz-uploadprogress]").text("Complete");
    }
  }).on("error", function(file, message) {
    console.log(message);
    previewElement = $(file.previewElement);
    previewElement.find(".progress").removeClass("active");
    previewElement.find("[data-dz-uploadprogress]").text("Error");
    previewElement.find(".error").text(message);
    previewElement.find(".progress-bar").addClass("progress-bar-danger");
  }).on("uploadprogress", function(file, progress, bytesSent) {
    if(progress == 100 && file.previewElement) {
      $(file.previewElement).find("[data-dz-uploadprogress]").text("Processing");
    }
  }).on("totaluploadprogress", function(progress, totalBytes, totalBytesSent) {
    $("#total-progress").addClass("active");
    $("#progress-bars").removeClass("hidden");
    $("#total-progress").css("width", progress + "%");
    $("#total-progress .progress-percent").text(Math.round(progress) + "%");
    if(progress == 100) {
      $("#total-progress .uploading").addClass("hidden");
      $("#total-progress .processing").removeClass("hidden");
      $("#total-progress .complete").addClass("hidden");
    } else {
      $("#total-progress .uploading").removeClass("hidden");
      $("#total-progress .processing").addClass("hidden");
      $("#total-progress .complete").addClass("hidden");
    }
  }).on("queuecomplete", function() {
    $("#total-progress").removeClass("active");
      $("#total-progress .uploading").addClass("hidden");
      $("#total-progress .processing").addClass("hidden");
      $("#total-progress .complete").removeClass("hidden");
  });
});
