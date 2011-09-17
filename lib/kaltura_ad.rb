class KalturaAd
  include ApplicationHelper

  @@timeout = 2
  @@frequency = 0
  @@opacity = ".65"
  @@alpha = "65"
  @@start = 1

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
    timeout = ad.duration_millis.nil? ? @@timeout : ad.duration_millis/1000
    frequency = @@frequency
    opacity = @@opacity
    start = ad.time_millis.nil? ? @@start : ad.time_millis/1000
    alpha = @@alpha

    if (ad.ad_pic_file_name.nil?)
      #There is no image, so fall back to the built-in HTML field
      if !ad.html_src.nil? and (ad.html_src != "") then
        overlay_content = markdown(ad.html_src)
      else
        overlay_content = "No data"
      end
    else
      #Build the overlay from the uploaded image
      #overlay_content = '<img style="width:100%;height:100%" src="' + URI.escape(ad.ad_pic.url, Regexp.new("[^#{URI::PATTERN::UNRESERVED}]")) + '" />'
      overlay_content = '<img style="width:100%;height:100%" src="' + ad.ad_pic.url + '" />'
    end
    Rails.logger.info("Overlay content = " + overlay_content)
    output = {'iqeinfo' => ad.iqeinfo_id, 'ads' => [ {'nonLinear'=> [ { 'width' => 320, 'height' => 30, 'html' => '<div style=”position:relative;background-color:white;font-size:large;opacity:' + opacity + ';filter:alpha(opacity=' + alpha + ')"><a href="http://www.bettersense.com:3000/regclick?id=17&url=http%3A%2F%2Fgoogle.com"><span style="position:absolute;width:100%;height:100%;top:0;left:0"></span>' + overlay_content + '</a></div>'  } ] } ], 'start' => start, 'timeout' => timeout }
    output
  end

  def buildCompanionAd ad
    output = {'iqeinfo' => ad.iqeinfo_id, 'ads'=> [{ 'companions'=> [ { 'id' => 1, 'html' => '<div style="background-color:#F99">' + 'overlayText' +'</div>' } ] }], 'start' => start, 'timeout' => timeout, 'companionTargets'=> [ { 'elementid'=>'companionTarget' } ] }
    output
  end

end
