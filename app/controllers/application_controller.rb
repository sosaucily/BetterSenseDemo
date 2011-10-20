require 'iqengines'

class ApplicationController < ActionController::Base
  protect_from_forgery

  VIDEODIR = BetterSenseDemo::APP_CONFIG["videos_dir"]
  IMAGESUBDIR = "images"

  IQE_KEY = '2fd276e7f0ac4a5f948f244fa127cd22'
  IQE_SECRET = '5de565aa46c6464a81fe92c3389a7a0b'
  HOOKBASEURL = BetterSenseDemo::APP_CONFIG["base_url"]

  def validate_account_id(account_id)
    if (!session.include? "account_id" or (account_id.to_i != session[:account_id].to_i))
      return lambda {
        flash[:alert] = "Sorry, you don't have access to that page."
        redirect_to '/account'
        return true
      }
    else
      return lambda {return nil}
    end
  end

  #rediretion after login for Devise  
  def after_sign_in_path_for(resource)
    #This method needs the overwritten 'stored_location_for' method below otherwise this method won't run when a user is redirected to the login page from a protected page.
    if (resource.is_a? User)
      logger.info "Login recorded from User with id:" + resource.id.to_s
      #clear_session_data
      setup_session_from_User(resource)
      if (session.include? :user_return_to) then
        session.delete :user_return_to #This also returns the value of this session variable, used for redirect
      else
        '/account'
      end
    elsif (resource.is_a? Admin)
      logger.info "Login recorded from Admin with id:" + resource.id.to_s
      '/sysadmin'
    end
  end
  
  def stored_location_for(resource)
    #if (current_user) then
    #elsif (current_admin)
    #end
    return nil
    #super(resource)
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
        add_data_to_image(iqe, JSON.parse(response)["data"]["results"])
      else
        hookurl = HOOKBASEURL + '/videos/' + video[:id].to_s + '/iqeinfos/' + iqe.id.to_s + '/processme'
        api = IQEngines.Api(IQE_KEY,IQE_SECRET)
        qid, response = api.send_query("./public" + iqe.imagepath, extra=nil, webhook=hookurl, device_id='test123', multiple_results=true, modules=nil, json=true)
        logger.info "api.send_query(./public#{iqe.imagepath}, extra=nil, webhook=#{hookurl}, device_id='test123', multiple_results=true, modules=nil, json=true)"
        sleep 3
      end
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
          add_data_to_image(iqe, JSON.parse(response)["data"]["results"])
        else
          hookurl = HOOKBASEURL + '/videos/' + video[:id].to_s + '/iqeinfos/' + iqe.id.to_s + '/processme'
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
  
  def add_data_to_image (iqe, qid_data) # This needs to be a DelayedJob...
    logger.debug qid_data
    labels = ""
    qid_data.each do |qid|
      labels += qid["qid_data"]["labels"] + " | "
    end
    color = qid_data[0][:color]
    iqe.matcheditem = labels
    iqe.colors = color
    iqe.save
  end
  
private

  def check_session
    logger.debug "Checking session"
    if (session[:account_id].nil? or session[:account_id] <= 0)
      if (user_signed_in?)
        setup_session_from_User(current_user)
      else
        flash[:alert] = "Error with user session, please try to log in again."
        redirect_to '/'
      end
    end
  end
  
  def setup_session_from_User(resource)
    session[:account_id] = resource.account_id
    logger.debug "Setting account id to " + resource.account_id.to_s
  end

end
