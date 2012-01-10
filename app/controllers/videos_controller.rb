class VideosController < ApplicationController

  #before_filter :authenticate_user!, :except => ['show']
  before_filter :authenticate_admin!, :only => ['new','create','edit','update']
  #before_filter :check_session, :except => ['show','index','new']

  # GET /videos
  # GET /videos.xml
  def index
    #@videos = Video.find_all_by_account_id(session[:account_id])
    @videos = Video.all
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @videos }
      format.json { render :json => @videos }
    end
  end

  # GET /videos/1
  # GET /videos/1.xml
  def show
    @video = Video.find(params[:id])
    #The next line are a security to validate that the object being shown is owned by the current session holder.
    if (!validate_account_id(@video.account_id).call().nil?) then return end
    @nac_id = @video.getKalturaIDByName(@video.name).to_s
    respond_to do |format|
      format.html # show.html.erb
      format.js
      format.xml  { render :xml => @video }
      format.json { render :json => @video }
    end
  end

  # GET /videos/new
  # GET /videos/new.xml
  def new
    @video = Video.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @video }
    end
  end

  # GET /videos/1/edit
  def edit
    @video = Video.find(params[:id])
    #The next line are a security to validate that the object being shown is owned by the current session holder.
    if !validate_account_id(@video.account_id).call().nil? then return end
    @video
  end

  # POST /videos
  # POST /videos.xml
  def create
    @video = Video.new(params[:video])
    #If Admin is creating the video (which is how this is done now) the account for the video should be the one selected on the page, not the one from the current session.
    @video.account_id = session[:account_id]

    respond_to do |format|
      if @video.save
        format.html { redirect_to(@video, :notice => 'Video was successfully created.') }
        format.xml  { render :xml => @video, :status => :created, :location => @video }
        format.json { render :json => @video, :status => :created, :location => @video }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @video.errors, :status => :unprocessable_entity }
        format.json { render :json => @video.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /videos/1
  # PUT /videos/1.xml
  def update
    @video = Video.find(params[:id])
    #The next line are a security to validate that the object being shown is owned by the current session holder.
    if !validate_account_id(@video.account_id).call().nil? then return end
    respond_to do |format|
      if @video.update_attributes(params[:video])
        logger.info 'Updating Video with id ' + params[:id].to_s
        format.html { redirect_to(@video, :notice => 'Video was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @video.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /videos/1
  # DELETE /videos/1.xml
  def destroy
    @video = Video.find(params[:id])
    #The next line are a security to validate that the object being shown is owned by the current session holder.
    if !validate_account_id(@video.account_id).call().nil? then return end
    @video.destroy

    respond_to do |format|
      format.html { redirect_to(videos_url) }
      format.xml  { head :ok }
    end
  end

end
