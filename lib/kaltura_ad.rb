class KalturaAd
  include ApplicationHelper

  def initialize
    @ad_params =
    {
      :timeout => 2,
      :frequency => 0,
      :opacity => 0.65,
      :alpha => 65,
      :start => 1,
      :width => 350,
      :height => 40,
      :font_size => "large",
      :background_color => "#737373",
      :padding_left => "4px",
      :padding_right => "4px",
      :padding_top => "2px",
      :padding_bottom => "2px",
      :a_color => "white",
      :a_hover_color => "gray",
      :a_visited_color => "white"
    }
  end

  def buildAds ad_list
    count = 0
    output = [] #This is a hash of hashes that are used as Kaltura HTML5 player ad sets
    ad_list = ad_list.select {|a| a.zone.zone_type.name == "Video Overlay"}.sort_by{|a| a.time_millis}
    ad_list.each { |a|
      if (a.zone.zone_type.name == "Video Overlay") then
        #if (defined? output[a.iqeinfo_id] and !output[a.iqeinfo_id].nil?) then
        #  output[a.iqeinfo_id.to_s].deep_merge!(buildOverlayAd(a))
        #else
        output[count] = buildOverlayAd(a)
        count = count+1
        #end
      elsif (a.zone.name == "Standard Video Companion") then
        #if (defined? output["'" + a.iqeinfo_id.to_s + "'"] and !output["'" + a.iqeinfo_id + "'"].nil?) then
        #  output["'" + a.iqeinfo_id.to_s + "'"].deep_merge!(buildCompanionAd(a))
        #else
        output[count] = buildCompanionAd(a)
        count = count + 1
        #end
      else 
        Rails.logger.info("Ad of non-video type, skipping")
      end
    }
    output
  end

  private

  def buildOverlayAd ad

    overlay_content = ""
    @ad_params[:timeout] = ad.duration_millis/1000 unless ad.duration_millis.nil?
    @ad_params[:start] = ad.time_millis/1000 unless ad.time_millis.nil?
    target_url = ad.image_url || "http://www.bettersense.com"
    ad_target = URI.escape(target_url, Regexp.new("[^#{URI::PATTERN::UNRESERVED}]"))
    ad_id = ad.id
    content_type = ad.overlay_content_type || "image"

    case content_type
    when "html"
      if (ad.html_src.nil? or ad.html_src == "") then
        if ad.ad_pic_url.nil?
          content_type = "invalid"
        else
          content_type = "image"
        end
      end
    when "image"
      if ad.ad_pic_file_name.nil? then
        if (ad.html_src.nil? or ad.html_src == "") then
          content_type = "invalid"
        else
          content_type = "html"
        end
      end
    end
	
    case content_type
    when "html"
      overlay_content = markdown(ad.html_src)
    when "image"
      overlay_content = '<img style="width:100%;height:100%" src="' + ad.ad_pic.url + '" />'
    when "invalid"
      overlay_content = 'Invalid Ad Data!'
    end

    Rails.logger.info("Overlay content = " + overlay_content)
    output = {'ad_id' => ad.id, 'iqeinfo' => ad.iqeinfo_id, 'ads' => [ {'nonLinear'=> [ { 'width' => @ad_params[:width], 'height' => @ad_params[:height] + 5, 'html' => '<div style=”position:relative;background-color:' + @ad_params[:background_color] + ';font-size:' + @ad_params[:font_size] + ';opacity:' + @ad_params[:opacity].to_s + ';filter:alpha(opacity=' + @ad_params[:alpha].to_s + ');padding-left:' + @ad_params[:padding_left] + ';padding-right:' + @ad_params[:padding_right] + ';padding-top:' + @ad_params[:padding_top] + ';padding-bottom:' + @ad_params[:padding_bottom] + ';height:' + @ad_params[:height].to_s + 'px;width:' + @ad_params[:width].to_s + 'px"><a href="' + APP_CONFIG["base_url"] + '/regclick?id=' + ad_id.to_s + '&url=' + ad_target + '" target="_blank" style="color:' + @ad_params[:a_color] + ';hover:' + @ad_params[:a_hover_color] + ':visited:' + @ad_params[:a_visited_color] + '"><span style="position:absolute;width:100%;height:100%;top:0;left:0"></span>' + overlay_content + '</a></div>'  } ] } ], 'start' => @ad_params[:start], 'timeout' => @ad_params[:timeout] }
    output
  end

  def buildCompanionAd ad
    output = {'iqeinfo' => ad.iqeinfo_id, 'ads'=> [{ 'companions'=> [ { 'id' => 1, 'html' => '<div style="background-color:#F99">' + 'overlayText' +'</div>' } ] }], 'start' => start, 'timeout' => timeout, 'companionTargets'=> [ { 'elementid'=>'companionTarget' } ] }
    output
  end

end
