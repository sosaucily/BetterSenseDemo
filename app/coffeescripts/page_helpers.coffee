root = exports ? this
$ ->
	j_zone_id = $('#ad_zone_id')
	$('#ad_zone_id').change () ->
	  if $("#ad_zone_id option[value='" + j_zone_id + "']").text() is "Video Overlay (Text or Image)"
	    $('videoAd_fields').show()
	  else
	    $('videoAd_fields').hide()
	  return