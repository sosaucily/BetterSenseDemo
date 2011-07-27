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
    @image_for_crowd.processing = Time.now
    @image_for_crowd.save
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @image_for_crowd}
    end
  end

end
