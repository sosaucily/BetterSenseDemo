class DemoController < ApplicationController


  def index
    redirect_to "/demo/video_analysis"
  end

  def servePage
    @demo_name = params[:demo_name]
    @demo_video_metadata = DemoVideoMetadata.new("dc73d48f3148ad3232cf3334d4425c13","Casino Royale_premium.xml")
    render Rails.root.to_s + "/app/views/demo/" + @demo_name.to_s
  end

end
