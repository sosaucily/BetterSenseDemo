flowplayer("player", "/flash/flowplayer-3.2.8.swf", {
	playlist: [
		{
			url: "/processedVideos/dc73d48f3148ad3232cf3334d4425c13/video/Casino_Royale_Product_Placement.flv",
			duration: 72
		}
	],
	plugins: 
	{
		controls: {
			url: '/flash/flowplayer.controls-3.2.8.swf',
			fullscreen: false
		}
		/*ova: {
			"url": "/flash/ova-1.0.1.swf",
			"ads": {
				"servers": [
					{
				       	"type": "OpenX",
						"apiAddress": "http://d1.openx.org/fc.php?script=bannerTypeHtml:vastInlineBannerTypeHtml:vastInlineHtml&zones=pre-roll:0.0-0%3D257503&nz=1&source=&r=R0.2028159899637103&block=1&format=vast&charset=UTF-8",
						"allowAdRepetition": true
					}
		     	],
				"schedule": [
					{
						"zone": "257503",
						"position": "auto:bottom",
						"width": 440,
						"height": 93,
						"duration": 3,
						"startTime": "00:00:03"
					},
					{
						"zone": "257503",
						"position": "auto:bottom",
						"width": 440,
						"height": 93,
						"duration": 3,
						"startTime": "00:00:09"
					},
					{
						"zone": "257503",
						"position": "auto:bottom",
						"width": 440,
						"height": 93,
						"duration": 3,
						"startTime": "00:00:15"
					}
				]
			},
			"debug": {
                "levels": "fatal, config, vast_template, display_events, playlist, http_calls, api, segment_formation, analytics, tracking_events",
                "debugger": "firebug"
            }
		}*/
	}, //Close Plugins
	clip: {
	    // stop at the first frame and start buffering
		autoPlay: false,
		autoBuffering: true,
		onStart: function() {
			var self = this;
			v_meta = window.video_metadata["video_metadata"];
	        //var timer = setInterval(function() {
	        //  document.getElementById('videoTime').html(self.getTime());

	          // when playback is stopped clear timer
	          //if (self.getState() == 5) clearInterval(timer);
	        //}, 1000);
			scene_count = 0;
			prev_cuepoint = 0;

	        $f().onCuepoint(
	          getCuepoints($f().getClip(0)),
	          function(clip, cuepoint) {
				//console.log ("cue - prev_cue = " + (cuepoint - prev_cuepoint));
				console.log ("Current Cuepoint: " + cuepoint.time)
				if ( ( (cuepoint - prev_cuepoint) > 1000) || ( (cuepoint - prev_cuepoint) < 0 ) ) {
					setDemoTextToTime(cuepoint);
				}
				prev_cuepoint = cuepoint;
	            //This will act every second of video, with the variable "cuepoint" holding the current number of millis
				console.log("at cuepoint: " + cuepoint);
				//console.log(window.video_metadata);
	            if ( ("elem_" + (cuepoint/1000)) in v_meta["frames"])
	            {
	              $('#curr_keyword').fadeOut('fast', function() { 
	                $('#curr_keyword').html(window.video_metadata["video_metadata"]["frames"]["elem_" + (cuepoint/1000)]["keyword"] + " - " +  window.video_metadata["video_metadata"]["frames"]["elem_" + (cuepoint / 1000)]["relevance"]);
					//$('#curr_keyword').html("hi");
	                //$('#categories').html(keywordCat[cuepoint / 1000]);
	                $('#curr_keyword').fadeIn('fast'); 
	              });  
	            }

				if ( ("elem_" + (cuepoint/1000)) in v_meta["scenes"])
				{
					printDemoText(cuepoint/1000,"none");
				}
          	});
      }
   }//Close CLIP
});

function setDemoTextToTime(new_cuetime) {
	window.scene_count = 0;
	console.log("in new method");
	updated_content = getDemoBoxHeader("inline");
	for (curr_time = 0; curr_time <= new_cuetime; curr_time += 1000)
	{
		if ( ("elem_" + (curr_time/1000)) in window.v_meta["scenes"])
		{
			if (window.v_meta["scenes"]["elem_" + (curr_time/1000)]["keywords"].length > 0) //Make sure there are some keywords to be had.
			{
				window.scene_count += 1;
				updated_content += getDemoBoxText(curr_time/1000);
			}
		}
	}
	console.log("in new method - 2");
	$('#demo_info_box').html( updated_content );
	console.log("in new method - 3");
	/*$('#initial_demo_text').toggle(function() {
		$('#demo_info_box').find("span").css('display','none').toggle();
	});*/
	console.log("in new method - 4");
	$('#demo_info_box').scrollTop(9999999);
}

function getCuepoints(clip) {
  var cuepoints = new Array();
  for (i=0; i < clip.duration; i++)
  {
    cuepoints [i] = i*1000;
  }
  return cuepoints;
}

$(function() {
	initial_timer = setTimeout('setupDemoText("none");', 1000);
});

function setupDemoText(display) {
	v_meta = window.video_metadata["video_metadata"];
	$('#demo_info_box').html(getDemoBoxHeader(display));
	$('#initial_demo_text').fadeIn();
}

function getDemoBoxHeader(display) {
	v_meta = window.video_metadata["video_metadata"];
	return ('<span id="initial_demo_text" style="display:'+display+';">' + 
		v_meta["title"] + 
		'<br />Title: ' + 
		v_meta["videoName"] + 
		'</span><br /><div style="width:300px;padding:0 0 0 4px;"><hr /></div><br />');
}

function getDemoBoxText(curr_cuepoint, display) {
	curr_scene = window.video_metadata["video_metadata"]["scenes"]["elem_" + curr_cuepoint];
	if (curr_scene["keywords"].length <= 0) //Make sure there are some keywords to be had.
	{
		return ('<span id="elem_' + curr_cuepoint + '" style="display:none;" />');
	}
	relevance_break = "";
	for (i=0; i < curr_scene["keywords"][0]["keyword"].length; i++)
		if (i > 6)
			relevance_break += "&nbsp;";
	curr_demo_value = '<span id="elem_' + curr_cuepoint + '" style="display:'+display+';">' + 
		'<strong>Scene ' + window.scene_count + ':</strong> ' + curr_scene["startTime"] + " - " + curr_scene["stopTime"] + "<br />" + 
		'<div style="display:inline-block;">' + 
		'<div style="display:inline-block;">Top Keyword: ' + curr_scene["keywords"][0]["keyword"] + '<br />Relevance: ' + curr_scene["keywords"][0]["relevance"] + '</div>' + 
		'<div style="display:inline-block;padding-left:20px;">Top Category: ' + curr_scene["categories"][0]["category"] + '<br />Relevance: ' + curr_scene["categories"][0]["relevance"] + '</div>' + 
		'</div>' + 
		'</span><br /><br />';
	return (curr_demo_value);
}

function printDemoText(curr_cuepoint, display) {
	window.scene_count += 1;
	curr_scene = window.video_metadata["video_metadata"]["scenes"]["elem_" + curr_cuepoint];
	curr_demo_value = $('#demo_info_box').html();
	$('#demo_info_box').html( curr_demo_value + "" + getDemoBoxText(curr_cuepoint,display) );
	$('#elem_' + curr_cuepoint).fadeIn();
	$('#demo_info_box').scrollTop(9999999);
}