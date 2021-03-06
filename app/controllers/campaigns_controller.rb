class CampaignsController < ApplicationController

  before_filter :authenticate_user!
  before_filter :check_session
  # GET /campaigns
  # GET /campaigns.xml
  def index
    @campaigns = Campaign.find_all_by_account_id(session[:account_id])
    #Generate Performance for campaigns in the set.  This should be for a single user's account.
    @campaignPerformance = Campaign.generatePerformance(@campaigns)
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @campaigns }
    end      
  end

  # GET /campaigns/1
  # GET /campaigns/1.xml

  def show
    @campaign = Campaign.find(params[:id])
    #The next line are a security to validate that the object being shown is owned by the current session holder.
    if !validate_account_id(@campaign.account_id).call().nil? then return end
    @ads = Ad.find_all_by_campaign_id(params[:id])
    @campaignPerformance = Campaign.generatePerformance([] << @campaign)
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @campaign }
    end
  end

  # GET /campaigns/new
  # GET /campaigns/new.xml
  def new
    @campaign = Campaign.new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @campaign }
    end
  end

  # GET /campaigns/1/edit
  def edit
    @campaign = Campaign.find(params[:id])
    #The next line are a security to validate that the object being shown is owned by the current session holder.
    if !validate_account_id(@campaign.account_id).call().nil? then return end
    @campaign
  end

  # POST /campaigns
  # POST /campaigns.xml
  def create
    @campaign = Campaign.new(params[:campaign])
    @campaign.account_id = session[:account_id]
    respond_to do |format|
      if @campaign.save
        format.html { redirect_to(@campaign, :notice => 'Campaign was successfully created.') }
        format.xml  { render :xml => @campaign, :status => :created, :location => @campaign }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @campaign.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /campaigns/1
  # PUT /campaigns/1.xml
  def update
    @campaign = Campaign.find(params[:id])
    #The next line are a security to validate that the object being shown is owned by the current session holder.
    if !validate_account_id(@campaign.account_id).call().nil? then return end
    respond_to do |format|
      if @campaign.update_attributes(params[:campaign])
        format.html { redirect_to(@campaign, :notice => 'Campaign was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @campaign.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /campaigns/1
  # DELETE /campaigns/1.xml
  def destroy
    @campaign = Campaign.find(params[:id])
    #The next line are a security to validate that the object being shown is owned by the current session holder.
    if !validate_account_id(@campaign.account_id).call().nil? then return end
    @campaign.destroy
    respond_to do |format|
      format.html { redirect_to(campaigns_url) }
      format.xml  { head :ok }
    end
  end
end