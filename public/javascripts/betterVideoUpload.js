/* DO NOT MODIFY. This file was compiled Thu, 16 Feb 2012 01:05:42 GMT from
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
    root.clear_upload_fields = function() {
      root.$('#video_name')[0].value = "";
      root.$('#video_description')[0].value = "";
    };
    root.do_upload = function() {
      if (confirm_upload()) {
        console.log("Uploading!!");
        root.$('#video_vid_file').uploadifyUpload();
        root.clear_upload_fields();
      }
    };
    root.do_clear_cart = function() {
      root.$('#clear_cart').click();
    };
    root.do_cart_order = function() {
      root.$('#cart_order').click();
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
      'sizeLimit': 204800000,
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
      },
      'onComplete': function(event, ID, fileObj, response, data) {
        root.$('#refresh_videos').click();
      }
    });
  };

}).call(this);
