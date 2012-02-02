root = exports ? this #This line sets up the public methods under the 'root' scope on the page's javascript

$ ->

	root.update_video_params = () ->
        root.video_parameters["description"] = $('#video_description').val()
        root.video_parameters["name"] = $('#video_name').val()
        root.$('#video_vid_file').uploadifySettings 'scriptData', root.video_parameters, true
        return

    root.$('#video_description').change () ->
        root.update_video_params()
        return

    root.$('#video_name').change () ->
        root.update_video_params()
        return

    root.clear_upload_fields = () ->
        root.$('#video_name')[0].value = ""
        root.$('#video_description')[0].value = ""
        return

    root.do_upload = () ->
        if confirm_upload()
            console.log "Uploading!!"
            root.$('#video_vid_file').uploadifyUpload()
            root.clear_upload_fields()
        return

    confirm_upload = () ->
        if root.file_count is 0
          alert "Please select a video file to upload."
          return false
        return root.confirm "Ready to Upload the video?\n" + 
          "Name: " + root.video_parameters["name"] + "\n" + 
          "Description: " + root.video_parameters["description"] + "\n"

    root.update_file_count = (count = 0) ->
          root.file_count = count

    root.update_file_count 0

    return


#Build setting to use uploadify for images.  This enables javascript uploads of files.
root.uploadifyVideo = (buttonText = 'Select Video', upload_video_data = {}) ->
  $('#video_vid_file').click (event) ->
    event.preventDefault()
    return

  $('#video_vid_file').uploadify(
    'uploader'    : '/flash/uploadify.swf',
    'script'      : '/videos', #I believe this should create the new video object in rails.
    'method'      : 'post',
    'multi'       : false,
    'auto'        : false,
    'cancelImg'   : '/images/cancel.png',
    'fileExt'     : '*.mp4;*.flv',
    'buttonText'  : '' + buttonText,
    'sizeLimit'   : 204800000, #approx 10 megs?
    'scriptData'  : upload_video_data,
    'folder'      : '/Users/jessesmith/Documents/BetterSense/www/BetterSenseDemoDev/BetterSenseDemo/',
    'onOpen'      : (event, ID, fileObj) ->
      console.log(upload_video_data)
      return
    'onError'     : (event, ID, fileObj, errorObj) ->
      alert(errorObj.type + ' Error: ' + errorObj.info)
      return
    'onCancel'    : (event, ID, fileObj, data) ->
      root.update_file_count(0)
      return
    'onSelect'    : (event, ID, fileObj) ->
      root.update_file_count(1)
      return
    'onComplete'  : (event, ID, fileObj, response, data) ->
      root.$('#refresh_videos').click()
      return
    )
#  $('#ad_submit' + iqeid).click (event) ->
 #   event.preventDefault()
  #  $('#ad_ad_pic' + iqeid).uploadifyUpload()
  return
