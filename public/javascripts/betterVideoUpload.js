/* DO NOT MODIFY. This file was compiled Mon, 16 Jan 2012 21:15:45 GMT from
 * /Users/jessesmith/Documents/BetterSense/www/BetterSenseDemoDev/BetterSenseDemo/app/coffeescripts/betterVideoUpload.coffee
 */

(function() {
  var root;

  root = typeof exports !== "undefined" && exports !== null ? exports : this;

  $(function() {
    var confirm_upload;
    root.update_video_params = function() {
      root.video_parameters["description"] = $('#video_description').val();
      root.video_parameters["name"] = $('#video_name').val();
      root.$('#video_vid_file').uploadifySettings('scriptData', root.video_parameters, true);
    };
    root.$('#video_description').change(function() {
      root.update_video_params();
    });
    root.$('#video_name').change(function() {
      root.update_video_params();
    });
    root.do_upload = function() {
      if (confirm_upload()) {
        console.log("Uploading!!");
        root.$('#video_vid_file').uploadifyUpload();
      }
    };
    confirm_upload = function() {
      if (root.file_count === 0) {
        alert("Please select a video file to upload.");
        return false;
      }
      return root.confirm("Ready to Upload the video?\n" + "Name: " + root.video_parameters["name"] + "\n" + "Description: " + root.video_parameters["description"] + "\n");
    };
    root.update_file_count = function(count) {
      if (count == null) count = 0;
      return root.file_count = count;
    };
    root.update_file_count(0);
  });

  root.uploadifyVideo = function(buttonText, upload_video_data) {
    if (buttonText == null) buttonText = 'Select Video';
    if (upload_video_data == null) upload_video_data = {};
    $('#video_vid_file').click(function(event) {
      event.preventDefault();
    });
    $('#video_vid_file').uploadify({
      'uploader': '/flash/uploadify.swf',
      'script': '/videos',
      'method': 'post',
      'multi': false,
      'auto': false,
      'cancelImg': '/images/cancel.png',
      'fileExt': '*.mp4;*.flv',
      'buttonText': '' + buttonText,
      'sizeLimit': 20480000,
      'scriptData': upload_video_data,
      'folder': '/Users/jessesmith/Documents/BetterSense/www/BetterSenseDemoDev/BetterSenseDemo/',
      'onOpen': function(event, ID, fileObj) {
        console.log(upload_video_data);
      },
      'onError': function(event, ID, fileObj, errorObj) {
        alert(errorObj.type + ' Error: ' + errorObj.info);
      },
      'onCancel': function(event, ID, fileObj, data) {
        root.update_file_count(0);
      },
      'onSelect': function(event, ID, fileObj) {
        root.update_file_count(1);
      }
    });
  };

}).call(this);
