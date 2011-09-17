#require 'iqengines'

class ApplicationController < ActionController::Base
  protect_from_forgery

  PROCESSEDVIDEOPATH = "processedVideos"
  VIDEODIR = "public/videos"
  IMAGESUBDIR = "images"

  IQE_KEY = '2fd276e7f0ac4a5f948f244fa127cd22'
  IQE_SECRET = '5de565aa46c6464a81fe92c3389a7a0b'
  HOOKBASEURL = 'http://184.72.217.146:3000/'
 
  def populateAdWordTrie()
    if (defined?($adWordTrie)) then return end
    $adWordTrie = Containers::Trie.new
    @dir = "/home/ubuntu/www/BetterSenseDemoDev/data/GoogleKeywordData07192011"
    files = Dir.entries(@dir)
    logger.info "Building ad word trie " + $adWordTrie.to_s

    files.each do |file|
      if (file.index(".csv") != nil) then
        categories = file.split("_")
        categories.map!{|item| if (item.index(".csv") != nil) then item[0..-5] else item end}
        FasterCSV.foreach(@dir + "/" + file,  :col_sep =>',', :row_sep =>:auto) do |row|
          $adWordTrie.push(row[0],categories)
          logger.info "pushing value " + row[0].to_s
        end
        logger.info "completed with file --" + file + "-- and categories " + categories.count.to_s
      end
    end
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
      hookurl = HOOKBASEURL + 'videos/' + video[:id].to_s + '/iqeinfos/' + iqe.id.to_s + '/processme'
      api = IQEngines.Api(IQE_KEY,IQE_SECRET)
      qid, response = api.send_query("./public" + iqe.imagepath, extra=nil, webhook=hookurl, device_id='test123', multiple_results=true, modules=nil, json=true)
      logger.info "api.send_query(./public#{iqe.imagepath}, extra=nil, webhook=#{hookurl}, device_id='test123', multiple_results=true, modules=nil, json=true)"
      sleep 5
    end
  end

  def do_iqe_process_missing (video)
    video.iqeinfos.each do |iqe|
      if iqe.matcheditem == nil
        hookurl = HOOKBASEURL + 'videos/' + video[:id].to_s + '/iqeinfos/' + iqe.id.to_s + '/processme'
        api = IQEngines.Api(IQE_KEY,IQE_SECRET)
        qid, response = api.send_query("./public" + iqe.imagepath, extra=nil, webhook=hookurl, device_id='test123', multiple_results=true, modules=nil, json=true)
        logger.info "api.send_query(./public#{iqe.imagepath}, extra=nil, webhook=#{hookurl}, device_id='test123', multiple_results=true, modules=nil, json=true)"
      end
    end
  end

  def do_image_import (video)
    video_hash = video[:hashstring]
    image_dir = "public/processedVideos/" + video_hash + "/" + IMAGESUBDIR + "/*"
    @files = Dir.glob(image_dir)
    @files.sort!
    #logger.info 'checking directory - ' + image_dir
    for file in @files
      #logger.info 'file name is: ' + file
      #logger.info 'creating an iqeinfo object for this video'
      iqeinfo = video.iqeinfos.build(:results => "test iqeinfo", :imagepath =>  "/" + file[7,file.size-7])
      #logger.info 'done'
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
