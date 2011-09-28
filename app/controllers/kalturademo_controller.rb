class KalturademoController < ApplicationController
  def index
  end

  def servePage
    @vid_name = params[:vid_name]
    @ad_set_id = params[:ad_set_id]
    render Rails.root + APP_CONFIG["kaltura_demo_path"] + "/" + @vid_name.to_s
  end
end
