class BetterpicController < ApplicationController

  def list
    @completed_crowd_images = Iqeinfo.find_all_by_send_to_crowd_and_complete(true, true, :order=>:video_id)
    @incomplete_crowd_images = Iqeinfo.find_all_by_send_to_crowd_and_complete(true, false, :order=>:video_id)
    respond_to do |format|
      format.html # list.html.erb
      format.xml  { render :xml => Iqeinfo.find_all_by_send_to_crowd_and_complete(true, false, :order=>:video_id) }
      format.json { render :json => Iqeinfo.find_all_by_send_to_crowd_and_complete(true, false, :order=>:video_id) }
    end
  end
  
  def crowdProcess
    @ready_crowd_images = Iqeinfo.find_all_by_send_to_crowd_and_complete(true, false, :order=>:video_id)
    
    respond_to do |format|
      format.json { render :json => Iqeinfo.getJSONForCrowd(@ready_crowd_images) }
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
    if @currIQE.update_attributes(params[:iqeinfo])
      logger.info 'Successfully updated pic with id ' + params[:iqeinfo_id].to_s
      @currIQE.complete = true
      @currIQE.save
      flash[:notice] = "Thanks for updating the pic!"
      @image_for_crowd = Iqeinfo.find(:all, :limit => 1, :order => :created_at, :conditions => ["send_to_crowd = ? AND processing < ? AND complete = ?",false, Time.now - 5.minutes, false])[0]
      if (!@image_for_crowd.nil?) then
        @image_for_crowd.processing = Time.now
        @image_for_crowd.save
      end
      respond_to do |format|
        format.html { redirect_to("/betterpic", :notice => 'Thanks for updating the pic!') }
        format.js { render :content_type => 'text/javascript' }
      end
    else
      redirect_to("/",:notice => 'There was an error updating the pic')
    end
  end
end
