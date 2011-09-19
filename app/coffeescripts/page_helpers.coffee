root = exports ? this
$ ->
	$('#ad_zone_id').change () ->
	  update_videoad_fields()
	  return
	update_videoad_fields = () ->
	  j_zone_id = $('#ad_zone_id').val()
	  if $("#ad_zone_id option[value='" + j_zone_id + "']").text() is "Video Overlay (Text or Image)"
	    $('#videoAd_fields').show()
	  else
	    $('#videoAd_fields').hide()
	  return
	update_videoad_fields() #Call this once on page load.
	return
