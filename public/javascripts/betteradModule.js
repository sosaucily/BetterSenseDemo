/* DO NOT MODIFY. This file was compiled Fri, 18 Nov 2011 01:17:24 GMT from
 * /Users/jessesmith/Documents/BetterSense/www/BetterSenseDemoDev/BetterSenseDemo/app/coffeescripts/betteradModule.coffee
 */

(function() {
  var root;
  root = typeof exports !== "undefined" && exports !== null ? exports : this;
  root.registerNewButtons = function(id) {
    var companionButton, overlayButton;
    overlayButton = $('#newOverlayButton' + id);
    companionButton = $('#newCompanionButton' + id);
    overlayButton.click(function() {
      return $('#newOverlayFieldsContainer' + id).toggle();
    });
    companionButton.click(function() {
      return $('#newCompanionFieldsContainer' + id).toggle();
    });
  };
  root.uploadifyAdItems = function(iqeid, adid, adsetid, buttonText) {
    if (buttonText == null) {
      buttonText = 'Select Image';
    }
    $('#ad_ad_pic' + iqeid).click(function(event) {
      return event.preventDefault();
    });
    $('#ad_ad_pic' + iqeid).uploadify({
      'uploader': '/flash/uploadify.swf',
      'script': '/ad_sets/' + adsetid + '/updateAd.js',
      'multi': true,
      'auto': true,
      'cancelImg': '/images/cancel.png',
      'buttonText': '' + buttonText,
      'sizeLimit': 102400,
      'multi': false,
      'scriptData': {
        'id': adid,
        "commit": "Update Ad"
      },
      'onComplete': function(event, ID, fileObj, response, data) {
        return root.updateImage(iqeid, adid);
      }
    });
    $('#ad_submit' + iqeid).click(function(event) {
      event.preventDefault();
      return $('#ad_ad_pic' + iqeid).uploadifyUpload();
    });
  };
  root.updateImage = function(iqeid, adid, adsetid) {
    var imgsrc;
    imgsrc = $.ajax({
      url: "http://" + window.location.href.split('/')[2] + "/ad_sets/" + adsetid + "/getNewImage/" + adid + ".js",
      dataType: "text",
      async: true,
      success: function() {
        return root.fixImage(iqeid, adid, imgsrc);
      }
    });
  };
  root.fixImage = function(iqeid, adid, imgsrc) {
    var newsrc;
    newsrc = imgsrc.responseText.trim();
    console.log("Running jquery to update the image with iqeid: " + iqeid);
    $('#existingAdMod' + iqeid + ' img').attr("src", newsrc);
    console.log("done");
  };
}).call(this);
