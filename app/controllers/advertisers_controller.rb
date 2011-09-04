class AdvertisersController < ApplicationController
  # GET /advertisers
  # GET /advertisers.xml
  def index
    @advertisers = Advertiser.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @advertisers }
    end
  end

  # GET /advertisers/1
  # GET /advertisers/1.xml
  def show
    @advertiser = Advertiser.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @advertiser }
    end
  end

  # GET /advertisers/new
  # GET /advertisers/new.xml
  def new
    @advertiser = Advertiser.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @advertiser }
    end
  end

  # GET /advertisers/1/edit
  def edit
    @advertiser = Advertiser.find(params[:id])
  end

  # POST /advertisers
  # POST /advertisers.xml
  def create
    @advertiser = Advertiser.new(params[:advertiser])

    respond_to do |format|
      if @advertiser.save
        format.html { redirect_to(@advertiser, :notice => 'Advertiser was successfully created.') }
        format.xml  { render :xml => @advertiser, :status => :created, :location => @advertiser }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @advertiser.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /advertisers/1
  # PUT /advertisers/1.xml
  def update
    @advertiser = Advertiser.find(params[:id])

    respond_to do |format|
      if @advertiser.update_attributes(params[:advertiser])
        format.html { redirect_to(@advertiser, :notice => 'Advertiser was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @advertiser.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /advertisers/1
  # DELETE /advertisers/1.xml
  def destroy
    @advertiser = Advertiser.find(params[:id])
    @advertiser.destroy

    respond_to do |format|
      format.html { redirect_to(advertisers_url) }
      format.xml  { head :ok }
    end
  end
end
