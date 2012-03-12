flowplayer("player", "/flash/flowplayer-3.2.7.swf", {
    clip: {
    // stop at the first frame and start buffering
    autoPlay: false,
    autoBuffering: false,
	onStart: function() {
        var self = this;
		v_meta = window.video_metadata["video_metadata"];
        //var timer = setInterval(function() {
        //  document.getElementById('videoTime').html(self.getTime());
          
          // when playback is stopped clear timer
          //if (self.getState() == 5) clearInterval(timer);
        //}, 1000);
		scene_count = 0
          
        $f().onCuepoint(
          getCuepoints($f().getClip(0)),
          function(clip, cuepoint) {
            //This will act every second of video, with the variable "cuepoint" holding the current number of millis
			console.log("at cuepoint: " + cuepoint);
			//console.log(window.video_metadata);
            if ( ("elem_" + (cuepoint/1000)) in v_meta["frames"])
            {
              $('#curr_keyword').fadeOut('fast', function() { 
                $('#curr_keyword').html(window.video_metadata["video_metadata"]["frames"]["elem_" + (cuepoint/1000)]["keyword"] + " - " +  window.video_metadata["video_metadata"]["frames"]["elem_" + (cuepoint / 1000)]["relevance"]);
				//$('#curr_keyword').html("hi");
                //$('#categories').html(keywordCat[cuepoint / 1000]);
                $('#curr_keyword').fadeIn('slow'); 
              });  
            }
			
			if ( ("elem_" + (cuepoint/1000)) in v_meta["scenes"])
			{
				scene_count += 1;
				curr_scene = v_meta["scenes"]["elem_" + (cuepoint/1000)];
				curr_demo_value = $('#demo_info_box').html()
				$('#demo_info_box').html(curr_demo_value + '<span id="elem_' + (cuepoint/1000) + '" style="display:none;">' + 
					'Scene ' + scene_count + ': ' + curr_scene["startTime"] + " - " + curr_scene["stopTime"] + "<br />" + 
					'Top Keyword: ' + curr_scene["keywords"][0]["keyword"] + '&nbsp; &nbsp; &nbsp; ' + 'Top Category: ' + curr_scene["categories"][0]["category"] + "<br />" + 
					'&nbsp;&nbsp;Relevance: ' + curr_scene["keywords"][0]["relevance"] + '&nbsp; &nbsp; &nbsp; Relevance: ' + curr_scene["categories"][0]["relevance"] + 
					'</span><br /><br />');
				$('#elem_' + (cuepoint/1000)).fadeIn();
				$('#demo_info_box').scrollTop(9999999);
			}
          });
      } 
   }
});

function getCuepoints(clip) {
  var cuepoints = new Array();
  for (i=0; i < clip.duration; i++)
  {
    cuepoints [i] = i*1000;
  }
  return cuepoints;
}

$(function() {
	initial_timer = setTimeout('setupDemoText();', 1000);
});

function setupDemoText() {
	v_meta = window.video_metadata["video_metadata"];
	$('#demo_info_box').html('<span id="initial_demo_text" style="display:none;">' + 
		v_meta["title"] + 
		'<br />Title: ' + 
		v_meta["videoName"] + 
		'</span><br /><br />');
	$('#initial_demo_text').fadeIn();
}