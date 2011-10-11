class TagController < ApplicationController
  def deliver
    logger.info params.inspect
    @ads = Ad.find_all_by_ad_set_id(params[:ad_set_id])
    #For security, use a randomized account_id and make sure the ad_set_id matches that account
    @ka = KalturaAd.new
    logger.info(@ads.inspect)
    the_ads = @ka.buildAds(@ads)
    render :json => the_ads.to_json, :callback => params[:callback]
#    respond_to do |format|
#      format.js
#   end
  end

  def display
    #@videos = Video.all

#    @ads = Ad.find_all_by_ad_set_id(params[:ad_set_id])
#    render :json =>

#    respond_to do |format|
#      format.html # display.html.erb
      #format.xml  { render :xml => @videos }
      #format.json
      #format.json { render :json => @videos }
#    end   
  end

end
