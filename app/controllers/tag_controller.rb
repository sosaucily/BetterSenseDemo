class TagController < ApplicationController
  def deliver
    respond_to do |format|
      format.json
    end
  end

  def display
    #@videos = Video.all

    respond_to do |format|
      format.html # display.html.erb
      #format.xml  { render :xml => @videos }
      #format.json
      #format.json { render :json => @videos }
    end   
  end

end
