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
  
end
