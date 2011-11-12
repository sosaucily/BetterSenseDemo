# This is part of the BetterSense Web system
#
# Author::    Jesse Smith  (mailto:js@bettersense.com)
# Copyright:: Copyright (c) 2011 BetterSense

class AdSetsController < ApplicationController

  before_filter :authenticate_user!
  before_filter :check_session
  
  # GET /ad_sets
  # GET /ad_sets.xml
  def index
    @ad_sets = AdSet.find_all_by_account_id(session[:account_id])
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @ad_sets }
    end
  end

  # GET /ad_sets/1
  # GET /ad_sets/1.xml
  def show
    @ad_set = AdSet.find(params[:id])
    #The next line are a security to validate that the object being shown is owned by the current session holder.
    if !validate_account_id(@ad_set.account_id).call().nil? then return end
    @video = Video.find_by_id(@ad_set[:video_id])
    @iqeinfos = Iqeinfo.where(:video_id => @ad_set[:video_id]).paginate(:page => params[:page], :per_page => 20).order('id')
    @ad = Ad.new
    respond_to do |format|
      format.html # show.html.erb
      format.js
      format.xml  { render :xml => @ad_set }
    end
  end

  # GET /ad_sets/new
  # GET /ad_sets/new.xml
  def new
    @ad_set = AdSet.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @ad_set }
    end
  end

  # GET /ad_sets/1/edit
  def edit
    @ad_set = AdSet.find(params[:id])
    #The next line are a security to validate that the object being shown is owned by the current session holder.
    if !validate_account_id(@ad_set.account_id).call().nil? then return end
    @ad_set
  end

  # POST /ad_sets
  # POST /ad_sets.xml
  def create
    @ad_set = AdSet.new(params[:ad_set])

    respond_to do |format|
      if @ad_set.save
        format.html { redirect_to(@ad_set, :notice => 'Ad set was successfully created.') }
        format.xml  { render :xml => @ad_set, :status => :created, :location => @ad_set }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @ad_set.errors, :status => :unprocessable_entity }
      end
    end
  end

  # POST /ad_sets/ad_set_id/create_ad
  # POST /ad_sets/ad_set_id/create_ad.js
  def createAd
    @nfo = params[:ad][:nfo]
    params[:ad].delete :nfo
    @ad = Ad.new(params[:ad])
    @ad.account_id = session[:account_id]
    respond_to do |format| #if the javascript response is empty, this may never run
      if @ad.save
        format.js
      end
    end
  end

  def updateAd
    @ad = Ad.find(params["id"])
    @this_ad = @ad
    #The next line are a security to validate that the object being shown is owned by the current session holder.
    if !validate_account_id(@this_ad.account_id).call().nil? then return end
    if (defined? params[:Filedata] and !params[:Filedata].nil?) then
      @ad.ad_pic = params[:Filedata]
      logger.info("Results from saving the ad is " + @ad.save.to_s)
    end
    if (defined? params["name"] and !params["name"].nil?) then
      @ad.name = params["name"]
      @ad.save
    end
    respond_to do |format|
      format.js { head :ok, :notice => 'Ad was successfully updated.' }
    end
  end

  def getNewImage
    logger.info params.inspect
    @ad = Ad.find(params[:id])
    #The next line are a security to validate that the object being shown is owned by the current session holder.
    if !validate_account_id(@ad.account_id).call().nil? then return end
    respond_to do |format|
      format.js
    end
  end

  # PUT /ad_sets/1
  # PUT /ad_sets/1.xml
  def update
    @ad_set = AdSet.find(params[:id])
    #The next line are a security to validate that the object being shown is owned by the current session holder.
    if !validate_account_id(@ad_set.account_id).call().nil? then return end
    respond_to do |format|
      if @ad_set.update_attributes(params[:ad_set])
        format.html { redirect_to(@ad_set, :notice => 'Ad set was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @ad_set.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /ad_sets/1
  # DELETE /ad_sets/1.xml
  def destroy
    @ad_set = AdSet.find(params[:id])
    #The next line are a security to validate that the object being shown is owned by the current session holder.
    if !validate_account_id(@ad_set.account_id).call().nil? then return end
    @ad_set.destroy

    respond_to do |format|
      format.html { redirect_to(ad_sets_url) }
      format.xml  { head :ok }
    end
  end
end
