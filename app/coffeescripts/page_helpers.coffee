root = exports ? this #This line sets up the public methods under the 'root' scope on the page's javascript
$ -> #JQuery initializer so this code runs after the page loads, when JQuery is ready

	$('#ad_zone_id').change () ->
	  update_videoad_fields()
	  return
	#Helper method for toggling video ad module
	update_videoad_fields = () ->
	  j_zone_id = $('#ad_zone_id').val()
	  if $("#ad_zone_id option[value='" + j_zone_id + "']").text() is "Video Overlay (Text or Image)"
	    $('#videoAd_fields').show()
	  else
	    $('#videoAd_fields').hide()
	  return
	update_videoad_fields() #Call this once on page load.
	return
