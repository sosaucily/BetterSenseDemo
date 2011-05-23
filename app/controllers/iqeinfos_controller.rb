class IqeinfosController < ApplicationController

  def show
    @video = Video.find(params[:video_id])
    @iqeinfo = @video.iqeinfos.find(params[:id])
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @iqeinfo }
    end
  end

  def index
    @video = Video.find(params[:video_id])
    @iqeinfos = @video.iqeinfos.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @iqeinfos }
    end
  end


  def create
    @video = Video.find(params[:video_id])
    @iqeinfo = @video.iqeinfos.create(params[:iqeinfo])
    redirect_to video_path(@video)
  end

end
