class BetterpicController < ApplicationController

  def list
    @completed_crowd_images = Iqeinfo.find_all_by_send_to_crowd_and_complete(true, true, :order=>:video_id)
    @incomplete_crowd_images = Iqeinfo.find_all_by_send_to_crowd_and_complete(true, false, :order=>:video_id)
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => Iqeinfo.find_all_by_send_to_crowd(false, :order=>:video_id) }
    end
  end

  def info
  end

  def index
    #@image_for_crowd = Make an autonomous function to grab the next send_to pic that isn't complete and processing is more than 5 min old, or is false...
  end

end
