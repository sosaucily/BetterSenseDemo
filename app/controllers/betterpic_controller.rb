class BetterpicController < ApplicationController

  def list
    @completed_crowd_images = Iqeinfo.find_all_by_send_to_crowd_and_complete(false, false, :order=>:video_id)
    @incomplete_crowd_images = Iqeinfo.find_all_by_send_to_crowd_and_complete(false, false, :order=>:video_id)
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => Iqeinfo.find_all_by_send_to_crowd(true, :order=>:video_id) }
    end
  end

  def info
  end

  def index
    @image_for_crowd = Iqeinfo.find(:all, :limit => 1, :order => :created_at, :conditions => ["send_to_crowd = ? AND processing < ? AND complete = ?",false, Time.now - 5.minutes, false])[0]
    if (!@image_for_crowd.nil?) then
      @image_for_crowd.processing = Time.now
      @image_for_crowd.save
      respond_to do |format|
        format.html # index.html.erb
        format.xml  { render :xml => @image_for_crowd}
      end
    else
      redirect_to("/", :notice => 'No pics to process at this time')
    end
  end

  def update
    @currIQE = Iqeinfo.find(params[:iqeinfo_id])
    logger.info 'Updating pic with id ' + params[:iqeinfo_id].to_s
    if @currIQE.update_attributes(params[:iqeinfo])
      @currIQE.save
      logger.info 'Successfully updated pic with id ' + params[:iqeinfo_id].to_s
    else
      redirect_to("/",:notice => 'There was an error updating the pic')
    end
    redirect_to("/betterpic") 
  end
end
