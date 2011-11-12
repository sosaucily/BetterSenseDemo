root = exports ? this #This line sets up the public methods under the 'root' scope on the page's javascript

#Creates the buttons dynamically for each unique item (image)  These have a unique ID, and thus must be created dynamically.
root.registerNewButtons = (id) ->
  overlayButton = $('#newOverlayButton' + id)
  companionButton = $('#newCompanionButton' + id)
  overlayButton.click -> 
    $('#newOverlayFieldsContainer' + id).toggle()
  companionButton.click ->
    $('#newCompanionFieldsContainer' + id).toggle()
  return

#Build setting to use uploadify for images.  This enables javascript uploads of files.
root.uploadifyAdItems = (iqeid, adid, adsetid, buttonText = 'Select Image') ->
  $('#ad_ad_pic' + iqeid).click (event) ->
    event.preventDefault()

  $('#ad_ad_pic' + iqeid).uploadify(
    'uploader'    : '/flash/uploadify.swf',
    'script'      : '/ad_sets/' + adsetid + '/updateAd.js',
    'multi'       : true,
    'auto'        : true,
    'cancelImg'   : '/images/cancel.png',
    'buttonText'  : '' + buttonText,
    'sizeLimit'   : 102400,
    'multi'       : false,
    'scriptData'  : {'id': adid, "commit": "Update Ad" },
    'onComplete'  : (event, ID, fileObj, response, data) ->
      root.updateImage(iqeid, adid)
    )

  $('#ad_submit' + iqeid).click (event) ->
    event.preventDefault()
    $('#ad_ad_pic' + iqeid).uploadifyUpload()
  return

#ajax call to update the image after the uploadify has completed.
root.updateImage = (iqeid, adid, adsetid) ->
  imgsrc = $.ajax({url:"http://" + window.location.href.split('/')[2] + "/ad_sets/" + adsetid + "/getNewImage/" + adid + ".js", dataType: "text", async: true, success: () ->
    root.fixImage(iqeid, adid, imgsrc)
  })
  return

#Change the image when uploadify has replaced the existing image.
root.fixImage = (iqeid, adid, imgsrc) ->
  newsrc = imgsrc.responseText.trim()
  console.log ("Running jquery to update the image with iqeid: " + iqeid);
  $('#existingAdMod' + iqeid + ' img').attr("src",newsrc);
  console.log("done")
  return
