/* DO NOT MODIFY. This file was compiled Fri, 18 Nov 2011 01:17:24 GMT from
 * /Users/jessesmith/Documents/BetterSense/www/BetterSenseDemoDev/BetterSenseDemo/app/coffeescripts/page_helpers.coffee
 */

(function() {
  var root;
  root = typeof exports !== "undefined" && exports !== null ? exports : this;
  $(function() {
    var update_videoad_fields;
    $('#ad_zone_id').change(function() {
      update_videoad_fields();
    });
    update_videoad_fields = function() {
      var j_zone_id;
      j_zone_id = $('#ad_zone_id').val();
      if ($("#ad_zone_id option[value='" + j_zone_id + "']").text() === "Video Overlay (Text or Image)") {
        $('#videoAd_fields').show();
      } else {
        $('#videoAd_fields').hide();
      }
    };
    update_videoad_fields();
  });
}).call(this);
