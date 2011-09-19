var urlParams = {};
(function () {
  var e,
      a = /\+/g,  // Regex for replacing addition symbol with a space
      r = /([^&=]+)=?([^&]*)/g,
      d = function (s) { return decodeURIComponent(s.replace(a, " ")); },
      q = window.location.search.substring(1);

  while (e = r.exec(q))
     urlParams[d(e[1])] = d(e[2]);
})();

var tag_url = "http://www.bettersense.com:3000/tag/deliver?ad_set_id=" + urlParams["ad_set_id"];
var impress_url = "http://www.bettersense.com:3000/regimpress?id=";
var ad_data;
var myEmbedPlayer;
var result;
var adCount = 0;
var interval_handle;
var impress_flag = false;

$.getJSON(tag_url+"&callback=?", function(data) {
  console.log(data);
  ad_data = data;
});

function setup_stuff() {
  myEmbedPlayer = $('.mv-player #kaltura_player');
  loadAds(ad_data[adCount]);
  adCount++;
}

$( function () {
  $('.play-btn').click( function() {
  });
});

$( function () {
  $('.play-btn-large').click( function() {
  });      
});

var monitorTimer = function () {
  //console.log("timer check");
  if (myEmbedPlayer==undefined || ad_data==undefined)
  {
    //console.log("Ad data not ready, returning from timer check");
    return;
  }

  var currTime = myEmbedPlayer[0].currentTime;
  var currAdStart = ad_data[adCount-1].start;
  var currAdTimeout = ad_data[adCount-1].timeout;

  if ((adCount >= ad_data.length) && ((currTime+1) > currAdStart + currAdTimeout))
  {
    console.log ("no more ads, clearing interval timer");
    overlayAd =  myEmbedPlayer[0].AdTimeline.timelineTargets.overlay;
    overlayAd.splice(0,1);
    window.clearInterval(interval_handle);
  }

  //console.log("currTime: " + currTime + " - currAdStart: " + currAdStart + " - currAdTimeout: " + currAdTimeout);
  if (currTime > currAdStart + currAdTimeout)
  {
    console.log("Moving to the next adItem")
    updateOverlay(ad_data[adCount-1],ad_data[adCount]);
    adCount++;
    impress_flag = false;
  }
    //console.log("exiting timer check");

  //Fire Impression if ad is being viewed
  if (!impress_flag)
  {
    overlayAd =  myEmbedPlayer[0].AdTimeline.timelineTargets.overlay[0];
    ad_id = ad_data[adCount-1].ad_id
    if (overlayAd.currentlyDisplayed)
    {
      $.ajax({url: impress_url + "" + ad_id});
      impress_flag = true;
    }
  }
}

function loadAds(data)
{
  console.log("Adding first ad");
  myEmbedPlayer[0].AdTimeline = new mw.AdTimeline(myEmbedPlayer[0]);
  myEmbedPlayer[0].AdTimeline.adOverlaysEnabled = true;
  mw.addAdToPlayerTimeline( myEmbedPlayer[0], 'overlay', data);
  console.log("done");
}

function updateOverlay(old_ad,new_ad)
{
  console.log("Adding next ad (" + adCount + ")");
  overlayAd =  myEmbedPlayer[0].AdTimeline.timelineTargets.overlay[0];
  overlayAd.frequency = (new_ad.start - old_ad.timeout) - old_ad.start;
  overlayAd.timeout = new_ad.timeout;
  nonLinAd = overlayAd.ads[0].nonLinear[0];
  nonLinAd.html = new_ad.ads[0].nonLinear[0].html;
  console.log("Current Ad Values -- new start: " + new_ad.start + " - old start: " + old_ad.start + " - old duration: " + old_ad.timeout + " - new frequency: " + overlayAd.frequency + " - new timeout " + overlayAd.timeout);
  console.log("done");
}

setTimeout('setup_stuff()',3000);
interval_handle = window.setInterval("monitorTimer()", 200);

