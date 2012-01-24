module VideosHelper
  #require 'kaltura'
  def getKalturaIDByName (video_name)
    filter = Kaltura::Filter::MediaEntryFilter.new
    filter.name_like = video_name
    #
    KalturaFu.check_for_client_session
    media = KalturaFu::Session.client.media_service.list(filter)
    if media.objects.nil?
      logger.debug("Could not find a single video instance for Video named: " + video_name.to_s)
      return nil
    end
    case media.objects.count
    when 1
      logger.debug("Kaltura search returned video with ID: " + media.objects[0].id)
      return media.objects[0].id
    else
      logger.debug("Could not find a single video instance for Video named: " + video_name.to_s)
    end
    return nil
  end
  
  def getThumbnailWithPlayButton (kal_entry_id, thumb_options, play_button_wh)
    thumb_x = thumb_options[:size].first
    thumb_y = thumb_options[:size].last
    thumb_left_marg = (thumb_x.to_f/2.0 - play_button_wh.to_f/2.0).to_i
    thumb_top_marg = ( (thumb_y.to_f/2.0) - play_button_wh.to_f/2.0).to_i
    
    '<div style="width:' + thumb_x.to_s + 'px; height:' + thumb_y.to_i.to_s + 'px; position:relative;"><div style="width:' + thumb_x.to_s + 'px; height:' + thumb_y.to_i.to_s + 'px; position:absolute; z-index:1;">' + kaltura_thumbnail(kal_entry_id, thumb_options) + '</div><div style="width:' + play_button_wh.to_s + 'px; height:' + play_button_wh.to_i.to_s + 'px; position:absolute; z-index:2; margin-left:' + thumb_left_marg.to_s + 'px; margin-top:' + thumb_top_marg.to_s + 'px;"><img width="' + play_button_wh.to_s + '" height="' + play_button_wh.to_s + '" src="http://localhost:3000/images/play_button_50_50.png" /></div></div>'
    
  end
  
  #I'm going to need some kind of status for the videos, so in the polling I know which ones to operate on.
  def send_to_backend (the_video)
    #Call backend system to make an entry in the backend system for the video
    #Build video parameters for creating new Video
    video_params = {:params=>{:action=>"submit",:display_name=>the_video.name||the_video.vid_file_file_name, :video_description=>the_video.description||"", :account_id=>the_video.account_id, :friendly_id=>the_video.id, :video_meta_tags=>[]} }
    submit_url = BetterSenseDemo::APP_CONFIG["backend_base_url"] + BetterSenseDemo::APP_CONFIG["backend_video_url"]
    logger.info("Submitting video to backend with command: " + submit_url + video_params.to_json)
    response = RestClient.get(submit_url, video_params)
    if (response.code != 200)
      logger.error("Submitted Video to backend, but received a failure.  Printing video data: " + the_video.inspect)
      return
    end

    #Move the video to the backend folder. (Can this be done over HTTP to allow for separate machines?)
    new_video_file_name = the_video.id.to_s + the_video.vid_file_file_name[the_video.vid_file_file_name.length-4..-1]
    response = RestClient.post submit_url+"/accept_video", :file_id => new_video_file_name, :video_file => File.new(Rails.root.to_s + BetterSenseDemo::APP_CONFIG["upload_video_dir"] + the_video.id.to_s + BetterSenseDemo::APP_CONFIG["upload_video_sub_dir"] + the_video.vid_file_file_name, 'rb')
    
    #logger.info(response.to_s)
    if (response.code != 200)
      logger.error("Transferred Video to backend, but received a failure.  Printing video data: " + the_video.inspect)
      return
    end
    logger.info("Successfully transfered video to backend system.  Deleting video file.")
    the_video.vid_file = nil
    the_video.save
    the_video.poll_for_video_status_change(the_video)
  end
  handle_asynchronously :send_to_backend, :run_at => Proc.new { BetterSenseDemo::APP_CONFIG["send_video_to_backend_seconds"].to_i.seconds.from_now }
  
  #This is an asynchronous background function using Delayed_Job.  Settings follow the method declaration below.
  def poll_for_video_status_change (the_video)
    #Do a retrieve and see if the status has information that we don't currently have on the video object.
    #If true, update the video (which will give the user different functions on the website, and may fire an email)
    current_status = the_video.status || "new" #The default is "new"
    video_params = {:params=>{:action=>"retrieve",:friendly_id=>the_video.id} }
    retrieve_url = BetterSenseDemo::APP_CONFIG["backend_base_url"] + BetterSenseDemo::APP_CONFIG["backend_video_url"]
    response = RestClient.get(retrieve_url, video_params)
    if (response.code != 200)
      logger.error("Error retreiving video info from backend system: " + the_video.inspect)
      return
    end
    video_data = JSON.load(response.body.to_s)
    new_status = video_data['status']['bettersense_status'].to_s
    logger.info("Body of retrieve query is: " + video_data.to_s)
    logger.info("Received Status is " + new_status)
    if (new_status.nil? || new_status == "")
      the_video.poll_for_video_status_change (the_video)
      return
    end
    if (new_status == "error")
      the_video.status = new_status
      the_video.save
      error_message = video_data['status']['error_message'].to_s
      logger.error("Error processing video on backend.  Message: " + error_message)
      return
    end
    
    #Loop through waiting for a status change.  When it does change, do something
    if (current_status == "new" || current_status == "created" || current_status == "processing")
      #If new_status = "processed"
      if (new_status == "processed")
        the_video.status = new_status
        the_video.save
        return        
      elsif (new_status != current_status)
        the_video.status = new_status
        the_video.save
        current_status = new_status
        #sleep(15.seconds)
        the_video.poll_for_video_status_change (the_video)
        return
      else
        #sleep(15.seconds)
        the_video.poll_for_video_status_change (the_video)
        return
      end
    elsif (current_status == "ordered" || current_status == "analyzing" || current_status == "analyzed")
      if (new_status == "complete")
        the_video.status == new_status
        the_video.save
        return
      elsif (new_status != current_status)
        the_video.status == new_status
        the_video.save
        current_status = new_status
        #sleep(15.seconds)
        the_video.poll_for_video_status_change (the_video)
        return
      else
        #sleep(15.seconds)
        the_video.poll_for_video_status_change (the_video)
        return
      end
      
    else
      logger.error ("received an unknown video status from backend system " + new_status.to_s)
    end

  end
  handle_asynchronously :poll_for_video_status_change, :run_at => Proc.new { BetterSenseDemo::APP_CONFIG["poll_for_video_status_change_seconds"].to_i.seconds.from_now }
  
  def order_video (the_video, quality = 'basic')
    #Analyze video
    if (quality.nil? || quality != 'premium')
      quality = 'basic'
    end
    current_status = the_video.status
    the_video.order_status = "ordered"
    video_params = {:params=>{:action=>"analyze",:friendly_id=>the_video.id,:quality=>quality} }
    analyze_url = BetterSenseDemo::APP_CONFIG["backend_base_url"] + BetterSenseDemo::APP_CONFIG["backend_video_url"]
    response = RestClient.get(analyze_url, video_params)
  end
  handle_asynchronously :order_video
  
  def get_reports (the_video)
    #Transfer the reports to a local folder for the user to download and be accessible from a javascript API
  end
  
end
