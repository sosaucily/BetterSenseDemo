require 'iqengines'

class ApplicationController < ActionController::Base
  protect_from_forgery

  VIDEODIR = BetterSenseDemo::APP_CONFIG["videos_dir"]
  IMAGESUBDIR = "images"

  IQE_KEY = '2fd276e7f0ac4a5f948f244fa127cd22'
  IQE_SECRET = '5de565aa46c6464a81fe92c3389a7a0b'
  HOOKBASEURL = BetterSenseDemo::APP_CONFIG["base_url"]

  #rediretion after login for Devise
  def after_sign_in_path_for(resource)
    stored_location_for(resource) || '/admin'
  end
 
  def process_video (video)
    logger.info 'processing video at path ' + video[:name]
    video_actions = params[:videoAction]
    video_actions.sort!
    for v_action in video_actions do
      case v_action
      when "200importImages"
        logger.info 'doing import of images on this video' 
        do_image_import (video)
      when "100clearImages"
        logger.info 'doing a clear of images on this video'
        do_image_clear (video)
      when "300iqeprocess"
        logger.info 'processing images with IQE'
        do_iqe_process (video)
      when "400iqeprocessmissing"
        logger.info "processing missing images with IQE"
        do_iqe_process_missing (video)
      end
    end
    'Completed processing video ' + video[:id].to_s
  end

  def do_iqe_process (video)
    video.iqeinfos.each do |iqe|
      if (Rails.env.development?) then
        api = IQEngines.Api(IQE_KEY,IQE_SECRET)
        qid, response = api.send_query("./public" + iqe.imagepath) #, multiple_results=true, json=true
        logger.debug("Waiting for response from IQE")
        response = api.wait_results()
        logger.info(response)
        logger.debug("done")
      else
        hookurl = HOOKBASEURL + 'videos/' + video[:id].to_s + '/iqeinfos/' + iqe.id.to_s + '/processme'
        api = IQEngines.Api(IQE_KEY,IQE_SECRET)
        qid, response = api.send_query("./public" + iqe.imagepath, extra=nil, webhook=hookurl, device_id='test123', multiple_results=true, modules=nil, json=true)
        logger.info "api.send_query(./public#{iqe.imagepath}, extra=nil, webhook=#{hookurl}, device_id='test123', multiple_results=true, modules=nil, json=true)"
        sleep 3
      end
      return
    end
  end

  def do_iqe_process_missing (video)
    video.iqeinfos.each do |iqe|
      if iqe.matcheditem == nil
        if (Rails.env.development?) then
          api = IQEngines.Api(IQE_KEY,IQE_SECRET)
          qid, response = api.send_query("./public" + iqe.imagepath, extra=nil, webhook=nil, device_id='test123', multiple_results=true, modules=nil, json=true)
          response = api.wait_results()
          logger.info(response)
        else
          hookurl = HOOKBASEURL + 'videos/' + video[:id].to_s + '/iqeinfos/' + iqe.id.to_s + '/processme'
          api = IQEngines.Api(IQE_KEY,IQE_SECRET)
          qid, response = api.send_query("./public" + iqe.imagepath, extra=nil, webhook=hookurl, device_id='test123', multiple_results=true, modules=nil, json=true)
          logger.info "api.send_query(./public#{iqe.imagepath}, extra=nil, webhook=#{hookurl}, device_id='test123', multiple_results=true, modules=nil, json=true)"
        end
      end
    end
  end

  def do_image_import (video)
    video_hash = video[:hashstring]
    image_dir = Rails.root.to_s + BetterSenseDemo::APP_CONFIG["processed_videos_dir"] + "/" + video_hash + "/" + IMAGESUBDIR + "/*"
    @files = Dir.glob(image_dir)
    @files.sort!
    logger.debug 'checking directory - ' + image_dir
    for file in @files
      logger.debug 'file name is: ' + file
      logger.debug 'creating an iqeinfo object for this video'
      start_char = file.index("processedVideos")
      iqeinfo = video.iqeinfos.build(:results => "test iqeinfo", :imagepath =>  "/" + file[start_char,file.size])
      logger.debug 'done'
      iqeinfo.save
    end
  end

  def do_image_clear (video)
    video.iqeinfos.each do |i|
      i.delete
    end
  end

  def process_video_path_custom (video)
    doing_process = 1
    "videos/" + video[:id]
  end

end
