class ZonesController < ApplicationController
  # GET /zones
  # GET /zones.xml
  
  before_filter :authenticate_user!
  before_filter :check_session
  
  def index
    @zones = Zone.find_all_by_account_id(session[:account_id])

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @zones }
    end
  end

  # GET /zones/1
  # GET /zones/1.xml
  def show
    @zone = Zone.find(params[:id])
    #The next line are a security to validate that the object being shown is owned by the current session holder.
    if !validate_account_id(@zone.account_id).call().nil? then return end
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @zone }
    end
  end

  # GET /zones/new
  # GET /zones/new.xml
  def new
    @zone = Zone.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @zone }
    end
  end

  # GET /zones/1/edit
  def edit
    @zone = Zone.find(params[:id])
    #The next line are a security to validate that the object being shown is owned by the current session holder.
    if !validate_account_id(@zone.account_id).call().nil? then return end
    @zone
  end

  # POST /zones
  # POST /zones.xml
  def create
    @zone = Zone.new(params[:zone])
    @zone.account_id = session[:account_id]
    respond_to do |format|
      if @zone.save
        format.html { redirect_to(@zone, :notice => 'Zone was successfully created.') }
        format.xml  { render :xml => @zone, :status => :created, :location => @zone }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @zone.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /zones/1
  # PUT /zones/1.xml
  def update
    @zone = Zone.find(params[:id])
    #The next line are a security to validate that the object being shown is owned by the current session holder.
    if !validate_account_id(@zone.account_id).call().nil? then return end
    respond_to do |format|
      if @zone.update_attributes(params[:zone])
        format.html { redirect_to(@zone, :notice => 'Zone was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @zone.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /zones/1
  # DELETE /zones/1.xml
  def destroy
    @zone = Zone.find(params[:id])
    #The next line are a security to validate that the object being shown is owned by the current session holder.
    if !validate_account_id(@zone.account_id).call().nil? then return end
    @zone.destroy

    respond_to do |format|
      format.html { redirect_to(zones_url) }
      format.xml  { head :ok }
    end
  end
end
